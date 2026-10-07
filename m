Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A25CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 09:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B1FC405AE;
	Wed,  7 Oct 2026 09:32:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DI13Js8ZBfzS; Wed,  7 Oct 2026 09:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 29E4040562
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791365556;
	b=qTPawTk/RJA4EGLOEBEIV/qlsv06lq2v1TF8NM5s+WEvMUB09577Cqrn23NBV1ZkrV+u
	 M+A5v9xDaIzEbZYd9m/Vm171sv52mrbCUf00ZUvp1eFqIYXZs5cJmzwS+A6V9AnVE27mK
	 1HrIhLLK6fepEesAdzi/oPLmyQqkaqB9Pax6WCKIpch7hc2Uet34HlNwPXu44UQ45IffF
	 HyoVKmdF0wLeZAN36XW15NDzsTFXO8hSSKY5PQ0zEFEcquicq1y2NhO1E/RTV7wVsUDQQ
	 v8nQwK2kCjjwUu59U/nhVEM9CTTe5osKKPW0YwolAIs3z2v6vDxcsaoDZuIkUo2AtjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791365556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OBhiv4thNS3GTyNHxOrR3C5qrTcAaH0SltyNowP4ymQ=;
	b=maESok1s9O3qzwmdaCWoLvkR4fdEBmVC4Kem/9+q77gV+CFQU72q7vs2zB1Qn/7D56z4
	 Fv/L8o2XSyV+g7IwQcfTqP09j5Cw3OxgVzzAZLodh06JyqhBtGoNshUAqx7Mt2XcIzoH2
	 YewoAjQGqsWWbK7VQPXqAVZj2pTn2wnZZpnwUWYZ8w4zciCZh0+acz+hJjzBKsBdvuNWA
	 MkMuRy+CRTatRpYM0PU3oAgWlpgbMzjEkYAiBch7LfqWd2FlYh0pcujqA1DDmlGgFp8L5
	 vT5pTLeRWclAKkXiaHQ/P6ZELSGdwSHwJZPARKUiWCdlnxWkDnuTdA6THuTLzwg78ww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VxlTi3TW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791365556;
	bh=OBhiv4thNS3GTyNHxOrR3C5qrTcAaH0SltyNowP4ymQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kKZblR3IgRhhf62NzwjBGu5XfBD797V8jzHYcvfzAuhCz86ypofQTRnmGANSATT7K
	 YHLGDLZMyuTaSOvE1icTcYaZIXwaMvMrc59d02kGvGRZhXBaCavlIp73MEoqUNVbI6
	 sNMzoNnpBDWm1EobHbokDrX2V32lsCUCjw3tUVN2fz3/v6exRynELDV6+0yF4qJo6p
	 h6/S6aTc6N7lHJh56cPopRL8X48nzFGh/BXJ8t884C1ePOjoiMI4FVPiU2C/j0O7y2
	 D31uP0ps82ifEhxW0jzEqrw5XdjozYplXl5G/Xu+CPaA4kQtzJ4E0FO9VYMW4GuYE7
	 zLHsBHJubmBVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29E4040562;
	Wed,  7 Oct 2026 09:32:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 709441D2
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61E0F4069C
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLUnLdhjqWR6 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 09:30:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7D41840692
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791365453;
 b=AjwfZ/Mu9FmjC8Z8rrpfoyHL3YqCMZngZCR+jognRtnK1ZlCjf2vGn7ok5lGwXJF/zEe
 QKkz5gQIGaf5lDzn3MyeH5Nt+UjI+VvzOL64MbYdNeHRlTWJdsL8m2BAWHwF2ikUUi9Ui
 wHu8JfVPHtVx6slwWV3pM4b918ejA+06fWoTaIrob+ka3G/BNyLYt8AI6SYTTHEe5oOE7
 1Q+Nky+d8IwQfolH2aMW1XRzzNEG0o+JHp0l3VimJZfyWJmlW67NXCzkySkWvi/u9wopW
 Uc/Ji90cZl9dAMe4vk2QiJ6wLIJWZu4vskh8xNCuCCRXMBmilI60MZWLdqG3pUxgqOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791365453;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=OBhiv4thNS3GTyNHxOrR3C5qrTcAaH0SltyNowP4ymQ=;
 b=F4qkyJ8MtGRHEbisflm5vT0rKmCtscmE/ks4WWrck/Nej9b+Eg7rLgQ8/YpYTJcP1jD1
 +PKwQGIF3+UYgYDeMBjrLJfKoSXUb7tbzXM2mqO4pON8ZmpjEcSyYq/wzXYh7qwy1ZMLl
 kNE3+nrl3C9KawyMk253Ou7vVCzZ3ROMh/1OfSn7hJ6hp1Dryo53gmW9wh5cU5Ql+WzKY
 Tvq/+Grq8cQoTfmMvnYc2/3Hdet1dyxkffjFKk2VQkUjUSIaz7/tn+qosFJuL8lLEtyWS
 JiLTnYE3qlXE3ylcRsyltfV/vQ+Wz0NfGDfbGUGsyvIEkhHFHhJcMfykbCGkMusGWVw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VxlTi3TW; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VxlTi3TW
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D41840692
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:30:51 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so27363585e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791365449; x=1791970249;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OBhiv4thNS3GTyNHxOrR3C5qrTcAaH0SltyNowP4ymQ=;
 b=VxlTi3TWI+r3Lk6QzTZKSjpcAbepNxiC+tsdPUdgScoMPUffe0XlUMANqiQJV5pyYj
 QaTmFeHD88xc203jeyodElyIL+jHAvZnbvMOh9G+wYE6Bwi62y87xXQf+L64nE7tU8ZJ
 kEk5nLrLnR+T7RaGcvTnqJ4rN/ehsDl9+EetiBAsAcB4NvxofNhRV4tY9/eQ8/FLoKbY
 07bjHi4uMJGLcRAnebMrIJEFoi7v9s2/WzJnW7nxVHSTTt+lggTF+QG/fXIP2bk+MY7B
 bKqNF/qsxDKQb08ABSWc/5F8yv9MIcHhF+5rNoC8six8l4ZUt/E1zsTPGjkZHa4bA2Eh
 53mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791365449; x=1791970249;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OBhiv4thNS3GTyNHxOrR3C5qrTcAaH0SltyNowP4ymQ=;
 b=24MxhiqrF3lXF2pFrV6eEC7ntXbfeXOBCqDTQlsNvQ5gcJoMLNITGiFnTqEjyJWzuV
 YPexOznakkDA03SIO4VuB5CwUkM/9JwU9JEXK8T3l83t+PIVKW43I6KVdT13uvF+krO/
 BdMmCepZdigTAVyePpwS7jnsiyAu2pm6/ZT5ZMbqhc1+aUiPRuGz2llKVS01Zr9xBo9b
 yINHFgwlGXxaI1T9r6o7KmZ3iZVn8CVXVpyyuL12QF/YL+b0yph7Ee8/kBTe3USL7kpZ
 DG0khqA91L9hOC7T2Brss+0QpDIYJMYn5h56Ar0hZeYfkYo/BEPg/ERRffhhmPima+n4
 /AYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkAs5hsBYg+o0icABGllbaklVkpcw5IzVfwVMRj16ZZ4Dsy7KWmHKIh8vxfnMog5ATbyyDmaQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mxamw+rgbIx4kxcCh15zJQ3twDZSDDldRZ2a2pft9hAkUmA2T8
 92xbGXupERvRAm9EOePWmn+DMYov0shtJX4GPL2Tqf5WHgnu43TVdFZ+qAJuzFn62Xc=
