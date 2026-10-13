Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78385CC6B16
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0925680ADE;
	Tue, 13 Oct 2026 15:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMlUOublWDla; Tue, 13 Oct 2026 15:56:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 42BC980A56
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791907010;
	b=Pv02IVNJ2fCrQwp6Ew4stIECxuq/AvYdhPXc8/+TDUxA74bRzCPaQyJ+opbx7DsmzaMv
	 JM4KzueFWpB/hyFfl5mk+1wLSWhY4Q4zI2KoY2IQbSV0E2rXXJ54kiKoTfMvz66/pUmAJ
	 PbWpBQkTjG8CSgTc0v/0lJiSvpGjAhoXiBuO0TIhcO6v7d67a/AD53cT7lS6Ikps0aGhR
	 FXhyI4yuKt100Z/mOW8dX5fAETuQ0sNWbY+rZkwOnnB3xOmTkUsAgCyBDqwcyesOXoUPT
	 rh492vYovFXfNKGcgKPXwcZy6LMy+MlWI5vhA25xNOR0PgwlU0cwCAWMEOoAK5RzcKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791907010;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hsjQg6jWzl2gImT4jRxgXXGEeFEh1m9Ee7VkjMFDuRI=;
	b=I2xb9KlTCPmnu87SD0Js8uotfPmmAf7Fb5o9j+SxNnadDb+bSMKHHjqp3Zi/MAt7V0oC
	 7qJGwKyuEwJpRa1ZPtu3xbUwVR31wkWGuN9E+YWOFZ597mI1vg5r91xr1uopEnlgnIGXD
	 2ATwP+BuAxSb1WvKwWZ3oACGXgv4n8VX3ZXNekRjM0oUclrsr6fYdnSrucyzT6uOIsGFY
	 c4x5AfywaCoo1g9Sc8YyZFYl9dHtcc/bjfFNYaFfeV3JUJFL3O9D3+jMjsw8wvMEXWGLf
	 mmY3FSWro1J/qb+64TPIN46/L+D7t8O2uuz4CYp4DR2Zdplvr2gVno6EguggnNCx4Yg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791907010;
	bh=hsjQg6jWzl2gImT4jRxgXXGEeFEh1m9Ee7VkjMFDuRI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zg3n32ygQcLfhrfG5Sy9G3RKjZsHyeJ3LBRjf8qJo6oxwMbvs9zTZ4xj50fej+H0S
	 eC4p7A5gRHL0f6yhSoul0bEPX97Tj547Iby5jD/a2V/xjVadWkR9gXuxVh8p0Ods5x
	 X4FzgwxKcSnMJwRCX3sYCehNMpxv/32A2xp/hcsPZndgRNMv1Qu2Q7ijmnwOI2wh9j
	 Eh9dzdw2b/5wbh2Woeb8f/Ylg9zL5cBc2UT3zJGe9PwZjKTawy2s8/bGrNC4mNdbb0
	 GedIy6SslRsXQPZejwza3VZ/7E350fcXw9/QmIk8jnioG9+J/M7myKeNvWScvTiHoQ
	 0S+ZBlt88qZbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42BC980A56;
	Tue, 13 Oct 2026 15:56:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EB1E788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 304C040462
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NNtm6pR3mtp for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:56:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B8E74043A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791907007;
 b=CAfillYJxos02YXenPzoy8JoKoBVxo6SDWIBdHNNwiooE+rVjDShtZ+TAmbvxmfN3jQn
 f2A5cZmrywvaO2NSF80e3XdvHTDdnjBjcGSvfjHbi944XOi2xZ5Wbl/UbNPcFihr02yNd
 QdDipiaAfXgY7L9sa7jsvRozgjuGaX7f0mzKyA3xqE4KwlUjbglRkJj6wiQe11AwsDSSk
 IIbSejgrCryiE7eF1vj6WDyMRBso/pitasR3kXtam5hSZn15qA3Z4tblqzJ38cSBkrFoS
 WTttyGKHKmdVzywAmBacyYUC2uztsnW9doxt5LfPa6Si2w1+p9ClXBcwL1+KwRmF+nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791907007;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=hsjQg6jWzl2gImT4jRxgXXGEeFEh1m9Ee7VkjMFDuRI=;
 b=bG0ZAJei0CW1AYNNxqYs4eMKqSP7foWJq9JJGyxZC/+cHSx+3FE1R5HCpIny1OxEH1oc
 OE1NDqe2r8/KVlJUkzngS8DFOCC4+2tYwELDMYroaxIkVwxohtv7s0nXu1rJC3f4h2I8w
 C2bEnHSbov0O04hEbyT+IiqXi3jFHxGE6Pb9zRD8Wb682Q+5ozhJLoSLPOx9x3AyD734a
 jutdCS3AgVqyGZK3icQiVOaYcSRoO12Eg0JuXdUTjURdQeYJoMcBnYaDEP7X1KBzi+XV7
 q4zlgjdB5Eh2JZRMMhCCNfQXAlYHafqjHaGhHM05hHdTARbj1F3OyUmlYgps6fQYEEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ayYoHfjc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QLPPIpQn; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ayYoHfjc; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QLPPIpQn
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B8E74043A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:56:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DEpxB41402910
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hsjQg6jWzl2gImT4jRxgXX
 GEeFEh1m9Ee7VkjMFDuRI=; b=ayYoHfjcsmXDWClw95CMLL26DlpCzcPVIA47px
 3UH/1zAnTiQa0/aEa9aY8XCtKR1TgTCX36v1nCz3h3rCW2tvvw9uhsvgzNcU/kZk
 2j6M7NY1qoKYbqL/fCVYcDQCEJkQkI0WQ+EM1Yruwd2E2sPcPo/T+IjUFS8WHxhh
 m7eBgGyk5WJoKGLDRkzgwYWMhRx3HCLrtSyqyOKZft8C86etfPMbEs+h+1Zpmh6k
 Wk9xyBJQ4F5up/DcPtv3EAupzDedvbDrDp48eelZaaQ7x5j5zqJR9xlG46oqmeY2
 uxSEA0Sj0OoFEb0WypCsyRHubI7izxFNwS4/pmwTFpjPDwQQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9psk09mf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:56:44 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so12814347c88.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791907003; x=1792511803;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hsjQg6jWzl2gImT4jRxgXXGEeFEh1m9Ee7VkjMFDuRI=;
 b=QLPPIpQnoHt8ve9fcGQRTqwJ+gwyS9PK2KZknbgZXtSA1FUZyBuI9A6DikuXtjYwV4
 w+ctoTPDd8DtvW3U8oyIEw+5DFzwMu9vXE+0tE5UDadXBXMgeNG+0t+OCwMaYerT79Hd
 rfGv7J1IEdcPpW8duGbnJ0i4olaapYzxiYRj9TnNamdZzzgYoTRxGO+surUZBKchOyQq
 FNibb2ZDX6LJ2YjKpRcq5eK2iUSIxD9iB5ifJmQexpKcC5rR+2aaKHhvp3mlAMDeTm7S
 2hXJhrsG/VVC37YyHAAJWQMU94391VoNkBwe3IFD8ezWkKbKzjkDiaCpp+rYCTuLywjs
 rVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907003; x=1792511803;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hsjQg6jWzl2gImT4jRxgXXGEeFEh1m9Ee7VkjMFDuRI=;
 b=02l1lURPnVaoWdrWwH8G+YWk36w8xbX+UvMYgF2bsCAcaFtG45pNuqTiB1UhjWPokk
 Lkuald6eSSlE7a/IN3CTpDOt62Dg3oaI9DXgY/0gQnlmrmDZczE3tTrfJO8eAPhumFsw
 MCLKmF4f4n8S6GVo6FXfN7LMA6Ms/WKYxi80u6loexba07/MC2Q7IgmXTbG2tXbj+PjO
 xSFVqQt1l2wLfmHD97A5IiTvdxfUDVqlOhsmNIlmIOefk7LXEO6D07O1eynU8niWFlsk
 6qg1BK4R/Dt31pNwuD6UmGkVdWQk93mIhWrbQUvLEEeo1gftde9GCQP7kqQjdWuAi6o3
 fDhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJRnI7udseI/XX7HZqG10smlJhsG+aZAnDy3IW4xqH510vFnGng29Y0vPPvhAT53N99toOswc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIddIhGGfgDwKXvjHYDKcIdhYE+5fOoxNflsfF6co+Vact1gJrF
 6IfKGzVHFXSS9rHkPj+LCnJHdq8OXWZFbK4RAPGOghE7Q36S6PxL4BS/lOGudi8172f32PpCjtL
 WtCKi/rEsOZFui3RclA3ZEfJbP4ceCs31WHFAlHXO3B/8m+6b7xaIpj+5RKLZ1hLdZ/MAtew=
