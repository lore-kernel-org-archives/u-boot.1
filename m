Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2064FCD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A897D846D5;
	Tue,  5 May 2026 07:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CaeUWflN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A5F884713; Tue,  5 May 2026 07:52:31 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F0A84683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-651c7ddf514so4525212d50.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777960348; cv=none;
 d=google.com; s=arc-20240605;
 b=MaE62OgTv23JQNrhGbvG1hJtNip0wmQ8/1IRoZ4m7PzKAwaUhIBsDBu0YHtDzpn3bR
 +qmJvm2GQXtfU1CX7qWtbHFofwckXnQs5bw9PMz0w9iLuC5U/326rd/Tbhusbj7Hn8pm
 DD3UnaSef2KVOFEU4zvn44Ew8l/omi1tl3BQxMyoU6v8rcEboYCM1vfifDfgYj+umrh9
 v1SVHCP0IZXYFzn17ZPHYr7cDBI5PIkIo6d4uiQrAvexqdnjVPvJglN2cDC+2yHsKi8e
 R5uBKz9UGINNUkJDixOMkwCWNBn2CQrANQzFik9PE4/iQ77w2cFLPssuyu/bU+pENEnM
 /+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7DqLUhzxZcN58kksvMfeEEY7oTmOuG530RLnJe+RrMA=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=lQi0D7b0o7V8P6nfxchudihHwg1U2zeN6FnK4fC+Hx7xszvnoThMhePeMjaVBZyIVw
 BuuhPJltygKJ4P821FPlfTCTpeVjr804HjjJEZQqLxNFSgdFcb5bRZCO9bwSFEBvu/5/
 YGLtypegEOjiV523sxD4cQOWVrnZfMA2Of4H++ELroDkkFc989kTjHLqioszrwJv/j1a
 hw80J2Ofzu4t1HqoOX33ZLcPxJ58bLx7ucIA/ECUMXGfldZH7PIOKJRiWkArzbmWNB5D
 gmgvlw94YNeLkP+Kb5I/uptDusd96ye8/NZ7i49aDu0RQG3N/awX0HSkBX1v/+5O0WzJ
 puBw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777960348; x=1778565148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7DqLUhzxZcN58kksvMfeEEY7oTmOuG530RLnJe+RrMA=;
 b=CaeUWflNPhP+rkEZS2rXVuEKMsmLMwDDKeyOoxJDLcFBz8Ol7uqlApjItgVXznmFgK
 SeIY7wdzOzyKT/OU2zbjuP/ceKtrFBe22lUlLWBCHsXZixv/VxWjz4NOmeiEpqIuBxNV
 rL3TJXx5w/0ZyRki8FvzRExJSbk50ShTuBgq07lM1Or1/LUZASiw48Q/s55YBt1lruef
 V7mEAHMy4lhRFz5FIykkafXKWGj5lLpFEwPRW/JzgpIaSqVGV3dQjUdDZ2k9Cb4PPuQg
 uOmh7Ct4ThKy8nRYJr32aY84W6O2KmaFP0VEjQ4NdSILIAU8XI4uXYWFIPcz5KiEkAeI
 B2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777960348; x=1778565148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DqLUhzxZcN58kksvMfeEEY7oTmOuG530RLnJe+RrMA=;
 b=D94YSRZltTxN3lzCB48yOf3gP4WscFXDjfyYeju1sSNlA2/2aq0NWwdYl4GhnxYpIX
 j0YHR4jWhMWxw3mS0myuQ338pLLAA1bmcfhYvoOu5qIvDKLvi/lLfygD4HZQEGRr/tw+
 iwLvLTtQghU+AYXlivFXAlz3rGxIxlo0hKlQ+lSIy6ZCVNZq+n0IFdufAphdkeh8jjKr
 yHhfZXzg+59iD8U6yVAtd0cXYd8k1b9WCnMTe8TB6BiR4PahPV1uFZqpMgAs71WScj6X
 M/7iEweBygStuc3+wS7eMjnTkVVZv50BZ7Arl8XPtRhlEOWcMaGdNE2S+8dqTdTmbwas
 u79g==
