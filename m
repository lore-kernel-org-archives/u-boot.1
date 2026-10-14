Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1748C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:51:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AB7A40709;
	Wed, 14 Oct 2026 16:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QlrlAXn4dyGW; Wed, 14 Oct 2026 16:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B281740755
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791996713;
	b=CggzYxisY98rPky9C0HAsaFcYpQH5+kKd49817kkDCdwON+gPM40xMBc+rBFidZ0C+f1
	 J1WHnZa6gRJwoDqMC2gmHVl2WHb5RvrLvGQ001oEOkIvn1yF9gFN/BRQl5gi+h+1nSomn
	 pTAzGV9v3Lrf2/j+GriC0Yr4cowjj/5Yp3ONVT3Hm2JSYWQPVATKh8pd+jBVSNmbLR1jN
	 w1bwqCgEhf9205/GUQrzT0Mk4Cw2GOzJRTCL4mO+ljUVjkwfJZINKc8kRqwvFfsc/2fD7
	 FBMahyKIiM1uDQB+zrjYOypcZaSurc71+ML3HhIAt9Xov4hDxG2uJ7t6/Rhb+1v7usw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791996713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
	b=GgWljiQTvQ3rwyLAzLaw8yRarltGApUB+G9mLyGbVh8lQnVUDFpwFL5/pmr3fNuYzF92
	 xPqgnYANWmqT+58XYu91IsnR3uY6BySA5j/bpG0hClIL6sLVoJOR0lG3aC4KAbCj3YMD2
	 UoDtXQDjSjJSEVJfqcF0zHFjmg94hL6QSzQui72ykO0rqtHh3KlcxU4Et2Ezbju6t78Mm
	 n78wYyO7R4IzS9MD1FLSogfKldFcRwDlDXl0VarRg8hCgTBrw06aiNPG4IOqUfJsJCXKu
	 3Qj1I/UKtbkDTLvvRJks4sb65rhnLQmjK6STzkL9jT3cRs0JAJY/bXw40DlRvgwDocg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791996713;
	bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IC9cwh2ppAQyAiNkvaWjxr3PZVg2FL843IIsANBI95WYU8eqvwS48Q49hb297CD9G
	 lVAeOvvOV67GxMsPCf5TZccQQ5quswfVYWHNkUqDYsom1EM87ez1JrxrGZzite3jxS
	 Fyah5MRNtBuRVZsHj0cJCuZk3puKJFKkEif6bxhhJQhH08S0FjU/YWGdAu16yNEFwV
	 twrZfrmbMsBrfN6jwNVOVvIQbx09CbpI20hwcAx0A+U8gzWvoC8ed8QRgiViC5FiGA
	 gTg3JHvQKRamd/UK5xAD8pHYBugy/R67lQW+Sp0tG6eaX6NBp6vlkLRuihe9LyDPDk
	 Mr7hxBbjlVHmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B281740755;
	Wed, 14 Oct 2026 16:51:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A1101DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B338607ED
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tiz1MxMcJgm9 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:51:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C6443607C3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791996711;
 b=bsSeT0jAFvPTbHk25fj3RoCd7ADYJUeQBMHLb8Gmt2YndpkGBTDhGqu69uHLy4XfJdlW
 4zMq9xFGQGyvummbjU5GK9uTIfwQDQo2YD8+mif6HBW0qk70EFJWnrYuzY8JRjSgtlHCO
 neMgEzZ+3JwVJestyfLWvtxHQBbM9oy3csMN26tPTalXP/skxGNQAmLP69F0gUQeANYOm
 qPM5qG0q92AFHQbdEblKJ+5HD3wuo6nTpMrRcT4agdYzUgDv8KfIpXYLhO0N4jB7fQi31
 1VPVwjM3Taaj9nijFzWaRVDv/4BwqeEr2NugtKOkjZgWIk8ceEYzSVzTUpfn/v730MA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791996711;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
 b=AGGgAUatxWOXq72Ye2gHYE2hmhwTn0mlb86aLQG1073AhdQ9zkm7z1ZKGXmQZA3WpY2k
 m2UIwfGNm2DcL+NMsM2wv4/WoWjYew1IjS/VnbwId9fmIGW2+MKVrZOAacDeXfAS0NXEJ
 jRR/EvpaLFGpukdl7nknORL2hsBPyjL665ivwYO42xYQsSFDvDUJrTShuDEkPyR14fJo2
 KcVSnM8cHxDR5VN/IEQJUiOdVuXyQF7U6MMDT43a3la3hd6PHfmbBeLqoDh6zJYApoUKa
 DHZ11r1oVV27ifju+GWNWtPCeNZDATfIHgAV8P7Nunno6zsEDNNQUZQkkOt1iR20kmA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mcHB4l6M; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="O/81cVVZ"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=mcHB4l6M; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=O/81cVVZ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6443607C3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:49 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJDK467786
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=; b=mcHB4l6Mq8uTICMQ
 1TA2Kpobl41pkFeZP7Ptb8gfXZD8xRh6kE9sObg2WnBFcW5pHFMYpJFL09gUo/4X
 PxYfG/qK9ErLXD1FrECEyPJNRIt/9VaWLX+++YK9rvZUlaf8b8BMIBJQRD1Pnsux
 SbyjWI1HBjywe5BeZo1btrHLlJHewjbLiHWcNMEJyn5s3XDouMOOKxyzJOQPmdtk
 MJwBkl6unWGqGcXe8Lo/6MM8V6Ah/a9437B5fZ+qnu9+VoPSVb1J0tHoeqxHmzyB
 dG/V89P8P3bS56f/X206nDXjVmvJ7cwpF0Aq8I+y6baS35ASFuL828GwCpQU8bSl
 7i8DYw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphkkkw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:48 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso2187029c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791996707; x=1792601507;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
 b=O/81cVVZQpbFIhJjCkArjpete31qZg//6T5CQX4CNJmSsanHUr2sAmDbuAWGaP9fpx
 rlO2q06/4NvRUnjFQWApukcpH27h4pEEEPJxwdOOR9q+5vZslIgIPO+qrXxIbLBmXkyc
 btlIUComLRfp/wrbRoemx+HKHqdEcf49QRPfIWJkVZnEUerPTv5AeHyIY8RUmUkSr7v1
 9u6TO6Joj8StHNivzoEOC7L460fSUMlRHnuPWvFNxz8W1pZmQFTzh07tGSToL/+Mdb2o
 yoAfe5j6mLji9SAbQiI+XZMuYlhJP3JK8gDe0yOGnjv4iWZqaaMIYKr0S5dx9ugSLqwe
 QOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996707; x=1792601507;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/RwD1wksNx50hyqO8u8SKbe32tt15/ObUf2DLyt6cHg=;
 b=hBaPFlRqOaPrG5GlhZ9wasiTJDpMLczyeKM0Gw4p7oIT7r93nvzPIkYmiQwHu/Rigx
 PLQY0UJrDKGacmQQunUCjzgwxwxCENPxagIftnQAhYKJ3xSUEXeo0aXwJfsat48lCdCT
 KCVcy72uIbUUTvLV+5sKmGmRDMwatJFrmNC1e9OcGI/1687w2V3F0VLinGJiknlpr4hO
 AvIQaGongvqnkLFvzWT6HXh9FOzI4CQFxoj+KNNVdKxlzVLBIgNpS9qpcDJhp87zRTd6
 V3qHJsPtKuMMksEQgYlN2svUUGY9It14slG3TdRcMbAv6mXI4y8DzZULFNML3rFLqi2z
 yunw==
