Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77801CE7B13
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13B6283F54;
	Fri, 14 Nov 2025 15:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UTodRdv2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA708410B; Fri, 14 Nov 2025 15:25:07 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53ED480077
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b71397df721so267865766b.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763130305; x=1763735105; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X0ICHYYq29JPCFTciLpg4aOnoaUUunT5qtJO0AkGh38=;
 b=UTodRdv2PjxZJSTy38Z8AZEqPYcl8AB3qxZ6nDke5lGIBkZM1BblzCtwuRoy8XdKOz
 g5UB9tp6dbw4psrqVJyye7uaoRXIa//b7Iw0DTnRf4XtsRL4cs01G+5Kn/Egka1K8qvJ
 Px/DYsKXKX47XDYnZpkstIR1BJcBiwK9Wky1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763130305; x=1763735105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0ICHYYq29JPCFTciLpg4aOnoaUUunT5qtJO0AkGh38=;
 b=NLTraVZbxUyxKIy4IAvocvTA91CfzSr0HYsBEY8ykZ7HpPuTlPTqrDctB1YoZArJw/
 0QtVA1AvqiIBgjTRONmrAhBylwPJ/sCdOVTWpiqInckdJsuWwu5D+vomV5o+ZT2vhRaC
 kzz7rXrc32reHYShKqWqZxNF2z/mB0jpYupoDALcEuJesKsVkqfDa29hn6UExlwjyTYd
 5DAet9ghaBEybkygz56XybZRcons8vmew56uGRmmActd84nC1OEAe5Gvs2vGdMARJWom
 llHUAZORSMixWJQc1rPiIPda49XsBE3ts2Ag9IpcLBUw4bK8L/n0lQlkI18OJ7582i1z
 J8Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3TfHOqh8inK8ZsXcT1U3MZbAVWej42fo9umFDjoKi7I7G0EfPlmr25AhMmXRpE+pbHjb1zXQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxav6AbhWsodfKYrlh4ZDISh9+CZQbEYWfS5fXCY78bqlcRgNsB
 gyMpymfn1YYgzB5CKMapNoZTgfMAMFS6zY4T5lRPkLQm4BcIvrViC5I0BegAJouLXJMnX8gj+TD
 2PzGKXrXgUAJ/51SNIztR6omQDV1wA/BDPp1ZUAPg
X-Gm-Gg: ASbGnctSvcg17o5sh0K9N7zw7alZDv92LKrT/04ZsD/dwob/vxvHlYHGzYp9jbXspFl
 eOmfshcRcocThIYuPmpelxQyB7+ZLE78izu7heIkxNPmt1cALDUAyC4mAc7RrRINIPtTL6AMXhL
 uiGIQ3fbGO8cZMSLujUiQpMh7LQmhqxyZrDmmHlmamuw1EreZ9a+8Hbfxa0FrZZtXPcaN1IaxsG
 MK7PUxx0uA3nP3g0xizaoXH331xWCQciOM7nAUWvaFw2hfWH4tVKUfYYhUzTPlfUp+Lxg==
X-Google-Smtp-Source: AGHT+IEcy6Zruz1RrD6IyX7iy+3dG/Rljnu6DXUy23qAPKyIu8rixwk38H5bxZuY2Gs/29+utRHOviqOnmVlFEWIUGs=
X-Received: by 2002:a17:907:3e03:b0:b73:59b0:34d6 with SMTP id
 a640c23a62f3a-b73678ecc12mr383547466b.33.1763130304778; Fri, 14 Nov 2025
 06:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
 <CAFLszTiHVqgn5eox3p7CWt0=XjAcYMBjR7F03UqweRftZg5fDg@mail.gmail.com>
 <20251114141943.GV6688@bill-the-cat>
In-Reply-To: <20251114141943.GV6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 07:24:53 -0700
X-Gm-Features: AWmQ_blEiJywkVWVFYtAXpa6xtWlNNofVjseVVF832IhqjbjRgctlC9kf8B7cbo
Message-ID: <CAFLszThhPVcKhcbxA77HCwrRcq9H1+p_YvEmir3p6TEkLb1YQA@mail.gmail.com>
Subject: Re: [PATCH 6/9] test: cmd/fdt: do not use fixed buffer addresses
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
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

Hi Tom,

On Fri, 14 Nov 2025 at 07:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 14, 2025 at 05:31:40AM -0700, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > The location of memory depends on the board. Do not assume memory at fixed
> > > memory locations. Use memalign() instead to allocate a buffer.
> > >
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> [snip]
> > >         /* bytes */
> > >         print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
> > >         ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........",
> > > -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
> > > -                          (uintptr_t)buf);
> > > +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
> [snip]
> > This is adding memory allocations to a test for hex dumping.
> >
> > It would be better and simpler to use a fixed address and make this a
> > sandbox-only test. I struggle to see the value of running these sorts
> > of tests under QEMU?
>
> Removing context to highlight value of running tests on multiple
> platforms.

$ ./tools/qconfig.py -f ~PHYS_64BIT -l |grep sandbox
sandbox
sandbox_flattree
sandbox_nocmdline
sandbox_noinst
sandbox_spl
sandbox_vpl
$ ./tools/qconfig.py -f PHYS_64BIT -l |grep sandbox
sandbox64
sandbox64_lwip

Regards,
Simon
