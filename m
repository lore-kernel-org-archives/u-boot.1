Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADDECA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F195606C0;
	Mon, 12 Oct 2026 13:37:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NuJNbt09Z193; Mon, 12 Oct 2026 13:36:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 93389605CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791812218;
	b=LoOvP2lAhqAG8mC10hEht/XaU1LGqB71uD4Vc+5bKWxzfdkHpOmbryf5/NOD57epai4M
	 ICLrWcxJ+hdz+FRa1Wo0z+duKrIV/HuMUSYKwpyEZNxKaizG9+yYRBOiMV0WDt7HDX+4F
	 +/9kGEYi19bWxvnpYdLgf2nnPwe/Ppt0quSez6UJgPWsM7xn2DyJtYP2ki+GYB2R1QXCX
	 A+hWhjadZAcO0fsGv8aK7UUvxeOv/OXxMKN18a15b4TkKO6sPO6y4+/eDmfifkNYhonJR
	 gF1xrAKm0z4LmBRLlW8ZZBeS+3I8fUwFpZIqQmhaHiJsJ3nMoLGwvQdeiezFw/oi6Yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791812218;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/kqThYrKmtRe1JgVTBoAttQAkrKVYcXnwflSjNBjhIA=;
	b=BXLfpAHm85FxqS6F/VSteY+xyEta3QnhQR0XaJZOY3+jV7KsCsiNgctU/3PM4SkUh2Wr
	 xB4P7fncj4LnKtqL0CysEIlzOOC+ETL1/50aiDHLxOMaNzhUJHDFzuBDrVSkRUMIrYucc
	 KoWOhpnuHzRgUM8xPp34u0xggt4UML+86iXMToMOo5KtHiyIs8nYcDrjt0w6tFMmaRtsI
	 LL5yPglQuqbtcT7//7M6WkhisqCw/7vIQRdz5mBOkLpy3y49HiuvfzJJ8oLYpHylVKsCa
	 FozLMNgsTeLQA/0wuWODpRjuT5FIqx+YeFHowlG4qtwOYPEqiZxiXrXmuMMTKjq5gZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V3DuHyXf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eORi5XZC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791812218;
	bh=/kqThYrKmtRe1JgVTBoAttQAkrKVYcXnwflSjNBjhIA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NyIKWg6xLmXoKCD+6fGvCv5LxFgsfWs5Maffq/OPnzPZTuWOVJAo77d+QAdpnl2dY
	 3Yj2wi2UKKDWLK9Z43vUExhWdXxwQZ125jLSKqlGaVShMIjtD0EJAQFZK0svr7adq5
	 pkLLwZoFjX/mz/W9WyWHtYOZsXc+5G1cLtpkm7g/vOsq6EbAHvzjEWICSjy0l9Ys5A
	 IBJqizwzvXrcUAUVGo6SbuUBpHyjQjgIfabtRH2PBIng7yXnwfb4UM5rZlUA0/JIVG
	 724rlHNh2vWAr316liSkS+0ftMxTIjSQQ2kOQpJLFZGXJHv5EubDyI67C8bjkwQt4w
	 Arqc3ypzs37tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93389605CF;
	Mon, 12 Oct 2026 13:36:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 291D2A58
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0ECD7605CA
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dpRCTojkCXyb for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:36:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2542605CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791812216;
 b=V8rYJnqu/kkQ+hElxFDDQLaYU1btTUA532CC1IIf1bkaLXa2n5JP+sdU97jFmgDGCPhV
 CFOg4tutMRsWCRy5ZYHsVtv27/d2Xv4sfCFQLzS9IB2Y6/vBw10pA3XttzJN/xt+vt6G5
 JNZtxKJhi3S23AGzly21Ur0B9l61bRXmxAWrk9dZ4uUjaSI5CwDE62I78F0cI/bzj/HxK
 mlCygQMTpPBIsgVEAYu7757YSCbx6KUcoG3Bk3BnFm+Gi9gz9/UKO2vkIPnrORYC5uGmV
 DfgdqrskHS8P9fh4thJRm2p+/WGC10BNxouztdyQjdYg+4kzyc27y4TESCyFWh7j9AQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791812216;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=/kqThYrKmtRe1JgVTBoAttQAkrKVYcXnwflSjNBjhIA=;
 b=P5gD6TG7Zv0rmUI6RoUTkJH+INcT9EJ0fa5xdVqv6knaFOjpGTM8lHgx6cGd/qG41kXH
 ezlCnubZtjrimfDyC3obGzOCkn2CEsWmfnXI+uBUJ5xiI3GbaNgce0MGJugS4OthJn/eF
 XZdmWE6bntP6HkYSF4jAWlu4BTlcPRoxjckXyYKnpE0ADKsbjEOdkQy40aYiLoQ/6mXWY
 JVL2os1jWy2JRn5uMkOjwc5xmo4m81L0MO8NuOBvW9hP5ISDjz1v2x3pjSu3AAHRfqh3K
 qJnQ9neWIitsYn/Ra6BpSfCxqJAobs33l0cDh7dTDHrgbgHU4XukZJcmWP2QLjqlUxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=V3DuHyXf; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eORi5XZC; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=V3DuHyXf; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eORi5XZC
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2542605CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0VL12088718
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/kqThYrKmtR
 e1JgVTBoAttQAkrKVYcXnwflSjNBjhIA=; b=V3DuHyXfChvlNBlyJOrcOWRn/1P
 7Eri1i0S9IFBxbP9zEdFN5KhXOnsq9wRnA2O8lWMAscEQkSrgLtKsg2T60SpuQKO
 eOLdykWxaKk3geyIhXLsBqszVkL3rrGZERbKwTLGB2Q5zoaVr6YE9qEriQwEUpdP
 +AQ76/6MfjEaei5uIZbSGojcZIUykzN1wgnmxlJpRF+W0A2OtYjI1jpfsyJWNACa
 tXXevwab2aS6p76udqawvVZg3OiDMuD6uMpXZrg+6TE0xLUY78TJgyS2X6KRRVxF
 GIe7S+gjS1TmFYlGT23YAkTgw2LeTUflwmmGAUVXB3Yd4pHjgwhsnUH4UIA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu24y1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:36:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-351788121cfso4669737eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812212; x=1792417012;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/kqThYrKmtRe1JgVTBoAttQAkrKVYcXnwflSjNBjhIA=;
 b=eORi5XZCl6ziU7Dk0HCSbJd4Oevfo7RbTBKZo6SXZM/qXk4a/MRi7dyVI+urSP8uLk
 ppjYJwmK5cy0OwY0JRVrKY/ckSAIsiAwYxEnIIp1jKpQhyiUKZz1N3XsU91fxJcvbBpH
 I7GAi7d2OrLvQjxkj9rbPqKnLdUXj863NzMZ9lbCFxMURusYpI7ZP7PEjv8H/RE+RWNv
 abzxc6WjKbPg0tbtn3LdjIIfranwVrCzZmasIvd2lAkopBlg8NeGEApx0iGEbjPsWF4v
 LFmknUS/P9GaXODRz/YUNoaKJz06mtDryp6OUlgWUnixrVUA1GXoshTtKrUGbRYf4rrX
 5eDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812212; x=1792417012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/kqThYrKmtRe1JgVTBoAttQAkrKVYcXnwflSjNBjhIA=;
 b=QnlfAU4Rya9Oc/PgSY0+4trm0+RaFdsAmUTb/0yChg2+s58TLeBNou15risHuoecf+
 lQV6LX9o2N86eMI6eZCmIlJIDLpdxWcyL46ojBanplo2CVMCvZb7T+riJkgXa0+tvY1J
 tF9ne7M6srtVJ2/hfvs4fM2sirPap2nHQxbJXInJFnJEd7vIvnP6r405fpzTbw24coLR
 VVwhsT9ZL+4NzElcv/apDNX8K+83TArG1zM88eA2flj345chZQWfVA+0P7YhmJ4xhmvj
 xbUolaGqc6aJDKlOiouufMbTSQ9CyBtRoqXdEX8oSjYepRBUNuWt3O4RzvZBtZ0IQSbw
 o0bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlgNBrNxTdxEzhXp7luivZzptmpcBsvN/72nP5pvTqxEC1V4q4zNlU2d32cpaHdYCohZniyrg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKdhkmChie8GyaVvRyEwAqFiHpe1BvYX8GbQNj71Gcf8iNqOBbk
 8Hcz6Iqi8p1oH1TV9u1qjrOTDRAJmJ9XxTJ7q0305eSBn4bs4fEGVFWt2SGRnYYSNkKNaeb7Shk
 QPb6jsUIMyNe922k5wHYzNGktWE+jZYmSAerzeeuAq9fWE4Dmh0ji4Rn+32QS4BcrRUGMDlI=
