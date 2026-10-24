Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F1606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z7S2Vb0o;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KV9/pYL8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=On5ZcLGx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 476EB815D5;
	Sat, 24 Oct 2026 17:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DP9Q-S-mPkBx; Sat, 24 Oct 2026 17:41:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2976681463
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792863669;
	b=JcnRI25RaWU6/gK+zjOQGgbB+GC8NShjDFGvgA7uJoOlV4Qjn2TMPnUngzlF10sKAXDU
	 Suz4TkZsi9aZPwqPezQgE6f3EAMZGg1lKFxOCvpaQPoApHozf6xMUrfwxV9U18sI3Mo7l
	 LFUFSm8pTj3/as2yw3wTSY+TWC3Nqx0nxoE6x7hlSF+S1mH0jqQJ8/dqRQBWFOOKHBV1h
	 6eQX06ZBe3Rgt3hd5MsHGe5wZbm73RJmnqZSSuFf9Z4kuGxPjR1cOOGxsfV6bMQOa9D7p
	 taRMF96iiiXB2X08RrirDpXXtuFiWiBVVHQ2ydb3BTVn6WKTQ1C5SMjVq16oabRcOqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792863669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zyHm42qnaclCvZeqqfqd4hbBnnuuwiim3zZyZuITYS4=;
	b=HnP67xe57N/rL8Aj0gwxT0/0TjDgO60qmQXydFph1e6RWaEstmdf6JuC93FEYWTuUbLu
	 7T7EY08lphkAlKCF/whugh5WWWJy/agFZQucib75hNhiDSVTDcjBTSGf1NmVszlBlYjEV
	 LWSzXOvq8g+NPnCt7Xf3LYkFomJTLuCifFX+9rEPUeYwwZz9FV95W3Fk3kgJVMGU6XaxJ
	 /hMmHo6FQhKYkbCFz4Zjp0gwXElk3yzJWS3x+BeYbsdPBUw6NeyThpBKvKtt94/vg/wWS
	 HoAlyn3EUIa3btp6lsE5GOK66pPt96RORFDqMO5wcH4WkywYn5AVTiH6hHb2WHnPQIA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792863669;
	bh=zyHm42qnaclCvZeqqfqd4hbBnnuuwiim3zZyZuITYS4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z7S2Vb0oNgckKZEZ8LJEkHNGbwG3+YOTOYRONIm6attY8Fyqj6AYonNACZ3uY5PEZ
	 +GlgCesLWtGVZiGQAYUoC4jFR77vuHesWbwjVHQG78wKCVVppwhUj7KUoon8/suNCT
	 KeSUFd9yDrOQ/mvSKylrnpN7gFBP0GG/Pt1vak0TE/XRmUPTA1Elm3YbZ/DqW5DJZ7
	 Vks9HkU9RVuDj1wfCl/79+ejvbOQo0EGemPlVNdcYNdTrhxYxJ/vLBDu874ESmHBIg
	 F6EHo542YKLLWDN3vB3bY1r19E+0FO2NeYH2MNunTJYGqkcomqWki4kV9nVzOAVAgx
	 RT2Ke6MQ9QCzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2976681463;
	Sat, 24 Oct 2026 17:41:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0232643
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC57360640
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6V961qBcMQ3 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 17:41:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54F30605E3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792863666;
 b=D+mj/US1QbSATYeZhvidJeT1zM8/8uj6ZuFM5uD7o6gab1GnadUOy4rLQ5IyfGkMNowh
 gCIai4YSs4mFxCuyL5UUR8j7Yho4DSixLSCJqSy5FkaLNsIzyOoeooFfMHp0i2n/4gBac
 1E0UHj050bvMJMh2vVr33Hl7f+Ohl+h1drzZS/zjEr+UXoq3DU9ucSIRU+k8FOjI3roLM
 HpyDlbLAAVlueni+f9QVtiPE9RH8Xamt1kDBiPwnWsff28koXyokL6Wp0fu+9HC/Idtp3
 sPoh43QSMLhTt+40Gd7JEmj6TkZV+Tz8hWbZj1IodeOhkcAx3a/w+PI7vUiK6t8EmKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792863666;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=zyHm42qnaclCvZeqqfqd4hbBnnuuwiim3zZyZuITYS4=;
 b=ib3fc/4UEjqeFz4RHtCXwpe4YIWhkq6cRFd/662xSLJKx0bN7mTFFzICV2LN9ywJExPw
 cSKN+uwYCwyvsLfNxN9VBdxloyHa2M+3/t73TzXEF/q0+8wTM1P/6beaWlUIyUgfNlHnU
 xSTwRnuzy7OjWMC2FYo9Rmpwq/nIODablVrRyRAa6iUNHkcIXmKA6h1WuaHNCV9w7pEdl
 nUQtyKFsLP62IN3p0RMilI4ftx9G2f+4wUPfftPptlxIVWUMEEHoGBWtz2OuRYAwCp7zv
 LG6Q2hXM783egdXx9KHhZoDJW9Fb8Zebss3NloQ4TeR+oTcCR/uzNtOB/ArScr+fn+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="KV9/pYL8"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=On5ZcLGx; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KV9/pYL8; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=On5ZcLGx
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54F30605E3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:41:05 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExp4X1907243
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=zyHm42qnaclCvZeqqfqd4hbBnnuuwiim3zZ
 yZuITYS4=; b=KV9/pYL8r5x4njfbWOEvnwNcSxV3Zq2NiiB8/NOZwzOgHWUkK3p
 uOGf8Vt3i/nPL+7lVz/NeXjfGaTfcd9bHkmiIVZRgKklHG9vYIlCW7hOUbC+1cVc
 hWCmLGgy7p+11iwHENDzfG05l+vwdb7zzxZsGZkBxNVivp4R3Es2fuZoai9CAg1T
 Ovb98rXZgIg/H6sdcbMYUAD0nSdC2Ad2Mj2aMKjrRLdnNHP8wYM1hhqy4Zf850G4
 CXEEb6i8nQ82iIOM5s6BZHkljbhMELbCDGuD0XOB0DXvMcQQWKaWZ1FZfIiUrahw
 SiJJN4C5GudpV0zhqviqs+TK4nFRpM+YSxw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3hetq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 17:41:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3662e7a9299so8712701eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863664; x=1793468464;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zyHm42qnaclCvZeqqfqd4hbBnnuuwiim3zZyZuITYS4=;
 b=On5ZcLGxyr2P7Uo73u0F6caar5qB3xwC+MhuUk4kE6wKh0n43FqWg4GapQBvD72tgd
 EacR1iNVAF4wmvzPtn1QpcgT69YoBitY5qSsKqUP6zs7MKKmVp+vJsovjVTWlN4KE7yL
 uZxl/nH2/fnc0noAMTdcDHhFuGEuQ9yK8FzsTkXq2ALFETwMJfGSVhEtATxiaHU6lSMR
 0FW15YcSxIQcf3r9dVzjtcSHRD23vmaKfTxM7uus7M0hjn88lS0HjDPPDXVgSO3jb928
 V56TKsDYvFg4axzltVYx9PCLA2gH75O5NdqxZvMRH2NNoFO201PlQMuHhnetMxS08dvg
 nDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863664; x=1793468464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zyHm42qnaclCvZeqqfqd4hbBnnuuwiim3zZyZuITYS4=;
 b=FWD0J67i4WEmeY7jfME54EPEAdjbLZa2RN7FDpOsYl0Y+0a7uiMn3mNEAOsECC8Ex6
 Jif1SGp5eKc2ooaiAtmKbriFWfTA66dI8shE9hFhpQ1edS4qCp+zsJ+otI4ao+Aj42OF
 rn8CSz16F3mjO5GHrS/TauRfGxNLHQRsedX+D6EyXnPBHESASpDCwpA59pHbvI+B8frY
 RW7qwicKm16iKDJzGXnrdeHFdXEJ1KKuWqYdeZeuMi/2WlZup8w3RFXKibxW3JjX1E5M
 ucEmDCWcG5GSoNkQiv0U/Jg9kWGikE3U4EGglsgxnZjx446YI4iD1Z2BAZHx8TO6DwTW
 VVZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcIZ7OhEnPYzWzeFd88FYrZ8AVjb+iRUcjDpIUUm53oy5JSAQ8d6kGOCx5YNRFgtmtPMC7wLw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKvQspUlNorfDbxfiIenjmleLd92rg4eSb1ZswaeXYS9m3z1hRR
 xNu3PVF0RazLYQzdh+mG5ZLAHxsGWZbSr/GHgTv2mACHt3hAfpr2IdlgHHmTxLwT3OCUu5f3TAV
 lm1UHlbetotx4q44/SlFG95VXLrSzER+c8LgjA5HFkAHh0JUF6ehZx1R4TnKi1kExGYXfm1k=
