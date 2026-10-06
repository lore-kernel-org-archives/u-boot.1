Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205E8CA5FF0
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 07:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39C3F809B3;
	Tue,  6 Oct 2026 07:25:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id csXzxUF2zD55; Tue,  6 Oct 2026 07:25:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 104728098C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791271525;
	b=LrKJd8WWOuh+uBsj8t00/pwAa1S3BRCPfrb4LUPWk62FNvE2LxkN27tkXDCvOz4TUboM
	 mMxSqKJ8xGFyCVePJ1cYAc7jWic4u3vkh4+LdZzEFRIBEt/ihFfIfCgMYsf+HZh0n98Ms
	 uQqFcaLreg+DYXKdl2et/G2LWCJSPbBh6GBsXupG/JfmtL44lwcoEux0NzWrrLGmxECOy
	 3dx81SzMkwFnsUpwd4QxRqIg2jrjFvTv+MMfHUAqoos78PxZCjfXg9Yp2UMu9T+/+Jl4K
	 ihhA7lcBLk2Fm19ZohXnI5+sG0H8w4PrGH0pXzQslq9dVHYEBBceVnNzsmqM8xg+MQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791271525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Cu8hRyUkHKFklV2aFJx7ibePu4NWO6ixVwEkXjppPVI=;
	b=ny8KnbvSyhBA49MinqV4BmEeUianhNgl6EFi8nlHKlWkWsUMxdI2DdHqstyGR7f208eu
	 kUCkMqi8unTy8ghspKp0eR7sCspQOFyBcqG9toeXYFymg4dyuv4xScHO7tVgDASBTsNwt
	 vJhQxwE+uQIUyKCNIYD17PiNnVmzCF2f+ouXcdnk6tENrr79CKOENfqSOCx4ieaHgC7+Y
	 aTRS/u0NOdDgg6YvAJd9qvyfhWvVyv/gLgS+YpeadyIMuiwgBDV1DSfmPhSYqqOjibOJv
	 ONG0rDgmATLmHEwnc2ewTBwttw/D0mKn+nuTGOMYtajalpcxWd6nE8Fohflx3mvyKGw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mcTbQFgF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LlN6zRsU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791271525;
	bh=Cu8hRyUkHKFklV2aFJx7ibePu4NWO6ixVwEkXjppPVI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ude/ZN4l/gKfr/kvHjjHkVvVIEUHaGTGEujuvLIq2V/h3TyBO+64UIkuKB7bdlRax
	 pgYz1c+oAjP5s+LyIXY6EJi9efmPzyu8B9LFAY8qWCcsmLXZCcXvJCWaiGhUek0KcN
	 9hdH2GlURiQ0eUW9s8AL2e+oL0Y4nQnQjU7gNAt4tbqLLusFjSpn43v6qTq5NQBUMU
	 dqiMhAA+9n/dZsR/EJGtqAD7jle1KY3B5nTtf5OSDRKEnF1HdsJJLBDNx7Ef6WGWII
	 sWdNPfhKnswUO+p1j6pz667DmR+dQfefKxoc0sxs0CGD1YiByrZOB6TachMijv9BX1
	 WSAWOixNzlv+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 104728098C;
	Tue,  6 Oct 2026 07:25:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BE922E0
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 07:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1DFCD80972
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 07:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wk4wqVSVkgeU for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 07:18:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7ECBF80980
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791271100;
 b=Zxig/C6aBl7RfXou8UpJpHaNmCkeI+ujH8IuchVwMEHJzCobQtSg1xJ2r+758d2EX7NH
 7xMPPX3Ms6oomCN2ZgjNIwerDC0193GDpFkK5pnztujMKGMqtK6q7TWBOQq5qQi7SJTyB
 73VomjRnjWMfDoYq5D/5ombVBAAF05gp6Bah1mNX8Rc3pkopWX2uI1HF6aRnEyqX0wCes
 X08eX/kLaNdZe3/snYEYohIEAke3DAxo5UINoWI99pPKYsp/0xhkQmQrNb2qtBodpghw0
 cUun7IO+5ddbqUCOnmSD/6dK4Hx/dDSSVOeF6uK3U1MoPFmq0bmpYofY9PrbXfb8yrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791271100;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Cu8hRyUkHKFklV2aFJx7ibePu4NWO6ixVwEkXjppPVI=;
 b=dQU/hEoyYllodvfgb637prthBZVihDcer+KAwq7s8nuzlM5icMpPBaU3D9byB5mopyN8
 IUB5NcCxgeqMsvhlLQdjWRTcvuM9w6lcHAqIjiNkgWjJZqtsooLP3Fy77nxi5P/K2YXnT
 EH6gLqdzSOC/AZvFYMdxFLDVTb5sBHR8+EXchReamGF9v5s1DNH9FPngKh4gBaUPisNKw
 M1fMzBe6Mkkz8RZBZRLQo0YiV0oJNfAgj+CJdBHKpuA0i3XE/pPuqbjhT07GzPJn6uPgV
 H8crymk8LfnM3uf8rXNxJ5JC+W6nvwEdrECZZtgYY1BSL2ygftxMm18Tbp8BP3M5JBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mcTbQFgF; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LlN6zRsU; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mcTbQFgF; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LlN6zRsU
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7ECBF80980
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 07:18:18 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966dwYY3432573
 for <u-boot@lists.u-boot-project.org>; Tue, 6 Oct 2026 07:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Cu8hRyUkHKFklV2aFJx7ib
 ePu4NWO6ixVwEkXjppPVI=; b=mcTbQFgF5obUO5Hvjl199jckLa007YED61vYEy
 8GcNNTwhxOM+zk9CMjBrqVhBImYqGc0r2Rj5JmH4BNp9r79IgMSPvQ/dT1c+Eg+r
 n9gzfYo1EHib58NBfgHSik0IkMB0ows3+h99KG6d+BHOS+UPpGRxGAfX1T4mk2bR
 iUkICcrLBeGk9nWSe/B4+Yab/iRHdGnU11GNaL3qgr1esCjK10fxefGttKX7IVrT
 7XChvuG+yVxKFtVVUL4MDKPQShUcWjHs4WBlZPGd0s34KOLs8WBh8PelMDARAcZs
 M4vwuYizdhkiw2CSYTJ8ZxsrW2m5SEFLaE7aN5tpHY07OuUw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cvnkjr6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 07:18:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510d0baf63so5156801eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791271097; x=1791875897;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Cu8hRyUkHKFklV2aFJx7ibePu4NWO6ixVwEkXjppPVI=;
 b=LlN6zRsUW42wZq2nPNTV5J+Mho9nUAsAKHYusw4yz3luA6GSUIo0Ng1Z2q17rSvD8B
 2i132cGulVJ52nzEpi5kviCot9iYZY2a/uMzf18W6luYRDHNmzdM2P9sMiL0hh5gaTQP
 k21SUOKAd+f3ZuFpC9r3j2nQUjVp/axoWgBUszd3KaY0BTRoyriREEYTOUvgXyIXVfFO
 IZk6V9rxe4Hh/wUVZXldqssK38n7HaKuF7LJvfU99mYl4Ffps0HX5ZMdnXRVNAipuuKI
 dpjCf9JdRDOviYHYg0bFaXh+d/Pm4vLY7fL8QIOvcQ4cm2ZvZ4KEYPq9ourhiIqtgzdi
 2e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791271097; x=1791875897;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Cu8hRyUkHKFklV2aFJx7ibePu4NWO6ixVwEkXjppPVI=;
 b=OfqN1R52xOG+jy1GZPTpMdyWQZML8nk1p7jU7a6SUo6CThZ4eFwGe9Dw/8amcxFJ26
 4vIzIElvWVoNZuVysEYFWtFSPr1bXlZlLl1ZtMwkxurj9AeGjn6zdf7cmARUvZpVwXyG
 96Yp0M8gyIyuhtW2Y2kGBkjna4KnmrA+MpwZdLtomRwsgAmIdr7JrDN/yYYvn3l+1TKo
 x4DEeVl+q9WroaK9fJJjqDgnqONPgUh7dkvswbX8tNGvJKerAbr/69MFzPfHyU7TZxo9
 BJNeX3ggMl6PNALFxZAPiSGD/QKBzBOzGqk6O7EsmDxrly/D6cdaHOAIllPM3DVIYGbI
 UE0A==
