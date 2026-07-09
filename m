Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A0CC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A7284A29;
	Thu,  9 Jul 2026 03:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fc0EysCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6330684A51; Thu,  9 Jul 2026 03:23:32 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F07CF84A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so539044a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783560208; cv=none;
 d=google.com; s=arc-20260327;
 b=C9WHZcrNIJY1VftcRn+pXuWYwcqQBN6z8YJKlnSM9pbnfbJI3Qmf0ji4eIUhFjm9Ss
 sTfE4NsfmG2nThiigEII2+Ne9j9xkqeakYlYG9nO+ayMDpV2GcLcoLSuElm3Cyzt3XIo
 1YJAd8VzoVzQfO8mcJDygWV2GVI3FSn1CVoM0Q6WxIlt9G5eF7loaMatqXT7XlxKlfII
 iZQX6ne+jK4NSIUjNtshF7/AxvOf+/YXKX+2A0kQosBvYh2f1FRqVrkIf8jdw+LazAVF
 BrWqwkBZlN8BQMQ6XLk6SpmqlNFo344evT6LFQzQykFdrH7/EHCRHDFTdDIlAknLAR4w
 TsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hvQkScZ8cn5V2YCvtEEktLwdJYjUdStAsVb9Av7tdKo=;
 fh=NJvti96iWr1RedAx5v2nMvfBUKn0yf6cwr/0thOFQRA=;
 b=O58Xh7zIuK5Y8VdbI23orJq6n1uSilvkYyZsk+IWp4i8xeB5tEmxHXy/nVzRvoe+Wh
 +YBx+TtXDThbVXK2smGo+ugoSWpOGzHjzAP9LX2yKdXEOQZBLKPVYQg4ZJNuNoQFBV7J
 L373415zw+8qbH9QqIyId35aYF8xeqdEuO6JtywLSIKYaaLD2jbmxx9HLJs55+JrKqiy
 SPYgIZkcDzraEedPqBxa6aMSQJHhCnj5mXO/E14QQDiB6REQmBkNUdzDEItai1OvaaUM
 RHHhADMuXlIaG3Mov/Tt0unLVIo/deIKTicB0ZieibQbi9k4XgtsgVf5f9bww4mXpUG6
 /S4Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783560208; x=1784165008; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hvQkScZ8cn5V2YCvtEEktLwdJYjUdStAsVb9Av7tdKo=;
 b=fc0EysCLkY4H05HWxxUsn3VrgGFfAcCkKeI2sv1HO4R9pYnZ7n4oObTAmvgHHL7AYy
 dPAxdBWMaTKiD1iqEo/WgxkkF/nAnVQgvV+E7dRuBL0j+GOr7W6DORM8H5lM8cVPLe9h
 1czNKVb8fp6Cc2UdZLJlnNu1DCo11Xwa1MimQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783560208; x=1784165008;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hvQkScZ8cn5V2YCvtEEktLwdJYjUdStAsVb9Av7tdKo=;
 b=gPuGuw+rwk5qkMzhP9N/m5MQHp+oJVnFPxzb6DAXd9phg33PPkrIx9JZPWlV5NcU6A
 3fzf8pWuM7iYUDuFPXgrGQqOKdGTEYVsRJkFlgFr35bWBxrJtKqKbn3gMgXh3nDuCIot
 v575ubrQz1qIkiGmvI4MOuez+DOtXwOexCPInMRgHhar0qUxpZVYDcM6qDMdK8he9h6u
 B4Hhx81Pgmdb68PT+szUagEg6dxYKDpXSDv7c3qIFglGsG8RQTFmupvlX7nn2rPM0+WW
 X+aNx0kV2VvbBK0elefhBZzJKjlsn1Q5syRsRnuUGKUKHtCkdFFFgURmyUguIWF0RAIp
 t7lA==
X-Gm-Message-State: AOJu0YxaXcn+Gz44LCwYwTvHl39XxG0bsov4zs4I5imEcEvMfshwOthT
 5x6iHPX1C2AB3BqYQGHw2k23jiUeAW1QRCU8+LBdvefWGE+BYqgljFM6ipuDKC2cQcmLL8H1t+h
 2DvBRcg5Of6wyLL0MOdOUTCFPUxx9xWQazVqDxDTp
