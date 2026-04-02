Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CABCD6AAF2
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 16:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB69A83F8F;
	Thu,  2 Apr 2026 18:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Thwv7BcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A82840D8; Thu,  2 Apr 2026 18:40:30 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 225AA83F7D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9825ba7e8dso148742866b.3
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 09:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775148027; cv=none;
 d=google.com; s=arc-20240605;
 b=M+YLNqHRYcFl+4X71PExObb0FAnEwwgup7HgqUPrZexWswE8q3s80r+XuoxAOlSjP+
 VDgOwuxvRnrEB7UkuM50pk9DopVF3w1dx090ofg/6S6QcMfpWEj1Ups6Lu9e1QoJHFwd
 M4dPFqovr/WwgAwVpIluzFoLMb+4rtwI15WZa4ZZe4zPaMU0haRjyRX36TyOo1X716/C
 2KnPU5bWel7HdW3H3DwaPm0njOz9ZmHVcb4eJ/LKSiWw4J++yonBYT5Rp5J/83GTpOWJ
 cdZ8HEVFQ5bIZPgKJbIAp/JVNM9wuH04JRkEDJYmWPXUtyTXI3ZHPnIXQdqDN+SZuJ0q
 MF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=qOOIOJ7IDlU1o5dIGb8MLtNEFdGrYIJCU4x3knRrqdY=;
 fh=0S+1xXUw/FuoKwRrebf8NjIdk6t+qE/l9BmETFX4MN8=;
 b=CGHzbHwjvjTJr66ryLVZFjXM2xwcelOQxg/8SNvH0yXnL7JEJ/Xi3ReJgnu/zB3ENS
 x2lvFGJLyPb04q1vU2sk4tk9DjBSJfB10PRl/87YE2w2/6+n3wPjjiN6hXD7jzaUR91k
 6u1FetDZcS6CxqjS/8byq2hTiVAAKty81UNWCycSJNeNm9fiICW8ZDWT/bdk6nqE16po
 JrAh/TyE542TOBbqrQ5C2a3VPSSAZKyFQIA7oMeqdhwreVFVg+Lv3Bqucmrs74ljCD4M
 HTkrC/mYLtbcdBvgvBUU8VcgHeojqeAof+ktF26V9+hzCCIBKaXLBIy8liaaX9ou36xR
 tcpg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775148027; x=1775752827; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qOOIOJ7IDlU1o5dIGb8MLtNEFdGrYIJCU4x3knRrqdY=;
 b=Thwv7BcAsl/OXJHqOt2zgWsju2hGDB82XUWMilpD/5xl2Pni1aRFzED93gQvkvp3Q5
 lWkDqCH4hyEEPAWBrgjoWH1bfifZPrHcPx1Fn/ZbhoQrnemY+grbNWt+bAx1iveZHrgz
 mXjNBUb+RKVbzb93HadGAwX56kirgGhSq+RXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775148027; x=1775752827;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qOOIOJ7IDlU1o5dIGb8MLtNEFdGrYIJCU4x3knRrqdY=;
 b=P5ezfzWOQ0oJy3g1d5vyPthTlBLFKNXLMg+8igqM0ILsm2LUd8VET6V1yqiAqQWIsf
 mS1UZBgkfsOt6kodjFOtuXnlbeTInxSaXHtTyB5o2sx9aO9az27vJiN92o5CQCbpCYLD
 xGOdkwxz9FEWVwC1tr+amHpb3hakFsebwunS6uS9jVwnvykFmoZINRmInT2BcyCCSXq5
 lNSMh6PQB0RHTsbbWPFolwTgzv7IroY6d0Y4KNnPuDqTrvkkBTnW/X4Gz5xVteCugw4c
 xMoe+wwbJasgIs6Nxpp2Hyybz0E0JUZAvAIQzw0EED1OO8OPC1/Y1yMVDK3x/p2OjjMO
 DWZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk2SsTeD07oNc+fyCcMQ4k1YnASvcgA2OxcxCUJl/fzixPjlSwQD/Tbfn+gIgsgIOgll3igtk=@lists.denx.de
X-Gm-Message-State: AOJu0YwP1OoZIa09gnWFhzx3BoSHDQoQYNO9DGqvX6Z0Y8kRjyb7vl2Y
 NFia32EZS7UAcYbnKnnXthjCZ+Tw79rlm7ManV7bJvbAYd7/uJxjm7+TZsM9Vf/wuHDdD54iAxH
 N3OqjInIefvSNGix36y0KMsvF/ttSgDQfiHpP6/fN
