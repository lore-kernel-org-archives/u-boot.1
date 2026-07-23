Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704D0C531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 08:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 357ED60681;
	Thu, 23 Jul 2026 08:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1RvU_LIlkMKW; Thu, 23 Jul 2026 08:36:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66D9A6069A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784795792;
	bh=Joh4ANCqj9dM4v+LZqwizQA+3LY9J5GVENwg7JI/WIk=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zKA8wk9CQpiaPauIgsBamDKaKhejrg00XInLFjpAQ8II5y4U0LOLJTxFljB4rORrx
	 rtAWIR9F4EZ9T5oLCYCWxKiHlEOYh6iqvrT8xn6rqtVH6AbTETKUtX2B/8j+FoCoOp
	 i0w1y5+7D9LnHmH6xoWfc66LatDZL+UuKvCpQJ8iM2CVYjoIk/0/vpYBIi3ii/Z9mo
	 6jHqnrcgnMeKyi/d8m8G/u2j4lmPzAgezKhhevmu5l2pjeVSytllOoBH5RJ/r25opI
	 1BxAXqQgJf0JihL7jpQ4D0tayTmAru81nKRz4miuVqj1/YaSYgrENs063K2l54yIID
	 lItVQ4zDXpNnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66D9A6069A;
	Thu, 23 Jul 2026 08:36:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04483347
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9FF86069A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DB_fIQ_BFvKy for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 08:36:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4047460681
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4047460681
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4047460681
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:36:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7Bbwr234473
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:36:29 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28xu4ee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:36:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so288835a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 01:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795788; x=1785400588;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Joh4ANCqj9dM4v+LZqwizQA+3LY9J5GVENwg7JI/WIk=;
 b=LZQ9Vt3D4gLhNj2JCPv2wfNjS+9kY0kxTIUyx34UmM5jKoF/6gqeDfZYsoma8my9ch
 kIBUFPn5p0dQX64lrXZ7DJWsh28g+9KxKhdIiBDLQgyzvVJiPuOCeyIRp9CH2CcTrh3k
 suxEWLiHNVr/2JesgJs2jTd7XmEgrmKD3EjB7OpIe3fszUVpavTgdB2l+D6GB1r1OqV8
 dZYKvOgHoIBlU4S7E1wURjyHrWEzO+4y4mwCjYBdB4xEZWXcQzGovo6RlRAOntSJq3dt
 ROa4wPqYtjUQdFsaEQBW92FL5SOGg0D8tX9+7eFFkjwsWctoeMc3rXLi9U6DVoGiPJvo
 bsRg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1dKv63dS8miq9YThzR275mg4jnh9j+cCAdXBgfULWdTG38AhCgsnm21JQ9BSdaVONvPIhyaw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw6f22Mw890SWo19JPrQdT9ilJCcEEnHW7E6UerhMeTEVrsfrbr
 +13CzL+4KR4l7584URqDkbH8UCdk7i3f3MfIvri7yiQLh6g0peTGc5eaehtsQyoJAfQ/ngta+wd
 wRxME+TNKiKFlcIu2U3XbTB/AOnKiop/lIRtgcwkPmMQJZkrC2zXN5Fw906CS6IkoI5wNLuM=
X-Gm-Gg: AR+sD13AXKEOhIX4tVkFgDgUh+sjfI/G83MR/KRl6tkjzfKOud3jYIfOawuia2EZjFB
 WJ79QR8Rc5tunqtEz5+3cZw39TFm2DzsNBWYAyXa15e24bWzWtXZoZOiKw+2WGljx4E+QwoMRvl
 ug/p1aMV6FQk757QPwqnV3cr1qDe+0YE+QLytbQbYZ3hExIRkyjJO12UkcuW/1QDH7v/iZifPZ/
 wvVIqeh0ixasLojgn2qUR68WxkeQybH5MjApyy7wFfldoktbyfn/B+q+ewROHHLsA2Wh6mkPSsy
 uG09Ve7zEKSI6fIGyUNSpk1j4/kgDVznA3QhMAx0BCGebhuYj8o0XZpuzhbvGCoA3g4BNeWSWpg
 bSQngvgbWJXsc0lGg2EgJPTiMr39mc8TYBcxubCs8RoxzqyEtTt49stpoO7PkYMr6hfn/uXFAWA
 9due95sSgOGlalAMpzUx93i9LkGP5DOA==
X-Received: by 2002:a17:90b:380e:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38ec83d0c2bmr1833481a91.5.1784795788302; 
 Thu, 23 Jul 2026 01:36:28 -0700 (PDT)
X-Received: by 2002:a17:90b:380e:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38ec83d0c2bmr1833454a91.5.1784795787830; 
 Thu, 23 Jul 2026 01:36:27 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130ce035sm13734604c88.13.2026.07.23.01.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 01:36:27 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:06:21 +0530
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ajit Singh <blfizzyy@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] clk: qcom: qcs615: use GATE_CLK_POLLED for
 CBCR-backed gate clocks
