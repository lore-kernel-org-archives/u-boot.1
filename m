Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF06CC982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82D9180EEC;
	Thu, 17 Sep 2026 07:47:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lBEtFT3__d_7; Thu, 17 Sep 2026 07:47:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C7D3080E58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631250;
	b=GnQO/uip0cVZgCKCt67Iike5gINY++WH72DOdAYVrbm5V16iGpusSGvK/+pL+kP8oXEL
	 60hDv/6GMj9Da5RvtmEu2/Sch5kJhHbrsfBlgaANL0I6hNt8cYHeW09eGqx+FBeUppPh4
	 pwh4TTE+9ghYjNMZ7T254tvpG8RoCKgJSoH5Hm28WevoFWxQHi+tAsOvl9MLz/16QILE+
	 3KD6HSY0VYKTkTEtlbmGBRcDIj4As2RrjWsmuzo27TE2NtrVewVz/cRSMCwZ2edXn031f
	 WrBda2c8IpDiNJvguE+Hioq12Vofmac4rz1g2m0Ozbg3UewrOKj/AtcrmjHhF7o6vAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
	b=MXh7JSKzqLwBE6vuk/a2xrUDN81vCgrObapJShhOFOsr5kDDEUZ4CKJ1SVoLZCExjf4h
	 2KBC1BJ85jzaolAcqU1H+VT1cO4wfWnMY/xJ0yegN/TUwKrUbqBqstrY676UBjcJ1cJqx
	 I3nhDdX1mJhdz4d3uTNek1SPrKDLO/BuIrc5T4clclEQFJYErYZizh+SKrg3jwHkTHZxc
	 FUXzGOX/Q4WQgYaYM4LekCJ715qYKmvaqvXyc6JrhHa78WciQyo/RmPGZerLDJgyLaeQg
	 +GqOSZrmRk3+ZaTz+KWQaC9kRJColslRHS5FNIFS/r4glByJQLp3OF8droYHKXioM7w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631249;
	bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ezf5LSNZNUMtn621vG5u5oDS2MRbFYKI/+8XmteDOskL9vjyPWghbKfDpI2ku1Iov
	 LNBYly0YfUEKzN7wnE9vcJLPAxSuCzx42p808CmlrPiWlKeg8O6eTYQMgS38+Nf8y7
	 7a+rC0C1LRU6XoqPrILlHpkcmPqjBhBTsFSRqzB5tVGMyxbcQHsiQo2gshWo/c+dpi
	 zdzZRHguzX77N+MEJr5h2dlTHOK/Q6Q3ignw9STc8ECu/xZkfJmqg/SQivD2l9FGZW
	 mXLKTqOSymnCnPqZgoZBRNBZ0nQBpH7SyONAT6HMU3lAc2kHHJlctZqTV+2/GD9EnU
	 m8Qp2eoolWINw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7D3080E58;
	Thu, 17 Sep 2026 07:47:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48266422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E4AC6075A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8TkJrX_4QChw for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:47:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8127260659
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631247;
 b=SF1FP/ZeUH9TenNuxtLKPY8RsjyURDIdVEP7pWi59oHAjP5sYWqWGDJ5mAUswG7rf6ty
 uaQmMzmWJeeTJJ1V9+gYkPPLVHvXRTynKDLoZquLIE7SAHR6DuX8LDeITLo3k0iHj8C/T
 pHQvVMaMyXg6WOznak6y2dfEWoWJEja3ndt+h+ayKofpfgVH3+1Xmqj+oqVFhcScfq2fj
 GXr8jvTZsdPN+0YvqPytV4Ljs/WBDaICk+cGlgjmVGbY0HNAUsByr8LnFl9pvdnBAIu6X
 iSHZmtJh4V75vTZ5N5SpyXkYHsjWEHJmmReNNg9a7ZmpigbI8CJsfnDWsmO1GLNfsAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631247;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
 b=M/Q+aabjxERNcMQ30TymX/GA91hMNaKQJWc1/2vijlwDChgsqA3id0VTbw6FRrd5XZBQ
 4U63BWyXrZsTf9TQt3e9cgzKH8P0qaB+Zr6Q0CheHnUB+N/CxJL12WbO7o9+BTHbXWE/b
 dFku9I8IslhkENHROAtWpwowAPDm5SwuxsPisUZr/kLXY8EFD+ImJKO+SFTxoTnLv1qjY
 HWbl8VTDEon8x+W7vcZtQ1Mg4an/ngfUNWhZVdUKTPHF8NmVAPjiv5RrUDD42BdljBqDm
 HFbGXDmo96SicUHk22Jud1bevBV5DX1Vzyq4Lk1+EzWEo9MwMu2iYPI3XiAqifCSbrQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jek5MajI; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="OUE/EbFt"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jek5MajI; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OUE/EbFt
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8127260659
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:27 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H611QT902553
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=; b=jek5MajIbd9tip+h
 vX/QI3dkHFwiHx7r7FDO1sep/9/l2pPv4hhWgYplZllHyZNpEKJ5aA3HS0xAKJRk
 FdiBlhmqA3X2WSsZUIauPo3Q04XKKdIeYa1GSvPT7k89SjbEDGZuSW5NM1/sQkMx
 PwNxHaBzcFdBpAQ3K+GgLJrIZh3mBxkdUf9n2gz8KLkGMhO+ycYqbyHwdc1Jyidn
 EnT7prNIq95R+felsE54NdiOrfcqp/jLHtYsef6Rx1h3LUxN8De6jnvj8Rc+MocT
 ZRmxrV6FsGYPIGbIZ36AIEPoKLTUiySTeoxOWUTBJXjWNy4PZ00xvnuXYyuhruj8
 BY/Vww==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy2d37up-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:26 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6c1a8f2c565so746346eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631246; x=1790236046;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
 b=OUE/EbFtRQFk0DgS156lZWQmDaX3tfPqp2T2A/kbO3G5qMQFuQ73IezdAMwANQFjJJ
 5aXytqg0MNVG7+Kv9DUI9GOcCTVWxF4JwabEKY0UiVt6U3kPx+7waQiNhrScYtz1wkSA
 8WeWVxObH7TS2V9JOFlQguA4yoxmOjQXZD3G/CDFwUjF7Tca5YjFZ6V3vGoWRSUT/YdN
 tc3UoLEdu3JpU2WYrwI7xt8r2UlBhj0LW/RHrSRnsYu/ovpJpQ2CiuMRdcKfjL0w6Exp
 apRvtfi/WbsXQm66htlSHHRU75EpaI1zMDamYyQ9/zIE1KqN1QdGPSzTzegnqmf560Ue
 55Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631246; x=1790236046;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
 b=Vz5rHylVcrjTOWFmOnFDJl09Y0mqiwurAZNSQCPLrW9KwqFivmUrNVwo4nWC2Ohcc0
 2mKt6/L71T09FCw23P865S4LTT5rEUVeeujOUFffAU0h+cr30P4F/GB9sASFb8pbDuQl
 MASbcmS2Xx+45hrlofJ1TeCnOnUGVXs9gy2U3L+QR2YnTxKVv70hCi5VNU3LmZU8usUn
 RinEknEZDr0ujn0kYR09d5nv8k2+he06gnW6il4U88JSGugJ2IQPlLxmEkVX/zu5xuui
 He0Jx2oLAyvGoiZ6BlGoON+QQrVwy/7ErUTS6OEdcBTakHZ9QUyMXiNE0BDvXaJGRp5R
 mRhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBygRQhDRMDESRwi/RH7Q9nVTEKTd9nFtQdBXwhCaKfmBMsDHb57BxIIrUx775y++zd0so4rOyU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nWdgKdPgWxyr9kWcPQIkxY+90RztJHeEW01xzY9P26r9EqswaZ
 x2yvGMkw3ZsEDISveS0Y1o+3nSGvQREWr+vhgZzAqsyhmEEPdAfr2/I7ygAKqipfSIOiC4jhsp9
 f+ZpeVzbct1mxHnFKwq4IPaEta79joMMpB9WcOZpA7aLtPTkgvKprMSvlmzU1FmR069vZOmA=
