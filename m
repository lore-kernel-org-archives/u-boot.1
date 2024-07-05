Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110A0C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 06:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227E1885EC;
	Fri,  5 Jul 2024 08:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uCnBtggU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA3888579; Fri,  5 Jul 2024 08:54:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5631788969
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 08:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720162488; x=1720767288; i=xypron.glpk@gmx.de;
 bh=kvtZRrEn06fJGXb4OC30WECwnXvBeDBWF9EAxhKv7xs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uCnBtggUBn7wN48G3tujaQBq9CoAHPZ/eBzMU2N13aC700JY7pWjYziECPKZjiB2
 gyzaF9DbkHp+SBzPGj5MLjd1qfmx/1zd/ut+jrMpmePJ+f3SIsDg6xUcruDQhx84+
 iUZ2kQ7mnni6e+y7cIGFnf+N45HmEgs3nXnxnTG89eax7qPNkhkQzn348FCrV4+Us
 OnMG9m29yoJVwl4WWwN0uoVjWPTVFD/IqlvL5wKccIrdYnlK6uAR/gf5Q659yP+eC
 IdWpkeJ6EtKVVJ5Cda8FlL4PAVMvczUIWzzItsOaEqnzpwRGtV3Fg4ABXSznR12XL
 QUMLK751Cu+tXUzxkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU9Z-1rtqn50xZj-00f5vM; Fri, 05
 Jul 2024 08:54:48 +0200
Message-ID: <4143f8ad-2012-493f-89f1-5bfdbd018b7c@gmx.de>
Date: Fri, 5 Jul 2024 08:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] lib: uuid: add UUID v5 support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
References: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
 <20240702-b4-dynamic-uuid-v4-2-a00c82d1f504@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240702-b4-dynamic-uuid-v4-2-a00c82d1f504@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EmU86PldZKw+xivmOdwOQ0xXCRD1bvHHVd9zjIbOsw9b9HafTpp
 gCpTNU49D8d2KMvkq/dajKish4Pl/VDCaQ9KHh4zT6zL4GUDLpQTgZur7+Pa/lXcmvf1lck
 4qU92RDpr3uSeAkoO3KlJabbeuvEPeUGsjk/0LfdhqC386XvicLM6jVtcHLrzMmHtSY1xIv
 jl+n5kYYmhdzkQS2KxtSg==
UI-OutboundReport: notjunk:1;M01:P0:VH7HCjyDr6M=;HAdITBET9D0jPeRTHioVmTi20oX
 a/ivCH2HZAzuqMCNyrIlPV4HYOIWUweLrierSLEc/C+1zLHOQ8/HYOq6jyVH13CivkDS/BWDH
 cgQHMtA2cxqjsinYc4SI0M7lUBKScbL1R+hiSmi4dh9hIhiOLdbL/RX0omrDVvwlK3h4OedjX
 LFoj17o51KhWoMs91MWsNOxjW7fk31b1M5mAlrr3hmTknCmxNu3+VAR9x6GgAB7sVcasbzz+B
 cgnK9zXJPUFsU5iUQkVqef8yNfuBVGl6Mm4OWMZYrLkVwhr/Kou/WxjQI8rL021f0M+n7PZoD
 ytyvJ219wZMqko9Q681+rqjpvtU9JvO56yOWwjlLbhgfCIeGcHnkEC7BKT98ewHkjwjtfapPT
 udhy3LilxWQXSsDEO/lKMnBDR0AroXW7QBXsuq/4YkZ+0CPb5x5/PVnU/LjL3pQOIid8vz5qX
 cugmBKE0L+8k1j1VoPpUeFfllErxGP8YLF6ck1ymQr9KFi8Ohp7VkBHAKm5Sh41JmfcxNeE6+
 /Wlb6mpmjlkXTJDeoMdSoY4StAO0VCEbqIc5QlHojl9n/v1cjvI9W24zuB7DpO9W1g1NW1wVL
 /liGUriaxAstUAJeovJsgekt4dvA305HgWeenP/swb9k+RyttYwp+NX/ZcGnASAIAOdwoJfTn
 T/OoTJsrfput2SNH2Or0FUAtjjFAfQkvauhefTwXDKt25Edv7atscKGze4CEAR3d9eIwtFyFw
 n3xkwzMpY2Eg9wBXLo5Ety29q8co3mSsKEwGiAIx/oQvDB7oBFnPRfPtZfh84ZvMyHy+2v++Z
 qS7tMMAfk+AehP7MGJkFSOPCISrT+a5tqXzYpgp/wvqX4=
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