X-Gm-Message-State: AFq9FYJ4vQoNu1rOg6ZgVytMRdxMt6zFhv8nNDUwfhHSKK4mMfxWDZhm
 T+vTH8/q8A0zpbKEFdobMzs0ZgLxK2zOn8J8U2XWrh5Eepl9JVF3V3kYhmj2QRQuNCVwUTOCWxV
 n2aaUXo7HOJuZT8aOltMXcQUFa+oI6iOzS2zUqQTopoDwxkDwEHH3wcuq0WHSzYs0w8mpYBjFX3
 CdSYY=
X-Gm-Gg: AYBFou0cdAfeSiHYPz9Tc5YPoH0y79juA79DDROH21l6r7d5PU3ihLe7b2P3VSCXebV
 /L0HbTEJPq3invrhTrZr7JMXhu+hj5l92onWvUvHszcL1GvopEhUXiJAcoyE2a9BlYuHH+GN11/
 6oole5vOxhf+tCDSvL5gPqgHyR/eVsBLam82co+WDhyhegP/gY0Dr2doR/XUnB8w76holxIVgDN
 YkMIoBiRlq6FTMjibV6pUJ/BbkGCy3YaJBnVpDAAhfZOYwvcMf7iYdu5VUMbQYeFGTH+KFtXlEF
 XczxW2Yf8Oy7fgOk0xFkY3uRT96HfYag6TT3q/8EPMb0Labh0xpr/SCMMpzyky5zb6BvdED6xf1
 CigW8EwKwCyvChieFjnRyYp64E2z1gbshki6LSr82f43bcv9zlhHW3OXJT05kq0IfuVeWM8826x
 EbrkiwsNIkeznvUk6elFtlvsjrIrc=
