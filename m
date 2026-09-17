Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E79C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C181F807B6;
	Thu, 17 Sep 2026 07:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5CNggS187_FG; Thu, 17 Sep 2026 07:47:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9AA9B80E9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631278;
	b=np2y0P/9mY30GT2OX3MkwYSKs+SQlCJ8P5lqMPyK9pFCgCHzmvU0iIRQt3+0xCpHj7j+
	 k7BXac4vtZDOWOfx87V78UmxhJVl6rUu5zVC2wSuetwNjdu2VeVEIOXUf4NiwNr10GEvW
	 i1C4pj1KbxS4v3YFuGNfIKACu1M0oexwTQG61qaB1EwdLXi/1TU1YkBFyTcMG8oQny3Hd
	 R7go/0vDWb8ecHR4CrJkYj27p7p4bWmdzgzB4vz9ywWes4D+fniO55fYasztYBhi2A+2Y
	 6uEa2xk3+QDZddZW8ae2Vac7XgjxcY5hK/flCHiMfffIkBCNH1m1deBOMUToQtKgdMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631278;
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
	bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
	b=rnMUoIHyDZgIcFtJoCRyPlrI7ec1Hy8Q/s5s7Zy6c41Ch95rUBPBbbE0YJa2zCeo6RmS
	 DtcUyCXEgF6VIzD0zTszdGjGuZSHDYtLARCf6KrTsUaAAHIxtV0IK16aPEwBZ6ZQxqbqt
	 8DIk3Y4ZA5AqVQc1ecreiSuELltcToPfJijjKqS70335MUP3QPtLDxcRHFzM0tUtw9aWS
	 WLMF3pDQYtSo8+NgH9Tsa2FVgn04Pg57qmjzs2Sx4WO0Ke4jyn0MAIDIMxFw7Vmg4JpZO
	 mzFvYC3gUvFI7MLQki7/MW/ZvPf95jI9I65TSGigMRNKmSjNnMqqy4gO9JJSMqia8vA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631278;
	bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xa+RiJpMcWWqx5p7JztVESSw2qWoa5j30QsL/BuFUciCw2DHcZYpKvXhxlldon6wt
	 a0h3zjiRB4wDS8l/nBygFJSItR6n9N5ZknGDflZ8kznQAU89hLohhgyuiGppLp/jVi
	 p1v44/xPT1BDC3MPdZeQ56+m3I7gzhBuh6bt3pn4yHcZgAkFW4YtlxP85kG0yFAlsT
	 FQ/d12Ma9XnVD5tt9zig/C63Gjs6wUKTQR3oy6BYhVaYyepB9K/gZKNmDrDYqln7/j
	 yrHpZD7pVRF3SFxnwkOVvwIvXb8K1gCIq7QAbHl0Q+NmAYBytEg45S5g7sFxtmWfLx
	 bM+GZO6VOY/nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AA9B80E9C;
	Thu, 17 Sep 2026 07:47:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51629422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 432986075A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsgAaaqQDM0l for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:47:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6F0B060659
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631276;
 b=igv3I5bBit58h5L/JI1uUiWYbHvKwbDtYDP41XePZmq+z426X2cemCYQ36g5B5ngwZrV
 3WRD7vyhnq1bgAWT/S/y7MmC53LAy4GUd47avcz5bjdlhn1r40SWaONOQmvIp2FGDRXN7
 GA0d3Ul8DIGXPnEhV3IAxkQBFvmt9l6DRaq7AqvrIgn+D9hKVDNuECg1ChLQrC58NmM/K
 Yk9pnRgFLluhZ/7ng0lBc0LMW3Rh/tGWHcBkSPSJrLa3ddoAzqcyRHVYB2UqDCPbJ2PPD
 qguhogm/x6pwuw0W8FPKZCsby++2DRiiwZ1M5AevuMWnSBcTxKQ7zrgj8svR51ubQrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631276;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
 b=FpodZ+fJTWy6ZydF+k8kX+r0NjvwglYfwtSKlbNnLaZeENQh3eJYXQgji+XJIPbhhdR0
 B+ju/tf5xB7/NJYif9SxDCfI5NAoqgm0nEasMWrR+bcmcFMpi9nlm6e9/VzQlEqs4duor
 kluRfjNpEGyzjVwKlbBy3eJ10fQxdhmTvBvmmO/DnXSlhFJcpO2MpavDKjjNPwsyMy1Ha
 dqXc4cTe9rObb4xDPoo9W+VcfwUcXHV2bracxs9FrejfrPcIkDT/ysjutWYgT494uR0Px
 hTr5gl9J4tITXqsLMHnR+/vb5dMn/FE0mjpbw3gO9FPRhaFuGZ/Eaw3ZKedvkbns/MA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=YEDaq6y0; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=P6oW7FRi; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=YEDaq6y0; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=P6oW7FRi
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F0B060659
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:56 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H6086d091719
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=; b=YEDaq6y0jKbsuVfQ
 hA9R97NqLAF/nZu2Pi9vTtuCDLEyHttC9kGP2ZLWtWkPb4/r80dzWAxqpepy9P9R
 MqhDvOiLL4ZqGA3d903E9mW+Vkg9ka0qmVnY0e9sSlYewS0dkj5/48Ih9PGFMUZG
 CGdKPBvUIMJ0G+Fp6NxFtK9Bea81FshDz5R1dJyKvrH2ewhzBAVRcQdX6lCkzZDQ
 jESZ1Gr8oF8ZOZcPo+t6SY/v8A8OiM4jQiQjCmDNa3Q2mPMwcOYp01wDne1vYIlk
 dk4mWs3cN85yH6YOFoXn1HSeni2mhoG63hOi5UBRpb42Y/eK1Kk6uUIQSwf9LwYD
 6/3y2A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw0sqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so591728a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631275; x=1790236075;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
 b=P6oW7FRiPrrAdmoIXAJt7ogXPP7Qy66PAgjigZvKcxSOKieA8lFLalNnrr1GIXtQ0d
 SI0ZgkHPnTLSmg9ttCCejHIoE8FB4omjD+aPIlWK1XNSd8sgpsc4MA7skZkVZ0cSpMq9
 Gz30NwlxXNckfVUuiB0yRvH9DdFxPh2v70vbB166KvSuEtCyoio2raDvxCekqTzoJi51
 o5TVn5C/tiQQaUB8sqrCoOECxAXgtgM5dKDD6NJHXdL5eNMgJtC555rD1s0qXjaaVg01
 8as+n91t+Qc2lGPbNtGm+614Dl1EbPZKa7AhpoW5bz0+gYgRK6dZMrfV0Qy8N+1ceAUD
 rEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631275; x=1790236075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PsDTcz6+5glb5rywMAXEdZ3tLUxJfOqcDIdJ3hpAV8A=;
 b=yPsAMdkqhPUXJKcjo42OGQtW3gJdj8aEgJD0D8iIqsSfwngx256CTpPw6EShxKy/Zz
 /YRT0uPLfXln6j3ZXt3ZA65yTTuI/vOEOA5z2cYScruNlUSaHd0CzftOTVXYOjwQIid+
 L2hooI0AZY7nfw0qFGg1CpTDqbSTxVfOQK27n2lUEUO2xSdFvvWk7aaBUOPtVWEs8Y/e
 j9g5DUOPvXPuBKCajBi1BhkDw7qiUrJQIKH0F9gIKL5cuLXgBMZVlrNU2nELvZJpGqNP
 eRldW/DjyqGy1GACUpMe7e45QwiaKy9cNDQFRhkpal4D9lpUxfbzb77iNCOJCLaAZAHX
 8u3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwOjA0znaVMvUUxibKAoDEVqcnT+ep3lmJS5AWPjl8Ingmn9+CWsHsk95d5G77bLK7SVp8+XIo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mVxspu2rqP/7BbeEf+XMjkNcrWifqpDMnHNiuLRkUCwd/Yjcbs
 awWUz5FU1oNRaXE/0SalVkD7d/dZYS2lX80oe95fMLucAD4IyIK1PWHzJiL//JEz/uQKNleGc1o
 Xe1HEWucG5wugHNyNkg+SnZe73A9myBLYKp8xBur+8bDgkVfVESzboeaDWLAKyrTZgZFqbms=
