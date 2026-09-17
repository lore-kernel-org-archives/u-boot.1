Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F265FC982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B61E280DCF;
	Thu, 17 Sep 2026 07:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hXv8g-ceeaqt; Thu, 17 Sep 2026 07:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CF0BC80DD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789628406;
	b=e/Tg6OG0dVMD9vhjenNtWd2FDCmJ/YVOMmtbO6WTWo88luSbSL3mpmIBZ7El+sYOCQRH
	 ug/SSoofIaMI08NQQRXn4MM4BOlDQgNhSWetPNg+tG+u8XvA+BwLhnxI8SDG4MDj6NbHy
	 tf9tU1ownNOV5It8WUr/zHrkOy7DwAX4vLkqZxS9EV/IN9tXBx6eLC65hz5wZWdjASVCJ
	 6rfqXJqdGb6VbOZJGjZsdQm1QMih0s3+13GgXqSvS9S8g/HBWmYROAmtPDbNqe61tzXq4
	 VxvPsOsu173k6GWmTo++JDxGElo+MQ4HYCU0a5w04qB29Zs28nEjQ3nFg3SWxv66ZNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789628406;
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
	bh=BPvJvqf3csglTPg/PJF01JfeSFOjA2mHe+PPPkscl+c=;
	b=nMKCGIEq6bEN0NY8YqA7saZpBPpGGVtrCC9bT0GirXKg9WnOptWJOBRgEYQluya/q9Sy
	 fq5HSRM95wfQb2u26TyQOCU4Vua69YbJstdD+DTOc3dKr70uQnRwmE4HGPJE2CvWw3Y0k
	 +IfC9KDVSv5ZuLWyhUN0Z5UJiscRDnujw7FiSV18lPer8toBDu8UrV5tExB2BR74Oagrr
	 5nW7wbVc6662AWfPd7/cPI0E1UILluC6yEMZZ0MLTK2W4pRHtn3hApcUI0zeV58ZCQr7c
	 CrpD49Mf6O+ixvImAsZQSN7hUTSKjDpjU67nyySJ+5TGX0JC06ZTH0DQxcRpfenx47A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789628406;
	bh=BPvJvqf3csglTPg/PJF01JfeSFOjA2mHe+PPPkscl+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=prBDAvJOTR0s/Lv6qdcMuEGW3OelUUb+uX9NztTt8SJPgMu5dzWdgCbRqzzqW2OE0
	 Wjmn7Z5WUWPRSuutQvHaa6qQ+nBRtTegrsD3qvUbB3ttDZ+74GXEtVYfx6UBflEtdi
	 93gGo96LS6qG8EyGIcjxxHDit0hRg1OBDjOcYlR6l08I5YPkLhHH8ontgv7FaNgwng
	 mS4yk4nT0SkgOaKWvGVGxdGpF/A18hLopVGJ7RVPUtpydjQUacIy3ng8g/GJOcJCO8
	 BFJg54WsnCWH2fIuIRYrEe3ZlQgZjFFNBfZ2Y1jGo/LgD8jVA7TkbQCAZp9URsCIOI
	 im6RNqQGiGo3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF0BC80DD3;
	Thu, 17 Sep 2026 07:00:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CB9D43A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AF2040755
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GEznSAc8zzF for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:00:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 458A2406D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628403;
 b=Gmn47QFrADMYBq7tZJD8NMnfEJAhybVEcZVYa1kKkFFakC4fPLYal4soEAHhMPAQ+FoB
 yuz6/Nb6qLKfbea/zPmRX5/prO1ZmMUiXVwY3f1YHqhYQtlOjM9eBHZo8fHcKt2b5B/1K
 Do0mSyXktFJJve/o3u3l1YNjpEvgdCrMyNwbVheeVWZ3TjQr2GhPvOxcVOkQEfJPs6yvt
 mpLoZNZgUocAt1reaYOmiCSdRWV81rwVYWo5szUTvf1uorYKMdoKYmfGNS0v3cVp8ui2q
 DQbyVcd620woO38Vlg5zlhwRAeddnnai1kb2QK+kTD5BWYQYSFxOgm1nUQ+ZKuJbs2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628403;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=BPvJvqf3csglTPg/PJF01JfeSFOjA2mHe+PPPkscl+c=;
 b=CIhKMcaN+mxE4T3PsYPPYSvSi+L+xRgnc4Nv59kFxod99dgqNbdcPHFDNlzHpoPsvxlC
 U8sXGswwgjmbausd6ufHMYpoCQiyQb7DFacuWe9toqDt4sFN436P2Etfv8acpKKm9GIPa
 7XR1DcLrNa+PkTon5N3d2O2NWLwRDhGvBWbCCXw8SC2m/Wp9ikCxP4WN5QUvAKiH/p40K
 uFiBXGQSxMNv7yN5vwyvQqJd3OYXhAsR1UgjztSWMT0pDrOy1btPIaDMhIiBmfx28JPCj
 oebBWBWAu/e5wemNZCuZMHG5gepq398DCZLOpiVaUsacvAEHINpxvJZhz5wckR3ZqFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=lg4z4Z6B; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jombaUZE; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=lg4z4Z6B; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jombaUZE
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 458A2406D4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:02 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H61X6A133564
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BPvJvqf3csglTPg/PJF01JfeSFOjA2mHe+PPPkscl+c=; b=lg4z4Z6BxMORGRv8
 An0wdj/gVwNd5Ng1+fE9LP9/GbtGm/mW6FclKT21OVo91s7B3i/ashN/4dkMoqc/
 SFn/Hqclrfd0mQCBwbCU4/J2EbpFnxdPYgiQ/3xe/Xp2iclZGiu+riIsTDZG6vXJ
 8xVzKIu/80JLzCcJtITtn4z+sfUL3NPTqAyKnjqGSB2EguD9EyHahddfDnPxJcBb
 oue3g/VIcEEXNEEDqgMA3Or8LA7z4s7Z1V8idRCXPVEjbLcpCz7fBZ/B3Ry9YNGN
 Z1SHcgDDv5jiPibHss5ZEL9FAaYVWiyhGI25JebbYTDExd+3jWyd/UR5oWWgqWyL
 c+xzXA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqtn548m1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:00:01 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc4fc935a11so452713a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789628400; x=1790233200;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BPvJvqf3csglTPg/PJF01JfeSFOjA2mHe+PPPkscl+c=;
 b=jombaUZE7hDonXU/roQXnd5yCsi0YJiIWXEK9vafFsFrXiwIrya9EsqW66nk3iMcqS
 QyT7MHv/Hg9yrntaSaC7GzA9pdTw9Wm2AQaMlKgVEIiiKC5SWHSEl+2HZctjxb5MiF9V
 Z/hcVVGo8EhKhhMgZ7MTuOl1yLUEMovSMR2+6ZCc/XO5OGIVfvaG4uN7SBp5435icDeH
 UX46tIGWp6nib40Lb3k7sjY24EKMCjMuSXEOzu+L7ezSYAr2lV576fly9pxnwQM9oWFe
 hNBOSjv0D79HrOzNV/QLsUbgTdkCZL+A0yBK2qzCNCS1EPYyhdg6DlLmLRumuAXo6k6K
 XSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628400; x=1790233200;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BPvJvqf3csglTPg/PJF01JfeSFOjA2mHe+PPPkscl+c=;
 b=YN7LYFZEPNa5L+SkOgouYKZRNRJs01MmUOnRZGAS2zmMV+oVWipzMX1h/NhNFxGBjU
 Vrz/1EjBjAVtgVpOgHtPjLLJSNRT8ysfh61//0hZqIsx7bvooR2TWwXPH0FyP0uVrq+G
 23qbehLZpry0R2lXwWad77Is4oEq29ZzqkAuKyXcufD3EhjnFN0RJUHr/Qf54lzt07Lu
 R5kuLdXggDWJY/M+bpSvize3W7xIWsnSg4T2naJjzyt9Rzz0SUEB8tmphHk8vRLBCLUC
 jnKio0PRuXj//raygMoUnaxEJO2l6MxX8uJ7u55ONOyy2N7rzn6mDJcsRIQXCoReTCWX
 uL0A==
