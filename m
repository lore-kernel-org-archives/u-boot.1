Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57B7C27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 16:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F28F387D14;
	Sat, 22 Jun 2024 18:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TY6us6Kv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CFC28803E; Sat, 22 Jun 2024 18:29:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E6587D14
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 18:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719073733; x=1719678533; i=xypron.glpk@gmx.de;
 bh=COPyrrv71YesO6Z2TrdyEYYw2gyoQ+Y5DjXsuiyaw9s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TY6us6KvOOrMHGqVRaGNNKhrRM82Z7z0pW/fxn4XsMwgntBGQi6/btGKl0SP7h0Y
 DIX5HkNtLf3ss0ZDEIF6WQSTOj2M4bFjKB5UZ/EgIru5SUd9bqzK5F1PUXrbbW4xS
 fQJU8qaNJAAfxoARQeCjWMa0Butb85ntkqbggf/68mAtCcLb1+5VV2R2IuA+3+GrU
 4k/Nm7tcLTjRS/iux5JVE8dliEy6sI3gmhwv/5dqk1nVh3dn1K0Z7DU1k/aJkubpf
 FknySvhp3rn91K8aLfQ76g31RDTXNSO3Z5by5IYrLOrVDWYd+5IEJkwMybk2lhN/k
 smmmkwckuTcBdVszeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1so3Ix0DDy-00hGQX; Sat, 22
 Jun 2024 18:28:53 +0200
Message-ID: <b91ca754-3b04-4db0-917f-2362c53539e6@gmx.de>
Date: Sat, 22 Jun 2024 18:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] tpm: allow the user to select the compiled algorithms
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 sjg@chromium.org, trini@konsulko.com
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-8-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240622143601.187723-8-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iExf5Naa+NUA1iYNVOjxtRP9OD88rm0fIA74mTIdFscRrP7j5eA
 uCK7nEvoOwK652Izl0vgYrWGHjZs/nnwJctGirWXKLqOZYSrLiHzEKRl/wJkwYITtQxl2lW
 /kTn0iieBYm5zxKbb+nlqOYmQ+TdoJH8u+Odw/2afJdMrXUYmBh1vLT9ifuhAa9j5KYXQLR
 IQNwDDKsM5y0AaMF098BQ==
UI-OutboundReport: notjunk:1;M01:P0:mmM0gWEJRnM=;nc+QZrSy2GiU3JNqDyJEfCt8YV2
 DP984anxCZLohd4f32w5OrFbxRijVb9gGFhyag4MPzCPmoHtcbcinqAVmg+vOf27EwGIGC/Vu
 OsqHd2qojxVrYyeuOpb6dWxB7UZrle4HSShI4dpEi+AiMiQafx5kZ2uduQ0sq6egJ3FBjyUY7
 k9D75vJdHWmKlIKMiEQBcO2kHjbMSVGylxNVWF48MGek8pqgQo5Vs/hbOJgzsvUM+phfmw7GE
 P+K294aUtH9oy79Z4zxk5ZMTg+x60aysKwZzgfHC9AtYeuXWZqIEMkPUY0BtrJgZS/tMxOm5W
 D6oSEWIdbjZaRObeBqt6zkv66Y4gNMocEHxrEI6fS7pAZMZC+GvUeSdhxm/3TOAoG6W+3KdxN
 sd9YfxY6FUsfTI4IJ4d/YsNc13x7OiVj6H5NhMyWy3vgy0DZh3/Gemk6MH+afi3XOwIn8Idw2
 9RonRjQhXmu48CHmnGotN4DDgl7lIC2hzzI9VQYA5BEhH4+xbrDrlhRGHxgmQb0v6nd31mlxM
 rFQbvQTee5STPZ9XQ6dBdmABoSyGloGxepqShRzDfNXeKz6QEg1LuxJl6tAgjAfufnAXTQIqD
 35JGfMdiZF7+JLr3WVrup090KhhY+jxqcq92dfJI3bxNIyUjxnkFkMl18t3WrPYL8o0Am+ACk
 wNj2OW/y647kDa9bXl0Jm8oPk79Rj2p9FRppfplAyqE1E2UI8wlftcN980gl7RaS5RzBXPZnh
 qyl/13AHronseANW7SvuQyWAeTK/L8+AMAM9drIq9XLg2VvUGHzdfdEFAN01+qg/FQAsxg0uV
 dQQJ92h2V37mhECcjoxpTtyTFbbTq8fhEtrYu8YcX7SRA=
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