X-Gm-Gg: AYBFou2y4AK/SspRsjya0WBYe2QQJhtNWKj9j5y0Unke+nOvZ0QCtPnfNvIY2WBch/7
 L5jnFbkFc8idvrwnNtJwa7MldYK9I9MSRNgAUWCmLUd6mqXdMAFCHlAOU0jKS3h7xL4L4K1R1UM
 /LvFaWG0rASvk+4rsclYqpWoWwL8eH7mXgSLlQv9V/bzyivihQqzg55boIVF9XsBWPWcnDR3gfh
 z64AcnaMugjg1uQiZD76rpa8nELZUDi9b1fVHFl5+7DqMLb1NXpYD9jus2lpd5+Y8CqblDiel2Y
 oUgNzJPhkTIwQowmWFqkQ5Hqcq0sNXTVxeDEDz6oxBgTvQQU2xn+w7WYGi5yibIXBYL9XrWiFv4
 ZL87HWLPq74F8OhhN57Nksw07ZvcbNUXAIs87ISplkUwZu9YlQBJLpE+dtqtGr5ln088CuxDvXz
 xTy5dcXngx3LZpSnPF8nCEVetdXXvmSw==
X-Received: by 2002:a17:90b:5806:b0:39d:e78d:32d2 with SMTP id
 98e67ed59e1d1-39e35e4bd9bmr3896212a91.13.1789631274732; 
 Thu, 17 Sep 2026 00:47:54 -0700 (PDT)
