Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9E2CCF2D5
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE2E66076C;
	Mon, 19 Oct 2026 10:51:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id re6Gl1OJUaCV; Mon, 19 Oct 2026 10:51:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 22B1760748
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407080;
	b=Im+21VTWboeoc5rtl4YZtqiAT6uBxppRyp+9pTCebt7T4Rxd5Y8gaOzNf71K8CStKrzi
	 L+WUF8iq5Zp/ClG+9B4O0uOI8uAANE08m73AE1JXb9xqvY2Pv13oIyLfHz/0o9wOYRdE+
	 3yiOHaU02U9LnKmzz9tvIBZyqeEb3W7W39ltAcxiHB6zwFmmcO1riUvpx9hzqYOBm4Vit
	 /xUhZuJF7SeM+Y47m+VG6VV8x2zIUzd4E0dzGDIiwzwTf/3etuvuKJsyV6UkOCAnmpbQm
	 B1x6uOLyI70uNkg+lw7rXtLeB2KLaM0RkWIB3pGhV1Y8Ik1zc0Q09JSb6MwqXlFL+1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407080;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rIJcmCRHTuTIp1aXHSvqfX+lkGGKJ2JvZYpPfaLv+RI=;
	b=p7k2r6jHwa7bz5w28vpA0mz0kEoJ8ZjrITTQZIcLrQRzvPDOWamTV91EKbOX7zg+VG6D
	 4uKu8l7G++596L+nqpktIZVs5fxa/euqK/tq//YLdAp4PkuFggW79B6FPQqK/+aZmDcGe
	 /OQXubnx0/IBICSRNjcEQ5xb6x5bAdrpK+SSEYm5OnMbkKZCK+iunCPOzAyi/5G2O7o9L
	 IlFqmbPwmKaNjvzrxgA1Z7aqYNT2lv+eSskc4anL0YT0NxGE2wF5jaLF+Z4KhYb/0YQ2Q
	 SoTvvzUZc8eetbvJVNEXu/PS1FCAGbgcGWMcGvmig3b6+C0SIBYqRKiYKU6BV9INK+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407080;
	bh=rIJcmCRHTuTIp1aXHSvqfX+lkGGKJ2JvZYpPfaLv+RI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MAzwNlDsfFFG4QzE4uNJRONuziQdc8QrihrP0zr3+77QBg9PjOtICuKbDvNAIJBke
	 pFTL9dUq6p2X8ZoSrh1tBgGCsz41cdCxcBqa+bELIUqQcea8pVsP/PWB9BOWPPDHHl
	 ubPq1S0gaRhnG33N5IzfwM114/WPWky8P9yb99JWAS2ZD3h4h6GF1q9Dvxdm0EOjwX
	 4k1vfL34IZkSQJHVZW+LgLdMCI7c0AiSY6yusIpSUoDaNV5kX8m0uqSe8pMY7qCwXP
	 J3Wp/JFtZ0NqkREgGRo78uiDatHiNycjImghpsOqswGVPmj4/cF0X+D+6YoJw/LB2d
	 WKcrLqCn+Jptw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22B1760748;
	Mon, 19 Oct 2026 10:51:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 70A541E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56A21406CA
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kt3yfzD9A1of for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8B9DD406B0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407077;
 b=IPm7CrADgYPA9Yzb7FmESA1mVCEMzDK/jXLSlFiHIvlwx7+6ccbe7jM+jaSdBSK1hNJp
 5ajsmrKVE64f3iXXd/O+S8zMDjk0Iz8ymABtMdt9XJ+1G6Tpws6AeE08vmriczF8xZQ5A
 JYMJVJ+rnmxPPmaRHMWy32U8HjWdIw/bgww+U07knt6pLf/8/gtzCE7xNWetkBTNmsF41
 opuMx+LTwi0kbPHGrWOnI0zRY0FxkJucgThzz2qbuZVkPEhJlLSTJD30AmkfEYf1PckV6
 1tdSrkel1hFXP7QYU3sE0mU5oCk/kRrwFrvbf2uWFsJbx0aX6caDSZhCz2gGmzO0cqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407077;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=rIJcmCRHTuTIp1aXHSvqfX+lkGGKJ2JvZYpPfaLv+RI=;
 b=G175qmKeWF0sCE7S191Dsjv4GaV0ICYc1c87WD+XzmKZsuDW3XsyWIar4Mm81BNz+v7i
 RgdhdYSp6qz5eIt4NXF4TqWoDC88UWctKtk+fNuScMAfeSG3shNJ024rZaQmHAmXpgfi0
 wqcMTuUckiVChOi8kgs/m6f/3eRRlowmb7gTuhvLT1b9wqjnPSWwNuYyX+aV53mWAF/Iw
 82dpiix96Vx9zPwyR7xL2aQToQklGJ82xmBeoUCijI7nbqMgv+AbvfUMBsHXYQhIU3IaV
 wohWJlA8DIqOnsS6C992+ciS/BrnM22j+T9OvDJe7VxFsTqXncO4c9B77XuPgVAMKBw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=G+njkd4h; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="WFNm1z/f"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=G+njkd4h; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WFNm1z/f
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B9DD406B0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:17 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8PD3h2193424
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rIJcmCRHTuTIp1aXHSvqfX+lkGGKJ2JvZYpPfaLv+RI=; b=G+njkd4hFkXAyByh
 6XZMz1l+nSkcfWqttISujovW3wqbKzQumyVM6LBQzdIe/BC80iKtVM9vaqZpnRu0
 heFvWlmuKFJab+IOuVxryosDjhKPtQNc3pNytlJH0zrD0PAZAIuBEma7WPuQQ+oM
 3w+vZuplkQ6BXbkqh7TlLI+W1f7oxSEFPI2Tz1yB/uTXVCSIKtk6sbGVo/gKTsV7
 8bNiU2GPLqZw2O7May6sqrWINLxXUe/Ke7wa6DRysr+mr28Onwqy2XI+yX1NR7+u
 cklH0OBn4nKGa9ifHAaBZ5+9GUUbzuYW6O/B7MbbeivjEFVKAf9rzSlC68kUvbqI
 0sCRtQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1abjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:51:16 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so5226968eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407075; x=1793011875;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rIJcmCRHTuTIp1aXHSvqfX+lkGGKJ2JvZYpPfaLv+RI=;
 b=WFNm1z/f6+zuw+hk6G/PZxtQbv2gcnPTR10sgHbQlSg3m6jAuXT5fW3Fpg6YmeO97/
 6gf2Vde1jaC9U56C7R6+Gmw8ZLJZMS/16803GS2Du2k/DLFjuLYpSO3GMt5Fq/IACL67
 85v239nFxm3lrRR6tMYPbMTDEMjVlKyVu8xDtdalLSxikcqQn+7wA/kNtukLfXT5YaYg
 2L53v91/kCNkWugrOcG/X78k/Pf9eUm88eDm1LFz6sHqjSEp4u96AwFSkh1o2JH2F22o
 N0AFaV8vbThsX3E8rkZT9XgEK2kilfC3pYV/kTs80B2VVG5UwTrcmpwbz/Uy2TjpwcoT
 23gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407075; x=1793011875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rIJcmCRHTuTIp1aXHSvqfX+lkGGKJ2JvZYpPfaLv+RI=;
 b=p8OSVQg+w7Lbg128q+NBuaIwZ/8c1YyClCtrHL2II1o2ZmL5RuXwfp/ieA/i6Uqp1E
 e22Djx5OIJsd08YICwEOPUqQqW6c3Bi5Q5MhsdrLYbOXf0z8FZmUpLqUl2WXwB742H68
 X/OoiI53ZzyprjT75sGRzoKWsx/eOU4uTV8ZJzAZvHJB2yyozv85TsZfPXhikDiqOxoi
 bce83kp7NErXE9FXbuqoDMxck+w6b+q9DzINwxKa+k5mZIcOSghjiORCji0oHmX7QeaN
 YpQjiT+R8Hz62b8aKjo0aFiKa1DHx8UE+2vLLalvff3VpJPn6iLs33fQ4NWNPKCY9mKw
 f9xA==
