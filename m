Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6755CCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 06:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 150CC4054A;
	Tue, 13 Oct 2026 06:35:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E-kTaTEwPTQm; Tue, 13 Oct 2026 06:35:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0171040536
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791873347;
	b=H9IPODQMWyZU/0H+FpYHqph1wr/FvBIPvS/fM61bqkEfbwnWt7Na9LBe0vjcqtRlDbSh
	 CybtrGC31eEYvNMnv54tHEiFKDseAQcc4gpmlMGF1TjVTBFJY9v1ksyDCJrfhhP5YK0s/
	 fjs+rP1v0aw4qsv9t7/ANybZZrr0fSBVeT6I8tYT1pSb8HS+Az+wWHW/2Ukj+qs4BddBb
	 y5oguf9H2gG3FsbS0gd3EHLYWdZpzWXuqjLGb5E96vXTLjt9W+o5sd5SdrQI8b6uQYn20
	 H8O9kBkJIKSffeIl1q3nUUFyL1ohdY0/cPiCC+WFawI/bWKXKSWb/r6qOWdIZal5ajQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791873347;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w5Yemil6YYcDJkD9VytrIHKfnRYxjIlfy83016YrLGk=;
	b=iLFhDolSy/JuGMCKC86KSIAhIpverwt7RumXo0xIZ65rp0HC49MKPgXYvDxWCCYbDCEw
	 vvwqsTqktdQz+F2TMGGqpCl+t/H2ME6fi8yyLRzAuoO8Dp614kxRu70ivLiuS9XjIsmOg
	 ULqO6BS6wFTFulntKd8Qorma3VDlQDkWo1TFvOaj3YVYrX/34rS+LOI5XmK4ialAl8d9C
	 43VXmwcKaAnR6yRp3+qWX0uAj3/FOqZ66KCGo4DQnOEpXp9y5y2humlIOjfAWcGq2EElK
	 tqK6zQhppsw0t7xbRDbcGTn+5wAf+421Y5suVa7JqmbjhpTVb+qP/6rBynQGxrugiyA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791873347;
	bh=w5Yemil6YYcDJkD9VytrIHKfnRYxjIlfy83016YrLGk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GPZkzliBZ0OmVxG6yGDLirYaenTbfRugBMDk8zkuOXabL15QXG8JIxd98/gQtL6OP
	 Z1a6hlTTLHmyPQQZfAkcREhIumFwjyo15SZKilkUFeLZutxDd+LBGOwM5UCSG5QYCy
	 i6WC88tSY+nKobYRJfWGUMfLxAxPcJqQvMbQrmJT6FAgAj0vptvArACwvOe1T9xW8Z
	 61dJCtwBp1ijy9EGIussVhO8I0xo/5gU1uOWf6m4cQKGpLqvB2vTsI3ebMR0Q/oY4m
	 mVeeWP8W7Zm0k/Saq8BvMtqRwui4YIL1JsX9i7d9FBJIfCA3V3BIxHaMuf2o9x2aTS
	 GOCt3D3njfqow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0171040536;
	Tue, 13 Oct 2026 06:35:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B370F1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A52A240068
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:35:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9tU-obaweAn for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 06:35:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9912D400D8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791873343;
 b=FIXNzhH6XIydxVG9WV4ZB/CdKEQ2EPbsYaAYJCXfaX6t2Ns34NEwxcEoZm+irkmWEDdP
 /EcJevT7jLlNlQEZIfM72irSOMbWr72xy4YuA4jvH32oWcLvkUdCAUvrPksS2TgKQkSAG
 dX1VHUa+tWlm2ioNpj5UF2xOv/FTFd2rLbn4wwRGYN8PMoWs6m6jBLyXpv6BNRt0xG+K6
 9ohH+mEvkRnD7Zpvvf4Rj9rRyTc+MgXVq5f/H2u2nK5SqZ5ErwYmf+apDxXZMv4sQAaLH
 CRBNolDJHlSm0WS1T8GtTzp0aL4f1kaowoH5vnoEycyDgzMK8nBKJu55UNzEP+IsRSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791873343;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=w5Yemil6YYcDJkD9VytrIHKfnRYxjIlfy83016YrLGk=;
 b=cNOvsfcyaxjmzoTwErJZcKEvLj/ImS2tzvz1tdOKNglNe5QbamircPRpnRYk37nUnnpm
 Bzea9zgBtI33LJsqASZk/wSa4HJMD2lwO7BGsYaKcIV3qi8H4n0WRSgk9V1jvfzG1JXWB
 ZSRbM+GCtImWPuL0yuaTGsSKRxaxTrOnd807GAzA5aq2e+o5JOv25KW9dJae8Ua9mGXYw
 db5DUKLi0vLN0Bsi47TwApaVCu13Uym2ppY87TFTpW9P1cxujiGtqOcaHrkvfvU+LFizo
 8b/NIFYskWwJz8/7vUjE1RrsxNZwpxJVKrbhNgtqOUBYimtFvfc1nAFFe9ehLbl5/Zg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hUJNWNZh; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WVjmOmoJ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hUJNWNZh; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WVjmOmoJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9912D400D8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:35:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D20mqW988774
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=w5Yemil6YYcDJkD9VytrIH
 KfnRYxjIlfy83016YrLGk=; b=hUJNWNZh4jeA1ACwNWqQchByP1R1BQGW8+uY+N
 Nkqh9cvtxkNCqfT0ueekxQ/p0kP03h8azNFHj4ahOO+9mcJsVWKCkS+wxHVBrFkF
 b5E1Icp05lyR5IvGTb6J/GX2ZDKsE7cf11x8j7v+PNDWvukj54RWvHZF4sW6RoPV
 3SVTUi5QGtIiq5hiwroF1wrt/Lo5Yj0jX2DkmPsxSsqydnBrRNSts6PiX2mJNOSd
 DT2BtNCmNSFExAcPHO7HTcxJCjJJ8a8bFxTBiD56Mv+JYG87mGs8DbT+UOX+FRkF
 za4gVpAnhKi1tX2EJwEaYBRCR5gFi+MEZpb1NRyK9ogYmqhA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hc9fsu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:35:42 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso4632648eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791873342; x=1792478142;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w5Yemil6YYcDJkD9VytrIHKfnRYxjIlfy83016YrLGk=;
 b=WVjmOmoJMGWhA+YGuTJUb6kzUE41P712hTHPztQqf3N7eoAYHGU+49+baZ4Em6Y2p+
 oOzNmSTeT2icKvfDVwjOY5HRpA+9J18dB2uJh87TMhaAcXJY+O6IvdT9EQwYe+oOb2Gf
 8Op18mageBE2dLzFsPX07L4DjfjMnqXyjOE9wLXQ+/pzml3s826L4pKWiY5Fmvr9937P
 P6RpPB5Gq4N/OhZRAMgbjt+dkO8TQaXO5nAto2M8SO9NfCn4DewCElCfwRhAqFYfF11K
 FguZH0o1YHsQRAHWBpPb8scTCeLOKwkH1VuzBBMH8t/+C4n4t6ZSJDFILjsamfcuSEfH
 nE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791873342; x=1792478142;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w5Yemil6YYcDJkD9VytrIHKfnRYxjIlfy83016YrLGk=;
 b=eUIoU+GOitzoac/j4v0q24s+UKCE4RloUmje3PXf5l0nB9CiTvACTFsojSrPHJrWhc
 kFQVx9/ELLE0l1mrEQ6R7cM8xuvptzH/TFP96pmD5rt/Gepplj9WJCo/LJGD9IqdBMa1
 ABJcfBoLpCeiqlrBgSp+4sNeIwLqe0A5WutSZ56Kn1Ho6JtkKUT3RiIdkJr9iq3mVotw
 ncLasCNB3RK6WJn04QO1sFIwMpvVlPOUydh3XHL0Efcr5fO6g1K8sb6A9QQJiYysLV+Z
 OoVGZCSR6P0MtyIE4WKox2wyyeVuxY6s+cG1iJMXhKCOjgEn1LwRNV9e+HS40ON/RSTi
 1bwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2nzjiE1D939L8b/t0F6sOQOpe96shzeLSQ17xOvb7e8vlKVAEZa4mAFHh7ShxVAEINagzz9s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIyA2evyKdG8CfA5NCWkBAEepuAxr425kqSxszdE7IK1WGt8l7m
 YdeRuIBbIefRSS8EWmpCW+M058QjmXs+xZcxa4SgX3F4Wv9FcZVSAI2Ya75RYG6OhM63+/uxbK6
 0KmCdpf9gfUivAIio/LI1lKo2kFQhn/1TxysMDphQH6lMJG4iakRNBdhUB4rnFrsdjM5iiIE=
