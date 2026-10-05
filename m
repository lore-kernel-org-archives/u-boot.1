Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60BDCA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88C7440655;
	Mon,  5 Oct 2026 07:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id otdeyG-fIb7w; Mon,  5 Oct 2026 07:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BA5D540670
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183931;
	b=Pm0ORJkKHZcexS0NI/b/Qk469sen4tXlcjR4rtTK/2PAUfr8jOskz/TPmnHf4raGjF84
	 Ywez9v+EGhfbjacX48S91mALgCC8kPGk08k/MfDE3KxIF/t1qPy95J3xEmyKj2b0eYnDj
	 2gVsplwLllPI/qAPmokNIIxXng2lE5FBGPwvxSoPIYtLVK/PDmy1GU0SF7CFcoi7iMktj
	 ZQZjcP+FclBgDjuUDUX4jRO7Evsx3bUHtLKAvDN9U4zWN/s9UY7yJpb5hE5iE1LnhMzcs
	 9klE5l7nAOH5vddz+xkE5eBR00RMwATkZQjBhc2GXHaApEsr/suc1RCzEVBxLFicyiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183931;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
	b=Mv1R7P3PbAeUVb8lZf368rmb3HJ2806G1A1hbSfnEJHDBvcuP7ZWf0+ZvlVxpWqtUoSd
	 ZTHDBNaypy3OZ/oUx8xuuAttE2p6i2Z9PYRNH93aQWNDcqvMe2OoVXAIiZrpgnPRO4LN5
	 01JUfvrss64ZHUl4FUhRvt5kWFI9htd7zpy//+at6mPhtaBKUEBz3RwOf7294J5+onwYJ
	 SGX9ELaepzxlP8t3rCVzrFFxwiJeX/ewFjhmgXZvNgIxwcGcP2h2EzAxFE9S5LXWbQTEk
	 1sl5wJbzALS2NpOe4J10R67epAXiK8gQ85uhEd6FVvvYjTrVwXb742A0yG6huu2pRLw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183931;
	bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PtuaVqumxcXqp+I8OojMpjsykn2gDROkHcfe86oXC6xl9B/uXkj/1wp6hrkeC9+Ha
	 lnMpTjXsNR4kGGOgIMUajqvyebQDdC8wDym1wBaIidPaO7F+rfgKsXKcPnupfh/6kR
	 qpVi0JxOsUvGz8StUNGUfDVo9zI8cwSdhJ6wAuOaXssbCReh2D+ZYfATx+Tdw8+H6j
	 kPM0ggXMU7IHaoy7AyKxYVZyub913cq7lrqHnzMbuKcaZv/ceDmc+E8JsI53MTL4Ij
	 xlWMlX9AbzF2sNEcAAVwDu7Zt4FPogZFi5tFcvsoBvB2baRU55BwxwZwS4eJc5AmZV
	 V2cL9Jfhal1IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA5D540670;
	Mon,  5 Oct 2026 07:05:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A73F1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60A7B605F3
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6H5M33xaQNOE for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:03:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8AB9B605D0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183828;
 b=Nym07LbKOH1TX1y4wQgjDOsN9oTLTgHLZ9N/S7IPOGk+1yekYkAFw8tVFXFa7hT0/Enz
 WIIV9w20DUohCcY24U+IvnVhqxJEew1KYb0bxLuZZtwXdmFoQesHGSMvy5TKJYoNUcfsL
 RzJV7wByqMLFRHMzR1jLiaPW7RGMTHL54paNnFSj3bM/xWH6K0wL1NRr5v5CppzxtaD4/
 RfyvR2KbPX9XYpcLIJbDlgFmdEXodVYLTXzuGmikCTQG2P2gik44tE/nQ6pmU0YgeOIrJ
 M6G/mOkYOxr7woQ8+eBxWO1BjLkZJVga8tJwt0QtbbLlBqp/slY3A8F4nfMaMAPDcKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183828;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
 b=nWDgHQqq8VU58X5JtJWx+r70b3FtwCHGVfme531W5J8IXMezsLHgxrSOqLCyFjhoPlwQ
 CImXCfVI7Q9ow/eqfMw5oSupkU/W6AG5A5EK1vVKaIx/FP1eHL1kmfklKkhdv09qrqLMD
 I9pgoGwqhMruW14O5FeMquMXRA1VBO6XUD6yrewZmBdmAY24EZGxMebhi5XPHeSeu0g+p
 3y8jxgYNPRVN8+PNl0hFxcq1vllBQSCM9HOmInhPLHmtMrC2h+ToONpOB2rUzJ54dWGlI
 lIrMs1Y6IpsWofCN4rJvYbM456IMZosk14iX2r7booB28gdl2tcGswZfhtDDlqqm0iA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CuU19v+g; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BSYeoeeX; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CuU19v+g; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BSYeoeeX
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8AB9B605D0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:48 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6950xwEw4060139
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=; b=CuU19v+g/dQ7lw1d
 yDrxoIQgnTiERPAR9G9529Ol6jWc/zT8v59J7U+K3pkPBffrlsFxmNnvBdHjndvR
 3ZkFuLSmLKy+scnxNmVvwwxI81YPplOuZReaZZ/yndh9qUeDGUyIIOGcprhwi7V6
 8UFUWcsTvwyqcp9mAOB01/aBYa4UM2Dfn6v0Ev9fhaql3+JhKrcIKER1geie4Yj1
 yeXUKTLS0Nyxv1rMqZDbYynfGSKbbQshIolcOLaB0RBw7JagzMCr8Qatqyuk2+Xk
 KVxMxcLD0heYZB1Oqo2tuIUBiT59GSY9VLzY/utwuis4YZXtwCnMSW24xK4v2fNS
 fDZxRw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h41gn8s6s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:03:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3282d5302ffso2028457eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183827; x=1791788627;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
 b=BSYeoeeXRH9K6xd/GU2gpH2VQ69ASq50XoH8ZdTHXCjlh9PMjYqyvcBsdtB1mqWWUU
 6rZ76IqecW96mEB2Lx5PLBfwBbGfoS0z7r//mtSdw++VWvAdXUjbAZrCV4IUiUJOhP0+
 NiCeydTxGsR7zo77l2SqsGlONPRcVkbkZisDUsObK/qxR4Pf0BeMjK3w4VFOAP7XKOXA
 RbI8nDP+rUxNisEDm6FEIE4DYA3blt1lBlZ/ZdezdNihKXL71LwzxxtRa/YyRwBMQ/xP
 48eBNwX8V2DOqUO3ByqOdp/MQkabDw4YnMSJAlfQ8s98nZwBU/BxtQgZHPSu8ggG8wTg
 rzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183827; x=1791788627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
 b=yRDjq6MMx2U1Je/WV0DyyEBUUxg+G47AXvJjwjOp1URINEQ6lnjRBUuXsViViNqmNB
 J6J/zKVqv3xzXRkwIjOUVrw6sUORE01gTbDjjhF7sdDiPiN4d8UMtKHPbwrqqOtZ7jdE
 xsx73cBs2Q5PY+gMR5r8tQJF8ClyBbBaEcft3BMYV4l9nv3rOaTP+fZnF6rHlCrbn9dz
 I+88N8pdpyvD3c0p4RJJ20pETCb83uTmSSdDznojJvpPxG2R8AkVpCx5WPeUysi355BC
 Q4Gv0LcS90DFjqrgmUrlOPEsGostg0O//6zOUP7j7APOMPKSE/uPObfjGEp/BxVwXpDv
 odag==
