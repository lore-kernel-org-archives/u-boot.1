Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F7606A54E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pai4gnbq;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dAPhommo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H8NeivZ8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D02380D0F;
	Wed, 21 Oct 2026 16:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ETt5j9PBfCpz; Wed, 21 Oct 2026 16:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 37B9680C26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599229;
	b=nRJkCZN5QLZCSNHriCNv+dQTc8NqrM/7biHcks3crxp78ZnS9bgt9Mkr8ddsARsXy9W0
	 CrGEyot/gtytivgwJswQEXanzf2nA3HQT64OUjXhQFiZbCoOVzFVoiHm2Q86gNQvKHTWm
	 xZRIKzNmSz0gG9Ztm7bn2/qJ8/4pS2tJQuBWCDiB57wpk0SDWF3+NVumHoNk0kLQj520F
	 OnJPuDHmqxpe/2WCJ+s/iXS3PReyQHLGNZjii/Xcjw81/lPlCyafRSiHMBs+ywYF2McLd
	 50EW0mFFC2mo9885fpjHjxGtWskSuAsddgxk/nwMbIm9tKxkzFeATp+7xzNMKW6CAyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rsXtFF9/DOLV+nvTA2lfprbjTeOAJ+qc0aX1YMj7x8E=;
	b=EvNFxdkW86d5xrRWvWcPHK6JETVvbFVTMlbSV5hGc8sC2VCgIUl/vJZCsMsfALwTJHO3
	 RMHNtYk4hVLPRXfzpgyMaxS1m/gV+o9UJRIbcOBYgJZXEi7X/4r/+UiogCfL6maM1Ipv3
	 HNudi5RftP+3JdZkS8f9cKmLvCyF5Qxs3Y8qkDKGKjucjvqSK38kebtdZ7En9rkrV+ICo
	 cgV9TPXdpmrA7RBjIyFD5fW4HcvIQ9HQP5Prewo/XJm6dhk0WYMeSyOLqqupyPUL/bemG
	 VCB224h/9bq/CmbjZ93TVkLytvgKkiLvH0lVxI+eQBCg4pnRrtEWX62BLihTDd9bDFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599229;
	bh=rsXtFF9/DOLV+nvTA2lfprbjTeOAJ+qc0aX1YMj7x8E=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pai4gnbqfXTuf1G7hCyRDjqGIBXLCMpmaOmyi9C/gzZ+cinP2CB7tPplun/Y2dqLk
	 UWl3x0NE80kdYdnAQPV7zWGA43HhkZl3S/KjX/CX3XQkgJos3VH4KKic8Gxkm2OfmH
	 z4WXFnfMaBAWwevc4IYjIyEwphMbOquOcwtsyrL8UaJsRTuxYoFWAe45nHzQiPlhwF
	 b4XOioLJY8g2CZqcYLu3CHalV1oiHiP0Z9zbuaUxa4VCOqu/dX0mCj28/E9uofQ/R/
	 GeIX8sjmpuF9V0q3NoPvwf0ybpuxpa+g8xifY2Qa1lKXdJOY1xOb4ylHEDJSw7Qdt+
	 w/36VBUq7dxGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37B9680C26;
	Wed, 21 Oct 2026 16:13:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B3175356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2147605C9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:13:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gES-rKJdY_Bo for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:13:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC28F605FC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599227;
 b=aRXiCIqHJm4Xtqb5hBSGHUkpLsShRfGI9ClRr509IpZ0j0u2XJQ1lt0fI9SyyQwKJ6kV
 T/yuGQptrM5mZTQ52K0KWVRghgf6+w7VAty9moqeh5422wOkZWj7HeQbKMr3tuDU4Z7+L
 DwQpga7lk8DFehluoPxVcp7V0Ys5vMrmvQVqPQ4OjYBOZgusrMg6NI9nWUZUcEMb1FIm2
 AmEun6naZadzt5Hda4mkY8VgwFVzTAbsGggkf5rYfo4V/pJZCw7eJbon1z0PwpSwVgPP1
 MhmFk5N0ZNSbj7LPe6K+kHXtsdEkCp9oBWp7OcMb/MX1wL5KjGexijdKW4SCcHcZSgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599227;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=rsXtFF9/DOLV+nvTA2lfprbjTeOAJ+qc0aX1YMj7x8E=;
 b=svszyoKZup1Rcedt4vySLyWGtnsrvjmlTdPzn0UZVcSJAmw3DzaTtBEF2KsxbzEkS9Up
 274cOUtfEk19TRJG+bGDkm09XLrmfg8/H4NsfR1SOtscCGAHdkbRPZRwEXD+CrQVuGn5m
 HjPSOkGO9Mnn3+9ZKr9aEbhsh8tw9ioRxGTcohw/6hvgylb0zjDvALP4hyedeH/6QmfsC
 IBKX3FLVQi5BSc4qIHy+b/y6uh0eof8cBhRhrWNaK4P76MxX3E+eIQ2xqcxto+bMgWeaM
 yH9gAF1MSY6SHYZTo0VRUzrEz5qJwJRSazn1x3IE9JYQhErurax5eaPFzTcYazplFLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dAPhommo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=H8NeivZ8; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dAPhommo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=H8NeivZ8
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC28F605FC
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:13:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU9NB1481551
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rsXtFF9/DOL
 V+nvTA2lfprbjTeOAJ+qc0aX1YMj7x8E=; b=dAPhommoXCeK89GXT7Xa1G5tadJ
 4HiRn3ZTJQbpXno+7G9v0xqMqguiYGF9FWS6mSaCp4Zn02PKnJuLuBn38GEMBI5+
 5rvbA9RC2h+yTgiVnen2Q78F5d9vot5auQ16WM8flWLc/IedZvlo3vT3z9paDmBj
 8KvbtczGbKTzQkI5BVVHMad7xzY+KgQJm00YOxXao/hCNTNEYeXSm6VhjO5ypRM+
 W/RHCE3OeQS9tBpEAtsg+jxr+YY1YRHvilovhOCPWZ1zwHtQ8q85aiFZ2NefFYFF
 FzNLZei+SopW1inWMgHHVcri8UTdIOVx69UMs63mKIT+jFlSbtrulszVd1A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs044jq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:13:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so465841eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599222; x=1793204022;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rsXtFF9/DOLV+nvTA2lfprbjTeOAJ+qc0aX1YMj7x8E=;
 b=H8NeivZ8lityO4UFcm7vtx4gze+gBfrQkHQjpMmE/RMBZRjyLQi9IBNR2BVjY3J+Io
 prwEf/xktZs6HiwHt08/XFhq6dkfP86n4IuXl87DuLYG/W2e4K8bX6tI7yphgAo5fXL8
 t0Pf8Km2zf4tdXFRizfY/OmJfvkAt8yj+ZN1q2JbD6A2FpS2WRBE/jKplUCRnL4/ZaYd
 cxaV2jIuZI0IIXsr3I8qRHYjiZlpZSCizQuBKURBOHF22FXFJqKkkIs5msIFZn1oHNwP
 rss0R5G0xTsGK21IcLXbNTggqpdYRQ0/NCnQ44dX6AJcGhgy9DP1atx4wSa5UwtsVQ5w
 GE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599222; x=1793204022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rsXtFF9/DOLV+nvTA2lfprbjTeOAJ+qc0aX1YMj7x8E=;
 b=D/mL+xZJU6Yf5MzNmD0TMLSFfRUgR5zjs08BLBPOoVOZkbqsC4p+KAEghi3jdS9GWg
 cieud+gk8ZAUvXPgjPPRGAkhucjj95ipoqgnH6XodTmzQs2eGSoMjyvAI4MmkJzk+I+D
 QQmJn4MwJX7ObwzeICsLgsUNHrppSylwZGDM+A01OtWuPHwe94iFgokS3cYuyAvJce2G
 2Ah9+1CEetc0V2Gw4qFsDJch8LI+tv2C37Pe2qiUo+BmEfmz0IowSZSMKngJQFRnMTyZ
 8b8Osho27+wzNB6AGFGjLeZZIEzqiu5gSX/DUo2TSpBUQCbRpOPBp7dJln0r0qgmXu11
 s/FA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwumvPAcjZOU7/7lKJg88yyNhVG5JJnFwc6C5EjVbPf6w5mZNYowU38JQ04URvK3wTMutAr000=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIOPzjh7Sitei3CDMyIOcttYSN6kbiLm+QsgmL8uPkZswOBa1Lv
 d1+aRU2x6mwFOS2p5xbpDyT5Pp/kxXBibkY0MPT8wn8Ax4qqW3SF4n38QtMNU7mB4XujggYBj08
 j7FJ0fBcE5faSBMqmNbfQ9t6DlKzsWhAFXccJdrbTec6D7AFn3srMog4ns1nviWQku6NjD8GLE7
 5B3hg=
