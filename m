Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A0ECA6009
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3C006083B;
	Wed,  7 Oct 2026 22:25:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EVKirsZusOf4; Wed,  7 Oct 2026 22:25:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BEDC760807
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411905;
	b=GiW7cKFn90D11Um0z9otAznz7Tfsya7QQMKJOLwdxnplzWLYaX009gb3fvHiWuINBMP1
	 YlovcDxBa808EelmuYwHGknj1jP5gejr87qS2egTfOKRpuA+ZltdfGWNnWpz44m7pIvfa
	 QNrppTcp5EImzUmi/cbhGP2nIxDvYfvdmq4l5LWTndPdNMdUNLlEz3GdJCCtkpvc+36bv
	 n0gheVGLyTuvEkEm7EtzmpWHYOMnF4xHDVgNwwQxddHXw+rrPI/BYphtfhQoQOHKSxjDn
	 CxtS7IDx+zd/mRGd1vpDU13mr8d9JC9BVoZONig5+3dlwq7uxlPWhI5+FnniOJYJj8Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tzD/nWzg1nlxAn1DBlYr/UOaVrTm1+bf3mP4siZQdO0=;
	b=eQU5gX9XoNKsAKh+26M0PPOMmcaVQdEfL3d2Psq+kEOo7zBRSu6GcoI7w0bDt6DkJXXx
	 9jo6U05dz+0uWawsrveW5btfo5kE5eExOBGvdHmseb6eji+mYHDSJ3AOuNWG5o0T/zKlv
	 WnGw+Q3GUjHilVz9QA4hBmPtA7APsuktsw7y0lfKHtsOMFuBDrcSakyEbzPzgrIb/q60n
	 8FO3uuoLr7p76YrSgZ7wOHzSbfH8O3NLa2uP9vET7I1vfiWgcEtYs9xitjkvr/GqEBeo8
	 ZvJtnQZffk26+U4/Di3eNGskVoxvRDbfKCkf5KvZbUKiqWXCJo4G/RfGd2qSCzC8LUQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411905;
	bh=tzD/nWzg1nlxAn1DBlYr/UOaVrTm1+bf3mP4siZQdO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lw6xfnGf6kLm9qrdSOFHFsxUa3lP0CNG4psrdZ8l7UZMd9kTkMi1733gLek1Ej7Xt
	 H8gfBoKAzLil6hqOQmLn3VhZ2Wmj7/XD24juTqHj/GLG+T5sKsbPpLnAmEQMJEoztn
	 ReBYHOuhsFeT6bdGOprwj75Jnr5jaGe2Ze+qdo53wi+lbCTinmqSXDCIuo3tVg00xz
	 Wsbb2Wbbxkzg8LGDTpEsTNFUpiIayOcipsd2S1SXmpxivnuRVpjgTjBFPa6t9BpCQV
	 6LiJuqeZwit5LEkrWityvkXA0V2398XcsiU5Cn33ONLvAwHODQZ+OAuKv4oomkJUZ6
	 R42FPJVGPjBNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEDC760807;
	Wed,  7 Oct 2026 22:25:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFD69338
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 22:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B23BF4083B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 22:25:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIhFf6sYuMjy for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 22:25:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ADA1E40836
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411902;
 b=lDmxfwcSN0JU4Qku451ISJSGRTqLmlgxhjlWxNKsqpDZcApKX8ED42WFgOz+L7oj4ase
 wSHrf2WtUQOJgo+y/GfAsPsouJwSZJOQ15htP76t05m60DO8Vy+EXxrpY+lQZANLiiWDV
 DUx3nb7bqTrq5MGfVXkn8rGvM9riLNKeHVGqSvf0L2vCClfZvSQMwUWaiqQiU8W8DXdgL
 j7JUJHeLtxHxeYlZF7Od/X/jJWKYR+G1OUq+YkqwLTffpVJaqf3t+ER5JRkeIL0WcuPfl
 aHQHjDFFS5bIpNhlcQ1b3aPTOokphjqXM9KBN+mLvJhhb0JYa/dB+dHYWD2i08Fj3zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791411902;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=tzD/nWzg1nlxAn1DBlYr/UOaVrTm1+bf3mP4siZQdO0=;
 b=IBg/US1vw1cTlll2A8j97pgWpzczgllOF/X8pDci2X1HiZawEn1cwhwpJwU2A8Dwhaxt
 9ERlgn33GA+tl/Lg7cGkUvlTi0XAOdo4mmpVrDEr1iDRzipp9qm5VmF82TPsQ6gPulLCE
 fiTiieCE1wpCvydcx5ZU9qwDFWq226mLFJ4aZ0t3cYoShKehRrnyckbFjJT0CZhcNRBF3
 sj06jxNIgI8kYqm0hO4UMYDy2CUnPtpK0pHUxsUyCsB+RAEAUPTTllhv6l59Wl6HyaSym
 AIRG9qkjJrK5hOLEKSEd86H4f82BAbmnOnbz+JoDDLmE/H7mSwPhfp1If8OkbryswDQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Mx+EZmp7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=Mx+EZmp7
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ADA1E40836
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 22:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791411865; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WdJXcYHcZ8r57a8e+/pkq5YGJFU0JImgy9w7W+QQXi7/r+XIaLCzxUgb5A3oz3Aavkzh/R0/4OnauhD1IEK5zIxJK0jS24Lr5IH0bhvChiK7hNNBktPW2rgBNB7kD0yh7Zzy/ERRYvDFET3DOg7Gqefhkzzq+Noa/bu3m9AKzVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791411865;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tzD/nWzg1nlxAn1DBlYr/UOaVrTm1+bf3mP4siZQdO0=; 
 b=JePjCGfu5tdZkNtg0M5QjqymW/QFtXhiPvSClZCNLENpkI5dv3n4OHUmYcKDnttaDxRVgUia/CmLLsJVg84Ip6iy5OnLozTED7JBURQwEOIXWkPpwmUpJiwYxYlEPhT++wFnTbfU7tmsndIwuIm8fBQTfE2QVZTX8BMwTDdn1j4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791411865; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=tzD/nWzg1nlxAn1DBlYr/UOaVrTm1+bf3mP4siZQdO0=;
 b=Mx+EZmp7g6PIG3bHh5Bri3yAU+MUPIBnulOrf6vgPpYRZoNJI3hs/sz2iewGfToL
 de2wG5HvPF2WKVpysO6cti+3jxDzEebr5BNtEC5e/EV+jgo2xxilLn+LcOmaG9jtFd/
 vjkuqkQbW89qQ8DRaf4C7k4rspFsa8xCJA5JY7OU=