X-Gm-Gg: AYBFou3c9Fag2Njv54s+rYgJWmWThCrzxQ1QoC6BHWIYJwvYRmTFVdI6q8QJIvq8dmk
 RooQSey6bxMEBLfEOGRmKkSbgcg1M7X3p2uAM4M3MWosEybM4hW1YdFocjEHKT1ZxdL7agHbWz4
 QBmuQ45bEuUH8MJUwTbcifaouy88WiGILioUbjr6i4X5jBMAWHEcC3yxoHTGLGBf2omF73khC8e
 85VdWJLx8p989qn7ZQgZB6Lct5+kRdG1hROxXBE+e+WoWb+P6YWOhCf6aoFxOFIUCQ42X2l3LWA
 j00HG+78MgBmwrVsJQ5u0PrZ+/S+zD5nOMsKyWICOrHeNdUhCGZjN6NW2VohxPXZs/RPBWCqH34
 yqL2mk63zXrcDNoEh35oZoXufaBTe+y17/4eUVDTG1dAILMyhNxGAGwTVQCDx9DgryKJ3FRWqfN
 WhJBqovKM+V4lR8/kPa5qptQ7BW/DX49WOpwdNUw==
X-Received: by 2002:a05:7300:8d:b0:358:36e5:b81c with SMTP id
 5a478bee46e88-35836e5b925mr13213158eec.31.1791873341487; 
 Mon, 12 Oct 2026 23:35:41 -0700 (PDT)