X-Gm-Gg: AYBFou2bxNuXsPbcINF51dwpRNOln9icYawu4iMRX1Lbuv3O0oCb3s0HsimA5KCOFTT
 nzAQXVphF0lR/GL14gTiEIQAONcTTdzeOihIhw9699BnWgUWZ+IA0bsLMJHKXou4+G8m3hxaYao
 eBjw46uE2Rec3WnOexKWWTtuaR/ZTiVZDqIzdk6Ov4aiS9XTq1lcgPJUA2y/bQ9rD9Vhelh1rtf
 7oNyTeCs6wMJRpvNa8I7WgOqIIMwn3xUWMRJ6+GWqqrhSoYPZa+yogLtkh5t0T8mDKBtItqZRtZ
 qkvp/EBVsQFh2Xh57YeyfcxvAlHgUoGsyYuEu9CA8TDrF6HObPlJpBBEtY+wZiuEt1j+Frs8A7o
 imw3sZYeWv+Vs2lCvXh661PptfpCwf0kpnIoVIrxtm2KitC58cBaJxM7k/kNQGYTjqyIuisItT/
 60M5I27d+mfljV2830fOvgA9Wuvn0swj1TYt+1hP5X9+o38JQfRolQkQBYumXWWQtDqj+XJdwVO
 U+odbvkGQ5DIDZXM3vYP/B1qVjzCoiLmWslSAPmtEflHY3d0ATX6ovOOemqhJ843XZW0JxE35Q4
 3mw=
