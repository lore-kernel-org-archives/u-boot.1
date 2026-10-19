Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC16CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFAD36073D;
	Mon, 19 Oct 2026 10:50:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nInpSjE8C2ME; Mon, 19 Oct 2026 10:50:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 99615606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407031;
	b=UIbTm+otPfHMdR9keRVuk5JvV4kk+wOnbxTd35I7hI3KUNz7YQeucMLjYkc35t6pWw7T
	 v2rMuDYyeB7FdYd29SdKjtUkh3Z9IG/wz2seWbzJBIKhAtpbSfdLodEUuFm+cdapI6dzG
	 hHumEqfNg1EHfbkM1r1c3PJts92RwjvqA/79MXn3VsbTxmB9Y+zmGasdONioO4+7BWkXC
	 jQShT+2h+bsl4/2qWdBIwksk9RxqYSZoFqGRs70JvDP0K3VMToAgVoea6d0cQP9DUQ4B5
	 8z5dtRpCy5OwFetsoEF4McQOCyd6Tg6SDZhE90Y/ov2g69z3AFYL8vEI/JcGR8qev1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VIY0aBKGgBpJVgFHj0e3pcGX5oTCFMGKpk+3+8NPgWI=;
	b=h1pYikteBiuYbIP6T271mf8fSR/CmyNA5ljDGHeYUSz6ygeHfIolA5u0A184lGuua8CE
	 1ZrgHbMuk86buw/zLR7GfiiD0EzVpDotD3Z4wfADp+kFIwOELc6YAQDWCfx57sZ6VO8l/
	 M+FtHlCIbo76z6KQuzBzHsBGQpCDgCj/6bU8oeGVkEMaILi5Lg17TTkNMS3e+SiOsONGn
	 uCjgxjnEgYs2CSrVu1/K/TKqr/zDCbp199V1LCKZ5B+4xV+G0AtRr/7w3E93ia4majU0r
	 91C/JkMbPj4EKnuKoFhaGFjkTfbu/pR3mBH0s9wh+iW7cStWIMcvZmnGceV/SLd7cbw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407031;
	bh=VIY0aBKGgBpJVgFHj0e3pcGX5oTCFMGKpk+3+8NPgWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FFlDpNA4scj/IVfV+F788Mufd5470s6QMlrsHaSZLNFP8u2GDg/TJcZmfvjLaLmGn
	 AIj6ip2KbA+PgfjMrK0Y6EmCIx2TDGgXWszM8Rj4vyfqsXMMJWVT1Pjslwq1xch+Yr
	 bw+lWGOrVutK8F19E5bi9/QZRYJ7CIw1I79BkHwBaVu7lhyFdLOa8NZPo/D7eAd073
	 P6JvXG7nGVWbb66o1dR1VsJ1uNQn3h9D32uB9eIVPPXUGWGCYgCdodL3meFZGk63RC
	 JMwG5vGfwkb0ypcTTVPojkHNb5V2Vo8fQ6jJwB3Vqxv9fooN7xIuMIe+xDYrEL/2gY
	 eiGwcnGDv8cfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99615606CF;
	Mon, 19 Oct 2026 10:50:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 638C81E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 493E980D2D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lvrrpJgV_sRX for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:50:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35DD880FF3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407029;
 b=J7LKSRp84aHh+LlqH9CQhDzo+eWTV6oZtI97nmuNrmXjCrtzRY2EAcmyt2/MSvxwz1lK
 iCSoZ/c97jNhIKmqbPPF2wyytHq6XOeY/yt8OGy8XPkekdnJsE9LLWMnojx0Vx4ToN5Wx
 akBd9k0twnHycRI80xyBn9kMkQTIoGnKT6nmZixmLGXaemp0pNkA3/NwZoz6UaqEOylKE
 /AEIx6y19OdLleaGCO7cc4FdISgX/nYeaH1LH4iyCv8f5CCRTyiphbEoBc7mlNlaqpKZx
 NecEuRpcg15e1WM7hq8uZtJInamcAWAuPeSXVXVI2oK3CgGfjSSKfkVS1aROjoeeGlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407029;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VIY0aBKGgBpJVgFHj0e3pcGX5oTCFMGKpk+3+8NPgWI=;
 b=N+LP72u1QGbR6480inJGc3PAXtUlVXJoP06GyjFqArvpSn0x67jkdQK/EOGqTfzoJ7cb
 F0wClJl6SezXSr/QvT1ptLGgokJRjM/V7zexj5ZMgnvOZPF7FxEwzn+f1Z0Pt8ZZUH3xL
 IC1d9Iw32yRAUqNF6Y0m0KFlQ+wuR6ouHm8yKZncxChkKSgc8zSbmCB1vW+Y2BpzDR/7q
 c0YXJ4YuGban311xQuSNJ6qR8ET3YSv1d6izJk18vk3w9hXRjHGsKVBbQx7DKE8LptsRe
 XdrP8eo8HnTU2Mfs1ti65AQB3K+DmPEsaw+7l4nyazGLTB/Q61GKu3zEDrckaU8ZrRw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=kZkMKon+; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hQxLidnS; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=kZkMKon+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hQxLidnS
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35DD880FF3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P1BP2042098
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VIY0aBKGgBpJVgFHj0e3pcGX5oTCFMGKpk+3+8NPgWI=; b=kZkMKon+u/bcief4
 eXxsAzecS0zBNNo28QS1PdIqG24/SYkUtFpfEOFcnlsA1KfulCnwbXfLhLD6t9Yw
 kCkPXoFRIb20wYURKnoLHehTKnnOqf2rXv9jFJsfx53nUHipVrMgQGd+LJ90vObf
 pmlKGIYPKXv36383DGJ2uqxbpHk0RZp4ZViRsmLUb68KIXvw/k7bk8qisOMjf4J+
 aKacTxTkUcjeew41GfK4Xz85qPb8rOPGRPMt5sWwDf5n4ZgZJstoPqcWDh6vpPYy
 JenNBPZKGGcVB1eV+y3R2qJ6j64B5Lu12o/+Ruu88TJ433DJlW+Ep8TU38XszHNl
 mAc4DA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur2bg9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:50:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso5028912eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407026; x=1793011826;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VIY0aBKGgBpJVgFHj0e3pcGX5oTCFMGKpk+3+8NPgWI=;
 b=hQxLidnS6bwKBl02h5KVD3ccHL5aOj2BFtBKaYlkj0qKM9zx3Mt9Jd2mLc/G4Hk2Ep
 ipvKBk2Njgc8v2KTf2WKvr/O6Of6+3UJ1ZHBjC+Tpt8uNLbUkLypu9hERB43a/QHzkpE
 omQnc9zw726Zy7/2ZDAqvmiVlc8W9U7mEeuphqDEcB22BwEqogcAe0X5z3KcWCdVl01Z
 jx0iXFVudlIxAVEQrLEVzhwXug2y/EW2l8xoExY/A31mSW6Syl2OTlPlhfLs11rJ4Y4q
 Rsk9MFiYoYtoo6/74t9AhXlPZjls31adI4WZD+hhigWZWGwFJmwb95RgtnlOrk6KTUxf
 otow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407026; x=1793011826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VIY0aBKGgBpJVgFHj0e3pcGX5oTCFMGKpk+3+8NPgWI=;
 b=nuJCZQLlDfKCmiPuzAGfPb3DfF9ZR8s2qv9n0Aeb4gM145m6hPNVIaTVaA5i1dOd3W
 RK2zAs2hRjUGLN3mvzVG9XAbElU4uojYJelj7pLHbHrFxmdhU0gG/aYfV0o0S2tlHiuh
 BrA/d9PAL/ZFPY47wMDB7Bb86ULzF4vMbl9iJAnLGBB48UrTLaYG7Sh07CRdjsdWFdwk
 Q/O2psmGdTORdvcMI5w7UuL67/9zhU61B/bgMVDEe2e86RtvrC0wDvMwkDCfqOCrw1GN
 wrwt1HTAl4gEi2PuESTSaPqRJix5kk8Hwe3hnyPkDU05XugVL/iGKtvpInKDhaeZDBLk
 3uZA==
