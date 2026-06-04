Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6E3CD6E77
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 16:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A6228493A;
	Thu,  4 Jun 2026 18:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jdYwE0ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03BFE84954; Thu,  4 Jun 2026 18:58:33 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E821384928
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 18:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68852a4fc68so1626493a12.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780592310; cv=none;
 d=google.com; s=arc-20240605;
 b=XteYA7mAOLnfjJWR2mt51/wWuuhbxNvb9fVdYCnx/BEmGeytBhvEDuQgNv3NheyuZJ
 22EuHCZjKPzkoNkVn2/0zHF+veGW7/wr05yOJncXY0MJmdj++c8/+eIyWFasw0qPUYp9
 j8pwDTW+8tDaeCeQAwQ2FDxl/mF8Pmzcgqo8ZQjm1DEq+WfMKHLTbnwtaoSJpGzMA3SV
 ur2Ia2EHn0agsUKOlfKREMb6rNRCfVIf25lIR7lrrEsv0srVTkzdZ07rTMEPhjviu/3e
 SDJEJm2Mc7k2/NLjwtxycZdKce5kYURTK1TNm8FnKb318JIj9tmblAHW4Z9mTBOB8r1X
 GqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JOGsE8z/zdxeMVLYmq7Bk1XR9OO7NUyVYoegHNHY+Cg=;
 fh=Y61FZ0RughkKg6J9iYjyepvaDxj+0lc1BGbDA7WM4UE=;
 b=BuI8P+/z2CphRh6G9qi8f6PVEn74kjwpbLAJV/fT+8cJ0ZV+1KK/fEzwZznEsKorbJ
 yGbir/3jvwCl/HUzOCycbvZcaT/JlxaR8k6mlHW1s7NCTpxlIwmBpNnxgXPK0SUTYXQS
 //TStfwwxwaWdt9e5VK/Lk6HCgUwdBso4Rso4yCQ1m4iJdtjtX6F9srYrkOOd73IOXc1
 ZJA9z/oqtlnuga55bM8Iuito7QL5U1zK0Iv08eCFveNXwaRUHTlGn55vzAjprqQFBQN/
 nSV4ny3oza7wHszXiPtAutwUg0SMOIEW4vEcH9iKhKe5BpRknLFHrvqDGyFoi6+EEn00
 GT7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780592310; x=1781197110; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JOGsE8z/zdxeMVLYmq7Bk1XR9OO7NUyVYoegHNHY+Cg=;
 b=jdYwE0ruGyZXee+scUAYM+EgFkrwqXUphHJZgqkNrOB/MRtPBy1/LC8v/y6cHAu1Fn
 mQtqW5+1GBA/mwC3QzYOFPEnSYVVDDQx/dGrSqFC9tudxuJ+2SLoqp92Pf+fDlyMJrcW
 Z+f8bTGj5HZ4PvOLApDrwKdlvRUzB0r+bRIrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780592310; x=1781197110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOGsE8z/zdxeMVLYmq7Bk1XR9OO7NUyVYoegHNHY+Cg=;
 b=fB1/EBENdbR7EjhOg5sjnaD5e0+3omG4Ag+kHSAh6t6ccWlmo5xGVRceV0IKGamjTV
 z6hNAxs1xHvj8l1zqNDaiDKOS/7VZ9/FhOBBRY3XWsPFPRFCIfCH5nknVYywlfUOO47y
 jbVyWlR1qCzWpCWp1U4pyDHv9yusD6DbuhYoZV/l3qSW05rqpxaf1UOOqoL9t5bJlpp6
 hB1EDoV/lZ8cOi5HkwfO/Oop2SjUXkLddm4Pit6u3LhYkF1DHsc8XKGCSqWHo99/vLjU
 9L/iAuv5PYMiqEeAYeoJn6DMJDl9BU4w9j25e2rky3cRfvD/1WD/fNcHtuDaaF76rw0F
 F/Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+78RBE+AZCSFJg/xXOXXaAzhvurhZIEh9tEKByzyJCCzDNSBO8Q12lh6H3u0Ag8y7pbk8G9uk=@lists.denx.de
X-Gm-Message-State: AOJu0YxfyaL9p7PXOAQLiQEwZYITpSGxCv8LSEe3ZWfi7du8l03RtU30
 uQw4FY5L/N6gRlMvSZoL39fDYB3LWu3h/xdgTmaDnwtUEv6eO8Dz8SnkhyVmKYNN67o1D4GBxfy
 l9+dcR38lyxMFxxrY+FJ9hR08liRrOOn9eprwaqTF
