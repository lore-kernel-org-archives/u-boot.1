Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7837AC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECAB87773;
	Sat,  2 Dec 2023 19:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hf3Ywgc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E7E87760; Sat,  2 Dec 2023 19:28:52 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6584A876F8
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a1a22b7f519so222847166b.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541728; x=1702146528; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E1o6/RbjgX1cm9SA2uJ6KByDR0OUn9p457auJJjGdJ0=;
 b=hf3Ywgc7kyp7YzrAeuFwDF2pnz+iJx57r70oyfGI5tpIaHKqrc/NprkBcI6+Qi4mn5
 vBF/G+z7WfAmPfYWbNuFko+/jguKiPd0t/xjjx0EenADnKNw5A8dYQAaGBk/tynVE9l4
 NBZ4cG4ho653GdLNQEHX91ZEfUEQ1ZuRmBPxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541728; x=1702146528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E1o6/RbjgX1cm9SA2uJ6KByDR0OUn9p457auJJjGdJ0=;
 b=CSHFTuhk8Y6is5f6n2xSMhnwblxdGC66wHH78dRKxRRmxloswA/e13pBm0i8B97pah
 JTml6FODXeBJVJhpFbk75bWI9ay37pj5sieaIoDFyl40JLxkCYFBh32sjxtzPf6HeY0/
 o+acqAv0DFlAwhI5wUrC9BEG5ePJ/kiO2pWcxNoKy0G9Z8jIqEkvxaTXobkLOuBdZ3XM
 +4vBvpF0DEaE6dpblaHSyxQvcOc0j7OkKJi2wsVnkSX9flcaLq4gpkJAOTWh59kLNocO
 otHX19yq4kjBqHd05tqcDjebLEV7O7cgetr3BJX4tq0eLvsjF/Z3BZZWzdTh3icKOMRk
 8pGw==
X-Gm-Message-State: AOJu0Yx88KzcVKCzlyRvKG0gHq207TaIRrpZk5SA+/hdlq3+Da4LxmF3
 dpnpSKhoDGSbteGHWPcmhZYOmuQExUFe11OMepqEaA==
X-Google-Smtp-Source: AGHT+IF6HIeUYRicCnWB16OwZXiiOebZJrT4YNuAzQM1otnqWfBML7/0XC1cAj+EKRXjZZxppNxS+xtmMQNnF1c0loE=
X-Received: by 2002:a17:907:75d1:b0:a19:a1ba:bab2 with SMTP id
 jl17-20020a17090775d100b00a19a1babab2mr886181ejc.88.1701541727714; Sat, 02
 Dec 2023 10:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20231121144128.20256-1-heinrich.schuchardt@canonical.com>
 <20231121144128.20256-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231121144128.20256-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:27:25 -0700
Message-ID: <CAPnjgZ2oYLctyOAqfL6yq01veqJt1Y3RS-gbcOBt4XWoU9qLSQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cmd: acpi: fix acpi list command
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Tue, 21 Nov 2023 at 07:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
> to check the presence of the RSDT table before accessing it. This leads to
> an exception if the RSDT table is not provided.
>
> The XSDT table takes precedence over the RSDT table.
>
> The return values of list_rsdt() and list_rsdp() are always zero and not
> checked. Remove the return values.
>
> Addresses in the XSDT table are 64-bit. Adjust the output accordingly.
>
> As the RSDT table has to be ignored if the XSDT command is present there is
> no need to compare the tables in a display command. Anyway the
> specification does not require that the sequence of addresses in the RSDT
> and XSDT table are the same.
>
> The FACS table header does not provide revision information. Correct the
> description of dump_hdr().
>
> Adjust the ACPI test to match the changed output format of the 'acpi list'
> command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
>         deduplicate code in list_rsdt()
> v3:
>         consider map_sysmem(0, 0) != NULL on the sandbox
>         adjust signature of list_rsdt() and list_rsdp()
> v2:
>         add unit test for offset of field Entry in RSDT, XSDT
>         merge patch 2 and 3
>         remove leading zeros from address output
> ---
>  cmd/acpi.c     | 64 +++++++++++++++++++++++++++-----------------------
>  test/dm/acpi.c | 18 +++++++-------
>  2 files changed, 43 insertions(+), 39 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

I really don't like using 16 characters for a 64-bit address. I wonder
if there is a better solution? But at least it is leading spaces, not
zeroes.
