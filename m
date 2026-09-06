Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B0EC79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 12:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D4DE80BE7;
	Sun,  6 Sep 2026 12:18:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iITnUxcptPH7; Sun,  6 Sep 2026 12:18:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A747E80B1B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788697087;
	b=PpIaec5J3QvpqCWypQd+z1yc0osytw3Qw+0p5WZDcWOTCo/DcUtp/OJVS6Ow3hqEwTPQ
	 EBZxd8hRquWj9TIm8nh39+g4HQBZOup+umBIpTzsPt0tGUGyaG7kU1Qejj/V3aSxUafSe
	 cP3rHR8fkNhpuVAiWaNhPLA+bERS1JwOSQ6CliRHQTE3CxfetiavTyy2iLq5IEeDZWL9M
	 44NzomFYplSmBj+GJoO0WQR2GVvPCoyLW6688DGDVJNbDRt1l259OijP+T4FfzrqtwIfo
	 E/Wsq330aeLBCby/drNkq1cauaJ94PP/QXki6hb+ixoMgMLosGRccJLdw7tw8UmsEaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788697087;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GrFASIGuCe0yBC+HVnGJd55KbhhQNefJ5xzWLDa9/xI=;
	b=ZncJ6xxrHHCMOqGRgn4EFonIodD7mOF4fV/L2ehRHDBL2Dbf3WH5mYihBJpZvxdBHNd5
	 3HT7cFI9PcLYTHs154c+ELkBuFkiUYVtU9E0OCJPYerdMk+TbIo27D5L/EmjfbDwxIyOv
	 8OaQgiNTnWCtYPwAlnLBjp7nySj7Fy8I/Ib1z6wO2CFNDA0KEULiEY3TKX6RDNrWTqBnc
	 Q+HE2cRehfp3/KUPgttq1VttyjT2hcFUAEdcGqDnlqKRtsArAtwmNcUrBxifm0yu0QN+S
	 ne6Vs30V4JNLd5epWqFRREfmFJd5i+kPqMJ4hARGAh6DGoCY+xavuC4OfxZc9nhDvZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788697087;
	bh=GrFASIGuCe0yBC+HVnGJd55KbhhQNefJ5xzWLDa9/xI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NtXFxf8gscXIQvdzAnm4+DZ3Mu3sfZ0O+GbkXektPiB0lWCMZ0YmdNY3NBkGspz/1
	 5clCYUsCLMOtm62uOKE9dJKM5vrY/yD5VNIzVaveCir5F5lEWBh+DDb0/o9Bltd1vC
	 +IhF0UJmymzOhfbBGipi46ZLGek+38T+VYwMYjac4clfyg/yl6SDy14IHx17feG9po
	 jv/oJaJ03cXW/ZTb/Ty9C7mVTkVOV4T+EzzvTUNWXVEIzkUucychKawGeOiyp7VrQE
	 8V1CsNwUDGNZOkCTRXG7yQ8TBbWdHsP8czWDcAL5LrzP6Nw/XDpkzNd1qdyWpPA22L
	 j1BK6pXM3puJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A747E80B1B;
	Sun,  6 Sep 2026 12:18:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A6CB03AF
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 953A94061B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lc3AH_Nrz_gK for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 12:18:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 25CEF405AE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788697084;
 b=BW/mS3J+fpytTsfhz0k6E07DzNTMp2jq9yy7042mJQG49H/c0qRNoQSZ3T1l4vItWTS1
 yKNOWYzFME4pMLRaT4W269r86kfVeHsYs0xc2wtcIkL2gJ45HU8MTq1u1GBrhJyNUO1hg
 WOEfUidH7jLYpIwpNz/YU9cHDRJuYjCo42B+nZY6gH32QEpEMbbDeGEr0tDGqCfV/UB8e
 GR4ECz8+L0NlNkKbaBQOxTSpEKp92iXPEnKmcHedjOIdfvnrgjRVZtk/LUCwBmO0+FItb
 HUzzj0r0Ho+HsiFugWkaf8SJvkSq3E8Yg9JQ7lPtzMdn9Lu1PSMJfYGL6l+YJ57rbrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788697084;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=GrFASIGuCe0yBC+HVnGJd55KbhhQNefJ5xzWLDa9/xI=;
 b=l5QTXbXonB2LRm8Y1AkOe+CKcL8XEcJV9wYCl4BGrOLrBPgBmoST1Ul+QyyJySnlNrR8
 ZFsIXEourpzr48PUclssBzaloJefX8wLL+Sdsye7r/uhswseqkC+jOJ0pi8M6OvcyPBnP
 lsg7j5OstsG44jcWGichOiZF7Gz6zUc+jbDH1c0DJa1iY8mVmQjUDZER+cBm4m541QedE
 qpJf9IclBCPYnOBpZo3BzE6A5t5pQmco/98Dk2arOmT92McHeoyLajinghUEn5mdeWdLL
 j0W0WY4AfigmG8GKPF5BeJwzhiObXE8L2xTWc8yrrsif7fEYte5hl1X99oMDqUSSSwg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pm1glNhf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gxzasWLs; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pm1glNhf; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gxzasWLs
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25CEF405AE
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 12:18:03 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 686004mT087823
 for <u-boot@lists.u-boot-project.org>; Sun, 6 Sep 2026 12:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=GrFASIGuCe0yBC+HVnGJd55KbhhQNefJ5xz
 WLDa9/xI=; b=pm1glNhfE8HlekClcLUceUEY7K0GTe8LmnNoQLvFpcOgdyOE47G
 O6AqaSayIzqeHaluD8g53G5HJi0r+PYPA4deSePprXFIuZCq8dh2kR5maj1NYSSF
 LR0j261Pdixql3NxQmKbyfE5ZhayoFvGG1NuECxfi0uYu7aZif1+uIjbppurfQwY
 NygxVlwMwSngM6n4w6mr8Qc0AuEJjZ69V7vhi/MRe8SSd32GAwE9PEnAcGQlw804
 TN5BYeA9zlrOTyY1l0FCRbn0YJ5pR0dP6frGvLu7gL5Yu/gv7WfNQo/AMhQwz/tG
 0JIo8rlAjBlJobiuk6tKRktfZBxh9ej9QdQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany3bq5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 12:18:02 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbe77d6864dso4064773a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788697081; x=1789301881;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GrFASIGuCe0yBC+HVnGJd55KbhhQNefJ5xzWLDa9/xI=;
 b=gxzasWLs9EQQI70NNNenKNuzHHdK+BxdjhePhk3+XuyPvPllmQlrqavaFTMDLo0RTg
 MGOHV26A3E8QlfDPv3wvbbwwrg/WD9bYvmhGLtGuYRLp36VFQ5l4ivOZnWRS4fReZZdR
 DZ+3N01eOv8MsHjcyCo3ES9PwuRv4leXjbsj/yCGAvQqcMl8LY8labcGFrwZ5R2+6TNg
 sXW+I1z1mgh9GMcGfys49Rr1nVpze1FMXqfqVUYJFuj9fh2ZuyUTHsb2VpWCH04IW3nb
 UbOI4SKx3awcMLfbMjyxGaTY8AdUvZvP9TvEkUAhTF4+IjHbiJAJ7/JVtkQwrgg/Zhfi
 AwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788697081; x=1789301881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GrFASIGuCe0yBC+HVnGJd55KbhhQNefJ5xzWLDa9/xI=;
 b=QT1c+YHRKYBJpJ863tojm46Qe0ltUWTqF7qcOMIsisVWdO+vqqg2j/DsvJRp0USsk7
 z5pUXxnVw9aOa2tR0HO0P85v4g8uFpbdL6zY6OXYyGS0nBU7LqmvXnOT2ovwg99hb0W/
 Scz9OcMFANoV5T60FhziS76sX2aIOJd8Ir/MPUZqjbzr0eETgBKUevZTkk5QoRip/b9f
 jUK32q+vO4/1J0zJ32T1Ij+3lKqFas+AsMOc0MEGR/kuPcTVTPbmTa7tEkUBcZfP1wc/
 EJQx0S19mrUKJwdsREdOYyBIGGzLW5f5NmFdVxfN2bFCxPI8hliEumeMK88t+l81CMsY
 un2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByQH6QmwtcY1AD7MhAe1c0omz8xvYQfFrhBb+fzU38Rk+vddrVSj4YlgUH7SgEZOpcXjuPkbMg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ksEmIA/ffBzSWDoxbVRoLs+C/IUU5ynFtrEy7b5Otemql3azWx
 dLWA6AcTykmfVCJk4tgTS+3HJ3gjcBCMGl+T7cYwDHjYUaNdmePjyWOGHlNPcl1wyujKHgs3m2M
 X2ik0zOhsZuBz0RCnGiAg1YERi3WJI4YixogETk5spMPwBlgKNHw9KDvlkvtB/RWEPUFplqc=
