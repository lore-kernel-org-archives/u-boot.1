Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E03BC54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECDDA40A5A;
	Tue, 28 Jul 2026 18:43:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xijf5J6bPOWY; Tue, 28 Jul 2026 18:43:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3756240A2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264196;
	bh=ho3zMzGx42U5J6sru+edumC4ag9UyhgCwhcR1yznaWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KybNBg4/aWMt7aquWt8wBohNeF4HONvzbT+2h/vhDpdnrS+4dLnGV87+rOBSXNBG+
	 /AQPG1xLBHYhvRz0xU1Q5/wyjQII8n7kLQs6o1aWOuO/aBUK/I+2tril3v4cudZ7T+
	 mCG1D8nvuMxmUJT8EKPbLOxLOM7D+VqMX5KSq8DgvXZEltifICf8vYPtWd7sEpcE3F
	 LVpPsLBGkSt2MW5MelDiLHNiV+DIBv8ZKozttlVlDrhvV+saBKumnM1HWt+bcJ29It
	 QFzJsC6+jb0XNcuB3Y+dDgj5naCngXQNb+NpyJtmT+IFj1/Q7AoRIBpe2sZh9MWZY5
	 4f34lg9WKsqCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3756240A2B;
	Tue, 28 Jul 2026 18:43:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ED524BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E5CE60A37
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yndMklxjwzSH for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:43:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AB0EA60A3E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB0EA60A3E
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB0EA60A3E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:43:13 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so144556a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264192; cv=none;
 d=google.com; s=arc-20260327;
 b=i1kRAVQA46Q9+jC69AKaP5Ppl/mSc4o5zl3b8SsHGei9xCDtApwdN4wUagwC53MHvu
 IRjHjLuXfTmNKteiFqOcpofPPIPVmd2ydcAB5chNwrmYN2xwKf3/bsSVHQfhlEOIANdK
 jphoybDtwMBkg0PXRdW2X/D6dbstuSCs0dJ2dpY+g11mS674EVdP9q3NthvYVGRGWlSa
 kSQERaASC2yqQGI3K2Fk37VtcmGdC8yG3BGr+dnfqjeMQ0Who17AIvyasMdg3BwO/OAb
 PXNzeNsl65q7UrSzkFBBWvswEQqGP88MCoGp5MSXxnRTk2w5yPLCgxQwJzcRWOzAAqV4
 YsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ho3zMzGx42U5J6sru+edumC4ag9UyhgCwhcR1yznaWw=;
 fh=vQkykPx1R4jk+N11ZqVs9o3Tv8swObzl+A+/Iw/9MYI=;
 b=Hee09iSLKWJ7rdBXNVREEvloHvf/Cy1tCfCA1ZEqkYD14o6PRLoedCJPDIaztZCM8t
 CQVzMdLNRiGg+juaUm1B5UpT+SETjNSVHRoQqSS5KDakBHu2sRDtwZyC5VopV/Pugv2m
 0UaWuo0DbMus3v+TwHi0DHbI6nZooilYsHyJGWyBKewOU7g7r1tGF9Vj8ZvKy+MHnEHj
 E810Sgl0PgqC2QPcL7LvPm7yj60abx7MqZRe/gxsl+w9Ro+qgUkxykVVD1LvUy1EX6h0
 pf0r+7rXp4VFWWxF8wPvfMIdlHqbatcjGKacT/uEZLF42SDnTJo6ywWnbmBAgm8q8So2
 1oNg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264192; x=1785868992;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ho3zMzGx42U5J6sru+edumC4ag9UyhgCwhcR1yznaWw=;
 b=k5PhaaZXEwgWzDrdMhDnzVlTiU7nUWMJ8gb3nNGjlOlXgFnkIwvh/sR+4gTAEVXljY
 YMTqL0l5NQDw6oPvXIEyLmBa7G3K8czekZ0oyd5EVss3gPOmO9kjs2Q26LEPHSeYM/CV
 FKubIbf9ywD4WcNPemn52l3omlmg1uZMRU7tlUyQgVxhKE1H+49LuBHmmlJAFF5E0qQv
 5ba20nUOnyNUuAf69tdtX9BSxbTTjlCIIEdnvVtPcEOPnOIvNElIn18zIaF3BjvbOTsf
 EFPvv6thivodmpFd7FuqdzS+PPSxKvOUgo+fUzCL3LHWsg9zOq1CngPY+Kn/vE8r8cB/
 dl9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrz85V3XjdAQniHrUfVTwhRsiCtyx5+6pMicaierBwZBsB0e3zz1YnUAZ5JGLGRFs94/kQ6tUE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw61ElSc84RtmdQoEyrVZ6fUO9OxCh+OT63nWucB8Iwj2q6YVI2
 Oxh2kU6M8Dg60DbM3kH1cWudknWgZKysAF+/Z0G0JmE1Stjo0OESfrdBMyvV/koGFkJcnjoju+q
 vjv8ZvT3uhBK59d/OtlNbGQ41iF3e1X7Q3NE4t20+
