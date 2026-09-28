Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF82CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB5E880EA7;
	Mon, 28 Sep 2026 12:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tfeFzqZ3vO4m; Mon, 28 Sep 2026 12:03:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 00B1D80E20
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596987;
	b=Gm9BotjB8ULEyhUccnyvFtZyYf/RLC6XY7arT/QG+rr/6fyLQnUms3Xos3rnkYs6u7J+
	 jH5iD8+Hsw+5ZZn97g+Vzf2A6iYkJrIKJlSQQYqfGprZ5b/2YhESsFHsQoUZmyqmXvWjj
	 2F/ZMgLZxCl6I9Nv5oVfnutLXGZHgpX0u8HVAvjyn9LtD06mKSJVMTu/E9vaKffLvIqdh
	 UTqcAvbdFq9uwuCDOE41uQQ3LQz8hkgkAG+07tJSwSw5NPpRKPAZI3gXD0YRJqU0qulim
	 WUGVtLtanIkFuKAU/Wi8QeSzJEmaqvKWPE5q9DuLrdHCUqfRmn6AGF2CQB1g61SGAdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ERYVzH4/Y57szMwOon7OLQBaOs8X1Wimhwt4tJgLhFc=;
	b=aCm6b9i7obSj22+PNFswaS31YB2cu/CzPO2NWtx+ZZtAJ30y9XPkORCiwr4m6WZBZk9o
	 bE5v37SWc3yz6MeTDOmv0HwEjfrgZ6KQS/vLSB/XmFVW/nnzSzQ6ygwRSz7Z/G5VpeADL
	 JYicVbgUDNAMjfFxjYdkxRHdMqimG3sob8vgOALOSRge5EUad84dcdAa5HmrQ6qSGDxni
	 M7+mHwFtNHHccHZaib6iJLnbhbUdJXwl+x8B70tWxYHIiHQDt2Gqz9wQQqYC+vwPjVVQc
	 vsNEx5t1Upgp2PFmMlNmJfoBSwgjR5Au5ri9/14VvAM+ik7n2Ni+Q6hMs/8Cf2uUPvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596987;
	bh=ERYVzH4/Y57szMwOon7OLQBaOs8X1Wimhwt4tJgLhFc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W9OecqyrhMG748sRprrLiWlMo9SpW5DHKbbKRAWgzpGfkTFD2ZR3pmo47OUlB0DhW
	 TCj0KJef93gZ9x/5NJJtPVF9CQq9NRYj2VRv4wkIHWCkROGyB9kudAzNZMbb6WtUVV
	 35Rge0znCxe+2i6syB1Zyvk+S6k/x5ag7zOwAZmszFbvAiFI1S7AgmBbxrehoyh47O
	 1ErUwL0gs8uijrPLW6MuBD1O0Qqyf7xpFpy49rhRFr5FYLVyPE+H5C4MXB908O7tn9
	 jYvaUulL8wnipGwL2AkL0XM6dcpGc+GgkIqiiUJchzSkwBlsMpAy6ux2lBo8ex5u/k
	 z36skMkuz0epw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00B1D80E20;
	Mon, 28 Sep 2026 12:03:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E4A12B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FBD860632
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N8DI4gnRPsUv for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:03:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B2AE860625
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596984;
 b=Lem5c3gaB7GCZBKY+7Rnu4H0H+RcWYjwhI1M6gpBaU5Kz+TAnkxkCu+MJxKsRjm740Ca
 cAOvAO2EvsbJNG6JA5DN/AjGDUXB5nCDfRd3GjhYUG5Rpj+/zcfC3jAvtQWpY3Cb1P/xy
 m82fOel85pKzay8PfLEJYtlf7bklRluAb7bXoicnkdTh7+u2njcD6TMEhz+BeklqBh0+K
 TvHGHFYynONQwfH3EJMat8xmCA7kwBZ0+2AzoKrcvy87cAoNIuSw3C/3m3Vy7lGkQlP6g
 KwnKFs08MrQYDaBPLq1V+CN2fkIJGUfT5uiQNbcDGG8mCOPQ3ywPaEnvz1KFBi2xn+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596984;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ERYVzH4/Y57szMwOon7OLQBaOs8X1Wimhwt4tJgLhFc=;
 b=Foo2atnsOoDGNPD64Qid8mc0WR8+xlvfTOm4t1MNrR+O9knwE5Ix7NM13E0RDLA0dPNz
 qJWvX6HI8k8wtFLYHqS7lhE5RZZaqCX0a8YTbXzMLB+ppW1DVgj6q17dmtBvqa/GRaAU8
 Lr2K2sjcrTVY308SSHXbYb1/DAG0SuVmiO56+6jvQN2omV0ib+XiLKTe5HkMJlCfYJYk4
 ct2AE6Bti+y4OJct05Kr34BuECIpdE/KuIF28ZozOHSiI00cOE2X47D3ieALfqvxb9wYY
 MoVoeXy0anuV7GoxvwfWdXuUslzfDCjiEuj1cQuo4cxRQUfa0kkHGotVjaMJe8HCZMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="A/DGQ3Uc"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Rgbs0GjC; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=A/DGQ3Uc; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Rgbs0GjC
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2AE860625
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:04 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBA4nK1433615
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ERYVzH4/Y57
 szMwOon7OLQBaOs8X1Wimhwt4tJgLhFc=; b=A/DGQ3UcXr1Od1W1wDrfwOI+n1h
 wgBuwmKypnYoAMW+O6/koYhqjT/ZwziZpi0U12yFWgB4m0C9Yz/wqZTLmjBglYcW
 2iQ2ADJFatZ34kgIbJ7s9fUgt8OP1gvXfwx91/XAQcydHJc2tZlGqGY1ML8cAiAE
 PklLXxgYfH6FF9QrVSk6jgwaFMl80QlGlWWMHaMJX1KTW4lwXbjCUMPeFxGweZ0R
 XQXUhaTulsweyL3udf5dBz7ww/W+2XufgvW4pYkt/6adMLfapsSdCQqVq5gA0++G
 vTaeGrg8UI1kbBTp9K16WPEjVmtFT0iNAw24iQjzzheVoU83/Q3e7wY6hgQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s1ddv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:03:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5311306eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790596983; x=1791201783;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ERYVzH4/Y57szMwOon7OLQBaOs8X1Wimhwt4tJgLhFc=;
 b=Rgbs0GjCwsqv+x+53+ZgJ2KZBTTCX32OI/sO7I1tMLJDv3q/JEKjs8bMOGd8CvijHt
 P7V3KN9Ijmy9dBtzKn4HTjrQ4s6gO79AS2PZahqKRFItbgiJEAR6jzDe8k60WxiEhMfY
 6iiEugLSN1qUeg7lw5aqWd4ScP1hl8mLzwFqdVm0cqdgSfXvYY2JtGbTMni9ZMtb/mpe
 dmEC5Uu6HSraHfhx8LdQ3WtIJs/R981vv9DUrCgbmjB4lo/LTJkUIt05SKqfAhvxAo+2
 a+zsb4lHLsvoisyaGpIFusyLMhwvLBGUMWq/S4z+X1LpC/4IunBNruAp1UjNLllBptNF
 aChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596983; x=1791201783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ERYVzH4/Y57szMwOon7OLQBaOs8X1Wimhwt4tJgLhFc=;
 b=QtTrTd5TnyrtOeGF/hFrY7mwX2xlUFpiUvyFQxuetIHuhF17Vc/JcCObxNp4Ndayjy
 nKQULuch2AZjPsH6azphUDVZrWTG85aPoT3mvNvijSv4lwvRyVRs5JBoe9QDA0JXCwNj
 XEopWR3Y86qCeuARGA95/LwVPhiygp2obvUfTyk90Hf7I2O2Wc7nZOis2CatnA9sTRbd
 DhNqm7/1kQH54j/lNfk/8+I2Q/2K4O+hA4+nztbEbPUYIejNIFNh4fWaFiVilUlt0JMC
 TgmJ5fndRHGLY4BPQwkOHiwf2TrfoMJz3TeumueVB5DTOe3T2Iaj8JfOKd/Yy5BwiihV
 peNw==