X-Forwarded-Encrypted: i=1;
 AKwUvByWkDkB25QX3ME0bzc2tbkXdNSfbEksakhPqbdFRP66tC9HgWDHJpTEgwtmWbm6hwzW6u6FawU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJDb6jd/Ujc9k4x/VIcz1DEAMmwU6XxcIv5WV7K7VF3V3ckljej
 AWlDlWTFjT9x1/RWJ/cW5qnTmvHdGmf7j8hJ82onC8QKJ0eMVRXtXeO6JT3GpZ/uPvRXMXPD8pe
 ODRcKDzY0tBZPBveW7XCCBP6JFR2/hATa5Kkq7ZzdZZoM/vbTPJqBViq2Xv/cNysdARPZLMRBzS
 ZiwpA=
X-Gm-Gg: AYBFou18F8vWRuBirkszr/eZkDcejh49jIReb9pXc6FgudAHPJmmrZAS2y6uUEf5iPk
 drTGEdGCEyJklh85ue2E4vQDjq5MKu0fLNfRGt9oQ7PsX3EkMcTq6MWnRQEYFZeJf5w/cTFl4ip
 izdKV2GJtr+P4ly/TlXY4rzRof+7WWaLFWQUGymUZguE0jyIdMgZ0a+IZN9d/9gLo7ubkcf7QDm
 QOEz91RaxDaI+uZKcmBQrcEUZ8r1j9Ln50al8YTrftFWMZZkKBoKkd4YWSEwvGtj+BublqVexur
 /M3IUWiRb/KgRZLEO111nUFRWK3YuMW6tyM/oc44VjmMr7DCpd1CyuiPjSM9JwsR6cTp2XC2B0L
 gam3q8V5l+/fko2BuNzub77CFDzPP0CK1utOjjBr1eZPhqBSZosAQevODLz5Z6o7PgTbvw69XpR
 OVpHtH7ukFu67eaybS1GcnviT4fvc6QO5doekKGg==
