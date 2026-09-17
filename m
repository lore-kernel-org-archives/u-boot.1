Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF33C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4BA980EFC;
	Thu, 17 Sep 2026 07:47:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j454DhtlrhzT; Thu, 17 Sep 2026 07:47:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EE68E80EEE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631221;
	b=mtZp8rwKymA7AW6zboizyCFFjmIOe2Jn8/iYROVYNUkOv2ijMhHjAhBP+/ca20OOxaOL
	 FXkf7/sLEAmObEcvT5p6XSeMLTC24ZcF4L3EC+tvAAuJuWVK892TUP4hAyLKBuh8vehr0
	 rl+tc5t8VtydA0KuaxiJK0AiGFSMWSwM6PSbmM0MQs3BsJNLfsWIpjS538eTpHpA/I0Iy
	 FbGsXYFKYyB2NWy5HVYdVHNQ3Fny6w0iQk+WLV/PGxfUxoP4BelUNvA7ib6xvb2anL/NL
	 8i3gRhB2CHeYaepHjjqSony6TwtPnHOBFfwGjyaMvVFXZLVu4lVaMyNywEBqSCUN+RA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631221;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
	b=h64fjpMg5mLHlhTuIwn5fCtlpKCCSSc5JssmOrXqQgYS0NAYTgEU5MsGkEnIrk9fg5uz
	 yK1kTZkAW7lojWx+Dvybw5lQ45do59qWjW0KuYbqeXZCFjhL1JW3Rw8rv7AWt0TRQoAlJ
	 ZbbrXCZ+rJBa4PRhAmgOLAAGNwZK6v5hYTl0qim3srne38zKA2OARbGiPYcwZV3+eTc1F
	 FD/dfA3a/jkLNbrA3jTFzl+ER1wOp+NkVwAcKJZJUlV7WGuWa3dt72L+SKY5fnVuyD3hp
	 5Gtk5mWJL3O9mgMCxrCanAHnrM/G0TVv0HBLHaauTDA2xsB1RguY54wkYXbL+pcPZ8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kUAq7BeE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h4q9SrHq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631221;
	bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gDura+nDES0KjbN1mVsgDnK9d+KAzYUVMbPFwZW8iTHH1RH7qBTCIwWTugty6AOiZ
	 +MM6c0e2pHHcR/ibVEMDEtMPy9+2RUkjnRdfVS87U1jUKNAYMGN20TcokmyBtQ0i5I
	 IWFAkHjgmihaY2hxqTUuRxsPhOW8UMhnPLGftistp9td5hFdQC88ivvXHbB/y0/TU9
	 31T9D/JTXpbrnsJRBKiVjZk3kj/05E9vlZM2AMSG3rPRcPKcitDWmTzzobjEqUgItb
	 23KsIEQd7zGXQdGvmI/ey5upZ8uGqNI+hsc4/zSL/Ao0s1FsqfP0blPpyHwgVZ8JVP
	 1u3nWMm97T2AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE68E80EEE;
	Thu, 17 Sep 2026 07:47:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B4FE9422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AC6C80EEE
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bf4Ca1ZuGq-4 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:46:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D99E280EEC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631219;
 b=HjHtlNGI0ZBXR6aXYVhpXhHXnr5eGzrKJmJJ27Bp4lpmVuO2k2OkI3eODuU/VGked70A
 8qSzY4ynrfC48rdpQZA1iUgtvtNL9W3yi/svhvJ81y17gWCu9yE0DfZ8ucFqyev5ss1CI
 O7hDLk9lWDcXhw6ID5cYExVZfI9EZJYqD6RRp5rbnj6tx5XsS9Fv/+hPvVBDNHiO4zMMw
 S1rx9PbUl8Tbhw9o6IPXTIJZ19HcpYcVskluwRDTJTZDchhQwLaQVP6Xoyqk9ocCWPj94
 6FQmcps68ha99F207WB4nNgcORjG+86n7QGKaSKov2OzMY0O27X/28NNRgDQnb99zJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631219;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
 b=ZL14rASJ8XvvcA6dC2de6XwFfsIRJZueOLOL08o61whNP8q6eq4WWXzvYkM1dM5ts9p5
 xWjaLQPySXgCrm6d+xprbdCHgIVU9GKoVBDeibqdaL2YfO3pNmkCO/hhYo/sG1HS0i7E+
 uq/nNHaPhSSBxlspTMIhFiOTxjHFGtkU7yYPfCO91PeZYeuDzyrmedulf3lvv2aZNXGJ4
 52MXrCT1dnGDGuYNkoc68l3sBcTeAtyCyCAnXvPQSEZ3dtg5AzWxEoxDIaFZNr6vvh+2s
 a1BWADPQArqkig9+Gwe2M33fx9VOuDNMBCVEeJxzZN7LLSiR0+Wq8shO85aYNf/ZUmg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=kUAq7BeE; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h4q9SrHq; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kUAq7BeE; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=h4q9SrHq
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D99E280EEC
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:58 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60GpT1924331
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=; b=kUAq7BeEZA3ZE/4k
 fPF06iuJ8rgtJLRpRkT2Y0yih+C59sxoDgS+x/b0Qln5DjdfB0VItDy0UfI1FQz0
 ZyLBuVI/i2e/HBJPxXr87F1syey3rEDmW6O3R3iz76BDc/iUlJkFPhOTQd1j4w+l
 oFAw1agdNe0h2+utVpxphuCfrKNZt3NgjvnGs2slVuByEJc2acYwL6s37SlEMVKi
 SeCEzWm88kHNaUBsSYY4cFbQ+NV3eJ82NaPSSK+F5HS8TM8GCK/iHkaGa+zMQN7u
 51kGlJQkMc3Mg8kq777q05pkQgG0+RY1Tr5Ps72lYMy8NHBK7JIT3+riADrz60dC
 WyDZTA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxw8u95w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39e3c10ac70so1038553a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631217; x=1790236017;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
 b=h4q9SrHqn6bonCJ+i0XkIZFccZzA3ojCP9vroJQB9y9VCN4390IU/KiyMGu/Cql4WN
 nE2cdCMc62e8SkxNyhZjXzeYLmxNMjrL4nypJvOc78Sp+wHmd9ILy3AxVs9ulWPs3fZm
 7VSp1Ggejydlg/w5gR47LSNPI/oUWrGnMlWg9KD4eV5jjE8w99t9FOMquZdrm37EUv0M
 zOn2Daww37vGOLnVBO4H9BXZuyT4ji1IbQhVb9IL/wxrsFXvpbSbZ40nbCSSBFV9x08L
 GR5pdvCa6S6loFgJPE/6jk43ZCEWwMNcfbSZuYh7Wnim1EaBI8x66MPMhOP44ATaoVQ9
 XtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631217; x=1790236017;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HneFoMjWe+UdxJOBS5yqzyCGmXvCO1wZ+jeZvx320jc=;
 b=c3SghJYTODni+lWqGRxO/+l89WrpZ7c9CqRlFAR6OujSYLBjBduUn14r73mRJYzYgY
 pe6xbxWybX1Ypki+/Rm2wPBuvZU0/7W7l9U9JgPyAs6clsHwD4BsmldtS/8J9J6XCNgB
 ZJtEC0gO40tuoYzId+WqXmzyoDgOwa0nzcIgWMH87B9pvT0hWn70FdFdVf4ApSAkFzO0
 ee4ZnMT4dDVE5s2W6kFRiQ9I0l75xObY4IosF8nmf3OjSDB0HFdtWhsd/dI2xoAHoZyq
 MiJdsMQg67JqY0KfZlv2M41pOzZ2M9h9mBCLNjmm20bUb59VXJdS1p30M6goJrzMm7Il
 Wv3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHq6SmegDB4bhcLsOYfSDV1aqV9o3B5rlco+LZmVkewtfnBpxpyu7AfDHRlKPiakHZZr8SjQE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mpZ6KI5DcUVuOLbEMHjVhexL60Ss98tE2eJuidRQdGANVUFtHI
 XA7J8gnJ2tl+P5geFEXx6NWcCK2/YQocaFIpwDQaYwDqzNaVyfYbca3qOfq9t5hT25Wj39JVIoq
 BL7601h5jcVFWYYpxWY/rPbIx9UrU2ua9Oua1CxElDlzhrN+09UhkcQYZon4PpiAFkXtZCnA=