X-Gm-Gg: AYBFou0GdsWoDQWhVy4MiiEQHATDo3PclnYHP4rl/bbILGc9+LL8NKApTDogZid2pzD
 8Zv8Hvlb7XeRdAxE56FD30qtrDasO8oK/i2O8Bl/orMPAOB/UVqLi6yDCRIrYRSwBXBKISkFSxO
 asFLdB8QYyY8dYb2Mvep/QZ5lHT313tMtYApgbCZ4xJ7wNMSfkbTZ4G7iP0ERFskO75JUu0hLVu
 0bTDxbm6O5rh1/rd2sMV62q9SYFHm/JnHJErjWsgi/FIBSQl4a/AbyOAjIsdNYA/CYLBii7SPr6
 eFFY/zEHEblfReBwaBsZPYmeA5PE4Se20W+IUEXqCz8eVsqqut+JFd+uw1bPf5tgC/pd9Ltxy6f
 kJsy2H3EoPkKeYA3BpBl2fj/s5VoCL7CrPfXkb44Z8YEmWUXa4as05+WhQ/2ANg0/kk4ppsRi6R
 n0sLi160/MTTShYRhCZ5Np38A0cDM=
X-Received: by 2002:a05:7022:1706:b0:16b:fa6d:b11f with SMTP id
 a92af1059eb24-16bfa7cf69dmr16692426c88.6.1791907003190; 
 Tue, 13 Oct 2026 08:56:43 -0700 (PDT)
