Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18515FF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 23:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 798B2848F3;
	Thu, 30 Apr 2026 01:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IVHlStuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AA4D848FB; Thu, 30 Apr 2026 01:52:32 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC75B848E7
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6794b8699b8so526892a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777506750; cv=none;
 d=google.com; s=arc-20240605;
 b=SLNs9CPlrl7N92Ttj3Zpcbk3FDSi82XgZEo4FzRIR+orj3xkQvx/iQSoN2k07lSW+Z
 DNfVl4Wo9KgPINdwOzC/7R4NND/3jwsDs5cy/zFPlASLo0DJrmkZL/7AWqNX+AQj8ZB1
 jbzwA5xTLLtJ5bWQfEOn6M7qla4bqBOr6SjIRGGG+Fo+ZBOmgvFITpUIyWy4+dBNTKPB
 N2MqH1nzbB8Pj0RJfM7NItlcLX7vzj1yek6pR7gBPZvpAyRRXOIpqo7dYGOAZEPHArbd
 JRNIeszrCbnuEQ1RZ8zZbb67+p1s/C8uUyxQGjLxhUWFL7EyYG3DBRHAc8aQvHF7ICfq
 m4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YkYwHKtnI4wHAmUqqAhewbzu1jtDlGd83UAw0aBeM7E=;
 fh=rA9GEoD1zm6JhCbXhHp8ezb4eePUUbom26L9AO8HtBk=;
 b=OKQrmeEiO2uk8dIdMJ+V/phTI03DLqcwetwwW2aWmX+P06rTv4aSj3AEN/SiNazdLd
 3ndslr20KpZzX5R4hFngUV0UuXr/+xwcRs8RxCffhdcl9vXr9+5ntM3vBv/RN+wiOJad
 teDeCNdjkDyV/AkhYQkgkWmpZmDfsI9pz3ny+kdrTs5ws9hYvWrYKV7g/Ejam88cYtp4
 M8YurcRvvFrJKksUljxUzJdEhKQtFTHyzDeMJjd6rTI5SD5YSsfHpHOc43Ofvpex8KhF
 QDr2IeD6Ntf0dZJ/3Rf/8+me4ho2gzud2ZQ34R2YE6/gfaMtg77NFhBcxV8rxgod4QwE
 f1SQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777506750; x=1778111550; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YkYwHKtnI4wHAmUqqAhewbzu1jtDlGd83UAw0aBeM7E=;
 b=IVHlStuOZMyLOKi8AXbXVGZ9SgHayHe9BRBlEO3fV8SQCNO+NcMQjgMzD5B1Ta1UJ8
 NouxyZh7p346PXwcuhtBEsT2i0PYGvMCCJYg4bQAI5wFCQQL4MvCdK+PxvLk4GxWbOfG
 o3XvrpK8j9pcbJDsv3zDFZaoCEgpi9uAoehtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777506750; x=1778111550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkYwHKtnI4wHAmUqqAhewbzu1jtDlGd83UAw0aBeM7E=;
 b=RSYIAxDFvJsFur0nOxHcvJ8cyPgvgb7WZbqwB+y4Qh/aho5BMTwPT9V/1W8XoP0JEp
 CR0O/YQPuI8yu6XuF+beKoQwwtiXxS2lD5TGhT2LgKPU+vgP9ZxhpmRWDpl/g3q06RMJ
 2jsv87TyA+cPG0Wi9W1YosrZQ487Z1TmPqWEWgkwMDozKjBVhhucsFcbH3bxzctl6WY5
 IewYUAq27/vi6K/Cx6K6stfy/ABOY7HGLzjH3NCRzpVv+lt6jNRXam2VPHKgsBuqXpGr
 KWIeY52UO2kgX0K7Lw++R6vjLSug5qvQlorwi2NGLvwU6mNK47eyCGHG8XYp2hbwz1tK
 /gzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pvi9ZlDSZ2vZqouLXDHxDdLBKofXZ3FQSAPWY+e5n9E75EHZTVvpPl9NYz/yAGQ0Nse8wek4=@lists.denx.de
X-Gm-Message-State: AOJu0YzCw0fu5o1fn2wdx/ZVehBHztcyjqizWTSaeRg2/64pts71ES6w
 w4em6SnTADTYHxSLAvFHHXYuHxOrJlL7j2rXRHdxeE0uV8rzJ+DNlEVvCQhQIld1yd03FR+SfT5
 rqB/3BPVpqx2Sv83zwhkjMHtSKA0hLqW4Agx6BTSl
X-Gm-Gg: AeBDievP8n94CveMRO7b3jXMQKDFrqtqYlQUFqQaDEwXaR+ui/eagfQ9/3ruTgLEfeh
 PadduFRgtVbaqtpIAbVcHIQiDuTaF0dCvQ8aacXNOtUUkKrcISHmY1E6Ce0rpTs4mwIw/h9paoZ
 mC7GFjvbPlm26mBLd1gl2ZDwXD2mALfxEuZBRR0686498bjcGLL23M++DkB8TQ92so6HEXi63HK
 TPNKncIHnbKBlSkrj4SB8y9k32CGSAaPQg80WwjVll8dtT/GsiIMgkCcaCrhih6+XJd5OoEqsWP
 mKPmUnMuOQJ6LInS
X-Received: by 2002:a17:907:e102:b0:ba6:689e:2f48 with SMTP id
 a640c23a62f3a-bbac7997c5dmr24425566b.25.1777506750091; Wed, 29 Apr 2026
 16:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-7-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-7-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 17:52:18 -0600
X-Gm-Features: AVHnY4Jx9ZUJ-fin3XG1hNutLKxnB2i_1oiuiE9hJvhp4daTyUenCXk9QlP4m58
Message-ID: <CAFLszTj0VhzA64FWAZ6Rtw5twMOug1QYD0h5NEKrD2UTX-exmA@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] arm: dts: k3-{j721s2/j722s/j784s4}-binman: Pack
 HSM firmware inside tispl.bin
To: b-padhi@ti.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Beleswar,

On 2026-04-25T03:37:39, Padhi, Beleswar <b-padhi@ti.com> wrote:
> arm: dts: k3-{j721s2/j722s/j784s4}-binman: Pack HSM firmware inside tispl.bin
>
> Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
> and used by R5 SPL to boot the HSM core. By default, point to the
> firmware for HS-SE device type. This needs to be changed to point to
> appropriate firmware when using a different device type.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>
> arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
>  arch/arm/dts/k3-j722s-binman.dtsi  | 12 ++++++++++++
>  arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
>  3 files changed, 38 insertions(+)

> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
> @@ -154,6 +154,16 @@
>               fit {
>                       images {
> +
> +#ifdef CONFIG_K3_HSM_FW
> +                             hsm {
> +                                     hsm_fw: blob-ext {
> +                                             filename = 'ti-hsm/hsm-demo-firmware-j784s4-hs.bin';
> +                                     };
> +                             };
> +
> +#endif
> +

Note that the whitespace here is inconsistent with the j721s2 and j722s changes.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