X-Gm-Gg: AYBFou0SDlPKrQrAlzVY3BzBIgEzfvDR+4+ZUXmScnCnWsjMz2FA3mKR9yaweDKJlHw
 IuZ+E1PbfiggFmELc3+b5BUTQ6Uun6oQh7hk6BE/r0WPGxftqE7rvEBLlZhsNq3pFMdnXNtC7TF
 3NStf7xyXELeBs38At3Kao7s0PKIgcKtYNdNWtU8Q1BJYgVZ7ZxY2sC79fw6ongIpp9zBVe6JAI
 Ot0so/wLN2PdiYZeEPlCsJmycPmK+fUqYVS+rFX5y+YWaat7OznapObTq0y4FXEA0Cpaw5kfX60
 sMu2qE+1PbrZVVTXFPeV7LcLuRRRUC+/OXN5O/Emg3FK67b38ApawlGNo2WeNeSFLIKOMMcfatI
 sUFfVe3NBg4RAD2rF1QY54e1eWi7SKfqySF5EW2ozUCggEJtY9NKs8/GDqq0yWqHWM5cTNDGf58
 06Iw91VBNRSZCX5uUYMss=
X-Received: by 2002:a05:693c:8345:b0:343:fb75:a5f2 with SMTP id
 5a478bee46e88-3674c93b04amr3335554eec.9.1792599221456; 
 Wed, 21 Oct 2026 09:13:41 -0700 (PDT)
