Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B68C9832F
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 20:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 089686066D;
	Sat, 26 Sep 2026 20:41:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3U0XEfo_D-Tb; Sat, 26 Sep 2026 20:41:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1917C60653
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790455271;
	b=JYnQQuiC4v/7mV41B2B/RMzU4rmZOA2qBkpDEJLH92bEwwDoh9URua2bbEGMl9lr/Oan
	 JR36Xasf+AFCDrZef0lPJToO2PdhaCpjjZk02uVzSXKLF3qCQJHD/HUVoqcU7cYHpW1lJ
	 Jh9jceWQqGkVN1kftJK1+WT5rID/CLVFUJMT7jcS26Br9e1rcbjtMdplbB/UqWkV+0wj7
	 T92dzNqmUUnaCELv7rE9OzhEXMJs4DIdYCPtiqDcYh26iSc2We7OTftP33QQoNzrcKPvM
	 HouAX83uEgpjcyOrfEAaBNJ6nE4t0l8rJ2k8c5AmyHAH/4t1MGsnWMpsvHBQz0mr5XA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790455271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
	 Date:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RfcmdX/aEXn2QhmjUxTIgpq1MahU6YVmGfRBUVQZWW4=;
	b=i3cWCpUniGtk9sQiytiCLiigBgRBOnuSpeMsT7bEm2NbwWsAbGDOFxFuO2UqAQfpGMEb
	 ilNWmPuaJHdYRUATzOAlry0SIQwQLVUwUbA2e1iuyklN9Y0sVQbWW/gPZGsv8bwAHpGjw
	 dGFnrkCSgamdMSNxOm7Cgwe8mUF+n0gWydXB/2yE6idHUCudodoaBOtJyeJUz9uzE6IeL
	 /WvFG02K9v7s0ekup6NWbgiR9d7h/2as9nlhpQg3m3yX5i7TrhH2u3MLmqYN5hlMQyDuw
	 NqgSGiLADab7AC3oN6jaAyNBB2nI1yk0zR6IssLiTZQfS6VEPso97cLM/AGi5zZfPBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IALnPW3E;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gy8xuoYR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790455271;
	bh=RfcmdX/aEXn2QhmjUxTIgpq1MahU6YVmGfRBUVQZWW4=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t/vsKGH2DxKAfj3ao+glx5gfpHr6loNnF8SOksEYDtUruPC2XlArr0Z7VQc3xYfiF
	 impUEKU5CqrVIoQZj/a0czu6TW9vYrrlTp8NX2CS7YGtpR88H8E0wRj4+egFrokSL+
	 3a6Xng8CI98/S303Hqz5p4u2+zUMCdGFEh3rbtQxStBW3fh3ypbY2IqWJpJ73ESuK8
	 VkMjoJsequ1ue67/HurLdVc2wQn36E/cMUbgisAKxWv9ODZhqf6jwfh3aEoeupRLfs
	 GLaZ0z2XyWm/Emx1J7NjNBdtrqCHwsQgRsrRvNdVviQ675SCioCwjGBPuVowiNj5//
	 iJGrFkbqNAvlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1917C60653;
	Sat, 26 Sep 2026 20:41:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40D73D1
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 267F660653
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ctg5SYjzumHu for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 20:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0B5FD60643
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790455268;
 b=G6MuEUI8gOJe9WI5cKT/F7EPHR9YAEiDuWyXYTnBJYw2l17msCnfi6rymFxN6IQj6gd0
 YCIB9GDE3yioMplPeSaPHBjYtDMyiUBtnIn3ihgMjWOA2DMehY6Xb9JI7BmvXJ14BJz1x
 2NHlB7Sv55WaM5CsoOYCesnHKR7dFw17qbj1lnb2wvvnJaztkzm5xtdz1X1pzk6+IBlTD
 jhw7RHr4axz0B4iF7ii1tS7pymLiwwBHBCfm5y/1iNNkR2d7xt62JCvIo7jKUoFym+yHJ
 sMwsWZVVLNEhqVh6423Fl6e3Yt/KmSQ/PB72o1fgk/pKLSFs5MFDIq2CHUWjr80Lx1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790455268;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=RfcmdX/aEXn2QhmjUxTIgpq1MahU6YVmGfRBUVQZWW4=;
 b=P9W9PWOBQ/zd4NgYH6pMDrvPg9at7ApURODaXbjpFVvxQNB5QWUaL5XBdXdkTte0TdE2
 dUdHoSHMO5GsiRRa9XbTWuvTvZPBFOoDaXyNo36FV6OFGiC9JQJtTuaLDUlvzIc4Az1zm
 gewrZjjk/GQLgzpc0a8NyRFMhNDZDaqeGUVd4y8vZh8YUhFJoFMNvT4k1a79Y5sswv4n3
 ZRVfjd+NGSb4lvqp+xoU1yA9nmu9YoL9fN5smKDEGQILqcowD9x96uYfz3258iREAe6BG
 nr5homIqzuwrWtCNNIkA/ylzhV2w7QjGt5wQBFEGNq0wk1BlBV1rRiQtIc42BOEcXSQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IALnPW3E; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Gy8xuoYR; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IALnPW3E; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Gy8xuoYR
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B5FD60643
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:41:06 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QH05Sa880318
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RfcmdX/aEXn2QhmjUxTIgpq1MahU6YVmGfRBUVQZWW4=; b=IALnPW3ERneJmdzC
 NBjnWzkla3L1g4JqItwC+q/szPZFFixG60aO8DFsSWzarQntIdsrcTORH+t2riNg
 AbIzlwp56CY75XU1cQO+96ZsSxueiu3hZ4Tw0vNtLILh06cKcAyZyuvohj0WtptP
 VeMMNBoHshSWDu5H406uZmNzhOZSdGG5GSLsFmS8k3grU1Pdc8bEtybqCeLIWrYx
 S/SpYibh+rPjGZLC9X5P9TgHLDrsQ+87hA7farTIyMo1+L5Zbe6oIGPGyR1aXMaW
 in2puhfoisTsa8bcb7+RUW/hu8QGHQFkns7tCU9/X4cd6uMS+USdm2RwIqpd/Tnf
 v3fN3A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mw9rew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:41:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c6a0d2122so39159685a.3
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790455264; x=1791060064;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RfcmdX/aEXn2QhmjUxTIgpq1MahU6YVmGfRBUVQZWW4=;
 b=Gy8xuoYR0vskqy59qjU+yzktbnjJwOpdyYxd+6nTfXVAKwBw6Mh66LtSOG4Dv/Vqj+
 kN9cgz52k1Y9N+ZFk/Py1q+V3cFxweqvX/03Md21jdf0w5TCQh8Yc2FDL79pv2ryPG7N
 2/jsEBQbFbd5LWEltl5S0i+t300uBvb/32XO/9zYSFaFwCN9hTrCy/9XUvnYCGztmdU0
 h8sTx8SDZw9UcRwvvb3adwRt3HbWP+bDRs/us3crzFGD7j9IcY9hl1Codm/BfHOxkI57
 03H3ztO+0cfMlnGFr86bqcL/jUexrLrTey1Uz2Z3zYieYnrv7Bv2mQvar1HjplHIlBN4
 D5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790455264; x=1791060064;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RfcmdX/aEXn2QhmjUxTIgpq1MahU6YVmGfRBUVQZWW4=;
 b=tqSa08ctCZ19NlMetpLcDJYRoYpqTWy7h67yIfEANf3sOftfv51jM9tEslNjhRFi1g
 RwGmqmJO0GtrmM3EAgbCx+u9H7wMx0YjAd+hqHlJn+2692QTHF0fJfCVbC5GEIx0WlU1
 WqCzzcolu5ac3JJsrrgzA0GxxFvLFcLpNByernfqRfB158pqDDCiMexfFspnXOzEtqCx
 ug2AVPVXlOgzHiNO8sEzFqhCBScFiWWcq09xF4Y5C5/ldU3i5PLy/DxSN3jrFWri4qBW
 KFUc6k1gtssCahD0g4BOJXLL7eDqmfGFFOdRN6gWX6/tI+NvaZmpHUU8Ezdk7P2/khgd
 p/zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPOCTX8qt1DbUhJgnIZwlb6OF8XotIUYXae7yplzI6Ky1hkhYsvjEA63ou1TYxGRqq85UPRZc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mFkTlJppIX7vBR/8hVc1dEZMhf3I+7iYFT34Vjl02nUqBkzq7z
 e+C6kJ3k1nLIEUrfylhkX+Elun+gO7X+nrlzLA6AvOMXfIRGUniXasED5KL8hsXi5DRwLVvUSwt
 iUHE3dXgvA7oHScDjPjBx0H2P06ZnY20WhXUw1T+VOLdf9j5uXGu/Ma7aDX6KsdsM6SlOiIo=
