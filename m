Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C21AC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 264B860659;
	Thu, 17 Sep 2026 07:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACZHU3N3_fha; Thu, 17 Sep 2026 07:48:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 55D376075A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631290;
	b=qgrE4+nG8KPLXjMNODG56DImB0MB3OEdpsmm+uoPvBXtPxXCzuQEecTlKo9qV5OGmjVb
	 nwL5O9l+cO0YGQO7xiIJArM7TENSmiFfIx1noSSEJclYhdD+KD6HLVZwLfftmj4GkLf7l
	 s3blAXqQSabTdpglgngCKtgJ0qvzrIYn9EO5pszlGbWYT1+Mu1pshntA0YGATjdpTJ2E/
	 WYJPAqT3PAswbE09u12LSx+/qXxoZ1w8zhMn5kE3nHuAiWPoCcG+qKfD5EwP55BgFETTE
	 dj/DzFqNndxJVJZASJsAz2mzP2611b9/s29+0j46GpE8ZTYW1QJX1h9Rd0Gb+5C7iBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631290;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
	b=fqDTObbFSXNCItRCiopkuSWBeSZjQ3VA8araBpp4eY5ST7nq7oeyqi6Ul7aY/oetJQCu
	 EULGOSExyL9tlXUbqTg02ZTkdRir8TydD9MxJM84STqqm5WdcGzo6m8meEVSQFWYhK/ff
	 /BYwKDNZAYPwZsSoBB7be1YVmKXNMCF1vjWE2XxQHC4U+YLlQQzped2uVXKXAZx8J4LnL
	 HU6NOLF9qgNtGpWG59Ibwys6GqQKYxa3nP/PIfd64X7HZvWhJEy80J3d2SlZj0dn/FA7M
	 rGOS2m0gI7Mt1+LZypPk5HNcBYnsdbO8nQPl5Zhk5nLoP6dh/WdilmioGT7Znw1NOkg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="JRUXH/0J";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hrrzCeiz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631290;
	bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qq2CpJ3lKtjte9OrfsHT+vAF+V39E7EmiL5ZnHLN+sw2hcADg+od40sP0M/nxsRvP
	 Y4SYawmCdScwsPdPLLBLoobhqTbFGSO1+4H6lju06veAlVHcQEZ2kLijElNHX4qdu/
	 wtAIzIUAGIJ08z+jxyxOzX83bMn+qS0ojYgeZVpX9/yFlDLB5qDqYNp4gEvq8iQ/rj
	 5t+m8d2WOnm7sofh9fFIiSGvbVPsjlbWZbZty5lhSav0Af1y78Z/xATYJ3UiNSz+pB
	 DMA1lZP7H1s5mZx0/Mzi+2oxhq9bzHb0h3d48pi95hDLBEvhbW+AVwPZ+mee6jc+Su
	 c/kKYg7u6z0Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55D376075A;
	Thu, 17 Sep 2026 07:48:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A822424D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5E346075A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:48:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dSns5Kate_nD for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:48:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D51B460659
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631289;
 b=NEpGBMiA9aSxU6v8r0gIX7eS+7fGjYmHfoqomMO4SbL9CRQag3la+wwPnkzhkO1wRHYu
 2xKg0rVudSqLsJmZXgEKWu3aXz1gW2ocZDYuHnMFAFw6yBsKRYi9YHQTDqGlaQpwKRfnn
 1P3XQpdlVx2ASwRjEq2kyEyHPUkPjtMjbJ1JbsT54JevQF8+0CB8+Jfp6s9G4+Z1FK8Ek
 vShjLFRDNkluDcL9qlojSywXnLb855FfzeFCXkQS43G1vPAh9DWIvvSCtjc+TePktvas4
 kcfrEMjH+9gqt/2uNr8hNGG8SnCRl85aktsrFlGyOlWwuz68bME12K27RTqfD6ZIknA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631289;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=D/nE4MhOs2X96m1kPN3tNTcwkQj5d0GJnhNOWOgM92MjPWa2IkRGqnRq1mFaYbbgToe7
 j3NbFVH6UfAKPxhgwQRSub+pW3xIYLzA2WPP67lCvujG1kd2aH35oTXH8tV4dERtBSNzC
 rfZhxgr7x/cDTfdQApzq5LTdR//FSJi8/QwAKgeu9kEV4uJio8uQOlh5I/StonzfPmrw/
 u8XSW6qfp5lq9FoPtA/vxC5tAc+NBBMMDit4m0QhN8Bup2fT5ZAdZ2oYOvcIfJg7V6NWp
 u/o3FCgUpa1G50Yo2qhdh3yyv8e44IU4mYKHjwcN5oUwk6JOxZa2jWhMV41LslbUb5g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="JRUXH/0J"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hrrzCeiz; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=JRUXH/0J; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hrrzCeiz
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D51B460659
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:48:06 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60sGx1031594
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=; b=JRUXH/0JvEyErJxv
 roGIRSI0jDVyO7juB+ARnt73JcLV+18mI5bfPtY/6HXE8SReQ7jJglgU4H4GPWgD
 +jUKYxKAipN47dkWy4gq3YNwvm+QHtAJL8BfGDjAsx0u/nJDKwZQVCW2+OR+kPGV
 c6tQYK9JC/93Ius/ruhUc1P0F42sKV0by6jTlm//OqegQp2deoljHxLqyf5dlV+w
 n7+navbMpGOck3MR6zG7iTGfqbxUWZofgtzws4XZGvxwllH7ZM3TC68Ua8EphJ93
 KcNkMPj1Lu0+dVuZ5rrEgDELSwS5D7WaCDbJ32mxneaJy1byKeYpOY7m5bnF7IL3
 IEe88w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy7hb47q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:48:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39d865b11b4so787117a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631284; x=1790236084;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=hrrzCeizVIjyBm9hpabdGTkp+xZdvIoR8atfwMxmav27z/OEvYsYq/kGcg7v3lynKY
 /PoTSU4xLZ7QvxC7+70Gwj7jHutikcC8Yi0uZg3CzN9jEQzri9tRNByJ8nndE+Fz+SPp
 nB3oow2dMD6l5luFVBa31/tzh5VlTRs7cNuQw1LJBpc8cMULR5j9yGofizMOPrx24YZI
 ZcdBHtirpUKcI9Gow5Aoh38eOn8M8djZUqed9fJeO+tP4qJ+7owIzJRGyvnJHKnZqSTp
 11+WsqVfOUFxEfJUuLTMmTx4OAP4ME/DFt4iGXcy40CHHDGl5SK/v11vZJXXdMBRwsWx
 ceMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631284; x=1790236084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=LyEjG4EQUzvNsEzS3U/JrV/Q+r++ta5+XgJtGsKnuv1lKprGX0AMRqIA2IHw5+N9X+
 Imf7KMzYaQLsK8KrtsoMNVkmsg14iPDm/eGR0zyVKzV4ZXRTzeSfwOOVgk+OXeY8D3Im
 a5lc6FKFzt19KGdvyfHqCfEkmgOGcDeYP5w2PwVZXy0g7+Kq3FcyCf8VzxkfloyKc4vM
 /L39+qq8KLhodNYYf/ZlOGulp5s3yZJdG/Nwk18qdfEjyoZmAXplUMPRI/gP8ZuWRJnR
 YD1cEgy1Vw939WANNYUzbZqZ5LhTWei2Mrz0cPOIv/c96mtv/oAkODFnUJS5RdWUTLI4
 +Qag==