X-Gm-Gg: AYBFou2SW8QCS5IvzGaYHbUMX4Mo78VneIu8MKIZY2+Gk6l2HVobDdJbKFQDsHyW/dL
 9/+vn72fF0yO6egZbs2WhXJekVjyriyCDPV6tuMs14qipJYxJM/jbzyyJL6HsSlbxG915ZtXVUT
 +SwjdDEfkvH/P45EXBmhMlRbKGWrWqnNZZc18nf4eqzVeOXf/dbyssaekErs6R0isk8cQplpb8J
 dTHN4VAYDbRIJnKm/olo9gx+1L6R41pjH0QXDI38m9EjDlk5z0TyrYxALhZfn851cN2T/362jvK
 uXgq55QjSlzvohueVM0a03PK4F/+YQboQSlft1biBrCzIWUAV5WfxZYmimIGqzDviuWJy5PMABz
 7whhGL5vZRMvBZeYUZ2yJI8rCh2MyXszjAcMdNTmG0l+hZohHFWFWDCIJS4jcvF4gR+U0x5zn0z
 4YhCDs/n79ayvg094/j6OHmuuBAYObEA==
X-Received: by 2002:a4a:ee0e:0:b0:6b7:83c5:fde9 with SMTP id
 006d021491bc7-6c7d3ee58ffmr5802894eaf.42.1789631245883; 
 Thu, 17 Sep 2026 00:47:25 -0700 (PDT)