X-Gm-Gg: AYBFou24wZKSzzxRcMn8qWrLYADyh6TS3+eyKa0DBAtsKcqUUba2kYcWWDr1vv5iS0O
 GVRt52YuJu4iGN7PkiiMkVMo3zgoi6SxSd0u2v6ZxWLwyOtbNvSQSNKpz0cgRGvX5YghdCsZuVj
 7aDnOOBre2fHRlB8AcdqCOiQ9Wcd+B7leVh6TybR+JpvGBiLpPxgyW8U3CjzVqjvT99Jx2tY4Zr
 YRaC8Ivc13RzOOBazygBXedHE40jsxgWxOPtnUD1WUAwB6ip0mL5l/qs8qahactVYfZxKZZexde
 p2pyrQ3T8VzuzTu/ZzzAQstCYoxa2wFiPkGNZpYMNvpO4GvJNABIJNVmWHPIv96dNA==
X-Received: by 2002:a05:620a:170e:b0:939:5ae7:2dad with SMTP id
 af79cd13be357-93c43c9fcddmr1287708485a.38.1790455264312; 
 Sat, 26 Sep 2026 13:41:04 -0700 (PDT)
X-Received: by 2002:a05:620a:170e:b0:939:5ae7:2dad with SMTP id
 af79cd13be357-93c43c9fcddmr1287699985a.38.1790455263448; 
 Sat, 26 Sep 2026 13:41:03 -0700 (PDT)
