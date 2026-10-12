Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149F4CA9ED6
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79F2080CEB;
	Mon, 12 Oct 2026 05:01:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qil94yN5eJvu; Mon, 12 Oct 2026 05:01:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8CB7180CD9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791781262;
	b=gtOqDdr4uVS184qf+8zrHLiaC4zwonxOrTPI2K+uwdRN5VkJQXSiaVHuewpfvTaBKFwV
	 tg9RjR+/QlQc81OHAgJSPuNdlK9Nt5tyt7vy6o3mag53efOS9eVcYtTj3xyZGqEi5+Sjg
	 GDiAwCM+RsEbrejh0SaLFVqjZd7NmRTsGCR8b65UsVTifvUhognItMpYVzYAXEJ52c0a9
	 GEi4qZyAHswvj8i2fnaID+gF0AAFwwM8kbAiMMdzEaRp4BMI7eW31QhFUnyK9UtjKebDd
	 92jFluqu9nGNAV4Ipd6P71JADQhrZgroJr0J4sgNU0fde9rl9CUjvpZPllE+EF48+tA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791781262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1mPmMV52P0Di7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=;
	b=IFBvFwZBlmNZ83BWbGGmalU0DGm8DLnEpWf7h7Oek8fCVONJ1EzOPEMYoRHAmmxbwY6g
	 pRLgyk/K++UZGYY/MSElprb19to79/2yvHsNqLyk2HCte9GAu5G+IQnTof7i8FhbLLdRD
	 PITQvxqxeXaG1jPr9jSiXT+o3BwJo3nCRL/SHRYO/Rfose9deerBed7VuNEp4Ae0gKTfL
	 Dn453LPyXyUvtlgGf7KDwP9qJlwFpUTk8EqOxpD8rVBSYc1m26SFIkFmIRWNFVdTsWFfW
	 4IkR1z8og9XH1wad9DH1VEYrh8v2kH1OB90+7zcT3d4odOVJgQHxv8+G2C39Xdk73+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791781262;
	bh=1mPmMV52P0Di7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g1HTMs5nJdoHmHng92AjHgabdwEXnHgZuLRjp5ER27h2CZmhANn8tRvQIVfZW4TdV
	 En3+ieibQ4fklMwyID1i49S0D3L0BhFgW8VD6VpAso6FkYZ9CIAAUMNVT64LKqC66N
	 ylLdPmN6O2ivVyoMTm0MB25pltDZ8DcUWrNdbPNXTia61JEtxpJhhfydEyo8piUAIJ
	 pSroI0JacHwhSqQJktoRwP78a20DtZrMmgvW7tv2kon/YNR4QQOoFcA/eiM8xjQlnS
	 zP6F9pZ0XkR3fW85f2Ev7YaGlw5SFK/Ck31I8K3R78S2MHg8cTXP5enMY1B35p8dt9
	 k5bnk7p6oiMVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CB7180CD9;
	Mon, 12 Oct 2026 05:01:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1085F9DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB43C405F6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sHvg8GyUPykf for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:00:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37D27405F3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791781256;
 b=GriBrlbTncoRbRkCImmSO4ad/uCqOmKFaMh/l68EaUDy6hdco9kqf3obIlh10CNbR6z+
 MehUmYEqwUlRHodRt/wgUz3R7Z6S6c1JB+JbKQBAxtt/MHtU+P2R3iZhPKpyFnOAKqBNo
 Sp3FYg0ZbMOB+zYDNtYevodTRkcFa6n0zku5X7mNXwEQg1GL3G1qQ15y0MFNrVQs7mRKd
 Rw1G4F53Jpoyp8H0Y2Pty4XHX2Of9j+aZARGG3QbS1nQiGAjm9I6W05W3mIf+gQ6L+ygb
 nPd9ZsNzqkhmm9U8PUaTOIalN7xO7H+AEX8BgagGJYfr4Vx7KuoMQGT8Q7ZJwBUOaTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791781256;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=1mPmMV52P0Di7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=;
 b=HkAisBWrHfWj4Bjhgj0LLi4dhwPS28phEu/LKn8Gpdopqc0tI8Fo73f8UpPo6Dvqg1MV
 8tm0oro5eadLBUpbZXkYi/Ic7PW4qliHpheR9rC337+mcOIw/yg7di3qEkCIf47CVGZZl
 5mtTxq875c0oe392VWHgKOJJBXnnWS20RSKTHBD5x7PDf9nzSDv+3qyFysuTuEVK6cdCd
 5tKUh2bROCF15Wy31VjPYEPdBe5nB/ctRUJsHVwMIKJEiTEJuBvGlU5ycVTGiZiFyOn34
 Ch3PZDgG1Mq7Bunkosk5ZOVIsdnjZLCS1eH/PeofK3y7/0sc/g/Z5jq2iD9M7RAy9jA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EVhekycJ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dxEtVnMD; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EVhekycJ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dxEtVnMD
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37D27405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:56 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lIIQ2015594
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1mPmMV52P0D
 i7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=; b=EVhekycJfGbuRBVs+4ynhBY7T/4
 L3L1ITnofM1/xIqTgojfJmeYlKWCpGSZUGjkh5mC4nYgoaXL8sw1l3eTvLFSpyWx
 sXra4F0rI6IkPELEJIf6nTAFdMlGFaOr4Ip62WzeEXU9mm7+ifyNlGqaNsffevNo
 vBe8BZK+uIEAjFsCg48TPaJ/25UXzj0FNTipuXRGy/1Devv9kjneNt9HqBb+Mlop
 Gm/Fqg3eACGK2vHKpfJwT8bCjw2F9dIkgcVQtH/EY0+3wRRTZghvMumYVJA91hvS
 FThet2A+6hzPAQcDl4L8aIbG6W/oGmhkSCTI2EPoYD1efLwIv68ZT2ybSGQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7b2fd3ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:00:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so4158962eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791781255; x=1792386055;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1mPmMV52P0Di7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=;
 b=dxEtVnMD+BwoRu2fjdBHLj4ILeelIe836b1nvNPKXLlCGgr+8F3KL2PlI4yEekmRCA
 aiz3Gf6JJ3y+BLwtJGGowAed1VXbe837kPkwXjBenynBiuxIPAE6ZoZRLElTfNZ6XLcJ
 a23N8sZDTpjardYiRscLiV02EvDplWvHyNEozFzA+uUbqAO8wLAscrN5pcWG3RKTvbdT
 IbXKaefy6RMTxHLgc6hLTH3jkEUEktSQVonTS9KSkwK3VmspP3kzleBytoqBJ+Nr2nix
 c1EJAhwW7aBBk7XkBHG9Bm07cBKAYGPjeW1z0xya0ctAsp4NKraqDdyKv+N0Rux5Up/n
 gbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791781255; x=1792386055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1mPmMV52P0Di7JaIJobg3uXb4SVZmxcM1nT3rG5HBQE=;
 b=j4jtL1MXpxYLbnDbydIBcovEPzWmTwD6syKauJkspdpiO0VmnjN7uhlJlayfyd5yBb
 4g8vncJVIQkplMjCi+Acrn253CL0AAUW/CZ2FV89nO0QlmRWXzg69T659DtOvjXA8Xps
 e8JTU86iD5x+yv84rLHR4tVQMYLpDoS8sgA4SKLEDS1ReOhCcn6L20DBuEYFUgPMlTaX
 a0W9IYOPP4aT/Nzjcr+liP2QPGdjv64Gj2yeobS+6Xg/wQEfMCFTUOSLjGJ3ZbIqFlkG
 X2JhGsqaFTWqAW2f9qXSbE9UtlGsXQo5gGObJmtIaRoby6nMmiTWhc0xXBUK8SOv7V6q
 SDwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6psxl0oIBLG33nz48h09QM611SOut5biq0upy/pK6aYp7t7Tnl7tSeGb2ednVaLu9nTmwFfg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJUcN8uKgLSsb9s+4Vv26+ee2z9fb0X6gIvRyVuKtYDZ8wusOyK
 Fq80KpsZjW4egwVWz9O2ZKP8yI1gbVCpuG2t5OGR0aG9d+QTfCzKzyupW1a7YOnS3zo39M+WMcD
 KA+98qoJimVKaLE9Uv5UvK7WF4O/NXSwqo1XUWL4zmh4J+e7A0hRtWZNKzmz00IjyTnyyhtw=
