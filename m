Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F77C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425D684A6F;
	Fri,  3 Jul 2026 14:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PL+vUxjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C8B2846A4; Fri,  3 Jul 2026 10:39:32 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51331843B6
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 10:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-37dedd62b90so346086a91.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 01:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783067969; cv=none;
 d=google.com; s=arc-20260327;
 b=Ew0kJfTNt1kuDDF07WCFKiiEORVdkScu396HGmAiidrYZ4r1ejLabPQ4O/y/3yvyE7
 moXGf3QifhM26Y1pnoYIslHfIro+jnDgI6dQIOZlVtiUSmT9+/Z0wMTJagDNZnynVEUn
 amgep7/wRag8GZNOKCkYKvhWo/eH8P+DifQiDtqWuf6v3XOw88UFass5VtQ0arTGywAr
 iQ9rMbe1ShHD9oyUFYdoTctlAu3PPcZpJtWSnFqmh3skAEoUOzFLPF6tv5nqzdfRPPha
 Tw/RqxLqe+9fob+uiBUffmfjfHApEYobM7xhQ6LV4kA7BPSxhLV/1JjB62WS3TVVvzZH
 oqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AwOYeNvE4xaiJeVXUjRGlQ++erBgzXf4kIVf+fFXmr8=;
 fh=S18x7IG71hAHdEr7O6mO7gI3Em3dQ/vjpvhEHvLFdBQ=;
 b=cthSaWcxBFxJRQo4+Q/BHJT7MhAgrQI9OTWGBpEc4lAEW647GSwUU92SFrdd7MUj5f
 YWi+cifSjdy9DO4w3yWqPmmVGH51sBMYuP3PcUSgUO3K99AUK3FVEHSno6AGtPhsxl0K
 HqM5owARzsJbzsIRT2jhzYcPw+3PQtGN53zrx32egxWKtyeE9NHJzPY++UMLTZj3S/NR
 9zMlGpN14i3nH3X2WlDNx6Eru1ekDSEMW68/4me6clsZlYqBLWK/qT0/qG6J+5AVhNkj
 mty2DsOpIg5ZCaS/frjG/Qxt5n9Gtt3u1GnXbtNR2BHAFhj1vmL7GFMU4i22R9aIBtB6
 XsRw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783067969; x=1783672769; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwOYeNvE4xaiJeVXUjRGlQ++erBgzXf4kIVf+fFXmr8=;
 b=PL+vUxjnE7CzynWOGu4uMbCV3BRaCNNFeDgUOn7eICl1EDnqNfrqpEzO3nVFkbh//i
 yNQB11ha/ydAo4mWwvS86YQX/5UEFJ2/NlYGEDSju3VrycVs2cHhY+AHyX2eXIZamKfM
 CDuazoUA1tKSDOY7lRgk7PjQHlhOVbhFQu830ffr3s3geh+W+lUyFZnMQZkGoWu/iMQc
 VAGtiOJt6qC/QMxh4F26JE4FPimEEDWwl7fBzTVlmyp4ly1FeHq7uihFJuj4Uvw4m1pn
 jr4dlttWnjg4Z9x4U9oPjLViRo7SPVsEvWFCei++ZIgERdSiCOlKO1ecuzrwWj4rbyWu
 T2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783067969; x=1783672769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AwOYeNvE4xaiJeVXUjRGlQ++erBgzXf4kIVf+fFXmr8=;
 b=Zh71mgPTCjz3rL1bqgXWOTFjKlNeH/l0aAMao62ACBHhPNpwEDM8a6tYLWKGevwX37
 mgq7mwnVt/saXhGcFh3wlD2p1+sptm2dmYXrNEGdiNV1Oqsme0/fqy2RFrIlPTuTigzA
 wBhKFOjTLkjs9hbY9ULNItQCm1+NdrULFDt1KKydPNAI8PkP1u/TeFtHuR7xR9Fstwf/
 6w6c+vVJeDdz74smIpnclymmir51DryCs7JU12MM/RXeeW8/QjRjOarLtESC3yWhGWle
 LqWCBXBr/1P2Ax2Og55HBDS4Q9jzW7zd4AmFDLVHRfjFul2hsS1g7ABIbD7B3ytgHqDV
 E2LA==
X-Gm-Message-State: AOJu0Yw7M4uH7nULatzgw9fxhP7F3JYJRAEFK2rEb4kqw/hg8pTwFJtb
 A9rdu37kH7uRJrudVgfRFl4ZV8QT4thaTUIroAGMwGfj87sJQTbds4tsk4l9LJG2gfnjv41CAH6
 jd39r7/0T36FBIbhw+Ok28nCRxgejPPw=
X-Gm-Gg: AfdE7ck8PFMsXhs5ig64Id9vZhB3QnIJ+q7GyJMVu1HmzsPOFLYo+8kcU/jhVFakLnp
 7koGiaBqXS9U6N9MSEo8hdQvzotB29kvydKsAAenIgG2G3j5J9Nf2nGI698Za0Ct4LtUpxTCNo9
 1Q0fnjQNx96ndedMGCpPaoJEP/GEJ30DKDSE8xd2qa6Fif5sRfuPT59wszFulWv8Xb2dMggEZfA
 lJ7Wwf/OTn2cO2cDhzI4wd9tzTcP6TW2Vc5GJf2woqWxvqm3VjDE6yYHG76jDWBR7xACxXoD6kB
 PXw7dYOXczfkc15PI0ZyT/q8Ba8WoA==
X-Received: by 2002:a17:90a:fc50:b0:37e:cb9:fd7d with SMTP id
 98e67ed59e1d1-38112382d3cmr3678969a91.17.1783067968492; Fri, 03 Jul 2026
 01:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
 <20260702-submit-ce-series-v2-v2-1-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-1-ffda5bed58af@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 3 Jul 2026 11:39:16 +0300
X-Gm-Features: AVVi8CdRHd2g6wFqrvHq0-ghjluCKDCIrWqXoweJWGmnC2pyNw8ntKPZYsbG-0U
Message-ID: <CAPVz0n0+BuzFyvmx+OH4yo-UT6HeKOwQ5pDGOqV3x0qVq1=qCw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] cmd: aes: fix DM operation handling
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.denx.de, Ion Agorria <ion@agorria.com>,
 Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Michael Walle <mwalle@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 03 Jul 2026 14:59:42 +0200
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

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 04:49 James=
 Hilliard <james.hilliard1@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The DM AES command path takes operation-specific arguments after the
> common arguments. argv[1] holds the mode, "ecb" or "cbc", while argv[2]
> holds the requested operation, "enc" or "dec".
>
> The DM path checked argv[1] for the operation, so the ecb and cbc
> commands always returned CMD_RET_USAGE before running. Parse argv[2]
> instead.
>
> Fixes: b01444aa14cf ("cmd: aes: Add support for DM AES drivers")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>   - Limit the patch to the argv parsing fix  (suggested by Simon Glass)
>   - State that the commands always returned usage  (suggested by Simon Gl=
ass)
>   - Add a Fixes tag  (suggested by Simon Glass)
> ---
>  cmd/aes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Good catch!

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
