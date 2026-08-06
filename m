Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130E3C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2A2D80B1E;
	Thu,  6 Aug 2026 11:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7JnAEf4VmNcn; Thu,  6 Aug 2026 11:40:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C55080B50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786016440;
	bh=JhnjSsYhWGOJUT6MJzto40qndxEf/qBOmM4wHdeYcME=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xiBx0MoIPwIV1IMsOeDzNEcZsa7UywKUA3OPg6ohPp8Vd+3MEwM/bcQAK+7f7G0Jl
	 QDTcXZiUVpJ55RjJ5wmbzr7z5E82+YyyxmJk4YCnBgEfPjo6u1cck++i5BZsZ/BMcX
	 dyANkqtgm7mfOXfWsd44pqxBrknpKKL9a+uh7rfG2Wyn0k97XbNU5B4oMvrZ8N/ydv
	 9dUpZJqCOCHvHo1yoDZUllcp3doGW1NbuJndLWJTJdGEf/PPhJOeMf+1/PVtzz3rse
	 Mq8NU/E1JVmohSBVL0ZzoUpHxrMgaXz6nn3kBRz1b0fOBBJzoHEMq88dcyedvkhmMx
	 sT9O8rI1wxU3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C55080B50;
	Thu,  6 Aug 2026 11:40:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 33B5D10E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 195CA80B50
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q4RCX8rgrhUI for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:40:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5ADFE80B1E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5ADFE80B1E
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5ADFE80B1E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:40:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6769ndKN1625667
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 11:40:35 GMT
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvntnh3mv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 11:40:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cf7dd9fd91so19752355ad.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786016435; x=1786621235;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JhnjSsYhWGOJUT6MJzto40qndxEf/qBOmM4wHdeYcME=;
 b=NQwIuXr6uYC3ALcIF4Dxli3YqUA+P3yWVBZEoD5u9zguupckM3uGH7Rj5Q9EvMg86L
 Ju/QUCdGxdpjV+G3wFLSHgPgDixUFePH6UoH9M3SQCtgoxC+WWE1B+QI9Il+euhRRxHR
 1uniVJZhMnGkru7BzU/hBEKA3qbrDQ1txu2OU4dVEf0Z0Sg1uvfWSJG7GgmuE296JaHT
 P5QlJ66s1t8nDbhGbHK90WDKBqz6lDpjboHWlYl7ngk0KTMkxZaHySfPlHEEHNML1RUi
 J0tOVr+Zssccolmxz60pEP4ob6oXSWQyVNyMNz95iNbb7umA78i63LuqwzluX/J/Rr52
 R8dQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeVFSFHpHeOYSRsdxaQT+fXLS0g3AefMeQhflE8JgXX2BqTyfp+6fLtaqlf6EBHUv3A2nD9F0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywmp3nrd9thrT8rK6qgidMkQquU4Jk10IJjC63xi+EJUN+Hjn3E
 ks8Db+U9vqDi+NN7T6GlgPrdTNJBtaPoy3Q7DWOSBBfBEcYnUomWQD6eTyJJFYewHVaGjU+q6dN
 K3uPVAqfJqtkuAXk+yF3Vzr3N0CRDUl5X8fyv74Gp73Q+zjr7c4KRY/ncbx1jmf3/ql1y9hw=
X-Gm-Gg: AR+sD13BF/lOKFljVVwRqA1delZMiB5wHBC2VgH22VYpW7ucsElrNbCI703LMkv1rk1
 SRJk0RGxoRqd+igwqHaybse+K5buZa1VbDXQdeAlcx3zOvuXovnpxr0wIBfnSQCJ2b/hTHSMJja
 fCTN5Q8Yd3UDh80UPeNW2RSN+d/TDPsbZbuJgxHCIDBMMvVj0QZUOeYOzUOx/W5OEQ1yZ6GLoDW
 up4pH3GwUaJxO/WcOrVlxFOsJ2HOZqqZ7Gu0X+8soVARBzAG7ekdvLPrb0TpPvLU81QJsrlstRU
 Lzn0FvGsY6jKK0zYuTOTaQdvglfjI2HfjbAjrCDaLn0/Vajkf8Nu6BPV2YB/YscjZYtF0NLZc++
 ooQkKkNoY7sbobzn2MqAf2McaRisuUeew0W/l+u2l0QXNgxkSnSUPJ8pM/8ztcg/gU4h0T/MTn4
 njcS1Otz28x2JlznjZ2PyXSiA5lBAK4g==
X-Received: by 2002:a17:902:dac9:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d106da916bmr6063145ad.13.1786016434862; 
 Thu, 06 Aug 2026 04:40:34 -0700 (PDT)
