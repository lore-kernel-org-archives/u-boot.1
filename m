Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83C3CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9627D80BFE;
	Wed, 14 Oct 2026 16:51:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GHVNwAt1LI7Z; Wed, 14 Oct 2026 16:51:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CEFA280C42
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791996687;
	b=SRBODMNP36+k2pvDIxVqpa/yHgJwxPS5I/MHSzSO2rfRZbdgI4rP7YQEaLgv4C5g6Req
	 WggOPBaaYMA+BAstNdqtpEVkUX3T/bYjoiErGLGC7LCZkwoLLzRfC//9G+xpnMW902ei9
	 I5vpdCIOLGp6kzCPMaa0gZYXJwYeDn9zYrFft9yGmogRapqVLs1dzCsrtd3CfFu9KaMPt
	 E9AU945m8XIFYT0SAORvG+XpgZngIZ9BOOemKnZAoAY91Pf/PLiuSKtIuWsgpcCxs2Qw4
	 RoMAFSV9xO+6/av+GhblliSKR6/P4cBpurHnRE/T05yiq2MPHXT1Z/kh2eEEBpcWH1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791996687;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
	b=qaP7SHHoDsvDY71KQAUqIEkC1S8ROMW4eKKvXhkXOItyE0tn2rusP2YViDvXd69+N2bn
	 4bpxGrjZbgf+e4PDx4MNHulnJHcOzCgt3DmIQ7p4MUxMktVBQj1i2i+mHhCV3GzBhb5mr
	 QU6ztbL0kOimXXAh10dzcSI/Y0GUH9gEqPwIds2ObuXgIEqeMFJk3RR6pAxKjo09Id5f5
	 NSkTRrVNEvq6hSmcuam/5q0dqHQYOz44mF1q/JDTLVthA44UuWgOQdNZtY87nBUvv0uTz
	 gvLkZfZ52S42QtWGIN7oFJS0bJ/jxD4XZZzgOGwp+GwMYbwjP3Y8g6hfx0MqRP6U52A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791996687;
	bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pH8oUbJnkuCHYgX3apgkT2iANKRcKHfyjQKE9rGCjrjFNx3T3NrDrlq6OY1Swc1w+
	 r6LshTWGJTxTbLUCipyDq+SoO/JnxqqhGfVfXYUTqmiIGrg+mmG0GesZbVzS4pO7fN
	 otDOTow1QrKZYB6s+nsVVdXp6poE97hIrC1Vd3jMAB15XlaDRIaPfRpujwDP/Q9aJu
	 Jh/Y+FHbkHYjgrFDLf6ChQjgTULh98tnf/wlDUXWh5Z849mq2M5xTPsLlrIwTe6rtX
	 TpcsS7gSQ/ep4B1rfi7QSpnLX/GvtEAOt9Ce/nMuQd/ZjSlxknKRt3rjy5bf+7Cb9T
	 ox3tKdw7jBqbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEFA280C42;
	Wed, 14 Oct 2026 16:51:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CA95F255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BCA6540363
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7hp-1ozg0F_3 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:51:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1B313401A3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791996684;
 b=iywO4Zsip7i+CX5Ip1mLBSL98EJzx59BiyewOy3W1wJc8BWqqKvmhy94zO2Dt2em+A0q
 1WJ9BgqnhHs496m6KFQ44ToMH9XXsqGLVyPw+aGQ5wBP/8EALpp46/wvxN62la6tHl/La
 vPPvL5pSar0PXcz8NYGwIJmU6i4ZiKdFSFwqJ+uDbN2OYlkmK2zo9a0pcGyAUznzLPWd/
 fa9mgf0DXmVPCsjtEeYfUa0dKvzaQDx2wixjmqigEkbZUael9IngbRL/bEiSvxhR/tl2E
 2BRKUO5EwKs9VdWKLpXj5gnz4SwoJ5ZASpfmj/+gGIKfHVLQyLhLCGM5aRyRO5+cBYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791996684;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=UD4YvfpKwrw5uM6+EMZCMKejkBMMCvUD3rwixUyLlZyTZNM+53msaTdkK6n66FIPnVJr
 gBXm+QM0fUfu/yRJwHiUbOZx1QWUuDti87amkTzYShmondMWCspyZ9MrwmYHTGcLGAuUB
 l9W3qGxwZmSOLFZcXRBNnJZXAojlp8RdlwsWklxW9purjAuIrK9xUpcdQe+cu9oxi36RS
 c0D0aCRaUcFWkqVy86qaIRw8u0QFsWhTzY7GP7RIZEL3YnoNk0MyLWPpkQY6lWa9ilY9t
 wo8kPbbankKKkp6nYDqfEto3nFmT4/DQiZVTrA8Wu9Oe/c7ClNLR4OZlabFedzJp1mQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gIFV04k6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="btex/vnK"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gIFV04k6; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=btex/vnK
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B313401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:23 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFpbdq1672259
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=; b=gIFV04k6aLoxlTgB
 0qHLapoGG3oxfFzWXdlXlPSoSfx6TK2QIPvgqmS9MvQGOvWBlvf+LfijamON2rph
 RsnOpBK03m3vg+As16MON8RvYsgdIO0wD2orj1u+6gMmFe8KPQxG6NkQdlcezcm/
 gp0qt2O7nBY5HCZwr8xZpcgO/9OrNffeTvdYUPBAHlO54WpnZ2dsMho8PjyX3fW+
 B52jr5+Kci1D7IVo/E2Ap5MPMUXt668pFeDayuLLDvW5zYoao934vZXWwOvS+Bpo
 5pusRc4tliYQGn1WRqYZibw8yu+t6xPqEZ4iZ5SpnforcV4omOt3Iie54EvqUqMb
 ITGqSw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrh87qw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c902e0da2so1501982eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791996682; x=1792601482;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=btex/vnKln4zHap6Il9i3fzXvdTo+uaPvkFdrqAbAG2qjHMSGwc22PNUGHcv+NJI1h
 ix9UN+8W6F1B5Exypt7OWx5CdG2kgEeCeEU0RG4887QM+WNrpCXXwT8Gl4jpGDzAKbuI
 /8XuNLbFGfIJm/BEK7BKCllHa+6EFnLbp3Wnw9GIHfywSJAYa8lsIAU/rGvyXyWPBy8Y
 fzPdbPS3LxkoyPwj0sDvynOKoUziPqOPldRmOm/03zQSAxy0gDifH8/Mo30GBrrC+AEw
 bI5JSsQdeT+qkCs5S8xr65cGTo6YSZYB8An7OQz2hT22yhgMy8nVUaDkLC2gfU/gjaly
 dcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996682; x=1792601482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u9SakT4EHN+Bia9c6ciqE9ORqE8sy335d+lf3nVYf1k=;
 b=RFSn0hhZFlOl3sNYS6Wf9vaK275dQ0zwQAKp2ucZEnbzRFtJSeNbwg11cSOma4a7P+
 9YU8k8xyPxAoClEWrC4kDe90micUGJ9uIm8C0cNRhHtzUEOmBZB0KxUarvKzHOOxSiQn
 n3boKpSv9xGd89vIt7bZZjvRHDKiFSqs8lD6L3QKqVGci0CrxG3MrwWXYZdoCl6AOZjQ
 Cb4cAdAAUOee0yDaq0ZjJy2cVdRUy3GCuUuVwAv83ogJU+BcYjAT/ffl3XE4aWwoCMUR
 E/3MqLLlKv91Qwi2BbHkvQaFKkH5F4rlms9RtNlaCy68hht9uVivXXz/IsIHBIpX1o4u
 COoA==
