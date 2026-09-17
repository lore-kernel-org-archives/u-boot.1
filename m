Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D2FC982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA0B360848;
	Thu, 17 Sep 2026 07:46:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r00ntf80jzPa; Thu, 17 Sep 2026 07:46:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CD85E60659
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631200;
	b=WYskoXyyFyQkbaE7qi7RI1HX3JjQ7QJU1M01dPQPFfElu/zZr98Z0KRsGNnVEDP/wqEx
	 8a5uE+tfD1Zb9xEwbVCC1/paTsqwfinsOV/7gruDuJHmPoAs9DrmtIv6p2YGJ3TzR5yaD
	 U72X2kp4powPgdZ46olsNTUaflDN24YHQN6wFJLDlNwaiFky/j3TrS4iXcWXpm6GHP51n
	 LASzuzERRqQgBiKghgBac1mgxrKslC4fxgxOuwi+WIqBjy5rytpwKXY9izCAXUinGjgFy
	 O9NoMR46MFKGuXE3bZYAvQdYezKVFbbu0FXwe3tHwlL8IWgm2nc+aQPGTiU/fBV9Q2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
	b=MLt80CYx+K7RF7XmLqfvaT00B+49Fl9ECQnnEOV96crPjilbJ/fzWPtEWekufBtYbeWo
	 fkY7gQnxmZEIG8+a/LEG4CXxwZdRBBA1p7vQjs850zI/xnA4r6squCQBI2R1J7/ai7KtP
	 oFYYhEOk6aOdc9eLPLAYgRkR2SszhpAzwzs5lFITstbY8px8Y2gMmPWYe9uBPb+nyAwAq
	 AWb92agDztsQvZurztvDxoebhkMkrgT2MAk6+B5SpyACgsxaSisyVLPRv10qx97z2/hPY
	 BfZc8oG31JY2KERg0ZAGlh06Ph7jbBESFknUhYTFisKXi1B34mgtiLqXVUKch+a307w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631199;
	bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pxu5fM0bVLHnLvBmeFvZ1m6k+XAwGkv3/ehRh+iZdlg2D/N3ld8MoC9VZy9emtW+0
	 QyngEIGuENNYcUVX6c1ND1DacGpq9KJYOIID1cpGZvyR13kGOTD05LY0/qGuWevOLk
	 JTRuahpXhYKMNxu9EUmbKxQEn0xOBHue+rgKO/9DNzRZ95Ln/Q6j1CCq5s4g0dmcYl
	 3NvN9tXWXHGDpIgk7teqlmuCuvJV2t6UCJvZUSZn+wSAWS4q/Er+Lq1UfO0CbPL7YV
	 vL73mWkUAYzNIvggCbWKLQqnK6oiAWuif7+Hm4qHgIeSnTMXi25IUFc1YAuVkLgH8A
	 eEeDW8MELN+aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD85E60659;
	Thu, 17 Sep 2026 07:46:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12168422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F57F407A0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3l6xwaUMq_m6 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:46:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5CA8D4079D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631198;
 b=PGQ9cgEPx3Fyn3mHlB8KfNKW45yGZId5AxY2YTRTsShihYLNjWCteYD3hmkHgjY4NBet
 8U4EGEOgmd5qPU/b6OQLAjMz9x5ETm8Pxx4uAeGKHI2L4Wr7a5IZnFp4KdtHejznQ3esw
 Rjm1hQdb+4i12NPQJi3g4cWzV39ZNTUp0tGGZiAZeuX/ulH9luOY01QLokDcJ/izIyAo3
 WDjzXMQ8p0H203099ACPj0HEG776oyh0APPwmgaICOVKo3zTmlaOrwIRH/+Thq5+1vhFp
 Xz87C/KFNOr1AXn9lZy9g0p/192xJlSYP9dvsQXd+kvMkNKHlrg/hSChp+5o2Yw3OZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631198;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
 b=B7aALpu5JWgCe6xAQwRgm54clt3GYuBvsXSMRMmdjeeleHIXn5mnvFJf6zYEh3bKHjC2
 oLSgLkqPuVz2Xu5EoMznH5oIlxdrgdalDfHjSpgNoZZ5pIhbFfuyX083ObPvm6MbepeXV
 fj4leNMN2OAovWadOcOpVkuXcCJ8Un+yxzICSnnmI9fPADDyVzHRK9cgPngd58b7IX8kw
 JFXpF5Ojjf8O9zcIuE45L3TJctkygbA1hcjQVwTEYhMmYo+6FJzt4L77iuyRNC4xlFUTu
 vkR3IXyzwefi9q8fY93sUrMEjy+bwMz4YtoLZIoWn+qL2YWu9Uqa4svOI425S+Oh4HQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hSzPamBG; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KOZiRJuT; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hSzPamBG; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KOZiRJuT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5CA8D4079D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:38 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60AoT091772
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=; b=hSzPamBGgPScTbfi
 6kwdbBl16mOchLH0l1UjbUIZQ03FE22zLoCsTZ1e6oFWBPUP4HdGfqR0J+r7pOK7
 KDvZXY3XrI0fmTyMLmlG2oPaWFq7joKKdHPzozHqrbTRi6R3hbBgU7YtN+HdzmyL
 MrZjvaaHPC/hYSKk21cHK9a5Jy5lPjuzsIA0Gq6VBDU7Rkn84LxQYtQoJNeugpli
 CgtJNTsMOczzPMnHaQBVWxnL/Rl0fKZBAfiovMUjERAZzULHLPvgUGDIAOtlUPRD
 ZcIj7T8Rg7YwZQHuPSfFhr8s94ziffZnwVSdL+EaZokzMg3fH0EmHHcXOnA3dtAj
 WTigyg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw0sk4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:46:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2dd7d0751efso6864655ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631197; x=1790235997;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
 b=KOZiRJuT8hLtxhJOGud4vcZKAFsoLig1+/hkKPIzqSHWPN9U69s9giDm1lgWzpExWh
 s5cA2u6IiFyl2XedyOf9y0iDHXweyJP5Etr+yyvNLNWjtjNOX4b6kvVOeFUWMvGvHc/z
 P3lIglIFLSEzSXydyDXXuz6tio7C7RSGslHVDszX7wimO7cakfUifAwtk1v2dckjCGBJ
 MBsmY0U7+W7NA5Jk29AFOBJZiDZJuHdFJjKxyaHpseOV4O9Jgy8dEv8BFV+A7zpBgdrn
 PGB3UtcgAPYYd9v4fy7bYfXv1qAKLgwlDDz9oiXqKhyspPedWNI3F09he9Mk+aRGtqDH
 FDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631197; x=1790235997;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YvFHSmfV9UtWRfvqJQmOBRLirVFtmMjN6llWkJ422sk=;
 b=Dzx5z9zvHjNp1vtNYHL6oyNZXZ1hqpEGcyinXRTnbBrYtTooQWgeLrfOMyyvQAE8du
 JDHFi6jsjUiAg4TqQExu6PBHz5532nLpyRxHcezTrK6+210/okJbPsgVcdGl8JeajJ37
 /OLg6qQIY34eTSqleO3nzcUnuLZqg+qmWDkAX1Ha7RSqF9Nh2nVy7pU8dxQxlvEYnyK/
 338/AKwLu0dXfLc2vnO9ppLnSsAiaakIf/v0QYlmgQKkKbw0fptZbJXib1hOA2qWyfWk
 OzdZX6r3tM09ZofUNt2KMjO8goi2vt18LfaUR7COv6RfDbb6mlE8YyjUWU9jRC2SZ1yi
 mZ/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz994DNL//z8KqKSfxH2kPSE3uRHVpRGZb5SPHDjT5Co4/N1aAH2UXVPnjtHVymEhoDH24F8K0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nuhql5GKont3JC3UFNAkVGr0sLhyUSIY0cbR63wM8LJLHSWVUj
 NQM2tMJmCwZQW1vLHqioVOIWpXThYOfOoWdO1xG98QckXzg225Mbv31sp0ttc8vj2SnkJ9yLfdL
 IJl2STKvmP07GfoHP+ZM/fiCNMylVszpwWmTzyCE8QncF+PoS6fYPKGmBoAP/5xb81JdFOac=