X-Gm-Gg: Acq92OGQnSVYgcVWe4DFKA3S8ePqBH5J/e7QaE1767mSDgpg81H2tTkWZu2j7MXAvub
 3o03se7aR0U6EXpkCfVcbutC0l44o8eHEfyuNrtlMcSR7yACNe4gnmYaRw27lcx5/TQhuhnKdqE
 BAO3YWrm/9kHhdjodR4byJpXYJunyr+WHYTrxNgkCCBPt6bFcq7TipVYKmau16SuNhAEhPBp2ut
 OPMQhqTf1kr/awVGQFTIPhBsQF2DT1kjmO4Hwd0N9bgxqIlIzja3N7Va4mcuNrjz+RXCoQTTcTk
 vB9vuQ7EkaGX2Cur
X-Received: by 2002:a17:907:cf87:b0:bdd:52ef:73e3 with SMTP id
 a640c23a62f3a-bf0a8d277c9mr515951066b.12.1780592310373; Thu, 04 Jun 2026
 09:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260528080356.399082-1-Wojciech.Dubowik@mt.com>
 <CAFLszThvtrgFCdvOa1-QYYcrefW=vt95jwMfr+QQykE8E1hg-g@mail.gmail.com>
 <549986cc-e647-4f7b-8bd9-8747f04d9789@cherry.de>
In-Reply-To: <549986cc-e647-4f7b-8bd9-8747f04d9789@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 4 Jun 2026 10:58:18 -0600
X-Gm-Features: AVVi8CdEMRP9jJpJ9xuOcVl_rP0bYRY8z0qgFXwodNOojEsFBkHOT9rmDDCiWoM
Message-ID: <CAFLszTgW51om6z4nfaW10r8CDDKmibbapwQSPfXMwpACzU4McQ@mail.gmail.com>
Subject: Re: [PATCH v5] tools: mkeficapsule: Rework pkcs11 support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Wojciech.Dubowik@mt.com, u-boot@lists.denx.de, 
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com, 
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>, David Lechner <dlechner@baylibre.com>
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

On Wed, 3 Jun 2026 at 11:16, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> There's a v6 already, please post your reviews there again if applicable.
>
> On 6/3/26 6:43 PM, Simon Glass wrote:
> > Hi Wojciech,
> >
> > On 2026-05-28T08:03:54, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> >> tools: mkeficapsule: Rework pkcs11 support
> >>
> >> Some distros like OpenEmbedded are using gnutls library
> >> without pkcs11 support and linking of mkeficapsule will fail.
> >> It would make maintenance of default configs a hurdle.
> >> Add detection of pkcs11 support in gnutls so it's enabled
> >> when available and doesn't need to be set explicitly.
> >>
> >> Suggested-by: Tom Rini <trini@konsulko.com>
> >> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> >> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> >> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> tools/Makefile       |  5 +++
> >>   tools/mkeficapsule.c | 95 +++++++++++++++++++++++++++++++++++++++-------------
> >>   2 files changed, 77 insertions(+), 23 deletions(-)
> >
> >> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> >> @@ -207,6 +207,71 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
> >> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> >> +{
> >> +     gnutls_pkcs11_obj_t *obj_list;
> >> +     unsigned int obj_list_size = 0;
> >> +     int ret;
> >> +
> >> +     ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> >> +                                              ctx->cert_file, 0);
> >> +     if (ret < 0 || obj_list_size == 0)
> >> +             return ret;
> >
> > !obj_list_size
> >
> > Behaviour change: when obj_list_size == 0 but ret >= 0, the caller's
> > 'if (ret < 0)' check passes and execution continues with an empty
> > obj_list. Please return -1 explicitly in that case.
> >
>
> Yes, good catch, we can have ret == 0 here when obj_list_size==0 and
> thus return 0.
>
> >> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> >> +{
> >
> > ...
> >> +     ret = gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
> > ...
> >> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> >> +{
> >> +     return gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
> >> +}
> >
> > gnutls_x509_crt_t and gnutls_privkey_t are already pointer typedefs
> > and neither function reassigns the handle, so the extra indirection
> > buys nothing. Please pass the handles by value and drop the '&' at the
> > call sites.
> >
> >> +#else
> >> +static int pkcs11_init(void)
> >> +{
> >> +     fprintf(stderr, "Pkcs11 support is disabled\n");
> >> +     return -1;
> >> +}
> >> +
> >> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> >> +{
> >> +     fprintf(stderr, "Pkcs11 support is disabled\n");
> >> +     return -1;
> >> +}
> >> +
> >> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> >> +{
> >> +     fprintf(stderr, "Pkcs11 support is disabled\n");
> >> +     return -1;
> >> +}
> >> +#endif
> >
> > "PKCS#11 support..."
> >
> > import_pkcs11_crt() and import_pkcs11_key() are only reached after
> > pkcs11_init() has already failed with the same message, so these two
> > stubs look like dead code.
> >
>
> How do you compile the code if you don't have those stubs?

I haven't tried building it, but just from the look of it, it seems
that the procedure will fail if pkcs11_init() is called. So why do we
need stubs for the other two functions, which are called later?

I suggest putting the #if inside the functions rather than having
entirely separate stubs.

But anyway as this is already on v6, my feedback is minor and I should
have noticed this earlier...

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