X-Received: by 2002:a05:701b:454b:10b0:14d:baf5:c40e with SMTP id
 a92af1059eb24-16a5faa76admr20360236c88.8.1791996707244; 
 Wed, 14 Oct 2026 09:51:47 -0700 (PDT)
X-Received: by 2002:a05:701b:454b:10b0:14d:baf5:c40e with SMTP id
 a92af1059eb24-16a5faa76admr20360210c88.8.1791996706545; 
 Wed, 14 Oct 2026 09:51:46 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm48975894c88.8.2026.10.14.09.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:51:43 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 22:20:59 +0530
Subject: [PATCH v8 5/8] soc: qcom: cmd-db: Allow boot without CMD DB data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-snagboot-v8-5-7caef86562b7@oss.qualcomm.com>
References: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
In-Reply-To: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996669; l=1942;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=UgnSfcvQN3KxWw8blo6gGammTjNQRx3KkF+Wvh5C7Is=;
 b=CIZJQjuHWuxeP5sLtp+J++IEhwENnEGRQwEi+8a8Wv4Q1siKdxNSKv5gtB9G1It/G4OL6cw1G
 V3tcxwAGov3CuJnW3kWSlsBt191oPcT3U8tTJZiLdBS+Vsw9q9PHFTv
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: _7xY5NAcYv25Fqxse38HuRfBRZdQXZrw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXwW3OCZURmSMi
 kog56w1F5Z5bT0EjTnWhgxd7+G2j70HrI4dTm7+WTs9b9UmambwVmJJzqAGjceeZLKI7e1hWT4F
 rQ9YdO985+dPZt+Y2p1SzHq/LhGuFxo=
X-Proofpoint-ORIG-GUID: _7xY5NAcYv25Fqxse38HuRfBRZdQXZrw
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acfb324 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=GqjHzkLP_lxEehVDorYA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX57vQf7Q+GQum
 Oq3c+ajsAI7TbgD9M2/nNo1/PWEQN0NXGc0yUT8/bo0mYmzMB2A2WJxHxZhmlUvtVH6SmjkdOvR
 Tj9MZFCHBmiG9DtE+QtGHexScB/bsxIzHUsm4DnKLNvuQptPtIwEA9q6uXBh8Zz/TvITk0mHIf5
 RuBlmj+oPesuQVEIEzxm7nMxiMRw2RDIc6LZrkWnv6WQwGZ88d9pae5BaJ7SYJJasUqgVdceQ+v
 WPdZf9bQeC+xwCDligyYcrZ+7XXcrqAHumBPPdbOOHGVx/r8bq0eEyG/WVq9zE5873h00oUqXSM
 SZpOk9oi747zzxYEQ9XQ0mnsAca0iiOSZtefUq/doS2xXszcaTbVF0qHvfLJEjoBJzzaZlhKGGQ
 FolH0o5H5NleUPZ4p32JrpEj0mJuNmrAPgePcxmnI4w973SEMNDBYwsl0IDLz/fEqxO+o1hgoN+
 oeU/VVvjt4xquyirKgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067
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

In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
boot even when CMD DB is not strictly required.

Use QCOM_SNAGBOOT_MODE config to allow the driver to bind
successfully when CMD DB data is absent. When QCOM_SNAGBOOT_MODE is
enabled and CMD DB data is present, we log a warning.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- Remove QCOM_COMMAND_DB_OPTIONAL definition from Kconfig as its now
  not used

Changes in v4:
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Drop these warnings if snagboot mode is enabled since that's the
  expected case
- Log a warning if snagboot is enabled and we do have a valid cmd-db,
  since that isn't an expected usecase

 Changes in v3:
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef

Changes in v2:
- No changes
---
 drivers/soc/qcom/cmd-db.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d0a6047b8a6..c94a90a2903 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -252,8 +252,19 @@ static int cmd_db_bind(struct udevice *dev)
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
-		log_err("%s: Invalid Command DB Magic\n", __func__);
-		return -EINVAL;
+		if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+			/* Missing CMD DB is expected in snagboot mode */
+			cmd_db_header = NULL;
+			return 0;
+		} else {
+			log_err("%s: Invalid Command DB Magic\n", __func__);
+			return -EINVAL;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+		log_warning("%s: CMD DB found in snagboot mode - this is unexpected\n",
+			    __func__);
 	}
 
 	return 0;

-- 
2.34.1