X-Gm-Gg: AYBFou3IPHAFgG7AS54GfTPA9I788tcildl6GPPvtg9pI5jDyWwHI0s/6RmAdzMYeJu
 Ufx2flpXyH7mhC0I58sAL7+EX9tlnD0CKCMxgkFKVWbEl7P3fLtUx2gEeO9nr643/QvN6xbDbK0
 g4/04bMeqJkCmClduGB9ES3eqAYT2+gBw9g6GJ20uAlJKXrG4a/17zlDQZ0ajeB+JMHpyEk2siu
 m73Ibp6i5VADTz8YJWnNdtOI/Jco6Mi3xLaVIazUaTZyljpdTdvFbrdJzrRpAvXgFeyDS4jx20F
 lmS9NKrHg8IWGWhBGYuv/JFMwF2vuasRnEHq8l0l9V10vHKsYaU+aMqyuK6E/D3h3LSJPbq5hPL
 1YeLAhUYz1Pw3jmnwSj7XLH2sqNyb+7eMHSDpi/5AVamAFnmawv1cQkDQJM9Ac7ADaT+/YQ1mPt
 sutDvqRd55DNDn6ySG7rbS
X-Received: by 2002:a05:7300:fd03:b0:351:4866:255c with SMTP id
 5a478bee46e88-3537e058277mr18338044eec.32.1791812211856; 
 Mon, 12 Oct 2026 06:36:51 -0700 (PDT)
