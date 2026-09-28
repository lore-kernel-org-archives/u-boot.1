Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C80CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2E2F80DEB;
	Mon, 28 Sep 2026 12:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y3o_l-nljqqL; Mon, 28 Sep 2026 12:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E7C6A80989
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596975;
	b=a2GTF/u0whtNpVjjip7jIGcRmFYVO6Hxv0bQecaa5ePJp+/RHJtLT87XT8/Jl6oCi8Zg
	 VFdfXIBKgM1lDBec6uKLRnUNPFboCbpsQb4EuY818ovOhuql4TLvwNcWQLOCTOLWzIjOO
	 hseYiHURuKVevy7bWiPsTtC8X5U1FPn12juMz9pJiw1nRrcN6wtBViZGCjYRqEkywc94y
	 GnMdw68t6MQSV/GWpd91jQ/B737xZg/xeDhSzDYR2Rgokd6ZYsdygQwQ2X84vi8oZbrem
	 dgCT96jXpRqjK4JLOuUtMq9F61Ef4vN6z4YfwNMgCPfpbTIO7wQzmxwZRb1JYpnIe1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cIcupaZJ37bJyWS2l1T2Eio+9/Xsy96OkWaJmFjeffo=;
	b=D+X0tUyZW9Sna0+StEPLlcTUTzDwT4KT1sP9Ykl9VVtFEx8cOL9RY54WZzgAfaLZWhLA
	 kXpU66PrwUKyLyxIOvyzEjsY028/XUVzkttSPgLXq2JaSowh+vM46mvqf+EWMoZJVvLdH
	 +dO6V1ZZKQieTPSAS4o6su3pfQuHUIZn+52ymaN17RM68+R+Gr4kpAppxHS1f/MhTDBhK
	 hgGBbP4ohYMstdqn6a5lr3pbuot5OxdMX2zh8ffXwV1ZQ/RLTGxM0CTRXwT5r8AIgoV2d
	 LF9m7mupTHdEsG/Q4ckvyNucvmUN9XBQZoy/2QzCQ53gSPY4X487tCbzRis/W00CpHg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596975;
	bh=cIcupaZJ37bJyWS2l1T2Eio+9/Xsy96OkWaJmFjeffo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hMjtRmZJCe3NYSL07yHw7iiBnJ/M4wfdDJItYizN9h0uKJ9rLbjjTeH0zFgKplp67
	 eGZF2nQarCyD0hJ3lDxfDKU4Q7zzLs2uE/VHUZErUxgTugXEQwkyI5QwJ92YBltwiK
	 2WjM9Fn0mWubjJUSzVmlzgIWPa79VHbQS5NA9t8s0aUUbnFpVVcpsDAtXlexbBY61t
	 BBy4DbWtk7PSY2R9tpQLWnu/ukWt1LpaJWXcQ8TfuXvvpieRmIae0+sSbjwpZBC8Nr
	 yPyru6QYPIscxkptKkaDH/lJQEa31sw/fVeWoLUUyuEcBBJrZF/l7278DmA4zvC7sH
	 E9cn6ZOguFp4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7C6A80989;
	Mon, 28 Sep 2026 12:02:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A183361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FCCD60632
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2oBI94I3A3L4 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:02:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6191C60625
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596972;
 b=oh8I/43lIUcLbqt52d4Zt0ao5Scnsaf2BO0T1m07lS29AG1NKSO521shzDGjFkzqq3+Q
 cZEqLCMybmYjJEK+HOWEoGQRU0dt1wpchczoJEEc7jd9CiFrUBXXxPxuR1D+Q84McAjzW
 xfnxijqHbGwvXAnWAMCla9KRnbv9Ztevyg4aw1w3zOwIM36ZjxdiJPqLOylch4kAXwylM
 wge0gePzx4DjF50txWVjS7wJH7pmwM4fOR7dl9Qd76e9+VS802Jd7vER1nkqIBSQ/xFlX
 6iCFm19Vk6qfmMtEsufEgp7orrEfo820aJdyp+c26moVaF/cb9ssRJlydEgxrzpqcYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596972;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=cIcupaZJ37bJyWS2l1T2Eio+9/Xsy96OkWaJmFjeffo=;
 b=eG6mOYejC+vs1M9EzxYd/SPOq4sCXsOrhEnm9Dy+hTbq1z0+axPpDMv6w39U9XHyldcp
 MJbNkAeg6qwUBDtwrIsRV5YIMD0Z/lUkZzMccV/3USeT9LHMKEqqKDkQZNGBTnLmnZsqS
 lPkdNrlb2FUtwzEG1NSN60zBlyEY7icKy5Hw3Pml8NDpoU36OJArOIwu9IQIVjOa1imUQ
 qCb+x0AJPZ4j24EmSM2W8uErS/KqW3bCV3Mr2lXOtECxDx+qMCjWF2g29P4YkAIopnaH0
 9NWJsruj80OGRhpOfvcvbQ9UKvA/CR7nwek88LwEIdsSLnxuetxT6Ud1fq7yDD7F/GQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=oLfG0AsQ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ib8+SwNW; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oLfG0AsQ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ib8+SwNW
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6191C60625
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:51 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBATl6782816
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cIcupaZJ37b
 JyWS2l1T2Eio+9/Xsy96OkWaJmFjeffo=; b=oLfG0AsQyXAqsJDWuqKzlL1MeFH
 3qQfkO2lP/r+PYAdGWIIRKYVMylJn97ON4312bbPO/rtK9MdC2KLYWp1BMMKXZbB
 CQPrU+x6yJM4wRdN+8wGaUyN3sydyiDcfEbW3KRs/Intnh0ImH2UECOgM1qa0aCZ
 OBAPqVTwBsb8HsxpC/tcxTScqyMJZkCH+FwQZqfQEWDAjhm983m918/Wf0ib1X/V
 lEdqRwykB2UQf4l6kedcVPkjMyHRd6cuJrJddOlcVjVLpcYwL2yOMe+EuWpL1ZkX
 cN6oAcYVo5rez4P08pUZGeKKN0LHyhZvKR9e33MmJ4QvyX06OcB7AAcUTag==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4abf4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso4771126eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790596970; x=1791201770;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cIcupaZJ37bJyWS2l1T2Eio+9/Xsy96OkWaJmFjeffo=;
 b=ib8+SwNWQEwVa9WAE9u+MbyClIYUanmO19wRf5vSwVkoaDSJDT9fIp3JqB4TV2+DrC
 R2qYErFKBowIw6Uk2kGIrMg3Hpcm7pHvboKvsBbHsrgMBqpwyANMr+Mh5dwRvalGleX+
 XDtdUU9svB3Lpq4C37jEwHMsQYR7i/bWZh0Jyo2qP/CP/oB9WFb+rh9SSsObU5gKJ7xt
 Hayucm60nJcVf7rniBODm6vUAyLId6z3WVj72+9f4buEGns9M8Qh1bgZOcbFzzVONUlA
 eZJkBrjl+eLC+zdcQ+MwpuqJryNvdL2M2YhV2TnjqYUwIxHAYHNAhMQP7jaMcIqxTsh0
 QYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596970; x=1791201770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cIcupaZJ37bJyWS2l1T2Eio+9/Xsy96OkWaJmFjeffo=;
 b=KM9rxuPOZq7ggwTEQgoZ3cYbQTokkBM3ImP82gv90OJU2lCXbllPQcyyy2MgfdBt7W
 X8HTf0t0dUifcv693i673wxi69jVNbjU6iZZsSFFJz6sgNi4rOMVSudVyupljdO9h4Uz
 VgMdAVtevwF209bY0Nq4x6IyhEh9AIgoB6JaEE8pov8dVTOPQas1Gm3COa8yvVnOaQeQ
 d9aZvMqvpL2wVfUfXdf1p/f6rQNayo4pCH6leX3x6/Di3DSry2bfNF3Qvyc+6q55dipE
 NCQrq+TbrRHLS3N+JCdWo47S6mZOOC+TF7yrXxItOGbXRtkCGCLRL9TjxatTs7M4fvmI
 pLwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9VzpwTEGT+uM1QgpfYG5VEkaEu+/CllUw6+8+4ATYSYyarMFoJ0rkngvkZ5JuismXmh3y59Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKiLz6jkLrvd3Kw4xB+ABufT0JCvPyr2Z/k9gbQvcTd4pN3DNwv
 DJ9nls7aCrpxbpGD7u1KnE8bWEC3IKlt2SOzRyyZPlwS4H8NPxM7hVB/7uqPsis+X2D+qHFr1Vx
 GxZlrHZ532FI6jTqf7HMI30XfbTW9t+8Ss9JGgh6xVlJrtmlVttfa+Yft+bCtdzVd5zawcYU=
