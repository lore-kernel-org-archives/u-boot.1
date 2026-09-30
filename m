Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EF2CA5FB5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD7F240A5B;
	Wed, 30 Sep 2026 06:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x2_E5VOHh2Bm; Wed, 30 Sep 2026 06:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A12A840A34
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750126;
	b=jRjYcIA4uBcpVPCvkLZ60SUIYQ2hnlaVLcF7pfFdi34lbb3Th2x//vFp5Gj73A3RUdqa
	 E0BauYGjL6ua10ljazcgdMzcgEYZJK9vdKkHcUOBr43mXr5DCdhK79PKCcbKEAGH0Mvps
	 tGXWxdFC8eNm5h+lOCR8cAO+3ri2Fz2FUuGbOG+GtWDAyN6keAd/5zSZMpGU0YiJJ2/Be
	 w9G8CHgcfhf+uBE4YwcOmHz5E+1Bk1xM68CwMsqXD+JcXsg+3COybqpBL56JPBEZ3Qeco
	 1DyXk37udfSNXyXfEO1ddkTiK8rOl7NpED0DuEF/F02YIAarlD9Psvqh7ovsz6WB9oQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bsGZ8sqTA6p9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=;
	b=oh20MwCHnM1vLpToRsr5neda75NJ4BBBydygErcLNMtj8T2Vg8yk2/h7TnLBGi18hlwc
	 Dv9vkT9yweb4UEFtp+rvOlir045/wVYRoycBFiYeTo2xXbWvc6iVxM7YSTmJqyWbw58Fi
	 Liim0feCwrQPgtj3jJeELZ/+1EwAP4pPPiqs9b1j+KTA38uqlN848VyBVyWZZnC3w38Bc
	 yvR2xOfD4iZ5BsQdVDFjLmbuY7V7+s5tmSnDV0UfLl+ePiGgjJncjZinmr9+FLYlVyPyS
	 YQNZFPcAV7JXCTzEjOv3BJrljN0kZHNW0I2JfsetBrhLwoHoRHSwSiXs1wcj8kqcAjA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750126;
	bh=bsGZ8sqTA6p9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZDRIeuG9NrFHW6Yyyg3P99fXmeOpqKY1DzIwBOOv0BOLdbctjOWTaWfsgnro2IiyT
	 +9ScIKP07HwpI5bJA4B1yfhwVScC+MIlMf7Z6XYe45xwkNJvFVcTRAcRxkyJ3VGkvG
	 PFrFXAfGsXGiZ1jOVl4LHzmxsjGoI/Mc35gx4J8WNwu3foevh7d+d3pJowdRwdDJat
	 M+JjhXQ09083UnfyWITfTkQe4neSPQkXc+6QZfcUsf2EDhFrbJtVZcUHXnuJuYwTJG
	 YPnM8gptYp3J9WY2X4qs+jPUHktYamkkqAslvq+2Pvy5nZZBgXKIhuLcliStcCT9qk
	 eqxmfkLmhb7lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A12A840A34;
	Wed, 30 Sep 2026 06:35:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D769532F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8E4580FDE
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rDNX7XyJHR4a for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2A54B8102D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750115;
 b=RupAYwHp+tJ2dy1BNJ8oVg5yFGXoFQrMmq7QBg4aXotaURPeD6/lvGrAHKUs0UzJQGxQ
 wuGSiu/Umw+D7Ov8/D7bTVQ6Bwo46cvV55lziEJPbNRytf5QafirhSFEh3mDs6DXvd3sY
 AFwwQf9d9+F5LPc+sCx1U4G3tLcMCFJworhbG+uzcOZByxaGXPbPMUrVReVnXXAkFVET2
 SyBsU3mJUa+JUSn1UqrDEyE3Gtz9gv4QeUU0HKRmu2ZORtx+ztQYBZF5z5erz4G/yJuwW
 xcyft6tGag2ARVxmYN9RVstinz9PqWcoV291sLDS/LvMTcobdeuUqeRuJQKkJZr5bNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750115;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=bsGZ8sqTA6p9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=;
 b=nniyalT/bdc3AbrFfd9vxrCaosli1sDIMvYtRYKEiOAMC3/DHDGpLUPeltzW5ImX8NzW
 +u5Uba0MVlL1VHS+9lMl40pCHWnlG1QIaPrnceHcdJtzKPwo/GvXxQ0fCtNewV1i+8oL1
 WVg/ZVCP0EDxK0CTEgIUi79nAdcK7NLzabN0jasmWJ3YIDtVd1VTFOCwYEF4Fi3pzhEmS
 yX1JJJVPwqlMvJvxbmS5WvAEqqrF2HePp6hZowgKjP7XgASraMnXASZa8qNq7SdkwNHIO
 SXVZcTUITECRPHSKsUD4P9oUrD8tYZQV799glQPx12LjkDZWswKVl/sBKEDss8mq2cw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=KmOaak3t; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jcgTWHAF; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KmOaak3t; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jcgTWHAF
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A54B8102D
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:15 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U3Vdar1887435
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bsGZ8sqTA6p
 9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=; b=KmOaak3tsJ4yE6XlAcMtYoZ0Uby
 7095+GTVV0H9ZZO9HkczbC8ASfTt2+XJ6tm7XwA2W76jaAjSC1XhrpImWEGGewQl
 gVpJytv2RYfsl6TxVyS411gMAegXQq2AmewEas/4CmoyoPniifiFeiQqK96ziIKB
 kjMXRagwGttTqCZNPtnF8szQdZDGqjtiIDo3a1ohjVCkL378cWDuZtFbkJZ27ADZ
 u2hejWvDS+XIn95TsMa4uz7URHAxRmcS+jd9tqy6XJr/Ic0oY04ej/pMoNmDbwLh
 Cx2lghZXpqAHRVTJtlqQPUTaU1D5GK7fpOGuLJyOthLSiyGR4fztjzv+H2g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn0nk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34ceac22194so317230eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750114; x=1791354914;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bsGZ8sqTA6p9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=;
 b=jcgTWHAFrJb3xHKZfgA5OsP10nLMjwR3Qu5T9F/zPDZzlByv1zADucIM7JXL8nuiNs
 yZ4vyi64b/0wySOgw4GBoucNnkZ8thNNINWgUtWcPnn04N6noWI9JhlwgwF4ASimR9nH
 GWHfNKtGwHhxdbb44FaV6TxWPDS35aoO2vI+FhuAYxYwwx0YF8elvApltdUz0YyrY+zE
 EP2SRTj3m9sl0nGMW9KB0WQV2Hryt2Jc04O49981Fdk7qSR2c8oadH+PybQyElHlpfKr
 xb0V+/OJtB2THKuMCswpB5Cmwy6BRIBrPbR47/TMky/q3YNQumZ0J+fRjvHRh2tRJTS2
 ek9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750114; x=1791354914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bsGZ8sqTA6p9K3Gm55hjt55nYeTNZAFdNyVazYFa2Y0=;
 b=ULEN4lGHsU3hkGVNfI4P7giI04nsMy9Cjvifcv49eYsweViogAEm1h/mL7kgNVieHA
 zcjKhm88a92yS0O/dN8KMYt3prMQm4X17PXnUoMSC/9pbz8kulgW97yrSNJ8r2nppjAZ
 kzovbmQOgzN8N6CRKUa3uwJZELaT4375+41wsJ6Z2AbZWz8jf3lW38Focx7m9xqKWIVN
 6SxJokj9CD18AAo6IVr1OZzhs8w2yW+HUazpvDHJ5uEgzAFslxnk3p+/H7itJLji+A1b
 4myhwkK7BN6ryUN4V+xersxqiPJFC16khj5FLZcm/SEHLmGDSKRHxZbOULZ46E9FPS7a
 ZE/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6nQKrqyIpC+ca6gkTyAsCViJfVsKh9XcjJL6DFBpu1wufEOsPZbfzhUOl4UKkaBPIfJVESiY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nhImLomapMI9pXYwQn4rVZwwC4xWa/1928ojiXPKLX1f3pPJ9P
 2QpV5hornbVf/FTeAsab+bHK4ghvv1A2d6XEfU0S36CaITgIr04U3gDbEZJlXiFfdTzFS3LDvTZ
 d6iP6U8MqoRh0ZjpXMMhhVUbo2u5WogrwFWoeHUVl72PO2/EKrZ6m+6KTOKNMAqx/AzOpQw0=