X-Gm-Message-State: AFq9FYLdSYztBiEQ2CC2C2a071fTa7eUU86PtImlMFgTwerckJHVg7ZC
 yP1iIJkb3u5lLkLgx4xzsAkYuvbGKS+CKCcd2yDv/TU/6oU976oSOYhGPnQLFkCiYti/EQlOuEF
 r2XUHZGhYMuqGEtMVJpfmPaobGT4I9cmQXA47QcKXzOLIiqzMLG8/qF7Z9goFE9fjU1fINMz74g
 3VFVM=
X-Gm-Gg: AYBFou1y1LOmiUjoWnNZpq9Hd6E07zXm65EpbXeZnQf/SKkilHWgQJ/xGkMyo15SIR5
 FYCmJGcPaF5reXCs/AkCtgj6BLtDOVDKd+C9vbXcyepXqcHrVSFRxtpGDgOsOLXQsjGZoQb8GDh
 rrr3eGPQ9HO3IHsbqU/NYRAU3icFIyvzVZFoJpAVQwX/R2Mjmq7pPToIc0A+NPT4kqvieH1Cskb
 ZN9+3aCYRq18LwDeY1UPXgQjye6SDSCl29g0erASRPHDNbpJpD3SvQES/DCGjmceYzygrSUMHhz
 O78irDeS0g5ce4gNNcm6ot5K3RaoZfB2oOkkr1ng0p/CnEivi8inH34mXTguuVsWC3KI5NR8POy
 f8HULBgI6IiEcFBY9yDIX6NKkPXp/nvXslxua5pzZMef8G7A0dYHBV8M5cEN3s6OvYPZ3agS7bM
 S/T3oy/7Cu79t+dINP6GGN+nFdBkI=
