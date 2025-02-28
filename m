Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C09C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE24E810FE;
	Fri, 28 Feb 2025 13:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x6aKGHxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C2F980BA4; Fri, 28 Feb 2025 08:21:27 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2873E807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 08:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6fcdf0980a6so16137707b3.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 23:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740727284; x=1741332084; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SSuHB9jG60TZaMG0KaoR+fkU+Hc7M1EwQm2M4CFynL0=;
 b=x6aKGHxVmvcT6EQwXkpMtjAzkZTrYnjPOgppBy92uzQlRUt8fY9CfOrg50cpTdffgl
 x9KHe+GZOlZfp++ajBNUMpzvLcy6trFs0TEmOecZNTXuZsfSIRk87HSZgMFO5gm4bqM0
 D8xWS/BtfnjPTJxNKu/w/ex01o+Bbc+lNni/2zCsf55/ll+sqfTvPE3PrnPq9PpebEcD
 8/tfQccKSfiG2598am1uFStPQgZm5wru0cjNgGXiaBX0t/dygJGHXmC3oyWPkOBlvGT4
 A0qAON1SUNzSx2+O2zC+5w122N1vbDQKSxzgzKILBAKoRC1JerInERMS03/pIT2jDT5m
 e1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740727284; x=1741332084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SSuHB9jG60TZaMG0KaoR+fkU+Hc7M1EwQm2M4CFynL0=;
 b=VBhlUkQusehpc9VBt3P2wsKMIjmXXOasWf5SocPLWe6+Hs5RXbmCqK0r4shhNNaEFz
 cSlBMmsLnLxTWBZ4dcDukQ38uUSt1Hm9w2JDOwV8vDZU2KXrYtRwtyb7oXoBfuMedJlL
 mnajDHmuFpUBUlh2MzI8T6OAOsUKwLZVb9sEdtYxmUGfJVhp2r6b7iX6dQ7S4RSZShbt
 3d37r4KzIw0obitIPVZQ8DyEEFvvTc70oYajNNWixPe/NWM7CzIvyslPtj69B56Z0RDN
 b2DeYXVTbk0Rhok6l6UPXtP07a16HFpmMY9/XV+bFAfuDN5W/uzCqfuY23W3DhN6sxm/
 2xsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU79m5Z+Y49k2SJ7djFBHme1885+Mr7Hd0MGRI2q3WCMCsmGjnlVhTEOos1+df9Ok5A6a0qvvw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf9vHLFMT0o2Q+MmVQH9Q5+EjQzp+HL4j67N/UqD5P5nL/eWuw
 UN7Q4kFGA26yxzQz8+68p1z+v0qRPU64IISo8lS/kH37Ve7T+TvKhU0ZjjJWVm+3f15/75RlILb
 whGVt43WJYC9bGptDgdY6vCs666xIrq2ZTmVopw==
X-Gm-Gg: ASbGncvQFtz63jMqQbPFrNSwSx48CVcwr+WvwWJ54R065ZoUAKdoMW2Zv7Wkj9dTuoX
 HMnJHmOXjGFNz/aSkSZPqHLqcFvdFJMz9q2t/cAf9eE8eis4C8sOkdnc8HEnEh+WmJD08EnZqE0
 SlK0vXqBHt
X-Google-Smtp-Source: AGHT+IGlh29sx4ggPcNluQf5UbEr9V/bMwWnVg34XuOPVCBuP1zyhVt07gLVdYFrTg2klUaW9UvTS76/Dp1TUsjQdps=
X-Received: by 2002:a05:690c:74c9:b0:6f9:a402:ff2e with SMTP id
 00721157ae682-6fd4a0130f8mr35573317b3.16.1740727283889; Thu, 27 Feb 2025
 23:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
 <20250227121515.232996-5-ilias.apalodimas@linaro.org>
In-Reply-To: <20250227121515.232996-5-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 09:20:47 +0200
X-Gm-Features: AQ5f1JqRb-nTBC9kF1GFdUXI_1498WaI0RJHaKNyXGAflgU6ZnBKSJjemVfiFAc
Message-ID: <CAC_iWjK70VuCNvfq4U3-iXoyeWx5wN4O6BvdtmouNW7aofLrxA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64: mmu_change_region_attr() add an option not
 to break PTEs
To: xypron.glpk@gmx.de, mark.kettenis@xs4all.nl
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Tom Rini <trini@konsulko.com>, 
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefan Roese <sr@denx.de>, Harrison Mutai <harrison.mutai@arm.com>,
 Joshua Watt <jpewhacker@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>, 
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 28 Feb 2025 13:45:41 +0100
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

Hi,

After a chat with Richard I figured I misunderstood his comment ...

[...]

> +void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
> +{
> +       int level;
> +       u64 r, size, start;
> +
> +       /*
> +        * Loop through the address range until we find a page granule that fits
> +        * our alignment constraints, then set it to the new cache attributes
> +        */
> +       start = addr;
> +       size = siz;
> +       while (size > 0) {
> +               for (level = 1; level < 4; level++) {
> +                       /* Set PTE to new attributes */
> +                       r = set_one_region(start, size, attrs, true, level);
> +                       if (r) {
> +                               /* PTE successfully updated */
> +                               size -= r;
> +                               start += r;
> +                               break;
> +                       }
> +               }
> +       }

Instead of replicating this, I'll remove this code from
mmu_change_region_attr() and call mmu_change_region_attr_nobreak() in
the next version


[...]

Thanks
/Ilias
