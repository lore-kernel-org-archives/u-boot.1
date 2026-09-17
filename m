Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88049C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46C7D802E8;
	Thu, 17 Sep 2026 07:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pux6SxHOl75Q; Thu, 17 Sep 2026 07:46:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4DB3C80ED8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631183;
	b=gZvbvtKpCsspm5yqA7Q6TmYfInjt1cE7nDGeY4Ich3YXSr6Xx1JTDy3mWZHzHNMt1/NS
	 /XMcSxy+kH1d6Ee0AqxUkaTmavUr9RPzQ00U1WPLNTGF+751zE55OHONmmJkJpCKz3owC
	 4CunD6NarKUwQR96nWhswWCl6GTXnOU3couccyumiFvi2mKlDSyK8FqCnXYNrpMr+CMYk
	 TqNgpFOBqcISTxTIUQDcNOCcjvqp6DLD97AVG1VYKwF8EuwTGjMBzyICMQzKSC7L4y++8
	 OFBBILizloyXPOpBhtxOeqzanE16HcV9x1dP2sPHm8dw3lScECXlamN2IIiLUaCITvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631183;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
	b=b0GBuXkC3ypz9JWg4MFe++L+0O4s3Ynfub4rFUmmgCweWE4FuctgGxtz4qi9APLSvKdi
	 ljtRFKdLldg2ghJA6LNrge3VupF/LUZE3OvT2zxKTEIbX7HzoypbvW6pP1Rr6POYEGp5k
	 NfUnQ8Iv/GOVByiEwlmNFn4eYNsgo9ZKr1s9Mtovu1DZ/H2XkdyfriPuB4scJT7lR4Uf5
	 aylfTO4Wg3ThmRpzcBtfS7YR5OWEL9x7JeosXDFyjDfjDPtGYbYd+Zw3jbh0a2Q+G00nn
	 qZVqqnG8ZO/BUC8a+lUZD1A/9uoM8bRjPUuvnmWnw6sHe5HO1BnpiowM2BAByBlHr7w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631183;
	bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lar2ydBTMEVo1MbZX3bgzri/DKUVS48pbKBHYsXGJBqvdNsHvN2pxBay5uwYGhsVj
	 mOTyo4lVxcR2ESC34Z6Jv5xAodLfyEvdFml6Bl4KFVt40tjKxnUgxf7KiFqdFuhSRk
	 +5aTpT5d8NRJT6oBXL0YKJSWvhKlG2/k17D1P9s7s2LuaEoSj7Yw+yYn3YF+eTyAhM
	 +FB5kOYgnMtp8czNk5jLOw42zvoaHig6fxRzdF6++qzpgIhJcSBDNqozk6W3Y5hNvz
	 q6Abjdx5qe6J5uhbeIz+r5KH3ucTrqG5uUttuPHUeZmjbRevAOAwEj1weZrk8Oce7W
	 XJ2NkRxGEZRjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DB3C80ED8;
	Thu, 17 Sep 2026 07:46:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2C5129B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 990526075A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mzb0snDxcWKd for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:46:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B9F9860604
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631181;
 b=kDEK/YJIZmeEf5eO5iZxKfrMtBQ+Oow28xvA4afgLOCE4f4UKFn1URdzwZbM5+v/CwNa
 GeTzmqJNbLt6FMyzVM3C0s73RRY1dfllJOa0KA2aYkhGdBBICwZ6e+OYMtQ55W3l/1Ofh
 C2XpcB7BWAj9BtS9UEgiMdIBLJTfoPra6XTSFn6IQJzPYhsCgghmBAKgLy4ZXIqRcON7O
 EEegML8qzeQpWXxcUF+ZmCFQ5hysmgrZP+vxJy14/RGoX17b8vCCSheomfZ/Rq1YSWxW+
 aaayfTUF+oTmKfBenU5alwJz7VLt0TrpTBJKFK2yZF74cB1W6vvNucb54N9dXEKH4XQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631181;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
 b=AA+oiK3UKVIvZBcmZPPSuYQ2J+FpmnYYV7DiYbl/E62HScujc2KGAM7Qcf+SxIKCY3aa
 NjFgn9zlJFPc/d7OcZoqjFRbVnNFv6iKiPr0is/XJRb5UyOyh+7ZgbUEtdiJiVJXU+yw+
 3erSqmEAoS4b+pfYmhIUyoh545JUIMQr5j9Gu5fZEr0MoF2vlkC7MKZRVnwipZNizzgWX
 Q/dhhzQGRLBehbcbwTMD4Yw9v3YNXlz0n2Jbb0IO4pmoPJapuWGMxV8UR0zBpGrNA/OPy
 Z0URd10Wk7QUdCSsIrzhyKYnzh0CTODH28CfKqUAg4vilzshHhc+2xu3rGnEZUohVnw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EEfZmIzz; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ejnoy0Ug; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EEfZmIzz; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ejnoy0Ug
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9F9860604
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:19 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60Vcu1211749
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=; b=EEfZmIzz8iB1VQq0
 sHHHIURdzBZ5DymJi0ngE1wVpz1iPszNrvoZVIFkb9BUSRVEU9CzktjjJsE9C8qI
 Pn+qbsNIkTQ/0hvcPy+R5sUsz1cQ9cJv7h3Odp8/gaN7nhN8YIhkUMSG0WaRCVAQ
 iYrtHCAXZjtTtqpXfizz9v3JnJz6bxTxqnVcwh5YIzgzsfsEsRIUuKqGmSARieJy
 R3AUH4GvrXi3aJwn8CcLqThoci4Y59rMSdIjWkr8+vNjUI7zlKguEN/kjaPcQsz6
 R8b/jv3wBi0DUKipWG0EYWNmTeSrKENH3qlngaspjHk438kAUzFxV9xamofPfb/9
 egBwwA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxaybcvn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso536914a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631178; x=1790235978;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
 b=ejnoy0UgDdWJwkCBKUvuCyp2vg9sjWM/TFCLZtEgeatdSy9wZyUi8RCHPHwjyp7eDu
 uCBBSxqhgdON6QOmCNATLURtKsy4P6AYNeQcgY51uR7sBShYJ8xSZS+dLJ2U9SdQeht7
 KB3LflhT3Z2cn4cvEi6mz0QFtPvhRaxFHOB8Vpd8nIRE8qjFLrxRZzuJzal0cdegUxf4
 KP94ckmX5c+2LhcsYGxdnbU5Iz2M2ArkKNCjXjCiIgB3he8wioUff3gHqKfP1A9lccWk
 8mIaztiA0Yi29phLQiE/5sXnu8cnxPHt69UEnubu2sHi3xlXOu4xsm6g/eCvuu4hiyWR
 xb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631178; x=1790235978;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8zo5cP4A1XWyfwBKa2vn8PCt0VnJQWeRaSw831ccD6U=;
 b=BHmIO/wYXOD7img2y1diOcKYtE6wZ/an4Q7uJ6myneX9o3iDvVylTCB0bXdbPYGHq1
 cVQa9VWS4yuFh7RYSt5zql4EWfAnxaEdtVLdgW7oI3Nj/9l0hIrOs5nwZNfSwklHEcQu
 GleOhHMqCAEz0yJ/Z4PALHL3u8ATGrJf4mnl5niX+k73rYOKO4rpvX0aJgXAur4wikzd
 qXpR5KbkuqAYJWdnkcIiFJL8l1jLLQL5z/X4jo9FPuO1Myj/NZMlJeyGIMJP1pksZFSi
 M213+p2irotHbh5Pwue12h5gUpUqZ31rP0Z1TFLuFX60JR37ykAPZXBzOp5VX4TD4Wf8
 wgAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMrSU7fewNgkwAS4GGkMel0zl1HI+FcXKVgHWIk2VBAODhpscMI38RtfzpCfKbWwfpPJhA+gM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nsfrOurG9W6C0y9JsjAYo+EApwC/d8SqNo2XYkEFtn0q4qObWM
 gbF08UO0TF+JhPNWohfokbYzxD63QQVwrGiwUTF3XiyTSpMGNUZdpjEd9qaPKDcdjdZfM/fV4cc
 u5CaW/KZOiuLk7752NzwtrY+0y+FKbOtAJjzBwwd5qF0LcdmdnRAfZ/P/C4CeV9js9UUsuUo=