X-Gm-Gg: AYBFou1bb+ja2GgSefCmg7tnVMzPcXb/KC0Jg94caq3A6yihozuHhIrelVfQft4vCLR
 sqdRZ01pIg5DfGGMC4aZjocHCOLEzEwUdye+tYKie7K5PThFeZhtYw2ZK6DN4TIGoCZQE6w3cNl
 ifZh0QzhLVBxL/81yUX9khsHGzjxdf1bCoNHNb49KfUNSae3jEs4Iu01Ybyavfyr1sO5sc+BEMO
 OUnZESbVv+BzOpCFBw0WWzgjsPAZXZXYqPf+7jbHrBALYSX61ePwlnC70WpWingwzPBT2z2GveI
 vI0lIrQ33gkvHaoMrrUEGbfehjW/LfMDbvm2p2CpR2Va6aW5Dp/XgXQKdwBudPHoDIYM2vSYTUs
 86kZMo1nUqrxQeOjWXxfvjlg3CeLEU0XWFnE+KO8U3wowGkkJBgh7stZJcOvdD/LfK3ijCHrqGn
 8NhJj9vHEUxHXAFlxckQ==
X-Received: by 2002:a05:7301:fd8a:b0:33b:dd20:f79c with SMTP id
 5a478bee46e88-34270ab8840mr9696861eec.12.1790596969929; 
 Mon, 28 Sep 2026 05:02:49 -0700 (PDT)
