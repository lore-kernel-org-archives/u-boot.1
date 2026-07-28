Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C7CC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6159160AE8;
	Wed, 29 Jul 2026 04:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTsxY_c7Hb1r; Wed, 29 Jul 2026 04:56:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 563E860AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300962;
	bh=+5osCy8mHKFNuthSGdIcKS1poyDUcC+XQ9o1KgDXif0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U6T+r+MYZm6B3oiAGAVTnGi9IgovHizGq985j9x8o37dgfMLvEY644UkWr4/xcobU
	 umPK30icVM8Ljwh/HaOvysaiFTg9PmajvIdUZ703icjTo568EFe20oKdQ7O7+Pah8h
	 sq3R13BDUKUQBfNnZEqUEFJ4redKSt2/Lh/XTvwDF/NL3huwfrPk/aDIv2GRwKOEfI
	 WCbsnL89TopseHlvZWpMXkcGfMw3Xbsxlif6S6ReA4/7vPjn+VOgqO/dc9DSs5vdsS
	 pEOwYDgzKZaRAJlwrwbimOTz/RIJ0RNVqvMOKWWA+C9QzdLAm1U/jGgn+Ru81BkW4N
	 LNrFdGvQy3h/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 563E860AD9;
	Wed, 29 Jul 2026 04:56:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E486D45B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAD1740176
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IIRdInUtx6-N for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 19:42:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1B74F40097
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B74F40097
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B74F40097
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:42:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FEE8494B; Tue, 28 Jul 2026 21:42:06 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE248404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 21:42:04 +0200 (CEST)
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-7473e927969so48207137.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 12:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785267723; cv=none;
 d=google.com; s=arc-20260327;
 b=P4Vvqo+KVcVmYRJGksx5VVkVmFN8fnjFZFg01DzTjiaI+1v/BXqjno7aXdwuXYoHgH
 LLruZUPUfcNruNK41WrG2PyU7dPihULRg+Mqhje3/GUsVET+yWeg9HepRK41SZKUfXv2
 dsRfrLFhEaR52Tyvei5WJmKzWmvEzjgaClBo4FFGaxH3EcG2MHINqIQViTFy4sE59nnl
 DI2qF878dO5N+BXX15qCwlsaj7EVsKwiIeac/8XoleNATzSTXq2oHPT0/mM0uv8n1GBV
 oXXZBui1KYSWWz7/e/iK/wEWQJ7Igfl6t4xOkNq+Hc3ONskTqcIdbY4suYF6Ww1Ai4DH
 LXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+5osCy8mHKFNuthSGdIcKS1poyDUcC+XQ9o1KgDXif0=;
 fh=HegYvWOFwSt7TqfQpe+dNywifJJIyXP5OLVa/dOO3KM=;
 b=L6yP+NiaPm+uxPG6RcSJitFL8575WEFlgSKvzmxFwzKaskzvRV6AEdAg5GioDBbW5X
 ywwbhLpC9OOiFi9iHAz/KN7p/e2DrfibEeaoIBFS58lDvNxYitLh37XYbcCw5BVPb6wd
 ehcm24c0Kd4h2ZRh/nB2ScZN5uqhFfTpsPEbX91dOBATbUivdfXAde371hU8x/1wWFS8
 UVApAeKDWMrU62ZH1y3DD/cZtRPO47En9OW3szd+WGebXagfftZPxb+5FbHT4lHb0qeL
 7501bKFbL/map7RqJz7n9jOwLniwpiJxVWzVVQpw84fx3HJ9FIqrxhA3An5ghWHgprnd
 oYqw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785267723; x=1785872523;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+5osCy8mHKFNuthSGdIcKS1poyDUcC+XQ9o1KgDXif0=;
 b=cB2JYnjZ7kSWEeM5IL1s7LF4cVSvOsAG8su5uzGn79jj5JjE+PgZrx9niir+P4dWGF
 +KoG1b3a+pQJZ58+AVyFFnMB4jLQ+cmlgj2h0Y4YzgT1I1CvvvKRq+0d+hemrsveESbq
 fj3a/3tK4tFHEcPgqEj+xoRljKegoNl9bw0CMRJ7hnpCKlynvPEGNT/PbQG7wY2QfmRc
 Rcurq4fp0eHSHATg5pLfhW6SOxqnGJgk+dehGQojeCffDZnUSiw66swe1XdHr0cwRbZJ
 QVfvwvF4IPLsS9ftP1KB8i066xHI7X8FOVd/9jtdY9kKO2yOycH21OSpid/Jy3MAliCb
 kzzg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8WfcqMPVLTbF0YZU0ywEZ5fuLd0vRrnveIcqItY53UGATJee6BHZcY2tA+I+QbsgSBSOJMSw=@lists.denx.de