X-Received: by 2002:a05:7300:8d:b0:358:36e5:b81c with SMTP id
 5a478bee46e88-35836e5b925mr13213112eec.31.1791873340825; 
 Mon, 12 Oct 2026 23:35:40 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb1e05esm41301560eec.25.2026.10.12.23.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 23:35:40 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:05:36 +0530
Subject: [PATCH v2] clk: qcom: sa8775p: Add QUPv3 wrapper 3 SPI clock support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-sa8775p-qup3-spi-clk-v2-1-bd6365d81a7b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADfRzWoC/4WNSw6CMBRFt0I69pl+kI8j92EYtOUp9UNrXyEaw
 t4FXIDDk5x77sQIo0Nix2xiEUdHzvcLyF3GbKf7K4JrF2aSy4LXMgeTA+mqLA8BXkNQQMGBfdy
 hsFy0ShilULNlHSJe3Hsrn5sf02BuaNOaW43OUfLxs12PYvX+v4wCBFRYW1mXWnJTnBJS2lv/Z
 M08z19hR37bzwAAAA==
X-Change-ID: 20260924-b4-sa8775p-qup3-spi-clk-6c01d31b33ea
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791873337; l=4425;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=p4nf7t1d8t5N/3U29INSaSPlr/AjRb2udJ37Mn2Fcdc=;
 b=vc9izTkwkklBk+oRLqorWu/rVdwAf+Dr5HZAIixXLtHJYMw1aC5nuV4BzyvIMWpGpxj/yvgFr
 POdXGBCGtlWCPtJu7N2TkZsHptxwoypukSRwz0I4QFBT26fsFg32axP
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyNiBTYWx0ZWRfX6vUpOyw1lL4K
 LWquEOooKeAxpEBbdNS7fapJjSXLuf35cQvMKFftZbJrJDoaWgUwNHmdHj1amM+R5DzH/VVSmrU
 XVb57Krpiqc8dQmfk6S3ou46Guowyr3NFUPTtFxp+i60rYyXalhhyOb7usUfhCQD6LxBKHb2mYE
 xmL66DXf5VRE0brvWmBQBsQ1Di7mp2GCrm1z31qzd0LxDeC/EFJsOQxXg8P9nlP15VUHwViPV3D
 TBtQ2+Usb0zsaMFRjsAC6TzLfFhdbROxt73oJ1po/4s/jyJI6IRPqG/Cj8X7Xwb+7syjZr/i7RP
 k5S6tL8VKj/sibSjoF58NVmoCUnGZqG0uRBYcSAJQhBmidVFi3FsaOXGJvITEbB2wpiV8ADDpU6
 h+LifywqwA/oI209A4tnQ5R9Q9aHme71ygrzOozuOeZNyA2f4iGlvY6DNrGGpoTIb7zCvwj3jXa
 FbmN9iqYnn65zvwW2tg==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6acdd13e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=r6LF-9bVAAAA:8 a=EUspDBNiAAAA:8 a=aBlBvB-F2evWav5k4gIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=sL0kBDm1BSwOBZmmfnro:22