X-Gm-Gg: AYBFou1/VaFKoZ3BeCT1Ugq0ZLb19RvCefsuTyZMqrYV4plyyn2nS/KkNUiVJR3Nk46
 0fbT219nAdO02EobKsc26p8Au+TVqmjImlhDCjLFA1b/zp2ik3Diud7O+2HO3k7as8npefr7m39
 oDCG905s6Vxga5WCH4736gjCsLiFGOC7KJVAsMJO9bZcaidL3eNeHn6+UxVNku68Ltecbn2UPgl
 EtNwGmM1iSt3HQkvnHpnhNjzFoD+32i6RJDMrBM29VLcJsnpP8jmcYs4VqzOMyeFLHIZWb1ldGh
 UtIetBSrkOyhNNx++SOwh94oIRJhRzEa4e7ajb31cNIBRN0JFDmWsvUirOjBSOThNqR13Vz+nif
 az/NC9ht9t6Yxm2du4Pp2/7J8A4e9NChQrWBiG2joxkbwAIU=
X-Received: by 2002:a05:701b:2093:20b0:163:fd28:5658 with SMTP id
 a92af1059eb24-16a5f9b0ab5mr12430184c88.22.1791781254719; 
 Sun, 11 Oct 2026 22:00:54 -0700 (PDT)
