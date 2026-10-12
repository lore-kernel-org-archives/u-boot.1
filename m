Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E08CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C4326067C;
	Mon, 12 Oct 2026 13:36:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5777XdP9x_Qu; Mon, 12 Oct 2026 13:36:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 590CC605CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791812203;
	b=q8jMycYxfnIUDMPi9voupX6aenw/KQ/LTklMbLjErNlGA3njJPYpgQLSb6wNgsi8bg1O
	 bCy9StkzygMDnDAtllUQ4dM3R1K9hf4c/F48ZyPiG+sKDM67KxcWSSCnjXPvzqPy7DeBP
	 gcecKMm+1qieXGkqvLXd97jCYOzBfbhfR1+DOEB3ezswP9p2gf8L114Nlj7eHd5c7H+sk
	 ePzmPC5hOOelBQ12vbUEgNpDzjeegw+pWoxB6RY74srVvJXhNk3uaiMi5xnLc3Jpi9xMZ
	 K/o0+PhZCuFMiRcPxxOYRBGHv0S3Ujkhxt1/xCx7i913+tu0YK8M5+xwB92z3YGkYcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791812203;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lBxWGOebpviqvrlgLJm4C+hbNagNpwIvQkN7JDowkPI=;
	b=YS4IvufOBQr2opkO6FYqeN/gCYwq71FNzn8UBrU+1DVRkLAAq9ky1cGpNC/dvmITcc3F
	 prqdlxyeRBJ8B1hCDdY+nGEDQu8eJ5iVZtu3FgQ2MT+3RXOA5dimzygOLKIP3trsuaOl1
	 udsisgKCrShjJ+SJXzAeXV0D0bsvoD/M2YY74DBVfwbvpHQLveG4MrWH9BlFQEiKoVax6
	 /1iYoGQoS6KM90O/+QJ3GyD3sZPXqoN/qGnPRwFZkmgTF4RtUcowU+VyY0xXPaI1x0q4F
	 o3At6s4BuPgmbzYMLCPmGQlrVIbwywJDKaNpg7Ejn6VHc8rBBn2X+/VQ4m2oPtEHfwA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791812203;
	bh=lBxWGOebpviqvrlgLJm4C+hbNagNpwIvQkN7JDowkPI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kgWQc8k9+cN+mITjjnR4e+BuOX10bfN26SC+HeaX+5LFq/9C4j5MkBGTaqYyaSLBV
	 DOdLlKsCjQUOt1+Il+x190ih17yFgi/4hpgdgiPqNYj9WbJylvYgcYEKVDLcGivo/E
	 OgVvCFYNMCQB8yDWGO/a2csFbvgvw/ynWtH72S3wuy9VM8lZygYR3pPqsPkIePUEIh
	 eYIz3cmtSO70iPC9H1xirImz20scQy6PbVNt+O5fYrhKhtrTOheXa37Cl3w12Bj6AH
	 cNcdjD9dpKUg1k+QLGfbbsQC8dFhAgIaMPAEWJvVe0S4Pam/0MIc9bTLdM6MvA6w0V
	 30RgvgPPjWm0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 590CC605CF;
	Mon, 12 Oct 2026 13:36:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D76F2E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13D5B405B2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e68nW4DuSPv7 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:36:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F1C2140580
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791812201;
 b=K7j9M1/BdbqbRtKLIjaTAObiJ4Bp6bXOY2UpJd0/4sNnAZHwqhMmFCG4uk72yMEVJgmM
 5JqMeoa53QIUFuGALocjkLJHmt2r0gXXQNhEDMVWOTLi25mF+uUJeN2BwDIK1YqbG/9qp
 YyTzGhYck4EEiaNqTtA3/1n7L86M9gfx9vi2ZaF/LyEdYKsEbn/MKhUJAH3418NXNHZlx
 YyyP7Vttl3NK4h74cHK4zVnpAohF4jkmBDIYtziIUbVq5G6C3VTNp85RKVuyC2y3E4TxF
 vLsi0/dlZB2pbbmqGwE5JVz8rIBsOU34tO//2Lk2CVqHF2IIHO49WS7LOzsdJgAEWHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791812201;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=lBxWGOebpviqvrlgLJm4C+hbNagNpwIvQkN7JDowkPI=;
 b=rFr3DIPEGc+51NLQQS69Q2hq4kHAMVZJ1oRx97DjNS2M9mtk9JFBEK46OS5EsL3oKA69
 JlxvxbAZJSWe6/ld3yg9faMCAFYpAo43g/PsyqM2L1GAQ3hNfqvjpyvjbzP2x8ffKXYEZ
 +nN6aw5uEQYKdqaXyqTEnQo733dAAVpvVxThG5vvHWT6BDYbSv5jplYyeX5Oiz0LhhEKa
 ak7r852+Rlf7omOtZRPjO1oYF1SJYiXGJ8Qh9KZqDuAJVXT4OmVvTvbUgNC/0iqM7tJDU
 B5ShuFJT+bZYWxnqmBQB0viHrkD4lC5uA1oz5UzLIC118fbG1axpFCo6CnPcSFi12mQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=fzmsvE81; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dY63roMq; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=fzmsvE81; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dY63roMq
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1C2140580
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC08Ir1933179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=lBxWGOebpviqvrlgLJm4C+hbNagNpwIvQkN
 7JDowkPI=; b=fzmsvE81K7p6bvFekUX83rkIIFA3RugN3VuMat/p/lgCOuVGi9m
 3qNj3+dopjv+CLfyxyTDisFujyQx0KekqQzrhUM9XTz5J2fxq/fk9UNIs5JG0+pq
 3VZPkoHPFxb0yVsgUkevZ/nfGXLDV9Tr/o3sw11jPTMzIJkgmU0ZMvDY2i4+phcM
 G0ytIjAMMlrplOniFZDXY9DjVhsdNQztZNjHAQzfCxdYVpMv1o8wGiTsWOObZdsx
 3WZr0EbcHLlEOKG1d8J+O1T0PTFTSlFI4hVHO+nvgc1a5oukznmpzfFdU8qW/zDd
 yLymz4MA1rcyzoskLpjVJYYFHdw7FPIdF4Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkjdva-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso4668864eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812198; x=1792416998;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lBxWGOebpviqvrlgLJm4C+hbNagNpwIvQkN7JDowkPI=;
 b=dY63roMq+QAUUQ3hF72QSUJoyT4mb7hYO3xDyyAMkmMxsQhmoa7RD9mL+GJUp3Xg1q
 HibDLGqNRulPmdB80sOy/TQ6Vlk28pRicHEVplfPlknkdZHvqopkNqbu2YPkrcTfSFdK
 NhfTd2rRUfjSRPqdL82z1+kceue6mZbtHpwZWR3eRwp1iITYEzkKFXyC1pZPbuKoFtd7
 Y2kBu0NsfMsVfhLi8jFfR+3SnJInO9WG4folXKPuZWhOL93mRiB/wafqAB8kee+OU2jD
 HOaQw0RoDaJCVaQ0AXjPVPIo7maIo7D0dg3VsJ8/5jgwtQL5ZP+mC0CcNbYcZfYUtA/R
 P7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812198; x=1792416998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lBxWGOebpviqvrlgLJm4C+hbNagNpwIvQkN7JDowkPI=;
 b=1pkKPTXNr4UJTifxYl4f9bxPkBxYrhvvuygrf2TnaGMTkHVZERcadfn+5puiGP5l68
 QEKJEgvDvsEhybj5d8maACcZEL6VBHdMCJpwvFr2m2LBNQIU2ErJWRvuvrY9DSAdMB6k
 +9a45+b5zLXebCVAbrf+B08M5lOmC0pATSAh3e2c55RK4ErEE736d9S7IQ+/k0cfWOQA
 nEfqtFgaJP43soKqq0V2PJSkBMNF9CrbLFspli0nmszNmmziVDN2AkEXKZ6xIoFOU9lp
 4xITxhxD3mtZmxIX9nw7Yu0w8q9LPsdpo+KacvgrQU+r/rpzWzjqMTv0SaJkZgIx8due
 KBCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4EMHfDguHa2Th11B2WcH+YXWhMIUbEeItpE1vCX1eTF4ERza1OXJ2gOLmE971WWzmh1xiPmY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJd7RP/tOJpY+qZJRJJMUt+beextdTOoYoxYzGMnmGqOlDu940U
 dxB4WZpARYtzlAWztc1ntevSSM/FC06VgUBDl4pMbTvmy2GHWfmpneZx0eOzPa3kKpqmRIxwYjd
 IxC/CyL25gUY27AUcjJNbyA+HNo+E0RPhItuEH4ggmaTzoFhaDGTCDylkH8kKcsfVr2d/NkU=