X-Forwarded-Encrypted: i=1;
 AKwUvBy31fnEr+vRbvXAzPqUm4arHmK0by/ZWMgZ30tvGsy1GqE8js+96N7S1UztcEkKicaVXb2zsTo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nQLrQ0xFO1P93Rhkx/YwWZK0FLsjb7ubId8oWUx7KgPU91Tsdi
 Sg4ia8Qcb8TWPFcfYA/SkXD5jYDaMX4p2YAyuiA6VP3mEuNKO1pvbVQMVwaTqRwdAlXWvLiR1V0
 D+de0x9GB9RM1/p+uT+T7TNdp7MOy4bISTc2q7osRZgJDRhzFvLoSgrU5nEV7uTfBRePrLj04Kj
 HImWM=
X-Gm-Gg: AYBFou3La1ovyNtmxsC5fe7LdgfBAkmoJHDOtPsBnIWagcrSkPzZM8yL5i8nZ0oEXnr
 Eq6aeVY1HJz5ZXsWDIRDiYK010DrMEgpur/tp8U469Ouct41FoJtYGS1gZGp/1ygI4btf6BeMlP
 f5sQdT1bOZxVMlb9w5GVHoAkr8juH/h0IdrBY/wJGQ15KMGeiStDRn8hbWPqR+rOh1FkKb8RbEM
 Lm9sdl6PgsP5dTiuSw5nMx4qWJcTDxX4Q7CXibMmnXAsGUzEQcUY/8qs/kLBzWJVBsHrDUWp/H5
 BDUHalTZRJZicnWWl0pIIAr3M/XErX9PGv+HI5yIQe2vUwZJe+1cPy8hu9AgqxPluolt8MLcLOj
 aVyQFGpoc7hM/sA++b/4MdNnbqxH42Y1DHuMIOR5Q6j60/u7yYg3SbmSBpdvYde3yIp/6W9mLMR
 KjLGz5398AULLJ9bnbYQ9ykbVoeO13
