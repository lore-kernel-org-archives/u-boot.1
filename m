Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBE0C369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AB5982D17;
	Mon,  7 Apr 2025 11:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mdZT3VF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC53D82D39; Mon,  7 Apr 2025 11:38:28 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BA782D0C
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dlnv010420
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 09:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1V7VWdxYjyM0/wYivEl5DYexZPDFQmRuFrmD4YUn8WI=; b=mdZT3VF+swOBjfM0
 XwL7QULKehj4JwNzR8x17UJM6WMp+GdHm/9cKzgXc7eNMyttQiQmN3WcU4vSSvYO
 3aJhOeUyMUs6zLN5mF1CPDJ0ei1Gk16k0uTmlzeF/ljc8mCB8YGExZlc1d9/wXKh
 ZvOH7T0p3yPx4ugTMxuOEFkOpHW7H/bBloMBV0FfPKl0eR60+xw7hcLB6Cz2AJhq
 xabmvZiUKrSAEH+EYmB5uatHZ+GtgF2rPYSF75wHWBNmc04Wm2kEIHWkV3Nc67f3
 FKdne/TignIvMqNmiqxinrQtSoagbDuhp2B7NrHRWUB2hvM2hiPcfIyVG/BmKAYD
 4UoDAw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2kt50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 09:38:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c760637fe5so733406185a.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744018703; x=1744623503;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1V7VWdxYjyM0/wYivEl5DYexZPDFQmRuFrmD4YUn8WI=;
 b=WS2Kp5cXhKYJCmCSQyPAzaBzeJkJ6mB29SeSE0HZOWBK34olev3m2QBuNbtBLpVYXU
 AmRXJcV8LYmC4Ga8NQPX2KCHb6r9jTnVMtmRo/vb2L3fcw+5Of40DLchxjO5kRbsyV3+
 OudCCAusfIAm8cGtHICjuMonU4vL9RG8RJtXY2whBYKU4Amy5Reuzb8sBFLE1099Kxt4
 SGKcY0s4OrJ6ZakvNHEy2iKVgbB5+9OU8W3dMPX66Mj4Oz6tkR7m9b+IVfAl0/GODsGA
 EmqXvWM8dDzokU9l/FBGjrCz2s/mFrYpFsygUvOodNIKhNqf+IHEpsut3xbGCwjnDoxc
 8NWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyiQ3IJALlQaqpBvickSyXiBGZenzXMfys1uFnal05UmkEBYjwlzuUArBNL5HiSRJJDp/qudQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzplkc4lS+MJikUZN4PMx1kn7oEwhhGVEQEJOAL4B/U0ZFxWz5Z
 mKE8C6n7uzsFNWN3qrHfFVHW5JEoT7HvjwS2vopKSGQjX+VtYwIo1DoCtOOkTOGlTRkAeyU0FaJ
 l6chS7wAl2+CTeZgMLA7YRSxhibs7L+9G/XGYD3aDjuBPdGxN319y
X-Gm-Gg: ASbGncvU3/I8+530kP2WP+UFYornlaoPQKqt/1HNAXOa3w3yFDVu9MmvPbIuMf8WNhW
 nYvPbuFuRuGmO65Xg30zd86vgWioWYFNyREwqIMIc+J7L54k2cTeH0etXPHCDEfJAC0NKakqgf6
 HpIkc6nCCQ0varmFFdzsS3aFSODKSHqNzMfO53zSefs+R/+RhsF9V2Klol5Y4NJUOVNa3HhYCpL
 iITQ9+FnUZ4BJBPZY2pItHVCNPQehaIxsKYi3dP/PL5GvlSEn4bQ3GJ1Ta3I7oPAS69R76Q/hpJ
 scJttFKBjMmJtRIZswf6wKgXjVuk2KcOxgrjZH7R5RnPQiQJPpY=
X-Received: by 2002:a05:620a:1a08:b0:7c5:562d:ccf8 with SMTP id
 af79cd13be357-7c77dd44983mr1196939485a.8.1744018702734; 
 Mon, 07 Apr 2025 02:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIlw1sQP7zLWANhPi8NGs7eZeC7QOVB+ZJr3VedFCsHs83x3BpYYZeI9qalEDhXxnJa8HI9w==
X-Received: by 2002:a05:620a:1a08:b0:7c5:562d:ccf8 with SMTP id
 af79cd13be357-7c77dd44983mr1196936185a.8.1744018702217; 
 Mon, 07 Apr 2025 02:38:22 -0700 (PDT)
