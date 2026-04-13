Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE661F34C5F
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 14:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95C38407D;
	Mon, 13 Apr 2026 16:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m8/7zq3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE4D84199; Mon, 13 Apr 2026 16:54:58 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0AB183DC9
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9e00649769so72456366b.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092096; cv=none;
 d=google.com; s=arc-20240605;
 b=ho0o37VcBnWScQlF+0wj2G04On+j2yK5wuQE8dfE5hcp9MxGIRVi2yfhIi9tQfoMSu
 KdtfRu9IYftv0Nx41Ztq6JYkLsEy6VvHvGI6SpX33rtvtXqvfy27MeS1nTLfZ5V4er+J
 84vFQdJl2MoqBTWPTvv+6ECQdjUSs2DUg8yoYRZiKOwlD3yW8NmHffNNasQIQAao0/Ex
 25CU2weWlKf7juUKTebf0003Yrz2gjc9pYAQeFSAa/D1jUJCkPhteaerFPXJnX38Xks5
 ZK/Hr2DxXUXIppeuX8AxbbBnZPvKBhVQydwOKdG3LG0j4/5tAng/jFm+MSmyFzlr/ZvT
 x0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1EFyaHTg851r7lufNcaM4Ki7+obc5Re9dAxnhFM/0ZM=;
 fh=vWGjtn1jaHvP7sTvYs5T2kZsOKPFB1kxIckHvNdP2E4=;
 b=SmYoe2RWNVXOZZRm6wUVHMipba51a8z2aTOtQLD5POF1PqXz//DvR0pb61VnmKqTwp
 IFk4PwsfHuNlJnv8V/+e1R22LnNWnAQBCX/vyj2xJoES1MQ5XLnVeRalc3tpn3gc6WZ9
 TWEK6nQqUys9ty8OkfIP62rIe/0IoqJaNJJLGgnUEPVDyAKEuLs5LYU7qEdLXExLH3hb
 CYZWCzzLIKhhmLbqliC1JGUm9RV4F+DffhDjjtupBVdzwGGLHJTy+z3MjI2KnNxGwAsC
 1JgNtC3+UuTd3Wk6oXhc3zSAckppIhwllRDorZew3CU9McQ8E0CPjHPdCLy4oNiTAKrx
 KcrQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092096; x=1776696896; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1EFyaHTg851r7lufNcaM4Ki7+obc5Re9dAxnhFM/0ZM=;
 b=m8/7zq3PCiv3SggCeQt9szumoq4LQFx0t1Wp8/l0kNcfgxxRQsQSlU8R1Ytv9q5tNq
 aOLL0pCznYSipb97z9fyWUxSpRPvcTi/TtKmHJ1gnge+Qk5IPvuoPQj2ZLHqS/Rt/fiE
 Qv5c87mkDZaPQfSuGGStoqG5OpQibXdPDQUaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092096; x=1776696896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EFyaHTg851r7lufNcaM4Ki7+obc5Re9dAxnhFM/0ZM=;
 b=b1iBMBxvqWp2pLUdpxfAcX1/dOqHyLi7D//mEnQgVPUB94TmAK6LqtwJfoZt2VzysJ
 g2ztaLVpdAelcc5PeSAh5dB7o7pN7xAQ+MA1YzJ5ZyQ/sUIVTG2z8siFfQdkotciYmpW
 Msbiz71Ol+KnxCztD0kqLSwLWmxGa/KEkxImcwaSb0J8z14VA2Qdc74xUh189kLNoLwF
 sHt1nGAaxnZbotaiom0h21BgTo0CCynyOqEEEr1W7iTa1tBASHToNT1fzds2WswK/zkM
 rtvUS70yKeUT+sxInW5PjSASjEzGkD3fTDu4eAWXxL1yhXDsOyAw/+H+nmNuTcUOukcx
 N65A==
X-Gm-Message-State: AOJu0YzCXg/Lu5A13vEdmtReur9uzBexjA2eDt7GTbn1eXFBkp+7JehI
 NSKYc2L7aAI3XTEl4z9eWffOvynJ2rgDvK/K1aS1WaiOlFE1HH4RhIUNpfzHsln0fVXVOU8iYoL
 4xU6RNamBoYyo+CKeFmFss7YAu6ZuWpqyoHpu9kTS
X-Gm-Gg: AeBDievZ2MGvAKdyA6JV1a3eJ+VEFd4uN3OXq7waNlRMhWZ7GjlsqojOk/9xzkhHvlu
 cxt5KrrdL2pDqwcYt6edKX2auIUp7VICnWsFEb28fwsYRxP3R+o1H0W+OnNFhI7yhWR7Ci5cJ/w
 K9ZywwZ01dNcEVtn1QmggbetVhUPtKaDYR01rWcHDyw9GVITdXt15d0/Urx9ZjwaUe8e4DlCpR8
 dxrEZEMpM1UqZZUvFqFxrs3vpNAhzj8vZUzY0m+HTgqBpX5FWP3d2GqxImjzK2xNPItz80F9edq
 68rKZA==
X-Received: by 2002:a17:907:a604:b0:b9d:1a1c:a664 with SMTP id
 a640c23a62f3a-b9d72991a2dmr858472166b.40.1776092096135; Mon, 13 Apr 2026
 07:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260306012019.800588-1-sjg@chromium.org>
 <f1cf64a7-04b4-409f-ab54-044b010f32cd@pengutronix.de>
In-Reply-To: <f1cf64a7-04b4-409f-ab54-044b010f32cd@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 08:54:43 -0600
X-Gm-Features: AQROBzDDjTLyTa3_k6o6qJJOpgaop7YQ3EOYkpJNqjOrKWLJwbqyMrwO-MGL0T8
Message-ID: <CAFLszTjcdFs78x8f1pH891cmrwpDr9k=T-zU2HTbNwiXqii9mA@mail.gmail.com>
Subject: Re: [PATCH v2] boot: Add fit_config_get_hash_list() to build signed
 node list
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ludwig <ludwig.nussel@siemens.com>, Simon Glass <simon.glass@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
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

Hi Ahmad,

On Wed, 11 Mar 2026 at 08:17, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 3/6/26 2:20 AM, Simon Glass wrote:
> > From: Simon Glass <simon.glass@canonical.com>
>
> > +     /* Process each image referenced by the config */
> > +     image_count = 0;
> > +     fdt_for_each_property_offset(prop_offset, fit, conf_noffset) {
> > +             const char *prop_name;
> > +             int img_count, i;
> > +
> > +             fdt_getprop_by_offset(fit, prop_offset, &prop_name, NULL);
> > +             if (!prop_name)
> > +                     continue;
> > +
> > +             /* Skip properties that are not image references */
> > +             if (!strcmp(prop_name, FIT_DESC_PROP) ||
> > +                 !strcmp(prop_name, FIT_COMPAT_PROP) ||
>
> I know you need to mimic what mkimage does on the other side, but I
> found this surprising:
>
> The configuration node name is probably hashed along with the FDT node,
> but compatible isn't, so relying on compatible means an attacker can
> trivially control which configuration is booted.
>
> > +                 !strcmp(prop_name, FIT_DEFAULT_PROP))
>
> I am aware of /configurations/default, but what does a default property
> within a configuration signify?

Belated reply, but yes we don't use a defauilt property within the
configuration.

So we don't need that extra check, i.e. if someone did add a 'default'
property into the configuration it would be OK to fail the signature
check.

[..]

Regards,
Simon