On 7/2/24 15:30, Caleb Connolly wrote:
> Add support for generating version 5 UUIDs, these are determistic and wo=
rk
> by hashing a "namespace" UUID together with some unique data. One intend=
ed
> usecase is to allow for dynamically generate payload UUIDs for UEFI
> capsule updates, so that supported boards can have their own UUIDs
> without needing to hardcode them.
>
> In addition, move the common bit twiddling code from gen_ran_uuid into a
> separate function and rewrite it not to use clrsetbits (which is not
> available when building as part of host tools).
>
> Tests for this are added in an upcoming patch.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   include/uuid.h | 17 +++++++++++++++--
>   lib/Kconfig    |  1 +
>   lib/uuid.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+-------
>   3 files changed, 67 insertions(+), 9 deletions(-)
>
> diff --git a/include/uuid.h b/include/uuid.h
> index f5a941250f48..1f4fa103b5e9 100644
> --- a/include/uuid.h
> +++ b/include/uuid.h
> @@ -10,8 +10,9 @@
>   #ifndef __UUID_H__
>   #define __UUID_H__
>
>   #include <linux/bitops.h>
> +#include <linux/kconfig.h>
>
>   /*
>    * UUID - Universally Unique IDentifier - 128 bits unique number.
>    *        There are 5 versions and one variant of UUID defined by RFC4=
122
> @@ -45,10 +46,10 @@
>    * where x is a hexadecimal character. Fields are separated by '-'s.
>    * When converting to a binary UUID, le means the field should be conv=
erted
>    * to little endian and be means it should be converted to big endian.
>    *
> - * UUID is also used as GUID (Globally Unique Identifier) with the same=
 binary
> - * format but it differs in string format like below.
> + * UUID is also used as GUID (Globally Unique Identifier) with the same=
 format
> + * but with some fields stored in little endian.
>    *
>    * GUID:
>    * 0        9    14   19   24
>    * xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
> @@ -142,8 +143,20 @@ void gen_rand_uuid(unsigned char *uuid_bin);
>    * @param          - uuid output type: UUID - 0, GUID - 1
>    */
>   void gen_rand_uuid_str(char *uuid_str, int str_format);
>
> +struct efi_guid;
> +
> +/**
> + * gen_v5_guid() - generate little endian v5 GUID from namespace and ot=
her seed data.
> + *
> + * @namespace:   pointer to UUID namespace salt
> + * @guid:        pointer to allocated GUID output
> + * @...:         NULL terminated list of seed data as pairs of pointers
> + *               to data and their lengths
> + */
> +void gen_v5_guid(const struct uuid *namespace, struct efi_guid *guid, .=
..);
> +
>   /**
>    * uuid_str_to_le_bin() - Convert string UUID to little endian binary =
data.
>    * @uuid_str:	pointer to UUID string
>    * @uuid_bin:	pointer to allocated array for little endian output [16B=
]
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 189e6eb31aa1..9aa882d5f882 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -72,8 +72,9 @@ config HAVE_PRIVATE_LIBGCC
>   	bool
>
>   config LIB_UUID
>   	bool
> +	select SHA1
>
>   config RANDOM_UUID
>   	bool "GPT Random UUID generation"
>   	select LIB_UUID
> diff --git a/lib/uuid.c b/lib/uuid.c
> index dfa2320ba267..7d0a8273d157 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -21,8 +21,9 @@
>   #include <part_efi.h>
>   #include <malloc.h>
>   #include <dm/uclass.h>
>   #include <rng.h>
> +#include <u-boot/sha1.h>
>
>   int uuid_str_valid(const char *uuid)
>   {
>   	int i, valid;
> @@ -368,8 +369,57 @@ void uuid_bin_to_str(const unsigned char *uuid_bin,=
 char *uuid_str,
>   		}
>   	}
>   }
>
> +static void configure_uuid(struct uuid *uuid, unsigned char version)
> +{
> +	uint16_t tmp;
> +
> +	/* Configure variant/version bits */
> +	tmp =3D be16_to_cpu(uuid->time_hi_and_version);
> +	tmp =3D (tmp & ~UUID_VERSION_MASK) | (version << UUID_VERSION_SHIFT);