X-Gm-Message-State: AOJu0YwE2Wuq7t+aytgVGxeHxjBtuzDfzpesA+haHblC90MeAKOa0h7Y
 JKydy31GTFpUFsYlS4hj98gMv+WXrlYfo1y7G+jgTVYIM2oOcKa3UE5tWcNp9a6V/dvwxRlBzfg
 ABnatFHvEZapKxeIqfqPpdrSzC4P73SY=
X-Gm-Gg: AR+sD117lmoQxHrJaWWkOHJs+Y62g/wQJ3ELzfzkF0qpgKQq9tMv1JjofHiFbH5veD0
 AXq/Jnhl2wxDIISQHROJugVzs9VBtMoBHPDnQl4A+PtcEAT8pHbr0kouui75F7hk5enQ3KEKUeH
 2/Yu84oDdr5RUnD+EXQ+YMjqlgqIGAZutdQ9tBvxYLS9eEMsppl/RMY/uLmzHp9bAqd5t43EF1t
 mwJnIPgbTd+gNB52vOGbN36FcNo//lq/OKyTHqcub4KMjrii+oCrpxVg/cjJys0gqbE/7LfjuzE
 8Ql5kk8YYKmCcAtgPTbyftDTr5VTO1l2MFcm9PF9Ut98bvpOpe2cbIQO54kLYL9FUz04zDyRvP7
 MIg==
X-Received: by 2002:a05:6102:3e87:b0:631:26f6:701a with SMTP id
 ada2fe7eead31-754a29cc282mr1972104137.29.1785267722783; Tue, 28 Jul 2026
 12:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-2-3c41f66d4522@gmail.com>
 <20260720232409.GN749385@bill-the-cat>
In-Reply-To: <20260720232409.GN749385@bill-the-cat>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 28 Jul 2026 15:41:50 -0400
X-Gm-Features: AUfX_mz1SvwFHASgXMF0FsRLcb2jPUPbswnVvFC_ui4chjAMd57D8GbQTUPgdR4
Message-ID: <CADvTj4o6kmshf4OEMUpon_BxbssViL6xzHDo_cin6QM17q76yQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] crypto: hash: use DM providers from hash command
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785267723; x=1785872523; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+5osCy8mHKFNuthSGdIcKS1poyDUcC+XQ9o1KgDXif0=;
 b=MSael+uq8kpEdrTF3JSza/gmEnRmsaYktakgJs9Nc+AfBlS17zihXVDIxfHXL2eLog
 Ddm2PRjoExuxumsGDwFrPMJVTdq1mI4el5tL+fzpM4MS3aySbOmDXKJy72wgoay3wOVe
 Nf4b1EJCvHpVYQ/jDwwhxyKgSTZxpJ6eLjVcJ4lPssc+8wBRkaD9aH2ReanIqMFZs257
 ZBXvNCO5p31MpWBrJcuRkQodTNMnH7A/4sKn1AMi3pv5ieXDUq09/2SzmPaN9o0d6ykY
 H/iWLqpuWe+m1MCAhWSqg4fcxtl3e7Bp4wYZ4LxF27HIYYNGa2aOI2EvepplJKpXKaTe
 tIJw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MSael+uq
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=james.hilliard1@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MSael+uq"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 20, 2026 at 7:24=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Jul 19, 2026 at 10:13:46PM -0600, James Hilliard wrote:
> > The hash command currently always uses the software implementation for
> > the selected algorithm, even when driver-model hash providers are
> > available.
> >
> > Add a hash_digest_wd_lookup() helper which probes UCLASS_HASH devices i=
n
> > order and uses the first provider supporting the requested algorithm.
> > Continue past unavailable providers and unsupported operations, but
> > propagate a hard digest failure once a provider accepts the operation.
> > Remember probe failures so they are not silently hidden by software
> > fallback when no later provider succeeds.
> >
> > Use the helper from the hash command and retain its software fallback
> > when no usable provider is present. Add sandbox tests covering provider
> > fallback and hard-error propagation.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v3 -> v4:
> >   - New patch
> >   - Try all registered hash providers instead of only device zero
> >   - Add provider-selection and error-propagation tests
> >   - Reserve -EINVAL for hard errors
> >   - Use -EOPNOTSUPP for unsupported algorithms
>
> Putting new features in an unrelated patch series makes things harder to
> merge. I don't know that Andre will be comfortable taking some generic
> changes + sunxi support, but he might be. But it's even easier when
> something like this is standalone and can be reviewed and picked up on
> its own (I'm going to have some size questions about this, once I review
> it globally..).

Maybe it makes sense to merge all my patches prior to the sunxi specific
ones first? That way I can rebase my series and shrink the patchset
substantially for the remaining sunxi ce driver patches for Andre.
