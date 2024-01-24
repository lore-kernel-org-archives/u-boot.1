Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DD5C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 23:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B8608793F;
	Thu, 25 Jan 2024 00:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ij86owFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F38986FC9; Thu, 25 Jan 2024 00:57:46 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3EDC8793F
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 00:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55cef56c6f9so264197a12.3
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 15:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706140663; x=1706745463; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3HldD2w5h2goIkJnbiLjM6200zxvC2JNdpX2OhECbsk=;
 b=Ij86owFl3Wcrq8z5Bc7QZ0IvPk1vQ0YIE8KzKtjOzY1hkPQebTD1+fo9W/pFVdnFl7
 ogRkbXC8/pPDvG3Ao2ebbpVXJKWnc682o0dh/6mjJP1N2H1T3WNhC4DS2pIimj6UDvbn
 Q1Fs6TB9O3Gz8IiDTp0Fi/dHnfKPlIgH0zmdd1/Um5c5yMh3Vr95L8dN+y1PPRd2+5Dv
 BPThN92f+rH5iikTW/ULxxpciinssoXfZ786psPYIXB0cH75BnC/cG+QpuFsyw+rlMTX
 8t1uR2YK0k+jo/iQ8AN2b3ldyXlZPyOb0YzEJgb+uKNSBrcdGMdhQpUj5c3f/puMl7fR
 pUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706140663; x=1706745463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HldD2w5h2goIkJnbiLjM6200zxvC2JNdpX2OhECbsk=;
 b=cIoX1ZI85NUeOo3a8ONa4fwdfbWcBV+5czZEuKtWdLOS82MNeVSsmvNMayjOCLJE+m
 06LuDvRT7cfLTZoKhO8RjWzhIiJV3JH5HuYENPYj7FLB8l0tma020YN9IWoPKhnbpW4L
 GeSOikYXmtNyayaWbsgYE18Ex+lKV7H8CfJBKkMK78SwTJkSxFP4C0aeyfEFCQthq9kH
 Tu2vSdHs+VnnHyxeX15t/DEzGfnvv3QZ2PCmlV0LZq/0gN35F2x4dl2vDLb+HoZKY0np
 8zpxtCi2B0mEDRPLQdNE/74vbTxOWbbfiLB25iHz3qrLYRYtxf7cPL4j8Ng424Hdfk8S
 BG6g==
X-Gm-Message-State: AOJu0YwzkzAI045I37A4frZKSASsplZTzlcUAec3RCJvG8jhnxhNEABb
 AGAvyfzgWa3mk3X22qGpIbpfChOyZrUYG1RaQNt4fNbNC3tSd34tgQewFnxzm0/aXtvOrys690V
 N1pa729jz5p404J9KVJmf2Pk7tDzhZ64VK4a6pHSnxUQvHRq4
X-Google-Smtp-Source: AGHT+IEaQCHX60k75IBDoO/QA8HeUp7yhAJCC2hKHX2qffedIevDF1Xp1/ly20KgSV+V+X8FSniFPpoxUM674Oo8rv0=
X-Received: by 2002:a05:6402:30b7:b0:55c:c7f4:9a23 with SMTP id
 df23-20020a05640230b700b0055cc7f49a23mr78561edb.40.1706140663057; Wed, 24 Jan
 2024 15:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20240124091507.1173469-1-masahisa.kojima@linaro.org>
 <be7e671d-8dfe-4d7e-94ad-ac30641cb96c@gmx.de>
 <CADQ0-X-iRybEguG1xj9yr7JDWbcDsZ13v5gmAcdo1jnyzsRDxw@mail.gmail.com>
 <b5159b09-39e4-4eb4-8a66-34d5ed3b6cbf@gmx.de>
In-Reply-To: <b5159b09-39e4-4eb4-8a66-34d5ed3b6cbf@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 25 Jan 2024 08:57:31 +0900
Message-ID: <CADQ0-X9nF9yAYO67_epandJjwQ-GsMdeVZe3zQR3X9E3RUwwGA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: migrate SMBIOS 3.0 entry point structure for
 measurement
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
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

