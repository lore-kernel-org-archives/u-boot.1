Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17563C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F5B81F32;
	Wed,  7 May 2025 17:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hhyvVUIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06F1820EB; Wed,  7 May 2025 17:07:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCA48059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746630475; x=1747235275; i=xypron.glpk@gmx.de;
 bh=c5xJWRR83tOi3IQh0QCa3TkcAn5TmJZMW/ak6HKNcWY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hhyvVUINN1a2dVVSiygKNMyNCYjGO/JOmrlk7PAzXbqZbaMoJy4R71WzFC1+tqNW
 UwN8jRRfP9I7L9TX8cn1G3bkZVgjibiTl9Y51UAQems12/Gng4yr7jeswTp/UH4o3
 ZwzUka/zDTYBG9mDd0U8KU8vFEgena/1tQdgPVdjAV0OJ9kAYPwp0oYYlbndlubzY
 qKyQUdIuYmNfbLNOW51WkL/YDW7DNT0PBdEKNgU1uSmLdacJwJFxER/EaYDvKxLQs
 eXhQqYZ2ghIkjWcIk5AN/zIVecll8Wnjb00DhAfLNA1HJtZhd7hocM6bt8C3KCnGQ
 pLAK+TkeoXGCvACrOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([213.157.19.150]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1uZ6WS3RCw-00UcnS; Wed, 07
 May 2025 17:07:54 +0200
Date: Wed, 07 May 2025 17:07:53 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
CC: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH 2/3] efi_loader: fix dtbdump output color and format
User-Agent: Thunderbird for Android
In-Reply-To: <20250507144619.3288456-3-adriano.cordova@canonical.com>
References: <20250507144619.3288456-1-adriano.cordova@canonical.com>
 <20250507144619.3288456-3-adriano.cordova@canonical.com>
Message-ID: <E5E2285E-9BD4-4DE5-A621-CC0B4BAF5885@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fyqtemhIwZG/ecJQxnlBvotOAap+5PmOuk70qeZe7RUugh3F5gK
 LbqdOf98MyVZvDeVYVQFA77vY8cerAbV4dyJQTf61o0VgaA2V9pB/D6rJcidK8JDkpIu5DL
 wzsCsTo60YpqootPRn97enxyOZNXCubayYBF5OkFKIZ69Yj8szdbLsgTZGhGCot/Eo0HlFh
 uFY58dQCGIONn0MIWJaiw==
