Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48330CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D17E60743;
	Tue, 13 Oct 2026 01:54:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6mVFCroQgS41; Tue, 13 Oct 2026 01:54:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C97660660
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791856447;
	b=WpBrB7oy+Huuc+3KJv7c6+Vw7XNV5TAAj4UD4IAuzfDXaP4rGRyoZHbou/rZlCNr5lK4
	 Bi2ON6lTmTxQPnOtTWRVRSCDvcUgcz4XcSF+H29cvaw7al2f/i/R8pvCq9kM5alRCO6TT
	 f/CaVL/vux0NGjxhXcKo+HBFq6hDH+isozmSeSV/L2gOPZCedjCrTAXLRxJrZ6Hs159Tm
	 EU7NP57Rf38fEWb6Q0v0H58lzJlLyp/BDxgielrbft78Wclb/bBD09/OeoqYD6EVN0uCb
	 XdEDnBi4KSx7YfsqXr2BzPnKv8ippf5C362aazaKjQb4EqtdZmlwT/79+0/w7veR7Ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791856447;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=;
	b=iBOVMzeoQP52KVzTqkUd7xYMGRJ/3N+icwhVRrn9t+68vQii3z1n2J8tb/wh2luPRsoJ
	 JvcxfKwMmCcRs/hRn0VELdNNTH89kuzKolh6q7P1WkXvm+KofJ0cAsMMc8tZIym6YOUyD
	 WDHX4jO0gP/hYIz7mdikhLxoFSOwJQ5hHPbJ1jFZFAcwCntR63k/fXINsh2zCv/jEEyke
	 Hp02pm1HKQIgts78mj5BtPLWqCY/aKAZASHX/G4eplItFBlxoKvGa47LNabjmxMwRneGi
	 u46LIKMXguRjZh0N9u2aOltQWUruzRU0kzPfUCHA1XBhfIkZ/BOimL3HubcB/g5T8UA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791856447;
	bh=iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eLnZ5SdxWk1n+PvN8NA7OgjjI53N1aAkng5MOe7J3PP5KGiSO1MZ/74CgZliHpKJz
	 U8ryzICwKtwiX2gawnPUyoOJ10LGFvgP85jaLANsouT1+xTbyLt5v3K1kb4KGgcmJB
	 dMB63CtUVdQJU3AkVs0DQoduCguvjVutMX8bZQkzrvFNkrjMd+OmhwRh7JLpfD0zJ0
	 L2E2k9YcnF33lLVYE2cWGVpJ7wrV3Qa54+Q+jeqTL6QRlmUwsOKmrMm2SMxN6Piub+
	 9OZMU5R0fBTiHwhNdMbJMKKyr9Aa71Au7fNVaceYbRLz4xtEntIRfbNiRN+5b6XlN2
	 lcsMmGj0o3ghA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C97660660;
	Tue, 13 Oct 2026 01:54:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28D53731
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2697E40512
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G1aVGgMHZ7cI for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:54:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 583134050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791856445;
 b=b2w0A68OJ1ArP4ARsqqfl+qM+Y+TaG+fHO1dKXYY/3XetlItB5lAdNituVlbXb8rUDV5
 tfyzIcuoRrxx6eAV8wIkNcMC5VgXuBlqh1o2WbE7lJ4PXmxLPKNONPHH0c2X3FDb/U423
 YV7Bg5+fpe7skI73oIQwVaLTLQS0I+TrJP5opyB6S7l/gRaVwq4Mzay/uoncIpKsHX6rg
 01Wx3RtcAbRa62r6J82Bb5/vgp+iQPppw9/6J1Ecq62D2Dpo7W8jf639/Lxip/qT6u1AG
 LPUMxjZL1h8X5EjXE9fXTQrQzLlj1oMU8w2na7+ZMS0p7rkhB7UiuI1bBhWo8xAsqBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791856445;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=;
 b=rAEboV9XwbdTaCSIRX2kgl/T95k6+DqNcq1e3oc93dXHKJCLFJ5xXvZtoHsGZZfPnJJq
 8HMbDscyMUX6BVO4FaUp++OkSgC/y2DRi6UO2JHQ0bSCi7qHLk5CfcvTgEAICZhzoGPRp
 I0co6aQ94ry7Dl7LnmQDxa0U1yNiS56bBHMT3TzbkBJ+9LluGaeOY1VUqoBEd2UVweG4G
 2Gts6r5e+SmXTXVdrY7zxuI5GVzDbEoopJaSJzvyvkO/HiBMKW5RgG/HnmUu9TMO+0lZv
 m1zS6ZX38s+Ub/0d9MZ/PdzlBymV5lIeZiFOSwSpqeEkHMBIQqvi6fZrVLuWGnZoXAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=eakk+RCW; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gcA9SXnF; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=eakk+RCW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gcA9SXnF
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 583134050C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:04 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJgZNI3106566
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=; b=eakk+RCWKJDd4uzU
 Xa1Xxwmn1acFnceuI86kLae4NpQUQqO89JQJuAhGVB28dvUJBkWn0Qo5WZ7O9CJl
 hBG9XNUA2PXD3dhEJb1lofsuxD10PxPutp9Dcoy2tzmHq2WfeDvQomo0zX5s02xc
 Ssss+OlF74S7QeDlpAH30owue3vut/7hVPEejgws+/BWr8VqEnwGIZQ0AZGfDzJZ
 S+KMSJt5iHKzh29MdMonbFoN6ZHsFU+GabiNY+lff3Km3cVc10m3KRq9FW5+oLJR
 nwT/aYUcLVRl5BdVy+X9uGEUIFN09qoqRygtw0UVEmG2fFtyQgECkLZGPiG8jDXg
 ZWuVMw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h95xqs33p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:54:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so1151136eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791856442; x=1792461242;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=;
 b=gcA9SXnFYbQ0MbDc58JfrPWXXDjbl7FTSZj9KrmxnR/IwSBBMiS7mr97sSeNZ/du7F
 NwCBtTnczQkKLmsCiCYr9ZzFZgsGmq7JDpoz+AnVvTbERfTGzScWk7AlNj0jeb6/dwrX
 JI4mWfZkmjS4Z+lrm2m+lQn7KXFkNfv2J2uj3Rk7yVF1CBpbzQVNsBNGQn2eprCIwY87
 my4vDSae/63kAHVD5dwhYhxuVNLbg6HB9U0/qVKroHeg7kGltPZDdLLOQIotTnnQzwzg
 hlXwkSelepmJL/gJeSVn+hWOs+MKGK1YdXvxdmgyDtouiIUmbnct2jZ07lna+JbhWQBn
 hPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791856442; x=1792461242;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iy+NzBCG3G0LkvjevtcTi8BbfA0NuVpIzCoOgoeEyEI=;
 b=XjUJYsN43DQDbQIR6Zm2//WjCHT2ZH1/GwweUMfIuqhjitejQdp6537oJtJzwghDCM
 p9wITcS5MicRz5+rhXR4hb8V3RGpwnUWJtE/q7ut24WcO6U6QZuu5VHgW8AzhloM/dob
 50EDkit+STHtV5Wqp0X3D+fzy+PSezn9BqIuSIoDA7Mm5a49IpRBfIhfUlXnsmKU2BC8
 14YDft4T2+brGpmMBKl9wHbN4XnZEVxoSitJlyVLFLy1dvs5sfzZry2vi05335pgZ8I1
 Rin/+kCLc+/qN9g5uK88Z65JSD737NetFW6lzCswIPqECLSvhNmUJWSN6YCsYRlAzL9O
 U+6A==
