Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5903BC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 11:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF66560693;
	Mon,  7 Sep 2026 11:56:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeEkA6Ck6joD; Mon,  7 Sep 2026 11:56:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C776260686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788782184;
	b=D+ax3btD55QY5z+txSFVr914VJ+ZSkrTGoIa3l2H1t2MciLulFYfLHMLQxzF43MAbqlL
	 9ipqYwU1jY5L4SyShwyo+4Jsnz6whUm1lLamNOeS2FnBfGtqB2XeJzt8UKsWISnTa/zlJ
	 lGx6i0aiYRu4wT47iM7QpaW/NK6kuuU+1ippOmDv6BFe91zU+XXILXRGVXMfs5/DqnBlS
	 WpTbPE4wBO3vfs9dxtxf6pBQOqrCNGg7eDMNByokQTWId3xgFQo1eXddp0qOmif5rrxuD
	 LnfxUvIhbiK/PmmIuso9Wy++qHFcVMsqX6AYG/WxMZnIaoHRcj2gpSqlcJL1NzyhMyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788782184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TwepCkWWlhPMy7d4ogTauUlLSEikkODbQ9InHv6ixyI=;
	b=ahORk+AbnsE8Y/tnK4bhPL6zV0YBEz5qFzQ6jz4ja4z/8u2SWG6VLpYJZtlWnIWJhw/S
	 1BIsFPQEnO76VigoE5AHjF+/UWBF6vnCMfLkS+jTSCSwrvbQXxDUO7moOExUzNlVDp6L6
	 1LW6dzMifh5ROga9z7VeOLLSxpsQ+jYx+tgR05uxF4NjF+NGGHMrbmEwt7cOt+nLiZNCx
	 Ys8T59epqX7aHGsZ4/R/q31yUp/Qu75CeEnjILQBMc1ikh3soGeosM/uLFAILAbOBniqm
	 uc5XPffF9i0Oy7TaeNIcX58wc+Dqf15/Q7J6AidcGmWbsAP40r5QNqUr0u7xBBuzsqw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=euhkcfPu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RF2YVBZa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788782184;
	bh=TwepCkWWlhPMy7d4ogTauUlLSEikkODbQ9InHv6ixyI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LCFtrRGQrRbOUz5x1TdTP8oBNOSLxKGxOLRMtGQEjhlcLvD/Jxdt0a7Y/lB4Ashmi
	 3OEBSDsrfoW7HgNZx6AGcLW85m6uWdJX4AdDVXlUpqyjZP9Uk93Jah++8xvmJhPFde
	 hicJMDVptMyshwjIV5kTMtBigDcYwskBjtEh63mSjVBenzOXUfnpNdONw1UMJSGEG6
	 ZZyNxICB3Jvkw2KbI91js2cd06lI7Fz5ywFc9TkNg++mIhyS/j/gPM/JxD3A5xUGqS
	 wfpT5fQ+K5bYnjkbcEq6FENprQQIqkgKSzThIoQEB9Lhki5RJojsESxCTz75OzFJCw
	 Gy7TcTGrRsbgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C776260686;
	Mon,  7 Sep 2026 11:56:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B24A990
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 11:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D48C60686
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 11:56:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JjLmUvRdhwtV for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 11:56:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A5DB1605F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788782182;
 b=CBnoy+mC5lzJxcNnL76zLNMKNWrVn8yy3LL3TV4KM8V1WtmhTNbhDT9f4zD3wECjrmQ7
 c+IOdPuMtPmlHBZvKo9my5LqHGV341u70RnlDNff2GtNeeyUU3FCPx8M5iXARW4XboJ5O
 Uea6+J1Fww9eU5E2ASJFLuxm4onfiinySDEXsTlmQxEXOgcCG5hffqHFR7Zyzvm3+FBvL
 kZBn8gIFn+y+YCiMea7PbvosUOP/2HVjcjIcXfb6iC9C9dli0swfm4wSQRFbjgxMhKbjO
 hLu+osde+ujjRcyJ7DQBU1mOTK9kw2GVVtuTHBUYaxQFfxfa1fdOAyYqK+BA6je8Okg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788782182;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=TwepCkWWlhPMy7d4ogTauUlLSEikkODbQ9InHv6ixyI=;
 b=eDj8aUU0uQKYziS27rG+koy1rheRZ4zmOo2zYsFJXLARdfKJv1gNX5RE1MGCHP5HS5Y3
 ekA8PA18bqKH/eZkXuxe1D2f5Ae+wLt5woJWXG66vUuQFq1ZBKuiQDNfWZP1cPXEOGuWw
 sJldW1Q0B2K02G+55UX+QP+90kWGqwetlDejuUJk+OsLFowQGlmVcvjYKjUvYwXDqcXq4
 c03EbvZnOIXmF0LdDuryV68dQbf/doATqhJef9RBe8R2wlcFdvpd1Ma+nUKTjudQVDOLc
 oZO8LaYT10CE6k6krjCW1RpiLYIhD6UORkjra8HeZUdZXncsaOeQdHuRETzW878scfg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=euhkcfPu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RF2YVBZa; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=euhkcfPu; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RF2YVBZa
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5DB1605F5
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 11:56:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AmuTc3349032
 for <u-boot@lists.u-boot-project.org>; Mon, 7 Sep 2026 11:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=TwepCkWWlhPMy7d4ogTauU
 lLSEikkODbQ9InHv6ixyI=; b=euhkcfPuw3yRZKRerOqOgj4qmcdEq5QzZYtRkB
 /XZCLEl+GykR4FPW74Y+SzE2cujci910m46EuQkxeKhi9riZgDCCU9k6Pb9yIABo
 hVxHmiH8EL+gj68DDImdHahKrQijMSof9DzAV4JtaOAQIg8kjHZsjDer/BqsmHB2
 g7VGjT+V5dgQNE4slOUbL+IMf1v9PLp4E4P0zZoSLqCrbIAnG+XEWvXVir8RsrWz
 tXf6qvynHGQw9h5puilfKV0P/H6LMfcg5634X+k+N05WPxiocL05LonomhRjMP+M
 X35iD4Q5Ym6Weh13OmwpDY570ivZLX5LgKk7oiGBtH5LgcVw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtfx0mr6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 11:56:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d959904658so60794145ad.2
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788782180; x=1789386980;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TwepCkWWlhPMy7d4ogTauUlLSEikkODbQ9InHv6ixyI=;
 b=RF2YVBZaOu/W8BqI+Y2uv874I2ZW+ZmI5tXX15IgCs38plrunl0Ix7HUqjdl0Azwo5
 Uau6Y09EowMsktoT8pK+f/I3mJ+csnO59yu00BSTgQ06UVcLWVEHqMQdOvCtO4eszkzC
 hQOQOxJdNXNZDGtxMjL2POOj3Znd2nBcITLgxO1WNSTwKFjKDtMrN+CAdq2IJKC57Vxy
 xdkJPmfmkWF7/UNYYh0WLlIjIF/FR8TgTMEsx1nVsasjHgcDZGb4BtsvDn02R5RDMgYg
 Fbc+Jw1lwpwpFy505N3YPBPgpfEzVOGs+WNdy5wLUZcZtllPbXckRzdws4Yda8MLJMm7
 dqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788782180; x=1789386980;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TwepCkWWlhPMy7d4ogTauUlLSEikkODbQ9InHv6ixyI=;
 b=SruiiWy7zN+oT4btr4F1x0QKGtG2TafmjU8sX2zhxalbtTAxm2TY4vpYP6ThlEh2vv
 Reu62l03aQlyyMYAA0WGM9t0mDjptP8fwuezAGlyfg8NuhT1mVx2PU+c0BxUgpJWOUru
 Oj2jbzOsq+WMYLWqRHiuzznOLnLSryTX4Fco0rlySKacFqcpnUOqbptH6S1a0aMqZl4V
 D3SWpbHRs2woL9IMsWjj9KOzu8UsXPK6rn2Tg/eKame5rQauHx5i7K7CK49K/3ee32L7
 tjl5gZ4WrvHm4EseLi//A3VaXwut/fkPUo0vv4yR5/OlYEe4jZdspNIyvF2xbOjzFWWm
 1paQ==