UI-OutboundReport: notjunk:1;M01:P0:JyfgEB7P6Qc=;47tiiXhDuUYW96CvWiXmrZk7Qac
 48EtLvijYw0oLiBPL08ytpMl50aHFvBch0x83t/B/2P5F03/ZB6mc5iHOclJzc3ywuSmidO0y
 GQAGc59dd/BM02F/SLxYYkWVo4kKqLPnF7eHKCklpIFU1f4meGkZObTSUcF1SnBVSXlJGXa1M
 PVJNDTIp1KEzHSKLn8vXAeBIUsLQqD7W6j1kHpl9tuExgkbniYXHwIN29X1/9QJ2eixEbBk3g
 Ll1t6zPJUr58Z21iCOU3U1GBJzNppk6HKm8aVj5BFnmlexd5BDsf5KLsg+KvRSzaP89LShfHk
 zuu+QvUAdI0DcMDr9RuEOxzmE5HNNoFXPsBB680TmdYmTyJE5EnD7YpRaJhh8NWOEnOYi/nXp
 JHtbhWhDvXqaEnz1GVDKMbOQbxB0g63SkIuGRd54Ghz/PCb9hZB7Zbgjc0HtBCYlZd0SN8XwF
 Ir3leK+rDeXhla7zmNEQOO9JAFyHAmd8OUqHbx40WkjLfqbHnKKu5499JWnoWqfFabct8T1oT
 xXALDbK37KSx4vonEKQknaWkWIv8+4zHA6lLq/1pSVUWEKAipk6Xx8s282I91uBndRZUCeb9a
 G1RjuP9VPHpvbkUo1h55GBo9MWEaJKoBPjmNVoEHAF8RQzucDM9cW7u5GqiqKvu6RRq/r/Mz6
 UBFxnBlNho7av4u9iooYrJvj/+XccJzGSYH4I2XmAYq0VlNLZqGiOnbCONKv9gvDzt0m42lXV
 yi+kM6MnbcGnD/Bp0/y0pPYYSplTF3ukf9ckMihLs7DLEdiKUsww4YHe5W3ZWxzONH/OcsFDe
 c2fgNilcApAY5COy6hVEj7qLyWCREfsQiGueF5xYl0PMs7/ZPFtqoTT3mqST+Z5cT97O7BCvf
 6uhMjz+cbfi7Fkv5Ck3OiJ6qzl2SThGaWO3NHf2wyIHdRZ1yRGXjVo0e3JsgfyEj87XM3Kmh+
 WlyN+ljZJIsJJfe3wIQmzsfRNclNz9KtdZUgTyUjdQPD0DqxSWcO7kb4TpqDe48UVh56IN/hw
 OmYp0hS8b9eXnaraZC+fnjETZdIZUfv/IM5//ghxvYZ1jQFc4OR9ci68aWUH8aK1FZYI9PLwm
 DFaj0NTYKJNMMuKSFxk6Zya62NFWHKmuEdy5US+B3ZIWYug/R7Y5goJkq1t0YFhNzmNSs/FDo
 1YSEolIP37nZnAvHPLUFDBDn0tUzhIKLOeBYea3Hhvfpv6heo46e1RIfMZ454daMT8BewTd/x
 spzikb08I4/QqDjZgY4sdIy3KKxFmvVhEHQrxe2usPFZTjc2+xZxNqE+JO05yMkYIWEOtZSrp
 QhV3q7w+n56cO87LUjkDCEqqOPP6a5rEm43Sfcj8YiDvJM9oAgsnnrIKHyNIK/nhDanYgXYrW
 GRouy/zKCHSgLsUw6wBp2FJCKhRVmPJ+OgiOZlaVHPrVuAtI91KerlJhU8gbHQtCsYAuCNlpz
 mTINSt4w/Ny7p/0EwFzKuWxG5QBTbf83XI6IgL2k3E3gQ8WuxxZ8+CloNd51UZYUr5IcF1Ve+
 p+OcS6i7lk5bljGSLfpqkTXZm6kp2h+fnRJkYaJbH8epGCxgiBC4HtW16Z5k1Ny7sLeDScPWk
 96enkT2HtPff03kUWtRXokTdIs8fk5K5ygKmKtBRiiXUmNTLZSUYTSoWeRRn/lkvIJjHluRpW
 be3XtMAlLWphqT3LKRgnSaW6DylOjiWgTDNBLI/v7vL4b9mtOQ1qoIwTuaGeKIpMzBPvwwgYr
 sD0unPjFuYjtYzgyk/dA+LgtusgEuZt1fwJctvGG0TQwXMhkiIG7kAIXhoVGXpVSml384FhCA
 +JHRchJOMu5hnlXb/EEP+zx44lp3fBbLROTecOh5nSV4p83Pi0FVKKHsQ+B4hBu4KV0CLmsDJ
 9vlQ6cv5UdKB1BjlwKhjvJ+AfQ8iQSYxF9axUiBsd+glYUglJoUsf7NQzybAo/STXw1k76Llo
 Twb6DRQ20rfHNM/WcndxDVxgNExLw3PW1CAqTRTRjvY/8c7Yr4/yEIX3mLJxXD0VtDOYahzcX
 GsV7u3rJMBhVRT2BcG1FBkHLR32jAKmHBwmXowPsKE8HkiNR2uK4o4Igco5eSTgF4FqphL1nA
 zHjpFB12kSUuIoJADggEOjH1TlYyaLCebeHiAFo7e05/eultnxqAXm6t73YjnrPmUTcqUYt50
 fra+jS0cJkiFt5vRmW7k5q00TnbVbaDWht7GN2Ih+9EcaxTh5rq+N6uRJN6Z2ik9di4OoBEki
 44vktt+Fran9DANyfH4zdHF3fkZszUHPj7Fg7FxqEdC8ybJgDdZ6R/6cw8HnEfYh+0cwmhybS
 ITWB2z04ca+y/swhfkGYYCdS0PILz7KjTL5HfuPL50TG42FrsVut6aOcmRBSj3P01eGOk7k6J
 dmjI1y4fs0Sg5NLtQ6nFbS4z0oLmiovNF/rPcyS6pT6/7g59CRpZ869sUxmCv8B2+YsQaDK9v
 E9irV878TCPYekPvJwyJ0PKD2iWx3sl0OdzDT1whs2DIvgQJoLOzbdSSmh5kBzOTHXwYwaiv1
 Joubqhxex+LZnxHE1P+Ci00Af9D3wbr9UzTPVYHIqrKUuteUblUEAOUqTrdzAQdVE+0zQYIXu
 lsTlhZn8n3kgeb1c0fmnw105fri/iRVuHePeKqAUyWwLkluKOPX994NH35bOpSb7hbOPpaNTj
 qfkD4+Fb0K9s/pqh3x8Vest3eyN7NztGytUxE9dcmm9ni0uujvnJjD8MdYTnsn6EPQSEoAoIM
 BFy6go23MdXeFbGfbE3gMc8qa061rs1lf6vFHHOLPPSBUxwWDliIkINRZwAaRtSvdIQiLQh/u
 5Hd10eTM0JSKwNth8JeHfwgk0GvJEgL4gsl5FJ9LtgabrPg4eaccH3Kn0EuF8cuP7XPtlz94n
 z3NdftRtUCeSsUfUZQFjKZFHSFD1KBQ5xJxEKR3sNc05U4IeZADXJ8GOaWJ64xrVJzO28IGaP
 YlRJgODmsJbA6TQx+vI8abLp1jqYRa3qfI39vzoAoWRIAhkswZz51hgJqvvDJMiVCbRlCrZGz
 jjqOkz104CC/BQBc30rAzMgtOqOcAmn4+6OadKQb9TPRF982qfkPxAVd6+103dl8nSCRmjhQ8
 1f+5EoPL8Q9vHlCWAPuONqaN+U2GJiHkwyikPZDRDugm7s3BZqyZHR4guNxvU99pjBqVWv1l3
 0gdo=
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

