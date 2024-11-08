Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BE4D5E15A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 11:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC04A8908F;
	Fri,  8 Nov 2024 12:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MFmURumh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F4E8909B; Fri,  8 Nov 2024 12:19:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A1489083
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 12:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731064788; x=1731669588; i=xypron.glpk@gmx.de;
 bh=5/g2cJfnkPouwqaKHfBgNwBnh6doo+UpL9wCyKvNxzU=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MFmURumhaWOn7Qka6lSahKw76J+M+LEExGM/NaW3R+WsrD1PIMiz4Au0nU8bcvod
 fXhlfHuYwulYTtpJV2TXraykq9ldMx+nSIEbcuGXgblE2uGHKMmBoZexCaJFqYx2t
 gruv65LHzp7PiiC7xhS7zVbruC9nwDwVP/TZNVFnOzjyGcARxgfjwgQDkQ74bhw+z
 CjyzvquQPrkYJw5uzk9wwMZgSxfQIwcRPVT7tfwV35C9Lr4viFZIq9gjF5xeXTw96
 d5/uO2o2P9FjQhXER+CYXHM/gin6rBgg1vXqJUW70swuq66byyl4pwjzDKUU9LUfS
 a2uVonqLRwzFMVtgzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.110.72]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1tyaXJ0ojN-015FqS; Fri, 08
 Nov 2024 12:19:48 +0100
Date: Fri, 08 Nov 2024 12:19:44 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
CC: Maximilian Brune <maximilian.brune@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v10 02/37] acpi: x86: Write FADT in common code
User-Agent: Thunderbird for Android
In-Reply-To: <CALNFmy3ZuZwzXUsFt5EN-5VndSP+cavkY0R5=bhYDWEexG_otg@mail.gmail.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
 <20241023132116.970117-3-patrick.rudolph@9elements.com>
 <4d55f212-ee39-4886-9246-3596fc4268f7@gmx.de>
 <CALNFmy3ZuZwzXUsFt5EN-5VndSP+cavkY0R5=bhYDWEexG_otg@mail.gmail.com>
Message-ID: <F9A3E58B-ABA7-4864-BBB7-F26AC1445AB7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mn7qw/PHNGEGt2k4ayuDZdkbuL+BjMcQu589pmXlud/Wnmv6LFR
 zkzVGo+Mh79AFavepc/RVoZbnPj+qtSfy/rKOCJWm5ALD0NWEvKGzjvawgkcjvWH8icJhIg
 lMVMB328wm0RSTPHAUkkHdUttnL6auGbUtqfIo0agodk1jqYFibhAn5WHUC5dora6E65Oa5
 UVqkKvft/wtAw22v3+M8w==
UI-OutboundReport: notjunk:1;M01:P0:CX04tjRHSm0=;ZyEyGVAn70kJn4emC52sNAgB3ro
 BeXu0Wryt+ccbBZ6ozdp9dga8nKge77t9yCSHHr+fz93WyS8WJCJF8rC4KXNpg/pJAS4ckt7O
 DkA9dzfmyERQNlPzP6ryTZZO9wqg5t4JHR4+DvemxXJjVC97xYGPj1ihFI6V/EeuQxFg+95Da
 ZvYm0hKNJesPWz/mfUplApv6VM++W7MHJgKx8pA+K/TrRvX1aZym3iEMOFur43VdHuxNhZlTW
 l/xrxArWoI6vRF63sMbYIEvLfOGxPiAfJPgWGxnBfRt0zTd7OpWSSLt5+F4B5L2AzvS/qYmTT
 q/xguG+WX+sDaG2WPpq+FKuk39ntsZpDghX2FLzQ7j5adm5eOJbD2kdwB3//Sa//he6h3c8WI
 F5PU3o4jkTNSuW7eb83Nn4R58ZZ8c8Lnwoj2EhmnF4nMEfaJKaywRObaMESL65k6pIt5qhuGU
 MlM2xzFoe4aWmoCwrAHQcBG+ULbJhgR4/B4hMzU7tqj1g4L81VzTBeMtsIznD73XxxWKx7WKw
 Us0eZniB4OWal3FRcxeY8O3JY1yIP2ftN2f2Bpy87JScJCsInqe03DavihTyPyIvqQgVe9gp6
 2bkEjiljM/CbIrCRr3OOhDJgmzXPGeVh6JwER0ArkSiu5wSm57xM2+H8wwVmAEAq4IF5yEG/I
 8TAKsg9mR/DVGaKVTdRmMxuO6nupMYjuEt7KfzUtMJT5hMI9Vu934GVQ0m9Ifsc/9vUOInX1l
 Ij6KDg2VDmoFKXzGy9W8d8I43/ugUkygqLwBout5cKKdUjIeT8iraX7QlbCJydbFZZE/ZtPGE
 4ajcv/zgv9/qf8tJYH9A5U2A==
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