X-Gm-Gg: ATEYQzxtbQT37jzDahC1iaSu4k8aadie86nW4GQ/lcYnPHUYGCZtFcA8WsTb3K9CoVu
 lW2xIgCsyilagoeCu+yX2Ep9ILnRaBVo1czojS1Xcngr7Ak93ayGTPmhZwJaza9KzooIctEtgMs
 GxenLDDo4uNUEHe9oeSrIEmNqXU6LgUFrQEorENAM29yLI11xXy1LMa02rWXXxiaywx/s1Yx2jM
 pqpWIdsjLww/LKNagcPa+hJkki4COkD95vGzAhTfM8EEyBra+Intyn7v/dOSl5KMU+c8YyXoeWP
 H4E8vs/OTHoMwb4Z
X-Received: by 2002:a17:907:d40b:b0:b97:acca:fcf6 with SMTP id
 a640c23a62f3a-b9c139105eamr521236266b.23.1775148027456; Thu, 02 Apr 2026
 09:40:27 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 10:40:15 -0600
X-Gm-Features: AQROBzDb4Hzi7k3DOLQY4kT7sl5c54kizu7JXnC4JPN8Z6p3U52mjDeuQVSVY30
Message-ID: <CAFLszTi-H==WCgpJPgnATQ=HK9=azYF-p3KmpqjNcDH4Qz91XA@mail.gmail.com>
Subject: Re: [4/4] doc: fit: add dm-verity boot parameter documentation
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, Aristo Chen <jj251510319013@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Francois Berder <fberder@outlook.fr>, Shiji Yang <yangshiji66@outlook.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Daniel,

On 2026-04-02T03:08:27, Daniel Golle <daniel@makrotopia.org> wrote:
> doc: fit: add dm-verity boot parameter documentation
> doc: fit: add dm-verity boot parameter documentation
>
> Add documentation for CONFIG_FIT_VERITY which allows U-Boot to
> construct dm-mod.create= and dm-mod.waitfor= kernel command-line
> parameters from dm-verity metadata embedded in FIT filesystem
> sub-images.
>
> The new document covers the relationship between FIT loadable indices
> and the /dev/fitN block devices that the Linux uImage.FIT block driver
> creates, provides a complete .its example with a dm-verity-protected
> SquashFS root filesystem, describes all required and optional dm-verity
> subnode properties and explains how mkimage generates the verity
> metadata automatically.
>
> dm-verity is only supported for external-data FIT images (mkimage -E);
> mkimage aborts with an error if the flag is omitted.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

> diff --git a/doc/usage/fit/dm-verity.rst b/doc/usage/fit/dm-verity.rst
> @@ -0,0 +1,279 @@
> +Below is a minimal ``.its`` file showing a kernel and a dm-verity-protected
> +root filesystem packaged as a FIT. Only the three user-provided properties
> +(``algo``, ``data-block-size``, ``hash-block-size``) are included; ``mkimage``
> +computes and fills in ``digest``, ``salt``, ``num-data-blocks``, and
> +``hash-start-block`` automatically (see `Generating verity metadata`_ below)::
> +
> +                dm-verity {
> +                    data-block-size = <4096>;
> +                    hash-block-size = <4096>;
> +                    num-data-blocks = <3762>;
> +                    hash-start-block = <3762>;
> +                    algo = "sha256";
> +                    digest = [8e 67 91 63 7f 93 cb b8 ...];
> +                    salt = [aa 7b 11 f8 db 8f e2 e5 ...];
> +                };

The text says only the three user-provided properties are included,
but the example shows all properties including the computed ones.
Please can you either:

- Show a minimal .its with only algo, data-block-size, and
hash-block-size (matching what the user actually writes), or
- Add a note that this is the output after mkimage processing and show
the minimal input separately.

> diff --git a/doc/usage/fit/dm-verity.rst b/doc/usage/fit/dm-verity.rst
> @@ -0,0 +1,279 @@
> +4. Reads back the expanded file (original data + verity superblock +
> +   Merkle hash tree) and replaces the image's ``data`` property.

This contradicts the note at line 264-265 which correctly states that
--no-superblock is used. Please can you remove the reference to the
superblock here, since the code passes --no-superblock to veritysetup.

Regards,
Simon
