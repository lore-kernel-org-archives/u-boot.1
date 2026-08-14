Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D155C5B572
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 00:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F31D60B08;
	Sat, 15 Aug 2026 00:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MQCZq0hm2JLg; Sat, 15 Aug 2026 00:52:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D6BB60B0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786755151;
	bh=PHGYUyAGC88W3GLQLOemnHfV3QGWyRGtzuvV0pvVi18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nz9mEg554dBQWD8OQW0Qgc9fJrhb8cfC+EbaV6pMnB/avmoo4P9SrXL9MHTDLP7+X
	 GoF50El7QhN6yCzPcIYBHseeJqiNNpVh/AwynpTaUawL48k2Gb8UVghrLrsnwjZWC/
	 hdgvq1ss3Fl2s5S4o0d2GBF9nMc/xZXT4wp9IOAwuPafVa9OGYJKsM4Gx8oDzV/Ikt
	 om7eMeoetepoXqpFIZqBhqbSHzWP/e4XSj+t8deG0I+f5A9PIYpkvJ5w5MwjwfsO5R
	 34xcxrAn4qvp2OVxXmC4RubMf/LEcLPVOmZidJqu/ZiTZgGlP3ixw0q1tJUDi2IkmF
	 EKIphmvZkNWGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D6BB60B0A;
	Sat, 15 Aug 2026 00:52:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F49B139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D5AA40064
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:28:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVO1wT1O5Zzb for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:28:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 268B7409BD
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 268B7409BD
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MRTusxOd
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 268B7409BD
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:28:19 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69fc9f25118so1518710a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786746498; cv=none;
 d=google.com; s=arc-20260327;
 b=MEbJX1XqLDdinkzF3xUafzMG8tBvhvviC1CefGOPJgD5gCkvDdp5mITAwLeAKBWdQW
 DZ7HuG80BscUwq72LMpp22xRkBsViA+0DxHXOjl4bhjFTiS1gvMHHRwDT/Nj/03ocLqe
 o/FrtSAgUtGAFaZEpFLCyMjfuPgs2P0aAurIeTb25VCwaBzJL1P1qpyfi2ZttyVLmTtx
 uDI2FxV/9tWH1eFckb2VXJX9RE6oDphMKLtNp+GbsYDtmOqH/NedNivlnV27oFpKekYn
 aZU62E3Gn7LrxFOJcrvQCOLxzDw2cggmLElfqVLhe5BW6ccn22RH8fO7qtfv2tPzYjdr
 /uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PHGYUyAGC88W3GLQLOemnHfV3QGWyRGtzuvV0pvVi18=;
 fh=sZTFMmHQqEzDe+GwhMR0p9sJrgxYtASACbxdOnSFNaE=;
 b=En9Vv3X9gpYNTYWXNO7latkK458cdg+BQy61qBAlnkKVYrUZ6bNaKp95TlNFKrg5e4
 5HVb+okUnnypyFO/LdoHKdOjjyr5T9Tu1GpEr1simnhwGeVHdj7kbMntYZFH4NH0lOYI
 qubpqQ6h+KD/UlB/Vr9Rz17ggFr91EzFvDDZtWLOm6UX1rjW4O1KMacR9dBLrVX7K6Ba
 TXZYyj3DwcPb0nWTQ8wLEja9UMMdiWulfqzIDYUwyi62HYPiaJ5l0e0Bx0F3SvTiP0Se
 QNaD4U1vCghCSfevHhFwePJWD7tIrPmQghuYGErpRRoKyPNePq1LuvLp6Jj7Z+E1+9vw
 L6iQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786746498; x=1787351298;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PHGYUyAGC88W3GLQLOemnHfV3QGWyRGtzuvV0pvVi18=;
 b=MRTusxOd8flT6yLuLctmo/bdgE7/oBoXU5fXp6IXktuKMp15YtGx+hjP9WYE+9CJwZ
 fCnIw6A9Mx4GhV60s5Xzokx0S7T91A1x7RJez4k41eK+sZJ9uorH1W03OdXA42cfdgie
 GmoZnhwVTQULRjkKW3F1ZjGMO2AUn/Uzlskvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786746498; x=1787351298;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PHGYUyAGC88W3GLQLOemnHfV3QGWyRGtzuvV0pvVi18=;
 b=n8PqJp4eCR1YCDYl9Yn+gW8/afpSUBLA9ZFH8InIAtH4OIsWagqEpIAyQLcScHeKKI
 dAL8q+G53CHSTaFPnGF16/EE9iKFCk9nIIaPiUhxauTUOmD4i5H2kYSnDZKMmW+2bD0C
 TovLvzOAvBMawTV1UDTTzL2yF9JmO3VvrHRgQdmKAKGBQ2DpwBYzJLczYaSnqPzPS4M1
 npk5sk/zIDu7Yw3mck667XmWQ/nKSKoLQfY8CJK0W0KrVrd4SxY3szoKEBPeMIJ0jSgl
 GvI7q+A+H/7/fva9T/A8dFyH2Hk/xoDSVAb0iaVvznhKaR2EEcm0sj1nVIvrIvoK+eWo
 sFUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RonT7yYGeGmev9uuT7tjwkup9IErikEZOgDJ4ETEBa3C15dzqIhftFIhmSLBhfQ6NqoRk9ITvk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzLWa3EORMMlIKjyzOTqf7tTsCDDpwTShOzufOAqTwAp+oVNo0a
 NMQB0am2aD1ZYNerfycjEN3fnzYJpSaFWgfFr7tZA+rPO61TR4VByY8D+GN3EiaxhR9qlJxs6bY
 blNJM6dLz94zhpnAYTDn9ZM4WiLz6ZKGUyuxPF0Of