X-Gm-Gg: AYBFou1FbHh9nG/ugTyAWAaxKZwbxeKSzQ4YPWBuScl/K46PadKbC7zjjBMGpPtzlSb
 BRUcFNOpYo4Wk6vb/wcakaF6WoVstHN253mF1rIUygHS3H//B08PkPHnPp39hYIXQs803HS4V1T
 UEQsEo+mujvqjlpz645n4X6i7/gV0EDJTpPDY+6RmcoQQHY6EscjzTWlHWh9sWuTXlAZcY7th4l
 N/Il893PSuGl2Wl5JElB7XrD1lAqusU8I5Jk01j40wjsqY21HpJaKAHiwnvPvAC3nUnortKrT98
 FymdDasKYa3v597IyhdwTtbj5ivZF99iVVl2C7C1tipVhG/IoQY++cZT6+uXQXKXFJ+A35izeJV
 jVlJY0cGre73cUkz4JDtcccrzREuQI/KvJ+ftPfyFR9rAgXUv
X-Received: by 2002:a05:7301:468f:b0:346:7bfd:8504 with SMTP id
 5a478bee46e88-34cdd98c9d9mr792153eec.41.1790750113723; 
 Tue, 29 Sep 2026 23:35:13 -0700 (PDT)
X-Received: by 2002:a05:7301:468f:b0:346:7bfd:8504 with SMTP id
 5a478bee46e88-34cdd98c9d9mr792121eec.41.1790750113150; 
 Tue, 29 Sep 2026 23:35:13 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:12 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 08/12] mmc: msm_sdhci: make tuning callbacks optional