X-Gm-Gg: AYBFou1eH4l77RTcMMm8kttMoDO+HO+Wb2TeGS+mBjLZEx5wbIRk8uZUKQdYUjIwGdz
 4Dx8xEthR7xFbL52K7OJnUb8tzGLYtpC13G6ea5zVNqKXCg4q6srr3eB6wp28xE5ojkES/6d+a4
 lqSuziRsKQQwq/iGbp0OSxAAN+/IQymcC+/STb3vFKdVTWvfwiAPtGje4m09JcymVOlb0NKspch
 PoykpTNM+QNEhlCGnaGaix6iaSKlyHDhsjRQd9jrze69PkLSnyGqoHQcpHX+oj6fOhIyhZv5SF1
 4CldxUzvGbGN/h3Edr664HXGNjIsGzUzldUgS+am4wAfll6A3zgNJA1tZ5Ba0Cc1BVbPA+Jynbx
 xvAyV2OnTrZ8gARwzocMNY0ORu8XrG6imkNG9k42+N30MmjoTndiyCG7TBsWFBHURNtpA1PagjV
 MKaQfLG8uJGJhYADToGQ==
X-Received: by 2002:a05:7022:1508:b0:195:49ee:94c7 with SMTP id
 a92af1059eb24-19934a926ecmr3787970c88.8.1792863664243; 
 Sat, 24 Oct 2026 10:41:04 -0700 (PDT)