X-Gm-Message-State: AFq9FYI0pjQldWgQ/yyjBS+uG9bn2bCOTA5V657W+ImllJBmJnaxfIOF
 U/NoZ8o3/mZ1m7GEMxAKbba/x1XvdffL+a/qfzNGQmNNoLCZTTZQEwZVsoJcb1Zq+luV8gez8BM
 //7uhtT620PCAOwrsFg/qRWiN1BJFKfhfDlugrjpHQf3120w3rrdJkWMqvBJG4Qwohjeb87c=
X-Gm-Gg: AYBFou1H/16Rqs+gnZ4KiqjhLYCoDwoTxmbunMdR1so1k35zuczEgpzaVWy2j6fOHJP
 XIHUPzMnsznb93E4aYmZElSAhf1sPxCMhxr3HLeBwhxSMseZwZ0NqAMTnjp8VDAkPU35+nwf1v/
 ihdM4Ph/BUczq64fr6ds4knVv4HWMOjU7gAaDgXPOTwiSqDp4D7aNecMM82WIMjow6+RAlafll8
 CocXAziXdWypJ1iULD9qnab5Jpo6JDGljBTR2WJ8jAXIt218r5U7heucYG+jpHMj+8MBTMriHKq
 pAFfR791PFsdF7xJjedmucNiRyUljAlQJMt/bVULX803m+ws+1kcUys9OLuh5UErJO4Z1uShLxP
 +bUgpyGrB5d7TDvkq367lFn4DSPcvxfvqU75QGysHSsVM1ltraStywpgPVVC9xHKKvLRl9E6MsK
 IaPJ2p+7xthuPYLi2cUHcawZ3Fggq5