X-Gm-Message-State: AOJu0YzJ12YwAwrN1DcXuJW0S7xsIUb7qEFMe+WMG9yZ+63e6scKGc4Y
 CDMjfZiyhgnNUr2sSUgKVejc+yRCwS8r7ioTDS4KA9AfLqsyhT12/rvphCy9653r4zg4vA+ipzq
 yR+2dc0b/neMgcwer6dgUU0ZsdST6Bat44PfO5gJ6EA==
X-Gm-Gg: AeBDievz1+XmMSdofa7JC4m2HrCYx8mrFv28JpWI3fxGoD24kydGPpluVO3bUkktfvJ
 JLt7swv5+61WBbkwuFbdWw4jOtZFfgbF0YsfE7JvCLOeczVrKldjlQEGFGx/Db4AQ4vGLPkz7X9
 BQ8XOXyAnWT652+PDh+4Jj3A+zWfubuT9zSbTwsptyJRjjzJ3JBrJbfVlMPEtJcv6lf97OvHcUr
 6YFuaCLSnISM24dLN8RuVGHrz54J77P4QmSV1sB1JLKkDt2nfFWUk6Mr03Nn8LR2gxaWsF8618d
 a7OVTgvrTIj9z5RcEy/+St9zYOC4IIX+xtsXNV5dAybnb0SzW4aqTV4yeNoAVWhvmApW0yPBeUY
 T44yU81bTWDIkXap+7aF4fjldzhUfqq/sBFH4kocwdwQx3hBAv+QnRj66zZUN9CbSxfNluGShEq
 iqjHryh0lC76geAvz7mZ2vgr1Sk5lWo7RfyJXFA7WiMEhAnrZ78IVXnKn7M+cVNpZ0g1FOE74TK
 Td96FcHC7XuoXCn9tApCxfz+WFAt3JA/eszyTEZAKl3AmDe9jaxT5Hxu+DEj0gOB2aN8+Nn0AQ9
 PlFVlDwdf+Cq0NFNOJn0PqQzLWNLJSzVWsEyBSPmLBla3YthU+BG+Nwpzd9+CGNc7RFXHovmkWn
 AlDnaVPN8ScUteX6b
X-Received: by 2002:a05:690e:1303:b0:65c:17fe:6d49 with SMTP id
 956f58d0204a3-65c3dbe3cd9mr12253423d50.61.1777960347783; Mon, 04 May 2026
 22:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-15-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-15-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:51:51 +0300
X-Gm-Features: AVHnY4KusyhSBUFt_IsjSAp_PhdlGGdqW5wxS7NvYM5tTU4NWl32ZVdmzw-W4nI
Message-ID: <CAC_iWj+-_NvMQLPCiYJLEJ6UMwd9QQGsc=jMSgQsVE8M6BGASg@mail.gmail.com>
Subject: Re: [PATCH RFC next 15/18] kbuild: enable -Werror for hostprogs
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> [ Upstream commit 27758d8c2583d10472b745a43ff86fef96c11ef7 ]
>
> Original commit log:
>
>   The hostprog compilers and linkers do not share the regular compiler flags,
>   so they are not affected by CONFIG_WERROR or W=e. As hostprogs are used
>   during the bootstrap of the build, they can't depend on kconfig options.
>
>   Enable -Werror unconditionally.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Doesn't the next patch reverts this? I think you can squash them in a
single patch

Thanks
/Ilias
>  scripts/Makefile.extrawarn | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 29b6aab5f72..8988308cc36 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -109,3 +109,8 @@ KBUILD_LDFLAGS              += --fatal-warnings
>  KBUILD_RUSTFLAGS       += -Dwarnings
>
>  endif
> +
> +# Hostprog flags are used during build bootstrapping and can not rely on CONFIG_ symbols.
> +KBUILD_HOSTCFLAGS      += -Werror
> +KBUILD_HOSTLDFLAGS     += -Wl,--fatal-warnings
> +KBUILD_HOSTRUSTFLAGS   += -Dwarnings
>
> --
> 2.54.0
>
