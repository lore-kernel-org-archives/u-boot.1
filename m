Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A52EE6B6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 00:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49B9383693;
	Sat,  7 Feb 2026 01:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FXBRZql/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D190D83AA7; Sat,  7 Feb 2026 01:02:45 +0100 (CET)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80FCC83642
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 01:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-1270be4d125so1980968c88.1
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 16:02:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770422562; cv=none;
 d=google.com; s=arc-20240605;
 b=M7kfi8Tfs+Um1Hz63Np+0nExJA3FIc/PPPdbi61DBke0CMshat36+/JN4Zmjfu+hBF
 x+LlqI7YQO50NzLSLD4ypVgAubivpgF9ZZvf/CKgYUH83N9z9lYhxic9EI9zDYFnEB/e
 dX5g7dKraKiUw7YkL0TH5KkNGFNEPDv02hNPcWBcGALpL9DrsDOchuA+jT8P6NMSDwKI
 9mFdsMWl6AKan5fYEzTpt3LhHlhFqrs1EjTYM2wLIOErdHaZBlcCPPcn/LYujRspvM97
 IHMlCy2oES+nFeGgkknG7xEFpn2iPlvrM3zq+OOXmKf01J09Z9oRQTXALIQdteM+5b8X
 EsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v56w8kOiKuBvj1IXo4y+MX9EkBBaYk9JXvKT+oFAflw=;
 fh=qZ3s20c7bQLStgy8mb1N96wUDADWp3ib1XmXEiVlhFI=;
 b=MJIdLB95JFPho6qKA4Mu7ukHi0YN/AzRffbMbWJthlhnWhlizd+HyL/R1IBJXPDVkI
 I8csIdiJnIekfvqX3Ti2OuoYCn5tgp7u+/U4Em4eT++5/gc804rbvqlLRy3kY1Zx6oPl
 svDSo4CF+rfjQvLBrZlXImh2D/SmVLJxuFoYniirKkDNmCN0xeBJMYi4iMZAcQfa5zbj
 j5Z+rc/ZcEinBs9XdDyoRXIafe/xNb1Tx7EEVGvugp9nClbgc2cVp+SllRSQSwt7v8+r
 Sg6MBm3Dwt760620dBu70Sg/wHJqafUQ1nTTrrBrvj3XgbEwz1l9v9d/T4c0ANCc2zrJ
 SEIA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770422562; x=1771027362; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v56w8kOiKuBvj1IXo4y+MX9EkBBaYk9JXvKT+oFAflw=;
 b=FXBRZql/p/swpMGrQyCJs2itaiD4k2/lhyFVLoAFYJO6m3HlLdBvckhBsGUIEwX6xK
 LTdw9T+0UsbnQfcIY7yJm1Cisz/KvSVv5DG05OV3VkWW6lmaIW9ROgVxm72ShGzjBK1R
 GmGAPtwoWONiVyUQuXfo0cmKPHBUYYnZFvhDn1Q571czCLMwaaD3D3OgX29An9ivRe0k
 lAVDMlv9jdKoeKuMg5Lnmg3NS6pxVZZv0UQ8bwcH/guEgNTVVYFQ/0p2/dAWGG+7Xxfs
 lrEr+yosxIH99TY8ZVcBGABwEUwoKmEzHjNpysxxkmTJuhZjZ0HuZqrof3o+CUV0Gnk4
 8k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770422562; x=1771027362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v56w8kOiKuBvj1IXo4y+MX9EkBBaYk9JXvKT+oFAflw=;
 b=rytSLxjTsfzLoyAGsvWh/8XEt3l4PxsQxVnXc0yiABoqq2zgIak+0RxVrHKau3m5FA
 WfVqp6rnCDThO3IEIENc/mj35UYlKj9oqZsX6+EIPNxF764oamKBfZrKncmqOSjN5pUP
 BTjlXcqqumGV88F3ugHhRWqG0JbdkarcZj1d0fDC1sNEKoxngYmNEBewV4/zUK5we+JK
 f0laeB7d9l3F8RSGwzwfgm07HPxU4zTUxKcX3UcYmnUgyiwAMk9Dhi8mGH5cDoberh2o
 tDpenWpatgNb715hTylboLGOhQJhvaQ00PgcyyEmNHwqMakfLAcBrWV0gDSMV8Rp2Jxi
 E2hg==