As you wrote above time_hi is stored low-endian in a GUID and big endian
in UUID. So the version is in the byte 6 for a UUID and in byte 7 in a GUI=
D.

E.g. on my hard disk I find:

Partition unique GUID: 003EF8CE-F7E9-467F-B80D-22ED2E6E93D7
CE F8 3E 00  E9 F7 7F 46  B8 0D 22 ED  2E 6E 93 D7

Where 4 is the version.

> +	uuid->time_hi_and_version =3D cpu_to_be16(tmp);
> +
> +	uuid->clock_seq_hi_and_reserved &=3D ~UUID_VARIANT_MASK;
> +	uuid->clock_seq_hi_and_reserved |=3D (UUID_VARIANT << UUID_VARIANT_SHI=
FT);
> +}
> +
> +void gen_v5_guid(const struct uuid *namespace, struct efi_guid *guid, .=
..)
> +{
> +	sha1_context ctx;
> +	va_list args;
> +	const uint8_t *data;
> +	uint32_t *tmp32;
> +	uint16_t *tmp16;
> +	uint8_t hash[SHA1_SUM_LEN];
> +
> +	sha1_starts(&ctx);
> +	/* Hash the namespace UUID as salt */
> +	sha1_update(&ctx, (unsigned char *)namespace, UUID_BIN_LEN);
> +	va_start(args, guid);
> +
> +	while ((data =3D va_arg(args, const uint8_t *))) {
> +		unsigned int len =3D va_arg(args, size_t);
> +		sha1_update(&ctx, data, len);
> +	}
> +
> +	va_end(args);
> +	sha1_finish(&ctx, hash);
> +
> +	/* Truncate the hash into output UUID, it is already big endian */
> +	memcpy(guid, hash, sizeof(*guid));
> +
> +	configure_uuid((struct uuid *)guid, 5);


Please, provide a test that in the resulting GUID output we find the
variant and version information at the expected places:

The high nibble of the byte with index 7 should be 5.

The high nibble of the byte with index 8 should 8, 9, C, or D.

> +
> +	/* Make little endian */
> +	tmp32 =3D (uint32_t *)&guid->b[0];
> +	*tmp32 =3D be32_to_cpu(*tmp32);
> +	tmp16 =3D (uint16_t *)&guid->b[4];
> +	*tmp16 =3D be16_to_cpu(*tmp16);
> +	tmp16 =3D (uint16_t *)&guid->b[6];
> +	*tmp16 =3D be16_to_cpu(*tmp16);
> +}
> +
>   #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
>   void gen_rand_uuid(unsigned char *uuid_bin)
>   {
>   	u32 ptr[4];
> @@ -394,15 +444,9 @@ void gen_rand_uuid(unsigned char *uuid_bin)
>   	/* Set all fields randomly */
>   	for (i =3D 0; i < 4; i++)
>   		ptr[i] =3D rand();
>
> -	clrsetbits_be16(&uuid->time_hi_and_version,
> -			UUID_VERSION_MASK,
> -			UUID_VERSION << UUID_VERSION_SHIFT);
> -
> -	clrsetbits_8(&uuid->clock_seq_hi_and_reserved,
> -		     UUID_VARIANT_MASK,
> -		     UUID_VARIANT << UUID_VARIANT_SHIFT);
> +	configure_uuid(uuid, UUID_VERSION);


Please, provide a test that in the resulting UUID output we find the
variant and version information at the expected places:

The high nibble of the byte with index 6 should be 4.

The high nibble of the byte with index 8 should 8, 9, C, or D.

Best regards

Heinrich

>
>   	memcpy(uuid_bin, uuid, 16);
>   }
>
>