Am 8=2E November 2024 08:10:05 MEZ schrieb Patrick Rudolph <patrick=2Erudol=
ph@9elements=2Ecom>:
>Hi Heinrich,
>On Thu, Nov 7, 2024 at 10:19=E2=80=AFAM Heinrich Schuchardt <xypron=2Eglp=
k@gmx=2Ede> wrote:
>>
>> On 10/23/24 15:19, Patrick Rudolph wrote:
>> > From: Maximilian Brune <maximilian=2Ebrune@9elements=2Ecom>
>> >
>> > Write the FADT in common code since it's used on all architectures=2E
>> > Since the FADT is mandatory all SoCs or mainboards must implement the
>> > introduced function acpi_fill_fadt() and properly update the FADT=2E
>> >
>> > Signed-off-by: Patrick Rudolph <patrick=2Erudolph@9elements=2Ecom>
>> > Reviewed-by: Simon Glass <sjg@chromium=2Eorg>
>> > Cc: Simon Glass <sjg@chromium=2Eorg>
>> > Cc: Bin Meng <bmeng=2Ecn@gmail=2Ecom>
>>
>> This merged patch breaks
>>
>> make qemu_riscv64_defconfig acpi=2Econfig
>> make
>I'm sorry, since the CI doesn't build that target, I was not aware of
>build failures=2E
>
>>
>> You are implementing function acpi_fill_fadt() only for x86 and call it
>> in code that is used by all architectures=2E
>>
>acpi_fill_fadt() is called on all architectures that are ACPI enabled
>and build by the CI=2E
>There might additional ACPI enabled platforms, but since they are not
>build tested,
>they aren't officially supported, are they?

I worked on getting ACPI enabled on arm64 and riscv64  QEMU but could have=
 made better by adding it to CI=2E

For some features it was decided that we prefer config overlays over decon=
figs=2E But the test concept is kind of missing=2E

Best regards

Heinrich


