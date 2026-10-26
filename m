Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD3606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Oa2RG5Ty;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gJnop2Ka
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33E3480A5A;
	Mon, 26 Oct 2026 16:38:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GgErI9krzRNH; Mon, 26 Oct 2026 16:38:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18F7E809B3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032734;
	b=M407WaVhI1oCOX7FJtVtcJc3mQY6+RQ6DtD9DUYx4EmYGcu80wMNKU2Xj7KDAJ1sREh5
	 0dzuwSFTahifYlGuhvxxFbVjH13uCF+VffIWZH96UU+l0o5UXj1iZPqmu66rC19Pe9YsZ
	 cHcSqhshOmRKdgnumt4b6UmXIHU38NY2bW8FcNeQMD/ZAowfY9evK5ZaVNFeVI6Ey0bSE
	 ivfHj5JHnggsKg89Y24mhPdEa/g90XzB44iezTRjr0phNVnu9aUMfZViTXCPWyhsE+/BG
	 bBCUQSp2OCzOv93y5O288DK+pV4XDtyn3pT52ItT03cUNUx/YtaiSwVPGu0QSgWfUKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793032734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fv24eQVdcmiKvN9j3iOSWF6b8xQRyX9G6xBsQ10fyYw=;
	b=e/a3Cz+eS2TnPWbBHd57PUBLnhm8fp/lkqNV9kZPXxnymR06FKwbr/i8RqqyfP0+/mEw
	 bxWyYe5jCwmqlSZ+x9d4X6v0/Ziw13fKt7hBkvBWqYffbxf3lweSa/srpYZn6NzVbfkz7
	 wYeepp57x1DXCNqXslUyK2OXAqZfn9q1fRbYc9K/+SIGUFZNzSlCZ2X+B90jTAy8TxOPE
	 vXa/B+NLHmyDROYRBVLbu5gnr6oJOoaeYwvFNTfcmZK9jvziff8jGMgL6GxJsgJyIfBHb
	 xcZpnh9nRQMxcerHOWIRsFeFJmgkRUNBYUQh72l95/R8gvWbXky2T5dgOllIlqtcTeg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793032734;
	bh=fv24eQVdcmiKvN9j3iOSWF6b8xQRyX9G6xBsQ10fyYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oa2RG5TyLDLVNrCozT+9KsjcQLvbA/qWMtyVXw1driQp7jzqFNMbd4Bu313I2Surv
	 NPRd7p+/tooSNgbPCw/PbVLCaK51DfB/0gzjM/UIUHjeQ2YnOfrhr5NlYsQd0aUeRq
	 Cg9FbDOXLmmwZRsnzetk3FAzvw3ds6NrS0qixOtMURocyhmpPoiBwZ0mL5giWyuD83
	 ojyTrZySIk3isvNiQRcMTO0IaqTFpbQ9rMjnTpyp2jLZJo3Rc3ny2d6RfxCRzAb23y
	 DqPJ4qDaotZpIGM7MFX4bUshT9TY9NbiDQK5NsYfjFdEPqrVxxI/rhJdLBswyztbnc
	 B4ZfXqXr0+4kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18F7E809B3;
	Mon, 26 Oct 2026 16:38:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FE74235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 518754043C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vt9aQSYNqTJz for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:38:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4656403D8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793032731;
 b=KPpdAGW6WYEF9TginLSekHSN9SuTo9IIds+frZtwsjr179wbJ95AulXvpS0vMTOJubPJ
 CRgF0FgrpcUNp2tyUVdT/8Xnmw2m+D7oEIEuVU+JPOjosxwmuUDu/mUMEWvJlor93cOJH
 1snBbuOvyBiHfXCPMjWohPWwEIcDyjARH/4IL57ii8z/T6UjZ2TRAiCNl5UxOl8w8eYjf
 VyorzNn0/UWLlFrqs/X8CCkGxSYnvNZQcteX+dG5KiGyqoFNygg6iGNF6qQPpovx7xcwD
 mxorkQUvdRPmCNrAC2AqFtKosfp8NQgp94yp1JfBppUqbfxl6tDPXZ8uxzc1EWkUm3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032731;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=fv24eQVdcmiKvN9j3iOSWF6b8xQRyX9G6xBsQ10fyYw=;
 b=BTFvrZs2s6htgqb8cMAy62SRuCOxQCzjTa3p1m6e2yfbzTJuqFD7tIf0N+7Uu1rSewwj
 vhEzCVP5zDOpKRH50+PUFrH7MzNZcZJd+MpjxhLiupPSg07NanjR4zjeSaSm3lkIdv4On
 UssTmPN32xMirf6v/X9wwlLQDcUOfad52sjOSxREoaHfoaRrIbJmjuViI95kYUJAuCOlf
 QXXPsYT4BtaaWWCmWy3SAPFigTNrOwBw8oJZzUY1QYh1JW8p2QPTCig1rWeSxrv2JMBFy
 A0APWbp1dKvnMndvmYGJXHbnhEqlvHgxQVzjMkNHgKyeNG6S03gsRro9qXTynbRva1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=gJnop2Ka; 
 arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=gJnop2Ka
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4656403D8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793032728; x=1793637528; i=xypron.glpk@gmx.de;
 bh=fv24eQVdcmiKvN9j3iOSWF6b8xQRyX9G6xBsQ10fyYw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gJnop2KalDggu4+tjtcp6r0CGt3A/uBOBefAuGCch1flFJOUgTNDbgp1NYuE3agQ
 hTV73r3inrhmsNaJZFZnJ2rONJGsautZBK0+TBqGhdK8wjdOQWmzeifFzYOmfrijd
 JRNh9bd/SDpm3czT/xYUUcwF5G+GoJFFb9UQKzZowSqRTTXzSdcMgVf9jtJW7u1FX
 1rqkMtAAqs9+4PNjOT7L7ul0shu1rW8epiT7WH5SVbBp6VinsdiCtu8dQXYjxAXKA
 J0pUDFCceTPD1mYP6mq6TpWjO6QJvdEfkEJOFcraqS5RGh3beN+tHFT2u5q8Zb+yP
 dRNCOs/fjM7gXWvajQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1wfTOJ40qW-00oeI3; Mon, 26
 Oct 2026 17:38:48 +0100
