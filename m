Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943F1D30CC1
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 20:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7D4802C1;
	Tue, 13 Jan 2026 21:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="APibaflB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E57A780077; Tue, 13 Jan 2026 21:03:26 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 052B8802C1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 21:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b83122f9d78so1260345866b.0
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 12:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1768334604; x=1768939404; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4LQOWyJEmm937+PsOjT9YQMCGNdOGNeYGPnwnw5fgBU=;
 b=APibaflBCIbEtcgCbqM9NPskbfWfkNLtbrB7PUYRj8k5WoYZrAxdgN0jxfsElV7167
 FxmOZo4JF3UkpKKo4zIedFBrHVC6UvxDY4r1kIiSKx8f+XGBa8c8rSNyQfKj2WGdrFlT
 1srPks6Yw4TdSerMsFCuUQp9tIjHNKaY80BFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768334604; x=1768939404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LQOWyJEmm937+PsOjT9YQMCGNdOGNeYGPnwnw5fgBU=;
 b=FbsjL5IJ/0vauecsyuj1Hj6KMHJCym8BmnHxKS5t19L2UQqkeGVntUbdjtQOOsAwhP
 z2Wu7r1d1KX5dw5+OAf/3Xal/wtqKPh6j8cVxAfDQvVlcpOT3T42qwWbtIk+6xC1MHXG
 CApq74Ywjy35Kxb11yQXPIX9rul7tQo3Obeyq0/PNH8JKiAwnC2q7QvoJmswgEj+pSe9
 lokGStfLeIkLcLEHPpatf22SMr48gDBPOROhRO0AFZpi6Vg7+ECrsDUiOOyBscEA/jua
 9ujwlUfoYS8Hfjd2ZG1vMOix7Xo0GsNdF8avRcOmeUQRsyqyYtMl4qcfEtsZE38QD79x
 4o/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW17yyjYe2qT+s/qpFFoaTKc0dtgIF82JO9MTl4+NMfI39cyIN8JQoWJyDN90MwZsOWdY3DSQ0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywqwp+kfLU6OvWu3JDJ90tbt49Y3ADmRVgt8OilpNNdHExj4UNz
 t+SKTNa7+/RiXQvXK+1B9GZ59LfhLQtbVpI3eVYRGD+YKBaFDtdRpnOvz7qooJjXLL+tjgO14RX
 MzQ4EmNcrtUSD6d+DvogSh9NUX376T1f6InSPgxqa
X-Gm-Gg: AY/fxX74wXgnG2nzDKMFFx4Y+t6lqt4RWl5EH82ATJ/eVu2nPzAOY4TjjgeCyDIiDsY
 JvhUOT2M8F9RA+XQuKHxUHFJsNigMz0luVgElnLjd2TPRkTOJExCNGpaYJbXBE/CDjvvTpXCu16
 YwjfLgP22ciBT2J5AIilsB8C75kdxmHDeG6I17ue/7WDGHXKcshQkaxtj0GyQAKUPfbCgknvRoG
 xKAMZanj/0zfqo37LR6c+P6XG9ArDz659zRVdz6CsV4ngIS/yZcsFQ2dpyM2c+VIs2gqw==
X-Received: by 2002:a17:906:dc95:b0:b87:19ac:98df with SMTP id
 a640c23a62f3a-b8760fc24femr28600466b.2.1768334604476; Tue, 13 Jan 2026
 12:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20260113012037.2566942-1-sean.anderson@linux.dev>
 <20260113012037.2566942-2-sean.anderson@linux.dev>
In-Reply-To: <20260113012037.2566942-2-sean.anderson@linux.dev>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Jan 2026 13:03:08 -0700
X-Gm-Features: AZwV_QjEzQDoHnEK2lEr14W7Dvnir3-jzASUgsagaFb-_xjcFQZTq_DkMVx5LGE
Message-ID: <CAFLszTg4qM-jpq6R7TvKQkG9hbing2afHx+qCb5Whv-U=PzBBA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI: sandbox: Use a parallel structure for
 emulation
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Sean,

On Mon, 12 Jan 2026 at 18:21, Sean Anderson <sean.anderson@linux.dev> wrote:
>
> Currently, sandbox associates PCI emulators with PCI devices on a
> per-device level. To create this association, the PCI bus needs an ofnode
> for each device to include the appropriate phandle, or sandbox,dev-info can
> be used to automatically create PCI devices. In the latter case, the
> emulator is bound to the PCI device itself! This prevents testing any
> U-Boot PCI driver, and also precludes bridges without device tree nodes (as
> non-zero busses cannot be specified with sandbox,dev-info).
>
> Instead of extending sandbox,dev-info, switch to a more-natural approach
> where PCI emulators form a parallel tree exactly matching the PCI hierarchy
> to emulate. To do the lookup, we walk up the PCI tree until we get to the
> root port, look up the emulator, and retrace our steps down the emulator
> tree.
>
> As it's no longer necessary to have device tree nodes just to link to the
> appropriate emulator, remove the superfluous ones. 01:10.0 and 02:1f.0 are
> left in because they are required by dm_test_pci_drvdata and
> dm_test_pci_mixed, respectively.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
> Changes in v3:
> - New
>
>  arch/sandbox/dts/sandbox.dtsi         | 16 +++--
>  arch/sandbox/dts/test.dts             | 85 +++++++++++++++++-------
>  doc/develop/driver-model/pci-info.rst | 59 +++++------------
>  drivers/misc/p2sb_emul.c              |  7 +-
>  drivers/misc/swap_case.c              |  7 +-
>  drivers/pci/pci-emul-uclass.c         | 82 +++++++++++++++++------
>  drivers/pci/pci_sandbox.c             | 94 +++++----------------------
>  include/pci.h                         |  5 +-
>  8 files changed, 179 insertions(+), 176 deletions(-)

Thank you for taking this on.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