X-Received: by 2002:a05:7300:fd03:b0:351:4866:255c with SMTP id
 5a478bee46e88-3537e058277mr18338002eec.32.1791812211347; 
 Mon, 12 Oct 2026 06:36:51 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-359789fde97sm18323802eec.20.2026.10.12.06.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:36:50 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com,
 badhrinath.s@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 3/4] arm: dts: ipq9650-rdp488: Set usb2 to peripheral mode
Date: Mon, 12 Oct 2026 19:06:27 +0530
Message-Id: <20261012133628.1569010-4-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012133628.1569010-1-badhrinath.s@oss.qualcomm.com>
References: <20261012133628.1569010-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6acce274 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=d-p-c2rNYXNZ1EqJuCEA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX5Y0GTDaYqLLo
 1yfxSKBPXATit3+ZkXRsC7jfaH14bJCEOXUfHoPxDMZUkur0Q9t7C8/8d038ClKb6jlXRYGTdam
 zdeGaHfWRLd1bYjkp9fzuzDdUaCGfroeTiZeyHVWXLIFLTBo10wX1/vWf7MYXZyAk9ejQSGJjxz
 snmw4JGJWq7HCbEPjLqgqFdvVVIiwwKHQBZHUJTv/Y+VKB/yGyJjEmXr8gi024qtOYJ8Lq2JYMl
 +fQE+JHmPYAgk9JL1QupEWeGVWP0wQii3vyRZ+n7Y0UAj7gBdN560LQM5hC4lh6W0QeeU48xlTP
 yb6dDLEkFagTxd1iipiPB3dkoGUHIpcvrOccxEGHes8m78ZEyCii7HnP0GU/vaq2jAMSfRdQCvw
 oygQ+DncIaM0wvEt9hiHVkV+0LtOnEyaeclbbBIsTQXTddyQSrMgQCSXJTJ31xogsWTif0gD5Dw
 9maSePJDs0tkh/PGHlg==
X-Proofpoint-ORIG-GUID: -6_UhYX_x7-bVeX4z4nxJAOStTgp5HVd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX818unTxiigOr
 Hj+cz4ZD0pMRX+RWPV0QC9VvqPJY4yjFX79719JNFIO9qsKVuaPJEGBBGXW82+K7Gb5lz+7DF5h
 8WqB9d4FFhjBa2HIPiNmo5o7fOJIa5g=
X-Proofpoint-GUID: -6_UhYX_x7-bVeX4z4nxJAOStTgp5HVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120054
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

Override usb2 dr_mode to "peripheral" for fastboot gadget mode
on the U-Boot, since the upstream kernel DT defaults it to
host mode.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
index dd03de98b921..dcf4cda728fe 100644
--- a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
+++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
@@ -13,3 +13,7 @@
 	};
 
 };
+
+&usb2 {
+	dr_mode = "peripheral";
+};
-- 
2.34.1