X-Received: by 2002:a05:7301:fd8a:b0:33b:dd20:f79c with SMTP id
 5a478bee46e88-34270ab8840mr9696816eec.12.1790596969125; 
 Mon, 28 Sep 2026 05:02:49 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144b4ae50sm28658382eec.17.2026.09.28.05.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:02:48 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, luca.weiss@fairphone.com,
 nikroks@mainlining.org, jbx6244@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 5/9] clk: qcom: add NWGCC driver for nord
Date: Mon, 28 Sep 2026 17:32:05 +0530
Message-Id: <20260928120209.1064781-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
References: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4V4aGGn_jVkRxILER_qs7AXVhnC4LGgK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX2wri9gTm+BfA
 H4EhetEk1EDQ95A/MQJ0MH9uCYQPXnfYKg65UhmqaV2A381IvI9ifoMezRDiWoBLxHiYOvggLHi
 YqT40U54Df1DE+trBIj0ecpPgFBQTJ0HZfaXFe4D8CUN8xK25X3cGKCYpXEpHRDR2atbO+6zsu/
 HJcZyDFxy8v95vhXvlLwi+l+iodyRLXOZsnCUKIpZSXIDKgdeVF9rUMG4Ol1OPuDmTT9JThs/4k
 03tUKvrnJp4Jb547RkJsRi1YfGS5K/Z+ay3CRdv0z0ntQL1OdrGETicL7muLsw0f3ooVt0b/6NG
 C+6kPr8fhJmdh3TQPc5Tkm1c/pNFX0TqXO4Zry6Fv3cGnNX/rwvyZo3jrA9oEYewFowyTg2OMy2
 Y1bf/dsbDABJuRkO6cWw5FWDi57dovfcCVF/kS/OtYt7l75qmAltyLMKZ+YrXPDphnWnf3Gz8LE
 l3xDbdLlO4oigD/uMlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfXyd9wr2QnLeRz
 zgZ7WWFHG2AICyYhww2T6bnhOZxNpS7xMvnyFsgmNzMH3rnSIqv1GU5GvJAb8vvhyNvHmL0M/Bj
 CJN8h33cVxH1pMLsNwREh5nMmmpyzag=
X-Proofpoint-ORIG-GUID: 4V4aGGn_jVkRxILER_qs7AXVhnC4LGgK
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba576a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=3B2p8TlSs3hVEobYSyMA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280047
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

Add support for the nord NW Global Clock Controller (NWGCC).

Implement the qcom,nord-nwgcc driver to provide clocks, resets and
power domains required by nord peripherals.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig            |  9 +++
 drivers/clk/qcom/Makefile           |  1 +
 drivers/clk/qcom/clock-nord-nwgcc.c | 91 +++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-nwgcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index c10bb8186e9..6266f4a15b3 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -81,6 +81,15 @@ config CLK_QCOM_NORD_SEGCC
 	  EMAC and QUPv3 clocks and resets exposed by the SEGCC hardware
 	  block.
 