X-Gm-Message-State: AFq9FYItI/tK6QhZfFmrk9ic1BezRXimLE3xNz8nq6pJMnvj7nvRfGl7
 cs79J8BX7esoYodZMf2aozYia3Q+LLX7JFBEm5fxgabMvmglmabV3Ke2KHYiBx93OA95QRc2nrp
 fSRGvQYLWrUZUquExsw7QvQBwL43ldxkbnX/byYGUaf1mSMHa8ELXfVi9F/S4KyDeTzwMC2k=
X-Gm-Gg: AYBFou2rn34gN/Gf2W7kDw6N88Hy6BJZpaWnQal2ZWdQ5uMBqWf1QRSMcewjhMCw4mX
 e36WaDIknAGBQteczJ2cxt4VM2uUsJg5nkJZRQtCyjgoiBfNn8LUoJkbSYE+BXib8EH0vaKsozK
 VPCP/F3dbv6znrBI0CrQkzKtDMmLPaoCXlb65SM7SEdk3RAaB575MBkzsLEWKOAuLk+ULMQ5JVY
 IjzVB4L/Y0UFffV7v0+k4aEW17RGUSSjSLiK8Exb9qPGilT5D3T194ZHB15sIskRAASwuu78bHs
 Wp1vBWO79zVbzV3estpmeFpN6Yj2JLNbGBkCsZUFrEnjX2tbvnLxTMSbMYqErhlobWxyVjDwJF7
 6+5riaYjCrRMQ3fSqpvdYoUlqWrcKTHK6jjgjTad+ASk+AzZX5sxjxJl9hUDsohzqlsf3PVa4gi
 i+imkEhNkd5x5k9JP29kFOYQ9Gwsl1
