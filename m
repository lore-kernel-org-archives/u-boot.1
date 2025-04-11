Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E78C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 10:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A3483F85;
	Fri, 11 Apr 2025 12:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cS85mj8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD36283FA4; Fri, 11 Apr 2025 12:00:48 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8568782B1F
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e609cff9927so1281877276.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 03:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744365645; x=1744970445; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y7wrQCRVI5bxZqjqbzq0vRyvgtarLSnjzkjQtJf5ZsU=;
 b=cS85mj8v0C3TBLkBOokQR8hwaewIcchZ3X4jQACLksrmQlNnhpsjai2ZZOeCe3HJae
 pFbRCPzHnM9cNfkLYLEiQKeeq4KzKaOjQ6izQNbmh/uQjKMC86tAX7XOxpMLuh0psDv3
 5+cHtwiA5Y/YxdXqm/2rfLA9PCOvznRP5zjnZoZ7v4dyqxgHhwSLH6BexoWiPVagPs6W
 wXlYJx1VeyXBUUSqnyHvQKEUEmljsGYCeavLSRLnEdhmCrgcQp35PVyhjpecD6DOSww9
 4oFGpdS5KEz78g+eSoygSPyVaZ4VydScE8SNzh8yXRykytOlHA+K2+/FYUIXT7mi3GaN
 oH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744365645; x=1744970445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y7wrQCRVI5bxZqjqbzq0vRyvgtarLSnjzkjQtJf5ZsU=;
 b=Otkrv42jSGtMyjXtSQARNq4uAnbopDWXoZYl53TUnXvkGV5q1oZfifv2fh705MuIvr
 mxoD6zvWZQrl305wZZqsKXVfGgSiCOMRpzi0MBYKXa5oE/sjE6xxbaZxGY7yz0KUGhD4
 tlvYcHp05aB5QnnKPR820NhKbnRp8chxpkSeTWLI2diPLKvQBSCI5lj4byMjoRzYrHGq
 IUtL63+mEyFTwF5wh0k7np0cZuX7ElefbVlxGUBbbP7QyVYAJOqhejko1te24EJw5rzY
 29kr35U3NaKkXJPLzuvubdUU+26XDxg/hbWcagLjocVrpL5GwmpP2gAvw+jVtM+Zgq7H
 Fx9A==
X-Gm-Message-State: AOJu0Yy/qBPcbz2MUppwanrqnMB711TOVV18O2yiw4IPG4pwQntHdmP0
 6mmwdS9wSi1C8mrN0WPnokqaEUZVQIUinsOvck4zQV6QUW0f7ccwaEVNzIMxUXjff7xPlmwMGdX
 oKDQCykoK7j3jAOTiQFU4ZxVDNyVuoEXYZI34i3u7w3ET2YsEFbg=
X-Gm-Gg: ASbGnctL7TculTkBWQC6LVIL960eQissBXIi5Ys1CQltoTP9plr5E6/Crd2nBLikypg
 YdWSUblNIwAHb6F9VCOQTZXOzw0NQS6uTNpwXQj9VmbMebxfkIElxufCDco4Wd2+o0zK0p1aSEO
 eb9Ome8RciE/0aTuZb9ekhhlA=
X-Google-Smtp-Source: AGHT+IEHevqMuWZ0moHH/+6M2YqMAV1RShmqqNok+ykC1sbOiQ5rwXVFyg2eoPi3VAqBcGykvKakQf0NC65A1vwQngM=
X-Received: by 2002:a05:6902:2011:b0:e6d:e063:d552 with SMTP id
 3f1490d57ef6-e704decf48amr3360245276.19.1744365645339; Fri, 11 Apr 2025
 03:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250411053256.17332-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250411053256.17332-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Apr 2025 13:00:09 +0300
X-Gm-Features: ATxdqUHT_dNw8SfcChXk86FbHaoUnYpaugyLsvJaMyymf2-h9fqcM0Blg-M4eHQ
Message-ID: <CAC_iWjL+L4ad1hfz1a5J2ozUPEwmwkZSZRuU3_mb-Qz4LG3KKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: check executing in EL2
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

[...]

> +
> +/**
> + * current_exception_level()
> + *
> + * Return:     current exception level, 0 - 3
> + */
> +static unsigned int current_exception_level(void)
> +{
> +       unsigned long el;
> +
> +       asm volatile (
> +               "MRS %0, CurrentEL"
> +               : "=r" (el) : : );
> +
> +       return (el >> 2) & 0x3;
> +}
> +

We have an identical function in arch/arm/include/asm/system.h, can we
use that? It's static inline so you may be able to just include the
header file directly. Also, that function adds a 'cc,' which tells the
compiler that the instruction might change the condition code flags. I
don't remember if this is needed, but it doesn't hurt to have it.


> +/**
> + * execute() - execute test
> + *
> + * Check that the exception level is not EL3.
> + */
> +static int execute(void)
> +{
> +       unsigned int el = current_exception_level();
> +
> +       efi_st_printf("Exception level EL%u\n", el);
> +       if (el != 1 && el != 2) {
> +               efi_st_error("EL1 or EL2 expected");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       return EFI_ST_SUCCESS;
> +}
> +
> +EFI_UNIT_TEST(el) = {
> +       .name = "exception level",
> +       .phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> +       .execute = execute,
> +};
> --
> 2.48.1
>

Other than that LGTM

/Ilias