X-Gm-Gg: AR+sD11lMgbV1PlqnYfDT4bXw5omFP/x7uoxtRZMttpR+ZrBRSi9A+8PLZmVGqcTGKQ
 FN0D7m54Hxr3Q1hWxjpUAVJYFJhd2OTVdc56jZFirJETwtVGzwkafPOTMbvy3jAfrIoU4P/ViOu
 M4KtwG0I4ZuGcleaoTD+JC0aORwBNyglap/8JRnDnZtJEK2tIEn4p1HDF9HQkor57o6LtabtpKG
 y4f+mRdmDSySblMaJ7ziBo0I9HfUZCpYN69t7vJ4SMwMNceZD3j1f0sDGNBiLrGTcr0Y6aJ257p
 +quCeyGQrwLJPe042+7nHe2mMospA919M0aL8McPFtg=
X-Received: by 2002:a17:906:eec5:b0:c1c:4895:c3ba with SMTP id
 a640c23a62f3a-c212a23746cmr412377766b.22.1786746497970; Fri, 14 Aug 2026
 15:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
 <20260813-submit-ce-series-v2-v7-5-593fcd8479fd@gmail.com>
In-Reply-To: <20260813-submit-ce-series-v2-v7-5-593fcd8479fd@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 16:28:06 -0600
X-Gm-Features: AcwNN1XtDzchISxPzmZL5sLqtp8gXedNe0-13GfA7PO7M7xyRr46-Ve7uDqwdGA
Message-ID: <CAFLszTjSa7bsQ2LNEgb1-za1LdOPs=TQ5R4jfyjJzX49auVCvw@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] lib: rsa: internalize PKCS#1 DigestInfo prefixes
To: james.hilliard1@gmail.com
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.u-boot-project.org, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>,
 Peng Fan <peng.fan@nxp.com>, 
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
 Vincent Jardin <vjardin@free.fr>, Raymond Mao <raymondmaoca@gmail.com>,
 Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:52:29 +0000
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

On 2026-08-13T19:58:53, James Hilliard <james.hilliard1@gmail.com> wrote:
> lib: rsa: internalize PKCS#1 DigestInfo prefixes
>
> The checksum algorithm table is shared by RSA and ECDSA, but its DER
> prefix fields are used only by RSA PKCS#1 v1.5 padding verification.
> Keeping those prefixes in the software hash implementations also ties
> signature metadata to a particular hash backend and duplicates it between
> the legacy and MbedTLS shims.
>
> Keep the SHA-1, SHA-256, SHA-384 and SHA-512 DigestInfo prefixes in the RSA
> verifier instead. Select the prefix by checksum name when checking PKCS#1
> v1.5 padding, include every algorithm in host tools and only configured
> algorithms in target builds, and reject padding which is too short for the
> required eight-byte padding string.
>
> Remove the DER fields from the generic checksum descriptor and remove the
> now-unneeded constants from the hash implementations. ECDSA-only and
> hardware-hash-only builds then carry no RSA-specific DigestInfo data.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> boot/image-sig.c        |  8 ------
>  include/image.h         |  2 --
>  include/u-boot/sha1.h   |  3 ---
>  include/u-boot/sha256.h |  3 ---
>  include/u-boot/sha512.h |  6 -----
>  lib/mbedtls/sha1.c      |  5 ----
>  lib/mbedtls/sha256.c    |  6 -----
>  lib/mbedtls/sha512.c    | 12 ---------
>  lib/rsa/rsa-verify.c    | 67 ++++++++++++++++++++++++++++++++++++++++++++++---
>  lib/sha1.c              |  5 ----
>  lib/sha256.c            |  6 -----
>  lib/sha512.c            | 12 ---------
>  tools/image-sig-host.c  |  8 ------
>  13 files changed, 63 insertions(+), 80 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
