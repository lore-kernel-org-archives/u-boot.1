Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5299CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 01:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 726364074C;
	Fri,  9 Oct 2026 01:32:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tjEUH07dw7Jq; Fri,  9 Oct 2026 01:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A5F5E40512
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791509556;
	b=rXmMA/95nlGRuzCtLKwzPl7mEBJM0GLUbjMEczGsMi7g8aJsVWUIXvrP3taKeKZB5Yb5
	 osoY7kSIK/KcpvKir9SO8Lcm+94COdZQrNHw1ZK2npqVIMGAIXSPIhUkAizo8Z9GvBYP7
	 Tzm+QQe7ReAqoG9jg5UD7OhIAryuOSre5oHwXarDrZst8nSqbHTXr7kFTWfqa7TyudqG5
	 JCAmv/nWj95Mr4zHREkcd82XtnLCwBE4cHVabdoSJF7Wvbj7XEDPYWCY2JuCvhR9z30Tl
	 S4FPWh2SnUhMrQD21nIg7mQ5O28zanSkOzhbWdSzGJ3Ot80GI2qk0oMQBC9DZ718A/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791509556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yjVKSdqIIPnVa6mjpcE7OdEeHI6A2B+xLi2mhhP1Puo=;
	b=mqjt+oyPjqHbA+aEynOgYo2PQJc2TsdN1S/8LReW3kkRjRB0jqwNFB7ZA/vfGM5k+Ac6
	 MCZENRmcyrP4NUSp4An+HQ/yTmQGghlLDXOQKiSTmWOutWkirqC1QvrllEKpzU7RENVrV
	 zQWEH5neis45MfdsACVoEgLSOUPhu8c/4cU2muRrPiMy/6Cw03xKivVE8xI0jv9nf6grr
	 hex3SY1hhcFTraRFaFq+DIln4cstGpayCo9rapdp407mNWKiWme1tWpnP0+j2ev9l71dX
	 CAaoLgYrOtRNU9BcfObZlVjBfHWDuBUFAOMU3hm9ybhiuR5fye0Z6xjG4sRtpRafsPw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791509556;
	bh=yjVKSdqIIPnVa6mjpcE7OdEeHI6A2B+xLi2mhhP1Puo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0A2neHNGY81kLyuwbhSku+gydiveGhEmpoIri6jyVDgPov5Jz4OUfJ1HHHmreO3nD
	 36RAGIBKHoS1gGL/bFvnHOFTqY2vWhPj7hKXLsAJGG63bgsQZuzA4m34A498AW4qFH
	 uixjqzCKUWRqJ9daL5iIz9aqYZIVZk6Tpo1GhlcofwA7T9lwYQdw8Cb/8JIUPyIRDW
	 p1muA7TRH1ZKm74+5d6WKFBYqP0P45SK+lle3Ic0sfL0TlJKjIpcXiYlDLkRgYPXKU
	 WBZu78HP8hTuZMYm08kEbNGZncC/KWmV+kXSCYKLdgDNiv+IJ1PcZ6QO4wJyOtGttg
	 LCDLLycZmLiwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5F5E40512;
	Fri,  9 Oct 2026 01:32:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C49391D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6718606B1
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:32:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HuYJFzwP70VX for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 01:32:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A08260674
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791509555;
 b=P1IAe9aYHhIv8lZ90I2YYmRaKPSG+dzfroHhKOAYYd2Xot0znRC44583rnwmI6Sq/rIo
 PdDsEAm+H/KHvHVaLV1DnnNrQlVrTzIw3cPrylMJsDQVEHrK2Rfz7Iw80bB5cjqVR3jzS
 t/FQZ3XALZgq2X43xL7aXeI/w9CCve7O2AXHPOOQw55M7DNdo075AT5JAmlDQRSQZzL0I
 jVYBzz5mDdPuUttNWk9X4ttMqw9msrrNPWLFsje/SeIQh2Wfg2kDV0R6k4wvEhQoVps6m
 vxKdE3y7VMM28qWcOWS4bSBv72JvnYf9+xT6CUfOhu7kXU1Wsz4AhPbuhXnr5vdHCEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791509555;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=yjVKSdqIIPnVa6mjpcE7OdEeHI6A2B+xLi2mhhP1Puo=;
 b=fe2dQR8IHuUy9oNlhUSEB87ERYf2eJ+BfhjzP85tDMB3H578JWnkTdTokrWneL328qHs
 diduHcrfcH77El7xyy5KC2Alrnm11JHAkxy8ArHxJX3/xpv13UCK+dlvZkvDIT2TCykHk
 DhHmufqbKuHkSY75NLgZ+j+R/nJIwgVQXIDkeNXwIqmLW2GNxdtOwKNut7DV5og4cJA4O
 rgvIBm6xiQ9CyZhye7iIC8TtDkRkkUx777XQzVARavdhj0qPVPkJIBgnrCr/i3d7GXgol
 o2RsYmG4dNcvFM32SoS4aWQo9+QPWOBgnUjRu3xPW2XaSq6yxVTRRWDgkzHMgO9HJTg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=QmArphAA; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TWNXisdl; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=QmArphAA; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TWNXisdl
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A08260674
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:32:33 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990PgeN2959015
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 01:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yjVKSdqIIPnVa6mjpcE7OdEeHI6A2B+xLi2mhhP1Puo=; b=QmArphAASqeWQ5n1
 veCpgzXs7gkmfojpsuVThgYD4jkb40EhBUbc7gsM7Ennq4LraFsFplYTiLcT+H0q
 BJov1C/fodzWRIihTk/CTyyEdlR8bkoOvyvfSZe6CZ26LSqGIZw6dw+g2OPm4i0G
 axaMdQKkFXaAHYPFIc9dfrkgdE0EteNjy9wl2vlkNXK5WsziBz56qCgLeO4ODqy1
 grMOfGLszvgmph0bWq+hCRrVbyUVu6/zwP6x9Yq14fgQtYW+ivSgiNRXvW+vOxrO
 GqXBtFrbKZfBvlqtT1bvOeuitWQd+iDaiYCtr7kRLI5apRQbidrbDPcct/DZtL+A
 f9c2fw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ev59m38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 01:32:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so12165842eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 18:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791509552; x=1792114352;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yjVKSdqIIPnVa6mjpcE7OdEeHI6A2B+xLi2mhhP1Puo=;
 b=TWNXisdlwY24DHM18SZBDfQmWETX5p8xaSH+qntuss9d0mOzgEjDNtcicADkmPvWZM
 ZnGHmNnJM6jKlM3YACBGUc3Fo93fNrshz4CxkZBIYU7C+lv135c6Zju00+UQ2ZsdxWmY
 JeWx+nGpc3LtZ1Ikv2UtCouxG0qjAjlyENMNv62cx4RpVVaLeasN5gFc0321yBPrEkLd
 D+frKYwsspQh8LedYXfuvmihsvPMsPIyXZFqjterRUdjZQuqGodDCzsZ54Y+njXKFsXO
 93xnRv8AbVZXpFophnXjVR7S9IOgqRZJt/VLawXEKNc2iAOc6EuKw6kaFucQqFZ4QrHi
 /WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791509552; x=1792114352;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yjVKSdqIIPnVa6mjpcE7OdEeHI6A2B+xLi2mhhP1Puo=;
 b=lHZ+fWdBbZIbi/N2aM7Y+KO5uYP60w5ITh9BCh95HSoNLnj6IEKeHxxuk2ZF18lcSo
 ZFXExjV1DuREaCyk262i9oXXqAppAZVKSfBSiQlXoBEAAhE9aVDPvd1bgqDYsYRXpBrr
 oPH9/qajaqLDimYUYnafjWgnk2p4y32JoeegQygBqN6uEnWgRvyB4Wvzp2Q5pvy6ReNu
 3jqsyN6yeBVzQ8hXAvehIaoc/FrkipFFCcgtqX8CSgqJFupkhiAFaBkq1BO+qHo4XSPn
 5NmyUPElXwhdu7RPF42y2Ew4lPo36V+4dkO8OEr9mCKJDIstmfMu8RntJPTNVqqm/GFi
 Gs+A==