X-Received: by 2002:a05:7300:fe4c:b0:351:3a46:be0b with SMTP id
 5a478bee46e88-3513a46c529mr390448eec.6.1791183826672; 
 Mon, 05 Oct 2026 00:03:46 -0700 (PDT)
X-Received: by 2002:a05:7300:fe4c:b0:351:3a46:be0b with SMTP id
 5a478bee46e88-3513a46c529mr390404eec.6.1791183826039; 
 Mon, 05 Oct 2026 00:03:46 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:03:45 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:24 +0530
Subject: [PATCH RESEND v10 08/15] mach-snapdragon: spl: Add DDR
 initialization support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-8-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: d5IiCbtaLVK462mkMf96yVezaN6V2w0u
X-Proofpoint-GUID: d5IiCbtaLVK462mkMf96yVezaN6V2w0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX7IzNDqSisrye
 SByazmOfuB0l9e1CltgDqYdDiTohS4ww6bDDroXNJxENk60FOrSLhiNk53RCfkSMdDK6E14RoI5
 7AvQr+2Y6bflfDwpLHNQNsiURnEydDXeF/2j8IFlyhM1oGwyJ9cXpunjmnjrgRjU0L7XTCHC1cv
 nn2A7flQHJyVRgPvuo/Ui6mNULgN76ALQCfOmhVisHiaKC09UwF6sfYyeTpzWFKncPxgSXRxESx
 AMZvRwvdAHRcTzYCTgYOcpcU+y9yQpMC9vMm23Yg3bMe4aEfPQIgB0LZnimU4mtdD0soiYndFB2
 bOdyko73d3gpT3riE7vtnT61Sx001Cy1aa+abrcNQTxOyR6wO7KUcrYaYzq883g9nKMAjT4E4Js
 uxxgG7aLCXGzkhzISYuDgo9sOtNSKmdRzfPDzLeoZp9ORb1l/GkdE1oGQRQKQd15XI5qZbIzQef
 X4v5VA5m7ekm/MB5Xzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX8yi36cL+J8sN
 Pm+syEuDRvEr2J/BkSxR0aRYk/yjja+rjvR15SYk7lbHG2lVcns++6nUGXDQPQ0Kqavc4O0PcFa
 0O67ymgjVuAf6dR5Qa98WfqFmbCDBck=
X-Authority-Analysis: v=2.4 cv=P9WvFSAu c=1 sm=1 tr=0 ts=6ac34bd3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=OI4x4kLBNDoJJu7lNuEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

The U-Boot SPL loads the next stage FIT image into internal SRAM. The
binaries are 'external' in this FIT image. The SPL has to load the DDR init
binary, i.e. qclib and the DDR parameters i.e. qcconfig used by qclib and
invoke the qclib. SPL and qclib exchange information using the interface
table described in doc/board/qualcomm/interface-table.rst.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile      |   1 +
 arch/arm/mach-snapdragon/fit-handler.c | 131 +++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 4f2f35cb9de..2701f7c6fb1 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -7,6 +7,7 @@ obj-y += mem_map.o
 
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-y += board_spl.o
+obj-y += fit-handler.o
 obj-y += pbl-shared-data.o
 else
 obj-y += board.o
