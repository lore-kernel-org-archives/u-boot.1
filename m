Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691960A2616
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dDW+W4lq;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pCfacxWB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hg/mqRtj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 885ED6082D;
	Tue, 20 Oct 2026 15:38:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E7K87RsTn0Gr; Tue, 20 Oct 2026 15:38:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AFA9A60807
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792510716;
	b=oQzjKpqGgC7jloGJbZ6z1XiB1iX/+smarPZVKX75IY4e+NWrtlA6rD/NXFQAllBfaZcY
	 F4jtcj0Cxv1E+zDLuBS4cI2ITZ7IK5T0gJM+8SnaAvL/Xhx70bFO9COdfYWfiqZqITWls
	 zxw1faYyIq6CtBBeAWkOsepfbUg8cGG+xiYJs98C6uXfSqMGtNBShXKzBK78oyIl93enn
	 +ODkAmP363YhObEtu5nJEdp65EjVp4xVgw/kJ0yTtwQGxKkHYkd4BBZDofhWSMygb8J/S
	 YRgIg7Wj82glMi27fRnfoA9HRl/InZhURotlb0JX1hycaxZm8AkScv3obZYqcpE8xdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792510716;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
	b=LAm/m1MC0UPwaD+OTLf1xg+wh6wN3jU0OoyLbELFN3jmoGblp+rpA+76a9A1NzK0WgoY
	 10Czz1cAQB9HpYqfY+Opl+ZY1PFjlsCQTI9eNCN2EHpa2BlHr2iVW/Joe4jl6pb6VzeEB
	 1YcYTJZSU6Pwvwz29/szr2TTFsKdMLevsRyC4q+yfecHp0IoW/iFiYZUtGgLHHNb3NMA3
	 j/zo7ZymWgkmDULUqa14IVLmWsS92JkLhD266+3igpOmiH4r5+/aKuvOCPcZqvbXkEBiM
	 3MkIbIWQ9CFrvi8io7Mgw+QoURfpaB+Y1oje9TceCtlq3tTaJGFCxJE5mkCumzXw4jQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pCfacxWB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Hg/mqRtj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792510716;
	bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dDW+W4lq6DmFilopL1xHpuAMQCc6luNu2gOGINmvp6PT3UMe6DXeN1kqi7JkBlgSc
	 Yo40vTpWwajndOno2DlrIlXT6ox/EuhvEUnrqf/Q5sTqyZKxw90uNe4MD/bmiOSIEi
	 gsw8fNVoiLa/E59Un0+NJPPPWmWsnWINvhDmzk/NJYl2VVcrMssn9nXJJU1cUqctxo
	 9EmcXzsvCehpPTWIZG817RFBE0EF7Q7MnRPr4lBn5kAJiY3LN62BV8Bz/DnhGo1i/1
	 TQv7QKlFFpSlPhYOF4QFa0YgLc5u1lJof/y1nWXqBe+L9qyJq/zDXUjAVcDcVBw/5T
	 O9FimY1YU+tpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFA9A60807;
	Tue, 20 Oct 2026 15:38:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A475A75
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A290607CF
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MsFTz28ykV3X for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 15:38:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ACD38607C1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792510714;
 b=cx8cKfHgZDYIMUMxY3vsLenwvTr3JzMbn80Y2kXueKfbw8ij2C8rUa1Pb9f6b2F+/nmi
 2TibmTOOHMIW4VYxRns4ibm7eXxguleCcBaztXokj4yypuuXpPVU54Kaj0KNtIhBavClf
 PFh/vF/wx9swBLuQc296oc3qH2QU977Ga477RffzyvDid7x5zz6gFvIL0Kpi/At0A0l+i
 rWuSQ70MNFTt5/u36FekOanQI+t2Nv+7MKID0OJ1Wk8Z6RP0vq6Yi/a1ayzl1uP0X3NJR
 3aL2mIpjGpcTLuNglg82CmvFqVBUu8Qv+YCNLK6g9Tx/MILlTGVWqtoP5Myq6Cbq/gQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792510714;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
 b=j958wfP8qAMgqTkuSj+9Cry6uW+nfNd3XBHuDwgpzobybHr+zvYFg5VHfePC8EHx3SLQ
 XR18h71QetEjScObvMhGmMQjr9Zcz3EXkkZWjO8R/DPV0crvdFxmmv4RnlMh04vpAJNDs
 Ve/0g0iVnfpENpVhLoXaRUCWCTDaNFNxKV7FG5fggdnOMqODO7h3AO927nUlD7sRrjAgC
 Z781Eap+e77/WZJFPv9BSffxYSaVwvBBLAGAej26KmjcXRvxTDoZ71k7PFdGMsNn4ZVto
 1THdMs2pu1SnmI6yp31SSVQn7kbfHrwDijSmSiO7tFXpk2PJu7uPkPSITIEsGD5j6xw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pCfacxWB; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Hg/mqRtj"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=pCfacxWB; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Hg/mqRtj
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACD38607C1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:34 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KEcggQ2491490
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=; b=pCfacxWBXKPUzWpn
 79XKQqUceFNIwhtkAPMejFZ2LKSRdkvih8i9vbV1Lfm+mP1At0FqMiDCeteNlq/M
 X7ZDgKZDaA4F5XhUTehYE5vlcEyUtSN6ZTaLCtM4rheWtHnUEp8CkqD90nLCTHgU
 36XTFy9+TupmH/n1dXh/sAiVNYTxb43XqTbncwK3YmWDHgvK9xEt46AuGMIEO39r
 1hHnudk/TC2ehDpUh5SGy+Xgl0sXW54Gb9q7za6Ox2+v9xSiCmJtE5AfeOeXSbIg
 qUEtu5JXeoq8j+hkrdAdZXgRxzYrdf9RgDQK3Vc6v1X19oJCp17fqUilaAcihWgY
 EMB0yg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pk6uh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ca9b53afaso1124961785a.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792510712; x=1793115512;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
 b=Hg/mqRtjTvj9fZlRfkC7ifHE9qfIJ73B7+1+fuaN7TVjVWX2QQywAw8h4+yYGMhx04
 PuSiw+JvsSWaAGpYv7ZPt/LyPajSzFbqa/xQaxYYjejI6yVygQ9Angt++5k8RSfSgsYu
 BB52fUQ9pIVYX3nwYrA6bUw/9Y19P2N1Xnh5TXo0pm2QeSvzF/65YjVlhr2PQOdTs7xN
 gvgQe3LNxqy38FMnu1m4MOmfKhuB20u4iJ1rw9TXs3uby8UWq/jFNvUZw2uW8nFnGZ4u
 YXaoxSLhMRNeJGqWcyuqHM5w5x3F7I9GLX2O3OQ1kQ8DQw/IDK4CrepkwcPBTUhOna3z
 uGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792510712; x=1793115512;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjXDcCh5+royAoG4fdNVP7OFgDccHJEi/JU+fHDiZfs=;
 b=Ghv4snMda8MwDmrpd4ks5STaoxsM/PyhHAm24Utr8yBU3q3S5j8sdAR/2UGhOoahCM
 xk1t0Y+H3/RMPWhYYfISh5GWAvWyS1DbMG6RzzXaelK+uLCMZPT0G9xHRun84PWpbKpj
 vTn1Ulft/aPZu+A7qdUN1lpnla6L/YRFeEO9HQyiT4BKgb36Gj26i9YjOjhQ/Ar6B/cH
 c0Xehp0RHN1Z6cufEqWsIQMAOuVUr+tk5TMyoGV5K947l1fdUSc/FCMEt+2EyAyCcT0U
 FuP6yz7md9r4g/BSxLapwtDAQhd2g2whJ5r42qrfLO1O5VigD1qCesgG6cz+1h3e38RK
 gHJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNlmC2U7yybndZZF51n6gwOtjLOOryQ5n2XCxV7xYNoo9bwcu5k5zam8+uZoIgz0UVjj9uFJU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIceLrd8J2NmXWranfiGsHzFe6tL1n0NiTtQl/nRwCkCGL6F9V6
 AW2UKTYKdwAghQOIeNQMlpmVZ3OYGLaUW9YRrX0d63uaOMd3AuBRtWBGNztnAPc8xaTvvL8EIh7
 b36fu49Zxi5DKQZC8BVN8sTgHgM4JSvOU6z5n726SktdFjhqoTl39o1I35sAipVq1HE5nBz4=