Am 7=2E Mai 2025 16:46:18 MESZ schrieb Adriano Cordova <adrianox@gmail=2Eco=
m>:
>Imitate in dtbdump what initrddump does for color,
>newlines and input handling=2E The output parsing in
>the CI is strict and with the current output the CI
>is not recongnizing the prompt '=3D>'=2E
>
>Signed-off-by: Adriano Cordova <adriano=2Ecordova@canonical=2Ecom>
>---
> lib/efi_loader/dtbdump=2Ec | 86 ++++++++++++++++++++++++++++++++++------
> 1 file changed, 74 insertions(+), 12 deletions(-)
>
>diff --git a/lib/efi_loader/dtbdump=2Ec b/lib/efi_loader/dtbdump=2Ec
>index a3d59a2fd3b=2E=2E1e72404ecc1 100644
>--- a/lib/efi_loader/dtbdump=2Ec
>+++ b/lib/efi_loader/dtbdump=2Ec
>@@ -29,6 +29,18 @@ static struct efi_system_table *systable;
> static const efi_guid_t efi_dt_fixup_protocol_guid =3D EFI_DT_FIXUP_PROT=
OCOL_GUID;
> static const efi_guid_t efi_file_info_guid =3D EFI_FILE_INFO_GUID;
> static const efi_guid_t efi_system_partition_guid =3D PARTITION_SYSTEM_G=
UID;
>+static bool nocolor;
>+
>+/**
>+ * color() - set foreground color
>+ *
>+ * @color:	foreground color
>+ */
>+static void color(u8 color)
>+{
>+	if (!nocolor)
>+		cout->set_attribute(cout, color | EFI_BACKGROUND_BLACK);
>+}
>=20
> /**
>  * print() - print string
>@@ -87,6 +99,17 @@ static void printx(unsigned char val)
> 	print_hex_digit(val & 0xf);
> }
>=20
>+/**
>+ * cls() - clear screen
>+ */
>+static void cls(void)
>+{
>+	if (nocolor)
>+		print(u"\r\n");
>+	else
>+		cout->clear_screen(cout);
>+}
>+
> /**
>  * error() - print error string
>  *
>@@ -94,9 +117,17 @@ static void printx(unsigned char val)
>  */
> static void error(u16 *string)
> {
>-	cout->set_attribute(cout, EFI_LIGHTRED | EFI_BACKGROUND_BLACK);
>+	color(EFI_LIGHTRED);
> 	print(string);
>-	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
>+	color(EFI_LIGHTBLUE);
>+}
>+
>+/**
>+ * efi_drain_input() - drain console input
>+ */
>+static void efi_drain_input(void)
>+{
>+	cin->reset(cin, true);
> }
>=20
> /**
>@@ -116,8 +147,6 @@ static efi_status_t efi_input_yn(void)
> 	efi_uintn_t index;
> 	efi_status_t ret;
>=20
>-	/* Drain the console input */
>-	ret =3D cin->reset(cin, true);
> 	for (;;) {
> 		ret =3D bs->wait_for_event(1, &cin->wait_for_key, &index);
> 		if (ret !=3D EFI_SUCCESS)
>@@ -158,8 +187,6 @@ static efi_status_t efi_input(u16 *buffer, efi_uintn_=
t buffer_size)
> 	u16 outbuf[2] =3D u" ";
> 	efi_status_t ret;
>=20
>-	/* Drain the console input */
>-	ret =3D cin->reset(cin, true);
> 	*buffer =3D 0;
> 	for (;;) {
> 		ret =3D bs->wait_for_event(1, &cin->wait_for_key, &index);
>@@ -262,6 +289,9 @@ static u16 *skip_whitespace(u16 *pos)
>  */
> static bool starts_with(u16 *string, u16 *keyword)
> {
>+	if (!string || !keyword)
>+		return false;
>+
> 	for (; *keyword; ++string, ++keyword) {
> 		if (*string !=3D *keyword)
> 			return false;
>@@ -737,6 +767,7 @@ static efi_status_t do_dump(void)
> 				error(u"Missing end node\r\n");
> 				return EFI_LOAD_ERROR;
> 			}
>+			print(u"\r\n");
> 			return EFI_SUCCESS;
> 		default:
> 			error(u"Invalid device tree token\r\n");
>@@ -748,6 +779,30 @@ static efi_status_t do_dump(void)
> 	return EFI_LOAD_ERROR;
> }
>=20
>+/**
>+ * get_load_options() - get load options
>+ *
>+ * Return:	load options or NULL
>+ */
>+static u16 *get_load_options(void)
>+{
>+	efi_status_t ret;
>+	struct efi_loaded_image *loaded_image;
>+
>+	ret =3D bs->open_protocol(handle, &loaded_image_guid,
>+				(void **)&loaded_image, NULL, NULL,
>+				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>+	if (ret !=3D EFI_SUCCESS) {
>+		error(u"Loaded image protocol not found\r\n");
>+		return NULL;
>+	}
>+
>+	if (!loaded_image->load_options_size || !loaded_image->load_options)
>+		return NULL;
>+
>+	return loaded_image->load_options;
>+}
>+
> /**
>  * efi_main() - entry point of the EFI application=2E
>  *
>@@ -758,24 +813,31 @@ static efi_status_t do_dump(void)
> efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
> 			     struct efi_system_table *systab)
> {
>+	u16 *load_options;
>+
> 	handle =3D image_handle;
> 	systable =3D systab;
> 	cerr =3D systable->std_err;
> 	cout =3D systable->con_out;
> 	cin =3D systable->con_in;
> 	bs =3D systable->boottime;
>+	load_options =3D get_load_options();
>+
>+	if (starts_with(load_options, u"nocolor"))
>+		nocolor =3D true;
>=20
>-	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
>-	cout->clear_screen(cout);
>-	cout->set_attribute(cout, EFI_WHITE | EFI_BACKGROUND_BLACK);
>+	color(EFI_LIGHTBLUE);
>+	cls();
>+	color(EFI_WHITE);
> 	print(u"DTB Dump\r\n=3D=3D=3D=3D=3D=3D=3D=3D\r\n\r\n");
>-	cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
>+	color(EFI_LIGHTBLUE);
>=20
> 	for (;;) {
> 		u16 command[BUFFER_SIZE];
> 		u16 *pos;
> 		efi_uintn_t ret;
>=20
>+		efi_drain_input();
> 		print(u"=3D> ");
> 		ret =3D efi_input(command, sizeof(command));
> 		if (ret =3D=3D EFI_ABORTED)
>@@ -793,7 +855,7 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handl=
e,
> 			do_help();
> 	}
>=20
>-	cout->set_attribute(cout, EFI_LIGHTGRAY | EFI_BACKGROUND_BLACK);
>-	cout->clear_screen(cout);
>+	color(EFI_LIGHTGRAY);
>+	cls();
> 	return EFI_SUCCESS;
> }

LGTM

Reviewed-by: Heinrich Schuchardt <heinrich=2Eschuchardt@canonical=2Ecom>