Date: Tue, 29 Sep 2026 23:34:45 -0700
Message-Id: <20260930063449.3251317-9-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abcada2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=AWXtbog4CBKr6sa7RggA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: hhRiXor9Yysf90CcXLUCt9AjOVxhkAlo
X-Proofpoint-GUID: hhRiXor9Yysf90CcXLUCt9AjOVxhkAlo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX/TcIdk0gxf3f
 s7f0RYcIhaE0LxZkNOmh/HsJFBx7lGi7Oj97gecSbO6v2ahX8uZgtB5pRxyqzLzVaslwKBxLfnX
 eOpq0TXQw/aB8qfnE+NGYNP24VpIHD/j2cEBXCJBr+ktLFGQi90tDgSimEDVnR+qSMe0VQFuuvX
 qFtm+X8sDhLRtNzaCS2hwVztpIMVXcOrFm+fTC7UxfIPAifKSS/AkFF+aUIVjXwSGmzdIW2UXgp
 qCA6XCk2SqAUfqx3pNiXjvuY4e7PHd3v0FKLHm4wJai1hYofiLjqcjVkng+F7sAU092MPIUXRqO
 CKVx9daintsF8SkDOZFGHp1Cy3WxtsjjClIyRWlrYe7vq0d4Blt7DASvBHpAKLsxiV2nJ2xkA6A
 JVsmZYAHL78f6LXZ1yuwxKbe1bOMSxCyzItZ/pBuM+tuk0OsAe19mhoOSuJd6Tc/EiOsk8a3KA7
 Lz+e1jrJav4JA9emNJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfXwqJTJWKVKGQu
 BMMhPy1U5lb8RDtYNxNu8iGX7D411ay/nSJbhBbUTtAoQcJR9UOAvY1NX8NJGNIwV5LyHlGNOnA
 nTQ63AjHj8XR9ONNKj+4+65gxkxcwTo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026
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

Build the tuning implementation and callback only when the
active configuration supports MMC tuning. This lets Shikra
SPL use MSM SDHCI without unused tuning support.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 71a5aa15958..155bc2ef379 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -558,6 +558,7 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	return sdhci_msm_cm_dll_sdc4_calibration(host);
 }
 
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int msm_find_most_appropriate_phase(struct sdhci_host *host,
 					   u8 *phase_table,
 					   u8 total_phases)
@@ -711,6 +712,7 @@ retry:
 
 	return rc;
 }
+#endif
 
 /*
  * Configure HC mode selection. Runs from set_control_reg(), which the
@@ -907,7 +909,9 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 struct sdhci_ops msm_sdhci_ops = {
 	.config_dll = &msm_sdhci_config_dll,
 	.set_control_reg = &sdhci_msm_set_control_reg,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = &sdhci_msm_execute_tuning,
+#endif
 };
 
 static int msm_sdc_probe(struct udevice *dev)
-- 
2.34.1

