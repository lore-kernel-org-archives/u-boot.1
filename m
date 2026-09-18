Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E55C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 05:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 890FD60BB7;
	Fri, 18 Sep 2026 05:22:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fprz-CuOrQqq; Fri, 18 Sep 2026 05:22:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 753E760B9B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789708945;
	b=LCJ4UI5IP7enHHYZ6UeJ6V4kTzB07PeQBdi5Jsv0TwAv6fv4ypxjEEJpzQnIUNPCAcyT
	 Uutb5Yo7qgL/B5Lr+uKMymOBth2NmTqt5u72BIEye5iTxx8b9Im9M23h266zkHfX68EsF
	 PXlBCEkMfdsfSXmwMnsPGfL8bfT7GSp8MOxKJl82VsPM7ScWp/eykOKgZWiNWEuYIBTSE
	 OgwFjRJLW8BYo/wINuYfwM6j6BUHW1F1xUVxzBHUOF1zRmiNFktAtnMEp3u6s4kgZki5/
	 +F9O9HoN8RaSXA+q5gqlxLgNfMrAFB5wpujdLAnEr3biQfr9Di4lweC/8xH8N2YFJdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789708945;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xmFoFgIH6bSTJ7keI3M+DHABrVhnWcIIeYWwnrEDqoE=;
	b=Ot10tTrXc1DBz8gik06DFbJCuNJrJQPI49+/Q4cDRdwPSe1S1QTu7dm8N42VwB3BDYWx
	 uM41qQp4rnZnCPAeA1ED1uA7muDVQUx1BZbhXyTaFNBr6HSYYXPwfVcC3Po4KsMgdTp7k
	 zy7dfDDo/QDQldX5pqEC49PALwTvgLdZ2qGh6goLzQVGztU9NGpr36OhuSaSbQqi/Qxkh
	 UC1zn8H6L4Ynd3tQhfdouqVa4LvcUG6VOwq29ef5kAUEOZekgRSbNdQf5q7Ujxrm3nxw2
	 YGyp/DsBHweofQcj347lo06i6jT8lVM6ohUVPLSepuDyZTNuRFucBrHZeJpgEM1G0mg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789708945;
	bh=xmFoFgIH6bSTJ7keI3M+DHABrVhnWcIIeYWwnrEDqoE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jUtiqyX4T5eaHOTOhbkdFNc0qh0OeuZ31fTuckaypvYf0TR6FvSCri4BDnH8TNd9A
	 pzGg++NSemEGEFo7q8o/y8xLO3V4Vvw5B7QMoKZJGKaVrrEm/3XvtSBDiuBBhdCrhV
	 GvMOdHY72qYm5w4bEM+FifJcW6VgDkzwbabxYGERaHk7L2CCdVG9gQjk2tmASECWAG
	 GJe5E6+ZABqMbi4IR7L1GGhuRjoAqex+QcYJbhYWBBHcJWSBXtdBQe3kMn6UegYV0+
	 VT1a0w6LhGvtb7MMNYdXRkN5OSpqZtCJUON5Z0ltbFnzFV3+i6IOJcfSCeezd9zBO4
	 YGSLgZIDdhN4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 753E760B9B;
	Fri, 18 Sep 2026 05:22:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0A5E23F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8700E40844
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQEBsHlp-BrS for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 05:22:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 159D6407C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789708942;
 b=KNR9lrpUFfuRI5S5rKsz6eKs+oWwlrRZXjH5eioT8BtaiDyXAiNCjrhJosIHnR+sz4OL
 wcM6ktuZrVyHE+Ayox5f7djTgfeI8sp87JWpNh/cogM58PdCBewpkLo2uR9RnjE5oFP0/
 HmYGfYEBdB9ROUAPMKNUJwtORifP94lDZPx73Ff801wYpFC+Y4zDE6RXLgxlItnZMke63
 O9s+B9U0zITq5eyetzSV738lBEoaY2RQMmeqmnsScHjWk9x7UbKGs4xVuk2Sy/lb00tRV
 vbgIBLG3C4LZLIKQ/E+SMHRxxHO9dE8I2wVFoDAReYKwtqeEvHqPppvnYA61uTW/gOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789708942;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=xmFoFgIH6bSTJ7keI3M+DHABrVhnWcIIeYWwnrEDqoE=;
 b=XS18FETgwcgApXE+E51GsUbRzuW4PqJM63HcveG03Ka8scvTGIzLBE0mFIUVZnHck9xR
 aA3ik0gyTrY+7P6oCk6PkFzJpsdLAW1++hPKGAsS3zl3oYHX/jJZaQJvo1iDKAUun/6nt
 vE75gDRxskoZjd/R8CpMbFCGUITR2NgqoSdIgPq1kSZw9cT3d43HiIWnq74agivgdm6XP
 lMYOaH2Pom/kGHwC9skwAGEIO1uffHAgzw8i4cu7sr2FMMnfcy/eaqfXDhDb3NoCdCWbW
 EbzNKrobsAUP0MbC/UyDjpakL/QC1rfJxNlGqE8cO0O5Vms9yR7btBYcox+p6m7Nicg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gKIdvCfn; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UTAIIpQ+; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gKIdvCfn; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UTAIIpQ+
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 159D6407C5
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2Uhcn3492138
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xmFoFgIH6bSTJ7keI3M+DH
 ABrVhnWcIIeYWwnrEDqoE=; b=gKIdvCfn5gViMQd31DZnM4xV7hlqDdZjjOypZj
 WbSBGkjYmhgkMat2OALelUiTJDYs/RHuHWXtqLe9VGgErrCupICeyOz/Q6OtKJDp
 1rKEcJTzOdC5l/Rx3ER0s5QROcsRlpc4em8GgsEPLpPOSCmHk3a6MIy1PdvzkQGP
 whhLyVIMmxC+hZNxml+oUbX3Y7dTYdTJnpZGdG12vIaSw0s9tMc78OgyomODxvx0
 M5V9nTGXusKUOGrmr1ttKHGkTFvRw2hD5k+OHW/NHhkuO+UXEwEfS6FV1FGJxfx6
 YHhaon6xIOF/uwv6vlXSTRMWM2cBElppSi9FTcS1Wrjn1jmg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjkt393e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso824898a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789708939; x=1790313739;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xmFoFgIH6bSTJ7keI3M+DHABrVhnWcIIeYWwnrEDqoE=;
 b=UTAIIpQ+P0jsVExEi4vIkpI/sYHZIGNDjhcYkO5K8YwipCRAODr4rjXhADVZkZT5Ky
 sCHqDOvlkptXaOmv43xvdsnup0HVIQf5Flxj6GE63F2N4/ANnalXyOlViwmrCRpMoHd4
 Iwe1+2BIaukcIYD4SXq9d8L5i6LyN3XVIuju6wR8FoZFMZffJzRZWV9rde85Gow2FWze
 HMaDYIyVCkF2QKMNQij9i7SBWpuuRemAXhcxk8Cs1HzyVSn+en9yOfCsL1TxUflYkb2a
 3cvDV7FPJRW8p18oQLbWUToM+OPTTtahRCkZTFF5ldhsVU2GU8mQdmPRrPYI3crAMkFi
 63GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789708939; x=1790313739;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xmFoFgIH6bSTJ7keI3M+DHABrVhnWcIIeYWwnrEDqoE=;
 b=NBqldLcUBxR4w1f7OIBCHUAJ0xpNjDuTYWMX1Bafxn81HthWmacFRkgcEwnDUGLaWd
 f4RY9DgKAwFSLNjJlHvN3ZgX609ZIWHSfMTLa9hA6DouJAoTUgCw39eJzMHMX02coFuc
 BHMZzyE3Ft5is3qCggEczgcD8+7ifvFWn3BKlKaO7QuA3Ph544nBLqU6AQL7BCTCB345
 PIDCjLjY/QJZCY1BTkNmScIEytK7yxrkXgqPvgNjkq1YqOnz8yUsnsOXEGE+VAnperIT
 0aeUq4a0ZFXAZKkVepVDp+lxe06WPpKhM/1HgwO4FZY4zSlS/1Knnzik/LGmd6l62OF0
 dAiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqM2V8ReIgp/IgOZAqe80GRFcGWzdaXsTsultaYxckFbJHupcXQp18LJVXv89Vfq6w6VIncD0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nAkhuf4Pq9+xt6BLKEnt0aYFqPv+6QPTUchtM7jz+ILFjfKg+0
 sKdvpeMMp8f6pMnK615Sljr7t9/8LvP5VgAw6hxnd54D7aN/x9UAEzqxlOAx1Y4Gb99GP6jw+mV
 h8QdD6kw11bOHy/A5nJ9lfl5h3xD2CN16a8zSrFSmmitxvX5cCyqH4aWnVAWWbImjl5EBPUU=
