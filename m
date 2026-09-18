Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D376AC982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E069811D0;
	Fri, 18 Sep 2026 06:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBzsmmCuLW2I; Fri, 18 Sep 2026 06:44:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 966B9811C7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713862;
	b=TojtLh4w9nipQOdHTCElANAiaqFGAblL/8HcYzuortEpt34epCiEAIZx0DRdB0JZl1Tp
	 tU07kqpTnvixRNXTCexbSzBVJ560jYWr9InKCb57JroqjcROjK+q7nORlS93L/L73CeMf
	 K80n7+Td+/UIahAk6rrWh5RI5pgQuTM2QuhjtAUP9Kur1Z/DE/vOVYeAnysIJxgUWWvZg
	 ihfeKEPQZ0syz3CneqtNeCU+keKag6wok6h1FDkR3Dbw+GN+44lzleeqgA9CvwvUf5WRD
	 ndXL39O3t82pxhiKTQ+l/5SmUErvwvhgGSBrwzp4vCVZMUjN+0omo5qSuCTRGVQznnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713862;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9+rkEwiphwm8Qo8gKl1JehikPIjLRXEXBbFieW3bo5k=;
	b=AQ6P1SHDqR6CCLuUgAy5o944HSeWGqVYB79jzXJjTsMVo0sFa522l4ectnbe//AxaQI8
	 H//FM2lYa5/zqSW4BYYWQOLwR2hkb7zZoywYks5OmQMgKF6nIU3Jm959cwupvLuKEbJfq
	 UnO4ehBZ7OpyfdFAK8l0we5Q2L629xFhamvBidARqKnvKRqR2u1qTzsI0FNbPDYnwjfdb
	 A0boEh/9DSpzP1lC0jsQcws3eQXuYfDgt1Ow6q7yxr0wA5mOYIn8lM2IqbeRPpT+vNILq
	 I9A3XbJXahjmG+bvpEfWtSSa0UM4plH3mqHqACRzvZjwsK3Q5e55OlVaU/df6sSaJpg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713862;
	bh=9+rkEwiphwm8Qo8gKl1JehikPIjLRXEXBbFieW3bo5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UtRZF7e8cs9k7BliEU43/dm+DT/jeM/743zKmBqCveE40dfmyX44l7uB4ATOaxCX2
	 zdQSXZNExHNmJ8GettDMO/DAHl2/YXJi5/ommC6O1u2ITIRME1YN4q9KqyqrnZck3e
	 FWxiVDAdKLCTsTbpP5oDA9O+tQKI2M5vrcaZViX18aZTlbeMQr58Et4tiYX/JA18G1
	 dBdFbM95J/Dpi1reBLNoij3iQj7ZHN+di5Bz3HobhWM7tq/9kAWhVioZsIWVn532jv
	 pv9H5dkvEJJ+OzXSPKmenctoGRlOJPjoPiPrOSG6BA90WmBwqU4CKrXNDeSrnEU1Xn
	 i5DJU7QoojlLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 966B9811C7;
	Fri, 18 Sep 2026 06:44:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AE7829B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4008B40AED
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:44:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GiIkXeGcQt-f for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:44:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3A4DB40ACC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713860;
 b=ABJxBLwUa3vlnSz+lkXVslDAqvfEX4Xar4W5jAdPJ+vVDkoAn+b2g1XnHzR156qjpkDz
 IIR57ujkjTn3PP0qZnBhaJ8B3lq63/1Gdlo17rGFhSkrNDFXlkfR8r9y311wm+2N7H1kg
 Tb96ReJdrOjK+S+608PdrtMHz8WcN343TkQh135gTBkFaCnNQ+uIQHxbAnOuJOl9D2I72
 xr7beqliDXuYFo4jfLnzd1eN5ECEJHiV/ccPcj73lX2ynACkAjfBQTrylJBEHpnhYZ6Vv
 HkR8OOVpYUqu6W/2k/BPztXcoStljSFPCVDuFv6nKyLXw6mCCLiK42CUBvx3MnDKB5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713860;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=9+rkEwiphwm8Qo8gKl1JehikPIjLRXEXBbFieW3bo5k=;
 b=XHDINoGOO5o0+MSlk5+Yk+3eYegMPaWBRdT95s55rjvTNetkIaGVBVdl9FQrN3FAWe2l
 FBar7wOYjOCqpcHok4HrUAsOuwxx8UEzM/owHq36idY1Tebf+avvHYnnNtQTkEbwqmvyZ
 Pav3Zlw6GH1n6VE6K89vm2Z2LB7Ld+1qGR3CcFHb2rboBWN6hotPq8SlfkIg8QVSh4qxp
 V5w5MuIuuXSdFWJzjskmKt8h0CfubHSKXeJboEPvB9NxPQ7oiu5Oy2SAX45eppJ8mHWFB
 pDR+0/nyDOf9egCt2PVKrO4oMIhBsupsqaB4ZwBkpTLlvkbN7nlQWIee4DpP2eECQHg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=c29uzaqi; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Wwly9GsT; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=c29uzaqi; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Wwly9GsT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A4DB40ACC
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:44:17 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I608Uj3945082
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9+rkEwiphwm8Qo8gKl1Jehik
 PIjLRXEXBbFieW3bo5k=; b=c29uzaqictOA+tWa3orAE0z87AlPXTP4M/U9T106
 wp1eSQ9YIvmk6By9Y7GdIbGU7+Nnq5UdwdTT7ev1rtKtana8YBiYPz2hDWjRii5r
 yVOCnGa6qEAKzmCS/uiaha9703q5edPIwms0g1QcQ6mkWMDBy4a77wrrDG1RaZGA
 PgYw04+F6+VQ6s9vzmNrxxVf7eF4liFuvOM3UKX/iRPWdaww5pz7vau5ysurcrA/
 HXyRD3F3FOfjlxkb34pQfnKpqx3Pq92HZ5gnGO3CImF1ledIX2A66WEGfrZHwBsl
 JHS7uFPoA3AmrutrCJIhWP+I2SntH4PiJByBr+8Qsq1vpw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjkt3k2h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:44:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso849012a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789713856; x=1790318656;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9+rkEwiphwm8Qo8gKl1JehikPIjLRXEXBbFieW3bo5k=;
 b=Wwly9GsTfOalcvZFUKeGjKTlCjdLwkes0o33e/XdC7PDHdctkMyOTzcxkY83Q100oE
 J/HX00LbG3QniiQI/5drqdi+k+IEZqBe4IBcy+zJDeISTKQFft1rZAcq7Lux/ukyKAvg
 u1oeGf9desrCOy3KMl5w4oKfOXe6JJykh8r0rS/8mFelOZadrFDwAVRmuXpNAYxmSWyq
 FwAxqSKwW2RRMQxE0RZsedAnhLh8Hg/S7muH0iLTxbaATdM6OuAc/z4IVOfxiWrDFMv3
 TZOcBe/DrAqNcQlej53InR9tXB5/qHANFmwyRyr56/Pob1kht3FCG2nM1wF/qW3TU+v5
 dNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713856; x=1790318656;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9+rkEwiphwm8Qo8gKl1JehikPIjLRXEXBbFieW3bo5k=;
 b=lq68YwYvQCPP4EQ/dkODXhT3SX7aDUViqoeqrYlvLjlDBaD5fiJ2T50sdKSWy7rrBl
 C0lR3LLz8NWY7JjIjaWUL3zcV41Kpbib/TnSQDA1ud6GWZeUBSGwbBBF23P0PFgELQF1
 9YYqomTp0qF3UZmgkq1Wief0eAahUauNqEsdc9zNkj1P+Ayz296Tsn89ApkdFbzTM5XZ
 iXgJYytY7aEu+nTJACxA5wRGfI0mmYicvTzUtvUv9UqgK5I4BnIbwSUql4bqkawFEs7l
 uO9VrtvPyjgnrMHEZovktC6EwnkNIMUjk7Khb2ip55cnvjljoa98MHP7duVdbwptXFZ7
 x6Fw==