X-Received: by 2002:a17:90b:5806:b0:39d:e78d:32d2 with SMTP id
 98e67ed59e1d1-39e35e4bd9bmr3896170a91.13.1789631274254; 
 Thu, 17 Sep 2026 00:47:54 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:47:53 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:42 +0530
Subject: [PATCH v10 13/15] mach-snapdragon: spl: ipq5210: Add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-13-3e83dcd239f0@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: CgIC7Ixt2kNMTZmMSyW8nWirmOYBdWiE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfXwYklPO+ehaa7
 zfsyJ5GZh33keCGrk597ggNw5Sn+RuiB/Obyy6o0aYexbWKCOjuksBczffYPrWxbeciTl9M2Itg
 7OBRxzqBDaT7NODjbVwFn425xUCInaHMR3d2Q4yPl8al7hCgSl6EIiFOZz5RCVowwe7T5/RZkXb
 k3qs1/t+nUD+3ZOE5C+g5axA7RLvtGLL/u3nPvxybBAPjYPCFXbfdQKx2D1hMJ6PHT1SUd9XF1h
 dLhStJ72JXNxWB69t+AdiURfVW9GUu+CLwGrS5ZGTyQLgVuk44xs6uEMEr6mUFWNKvB6rjYZkxZ
 SsktzXFk1PhmESp40nux+tP/yEFJjS4HvuOd8vcQJJUbOtNfpPnzeeIKQANyxikXqoTdnPzkvB9
 vT571GKfEYAxNHT+0r7rGqpwXWO/N2w7ZQitMwdWoCeDuQawy3VxybZvMsIZayMeYu3woNP3h57
 qscMC1B08l/5QZfatgg==
X-Proofpoint-GUID: CgIC7Ixt2kNMTZmMSyW8nWirmOYBdWiE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX3ifb5uL3VH7m
 tRW2rBcvLkT8mQvKovm3uE+ERj/K9B2X6Rn74WLMuTxIpA8ve/KmBPNzMx8LLcTtSPd1bCtbt/6
 DJxVjwhSxKmd8fyzL3OrL6q4XbAikcc=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aab9b2b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=-zc8TOuOcBEM41oa4wwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
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