X-Gm-Gg: AYBFou1cmcLBqYkMDVoKn97HqhqK55Fu4GH1YnBCwICCSJirU6RllUXfy7PxegNWwE0
 IL2u4l4ZYLc3Er0lTAtxQjYvM6MO+St69zrtf4x2d4seJyONth7GlwDbxggnCjts1dEVzyA2T+F
 Rn0oSXaIdsU4Whh6VzKiEwNiqbLidsAMJ5wgFVLtvCyE41efFUJGRQQkW3wj7M2EIRkzrqYvqYL
 CPj/a2wkEajPh8peE7bltu0jkOTJ8cRrCsAUx+0Etbm/IJWO5DAvCMktMinAaM6pb6R+yDKjCbc
 sCA/nsPsCHZJCbg3iEVUi/4+7vfEXRHaKS8AD2qjzY1IISYbGdOif9ENN1TamEGUr6R9auiWPWK
 C4Fy7qGPXBG98J/DWRUGA0Qfmf8N7GKxP7yvmQBIWvPwLW4G6NBH/qy5kGIJ66bw5J/RTr3NqZm
 JzCHlLxkWv3V1HXirnJDTQVmWYhmDI8A==
X-Received: by 2002:a17:902:cf09:b0:2db:3734:cfa4 with SMTP id
 d9443c01a7336-2dd9c6b9151mr34459875ad.5.1789631196965; 
 Thu, 17 Sep 2026 00:46:36 -0700 (PDT)