Received: from trex (233.red-79-144-185.dynamicip.rima-tde.net.
 [79.144.185.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d16049sm121135775e9.0.2025.04.07.02.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 02:38:21 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Mon, 7 Apr 2025 11:38:20 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 3/7] mmc: msm_sdhci: handle bulk clock initialization error
Message-ID: <Z/OdDPn3R7Rojbps@trex>
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-4-jorge.ramirez@oss.qualcomm.com>
 <157becc8-34c2-48eb-a65e-55d312e9aa05@linaro.org>
 <6118b3c5-4bf4-4692-8353-bd9a02d5b2df@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6118b3c5-4bf4-4692-8353-bd9a02d5b2df@linaro.org>
X-Proofpoint-ORIG-GUID: GoPU2UjwQsS7x3gA9YWbXqKH2FlxsqBo
X-Proofpoint-GUID: GoPU2UjwQsS7x3gA9YWbXqKH2FlxsqBo
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f39d10 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=9rMOtB7ueBl8bWGkC6audQ==:17
 a=8nJEP1OIZ-IA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=_ISdD_dKFa0wEv6TzKIA:9 a=Y8FxK0z1VKANv71n:21
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070069
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

On 07/04/25 11:10:45, Neil Armstrong wrote:
> On 07/04/2025 11:02, neil.armstrong@linaro.org wrote:
> > On 07/04/2025 10:19, Jorge Ramirez-Ortiz wrote:
> > > Some boards do not require all clocks to be available (i.e:
> > > dragonboard820c).
> > 
> > Can you specify which clock isn't available ? Because we have clk-stub for that

right, either GCC_SDCC2_AHB_CLK or RPM_SMD_XO_CLK_SRC (we have
GCC_SDCC2_APPS_CLK which is the one I needed to initialize and work with
MMC).

> 
> Enable:
> CONFIG_CLK_STUB=y
> 
> and change this:
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 343fa5cd3fe..c14f5b6e1a6 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -14,7 +14,7 @@
>  static const struct udevice_id nop_parent_ids[] = {
>         { .compatible = "qcom,rpm-proc" },
>         { .compatible = "qcom,glink-rpm" },
> -       { .compatible = "qcom,rpm-sm6115" },
> +       { .compatible = "qcom,glink-smd-rpm" },
>         { }
>  };
> 
> And clk_get_bulk() should work!

ah cool. yes  that did work but something else popped up
is it worth looking further into this? 

U-Boot 2025.04-rc5-00022-gccd064439bc2-dirty (Apr 07 2025 - 11:30:21 +0200)
Qualcomm-DragonBoard 820C
DRAM:  3.5 GiB (effective 3 GiB)
Core:  140 devices, 18 uclasses, devicetree: board
MMC:   Couldn't set MMC core clock rate: 0
Couldn't set MMC core clock rate: 0
mmc@74a4900 - probe failed: -22
Couldn't set MMC core clock rate: 0
Loading Environment from EXT4... Couldn't set MMC core clock rate: 0
** Bad device specification mmc 0 **
In:    serial@75b0000
Out:   serial@75b0000
Err:   serial@75b0000
Net:   No ethernet found.
dragonboard820c =>

> 
> Neil
> 
> > 
> > Thanks,
> > Neil
> > 
> > > 
> > > This change provides a fallback to the core clock when the bulk cant be
> > > retrived.
> > > 
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > > ---
> > >   drivers/mmc/msm_sdhci.c | 27 +++++++++++++++++++++++++--
> > >   1 file changed, 25 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> > > index 27bb7052fca..8081330bd25 100644
> > > --- a/drivers/mmc/msm_sdhci.c
> > > +++ b/drivers/mmc/msm_sdhci.c
> > > @@ -9,6 +9,7 @@
> > >   #include <clk.h>
> > >   #include <dm.h>
> > > +#include <dm/devres.h>
> > >   #include <malloc.h>
> > >   #include <sdhci.h>
> > >   #include <wait_bit.h>
> > > @@ -56,6 +57,17 @@ struct msm_sdhc_variant_info {
> > >   DECLARE_GLOBAL_DATA_PTR;
> > > +static int get_core_clock(struct udevice *dev, struct clk_bulk *bulk)
> > > +{
> > > +    bulk->count = 1;
> > > +
> > > +    bulk->clks = devm_kcalloc(dev, 1, sizeof(struct clk), GFP_KERNEL);
> > > +    if (!bulk->clks)
> > > +        return -ENOMEM;
> > > +
> > > +    return clk_get_by_name(dev, "core", &bulk->clks[0]);
> > > +}
> > > +
> > >   static int msm_sdc_clk_init(struct udevice *dev)
> > >   {
> > >       struct msm_sdhc *prv = dev_get_priv(dev);
> > > @@ -73,8 +85,15 @@ static int msm_sdc_clk_init(struct udevice *dev)
> > >       ret = clk_get_bulk(dev, &prv->clks);
> > >       if (ret) {
> > > -        log_warning("Couldn't get mmc clocks: %d\n", ret);
> > > -        return ret;
> > > +        log_warning("Bulk clocks not available (%d), trying core clock\n", ret);
> > > +
> > > +        /* Sometimes not all clocks are needed - chainloading uboot */
> > > +        ret = get_core_clock(dev, &prv->clks);
> > > +        if (ret) {
> > > +            log_warning("Core clock not available:(%d)\n", ret);
> > > +            return ret;
> > > +        }
> > > +        n_clks = 1;
> > >       }
> > >       ret = clk_enable_bulk(&prv->clks);
> > > @@ -83,6 +102,9 @@ static int msm_sdc_clk_init(struct udevice *dev)
> > >           return ret;
> > >       }
> > > +    if (n_clks == 1)
> > > +        goto set_rate;
> > > +
> > >       /* If clock-names is unspecified, then the first clock is the core clock */
> > >       if (!ofnode_get_property(node, "clock-names", &n_clks)) {
> > >           if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
> > > @@ -105,6 +127,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
> > >           return -EINVAL;
> > >       }
> > > +set_rate:
> > >       /* The clock is already enabled by the clk_bulk above */
> > >       clk_rate = clk_set_rate(&prv->clks.clks[i], clk_rate);
> > >       /* If we get a rate of 0 then something has probably gone wrong. */
> > 
> 