X-Received: by 2002:a05:7022:e80a:b0:15b:722b:4bfc with SMTP id
 a92af1059eb24-18513b99f8fmr14483398c88.31.1792407026206; 
 Mon, 19 Oct 2026 03:50:26 -0700 (PDT)
X-Received: by 2002:a05:7022:e80a:b0:15b:722b:4bfc with SMTP id
 a92af1059eb24-18513b99f8fmr14483326c88.31.1792407025512; 
 Mon, 19 Oct 2026 03:50:25 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm25187828c88.8.2026.10.19.03.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:50:24 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:18:56 +0530
Subject: [PATCH v4 1/9] spl: ufs: rename SPL_UFS_SUPPORT config to SPL_UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_ufs-v4-1-61432d0b258c@oss.qualcomm.com>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
In-Reply-To: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407009; l=5171;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=WJfD6jCj7shMyD0NNHZ11BUO/u2vrcuFE0ezrKA4nFE=;
 b=OqFsjy4SllIb+S7ALdYzFHNzokJq6SdBWt96iIUS3HudJzBKAUKMuGP4L3b5rEFKWJfrpwt0F
 Z6xRjEEz5zvBOOjobc9Wudgom9UZBfpOY+Y4PDXxEEdPGIOVQ0tHiy9
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfXzI+H4CVkXd+Z
 2bI+v4ELtcmomiJHfQMkSdSOXQUWmKPlxhNPOrd79zUorHxFkkViQzaUbkm0+fSwnN7x5opy8EQ
 00045WYq6Rjz1tLus0r1nE9OaQaenG0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX37XF7+emees/
 nZRYCTKoOdZovgDcJjJ9VGQ7TevupvwNJiguvVKJ8Q2MSJe/q+3Jt9NOupcVvRgMVh9DisEwT+T
 uAxmiS2SdmM2wRWbCHJRQC4gNZby4ft8MGNtH7L34dCBCSlG5H6pgQUsPcMOqN2B4RFHvDPiWaG
 bijQq2huWMMIPiERfA+CcDW+4YYsPRa/4tXmgTubw3rvS2CtawVU9zmdMS/LxOgrI74YnhuUkDL
 BjS6sjKYW3pNe+Ga8c6a1OsC7cC0W51P8vquDmQESNOPJOa9VZ/DhuhbiFRsxPlgWho/QI6rKHX
 IOAQwrOUOy3WtuMI8ARyBR5QxrlVgOh+AFC4v5tIZdoXKHhsnvLoXswvk9vffuQbhfIHenDuk1o
 4B0QOwWBmsu6rvZAvPDIy+gEmO3OrnrxjkwZ2Y9XQY9GQ+yF9Lu7fElrsXAXytfyywnkzilP/Xk
 qZJFYRWl0hZknNyHrWw==
X-Proofpoint-ORIG-GUID: 4Do-dfYCT1QccOvWZbQgVjxFGePZ_qZw
X-Proofpoint-GUID: 4Do-dfYCT1QccOvWZbQgVjxFGePZ_qZw
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad5f5f3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=kZfgXYiRI90XAir58TwA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190043
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

Rename the Kconfig symbol SPL_UFS_SUPPORT to SPL_UFS to align with
the naming convention used by other SPL storage drivers (e.g.,
SPL_SATA, SPL_MMC). This shorter name also works cleanly with the
$(PHASE_) prefix macro in Makefiles, allowing uniform use of
CONFIG_$(PHASE_)UFS across SPL and TPL build rules.

Remove the unnecessary `depends on UFS` from SPL_UFS. This dependency
is not needed because SPL_UFS is a build-time option that can be
independently controlled.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Use CONFIG_$(PHASE_)UFS for both scsi/ and ufs/ in drivers/Makefile
  and drop the unconditional "obj-y += ufs/"
