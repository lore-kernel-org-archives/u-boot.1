Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEA2C61DC6
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46E86403E8;
	Wed, 26 Aug 2026 16:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xki7T9c07ISX; Wed, 26 Aug 2026 16:42:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762555;
	bh=qaEIZcEVCTTOiq4MSBxfkUyzgfR70UVkah2CIFM/YM8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i02fdbxIwytncU5UK27/74KkwDfiCOP/gRd1heC2M/1kY92GwIoQ/IWD9Vrpuvued
	 ZakUNC+nLGXVJEAa2cWDrSUFmcG7ucvVIHmns/SFFPitFZUswTOjoo2Yx8QXS1KHYw
	 m/a5tjbyh2X31CGob5lnjnJcDlGQRGIFYScAE0HwNfbzsd9WglGEBh2OGpdUxbyQi1
	 6KMKl18KWaGowlhIwRyBGxKexnNYJex0KHlWwNPnrqePr4i5tN+WphODNIvQfHks2Q
	 jGU+ZOophZMBXFPMX8RwYtlT0+nvyJSGF1G+GOQ31pqMhRtCbstnSC+pGsLyAcfWvx
	 mgoK/2d/3pc1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34356404A8;
	Wed, 26 Aug 2026 16:42:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EA46229B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC7AA40206
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:42:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7a8aErUvlac for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:42:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iGK994+U
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2AFE7400C2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:42:32 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-49ff971e903so92464b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787762551; x=1788367351;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qaEIZcEVCTTOiq4MSBxfkUyzgfR70UVkah2CIFM/YM8=;
 b=iGK994+UVxsw7d49lNENxDrrGbOpUGOJocjpEPci38reuew36nG0wcZrvr5pUSzMOz
 bq6Y58InTq45hayRxFDSsMveaXxHSyVQrQnuSMXrEl5TuvNjBA1M1qDjCnt0K7N310tn
 PqXNWs4y3SR52YhfP0by56ZSY9mdJ+jf+sG0aWzNLwpxYkw9FesBH0mqX13h94mGw6X9
 78ayfLP8kBdmAsPtVuO9Lf6J23SVfgoIdaPc9CjdS94M65IosodUN0yvaL8DsCmMSpMC
 oJ3L1P8CFuN6kymUhARRnXGaob3PRQNDaA0ZCxsspQhY10gg6Do5nJiQtpAzfQPYb5uw
 aOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762551; x=1788367351;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qaEIZcEVCTTOiq4MSBxfkUyzgfR70UVkah2CIFM/YM8=;
 b=tOTL5EadRutVv1pvXedvt9fXyoGojBT5QNFYWVaz0iGw2GF/acDKkd8zLiJF82mkY4
 kio9U1h6WME6KXDUFvn/x/w40qk9/DcUBJNTtSU5uHV7hMIvS12vu+t5e+rh92D7wzit
 VSdDd1NoH5RvZ3YbfpNaEdPYeAGkz8Lxv1wB1yQC5nCXcpTjPsrlJcplNKP7STx9Lvlu
 Ve8x0cOUMpXmmWaTuMpUa2LMR+GqMdM6mvqS5mazlz2t6Z+6uuif2E4QpiaUQAIoSU2/
 G/eymdDaRXJhrhhoylAUnGEd7MSHYYBTgbooENGGLrp/FzGd+TQfbsPmqV/YSfIKsuKv
 Xx3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWb/mLgXr+CYDIZa1AKm4JDM7fDEnzw6fiZzXEVMM8zYmeXttoaSDX0lP5wksx2KZMQV2VJV4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++knpExUnBtF068I+z8MZsg4xxkklr5pft2TOzkDierRL2SLZMxc
 RCWXPjv4J9fAUWdQZt3DCRvDyHmD0xLzTEG2rvkc4rZ+CLLX4PzZe/QkwFv+o2aVhBU=