On 22.06.24 16:35, Ilias Apalodimas wrote:
> Simon reports that after enabling all algorithms on the TPM some boards
> fail since they don't have enough storage to accommodate the ~5KB growth=
.
>
> The choice of hash algorithms are determined by the platform and the TPM
> configuration. Failing to cap a PCR in a bank which the platform left
> active is a security vulnerability. It might allow  unsealing of secrets
> if an attacker can replay a good set of measurements into an unused bank=
.
>
> If MEASURED_BOOT or EFI_TCG2_PROTOCOL is enabled our Kconfig will enable
> all supported hashing algorithms. We still want to allow users to add a
> TPM and not enable measured boot via EFI or bootm though and at the same
> time, control the compiled algorithms for size reasons.
>
> So let's add a function tpm2_allow_extend() which checks the TPM active
> PCRs banks against the one U-Boot was compiled with.
> If all the active PCRs banks are not enabled refuse to extend a PCR but
> otherwise leave the TPM functional.

The paragraph above is bit hard to read. I guess you mean:

We only allow extending PCRs using one of the algorithms selected in the
configuration.

>
> It's worth noting that this is only added on TPM2.0, since TPM1.2 is
> lacking a lot of code at the moment to read the available PCRs.
> We unconditionally enable SHA1 when a TPM is selected, which is the only
> hashing algorithm v1.2 supports.

Why do we need SHA1 if we cannot access PCRs on a TPM1.2?

Best regards

Heinrich