- Switch drivers/ufs/Makefile's ufs-uclass.o rule to the $(PHASE_)
  prefix macro

Changes in v3:
- Updated commit description to clarify on why SPL_UFS does not
  need to depend on CONFIG_UFS

Changes in v2:
- newly added in v2
---
 common/spl/Kconfig    | 7 +++----
 common/spl/Makefile   | 2 +-
 drivers/Makefile      | 3 +--
 drivers/scsi/Makefile | 2 +-
 drivers/ufs/Kconfig   | 4 ++--
 drivers/ufs/Makefile  | 2 +-
 6 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4930ecb0861..c837f831212 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1639,9 +1639,8 @@ config SPL_THERMAL
 	  automatic power-off when the temperature gets too high or low. Other
 	  devices may be discrete but connected on a suitable bus.
 
-config SPL_UFS_SUPPORT
+config SPL_UFS
 	bool "Support loading from UFS"
-	depends on UFS
 	select SPL_LOAD_BLOCK
 	help
 	  Enable support for UFS in SPL. This allows
@@ -1650,7 +1649,7 @@ config SPL_UFS_SUPPORT
 
 config SPL_UFS_RAW_U_BOOT_DEVNUM
 	int "SCSI device number of the UFS device to load U-Boot from"
-	depends on SPL_UFS_SUPPORT
+	depends on SPL_UFS
 	default 0
 	help
 	  UFS devices are usually configured with multiple LUNs, which present
@@ -1663,7 +1662,7 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
 
 config SPL_UFS_RAW_U_BOOT_SECTOR
 	hex "Address on the UFS to load U-Boot from"
-	depends on SPL_UFS_SUPPORT
+	depends on SPL_UFS
 	default 0x800 if ARCH_ROCKCHIP
 	help
 	  Address on the block device to load U-Boot from.
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 9c94e8f143e..9714ada59f4 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
 obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
 obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
-obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += spl_ufs.o
+obj-$(CONFIG_$(PHASE_)UFS) += spl_ufs.o
 endif
 
 obj-$(CONFIG_$(PHASE_)UPL) += spl_upl.o
diff --git a/drivers/Makefile b/drivers/Makefile
index ff6853b06a2..5fc72932652 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_$(PHASE_)SERIAL) += serial/
 obj-$(CONFIG_$(PHASE_)SPI) += spi/
 obj-$(CONFIG_$(PHASE_)SPMI) += spmi/
 obj-$(CONFIG_$(PHASE_)TIMER) += timer/
+obj-$(CONFIG_$(PHASE_)UFS) += scsi/ ufs/
 obj-$(CONFIG_$(PHASE_)VIRTIO) += virtio/
 obj-$(CONFIG_$(PHASE_)DM_MAILBOX) += mailbox/
 obj-$(CONFIG_$(PHASE_)REMOTEPROC) += remoteproc/
@@ -77,7 +78,6 @@ obj-$(CONFIG_SPL_USB_HOST) += usb/host/
 obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
-obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
 
 endif
 endif
@@ -125,7 +125,6 @@ obj-y += thermal/
 obj-$(CONFIG_TEE) += tee/
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += firmware/arm-ffa/
 obj-y += axi/
-obj-y += ufs/
 obj-$(CONFIG_W1) += w1/
 obj-$(CONFIG_W1_EEPROM) += w1-eeprom/
 
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index c9af60d5d03..6d1f57bf101 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -16,7 +16,7 @@ ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_SPL_SATA
 obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 endif
-ifdef CONFIG_SPL_UFS_SUPPORT
+ifdef CONFIG_SPL_UFS
 obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
 endif
 endif
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 6dffdc00b32..8174a7acc5e 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -78,8 +78,8 @@ config UFS_ROCKCHIP
 	depends on UFS
 	depends on DM_GPIO
 	depends on RESET_ROCKCHIP
-	depends on SPL_DM_GPIO || !SPL_UFS_SUPPORT
-	depends on SPL_RESET_ROCKCHIP || !SPL_UFS_SUPPORT
+	depends on SPL_DM_GPIO || !SPL_UFS
+	depends on SPL_RESET_ROCKCHIP || !SPL_UFS
 	help
 	  This selects the Rockchip specific additions to UFSHCD platform driver.
 
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index e7f3c1d30c4..7c1db11be7b 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
 #
 
-obj-$(CONFIG_UFS) += ufs-uclass.o
+obj-$(CONFIG_$(PHASE_)UFS) += ufs-uclass.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
 obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o

-- 
2.34.1

