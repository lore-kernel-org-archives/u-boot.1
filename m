Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B9CC369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 07:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7F7581F66;
	Sat,  3 May 2025 09:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="un0afpPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E06C820E1; Sat,  3 May 2025 09:16:06 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26577812BC
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 09:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D83423F2B6
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 07:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746256562;
 bh=+kXB3IA7A6pUJaUguMQMChKJrmeY2yAPiqwMiNrey2w=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=un0afpPZR/bct8XteqQrATfHzvpqkfHhYHI+fdfSTlq+WEC7BYUK20llQ+vNgVsoq
 xcmcz5K2xkQ6AcT+3f8U6st11wRlQdRbzd1WkSRHS0WXY5MQZhMEskLp678ffGSBRZ
 dD7E4nVTFCzFj+1oMN+p22LjiRrGdFdJ8EP/YseDovW9W5FcD0umfiw2KNitQXLjBL
 bFFu4aeiCnD06TfF78ipSdBhGHfMSp0TJy3Yw6TD0EB63Lw1eXFhhTaPlVCEokgYVG
 VC7PytMATCI76Sq9PqidqLhwxxPvtU2o7a7kNVdo8qgxP6Ei+rbew0zARQ+H/LeHQo
 /oU5utsbiOy8g==
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-309f0d465bdso4325056a91.3
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 00:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746256561; x=1746861361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+kXB3IA7A6pUJaUguMQMChKJrmeY2yAPiqwMiNrey2w=;
 b=bmpnY2YMqXRkyZ3CgeTtBBlDAxqD+ofbtxkgsXeuuZcy2Tqyu9Kq2FFswQSQdnzSkC
 gSI80hH/Tx4AiB/67eNVn5AE/4Bc5+TmZVJJ7+UVhj+3n9m/3GkBkMbgho04pn5rgMM1
 eQXkIBmA8Ls6Gnx81OHIhnG3fqCzkh8N19GV0ezdFOL2nH9O6gIKgtT+CBC04cOGSV0k
 K6w0ctUFZwTF/IaK8RZadFdCJ3BB3Nad3p+uzUXo4XE4Fzm9yb8RE//m+sodbs8oSGj8
 hqzwhnuJH7W3iVdheZmW5h8Jv8F7GBGD2DMdh7R/hnFW/1Dqp7+FKxHrR0O0Xdj0Hv6c
 Ok+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9eskfne+d7V+yvV69+AD6plrbHrlzAsgUMb84/0RsGABG70XOI5fE1QkfyJdjBkwEZJwyC5s=@lists.denx.de
X-Gm-Message-State: AOJu0YyHCMlpwy1CxpXxTiqr66lMf3feAzK66gDPWixsq6JSmyUDP1LU
 5AnRSGamIHXDb4S9+3J6G/a1mRFL0dX6khEzNfgRh+8SkvbmhDiino5sszvvQZFwi5c9dTXDqwB
 GFr+Zi8p8QRJk9A6OQ+MDAfUSiInNa5DeIawe/4baCt9Sjepw48ReM8/e0NTt+GvEb26cXlfYyF
 v9iTMcsSyoGv9NIuOqJNXrmBTFVBZwf9BhDNCFsLhTQg==
X-Gm-Gg: ASbGnctPyOb6MYKrOJXcJsMFOQhCT0VfYTRo3zI18mpCBrJtDtmdek5SPeukiKDrGNH
 80YAYh0RcdvfiwNevABewx02wLnM3LZbuGHEfd+IRxc/ef9/xnFSSwu8lfHGqWHCQB7aq
X-Received: by 2002:a17:90b:3c0b:b0:2ff:58e1:2bb1 with SMTP id
 98e67ed59e1d1-30a61a6f700mr230137a91.32.1746256561148; 
 Sat, 03 May 2025 00:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnhAK8DHfMjSSOGF3vzOZKgo/wjOJYs1vBcQWB/Dh1fMnNt3YuhSNIXABot7MWKZFnPJL66Kgrc7AFemKdbGU=