X-Gm-Gg: AYBFou2LBtLOekabC4b+cVkFaxaWyhNug3EgqNWSMzRIVQv9xgI5oB9G9IKpHVHjztL
 bKeov1SmadNC/JPrPBi6U4/QGNV74o0IhhmGfmXV37bcZR2E/Xb5JUHtsuFdI9qde09kJL9+x4g
 OjA+xE1R7Y+Djl5z3VzSKjMtUPlBqY58/fnl4YA1u8wAHva7Ws+ExOplbI0EYpQpiVf6OnV6ewn
 jT+IxBJZXKLApdvS6rnDLIT4G6uCMfO39f9nNFTBIxGHbB4lqf9a0mjp3lbWLpOIbZ8EnEfFWgx
 5y73Su5Qkv+nmJdDuZ0s77/CGaG3Z89yi82p+R3Sg/lGaIZL6y0tZcdETixziieQRvW2YiT+8+q
 LOzfEsubDZp4QJYKSDnQZJkTATQjyMIdb9jHXjBIveYbK+oNjn6OGClHj6Q6quE8sfPAP1Fv8vf
 NNH+2tDbFh1CfWcR9y7uyKXZn1CLTO7g==
X-Received: by 2002:a05:6a20:db90:b0:3dd:5688:5ab3 with SMTP id
 adf61e73a8af0-3dd5f451c33mr16728328637.8.1789631177643; 
 Thu, 17 Sep 2026 00:46:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:db90:b0:3dd:5688:5ab3 with SMTP id
 adf61e73a8af0-3dd5f451c33mr16728276637.8.1789631177194; 
 Thu, 17 Sep 2026 00:46:17 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:46:16 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:32 +0530