X-Gm-Message-State: AFuF++nMWvcA/sFYpIXlSCAmJconL+rxCwvsJ9FNgWFvpSYa12WfAkcr
 IWySGFbJXbubS0gTfA+MPM0ZnXLogWwqrNn7yT1/15JE27cifb7Jz4ZAP6OepM6zp5uL482uClK
 O+N7nbW3XJnPVDmkdqyWYNuYuV28Dik8eLWHkFiAUJ9tVdyU7fAIUKnSeqWGr2oR/S20YdsA=
X-Gm-Gg: AYBFou3gYx+lo5MFuLC5QZLf0YZfJISNHoCrrhi9tXXOaJDQaeAEnGkbSa97oXU/cFz
 9e75RTmugNScAHEXaC/z68SROHXXsBsxPY1cPFCWRVp8ahcgZ+S2+FNM5w95MSPisE+2Ri37y4l
 jyAx1faEhFO81HahhmEMsc8rM5cpXlJEUq5JOkDDmcYGvbZ2C22830AnqhuiNIgP5IYfYNgCQmF
 4MbvXmVtr6mrP7vLyFHljwqv0NiOVskhRTe1C5MCv6+Hh5rxyNmBEjktuuD9iMA+eLNBG+X+S+l
 WaHCzbjNL7iK3ULGW/jPzf3WTK96a2Pl1OZqqTJCWTgSi99deiRXgSOBciF2Lc0TksqlniuTc/a
 y7ACT9CFHIC6zIIAqoOm8om8V5PXZaTJW3aLXjpIxwO51w/8BnN+iBObh9vGABp7LfYMfnpeyjn
 29oGOMfrU+QEot4gQ9c+Qnd0ynoq66
