Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFD3C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0ABDE608C4;
	Tue, 28 Jul 2026 13:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N18kVthLnpvm; Tue, 28 Jul 2026 13:00:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E43AF608D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243625;
	bh=YgL19BY+JMLrLyhmt8noz1fypa038LWGNp72P2x8XmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=myEv6Ht1D9nB8VxUQSm0BEhRIiun97N6GM6aOzJTIsP6Yfli9svHWNh3S9g9OZ0k1
	 NOA/w9ufIPHUXyy5q2EyYNTERltSIO2jysFSxHJizxQohB0WYYrgi9UZavibs6sFQF
	 q9X6lRkwQJFxpyX6QCAsmjU7Ta+3GF0Hb9LqsKRRulMvhBI/1nZjJZY7T/PVG3q36E
	 ElkDei4Ns7PMMqw7eE9S08g9H2SNkrcZaqHx4V/p5RsbysZkQXyIIZH5JF9RQyBSu4
	 btLZgZ8VWzb8YAU3K2by0TvEpQiwU4WuEix80TdmiJjXJmWLsbPee2Mb4GGJViRRlO
	 25gkOmAZA1MHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E43AF608D1;
	Tue, 28 Jul 2026 13:00:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D40AE350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA9CC607D0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vHUgLqjdKl6F for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:23:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B36D06077A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B36D06077A
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B36D06077A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:23:04 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so5539688a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237782; cv=none;
 d=google.com; s=arc-20260327;
 b=SsrvT3myUoCQH0WAia6DrUhq12tx1+wtwmjr3F7WcwlsR9FI8YMJEiCMRXaYBqUxr/
 +y1u1eeuVrqzIfVthDY7p5s5hoeM68l+dqf2+inn94ma37ZInHXbbROvUiconFuqXPWu
 rguvyirDN/6uAFsPJR1dm2eGzajIAAeXKxorMTgUK//HnpMz5yZYDcfT3yNLhHr/3Gji
 maklHsvEJpIMiVjINHk/NpSZ+tLuLAD//CZOkZWSjJXHqSoOC6znJeagoRm3BC8zva4F
 9XARnd1ONNR3K077oDZJdGEJLHGppKqAYc+WlvqOkbj5jeE5j/8QraRn1Dn00oMks5OT
 Hmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YgL19BY+JMLrLyhmt8noz1fypa038LWGNp72P2x8XmI=;
 fh=PufDzExcHMp7iZyiCsPJI+HChZUSXyUTs4jQJUJaf7s=;
 b=C8kcfV45fnCTgaNSrViMWvsM0c75PmV7VtYrAW+boZawPaBtRPfsGhzPl24hcgIJWl
 YHFfLwLoF8hkGTyCGe6C5GVLKsGHktqmJ8cgqsBngJwCly8HWmjjS12XgLNdFhvy1ODg
 8xeZLehQe0fbz8iycAKMd/SDwZCCxfzcbkT5twgM0B6ci1Ljx11oLN2iI+eaiceayBHe
 urKfj9f3b8OLW6LylyodG8aP5ocHKrdi+TQrO7yLJ0uTjPGxfmVGL60Mf1UiUYoj8v9J
 QsXauDoDP9+0VIwVGZ3ng6LtJeJgBVDrHdmsdLaQWjgVeMS8LgSEaSzgBc71KYpGEKD5
 3sMg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237782; x=1785842582;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YgL19BY+JMLrLyhmt8noz1fypa038LWGNp72P2x8XmI=;
 b=DzIbKXp8KvsnrUYRoUkmRIO6OkguY4hHk8eyrGzWmvigyclFA9j0PW6o0NLfkweRzr
 vbfrCds80DaQapTHYp8TY0sKwBA3FR9YFqLqomPwUCrjZMSzoiyf8hiGgM3SuyYwEfAg
 8OhBXO8Dkj9ThoAU5JsmidM0rbUoPLmxsafsNTa50VBNXOQKnnJzWMVXPHk+N3tP08hX
 UZ2Q8pyh3PRBwF8QgL8rzYEbA8tEMv/oErZF428gFGn3QmfZTJhY78jYTUKW3rn80N+S
 io/7URqT2+7Sa6stCerfTQ/f540n00/Y+yw9+s57cXwPeCD5981+E/HOuK0NvNSkmPW+
 M8rQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/iwXu1G97fkrYWi162n6dMthiIoMoMZYNB30saUbyGbU2p8EcpIL+mtEjami18KuphPZkC1c=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwRw3HrKLdih23jYa5mTiLAAeRGvU0ypivxEAZ8TlfAoVylnuGa
 4lq5OElK8KKj8e9jckrsxNzYoWcbzI1mJyyTocmn4FmRSVdzDWmvwqa5pQDTNV6D2Qz8D4VV+6A
 YgYqGJKDqUB/H4zgyzgVXQv6UPZe1kyeNvRjpMmCI