X-Gm-Gg: AfdE7cl2pxILDNNVQrVWaEM59fKzcZfjm2JMhbqI5DVBvBgvAsbI991Mp24R4ioVrur
 g82hEAoWWwAcQO2F3tBb1pA+W82XxkznI04O1rKNvY470+ElF7QAMGcOPx/UDtwacIOJa4oLIHi
 CR/sQnfULyfBqx33pH7bobAwhP48YpEJR4nDJKt/BX6tUGwoaldTkTViL6kuUyURItcLV6i7mMk
 S5ZJ/yoSrNh5UiBzpBOi2OXFAC8HpQ7mBBTLQQl+ywJZeyhlvhCUNYXQZZn1FGWKy8sxMk=
X-Received: by 2002:a05:6402:234e:b0:69a:9c4a:3d63 with SMTP id
 4fb4d7f45d1cf-69ab4469a96mr1947534a12.17.1783560208433; Wed, 08 Jul 2026
 18:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260703213308.3804461-1-james.hilliard1@gmail.com>
In-Reply-To: <20260703213308.3804461-1-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jul 2026 19:23:16 -0600
X-Gm-Features: AVVi8CdsUSggB4L5Li-VpypgpF53kHVfR7l_-7TJRbo_BlQP3IYjYT7TSxYkv8s
Message-ID: <CAFLszTgZbTwszEkEQ8tz0CPbBBpAjvc3-iM4Pwc4gQZOKJXjHA@mail.gmail.com>
Subject: Re: [PATCH] tools: binman: add build key directory option
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Chukun Pan <amadeus@jmu.edu.cn>, 
 Yannic Moog <y.moog@phytec.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>
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

Hi James,

On 2026-07-03T21:33:03, James Hilliard <james.hilliard1@gmail.com> wrote:
> tools: binman: add build key directory option
>
> U-Boot's Makefile passes KEYDIR to direct mkimage invocations, but
> internal binman builds only received the generic BINMAN_INDIRS search
> path. FIT entries with fit,sign or fit,encrypt therefore had to infer
> the key directory from include directories before invoking mkimage -k.
>
> Add a binman build -k/--keydir option and pass KEYDIR through with
> that option from the top-level Makefile. FIT entries prefer this key
> directory over include-dir discovery and then pass it to mkimage -k.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> Makefile                  |  1 +
>  tools/binman/binman.rst   | 10 +++++++++-
>  tools/binman/cmdline.py   |  2 ++
>  tools/binman/control.py   |  1 +
>  tools/binman/etype/fit.py | 24 +++++++++++++---------
>  tools/binman/ftest.py     | 51 ++++++++++++++++++++++++++++++++++++++++++++---
>  tools/binman/state.py     | 21 +++++++++++++++++++
>  7 files changed, 97 insertions(+), 13 deletions(-)

> diff --git a/tools/binman/state.py b/tools/binman/state.py
> @@ -41,6 +41,9 @@ fdt_path_prefix = ''
>  # Arguments passed to binman to provide arguments to entries
>  entry_args = {}
>
> +# Directory containing keys for FIT signing/encryption
> +keydir = None
> +

Please use the existing EntryArg mechanism instead (see
etype/vblock.py and etype/gbb.py). Then cmdline.py, control.py and
state.py need no changes - fit.py declares EntryArg('keydir', str) and
reads it, and the Makefile passes '-a keydir=$(KEYDIR)' alongside the
other -a args. That matches how atf-bl31-path, tee-os-path, of-list
etc. are handled.

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -500,6 +505,7 @@ class Entry_fit(Entry_section):
>          self._fit_list_prop = None
>          self._fit_default_dt = None
>          self._priv_entries = {}
> +        self._keydir = state.GetKeydir()

Reading global state in __init__ makes this harder to test and couples
the entry to a module-level variable. If EntryArg is not used, please
fetch it lazily in ObtainContents() next to the existing engine/keydir
logic.

> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> @@ -2161,6 +2164,11 @@ BINMAN_INDIRS
>
> +KEYDIR
> +    Sets the key directory passed to FIT entries by adding a -k argument.
> +    FIT entries use this directory for mkimage's -k argument when fit,sign
> +    or fit,encrypt is enabled.
> +

This section is for binman env vars, but KEYDIR is a make variable the
Makefile forwards. Please clarify, or drop this hunk if EntryArg is
used.

Regards,
Simon
