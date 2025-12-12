Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9129D44149
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 09:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17082835B3;
	Fri, 12 Dec 2025 10:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f7Z19bnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E26EB8367F; Fri, 12 Dec 2025 10:01:38 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D038312A
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 10:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4ed9c19248bso8527331cf.1
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 01:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765530088; x=1766134888; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2OyFjy+wlKgnbzZ1PX2lh5ICC0gZleKVKVnQobyxOE=;
 b=f7Z19bnWzlChxwFIRmEFFBQC1NhEcmhI0IEtjkpF6JyHMEdd+QrDiTWlAFoEU/470k
 A52WAb/exbu5USdTpHpXsLUNavxYDSYWsioIhDKqyYeil31YHJLyA82gBuopgtvmho/6
 2YmoIJ5XMlNBZNctfpvMv7igRe69b0e5CdVZ5kACB5xFr2ZdTKs7YP0r6jA1/94WMdCs
 6Uxawq9wtOT5rDA95RSbf86i8NIZn3e/wok+rETMVjt0QAoCIBVmVsMNuNOjbkCvlxDu
 glvvUWDrV2q+ylFn5eeZYjBWf9Dd/U6FQMK8tPZXR9RkU5jc57mp69f9eZb7w9TyYuKl
 lUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765530088; x=1766134888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w2OyFjy+wlKgnbzZ1PX2lh5ICC0gZleKVKVnQobyxOE=;
 b=fdLUgWt2kBRyw2n+oNF7DHt7000nWn+XXn0zKuB7HJZneWghdc9kM5SJlUTZd1FLdr
 uKVkb8poyxFA1D5cbXaWDI0n0NDPi2qHSgPZ7dYBU3Yj7DuyDBZnkTJR6YtJnRXBq3y1
 Ws4g4tck6mDZzODUagmw9XSRKVxzVQghZ0mAcAfihEmM+BBMch6cYyrtaXuNVb/v9LFo
 z8KLT2ptnJBJJOKl/PzjRYtELsQ5YukObhE6s4QHJbqLR6aO/bUCYAT9QNZTb+N9LmOk
 1YYrNFnr+WnaUGQa7TCD7Hpr8dkvGpJYogy1ykoKJbgB6NwBgvW7+HeT7U5Xw8yQcOv6
 u/+w==
X-Gm-Message-State: AOJu0YwUYItWjMoT0qKZi/53ML4jfRm6OiHXJiXptJriW7KEdfJR0qq9
 YpUmDdBDrLjMTx2dkv+GS1CqLMHKjieMEJvpOjLDU/zwv/eHg3s//E6qcAlB8+YcPN59eTuf34e
 gWPoghl/RQD1fwiwIx2xmqeOFqm6EHE5UBb8Qs/s=
X-Gm-Gg: AY/fxX7qnSnAQ+fQmUPc0aBuqau/zrhjZbRNiCGAn13f7XBXyGISHKfl+cav3GCNYXZ
 YRZFcJ/akY35R5oMjylui2OaEfwJ2k1t73TrCBiQ7susnjFa6uFrNqgAtC5YDwlNBl89zXCwGcg
 pytRzFkK6eKJK8fchuLHG5hEufU4XdnfUfBpMKyDAtXgRK+yDQiobuFnUHb7Zp5BinqExTw70ol
 knj7y2yokNHDU+37AkQwlPafjdwwE3uun9Ly56Nrv8vkTvDpeIuWpkcf+dqtb11sjjeeQ==
X-Google-Smtp-Source: AGHT+IG9+dIulDJsfcvQqoDsedjuyg7bC5OjUXmV4IckpD9wcjk0WvuKPytgdddrleEr/PKJ/XOjGxk+d3VoCAQaWGo=
X-Received: by 2002:ac8:7dc8:0:b0:4ee:4a3a:bd12 with SMTP id
 d75a77b69052e-4f1d05d0f89mr14903961cf.57.1765530088250; Fri, 12 Dec 2025
 01:01:28 -0800 (PST)
MIME-Version: 1.0
References: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
 <20251210-rk3576-ufs-v1-1-a3f9e76eb66e@gmail.com>
 <f616ea88-9d87-4960-bf02-62f0fbd1b206@kwiboo.se>
In-Reply-To: <f616ea88-9d87-4960-bf02-62f0fbd1b206@kwiboo.se>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 12 Dec 2025 12:01:18 +0300
X-Gm-Features: AQt7F2pQBrZHCNOvTTs-_pVE0KT5xuVcA5tm_lAmy47iX32UbqOKEwnfpdoLcPg
Message-ID: <CABjd4YyevgLs4FqzgLTsog2A8h5VSKcFbhR+TABFUCrEBudLyw@mail.gmail.com>
Subject: Re: [PATCH 1/4] common/spl: fit: Avoid directly loading images to
 load_addr
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
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

Hi Jonas,

Thanks for your review!

On Thu, Dec 11, 2025 at 3:27=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Alexey,
>
> On 12/10/2025 9:10 PM, Alexey Charkov wrote:
> > Load images unconditionally to a known-safe location (which is
> > CONFIG_SYS_LOAD_ADDR) to be later relocated to its desired load address=
.
> >
> > Some storage devices may be unable to directly load each of the images
> > listed in a FIT to their desired load addresses, as is the case with
> > e.g. booting from UFS storage on Rockchip RK3576, where part of the
> > ATF should end up in SRAM but the UFS controller cannot directly write
> > there.
> >
> > Furthermore, the code down the line does a memmove or image decompressi=
on
> > from the original src_ptr, anyway, so there shouldn't be any performanc=
e
> > implications from this change.
>
> If I am not mistaken the memmove will try to move the src_ptr into
> load_addr and as long as they are same this is a no-op, so I am
> expecting this will have performance implications.

If there is no difference in alignment between src_ptr vs. load_addr
and no image overhead, the memmove down the line should indeed return
early. You're right that there are after all cases where this change
will affect performance.

> I suggest we instead try to configure the rk3576 firewall to allow the
> UFS controller to access SRAM (SYSMEM) similar to how this is allowed on
> e.g. rk3588. Please see U-Boot rk3576.c and rk3588.c, and also TF-A
> plat/rockchip/rk3576/drivers/secure/firewall.c.

Won't this introduce some sort of a security hole? I have to admit I
don't know how the "trusted" part of "trusted firmware" is enforced,
but I have a suspicion that there is a security reason why this
particular segment gets written to a more locked-down SRAM rather than
system RAM before TF-A code takes over the management of the firewall.
Would be great to know otherwise, because this sounds like a much
cleaner (=3Dfewer code changes) solution than the alternatives. Any
advice from the list would be appreciated!

> For other Rockchip SoCs we have also used non-DMA mode or a bounce
> buffer to work around similar issue in the drivers.

I'll look into a potential non-DMA mode in the driver for use in SPL,
thanks for the pointer!

> On a final note I would not fully trust the SYS_LOAD_ADDR addr on
> Rockchip platform, to my knowledge this is not really used for anything
> and because of this have not fully been considered when other static
> load addresses have been picked, so this could introduce some unintended
> overlaps.

That should be relatively easy to fix with a quick Kconfig change, but
I agree it might lead to an unknown number of regressions on platforms
that didn't use SYS_LOAD_ADDR before. Good point, thank you.

Best regards,
Alexey