X-Gm-Message-State: AFq9FYKKjgTlhXFmZHO50KfPHFxIosSZEDIi9GkH1FUv5Cq5LUxjdklH
 o0NmkljA0jxcXAKZeyAptlWeilk5wg3Pt7s09CbATe04SSM4jFIeUgRr6tZA6XX36BeJbfzLo01
 IA5doyrXpgog8+1SyNgeab4Pt2QaPVqcBAyKQbjAB2iDfWNxhkw1S6Ra+45Tc+n4iMkB+B6o=
X-Gm-Gg: AYBFou0m43dg8BL2jCDZw8tgXzUH0LLEcZ0F+ziAGGIHSxJUPcNNXdpA8rK74NoomAF
 IGFffsPpwUq7AXFCTuac1OqJc41vlgdGGQm7j10CKlv55mmwKh8ip3tMjdlopvUXzGWWnSHuAmK
 v1j3eDY3ues9JjNUy3LEd4vQd7tkbrI/a/oka9Nu62HBEpBskUR03Be1fcL2xH7Nl27pcnPPNr+
 /JnBMpaCyMbVYaYBMNDfVa/bwSDn5yNYGN1n+jDbVOrr9VErkwnYllYL9FIss9g1QFjod+J7MUY
 koS0ABCz6Gi/eMg06SseSGGKNa2gOFKZB3o4HNCBas0Tg+SfbmMzSX7Vmlp79tZyt4sA6RwcAER
 avy/o+ziYRKF6h2kvXe9g1lhiEoCCJJhyQlMndpGYLBrqYHPjWIJ7NeTqj0hyjQM1l2zuAY1ZbU
 FkCBZFILD/msSQcX5QqhH/QGyZQYU=