This patch adds the basic board init routines that invoke the common and
mach-snapdragon specific SPL frameworks to proceed with the hand over from
boot rom to the next stage i.e. U-Boot proper. This also provides the
linker script to generate the SPL image in the format expected by the boot
rom.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c            |  2 +
 arch/arm/mach-snapdragon/include/mach/spl.h     | 13 ++++
 board/qualcomm/ipq5210/Makefile                 |  3 +
 board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds | 18 +++++
 board/qualcomm/ipq5210/spl-ipq5210.c            | 99 +++++++++++++++++++++++++
 include/configs/ipq5210.h                       | 11 +++
 6 files changed, 146 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 2655803b31e..3293eab8f81 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -12,6 +12,8 @@
 #include <spl.h>
 #include <soc/qcom/smem.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 /* in SPL, we always use internal DT */
 int __weak board_fdt_blob_setup(void **fdtp)
 {
diff --git a/arch/arm/mach-snapdragon/include/mach/spl.h b/arch/arm/mach-snapdragon/include/mach/spl.h
new file mode 100644
index 00000000000..50cc8dc4e8f
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/spl.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __SPL_H__
+#define __SPL_H__
+
+void qcom_spl_malloc_init_f(void);
+int qcom_spl_loader_pre_ddr(u8 boot_device);
+void qcom_spl_error_handler(void *arg);
+
+#endif /* __SPL_H__ */
diff --git a/board/qualcomm/ipq5210/Makefile b/board/qualcomm/ipq5210/Makefile
new file mode 100644
index 00000000000..d808c106524
--- /dev/null
+++ b/board/qualcomm/ipq5210/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SPL) := spl-ipq5210.o
diff --git a/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds b/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds
new file mode 100644
index 00000000000..f0ced6765da
--- /dev/null
+++ b/board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = CONFIG_PLATFORM_ELFENTRY;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/board/qualcomm/ipq5210/spl-ipq5210.c b/board/qualcomm/ipq5210/spl-ipq5210.c
new file mode 100644
index 00000000000..5fc42e64c11
--- /dev/null
+++ b/board/qualcomm/ipq5210/spl-ipq5210.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <hang.h>
+#include <cpu_func.h>
+#include <event.h>
+#include <init.h>
+#include <image.h>
+#include <linux/string.h>
+#include <spl.h>
+#include <spl_load.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <soc/qcom/smem.h>
+#include <atf_common.h>
+#include <linux/err.h>
+#include <dm/device-internal.h>
+#include <part.h>
+#include <blk.h>
+#include <dm/uclass.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define QCCONFIG			"qc_config"
+
+/**
+ * qcom_spl_soc_qclib_override() - Populate ipq5210-specific interface table
+ *				    entries.
+ * @table:	Pointer to the QCLIB interface table being built.
+ * @fit:	Pointer to the FIT image blob.
+ * @images_node: FIT "images" node offset.
+ *
+ * Appends the "qc_config" entry and a placeholder "qcsdi" entry, filled in by QCLIB itself.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_soc_qclib_override(struct interface_table *table,
+				const void *fit, int images_node)
+{
+	int ret;
+	int entry_idx;
+	int qcconfig_node;
+
+	qcconfig_node = fdt_subnode_offset(fit, images_node, "qcconfig_1");
+	if (qcconfig_node < 0) {
+		pr_err("Failed to find qcconfig_1 node in FIT\n");
+		return -ENOENT;
+	}
+
+	entry_idx = table->num_entries;
+	memcpy(table->if_table_entries[entry_idx].entry_name,
+	       QCCONFIG, strlen(QCCONFIG));
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, qcconfig_node,
+					       &table->if_table_entries[entry_idx].address);
+	if (ret) {
+		pr_err("Failed to get qcconfig_1 entry point (%d)\n", ret);
+		return ret;
+	}
+	table->if_table_entries[entry_idx].attributes = 0;
+	table->num_entries = entry_idx + 1;
+
+	entry_idx++;
+	memcpy(table->if_table_entries[entry_idx].entry_name,
+	       QCSDI, strlen(QCSDI));
+	table->if_table_entries[entry_idx].address = 0;
+	table->if_table_entries[entry_idx].attributes = 0;
+	table->num_entries = entry_idx + 1;
+
+	return 0;
+}
+
+/**
+ * qcom_spl_soc_post_qclib_routine() - Cache the QCSDI address after QCLIB
+ *					returns.
+ * @if_tbl:	Pointer to the QCLIB interface table, populated by QCLIB.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
+{
+	int ret;
+	struct interface_table_entry qcsdi_entry;
+
+	ret = qcom_spl_get_iftbl_entry_by_name(if_tbl, QCSDI, &qcsdi_entry);
+	if (ret) {
+		pr_err("Failed to get QCSDI entry from interface table (%d)\n", ret);
+		return ret;
+	}
+
+	qclib_set_qcsdi_address(qcsdi_entry.address);
+	pr_info("QCSDI address: 0x%llx\n", qcsdi_entry.address);
+
+	return 0;
+}
diff --git a/include/configs/ipq5210.h b/include/configs/ipq5210.h
new file mode 100644
index 00000000000..5cbf838af82
--- /dev/null
+++ b/include/configs/ipq5210.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_IPQ5210_H
+#define __CONFIGS_IPQ5210_H
+
+#include <linux/sizes.h>
+
+#endif

-- 
2.34.1