X-Received: by 2002:a05:7301:438d:b0:343:ff9f:26f3 with SMTP id
 5a478bee46e88-3514df99568mr603372eec.9.1791271097101; 
 Tue, 06 Oct 2026 00:18:17 -0700 (PDT)
X-Received: by 2002:a05:7301:438d:b0:343:ff9f:26f3 with SMTP id
 5a478bee46e88-3514df99568mr603336eec.9.1791271096331; 
 Tue, 06 Oct 2026 00:18:16 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35146a2c991sm4952340eec.14.2026.10.06.00.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 00:18:15 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 12:48:12 +0530
Subject: [PATCH v3] misc: qcom_geni: fix RX_RFR_WATERMARK to use RX FIFO
 depth, not width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-geni-rx-rfr-watermark-fix-v3-1-b368fe3fbf70@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALOgxGoC/yXMywqDMBCF4VeRWTtg4hVfRVxEnegopmWirSC+u
 7FdfgfOf4InYfJQRycIfdjzywWkcQT9ZNxIyEMw6EQXSaUVjuQY5UCxgl+zkaxGFrR84JBVqlS
 myDNlIfzfQmH+tZv2b793M/XbE4TrugGLA190fQAAAA==
X-Change-ID: 20260821-geni-rx-rfr-watermark-fix-d48171a6541f
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791271093; l=5250;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=Tg2iyq5Ll/SUodwHtqjotbNZ8vNmLhLyhKUbbieFOZc=;
 b=566AKujgBJm6zcytrNn9tZpqH9R6UuzyVasQ/pRS5lTxb8zaVFcHeSpVJydReMVA2E94SMw/s
 oOLSwAUNeBtBFnpf1Yl96XvcGGKw4UuZg/ajz6DYfmBNSPDqip9euqw
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-ORIG-GUID: SxwoEFmHvOUopAlQaPUNCUZy84jHLVjS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyOCBTYWx0ZWRfX5i+O8b3o5Uiy
 FVy3N5Lrtbm/s2vmbXedN5t5YwcRTLDW1keEA4YnjMTKWfRhYXJ6L7O6lFSAjQgWeULaw+MiKGZ
 IYDmpq3LmLk/ImPnsljsxU2ILpEgSwzWTriPzKATXUn0K0CqSF19y1upm0tEJBqWz7rIJWsDcU1
 orry/T0f319hJ9SyHtg888BOZ3sJvVjtUgOex3FCjdi1jkwnE5RmkL4x1tS2JniwPesQdRaN+x9
 jMwuuYC6GyxIxnpxKO8vRyNLbpoixDduOrlK/EZemnQALxebjqZ+YpcGramJVOXJ8PCF2ZoeYVP
 Ehc9xwikTfp1OtvCwn3zZ37QBgg1jTvIlaktrwG7lUCuvMhHwD6tiZP80iFiE/suUT0lyF4Efeu
 BkS9FetHPxLasJp1M2j/r7X+ZO3ICLTAnXmcxvk4dBNq1A/aZcVDYteCJLtVGBCVYriTUvZ/a+C
 tWW3Yjn1RfMNvBnL9oA==
