Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EC8C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 07:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D348043C;
	Thu,  3 Apr 2025 09:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mKVPFGWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B95781CF0; Thu,  3 Apr 2025 09:02:20 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2285780107
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 09:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so575842276.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 00:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743663737; x=1744268537; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7U2hE2fRCE4/44jku9CHBEQ679zTz5ionAMz/HTKCU=;
 b=mKVPFGWIB8DTDWIUNYoUxhKI4J6jZ0q0/4j0Cmn68/c+aVMApWn8tDtZ8qrc4hf1bx
 cOWvikNbrQQzW6+gx9lCFN7kiRS2AtDcOvZPPYkEyjVPdXcuSIcRdv/LW93bLxkbB/kr
 oUBkT4hQjDZltwfMrMJexm3g7cbEbNShZt+QYXPmyzn3p9j+/Dz0JpLz+EWfLPMFZPIp
 VFmlMCZb+GkJee/WPZ862ulUiETC8svnzqRMIj8sfOkxNeWMowFUrqCSPOqx63tD2bBJ
 bDtXYl9yw6I0KVDHfCFyh/ZqE6T5dKVKGka3boDgJooHqH8YrEc+QvzPCAAeVA1Mljt0
 poVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743663737; x=1744268537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7U2hE2fRCE4/44jku9CHBEQ679zTz5ionAMz/HTKCU=;
 b=YMJq7s9Aug/6qBvRX0Ivel7sTMkXYtoV8lTjxusGIFjQ7aotLgaUaDzojdJgBQ+Nd+
 ponnodz87GQN7CHlWnldduCeXYPnzeSL34QuO3eTW0caBq220a838cS9Wg46OCs5hBAi
 bJZLRuxHKnPXIL0KKpPnTMX1jhnlHKUb0BKxr9Fk9aCs9bEM0SiE85RisiEAxooETyXg
 ggD6o9bx4EKbXYhmdF1odV6DdoRh8TKTw+V3VYGToN0njn2tlKm6x1HYH+mcHFSdS9Lo
 KA9tvCVLwCYyXd+F09HQZwEPwhF7RwXSxj2yFSVsFAc1o8lv1MJ88BM0ov4UYvkrZ5WX
 QoZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/Hq8pnQeNjx+RduhRVdVNcfv+NMpyrHvFtRR45AhN2hkTT8uNyaDnYJQcY8JCoi3M7tBogVE=@lists.denx.de
X-Gm-Message-State: AOJu0YxUlVW892DfWbnYzbTU2VjFeGm732ddZGxle/+hJ1eIi6x41l1e
 SaEXLjJJukROzET5XGmKGp5lCFTBr+1HugwhmmOZ2yS7fsFxX2NVPNP/eofnjdHrNQfGoGrm26G
 j1uIlz1rNpLx4Mb+/VREg09qgQ/7qMlwhON126g==
X-Gm-Gg: ASbGncsSTB1jJE8mNV+CgQupQorq3nEW+rg2L10OPYvWPIQwZKf3EJez8N8wFPVY1bV
 6DLLfr2BTfjtXwbHLeFS3VIT74uF5SNhRFaCT5s/goxnamzGAJfI6KK6N8Dc7P/u/DA2bjpJg2O
 xOlhyw2pEAVCxViRWTM73tEsV95iZsYZ05Gmw=
X-Google-Smtp-Source: AGHT+IGQ1srp5BBfo/mmk3XdcZcEAZ5cqD7dXKwFGSB9EDcbbSzyf8dMv4V4Xxf9t+y4BSn05qPeQZc9koefjpzWFY0=
X-Received: by 2002:a05:6902:a04:b0:e6d:deb9:6381 with SMTP id
 3f1490d57ef6-e6e0a23315emr2624600276.43.1743663736964; Thu, 03 Apr 2025
 00:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250403053444.2551339-1-ilias.apalodimas@linaro.org>
 <CAC_iWjLTUgocaxOPDtQCGS==yjV=66_=37nFv-Grv6b32FNDYA@mail.gmail.com>
 <e23ce969-3cd6-4bdf-9119-d0175806ecd1@gmx.de>
In-Reply-To: <e23ce969-3cd6-4bdf-9119-d0175806ecd1@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Apr 2025 10:01:40 +0300
X-Gm-Features: AQ5f1JogodcAVVakiLxnJLCbo7gfWLLlj7xYIQhaXeBTBjUTqiOWoI0-mWnh-Co
Message-ID: <CAC_iWjJ56Et24FUcVn38t_hAWDFe-Q=NLxEfgpLk_WmGbgDKOg@mail.gmail.com>
Subject: Re: [PATCH] acpi: Fix table length for QEMU
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
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

On Thu, 3 Apr 2025 at 09:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote=
:
>
> On 4/3/25 07:53, Ilias Apalodimas wrote:
> > On Thu, 3 Apr 2025 at 08:34, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> The end of the ACPI table is set to 'addr' instead of 'end'. The ACPI
> >> code for QEMU relies on those values to mark memory as 'ACPI Reclaim'
> >> and as a result the ACPI RSDP ends up in Boot services Data.
> >>
> >> Reported-by: bjorn@kernel.org
> >
> > I obviously messed up my reported-by...
>
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks Heinrich!

Cheers
/Ilias
>
> >
> >> Fixes: commit 638cc363484b ("acpi: enable writing ACPI tables on QEMU"=
)
> >> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> ---
> >>   drivers/misc/qfw_acpi.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
> >> index 0d0cf7646890..77cebae5e3fd 100644
> >> --- a/drivers/misc/qfw_acpi.c
> >> +++ b/drivers/misc/qfw_acpi.c
> >> @@ -305,7 +305,7 @@ static int evt_write_acpi_tables(void)
> >>          /* Generate ACPI tables */
> >>          end =3D write_acpi_tables(addr);
> >>          gd->arch.table_start =3D addr;
> >> -       gd->arch.table_end =3D addr;
> >> +       gd->arch.table_end =3D end;
> >>
> >>          return 0;
> >>   }
> >> --
> >> 2.49.0
> >>
>