Received: from trux ([2a02:8109:d902:e200:2717:b11b:a255:915])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2ae76abc3asm265320566b.37.2026.09.26.13.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 13:41:02 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Sat, 26 Sep 2026 22:41:00 +0200
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 "stanleyjhu@google.com" <stanleyjhu@google.com>,
 "Beanhuo@micron.com" <Beanhuo@micron.com>,
 Zhaoxuan Zhai <zhai.zhaoxuan@canonical.com>,
 Ethan Hsieh <ethan.hsieh@canonical.com>,
 Jian Hui Lee <jianhui.lee@canonical.com>,
 "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "tanmay.kathpalia@altera.com" <tanmay.kathpalia@altera.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
 "n-francis@ti.com" <n-francis@ti.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>,
 Bear Wang =?utf-8?B?KOiQqeWOn+aDn+W+tyk=?= <bear.wang@mediatek.com>,
 Ht Lin =?utf-8?B?KOael+eAmuWulyk=?= <Ht.Lin@mediatek.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "sumit.garg@oss.qualcomm.com" <sumit.garg@oss.qualcomm.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
Message-ID: <argt3LwLjENr5vZF@trux>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <aq2b2AspOcySKRvl@trex>
 <SEZPR03MB78102F7A1B91EBAA72743B2189812@SEZPR03MB7810.apcprd03.prod.outlook.com>
 <CAC_iWjJmZFsxBn_R4z6N5RVewjDL3GzBWY0t6MTiLk5tSCN7vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWjJmZFsxBn_R4z6N5RVewjDL3GzBWY0t6MTiLk5tSCN7vg@mail.gmail.com>