On Wed, 24 Jan 2024 at 22:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 24.01.24 12:51, Masahisa Kojima wrote:
> > Hi Heinrich,
> >
> > On Wed, 24 Jan 2024 at 18:29, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 1/24/24 10:15, Masahisa Kojima wrote:
> >>> Current U-Boot only supports the SMBIOS 3.0 entry point structure.
> >>> TCG2 measurement code should migrate to SMBIOS 3.0 entry
> >>> point structure.
> >>>
> >>> efi_selftest tcg2 test also needs to be updated, and expected
> >>> PCR[1] result is changed since guid for SMBIOS EFI system table
> >>> uses different guid SMBIOS3_TABLE_GUID instead of SMBIOS_TABLE_GUID.
> >>>
> >>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >>
> >> Hello Maasahisa,
> >>
> >> Thank you for looking into this.
> >>
> >> SMBIOS tables may be provided by QEMU. Depending on the architecture and
> >> the QEMU release we will see SMBIOS2.1 and SMBIOS3 tables. We should
> >> support measuring for both.
> >
> > With this commit, I assume that only SMBIOS 3.0 is supported in an EFI
> > enabled system.
> >   # Sorry but I don't fully follow the recent SMBIOS discussion in U-Boot ML.
> >
> > commit aa8499680c14afa80ed731b4cfcd6934b4f93712
> >      "efi: smbios: Drop support for SMBIOS2 tables"
> >
> > If QEMU provides the SMBIOS 2.1 tables, do we need to revert the above patch?
>
> qemu-x86_defconfig receives a SMBIOS 2.1 table from QEMU 8.2.
>
> But in qfw_parse_smbios_anchor() we translate this to SMBIOS 3.0. So it
> seems my worries concerning QEMU were unjustified.

Thank you for confirming it.

>
> I still wonder why in smbios_prepare_measurement() we don't check that
> the SMBIOS header has the expected signature ('_SM3_').