X-Gm-Gg: AYBFou2d5TckNGsiCeY7m9ry+QJAdo4vjUoC1Nrpbkulv1/HbkUCxhDXI9ypE4PaRfk
 3MK/Rt8Wiq4Ik4B8Cgq1lXsvvT7009OEMevtoxLDBm0x13iulF6ROm7GleK5X28UJQYFSs0lqNC
 d6L7liNuhpKGPG/UP6VzSZ8CQlhSOWTVHFQeth2nOkLMaFu1wrrerE9HrxLvRuj5FM8rXBIVoB4
 bLPmrPzlKOjIifxvpLXG3WDBzqdEjUYj3SNU6zXoyITWmaMIsmzugEkrKmqUbKPIooglX93mfQi
 MuM9G6KCdzt/maL1ZE0HACh1Z+mBn8hDoItNOwB7KBVtn/xckrXXE5rb27oSJ9x3rawJ9tn9Tgm
 MKkFsSmmM5U+t51sNMzhVety36HC1r6fs+3V0ZbAyDch29iodfmYfW94acm0M5U2svPcih5aJJk
 aq0xyq41ZwNMi+ZqW5jHugY4MkHf/scQ==
X-Received: by 2002:a17:90b:582b:b0:39e:f1:b2de with SMTP id
 98e67ed59e1d1-39e1e4c54fcmr13632438a91.20.1789631216813; 
 Thu, 17 Sep 2026 00:46:56 -0700 (PDT)