X-Gm-Gg: AR+sD13HvIarh+lzo1NI5AB8lyD/VamojakhkJg6EkJC9dRr/3Z7Ns5Fz/5bB5xrzgP
 CV0WXdgYc/pC66G6AA/39dt5hkfJcN3NuZ4TVK92HQqRQ50gAHrUr1cbflXiqTyTT3Ja1OgGtoA
 Kg4W5GP906znVbO2c8+7DkOjUphHcC33AgXGIiTWWjG8bEtdAZBho/ddPVVUyorjx6qA1zxhaGm
 dH7bvNrvvmcADEu8uVzU1hfZVnuc7s+SMMsWkQ9rjlP0ei2EwC/4XaP/FlpR0I4xo/UgVM=
X-Received: by 2002:a05:6402:5045:b0:69f:4c65:8682 with SMTP id
 4fb4d7f45d1cf-6a0349f6ecemr1610882a12.4.1785264191743; Tue, 28 Jul 2026
 11:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1784601041.git.daniel@makrotopia.org>
 <172e250a6c6c90ebc406568cdd8c6195ca41b9ba.1784601041.git.daniel@makrotopia.org>
In-Reply-To: <172e250a6c6c90ebc406568cdd8c6195ca41b9ba.1784601041.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:42:54 -0600
X-Gm-Features: AUfX_mzSr2a-FOc3rdM0rtis2NRzTyOmheo4bkKjnZTz1govTpMd8mw6dAh0fP8
Message-ID: <CAFLszTjoV1zrOJLn0T0oJb8TUCWJvQ3Fec7rwU-vLDbDgLEicg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] test: fit: verify dm-verity roothash is covered by
 the config signature
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Randolph Sapp <rs@ti.com>, 
 Francois Berder <fberder@outlook.fr>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264192; x=1785868992;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ho3zMzGx42U5J6sru+edumC4ag9UyhgCwhcR1yznaWw=;
 b=VQpIawpizS1obvVJkF23l39z99WuBKbAZ4bRTX2eyth2juAvHc5mwTaRThyAiyKdec
 X5FWPydV7meyFL4d3VjUFQGqrFZcJEyoC591aVaR26ScTepDHJwH+m9IhT1ZiRe0v/GJ
 UbcU9AJ6pIV4kRUSbow2inFGxcaL8MJF1ctCc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=VQpIawpi
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

On 2026-07-21T02:34:47, Daniel Golle <daniel@makrotopia.org> wrote:
> test: fit: verify dm-verity roothash is covered by the config signature
>
> A dm-verity protected filesystem image is not hashed by U-Boot; its
> integrity is delegated to the kernel, which trusts the roothash taken
> from the FIT dm-verity subnode. For that chain of trust to hold, the
> roothash (and salt) must be part of the region covered by the
> configuration signature, otherwise an attacker can replace both the
> filesystem and the roothash while keeping the signature valid.
>
> Add two independent checks of this property:
>
>  - test/py/tests/test_fit_verity_sign.py signs a configuration that
>    references a filesystem image carrying a dm-verity subnode, then
>    confirms that tampering the roothash or the salt is rejected by
>    fit_check_sign. A control that tampers a byte known to be signed
>    proves the check can fail. A matching page is added under
>    doc/develop/pytest/ so the module documentation is rendered with
>    the rest of the generated docs.
>
>  - test/boot/fit_verity.c gains a runtime unit test that builds the
>    exact node list the configuration signature is computed over,
>    turns it into hashed regions and checks both that the roothash
>    bytes fall inside a signed region and that tampering them changes
>    the hash. It needs no private key, so it also runs on real devices
>    and uses the same hash path a device would.
>
> To let the unit test build the signed-region node list, rename the
> config node-list helper to fit_config_get_signed_nodes(), make it
> non-static and declare it in image.h.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> boot/image-fit-sig.c                        |  14 +-
>  doc/develop/pytest/test_fit_verity_sign.rst |  10 ++
>  include/image.h                             |  23 ++++
>  test/boot/fit_verity.c                      | 200 +++++++++++++++++++++++++++
>  test/py/tests/test_fit_verity_sign.py       | 202 ++++++++++++++++++++++++++++
>  5 files changed, 442 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