I will add anchor string checking.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
> >>
> >>> ---
> >>>    include/efi_loader.h                 |  1 +
> >>>    include/smbios.h                     |  4 +-
> >>>    lib/efi_loader/efi_tcg2.c            | 14 ++--
> >>>    lib/efi_selftest/efi_selftest_tcg2.c | 97 +++++++++++++---------------
> >>>    lib/smbios-parser.c                  |  9 ++-
> >>>    5 files changed, 61 insertions(+), 64 deletions(-)
> >>>
> >>> diff --git a/include/efi_loader.h b/include/efi_loader.h
> >>> index d5fca2fa5e..5c5af4f7fd 100644
> >>> --- a/include/efi_loader.h
> >>> +++ b/include/efi_loader.h
> >>> @@ -340,6 +340,7 @@ extern const efi_guid_t efi_guid_firmware_management_protocol;
> >>>    extern const efi_guid_t efi_esrt_guid;
> >>>    /* GUID of the SMBIOS table */
> >>>    extern const efi_guid_t smbios_guid;
> >>> +extern const efi_guid_t smbios3_guid;
> >>>    /*GUID of console */
> >>>    extern const efi_guid_t efi_guid_text_input_protocol;
> >>>    extern const efi_guid_t efi_guid_text_output_protocol;
> >>> diff --git a/include/smbios.h b/include/smbios.h
> >>> index b507b9d9d7..e45303d0d3 100644
> >>> --- a/include/smbios.h
> >>> +++ b/include/smbios.h
> >>> @@ -326,10 +326,10 @@ int smbios_update_version_full(void *smbios_tab, const char *version);
> >>>     * This function clear the device dependent parameters such as
> >>>     * serial number for the measurement.
> >>>     *
> >>> - * @entry: pointer to a struct smbios_entry
> >>> + * @entry: pointer to a struct smbios3_entry
> >>>     * @header: pointer to a struct smbios_header
> >>>     */
> >>> -void smbios_prepare_measurement(const struct smbios_entry *entry,
> >>> +void smbios_prepare_measurement(const struct smbios3_entry *entry,
> >>>                                struct smbios_header *header);
> >>>
> >>>    #endif /* _SMBIOS_H_ */
> >>> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> >>> index 8db35d0b3c..8b4f2fd2da 100644
> >>> --- a/lib/efi_loader/efi_tcg2.c
> >>> +++ b/lib/efi_loader/efi_tcg2.c
> >>> @@ -1075,7 +1075,7 @@ error:
> >>>     */
> >>>    static efi_status_t
> >>>    tcg2_measure_smbios(struct udevice *dev,
> >>> -                 const struct smbios_entry *entry)
> >>> +                 const struct smbios3_entry *entry)
> >>>    {
> >>>        efi_status_t ret;
> >>>        struct smbios_header *smbios_copy;
> >>> @@ -1093,7 +1093,7 @@ tcg2_measure_smbios(struct udevice *dev,
> >>>         */
> >>>        event_size = sizeof(struct smbios_handoff_table_pointers2) +
> >>>                     FIELD_SIZEOF(struct efi_configuration_table, guid) +
> >>> -                  entry->struct_table_length;
> >>> +                  entry->max_struct_size;
> >>>        event = calloc(1, event_size);
> >>>        if (!event) {
> >>>                ret = EFI_OUT_OF_RESOURCES;
> >>> @@ -1104,11 +1104,11 @@ tcg2_measure_smbios(struct udevice *dev,
> >>>        memcpy(event->table_description, SMBIOS_HANDOFF_TABLE_DESC,
> >>>               sizeof(SMBIOS_HANDOFF_TABLE_DESC));
> >>>        put_unaligned_le64(1, &event->number_of_tables);
> >>> -     guidcpy(&event->table_entry[0].guid, &smbios_guid);
> >>> +     guidcpy(&event->table_entry[0].guid, &smbios3_guid);
> >>>        smbios_copy = (struct smbios_header *)((uintptr_t)&event->table_entry[0].table);
> >>>        memcpy(&event->table_entry[0].table,
> >>>               (void *)((uintptr_t)entry->struct_table_address),
> >>> -            entry->struct_table_length);
> >>> +            entry->max_struct_size);
> >>>
> >>>        smbios_prepare_measurement(entry, smbios_copy);
> >>>
> >>> @@ -1133,7 +1133,7 @@ static void *find_smbios_table(void)
> >>>        u32 i;
> >>>
> >>>        for (i = 0; i < systab.nr_tables; i++) {
> >>> -             if (!guidcmp(&smbios_guid, &systab.tables[i].guid))
> >>> +             if (!guidcmp(&smbios3_guid, &systab.tables[i].guid))
> >>>                        return systab.tables[i].table;
> >>>        }
> >>>
> >>> @@ -1360,7 +1360,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
> >>>        u32 pcr_index;
> >>>        struct udevice *dev;
> >>>        u32 event = 0;
> >>> -     struct smbios_entry *entry;
> >>> +     struct smbios3_entry *entry;
> >>>
> >>>        if (!is_tcg2_protocol_installed())
> >>>                return EFI_SUCCESS;
> >>> @@ -1382,7 +1382,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocation(struct efi_loaded_image_obj *ha
> >>>        if (ret != EFI_SUCCESS)
> >>>                goto out;
> >>>
> >>> -     entry = (struct smbios_entry *)find_smbios_table();
> >>> +     entry = (struct smbios3_entry *)find_smbios_table();
> >>>        if (entry) {
> >>>                ret = tcg2_measure_smbios(dev, entry);
> >>>                if (ret != EFI_SUCCESS)
> >>> diff --git a/lib/efi_selftest/efi_selftest_tcg2.c b/lib/efi_selftest/efi_selftest_tcg2.c
> >>> index 67a886efaa..fb8b997653 100644
> >>> --- a/lib/efi_selftest/efi_selftest_tcg2.c
> >>> +++ b/lib/efi_selftest/efi_selftest_tcg2.c
> >>> @@ -126,41 +126,40 @@ static u8 boot_order[] = {0x02, 0x10, 0x00, 0x10, 0x01, 0x10};
> >>>
> >>>    static void *orig_smbios_table;
> >>>    static u64 dmi_addr = U32_MAX;
> >>> -#define SMBIOS_ENTRY_HEADER_SIZE 0x20
> >>> +#define SMBIOS3_ENTRY_HEADER_SIZE 0x18
> >>>    /* smbios table for the measurement test */
> >>> -static u8 smbios_table_test[] = {
> >>> -0x5f, 0x53, 0x4d, 0x5f, 0x2c, 0x1f, 0x03, 0x00, 0x54, 0x00, 0x00, 0x00,
> >>> -0x00, 0x00, 0x00, 0x00, 0x5f, 0x44, 0x4d, 0x49, 0x5f, 0xe4, 0x5c, 0x01,
> >>> -0x20, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00,
> >>> -0x01, 0x02, 0x00, 0x00, 0x03, 0x00, 0x80, 0x08, 0x01, 0x00, 0x00, 0x00,
> >>> -0x00, 0x00, 0x00, 0x0c, 0x15, 0x0a, 0xff, 0xff, 0x55, 0x2d, 0x42, 0x6f,
> >>> -0x6f, 0x74, 0x00, 0x32, 0x30, 0x32, 0x31, 0x2e, 0x31, 0x30, 0x2d, 0x72,
> >>> -0x63, 0x34, 0x2d, 0x30, 0x30, 0x30, 0x30, 0x35, 0x2d, 0x67, 0x37, 0x32,
> >>> -0x37, 0x63, 0x33, 0x66, 0x33, 0x32, 0x35, 0x39, 0x2d, 0x64, 0x69, 0x72,
> >>> -0x74, 0x79, 0x00, 0x31, 0x30, 0x2f, 0x30, 0x31, 0x2f, 0x32, 0x30, 0x32,
> >>> -0x31, 0x00, 0x00, 0x01, 0x1b, 0x01, 0x00, 0x01, 0x02, 0x00, 0x03, 0x31,
> >>> -0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00,
> >>> -0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
> >>> -0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x20, 0x50, 0x72,
> >>> -0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36,
> >>> -0x37, 0x38, 0x00, 0x00, 0x02, 0x0e, 0x02, 0x00, 0x01, 0x02, 0x00, 0x04,
> >>> -0x03, 0x01, 0x01, 0x01, 0x00, 0x0a, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
> >>> -0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x20, 0x50, 0x72,
> >>> -0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
> >>> -0x33, 0x33, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00,
> >>> -0x00, 0x03, 0x15, 0x03, 0x00, 0x01, 0x03, 0x00, 0x02, 0x03, 0x03, 0x03,
> >>> -0x03, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x6e,
> >>> -0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36,
> >>> -0x37, 0x38, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x00,
> >>> -0x00, 0x04, 0x30, 0x04, 0x00, 0x00, 0x03, 0x02, 0x01, 0x00, 0x00, 0x00,
> >>> -0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00,
> >>> -0x00, 0x01, 0x06, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x02, 0x03, 0x04,
> >>> -0x04, 0x04, 0x08, 0x00, 0x00, 0x02, 0x00, 0x08, 0x00, 0x08, 0x00, 0x01,
> >>> -0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x31, 0x32, 0x33,
> >>> -0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
> >>> -0x33, 0x33, 0x00, 0x35, 0x35, 0x35, 0x35, 0x35, 0x35, 0x35, 0x35, 0x00,
> >>> -0x00, 0x20, 0x0b, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> >>> -0x00, 0x00, 0x7f, 0x04, 0x06, 0x00, 0x00, 0x00
> >>> +static u8 smbios3_table_test[] = {
> >>> +0x5f, 0x53, 0x4d, 0x33, 0x5f, 0x00, 0x18, 0x03, 0x07, 0x00, 0x01, 0x00,
> >>> +0x5c, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> >>> +0x00, 0x18, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x03, 0x00, 0x80, 0x08,
> >>> +0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x15, 0x0a, 0xff, 0xff,
> >>> +0x55, 0x2d, 0x42, 0x6f, 0x6f, 0x74, 0x00, 0x32, 0x30, 0x32, 0x31, 0x2e,
> >>> +0x31, 0x30, 0x2d, 0x72, 0x63, 0x34, 0x2d, 0x30, 0x30, 0x30, 0x30, 0x35,
> >>> +0x2d, 0x67, 0x37, 0x32, 0x37, 0x63, 0x33, 0x66, 0x33, 0x32, 0x35, 0x39,
> >>> +0x2d, 0x64, 0x69, 0x72, 0x74, 0x79, 0x00, 0x31, 0x30, 0x2f, 0x30, 0x31,
> >>> +0x2f, 0x32, 0x30, 0x32, 0x31, 0x00, 0x00, 0x01, 0x1b, 0x01, 0x00, 0x01,
> >>> +0x02, 0x00, 0x03, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00,
> >>> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x55, 0x6e,
> >>> +0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
> >>> +0x6e, 0x20, 0x50, 0x72, 0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x31, 0x32,
> >>> +0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x00, 0x02, 0x0e, 0x02, 0x00,
> >>> +0x01, 0x02, 0x00, 0x04, 0x03, 0x01, 0x01, 0x01, 0x00, 0x0a, 0x55, 0x6e,
> >>> +0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77,
> >>> +0x6e, 0x20, 0x50, 0x72, 0x6f, 0x64, 0x75, 0x63, 0x74, 0x00, 0x33, 0x33,
> >>> +0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x00, 0x31, 0x32, 0x33, 0x34, 0x35,
> >>> +0x36, 0x37, 0x38, 0x00, 0x00, 0x03, 0x15, 0x03, 0x00, 0x01, 0x03, 0x00,
> >>> +0x02, 0x03, 0x03, 0x03, 0x03, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> >>> +0x00, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x00, 0x31, 0x32,
> >>> +0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x33, 0x33, 0x33, 0x33, 0x33,
> >>> +0x33, 0x33, 0x33, 0x00, 0x00, 0x04, 0x30, 0x04, 0x00, 0x00, 0x03, 0x02,
> >>> +0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0c, 0x00,
> >>> +0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x06, 0xff, 0xff, 0xff, 0xff, 0xff,
> >>> +0xff, 0x02, 0x03, 0x04, 0x04, 0x04, 0x08, 0x00, 0x00, 0x02, 0x00, 0x08,
> >>> +0x00, 0x08, 0x00, 0x01, 0x00, 0x55, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e,
> >>> +0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x00, 0x33, 0x33,
> >>> +0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x00, 0x35, 0x35, 0x35, 0x35, 0x35,
> >>> +0x35, 0x35, 0x35, 0x00, 0x00, 0x20, 0x0b, 0x05, 0x00, 0x00, 0x00, 0x00,
> >>> +0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7f, 0x04, 0x06, 0x00, 0x00, 0x00
> >>>    };
> >>>
> >>>    #define IDX_ARRAY_SZ 3 /* support 24 PCRs */
> >>> @@ -179,10 +178,10 @@ static u8 expected_pcrs[EFI_TCG2_MAX_PCR_INDEX + 1][TPM2_SHA256_DIGEST_SIZE] = {
> >>>         0x7b, 0xb9, 0xfe, 0xa1, 0xcd, 0x64, 0x49, 0xdd,
> >>>         0xed, 0xe2, 0x65, 0x82, 0xc5, 0x3e, 0xf4, 0xc4},
> >>>
> >>> -     {0xf5, 0x79, 0xf3, 0x20, 0x62, 0x6e, 0x8b, 0x58,
> >>> -      0x62, 0xa3, 0x4e, 0x2f, 0xb7, 0x10, 0xac, 0x34,
> >>> -      0x4e, 0x68, 0x94, 0x37, 0x87, 0x29, 0xc4, 0xbe,
> >>> -      0xa3, 0xc4, 0xd9, 0x14, 0x2b, 0x66, 0x79, 0x9b},
> >>> +     {0x75, 0xb5, 0x91, 0x54, 0x12, 0xa8, 0xa4, 0x25,
> >>> +      0x73, 0x79, 0xa7, 0x47, 0xd9, 0x32, 0x54, 0x78,
> >>> +      0x9a, 0x80, 0x3f, 0xa8, 0x34, 0xfe, 0xd2, 0xae,
> >>> +      0x76, 0xd3, 0x16, 0x4a, 0xb2, 0x03, 0xac, 0xe6},
> >>>
> >>>        {0x3d, 0x45, 0x8c, 0xfe, 0x55, 0xcc, 0x03, 0xea,
> >>>         0x1f, 0x44, 0x3f, 0x15, 0x62, 0xbe, 0xec, 0x8d,
> >>> @@ -543,7 +542,7 @@ static void *find_smbios_table(const struct efi_system_table *systable)
> >>>        u32 i;
> >>>
> >>>        for (i = 0; i < systable->nr_tables; i++) {
> >>> -             if (!guidcmp(&smbios_guid, &systable->tables[i].guid))
> >>> +             if (!guidcmp(&smbios3_guid, &systable->tables[i].guid))
> >>>                        return systable->tables[i].table;
> >>>        }
> >>>
> >>> @@ -558,14 +557,12 @@ static void *find_smbios_table(const struct efi_system_table *systable)
> >>>     */
> >>>    static efi_status_t setup_smbios_table(const struct efi_system_table *systable)
> >>>    {
> >>> -     struct smbios_entry *se;
> >>> +     struct smbios3_entry *se;
> >>>        efi_status_t ret;
> >>>        /* Map within the low 32 bits, to allow for 32bit SMBIOS tables */
> >>>        void *dmi;
> >>> -     char *istart;
> >>> -     int isize;
> >>>
> >>> -     if (sizeof(smbios_table_test) > EFI_PAGE_SIZE)
> >>> +     if (sizeof(smbios3_table_test) > EFI_PAGE_SIZE)
> >>>                return EFI_OUT_OF_RESOURCES;
> >>>
> >>>        orig_smbios_table = find_smbios_table(systable);
> >>> @@ -586,19 +583,15 @@ static efi_status_t setup_smbios_table(const struct efi_system_table *systable)
> >>>
> >>>        dmi = (void *)(uintptr_t)dmi_addr;
> >>>        se = dmi;
> >>> -     boottime->copy_mem(se, smbios_table_test, sizeof(smbios_table_test));
> >>> +     boottime->copy_mem(se, smbios3_table_test, sizeof(smbios3_table_test));
> >>>
> >>>        /* update smbios table start address */
> >>> -     se->struct_table_address = (uintptr_t)((u8 *)dmi + SMBIOS_ENTRY_HEADER_SIZE);
> >>> +     se->struct_table_address = (uintptr_t)((u8 *)dmi + SMBIOS3_ENTRY_HEADER_SIZE);
> >>>
> >>> -     /* calculate checksums */
> >>> -     istart = (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
> >>> -     isize = sizeof(struct smbios_entry) - SMBIOS_INTERMEDIATE_OFFSET;
> >>> -     se->intermediate_checksum = table_compute_checksum(istart, isize);
> >>> -     se->checksum = table_compute_checksum(se, sizeof(struct smbios_entry));
> >>> +     se->checksum = table_compute_checksum(se, sizeof(struct smbios3_entry));
> >>>
> >>>        /* Install SMBIOS information as configuration table */
> >>> -     ret = boottime->install_configuration_table(&smbios_guid, dmi);
> >>> +     ret = boottime->install_configuration_table(&smbios3_guid, dmi);
> >>>        if (ret != EFI_SUCCESS) {
> >>>                efi_st_error("Cannot install SMBIOS table\n");
> >>>                boottime->free_pages(dmi_addr, 1);
> >>> @@ -992,7 +985,7 @@ static int efi_st_tcg2_teardown(void)
> >>>         * If orig_smbios_table is NULL, calling install_configuration_table()
> >>>         * removes dummy SMBIOS table form systab.
> >>>         */
> >>> -     r = boottime->install_configuration_table(&smbios_guid, orig_smbios_table);
> >>> +     r = boottime->install_configuration_table(&smbios3_guid, orig_smbios_table);
> >>>        if (r != EFI_SUCCESS) {
> >>>                efi_st_error("Failed to restore SMBOIS table\n");
> >>>                return EFI_ST_FAILURE;
> >>> diff --git a/lib/smbios-parser.c b/lib/smbios-parser.c
> >>> index ac9a367a87..f48d743657 100644
> >>> --- a/lib/smbios-parser.c
> >>> +++ b/lib/smbios-parser.c
> >>> @@ -223,21 +223,24 @@ static void clear_smbios_table(struct smbios_header *header,
> >>>        }
> >>>    }
> >>>
> >>> -void smbios_prepare_measurement(const struct smbios_entry *entry,
> >>> +void smbios_prepare_measurement(const struct smbios3_entry *entry,
> >>>                                struct smbios_header *smbios_copy)
> >>>    {
> >>>        u32 i, j;
> >>> +     void *table_end;
> >>>        struct smbios_header *header;
> >>>
> >>> +     table_end = (void *)((u8 *)smbios_copy + entry->max_struct_size);
> >>> +
> >>>        for (i = 0; i < ARRAY_SIZE(smbios_filter_tables); i++) {
> >>>                header = smbios_copy;
> >>> -             for (j = 0; j < entry->struct_count; j++) {
> >>> +             for (j = 0; (void *)header < table_end; j++) {
> >>>                        if (header->type == smbios_filter_tables[i].type)
> >>>                                break;
> >>>
> >>>                        header = get_next_header(header);
> >>>                }
> >>> -             if (j >= entry->struct_count)
> >>> +             if ((void *)header >= table_end)
> >>>                        continue;
> >>>
> >>>                clear_smbios_table(header,
> >>
>