X-Gm-Message-State: AFuF++nFDOe1a6Mcw8X55zNzd3/pMeKgA7jZ4WsclWKQYqL/akmRu26T
 oGbwkv07XTYjC8spJYUmjDXN22JWj84HRVEL8HyUvjCtJbhFEB1SoI4cJKpGveNbC+Bij5uJrJ2
 f7ZtgP0vsIeIEX43BSiLW1wVHHdRdJXJ0uUWZT2MHzHFSNAD6WdagytXYsq8s/zjj7oGWML8=
X-Gm-Gg: AYBFou1ps1hq32h9oDqXpuodo85bEmSgIl74iFULGwHPVVCea53yZ6WHzcFsCCM6y6G
 00TEU3k+jMBBHKaZNBWV/o6KraHl3ST2KFCx3fUhzyt97ncc4t/JgjWVXjmejaf8VjcGj9AcBUf
 ST/kFFOrUpF0X15DG4Kz3D7BgRMbdtibWmbrTF1Wc1Oelgc08XiA5B0sFpumr+XhUewrN8yDneb
 ggXDbaBHq5pZw3JEckOwwCILXuWoeaO0vX6nT0YgpaExhWdXWaqOAsqSdb1GcXH5WtsTf83A+5D
 bNAvsz1LUy5LoI3XAQyOH7nApTNycfP0RFKBwlWa8l6miCWGocpoH52rKywMtkgrjTXQEaLMQpC
 kfCd3HJj5I/Ijy/mV3wLw9FRBRfL9978UHRcJD+5dqdOuNAq2Tq2yGpPzopsZcCmFvfdvDWfeST
 AufjVZcZi0toV4yFfY60r5bIsywxGfA2xYsmHJq/Q=