X-Gm-Gg: AR+sD12Ir9iqOH0snN8lqewuRdD+TJeq7Sipjnyc4IbuPp0EFPTgJmANURTd+NYoGu0
 mSAuVaAvyH34xTJWNNJgPtpuun1O3aJQKaU1Z2ocSnSwhktEmIhZjTE9vFnQQuig9hpb3Idv27b
 OVqJU95UxZC0wr5IPXR2qZbki8jX2G5SiIUUPZpsEGBQ9u8yTMhu8RODNUiDpNOjww7kxJUaTVF
 d92MtJmpAYuhRm5ebyK1EF8PlXskujZMqnap4p555z9DvoDB900SZYxUOUwnbXHe2sWNL2yhFdb
 Lsv+Epffdb4JEHUbVH8pwUCTI2X7Myy9dXKrsVr4NR966FzTqKaS1AIBwv0pT70taF8VybCRPBx
 847ScNk7P1BpVbOwy5Z4IRybArBm2+2zWVGi8GnuNpc7iIcwQkKbO+NE7mDcTsfi4g0lnbZlQ1H
 95FTurl3WX06+1+5rE51TFDSjqKzmWhpLghqVQtkjGc3CZhdn/v5Cyc3xMfDXySMDrZUkJ8gYXV
 cKj6eGoYvNW27KaXIHeKXB/wjpphdt/9V1IotY=
X-Received: by 2002:a05:6808:508d:b0:4af:9364:b5a9 with SMTP id
 5614622812f47-4b37c82dc53mr469813b6e.6.1787762551550; 
 Wed, 26 Aug 2026 09:42:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36abc0827sm2077520b6e.18.2026.08.26.09.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 09:42:29 -0700 (PDT)
Message-ID: <21736156-823e-46ce-bb19-4c0994371b96@baylibre.com>
Date: Wed, 26 Aug 2026 11:42:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] include: linux/hdmi.h: add HDMI colorspace and
 colorimetry enums
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
 <20260826-add-genio-510-and-genio-700-hdmi-v2-10-68ebb1bf17df@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-10-68ebb1bf17df@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 8/26/26 8:09 AM, Julien Stephan wrote:
> Import the hdmi_colorspace and hdmi_colorimetry enumerations from Linux'
> include/linux/hdmi.h. These describe the AVI InfoFrame colorspace and
> colorimetry fields defined by the HDMI specification and are identical
> across HDMI transmitters, so keep them in a generic header rather than
> duplicating them in each driver.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  include/linux/hdmi.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> new file mode 100644
> index 00000000000..dee862d2a63
> --- /dev/null
> +++ b/include/linux/hdmi.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Looks like original source is MIT licensed, so `MIT AND ...`

> +/*
> + * Partial port of Linux' include/linux/hdmi.h, carrying the pieces of the
> + * HDMI specification that are common to all HDMI transmitters.
> + *
> + * Copyright (C) 2012 Avionic Design GmbH
> + */
> +
> +#ifndef __LINUX_HDMI_H_
> +#define __LINUX_HDMI_H_
> +
> +enum hdmi_colorspace {
> +	HDMI_COLORSPACE_RGB,
> +	HDMI_COLORSPACE_YUV422,
> +	HDMI_COLORSPACE_YUV444,
> +	HDMI_COLORSPACE_YUV420,
> +	HDMI_COLORSPACE_RESERVED4,
> +	HDMI_COLORSPACE_RESERVED5,
> +	HDMI_COLORSPACE_RESERVED6,
> +	HDMI_COLORSPACE_IDO_DEFINED,
> +};
> +
> +enum hdmi_colorimetry {
> +	HDMI_COLORIMETRY_NONE,
> +	HDMI_COLORIMETRY_ITU_601,
> +	HDMI_COLORIMETRY_ITU_709,
> +	HDMI_COLORIMETRY_EXTENDED,
> +};
> +
> +#endif /* __LINUX_HDMI_H_ */
> 