X-Forwarded-Encrypted: i=1;
 AKwUvByWcFWyvjOAeLI/Vj2nvDAd8pGi/V/SsFtjBpPTwU5HuPz5nEa4BTasf+eZT+vkJps/UGuDkA0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLAH+bffNv4DkOKm6NnjSVgEvQ3jtDdMW26udRaFhGXJa8xe20l
 s75t84cOiiUmnZVGS6iGdoE3hdDw3i2+uE8fYW9EftrrmDIHvTtuMFSkxXXgRoY6HlMVzhVRu7+
 mz3vv3OCxxRNAIAfa/pZiohtfdFjous66C7sciiE+GTA2mI+/3vJaDlw3D0+6/hZMjoWFCso=
X-Gm-Gg: AYBFou1DCAFqoabaBDD2Tjd41ydTHia/aCEy+asEg2ORndMGUTgcxZwTLbbaoHUfzxQ
 QrQEIFF8GvzI1Bj1RNuxL1aW/ioz7d+oReWG4786qKlbPpjAMGVaTlYHS83fllc/eubH0NuTFez
 Z2DxGun29y8n5+6AJIV/iZDW8isdWS10Nr9Z0GNGlToqFuO71fmbk9tFXz8879txlVF/0Mb/ZGm
 0I2ECB4lW76ATiGcgqSrRNtuNZrmeEITOghXwag08AAdGhOplSy+ukLU05CeARxdlo3bf/SqSaA
 SIT0KJTe9t79ZTbniUVJL1wgm3bZUqJTDXmo/mqv/gHn1rLMhotmM9jc1Cdl8gAn8IeUKQUMMSY
 McN5YUTrDVDzK5TaYJ5MJ4YOjRIWXwP3nOQeB9QCoTNuisXtioswvBOIhwtuRLxdci9mys3VWmU
 1hJO6vOdW90sSXFWI5T5BWp/KMzX36
