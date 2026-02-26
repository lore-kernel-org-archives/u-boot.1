Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E964FD8FE0
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 17:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4540983F14;
	Thu, 26 Feb 2026 18:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lml6pU1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE85183F36; Thu, 26 Feb 2026 18:12:05 +0100 (CET)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DB283E8E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 18:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-12758ce1e8dso1356663c88.0
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 09:12:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772125922; cv=none;
 d=google.com; s=arc-20240605;
 b=eUwN+lC86mcT/04ur6F/pURSsWKle6EXBwAzzqGik6CjlyxzWfo1xTruJH82RLGXy7
 pBNSf7p4Iim50k/VMqYnvbhlwBg6+p17STO1kmMg/9XxdWoWkwVe9QGcMxtSVjBLx64M
 9BwDd+BWG6pK0oW/roPFSsQIZCtBOqZ9EKaRox3y4HaE6LljKB5HuF/AmAfkb91UiFwv
 wBt8DUKT0SQIXebKf0ndz5d9iXhhO3pCJQtuFIF2xsaCs6LWOCDa1+uLzE70Tw/1w3/l
 KbXh4jkzKO8vCiYhrr0+ikPFVYw+Dp9bwLtqKk+ZG7mLuG5vqWFrvzJex4Dc2a6m7YEU
 jx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KVGeyYZwb5DBBWAsb4Sz6ldKNKBB2r5kGtLjqeOJtsk=;
 fh=4T8QG+1ZesSd2phMtU5AwXlzLd66Yn+tADKwZgHEfDQ=;
 b=g1DdhGBhKqBl/QyB2fvjUH5bAiARNfvhLs3fzI9uFZchuzDI1WwM8YouyeXvgLK9VM
 GOs/n5YMlxeDdzuUa/WX289uFp9TlQlq/aeiTrpwTUWARxq0U1UGc0neyOgIgWksD7zA
 JvGbCdWD6t+g2kfvTdpt/mMTn6r6wgWj59HGLPrW/j9nH8qwO1DOAEPNaqukm+EElSFR
 Q8y4oIFak0a/9Y0+FrAZxIy8GJQLh934EU0aECefcAgLzLyT3mC70o6wvFDCMhVAT11t
 czzfO6z6Fyk2V4nuLmSzGWDZsapyfaHYAqJotpDNE9u+yalnKwV6w43UDAXCNSp7NbqY
 IsBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772125922; x=1772730722; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVGeyYZwb5DBBWAsb4Sz6ldKNKBB2r5kGtLjqeOJtsk=;
 b=lml6pU1NMtmX5R9XvXvaFoAZUDIefNC+t3ERoyFqV5L91qQAq9A+QcyX7h9HFN/JWl
 JvXlKe5AZyTwp6atC4/eDKRb1DO0tGH/bzkSCunmAqyTgdKVxDwTGox0ZR9R6EaXD0IS
 +QSuQ1v11yqpcWZ7WBzIFAiXY1gs+KNfzH9ENNICS8+QE9p+J7jN0y8IM3XggfRXEkF7
 B+T3W11mWEWfn+XD2ma/AFqS8JB/onYNT5lOD4j1vkT0ZEA2AH9AFZjaQ3fjj/JS971a
 jvcLVPiNFldOFrPEjKzL/ny9MEajWBfNbEdyEwDChV8ynGuWIsF2xaq6zviEu+emGtqr
 6ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772125922; x=1772730722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KVGeyYZwb5DBBWAsb4Sz6ldKNKBB2r5kGtLjqeOJtsk=;
 b=Bvvvbciaikvm4EAnkPHuIYqouCvok/zF+Cmzb9YyUv6dylGC2jsMs1dj6Ehcy++wss
 1UUhC1dgcw4N+vDof2LbtbwQkZMQroll9KiSY1lwzim8978RAunCIOsgMWvrnTK93DkA
 bK7NRx5jKSspbkpl9CojPUHDl6lOYiZNDnrz8T+PcMm75xQK9U2XdGnCdq3Hh05Jn78F
 jSymdVWG2a53iUpLp+GbWgxor1fGi3xW6hWbAgPVAD3Qbd5MVXpHWdqM5pF1IlhtfV5i
 S9J2eypQz2RSSycojW6Vh7oXvVyOSRpL8pbOrhmY8JX7f0zXXFDu56BLt/dtTwh6s3OP
 6ndg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzIBOciuwUQizPYSytUk/u5TXy+kTdTnStfmYFAkgYt/BYVyUmqnB12NWtTmlWtBcGoX8L1BE=@lists.denx.de
