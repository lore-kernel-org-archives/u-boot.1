Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B56BFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48AFC846F5;
	Mon,  4 May 2026 22:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B4GO9LDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A67846F2; Mon,  4 May 2026 22:30:46 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DDD846A0
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67bc8609a9bso1299793a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926644; cv=none;
 d=google.com; s=arc-20240605;
 b=ZE1pI3m1Df5wroArkZ07U3RNLnZrMzgkwKyo/dVaeEEQDSMLSTpRHTYPlsKr0xbN/2
 BtYnQW6+WFI7KMlZ+Hfez9K90MUzL/TK2FkOIjhC2S8o7NXioFwOvY+XETAk9oMwP+dt
 yM1KL6SuQorTlvzbzl7JztvojMJuKXXJK5PgrS5QjvPKI/HkJixR+cJeXTbl+FODXtZP
 qVPWiXdwio8wUUcL0jXWFx410OjsgjEtql+iIlnPpHYBQuALGoenT9awRFmpsuxe8lOj
 yPC22njKiWlSLcYuKE+ABvNUrUQUJaPZLplwa/TBuiftXdsxs3VktRA6N2xQltQHfciY
 SNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/BoGWLETRDTpr6JaEeYHRAbjDxsUIhFQJRH7B9eKgTE=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=Feb+kv4krMCTqumudiGGhIE8nROfl9W0rp/vWLyDg50pCUVhCojdnkV3CwscufZjYi
 rYZfylCKtIEBnWk3jS+xc9Q810MlV25qt61a0fyBmqRupq+GBwpEBgJeipvWjUca54ih
 wim8xu294Y6P7Vc8xCth5LSuszm9kLdtd+VxVi1VsEyVgwDFv0r7eZKLhUU+JBMppfju
 3kfFZ5EzMaQGOfDjh3DkKS2FsUC0YPr3XlYg9Y5geJPXYVf9m68nTgTXPu0MZK80gQhp
 nnBOCq7a63JwiAUH9U5NKzw4TSCw23je6/x3kKB0l/WjPTW5PTfUHe35mO86jKLLcP9h
 31nQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926644; x=1778531444; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/BoGWLETRDTpr6JaEeYHRAbjDxsUIhFQJRH7B9eKgTE=;
 b=B4GO9LDTMN5DsQ6YGWEujuvYQMUhbW3XjyG3PWeA2p6yOXSaNSjj5V7wNOqWRldFQV
 QGn9wphOxltR/+Tfi17R2dkZAGl4B1JDYiRw0WR2E1+mXwUlVcskrzIizprMIHVHKByP
 YHgNsk/0mxnctHgPKHe80ym+/XpTnzn2TAgjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926644; x=1778531444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BoGWLETRDTpr6JaEeYHRAbjDxsUIhFQJRH7B9eKgTE=;
 b=r48Rd+aFyA1ALDes0KfEvJwAdOHOr0x0Q/QJFwbnjZNBvHgqKYf694c0F0DhM1JRMX
 Iu3xucM5pMhydNEK+ikgIgH/MrmqfWAUF9JnwTWNdX0NSHvxE1ICs5v9Ejo9GBhley9b
 aw6bCbuJKCHfmzt8CenBsu+vLwRvnzjZGFbEjsQC25KDeNue3UZqWaPHctXcvjCAjR9Q
 g/zwiq42s7W4DzfdqAovbtAWCREH9TxSL79R4tTce9wpxv3xZfE7GRJXqGbTKJGUgjpW
 SF5klFoJQXyaBsnigKzTaLV6dOeDWx/rbHjghQ7JGXNQsqXsKRC0XW1NPJ3qkFWVrVx8
 hTEQ==
X-Gm-Message-State: AOJu0Yxw8sU5oHydIceSs64QGZJLGAzQelypWILJ2uD/fZtfWf6Gkj+l
 dKTT9qQ+Fg2yZntEoqhSzGxWe5wfooNUO21eOOpNWR0z7K55COKXbXjYvPwJbuPu8fA0xz5zWP8
 Gxvoe9bSPNpU5XpBDwSG0vFLxRCSv30FXprYu8COL
X-Gm-Gg: AeBDievAKMreowNwkKtf0LWKrpOELqBu24dHVu8dYsoSFmtaLPtNakzuROhKsi1xr2K
 v7m5LNTI4Vp8cIgQD+eBlpwfo2dm/qafxkqVJCMtH/No5jfOqNbNHnfvev1manpg3XmAMWsjW7f
 eIaMLQYzyPZqUNw/4DJyRnts6LoJwulOvwb//q4u+pFzj2IzzefUWpGcftmg/C2e2nA7ITcTd/0
 VzI2ahEcF1/He1vRFNag682BhjHyd2R83ZzGotu1Uz+nELhqy3YtEQ+3b9scHA82zD5/adQPMF1
 XxITZsT3/wk6CJ4A
X-Received: by 2002:a17:906:fe03:b0:ba7:500c:ea16 with SMTP id
 a640c23a62f3a-bc40f9211b1mr6865066b.13.1777926643938; Mon, 04 May 2026
 13:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-3-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-3-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:30 -0600
X-Gm-Features: AVHnY4Jv6ucH20iGVlHSps1-J9P5neq9YEVFXm2Ld2q59HuqxbSeBlwqEsz5MoI
Message-ID: <CAFLszTgPaD-hf0QODzi0g20m4x+KM6z9-D3rGmnaXcbYUgPEtw@mail.gmail.com>
Subject: Re: [PATCH RFC next 03/18] scripts/Makefile.extrawarn: migrate -Wvla
 to a U-Boot-specific file
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> scripts/Makefile.extrawarn: migrate -Wvla to a U-Boot-specific file
>
> In the next commits, we'll be synchronizing scripts/Makefile.extrawarn
> with the Linux kernel's at version 6.1 which is what we've been claiming
> we've synced to for a while but that isn't true.
>
> In kernel commit 0bb95f80a38f ("Makefile: Globally enable VLA warning"),
> available in v4.20, -Wvla is now enabled tree-wide and not present in
> scripts/Makefile.extrawarn anymore. When we'll be syncing to v6.1, we'll
> therefore be losing this flag (since it's not in our root Makefile). We
> could backport the changes to the root Makefile to our root Makefile but
> U-Boot is not VLA-free unlike the kernel.
>
> We have two options:
> - backport the changes to the root Makefile and disable it in
>   scripts/Makefile.extrawarn.u-boot,
> - only enable it in scripts/Makefile.extrawarn.u-boot, with the same
>   warn level as currently: 3,
>
> For now, do the second option. We should probably go for the first
> [...]
>
> Makefile                          | 1 +
>  scripts/Makefile.extrawarn        | 1 -
>  scripts/Makefile.extrawarn.u-boot | 9 +++++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