X-Forwarded-Encrypted: i=1;
 AKwUvByX+twVhSK6Q/IVQrH/n5fc1kqUJ15bdp/zQrglNXfbTIFDAbQaPe3YlAnVCZjkVqx5EbwMcsY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKAWJ94Klh7b75c8GbQwcJQdDBO8+18BYQG90Mu0JgSD10T0Dny
 BrjUjDjrhtdupZyRYPqNxEDCr66vKHafATNdvMa56D9+CPPOfzMQXYmn0SWG4+b+jrVgifyJmDJ
 CLavZPbz1YoYotinT6TdjUyBWCKwTNIXZZlcGHrCs1yl5ijKxEqmVm4lVYOXv6m3BwdIbygg=
X-Gm-Gg: AYBFou1F/ejS3a5AcTYMkMAd5dVlhGsgYa7HvapEZottFKi66qmkLwcXEQYjMt+HrrC
 aRLK2TwoysTMkr/32OE6VtlUNlskpb1cAiN27LFnBsnqQf4WG+KupSxulVDzZihqmyTFDU4CxEb
 /3LY1neRnDpPs5gCxIFrMFkRPowtIg2e3eHY/uV179cdhhCji81Bx5yehwhJSwalwnoalEJFCnB
 kEiTl6+uoqU/kY+onupXA25FJf9nu054dQt/U6wqYdaOx9/D69irRnAs9xefNVAbk59vwCxC9RZ
 6A5KPqQhYaESgsAERiuN61B6TwuE4QuTwBFhTmViRxCp5xWzNgLfvp2sEuilfGwVP0HcCpYsFwz
 cxvRv2H6EyCZRC9s8hZIVoWVaKa3E/Z4J8A/p24EO9kfivemeinsxeirYkQxdxo1Qx/DHfSaEig
 Bp8v5gmispUTp3ecY4rw==
