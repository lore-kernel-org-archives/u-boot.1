Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E01E6B26E
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 03:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2D583E70;
	Tue, 23 Dec 2025 04:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cEUHoZ7f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ja1p+13W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713F983EE2; Tue, 23 Dec 2025 04:16:12 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5EA783DEB
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 04:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BN2eo0W2199451
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 03:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/omenjO+/rpCvm/mCFiYZu0m
 ehZFvMSwN0b3afuUsAM=; b=cEUHoZ7f8p1yxzVZBgbs6DyTVO950O+aWB4dDdf2
 0G8eYr7i49Z1tfh/fVY49TIWlWDWZmobQfKhg4+a2sUrOnnTeWio7fbP5SyxIT/T
 rY1rppi62um028OCFYuZd1fvWyvBUUlBEQ6lr6D6ciQ58c3fceM8b1+6hzfWEgx0
 D1CsGhNHq0xgwpRqdxoyrnjKJDwHNx79NcvFqAkl8yValqDyd4h/nSjQHfi9r0P5
 8SZPWiIWcAtVIb+4j33aBYu3bhUBwsrZapcfltgNAlCkLTYY4b7FCtxzyTs0fi5S
 1ynuaRqTZ4irVjuU0bP6gZHm6mCMgUwRrJnPRahPe+QryA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b73fwtj7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 03:16:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c213419f5so4376534a91.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 19:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766459766; x=1767064566; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/omenjO+/rpCvm/mCFiYZu0mehZFvMSwN0b3afuUsAM=;
 b=Ja1p+13WKutf7pzmbdv8uDaYIEzBH5P2R3kNwpjei+dFv2APkIMmXvxocQfZj6crXE
 E/xZ3Qu3W7pOJuuDnJQ+J1sYRPyfFyoVaz0N+niqJHVPnKQqDA2AO3ewp2UWKyanY7TK
 NFFd5XbhtPkFovEP50AoWM87Wkx1uG+Q8ak+zIsPDHcROyVMLs466K6aUpvrVF83MQkl
 jUZE2Bi1geYKpChuzm+QN55Ikyh15OhHMmP13VKs0CH5JTJ5CvK/XTVHB9r8mj/U5Bsq
 axZfrFVwraCKklMR/+IBikctMOA2vpxXzzdmptc1N/WFhJWNr4+mNTlFxbi9nPaG8Xst
 0bGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766459766; x=1767064566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/omenjO+/rpCvm/mCFiYZu0mehZFvMSwN0b3afuUsAM=;
 b=vCUI8V2QIH1dvzsyYeVTMRLx1NhFeCCQPxkMRSxCpywnUsfRYwVOZiwWwykYcKa8kn
 xjg5bQP0TTZ31R+2nIu0hAa2nPKJOCeYmWxGrch6lXBnKWv4MrwdsiohFhqPCt/vulf1
 zEWd7kNnME890B1R0RvmGc1KEeS0RZYs+zO5OBIch2Ma1Hhid+9tluL7x1wcd1XtuUnv
 bTsMXJPnOIUxY1dIFhtkkC1G5GjGRKNf4+vQdHlozlCPH3MYm4bmjnYZZRGJfwkTzA4p
 ryM+l4Lavb1RUrogLgR+NaA4O4KES6tNDVfZ1IzMcF9wUWY1N+kHLq90Nt6l7x3RYiO1
 r3PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ1qP+3O3013y4o2ySTmw2WlvDwo+rMtREWJZVyWLtXbg7EXiAyEBE5yBEW4YWJwV4W2x95jY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxtn07Iy0NMZTiUMTqOMl9uFKwDMnj1oUQS8k1K5QaohiRXGdqG
 7728vr4SnwL3r2pKMllkQlZ5P214km8M49jHUhQwYPOLaVD8WhlduDiVDPvy7Rm864kVUhUgFOJ
 rO6hvCSmnbPfHQCScaMt3b5ZHVRLNrCMDR+iscjmEfKjEIfhEETqo1ngQ
X-Gm-Gg: AY/fxX48+vOgaTT3Az7RcShb5skIBKnsaZl8Y02P4dSvC0XZiT26Rb+BPvz/k3Zc7d9
 DlYW/+CZQSgWZQXSaDZKL6BS+OLyzy0V1AKDOG785V20jk75kdA+MeFWVXzRov0H6e1PrVm5Hv3
 0bZpZm369XBMlWeFNMIkHw7NFPReQ5c1kjs5DOzK2kXWikAPNyH1O3pueG7aswkEFyZnb9gLgtk
 +5iYSPpMaiAtKyZiaCYhFPoxo11aWU1YvpJuFNAtFGvG++pnwqf81ebrD2JkJZdnlzrDuWm5ZSB
 evdWewmkOEzJW8JtzUtvX2G0ZRJoqcHaT+7Nlfo53AaFLlnzZIyZGvUPRG0sgU5ZIifC09fE6fw
 kOUxYO7nlPm3o4LiF52kpjXs4Ic0IqZhECufxgCnISSlbwJTfoSh6RZCF7BaXKjbOydYE8PC9P9
 qZglsiqy82gXMedg4bX/UTxJJnqh6J4nU0ocNW+zA=