>
>> ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
>> makes no sense for CONFIG_QFW=3Dy because QEMU is providing the table=
=2E
>Good catch=2E I'll send a follow up series=2E
>
>>
>> @Tom:
>> After getting this fixed we should add a build with acpi=2Econfig into =
the CI=2E
>>
>> further comments below:
>>
>>
>>
>> >
>> > ---
>> > Changelog v4:
>> > - Drop __weak attribute
>> > ---
>> >   arch/sandbox/lib/acpi_table=2Ec     |  6 +++++
>> >   arch/x86/cpu/apollolake/acpi=2Ec    | 20 ++++------------
>> >   arch/x86/cpu/baytrail/acpi=2Ec      | 17 +-------------
>> >   arch/x86/cpu/quark/acpi=2Ec         | 19 +---------------
>> >   arch/x86/cpu/tangier/acpi=2Ec       | 25 ++------------------
>> >   arch/x86/include/asm/acpi_table=2Eh | 12 ----------
>> >   arch/x86/lib/acpi_table=2Ec         | 23 -------------------
>> >   include/acpi/acpi_table=2Eh         |  9 ++++++++
>> >   lib/acpi/acpi_table=2Ec             | 38 ++++++++++++++++++++++++++=
+++++
>> >   9 files changed, 61 insertions(+), 108 deletions(-)
>> >   create mode 100644 arch/sandbox/lib/acpi_table=2Ec
>> >
>> > diff --git a/arch/sandbox/lib/acpi_table=2Ec b/arch/sandbox/lib/acpi_=
table=2Ec
>> > new file mode 100644
>> > index 0000000000=2E=2E10b7ce441a
>> > --- /dev/null
>> > +++ b/arch/sandbox/lib/acpi_table=2Ec
>> > @@ -0,0 +1,6 @@
>> > +// SPDX-License-Identifier: GPL-2=2E0+
>> > +#include <acpi/acpi_table=2Eh>
>> > +
>> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
>> > +{
>> > +}
>> > \ No newline at end of file
>> > diff --git a/arch/x86/cpu/apollolake/acpi=2Ec b/arch/x86/cpu/apollola=
ke/acpi=2Ec
>> > index 76230aea83=2E=2E93040e7bb3 100644
>> > --- a/arch/x86/cpu/apollolake/acpi=2Ec
>> > +++ b/arch/x86/cpu/apollolake/acpi=2Ec
>> > @@ -128,8 +128,10 @@ int arch_madt_sci_irq_polarity(int sci)
>> >       return MP_IRQ_POLARITY_LOW;
>> >   }
>> >
>> > -void fill_fadt(struct acpi_fadt *fadt)
>> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
>> >   {
>> > +     intel_acpi_fill_fadt(fadt);
>> > +
>> >       fadt->pm_tmr_blk =3D IOMAP_ACPI_BASE + PM1_TMR;
>> >
>> >       fadt->p_lvl2_lat =3D ACPI_FADT_C2_NOT_SUPPORTED;
>> > @@ -143,23 +145,9 @@ void fill_fadt(struct acpi_fadt *fadt)
>> >       fadt->x_pm_tmr_blk=2Espace_id =3D 1;
>> >       fadt->x_pm_tmr_blk=2Ebit_width =3D fadt->pm_tmr_len * 8;
>> >       fadt->x_pm_tmr_blk=2Eaddrl =3D IOMAP_ACPI_BASE + PM1_TMR;
>> > -}
>> > -
>> > -static int apl_write_fadt(struct acpi_ctx *ctx, const struct acpi_wr=
iter *entry)
>> > -{
>> > -     struct acpi_table_header *header;
>> > -     struct acpi_fadt *fadt;
>> > -
>> > -     fadt =3D ctx->current;
>> > -     acpi_fadt_common(fadt, ctx->facs, ctx->dsdt);
>> > -     intel_acpi_fill_fadt(fadt);
>> > -     fill_fadt(fadt);
>> > -     header =3D &fadt->header;
>> > -     header->checksum =3D table_compute_checksum(fadt, header->lengt=
h);
>> >
>> > -     return acpi_add_fadt(ctx, fadt);
>> > +     fadt->preferred_pm_profile =3D ACPI_PM_MOBILE;
>> >   }
>> > -ACPI_WRITER(5fadt, "FADT", apl_write_fadt, 0);
>> >
>> >   int apl_acpi_fill_dmar(struct acpi_ctx *ctx)
>> >   {
>> > diff --git a/arch/x86/cpu/baytrail/acpi=2Ec b/arch/x86/cpu/baytrail/a=
cpi=2Ec
>> > index 7821964f1f=2E=2E7e1c2de3d3 100644
>> > --- a/arch/x86/cpu/baytrail/acpi=2Ec
>> > +++ b/arch/x86/cpu/baytrail/acpi=2Ec
>> > @@ -15,20 +15,13 @@
>> >   #include <asm/arch/iomap=2Eh>
>> >   #include <dm/uclass-internal=2Eh>
>> >
>> > -static int baytrail_write_fadt(struct acpi_ctx *ctx,
>> > -                            const struct acpi_writer *entry)
>> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
>> >   {
>> >       struct acpi_table_header *header;
>> > -     struct acpi_fadt *fadt;
>> >
>> > -     fadt =3D ctx->current;
>> >       header =3D &fadt->header;
>> >       u16 pmbase =3D ACPI_BASE_ADDRESS;
>> >
>> > -     memset(fadt, '\0', sizeof(struct acpi_fadt));
>> > -
>> > -     acpi_fill_header(header, "FACP");
>> > -     header->length =3D sizeof(struct acpi_fadt);
>> >       header->revision =3D 4;
>> >
>> >       fadt->preferred_pm_profile =3D ACPI_PM_MOBILE;
>> > @@ -77,9 +70,6 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx=
,
>> >       fadt->reset_reg=2Eaddrh =3D 0;
>> >       fadt->reset_value =3D SYS_RST | RST_CPU | FULL_RST;
>> >
>> > -     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
>> > -     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>> > -
>> >       fadt->x_pm1a_evt_blk=2Espace_id =3D ACPI_ADDRESS_SPACE_IO;
>> >       fadt->x_pm1a_evt_blk=2Ebit_width =3D fadt->pm1_evt_len * 8;
>> >       fadt->x_pm1a_evt_blk=2Ebit_offset =3D 0;
>> > @@ -135,12 +125,7 @@ static int baytrail_write_fadt(struct acpi_ctx *=
ctx,
>> >       fadt->x_gpe1_blk=2Eaccess_size =3D 0;
>> >       fadt->x_gpe1_blk=2Eaddrl =3D 0x0;
>> >       fadt->x_gpe1_blk=2Eaddrh =3D 0x0;
>> > -
>> > -     header->checksum =3D table_compute_checksum(fadt, header->lengt=
h);
>> > -
>> > -     return acpi_add_fadt(ctx, fadt);
>> >   }
>> > -ACPI_WRITER(5fadt, "FADT", baytrail_write_fadt, 0);
>> >
>> >   int acpi_create_gnvs(struct acpi_global_nvs *gnvs)
>> >   {
>> > diff --git a/arch/x86/cpu/quark/acpi=2Ec b/arch/x86/cpu/quark/acpi=2E=
c
>> > index 80e94600fc=2E=2E0fe5f2bafb 100644
>> > --- a/arch/x86/cpu/quark/acpi=2Ec
>> > +++ b/arch/x86/cpu/quark/acpi=2Ec
>> > @@ -11,23 +11,14 @@
>> >   #include <asm/arch/iomap=2Eh>
>> >   #include <linux/string=2Eh>
>> >
>> > -static int quark_write_fadt(struct acpi_ctx *ctx,
>> > -                         const struct acpi_writer *entry)
>> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
>> >   {
>> >       u16 pmbase =3D ACPI_PM1_BASE_ADDRESS;
>> >       struct acpi_table_header *header;
>> > -     struct acpi_fadt *fadt;
>> >
>> > -     fadt =3D ctx->current;
>> >       header =3D &fadt->header;
>> > -
>> > -     memset(fadt, '\0', sizeof(struct acpi_fadt));
>> > -
>> > -     acpi_fill_header(header, "FACP");
>> > -     header->length =3D sizeof(struct acpi_fadt);
>> >       header->revision =3D 4;
>> >
>> > -     fadt->preferred_pm_profile =3D ACPI_PM_UNSPECIFIED;
>> >       fadt->sci_int =3D 9;
>> >       fadt->smi_cmd =3D 0;
>> >       fadt->acpi_enable =3D 0;
>> > @@ -73,9 +64,6 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
>> >       fadt->reset_reg=2Eaddrh =3D 0;
>> >       fadt->reset_value =3D SYS_RST | RST_CPU | FULL_RST;
>> >
>> > -     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
>> > -     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>> > -
>> >       fadt->x_pm1a_evt_blk=2Espace_id =3D ACPI_ADDRESS_SPACE_IO;
>> >       fadt->x_pm1a_evt_blk=2Ebit_width =3D fadt->pm1_evt_len * 8;
>> >       fadt->x_pm1a_evt_blk=2Ebit_offset =3D 0;
>> > @@ -131,12 +119,7 @@ static int quark_write_fadt(struct acpi_ctx *ctx=
,
>> >       fadt->x_gpe1_blk=2Eaccess_size =3D 0;
>> >       fadt->x_gpe1_blk=2Eaddrl =3D 0x0;
>> >       fadt->x_gpe1_blk=2Eaddrh =3D 0x0;
>> > -
>> > -     header->checksum =3D table_compute_checksum(fadt, header->lengt=
h);
>> > -
>> > -     return acpi_add_fadt(ctx, fadt);
>> >   }
>> > -ACPI_WRITER(5fadt, "FADT", quark_write_fadt, 0);
>> >
>> >   int acpi_create_gnvs(struct acpi_global_nvs *gnvs)
>> >   {
>> > diff --git a/arch/x86/cpu/tangier/acpi=2Ec b/arch/x86/cpu/tangier/acp=
i=2Ec
>> > index d4d0ef6f85=2E=2E1c73a9dbfe 100644
>> > --- a/arch/x86/cpu/tangier/acpi=2Ec
>> > +++ b/arch/x86/cpu/tangier/acpi=2Ec
>> > @@ -16,21 +16,8 @@
>> >   #include <asm/arch/iomap=2Eh>
>> >   #include <dm/uclass-internal=2Eh>
>> >
>> > -static int tangier_write_fadt(struct acpi_ctx *ctx,
>> > -                           const struct acpi_writer *entry)
>> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
>> >   {
>> > -     struct acpi_table_header *header;
>> > -     struct acpi_fadt *fadt;
>> > -
>> > -     fadt =3D ctx->current;
>> > -     header =3D &fadt->header;
>> > -
>> > -     memset(fadt, '\0', sizeof(struct acpi_fadt));
>> > -
>> > -     acpi_fill_header(header, "FACP");
>> > -     header->length =3D sizeof(struct acpi_fadt);
>> > -     header->revision =3D 6;
>> > -
>> >       fadt->preferred_pm_profile =3D ACPI_PM_UNSPECIFIED;
>> >
>> >       fadt->iapc_boot_arch =3D ACPI_FADT_VGA_NOT_PRESENT |
>> > @@ -40,17 +27,9 @@ static int tangier_write_fadt(struct acpi_ctx *ctx=
,
>> >               ACPI_FADT_POWER_BUTTON | ACPI_FADT_SLEEP_BUTTON |
>> >               ACPI_FADT_SEALED_CASE | ACPI_FADT_HEADLESS |
>> >               ACPI_FADT_HW_REDUCED_ACPI;
>> > -
>> > +     fadt->header=2Erevision =3D 6;
>> >       fadt->minor_revision =3D 2;
>> > -
>> > -     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
>> > -     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>> > -
>> > -     header->checksum =3D table_compute_checksum(fadt, header->lengt=
h);
>> > -
>> > -     return acpi_add_fadt(ctx, fadt);
>> >   }
>> > -ACPI_WRITER(5fadt, "FADT", tangier_write_fadt, 0);
>> >
>> >   u32 acpi_fill_madt(u32 current)
>> >   {
>> > diff --git a/arch/x86/include/asm/acpi_table=2Eh b/arch/x86/include/a=
sm/acpi_table=2Eh
>> > index e617524617=2E=2E3988898f66 100644
>> > --- a/arch/x86/include/asm/acpi_table=2Eh
>> > +++ b/arch/x86/include/asm/acpi_table=2Eh
>> > @@ -168,18 +168,6 @@ int acpi_create_dmar_ds_ioapic(struct acpi_ctx *=
ctx, uint enumeration_id,
>> >   int acpi_create_dmar_ds_msi_hpet(struct acpi_ctx *ctx, uint enumera=
tion_id,
>> >                                pci_dev_t bdf);
>> >
>> > -/**
>> > - * acpi_fadt_common() - Handle common parts of filling out an FADT
>> > - *
>> > - * This sets up the Fixed ACPI Description Table
>> > - *
>> > - * @fadt: Pointer to place to put FADT
>> > - * @facs: Pointer to the FACS
>> > - * @dsdt: Pointer to the DSDT
>> > - */
>> > -void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs=
,
>> > -                   void *dsdt);
>> > -
>> >   /**
>> >    * intel_acpi_fill_fadt() - Set up the contents of the FADT
>> >    *
>> > diff --git a/arch/x86/lib/acpi_table=2Ec b/arch/x86/lib/acpi_table=2E=
c
>> > index 08fd1e54ce=2E=2Eff02ce80d1 100644
>> > --- a/arch/x86/lib/acpi_table=2Ec
>> > +++ b/arch/x86/lib/acpi_table=2Ec
>> > @@ -381,29 +381,6 @@ int acpi_write_hpet(struct acpi_ctx *ctx)
>> >       return 0;
>> >   }
>> >
>> > -void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs=
,
>> > -                   void *dsdt)
>> > -{
>> > -     struct acpi_table_header *header =3D &fadt->header;
>> > -
>> > -     memset((void *)fadt, '\0', sizeof(struct acpi_fadt));
>> > -
>> > -     acpi_fill_header(header, "FACP");
>> > -     header->length =3D sizeof(struct acpi_fadt);
>> > -     header->revision =3D 4;
>> > -     memcpy(header->oem_id, OEM_ID, 6);
>> > -     memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
>> > -     memcpy(header->creator_id, ASLC_ID, 4);
>> > -
>> > -     fadt->x_firmware_ctrl =3D map_to_sysmem(facs);
>> > -     fadt->x_dsdt =3D map_to_sysmem(dsdt);
>> > -
>> > -     fadt->preferred_pm_profile =3D ACPI_PM_MOBILE;
>> > -
>> > -     /* Use ACPI 3=2E0 revision */
>> > -     fadt->header=2Erevision =3D 4;
>> > -}
>> > -
>> >   void acpi_create_dmar_drhd(struct acpi_ctx *ctx, uint flags, uint s=
egment,
>> >                          u64 bar)
>> >   {
>> > diff --git a/include/acpi/acpi_table=2Eh b/include/acpi/acpi_table=2E=
h
>> > index a372435492=2E=2E19cf0fb43c 100644
>> > --- a/include/acpi/acpi_table=2Eh
>> > +++ b/include/acpi/acpi_table=2Eh
>> > @@ -954,6 +954,15 @@ void acpi_fill_header(struct acpi_table_header *=
header, char *signature);
>> >    */
>> >   int acpi_fill_csrt(struct acpi_ctx *ctx);
>> >
>> > +/**
>> > + * acpi_fill_fadt() - Fill out the body of the FADT
>> > + *
>> > + * Must be implemented in SoC specific code or in mainboard code=2E
>> > + *
>> > + * @fadt: Pointer to FADT to update
>> > + */
>> > +void acpi_fill_fadt(struct acpi_fadt *fadt);
>> > +
>> >   /**
>> >    * acpi_get_rsdp_addr() - get ACPI RSDP table address
>> >    *
>> > diff --git a/lib/acpi/acpi_table=2Ec b/lib/acpi/acpi_table=2Ec
>> > index c9ddcca8cb=2E=2E9eb0b507a0 100644
>> > --- a/lib/acpi/acpi_table=2Ec
>> > +++ b/lib/acpi/acpi_table=2Ec
>> > @@ -202,6 +202,44 @@ int acpi_add_table(struct acpi_ctx *ctx, void *t=
able)
>> >       return 0;
>> >   }
>> >
>> > +int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *=
entry)
>> > +{
>> > +     struct acpi_table_header *header;
>> > +     struct acpi_fadt *fadt;
>> > +
>> > +     fadt =3D ctx->current;
>> > +     header =3D &fadt->header;
>> > +
>> > +     memset((void *)fadt, '\0', sizeof(struct acpi_fadt));
>> > +
>> > +     acpi_fill_header(header, "FACP");
>> > +     header->length =3D sizeof(struct acpi_fadt);
>> > +     header->revision =3D acpi_get_table_revision(ACPITAB_FADT);
>> > +     memcpy(header->oem_id, OEM_ID, 6);
>> > +     memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
>> > +     memcpy(header->creator_id, ASLC_ID, 4);
>> > +     header->creator_revision =3D 1;
>> > +
>> > +     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
>> > +     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
>> > +
>> > +     if (fadt->x_firmware_ctrl < 0x100000000ULL)
>> > +             fadt->firmware_ctrl =3D fadt->x_firmware_ctrl;
>>
>> The ACPI spec requires fadt->firmware_ctrl to be ignored if
>> fadt->x_firmware_ctrl is filled=2E
>>
>> > +
>> > +     if (fadt->x_dsdt < 0x100000000ULL)
>> > +             fadt->dsdt =3D fadt->x_dsdt;
>>
>> The ACPI spec requires fadt->dsdt to be ignored if fadt->x_dsdt is fill=
ed=2E
>>
>This quote is out of context=2E The ACPI 2=2E0 spec requires the OS to
>ignore DSDT, when X_DSDT is filled=2E
>U-Boot doesn't know which version of the ACPI spec is used by the OS,
>thus it must support all versions=2E
>
>> Overwriting the 32-bit fields if the 64-bit fields are 0 is the wrong
>> thing to do=2E If the 64-bit fields are non-zero it is superfluous=2E
>Since the initial content of DSDT is 0, it's the right thing to do in
>order to support ACPI 1=2E0 OS=2E
>When the OS is ACPI 2=2E0 compliant it will ignore the DSDT and use
>X_DSDT=2E Does map_to_sysmem() ever
>return NULL? It sounds like a bug to me that isn't going to work,
>regardless how the pointer is passed to the OS=2E
>
>
>>
>> Please, remove these lines=2E
>>
>> Best regards
>>
>> Heinrich
>>
>> > +
>> > +     fadt->preferred_pm_profile =3D ACPI_PM_UNSPECIFIED;
>> > +
>> > +     acpi_fill_fadt(fadt);
>> > +
>> > +     header->checksum =3D table_compute_checksum(fadt, header->lengt=
h);
>> > +
>> > +     return acpi_add_fadt(ctx, fadt);
>> > +}
>> > +
>> > +ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
>> > +
>> >   void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
>> >                     int port_type, int port_subtype,
>> >                     struct acpi_gen_regaddr *address, u32 address_siz=
e,
>>

