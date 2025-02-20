Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C805BC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F01180FBA;
	Thu, 20 Feb 2025 22:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k8MZZRn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA5980077; Thu, 20 Feb 2025 19:38:16 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4130080F67
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 19:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e5dc299dee9so1266622276.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740076692; x=1740681492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KsbltiW2DlmRULGlLEcQsgde6hoZE43LiRwlneBK4L4=;
 b=k8MZZRn7TqAxwWS4QCg/xRY+LHzSHX+y0rQgsl9fuBI+4erBVkMHM8tcr5g486sArc
 GZ7kxV+/mROj3eMtGqoeVzYtLNsTMMMtyfkSbTFo9mBb6FDTyj4W5Wp28u6FreE1fvFb
 kxjN1089P3oLzZ+aaKrBhr3lIMUMQUAwX/f5uV8f5GxHHLS3QJrwwXO6SeRjKX5hxwQh
 VtP5xhEAqtFvOcFtYfAm9WYQWh/4AZyyx+gaLhjM9TBjX7z85QxdeSkSgaiplFhuqtFp
 vpwwxIcqpUQQtAloU+lYIFNKGlfflpvsmfT8PwAAObuw3U2Z2oLNP9HrxVGNcEjY+KI8
 akEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740076692; x=1740681492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KsbltiW2DlmRULGlLEcQsgde6hoZE43LiRwlneBK4L4=;
 b=nuGocfjckHqljBsxbCYBbXN7P23Gm0UvWGa7bBtKjYSIBQALlBuaF9Y6sRap0afqWp
 Dh/ChaLiAY95gXcGjp9BuG5f5VOelEQj/C9fXutvX+o40shgiTwQxLO/lD9UUZz5GV5F
 +NNEeY1X3ueJFQpFRC8/Ttv2J82UaqE1NtZrGlKh/9sDRGX/0AyiKzJvK3WZL/2HNHKP
 Z+syWWnR0EJ7aCb60pCsT73twE3HLCyVdwOy51wrcLVd2VH5R0efCMMdA7lndqC5YupV
 K8kX5CvEh+Eg5ctz2BFKQb5Li7ReZGmhJg2Ul8UPh22P7p+EzQWxuZJas/CgwJgdYPA9
 RT7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvEveSEtlx024Zt2iKK+xdlniRgNpiTVE6OPu2J/JOXxp2WYqQ81bMIq6pzjsYKGgdP5Hxy8A=@lists.denx.de
X-Gm-Message-State: AOJu0YxlJTGXVWF2OPFldcdKamfB27ytR1ke3VE6nStcp4QtnLAniLA6
 CAUmK0rpFKigMlLmPQDonzwgyONysMwVZS9Lhb2hENN1/Z0nrdec+2DtWRl7NS4ATfLKOZ090SX
 PAyFciI+4qYQW/cnQ7h97BvFg2+RMXp1epkCHWg==
X-Gm-Gg: ASbGncvke6ZFCt+edySkej0l5ivoxFGCjxEdEFDWAEHszDz9lHvavhxHA011KTvhpVh
 JyNSfi4KCciXhsVOIjFeMugdOGychFkjkaoS+9zmFeAENrfaWbD0foXNjsjZORmNOEhiX+UcE7Q
 ==
X-Google-Smtp-Source: AGHT+IGYYSZLmmJ9cP3fs0feJ1ZwJrvzAseeXH3WuhidRpG1bdiHiqLuUVqeyYyNs/I+vp/cN4WBwdxo1GD5gUVH6zk=
X-Received: by 2002:a05:6902:1506:b0:e5d:fe0c:8bb2 with SMTP id
 3f1490d57ef6-e5e245ef5d1mr372150276.20.1740076691959; Thu, 20 Feb 2025
 10:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
 <20250220135506.151894-6-ilias.apalodimas@linaro.org>
 <66808cbb-1252-4270-ba4e-cf0fb7413c2c@linaro.org>
In-Reply-To: <66808cbb-1252-4270-ba4e-cf0fb7413c2c@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 20:37:35 +0200
X-Gm-Features: AWEUYZkxp-xGEMeUkJyd4Eci4SfQg-zF74yB6P_JC26-RUm3KYwCJqdkvAvVz5A
Message-ID: <CAC_iWj+0QBrG_EZXK9=Kq2E+mvk0yG0SFrF9w1NJg2x7YWp=Nw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] treewide: Add a function to change page permissions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: xypron.glpk@gmx.de, mark.kettenis@xs4all.nl, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Sam Edwards <CFSworks@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefan Roese <sr@denx.de>, Alex Shumsky <alexthreed@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, 
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:01:46 +0100
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

Hi Richard,

On Thu, 20 Feb 2025 at 20:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/20/25 05:54, Ilias Apalodimas wrote:
> > +++ b/include/cpu_func.h
> > @@ -69,6 +69,23 @@ void flush_dcache_range(unsigned long start, unsigned long stop);
> >   void invalidate_dcache_range(unsigned long start, unsigned long stop);
> >   void invalidate_dcache_all(void);
> >   void invalidate_icache_all(void);
> > +
> > +enum pgprot_attrs {
> > +     MMU_ATTR_RO,
> > +     MMU_ATTR_RX,
> > +     MMU_ATTR_RW,
> > +};
> > +
> > +/** pgprot_set_attrs() - Set page table permissions
> > + *
> > + * @addr: Physical address start
> > + * @size: size of memory to change
> > + * @perm: New permissions
> > + *
> > + * Return: 0 on success, error otherwise.
> > + **/
> > +int pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm);
>
> Why do you not use the enum for 'perm'?
> That's certainly the API you're expecting...

Ah good catch. On the original RFC I didn't have the enum. Instead I
had raw values of 1,2,3.
I switched it to a proper enum for v1, but missed the function argument.

Thanks
/Ilias

>
>
> r~