X-Received: by 2002:a17:90b:3c0b:b0:2ff:58e1:2bb1 with SMTP id
 98e67ed59e1d1-30a61a6f700mr230118a91.32.1746256560745; Sat, 03 May 2025
 00:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-4-heinrich.schuchardt@canonical.com>
 <CAFLszTjcCXDnjOjpD88tGcvSz1AOAouyHKsynzCC3tngDqzOvQ@mail.gmail.com>
 <27c7a370-ad40-4935-8b2a-f27468a01467@canonical.com>
 <CAFLszTh3db5HwBfD9rg=YGY0n2DKE2vfBL0UG5x1_5DoJcj5WQ@mail.gmail.com>
In-Reply-To: <CAFLszTh3db5HwBfD9rg=YGY0n2DKE2vfBL0UG5x1_5DoJcj5WQ@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sat, 3 May 2025 09:15:49 +0200
X-Gm-Features: ATxdqUEdqesReRYkGiR0xjbUf9NMG7kEftLqGaV8kDszMk8hh1OD_07UdEtFAWo
Message-ID: <CAM=mAOk8BOz9O517614qOLCin-KjmQHXuwAkSSRUewmLG65Vdw@mail.gmail.com>
Subject: Re: [RFC 3/8] boot: make BOOTMETH_EFILOADER default=n
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Simon Glass <sjg@chromium.org> schrieb am Sa., 3. Mai 2025, 04:10:

> Hi Heinrich,
>
> On Fri, 2 May 2025 at 10:16, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 5/2/25 16:49, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> The boot method is deprecated as the EFI boot manager covers this
> > >> functionality.
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com
> >
> > >> ---
> > >>   boot/Kconfig | 1 -
> > >>   1 file changed, 1 deletion(-)
> > >>
> > >> diff --git a/boot/Kconfig b/boot/Kconfig
> > >> index 71ddb37f6bb..b973d9eb0a7 100644
> > >> --- a/boot/Kconfig
> > >> +++ b/boot/Kconfig
> > >> @@ -595,7 +595,6 @@ config BOOTMETH_EFILOADER
> > >>          bool "Bootdev support for EFI boot"
> > >>          depends on EFI_BINARY_EXEC
> > >>          imply CMD_TFTPBOOT if CMD_NET
> > >> -       default y
> > >>          help
> > >>            This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care
> of
> > >>            launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option
> matches.
> > >> --
> > >> 2.48.1
> > >>
> > >
> > > As mentioned on the other patch, we need to keep this enabled and it
> > > isn't obsolete.
> > >
> > > Regards,
> > > Simon
> >
> > Please, read the UEFI specification especially chapter 3 "Boot Manager".
> >
> > * The functionality is fully covered by the boot manager.
> > * The current implementation of the method does not comply with the UEFI
> > specification. Especially if run before the boot manager.
>
> We're going to have to go through this together sometime as it seems
> like chicken & egg to me. We don't want Boot Manager first because it
> is slow and stuffs up FEL on sunxi etc., we don't want it last because
> then it has to wait for networking, we don't know whether bootmgr is
> being used or not, so we just have to put it in the middle, but then
> we don't know whether it will succeed, at which point we have to go
> back and try the whole boot again..?
>

Sure there can be a situation where none of the boot methods will succeed.
E.g. if there are no boot media. This has been the case before the series
and won't be different with the series.

But if we reach the boot manager after trying FEL, extlinux, script and
none of these booted retrying these would not make any sense as they would
fail again.

The boot manager already comprises booting via EFI/BOOT/BOOT<ARCH>.EFI. And
this must not be tried before booting according to BootNext and BootOrder.
So we can safely delete that non-compliant bootmeth_efi.

Best regards

Heinrich





> Regards,
> Simon
>
