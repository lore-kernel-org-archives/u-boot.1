Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA41FC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 05:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 270AE84119;
	Fri,  3 Jul 2026 07:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HzFi8aHM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cnqIjEup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D61841F2; Fri,  3 Jul 2026 07:21:40 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B156C83FEE
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 07:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66342rM42706140
 for <u-boot@lists.denx.de>; Fri, 3 Jul 2026 05:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ax5mFxW0oqx9r5rpInbFVR84jWhkqnt2/cF8GMBXp28=; b=HzFi8aHMWJnPV6Ze
 /Lh2RGDYciNwagrNdN6zqFAcnjvq9c/EdRDzrsO3thCPu1Z3zLRNyLaTHmrRLp+n
 ARoC3yQfAT/+W/e9zUAtFuy4vPvYgMwMi6Rc37HnXHHgGukzNQBLY9LNqJGbGgXN
 J0XLnwmLbvbGk62KA/PYn7RKQIlM4DUKToSLdD5zf+ymEhkVMHHt0JdcQVQ5JUTM
 NnMZ0/b4Pmb1OlQ43AK7OjOtf3Ieyl4/SfJbl7Za7g6HO3U+v5D+qYENnNEz9s/N
 t44sMUzbDXxz4uNtPFZ5P+lDcPEMGLZTT1FMw+L5XZ+DXB1t1f8Lo2woRn/QRPop
 0Xo0dw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n944drv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 05:21:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88e0f04e51so250325a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 22:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783056095; x=1783660895; darn=lists.denx.de; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ax5mFxW0oqx9r5rpInbFVR84jWhkqnt2/cF8GMBXp28=;
 b=cnqIjEup1phLNsboiHvO9H2NuFxhL2dPpUSCxEeHShHU012QDKz/i71aJqtcbSMjvV
 0NkrPTSCGNeTUyf99EMrVPMwG+yhzNP4FTJocv2BVtf6XCbCVOSdWQ/pZxLCO6J92zoh
 IfjIvwq6PGYTvKHQlqjo4mLXwHqQ55rkr51N0jf6Fcv/iZrweXLVd2Mh8mqa2iB1DdzN
 5p9tCW7aJ3YOmKHVCxMO0FMf+Y8MXik6NbHmYexYlnZAddTeyTwo2Mcpet8PeF1U3L/Q
 3p2a0gO1bMR1+JfZymxCPqTn8tY+A8+4Zca05QvJPOelnjo838wt9xN843CLR9Mzd7CA
 h85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783056095; x=1783660895;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ax5mFxW0oqx9r5rpInbFVR84jWhkqnt2/cF8GMBXp28=;
 b=Z6Pe0aRzXdNFO1BLTdwWoEpHOZD/5c3IXJ9YFkLUcrK0ZqPNonZkWzRNkEAcMlAg3U
 XA00ishbePMzDv/TAd6wResxP3x6WV3yITWL6KG+hqClI88gtfS9D1xxAxXEhzFrGzlq
 h8ZZYa8KPCYvk9PlrQ2G5HQoj4QVY7Q5zKcbfbkwgT/dqH5lXvJyMSsV1yn4t3+goL7I
 779DX8IE+oGIRxLLiTHWo94uicDqgElfyN5wapWjx36iarVDd5z3VjdbYcFJUBCkfiMi
 /0OQh+UStW/p/ONuWzhQaJSVtSXCQGFMwsr/9WFC/ROHkaXL4YEvgSjNgl3ubaxbGpei
 JUKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ98zWF/ts3ki9y+6Ho2E/tknYk1Nz43CW7UduiAJPilv52D+omkOeKPmwvD+CTK1BfyRHLC4c8=@lists.denx.de
X-Gm-Message-State: AOJu0YxnzFwMqCga7YFC5mcOnMdru5pSr3GTg7bYdjjIXS0aKfduPgBN
 xZW4R+MhlWFih2lRWb0b2J5mr31ngHBgP94/HbWFSXOSM0CGSanthXzKd8QXhZR9RHLYVygmxZY
 NrrNgvJnukQfjfrOIQGQsDaP0gLWkqtvQtWfpKZsxSvJ0ImmJTGc59HWc
X-Gm-Gg: AfdE7cmUk16lSUAF+elqxYN3rtMcHRTgL8rMVm+SNuZwusnJYUTLlFBHTHiNp2VqNz4
 96H68wRXh9k3DtsFU3dW+NCvIPIglR3xGmAHWkpwn2sxaw8k5hUD2wHPMCRRvbl3Zptfl2E9SDt
 mq99PtydD4LiPXHjJZ8zvFRIulD++ElCEKtZ6fG8YPgNxjkZ5StK0faCcUGYXwJ4cIAxJMRigDn
 QSGPuwwFsbGm5KGYH63sFohd+30TUxewlrdM6YTA9pWh5UBJSKONHeYlRF0rTCQ074Vpeq8/aVz
 J6frhd9kH36NetWW+OG4wj9EEzWC5rw9+xvhMIWYZHXGpdLrg73ZxDREUw43RXz3jGggVDtHzdq
 IeADNkqOQ4OTfLnzarZZ0RUMujEclMIQ2gRqSMyzeTSVmom88kqXYdH1W22mnAN6KdyOCXR7AGX
 Sg9uD7GZ1N2JG92ERYeZ0RGDj0TUG6qHXYz38FzCOy
