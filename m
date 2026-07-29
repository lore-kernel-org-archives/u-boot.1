Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89368C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30A656083A;
	Wed, 29 Jul 2026 09:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ED0ObSijdG91; Wed, 29 Jul 2026 09:17:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 488DA608B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785316662;
	bh=7jxUODshFO9TcIGcYRirO2gmkfI6BZnEudLvy8AO6gE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wjLpVJoTCVetgx1rATHoMayl02yb4CRohCu3Z2eCFf3D5h+aCgJ0q2v670Yu/rjbc
	 NnPMYh8mNsZDFNFyuH1JjNJPFL6EFqmdswrZgWUvmmUcsSyJfLZIcWN+KkIFUJx2JC
	 7TX0mjLF7tHGf3JrHye2NneyT/IMwi7Baf/oVD4BWwSEUwfWbFV6bD0P7a+6vbG0bi
	 YfxwcPr5hxnxzQCvP1UV9/s4a5paPr655OJgtNWMSp/83cj1iSxxMxdhHIC1TMTrds
	 qn1ML23igOoJGlJsxaWMw/uxZ59pjSfeQL9V9+oYHz010mZJUVqwJ5ZMI1d3XPGiuQ
	 cwRWhT4YDZJ6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 488DA608B6;
	Wed, 29 Jul 2026 09:17:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D363E26C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5B1E40AD9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:17:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbDzb90_HTaw for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:17:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6935840AD3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6935840AD3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6935840AD3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:17:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66D98494B; Wed, 29 Jul 2026 11:17:38 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD318404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:17:36 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7fEfH1372485
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 09:17:34 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqbmm8uq1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 09:17:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so482218a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 02:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785316654; x=1785921454;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7jxUODshFO9TcIGcYRirO2gmkfI6BZnEudLvy8AO6gE=;
 b=PZLkhMsHRhDwD3ws1/u6MoJmkmQfKxOAPscaeIFUew68Ezlp44unKiiuyzTAyPGPBB
 xwPyxcmp1R2EZBFp+UkgJWoWUC5U6DxPM9jF3yD9efHJES+abe1n4mMApns8A1pC0Vq6
 k83XanBbNOil8u8+jF5Bqt7PdSEBnHLOry7WmEzeGOAhqe302Y+swxTmwsKTH/2aUqHo
 nizhMoDLVWCOJ6caJaKZdvj7lmQVXhhQtKM08R5cHmEs9CVYeoF2moJnEi+Wf0KcFXVA
 BOZDmTusa+nfaN4NgrVHAsVdo8SUC5RyAnwO+WY0nxCiNVM97fJSGm1dUiZ0J7DaJqrC
 WWKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBOMT3Uu8rYHSuII91o04uMi1/vJ7pHxA57SGMt59ZKkD/MvtqMFOLL5n4gfdzk767NvGM+so=@lists.denx.de
X-Gm-Message-State: AOJu0YyrPIXp2BcEMQOBSw7Q4P6K2HNtWPfqEemVhMUA7bg9V7Npp5s+
 2OHkxHQAZnrD+igmk60sNKXRV8/CvAdK7wO4MrgJ6ksH5MyTdm20KCGDmoVx6bgmkmfovMHWJrv
 xu7trNZUqRC8pWz/0XJI2hoQpn7L54o+zakpOPnqviEbIsD9Xu+wt3/3X
X-Gm-Gg: AR+sD13krWseEmNjH1fi0s9gWD+NS/JoUP4gh5e3vBMbWFj/lhpQVWRfqQqRIKLXLqn
 w297PA8HQCgU4H3enWj/rx6t2Od98hNIHRLGKMrlPvXVYCnNnwRx2ChEGMuBTL2e6NMwC8ISMC3
 x/EoKPuXD6y6gU9+SCXR1t/WcW5Xv/oD156NJnSZPUEc4qchkY8xpPU3x0dn6Fg+GFzVyeTvc8o
 S020rhsq0HW7CsHHtgNe1B8/NGb5LaUoQmORXQoBwDT6RwFslIqAJmEBHW76wmu+Ln5hJ5G7H5i
 7HnmJfzIBHHHiHp44XeLfX1dT9B2tBVnovLU50Jckm45But5xEqcPP9KqIjPHNt+HxL7djmFVQf
 TEcxdVV2I0Q0TlOdFNaDMS7mWEpB+Ybo=
X-Received: by 2002:a05:6a20:939a:b0:3bf:6237:4d49 with SMTP id
 adf61e73a8af0-3c8ac7fd04cmr7319828637.23.1785316653755; 
 Wed, 29 Jul 2026 02:17:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:939a:b0:3bf:6237:4d49 with SMTP id
 adf61e73a8af0-3c8ac7fd04cmr7319789637.23.1785316653333; 
 Wed, 29 Jul 2026 02:17:33 -0700 (PDT)
Received: from [10.152.205.146] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7265be48sm7697905c88.8.2026.07.29.02.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 02:17:32 -0700 (PDT)
Message-ID: <df8355e2-ea45-4aab-88cb-4b38641c4067@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:47:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] clk: qcom: Add initial Clock driver for ipq9650
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, michal.simek@amd.com, luca.weiss@fairphone.com,
 danila@jiaxyga.com, adrian@mainlining.org,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
 <20260722104624.3842833-2-badhrinath.s@oss.qualcomm.com>
 <amCrqsQLNyW5zTsD@hu-varada-blr.qualcomm.com>
