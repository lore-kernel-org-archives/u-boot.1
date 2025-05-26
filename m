Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18D7C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D33082D40;
	Mon, 26 May 2025 11:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Dpqrii9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60F882D4A; Mon, 26 May 2025 11:38:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4474882CF8
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748252328; x=1748857128; i=xypron.glpk@gmx.de;
 bh=Nus6Iu053aodp/SkWeICyJuh/Fr7vRbgDi7gtqdX75I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Dpqrii9BG+9VMkgMrcDLFMriN13o6mv6V1jw548Nm/xWOGQofJNrGeCztaO9hbbQ
 +9IzYEFi/XsVSakS1KrWBUBCZQlTm62N9DQrqRL1guYBJG4wruA51nudA+HiVsqzI
 QKy8ZlGDQ4tozNSQJXlDdVGZg044nw/MoQPJnXMxn0Bpzy1c5de/rLPYj8lcSIOVP
 S8PmigVAuCmJHIZzcSd/SwRYeqDpUKt6s7wd8XeELqjnXYi2iuYKyJCql2fgws22E
 ZMqIiyjpDSIRZjWDnNW7R9taT75SJlwC5c4AzxTCUbJHdKiCKNoRq2ZKMJxpZyZDL
 t/Z6UaVqOYi388NARw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1uQf2j2qBG-00X4Jg; Mon, 26
 May 2025 11:38:47 +0200
Message-ID: <37c87d09-9a91-460b-a1b9-2ad96c46f964@gmx.de>
Date: Mon, 26 May 2025 11:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] efi_loader: Add netdump efi app
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
 <20250516081839.28587-9-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250516081839.28587-9-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uVmqL1wQC9UrxFqAlyIy0ZtKRV2G7KcP/J9kEgUEIUztk1mB5BV
 6e8aB8uJgZ9LwgFxpJGGOQZ0kXj6d6LdNiCSfoBFq124HkcVLFMs5NJSnsb4U2s4/bSnj9Y
 vMBmI3RnV3pr5ygTID7rTBhATlAyOoomMHg5zrr/Y0MY/qFRirU86vJLvStj8oxjRGHP6y4
 1S89VTxoaqaLYcwuuChRg==
UI-OutboundReport: notjunk:1;M01:P0:ARkXG1Hyip0=;+PO3vlxbWQdtI0JErk+7BXjxC4X
 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
 Qtys=
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