X-Received: by 2002:a05:7022:e804:b0:13c:f65c:d5b5 with SMTP id
 a92af1059eb24-16a0b37d130mr23410447c88.3.1791996682100; 
 Wed, 14 Oct 2026 09:51:22 -0700 (PDT)
X-Received: by 2002:a05:7022:e804:b0:13c:f65c:d5b5 with SMTP id
 a92af1059eb24-16a0b37d130mr23410397c88.3.1791996681440; 
 Wed, 14 Oct 2026 09:51:21 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm48975894c88.8.2026.10.14.09.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:51:20 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 22:20:55 +0530
Subject: [PATCH v8 1/8] arm: snapdragon: Make SYSRESET_PSCI optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-snagboot-v8-1-7caef86562b7@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996669; l=1142;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=TfHvwBncGiGT5hjC8HrtPimKPWS1PylfevaI2V49eds=;
 b=JcVGOPLLKUbBus36Rav7SjFXBZH7fwPvBYb92hCyyPzzxOlxSXlXRMfrFEnIQSVfYW/h6i2lC
 F7kxYCas2WMD5dio3q8mRgpPG0zjY2vzoXzHd0XSYb9Y7FosAKflNVm
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: RCgvLTVG5ATmDREgDMR5Y2YDqdGahlii
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX27Rc77yH3sxT
 fXqaUxI97Hz+cmbjCne2u0878XEt3EYx1PfVS3wtHnagO9u3IGEWFOmH8QNx+b98ryX9Gc213dk
 kcc0HrIMcZ9d0QXMwiHtr+VZU386zJw=
X-Proofpoint-GUID: RCgvLTVG5ATmDREgDMR5Y2YDqdGahlii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXwdSnqQ/qk0aK
 egQ5P8355M8L/17uiFFNxmBK18SvXCfYa9M5WIw78RM9CwTaxLmugOwBo+JK4mqwC3uNWVg189a
 4EOVF/iEkJANVXm4m39IFJqDTdp9KeT3rxO3jNTT58RCKTvOS2/fnm2GdozdqWjt33bpjLqtpQf
 qYgu68AVqy6lgkx72+BkJVSeUgqybIL4l1YR1DTQqSqI4D60s2yZHtL/jEGFQkiqhgSaB9JNVTn
 rxfWPWA+gMrPkTQjt+bXLw+/0YMkq1LN9xAtbwMwGwoycso3Y4Xtq2W1Dz67vpgN8YgeM6+U/n5
 WrZKsO5j1qY/gJjWpLrzxn+KKBIbYVxcG6KHE8+WmWVtTT9bNzGYUYX9vnGoRCu5Us8HI4Ua40T
 GPBf2g/RVJgwvYHZbU4CsaOLtl1emBT3vLbcJz3OHcXHItZbcGYwKlNoWNBgpAP5IY8jERkQowD
 5dTpbbBBIM7hHVRrvTg==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6acfb30a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=881fuD-RhmhaU7In5wAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140067
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

In snagboot mode, there is no PSCI firmware and U-Boot will crash if it
attempts to make PSCI calls so disable it in this case.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- Make id dependent on both !QCOM_SNAGBOOT_MODE && !SPL

Changes in v5:
- No changes

Changes in v4:
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE

Changes in v3:
- No changes

Changes in v2:
- Newly introduced in v2
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b51031..b438f0b9c14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1150,7 +1150,7 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI if !SPL
+	select SYSRESET_PSCI if !QCOM_SNAGBOOT_MODE && !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
 	select SUPPORT_SPL

-- 
2.34.1