Message-ID: <d4919857-2483-401c-ba42-06ef929bdda5@gmx.de>
Date: Mon, 26 Oct 2026 17:38:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 6/6] test: lib: add tests for the capsule size
 checks
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
 <38f3c18f-2523-4284-910f-6b68c2c58950@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <38f3c18f-2523-4284-910f-6b68c2c58950@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fALlkzWWE6BY18aTykshzEZuwPJVPm5N6+CXritzR0ZZf22kg6f
 kBytXpPV6gukTRoqP2G24D27aYFV5Wo00E5Ec5J1WsyCC0BtIwdYOLA92i5UnD5dk/HhEoc
 RIPKDSRBXY/dC9j9VPZWUkLurI339232ghJM0xn1Q0xJH/iwOOBKVZefYJdCzN4a7SJ0eSx
 Nk6n2QBu43moqFcH4pgUA==
UI-OutboundReport: notjunk:1;M01:P0:rVWgYeHl5JQ=;1BnpINEo1/fsK8lFN/XFH6I1zxb
 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
 gg=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 14:19, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
>=20
> Add unit tests that pass malformed FMP capsules to efi_update_capsule()
> and an image with a certificate longer than itself to
> efi_capsule_authenticate(), and check that they are rejected:
>=20
> - a capsule ending inside the FMP capsule header;
> - an item offset list running past the end of the capsule;
> - an item offset that wraps around when the image header size is added;
> - an image or vendor code larger than the rest of the capsule;
> - a certificate longer than the image.
>=20
> Each capsule is built inside a larger zeroed buffer, so that without the
> checks the code reads the bytes around it and returns another status
> (for the certificate, a wrapped image size) instead of faulting.
>=20
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   test/lib/Makefile      |   1 +
>   test/lib/efi_capsule.c | 193 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 194 insertions(+)
>   create mode 100644 test/lib/efi_capsule.c
>=20
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index 9fc4a1a9b5d..0fb6c6eabde 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -10,6 +10,7 @@ obj-y +=3D abuf.o
>   obj-y +=3D alist.o
>   obj-$(CONFIG_ECDSA_VERIFY_MBEDTLS) +=3D ecdsa.o
>   obj-$(CONFIG_EFI_LOADER) +=3D efi_device_path.o efi_memory.o
> +obj-$(CONFIG_EFI_CAPSULE_FIRMWARE) +=3D efi_capsule.o