Subject: [PATCH v10 03/15] mach-snapdragon: Add PBL shared data defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-3-3e83dcd239f0@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX+z5WH1qK4ZaI
 WrnPlHu6eaMFV5+nFJXzYYlsl3KcMvD6LX/y+bZGT39+pb1ewCbjbcph++5/IAkrGyuF8xustim
 x7hl3Q1jXwU0Bcs8P3Nk/sGEE8JWmUs9vfYYW04mtQDHveQVpyoINiIK3VnSCIy0fATh4NNoBM1
 W/vwzDcryPkJfGG5WoW83KWs2SC5t6fLyXtLYrP1DWpWbUmoUNqTGPkIncQ8F5tOdGTX/HTg3v4
 iTo1Z7NefnidoXHjIHVpbIUyzakAkcvj1vAP3hv7cvw+qS9Mzxnl0JSNx5MH5/9mcJvYAsygWCn
 QAoAF1Bhmel8iAfJEFsqlwPug96pQgqsSPQC0I/h5NbqIXtq2K0QWYf0Bnmj+jt6+h6jTtmiQI/
 mrmbOQavihxKz/ocXSW7WZAONlGt6Qab2Ftc7i8Y9DmKtAM9PQCHIw7w8GkytuwxPDyIv4tBHjL
 Kk5NbE61y8aUlAx4frg==
X-Proofpoint-GUID: rlw49B3fFsLvoZEQqCtU3u-xV8TBqg7k
X-Authority-Analysis: v=2.4 cv=EoJHPicA c=1 sm=1 tr=0 ts=6aab9aca cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=17UMeyZtP49W_7ZR7MkA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: rlw49B3fFsLvoZEQqCtU3u-xV8TBqg7k
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX9F5JlKWcaTzn
 1g8H54kVkbhxqk6ypj2674WgAMS//uMLc1IB7cHmGZNlNEwP2QTB7jx2FaNhbeLR+SY1Ur/ixbA
 yO1NdZ/ax/UO7oIsJmDVAql7gyroTv0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170104
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