X-Gm-Gg: AYBFou2eO8VtAW1o0uL9I7HB4tHH6shPJaQrM0/+n+wep68mwc+3D2G9WHMbYUUIreK
 tsO+TTlrmppJSwWtaA6YobhijjmS6NhVEegHH6Qwq73jyiv+bf3R/qRueVschlEDAHvbS4+wGkB
 avv2gy+BHM+W+bGK1r30YIzj6aKA/5r3cZ+YzhGleaapfhHsTceCjgcV4T490qmd8kvJyn/VlBx
 b9NwJ6qMVzRfFAQ2YVM6UmK1VHT7a1rejn1fSH1ktDtRArNydhhsAHIIs12/C8ps6dNHimLCpSV
 KFPRrpw40nlmToDZLfwslcKobDdaD2ymohmED6HGWASEUmvrQIVl0ePuprA4MLF4TiMDdeiuQhL
 xEn8I+qyvAOxx2O0Dwr004z7AFkAfBh5ypNQY9yQr67mBJgLFo6hLVJWYMOiZ9tAdhojPGpiGbT
 rlls9APde8R/ImLm71fhh4
X-Received: by 2002:a05:7301:9f0e:b0:353:417e:aad3 with SMTP id
 5a478bee46e88-3537e069fa1mr18728165eec.33.1791812197582; 
 Mon, 12 Oct 2026 06:36:37 -0700 (PDT)
