Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F11DC44508
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6400584B07;
	Mon, 13 Jul 2026 14:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XfLv4eHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77A5384B07; Mon, 13 Jul 2026 14:55:15 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D1084AD7
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-698ab9aae16so5817452a12.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 05:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783947313; cv=none;
 d=google.com; s=arc-20260327;
 b=iPii7rLBBZ7osl6+KHq9ZPmy72v5u55GLU8+OCJK4l6Kx6ZGHiNG6dgxgakRwq+xK1
 iHOjWkOpuYqjBanvrOI9uo7LUfhIQdqtQoNzth1cGnC/lizUNKW8yRwkPCzSNXdw4bJ6
 3VDgT+7jeNi6r9pahPgFdAXqzY1onimz1PDxFNd6PHgvUBTsr/grR+RrfXSL2ChN/J8r
 mQ1skrKCBghg8p9Pu7+XG5Mg16zKHXvVpb+szI4xBr5ocE68OumIIkyYkWXqvwGAQkHL
 Mk3Fy4558IGUK7a1jcSrbF9p8EDc/5CcXNQaMZoaPKI2dhMvQZx65YffKJ14Nv03giip
 ZgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z15NjDp6OuegIYnr2XjPaLWQJLi0TIzwLUQ4ONq2UAQ=;
 fh=CcuDZmTrATCCWiOVlvhRNk3dyUsaw1UrvxWB/NarpSo=;
 b=sQm8AdQ0GVmILiYn0sjRonKDNLrugaw5Ddg1nt4NO1qKeLP30Ol8mMJ9ljELG3F8wT
 6O64U9FojwMx/p2rEe0aRRRfK6P3Mc5ageBI2NIrL30HNGiPwrXJBdGNGT+LtPRT99P+
 7jE5OIKzQGYyuzDBJWNemQ5QZ72/a0vwFzMyzhSlpxvcAj99x2efSqcjTaGNVo2Aihfc
 EJJTNuMl1edbzUztiaTT7/R9w6tOReBK41/8pUOk1FSSVOMUU2Nl5wSzjI2NWL65SsTJ
 TkIiiGqd9BYRSplUIom6CUHx2mCnh5RdZh+fyezTmMxR37ynVoI3d6Cao4pquNMC4U+S
 h8sg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783947313; x=1784552113; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z15NjDp6OuegIYnr2XjPaLWQJLi0TIzwLUQ4ONq2UAQ=;
 b=XfLv4eHbdfJg+dNRnZ3L7wZ3PxIWuXx+TlcMEIHLK7pp7S3hr7bUsXAA5e4J6yLqmR
 jk4267aDlL6/rpSTyUAg2za3wNPofPS2WZzBzFcHesxtsT1nxAyHfse0QBwO6wMob6r+
 k1qRClLsHpQSPxpoLREEoiT90i2X8ZpPvqcQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947313; x=1784552113;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z15NjDp6OuegIYnr2XjPaLWQJLi0TIzwLUQ4ONq2UAQ=;
 b=pNHb38wpEugmSTukB2d2+A+iJ2VyUC9/b6UokIQNeA5ckV0Ta06UKmJKPsZO8DH8CG
 tXMrwT+AIDhoYPL4pVdgSgWbNzsk3H+nh7GewxfA+ODXD7O2amNIGzzL1kZHtS+uOxz+
 yteeGGdsEZ1MlrFpLQ1eT5ndpddCMUPdKs3SZ8ZIO88jwxHM5mYHjezZB3AvvlfH8PvZ
 +u6NRphXN2QKFN45bKbocaujovFOdSg1fzvmCjdZ+uMY4b4w43VD4n0CRtUMoThrC2mY
 bbCqx3R+e1MRqjcSE5hrsEbJ9Y5NpQjErxXTLDcCxEzps7Qp5Yyz4PsB+1AG846Wc31k
 cdhQ==
X-Gm-Message-State: AOJu0YxLhJTmuYgMqCXT9Q8qav/3kZAJJlZVM82glKl0A3e0rrco+8SI
 /rmNCS7ihewhuOFTXX7Fvi3vYs7eJYkJxnSggdY0V+/ztkm01GF8JfUaL6DKIfY2fx1tnhs3FtQ
 /qKY7rgja45wZoZGOD0hmnjFRJLCRrV78uzzSFTPCRCrDVecmLHcPsg==
X-Gm-Gg: AfdE7cm0/JY54fj4prDlEi9QpmzfMonmcRvhkeKbEM4D0eh1KUUosTUdMsmq1flbSgP
 N0x8IApmf7nSUtieBJynAbDw9oMFvZ9AcDN9xbn3LV7INNIVIfb3ntJODqPHKA0uqrEQH3dKxST
 sO1aYF/L+42rhIO3houB8xwp4Bng61cvbFk9A2HCtQ6tVplqjh8Jnitv5MMW9oHYK1sKWp3SQe2
 ubyH3eCNnMOYGgssB48JYHZeY85VbpCPg5lOnOY4EO9vyZxJvSZJg5y8jknaJlXPYPinXBJZTMN
 ifyKjA==
X-Received: by 2002:a05:6402:5c9:b0:698:3e99:8146 with SMTP id
 4fb4d7f45d1cf-69c5f248199mr3580910a12.40.1783947312225; Mon, 13 Jul 2026
 05:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <20260710123618.2036728-7-ravi@prevas.dk>
In-Reply-To: <20260710123618.2036728-7-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 06:55:00 -0600
X-Gm-Features: AUfX_mwWK7w00y23jBoM7lM_Z2IS9ojAOXqqpYSLSAzOqHzjlglT865kj5RZMnM
Message-ID: <CAFLszTjzRQStvr-Vs=aOQ=BaMKBPFmtkPfNXKdh7XNsZ9hacSA@mail.gmail.com>
Subject: Re: [PATCH 6/6] k3-binman.dtsi: insert keyfile and distinguished name
 templates in all ti-secure(-rom) nodes
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

Hi Rasmus,

On 2026-07-10T12:36:12, Rasmus Villemoes <ravi@prevas.dk> wrote:
> k3-binman.dtsi: insert keyfile and distinguished name templates in all ti-secure(-rom) nodes
>
> This should not make any functional difference, and downstream boards
> that already override the keyfile property via an explicit .dtsi
> fragment for each node will continue to have precedence over the value
> coming from the template. But this makes it much more ergonomic to
> have the keyfile and distinguished-name have consistent values
> throughout, because one only has to override the values in the
> templates and not each and every individual node.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> arch/arm/dts/k3-binman.dtsi | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

> k3-binman.dtsi: insert keyfile and distinguished name templates in all ti-secure(-rom) nodes

I still see lots of custMpk.pem in .dtsi files after this series so
I'm not sure of the exact mechanism for your claim in this series. I
was expecting it to remove all of those?

> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> @@ -330,8 +330,8 @@
>                                       ti-secure {
> +                                             insert-template = <&keyfile_template>, <&distinguished_name_template>;
>                                               content = <&u_boot_spl_nodtb>;
> -                                             keyfile = 'custMpk.pem';
>
>                                       };

Removing the keyfile property leaves a stray blank line before the
closing brace. Please can you drop that while you are at it?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
