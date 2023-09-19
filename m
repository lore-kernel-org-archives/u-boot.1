Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B02CD54A1
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E74286A09;
	Tue, 19 Sep 2023 09:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mCmqe/oY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84A7486A3F; Tue, 19 Sep 2023 09:58:00 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5ADF8648C
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99357737980so712140766b.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695110278; x=1695715078; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rW/aFjyQH8phEpY0DQ1L5psGiWbXLXrwiakBz9UC1+U=;
 b=mCmqe/oYMw5Fbq7Fn/rFFwlPNeGoynfN6gSOXk16nDkqNerKFoi6covbcYoWE0XbYI
 1xaOWrGpk/GCrBKXgeRYIj2D9ZiOEAq2g7iGQ++LPSsmFm40HdSBECQVuAZhYo98BoDI
 J00kxXZNLu85jZv49f5zXJBZ6zVpOS0GcHKDobl5MIlEdomREiFu0AbEjB74zXdQlUlx
 a3c74F0mhmGKno1JPs1gEYBL2SEXMOT+UJOT08FlkWO5iedM8bI/TbRxLR5mpiDshvnR
 eOtDAwckRzaE8lwknsSAB+2t3onLyxRflUFOuE0Qryo9TV5w7ud2fS0rJzmHeNoiOHBO
 XtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695110278; x=1695715078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rW/aFjyQH8phEpY0DQ1L5psGiWbXLXrwiakBz9UC1+U=;
 b=KDwVB97Y0pjoeQ1G+/4hD+cdM0YzJ6zgJR0lulbbwKNWo7nMu5Lr51TS9W0s3wAu5K
 Rj7TS0dbIWLdMAEO5/l4vjHMo7uqRNTfZI0jXFrxxDHo0xNwVrzdwwCbSG+jTAGo6oAH
 KDL0lY317zbryk92UGq1iJj7fLBCWzIAdvvtPQnOUkwwZ/ojNjTXvKlzolhgcHbZUwZh
 ph5XOl53mRBTmtJVyQxqpEew1l/muSDE+/CoGeP5oCYJ1TD5JgH4ClzQsp8NGoCbXyjB
 +QAqaHRmUC3JoJJNMbD3JOZxi0gMKnQs75B5MAf6gzMV0LF0pk3EFOvD3Dj6LRDDhmh0
 x3uw==
X-Gm-Message-State: AOJu0YyDP8w23Okk4+ySIJV7D5ziiGyurDvCAv7edp3I8y4ra/e9eNYM
 MDHO72fCxndIlqUwHCxa1ZP6mC1hOAcPLIRa2H7HMssTjJ0=
X-Google-Smtp-Source: AGHT+IHnZ0i9qtBfzHaRLp2F8ocuK+0r7tj6xzzIM9DQwLbZWy9wsYqIXwefoNwU3obim4ZlxPGWRzeOut/H2gQeDqQ=
X-Received: by 2002:a17:906:ef8f:b0:9a2:1b6d:eeca with SMTP id
 ze15-20020a170906ef8f00b009a21b6deecamr9514003ejb.44.1695110278169; Tue, 19
 Sep 2023 00:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230901112707.v3.1.I61008e563b1209243a9a7f2b66073b4737ff82d1@changeid>
 <20230901112707.v3.2.Id8d2f7a61003b53d62b89aab0523afe7184217cb@changeid>
In-Reply-To: <20230901112707.v3.2.Id8d2f7a61003b53d62b89aab0523afe7184217cb@changeid>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:57:46 +0800
Message-ID: <CAEUhbmVW-eYQE8Up5qUfgfz0GpQo1hxh_Xh-_85X6Zaj5N8m7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86: Prevent from missing the FADT chaining
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

On Sat, Sep 2, 2023 at 1:27=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Recent approach with FADT writer shows that there is
> a room for subtle errors. Prevent this from happening
> again by introducing acpi_add_fadt() helper.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/x86/cpu/apollolake/acpi.c | 6 +-----
>  arch/x86/cpu/baytrail/acpi.c   | 6 +-----
>  arch/x86/cpu/quark/acpi.c      | 6 +-----
>  arch/x86/cpu/tangier/acpi.c    | 6 +-----
>  include/acpi/acpi_table.h      | 7 +++++++
>  5 files changed, 11 insertions(+), 20 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