X-Gm-Message-State: AOJu0YwsyfBTkp09MELSKbKNAt4/lt1q8npUYuy/MD0tGFWN9WWLVYfQ
 mGJnpbH9Zk042qZnmrsv5m995MqAoJVskuo6NCDqhX1i0/o/DsV36fzZ1rY1QSAh6X7EXA03oeR
 9tkOTpjY+Irlyg8aUFXDFp0fmPO8uRFzmrwQ=
X-Gm-Gg: ATEYQzydDDNfezHNQeWpF6N0fq6XIDV24dtGvt4LWm9T3Xq49gRDNTBHYowzd9FneO/
 jqUjKBK/Ku7rJ3enOXaqF2kcDEWwj+fM2zBmd3hRFU2q71K1zYDc7QTM8dY4Mpf96tgk1UbvjBx
 y0xP1tXomflzlaEnGohnTweWjteuiBKuJ3QjY6ttkcJ2mbrq1cJRtNxDP8QzVz7oUc+AE3W7YmP
 Ep2HIv82vfSG5mv9tc4/6Nnd1zLwpmmsDjJlDPTXq6Y4oBu6PJogo12CMNWOzUwgHhP2gPpHswC
 CVgBDD2zm+jxpJTqrYZiWKnUr6ZGekFaxacCHcU=
X-Received: by 2002:a05:7022:6290:b0:123:2c98:f6af with SMTP id
 a92af1059eb24-1276acfe093mr10759204c88.14.1772125921653; Thu, 26 Feb 2026
 09:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20260225061951.46329-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260225061951.46329-1-heinrich.schuchardt@canonical.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Thu, 26 Feb 2026 12:11:35 -0500
X-Gm-Features: AaiRm53-1N8tji-MWdJ43VmIHoMzRRz0hQRu11ekV1iUlIr6sQm8PThAxhfs1yI
Message-ID: <CABdDSeWmo-eHqrqoDjrq2Za9goJpeVc0f3gBBOegZsAy8dNyew@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm/mach-sc5xx: don't select non-existent
 GIC_600_CLEAR_RDPD
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, Tom Rini <trini@konsulko.com>,
 adsp-linux@analog.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Heinrich,

On Wed, Feb 25, 2026 at 1:19=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The symbol CONFIG_GIC_600_CLEAR_RDPD does not exist.
> Don't select it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/arm/mach-sc5xx/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
> index ec1d5539dc9..e781603a8cf 100644
> --- a/arch/arm/mach-sc5xx/Kconfig
> +++ b/arch/arm/mach-sc5xx/Kconfig
> @@ -44,7 +44,6 @@ config SC59X_64
>         select COMMON_CLK_ADI_SC598
>         select GICV3
>         select GICV3_SUPPORT_GIC600
> -       select GIC_600_CLEAR_RDPD
>         select MMC_SDHCI_ADMA_FORCE_32BIT
>         select NOP_PHY if PHY
>
> --
> 2.51.0
>

Thanks for this fix. For posterity, the logic originally expected for
"GIC_600_CLEAR_RDPD" is available in arch/arm/lib/gic_64.S:

#if defined(CONFIG_GICV3_SUPPORT_GIC600)
        mov     w10, #0x0               /* Power on redistributor */
        str     w10, [x9, GICR_PWRR]
5:      ldr     w10, [x9, GICR_PWRR]    /* Wait until the power on
state is reflected */
        tbnz    w10, #1, 5b             /* If RDPD =3D=3D 0 then powered on=
 */
#endif

and the symbol was just a leftover from a patch we had made internally
to add the same thing before upstreaming and then dropped.
GICV3_SUPPORT_GIC600 is the correct symbol for us to use here.

Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
