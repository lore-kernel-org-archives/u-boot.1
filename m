Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29044C3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4396882CF4;
	Mon,  7 Apr 2025 12:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N06qxqCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 197E382D39; Mon,  7 Apr 2025 12:33:47 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B818A8215B
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dotP009987
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 10:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WbL9/YnYabTgt1rv9ACmC2Zj
 y3JhkViM0kf77FqfNCo=; b=N06qxqCVBOpHqUOqRsfVbFbog2SgVGCJW4dHn2s3
 a9vxn8Fttp0vyskIFyaZX+VQzHU1Eo3uDll9X0UR+InMGzlrFy1JjdCyXwSWrYWS
 doEVauRePmJF/ir+sxBASr2qQRbzZ/hiFTCmS+J/0zU9nT4MQyn+mkBQ8hB09GIv
 NuyebytsFKKaVSaOWDWKZxLN64In3UK+nKcmcWdttnfAhYZBQJm1ZySTDmX8wVtj
 sRBrBHvzZ0DUPAnHKAx9afBVtTrMee5BYoT9zs65gFEslMs9I2wZ4BXK7XiB1M/Q
 IOdfuGvCF8BHt3gOT03nhpud+zrBVFmHGhLsdlOEgAGb9A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpm3v9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:33:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c0c1025adbso901029685a.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744022021; x=1744626821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbL9/YnYabTgt1rv9ACmC2Zjy3JhkViM0kf77FqfNCo=;
 b=rCVmRkO4tNXK2BiHnjzV0AmkOaZDI8fHGZwOcBcAkA1FGKT9kSL0ACr6IchvHabWGD
 AEHe3i9dJXmaGGrcpL2UrOOp9SJBfmWJG7TJC7swQ9QjYYic7qehIbA/pWhqJFzJJr+n
 ivm/EzHT+gPcTUqhGsEydHKyxxQkqUWDo5q5WnSGmtWqWTZfeMcXKv9BjFaKBLSoNSH6
 P0RrHu3J9idN7ciU0rZMV5vQ/94rZvT163SMizB5zwoAkWvkaGFFQquxspb9bMlaG6iW
 dVSlDjd63b/mmjVKs9xsvdIO762OIR09F/hqRdHnwavEkZ8JquKlp0mxvSa8F2rE5dL7
 E5pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2YxKgTSeUiNslikzBGdtAIVMHbw9LwuDbj/AlWDOIB1gbftabYKBxlVNavtP+4cnWnElfg+A=@lists.denx.de
X-Gm-Message-State: AOJu0YyTqjwtPm8Nz6SHX9BLnIUWzecRNZBhaeKBfI9uFwpWUHS7P71J
 3ky1x+kPjqZTLFD3Bv/YmGBmzfUBdbsB+1R0S9p9+1M9qm28PBMIQRK6ZSCYtEB2g+0j8zso2KS
 BUYg7JKhRSrByc1d0J/HY8/aTt+2Tv90voAsarCrcFoVK8Ka8hoic
X-Gm-Gg: ASbGncuB/teBNuVAWHNqGqXZG4VnBN8K+NKZ5/xElV5dtyUFA1txC7B9JlcIUCar9xw
 gUDagPV3oD0xwZ0VOHxM5ITFurV9Ft4g+np5ySjG5rcQCo5yzWk0DSNqOK7SP3Gmgo1pidBlxIz
 kuHCv99QuQitjBwDtudwAZp1MU5uEBk9iwpPFYrdIGtI4thraCYOLKU10T5YT5yHUVLk9Dnm4Oh
 GFp3KVl+ACgX6SjvsLP/29yfCrmudHE5k2ApNKFdpdnSUnz2QRJcyJCvC3MZUBnMh2GrCXWvhbs
 4yJGfZ6a6UGfJt7RP+ZjhbgzYHYopu8APnvD+NKcG6JuAm9QCRw=
X-Received: by 2002:a05:620a:1721:b0:7c3:c814:5943 with SMTP id
 af79cd13be357-7c774d277f3mr1796207085a.9.1744022021533; 
 Mon, 07 Apr 2025 03:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj3gsQ/B2eYvRZXhUN+8NqwVTENj/QY4qxC5/bpN/HJmEgIHv6PI44UxJ/jNyZhz3Z6wCajw==
X-Received: by 2002:a05:620a:1721:b0:7c3:c814:5943 with SMTP id
 af79cd13be357-7c774d277f3mr1796204285a.9.1744022021166; 
 Mon, 07 Apr 2025 03:33:41 -0700 (PDT)
Received: from trex (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d753e48f7sm5432819f8f.4.2025.04.07.03.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 03:33:40 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Apr 2025 12:33:39 +0200
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 6/7] mach-snapdragon: board interface to enforce fdt
Message-ID: <Z/OqA6mZK+5EI/AJ@trex>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-7-jorge.ramirez@oss.qualcomm.com>
 <79fe85dc-9f12-4f64-a269-1c2020d015f9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79fe85dc-9f12-4f64-a269-1c2020d015f9@linaro.org>
X-Proofpoint-GUID: p2p61NyX3BybfFCQPXHI5U_TBPBX61q8
X-Proofpoint-ORIG-GUID: p2p61NyX3BybfFCQPXHI5U_TBPBX61q8
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f3aa06 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=sQsx4EbTpYptnzgV4B8A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=692 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070075
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 07/04/25 12:02:31, Caleb Connolly wrote:
> Hi Jorge,
> 
> On 4/7/25 10:19, Jorge Ramirez-Ortiz wrote:
> > Some platforms might require the external fdt to boot.
> 
> The better way to do this is to use the u-boot-nodtb.bin to build your boot
> image rather than the one which includes the internal FDT. If that works I'd
> prefer it (and it can be mentioned in the build instructions).

ah of course, yep, will do that.