X-Received: by 2002:a17:90b:582b:b0:39e:f1:b2de with SMTP id
 98e67ed59e1d1-39e1e4c54fcmr13632353a91.20.1789631216041; 
 Thu, 17 Sep 2026 00:46:56 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:46:55 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:36 +0530
Subject: [PATCH v10 07/15] mach-snapdragon: spl: Load next stage FIT image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-7-3e83dcd239f0@oss.qualcomm.com>
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
X-Proofpoint-GUID: WLK-E6M8adaadNxHUC-S9W89c4wplapX
X-Authority-Analysis: v=2.4 cv=bY3+w+PB c=1 sm=1 tr=0 ts=6aab9af1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=6bbauyjUkyUOPZ0J5qkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX0BAoRAuj+Td9
 Awk5Zl+SLFbU5KL7NqSzD10VYXeEKjob7ozLpFm+dBAe5cFep6EXxHVJYuhpHFnTm/H79KQZ4ef
 F3SafVO9KE7Lq+EYYx2ezOZ6d0eOkjU=
X-Proofpoint-ORIG-GUID: WLK-E6M8adaadNxHUC-S9W89c4wplapX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX+ia0Rw6AFMaO
 0Gud0TDl0vIkQJ9vEtxMMVjYptweF2lHc6gO1GWCf9d3JxZcvLTr+QQnf08dlquO5Vg0zjWZml6
 Tt1YJZNuwRSUF5hASWCOdly1bRiyJ7iXpgpcipdpIghR6g3ERdDg3Nhx8fzxTJ9Y/tZELWEeikX
 A6NUYivSaGOEzA3h2D/h7oV3MT0Af0Z0JqaX7sh6YiWYBiVIkNEcWRKQTayZObrVK/izJ9roTYg
 nkiS2KPJRuk7KMGrDhf/88+EGOC6KaiKx1HKSlNzoEzYz8JFM/qJEVQF4nWHx6oldVO8gnLMlIs
 il/2h6akfv1IWJlkTJ4M4ZiuuAm2azy37aNslz/QDBMLzltpJl99jPaSWRNDUDoWEw2VKY9ASxd
 H0oYG6itQJ2273xhwHsUPbvf9CYEj49N/l6h4Z1TO3xcWErZTVT9NVUi6dssanGdw0quIRAoFfY
 C+Py48E/fHHdl+/dsRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
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

Identify the boot media loader driver and load the FIT image that has the
binaries to initialize the DDR, U-Boot proper etc.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 155 ++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 2445ae8b17d..2655803b31e 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -5,12 +5,15 @@
  * Copyright (c) 2026 Michael Srba <Michael.Srba@seznam.cz>
  */
 
+#include <asm/sections.h>
 #include <hang.h>
+#include <init.h>
+#include <mach/qclib.h>
 #include <spl.h>
 #include <soc/qcom/smem.h>
 
 /* in SPL, we always use internal DT */
-int board_fdt_blob_setup(void **fdtp)
+int __weak board_fdt_blob_setup(void **fdtp)
 {
 	return -EEXIST;
 }
@@ -86,7 +89,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
  *
  * Return: Partition number to boot from, or default partition on error
  */