X-Received: by 2002:a05:701b:2093:20b0:163:fd28:5658 with SMTP id
 a92af1059eb24-16a5f9b0ab5mr12430146c88.22.1791781254024; 
 Sun, 11 Oct 2026 22:00:54 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becb11sm24317909c88.4.2026.10.11.22.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:00:53 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 abhilash.v@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v5 2/3] board: shikra: select SPL MMC boot source
Date: Sun, 11 Oct 2026 22:00:38 -0700
Message-Id: <20261012050039.1527083-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012050039.1527083-1-abhilash.v@oss.qualcomm.com>
References: <20261012050039.1527083-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOSBTYWx0ZWRfXywewsEYIAFnV
 yX2VOo1qg51XV4oj9mLXCdzMGMke0eqF+PFiF7M5O2adHuYQFIRpyuyP6409XgiL10NLIw0qz6Z
 gk0fLA97LblQz71oBm6/U8YH1T/DdPo=
X-Proofpoint-GUID: N-Y4YuuQ3eW0pqxGmXKveqEKtr5Lxkvc
X-Authority-Analysis: v=2.4 cv=NddzRGD4 c=1 sm=1 tr=0 ts=6acc6987 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=hAwZhLamoIMQkAxjX20A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOSBTYWx0ZWRfX3o1oLhisJ4Ej
 7hnfdDFV13K9KhgRImsOws5NgjUiCC3uB4VDsMbQTgUUHJdDd7nrHa/ziMqKkirKvoOnXbx/5Ga
 Pxrk1nnX8umu1uLHrDQtgDadvkSoVGQKkZOfFNHll0BfXY+SnCifGegZiA7cW/WZxY6BMR7M0ie
 jkMiqOQON/2vLpgWfQYR4FoViig2hQ9ylpIxnCbSVqXm/JnZX/iZGIFaBh1tF8Wrs3In4olhJhj
 pYNpAwDrsOGclK8x7xdz9BUwUYXdkkoH3BGz81WT8fUcA2Pf4T3gINRK335TFendY8+VeP+FpCR
 BIncp7IuYhYPWRZPGjn5sEYKpe6GJ54lu3DizP5LcmuTefHl9lUv2J79y1g0GXI1g+mcOaJpPVU
 ns4K7lFfRsJqc2X1EW46W6I1Mni5pDU6RXcUHK2IAUpeqUl2v4Oymr4Q4ZkU13fPhQAXFQUBiwL
 tOteM6IuAwM2W/hSJfQ==
X-Proofpoint-ORIG-GUID: N-Y4YuuQ3eW0pqxGmXKveqEKtr5Lxkvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120019
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

Decode the PBL boot-configuration register once and
use it for MMC preparation, FIT partition lookup, and
SPL boot-device reporting.

Map eMMC to MMC1/sequence 0 and SD to MMC2/sequence 1.
When PBL selects SD, enable polling for that device because
SPL does not resolve the optional card-detect GPIO.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 board/qualcomm/shikra/spl-shikra.c | 99 ++++++++++++++++++------------
 1 file changed, 61 insertions(+), 38 deletions(-)

diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index 091a2a49e09..00952d7769a 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -149,6 +149,32 @@ enum {
 	IPQ_SPL_BOOTCFG_DEV_MAX
 };
 