X-Gm-Gg: AYBFou2IAQRsOzbwgdQnQin3eUDxHSWetQz0dEGnKPipdqOQY1vpOevJlWu67ouuCsJ
 GdH/Mf84/DE1z/vu6wAJLMCPwvZnMzOPJFxYO3CkC9j8rDo02j8SqutD6OJ0Z+4S+8LkMpLREyM
 aEc88+Ac70R9rnKVUy594E0hzuxzBjZWbLuGeu8w08vIErLn4i+kov4BP8xybl/AQJtk1534v16
 QqINFMRzkPUh/dDhI3l7uxLFJn56zcliAiseewaFSMGLRwUGIZURu1N+zFeyMfJiREosYOvBzBt
 OamYbpnId322OOIOdlr4YdpGtL7NPbUguqGL/2FFTII4GyyCiGYCIR923DOS+3uHzbG6EbKG17V
 NeppSE+z5mWRZOLEo1zoXtmupAYeOronAgDs3IAVrf/7c8EcLJal896L7wgpphWWsGjnkWHM2mb
 z4hPeIwSdeQONoNEJVUvkkC3vYRltcCeTBojBREBY=
X-Received: by 2002:a17:90b:2b43:b0:39e:1ff0:331b with SMTP id
 98e67ed59e1d1-39e54d37ad0mr3367971a91.2.1789708938935; 
 Thu, 17 Sep 2026 22:22:18 -0700 (PDT)