X-Received: by 2002:a17:903:1a4d:b0:2d9:43f5:b462 with SMTP id
 d9443c01a7336-2db125a4758mr367922455ad.5.1788782179981; 
 Mon, 07 Sep 2026 04:56:19 -0700 (PDT)
X-Received: by 2002:a17:903:1a4d:b0:2d9:43f5:b462 with SMTP id
 d9443c01a7336-2db125a4758mr367921915ad.5.1788782179514; 
 Mon, 07 Sep 2026 04:56:19 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33688cfc714sm10492029eec.20.2026.09.07.04.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:56:19 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 17:26:14 +0530
Subject: [PATCH] lib: lmb: return -EFAULT for partial bank-boundary overlap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-lmb-alloc-addr-efault-v1-1-7a5b73c2318c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAF2mnmoC/x3MQQqEMAxA0atI1hNos1D0KjKLTBM1UHVoVQTx7
 haXb/H/BVmTaYauuiDpYdnWpcB/KggTL6OiSTGQo9q1rsE4/5BjXAOySEIdeI8bMrXkSbghL1D
 af9LBzvfbf+/7AS9j3WxnAAAA
X-Change-ID: 20260907-lmb-alloc-addr-efault-a29212da721d
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788782176; l=1990;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=8PdCm26FFpmLAbGrWuokO780DJY0KsK5cAwpmhhgkHo=;
 b=ZO/uDbtEY9LxSJ6M5Yd3FYFADMBskdhndyBE9gGBPTV7UGHuEc1qPbIgFKblKAJaTJ9ZS2WFc
 2um3xp/vax/A6VIeMC+zNoEDnTbl1JHUNRaX17MFKccp3A9M1XltzHs
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Weg8rUhX c=1 sm=1 tr=0 ts=6a9ea664 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=NA7I0oHMnQhyuj0z4kAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 86wGw2w7a66iXnr7XH27naE3YwlHPpV9
X-Proofpoint-ORIG-GUID: 86wGw2w7a66iXnr7XH27naE3YwlHPpV9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzMiBTYWx0ZWRfX9+BGJ2n0GiV0
 tBRsn6jmdQEUOHm7TF5S7RyKhHF3b6e6k2ExgqKo/rm0SvVuMhB+MnVUDhLpuYFGAXw8l/46Uz7
 PO3cc/UU9Q7d0sYYEHbdDzMKenF6sVY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzMiBTYWx0ZWRfX63IJRgs9Arrz
 8vKmRWq+tq70OSXIl//k4fr9G1ORm8fXrnTvyKyOVhb//PpipDgGxk1x6jkPFc9IDihOLc59R33
 Y3LeUOT3jXa4k4TPuQOZtA0V0CvuZUVKnA9dmHTVWCyRONupL/EGSmNqErAzZkus6cNPx4Y0m+x
 cxt8zCzDeusvUA5jP3u5g9lCPFBquihVYeB2M1oiBT/LLAeKJJSBMLp2QmYU2bDJFrBjv4LhTP2
 H5ONfEY/4ek9hkfi3hr+xgrUBUZ3guYQN9p8X30zcfu04CNmQxKpx7ZtwN9MOLWVKYaXJHBh8+9
 Vkup+hlaiYelcTHN4+y8JfmcDswP0VCUKIEISIUsTJqIKxH6Qr/aMH0SxwDwepDMuAzoAm4TYOL
 dGTUcx9lySLM7LxQn8ZHAB+PbsQ9HzZ4PNKELNN6FI2OC8nt0dVPuodUY1R7/dbTATU3mS6uYLJ
 wuyb2qAskinjXyTqLmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070132
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