X-Received: by 2002:a05:7022:1508:b0:195:49ee:94c7 with SMTP id
 a92af1059eb24-19934a926ecmr3787933c88.8.1792863663643; 
 Sat, 24 Oct 2026 10:41:03 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1989ff2ee5asm8009427c88.8.2026.10.24.10.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:41:03 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 u-boot@lists.u-boot-project.org
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v2] armv8: mmu: sync emergency page table attribute updates
Date: Sat, 24 Oct 2026 23:10:56 +0530
Message-Id: <20261024174056.3529978-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rkBE_UH3WXiNX4V9-A7PHMsMnGD0BkGU
X-Proofpoint-ORIG-GUID: rkBE_UH3WXiNX4V9-A7PHMsMnGD0BkGU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfXxUMUM2JN2g9D
 qKQhSK28nDJwShx2O97Q9BiK9QB8VJX0gPh7qOwM2+v4JFZmGLWvJSGS7OBbk84SyoeLx7Q+7wQ
 Gp4MNUd64yh0/kTQgio20cV5zT/hiJ4=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adcedb1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CDPI-Le-tkVpmyRDY5gA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX0qC0zdlRwAA9
 Ja2RUFifZ9zgGNw4HJ6/BLnebz4QUvwCLQ1CPdNrQfOjZLQXfL+mGW3Rc96M9W7dnvshZSbH50+
 WEI0Th39QLavayCbXDtAFmyWTGm9cd/XFms5p0BmlYvr0A2N9doHPcsBmNTfuCWD7w8YpgtvyGu
 Bs37ks5j0EWUFyp2Q/O6Yl2YfEjuhDPnjBBgE+Wdz66maemyRCw6rTlFRUVATlz13dW6xYUrE0t
 3rlhnbe795aMkTgy4XLuUu1k6jdpQum9Ga32xHGZ0W3eljqgbzQxmb0iXZ6zXTTk27df1L3StSs
 zptSw3UF/2IzY7K5nC7plnfKiulgEBhE78AVYG5of+Gr+zb1INs/zKId4zFZLCfVU45vKiIM6oj
 BsUJBHjtOL3T+MfjdZ3oWA6xXqHdsXJ460Kqe+aOdagz3cI9ArCUESb4YcEc3XrSyFZ6xfuw7vP
 261PvDF26eMnTxEGZug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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

mmu_change_region_attr_nobreak() updates only the primary page
table, leaving the emergency page table with stale attributes.
The emergency table is used temporarily while the primary page
table is being updated.

As a result, speculative accesses can reach regions that were
intended to be blocked in the primary table, leading to XPU
violations.

Update both primary and emergency page tables when modifying
region attributes to keep mappings consistent regardless of the
active translation table.