X-Gm-Gg: AR+sD12dt1f6vsItoJWCqxPUUEHYnN2F+WlFJevbfpQhwSXbVAPh2t+4tc1oOCE9+zN
 A7cORA96u6vRau58FB+KEOmudp9Mqa8tiZRFzkB8y2kR4G0NEItsNGLHAvcoDmT/6Ufk/seRW/G
 lDNxbOe9xnRlXkfple9KlG32sWOxA4DhkDaJjMFL7X7nqYwvZM5cQOspWBeD47EWdOjQvyzKQzp
 SJF3uFZVL+K2kbYnFVWqXyvEuDqhdReucjYlOm5W77tFs4jJu75pso7LWa1
X-Received: by 2002:a05:6402:159b:b0:69f:4b45:924 with SMTP id
 4fb4d7f45d1cf-6a0349dcf31mr1062144a12.9.1785237782580; Tue, 28 Jul 2026
 04:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-6-3c41f66d4522@gmail.com>
In-Reply-To: <20260719-submit-ce-series-v2-v5-6-3c41f66d4522@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:22:48 -0600
X-Gm-Features: AUfX_mynV-00WZz0Vlu0qqRI8o1tOZhjZLQyk-yfWhewaa3NHy4TYwoxHxBbPFI
Message-ID: <CAFLszTiOKdHZ-gSgCP_-3d3FLCSF7Tmyf+cjswAveEbApH-q2g@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] crypto: aes: fix software key-size handling
To: james.hilliard1@gmail.com
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
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
 Vincent Jardin <vjardin@free.fr>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237782; x=1785842582;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YgL19BY+JMLrLyhmt8noz1fypa038LWGNp72P2x8XmI=;
 b=jgjtBsllb67TuD9KI98yTFu7o8UqlNMNC204m8b1QaV1u1Yz8XZwMq1nWONNE42HUU
 zCyYZeBu+Drcpa/whHpxSmOO/bIKPlEMdgfo/pdvi7w65i4Vy3nigd6dO7VZpCJuggU2
 ckpXiZuQUgg8BXCxpTObS6v37oGEwtHHirdYs=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jgjtBsll
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

Hi James,

On 2026-07-20T04:13:44, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: aes: fix software key-size handling
>
> The AES uclass API expresses key sizes in bits, while the common software
> AES primitives take key lengths in bytes. The software provider passes the
> uclass value through unchanged, so AES-192 and AES-256 select the AES-128
> round count and key schedule shape. Key expansion also copies the bit count
> as a byte count for every key size.
>
> Validate the uclass key size, convert it to bytes once and retain that byte
> length for the software operations. Correct the primitive API documentation
> and add NIST ECB and CBC vectors for AES-128, AES-192 and AES-256.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/aes/aes-sw.c |  43 +++++++++++++-----
>  include/uboot_aes.h         |  20 ++++-----
>  test/dm/aes.c               | 107 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+), 22 deletions(-)

> diff --git a/include/uboot_aes.h b/include/uboot_aes.h
> @@ -47,30 +47,30 @@ enum {
>   * aes_encrypt() - Encrypt single block of data with AES 128
>   *
> - * @key_size Size of the aes key (in bits)
> + * @key_len  Size of the AES key in bytes

I see stale 'with AES 128' wording in both the aes_encrypt() and
aes_decrypt() headers, though the round count now comes from the key
length. Please can you drop the '128' so the summary matches the
parameter you just corrected?

> diff --git a/drivers/crypto/aes/aes-sw.c b/drivers/crypto/aes/aes-sw.c
> @@ -12,13 +12,23 @@ struct sw_aes_priv {
>  static int prepare_aes(struct sw_aes_priv *priv)
>  {
> -     if (!priv->selected_key_size) {
> +     if (!priv->selected_key_len) {
>               log_debug("%s: AES key size not set, setup a slot first\n", __func__);
>               return 1;
>       }

How about returning a proper -errno here - it would tidy things up
while you are respinning.

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