X-Received: by 2002:a05:701b:2309:b0:14d:baf5:c415 with SMTP id
 a92af1059eb24-190a465d2f5mr4249791c88.7.1792598740505; 
 Wed, 21 Oct 2026 09:05:40 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d3ae06fsm7480185c88.19.2026.10.21.09.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:39 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, aswin.murugan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, nathbappai@gmail.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, jbx6244@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 5/8] clk: qcom: add TCSRCC driver for nord
Date: Wed, 21 Oct 2026 21:34:45 +0530
Message-Id: <20261021160448.3893858-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad8e4b8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=oK3kB6-65Y4gctBAWW4A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX8B/EFivoxnhh
 fpPMr/swd31dBwQb1c0S3zpJTKuOXupueid7acY8kdJh9C7y54QCpAAPy9kYm5ncmh0f5kHAxb0
 G8N2BkJX0uhPI0oXamY/KIVHXhGJv4oq29+nLIGYbbM0ZqRe4/vPWoEmB8oQiHXVut012nhJr0h
 0GUuf/WyVAmp3biH47BtTd8rLVuxNyJTnMEMMgMLqC4l7AW1qhZI7P7KKmFM0tMZgrauujPKTAd
 ppVCLpVV+SXc6FB+ZUEOh/6XS4r0AqX85kWskqTa+U5ej+n0j2WZ+36Ml8QC1CbOWunNiZ0Xlcs
 oymafjxqaiUgtSrQrb5gEMBXUEmWfkjrpBtxQppW5rQEkc1K2XP4qjtJnZvfxQvL5VN7Vn/HQZh
 cK6GugHuGhTp/7+ZOBTU+PTmprsb3cC91f8dyUoW3HPiDJQhglJwQHXWQymOtGXMPW8uVittspZ
 4FOKzXnFiSZ0hTylxAQ==
X-Proofpoint-ORIG-GUID: oTKiUFhGuQ3Hj7Cg6kpKJyeERdLXjwt4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXx7pD+ZxQw9zT
 B3K9Z6yqAm6wvTXqnyH5AGdDJ1tz4gMPSZT8s1DFi8UGpKzEMi4OkkG6bFFCHJNoX/JVxqggP4s
 3/teB7icBvFApc8gD1v9Ktk3jWI2Lr0=