Message-ID: <amHShecJ1Irso6Fl@hu-varada-blr.qualcomm.com>
References: <20260723-clk_gate-v1-0-9549cad4d097@oss.qualcomm.com>
 <20260723-clk_gate-v1-3-9549cad4d097@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-clk_gate-v1-3-9549cad4d097@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: NxzA1IBjNmW9PsbHuVBcytJWSQ0hGdIY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4NSBTYWx0ZWRfX4EehUY5JO1xq
 YoVsXO7aDRrpGKcfG1ALL96nBbAcobH1JISoLlfIAknt8Dj2WVlkWKpeTiAep0pGttB+uIXtMpJ
 H7noBBc2Z8co5y5MC2jhIJKFCofcJ/Q=
X-Proofpoint-GUID: NxzA1IBjNmW9PsbHuVBcytJWSQ0hGdIY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4NSBTYWx0ZWRfXxa6iM04Z+DGS
 JQB6ITbHJnp2ylTSdbM69vE4wslnsRyQAduz4e834IwGEqJ291s9CvlgU3GHv8bohfMbFHXwKaR
 5ya/rIPr71iJJrswq91pX2Rky2WDnOxI/wkW1XqwYoIS5FS+mGuSykUh6jD8xZHBbp6KeqgItIe
 TEF1T2qyg75BDCgdClsBk1Ryk8UmNz7NWnVjgAoqbnzd/mwXDzldAO/Fq3mnFI+orQpjVXgxpxj
 WRHBU5ZpE4d6bqQZtL5jIyQ+/+BSGIaWhGb9jfGruHZk5i2uyH3nYQTx0D1KA7s1lP8NL/Dm8bt
 NwnXA7cwuQ6k4kedfJphWt6+/WPo6ae8l0K6ppl/9XY3iUFSTgSsJYVpj6piliVo8LSOCOYOXPd
 7E4jcCEZDbKlhZYJ1+yi6OSB4v8lizrwPlRsIT6XV8q49jXV9ZgcRO2M0f49/IP494WjrSHUhd7
 /UF7JVe41FgAOP/LjFQ==
X-Authority-Analysis: v=2.4 cv=WNxPmHsR c=1 sm=1 tr=0 ts=6a61d28d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=kK-LisVwv4V8z5IJHdIA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230085
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Joh4ANCqj9dM4v+LZqwizQA+
 3LY9J5GVENwg7JI/WIk=; b=PoATLfROVLEi3mU4gmbT1qSL6DoUrGyRzVAoA5/S
 WUJct0rH/1JobNgb9OYMpiAXQjjuSp9/6s7iTpzwi1dpAIMjKsQKMb7b2kZAFqrp
 KNHOAPcPl0L4gjwKPB2B6NKvovepRkWlRlUa7gjmz96rHZgwOEGItATMqu3w/d9K
 yylxdoNsMzYLxyVzkOkKrH+xqJTJHp8bm20El4Pfdy6/y0s4UKuXdog9bgnMicg/
 RhgPjotPBRKQNXPGMF+ZXMFxSkNxhLwV1RK/dF0HUc20PtM6GMXpMUcJgbek+DfD
 8j8YvqkT3TAUFWBFkvXjwqdFyvEPsaE3J+RAJXT7XyXb8w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784795788; x=1785400588;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Joh4ANCqj9dM4v+LZqwizQA+3LY9J5GVENwg7JI/WIk=;
 b=W80L39Qvl6FmZR+fK/Bgj0Q+n8QRdr67QG6RKZdnbWG/vsSbTzDjBr5oKFukZSIEl8
 LOpySaYaoCHnp7Dk/hTvKb3Z3evC4V2Zz7ovfIFrhFXeWUIhcki+tfREvKNS/CgrsBoL
 iciJ6POgzpVMS7iIvRaC0rBIwtrvixEiYSZT5KrXJ4xbPkOvmxqXjdkCwFqQT1ceSHQx
 FBvAGiIC0JZoBdM1FKKstZHVg3T21g0MlWX8sVjE3a5dOlWPaqkkyhu440rGHywpZ4Dh
 c7B+Rjb5Cq1malh+MOMmQKkE3FLZSGoFX2sXT+JKzhl3jGaSlmCuPGTP0CUkXrDZadMp
 oFVA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PoATLfRO; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=W80L39Qv
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

On Thu, Jul 23, 2026 at 12:09:48PM +0530, Balaji Selvanathan via U-Boot wrote:
> Convert the USB3, display, and UFS PHY gate clocks in the qcs615 gate
> clock table from GATE_CLK() to GATE_CLK_POLLED(), so their enable
> status is polled against the per-clock CBCR register instead of
> assuming the enable write completed immediately.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