X-Received: by 2002:a05:6a21:4903:b0:3bf:c07b:a9ab with SMTP id
 adf61e73a8af0-3bff430f6b2mr9512160637.55.1783056094824; 
 Thu, 02 Jul 2026 22:21:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:4903:b0:3bf:c07b:a9ab with SMTP id
 adf61e73a8af0-3bff430f6b2mr9512107637.55.1783056094198; 
 Thu, 02 Jul 2026 22:21:34 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bb80f5csm23472206eec.15.2026.07.02.22.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 22:21:33 -0700 (PDT)
Date: Fri, 3 Jul 2026 10:51:25 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 clamor95@gmail.com, michal.simek@amd.com, u-boot@lists.denx.de
Subject: Re: [PATCH v6 3/5] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
Message-ID: <akdG1STYeiKYRjZo@hu-varada-blr.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-4-varadarajan.narayanan@oss.qualcomm.com>
 <667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de>
 <4fc15188-3de9-4345-85e9-d594efe9bdd5@cherry.de>
 <20260623165021.GJ382693@bill-the-cat>
 <0a0af22c-ce8f-4c41-84bb-32d1b949c1f0@cherry.de>
 <20260702174613.GC749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702174613.GC749385@bill-the-cat>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NyBTYWx0ZWRfX0TK1hfJKLdh5
 O55jmrkm5VVvZZ+ZJWVAIw9dnT2mhqUntkVSYnWIujWmIsw6s+usNvIc2BKJ8biCDWp2P5wT54L
 v1e60rtLG31j/axyub1e9zVqpencs354HcHqSDzJtKKmUOwfaQbFIGJVJD9ZyQIx67bZQONb/05
 goNpTXQ3HDrPSXZxoiqIM4R8r7CoWyMY6xlqLQfLpCb4sM70jc7vigj2in4DLRqegbRDbTZ6RKW
 LSGffY5YV0reW3YjDxsCLl/9jjiTSWWUisokf95zbiDFMOFoDhNodNVaS/WS05+k5VOpm/RauDR
 Fo4PsVdCyC2psyBMig6Rzts/R5tjq3QYZBDOkxSISVYV5iZ9E64HkgtOkOKB5JovS5HREieJX+h
 F0NznDDQVDs4MgGInM9Nhy5LgWj6lXOcg0F/4RnR08MqZ4UATxqAtZGX2G+3QkpuCrr6Kd/4XtJ
 D7FK+5ut781GHIWxWxg==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a4746df cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Jbssjx0sovcfAvcieLQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: zYSJ41RxqRDn_omt2VpfyYnFWEGt8Ore
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NyBTYWx0ZWRfX7soJYpTRPzXt
 syQ7lJmy6BJvzdAnkqdEY0Wnw9+stBR0/CmTyg0huoO+Ou9pPa3UnqaqbynZ+eohWNvd9NZ1J4p
 WR/runY/CQi1Hi+fJ/zsRgPcQ88pAfQ=
X-Proofpoint-GUID: zYSJ41RxqRDn_omt2VpfyYnFWEGt8Ore
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030047
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

Quentin Schulz/Tom Rini,

[ . . . ]

> > > > > The issue is that the first sysreset device implementing the request_arg
> > > > > callback will consume the args and return EPROTONOSUPPORT which will
> > > > > stop the loop.
> > > > >
> > > > > Think about multiple sysreset devices, and let's say we have a new '-
> > > > > dummy' argument to the reset CLI command, then it'll depend on the
> > > > > registration order of the sysreset driver whether the dummy argument
> > > > > will be handled by the qcom driver which will return -
> > > > > EPROTONOSUPPORT since it isn't '-edl', or by the dummy sysreset driver.
> > > > >
> > > > > I think we should have a fourth possible return code which is "I don't
> > > > > know how to handle this argument", e.g. à-la IRQ_NONE in Linux kernel
> > > > > for interrupts that aren't for the device this IRQ handler was triggered
> > > > > for. Or maybe we should really be using -EPROTONOSUPPORT for that
> > > > > meaning and not exit the loop if that's the return code?
> > > > >
> > > > > Or maybe I misread or misunderstood the code?
> > >
> > > Following up here.
> > >
> >
> > Do we end up reverting just before the release then?
>
> Please send it out, cc everyone, and see if that gets some response?

Sorry about the delay. Will post a change shortly.

Thanks
Varada