+static int shikra_boot_device(int *mmc_seq)
+{
+	u8 boot_device_cfg;
+
+	boot_device_cfg =
+		(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+		IPQ_SPL_BOOTCFG_DEV_SHFT;
+
+	switch (boot_device_cfg) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		if (mmc_seq)
+			*mmc_seq = 0;
+		return BOOT_DEVICE_MMC1;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		if (mmc_seq)
+			*mmc_seq = 1;
+		return BOOT_DEVICE_MMC2;
+	case IPQ_SPL_BOOTCFG_DEV_EDL:
+		return BOOT_DEVICE_USB;
+	case IPQ_SPL_BOOTCFG_DEV_NAND:
+		return BOOT_DEVICE_NAND;
+	default:
+		return -EINVAL;
+	}
+}
+
 #if defined(CONFIG_SPL_BUILD)
 /**
  * shikra_prepare_qup_clocks() - Enable QUP wrapper clocks.
@@ -197,23 +223,11 @@ static int shikra_prepare_boot_mmc(void)
 {
 	struct udevice *dev;
 	struct mmc *mmc;
-	u8 boot_device_cfg;
-	int seq, ret;
+	int boot_device, seq, ret;
 
-	boot_device_cfg =
-		(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
-		IPQ_SPL_BOOTCFG_DEV_SHFT;
-
-	switch (boot_device_cfg) {
-	case IPQ_SPL_BOOTCFG_DEV_MMC:
-		seq = 0;
-		break;
-	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
-		seq = 1;
-		break;
-	default:
-		return 0;
-	}
+	boot_device = shikra_boot_device(&seq);
+	if (boot_device != BOOT_DEVICE_MMC1 && boot_device != BOOT_DEVICE_MMC2)
+		return -ENODEV;
 
 	ret = uclass_get_device_by_seq(UCLASS_MMC, seq, &dev);
 	if (ret)
@@ -223,6 +237,13 @@ static int shikra_prepare_boot_mmc(void)
 	if (!mmc)
 		return -ENODEV;
 
+	/*
+	 * SPL cannot resolve the SD card-detect GPIO from its live device tree.
+	 * PBL selected this device as the boot source, so poll it for the card.
+	 */
+	if (boot_device == BOOT_DEVICE_MMC2)
+		((struct mmc_config *)mmc->cfg)->host_caps |= MMC_CAP_NEEDS_POLL;
+
 	return mmc_init(mmc);
 }
 
@@ -404,13 +425,20 @@ int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	struct blk_desc *desc;
 	struct disk_partition info;
-	int partition;
+	int mmc_seq, partition;
 
 	if (!IS_ENABLED(CONFIG_MMC))
 		return -ENOSYS;
 
+	/*
+	 * The MMC core selected @mmc from @boot_device.  Confirm that it is
+	 * the device PBL configured before searching it for the FIT partition.
+	 */
+	if (shikra_boot_device(&mmc_seq) != boot_device)
+		return -ENODEV;
+
 	desc = mmc_get_blk_desc(mmc);
-	if (!desc)
+	if (!desc || desc->devnum != mmc_seq)
 		return -ENODEV;
 
 	partition = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION,
@@ -428,33 +456,28 @@ int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
  */
 u32 spl_boot_device(void)
 {
-	u8 boot_device_cfg =
-	(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
-	IPQ_SPL_BOOTCFG_DEV_SHFT;
-	u32 boot_device_smem;
+	int boot_device;
 
-	switch (boot_device_cfg) {
-	case IPQ_SPL_BOOTCFG_DEV_MMC:
-		boot_device_smem = BOOT_DEVICE_MMC1;
+	boot_device = shikra_boot_device(NULL);
+	if (boot_device < 0) {
+		pr_err("Invalid boot device configured\n");
+		return boot_device;
+	}
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
 		printf("Selected boot device: MMC\n");
 		break;
-	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
-		boot_device_smem = BOOT_DEVICE_MMC2;
+	case BOOT_DEVICE_MMC2:
 		printf("Selected boot device: SD MMC\n");
 		break;
-	case IPQ_SPL_BOOTCFG_DEV_EDL:
-		boot_device_smem = BOOT_DEVICE_USB;
-		printf("Selected boot device: SPI-NAND\n");
+	case BOOT_DEVICE_USB:
+		printf("Selected boot device: USB\n");
 		break;
-	case IPQ_SPL_BOOTCFG_DEV_NAND:
-		boot_device_smem = BOOT_DEVICE_NAND;
-		printf("Selected boot device: SPI-NAND\n");
+	case BOOT_DEVICE_NAND:
+		printf("Selected boot device: NAND\n");
 		break;
-	default:
-		pr_err("Invalid boot device configured: %d\n",
-		       boot_device_cfg);
-		return -EINVAL;
 	}
 
-	return boot_device_smem;
+	return boot_device;
 }
-- 
2.34.1