X-Gm-Gg: AYBFou3SoyDYjk7azVntWOWCjaiafePzP+n3t/gVvxgdfzeVgjQiX0SDoyfwqVISny1
 km0gPqd+cz1O0SDqoiEYbjZXlbSUErXrqYjl8qLHh/nq665VZL9TSlMrxY8KxRmNq1+fLW9yaAd
 UxykheyfY9JeoUpcX4bH8kdIMvZqy8VCiMrKI+VIl03aw0j5euNXhk14/AOwKSt2JXNtZSR4BuN
 uNmO6vIqTdrS/uf+mY/SbLUNwRcky/I7R8u/sB5RK1sqQDJ+ls46CHwr1+UN/NR+aRWANxtvunF
 FUGmPViT+QzaHWstd4ahRGPijABzrwDjpLt3nX/0xkZ5AdS2t2MBqgDODGOfx1AIfKoNXcxRP6c
 BPFdXXc2viGRxZVYAnEE0EwBZpq2JX9vmLF4D5PnpI5l6
X-Received: by 2002:a05:620a:6cc9:b0:93f:baf:279e with SMTP id
 af79cd13be357-93f29b72b3dmr1869336185a.8.1792510712336; 
 Tue, 20 Oct 2026 08:38:32 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc9:b0:93f:baf:279e with SMTP id
 af79cd13be357-93f29b72b3dmr1869322585a.8.1792510711083; 
 Tue, 20 Oct 2026 08:38:31 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1b140fsm5574963a12.9.2026.10.20.08.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:38:30 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 17:38:09 +0200