X-Forwarded-Encrypted: i=1;
 AKwUvByPpy02/K59rz28o1aBk2uSnTkj0yJYTPnNb0Pz6wnVG9rVkCiNLtRMPJ0klI9l+pLyGkIbL5k=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m3m+vyTg/LqFdEG09/2EsjMtIgsQ0geuJupPemXEUE9kzu+T4K
 Cc0UehG6qwj4Z4xTMC17Dak9ZNXtWEpK2c3tj9/J2/8YMEph+5Un6vGbTc5haE1TYt3c1YSePc9
 PiikGuD4OcaZvi6EzHNU1AdD5jTzjcDNZd472c90EXvdr5n23TXzkZ7yqjsAxslFN0x+sHdw=
X-Gm-Gg: AYBFou0x6ElicejUQwiK3z+4HiKcZ226WRSIyVsjzKwwa6cFqQIrMwUs1y2z6eWmmTS
 k1AKdtMTcerU/BlPcY2HVeOiLOj7XN1m+6s6Ti73ereUAmFf1AtQmeXEaKGkxu+OGPSjUio+ZwU
 CNYzz/tuv74jSjgqNmTkDujMHh72C3oHt15yv0UuIqTHL8NhlHnFJMPupLPj5ErGrfyy2XYp8HN
 UaixV984uNqWbzlUsxUx1v8Bi97S4FoNoEv9I83SBy+IfuDJ0ODZEehf2lPevBzAcDZiEbclVSD
 2DBPDR84I9eAbPnklWVDiPdls9W0uhfuzVnqbeuT/1JTlECjKYbg8r5YycW4uf+v58COnP39W+7
 7oFfvRrQbKNHuXMCJNr7DGXbRrGBmb/JNEujF3+oZh1NrhtNuWQHVGvXDMx0yfxvYTyqevujgFJ
 AzwrnLbDFjw7cSweMu0AP0OxinSWPadw==