X-Received: by 2002:a05:7300:ea11:b0:353:58a7:c0e4 with SMTP id
 5a478bee46e88-3537e0333f5mr791775eec.13.1791509552378; 
 Thu, 08 Oct 2026 18:32:32 -0700 (PDT)
X-Received: by 2002:a05:7300:ea11:b0:353:58a7:c0e4 with SMTP id
 5a478bee46e88-3537e0333f5mr791735eec.13.1791509551599; 
 Thu, 08 Oct 2026 18:32:31 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm1950600eec.17.2026.10.08.18.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 18:32:31 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 07:02:23 +0530
Subject: [PATCH v2 1/2] qcom: qcs615: disable SCSI and use MMC for fastboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-talos_mmc-v2-1-5d01c3428bee@oss.qualcomm.com>
References: <20261009-talos_mmc-v2-0-5d01c3428bee@oss.qualcomm.com>
In-Reply-To: <20261009-talos_mmc-v2-0-5d01c3428bee@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791509544; l=943;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Y5Roi5oeeAbNF0wSGj5J9Yrirx198f3XrdZiCxA2mCc=;
 b=ihrILOQWiFCHg5/ER6B72hk3u/+ryHc0Kc9cQifU1pyi7+o29MGIAZFAQUmuIZUv8QfrbY12i
 y1+b4a672MxCnQD9C2a8Wo2rs8Wgm3dwYiHh/R8Dle+bNT8/ERwPuX5
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwNSBTYWx0ZWRfX1i+njkoX+m4b
 e5iIj4UTgDIvnBRbkGKWe1McEZURB9vuy8GgqrUdtNBWBrjoBQ26P3FPR1xuBxKHibyAAMX4tlV
 cqbLFjCq0uiuLfwghys48u732TrTmnk=
X-Authority-Analysis: v=2.4 cv=MMT1C8Zl c=1 sm=1 tr=0 ts=6ac84431 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3V2iVeP53uLT_SfLFa4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Hc6dUBs4E7h8Fz9NLxwne9LPoTaMhBB9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwNSBTYWx0ZWRfXwNRA2rLDvHqJ
 syoNbV2VVMz06mOrBgJ8TTFk/ouuT3w/GuGJ3T2eYH1zZWqZQvSDwNm6pUqsbAUUtAvYJxhXsxa
 f1ighpSeMhBuH3MrG4W3n1WXx+5cT4QuXqtOeNphkXndDuE/PY+D23ZiVks2zhKOLuctVHMgphU
 ECLkFnjNf3rRLnTqh88IjNqGBA0gXxOl9/fsB7fqimby+dHnSiAhbX6dullcyXeL/E0SghGPfQm
 JreXAo51nxG1JPBTdW6A1bOS04Vdofi4XA7VcuySwkysmpo5TZqi4nMOkU6pDjFWSHBapfH5t5D
 bINvAFpjRir1tTkokhhWV6Woc0PaMwQK8bKmN940bwywhR60a/Ybo2qKG42x4G4dLNU3U13RzD1
 LjBg9cBC3k3u2lJufcvzrO+1l5s1Bh1AxCa4OY5pQBJ/N5BLbmtpIkpWG6f4g81Bfv5ATmiIJTZ
 noONtnE28DwW/nQPiog==
X-Proofpoint-ORIG-GUID: Hc6dUBs4E7h8Fz9NLxwne9LPoTaMhBB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090005
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

QCS615 platforms are equipped with eMMC storage only and do not
support UFS or other SCSI-backed devices.

Disable SCSI support and set fastboot settings to use the MMC
block interface with device 0.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index ccc3bf24ab1..a0aa019316c 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -24,3 +24,9 @@ CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
 
 CONFIG_WATCHDOG_AUTOSTART=y
+
+# CONFIG_SCSI is not set
+
+# QCS615 has eMMC only, not UFS/SCSI - override qcom_defconfig settings
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0

-- 
2.34.1