X-Proofpoint-ORIG-GUID: 693h97TVemxpgkfsuvBsK1VXhG4W3Mlh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyNiBTYWx0ZWRfXxcF3K+5bkKDD
 utjgBoWnlEjw1bCwSO+QMQXJVRRFf79Jwhxl2CO2JgRvJtqyq9jI5l44O1lg5vKpMEcbnK5GfLH
 n/xaRRm4wMtd4qBBZ2DNu+5NpfKaT7o=
X-Proofpoint-GUID: 693h97TVemxpgkfsuvBsK1VXhG4W3Mlh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130026
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

Add the clock RCG, gate bit definitions, and frequency table needed
to enable and configure the SE0 (SPI) serial engine clock on QUPv3
wrapper 3, GCC_QUPV3_WRAP3_S0_CLK. This is required to bring up the
GENI SPI controller on QUPv3 wrapper 3, e.g. for SPI-NOR flash
attached to that wrapper.

Also add the wrapper's M-AHB/S-AHB clock gates, and the QSPI/AGGRE-NOC
gates that are auto-enabled alongside the SE0 clock.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
Changes in v2:
- Rebase on top of upstream main; no functional change
- Repost: v1 was sent with a wrong author/Message-Id domain (test.com)
- Link to v1: https://patch.msgid.link/20260924-b4-sa8775p-qup3-spi-clk-v1-1-8e9c297a20b6@test.com
---
 drivers/clk/qcom/clock-sa8775p.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index a7bd6c43004..9ac914802a3 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -18,6 +18,7 @@
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
 #define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
+#define QUPV3_WRAP3_S0_CLK_CMD_RCGR		0xc4154
 
 #define UFS_PHY_AXI_CLK_CMD_RCGR		0x8302c
 #define UFS_PHY_ICE_CORE_CLK_CMD_RCGR		0x83074
@@ -50,7 +51,27 @@
 #define GCC_QUPV3_WRAP2_S5_CLK_ENA_BIT BIT(9)
 #define GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT BIT(29)
 
+#define GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT BIT(20)
 #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
+#define GCC_QUPV3_WRAP3_QSPI_ENA_BIT BIT(26)
+#define GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT BIT(27)
+#define GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT BIT(28)
+
+/* QUP Wrapper 3 SE0 (SPI) clock frequency table */
+static const struct freq_tbl ftbl_gcc_qupv3_wrap3_s0_clk_src[] = {
+	F(7372800,   CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600,  CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000,  CFG_CLK_SRC_CXO,        1,   0,     0),
+	F(29491200,  CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    75),
+	F(48000000,  CFG_CLK_SRC_GPLL0,      2,   4,    25),
+	F(64000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,  16,    75),
+	F(75000000,  CFG_CLK_SRC_GPLL0_EVEN, 4,   0,     0),
+	F(80000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   4,    15),
+	F(96000000,  CFG_CLK_SRC_GPLL0_EVEN, 1,   8,    25),
+	F(100000000, CFG_CLK_SRC_GPLL0,      6,   0,     0),
+	{ }
+};
 
 /* UFS AXI clock frequency table */
 static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
@@ -148,6 +169,12 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap3_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, QUPV3_WRAP3_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n,
+				     freq->src, 16);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -190,7 +217,11 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK, 0x4b018, GCC_QUPV3_WRAP2_S6_CLK_ENA_BIT),
 
 	/* QUP Wrapper 3 clocks */
+	GATE_CLK(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT),
 	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP3_QSPI_CLK, 0x4b000, GCC_QUPV3_WRAP3_QSPI_ENA_BIT),
+	GATE_CLK(GCC_QUPV3_WRAP_3_M_AHB_CLK, 0x4b000, GCC_QUPV3_WRAP_3_M_AHB_ENA_BIT),
+	GATE_CLK(GCC_AGGRE_NOC_QUPV3_AXI_CLK, 0x4b000, GCC_AGGRE_NOC_QUPV3_AXI_ENA_BIT),
 
 	/* UFS PHY clocks */
 	GATE_CLK_POLLED(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0), 0x83018),
@@ -230,6 +261,10 @@ static int sa8775p_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
+	case GCC_QUPV3_WRAP3_S0_CLK:
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_QSPI_CLK);
+		qcom_gate_clk_en(priv, GCC_AGGRE_NOC_QUPV3_AXI_CLK);
+		break;
 	}
 
 	return qcom_gate_clk_en(priv, clk->id);

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20260924-b4-sa8775p-qup3-spi-clk-6c01d31b33ea

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