X-Gm-Message-State: AOJu0Yzgpj3orUsyA0QkdysfZpbDs79HNTPLbr5zgpQS/WG/1zSXdZZi
 SmO02ERnPYGU0KXKLIWSNIJw9z5WBfWrYcw8obZc3VO8inbftDNYf8o+w/Ki8ExzFZxFueJlNyA
 IX7ReflHNcwycrpnlvXO5dPmzSZqBKw==
X-Gm-Gg: AZuq6aKk39W+rquqLQLsUOQ+C2CVCAb+6L8V26pNAb1wBlbdx7GoPsPUtClufrel9qY
 lUrAMo9lRgDPcZDJSw2xvbd0jkg2WH3cHTZQ1re80IV9wc+qzzGBZ+SF3IEw/lE7YLuIgMu972M
 Sfc8yhjEfpqgY1dSnfKFdzxmtt+8ZNbPjKzn1+ZyU9oMDR1vO4sJScWsVsVYU8WgxOnHsLVV9Wr
 90R2wCNJfv4cI4ddDBKW/HmVb7UViY5IAqtw+pxnOdLkOgBdEoKIA0ftZPZwSZFa/qGPG3/uhBv
 67v+B47LYLPJ3HsuBBZWkTsVuxo=
X-Received: by 2002:a05:7022:43a6:b0:123:2e43:ecbd with SMTP id
 a92af1059eb24-1270407229amr2586610c88.33.1770422561725; Fri, 06 Feb 2026
 16:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20260130183635.2612933-1-trini@konsulko.com>
 <20260205234158.3768337-1-trini@konsulko.com>
In-Reply-To: <20260205234158.3768337-1-trini@konsulko.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Fri, 6 Feb 2026 19:02:07 -0500
X-Gm-Features: AZwV_QjmX6bJAfPzB_y82ckE9Nvs7M4N4JDFNl4RXK9VMrdwpTPQJZJbVW8FhMk
Message-ID: <CABdDSeWvfd2vK2ykQb12YrXreaq7oiuHDktgrCm+c94_6aj=Mg@mail.gmail.com>
Subject: Re: [PATCH v2] arm: spl: Ensure 8 byte alignment of appended DTB
 without separate BSS
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Brian Sune <briansune@gmail.com>, 
 Phil Phil Sutter <phil@nwl.cc>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Feb 5, 2026 at 6:42=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> Which means second, 64bit ARM platforms. With the exception of:
> socfpga_agilex7m socfpga_n5x_atf socfpga_n5x_vab socfpga_stratix10_atf
> all ARM64 SPL_FRAMEWORK using platforms use the
> arch/arm/cpu/armv8/u-boot-spl.lds explicitly. These other ones set
> CONFIG_SPL_LDSCRIPT to a non-existant file and then fall back to using
> arch/arm/cpu/armv8/u-boot-spl.lds. There are only 4 platforms which
> don't use a separate BSS section and so could trip up the above as well:
> r8a779g0_whitehawk r8a779g3_sparrowhawk sc598-som-ezkit-spl sc598-som-ezl=
ite-spl
> I have inspected the Renesas platforms manually, and I'm a little unsure
> how this case works on the two sc598 platforms.

Do you recommend using SPL_SEPARATE_BSS on our platform? After power
on, the sc598 has 2 MB of SRAM available starting at 0x20000000 which
we treat as just a single block of memory to use for all of SPL
operation, so we don't have any requirement to do something like a
bare bones DDR initialization before using it as our main memory for
SPL, so it didn't seem necessary to enable. The boot ROM has some
guidelines on where it will place its stack, so we restrict SPL to the
first 192 KB currently but this can easily be expanded. I'm not sure
if I should admit to it, but some decisions on Kconfigs were made 4
years ago as an arbitrary choice during our initial bringup and then
were not reviewed because things were working.

Either way, works for me on the sc598 + ezkit. There's no reason for
it to fail on the ezlite in that case either.

Tested-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