Content-Language: en-US
In-Reply-To: <amCrqsQLNyW5zTsD@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA3NSBTYWx0ZWRfX84BF1wAaKoMF
 sjU3B858GGwRg5bAwx2PDXmyj7+gJSalCi9itw2Vm1BgRehEyDwyLTFWAwNMZ6YoYlHMPYpBuv0
 KH+iaqatnsCt/V7/LUr4+90crKT5nYE=
X-Authority-Analysis: v=2.4 cv=L7ktheT8 c=1 sm=1 tr=0 ts=6a69c52e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gu6fZOg2AAAA:8 a=AkcJ4Fg72frSqiM3ujEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-GUID: gNdUa4UgBCT7rIWJzS5H_DM5mCcyz_Fl
X-Proofpoint-ORIG-GUID: gNdUa4UgBCT7rIWJzS5H_DM5mCcyz_Fl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA3NSBTYWx0ZWRfX8BKYomoEz17O
 RirdDWKQZ7F2EQrj2DZTZ5a0tmKJKHTtcCtNpUNBrCdrrbkWcUOz3fhKQOjmhQmQzMenhbPx1th
 Rq2DaM9gEZWxHziJA0np2qfUtb94lpCl42Vuy2+UP+CBJfiF3KqHjSY9osgtglequABvfnY3yYR
 KEOinckHJK8JhgJ93O0RkOOPZkurz5QR9ZlFLc/O2jUrnX550nRHKBr8WZoapTwfCTKzG1q4r/j
 7IMAN+opA212wHKknjQDDX2v93YNSbcjaTp7SB5DzFlt/4z+1+ghdttB6bNRoTDsA5joBoI3Z8B
 lnc1CC4MUCcNhyqML4PEcyKyeAcgVppElPMNk9XkvWE7q+wgQPNP2ZarIUVEWU5rZV3WZykz1JX
 Ku1z2trn3Dn2J9uHdb3gsWtynce+bKg8eLizOB6l67FQGp496/TGIivuvczYXaoySrueA1yoZ7q
 c+gG25i9MKB2civG3yA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290075
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7jxUODshFO9TcIGcYRirO2gmkfI6BZnEudLvy8AO6gE=; b=NdTXUcRFj8UJauFO
 ayL+QLzFpRMl7v9+rrMkVflQuu0a3qMu3auwY0gmCKwSmL0MHdhljFRnvRpDQWQV
 hNhsmWeKJ0lYPYqoJGgeS/j2pb6LqvxM3pCt7XpSalgZL29B0qKmo9qK59kc+0Gf
 ZGhv+6elaVfW8fKy7kSCjyh+HXFe8fGuxrNuAKFWdLMnlvRGJ2L+09dOVrTwBalR
 rTtIFnLOZVIbFdkkKCIZkob9cK5JoDMrt4CvQAQWn5VyBnKDMWZ/O/RBFvelnp3m
 73jO/oCWrl1iAn7jn08x99rTFFCQSe0WTtMnLGXgn5i7dNF0C9YYqEA9+a04NbpA
 xYwTFQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785316654; x=1785921454; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7jxUODshFO9TcIGcYRirO2gmkfI6BZnEudLvy8AO6gE=;
 b=X9VO/3iyy40qzgaLRS13lNniVM/CzoAm6Qw88bjfLFcPPAGjvu+AadXt/2rzSXnX0K
 MY6ZPeMxlUuy2+piYgysEaX5brszN2Ooo5fEQZbolX7UcjOrZqsXllUB3racJcIriMGG
 0v21VZA7qZl5di97j0prDszIj+jJLbSEoiJXRDvzgeIVwyMtU+xLGYAINPY0+ksvijV2
 Ddk8zdVTb+xc3ekL+bUTwl/eo5/VAfyzGvbgiwN8y+htItDkzRFwrZMNhZF2rYF7mMg2
 qyQvygt98YcKtH8RiupAk49zxoYhrd+18SQihvvYE8v0FHIAQNmbmkYXw0hZqZ9/Vk+m
 URWg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NdTXUcRF; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X9VO/3iy
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NdTXUcRF";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="X9VO/3iy"; 
 dkim-atps=neutral
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
From: Badhrinath S via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Varada,

On 7/22/2026 5:08 PM, Varadarajan Narayanan wrote:
> [. . . ]
>
>> +static const struct gate_clk ipq9650_clks[] = {
>> +	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x3303c, BIT(0)),
>> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x33004, BIT(1)),
>> +	GATE_CLK(GCC_QUPV3_WRAP_SE6_CLK, 0x04004, BIT(0)),
> Use GATE_CLK_POLLED. GATE_CLK is deprecated.
> Have updated in V5'[PATCH v5 0/4] Add U-Boot support for Qualcomm IPQ9650 SoC' - MARC <https://marc.info/?l=u-boot&m=178530478539468&w=2>

Thanks,

Badhrinath S

>> +};
>> +
>> +static int ipq9650_enable(struct clk *clk)
>> +{
>> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>> +
>> +	if (clk->id >= ARRAY_SIZE(ipq9650_clks) || !ipq9650_clks[clk->id].reg)
>> +		return -EINVAL;
>> +
>> +	qcom_gate_clk_en(priv, clk->id);
>> +
>> +	return 0;
> return qcom_gate_clk_en(priv, clk->id);
>
> [ . . . ]
>
> Thanks
> Varada
