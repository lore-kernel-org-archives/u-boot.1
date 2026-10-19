Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06D4CCF2D5
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B84960782;
	Mon, 19 Oct 2026 10:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XEAWETZesO4X; Mon, 19 Oct 2026 10:54:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4DA2606DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407276;
	b=ZBbyQuD/KjUOPq3U5AhzoLP6EKfgDI9IMfnaFO/HxIwgjDL3fuVXVAfumpGufg5pfzcK
	 HAjQ0FLwTUf3CVXZh6Y6rzwu9osL1GeNHeE1WqaZl6e4Qr5JJfRMrfK8KWf7lo05XkUvY
	 uj4iGMUPOZp6xOrOWwyUv4yzotORS77JMvR8l9Ufr4SorM7iVtvVFDR6Vk9IXb8co0HE3
	 Uug5gN7UPcpKQ//JmPE6oi35fegA5lohlC3jFXyq4F/B/IhsmAeC1nAOWPLRrMdneMfet
	 gAqst8qgMYZ2evowx3proHsZkuiVPeDQc2NnPNP5+2GwRdPax8BWeqm1kPRo/s7KIwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rbng6egp13+1PftwqM64u3dSDC342NXH/LuCpCGwED0=;
	b=DbUie5Po6bNeieSTi/hN4FZPPksJ4TFnhatQu55IdNZb0PdRJw09hl8m1JmrlHRWVwHE
	 Vnqswfu43kGo7x+lbGjsZloy6+UtVwUu6qxq0Qls3NCsNiY1wPexDxvqi85vLUdPfuyQb
	 Lk6VGnjbMGGZL2qinwVqHxLMI5kFtHJYy+hHDno0sDDwjwX5tSpuOIx2zFMl1NgIQ/Nao
	 QaQm3Pqe0WQzvcawj0LX+rr8FFClmT2ymEdpRFr7H5RzTJRX/2qKQxULA+JIgF6YnrbXK
	 J4UxEHSmBkKBiwMgm3Fynw7DJ2PsGZUML4SCs6va0lbT9qQfJHToL2CsLB71cnloHFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407276;
	bh=rbng6egp13+1PftwqM64u3dSDC342NXH/LuCpCGwED0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dawImz1YW9mwtmePgGxVhTngyJk51CXP1Hl/q+EHiGI320q5bVy13N2PCwfyUi1Pt
	 cSTr/zmQy2lNEeC5VrXo9U4fKXk0d905lwbYoDPpH7PzgDCdxDXkp+Kty19hWGLCZe
	 7/KdBfuX/KvfLjZtUX99SBxXRB3AnESTCI3Qti2of8ZRXobmvmKZQ/Thuc7+jyOstB
	 FqZ5tZgcVosmlDNBL+2etkWEeT12gXLngjvaWnPhNUBG8VSN8ONnf9Tbwi5Gew7vdF
	 mrfk3psKDhdiT/9UtQ5OO+XP4dHdRXvcGG7ezcF0usyMCLd/cgvuqb0aQskmOH08gr
	 YbFuisi15z49w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4DA2606DA;
	Mon, 19 Oct 2026 10:54:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 18F9E263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F312980E0D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bk4ACSAy2cdi for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:54:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6130F80DC8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407273;
 b=ecR8UIq/1RgVAQokf7VDrGdvq5EcM6cWUX7us/OJGxFD2P0Dk+lNGwqo283hNt/AQr2X
 h5+/OfGjn6si8K2uyze+Q4LVEcmuSKwYx0dK4L8Tj2WEX/CIB5qlIyvrnWZgZ1FPtOXGm
 KKKsvK9M5Op/TRkI+54RaedE1GQJx46A/kjukEy5kb4aRupspgT97ZqrreAu8ra9VPFHr
 rGUvoSGXpD0WYaGkdmuDxBk4L6DR1MH+s5Dpvq1fNhwzSlQS824zkjT+v7i6xPVQCuLSB
 TBSqGMH897tUgJizLo0i9UAI8NTN4/eCORNqJrTlDuOuVxqicj4a0wipnXlLM8moMjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407273;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=rbng6egp13+1PftwqM64u3dSDC342NXH/LuCpCGwED0=;
 b=b9kbreiMO2EBHIV8OkEB+v0gCZ58O32FVzuOOnUEd/z/+g6e9ZuhTq5f/cXT+sYJXR+S
 2HE08X4FFwCq3rj0EuyekJVMbTTW5SFcypLUdpQV4on+QAaaKY/e391N2Hi9CSWgYspus
 o1rOW+NOAPt/FcFRItNj4VavW4gAWoq2+L3UQC8A4QT1tdhD5LvKNE8plJbu4kIqWcl3s
 w6iDnpMWBAsJv96g5TNUF3L2wyTBEPvRRJdKAPxQ4N7D77cjQN9KqSYmUpQ53/e7RALl8
 yVlEj9f1TRMqOcDJ0sTnfJFdBL2CGXSYc8rycaBgdw0pyC3ROXIqQE2e3vL4N+ptyfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=kg5rO3iE; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=T01V9m2M; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kg5rO3iE; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=T01V9m2M
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6130F80DC8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:33 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Olmo1348069
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rbng6egp13+1PftwqM64u3dSDC342NXH/LuCpCGwED0=; b=kg5rO3iEsLcVqd1M
 6KAaYbsOVtHRclmM1/8tzu/v1aXnoKYuOh+idHZp5XRDVyrRZcrLM++0eMTMLFc2
 TY4+JnM3a8mLUPJn+IgRe35XbbB7o0ChLsXd7CN5roPHhUtB/ibZbq4BiY7MAf5T
 s6rTkOnOkSmTsiLUDZcv7cgYvSQV+OBN7VsD9sZq8k7rXXTT2WHvV1fK9CH8mcAd
 6aSu5T0ob6thO/okIJf06qmTlobC9Fs1IcMNIvuvqdLGK2S4Gr1Xs6cwKrHtIlfK
 JyY9uYsw2tQcJDjZpWKb6H52oZp+XZ0ZmpV9MHJ/ba86hK2wP0ZZnQrOaUqim4GK
 jsUNLw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rgpp8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so6190385eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407272; x=1793012072;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rbng6egp13+1PftwqM64u3dSDC342NXH/LuCpCGwED0=;
 b=T01V9m2M74oqrb0EDJdrOe0o6EQ3dxPKOWQAgs870GoNxKos9DRuItg9VkIWIqUUoq
 Lf4o1g8PguEKGsMGUxPwafhErNnODvOTp4HOhXBatxX/Og5OEgEURk2+ZXZrN2jV2krb
 R0auiJG7Ewvv5CJyjz4nEQP25CdFgGLUQvpeylPRbgxWwvQcCGfV6u+VVUsJDWXHVGED
 BNmZcLBRm+04Nz2RXEPsCSvK0gEvSokUZDhMp88nJfAfi1wuzFq676Px74qfex1fQwtz
 nRoOmyWTKBHt00Yqd8nD4wXe7Ixpu2sgiJr6ymDvUZkj+eM9vYdFJl2MQJYvt07Z0btG
 p4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407272; x=1793012072;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rbng6egp13+1PftwqM64u3dSDC342NXH/LuCpCGwED0=;
 b=GYIFTqBmAtd/1TLNBmnhdr9beIwHFpfazwBjb7PzGEW9RqYN57myWbRDhrgQApcOcO
 qPAd0wSbE6MOy6rufn29Rx+3T/1z9RS5JceJhNCJIK5Asas/Y6TJL+zwf2PXYSst/7Ta
 e+K1DkiPrJ/NJ5/W5U1OlcS5evWQ8fYkqMv2eUnRneLE3ADZsMwwvqZUqIdF6pmqjOR7
 7nB6VjPleEKHGBcwjtWkwP7ZVNTht7Oor9f5qGZSQIUMSt5WpbTbKhakGgFjcRijuJgV
 8eAtlglPFvsrPZXR3hBEwoszHCIxLackARVhk9T06MEPS2f0ba63sPD6p9J5kaWiRL7V
 goiA==