X-Received: by 2002:a05:7301:188a:b0:358:7bea:88d5 with SMTP id
 5a478bee46e88-3587bea9608mr13064057eec.21.1791856442245; 
 Mon, 12 Oct 2026 18:54:02 -0700 (PDT)
X-Received: by 2002:a05:7301:188a:b0:358:7bea:88d5 with SMTP id
 5a478bee46e88-3587bea9608mr13063999eec.21.1791856441593; 
 Mon, 12 Oct 2026 18:54:01 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm34612666eec.29.2026.10.12.18.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 18:54:01 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 07:23:16 +0530
Subject: [PATCH v7 7/8] configs: add qcom_lemans_snagboot_defconfig for
 Lemans-EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-snagboot-v7-7-fc296a32836a@oss.qualcomm.com>
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
In-Reply-To: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791856396; l=3941;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=KPNNnHuguD1AneBC+YBqm54oBqvfQYhw/NTZlYFwwmY=;
 b=uZKojpA+CM+lCy/CfvWrVPUU64Xll8Idl1Jk/abYrxQZz7muWI3w1PjwGQC94pFaLeHvbsNML
 qys6ZM96/veAkd2ioInI+XzE6Ddt7uSH3NClkcEUVt7EhNas5VaHQeA
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfXyCvmHTn7/nYn
 1m3ZY8a4Mo50ZwYnkJojPFvpD0baaSSL8CC90Wd9uZarirgQdvVFYf9pjT2eNqciJZqXHr2Fmbz
 +wsBSHaT7fYALeTNqdLj2AdK3qB4OPcdEr+15aRJCvd8xRbkOC8uexbbNdG6fE3LLzK07FUmvvE
 z3MuFeqFkn+waT06lyiHv9nSf+roqnIt9kroi8oQPKOtyhYxqRS8ZEZd7x74mZLY0LKQKZiK6Ai
 9Q6OnXRolCtCnAPysW4o4LtPSN6EOZw1X7JRiMozpePNIvE5/nXIwgi5hFzUqok/V4fbEzLrrVz
 b5ro+epdgZRHzm+XJCEZmzBUJZgk+SgggEfVuwTO8Q7AQ0kWUk0UBtZzDTnZDwHl5YgMSvgcsy3
 5HkzPTY29vB0SgL2NcKi4BYTd3CluC6UgRbx202sJFWiCeMA4Y+QBbWa9eSyiXIDVq/G+7KM+bR
 dRU4RPryQMpVJix73nA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAwNyBTYWx0ZWRfX3AOujxpN33It
 Py8HeL/1mxf/2QO5w3tCOUk0Ma1thPOYOl6WrfZRaWUYyOdt3HxfrQ277G051LSRUHc08JKwEpy
 /pqH4RzH3xQZHR6uKzIyDCpAIxSgLyQ=