+config CLK_QCOM_NORD_NWGCC
+	bool "Qualcomm Nord NWGCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the North-West Global Clock
+	  Controller on the Snapdragon Nord SoC. This driver supports the
+	  camera, display, EVA, video, and GPU clocks and resets exposed by
+	  the NWGCC hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index e7c6e5fe35b..c9795377d1f 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_NEGCC) += clock-nord-negcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_SEGCC) += clock-nord-segcc.o
+obj-$(CONFIG_CLK_QCOM_NORD_NWGCC) += clock-nord-nwgcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-nwgcc.c b/drivers/clk/qcom/clock-nord-nwgcc.c
new file mode 100644
index 00000000000..f5345238c9f
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-nwgcc.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-nwgcc.h>
+#include "clock-qcom.h"
+
+static const struct gate_clk nord_nwgcc_clks[] = {
+	GATE_CLK_POLLED(NW_GCC_CAMERA_TRIG_CLK,        0x16034, BIT(0), 0x16034),
+	GATE_CLK_POLLED(NW_GCC_DISP_0_TRIG_CLK,        0x1801c, BIT(0), 0x1801c),
+	GATE_CLK_POLLED(NW_GCC_DISP_1_TRIG_CLK,        0x1901c, BIT(0), 0x1901c),
+	GATE_CLK_POLLED(NW_GCC_EVA_TRIG_CLK,           0x1b028, BIT(0), 0x1b028),
+	GATE_CLK_POLLED(NW_GCC_GPU_2_GPLL0_CLK_SRC,    0x76000, BIT(6), 0x24150),
+	GATE_CLK_POLLED(NW_GCC_GPU_2_GPLL0_DIV_CLK_SRC, 0x76000, BIT(7), 0x24158),
+	GATE_CLK_POLLED(NW_GCC_GPU_2_HSCNOC_GFX_CLK,   0x2400c, BIT(0), 0x2400c),
+	GATE_CLK_POLLED(NW_GCC_GPU_GPLL0_CLK_SRC,      0x76000, BIT(4), 0x23150),
+	GATE_CLK_POLLED(NW_GCC_GPU_GPLL0_DIV_CLK_SRC,  0x76000, BIT(5), 0x23158),
+	GATE_CLK_POLLED(NW_GCC_GPU_SMMU_VOTE_CLK,      0x86038, BIT(0), 0x86038),
+	GATE_CLK_POLLED(NW_GCC_MMU_1_TCU_VOTE_CLK,     0x86040, BIT(0), 0x86040),
+
+	GATE_CLK(NW_GCC_ACMU_MUX_CLK,          0x1f01c, BIT(0)),
+	GATE_CLK(NW_GCC_CAMERA_HF_AXI_CLK,     0x16008, BIT(0)),
+	GATE_CLK(NW_GCC_CAMERA_SF_AXI_CLK,     0x1601c, BIT(0)),
+	GATE_CLK(NW_GCC_DISP_0_HF_AXI_CLK,     0x18008, BIT(0)),
+	GATE_CLK(NW_GCC_DISP_1_HF_AXI_CLK,     0x19008, BIT(0)),
+	GATE_CLK(NW_GCC_DPRX0_AXI_HF_CLK,      0x29004, BIT(0)),
+	GATE_CLK(NW_GCC_DPRX1_AXI_HF_CLK,      0x2a004, BIT(0)),
+	GATE_CLK(NW_GCC_EVA_AXI0C_CLK,         0x1b01c, BIT(0)),
+	GATE_CLK(NW_GCC_EVA_AXI0_CLK,          0x1b008, BIT(0)),
+	GATE_CLK(NW_GCC_FRQ_MEASURE_REF_CLK,   0x1f008, BIT(0)),
+	GATE_CLK(NW_GCC_GP1_CLK,               0x20000, BIT(0)),
+	GATE_CLK(NW_GCC_GP2_CLK,               0x21000, BIT(0)),
+	GATE_CLK(NW_GCC_GPU_HSCNOC_GFX_CLK,    0x2300c, BIT(0)),
+	GATE_CLK(NW_GCC_HSCNOC_GPU_2_AXI_CLK,  0x24160, BIT(0)),
+	GATE_CLK(NW_GCC_HSCNOC_GPU_AXI_CLK,    0x23160, BIT(0)),
+	GATE_CLK(NW_GCC_VIDEO_AXI0C_CLK,       0x1a01c, BIT(0)),
+	GATE_CLK(NW_GCC_VIDEO_AXI0_CLK,        0x1a008, BIT(0)),
+	GATE_CLK(NW_GCC_VIDEO_AXI1_CLK,        0x1a030, BIT(0)),
+};
+
+static int nord_nwgcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_nwgcc_resets[] = {
+	[NW_GCC_CAMERA_BCR] = { 0x16000 },
+	[NW_GCC_DISPLAY_0_BCR] = { 0x18000 },
+	[NW_GCC_DISPLAY_1_BCR] = { 0x19000 },
+	[NW_GCC_DPRX0_BCR] = { 0x29000 },
+	[NW_GCC_DPRX1_BCR] = { 0x2a000 },
+	[NW_GCC_EVA_BCR] = { 0x1b000 },
+	[NW_GCC_GPU_2_BCR] = { 0x24000 },
+	[NW_GCC_GPU_BCR] = { 0x23000 },
+	[NW_GCC_VIDEO_BCR] = { 0x1a000 },
+};
+
+static struct msm_clk_data nord_nwgcc_data = {
+	.resets = nord_nwgcc_resets,
+	.num_resets = ARRAY_SIZE(nord_nwgcc_resets),
+	.clks = nord_nwgcc_clks,
+	.num_clks = ARRAY_SIZE(nord_nwgcc_clks),
+
+	.enable = nord_nwgcc_enable,
+};
+
+static const struct udevice_id gcc_nord_nwgcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-nwgcc",
+		.data = (ulong)&nord_nwgcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_nwgcc) = {
+	.name		= "gcc_nord_nwgcc",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_nwgcc_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