X-Gm-Message-State: AFq9FYJGOf0um4wJohwGugKjB2zBK5x5uunt69C8T4lkfisdpzxSgRDV
 +Bd7n9ouB6bRKVeCHbOve+wSyJRED/R4gZ+ZwY9lFCwTvaJjaZ9ZBSDyxtbaFw3cntLUCWEfKMe
 3lG1IWDhusN+3nJp8HNW0Hnn5i4wWa8DNCjaq1HbKoeuGfyr3mukhLQ2KeGe3kX69OGcF6mc=
X-Gm-Gg: AYBFou3/Ayn318BnhnBw3Hfzf3sbGsAmaQUvotRFumq1BKy0RypLvdK50zopSqDsNcu
 np3k0XfNIS5RLaViWYOWVuEpHKLLhAj7AvWJhBRxCDtnFnXAB3rMrc3v0D4kHXIPU7fLyxSnEmn
 4fIB1Mlshk5uFsrYLLM2ndbJ8bMkAzfpUqwGVVTLfN1WRderkgnMYzUAuWf8ep/xU1f1mRUkB5V
 3+hiQuqKHZSbDZdlRSob774kzb+Wi1ZmYX78cQnlMrBFTvmyixbq242P0e2MsZQ2AyRmKnGrXJf
 2c7J1TRqQnxgVK86Ceg9sYdNWMq7POkEbT2zHodQx/kca0ewRSNnghZ8AR9gno50+ufjm7f3W8s
 sj1UhurH9bwPhSNS0LqQf/pUr0aR2AlM/JFuwRW5mTOCHeKu2qcsw57+RYaHb5ql0ZUrrEWKgbb
 GnqV4IMxiJ7zfncBTxSr5EBKlhK70A