X-Received: by 2002:a17:902:dac9:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d106da916bmr6062465ad.13.1786016434435; 
 Thu, 06 Aug 2026 04:40:34 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b76cfsm26397801eec.4.2026.08.06.04.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 04:40:33 -0700 (PDT)
Date: Thu, 6 Aug 2026 17:10:22 +0530
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
Subject: Re: [PATCH v8 07/15] mach-snapdragon: Kconfig: Add rules to create
 SPL images
Message-ID: <anRypsq+fq5dc8I/@hu-varada-blr.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
 <20260722-spl-v8-v8-7-cbfa79e85a9d@oss.qualcomm.com>
 <6e706370-632e-4ba5-8ed1-efa548b037e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e706370-632e-4ba5-8ed1-efa548b037e6@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5MSBTYWx0ZWRfX0CA3JtAqpgbl
 lSvYqKyTaI/kwhsIzEO51EUCXoAu6ZFjvQTp4W6EF5HrijzfBTr0JOodVDuTDT9QdQLGBYP/aB0
 8fQbdnyRrce8ASRw1P7wJ0vpzK2GxItCPzYQ8bdsW4Dz+x4epuA8ivfJSq15kIaIKci5ottJvpc
 A1IM87CAMzqkm/QeeHVRoJJeMKSewRWSQJOj+ktVVFLyPTO1j3UXik2ThDnWAGdE5E3qFmh0D3m
 vUxgARI1zFTIQwFzVd+0lMvJpWryXcoFM/EiaEdpMiQV8ZgOM3Z78abBp3GxnK/fMUOs/aJaEzJ
 nDnGjgFhHlTwFDNeRUFtoSehK3xZnY9LAcrKcq4F/qWlH9gRrLmg34z4lZ9gesIn+ZShHOpsdmE
 247Le+0ia6EyeXb2GMuGhdqrl1s/aNguiZRDltItqTKxrIBIKisWOfyrCB91mRWdN/MF8Q36NDB
 gbf5Hdtf8GsJyZeuXww==
X-Proofpoint-ORIG-GUID: cSEaUaQPqnzSpoBzGyxaRcSE-n-6ODhX
X-Proofpoint-GUID: cSEaUaQPqnzSpoBzGyxaRcSE-n-6ODhX
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a7472b3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=eREQ-rH9p6d6X0VKs7MA:9 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5MSBTYWx0ZWRfX0OvRTxYdVMQ9
 8z4NC7khrQK5iQI7Q3h2EpMt/+VM7BHNHrEp6dtAEZ42bvUjFjb+kJ+rlIXtqe9Nf5Kwu3/E8lW
 WzqWZHrV1K7YEQqqLT6TEI6LatR+YHk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060091
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JhnjSsYhWGOJUT6MJzto40qn
 dxEf/qBOmM4wHdeYcME=; b=dYWY9f2y3mf4p8fOACB4AhK5yMmh/qvNgzPtj/FL
 5ALWrwjC22DmCsbsIBSexjr6XHglqLWb0pKRYZjTskKwKxBQP1JKYbMZzPo5DZQv
 JNRwPOqi0krTtIgabKdP7vwzrX5u7YdJHqyRSXhN391gdiI28cOHUNB258N36ggp
 0pkcz/nu6/FVWMjqL8LeBJFZhtYux7qO+T8OeH0ZnTgB0LaPrAxira1Dve6mm36Z
 Re719r74LXbHi2J6ALRsD+SDeaL2RQobOp6p/QCjp0eBJrnVoChtoNgYATWO8kBm
 x6FTxZcAkEv2pj8FdeH0fW1lm+LR9x9RHn9921sN4fh5Uw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786016435; x=1786621235;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JhnjSsYhWGOJUT6MJzto40qndxEf/qBOmM4wHdeYcME=;
 b=ibb4DSQWWj8gXih/bsvfKDjr0NebEN2stt0fwJsEe6kpUyv0LydXjioaeNZzwyy9Wg
 N8oZ/K5yN77eaUzGilgurpo1YzaLYj1Sy31JaLiUYNuvU86+L1ETm+sijzYUipfJqp41
 D/m2szDmv7/fO7dDvaEkwLhJf/A3D2Ms/Z7yy0tFZLBpfJhl+sCUzQLhFD/5D2my4FBL
 OvrszXUgR3SytR2zbr7ewXJ3h4Vd7vtIIXbt7TubydyjeaDpAiG2kt+PNeJ+3OXZSrP6
 xAB5ClDW9VafozDXrXYwAMyIH6q94vZTF7ZHnLqx0KZlLtCNDh7Bqa/2usL3eRxazPIz
 BDlQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dYWY9f2y; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ibb4DSQW
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

[...]
> I'll try and get around to revieiwng the rest of this series later in
> the week, no need to respin yet.

Please let me know if I can respin.

Thanks
Varada