diff --git a/arch/arm/mach-snapdragon/fit-handler.c b/arch/arm/mach-snapdragon/fit-handler.c
new file mode 100644
index 00000000000..fc419bd3f00
--- /dev/null
+++ b/arch/arm/mach-snapdragon/fit-handler.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <atf_common.h>
+#include <image.h>
+#include <log.h>
+#include <spl.h>
+#include <linux/err.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+
+/**
+ * qcom_spl_get_fit_img_entry_point() - Get entry point from FIT image node.
+ * @fit:	 Pointer to the FIT image blob.
+ * @node:	 Node ID within the FIT image.
+ * @entry_point: Pointer to store the retrieved entry point.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_get_fit_img_entry_point(void *fit, int node,
+				     u64 *entry_point)
+{
+	int ret;
+
+	if (!fit) {
+		pr_err("FIT image blob is NULL\n");
+		return -EINVAL;
+	}
+	if (node <= 0) {
+		pr_err("Invalid FIT node ID %d\n", node);
+		return -EINVAL;
+	}
+	if (!entry_point) {
+		pr_err("Entry point pointer is NULL\n");
+		return -EINVAL;
+	}
+
+	ret = fit_image_get_entry(fit, node, (ulong *)entry_point);
+	if (ret) {
+		pr_debug("No entry point for node %d, trying load address\n",
+			 node);
+		ret = fit_image_get_load(fit, node, (ulong *)entry_point);
+		if (ret)
+			pr_err("No load address for node %d (%d)\n", node, ret);
+	}
+
+	return ret;
+}
+
+/**
+ * qcom_spl_get_iftbl_entry_by_name() - Get an interface table entry by name.
+ * @if_tbl:	Pointer to the QCLIB interface table.
+ * @name:	Name of the entry to find.
+ * @entry:	Pointer to a buffer where the found entry will be copied.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_get_iftbl_entry_by_name(struct interface_table *if_tbl,
+				     char *name,
+				     struct interface_table_entry *entry)
+{
+	uint uc_index;
+
+	if (!if_tbl) {
+		pr_err("Invalid interface table\n");
+		return -EINVAL;
+	}
+	if (!name) {
+		pr_err("Invalid name\n");
+		return -EINVAL;
+	}
+	if (!entry) {
+		pr_err("Invalid entry pointer\n");
+		return -EINVAL;
+	}
+
+	for (uc_index = 0; uc_index < if_tbl->num_entries; uc_index++) {
+		if (!strcmp(if_tbl->if_table_entries[uc_index].entry_name, name)) {
+			memcpy(entry,
+			       &if_tbl->if_table_entries[uc_index],
+			       sizeof(struct interface_table_entry));
+			return 0;
+		}
+	}
+	pr_err("Interface table entry '%s' not found\n", name);
+
+	return -ENOENT;
+}
+
+/**
+ * bl2_plat_get_bl31_params_v2() - Retrieve and fixup BL31 parameters.
+ * @bl32_entry:	Entry point for BL32 (OP-TEE).
+ * @bl33_entry:	Entry point for BL33 (U-Boot/kernel).
+ * @fdt_addr:	Address of the Device Tree Blob (FDT).
+ *
+ * Return: Pointer to the populated BL31 parameters structure.
+ */
+struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
+					      uintptr_t bl33_entry,
+					      uintptr_t fdt_addr)
+{
+	struct bl_params *bl_params;
+	struct bl_params_node *node;
+	u64 qcsdi_address = qclib_get_qcsdi_address();
+
+	/*
+	 * Populate the bl31 params with default values.
+	 */
+	bl_params = bl2_plat_get_bl31_params_v2_default(bl32_entry, bl33_entry,
+							fdt_addr);
+
+	/*
+	 * Fixup the bl31 params based on platform requirements.
+	 */
+	for_each_bl_params_node(bl_params, node) {
+		if (node->image_id == ATF_BL31_IMAGE_ID) {
+			/*
+			 * Pass QCSDI address to BL31 via arg0
+			 * This address was populated by qcom_spl_invoke_qclib()
+			 */
+			if (qcsdi_address == 0)
+				pr_warn("QCSDI address not set, BL31 may not function correctly\n");
+
+			node->ep_info->args.arg0 = qcsdi_address;
+			pr_debug("Setting BL31 arg0 to QCSDI address: 0x%llx\n", qcsdi_address);
+		}
+	}
+
+	return bl_params;
+}

-- 
2.34.1