Subject: [PATCH v3 2/5] cmd: avb: add lock/unlock commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-upstream-avb_lock_unlock_b4-v3-2-e280795a98cc@oss.qualcomm.com>
References: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
In-Reply-To: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=a7WlZkSF c=1 sm=1 tr=0 ts=6ad78af9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=MoAT0fEG2T6-BM8MC5gA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: lfLvfmpfsDmkcrD-EyhBvVrcyVnCYgHU
X-Proofpoint-GUID: lfLvfmpfsDmkcrD-EyhBvVrcyVnCYgHU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX8WATf1KGp68O
 UiR8OXolmMaIzMzuOMvp9PUKEb4qW5+FZJBVACmryxceLLtzR7j5jS/gl1m/wORL2AobK+A9aSZ
 7g+Hw+VP7IiyX3CTK/XlVlm0IH6Dv8Gwn4ZvpYHA6dl8sCWJHt/oW39ynxo9F+wZoZIDn9FTJI8
 rYShclYg2UoWvwxVz4kgKUTIMymuS+fSY4mRXSdITjA+6CK/3UB3+k/2jRSur3Tcr+uastRjKS8
 riKwsyAY46SXX0AN2SCn472pZhxZk/lyF+24a8WAjC8KH0aXME2WY6oKagOOkmg8dW784vk6XBD
 X0Vt1o37swkg3BAkhOtfAjDcT58q2P224Z0bcj+UFEXknasV2YvCAqvunBHF62KFH73doPHFbEK
 yyZnB+2J2psy9rd4HHTlET/Pcq/CD4F6+zMyZ8/DlZAk67R2uYWcCYTUxi9Mkv2IZ89B5bn/6EF
 ovnkexP3z7xf9U74Iig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfXzvuIbYVgp+F0
 j1TdwEfIxK1n9t4uS9BM4A+RB238n7Bfm/VcJY8KP7x6DokCnJ3dZXST05cV3YrTcUuafVsogtO
 sawvBY3jDc1oL6erhhNj9LN1G/lMnnw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200062
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The OP-TEE AVB TA stores the device lock state
(TA_AVB_CMD_READ/WRITE_LOCK_STATE) but U-Boot only ever read it, so a
device backed by the TA could never leave the unlocked (orange) state from
the bootloader. Add avb lock and avb unlock, which set the state through a
new avb_write_lock_state() helper. As documented by the TA, changing the
state resets all rollback indexes.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/avb.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 common/avb_verify.c  | 23 +++++++++++++++++++++++
 include/avb_verify.h |  3 +++
 3 files changed, 66 insertions(+)