X-Received: by 2002:a4a:ee0e:0:b0:6b7:83c5:fde9 with SMTP id
 006d021491bc7-6c7d3ee58ffmr5802854eaf.42.1789631245424; 
 Thu, 17 Sep 2026 00:47:25 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:47:24 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:39 +0530
Subject: [PATCH v10 10/15] dts: ipq5210-rdp504-u-boot: add override dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-10-3e83dcd239f0@oss.qualcomm.com>
References: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
In-Reply-To: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: JXLIq8-7SjWigIbMFAawHQUFDwRueFOE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfXyjRshPOwpzAk
 flunU2w/Xbesh+v7lnRfjQO/ouMb/R1Lxj/DOcOiLjdn4IbtWxz4T73SP5PlPSfp3iNiqAzF/4a
 33+GEKSOw4roy6eyTzGdnCOpF0xnAOk=
X-Authority-Analysis: v=2.4 cv=HbeB3SE8 c=1 sm=1 tr=0 ts=6aab9b0e cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=t4X9H54Ucq2VsXYocbkA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-GUID: JXLIq8-7SjWigIbMFAawHQUFDwRueFOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX4sO+MfLeTSvi
 wyG/W/yyDoh8bgcc/T/uemb2NtYnHqomQ2lcsV1GMjDlTlmDkrj+vwt1YHEIlEBdVxBMj77SP6J
 e19vtcJ4T9DrhLXpIi1QNSrbgz8fCHLXLwmUpWP+riewb5AXFxOqiYqid6idb2ZgAR/p44hxCWH
 BLLkBWwx+acnPMepYk1KwxhSr48zCAxsTSBUmL2A/C1Mx9jYRbV7AF5x2QDPed4LkZgB/VgVwRA
 L+r5Sg2VWJazQwVN4g/5bNIYwgd6g6MCLqMvKf0UXH5QhdrtmORAjGAQ8hplT/nmBlxaEnlyUm7
 mY03Fx26M0ml5mwRzooszBXJr/MjiX2njpRWLrH/Nnm6qpzxo5xkS68xENsLfrh/dc84j9XD+zg
 NfMcgVIbQV/+NeZ4bWMyaV9USOCgbBLBJH/HB2Aq/AIy4D4iu0Ite33X30nuyN3cJsbldKY+XH4
 9jj5qY6zkv08GbzRuAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170104
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

* Add initial support for the IPQ5210 MMC based RDP platforms.
* Define memory layout statically.
* Mark the nodes that would be needed for SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
new file mode 100644
index 00000000000..5582de9bebb
--- /dev/null
+++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IPQ5210 RDP504 board device tree source
+ *
+ * Copyright (c) 2026 The Linux Foundation. All rights reserved.
+ */
+
+/ {
+	reserved-memory {
+		/delete-node/ bootloader@87800000;
+	};
+};

-- 
2.34.1