Received: by smtp.zohomail.com with SMTPS id 1791411864550546.1563801671182;
 Wed, 7 Oct 2026 15:24:24 -0700 (PDT)
Date: Wed, 7 Oct 2026 22:24:03 +0000
From: Yao Zi <me@ziyao.cc>
To: Zhuxu Ran <zhuxu_ran@zohomail.com>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Alexander Koch <akoch@initse.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Leo Yu-Chi Liang <leo.liang@sifive.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 1/3] rtc: cv1800b: Add seconds counter support
Message-ID: <asbGg-KcrPRYBT0Y@pie>
References: <20261007-cv18xx-rtc-sysreset-v3-0-194557fd5e78@zohomail.com>
 <20261007-cv18xx-rtc-sysreset-v3-1-194557fd5e78@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-cv18xx-rtc-sysreset-v3-1-194557fd5e78@zohomail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.389.60
X-ZohoMailClient: External
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

On Wed, Oct 07, 2026 at 11:33:05AM +0800, Zhuxu Ran wrote:
> Add a driver for the CV1800B RTC seconds counter described by the
> upstream devicetree. Map the node's register range, enable the RTC
> clock, and implement reading and setting the 32-bit counter. Bind
> the existing sysreset driver as a child when enabled.
> 
> Adapt the register definitions and seconds-counter sequence from
> Linux drivers/rtc/rtc-cv1800.c by Jingbao Qiu.
> 
> Link: https://git.kernel.org/linus/d9f82683b123ce315cc36c4b20a5bc3d8644f947
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
> ---
>  drivers/rtc/Kconfig   |   9 ++++
>  drivers/rtc/Makefile  |   1 +
>  drivers/rtc/cv1800b.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+)

...

> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 742481ce185..3c480156498 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_$(PHASE_)DM_RTC) += rtc-uclass.o
>  
>  obj-$(CONFIG_RTC_ARMADA38X) += armada38x.o
> +obj-$(CONFIG_RTC_CV1800B) += cv1800b.o
>  obj-$(CONFIG_RTC_DAVINCI) += davinci.o
>  obj-$(CONFIG_RTC_DS1307) += ds1307.o
>  obj-$(CONFIG_RTC_DS1337) += ds1337.o
> diff --git a/drivers/rtc/cv1800b.c b/drivers/rtc/cv1800b.c
> new file mode 100644
> index 00000000000..e98efb319d7
> --- /dev/null
> +++ b/drivers/rtc/cv1800b.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Zhuxu Ran <zhuxu_ran@zohomail.com>
> + *
> + * Based on the Linux driver by Jingbao Qiu <qiujingbao.dlmu@gmail.com>.

If so, it would be good to keep the copyright line :)

> + */

...

> +struct cv1800b_rtc_priv {
> +	struct regmap *regmap;
> +	struct clk clk;

I don't think you make use of clk anymore after exiting probe(), so I
think it makes sense to turn it into a local variable.

> +};
> +
> +static int cv1800b_rtc_get(struct udevice *dev, struct rtc_time *time)
> +{
> +	struct cv1800b_rtc_priv *priv = dev_get_priv(dev);
> +	u32 value;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, SEC_PULSE_GEN, &value);
> +	if (ret)
> +		return ret;
> +	if (value & SEL_SEC_PULSE)
> +		return -EINVAL;
> +
> +	ret = regmap_read(priv->regmap, SEC_CNTR_VAL, &value);
> +	if (ret)
> +		return ret;
> +
> +	rtc_to_tm(value, time);
> +
> +	return 0;
> +}
> +
> +static int cv1800b_rtc_set(struct udevice *dev, const struct rtc_time *time)
> +{
> +	struct cv1800b_rtc_priv *priv = dev_get_priv(dev);
> +	time64_t seconds;
> +	int ret;
> +
> +	if (time->tm_year < 1970)
> +		return -EINVAL;
> +
> +	seconds = rtc_mktime(time);
> +	if (seconds < 0 || seconds > U32_MAX)
> +		return -ERANGE;
> +
> +	ret = regmap_write(priv->regmap, SET_SEC_CNTR_VAL, seconds);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, SET_SEC_CNTR_TRIG, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MACRO_RG_SET_T, seconds);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(priv->regmap, SEC_PULSE_GEN,
> +				  SEL_SEC_PULSE, 0);
> +}

It's redundant to check these regmap access, since the regmap is backed
by MMIO, and there's no reason it could fail.

Regards,
Yao Zi