X-Received: by 2002:a17:90b:548c:b0:341:124f:474f with SMTP id
 98e67ed59e1d1-34e921e8a0fmr9455027a91.32.1766459765880; 
 Mon, 22 Dec 2025 19:16:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnAzcirhpWY1m4mDxtMYRZ4ZKxTvBjHpMWVGph7MeRjVx35NEdGL6+f11ac600zmct9hTJ2g==
X-Received: by 2002:a17:90b:548c:b0:341:124f:474f with SMTP id
 98e67ed59e1d1-34e921e8a0fmr9455000a91.32.1766459765396; 
 Mon, 22 Dec 2025 19:16:05 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70d4f7e2sm14175428a91.2.2025.12.22.19.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 19:16:05 -0800 (PST)
Date: Tue, 23 Dec 2025 08:45:58 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v7 2/4] power-domain: Add warning when power-domain
 driver is missing
Message-ID: <aUoJbq2YoAqOKXSQ@hu-varada-blr.qualcomm.com>
References: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
 <20251222114823.2146775-3-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222114823.2146775-3-aswin.murugan@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=694a0977 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-WCB9TnYaejT2uKtaZUA:9
 a=CjuIK1q_8ugA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDAyNiBTYWx0ZWRfX5llkrSCYk1kk
 I76fGsEWMcgSg3pOKBDmKWXlKIdu94ns6AWyelexyVcgv5FVT18RGB/v/4MuOgWlSYZNiJ+mJ9W
 oIrX+XCA7UuHWbdJdihviAG3Kite3Riy/fGllyrABw1RCckXsyl9ShWQZsFBz08rgFZSLP7XJCS
 a0nS9LbOH4NgcXe51OvdR9z2RLY3oZTjVtIXgTuovDMb42yviluOS/p3GViZwmaH02yY7DI8JIO
 OjMXO1zpVMn233IZdpINOZH77IaIrzGbCSYLRctGvWfBYnWNyaptKUHeWf2T1NvuvaEDMdsF91V
 kbqRSmVQfNDwuuaU3+oysSjVAsrgZsKBr7qcknyIU91jC7yAhvWUymr58C0hGSQI/TSeb+TmW86
 nm4Vwu1W+Cqgzku522Jo1G8BlU6n1c6tlcp7FtsKxbec9W5/2e4pyO7Ine53FHpx22isDwehI8P
 E6wsi5V6Ik7WY/2Y2eg==
X-Proofpoint-GUID: p2FJBTzkkAha5TmRHfULqKipntWyonfS
X-Proofpoint-ORIG-GUID: p2FJBTzkkAha5TmRHfULqKipntWyonfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_01,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230026
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

On Mon, Dec 22, 2025 at 05:18:21PM +0530, Aswin Murugan wrote:
> Update dev_power_domain_ctrl() to log a warning if the power-domain
> driver is not found (-ENODEV). Return 0 in this case to allow continued
> execution, while preserving error handling for other failures.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v7:
> - Cleaned up the warning logic in drivers/power/domain/power-domain-uclass.c
>   when power-domain driver is missing
>
> Changes in v6:
> - Newly added the change in drivers/power/domain/power-domain-uclass.c to give warning
>   when power-domain driver is missing
> ---
>  drivers/power/domain/power-domain-uclass.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
> index d9fa8ad4bd2..52f56f57658 100644
> --- a/drivers/power/domain/power-domain-uclass.c
> +++ b/drivers/power/domain/power-domain-uclass.c
> @@ -10,6 +10,7 @@
>  #include <malloc.h>
>  #include <power-domain.h>
>  #include <power-domain-uclass.h>
> +#include <dm/device_compat.h>
>  #include <dm/device-internal.h>
>
>  struct power_domain_priv {
> @@ -184,6 +185,12 @@ static int dev_power_domain_ctrl(struct udevice *dev, bool on)
>  					    "#power-domain-cells", 0);
>  	for (i = 0; i < count; i++) {
>  		ret = power_domain_get_by_index(dev, &pd, i);
> +
> +		if (ret == -ENODEV) {
> +			dev_warn(dev, "power-domain driver not found\n");
> +			return 0;
> +		}
> +
>  		if (ret)
>  			return ret;
>  		if (on)
> --
> 2.34.1
>