X-Received: by 2002:a17:90b:2645:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-39e1e5777famr13901905a91.23.1789628400081; 
 Thu, 17 Sep 2026 00:00:00 -0700 (PDT)
X-Received: by 2002:a17:90b:2645:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-39e1e5777famr13901819a91.23.1789628399426; 
 Wed, 16 Sep 2026 23:59:59 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ac47cfsm11974416eec.17.2026.09.16.23.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 23:59:58 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:29:46 +0530
Subject: [PATCH 2/4] mtd: spi: sf_probe: bind SPI-NOR into MTD block subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-series1-spinor-mtd-gpt-v1-2-d065abbc7454@oss.qualcomm.com>
References: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
In-Reply-To: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anurag Dutta <a-dutta@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789628386; l=4349;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=Z7fkvYNNb2f8cQXPhEy1fUXOfaL/jNztc5h3nyzAw+g=;
 b=2rb0IqoRsHYQ050RA3AvKB8PrZOlGmYgo+USLW8OAJ7gGiX1Qoh9ezbXmxrNPijVqN2chgQ2/
 nVLrmnVj079ASNSkvzdXzrSnjfG+ReF6NNzCPoCpu6vpS7dCDrfDKLv
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfX6QrjgFVn9tJU
 8XcPbGhrrq+IUoEhRY4F5lnE4aJx8tozxOfzQpEnGR/Ia7fjVDgAsJX/iv+7G09iJo+h9GWIyjq
 td+WTcIfVSUCENrFUq5MF9cW0SNz4BIuOVfVasc5YEx4EVvDo3MRZc5aArV9latMk+7PdOurJzG
 0ZG0UbVQ1sa5XXxLISS8/vmrhmuItgsf8cf0zm0uiAuPunG7UIMfnsxB8jWuCR9NW703a4Fqk12
 FslPxGPKl8t9V9tG8/GACG6JsbD9rK2AF5psuaURpALvVrpbYlEeD/xIk+H9TtToifzDpesY07J
 be3x9PDUA1EiKoTCgzOuVT1FUAqLrDNRVpjplzI2Pb8OUkRnwIwrELFcmnV+aGPLDOUhdk8pGA8
 k4lweL9tpD4IJwIEQP73K0+KzzZrGFqVVQyCzepgbLpOC9Pc3dwO+BuCBw5m2s73c/mKdneGRl4
 Qlk0HrlFUq23EsOY4Nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfXzz+EhYpN1+kf
 ixP2NbrN5LUhJEc+YvwwYuHS2I39EPy315Bz5Tkzs43NbcVd3xB8V3CdHf4kF4vZouyUb+OaQXL
 gVtwkbU3dyN6qScyjk2BQguaP0cPsg0=
X-Proofpoint-ORIG-GUID: XebJeimE1YAdxyK5p3dB7cJ4wDxAYeRV
X-Authority-Analysis: v=2.4 cv=K7O3jCWI c=1 sm=1 tr=0 ts=6aab8ff1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=5ua_uZKpwam2nJN9cjkA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: XebJeimE1YAdxyK5p3dB7cJ4wDxAYeRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170093
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

Bind the SPI-NOR jedec_spi_nor device into the MTD block subsystem
from a new jedec_spi_nor_bind() .bind() hook, matching the
spinand_bind()/mmc_bind() precedent of creating blk children once at
bind time rather than on every probe. Set the block descriptor's
logical block size, log2blksz, and lba from a new
CONFIG_MTD_BLOCK_SIZE Kconfig value (default 4 KB) instead of a DT
property, matching the sector size GPT images are generated with.

No changes to mtd_bind()'s signature or behavior for existing
callers.