diff --git a/cmd/avb.c b/cmd/avb.c
index 3c13d6a2cb2..8e0ab0eff06 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -534,6 +534,41 @@ int do_avb_write_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
+#ifdef CONFIG_OPTEE_TA_AVB
+static int avb_set_lock(bool locked)
+{
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = avb_write_lock_state(avb_ops, locked);
+	if (ret != AVB_IO_RESULT_OK) {
+		printf("Failed to %s the device, err = %d\n",
+		       locked ? "lock" : "unlock", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Device %s, rollback indexes reset\n",
+	       locked ? "locked" : "unlocked");
+
+	return CMD_RET_SUCCESS;
+}
+
+int do_avb_lock(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	return avb_set_lock(true);
+}
+
+int do_avb_unlock(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[])
+{
+	return avb_set_lock(false);
+}
+#endif
+
 static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
@@ -549,6 +584,8 @@ static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(write_pvalue, 3, 0, do_avb_write_pvalue, "", ""),
 	U_BOOT_CMD_MKENT(read_pvalue_hex, 3, 0, do_avb_read_pvalue_hex, "", ""),
 	U_BOOT_CMD_MKENT(write_pvalue_hex, 3, 0, do_avb_write_pvalue_hex, "", ""),
+	U_BOOT_CMD_MKENT(lock, 1, 0, do_avb_lock, "", ""),
+	U_BOOT_CMD_MKENT(unlock, 1, 0, do_avb_unlock, "", ""),
 #endif
 };
 
@@ -592,6 +629,9 @@ U_BOOT_CMD(
 	"    and print it as hex\n"
 	"avb write_pvalue_hex <name> <hex> - write the bytes given as a hex\n"
 	"    string to persistent value <name>\n"
+	"avb lock - lock the device (verification errors stop the boot);\n"
+	"    resets all rollback indexes\n"
+	"avb unlock - unlock the device; resets all rollback indexes\n"
 #endif
 	"avb verify [slot_suffix] - run verification process using hash data\n"
 	"    from vbmeta structure\n"
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 227b2d22465..7b60be4da7a 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1080,6 +1080,29 @@ free_name:
 }
 #endif
 
+#ifdef CONFIG_OPTEE_TA_AVB
+/**
+ * avb_write_lock_state() - sets the device lock state in the AVB TA
+ *
+ * @ops: contains AvbOps handlers
+ * @locked: true to lock the device, false to unlock it
+ *
+ * Changing the lock state resets all rollback indexes in the TA.
+ *
+ * Return: AVB_IO_RESULT_OK or an AvbIOResult error
+ */
+AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked)
+{
+	struct tee_param param = {
+		.attr = TEE_PARAM_ATTR_TYPE_VALUE_INPUT,
+		.u.value.a = locked,
+	};
+
+	return invoke_func(ops->user_data, TA_AVB_CMD_WRITE_LOCK_STATE, 1,
+			   &param);
+}
+#endif
+
 /**
  * ============================================================================
  * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 6dbbb39a8a3..e89bb229e02 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -45,6 +45,9 @@ enum avb_io_type {
 };
 
 AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
+#ifdef CONFIG_OPTEE_TA_AVB
+AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
+#endif
 void avb_ops_free(AvbOps *ops);
 
 /**

-- 
2.53.0