Thanks for adding tests. Maybe consider if patches 1, 2, 5 can also be=20
covered.

Best regards

Heinrich

>   obj-$(CONFIG_EFI_SECURE_BOOT) +=3D efi_image_region.o
>   ifdef CONFIG_RISCV
>   obj-$(CONFIG_USE_PRIVATE_LIBGCC) +=3D test_clz.o
> diff --git a/test/lib/efi_capsule.c b/test/lib/efi_capsule.c
> new file mode 100644
> index 00000000000..7e4e1e69540
> --- /dev/null
> +++ b/test/lib/efi_capsule.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Test the size checks of capsule updates
> + *
> + * Copyright (c) 2026 Ana Bobillo <anabobillo3@gmail.com>
> + */
> +
> +#include <efi_loader.h>
> +#include <pe.h>
> +#include <test/lib.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +
> +static const efi_guid_t fmp_capsule_guid =3D
> +	EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
> +
> +/*
> + * Capsules are built in the middle of this buffer, so that the bytes
> + * before and after a capsule are zero and can be read without a fault
> + * if a size check is missing.
> + */
> +static u8 buf[1024] __aligned(8);
> +
> +/**
> + * fmp_capsule_init() - set up an FMP capsule in the middle of buf
> + *
> + * @fmp_size:	size of the FMP capsule following the capsule header
> + * Return:	capsule header
> + */
> +static struct efi_capsule_header *fmp_capsule_init(size_t fmp_size)
> +{
> +	struct efi_capsule_header *capsule =3D (void *)buf + 256;
> +
> +	memset(buf, 0, sizeof(buf));
> +	guidcpy(&capsule->capsule_guid, &fmp_capsule_guid);
> +	capsule->header_size =3D sizeof(*capsule);
> +	capsule->capsule_image_size =3D sizeof(*capsule) + fmp_size;
> +
> +	return capsule;
> +}
> +
> +/**
> + * update_capsule() - pass one capsule to UpdateCapsule()
> + *
> + * @capsule:	capsule header
> + * Return:	status code
> + */
> +static efi_status_t update_capsule(struct efi_capsule_header *capsule)
> +{
> +	return EFI_CALL(efi_update_capsule(&capsule, 1, 0));
> +}
> +
> +/* efi_capsule_update_firmware() must check the FMP capsule header size=
 */