X-Gm-Gg: AYBFou10rrM/OVswCINsAbHIfeD6oLkNSK9nMYum6/yJaSl0V3ywO6bgE9QDrGlKwjX
 U9d2FLWhMSRo5lSMYR9gNlqXDoJJqbopujmJWzPs/GE0iHgoX09ZLSc1IZJUNIQrLNOWKC/mZkD
 M0YxI5Ozwpn+scwyDd9fYoWgHJyCUV1uk1LgN7lwFfkoF0u/E432kex8ZBC8fPacqzebmoCXSGL
 BshE6tEZgHIbKJKh4J84EYyFDIP8zzJ/5As7OvG6bt2IxOHcYfhXqki3TneWssAtGJfJs7x3GlC
 0kr6aYXenGH6hj1lbYEX9dXfXxrPgpsJRMr+YBLLbfVZEqMh1rXkJzzlMVCPtXCkIazCwm+hDQj
 sLbn1XU5xg94fFogh6w//DUXarSQxysFTcUAZIRXZ3FFQrHJb0fzeuhham7Kudnyp68Zxz3TWnf
 g8BdDi4hQHhBuLDN6BkFA=
X-Received: by 2002:a05:6a21:7109:b0:3d0:d933:af97 with SMTP id
 adf61e73a8af0-3da3a0aa8b2mr26634730637.15.1788697081253; 
 Sun, 06 Sep 2026 05:18:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:7109:b0:3d0:d933:af97 with SMTP id
 adf61e73a8af0-3da3a0aa8b2mr26634693637.15.1788697080872; 
 Sun, 06 Sep 2026 05:18:00 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14332405e92sm11768639c88.8.2026.09.06.05.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 05:18:00 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, balaji.selvanathan@oss.qualcomm.com,
 dlechner@baylibre.com, vincent.stehle@arm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/4] qcom: Reduce boot time by avoiding unnecessary
 initialization and probes