X-Received: by 2002:a05:7301:9f0e:b0:353:417e:aad3 with SMTP id
 5a478bee46e88-3537e069fa1mr18728090eec.33.1791812196845; 
 Mon, 12 Oct 2026 06:36:36 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-359789fde97sm18323802eec.20.2026.10.12.06.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:36:36 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com,
 badhrinath.s@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 0/4] Enable fastboot support for IPQ9650 based boards
Date: Mon, 12 Oct 2026 19:06:24 +0530
Message-Id: <20261012133628.1569010-1-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX2zqVzy4Cmq2b
 oiq5XSChYDs9YeVwAlB2xNMwJ0YUyk2BFmce/IVsSUzrDK8ujKEDKa+gTSLT5iacQ/JPqQ17woa
 kxNvjFMWbtHO1T3b3yxh0kG17EsPl82Ty44KNyen2O0fPymb5TKSTyWB19qJIxLOUciT6e/tg+6
 6Qbb0veLQpRXWIrl3t5DBcZvP4nsT8/pvGSdSj4ZBSkIqt3ARn4luseeGSf0hkhK0z14RMKieUA
 oLhVcpiVHpRj9UfA1ij9HgJjZUWaSITIEckkYkI7yPg2NoFTBH6+rJnUvet8aaeCsB33WV/5TZ2
 stg41WC3rwdwO74X7jQ+oa8GGrBapfxdUCMOCIOcTospjpS6LDE/YHC6K8Sni2Vv7n/egPSAVmb
 YbgE7H/qOkGLhYohfMMOrubGsri7R+SwKQml53jyq0O2I1JejGSv3OkIQWuiYjN3KAj00i8uo15
 JBh08ZqlPMpI04lDCBQ==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6acce266 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=nPKCTkQgJha4AycTQyYA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfXwtXXSicn4I6N
 EmWFYYCDAQmEjHViHEpYH05fjSutGccbIsNJ55C3ECNFVYTw8+VjvIdCWHUiqHFFfsTHAfr4vsg
 oDEmnNCinUy6L79R00uGaCtRb1Dk8lg=
X-Proofpoint-ORIG-GUID: -KANezWHh_tDr5QxOLten2W8T2gnD5fs
X-Proofpoint-GUID: -KANezWHh_tDr5QxOLten2W8T2gnD5fs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120054
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

This series enables MMC-based Fastboot flashing support for IPQ9650 boards.

This series depends on the IPQ9650 SoC enablement series which has been
submitted separately and is currently under review:

https://lore.kernel.org/u-boot/20261009122736.1185878-1-badhrinath.s@oss.qualcomm.com/

Summary of changes:
 - Add clock/reset support for the IPQ9650 USB1 (HS) controller.
 - Add an IPQ9650-specific PHY sequence to the SNPS femto v2 USB PHY driver,
   selected via the "qcom,ipq9650-usb-hs-phy" compatible.
 - Enable the relevant USB PHY, gadget, DWC3 and Fastboot (MMC)
   configs.

Tested on IPQ9650 RDP488 by flashing images over Fastboot USB.

Badhrinath S (4):
  clk: qcom: ipq9650: Add USB clock support
  phy: qcom: snps-femto-v2: Add IPQ9650 init sequence
  arm: dts: ipq9650-rdp488: Set usb2 to peripheral mode
  configs: ipq9650: Enable fastboot support

 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi   |   4 +
 configs/qcom_ipq9650_mmc_defconfig        |  17 +++
 drivers/clk/qcom/clock-ipq9650.c          |  17 +++
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 122 +++++++++++++++++++++-
 4 files changed, 155 insertions(+), 5 deletions(-)

-- 
2.34.1