_lmb_alloc_addr() returns -EINVAL when a reservation overlaps an
available memory bank but does not fully fit inside it, and -EFAULT
when it does not overlap any bank at all.

So for the partial-overlap case, it returns -EINVAL and
boot_fdt_handle_region() in boot/image-fdt.c prints "ERROR: reserving
fdt memory region failed" during boot which makes it sound like a
serious error.

So to avoid this, return -EFAULT for the partial-overlap case also, so
boot_fdt_handle_region() suppresses it.

Updated the -EINVAL assertions in test/lib/lmb.c's test_alloc_addr()
that cover this boundary case to expect -EFAULT.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 lib/lmb.c      | 2 --
 test/lib/lmb.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index ca00047f624..745410a8895 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -752,8 +752,6 @@ static int _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 				      base + size - 1, 1))
 			/* ok, reserve the memory */
 			return lmb_reserve(base, size, flags);
-
-		return -EINVAL;
 	}
 
 	return -EFAULT;
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 168c66ae649..e6c05a492df 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -781,9 +781,9 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		ret = lmb_alloc_addr(ram_end, 1, LMB_NONE);
 		ut_asserteq(ret, -EFAULT);
 		ret = lmb_alloc_addr(ram_end - 1, 2, LMB_NOMAP);
-		ut_asserteq(ret, -EINVAL);
+		ut_asserteq(ret, -EFAULT);
 		ret = lmb_alloc_addr(ram_end - 1, 2, LMB_NOOVERWRITE);
-		ut_asserteq(ret, -EINVAL);
+		ut_asserteq(ret, -EFAULT);
 	}
 	if (ram != 0) {
 		ret = lmb_alloc_addr(ram - 1, 1, LMB_NONE);

---
base-commit: 509312dc5386ff4c5adabf53a573abca0aac4ce5
change-id: 20260907-lmb-alloc-addr-efault-a29212da721d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