On 16.05.25 10:18, Adriano Cordova wrote:
> Add a netdump EFI app to test the U-Boot EFI network
> stack.
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   lib/efi_loader/Makefile  |   1 +
>   lib/efi_loader/netdump.c | 851 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 852 insertions(+)
>   create mode 100644 lib/efi_loader/netdump.c
>=20
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 92c6822bc13..98c8ad40f95 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -17,6 +17,7 @@ apps-$(CONFIG_RISCV) +=3D boothart
>   apps-$(CONFIG_BOOTEFI_HELLO_COMPILE) +=3D helloworld
>   apps-$(CONFIG_GENERATE_SMBIOS_TABLE) +=3D smbiosdump
>   apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D initrddump
> +apps-$(CONFIG_EFI_HTTP_PROTOCOL) +=3D netdump
>   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>   apps-y +=3D dtbdump
>   endif
> diff --git a/lib/efi_loader/netdump.c b/lib/efi_loader/netdump.c
> new file mode 100644
> index 00000000000..c4ed4243c56
> --- /dev/null
> +++ b/lib/efi_loader/netdump.c
> @@ -0,0 +1,851 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * netdump.efi tests EFI network protocols
> + *
> + * Specifying 'nocolor' as load option data suppresses colored output a=
nd
> + * clearing of the screen.
> + */
> +
> +#include <efi_api.h>
> +#include <charset.h>
> +#include <net.h>
> +
> +#define BUFFER_SIZE 64
> +#define ESC 0x17
> +
> +#define efi_size_in_pages(size) (((size) + EFI_PAGE_MASK) >> EFI_PAGE_S=
HIFT)
> +
> +static struct efi_system_table *systable;
> +static struct efi_boot_services *bs;
> +static struct efi_simple_text_output_protocol *cerr;
> +static struct efi_simple_text_output_protocol *cout;
> +static struct efi_simple_text_input_protocol *cin;
> +
> +static efi_handle_t http_protocol_handle;
> +static int callback_done;
> +
> +static const efi_guid_t loaded_image_guid =3D EFI_LOADED_IMAGE_PROTOCOL=
_GUID;
> +static const efi_guid_t efi_http_guid =3D EFI_HTTP_PROTOCOL_GUID;
> +static const efi_guid_t efi_http_service_binding_guid =3D EFI_HTTP_SERV=
ICE_BINDING_PROTOCOL_GUID;
> +static const efi_guid_t efi_ip4_config2_guid =3D EFI_IP4_CONFIG2_PROTOC=
OL_GUID;
> +
> +static efi_handle_t handle;
> +static efi_handle_t net_handle;
> +
> +static bool nocolor;
> +
> +/**
> + * color() - set foreground color
> + *
> + * @color:	foreground color
> + */
> +static void color(u8 color)
> +{
> +	if (!nocolor)
> +		cout->set_attribute(cout, color | EFI_BACKGROUND_BLACK);
> +}
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
> + * cls() - clear screen
> + */
> +static void cls(void)
> +{
> +	if (nocolor)
> +		print(u"\r\n");
> +	else
> +		cout->clear_screen(cout);
> +}
> +
> +/**
> + * error() - print error string
> + *
> + * @string:	error text
> + */
> +static void error(u16 *string)
> +{
> +	color(EFI_LIGHTRED);
> +	print(string);
> +	color(EFI_LIGHTBLUE);
> +}
> +
> +/*
> + * printx() - print hexadecimal number
> + *
> + * @val:	value to print;
> + * @prec:	minimum number of digits to print
> + */
> +static void printx(u64 val, u32 prec)
> +{
> +	int i;
> +	u16 c;
> +	u16 buf[16];
> +	u16 *pos =3D buf;
> +
> +	for (i =3D 2 * sizeof(val) - 1; i >=3D 0; --i) {
> +		c =3D (val >> (4 * i)) & 0x0f;
> +		if (c || pos !=3D buf || !i || i < prec) {
> +			c +=3D '0';
> +			if (c > '9')
> +				c +=3D 'a' - '9' - 1;
> +			*pos++ =3D c;
> +		}
> +	}
> +	*pos =3D 0;
> +	print(buf);
> +}
> +
> +/*
> + * printd() - print decimal byte
> + *
> + * @val:	value to print;
> + */
> +static void printd(u64 val)
> +{
> +	u16 buf[21];
> +	u16 tmp;
> +	int i =3D 0;
> +
> +	do {
> +		buf[i++] =3D '0' + (val % 10);
> +		val /=3D 10;
> +	} while (val > 0);
> +
> +	for (int j =3D 0; j < i / 2; ++j) {
> +		tmp =3D buf[j];
> +		buf[j] =3D buf[i - 1 - j];
> +		buf[i - 1 - j] =3D tmp;
> +	}
> +
> +	buf[i] =3D 0;
> +	print(buf);
> +}
> +
> +/**
> + * efi_drain_input() - drain console input
> + */
> +static void efi_drain_input(void)
> +{
> +	cin->reset(cin, true);
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
> + * Return:	true if @string starts with the keyword
> + */
> +static bool starts_with(u16 *string, u16 *keyword)
> +{
> +	if (!string || !keyword)
> +		return false;
> +
> +	for (; *keyword; ++string, ++keyword) {
> +		if (*string !=3D *keyword)
> +			return false;
> +	}
> +	return true;
> +}
> +
> +/*
> + * efi_dectoul() - decimal string to efi_uintn_t
> + *
> + * @s:		string
> + * Return:	string as efi_uintn_t
> + */
> +static efi_uintn_t efi_dectoul(char *s)
> +{
> +	efi_uintn_t result =3D 0;
> +
> +	while (*s >=3D '0' && *s <=3D '9') {
> +		result =3D result * 10 + (*s - '0');
> +		s++;
> +	}
> +	return result;
> +}
> +
> +/*
> + * parse_address() - parse string IP address into ip_addr
> + *
> + * @input:	string IP address
> + * @address:	pointer to u8[4] buffer
> + */
> +static void parse_address(u8 **input, u8 *address)
> +{
> +	int i =3D 0;
> +	efi_uintn_t part;
> +
> +	if (**input < '0' || **input > '9')
> +		return;
> +
> +	while (i <=3D 3) {
> +		part =3D efi_dectoul(*input);
> +		if (part > 255)
> +			return;
> +		address[i] =3D (u8)part;
> +		while (**input >=3D '0' && **input <=3D '9')
> +			(*input)++;
> +		if (**input =3D=3D '.')
> +			(*input)++;
> +		else
> +			break;
> +		i++;
> +	}
> +}
> +
> +/*
> + * utf16le_ascii_to_utf8() - simple utf16to utf8 converter
> + *
> + * @out:	output utf8 buffer
> + * @in:		input utf16 buffer
> + * @max_out:	maximum characters to convert
> + */
> +static int utf16le_ascii_to_utf8(char *out, const u16 *in, size_t max_o=
ut)
> +{
> +	size_t i =3D 0;
> +
> +	while (in[i] && i < max_out - 1) {
> +		if (in[i] > 0x7F)
> +			return -1;  // non-ASCII detected, not supported
> +		out[i] =3D (char)(in[i] & 0xFF);
> +		i++;
> +	}
> +	out[i] =3D '\0';
> +	return 0;
> +}
> +
> +/**
> + * do_help() - print help
> + */
> +static void do_help(void)
> +{
> +	error(u"set address <ip> <netmask> - set IP and netmask\r\n");

A netmask without a gateway for addresses that don't match the netmask=20
seems to be incomplete for successfully using wget.

Do we have a protocol for DHCP implemented that we could use?

Best regards

Heinrich

> +	error(u"get address                - get IP and netmask\r\n");
> +	error(u"set policy static          - set policy to static\r\n");
> +	error(u"wget <uri>                 - fetch a file via EFI_HTTP_PROTOCO=
L\r\n");
> +	error(u"exit                       - exit the shell\r\n");
> +}
> +
> +/**
> + * do_set_address() - sets IP and netmask using EFI_IP4_CONFIG2_PROTOCO=
L
> + *
> + * @address:		ip and netmask
> + * Return:		status code
> + */
> +static efi_status_t do_set_address(u16 *address)
> +{
> +	efi_uintn_t ret;
> +	struct efi_ip4_config2_protocol *ip4_config2;
> +	struct efi_ip4_config2_manual_address manual_address;
> +	u8 netmask[4];
> +	u8 ip[4];
> +	u8 utf8[128];
> +	u8 *tmp;
> +
> +	ret =3D bs->open_protocol(net_handle, &efi_ip4_config2_guid,
> +					(void **)&ip4_config2, 0, 0,
> +					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"set address: failed to open ipv4 config2 protocol\r\n");
> +		return ret;
> +	}
> +
> +	// Convert the UTF-16 string to UTF-8
> +	if (utf16le_ascii_to_utf8(utf8, address, sizeof(utf8)) !=3D 0) {
> +		error(u"set address: failed to convert address to utf8\r\n");
> +		return EFI_DEVICE_ERROR;
> +	}
> +
> +	tmp =3D utf8;
> +	parse_address(&tmp, ip);
> +	tmp++;
> +	parse_address(&tmp, netmask);
> +
> +	/* Set static ip and netmask */
> +	memcpy(&manual_address.address, ip,
> +	       sizeof(struct efi_ipv4_address));
> +	memcpy(&manual_address.subnet_mask, netmask,
> +	       sizeof(struct efi_ipv4_address));
> +	ret =3D ip4_config2->set_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_M=
ANUAL_ADDRESS,
> +			      sizeof(manual_address), &manual_address);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"set address: failed to set ip address and netmask\r\n");
> +		return ret;
> +	}
> +
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * do_get_address() - get IP and netmask using EFI_IP4_CONFIG2_PROTOCOL
> + *
> + * Return:		status code
> + */
> +static efi_status_t do_get_address(void)
> +{
> +	efi_uintn_t ret;
> +	struct efi_ip4_config2_protocol *ip4_config2;
> +	struct efi_ip4_config2_manual_address manual_address;
> +	efi_uintn_t data_size;
> +
> +	ret =3D bs->open_protocol(net_handle, &efi_ip4_config2_guid,
> +					(void **)&ip4_config2, 0, 0,
> +					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"get address: failed to open ipv4 config2 protocol\r\n");
> +		return ret;
> +	}
> +
> +	/* Get IP address and netmask */
> +	data_size =3D sizeof(manual_address);
> +	ret =3D ip4_config2->get_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_M=
ANUAL_ADDRESS,
> +			      &data_size, &manual_address);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"get address: failed to get IP address and netmask\r\n");
> +		return ret;
> +	}
> +
> +	print(u"CURRENT IP: ");
> +	printd(manual_address.address.ip_addr[0]);
> +	print(u".");
> +	printd(manual_address.address.ip_addr[1]);
> +	print(u".");
> +	printd(manual_address.address.ip_addr[2]);
> +	print(u".");
> +	printd(manual_address.address.ip_addr[3]);
> +	print(u"\r\n");
> +	print(u"CURRENT NETMASK: ");
> +	printd(manual_address.subnet_mask.ip_addr[0]);
> +	print(u".");
> +	printd(manual_address.subnet_mask.ip_addr[1]);
> +	print(u".");
> +	printd(manual_address.subnet_mask.ip_addr[2]);
> +	print(u".");
> +	printd(manual_address.subnet_mask.ip_addr[3]);
> +	print(u"\r\n");
> +
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * do_set_policy_static() - sets policy to static
> + *
> + * Return:		status code
> + */
> +static efi_status_t do_set_policy_static(void)
> +{
> +	efi_uintn_t ret;
> +	struct efi_ip4_config2_protocol *ip4_config2;
> +	enum efi_ip4_config2_policy policy;
> +
> +	ret =3D bs->open_protocol(net_handle, &efi_ip4_config2_guid,
> +					(void **)&ip4_config2, 0, 0,
> +					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"set polict: failed to open ipv4 config2 protocol\r\n");
> +		return ret;
> +	}
> +
> +	/* Set policy to static */
> +	policy =3D EFI_IP4_CONFIG2_POLICY_STATIC;
> +	ret =3D ip4_config2->set_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_P=
OLICY,
> +			      sizeof(policy), (void *)&policy);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to set policy\r\n");
> +		return ret;
> +	}
> +
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * select_net() - get a handle for networking
> + *
> + * Return:		status code
> + */
> +static efi_status_t select_net(void)
> +{
> +	efi_uintn_t ret;
> +	efi_uintn_t num_handles;
> +	efi_handle_t *current_handle;
> +	efi_handle_t *handles;
> +	struct efi_ip4_config2_protocol *ip4_config2;
> +
> +	num_handles =3D 0;
> +	ret =3D bs->locate_handle_buffer(BY_PROTOCOL, &efi_ip4_config2_guid,
> +				       NULL, &num_handles, &handles);
> +
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to locate ipv4 config2 protocol\r\n");
> +		return ret;
> +	}
> +
> +	for (current_handle =3D handles; num_handles--; current_handle++) {
> +		ret =3D bs->open_protocol(*current_handle, &efi_ip4_config2_guid,
> +					      (void **)&ip4_config2, 0, 0,
> +					      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +		if (ret !=3D EFI_SUCCESS)
> +			continue;
> +		break; // Get first handle that supports
> +	}
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to open ipv4 config2 protocol\r\n");
> +		return ret;
> +	}
> +
> +	net_handle =3D *current_handle;
> +
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * setup_http() - get handles and open protocols
> + *
> + * Return:		status code
> + */
> +static efi_status_t setup_http(void)
> +{
> +	efi_uintn_t ret;
> +	struct efi_http_config_data http_config;
> +	struct efi_httpv4_access_point ipv4_node;
> +	struct efi_http_protocol *http;
> +	struct efi_service_binding_protocol *http_service;
> +
> +	ret =3D bs->open_protocol(net_handle, &efi_http_service_binding_guid,
> +					(void **)&http_service, 0, 0,
> +					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to open http service binding protocol\r\n");
> +		return ret;
> +	}
> +
> +	http_protocol_handle =3D NULL;
> +	ret =3D http_service->create_child(http_service, &http_protocol_handle=
);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to create an http service instance\r\n");
> +		return ret;
> +	}
> +
> +	ret =3D bs->open_protocol(http_protocol_handle, &efi_http_guid,
> +				      (void **)&http, 0, 0, EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to open http protocol\r\n");
> +		return ret;
> +	}
> +	print(u"HTTP Service Binding: child created successfully\r\n");
> +
> +	http_config.http_version =3D HTTPVERSION11;
> +	http_config.is_ipv6 =3D false;
> +	http_config.access_point.ipv4_node =3D &ipv4_node;
> +	ipv4_node.use_default_address =3D true;
> +
> +	ret =3D http->configure(http, &http_config);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to configure http instance\r\n");
> +		return ret;
> +	}
> +
> +	return EFI_SUCCESS;
> +}
> +
> +static void EFIAPI callback_http(struct efi_event *event, void *context=
)
> +{
> +	callback_done =3D 1;
> +}
> +
> +/**
> + * execute_http() - execute http request
> + *
> + * @filename:	file name
> + * Return:	status code
> + */
> +static efi_status_t execute_http(u16 *filename, void **buffer, efi_uint=
n_t *buffer_size)
> +{
> +	efi_status_t ret;
> +	struct efi_http_protocol *http;
> +	struct efi_http_request_data request_data;
> +	struct efi_http_message request_message;
> +	struct efi_http_token request_token;
> +	struct efi_http_response_data response_data;
> +	struct efi_http_message response_message;
> +	struct efi_http_token response_token;
> +	enum efi_http_status_code status_code;
> +	efi_uintn_t len, sum, content_len;
> +	int i;
> +
> +	request_data.method =3D HTTP_METHOD_GET;
> +	request_data.url =3D filename;
> +	request_message.data.request =3D &request_data;
> +	request_message.header_count =3D 3;
> +	request_message.body_length =3D 0;
> +	request_message.body =3D NULL;
> +
> +	/* request token */
> +	request_token.event =3D NULL;
> +	request_token.status =3D EFI_NOT_READY;
> +	request_token.message =3D &request_message;
> +	callback_done =3D 0;
> +	ret =3D bs->create_event(EVT_NOTIFY_SIGNAL,
> +			TPL_CALLBACK,
> +			callback_http,
> +			NULL,
> +			&request_token.event);
> +
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to create request event\r\n");
> +		return ret;
> +	}
> +
> +	ret =3D bs->open_protocol(http_protocol_handle, &efi_http_guid,
> +				      (void **)&http, 0, 0, EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to open http protocol\r\n");
> +		return ret;
> +	}
> +
> +	ret =3D http->request(http, &request_token);
> +
> +	if (ret !=3D EFI_SUCCESS) {
> +		bs->close_event(request_token.event);
> +		error(u"Failed to proceed with the http request\r\n");
> +		return ret;
> +	}
> +
> +	while (!callback_done)
> +		http->poll(http);
> +
> +	response_data.status_code =3D HTTP_STATUS_UNSUPPORTED_STATUS;
> +	response_message.data.response =3D &response_data;
> +	response_message.header_count =3D 0;
> +	response_message.headers =3D NULL;
> +	response_message.body_length =3D 0;
> +	response_message.body =3D NULL;
> +	response_token.event =3D NULL;
> +
> +	ret =3D bs->create_event(EVT_NOTIFY_SIGNAL,
> +			TPL_CALLBACK,
> +			callback_http,
> +			NULL,
> +			&response_token.event);
> +
> +	if (ret !=3D EFI_SUCCESS) {
> +		bs->close_event(request_token.event);
> +		error(u"Failed to create response event\r\n");
> +		return ret;
> +	}
> +
> +	response_token.status =3D EFI_SUCCESS;
> +	response_token.message =3D &response_message;
> +
> +	callback_done =3D 0;
> +	ret =3D http->response(http, &response_token);
> +
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed http first response\r\n");
> +		goto fail;
> +	}
> +
> +	while (!callback_done)
> +		http->poll(http);
> +
> +	if (response_message.data.response->status_code !=3D HTTP_STATUS_200_O=
K) {
> +		status_code =3D response_message.data.response->status_code;
> +		if (status_code =3D=3D HTTP_STATUS_404_NOT_FOUND) {
> +			error(u"File not found\r\n");
> +		} else {
> +			error(u"Bad http status:\r\n");
> +			printx(response_message.data.response->status_code, 2);
> +			print(u"\r\n");
> +		}
> +		goto fail_free_hdr;
> +	}
> +
> +	for (i =3D 0; i < response_message.header_count; i++) {
> +		if (!memcmp(response_message.headers[i].field_name,
> +			    "Content-Length", sizeof("Content-Length")))
> +			content_len =3D efi_dectoul(response_message.headers[i].field_value)=
;
> +	}
> +
> +	ret =3D bs->allocate_pool(EFI_LOADER_CODE, content_len,
> +				      buffer);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed allocating response buffer\r\n");
> +		goto fail_free_hdr;
> +	}
> +
> +	*buffer_size =3D content_len;
> +	len =3D content_len;
> +	sum =3D 0;
> +	while (len) {
> +		response_message.data.response =3D NULL;
> +		response_message.header_count =3D 0;
> +		response_message.headers =3D NULL;
> +		response_message.body_length =3D len;
> +		response_message.body =3D *buffer + sum;
> +
> +		response_token.message =3D &response_message;
> +		response_token.status =3D EFI_NOT_READY;
> +
> +		callback_done =3D 0;
> +		ret =3D http->response(http, &response_token);
> +		if (ret !=3D EFI_SUCCESS) {
> +			error(u"Failed http second response\r\n");
> +			goto fail_free_buf;
> +		}
> +
> +		while (!callback_done)
> +			http->poll(http);
> +
> +		if (!response_message.body_length)
> +			break;
> +
> +		len -=3D response_message.body_length;
> +		sum +=3D response_message.body_length;
> +	}
> +
> +	if (len) {
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto fail_free_buf;
> +	}
> +
> +	if (response_message.headers)
> +		bs->free_pool(response_message.headers);
> +	bs->close_event(request_token.event);
> +	bs->close_event(response_token.event);
> +	print(u"Efi Http request executed successfully\r\n");
> +	return EFI_SUCCESS;
> +
> +fail_free_buf:
> +	bs->free_pool(*buffer);
> +	*buffer =3D NULL;
> +fail_free_hdr:
> +	if (response_message.headers)
> +		bs->free_pool(response_message.headers);
> +fail:
> +	bs->close_event(request_token.event);
> +	bs->close_event(response_token.event);
> +	return ret;
> +}
> +
> +/**
> + * do_netdump_wget() - fetch a file via EFI_HTTP_PROTOCOL
> + *
> + * @filename:	file name
> + * Return:	status code
> + */
> +static efi_status_t do_netdump_wget(u16 *filename)
> +{
> +	void *buffer;
> +	efi_uintn_t buffer_size;
> +	u32 crc32;
> +	efi_uintn_t ret =3D EFI_SUCCESS;
> +
> +	ret =3D do_set_policy_static();
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to set static network policy\r\n");
> +		return ret;
> +	}
> +
> +	ret =3D setup_http();
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to set up http protocol\r\n");
> +		return ret;
> +	}
> +
> +	buffer =3D NULL;
> +	ret =3D execute_http(filename, &buffer, &buffer_size);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to execute http request\r\n");
> +		return ret;
> +	}
> +
> +	ret =3D bs->calculate_crc32(buffer, buffer_size, &crc32);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Calculating CRC32 failed\r\n");
> +		goto out;
> +	}
> +
> +	print(u"length: ");
> +	printd(buffer_size);
> +	print(u"\r\n");
> +
> +	print(u"crc32: 0x");
> +	printx(crc32, 8);
> +	print(u"\r\n");
> +out:
> +	bs->free_pool(buffer);
> +	return ret;
> +}
> +
> +/**
> + * get_load_options() - get load options
> + *
> + * Return:	load options or NULL
> + */
> +static u16 *get_load_options(void)
> +{
> +	efi_status_t ret;
> +	struct efi_loaded_image *loaded_image;
> +
> +	ret =3D bs->open_protocol(handle, &loaded_image_guid,
> +				(void **)&loaded_image, NULL, NULL,
> +				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Loaded image protocol not found\r\n");
> +		return NULL;
> +	}
> +
> +	if (!loaded_image->load_options_size || !loaded_image->load_options)
> +		return NULL;
> +
> +	return loaded_image->load_options;
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
> +	u16 *load_options;
> +	efi_status_t ret;
> +
> +	handle =3D image_handle;
> +	systable =3D systab;
> +	cerr =3D systable->std_err;
> +	cout =3D systable->con_out;
> +	cin =3D systable->con_in;
> +	bs =3D systable->boottime;
> +	load_options =3D get_load_options();
> +
> +	if (starts_with(load_options, u"nocolor"))
> +		nocolor =3D true;
> +
> +	ret =3D select_net();
> +	if (ret !=3D EFI_SUCCESS) {
> +		error(u"Failed to set up networking\r\n");
> +		return ret;
> +	}
> +
> +	color(EFI_WHITE);
> +	cls();
> +	print(u"NET Dump\r\n=3D=3D=3D=3D=3D=3D=3D=3D\r\n\r\n");
> +
> +	color(EFI_LIGHTBLUE);
> +
> +	for (;;) {
> +		u16 command[BUFFER_SIZE];
> +		u16 *pos;
> +		efi_uintn_t ret;
> +
> +		efi_drain_input();
> +		print(u"=3D> ");
> +		ret =3D efi_input(command, sizeof(command));
> +		if (ret =3D=3D EFI_ABORTED)
> +			break;
> +		pos =3D skip_whitespace(command);
> +		if (starts_with(pos, u"exit"))
> +			break;
> +		else if (starts_with(pos, u"set address "))
> +			do_set_address(pos + 12);
> +		else if (starts_with(pos, u"get address"))
> +			do_get_address();
> +		else if (starts_with(pos, u"set policy static"))
> +			do_set_policy_static();
> +		else if (starts_with(pos, u"wget "))
> +			do_netdump_wget(pos + 5);
> +		else
> +			do_help();
> +	}
> +
> +	color(EFI_LIGHTGRAY);
> +	cls();
> +
> +	return EFI_SUCCESS;
> +}

