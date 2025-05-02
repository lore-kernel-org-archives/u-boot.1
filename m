Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AD9C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 09:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0EB881E72;
	Fri,  2 May 2025 11:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x0fyvnTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB4682075; Fri,  2 May 2025 11:46:35 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA0380F03
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 11:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ee623fe64so1749110f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 02:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746179192; x=1746783992; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3+U1awvuVgX5A0Daxd3sNhti/dI5ASZxhuoq0yZp0k=;
 b=x0fyvnTKaUO+TV4Ax2ilmzO3PvnU+p20Kz8GUvJfDt/o3Y7LzVIvrCvdrPGwDj65QX
 UaHHIrPh687RSVKZtEgoO6lhLdmId5Dp4VGWxY7Bvz3GSQ7JT50BFz3ZSVT9S27vZpaq
 OhDAY5TsVd4qvadvOlgeP7iTIqt6LjCkJt+3n8vNEZV6EMNM4R+R1aozVs0lddqPUXF3
 1J2NlZyCpFARM5lVy1rQ6u7TXLVptgC+uBF3zWpyLoxrGOpIo7rRoILsPilpt01ImEVy
 dTqGBmww5i1kX1Bw7fsh3Mqbk1C1Cl80OKItqdI5Z4xOsAa7gqtfIroXwIkfPTTV9VfG
 zi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746179192; x=1746783992;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D3+U1awvuVgX5A0Daxd3sNhti/dI5ASZxhuoq0yZp0k=;
 b=ajuZEaZ0/MTX1knmhZrJFettMMZmO9BbPoQYcpe6UXsPnusMj/s5ex2hfsHERV1KB8
 zEXscXn3XbmhXhsTPNa3K6AklI17QTew0631oGHaRDskg/tNydKRFKSc14AJi8TNXa4+
 YRbP0cE1DG92wS580rsfD7KmUSJcPsDN1xZTABmYJL2/Ibq0F9gz5JkfGPXz9mClfgYW
 bLSD1gpUgDEUdXAuM0+37liwjDHFrqhjwkrUTfKA+0gPhO1cAlautvD4Oc3OoK+YRlrn
 x0wj+vIy802ZW11e1ZpmPzK3+uvvfkwqW2hvry//R80tNGPJinbCXFJPkgX/G6oBb3eQ
 hayQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTcdSsXkl1pL7KL+EdXQQUQMyslkVgSo0+zdZOVQmum5zqnG+sURbR0pN/ES/jeDRvQxmUCNk=@lists.denx.de
X-Gm-Message-State: AOJu0YzJPUf+imPHoQm39JzWBzPQB8HAaRBqJLL/6Lc1giI6RABkNUKD
 NRoxCjxJ11LGbr+2btxLa8WNozJInZZHZhChyCu0p91vBAsJSq2U6SKV3L8S8K8=
X-Gm-Gg: ASbGncsUbGuNjUe8rf5RaNRg7vsOuPWa4yqUeiy3pkQLqDOfQIXlWMNh78HWyOYONaR
 r5QJLUgWnN5Tds/W5lSI5cQvZvaeDP/1IoN2pEPhgCmaCUfIrFGdk566MQTgeJsNd3CymoegVMe
 C+4lwL9ip0ZINBVBnHaoCE2WeUoGk6/DV3JQZam66lCy1toAphjDbQUPbOvc07R3wnUER+kwb6o
 IvWWgD57X2lDmZHAYN8Ldon1WmjgTh8WWLglTPo0RLwvO1xacQioKq8esFY2Z7rH127UIX4Ev2l
 zdUB82mbw7C9Mz9kIcDLD7363f3ulaZS4Ionlvrj8vUpM3roFCiHz63P/Qs=
X-Google-Smtp-Source: AGHT+IEHHOVoemU0DtcKr2CWH4WhI8N1Ter2RPLEudpOzOfc6ilioEGePSTG1B/KK8PX4PNBlBEupQ==
X-Received: by 2002:a05:6000:1a89:b0:3a0:6c62:8169 with SMTP id
 ffacd0b85a97d-3a099add060mr1583430f8f.25.1746179191859; 
 Fri, 02 May 2025 02:46:31 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b170e7sm1605701f8f.86.2025.05.02.02.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 02:46:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 12:46:30 +0300
Message-Id: <D9LKV1SJ0CNM.3VF6SNY0C4MOT@linaro.org>
Cc: "Ying-Chun Liu" <paul.liu@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/1] efi_loader: add dbginfodump.efi
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>
X-Mailer: aerc 0.20.0
References: <20250429084138.239990-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250429084138.239990-1-heinrich.schuchardt@canonical.com>
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