X-Received: by 2002:a17:90b:2b43:b0:39e:1ff0:331b with SMTP id
 98e67ed59e1d1-39e54d37ad0mr3367934a91.2.1789708938430; 
 Thu, 17 Sep 2026 22:22:18 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c286dc939sm1162060eec.6.2026.09.17.22.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 22:22:17 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Subject: [PATCH 0/3] fastboot: spi: add generic OEM SPI-NOR re-bring-up command
Date: Fri, 18 Sep 2026 10:52:10 +0530
Message-Id: <20260918-series3-oem-spi-nor-init-v1-0-319dfeed6c2c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILKrGoC/yXMQQqDMBCF4avIrB2wiQ21VxEXaZzoFEwko1IQ7
 960WX7w3n+CUGISeFYnJDpYOIaMW12Bm22YCHnMBtUo0zxUi2WvMdKCsjKGmJADb6g8dWY0rbb
 +Dvm+JvL8+af7oVj215vc9uvBdX0BwFM99HwAAAA=
X-Change-ID: 20260824-series3-oem-spi-nor-init-2fe96d643af5
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789708933; l=2712;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=Xeo8xI15twFSdqOeW+293ccJ+u1gUP6OJeXOtFmlFh0=;
 b=EYe/iZUhsUqvueVpEqjk9gVjIQZGKZ0dQz9RdjMt3Gs8ofjdlC/HWwb9vMC1zogEXdckoOLq4
 BDWbB3V/qq+C4as2DA3x19F2pI1NmdaQsZIeUtbTbj8b2B71b65Y+5v
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2OSBTYWx0ZWRfX/2KGZeWwjGAx
 squ+ZYoBuL9Dx5qMkRKtAyPvdl3POHCOsLbOgqoE/jXicU78GrcpD/tfad7Seg1ZAGQ1qk/AlEd
 ruihs0zq2YZpLX2ZY8QQqMcH8HCmi9fNj+ke2Q3g1MN9ADQQFU616R/bB7+jORyM6PVyZ3V3NUh
 I6mJZ0fnBGLPWO014utAw4OzwvfrVIT4j1hgjsFHA2MrJ7HpxcYtAL7YWfWNNDfO9UDKfkxJwau
 wCrkNMxRivOwTHuyhWYGEe8gfC4AawX5/32SI7TJuoqLfLyw/QAO6wPlLM59obKfi7MnOZVAthJ
 TnhDVlP7znV/AyUv2RynIt3tGwKOY2LW2eri67axN80f5Fs2wZAgtj0M46PGFfoKx62KxpN9jGH
 CyyymXgOTaVy142LpvJ60rydIdUGMV6g38nPyyATUO346d37vGF2Ao2v9znCU/qxzbBYxhaenVN
 dVryKD6ANmt2biGoTcQ==
