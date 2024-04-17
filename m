Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8146FC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 12:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC0648845C;
	Wed, 17 Apr 2024 14:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LFEW60RX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E977E8845E; Wed, 17 Apr 2024 14:22:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C68E888453
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 14:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713356522; x=1713961322; i=xypron.glpk@gmx.de;
 bh=/3dhnpbao8GOmNfu5Dg+EUz3+EKlPG9JY9ZAnT9C7sY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LFEW60RXZh+RShZ7Odi2NLIDpp6rNFCnqZRD+EabuklBCKrWxcImfXUux59lna7f
 WR6YQrXruqqpvARkvvs+GLQfr8PvTFT6tWOllGw/2QJ6CkrNtYLLuaPZqGvnU/8u1
 1LRX9QzB5fPHqybuL/7URHCIMvvgwoLRpVyv2wkf5wEE9V1vgwa0Ba/nCSaRRzr37
 6RYzKgavFCvElXInJ+fh7cd3cGgIl3Os8Bs94/j7i1ZAYParFw5FpsCTKEq7y1Dfs
 uoTQ8x7zx3XARwpGWd2qaH7Lq3NeAvfUXP74CF3jdq4ISn8hSbS7c+Ai0li8uqvk3
 rGo2Ds7PDR7x16+UzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1sZN7e2Xsi-00ne0a; Wed, 17
 Apr 2024 14:22:02 +0200
Message-ID: <21bbc05c-bf07-406f-a16a-e7655f8958ea@gmx.de>
Date: Wed, 17 Apr 2024 14:22:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] efi_selftest: add tests for setvariableRT
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Janne Grunau <j@jannau.net>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de,
 kettenis@openbsd.org
References: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
 <20240417101928.119115-5-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240417101928.119115-5-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FFZUechPLDHATHisdquZS89MvuvgDh/MixZPfsaVpctRavYjupc
 oaTvv0aUVbFC9xWAZW3chKEs5SymjcHaxhG4URS/EIsF1KQlzB/KUN8sptOkJ72KxbSUy70
 tOBHbtGb+P2//PiW6L3kZ7RCi4gR0Luv9+cabG6R+vO07uWkapKKP7WctSeYZ8j21zXOm5l
 iiMPv+1/i0njr5axNK+cA==
UI-OutboundReport: notjunk:1;M01:P0:O6DTa/W6E4k=;Im5OlOrVddgQtsKJdJRFSpJtGvI
 ot4wAE6Uj0WQZhbLjt9DKEsTN8Bi6tUasWuaahVlHwWcGJcA560DMSlpoGfQWQrsLZc34dEUI
 KuPb1hZQI4PxHSKiVbymPgtoY/BxLonaDD1YucIO75+xVyuksrdUGDc5+6gZh1EifMqA9Caxf
 5uJ8yQaqfC0mN1B8Mjo7Ft5nAqxOcXJ3PbdiKlwi44Tj5qMxCF6q+VOTuYfpxi9vW9edG8s1l
 dWYpbEBs6Y9R5davNFx2bYAdIl700sJK7AsJ1HwA4AcvrdcXCR9UOpy8BywlTUQIjx2Stg58l
 HMmXnUhgEBxNfRwFjI4Q/wkcWwrTdNHnYAt0J1b5qFruUCl1NBkPqmIe5uhWcBbgxKnaYx7PY
 kem3BmBwHyFliK+06ijf/oughMWyehJ23Xy888F6pHrJckFaiBbMY78la03vf5Op4Mz25/9yw
 RuCuc7/aW6BfpCCN1/I70AVVaRacyO6kQMxZbgowi5zWbMXA4pfx3SbrugoKeT87YRxtN/u0/
 +19PSGD+3TUvXe0o/QGse5fpTIjhm9LE3PPrJWp6y6MByQWVu1phFyNPGiTtu/aECJU9HCx8E
 dZ6mnsRNjI22vbrPDshD0vyVoPW7NUrLudH5hZdtAQa982E2emIE2xcUVGX83CgxK1sCLruQH
 govKMhLN31gPMaE/5HbI4iPSokNnd8QB90W0pwJJ4vZnW4M88wpcbvlvkK1ZGqj/+zTlsLaUV
 F0bU5RlnnS9zuOMMA6aRXJ2dlLuQlbGLmpyrpdtM6kL1V97wj8hHhDA2iapviqb1NbqpZ0vd9
 9bIK2LJ/poaI7i05eyjjn87CtRkbQR2ZtR2S6DLVUuSgg=
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