X-Proofpoint-ORIG-GUID: p-rysH-mdS2UzBpF-iafQpdsE4QYMpus
X-Authority-Analysis: v=2.4 cv=EP+TQFZC c=1 sm=1 tr=0 ts=6acd8f3b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=daLpoQ4NbywWfa45J7kA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: p-rysH-mdS2UzBpF-iafQpdsE4QYMpus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130007
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

Add defconfig for booting U-Boot in Snagboot mode on Lemans-EVK. In
this mode, XBL loads U-Boot and directly jumps to it. U-Boot then
enters fastboot over USB for device provisioning.

Create a reusable config fragment at configs/qcom-snagboot.config
with common snagboot settings. Platform-specific defconfigs should
include this fragment along with their own settings.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- Disable I2C configs as its not required in Snagboot mode

Changes in v4:
- Use CONFIG_ENV_IS_NOWHERE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig

Changes in v3:
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection

Changes in v2:
- Newly introduced in v2
---
 configs/qcom-snagboot.config           | 46 ++++++++++++++++++++++++++++++++++
 configs/qcom_lemans_snagboot_defconfig | 18 +++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/configs/qcom-snagboot.config b/configs/qcom-snagboot.config
new file mode 100644
index 00000000000..20b514a0a5d
--- /dev/null
+++ b/configs/qcom-snagboot.config
@@ -0,0 +1,46 @@
+# Common configuration fragment for Qualcomm snagboot mode
+# Include this in platform-specific snagboot defconfigs
+
+CONFIG_QCOM_SNAGBOOT_MODE=y
+
+# Disable configs that conflict with snagboot mode
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
+# CONFIG_IOMMU is not set
+# CONFIG_REBOOT_MODE_ENV_UPDATE is not set
+
+# PSCI firmware is not available in snagboot mode, so nothing implements
+# poweroff (neither SYSRESET_PSCI nor SYSRESET_CMD_POWEROFF are selected)
+# CONFIG_CMD_POWEROFF is not set
+
+# I2C peripherals aren't accessible in snagboot mode (no Command DB / RPMh
+# power-domain data from XBL), so probing them only produces noisy errors.
+# CONFIG_DM_I2C is not set
+# CONFIG_CMD_I2C is not set
+# CONFIG_SYS_I2C_QUP is not set
+# CONFIG_SYS_I2C_GENI is not set
+# CONFIG_I2C_MUX is not set
+# CONFIG_I2C_EEPROM is not set
+
+# Use default environment instead of loading from storage
+# This ensures snagboot mode works even with corrupted environment
+# CONFIG_ENV_IS_IN_SCSI is not set
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_ENV_IS_IN_FLASH is not set
+# CONFIG_ENV_IS_IN_NAND is not set
+CONFIG_ENV_IS_NOWHERE=y
+
+# Disable default env file to use CONFIG_BOOTCOMMAND instead
+# CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE is not set
+
+# Auto-enter fastboot mode for snagboot
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot -l $fastboot_addr_r usb 0"
+CONFIG_BOOTDELAY=0
+
+# Fastboot configuration for partition flashing
+CONFIG_FASTBOOT_FLASH_BLOCK=y
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
+CONFIG_FASTBOOT_GPT_NAME="gpt"
+CONFIG_FASTBOOT_MBR_NAME="mbr"
diff --git a/configs/qcom_lemans_snagboot_defconfig b/configs/qcom_lemans_snagboot_defconfig
new file mode 100644
index 00000000000..d6906c1e501
--- /dev/null
+++ b/configs/qcom_lemans_snagboot_defconfig
@@ -0,0 +1,18 @@
+# Configuration for building U-Boot for snagboot/recovery mode
+# on Lemans-EVK dev boards.
+#
+# For normal production boot, use qcom_lemans_defconfig instead.
+
+#include "qcom_defconfig"
+#include "qcom-snagboot.config"
+
+# Platform-specific settings for Lemans-EVK
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x1c100000
+CONFIG_REMAKE_ELF=y
+CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
+
+# Timer frequency for Lemans platform
+CONFIG_COUNTER_FREQUENCY=19200000
\ No newline at end of file

-- 
2.34.1