X-Received: by 2002:a17:902:cf09:b0:2db:3734:cfa4 with SMTP id
 d9443c01a7336-2dd9c6b9151mr34459415ad.5.1789631196529; 
 Thu, 17 Sep 2026 00:46:36 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:46:35 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:34 +0530
Subject: [PATCH v10 05/15] mach-snapdragon: spl: Add support for MMC
 booting in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-5-3e83dcd239f0@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: i_jCSoRnF4zoXdm7qQuJ9FWdJUNlJWSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfXwAYqey/jo4cC
 X9EmSg6ru3s3xEKiQ2BH9mjrzjZSx9qT+d0RzpJ037kqXZIf30rH6SAslbUxXdJgBmYWeg14agH
 qYHtvGncGBf5T/izYcBxAL2mpXiwXEDnOoTX7K1FZlLGzcdE153/mh+HOr3kWFuQSBGHEcuTCIt
 h204fU/4ha2pYdoqHO3iM1Ihz2IPwN8XTzevyIkLx+XJHiGGSiBj7wZNLCzKCHABeI2CEcoRsOp
 nr58hFHwIsvaF/1SYnNdkpul0o6k6HLf27TVnh3tVBAxKfqcP/Y1BN4/2GowUxA4SBDdpuEuB1s
 aJWuXT7QhjD5SSrvb1GxQ6UAqBuagZabTdVUmTWnNjD2bRnXxcED/Vo6qJQ1fDX/mwi7SfHnR5t
 M3dMJEEwFO1h1C9/kvkv9+JaDtxnyU8LgE7ttHn6ZVYX1xkSdqEfHxSh+wT60pqkIoVOsAlhlWu
 21lNQ26e/xC2+orxfPg==
X-Proofpoint-GUID: i_jCSoRnF4zoXdm7qQuJ9FWdJUNlJWSL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX77gOI9sGGwYl
 XpBAAUXLdA3AKuDVDjYb/zX4cVF4XzhWMw8Z0YbF0wU7KSIH9yX4t0cQkH2E6EfeqT1Ey9+8PpY
 +xBLbNiRZtUWxZZkALrojP86lr+I1DY=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aab9add cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=FyIKYYy4Oh7Up_33twMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
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

Add routines to enable U-Boot SPL to be able to proceed with the boot from
MMC partitions.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 460d07ef0a3..2445ae8b17d 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -63,3 +63,60 @@ static int qcom_spl_populate_smem(void *ctx)
 	return -ENOENT;
 }
 #endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
+
+#if CONFIG_IS_ENABLED(MMC)
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"0:BOOTLDR"
+
+/**
+ * spl_mmc_boot_mode() - Determine the boot mode for MMC
+ * @mmc:	Pointer to the MMC device
+ * @boot_device:	Boot device ID
+ *
+ * Return: MMCSD_MODE_RAW to use raw partition access
+ */
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	return MMCSD_MODE_RAW;
+}
+
+/**
+ * spl_mmc_boot_partition() - Determine which partition to boot from
+ * @boot_device:	Boot device ID
+ *
+ * Return: Partition number to boot from, or default partition on error
+ */
+int spl_mmc_boot_partition(const u32 boot_device)
+{
+	int p_no;
+	struct blk_desc *desc;
+	struct disk_partition info;
+
+	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	if (!desc) {
+		pr_err("%s: Block device not found\n", __func__);
+		return -ENODEV;
+	}
+
+	p_no = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION, &info);
+	if (p_no < 0) {
+		pr_err("Partition " QCOM_SPL_FIT_IMG_PARTITION " not found\n");
+		return -ENOENT;
+	}
+
+	pr_debug("Found " QCOM_SPL_FIT_IMG_PARTITION " at %d\n", p_no);
+
+	if (p_no < 0) {
+		printf("Using default MMC partition %d\n",
+		       CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION);
+		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
+	}
+
+	return p_no;
+}
+
+unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
+{
+	return 0;
+}
+#endif /* CONFIG_IS_ENABLED(MMC) */

-- 
2.34.1