Date: Sun,  6 Sep 2026 17:47:47 +0530
Message-Id: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9d59fa cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=gu6fZOg2AAAA:8
 a=Y4cRL4M3wEF09EKPb8QA:9 a=_Vgx9l1VpLgwpw_dHYaR:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-ORIG-GUID: YSqM_pLWm1NWdsNadUmQYakRyAm1bCMP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDEzNiBTYWx0ZWRfX3K3LTaZnmS8t
 8pzYTxU3Y7KHmkAlklhbHT0hSjNlDIyfT5s4mdgAZAhR7HvhVf5qSOA8XhbNosMUzlTd1adZv2q
 On0/3d5WU2Csvl8kY9iNmGJ9smUji9151nq8n5PqOplBDWHRqfuCv4CAxMO96NU0vjlBh0CvSbG
 XKZLQRuP2/EDogdKPWFoAJ/GSImYO8dvS14jXxTSGXLUJcyz5xAR/o6kQYiXzWOBCYCJWVFuNk8
 7GKUKnYVhjDMs4cUfvJpm7ZdroKHng8Y4frT54DMkHFEVyLQ6p/CRkCgYh3Fbi7y3aVYA5tLSdA
 tyElNnj84Jm/h1GRI/EUDTHcloCGX2xJbn225ypjOpVUTrBtf2PZQT1+8DWzvaol5er/7WSrs0x
 0ptyx0KPao/xTCMUjJWFkpUW2UlZOLKl6wX3P30lJSmRWSQXbYG9osFCSlTVTVUkZPh5GHCwB07
 wUT7Fw6VQbVV5eMy1cA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDEzNiBTYWx0ZWRfXyslYMnsxhE5/
 YUbBCHXagWuvcyT7gLBN/Eg1WUdPC84U0W9Z2I20/TTC+x9EUCz83X0fk0HkS+KGjo/bGIPVA8V
 EJEh4UXLFDD+ZafJVgTkqSMEdRWqY1c=
X-Proofpoint-GUID: YSqM_pLWm1NWdsNadUmQYakRyAm1bCMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060136
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series contains a set of boot time optimizations for Qualcomm SoCs,
targeting unnecessary initialization and device probing paths observed
during boot.

The changes reduce time spent in memory initialization, filesystem
probing, and redundant SCSI rescans, resulting in measurable boot KPI
improvements across Qualcomm platforms.

Boot time savings observed:

  - Disable malloc pool zero-initialization: ~74 ms
  - Skip redundant SCSI rescan for capsule updates: ~34 ms
  - Skip filesystem probe for non-ESP GPT partitions: ~170 ms

Combined, these optimizations save approximately 278 ms during boot on
Qualcomm SoCs while preserving existing functionality.

Changes in v2:
- Address review comment by adding scsi_scan_new() to discover new SCSI
  devices without removing existing ones, improving boot-time KPI by
  avoiding unnecessary rescans and replacing the uclass_id_count()
  guard in capsule update paths.

Link to v1: https://marc.info/?l=u-boot&m=178781570076393&w=2

Aswin Murugan (4):
  efi_loader: skip fs probe for non-ESP GPT partitions
  configs: qcom: disable malloc pool zero-init on boot
  scsi: Add scsi_scan_new() to scan only new devices
  mach-snapdragon: rescan only newly added SCSI devices for capsule
    update

 arch/arm/mach-snapdragon/capsule_update.c |  2 +-
 configs/qcom_defconfig                    |  1 +
 drivers/scsi/scsi.c                       | 27 +++++++++++++++++++++++
 include/scsi.h                            |  8 +++++++
 lib/efi_loader/efi_disk.c                 |  4 ++++
 5 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.34.1

