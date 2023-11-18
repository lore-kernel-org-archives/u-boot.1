Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C9AC5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E852874E4;
	Sat, 18 Nov 2023 18:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UGb8xzXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25FB6870D5; Sat, 18 Nov 2023 18:11:56 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD1287252
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-daead9cde1eso2833248276.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uu2bV4oYXpi42oICHvj6jkN5m1jxTpH88uxOdKkPH08=;
 b=UGb8xzXxk9LhNmkamHB+2eeIOFBiGVv11BdwDQsmr3XzK+/rAD+qrjYNs2HqDmRz8F
 BeAqqo3j5zbCcDEDWX1NURkXJYO0F+Eoj+27yPZmVev4BrrjRMKV3rlZxp3Os2aK/xI1
 ZP9CGLLzddT18vukWWiQl7zbMHwSDh+NHe2Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uu2bV4oYXpi42oICHvj6jkN5m1jxTpH88uxOdKkPH08=;
 b=EDoCE6p+ooiGfrYCe/ZvrKs+s9Zg4cb8v/BPM5IniWMOjAhEEVTjlqzwNAwCJA4lyY
 /4de88eKDwhn7ItlUmmxjcyPFwD9++9xFJnOLjq2L/Wz4RFgwAhPAnOG4+QT7HozBlXQ
 KqH7sSjbWMePcVI1WxXQHNXE51sonUzKINNB7uilow5jdZCIV4GlX1cKfZO29tEg+gdc
 /JWaWXs5hiA7Pagnyrtr9dgl+s0cy/Ez6m4l3fxVolmrLbwIZA7zCPBqoJNuyelnbDYS
 /kasow33hGWuCuBxPO31lpj/FWab4qZSrIFiTnyCAWN2b+jqusTP3+vRegZEqt6pLXTj
 4kjg==
X-Gm-Message-State: AOJu0YwvoH/tkW+4g+foHBossLGhfUWiFvYtkKjMT/rFzfbIgQILuJIb
 aIWjaaE7j9oRBbCwV6aUvTvrfcH2+VULm66vHXc5RQ==
X-Google-Smtp-Source: AGHT+IHH1yQyGPhRUpI6pZKnu/C9B9A99rb7iymxEe+i8CC7s0yxiAJBBudI4HSbt7YPnz59s73MZJzq4QR/g2YYHRM=
X-Received: by 2002:a25:ea49:0:b0:d9c:66d1:958f with SMTP id
 o9-20020a25ea49000000b00d9c66d1958fmr2069545ybe.55.1700327504846; Sat, 18 Nov
 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
 <20231115142355.123038-2-heinrich.schuchardt@canonical.com>
 <20231116183345.GA170968@bill-the-cat>
 <86182fad-ba42-46ba-a504-9f3f4deb34a4@canonical.com>
In-Reply-To: <86182fad-ba42-46ba-a504-9f3f4deb34a4@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:12 -0700
Message-ID: <CAPnjgZ2JiOjwiEJ2p7f56SX2OFOp2j9ZZNqGwfQDBxkrMc6D_g@mail.gmail.com>
Subject: Re: [PATCH 1/6] acpi: do not write ACPI tables on TARGET_QEMU_VIRT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, 
 Zong Li <zong.li@sifive.com>, Yu Chien Peter Lin <peterlin@andestech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, 16 Nov 2023 at 12:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/16/23 19:33, Tom Rini wrote:
> > On Wed, Nov 15, 2023 at 03:23:50PM +0100, Heinrich Schuchardt wrote:
> >
> >> RISC-V QEMU provides the ACPI tables. We do not need to generate them
> >> ourselves.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   lib/acpi/Makefile      | 2 +-
> >>   lib/acpi/acpi_writer.c | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/lib/acpi/Makefile b/lib/acpi/Makefile
> >> index c1c9675b5d..19fa6ac869 100644
> >> --- a/lib/acpi/Makefile
> >> +++ b/lib/acpi/Makefile
> >> @@ -12,7 +12,7 @@ obj-$(CONFIG_$(SPL_)ACPIGEN) += acpi_table.o
> >>   obj-y += acpi_writer.o
> >>
> >>   # With QEMU the ACPI tables come from there, not from U-Boot
> >> -ifndef CONFIG_QEMU
> >> +ifeq ($(CONFIG_QEMU)$(CONFIG_TARGET_QEMU_VIRT),)
> >
> > The goal here is to say that we have been passed ACPI tables, and not to
> > generate them, yes? Lets just introduce a symbol which says that and
> > enable it as needed in both QEMU targets and others as needed please.
>
> These are the conflicting function implementations:
>
> drivers/misc/qfw.c:158:ulong write_acpi_tables(ulong addr)
> lib/acpi/acpi_writer.c:72:ulong write_acpi_tables(ulong start_addr)
>
> drivers/misc/Makefile has:
>
> ifdef CONFIG_QFW
> obj-y += qfw.o
>
> but inside the driver we find another constraint:
>
> #if defined(CONFIG_GENERATE_ACPI_TABLE) && !defined(CONFIG_SANDBOX)
>
> So probably we should probably have a symbol which is set for
>
> CONFIG_QFW && CONFIG_GENERATE_ACPI_TABLE && !CONFIG_SANDBOX
>
> Maybe call it CONFIG_QFW_ACPI, "Read ACPI tables from QEMU".

Yes that sounds good.

Regards,
Simon