> +static int lib_test_efi_capsule_update_fmp_header(struct unit_test_stat=
e *uts)
> +{
> +	struct efi_capsule_header *capsule;
> +	struct efi_firmware_management_capsule_header *fmp;
> +
> +	/* The FWU checks reject a capsule before it is parsed */
> +	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
> +		return -EAGAIN;
> +
> +	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +
> +	/* The capsule ends after the version field */
> +	capsule =3D fmp_capsule_init(sizeof(fmp->version));
> +	fmp =3D (void *)capsule + capsule->header_size;
> +	fmp->version =3D 1;
> +	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
> +
> +	return 0;
> +}
> +LIB_TEST(lib_test_efi_capsule_update_fmp_header, 0);
> +
> +/* efi_capsule_update_firmware() must check the item offset list size *=
/
> +static int lib_test_efi_capsule_update_item_list(struct unit_test_state=
 *uts)
> +{
> +	struct efi_capsule_header *capsule;
> +	struct efi_firmware_management_capsule_header *fmp;
> +
> +	/* The FWU checks reject a capsule before it is parsed */
> +	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
> +		return -EAGAIN;
> +
> +	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +
> +	/* Room for eight item offsets, but nine items */
> +	capsule =3D fmp_capsule_init(sizeof(*fmp) + 8 * sizeof(u64));
> +	fmp =3D (void *)capsule + capsule->header_size;
> +	fmp->version =3D 1;
> +	fmp->embedded_driver_count =3D 8;
> +	fmp->payload_item_count =3D 1;
> +	/* The ninth item offset lies past the end of the capsule */
> +	fmp->item_offset_list[8] =3D sizeof(*fmp);
> +	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
> +
> +	return 0;
> +}
> +LIB_TEST(lib_test_efi_capsule_update_item_list, 0);
> +
> +/* efi_capsule_update_firmware() must check an item offset without over=
flow */
> +static int lib_test_efi_capsule_update_item_offset(struct unit_test_sta=
te *uts)
> +{
> +	struct efi_capsule_header *capsule;
> +	struct efi_firmware_management_capsule_header *fmp;
> +	struct efi_firmware_management_capsule_image_header *image;
> +
> +	/* The FWU checks reject a capsule before it is parsed */
> +	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
> +		return -EAGAIN;
> +
> +	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +
> +	capsule =3D fmp_capsule_init(sizeof(*fmp) + sizeof(u64) +
> +				   sizeof(*image) + 16);
> +	fmp =3D (void *)capsule + capsule->header_size;
> +	fmp->version =3D 1;
> +	fmp->payload_item_count =3D 1;
> +	/* Offset plus image header size wraps around to zero */
> +	fmp->item_offset_list[0] =3D -(u64)sizeof(*image);
> +	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
> +
> +	return 0;
> +}
> +LIB_TEST(lib_test_efi_capsule_update_item_offset, 0);
> +
> +/* efi_capsule_update_firmware() must check the image and vendor code s=
izes */
> +static int lib_test_efi_capsule_update_image_size(struct unit_test_stat=
e *uts)
> +{
> +	struct efi_capsule_header *capsule;
> +	struct efi_firmware_management_capsule_header *fmp;
> +	struct efi_firmware_management_capsule_image_header *image;
> +
> +	/* The FWU checks reject a capsule before it is parsed */
> +	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
> +		return -EAGAIN;
> +
> +	ut_asserteq_64(EFI_SUCCESS, efi_init_obj_list());
> +
> +	capsule =3D fmp_capsule_init(sizeof(*fmp) + sizeof(u64) +
> +				   sizeof(*image) + 16);
> +	fmp =3D (void *)capsule + capsule->header_size;
> +	fmp->version =3D 1;
> +	fmp->payload_item_count =3D 1;
> +	fmp->item_offset_list[0] =3D sizeof(*fmp) + sizeof(u64);
> +	image =3D (void *)fmp + fmp->item_offset_list[0];
> +	image->version =3D 3;
> +
> +	/* The image is larger than the capsule */
> +	image->update_image_size =3D 17;
> +	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
> +
> +	/* The vendor code does not fit after the image */
> +	image->update_image_size =3D 16;
> +	image->update_vendor_code_size =3D 1;
> +	ut_asserteq_64(EFI_INVALID_PARAMETER, update_capsule(capsule));
> +
> +	/* Both fit: there is no FMP driver for the zero image type */
> +	image->update_vendor_code_size =3D 0;
> +	ut_asserteq_64(EFI_UNSUPPORTED, update_capsule(capsule));
> +
> +	return 0;
> +}
> +LIB_TEST(lib_test_efi_capsule_update_image_size, 0);
> +
> +/* efi_remove_auth_hdr() must check the certificate length */
> +static int lib_test_efi_remove_auth_hdr_length(struct unit_test_state *=
uts)
> +{
> +	struct efi_firmware_image_authentication *auth;
> +	efi_uintn_t capsule_size =3D 64;
> +	efi_uintn_t image_size;
> +	void *image;
> +
> +	if (!IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE))
> +		return -EAGAIN;
> +
> +	memset(buf, 0, sizeof(buf));
> +	auth =3D (void *)buf;
> +	/* The certificate is longer than the capsule */
> +	auth->auth_info.hdr.dwLength =3D 256;
> +	auth->auth_info.hdr.wRevision =3D WIN_CERT_REVISION_2_0;
> +	auth->auth_info.hdr.wCertificateType =3D WIN_CERT_TYPE_EFI_GUID;
> +	guidcpy(&auth->auth_info.cert_type, &efi_guid_cert_type_pkcs7);
> +
> +	ut_asserteq_64(EFI_SECURITY_VIOLATION,
> +		       efi_capsule_authenticate(buf, capsule_size, &image,
> +						&image_size));
> +	/* The image size must not have wrapped around */
> +	ut_asserteq_64(capsule_size, image_size);
> +
> +	return 0;
> +}
> +LIB_TEST(lib_test_efi_remove_auth_hdr_length, 0);