On 17.04.24 12:19, Ilias Apalodimas wrote:
> Since we support SetVariableRT now add the relevant tests
>
> - Search for the RTStorageVolatile and VarToFile variables after EBS
> - Try to update with invalid variales (BS, RT only)
> - Try to write a variable bigger than our backend storage
> - Write a variable that fits and check VarToFile has been updated
>    correclty
> - Append to the variable and check VarToFile changes
> - Try to delete VarToFile which is write protected
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   .../efi_selftest_variables_runtime.c          | 103 ++++++++++++++++++
>   1 file changed, 103 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi=
_selftest/efi_selftest_variables_runtime.c
> index 4c9405c0a7c7..e492b50a43c2 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -10,6 +10,7 @@
>    */
>
>   #include <efi_selftest.h>
> +#include <efi_variable.h>
>
>   #define EFI_ST_MAX_DATA_SIZE 16
>   #define EFI_ST_MAX_VARNAME_SIZE 40
> @@ -17,6 +18,8 @@
>   static struct efi_boot_services *boottime;
>   static struct efi_runtime_services *runtime;
>   static const efi_guid_t guid_vendor0 =3D EFI_GLOBAL_VARIABLE_GUID;
> +static const efi_guid_t __efi_runtime_data efi_rt_var_guid =3D
> +						U_BOOT_EFI_RT_VAR_FILE_GUID;
>
>   /*
>    * Setup unit test.
> @@ -45,11 +48,14 @@ static int execute(void)
>   	u32 attr;
>   	u8 v[16] =3D {0x5d, 0xd1, 0x5e, 0x51, 0x5a, 0x05, 0xc7, 0x0c,
>   		    0x35, 0x4a, 0xae, 0x87, 0xa5, 0xdf, 0x0f, 0x65,};
> +	u8 v2[CONFIG_EFI_VAR_BUF_SIZE];
>   	u8 data[EFI_ST_MAX_DATA_SIZE];
> +	u8 data2[CONFIG_EFI_VAR_BUF_SIZE];
>   	u16 varname[EFI_ST_MAX_VARNAME_SIZE];
>   	efi_guid_t guid;
>   	u64 max_storage, rem_storage, max_size;
>
> +	memset(v2, 0x1, sizeof(v2));
>   	ret =3D runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
>   					   &max_storage, &rem_storage,
>   					   &max_size);
> @@ -63,10 +69,107 @@ static int execute(void)
>   				    EFI_VARIABLE_RUNTIME_ACCESS,
>   				    3, v + 4);
>   	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> +		efi_uintn_t prev_len, delta;
> +
>   		if (ret !=3D EFI_INVALID_PARAMETER) {
>   			efi_st_error("SetVariable failed\n");
>   			return EFI_ST_FAILURE;
>   		}
> +
> +		len =3D sizeof(data);
> +		ret =3D runtime->get_variable(u"RTStorageVolatile",
> +					    &efi_rt_var_guid,
> +					    &attr, &len, data);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("GetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		len =3D sizeof(data2);
> +		ret =3D runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +					    &attr, &len, data2);
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("GetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +		/*
> +		 * VarToFile will size must change once a variable is inserted
> +		 * Store it now, we'll use it later
> +		 */
> +		prev_len =3D len;
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    sizeof(v2),
> +					    v2);
> +		/*
> +		 * This will try to update VarToFile as well and must fail,
> +		 * without changing or deleting VarToFile
> +		 */
> +		if (ret !=3D EFI_OUT_OF_RESOURCES) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +		len =3D sizeof(data2);
> +		ret =3D runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +					    &attr, &len, data2);
> +		if (ret !=3D EFI_SUCCESS || prev_len !=3D len) {
> +			efi_st_error("Get/SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/* SetVariableRT updates VarToFile with efi_st_var0 */
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    sizeof(v), v);

It is fine to test with variable name size (24) and variable value size
(16) both being multiples of 8. But this does not cover the generic case.

> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +		len =3D sizeof(data2);
> +		delta =3D 2 * (u16_strlen(u"efi_st_var0") + 1) + sizeof(v) +
> +			sizeof(struct efi_var_entry);

In the file all variable are stored at 8 byte aligned positions.
I am missing ALIGN(,8) here.

> +		ret =3D runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +					    &attr, &len, data2);
> +		if (ret !=3D EFI_SUCCESS || prev_len + delta !=3D len) {
> +			efi_st_error("Get/SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}

We should check the header fields of VarToFile (reserved, magic, length,
crc32), e.g.

struct efi_var_file *hdr =3D (void *)data2;
if (memcmp(hdr->magic, EFI_VAR_FILE_MAGIC, 8) ||
     len !=3D ALIGN(hdr->length + sizeof(hdr), 8) ||
     ... )

> +
> +		/* append on an existing variable will updateVarToFile */
> +		ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_APPEND_WRITE |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    sizeof(v), v);

How about just appending 1 byte when using EFI_VARIABLE_APPEND_WRITE and
checking that the delta here too?

Best regards

Heinrich

> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +		prev_len =3D len;
> +		delta =3D sizeof(v);
> +		len =3D sizeof(data2);
> +		ret =3D runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
> +					    &attr, &len, data2);
> +		if (ret !=3D EFI_SUCCESS || prev_len + delta !=3D len) {
> +			efi_st_error("Get/SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +
> +		/* Variables that are BS, RT and volatile are RO after EBS */
> +		ret =3D runtime->set_variable(u"VarToFile", &efi_rt_var_guid,
> +					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					    EFI_VARIABLE_RUNTIME_ACCESS |
> +					    EFI_VARIABLE_NON_VOLATILE,
> +					    sizeof(v), v);
> +		if (ret !=3D EFI_WRITE_PROTECTED) {
> +			efi_st_error("Get/SetVariable failed\n");
> +			return EFI_ST_FAILURE;
> +		}
>   	} else {
>   		if (ret !=3D EFI_UNSUPPORTED) {
>   			efi_st_error("SetVariable failed\n");