X-Proofpoint-GUID: 8zvML865DnuFS5IUbwPj2KmX2G-xUqsM
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab82de1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=D19gQVrFAAAA:8 a=NEAV23lmAAAA:8 a=mpaa-ttXAAAA:8
 a=uqQ3DgWYG3BYbQI1yK8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-ORIG-GUID: 8zvML865DnuFS5IUbwPj2KmX2G-xUqsM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA4MiBTYWx0ZWRfXwM6E+0V1ei6Z
 QeCPWARc0BQ8tbZh7esTksEu2XTVrGsmqnVCZkiu73zoUOEVlB4m13CrO3C4rkuktaLnUhkBYG3
 w1MT7MP7y52PY2tN4C7amJqT5nUfk+1qF2ZtDSackiQIAVC8SvYAAxyJbtoNaCHvkdlBR2BV4Fl
 sPs2EVmwJ6qzMV1kS6EuAJWp7IAuF2wMzhzzKi9C+QKASkXKWSrTFNyW3ZULkoZieEYuaVjXYY+
 eMe7b344R1jxRFhQFFqx627SO7kD9dwy3jqQ8iAdRO/FqXV6nSqXM8SGqZFoORvWZ2GHdURo5Zj
 jP887FT9vxZDFXb+yZwFYHPSZ6/lAgdrtjciaSfhtooASUuQAQHk2ZU+zGWY7+gT8LOrRGoiv0h
 eACZxi64p/klMKcMbb7ti4GdukLcSuhRmh4n1q7llC9Cssg+Dhnv4fpf30hfEa8HylCr3vok4Z5
 YQ74tNjLrDb8N+2EzXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA4MiBTYWx0ZWRfX2+dAq1Z6TIxL
 1UdLWKhFCxCKOvNWCURWIq75WbNDshhgcqYwTRz6gfPMjTiXYU0zbpca+o9k2LyeFoefMyBxNQ3
 l+RFrplFEB+ThJnuxgg/0FNPsEc2zFw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260082
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

On 25/09/26 12:59:28, Ilias Apalodimas wrote:
> Thanks for the detailed analysis.
>
> I am pulling in Jens for OP-TEE and I'll have a closer look next week as well.

the concernt I read - please correct me if I am wrong - is that this code affects
downstream projects.

This is just not acceptable to me - downstream implementations should have been
posted to prevent exactly these kind issues.

We spent  time and effort doing an implementation and sharing it with the
community - it wouldnt be fair to us to block this merge on the basis of
downstream projects being impacted.


