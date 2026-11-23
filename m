Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A8606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cJQdWlGS;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B5woKDVt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 051A3406E1;
	Mon, 23 Nov 2026 17:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TiQjGumm3MGI; Mon, 23 Nov 2026 17:42:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34AD5406DE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795455763;
	b=DiX0u4UaRrvUGIyG2txDFDCC5KSAp1TwBNQjgkE4lOF/YypNr6DojCVHK+7SPgg5Lsuh
	 cEJNrgP4bzERdib7fjpDcmQGtH2fLWWn/YIyQaDJSeHJh86LRxzKWct9F5CwLGAQUaOJn
	 NzVHc6BPou8jrtbi4/+UHu2jHfcDRZPE9rKG4RkPPSAVF2BzRu1YMxk0p5SBX9IV9YtMh
	 9YRF5NH1tEQ3bzYZsJY/wUnbP/uwv+RUEi4oRZICozZSuFmPyAfWw9DQR5QHpXp2iEnUY
	 IxVsx9sK3b9W0xZRhZoi+zKyujx8Ym567dvJjHg5pd60D+A8kwpJJoFTXgDdchokyVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795455763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wDuTzsxPDuc6MyDvpteoG55FA+8xtlooASO4GJUiXtQ=;
	b=E4PiNbkPjr+rklt66Ks+gUYMkzvb7ZJ2Ybong/mCcpG+gtfuulQiWENfYq89e4J9MfN6
	 pEY+tfz1j111t+bmkJfEd/M9PuqRclB35kyXz4KmayOXCZLc1jUZ5zb6fRT8pysurWcVV
	 hFaDbBloK5EsGLB4zhQQBcUR8bYGQLkxL+R5ER7r0o/8AzoaewMV5WEu5Uh6GgT5aj95e
	 uq4JLXRdcKGkpU/jeGnE97MzD8wSeGSuG0q/4r3lK7hoEw+aI5NVNxDIZ3bq+2eLU4VEh
	 fUgX/T1NX6GcBQGm4c+GQa0/ti5sx9nxkN3WFmjy6+RTaTg3jB6Eo/IHSADq3gqP85Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795455763;
	bh=wDuTzsxPDuc6MyDvpteoG55FA+8xtlooASO4GJUiXtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cJQdWlGS1i/IcxvpOxRP/ZlmpVvnv9m0HmX1ot4ewD8+rJvOWS5eepHhMmtiQF4jp
	 Tdf6phubhbI3TPD5hpRX0ehtt6kbP2ZIuirtJY0K1IDWhM6zCToP+7+9AHi2QRZYlS
	 uWAdtcNR2B4lUZruCi5xvfpuK5IQAHEmCYov22j2kRj8Zi9g+tdwg97eMUeL58yy+1
	 3RosHQDB/bgk13wALfw78GC5ZCj6IjmDmzkSsOwZjitckCIaHPTyMW2uGWtUx5gs8g
	 T7lx3gYPAGTNj69JpxYxFIwwvLUkgaYPkSAljHTSySJRLEf+I/Gbt3zLx1aqylwZKF
	 C0g0YAxkbzC4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34AD5406DE;
	Mon, 23 Nov 2026 17:42:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 12CCC15D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C93760681
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P_UW89DKSPB9 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:42:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D8036605F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=B5woKDVt
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8036605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:42:38 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c5188e17487so102734066b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795455757; x=1796060557;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wDuTzsxPDuc6MyDvpteoG55FA+8xtlooASO4GJUiXtQ=;
 b=B5woKDVt6ylnfitxXDc0jyADzaX2m5LfVitu3BKcsRsC80iqzKJsNw9ASnjeTlqPal
 Zbqk3V/1PkhkwplO/lsz670aZpHDUSCw4jMLTKnOvdK0cZ3KGpkG9ZRwdaNUHG4aAdu2
 5dc2E2etb/i8mih81X+qLufeYNQYNBEMHxYuwQrlACpwRcq0CM/u/j/x9OeJUHvyUl3Y
 iG4F+g0zODlhnPm8qkAOYwyRAexzbG1F/ZVxax6EeJH2g6K/YTnIy1hfoEN1kfE6uWe9
 YUDJcISAXqU6Sc1N1/czosqSM+Oj/1nRzfLexF6BSOoLZwWqhb2iCx/xSbijPW4XnJMu
 paKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455757; x=1796060557;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wDuTzsxPDuc6MyDvpteoG55FA+8xtlooASO4GJUiXtQ=;
 b=aacwmQQxNw6q21QLapDdjCO+FlC/DYGnHfDnaR1AZLkD9mGCwHjSC0aqDl4zi/vC0A
 As5eCNwUi0/GpHESOp8dgcDbH7WmD3iEJneQRJRHpb7OOIWXv0DLu3vPjrhkCUHwQ2sv
 jz6aqyvzGNASc1rwMrU/pE2UgsgUtpuP+vBxiAA8ZrF/mKWy0YsliFYqkRG/ZKds6da1
 +C0HXEy7uG8lSvZCkvWTG7Jhyv9da39AjCscak2Bla5ZsFZ+KXqmCHXlRovFzA9AIwoc
 nAXmyqGvUVD+bDHzALVfKEOuZPXI+sCqiCmgm/wVPg/JNs12ZwRkAjegVppCnFF2HG/S
 dbZw==