Add structure and enum definitions to be able to parse the information
that is passed from PBL. This will be used to identify the boot medium.

Since the PBL shared data defines are private, move spl_boot_device() from
board_spl.c to pbl-shared-data.c to parse the shared data and identify the
boot medium

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile          |   1 +
 arch/arm/mach-snapdragon/board_spl.c       |   9 +--
 arch/arm/mach-snapdragon/pbl-shared-data.c | 125 +++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 2360b7c658e..4f2f35cb9de 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -7,6 +7,7 @@ obj-y += mem_map.o
 
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-y += board_spl.o
+obj-y += pbl-shared-data.o
 else
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index d69f3e8aafe..41d8789a002 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -7,6 +7,7 @@
 
 #include <hang.h>
 #include <spl.h>
+#include <soc/qcom/smem.h>
 
 /* in SPL, we always use internal DT */
 int board_fdt_blob_setup(void **fdtp)
@@ -20,11 +21,3 @@ __weak void reset_cpu(void)
 	printf("reset_cpu called, going to hang()\n");
 	hang();
 }
-
-u32 spl_boot_device(void)
-{
-	/* TODO: check boot reason to support UFS and sdcard */
-	u32 boot_device = BOOT_DEVICE_DFU;
-
-	return boot_device;
-}
diff --git a/arch/arm/mach-snapdragon/pbl-shared-data.c b/arch/arm/mach-snapdragon/pbl-shared-data.c
new file mode 100644
index 00000000000..b9dce22c417
--- /dev/null
+++ b/arch/arm/mach-snapdragon/pbl-shared-data.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/system.h>
+#include <spl.h>
+
+enum pbl_shared_data_param_id {
+	PSD_ID_PBL_FW_VERSION			= 0x0,	/* PBL firmware version */
+	PSD_ID_PBL_PATCH_VERSION		= 0x1,	/* Patch version */
+	PSD_ID_RMB_MBOX_BASE_ADDR		= 0x2,	/* Not used */
+	PSD_ID_CPU_BOOT_SPEED_HZ		= 0x3,	/* CPU boot speed (Hz) */
+	PSD_ID_BOOT_MEDIA_TYPE			= 0x4,	/* Boot media type */
+	PSD_ID_IS_EDL_MODE			= 0x5,	/* Emergency Download mode */
+	PSD_ID_DEV_PROG_ELF_ENTRY_ADDR		= 0x6,	/* Not used */
+	PSD_ID_XBL_CONFIG_ELF_ENTRY_ADDR	= 0x7,	/* Not used */
+	PSD_ID_XBL_SC_EXT_ELF_ENTRY_ADDR	= 0x8,	/* Not used */
+	PSD_ID_PBL_TIMESTAMPS_BUFFER_ADDR	= 0x9,	/* PBL logs address */
+	PSD_ID_PBL_TIMESTAMPS_BUFFER_SIZE	= 0xa,	/* PBL log size */
+	PSD_ID_PBL_DEBUG_SHARED_INFO_ADDR	= 0xb,	/* Debug info address */
+	PSD_ID_PBL_DEBUG_SHARED_INFO_SIZE	= 0xc,	/* Debug info size */
+	PSD_ID_TME_CPU_PBL_ROM_BYPASS_FUSE	= 0xd,	/* Secure boot status */
+	PSD_ID_XBL_SC_DEBUG_LOG_ADDR		= 0xe,	/* XBL SC debug log address */
+	PSD_ID_XBL_SC_DEBUG_LOG_SIZE		= 0xf,	/* XBL SC debug log size */
+	PSD_ID_CURRENT_IMAGE_SET		= 0x10,	/* Booted image set */
+	PSD_ID_MEDIA_DATA_INFO_ADDR		= 0x11,	/* Media info pointer */
+	PSD_ID_MEDIA_DATA_INFO_SIZE		= 0x12,	/* Media info size */
+	PBL_SHARED_DATA_PARAM_MAX,
+};
+
+enum pbl_boot_flash_type {
+	PSD_NO_FLASH		= 0,
+	PSD_NOR_FLASH		= 1,
+	PSD_NAND_FLASH		= 2,
+	PSD_ONENAND_FLASH	= 3,
+	PSD_SDC_FLASH		= 4,
+	PSD_MMC_FLASH		= 5,
+	PSD_SPI_FLASH		= 6,
+	PSD_PCIE_FLASH		= 7,
+	PSD_UFS_FLASH		= 8,
+	PSD_RSVD_1_FLASH	= 9,
+	PSD_USB_FLASH		= 10,
+	PSD_SPI_NAND_FLASH	= 11,
+	PSD_SPI_FLASH_GPT	= 12,
+};
+
+enum pbl_shared_data_version {
+	PSD_VERSION_1		= 0x00010000, // IPQ 5332, 9574
+	PSD_VERSION_2		= 0x00020000, // IPQ 5210, 5424, 5610, 9650
+};
+
+struct pbl_shared_data_entry {
+	u32 param_id;
+	ulong value;
+	bool valid;
+};
+
+struct pbl_shared_data {
+	u32 version;
+	u32 num_of_entries;
+	struct pbl_shared_data_entry entry[PBL_SHARED_DATA_PARAM_MAX];
+};
+
+static struct pbl_shared_data g_psd __section(".data");
+
+void save_boot_params(ulong r0, ulong r1, ulong r2, ulong r3)
+{
+	unsigned long sctlr;
+	struct pbl_shared_data *psd;
+
+	sctlr = get_sctlr();
+	set_sctlr(sctlr & ~(CR_M));	/* Disable MMU */
+
+	psd = (struct pbl_shared_data *)r0;
+
+	if (!psd || psd->num_of_entries < PBL_SHARED_DATA_PARAM_MAX ||
+	     psd->version != PSD_VERSION_2)
+		goto out;
+
+	memcpy(&g_psd, psd, sizeof(g_psd));
+
+out:
+	save_boot_params_ret();
+}
+
+u32 __weak spl_boot_device(void)
+{
+	struct pbl_shared_data *psd = &g_psd;
+
+#ifdef DEBUG
+	for (int i  = 0; psd && i < psd->num_of_entries; i++) {
+		printf("entry[0x%x] = %d 0x%08x %d\n", i,
+		       psd->entry[i].param_id, psd->entry[i].value,
+		       psd->entry[i].valid);
+	}
+#endif
+	if (psd->version != PSD_VERSION_2) {
+		pr_err("Unknown PBL shared data version\n");
+		goto out;
+	}
+
+	if (psd->entry[PSD_ID_IS_EDL_MODE].valid &&
+	    psd->entry[PSD_ID_IS_EDL_MODE].value) {
+		printf("Selected boot device: DFU\n");
+		return BOOT_DEVICE_DFU;
+	}
+
+	if (psd->entry[PSD_ID_BOOT_MEDIA_TYPE].valid) {
+		switch (psd->entry[PSD_ID_BOOT_MEDIA_TYPE].value) {
+		case PSD_MMC_FLASH:
+			printf("Selected boot device: MMC\n");
+			return BOOT_DEVICE_MMC1;
+		case PSD_NOR_FLASH:
+			printf("Selected boot device: NOR\n");
+			return BOOT_DEVICE_NOR;
+		case PSD_NAND_FLASH:
+			printf("Selected boot device: NAND\n");
+			return BOOT_DEVICE_NAND;
+		case PSD_UFS_FLASH:
+			printf("Selected boot device: UFS\n");
+			return BOOT_DEVICE_UFS;
+		}
+	}
+
+out:
+	pr_err("No boot device configured\n");
+	return BOOT_DEVICE_NONE;
+}

-- 
2.34.1