>
> /Ilias
>
> On Thu, 24 Sept 2026 at 20:50, Macpaul Lin (林智斌)
> <Macpaul.Lin@mediatek.com> wrote:
> >
> > On 18/09/26 22:06:32, Jorge Ramirez-Ortiz wrote:
> > > OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, but
> > > U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-command
> > > interface, which is bound to eMMC. SoCs that are UFS-only and have no
> > > eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-TEE
> > > secure storage from U-Boot today. This series adds that support.
> > >
> > > It introduces the transport-agnostic OP-TEE RPMB "subsystem" interface
> > > (PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enumerates
> > > the RPMB device and reports its kind, size and CID, then carries the
> > > signed frames. The legacy eMMC supplicant is preserved unchanged, only
> > > renamed to rpmb_emmc.c, with the new UFS backend added as a separate
> > > rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_UFS_RPMB
> > > depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant handles a
> > > single RPMB transport. The subsystem interface is UFS-only for now; eMMC
> > > can be migrated onto it later as the legacy path is retired.
> > >
> > > On top of that it adds a UFS RPMB transport that moves JEDEC RPMB frames
> > > to and from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT.
> > > The per-region 16-byte CID is derived by BLAKE2b-hashing the exact
> > > device-id string the Linux kernel builds (ufshcd_create_device_id()
> > > plus a "-R<region>" suffix), so OP-TEE derives an RPMB key that matches
> > > the one Linux would use.
> > >
> > > The first patch is a standalone UFS descriptor fix the RPMB path depends
> > > on (UTF-16BE string decoding). A small preparatory patch surfaces the
> > > RESPONSE UPIU sense data from ufs_scsi_exec() so the transport can retry
> > > only on a power-on UNIT ATTENTION; the transport patch also bounces
> > > unaligned frames through a DMA-aligned buffer for the RPMB WLUN.
> > >
> > > Note: reading UFS descriptors reliably also requires the descriptor
> > > data-segment cache-invalidation fix, which has already been posted and
> > > merged separately, so this series is based on top of it.
> > >
> > > Tested on the Qualcomm IQ-9075-EVK (SA8775P): OP-TEE with CFG_RPMB_FS
> > > programs the RPMB key through U-Boot and reads/writes secure-storage
> > > objects, with the derived CID matching the Linux UFS device_id ABI.
> > >
> > > Dependencies:
> > > Linux kernel:
> > >  https://lore.kernel.org/linux-scsi/20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com/
> > accepted in v4 --> https://lkml.org/lkml/2026/8/27/369
> >
> > > Op-tee
> > >  https://urldefense.com/v3/__https://github.com/OP-TEE/optee_os/pull/7881__;!!CTRNKA9wMg0ARbw!lQ5D9IUE1D5erqbaXCklFua6JiijZYB6XN0q5LDFZZpiaGmrH_k10rLkcjU1nSzhsRDX--J49Gt22E8U73lx7Es567TUAxwX$
> > and also following Ilias review https://urldefense.com/v3/__https://github.com/OP-TEE/optee_os/pull/8007__;!!CTRNKA9wMg0ARbw!lQ5D9IUE1D5erqbaXCklFua6JiijZYB6XN0q5LDFZZpiaGmrH_k10rLkcjU1nSzhsRDX--J49Gt22E8U73lx7Es565JETGdQ$  (both merged)
> >
> > > For reference, at this point Linux can access RPMB and just u-boot pending on this set.
> > I'd like to have some discussion in more detail as below, it will be quite long. However, my company's
> > email server and mail clients both have problem again as usual. I'm not sure if this reply could be send
> > out correctly and in correct format. Let's see.
> > Moreover, I've invited Kernel's maintainers Stanley Jhu and Bean Huo to this mail thread to see if the opinion increases more compatibility.
> > But, I'm not sure how to invite OPTEE's maintainers, I'll try to forward the following description to OPTEE later.
> >
> > So.. let's start from patch 4/6 and then review the whole story.
> > 4/6 — ufs: derive the per-region RPMB CID and size for OP-TEE
> >
> > Patch 4/6 hard-codes both the hash algorithm (BLAKE2b) and the output
> > length (UFS_RPMB_CID_SIZE = 16) used to derive the RPMB CID for UFS
> > devices. Neither choice is mandated by any specification the series
> > builds on (UFS/JESD220, RPMB, or the OP-TEE/TEE Client API), and
> > hard-coding them creates a real compatibility risk for products that
> > have already shipped with a different, vendor-specific derivation. The
> > CID derivation should be factored out as a vendor-specific, build-time
> > selectable component rather than a single fixed algorithm baked into
> > common UFS core code.

I am a bit at lost. Why didnt those products pushed their code upstream? If they
have an issue with this proposal, they can apply their needs on top, can they
not?

> >
> > 1. Neither the UFS, RPMB, nor TEE specifications mandate a hash
> >    algorithm for CID derivation
> > - The UFS specification (JESD220) defines the Device/Unit/Geometry
> >   descriptors that patch 4/6 reads (manufacturer ID, spec version,
> >   model string, serial number, device version, manufacture date,
> >   region sizes) — it says nothing about combining them into a "CID",
> >   and certainly nothing about which hash function to use.
> > - The RPMB frame protocol itself (struct rpmb_frame in
> >   include/linux/rpmb.h, and the equivalent JEDEC RPMB frame layout)
> >   has no CID field at all — CID is purely a host-side/secure-world
> >   key management convention, not part of the wire protocol.
> > - The GlobalPlatform TEE Client API / OP-TEE's own RPMB subsystem RPC
> >   contract only defines that a fixed-size opaque byte buffer is passed
> >   as the device identifier — it does not specify how that buffer's
> >   contents are derived from the underlying storage device.
> > - Because no specification prescribes the algorithm, this is
> >   legitimately vendor-specific territory, and different vendors — or
> >   even the same vendor across product generations — may reasonably
> >   choose different KDFs/hash functions (BLAKE2b, SHA-256, a
> >   vendor-proprietary hash, or a raw non-hashed encoding, as seen in
> >   other real-world implementations of this same feature). The patch
> >   set should not force one specific vendor's choice into common UFS
> >   core code as the only option.
> >
> > 2. UFS RPMB does not mandate a 16-byte CID; the size should be variable
> >
> > - The 16-byte length is not derived from any UFS or RPMB requirement.
> >   It comes from the eMMC CID register (JEDEC JESD84 Card/Device
> >   Identification Register), which is a fixed 128-bit hardware
> >   register — a purely eMMC-specific hardware fact.
> > - Linux kernel's own generic RPMB abstraction (struct rpmb_descr in
> >   include/linux/rpmb.h) already models this correctly and treats the
> >   device identifier as variable-length by design:
> >
> >   struct rpmb_descr {
> >           enum rpmb_type type;
> >           int (*route_frames)(struct device *dev, u8 *req, unsigned int req_len,
> >                               u8 *resp, unsigned int resp_len);
> >           u8 *dev_id;
> >           size_t dev_id_len;   /* variable, not fixed at 16 */
> >           u16 reliable_wr_count;
> >           u16 capacity;
> >   };
> >
> >   Likewise, the UFS-specific device identifier the Linux kernel builds
> >   in ufshcd_create_device_id() is a variable-length ASCII string
> >   ("%04X-%04X-%s-%s-%04X-%04X"), not a fixed 16-byte value.
> > - Patch 4/6 should follow the same pattern: UFS_RPMB_CID_SIZE should
> >   not be a hard #define 16 baked into include/ufs.h; the CID buffer
> >   size should be a property of the selected vendor backend (e.g.
> >   returned alongside the derived CID, or declared per-backend), so
> >   that a 16-byte output is one valid choice among others rather than
> >   an assumed universal constant.
> >
> > 3. The vendor-specific part should be factored out; 16 bytes is only
> >    there for eMMC compatibility, and UFS has no such hardware CID at all
> >
> > - To restate the core problem plainly: UFS has no CID register.
> >   There is no piece of UFS hardware that patch 4/6's
> >   ufs_rpmb_build_cid() is "reading" — it is entirely a software
> >   construction. The only reason the result is squeezed into 16 bytes
> >   is to fit the pre-existing OP-TEE RPC buffer size that was
> >   originally designed around eMMC's real, hardware-defined 16-byte CID
> >   register.
> > - Conflating "the UFS-specific descriptor-reading/string-building
> >   logic" with "the specific hash function and output length choice"
> >   in a single non-configurable function means every downstream user of
> >   this series inherits one vendor's algorithm choice with no way to
> >   opt out, even though the two concerns are logically separable:
> >   - Reading UFS descriptors and building the input identifier string
> >     is common, spec-driven logic that can stay in shared UFS core
> >     code.
> >   - Turning that string into the actual CID bytes handed to OP-TEE is
> >     the vendor-specific part and should be pluggable.

