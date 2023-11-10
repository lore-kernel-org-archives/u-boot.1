Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668A1C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 11:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BCC876B4;
	Fri, 10 Nov 2023 12:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZQdVPG4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F0587632; Fri, 10 Nov 2023 12:56:20 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02E787585
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 12:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9e62ab773f1so87552966b.0
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 03:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699617377; x=1700222177; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0hXJyKwG5bgw8fASII6eVRQQ+2n3mcDo7NIzgS4qT0w=;
 b=ZQdVPG4y/xotf+BKAYYQlP4/J+E9Ac0EGjn2xL3fQfQiV7N5cO+tSntpCVMogiylBj
 e2i4K0JKcEqXy4Eo5Md8hzwNP6P3FswLaUxEnyLPkMLcgYAQsMqRYI7MmieDYCMNmab0
 gzOKo/Lvjabip3xagULXDXZr0ZPXsq+TXXZTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699617377; x=1700222177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0hXJyKwG5bgw8fASII6eVRQQ+2n3mcDo7NIzgS4qT0w=;
 b=Oge4RtdpShZlcDxd7XUknioQyNCp2FQIpO06t8eoNNUE7FTiRZWPoi1Pu9ScZIWky+
 k5KnWfK6qbCSHcYcCKIRLR/veMcMONWHO6nhhoEr1IT+8A6/19RopqSCYaLAD6CF2x61
 Ec71G1aaSZ4s2CGauqnQRV5iuQ3sgCq+PQZsE/0+L6nLgf4mBtcpgtsi0fdRCVzwhD+P
 Xha6c/wSeA6fDNrnxxoJolfgWhbpoqPTR2gGcZo0pAX/Ek00ApA3YtZ3eCLedezdAJ8Q
 RNXkxw3Ds8/FJm9S+cOMAN53qXnJ5NzpDRCaH+Exc5TrnOnYbPFWOlesOGOoJ2mItUEi
 DIpA==
X-Gm-Message-State: AOJu0YxSCh1OXyBu5ZYwb6kQPl1frOhTDwYZ7WgJKWBJEtK9U5+grsx2
 IG2oNXsg8mYr/0W9aoCtBILzVxP4K0jNTBudPkMOPA==
X-Google-Smtp-Source: AGHT+IGXbjpAhmvkhsPIH4hCCx0JIBJqvlU5IkJA3xi+mxpbGuLXAd0YeereZJdKs0C96DLFTS9PkBTZnCMMge/v8hA=
X-Received: by 2002:a17:907:1c17:b0:9ae:41db:c27f with SMTP id
 nc23-20020a1709071c1700b009ae41dbc27fmr7437409ejc.10.1699617376820; Fri, 10
 Nov 2023 03:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20231109172302.54324-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231109172302.54324-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Nov 2023 04:56:05 -0700
Message-ID: <CAPnjgZ1xqNh9Eo3AU=uA8wKbhup885mrJh9J+TAicTpKsZb0Gw@mail.gmail.com>
Subject: Re: [PATCH] acpi: move acpi_get_rsdp_addr() to acpi/acpi_table.h
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

On Thu, 9 Nov 2023 at 10:23, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Function acpi_get_rsdp_addr() is needed on all architectures which
> write ACPI tables. Move the definition from the x86 include to an
> architecture independent one.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/x86/include/asm/acpi_table.h | 9 ---------
>  drivers/misc/qfw.c                | 1 +
>  include/acpi/acpi_table.h         | 9 +++++++++
>  3 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