X-Proofpoint-GUID: -i1QkuQ38lzXJ1u6Df5EFygYmxIHHraM
X-Proofpoint-ORIG-GUID: -i1QkuQ38lzXJ1u6Df5EFygYmxIHHraM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2OSBTYWx0ZWRfX3w7ZSnii4xiN
 +5s1fdDbOzakqeZLyREYB+SZOW2WQx9jK6CusaHPcsCdxHfrtypJ941ssxr28TNKyVKsKfckddG
 p7xlj8T12cv0O+LfoacDt4elFA6NRyE=
X-Authority-Analysis: v=2.4 cv=Y/VtIReN c=1 sm=1 tr=0 ts=6aacca8c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ug-H45lWc9DSuyxF3tEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180069
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

This series adds an "oem spi-nor-init" fastboot command that probes
the default SPI-NOR device, so its driver's probe() can run now if
it hasn't already, without any SoC-specific call hardcoded into
generic fastboot code.

Patch 1 adds the command itself, plus a weak
fastboot_oem_spi_nor_reinit() hook that runs immediately before the
probe. The default implementation is a no-op.

Patch 2 overrides that hook in drivers/misc/qcom_geni.c to re-run
qcom_geni_fw_initialise(), the wrapper-level GENI firmware loader.
That function only runs once, at EVT_LAST_STAGE_INIT; if the
firmware partition doesn't exist yet at that point (e.g. first boot,
before fastboot has flashed it), it finds nothing to load and a
later SPI-NOR probe cannot recover on its own. Re-running it from
the hook lets the SPI-NOR device pick up firmware that has since
been flashed.

Patch 3 is a standalone bugfix found while validating this series:
qcom_geni_fw_initialise() only populates the GENI wrapper's private
data if it finds a firmware partition at EVT_LAST_STAGE_INIT. On a
board with no MMC/UFS storage and an unprovisioned SPI-NOR, that
leaves it NULL, and a later GENI peripheral probe crashes
dereferencing it. This affects qcom_geni_load_firmware() regardless
of the "oem spi-nor-init" command added by this series.

This is useful on boards where SPI-NOR is not usable until after
fastboot has flashed something it depends on, and is intended to be
used together with "oem set-block-target" (see the "fastboot: block:
add 'oem set-block-target' command and runtime override" series)
once the device has been brought up.

No existing API signatures are changed.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
Depends on: [PATCH v2] fastboot: block: add 'oem set-block-target' command and runtime override
Link: https://lore.kernel.org/u-boot/20260917-series2-fastboot-block-target-v2-1-2371f8b15de5@oss.qualcomm.com/

---
Vandhiadevan Karunamoorthy (3):
      fastboot: spi: add 'oem spi-nor-init' command
      misc: qcom_geni: implement fastboot_oem_spi_nor_reinit()
      misc: qcom_geni: fix NULL pointer dereference in qcom_geni_load_firmware()

 drivers/fastboot/Kconfig      | 11 +++++++++
 drivers/fastboot/fb_command.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/qcom_geni.c      | 19 +++++++++++++++
 include/fastboot.h            | 13 ++++++++++
 4 files changed, 98 insertions(+)
---
base-commit: 31eb181676a0d7e055a7b7309bdba8fc0c52de84
change-id: 20260824-series3-oem-spi-nor-init-2fe96d643af5

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

