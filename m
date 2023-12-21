Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BFDC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF9F18767C;
	Thu, 21 Dec 2023 22:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dp15QKn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9660869F7; Thu, 21 Dec 2023 22:16:14 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B874B8767C
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d3a9b9634dso37455ad.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1703193371; x=1703798171; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krzE7ZE5xgTkSF/pawgSl767dewjnI5Xo7TxEUurYfs=;
 b=dp15QKn1HxHbg68sNwgpsXVOFesBpVta8H51pzAQkJ+79G2EJev3F3fEbf1+UO5tU9
 srSse/gxd8oqqijmW3F6QLnbL85PPaJeEkBe9/7IM3IkXB+zCgNe5+1esxCMo93QJ15+
 O3RaeUwvRzVGC3jp/3r7x5LR8dQlHC5KTknAgAbMJ4L286cKD83lI27xA9nzP/G5UJsX
 qDfj35bkDbTv+VQeAkVvJ2TwjrNGMhrPm+d/RBtIdu+YvEYVD1+0AK7C4tep1kjBl61Y
 GJ7db2Hyr8TE1cFS41WFqo4tLDh0IHABW4YqLa97MCQMA0yhw9cQipxke4AKFZvIBr5l
 SeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703193371; x=1703798171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krzE7ZE5xgTkSF/pawgSl767dewjnI5Xo7TxEUurYfs=;
 b=ftDQxWDWyC25Lwf6wdvDvlSMboHOZo/MtXB+UtzWYIRwtIxWWx2SllHJwwWq4ZEh8f
 5aabQdRwQBFXHGDYqL4RHYxgKufhjzg/y2UNQ6ou6lAWJVP5sqp561iFF6pJdf/MVeTZ
 Ly25qryt3gloBwiXcehz5YUCjO3lEs57EL5MtT2aRyZiorojF5ldbTiw5PLfUrrBauFG
 Jo26OaDBmxUhT/XiuJfGAbQaKkK2PiaMvwg9jHgpw+v1cdlkcrFyUYmmoX6Ok+WXXqi5
 gKPfmV/tsc0d11r/FynEgClKpei7NSITEMCeAymbuQH3F9VeI/aSoRaX8PYv8rC+rYKm
 RP2A==
X-Gm-Message-State: AOJu0YyXX+Qj7fb1dBucoxitqlLxVeQOo1C3apemwmQQgjpGixXH1jc/
 ExJwkcEzJb60U6ufJRjaM6hy/2Kv9Mg50aZ2lPnLiNOyq2vv
X-Google-Smtp-Source: AGHT+IHUTW3rkYoygdgu94vSwcS9wnzOMY5A0NE00H9g8biG4jZvCGq8AoimVW/wb6O6I6EEZMS73EX7hFIZYvPH/cE=
X-Received: by 2002:a17:902:6503:b0:1d3:d293:7767 with SMTP id
 b3-20020a170902650300b001d3d2937767mr324plk.7.1703193370806; Thu, 21 Dec 2023
 13:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20231217005209.2789651-1-moritzf@google.com>
 <20231221175341.GK2513409@bill-the-cat>
In-Reply-To: <20231221175341.GK2513409@bill-the-cat>
From: Moritz Fischer <moritzf@google.com>
Date: Thu, 21 Dec 2023 13:15:58 -0800
Message-ID: <CAFyOScp=vSYFg6HB0MAKFQvEDqt78M8XhZwaJaFQ1nG-ooeigA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] pci: Enable dm_pci_map_bar() for 64-bit BARs
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, bmeng.cn@gmail.com, xypron.glpk@gmx.de, pro@denx.de, 
 marex@denx.de, stcarlso@linux.microsoft.com, u-boot@lists.denx.de
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

Tom,

On Thu, Dec 21, 2023 at 9:53=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Dec 17, 2023 at 12:52:09AM +0000, Moritz Fischer wrote:
>
> > Allow dm_pci_map_bar() usage on systems with CONFIG_SYS_PCI_64BIT.
> >
> > Reviewed-by: Philip Oberfichtner <pro@denx.de>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Moritz Fischer <moritzf@google.com>
>
> This causes a failure to build on qemu_arm and a number of other
> platforms, thanks.

Argh, yes, I got got by the IS_ENABLED(). Switching it to #if
defined(CONFIG_SYS_PCI_64BIT) makes it work.

Sorry, let me resend this.

- Moritz