X-Received: by 2002:a05:600c:3b0a:b0:4a1:6a10:4dc8 with SMTP id
 5b1f17b1804b1-4a1806767f8mr21784995e9.28.1791365449402; 
 Wed, 07 Oct 2026 02:30:49 -0700 (PDT)
Received: from macbook.tail959722.ts.net
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a181ae0e19sm16736635e9.2.2026.10.07.02.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 02:30:48 -0700 (PDT)
Date: Wed, 7 Oct 2026 11:30:46 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: E Shattow <e@freeshell.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, David Lechner <dlechner@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 1/5] efi_loader: bootmgr: preserve a passed devicetree
Message-ID: <asYMDZzyE1EPSSOE@macbook.tail959722.ts.net>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-1-016658d0b6ba@baylibre.com>
 <2858ec5b-40ea-494d-8566-64eea06a1e89@gmx.de>
 <arrMZNzoS0hrDuSG@macbook.homenet.telecomitalia.it>
 <773e462f-7296-4b21-b090-ff1f27c10f6e@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773e462f-7296-4b21-b090-ff1f27c10f6e@freeshell.de>
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

On Mon, Sep 28, 2026 at 15:00:03 +0100, E Shattow wrote:
 
> I understand the need for what you describe, however the method of doing
> this is also not clear for me.
> 
> When I have encountered this situation the workaround was to invalidate
> the 'model' compatible property in the tree to prevent a later match and
> whatever process from installing a different Fdt than what I wrote on
> the 'bootefi' command invocation in U-Boot.
> 
> An example of this is the Debian Linux 'mini.efi' netinst
> debian-installer on riscv64 architecture. The 'mini.efi' contains dtb
> information for multiple targets, and there is not much configuration
> choice about this. It would be useful to suppress the Fdt passing logic
> that occurs through EFI, to mask any of the model compatible (possible
> using u-boot 'fdt' command), Fdt, and fdtfile name.
> 
> I would like to see actual examples of why this series is needed.

Hi E,

The case I want to support with this work is booting an unmodified
generic EFI distribution from SD while supplying the board DT and
overlays from firmware storage on eMMC (this is a very specific use-case
but you get the gist).

The FIT describes the supported combinations and, with required
configuration signatures, authenticates the selected combination
independently of the OS image.

About the mini.efi objection, I think that is the same distinction
previously discussed with Simon for GRUB (see [0]): this series controls
the DT U-Boot initially supplies, but cannot prevent an EFI application
from subsequently replacing it.

Basically Patch 1 addresses replacement inside U-Boot, before the EFI
application starts but it does not force subsequent EFI software to
retain it.

Let me know your thought about this,

cheers!

[0] https://lore.kernel.org/all/CADh8LscEUi5kvGQ28GErjEM=WvQ=6t0p5Kh30jQ-S8ZapG8yrw@mail.gmail.com/

--
Carlo Caione