.bind() runs exactly once per device lifetime, so the mtdblock child
is created unconditionally there. Probe-time only looks the child up
via blk_find_from_parent() to refresh the mtd_info pointer and block
geometry (blksz, log2blksz, lba, part_type), which must still happen
on every probe since flash->mtd is only valid after spi_nor_scan()
succeeds. If the lookup fails, that is a real error (the child
failed to bind), reported via dev_err() and unwound through the
existing err_read_id path, which is a generic post-spi_claim_bus()
cleanup and not specific to ID-read failures.

Wrap the block in a preprocessor '#if CONFIG_IS_ENABLED(MTD_BLOCK)'
guard instead of a runtime check, since CONFIG_MTD_BLOCK_SIZE is only
emitted to autoconf.h when MTD_BLOCK is enabled; referencing it
unconditionally fails to build with MTD_BLOCK disabled.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/mtd/Kconfig        |  9 +++++++++
 drivers/mtd/spi/sf_probe.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 21b8b21f6b2..41a4ee9aeea 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -39,6 +39,15 @@ config MTD_BLOCK
 	  Enable support for block device access to MTD devices
 	  using blk_ops abstraction.
 
+config MTD_BLOCK_SIZE
+	hex "MTD logical block size"
+	depends on MTD_BLOCK
+	default 0x1000
+	help
+	  Logical block size exposed by mtdblock/ubiblock devices to the
+	  block layer. This is the sector size used for GPT partitioning,
+	  not the underlying flash erase size.
+
 config SYS_MTDPARTS_RUNTIME
 	bool "Allow MTDPARTS to be configured at runtime"
 	depends on !COMPILE_TEST
diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
index 7100b64bf22..8143f53c3ae 100644
--- a/drivers/mtd/spi/sf_probe.c
+++ b/drivers/mtd/spi/sf_probe.c
@@ -9,12 +9,15 @@
 
 #include <dm.h>
 #include <errno.h>
+#include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>
 #include <log.h>
 #include <malloc.h>
+#include <part.h>
 #include <spi.h>
 #include <spi_flash.h>
 #include <spi-mem.h>
+#include <dm/device_compat.h>
 
 #include "sf_internal.h"
 
@@ -100,6 +103,28 @@ static int spi_flash_probe_slave(struct spi_flash *flash)
 	if (ret)
 		goto err_read_id;
 
+#if CONFIG_IS_ENABLED(MTD_BLOCK)
+	if (CONFIG_IS_ENABLED(DM_SPI_FLASH)) {
+		struct mtd_info **plat = dev_get_plat(flash->dev);
+		struct udevice *bdev;
+		struct blk_desc *bdesc;
+
+		/* The mtdblock child is created by jedec_spi_nor_bind(). */
+		ret = blk_find_from_parent(flash->dev, &bdev);
+		if (ret) {
+			dev_err(flash->dev, "mtdblock child not found: %d\n", ret);
+			goto err_read_id;
+		}
+
+		bdesc = dev_get_uclass_plat(bdev);
+		*plat = &flash->mtd;
+		bdesc->blksz = CONFIG_MTD_BLOCK_SIZE;
+		bdesc->log2blksz = LOG2(bdesc->blksz);
+		bdesc->lba = lldiv(flash->mtd.size, bdesc->blksz);
+		bdesc->part_type = PART_TYPE_UNKNOWN;
+	}
+#endif
+
 	if (CONFIG_IS_ENABLED(SPI_DIRMAP)) {
 		ret = spi_nor_create_read_dirmap(flash);
 		if (ret)
@@ -251,13 +276,23 @@ static const struct udevice_id spi_flash_std_ids[] = {
 	{ }
 };
 
+static int jedec_spi_nor_bind(struct udevice *dev)
+{
+	if (!CONFIG_IS_ENABLED(MTD_BLOCK))
+		return 0;
+
+	return mtd_bind(dev, dev_get_plat(dev));
+}
+
 U_BOOT_DRIVER(jedec_spi_nor) = {
 	.name		= "jedec_spi_nor",
 	.id		= UCLASS_SPI_FLASH,
 	.of_match	= spi_flash_std_ids,
+	.bind		= jedec_spi_nor_bind,
 	.probe		= spi_flash_std_probe,
 	.remove		= spi_flash_std_remove,
 	.priv_auto	= sizeof(struct spi_nor),
+	.plat_auto	= sizeof(struct mtd_info *),
 	.ops		= &spi_flash_std_ops,
 	.flags		= DM_FLAG_OS_PREPARE,
 };

-- 
2.34.1

