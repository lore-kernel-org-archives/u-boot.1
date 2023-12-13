Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A18C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7CCB87889;
	Wed, 13 Dec 2023 21:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GNTvgYhm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0BE38785F; Wed, 13 Dec 2023 21:39:19 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64EB287877
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2cc3f5e7451so5766511fa.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499952; x=1703104752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EJhHCYTvdfqAsoWE/57E47xi9ewwRhGJ5K+vylmFnxk=;
 b=GNTvgYhm3nM8cszViev1zJnmbELfdHlXnU8uHJkV7WzWJe45AuWkOfXq/TH7VVxbXc
 obVcrPGk9chEo/uP1ScsRHVH7DvCESaKcUAAzd+0KYWH5TrTgSHGtte+Fz5WN0bIiC9k
 LlYsIEJIGmXxKMbtYj4WpTM99+RH2L8QuR7iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499952; x=1703104752;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJhHCYTvdfqAsoWE/57E47xi9ewwRhGJ5K+vylmFnxk=;
 b=IFDlNJXigEtzDREJfCwrQ4PydKbp7N1Rf7Kx2q+in33VGfYMIr+Li33SKIVmIz0YkR
 fmP8ZFHw7VwUS5DQ8cXkBQ8l8rBRehL3N9E90zrPSO5she/0mpHrJSC+ZVjYzA3UJscd
 Q7TzJg7JbQqQ8BYCKaCfRJTS4QK7RDy1rq9zaWX8RYF1Hosn1L9ff0B+LzBePv4fyV1t
 uQwEltI1Qq0I/EDZ9TQvziIq8GWXHGcnznM1rR1LZdnUIRW+9PEGBLL9D3isyT+He2CF
 EDH+J6cmkmz78NJ1BJI0uQRHBqKaI4xK99iMlWnofFLYe/OYxJL//BKLQqn7wIIhIwrN
 MIKQ==
X-Gm-Message-State: AOJu0YyxybSRpcislvERi/fGI5VIxaBE60CutkAa9vsGZTxtLiar/Skk
 OgdSrVc1KGM4k/ua/TLwozflDY9uetsQHCiJVlLkjg==
X-Google-Smtp-Source: AGHT+IGpEzzknSNZt6oV/j8M30ztKS1HKm5Z9le1MNjSjxKWZjs/Y+0CWjDXvCTFlcQJmaLub0RryT0aStJScbLl0fE=
X-Received: by 2002:ac2:592f:0:b0:50b:fce6:19b3 with SMTP id
 v15-20020ac2592f000000b0050bfce619b3mr3952328lfi.78.1702499952364; Wed, 13
 Dec 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:05 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2oYLctyOAqfL6yq01veqJt1Y3RS-gbcOBt4XWoU9qLSQ@mail.gmail.com>
References: <CAPnjgZ2oYLctyOAqfL6yq01veqJt1Y3RS-gbcOBt4XWoU9qLSQ@mail.gmail.com>
 <20231121144128.20256-1-heinrich.schuchardt@canonical.com>
 <20231121144128.20256-3-heinrich.schuchardt@canonical.com>
Date: Wed, 13 Dec 2023 12:39:05 -0800
X-Google-Sender-Auth: bzY0X3CAN6oLGSCLIDSkMCEn-r4
Message-ID: <CAPnjgZ252AVtOp6WAqQ0e3-gmYbOqXcN6d1_cTB3TxXVat7aGQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cmd: acpi: fix acpi list command
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Applied to u-boot-dm/next, thanks!