X-Received: by 2002:a05:7301:da84:b0:359:3460:bc1c with SMTP id
 5a478bee46e88-361a1370570mr11133493eec.12.1792407271843; 
 Mon, 19 Oct 2026 03:54:31 -0700 (PDT)
X-Received: by 2002:a05:7301:da84:b0:359:3460:bc1c with SMTP id
 5a478bee46e88-361a1370570mr11133460eec.12.1792407271310; 
 Mon, 19 Oct 2026 03:54:31 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081ab80f9sm50709421eec.12.2026.10.19.03.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:54:30 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:23:59 +0530
Subject: [PATCH 5/6] soc: qcom: Enable phase-aware SMEM driver compilation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_qcom_phase-v1-5-2d8f7a1e6730@oss.qualcomm.com>
References: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
In-Reply-To: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407243; l=1448;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=uLdWxjjNhwVUxIZo+lSI73Eoupe7AugjIIl8g3Atjs4=;
 b=YfcCr0uavo79fLCJ3qyRjVT5wGfTpXauelJsRDEyiJAyXXwI1r72vbJrfP1yPzakGgOMBRmnq
 DlF7VDBccypCQ3pvtdgw/clr1zz6NBeZKutTQqtMKywEP1XfUB0Q/gB
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: u3d_yCHsRfTnHIm2b6Ei4Fo1b0TCNx0I
X-Proofpoint-GUID: u3d_yCHsRfTnHIm2b6Ei4Fo1b0TCNx0I
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad5f6e8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=V-IX-aArGZJJixLXkpsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX051QaP2gsLw5
 GYPrfL3vpVrJ5K7USA2STLdGZ0OJaQ0JieKwMDxgXcNkpqauCN4OtEvheo6bCO8xMlKK+2SYrNo
 5c9B9ut1B/Gk5Khpk3673OcYpdXwp0F+Rvq3Nkktu5KWY43Uhw9XlR95n6t/57hmqAAI6dSewju
 WfD3f9pYLPrBgGa0AtomeBlaPFzzXzsC5JryO8mBUDJhr0b+h19mAsJWEmv6Jmsvf+5Bft5n2zv
 5EOKYANMaJ0No5sr8t0es86+v6k5N7lobIce5fNawRlNAPRtei155gn91X+8rKD1twpuEWLMbnF
 yN6c/aFm1gonkMaljg65psbZVcjBROxuMA0R5kLcz37OsIYBJuPBZ8iMwf2+vgqJ/6pLRUjas7Z
 /2upPXXINGnxsyrexU+el1jGvW7vgJwA4ZyRSvN/7r/bNESHcp3jB9clKU9+4YnyJ+Ecje1EQpj
 YyIvm/QTc4kGwjBn+tA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX1rGrMeMRng36
 ag5tAQnwzwFZ0M06XTGdDpisrt04K416dXNE023+w6vkMddZWNfSkiyRGvTixRhULvR16NHnese
 M3NoZcwuFPJ+NhVCw3Tg6MDZye5df1Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190043
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

Modify the Qualcomm SMEM driver Makefile to use the phase-aware
configuration pattern CONFIG_$(PHASE_)QCOM_SMEM instead of the
simple CONFIG_QCOM_SMEM.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/soc/qcom/Kconfig  | 7 +++++++
 drivers/soc/qcom/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index cdd9e30f43e..6fec29b78a9 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -33,4 +33,11 @@ config QCOM_SMEM
 	  the hardware (e.g. DRAM layout, PMIC configuration, etc) between bootloader
 	  staged and the OS. If in doubt, say y.
 
+config SPL_QCOM_SMEM
+	bool "Qualcomm SMEM support in SPL"
+	help
+	  Say y here to support the Qualcomm SMEM (shared memory) client driver in SPL.
+	  SMEM is a shared memory region that is used to pass information about
+	  the hardware (e.g. DRAM layout, PMIC configuration, etc) between bootloader
+	  staged and the OS. If in doubt, say y.
 endif # SOC_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index f4102f9155a..a0423aa0927 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o
-obj-$(CONFIG_QCOM_SMEM) += smem.o
+obj-$(CONFIG_$(PHASE_)QCOM_SMEM) += smem.o

-- 
2.34.1