On Tue Apr 29, 2025 at 11:41 AM EEST, Heinrich Schuchardt wrote:
> Provide a test application to dump the EFI_DEBUG_IMAGE_INFO_TABLE
> as implemented in EDK II.
>
> EFI_DEBUG_IMAGE_INFO is not packed in contrast to many other EFI
> structures.
>
> As of today EDK II when removing an entry in the EfiDebugImageInfoTable
> just sets NormalImage =3D NULL but does not compact the array. So
> TableSize reflects the number of non-NULL entries and not the array
> size as reported independently in
> https://github.com/tianocore/edk2/pull/11013 and
> https://github.com/tianocore/edk2/pull/11019.
>
> The current implementation tolerates this deviation from the UEFI
> specification.
>
> This is what the output may look like:
>
>     Debug Info Table Dump
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>     =3D> dump
>     Modified
>     Number of entries: 0x0000004a
>     Info type 0x00000001
>       Address: [0x000000008315a000, 0x00000000831bafff]
>       File: FvFile(D6A2CB7F-6A18-4E2F-B43B-9920A733700A)
>       Handle: 0x000000017fe3cb18
>     ...
>     Info type 0x00000001
>       Address: [0x000000017e8db000, 0x000000017ea00f3f]
>       File: FvFile(7C04A583-9E3E-4F1C-AD65-E05268D0B4D1)
>       Handle: 0x000000017f358e98
>     Info type 0x00000001
>       Address: [0x000000017eae5000, 0x000000017eae81ff]
>       File: \dbginfodump.efi
>       Handle: 0x000000017eaf0298
>     =3D>
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	Tolerate EDK II setting NormalImage =3D NULL for deleted entries.
> 	Update commit message.
> 	Add more code comments.
> ---
>  lib/efi_loader/Makefile      |   1 +
>  lib/efi_loader/dbginfodump.c | 356 +++++++++++++++++++++++++++++++++++
>  2 files changed, 357 insertions(+)
>  create mode 100644 lib/efi_loader/dbginfodump.c
>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index cf050e5385d..0ff068b4307 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -21,6 +21,7 @@ ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>  apps-y +=3D dtbdump
>  endif
>  apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
> +apps-y +=3D dbginfodump
>
>  obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
>  obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> new file mode 100644
> index 00000000000..adbbd5060cc
> --- /dev/null
> +++ b/lib/efi_loader/dbginfodump.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2025, Heinrich Schuchardt <xypron.glpk@gmx.de>
> + *
> + * dbginfodump.efi prints out the content of the EFI_DEBUG_IMAGE_INFO_TA=
BLE.
> + */
> +
> +#include <efi_api.h>
> +
> +/**
> + * BUFFER_SIZE - size of the command line input buffer
> + */
> +#define BUFFER_SIZE 64
> +
> +static struct efi_simple_text_output_protocol *cerr;
> +static struct efi_simple_text_output_protocol *cout;
> +static struct efi_simple_text_input_protocol *cin;
> +static efi_handle_t handle;
> +static struct efi_system_table *systable;
> +static struct efi_boot_services *bs;
> +
> +static efi_guid_t guid_device_path_to_text_protocol =3D
> +	EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID;
> +
> +static struct efi_device_path_to_text_protocol *device_path_to_text;
> +
> +/* EFI_DEBUG_IMAGE_INFO_TABLE_GUID */
> +static const efi_guid_t dbg_info_guid =3D
> +	EFI_GUID(0x49152E77, 0x1ADA, 0x4764, 0xB7, 0xA2,
> +		 0x7A, 0xFE, 0xFE, 0xD9, 0x5E, 0x8B);
> +
> +/* EFI_DEBUG_IMAGE_INFO_NORMAL */
> +struct dbg_info {
> +	u32 type;
> +	struct efi_loaded_image *info;
> +	efi_handle_t handle;
> +};
> +
> +/* FI_DEBUG_IMAGE_INFO_TABLE_HEADER */
> +struct dbg_info_header {
> +	u32 status;
> +	u32 size;
> +	struct dbg_info **info;
> +};
> +
> +/**
> + * print() - print string
> + *
> + * @string:	text
> + */
> +static void print(u16 *string)
> +{
> +	cout->output_string(cout, string);
> +}
> +
> +/**
> + * error() - print error string
> + *
> + * @string:	error text
> + */
> +static void error(u16 *string)
> +{
> +	cout->set_attribute(cout, EFI_LIGHTRED | EFI_BACKGROUND_BLACK);
> +	print(string);
> +	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
> +}
> +
> +/**
> + * printu() - print unsigned
> + *
> + * @val:	value to print
> + */
> +static void printu(u32 val)
> +{
> +	u16 str[19] =3D u"0x";
> +	u16 *ptr =3D &str[2];
> +	u16 ch;
> +
> +	for (ssize_t i =3D 8 * sizeof(u32) - 4; i >=3D 0; i -=3D 4) {
> +		ch =3D (val >> i & 0xf) + '0';
> +		if (ch > '9')
> +			ch +=3D 'a' - '9' - 1;
> +		*ptr++ =3D ch;
> +	}
> +	*ptr =3D 0;
> +	print(str);
> +}
> +
> +/**
> + * printp() - print pointer
> + *
> + * @p:	pointer
> + */
> +static void printp(void *p)
> +{
> +	u16 str[19] =3D u"0x";
> +	u16 *ptr =3D &str[2];
> +	u16 ch;
> +
> +	for (ssize_t i =3D 8 * sizeof(void *) - 4; i >=3D 0; i -=3D 4) {
> +		ch =3D ((uintptr_t)p >> i & 0xf) + '0';
> +		if (ch > '9')
> +			ch +=3D 'a' - '9' - 1;
> +		*ptr++ =3D ch;
> +	}
> +	*ptr =3D 0;
> +	print(str);
> +}
> +
> +/**
> + * efi_input() - read string from console
> + *
> + * @buffer:		input buffer
> + * @buffer_size:	buffer size
> + * Return:		status code
> + */
> +static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> +{
> +	struct efi_input_key key =3D {0};
> +	efi_uintn_t index;
> +	efi_uintn_t pos =3D 0;
> +	u16 outbuf[2] =3D u" ";
> +	efi_status_t ret;
> +
> +	/* Drain the console input */
> +	ret =3D cin->reset(cin, true);
> +	*buffer =3D 0;
> +	for (;;) {
> +		ret =3D bs->wait_for_event(1, &cin->wait_for_key, &index);
> +		if (ret !=3D EFI_SUCCESS)
> +			continue;
> +		ret =3D cin->read_key_stroke(cin, &key);
> +		if (ret !=3D EFI_SUCCESS)
> +			continue;
> +		switch (key.scan_code) {
> +		case 0x17: /* Escape */
> +			print(u"\r\nAborted\r\n");
> +			return EFI_ABORTED;
> +		default:
> +			break;
> +		}
> +		switch (key.unicode_char) {
> +		case 0x08: /* Backspace */
> +			if (pos) {
> +				buffer[pos--] =3D 0;
> +				print(u"\b \b");
> +			}
> +			break;
> +		case 0x0a: /* Linefeed */
> +		case 0x0d: /* Carriage return */
> +			print(u"\r\n");
> +			return EFI_SUCCESS;
> +		default:
> +			break;
> +		}
> +		/* Ignore surrogate codes */
> +		if (key.unicode_char >=3D 0xD800 && key.unicode_char <=3D 0xDBFF)
> +			continue;
> +		if (key.unicode_char >=3D 0x20 &&
> +		    pos < buffer_size - 1) {
> +			*outbuf =3D key.unicode_char;
> +			buffer[pos++] =3D key.unicode_char;
> +			buffer[pos] =3D 0;
> +			print(outbuf);
> +		}
> +	}
> +}
> +
> +/**
> + * skip_whitespace() - skip over leading whitespace
> + *
> + * @pos:	UTF-16 string
> + * Return:	pointer to first non-whitespace
> + */
> +static u16 *skip_whitespace(u16 *pos)
> +{
> +	for (; *pos && *pos <=3D 0x20; ++pos)
> +		;
> +	return pos;
> +}
> +
> +/**
> + * starts_with() - check if @string starts with @keyword
> + *
> + * @string:	string to search for keyword
> + * @keyword:	keyword to be searched
> + * Return:	true fi @string starts with the keyword
> + */
> +static bool starts_with(u16 *string, u16 *keyword)
> +{
> +	for (; *keyword; ++string, ++keyword) {
> +		if (*string !=3D *keyword)
> +			return false;
> +	}
> +	return true;
> +}
> +
> +/**
> + * do_help() - print help
> + */
> +static void do_help(void)
> +{
> +	error(u"dump       - print debug info table\r\n");
> +	error(u"exit       - exit the shell\r\n");
> +}
> +
> +/**
> + * get_dbg_info_table() - get debug info table
> + *
> + * Return:	debug info table or NULL
> + */
> +static void *get_dbg_info(void)
> +{
> +	void *dbg =3D NULL;
> +	efi_uintn_t i;
> +
> +	for (i =3D 0; i < systable->nr_tables; ++i) {
> +		if (!memcmp(&systable->tables[i].guid, &dbg_info_guid,
> +			    sizeof(efi_guid_t))) {
> +			dbg =3D systable->tables[i].table;
> +			break;
> +		}
> +	}
> +	return dbg;
> +}
> +
> +/**
> + * print_info() - print loaded image protocol
> + */
> +static void print_info(struct efi_loaded_image *info)
> +{
> +	print(u"  Address: [");
> +	printp(info->image_base);
> +	print(u", ");
> +	printp(info->image_base + info->image_size - 1);
> +	print(u"]\r\n");
> +	if (device_path_to_text && info->file_path) {
> +		u16 *string;
> +
> +		string =3D device_path_to_text->convert_device_path_to_text(
> +					info->file_path, true, false);
> +		if (!string) {
> +			error(u"ConvertDevicePathToText failed");
> +		} else {
> +			print(u"  File: ");
> +			print(string);
> +		}
> +		print(u"\r\n");
> +	}
> +}
> +
> +/**
> + * do_dump() - print debug info table
> + */
> +static efi_status_t do_dump(void)
> +{
> +	struct dbg_info_header *dbg;
> +	u32 count;
> +
> +	dbg =3D get_dbg_info();
> +	if (!dbg) {
> +		error(u"Debug info table not found\r\n");
> +		return EFI_NOT_FOUND;
> +	}
> +	if (dbg->status & 0x01) {
> +		error(u"Update in progress\r\n");
> +		return EFI_LOAD_ERROR;
> +	}
> +	if (dbg->status & 0x02)
> +		print(u"Modified\r\n");
> +	print(u"Number of entries: ");
> +	printu(dbg->size);
> +	print(u"\r\n");
> +
> +	count =3D dbg->size;
> +	for (u32 i =3D 0; count; ++i) {
> +		struct dbg_info *info =3D dbg->info[i];
> +
> +		/*
> +		 * The EDK II implementation decreases the size field and
> +		 * writes a NULL value when deleting an entry which is not
> +		 * backed by the UEFI specification.
> +		 */
> +		if (!info) {
> +			print(u"Deleted entry\r\n");
> +			continue;
> +		}
> +		--count;
> +		print(u"Info type ");
> +		printu(info->type);
> +		print(u"\r\n");
> +		if (info->type !=3D 1)
> +			continue;
> +		print_info(info->info);
> +		print(u"  Handle: ");
> +		printp(info->handle);
> +		print(u"\r\n");
> +	}
> +
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * efi_main() - entry point of the EFI application.
> + *
> + * @handle:	handle of the loaded image
> + * @systab:	system table
> + * Return:	status code
> + */
> +efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
> +			     struct efi_system_table *systab)
> +{
> +	efi_status_t ret;
> +
> +	handle =3D image_handle;
> +	systable =3D systab;
> +	cerr =3D systable->std_err;
> +	cout =3D systable->con_out;
> +	cin =3D systable->con_in;
> +	bs =3D systable->boottime;
> +
> +	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
> +	cout->clear_screen(cout);
> +	cout->set_attribute(cout, EFI_WHITE | EFI_BACKGROUND_BLACK);
> +	print(u"Debug Info Table Dump\r\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D\r\n\r\n");
> +	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
> +
> +	ret =3D bs->locate_protocol(&guid_device_path_to_text_protocol,
> +				  NULL, (void **)&device_path_to_text);
> +	if (ret !=3D EFI_SUCCESS)	{
> +		error(u"No device path to text protocol\r\n");
> +		device_path_to_text =3D NULL;
> +	}
> +
> +	for (;;) {
> +		u16 command[BUFFER_SIZE];
> +		u16 *pos;
> +		efi_uintn_t ret;
> +
> +		print(u"=3D> ");
> +		ret =3D efi_input(command, sizeof(command));
> +		if (ret =3D=3D EFI_ABORTED)
> +			break;
> +		pos =3D skip_whitespace(command);
> +		if (starts_with(pos, u"exit"))
> +			break;
> +		else if (starts_with(pos, u"dump"))
> +			do_dump();
> +		else
> +			do_help();
> +	}
> +
> +	cout->set_attribute(cout, EFI_LIGHTGRAY | EFI_BACKGROUND_BLACK);
> +	cout->clear_screen(cout);
> +	return EFI_SUCCESS;
> +}

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