X-Gm-Message-State: APuU4Z8Le4wB4jxmVmWx9v6kZhe9Mz6uC1yw60rofalf7D6Vphg1H+7o
 WOT7PuYnheFjn2SMj7odyEoqSwr5TOUOFR7c2lbAaH6aRAyeAgIIBP8uvUNdnixdapIVs5IMJnd
 hO3cuqv4hI6EsPzMHWzSlNhqyqU7hGbBpdWXS
X-Gm-Gg: AZFdTZfOFdrIk0SrBd+3vjdsA6H94YpDmFhQUFtSdle4JheKEZLiKVW0N4ClU6AI1Cr
 0hMEKoIYc0Fi0QeUph1LgRX6yLfCHtLW6UGeCqBk6OpyN//l0JbBOH1sAxGyX8L43SDw9yalNRz
 wMQGFhwfGAnlorKhwo1pqxVZ+l52w8QhphnllKbvGZHUZ3YQbYPmOXPJmFUZs5q5lgzLvM6DUSp
 inqrhIqS91R/3DTF4ZUXNo14wU72/KuCJUwL1eFSTAhQryqIh32jayamEV0uy5s5Bs53X9GIlOm
 4bkx04axNloLCjlIT8AYlCSFAt3on7deYbpYmDWgxyjbN0gzJ4TXTf9gvlUdzeHqa+a0lkv42t7
 LruM6EoUI1UGHN5K0WMfKyCAQI/+GkH0ibOwG
X-Received: by 2002:a17:907:da1:b0:c50:5275:fb97 with SMTP id
 a640c23a62f3a-c513acb5e2emr1024788266b.47.1795455757142; Mon, 23 Nov 2026
 09:42:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
 <20261117-rk-doc-follow-up-v1-9-2cc0910f9455@cherry.de>
In-Reply-To: <20261117-rk-doc-follow-up-v1-9-2cc0910f9455@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 23 Nov 2026 18:42:26 +0100
X-Gm-Features: Aa3M54pGXtFiMgnF70diY4Z3Z255hlU10RLjSUt55gUaOgnSC6tFHmcLkq_swcQ
Message-ID: <CAC928HbMefZcDHDMthEYx+VXSt1=5SA=evLREaBiP=tRvb7mXw@mail.gmail.com>
Subject: Re: [PATCH next 09/10] rockchip: correct [ST]PL_ROCKCHIP_BACK_TO_BROM
 help text
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>,
 Johan Jonker <jbx6244@gmail.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno mar 17 nov 2026 alle ore 10:20 Quentin Schulz
<foss+uboot@0leil.net> ha scritto:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> User code can actually return multiple times to BootROM (on some SoCs,
> up to 4 times) so saying it'll load "a second loader binary" is
> potentially incorrect and misleading. Instead, just say that user code
> can return to BootROM and have that load and execute the next binary in
> an image. For TPL, provide the typical scenario, which is to return to
> BootROM for it to load and execute the SPL next.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/mach-rockchip/Kconfig | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index fef5932844e6..f8cc51d9b4b6 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -606,9 +606,10 @@ config SPL_ROCKCHIP_BACK_TO_BROM
>         select SPL_BOOTROM_SUPPORT
>         depends on SPL
>         help
> -         Rockchip SoCs have the ability to load a second loader binary
> -         after the SPL phase. If enabled, SPL will return to the BootROM,
> -         which will then load and execute the U-Boot binary.
> +         On Rockchip platforms, user code can return control to BootROM which
> +         will load and execute the next binary in an image.
> +         If enabled, SPL will return to the BootROM after it's finished
> +         executing.

What to you think of next alternative?

  +         If enabled, SPL, once its execution finishes, returns control to
  +         BootROM, instructing it to load and execute the next binary in
  +         the image.

>
>  config TPL_ROCKCHIP_BACK_TO_BROM

What about dropping this config option altogether? It is not relevant at
all: all Rockchip TPLs go back to BootROM, unconditionally. The default
for this config option is y, and no configuration unsets it, but even if
deselected, the built artifacts do not change.

It seems a configuration option that doesn't really exist.

In any case I can send a follow up patch, of course.

Regards,
Massimo



>         bool "TPL returns to BootROM"
> @@ -617,9 +618,11 @@ config TPL_ROCKCHIP_BACK_TO_BROM
>         select TPL_BOOTROM_SUPPORT
>         depends on TPL
>         help
> -         Rockchip SoCs have the ability to load a second loader binary
> -         after the TPL phase. If enabled, TPL will return to the BootROM,
> -         which will then load and execute a SPL binary.
> +         On Rockchip platforms, user code can return control to BootROM which
> +         will load and execute the next binary in an image.
> +         If enabled, TPL will return to the BootROM after it's finished
> +         executing. The typical bootflow is for the BootROM to then load and
> +         execute SPL next.
>
>  config ROCKCHIP_COMMON_BOARD
>         bool "Rockchip common board file"
>
> --
> 2.56.1
>