X-Proofpoint-GUID: SxwoEFmHvOUopAlQaPUNCUZy84jHLVjS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyOCBTYWx0ZWRfX1J1fDtWTyotG
 8YBwgnNZnirFmqc4ebcu8KXNvQ6HuLc8X1ZQpzcan/MGiq+h3urtzHb+nZ6yp9PHh9FifkT+FVN
 X56zToW+91XZYVXplBorg/E+SnM8d/o=
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6ac4a0b9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=KKAkSRfTAAAA:8
 a=9tQ5N9u0vCS04MSpLWkA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=2RSlZUUhi9gRBrsHwhhZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060028
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

load_se_firmware() derives the RX_RFR_WATERMARK value from
QUPV3_SE_HW_PARAM_1 using RX_FIFO_WIDTH_BIT/RX_FIFO_WIDTH_MASK, which
decode the RX FIFO element width (bits per FIFO word), not its depth
(number of entries). The watermark register expects a depth-based
threshold, so this produces an incorrect watermark value and, on QUP
HW versions >= 3.10 where the depth field widened to 8 bits for
256-byte-deep FIFOs, an inconsistent one depending on core revision.

This mirrors geni_i2c_get_tx_fifo_depth() in drivers/i2c/geni_i2c.c,
which already reads SE_HW_PARAM_0 with the HW-version-gated
TX_FIFO_DEPTH_MSK/TX_FIFO_DEPTH_MSK_256_BYTES masks for the same
reason on the TX side.