X-Received: by 2002:a05:7023:a87:b0:166:847c:f162 with SMTP id
 a92af1059eb24-18514b00c6cmr11002439c88.45.1792407074849; 
 Mon, 19 Oct 2026 03:51:14 -0700 (PDT)
X-Received: by 2002:a05:7023:a87:b0:166:847c:f162 with SMTP id
 a92af1059eb24-18514b00c6cmr11002390c88.45.1792407074198; 
 Mon, 19 Oct 2026 03:51:14 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm25187828c88.8.2026.10.19.03.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:51:13 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:19:02 +0530
Subject: [PATCH v4 7/9] part: introduce SPL_PARTITION_GET_INFO and select
 it from consumers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_ufs-v4-7-61432d0b258c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407009; l=4211;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=l1TyqR75NhOA3+uTQf36y6FcEeqi2iGKBPpd2AXLXZ0=;
 b=0/EK3SjUK89yJDbXi6GfcyM809mTt82JmkwEtFzJa5T8SzrujGWA0vn0co+RL9MLyir0qRVXv
 vOZWrBrKVoOCPE2HTDcjvdZzGkh4uJvDgAFlvb1y9JjORLHvMyJpjH8
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX4yu5eRBMf7hY
 4aIHkOOKJEJ31UCZ44OuwbtHRRYrhDWpMTxcrryI5ZUv/XgiihcR+j9HeVf5RCdCAL5sLTOTfSQ
 cwykpblRDReZf+/EDsco7cnceOUqCrY=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad5f624 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0qWeDD525EdcUZiRWVUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX0rSMngCTOG32
 dRIo1U8J1IjPJEp7nIACVW/fcUbeN9Pcy/GaBobL6yUz9VsTyBQGd4wkukNdVQg6B1xBJJvuiTb
 2ls28i/ig3s6V/NGxCXuD8WOR/NbWWk5+pf4yA54jwQ3i6CMt1SoD65RMyKBDqlaGM+UiAuz34w
 uktX5C7UstFA/jldrkEHuLSUEnaEWwA4Kcb4iwSLonGdP7DNdhDKtwz602pqnTqkCVRThDOtx3R
 FtC/2m1YtUowcMX3Boj9XcsX5oEyS0XI8wRW7nvNBOgyhyLBXalSeiT24U2ChIn++22ehAwx9w2
 hjYSN3m/QSh/uqzV3JPm4AB3YKzgjsKq9kaNnIemWbIT66rYkOu4AHwH/V7nhUVQPy2wBNwN/9q
 05Ij9g5mHuEvFeb2nmoKOzEDhAUC8Y0OteG8aNB5ICqo5nphCYKv5fr0GNvwQ2KgwhHi4o0/A45
 q3HCOuDjdmUr/z+5IIg==
X-Proofpoint-ORIG-GUID: qrIEtzy3ILLiiaA5u4mipWrMMnXuWMYX
X-Proofpoint-GUID: qrIEtzy3ILLiiaA5u4mipWrMMnXuWMYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
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

part_get_info_ptr() in include/part.h resolves the .get_info partition
driver hook to a real function or NULL in SPL, depending on a list of
defined() checks for the SPL features that need partition lookups.