X-Gm-Message-State: AFuF++mUru8TBGcRkxX0I87ZcEr45xQwPFHqwrEzebikwalA/nR9osjY
 frtfY+u7aApMxKEH//mC92hk2C6ST2WWXbEuTBqm7KzNdoJoJDYEmuqWC7PBo9CfOC9XQS3ZQnw
 4dMMq3KXjqX4kN56USNFriGp6MeQEwBDFjUZNc+hL7yowKW++v7YgHl08Ndlotk+TpfB8ft4=
X-Gm-Gg: AYBFou0KOmNu9um1DNwxKVDPe3An5gR8CPlyzaFMHZERRXBZbWyQUbn3pDclaKVUfL7
 Baufe8ltqTtLO72DaTPOhzkA7aoyfPlaDxP5FFnnVsavodvZc3iv/QkDcf3asEv9cBZOK5kalle
 ldmClhZZC0hQ9rlLVkBYuA7zykv6yyu+oir+SACJijd7zcknuDDWqE58rQfn4xL2ATu+lLAu9Fq
 6OS3kIcp23LBoXKm4wfG9im9zZdsOvVZJnVsRN4rt5lNs9v+/wXcZu39LwOfym1c4jldCsUsU+L
 xZ3qIWDRh+BiVKtav/lVI+0Hp4rj6PHDlyfJpTfNTdnTylTRtTK+5mf8tufEqud+a/GzW0JUvAE
 /Nk68mY1a7gYRd6fVQ1AkFhODvWnLoZiABnJXk4FSPs6UKh6TDYIFSZmTeq9p6AJNv6wB18JIvx
 xHCiWU8mUQ1NQcoqyr1Oz0BW/nI3OtWA==