Since splits can now happen in both the primary and emergency
tables, double the number of page tables get_page_table_size()
reserves for runtime splits.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- Added a `root` parameter directly to `find_pte()`, `set_one_region()`,
  `set_regions()` instead of renaming them and adding wrapper functions.

- Doubled the page table reserve in `get_page_table_size()` to account
  for splits now happening in both primary and emergency tables.

Link to v1: https://lore.kernel.org/u-boot/20260926092635.2712021-1-aswin.murugan@oss.qualcomm.com/#t
---
 arch/arm/cpu/armv8/cache_v8.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 135bb62ea72..f22cf3f67f2 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -173,7 +173,7 @@ static int level2shift(int level)
 	return (12 + 9 * (3 - level));
 }
 
-static u64 *find_pte(u64 addr, int level)
+static u64 *find_pte(u64 *root, u64 addr, int level)
 {
 	int start_level = 0;
 	u64 *pte;
@@ -191,7 +191,7 @@ static u64 *find_pte(u64 addr, int level)
 		return NULL;
 
 	/* Walk through all page table levels to find our PTE */
-	pte = (u64*)gd->arch.tlb_addr;
+	pte = root;
 	for (i = start_level; i < 4; i++) {
 		idx = (addr >> level2shift(i)) & 0x1FF;
 		pte += idx;
@@ -816,9 +816,10 @@ __weak u64 get_page_table_size(void)
 
 	/*
 	 * We may need to split page tables later on if dcache settings change,
-	 * so reserve up to 4 (random pick) page tables for that.
+	 * so reserve up to 4 (random pick) page tables for that. Splits can
+	 * now happen in both the primary and emergency tables, so double it.
 	 */
-	size += one_pt * 4;
+	size += one_pt * 4 * 2;
 
 	return size;
 }
@@ -1003,11 +1004,11 @@ static bool is_aligned(u64 addr, u64 size, u64 align)
 }
 
 /* Use flag to indicate if attrs has more than d-cache attributes */
-static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
+static u64 set_one_region(u64 *root, u64 start, u64 size, u64 attrs, bool flag, int level)
 {
 	int levelshift = level2shift(level);
 	u64 levelsize = 1ULL << levelshift;
-	u64 *pte = find_pte(start, level);
+	u64 *pte = find_pte(root, start, level);
 
 	/* Can we can just modify the current level block/page? */
 	if (is_aligned(start, size, levelsize)) {
@@ -1044,7 +1045,7 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
 	return 0;
 }
 
-static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
+static void set_regions(u64 *root, u64 start, u64 size, u64 attrs, bool flag)
 {
 	int level;
 	u64 r;
@@ -1055,7 +1056,7 @@ static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
 	 */
 	while (size > 0) {
 		for (level = 1; level < 4; level++) {
-			r = set_one_region(start, size, attrs, flag, level);
+			r = set_one_region(root, start, size, attrs, flag, level);
 			if (r) {
 				/* PTE successfully replaced */
 				size -= r;
@@ -1085,7 +1086,7 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
 	 */
 	__asm_switch_ttbr(gd->arch.tlb_emerg);
 
-	set_regions(start, size, attrs, false);
+	set_regions((u64 *)gd->arch.tlb_addr, start, size, attrs, false);
 
 	/* We're done modifying page tables, switch back to our primary ones */
 	__asm_switch_ttbr(gd->arch.tlb_addr);
@@ -1099,7 +1100,12 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
 
 void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
 {
-	set_regions(addr, size, attrs, true);
+	set_regions((u64 *)gd->arch.tlb_addr, addr, size, attrs, true);
+
+	/* Keep the emergency table in sync with the primary one */
+	if (gd->arch.tlb_emerg)
+		set_regions((u64 *)gd->arch.tlb_emerg, addr, size, attrs, true);
+
 	flush_dcache_range(gd->arch.tlb_addr,
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();
@@ -1112,7 +1118,7 @@ void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
  */
 void mmu_change_region_attr(phys_addr_t addr, size_t size, u64 attrs)
 {
-	set_regions(addr, size, PTE_TYPE_FAULT, true);
+	set_regions((u64 *)gd->arch.tlb_addr, addr, size, PTE_TYPE_FAULT, true);
 
 	flush_dcache_range(gd->arch.tlb_addr,
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
-- 
2.34.1