X-Proofpoint-GUID: oTKiUFhGuQ3Hj7Cg6kpKJyeERdLXjwt4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the nord TCSR Clock Controller (TCSRCC).

Implement the qcom,nord-tcsrcc driver to provide the clocks and
resets required by nord platform peripherals.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig             |  8 +++
 drivers/clk/qcom/Makefile            |  1 +
 drivers/clk/qcom/clock-nord-tcsrcc.c | 88 ++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-tcsrcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 78acc9dd42b..ad88f4cfdf8 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -90,6 +90,14 @@ config CLK_QCOM_NORD_NWGCC
 	  camera, display, EVA, video, and GPU clocks and resets exposed by
 	  the NWGCC hardware block.
 
+config CLK_QCOM_NORD_TCSRCC
+	bool "Qualcomm Nord TCSRCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the TCSR Clock Controller on the
+	  Snapdragon Nord SoC. This driver supports the CLKREF enable gates
+	  exposed by the TCSRCC hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1ca23a0e022..2027c4bd7fa 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_NEGCC) += clock-nord-negcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_SEGCC) += clock-nord-segcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_NWGCC) += clock-nord-nwgcc.o
+obj-$(CONFIG_CLK_QCOM_NORD_TCSRCC) += clock-nord-tcsrcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-tcsrcc.c b/drivers/clk/qcom/clock-nord-tcsrcc.c
new file mode 100644
index 00000000000..cd89e1b34ba
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-tcsrcc.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-tcsrcc.h>
+#include "clock-qcom.h"
+
+#define TCXO_RATE	38400000
+
+static const struct gate_clk nord_tcsrcc_clks[] = {
+	GATE_CLK(TCSR_DP_RX_0_CLKREF_EN,     0xa008, BIT(0)),
+	GATE_CLK(TCSR_DP_RX_1_CLKREF_EN,     0xb008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_0_CLKREF_EN,     0xc008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_1_CLKREF_EN,     0xd008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_2_CLKREF_EN,     0xe008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_3_CLKREF_EN,     0xf008, BIT(0)),
+	GATE_CLK(TCSR_PCIE_CLKREF_EN,        0x8,    BIT(0)),
+	GATE_CLK(TCSR_UFS_CLKREF_EN,         0x3008, BIT(0)),
+	GATE_CLK(TCSR_USB2_0_CLKREF_EN,      0x4008, BIT(0)),
+	GATE_CLK(TCSR_USB2_1_CLKREF_EN,      0x5008, BIT(0)),
+	GATE_CLK(TCSR_USB2_2_CLKREF_EN,      0x6008, BIT(0)),
+	GATE_CLK(TCSR_USB3_0_CLKREF_EN,      0x8008, BIT(0)),
+	GATE_CLK(TCSR_USB3_1_CLKREF_EN,      0x7008, BIT(0)),
+	GATE_CLK(TCSR_UX_SGMII_0_CLKREF_EN,  0x1008, BIT(0)),
+	GATE_CLK(TCSR_UX_SGMII_1_CLKREF_EN,  0x2008, BIT(0)),
+};
+
+static struct msm_clk_data nord_tcsrcc_data = {
+	.clks = nord_tcsrcc_clks,
+	.num_clks = ARRAY_SIZE(nord_tcsrcc_clks),
+};
+
+static int nord_tcsrcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static ulong nord_tcsrcc_get_rate(struct clk *clk)
+{
+	return TCXO_RATE;
+}
+
+static int nord_tcsrcc_probe(struct udevice *dev)
+{
+	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
+	struct msm_clk_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->data = data;
+
+	return 0;
+}
+
+static struct clk_ops nord_tcsrcc_clk_ops = {
+	.enable = nord_tcsrcc_enable,
+	.get_rate = nord_tcsrcc_get_rate,
+};
+
+static const struct udevice_id gcc_nord_tcsrcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-tcsrcc",
+		.data = (ulong)&nord_tcsrcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_tcsrcc) = {
+	.name		= "gcc_nord_tcsrcc",
+	.id		= UCLASS_CLK,
+	.of_match	= gcc_nord_tcsrcc_of_match,
+	.ops		= &nord_tcsrcc_clk_ops,
+	.priv_auto	= sizeof(struct msm_clk_priv),
+	.probe		= nord_tcsrcc_probe,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