X-Received: by 2002:a05:6a21:920a:b0:3da:f21a:23ca with SMTP id
 adf61e73a8af0-3dd8c52f8cemr3639959637.22.1789713855660; 
 Thu, 17 Sep 2026 23:44:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:920a:b0:3da:f21a:23ca with SMTP id
 adf61e73a8af0-3dd8c52f8cemr3639930637.22.1789713855302; 
 Thu, 17 Sep 2026 23:44:15 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c288f088bsm2035581eec.28.2026.09.17.23.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:44:14 -0700 (PDT)
Date: Fri, 18 Sep 2026 12:14:07 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] fastboot: block: add 'oem set-block-target' command
 and runtime override
Message-ID: <aqzdt69oS3Go0gHu@hu-varada-blr.qualcomm.com>
References: <20260917-series2-fastboot-block-target-v2-1-2371f8b15de5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-series2-fastboot-block-target-v2-1-2371f8b15de5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA5MCBTYWx0ZWRfXyxHpjLGRHZZK
 YITV0rVM6ujZPearDri7qdp5kFdWXWmc5YoIDpZuGcqERGzgaACJXhpvU+NRZd4hoE+S9cP9Ba3
 7U44J27nmTJwaOYdkHiIDPMU0i6AJslyaBFM4qhVcdKBYFNEu+TDQCoF/Mn7VBqkkjP68Itp4ON
 tgCKUEzBZsq8K5yej/W82FJuLyr0ZrNF/Uj/+O2lq4b1/SUVmyzFps6HrRMIR2B+Uu+culF3fic
 Jec9ptlhMvs5cC0U2YI8piWhmchUNkCAN0oREchlUNlpg94CZaHAhRzFNmZuHHm6vBPR2Z6JWEe
 U5TrlwU5hmiDHADcYNAWZF0WQBSD9OvWCZS7VrPn18dioWTSECZTwZ0bkrqDvooymmUW47aiAr2
 Jd6HL7oZxMtY1gb6rTH2l4+CJfz104qzxs7Eq9Yo36LrUvaU+LVicRzX7INP2H84cqVCVdTfiJx
 hi45WGi7rWizr7bYgDA==
X-Proofpoint-GUID: 9DXPVVMTv2yyEczD5izJ8pZhF1f47Qht
X-Proofpoint-ORIG-GUID: 9DXPVVMTv2yyEczD5izJ8pZhF1f47Qht
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA5MCBTYWx0ZWRfXy7MuDj8OILmA
 OGiq3WEQo5X/L7z7NFl7hTPhLHhkJihYjJCNp9/BliKdii/dQH8G1hJrXOKt5MgMrCimhq/edsG
 sLumnJx40i7xWZ0QGGQ1bGlCLg7Twmo=
X-Authority-Analysis: v=2.4 cv=Y/VtIReN c=1 sm=1 tr=0 ts=6aacddc0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=apn0q0EWAAAA:20 a=UVfoqKBMcnh2mdKrWdIA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180090
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

[...]

> +static const char *fb_block_interface(void)
> +{
> +	if (block_interface_override[0])
> +		return block_interface_override;
> +
> +	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +				  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
> +}
> +
> +/**
> + * fb_block_device() - Resolve the block device number to use
> + *
> + * Returns the runtime override set via fastboot_block_set_target() if one
> + * is active, otherwise falls back to the build-time config default.
> + */
> +static int fb_block_device(void)
> +{
> +	if (block_device_override >= 0)
> +		return block_device_override;
> +
> +	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +				  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> +}

This config_opt_enabled check is not needed. drivers/fastboot/fb_block.c is
built only when CONFIG_FASTBOOT_FLASH_BLOCK is enabled. See
https://github.com/u-boot/u-boot/blob/211de43d0f954a00a490220c1aac9db298287c40/drivers/fastboot/Makefile#L6

Just returning CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME or
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID would suffice.

-Varada