>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   boot/Kconfig     |  4 ++++
>   include/tpm-v2.h | 59 +++++++++++++++++++++++++++++++++++-------------
>   lib/Kconfig      |  6 ++---
>   lib/tpm-v2.c     | 40 +++++++++++++++++++++++++++++---
>   4 files changed, 87 insertions(+), 22 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 6f3096c15a6f..b061891e109c 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
>   config MEASURED_BOOT
>   	bool "Measure boot images and configuration when booting without EFI"
>   	depends on HASH && TPM_V2
> +	select SHA1
> +	select SHA256
> +	select SHA384
> +	select SHA512
>   	help
>   	  This option enables measurement of the boot process when booting
>   	  without UEFI . Measurement involves creating cryptographic hashes
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index eac04d1c6831..fccb07fa4695 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -277,48 +277,40 @@ struct digest_info {
>   #define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
>
>   static const struct digest_info hash_algo_list[] =3D {
> +#if IS_ENABLED(CONFIG_SHA1)
>   	{
>   		"sha1",
>   		TPM2_ALG_SHA1,
>   		TCG2_BOOT_HASH_ALG_SHA1,
>   		TPM2_SHA1_DIGEST_SIZE,
>   	},
> +#endif
> +#if IS_ENABLED(CONFIG_SHA256)
>   	{
>   		"sha256",
>   		TPM2_ALG_SHA256,
>   		TCG2_BOOT_HASH_ALG_SHA256,
>   		TPM2_SHA256_DIGEST_SIZE,
>   	},
> +#endif
> +#if IS_ENABLED(CONFIG_SHA384)
>   	{
>   		"sha384",
>   		TPM2_ALG_SHA384,
>   		TCG2_BOOT_HASH_ALG_SHA384,
>   		TPM2_SHA384_DIGEST_SIZE,
>   	},
> +#endif
> +#if IS_ENABLED(CONFIG_SHA512)
>   	{
>   		"sha512",
>   		TPM2_ALG_SHA512,
>   		TCG2_BOOT_HASH_ALG_SHA512,
>   		TPM2_SHA512_DIGEST_SIZE,
>   	},
> +#endif
>   };
>
> -static inline u16 tpm2_algorithm_to_len(enum tpm2_algorithms a)
> -{
> -	switch (a) {
> -	case TPM2_ALG_SHA1:
> -		return TPM2_SHA1_DIGEST_SIZE;
> -	case TPM2_ALG_SHA256:
> -		return TPM2_SHA256_DIGEST_SIZE;
> -	case TPM2_ALG_SHA384:
> -		return TPM2_SHA384_DIGEST_SIZE;
> -	case TPM2_ALG_SHA512:
> -		return TPM2_SHA512_DIGEST_SIZE;
> -	default:
> -		return 0;
> -	}
> -}
> -
>   /* NV index attributes */
>   enum tpm_index_attrs {
>   	TPMA_NV_PPWRITE		=3D 1UL << 0,
> @@ -711,6 +703,41 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const c=
har *name);
>    */
>   const char *tpm2_algorithm_name(enum tpm2_algorithms);
>
> +/**
> + * tpm2_algorithm_to_len() - Return an algorithm length for supported a=
lgorithm id
> + *
> + * @algorithm_id: algorithm defined in enum tpm2_algorithms
> + * Return: len or 0 if not supported
> + */
> +u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo);
> +
> +/*
> + * When measured boot is enabled via EFI or bootX commands all the algo=
rithms
> + * above are selected by our Kconfigs. Due to U-Boots nature of being s=
mall there
> + * are cases where we need some functionality from the TPM -- e.g stora=
ge or RNG
> + * but we don't want to support measurements.
> + *
> + * The choice of hash algorithms are determined by the platform and the=
 TPM
> + * configuration. Failing to cap a PCR in a bank which the platform lef=
t
> + * active is a security vulnerability. It permits the unsealing of secr=
ets
> + * if an attacker can replay a good set of measurements into an unused =
bank.
> + *
> + * On top of that a previous stage bootloader (e.g TF-A), migh pass an =
eventlog
> + * since it doesn't have a TPM driver, which U-Boot needs to replace. T=
he algorit h
> + * choice is a compile time option in that case and we need to make sur=
e we conform.
> + *
> + * Add a variable here that sums the supported algorithms U-Boot was co=
mpiled
> + * with so we can refuse to do measurements if we don't support all of =
them
> + */
> +
> +/**
> + * tpm2_allow_extend() - Check if extending PCRs is allowed and safe
> + *
> + * @dev: TPM device
> + * Return: true if allowed
> + */
> +bool tpm2_allow_extend(struct udevice *dev);
> +
>   /**
>    * tpm2_is_active_pcr() - check the pcr_select. If at least one of the=
 PCRs
>    *			  supports the algorithm add it on the active ones
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 189e6eb31aa1..b3baa4b85b07 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -439,9 +439,6 @@ config TPM
>   	depends on DM
>   	imply DM_RNG
>   	select SHA1
> -	select SHA256
> -	select SHA384
> -	select SHA512
>   	help
>   	  This enables support for TPMs which can be used to provide security
>   	  features for your board. The TPM can be connected via LPC or I2C
> @@ -449,6 +446,9 @@ config TPM
>   	  command to interactive the TPM. Driver model support is provided
>   	  for the low-level TPM interface, but only one TPM is supported at
>   	  a time by the TPM library.
> +	  For size reasons only SHA1 is selected which is supported on TPM1.2.
> +	  If you want a fully functional TPM enable all hashing algorithms.
> +	  If you enabled measured boot all hashing algorithms are selected.
>
>   config SPL_TPM
>   	bool "Trusted Platform Module (TPM) Support in SPL"
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 36aace03cf4e..59e6cbafafaa 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -196,6 +196,11 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index,=
 u32 algorithm,
>
>   	if (!digest)
>   		return -EINVAL;
> +
> +	if (!tpm2_allow_extend(dev)) {
> +		log_err("Cannot extend PCRs if all the TPM enabled algorithms are not=
 supported\n");
> +		return -EINVAL;
> +	}
>   	/*
>   	 * Fill the command structure starting from the first buffer:
>   	 *     - the digest
> @@ -409,11 +414,10 @@ int tpm2_get_pcr_info(struct udevice *dev, struct =
tpml_pcr_selection *pcrs)
>
>   	pcrs->count =3D get_unaligned_be32(response);
>   	/*
> -	 * We only support 5 algorithms for now so check against that
> +	 * We only support 4 algorithms for now so check against that
>   	 * instead of TPM2_NUM_PCR_BANKS
>   	 */
> -	if (pcrs->count > ARRAY_SIZE(hash_algo_list) ||
> -	    pcrs->count < 1) {
> +	if (pcrs->count > 4 || pcrs->count < 1) {
>   		printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
>   		return -EMSGSIZE;
>   	}
> @@ -880,3 +884,33 @@ const char *tpm2_algorithm_name(enum tpm2_algorithm=
s algo)
>   	return "";
>   }
>
> +u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hash_algo_list); ++i) {
> +		if (hash_algo_list[i].hash_alg =3D=3D algo)
> +			return hash_algo_list[i].hash_len;
> +	}
> +
> +	return 0;
> +}
> +
> +bool tpm2_allow_extend(struct udevice *dev)
> +{
> +	struct tpml_pcr_selection pcrs;
> +	size_t i;
> +	int rc;
> +
> +	rc =3D tpm2_get_pcr_info(dev, &pcrs);
> +	if (rc)
> +		return false;
> +
> +	for (i =3D 0; i < pcrs.count; i++) {
> +		if (tpm2_is_active_pcr(&pcrs.selection[i]) &&
> +		    !tpm2_algorithm_to_len(pcrs.selection[i].hash))
> +			return false;
> +	}
> +
> +	return true;
> +}