The same depth-vs-width distinction, and the HW-version gating for
QUP HW >= 3.10, was introduced upstream in Linux by commit
fe8aa1ba0783 ("soc: qcom: geni-se: Update Tx and Rx fifo depth based
on QUP HW version"). The Linux driver this file's firmware-loading
sequence was ported from, added by commit d4bf06592ad6 ("soc: qcom:
geni-se: Add support to load QUP SE Firmware via Linux subsystem"),
computes the RX_RFR_WATERMARK value via geni_se_get_rx_fifo_depth()
which applies that same depth mask -- confirming this is a porting
bug rather than an intentional difference.

Extract the major/minor-gated mask selection into a new
geni_se_fifo_depth_mask() helper in <soc/qcom/geni-se.h> instead of
inlining it here, so that the pending GENI QUPv3 SPI controller
driver can reuse it for its own SE_HW_PARAM_0/1 TX/RX fifo depth
decoding instead of duplicating this logic a third time.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Link: https://lore.kernel.org/u-boot/20260824-geni-rx-rfr-watermark-fix-v1-1-d83fd078850f@oss.qualcomm.com/
Message-Id: <20260824-geni-rx-rfr-watermark-fix-v1-1-d83fd078850f@oss.qualcomm.com>
---
Changes in v3:
- No code changes from v2; rebased onto current master and resent standalone.
- Link to v2: https://marc.info/?l=u-boot&m=178912440036662&w=2
---
 drivers/misc/qcom_geni.c   |  9 +++++++--
 include/soc/qcom/geni-se.h | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..f3cf05c1c0b 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -168,6 +168,7 @@ static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
 	const u32 *fw_val_arr, *cfg_val_arr;
 	const u8 *cfg_idx_arr;
 	u32 i, reg_value, mask, ramn_cnt;
+	u32 hw_version, rx_fifo_depth_mask;
 	int ret;
 
 	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
@@ -207,8 +208,12 @@ static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
 			       rsc->base + GENI_CFG_REG0 + (cfg_idx_arr[i] * sizeof(u32)));
 
 	/* Configure condition for assertion of RX_RFR_WATERMARK condition. */
-	reg_value = readl_relaxed(rsc->base + QUPV3_SE_HW_PARAM_1);
-	mask = (reg_value >> RX_FIFO_WIDTH_BIT) & RX_FIFO_WIDTH_MASK;
+	hw_version = readl_relaxed(rsc->wrapper_base + QUP_HW_VER_REG);
+	rx_fifo_depth_mask = geni_se_fifo_depth_mask(hw_version, RX_FIFO_DEPTH_MSK_256_BYTES,
+						     RX_FIFO_DEPTH_MSK);
+
+	reg_value = readl_relaxed(rsc->base + SE_HW_PARAM_1);
+	mask = (reg_value & rx_fifo_depth_mask) >> RX_FIFO_DEPTH_SHFT;
 	writel_relaxed(mask - 2, rsc->base + GENI_RX_RFR_WATERMARK_REG);
 
 	/* Let hardware control CGC */
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index fc9a8e82cd8..d7a9a4c82d3 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -277,6 +277,30 @@ enum geni_se_protocol_type {
 #define GENI_SE_VERSION_MINOR(ver) ((ver & HW_VER_MINOR_MASK) >> HW_VER_MINOR_SHFT)
 #define GENI_SE_VERSION_STEP(ver) (ver & HW_VER_STEP_MASK)
 
+/*
+ * geni_se_fifo_depth_mask() - Pick the TX/RX SE_HW_PARAM_x fifo depth mask
+ * for a given QUP_HW_VER_REG value.
+ * @hw_version: value read from QUP_HW_VER_REG
+ * @depth_mask_256: mask to use on HW that supports 256-byte-deep fifos
+ *                   (QUP HW version >= 3.10, 8-bit depth field)
+ * @depth_mask: mask to use on older HW (6-bit depth field)
+ *
+ * QUP HW version >= 3.10 widened the fifo depth field in SE_HW_PARAM_0
+ * (TX) and SE_HW_PARAM_1 (RX) from 6 bits to 8 bits; both fields are
+ * gated by the same major/minor check.
+ */
+static inline u32 geni_se_fifo_depth_mask(u32 hw_version, u32 depth_mask_256,
+					  u32 depth_mask)
+{
+	u32 hw_major = GENI_SE_VERSION_MAJOR(hw_version);
+	u32 hw_minor = GENI_SE_VERSION_MINOR(hw_version);
+
+	if ((hw_major == 3 && hw_minor >= 10) || hw_major > 3)
+		return depth_mask_256;
+
+	return depth_mask;
+}
+
 /* QUP SE VERSION value for major number 2 and minor number 5 */
 #define QUP_SE_VERSION_2_5                  0x20050000
 

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260821-geni-rx-rfr-watermark-fix-d48171a6541f

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