X-Received: by 2002:a17:90b:3885:b0:39d:f253:ed66 with SMTP id
 98e67ed59e1d1-39e1e51d828mr12373258a91.22.1789631284342; 
 Thu, 17 Sep 2026 00:48:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3885:b0:39d:f253:ed66 with SMTP id
 98e67ed59e1d1-39e1e51d828mr12373212a91.22.1789631283874; 
 Thu, 17 Sep 2026 00:48:03 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:48:03 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:43 +0530
Subject: [PATCH v10 14/15] configs: Add qcom_ipq5210_mmc_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-14-3e83dcd239f0@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX7F5hsJIFeITU
 Zs0y7iRyGN1j0hHIrMx7WSc5CrdHVunphD3kUTZkAgsERAleWlHu8Q2XQz10NFsFsFNM9UvlEF0
 GWm8flBqZgPDdgvZAk0kPY+nfIEK7lJksK6Aw+8NgmBrdJLXpt8RHsRYa+Z2mIjq0oxUm1jkiOL
 BIz5l348G9hfNIoBAI1YbVjIaME9alULE91rOds6AzzLg0EG+cJQxvay0Nlhh+oIsM7IjKQ69mx
 +0JCHrqyNGsatzOK/y1fx7csvelh60u/3whqbsQhGB65CCbPcJbcgJ2aFZKwumVy+rqTPK1LY2s
 EVRO8RafWS5hKsbOu2I73skOVyqlw5baStZhQqytIfI5ji6pjpc8IxEWzKyHJcLeeR9e3IgfZ39
 42hvrgxipZN3w1txbeW4ypTKlMFwOX27PRRs46tEt2Y017B904lwFw6YKCYOwQ7Ry9OYyuY5nOh
 EF8lDK9+/6DtRMD4Hrg==
X-Authority-Analysis: v=2.4 cv=L8aI0OT8 c=1 sm=1 tr=0 ts=6aab9b35 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=bkeBrEV1CVOi_WhrbfQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: n2fuZUfren8LzqWv7xHgdIJqxRX0pX6S
X-Proofpoint-ORIG-GUID: n2fuZUfren8LzqWv7xHgdIJqxRX0pX6S
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfXzsi+iZeg/ly/
 uRPz05W30BKmg/CyzyeU8Vpb1Bgz5dpmCsq3ZT4PHpP14nA/6I2HfU3leoVP37HSGuAhobbZqlL
 zPxlyyQX3JinKczI1dLdihp4PhdER0g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
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

Introduce a defconfig for the Qualcomm IPQ5210 SoC based RDPs.
Presently supports eMMC.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_ipq5210_mmc_defconfig | 113 +++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
new file mode 100644
index 00000000000..56a22ce346a
--- /dev/null
+++ b/configs/qcom_ipq5210_mmc_defconfig
@@ -0,0 +1,113 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_EVENT=y
+CONFIG_TEXT_BASE=0x87980000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq5210-rdp504"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=1024
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_EFI_PARTITION=y
+CONFIG_OF_LIVE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_IPQ5210=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_QCOM_GENI_MINICORE=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+# CONFIG_MMC_SDHCI_ADMA_HELPERS is not set
+# CONFIG_MMC_SDHCI_ADMA is not set
+# CONFIG_MMC_SDHCI_ADMA_FORCE_32BIT is not set
+# CONFIG_MMC_SDHCI_ADMA_64BIT is not set
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_QCOM=y
+CONFIG_RGMII=y
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_IPQ5210=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_SPL=y
+CONFIG_SPL_FRAMEWORK=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_OF_LIBFDT=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SMEM=y
+CONFIG_DM_STATS=y
+CONFIG_SPL_SYS_MALLOC_F=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SYS_MALLOC_DEFAULT_TO_INIT=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80008000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x20000
+# CONFIG_SPL_SEPARATE_BSS is not set
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_TEXT_BASE=0x08c2e000
+CONFIG_SPL_MAX_SIZE=0x3D000
+CONFIG_SPL_MMC=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x00
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SPL_STACKPROTECTOR=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x08cbe000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0x08c2e000
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+CONFIG_SPL_EVENT=y
+CONFIG_SYS_BOARD="ipq5210"
+CONFIG_SPL_REMAKE_ELF=y
+CONFIG_SPL_REMAKE_ELF_LDSCRIPT="board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds"
+CONFIG_QCOM_TMEL_ELF="../tmel-ipq52xx-patch.elf"
+CONFIG_QCOM_GENERATE_MBN=y
+CONFIG_SYSRESET_PSCI=y

-- 
2.34.1