why cant you extend what is being proposed in this series?

> > - Suggested restructuring: keep ufshcd-side descriptor reads and
> >   string-building in common code, but expose the final
> >   string-to-CID step as a replaceable hook/weak function (or a small
> >   vendor ops table), so the BLAKE2b implementation in this series
> >   becomes the default backend rather than the only backend.

sure, send a patch on top of this one.

> >
> > 4. Hard-coding one algorithm creates real firmware-upgrade and
> >    key-compatibility risk for already-shipping products, so the
> >    derivation must be vendor-selectable at build time (via defconfig)

I dont see why since U-boot currently does not support UFS RPMB. IF downstream
has an issue, please send patches.

> >
> > 5. Since neither the algorithm (point 1) nor the output length (point 2)
> >   is specified by any standard, and CID is purely a software
> >   convention invented to reuse an eMMC-shaped OP-TEE ABI (point 3),
> >   different implementations that already exist today have made
> >   different, incompatible choices for the same problem:

I dont see this code upstream. How can this be a blocker?

> >   - This series (upstream v5, patch 4/6): builds an identifier string
> >     from Device Descriptor fields (manufacturer ID, spec version,
> >     model, serial, device version, manufacture date) and hashes it
> >     with BLAKE2b to a fixed 16-byte output.
> >   - At least one other real, shipping downstream implementation (a
> >     vendor's production U-Boot branch analyzed alongside this series)
> >     derives the CID by directly decoding/porting the device's
> >     tee-supplicant-side read_cid()-style logic — i.e. no hash at all,
> >     just a direct byte encoding of the serial-number string
> >     descriptor.

You keep on mentioning an impact to downstream and my reasoning is the same: why
didnt they push their implementations upstream?

> >   - Both approaches are equally "valid" in the sense that neither
> >     violates any specification, because none exists to violate — but
> >     they are mutually incompatible: the same physical UFS device will
> >     produce a different 16-byte value under each scheme, and
> >     therefore OP-TEE will derive a different final RPMB authentication
> >     key under each scheme.
> > - The practical consequence: any product that has already shipped in
> >   the field with one CID-derivation scheme (whether that is this
> >   series's BLAKE2b approach or a vendor's own pre-existing scheme) has
> >   effectively burned that scheme into its provisioned RPMB key
> >   material. If a firmware update later replaces the bootloader/OP-TEE
> >   RPMB glue with a build that hard-codes a different CID derivation
> >   (for example, adopting this patch set's BLAKE2b implementation
> >   unconditionally on top of a product that shipped with a different
> >   vendor scheme), the newly-derived CID will not match the CID used
> >   when the device's RPMB key material was originally provisioned. The
> >   device will then either:
> >   - fail to authenticate against its own RPMB partition (OP-TEE
> >     derives a key that doesn't match what was provisioned), or
> >   - silently begin deriving a different key than before, which is
> >     just as bad if any secure-storage data was provisioned under the
> >     old key and must remain readable after the upgrade.
> >
> >   Because CID derivation happens deep inside firmware/secure-world
> >   boot code with no user-visible error surface until the RPMB HMAC
> >   check actually fails, this class of bug is essentially undetectable
> >   in normal testing and only surfaces as field failures after an
> >   upgrade — exactly the "silent, undetectable until it fails" failure
> >   mode already called out in the CID appendix.
> > - Therefore, the fix is not merely a documentation/comment change:
> >   the patch set should ship this concern as a build-time (Kconfig /
> >   defconfig) selectable option, e.g.:
> >
> >   config UFS_RPMB_CID_ALGO_BLAKE2B
> >           string "UFS RPMB CID derivation algorithm"
> >           depends on SUPPORT_UFS_RPMB
> >           default "blake2b"
> >           help
> >             Selects which algorithm derives the per-region RPMB CID
> >             from UFS device descriptors. This value is a software
> >             convention with no basis in the UFS or RPMB specification
> >             (UFS has no hardware CID register); it exists only to
> >             populate the fixed-size CID field inherited from the
> >             eMMC-oriented OP-TEE RPMB ABI. Products that have already
> >             shipped with a specific CID derivation MUST keep using
> >             that same derivation across firmware updates, or the
> >             derived RPMB authentication key will change and existing
> >             RPMB-backed secure storage will become unreadable.
> >
> >   with the BLAKE2b implementation in this series wired in as one
> >   selectable backend (CONFIG_UFS_RPMB_CID_ALGO_BLAKE2B), so that a
> >   vendor already shipping a different scheme can select their own
> >   backend at defconfig time instead of being forced onto this
> >   series's default and breaking already-provisioned devices on
> >   upgrade.
> >
> > Each vendor should be able to upstream their own algo and more.

I dont see why but feel free to propose a patch on top of thise series.

> > And these algo should be configurable by the users or by board makers.
> > For example, MediaTek and Ubuntu are using different algo and CID length for
> > UFS RPMB.
> >
> > Here we suggest to make some change to increase the compatibility.
> >
> > 1. Split ufs_rpmb_build_cid() into (a) a common helper that reads the
> >    UFS descriptors and builds the identifier string, and (b) a
> >    pluggable string-to-CID backend, with BLAKE2b as the default
> >    backend rather than the only one.

That would break kernel compatibility - the kernel uses blake2b.

> > 2. Make the CID buffer size a variable size, or at least property returned by the selected
> >    backend rather than a fixed UFS_RPMB_CID_SIZE = 16 constant in
> >    common code.

What would be the benefit of this?

> > 3. Add a Kconfig choice (e.g. UFS_RPMB_CID_ALGO_BLAKE2) so vendors can
> >    select their existing/legacy CID derivation at defconfig time.

And the kernel? how are you going to handled that? This would be a source of
pain when doing software upgrades.

> > 4. Document explicitly, in code comments and Kconfig help text, that
> >    this value is a software ABI convention with no basis in the UFS
> >    or RPMB specification, and that changing it on an already-shipped
> >    product is a breaking change to that product's RPMB key material.
> >
> > Thanks
> > Macpaul Lin
