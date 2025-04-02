Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61BEC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 16:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D90F81E1F;
	Wed,  2 Apr 2025 18:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C1pItY2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B5C81703; Wed,  2 Apr 2025 17:26:52 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8A58006D
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bjorn@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A54D6614AC
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 15:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCBAC4CEEA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743607609;
 bh=/txMtPZcQYMeDN0+OnIPAiIOOi/M6qU5DMRUyXOXn5s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=C1pItY2ZZa53dOiHgR0F89EXlX1EGWE6a7p4bu86MjK7SSgOcYQjsEFXlZ5+dhJqx
 VGiHXqLNNB2z5ZZMTS/3TTEB0Gdr0C1u44CENQa99IwIfADAVsjVTEdJpb7EpX+KQG
 AoVsQOP7IRIZQ7be5mOGy2/Iktdih2InRLNYDtXwtm45nETXk7qXwu55lmy8QtPFj3
 wK+Z9phSkbPHQ6GXxiOferxUcO67MRblOUKgcw8b8dh5JO/useOWTqm2M+2Ge4r7VG
 Oo1iskUIExY7eVV+NIL94/dGUJC2/3ek3FeNutmafA95p2t2Xxxcisn0OPLVFndErL
 GU04EZnOBvfFg==
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6e904f53151so58172086d6.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 08:26:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUuqibx9foeqCqPHAxDRXeHkYuLlzMfnC26LpT083q5ktxePOcVZ7wodgYdAms0s+eEOR3oe2E=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0kjZEsVVV9VvHVHJmFyFvagKuK+DGXP5UBwugxZlXRZgDTgfT
 nscv4MdEV7PWwe/HSw5za12bAihMT07j1lC0Gyi38qJCTrbDxwEP1gOvxm2luO8Evp01bENgonK
 HOBvA/V5tCV4GmBMGGtn2V4rAiCY=
X-Google-Smtp-Source: AGHT+IEMAl18WcMx+sY3qECHI183rPkmXA6tCv+g4z55Isg1hzEXeIC20oy2o8aG0zbyu+e3eMEMrBYkO3qYPZG9/0o=
X-Received: by 2002:a05:6214:262f:b0:6e8:fbb7:675b with SMTP id
 6a1803df08f44-6eed6213166mr254724776d6.32.1743607608357; Wed, 02 Apr 2025
 08:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+HfNj+B-LmZx7tVXWPqvK6fZ9V_iHsJ19e9MUFGF=JTVu6Xg@mail.gmail.com>
 <CAC_iWjJyBjGnK6Wv0qXvZ-ujnZ9anc+bw_q-0qCRk-3XAGC4bw@mail.gmail.com>
In-Reply-To: <CAC_iWjJyBjGnK6Wv0qXvZ-ujnZ9anc+bw_q-0qCRk-3XAGC4bw@mail.gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Wed, 2 Apr 2025 17:26:37 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNjOfy5FVBhPV52gpPV1O_=F9KWDoYVeZVBjSOoCUACacw@mail.gmail.com>
X-Gm-Features: AQ5f1JpqWHvGFu8m-GijsEc4IWxpBuTxhtJea2qxQxavcxGujAq_3SpgpoSrwVM
Message-ID: <CAJ+HfNjOfy5FVBhPV52gpPV1O_=F9KWDoYVeZVBjSOoCUACacw@mail.gmail.com>
Subject: Re: RISC-V UEFI/ACPI on QEMU regression?
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 02 Apr 2025 18:17:07 +0200
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

Hey!

On Wed, 2 Apr 2025 at 16:27, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hey Bjorn
>
> Long time, hope all is well!

Too long! Maybe next Plumbers? ;-)

> I think it's a regression and I think what breaks it is commit cfb4aa2a75=
4ed1
>
> Can you apply the diff below and see if it fixes it for you?
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 4422b31ac6a7..afa5eee85484 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -34,8 +34,8 @@ efi_status_t efi_acpi_register(void)
>          * add_u_boot_and_runtime(). At some point that function could cr=
eate a
>          * more detailed map.
>          */
> -       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> -               return EFI_SUCCESS;
> +       //if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> +               ////return EFI_SUCCESS;
>
>         /* Mark space used for tables */
>         start =3D ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);

Unfortunately, still the same with this patch:

[    0.000000] efi:   0x00047eee3000-0x00047ef19fff [Boot Code   |   |
 |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] efi:   0x00047ef1a000-0x00047ef49fff [ACPI Reclaim|   |
 |  |  |  |  |  |  |  |  |   |WB|  |  |  ]
[    0.000000] ACPI: RSDP 0x000000047EED1000 000024 (v02 BOCHS )

(RSDP resides in Boot Code)


Bj=C3=B6rn