Add an SPL_PARTITION_GET_INFO bool symbol in disk/Kconfig and have each
consumer (EXT4, FAT, SquashFS, MMC raw-mode partition and partition
type, and UFS raw-mode partition) select it. Replace the list of checks
in part.h with a single check on CONFIG_SPL_PARTITION_GET_INFO, so a
new SPL boot method only needs to select the symbol to get partition
lookup support.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Replace the ad-hoc part.h OR-chain check with a proper
  SPL_PARTITION_GET_INFO Kconfig symbol selected by consumers
- Drop Varadarajan's Reviewed-by as the approach changed
---
 common/spl/Kconfig | 6 ++++++
 disk/Kconfig       | 8 ++++++++
 include/part.h     | 4 +---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index a32c5fd11e6..adeb2ccc7a7 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -575,12 +575,14 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 	bool "MMC raw mode: by partition"
 	select SPL_LOAD_BLOCK
+	select SPL_PARTITION_GET_INFO
 	help
 	  Use a partition for loading U-Boot when using MMC/SD in raw mode.
 
 config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
 	bool "MMC raw mode: by partition type"
 	select SPL_LOAD_BLOCK
+	select SPL_PARTITION_GET_INFO
 	depends on DOS_PARTITION
 	help
 	  Use partition type for specifying U-Boot partition on MMC/SD in
@@ -771,6 +773,7 @@ config SPL_ETH
 config SPL_FS_EXT4
 	bool "Support EXT filesystems"
 	select SPL_CRC16 if EXT4_WRITE
+	select SPL_PARTITION_GET_INFO
 	help
 	  Enable support for EXT2/3/4 filesystems with SPL. This permits
 	  U-Boot (or Linux in Falcon mode) to be loaded from an EXT
@@ -780,6 +783,7 @@ config SPL_FS_EXT4
 config SPL_FS_SQUASHFS
 	bool "Support SquashFS filesystems"
 	select FS_SQUASHFS
+	select SPL_PARTITION_GET_INFO
 	help
 	  Enable support for SquashFS filesystems with SPL. This permits
 	  U-Boot (or Linux in Falcon mode) to be loaded from a SquashFS
@@ -789,6 +793,7 @@ config SPL_FS_SQUASHFS
 config SPL_FS_FAT
 	bool "Support FAT filesystems"
 	select FS_FAT
+	select SPL_PARTITION_GET_INFO
 	help
 	  Enable support for FAT and VFAT filesystems with SPL. This
 	  permits U-Boot (or Linux in Falcon mode) to be loaded from a FAT
@@ -1674,6 +1679,7 @@ config SPL_UFS_RAW_U_BOOT_USE_SECTOR
 config SPL_UFS_RAW_U_BOOT_USE_PARTITION
 	bool "UFS raw mode: by partition"
 	select SPL_LIBDISK_SUPPORT
+	select SPL_PARTITION_GET_INFO
 	help
 	  Use a partition for loading U-Boot when using UFS in raw mode.
 	  You can specify either a partition name or partition number.
diff --git a/disk/Kconfig b/disk/Kconfig
index fc30c13cee2..7a02c48365c 100644
--- a/disk/Kconfig
+++ b/disk/Kconfig
@@ -26,6 +26,14 @@ config SPL_PARTITIONS
 	  partition table types shold be enabled separately. This adds a
 	  small amount of size to SPL, typically 500 bytes.
 
+config SPL_PARTITION_GET_INFO
+	bool
+	help
+	  Enable this when an SPL boot method needs to look up a partition
+	  by name or number (part_get_info_ptr() resolves to a real
+	  function rather than NULL). Selected by whichever loader needs
+	  partition lookups, rather than being tested for directly.
+
 config TPL_PARTITIONS
 	bool
 	select TPL_SPRINTF
diff --git a/include/part.h b/include/part.h
index 1dc510cb6b1..7c885928b62 100644
--- a/include/part.h
+++ b/include/part.h
@@ -463,9 +463,7 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
  */
 #ifdef CONFIG_XPL_BUILD
 # define part_print_ptr(x)	NULL
-# if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
-	defined(CONFIG_SPL_FS_SQUASHFS) || \
-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_ANY_PARTITION)
+# if defined(CONFIG_SPL_PARTITION_GET_INFO)
 #  define part_get_info_ptr(x)	x
 # else
 #  define part_get_info_ptr(x)	NULL

-- 
2.34.1