X-Received: by 2002:a05:7022:1706:b0:16b:fa6d:b11f with SMTP id
 a92af1059eb24-16bfa7cf69dmr16692381c88.6.1791907002422; 
 Tue, 13 Oct 2026 08:56:42 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm42884316c88.0.2026.10.13.08.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:56:41 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 21:26:37 +0530
Subject: [PATCH RESEND] configs: qualcomm: Add verified boot config
 fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-verified-boot-v1-1-df1fa48a7ac2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALRUzmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Nj3TKg+rTM1BTdpPz8El0L42SgoLlRWmqqqRJQT0FRalpmBdi8aKU
 g12BXPxel2NpaALvrGf9nAAAA
X-Change-ID: 20261013-verified-boot-83c01372fee5
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791906999; l=950;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=DY4lm146UYvrqp8MWLgP+Pybhiu36Z7HlrsJsEEbAQ4=;
 b=oKSqBEgfPdPJRVDt4VteyQJ+4rkI+AXs9uAwR8OgshjmB34FYdA3DfhrQb/x9GE9o4jmS52e0
 QQdFsW9/4/HDq1HeNNCLMQwkKtlhUv3FvrIhU3rTpEd5E9MnQtraZDZ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: sAomOiAhTQjpN8oUUvBLbbjHEdbxj_cs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MyBTYWx0ZWRfX2kDSMXhrpGPG
 6UXG9sUrqhVSGnpskDL4FtitvTP2di47P9bBaCjQYgPBle1G/eX3G2RoR/jixGu7NLg2ymY3SSQ
 g/YGzlSQI8C8CMrm2QbeUbNO6pTu3lQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MyBTYWx0ZWRfX+UiIJ5VPOu4G
 MJwCorDPayY8tO7u6an9dHTcI575uUXSqZwZZHW/IpRP5wI+mi2OYsJ5UpTIhABZJ6sTLZTozkn
 V+PTaL79MEP2fojRZaIM+J7+ccQEsdjIlghBwBywr9p3NdclXQa6Tdjv0T/437JruDZ3LoSvZQw
 Swj6Gc0lt0nKgpTePqG9rdBTuMm2+9CCspLw3fO9wWVQWJnZP5vNWqS8OxU4QWjTK4a3EzGjahX
 jRuhoRJ7jLS7NKTPJu8aUQMwT4RnRU1+34DyAAnFJjb8jJh4342DmReq/8WAtRYG/nLYjbjfuTP
 D+vQEmeeKuVSrBDj75iznGpOQyb9r8twDSCC8qWOgKH/fSD5++iGVQZB0vFMkaas8PVsApQ9bF7
 o4ZQn27XpK1fXK2r8kdjHPRHQp+w43jklu7cbq3kL+gqRH3QEi6h8PVulLlQ9xg0TcptYUO/X7m
 gPsyIrNZv2fecV+xQxw==
X-Authority-Analysis: v=2.4 cv=cbJHPXDM c=1 sm=1 tr=0 ts=6ace54bc cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=wIccDC1-F7bu2At-tl8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: sAomOiAhTQjpN8oUUvBLbbjHEdbxj_cs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130063
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

Add a common configuration fragment enabling RSA-based FIT image
signature verification and the required hash algorithms, for reuse
across Qualcomm boards that verify a signed kernel FIT image
(kernel + DTB + initramfs) as part of verified boot.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_verified_boot.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/qcom_verified_boot.config b/configs/qcom_verified_boot.config
new file mode 100644
index 00000000000..8aff098944c
--- /dev/null
+++ b/configs/qcom_verified_boot.config
@@ -0,0 +1,6 @@
+# Enables Verified Boot support
+CONFIG_RSA=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_RSASSA_PSS=y
+CONFIG_SHA512=y
+CONFIG_SHA384=y

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261013-verified-boot-83c01372fee5

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