X-Received: by 2002:a05:7301:b0f:b0:33b:96b8:3818 with SMTP id
 5a478bee46e88-34272a44a3dmr8374678eec.32.1790596981666; 
 Mon, 28 Sep 2026 05:03:01 -0700 (PDT)
X-Received: by 2002:a05:7301:b0f:b0:33b:96b8:3818 with SMTP id
 5a478bee46e88-34272a44a3dmr8374634eec.32.1790596980887; 
 Mon, 28 Sep 2026 05:03:00 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144b4ae50sm28658382eec.17.2026.09.28.05.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:03:00 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, luca.weiss@fairphone.com,
 nikroks@mainlining.org, jbx6244@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 7/9] configs: qcom_defconfig: enable nord clock drivers
Date: Mon, 28 Sep 2026 17:32:07 +0530
Message-Id: <20260928120209.1064781-8-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
References: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfXypG2z4A7hxCe
 sBvsUR8Pzq/MmfxeW9FMr6pARe7yZRrRDHW2NDdE0QLasyfH8LN3lKuGeqj/DViFDqxcVsqnl7D
 RWQ+4rRr+8PQc/39gPjqj87BQxpGp7b30ph4V1Iv8Ndt7G6vVGVafxyKtHZ+pFBp2bULoNy/jvO
 xuBZK6eMKGr6gipthJo3u3WTceO0PkcVxi0PZ0HLsUIPV0upy/G/5DFWRaOft7MVJkU/kCHZtBX
 PrVxcBpcVAHua38Cp8khxvUQ6exbjGW7gYogWuvTCv1z8jOYdGHFfSJ1BhJKq9i4r3GQcpTc3mI
 YEl3elIDQazfNzyjPj5oBRKQIi+Wv3Ye/JpRuXdqn27cfJJt8EihGr7oSFG8MLBSGY+63RAs63C
 /FgIalg6wFEGWWaQSApAhfrHP4fSPFVHRNxQFcpwrJ+9bQmMNWRyGcaoEBbbct5vfIbpI11nwoX
 GhWxkps7bo5UoEeVO6w==
X-Proofpoint-ORIG-GUID: mvI6AjClY1bPNSUjQX8AaLYwRD8FSWHM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfXyiQHis1HS6Uh
 o3Pt4oJ3JLCJdmRA1r8pRPn1A1WXzrnU4DYV90UVbwMe9eU1Tt0yOngadr7VtXjElRo4+6wi2Jb
 fQDHB6GSHv4lfnhx75GMc9zbUg3kNVQ=
X-Proofpoint-GUID: mvI6AjClY1bPNSUjQX8AaLYwRD8FSWHM
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba5777 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ujKt_GTpXtF7ANkCTFUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280047
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

Enable the GCC, NEGCC, SEGCC, NWGCC and TCSRCC clock controller
drivers in qcom_defconfig so support for the nord platform is built
as part of the shared Qualcomm target configuration.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 7d4a2b589aa..24a117b9cbd 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -57,6 +57,11 @@ CONFIG_CLK_STUB=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_MILOS=y
+CONFIG_CLK_QCOM_NORD=y
+CONFIG_CLK_QCOM_NORD_NEGCC=y
+CONFIG_CLK_QCOM_NORD_SEGCC=y
+CONFIG_CLK_QCOM_NORD_NWGCC=y
+CONFIG_CLK_QCOM_NORD_TCSRCC=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_QCS615=y
-- 
2.34.1

