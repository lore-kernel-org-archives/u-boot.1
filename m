Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E524C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 21:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 750A5807D9;
	Wed,  5 Feb 2025 22:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zrq7iPvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3AB08033D; Wed,  5 Feb 2025 18:35:53 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89FD78003E
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e460717039fso8155276.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 09:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738776950; x=1739381750; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yd0Vwu8VGL6Fj+uexT7mnPw1rUpbtrUweDt/xFy/Gxg=;
 b=Zrq7iPvoASTscJOPEZP5YU9vQkUmq0y3HvEQ2RdvjSfdNbeDq5J292AXFbWtdoj3BS
 00G3FVazq4ccNku8pPP0UYfjmpXKhk19uVstomU9e/gqGmuEzExZ4WOQBRvJ2ial9SeL
 9odbMpn+rzLJYv6FrPjHYdPLI3G+N2ltfRyZqXjVF3LcNVMPQhgwdMM844OsQeu3ESgP
 AWBzbzjAMKGbMz9u5kH4x+ksfcwOoegubQxUMLoge7mLQ3ifKAgA0wILun9NWMkLyQL/
 /zS/IGLa+UcO1mST7/N5iekS+hQ/yCfqaq+bkTCf9kOVT51AS9sp5hsmWBV7VLJAq/G1
 mCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776950; x=1739381750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yd0Vwu8VGL6Fj+uexT7mnPw1rUpbtrUweDt/xFy/Gxg=;
 b=fnPW5bI++tPgkowNk1nRc89EQ/xPgr5QQ2POwrT6JnEErgQzngFPTNIpUHUOCrgkH6
 Lhr/4vPdq/OYN9XwQTXxYM7I4nUVBUX4Tafl1tS088UcEKeZDwObSdTdLGqNZ+S3Plzb
 L9yLk7a+P3+AWh4JfgwLXo50cPN3YzmJ/RIBlu6vNxxPDgr5R7SKtyvUrm72lrrklr+I
 vHvzUvKq51D94NSIQGjVHAm7Wpeo2q5wnLza4S9gkNIN1O/2xvwMr8F31NcOpSMKighL
 Z4ZhfUknFdpug25LmOX139LrkY87MLNvbDsfISdEVgXV/BN3BPKs9ize5MpfO4CosjCC
 KvhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqv/Ob0rsSkYDxBSECGmVwCXYEkB/cHZdSQizcfHh45xlufKb64gH5fXtS1t1shkmA30jzUd0=@lists.denx.de
X-Gm-Message-State: AOJu0YxTVfv7948kdBDgpia39H5nT0vS86Be1IIFhk2NYyZuL34uqm6t
 jH4gMXhbV4BX8M3yjN7gIwvoaxWj/Kxqv8U0cnfI5tJsH6y/ro6khRAy9FGK0mJu9Zc2gU3h7/b
 9NCCkvNmfup/gwC44C0L09qyTllve29WLmJl63Q==
X-Gm-Gg: ASbGncushFY3u2qHb5HeMfNQVKYPCSMsqsUDQx6NFENuQ0MuWLco8I80lpUakyxg79L
 Xodpahso/WRFfy3tjA6lrkKJ5nXe6PRoupy0FTDt9hdBZnncH83fmv2yjhyLnNo9FYcJ9ywWs
X-Google-Smtp-Source: AGHT+IEMSi7EBUt98aDQMMT3u3eRO24HtFgOvzVllTF1FY3GHJqdATQr6UpAaoAHTkm/ehxvHZBjNrh5xkX1W7RVOm4=
X-Received: by 2002:a05:6902:2682:b0:e58:68b:b079 with SMTP id
 3f1490d57ef6-e5b25a0433bmr3167160276.17.1738776950381; Wed, 05 Feb 2025
 09:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-3-ilias.apalodimas@linaro.org>
 <20250205172215.GX1233568@bill-the-cat>
In-Reply-To: <20250205172215.GX1233568@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Feb 2025 19:35:14 +0200
X-Gm-Features: AWEUYZkKU9oi05JYAaPy0dLRIqzpvROCiQWOLC1Fgn7Rlp3yxpdarUzwy84MSMU
Message-ID: <CAC_iWj+kYcFJ4R+XKdWproOKL-br1VtxtSHgvZ8QXw=5Dng7Bg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] doc: update meminfo with arch specific information
To: Tom Rini <trini@konsulko.com>
Cc: xypron.glpk@gmx.de, Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Sam Day <me@samcday.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Alex Shumsky <alexthreed@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:30:51 +0100
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

On Wed, 5 Feb 2025 at 19:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 05, 2025 at 09:16:46AM +0200, Ilias Apalodimas wrote:
>
> > Since we added support in meminfo to dump live page tables, describe
> > the only working architecture for now (aarch64) and add links to public
> > documentation for further reading.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Generally looks good, a small change however please:
>
> [snip]
> > @@ -26,8 +27,9 @@ The layout of memory is set up before relocation, within the init sequence in
> >  ending with the stack. This results in the maximum possible amount of memory
> >  being left free for image-loading.
> >
> > -The meminfo command writes the DRAM size, then the rest of its outputs in 5
> > -columns:
> > +The meminfo command writes the DRAM size. If the architecture supports it
> > +(currently only aarch64) dumps the page table entries and then the rest of
> > +its outputs in 5 columns:
>
> How about:
> If the architecture also supports it, page table entries will be shown
> next. Finally the rest of the outputs are printed in 5 columns:
>
> This will make sure that when the next architecture adds support the
> documentation doesn't need to be updated here (and the temptation to
> list every arch that does this will be resisted). Thanks!

Sure, this makes sense.

Thanks
/Ilias
>
> --
> Tom