-int spl_mmc_boot_partition(const u32 boot_device)
+int __weak spl_mmc_boot_partition(const u32 boot_device)
 {
 	int p_no;
 	struct blk_desc *desc;
@@ -120,3 +123,151 @@ unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
 	return 0;
 }
 #endif /* CONFIG_IS_ENABLED(MMC) */
+
+void qcom_spl_malloc_init_f(void)
+{
+	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
+		return;
+	/*
+	 * Set up by crt0.S
+	 */
+	assert(gd->malloc_base);
+	gd->malloc_limit = CONFIG_VAL(SYS_MALLOC_F_LEN);
+	gd->malloc_ptr = 0;
+
+	mem_malloc_init(gd->malloc_base, gd->malloc_limit);
+	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
+}
+
+/**
+ * spl_get_load_buffer() - Allocate a cache-aligned buffer for image loading.
+ * @offset:	Offset (unused, typically 0 for SPL).
+ * @size:	Size of the buffer to allocate.
+ *
+ * Return: Pointer to the allocated buffer, or NULL on failure.
+ */
+struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
+{
+#ifdef CONFIG_SPL_LOAD_FIT_ADDRESS
+	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+#else
+	return NULL;
+#endif
+}
+
+/**
+ * board_spl_fit_buffer_addr() - Get the address of the FIT image buffer.
+ * @fit_size:	Size of the FIT image.
+ * @sectors:	Number of sectors.
+ * @bl_len:	Block length.
+ *
+ * Return: Address of the FIT image buffer.
+ */
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	return spl_get_load_buffer(0, sectors * bl_len);
+}
+
+/**
+ * qcom_spl_loader_pre_ddr() - SPL loader for pre-DDR stage.
+ * @boot_device: Type of boot device.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_loader_pre_ddr(u8 boot_device)
+{
+	struct spl_image_loader *loader, *drv;
+	struct spl_image_info spl_image = { 0 };
+	struct spl_boot_device boot_dev = { .boot_device = boot_device, };
+	int ret = -ENODEV, n_ents;
+
+	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
+	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
+
+	for (loader = drv; loader && (loader != drv + n_ents); loader++) {
+		if (boot_device != loader->boot_device)
+			continue;
+
+		ret = loader->load_image(&spl_image, &boot_dev);
+		if (!ret)
+			break;
+
+		printf("%s: Error: %d\n", __func__, ret);
+	}
+
+	return ret;
+}
+
+/**
+ * board_fit_config_name_match() - Select the FIT config for the current
+ *				   boot stage.
+ * @name:	Candidate FIT config name.
+ *
+ * Generic default: match "pre-ddr" before DRAM is up, "post-ddr" after.
+ * A SoC with additional/different FIT configs should provide a strong
+ * override.
+ *
+ * Return: 0 on match, -EINVAL otherwise.
+ */
+int __weak board_fit_config_name_match(const char *name)
+{
+	if (!(gd->flags & GD_FLG_SPL_INIT)) {
+		if (!strcmp(name, "pre-ddr")) {
+			printf("Selected FIT Config: %s\n", name);
+			return 0;
+		}
+	} else {
+		if (!strcmp(name, "post-ddr")) {
+			printf("Selected FIT Config: %s\n", name);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * board_init_f() - Generic SPL entry point.
+ * @dummy:	Unused.
+ *
+ * Generic default: clear BSS, set up malloc, run early init, load the
+ * pre-DDR image and invoke QCLIB when booting from PBL, then hand off to
+ * board_init_r(). A SoC with additional bring-up steps should provide a
+ * strong override.
+ */
+void __weak board_init_f(ulong dummy)
+{
+	int ret = 0;
+
+	memset(__bss_start, 0, __bss_end - __bss_start); /* Clear BSS */
+
+	qcom_spl_malloc_init_f();
+
+	ret = spl_early_init();
+	if (ret) {
+		pr_debug("spl_early_init() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	event_notify_null(EVT_LAST_STAGE_INIT);
+
+	preloader_console_init();
+
+	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
+	if (ret) {
+		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = qcom_spl_invoke_qclib();
+	if (ret) {
+		pr_debug("qcom_spl_invoke_qclib() failed (%d)\n", ret);
+		goto fail;
+	}
+
+	board_init_r(NULL, 0);
+
+fail:
+	if (ret)
+		reset_cpu();
+}

-- 
2.34.1

