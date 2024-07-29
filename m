Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE251C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 14:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F71887BF;
	Mon, 29 Jul 2024 16:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M2xLkJ1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4DE2887CD; Mon, 29 Jul 2024 16:10:04 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5357885EE
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 16:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7bcd0so5690160a12.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 07:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722262202; x=1722867002; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lTgnK0GFYYYDCsT8MiNjg6K0E0iERiLk3LWcNe3b24g=;
 b=M2xLkJ1N80/0TrR/IbLqHjead6ZvagIHC6qkoitSMO4K2rx0uf3yXrEhZ5FsY75svw
 1/UraMa/j58Vmgr+1nC7Hc4I9pIA0RM4YH4eDwbOEVsShNHOVqRNT/BYVcd/1/GrumQe
 1gcJ27qbSTP7ZEb4nAx8YdUl4Pg8XNOLGdrFrVqqT34cVw66vHvkTRf9oege4UOrfBh0
 HXQDoVvr6ZPxqWCK/D00W1j04jLGXNUJkuAlnYyu95C9iTujht1EUoAnJbJ/boKG9B5m
 QRlFp6q3EizktUfgrWS0IpXZuis8/TY2JWCx20NyE8/4+OA1AZz9iL8pFl8W2xBryFJ8
 a2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722262202; x=1722867002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTgnK0GFYYYDCsT8MiNjg6K0E0iERiLk3LWcNe3b24g=;
 b=QqYNwZiQYqSOy0N/jJPWZpC1ser1raJBPPUjlgUDawccjQwDrwULp2q5eb9z3Qt159
 cToIJ50JiV7oLfEePpMf2jkxlFtVyGgvcxPa1hs2MZMEcAsiII0o8tqmrbfIFGJbnDr5
 lqjtcR0kTFhOFi5mXGUsqAP4+l0lRj1cuwaeME/QlaM2vjsChO0L5Q3eLZHdB32nKT19
 CqRsPpt38L0X/J/RXzipM70GTdWPVtSPLurdcLKDdOD5Sc9fK3UkPa7SeEUVtSZxHxqz
 /R8mnGnSmFbErylm8TPj3pKja4OlWTiCky0z2JImQniMcHnZYYq7DLiHXdz1bak8htBJ
 kFIg==
X-Gm-Message-State: AOJu0YwI19fkqQA4Sam5rBMLl8n6Daju/r7h7/00tyDo7uvOy0ZmpTNo
 SaTjCpQDNUh7cgvKRTJbbLt4eQcuRg8OOI6rsyWZxSetUMgmuFsEpYS8dSbYPxbL6aBaikDPgQ6
 u
X-Google-Smtp-Source: AGHT+IHjveR9XdXAaWxNtUhB0CffTa5Vkt/zYWUQEBFieLPhrb8Nt4RB/5jtpYScK+URXjgzECIKkQ==
X-Received: by 2002:a05:6402:40ca:b0:5a1:a469:4d9b with SMTP id
 4fb4d7f45d1cf-5b02184c31dmr5672955a12.13.1722262201665; 
 Mon, 29 Jul 2024 07:10:01 -0700 (PDT)
Received: from hera (ppp046103060252.access.hol.gr. [46.103.60.252])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590d29sm5746461a12.21.2024.07.29.07.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:10:00 -0700 (PDT)
Date: Mon, 29 Jul 2024 17:09:57 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Benjamin BARATTE <benjamin.baratte@st.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "akashi.tkhro@gmail.com" <akashi.tkhro@gmail.com>,
 "abdellatif.elkhlifi@arm.com" <abdellatif.elkhlifi@arm.com>,
 "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "kojima.masahisa@socionext.com" <kojima.masahisa@socionext.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "sughosh.ganu@linaro.org" <sughosh.ganu@linaro.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH 3/3] tpm_tcg2: hash algo optimization
Message-ID: <ZqeitfLsRW8_Tet_@hera>
References: <DU0PR10MB5244DD7996739E6063425201E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR10MB5244DD7996739E6063425201E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
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

On Mon, Jul 15, 2024 at 01:33:19PM +0000, Benjamin BARATTE wrote:
> To properly enable code optimization with hash algorithm, all the
> reference of the hash algo should condition to hash enablement.
> It is possible to fine tune the list of hash algorithms based on dTPM
> configuration.
> Therefore if dTPM supports only one bank, on one hash algorithm could be
> selected (TCG PTP specification mention in case of single bank support
> that SHA256 must be support and default value)

Yes, but...
In order to apply this we need a function that *configures* the TPM with
only the supported compiled algorithms.  If a TPM is configured
with more than what u-boot supports, there might be security implications
since we will fail to cap all active PCRs. On top of that the EFI TCG
explicitly says that all the active PCR banks needs to be updated when
extending measurements.

Thanks
/Ilias

>
> Signed-off-by: Benjamin BARATTE <benjamin.baratte@st.com>
> ---
>
>  include/tpm-v2.h       |  8 --------
>  lib/efi_loader/Kconfig |  4 ----
>  lib/tpm_tcg2.c         | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 9848e1fd10..ec3504de44 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -285,38 +285,30 @@ struct digest_info {
>
>
>  static const struct digest_info hash_algo_list[] = {
> -#if IS_ENABLED(CONFIG_SHA1)
>         {
>                 "sha1",
>                 TPM2_ALG_SHA1,
>                 TCG2_BOOT_HASH_ALG_SHA1,
>                 TPM2_SHA1_DIGEST_SIZE,
>         },
> -#endif
> -#if IS_ENABLED(CONFIG_SHA256)
>         {
>                 "sha256",
>                 TPM2_ALG_SHA256,
>                 TCG2_BOOT_HASH_ALG_SHA256,
>                 TPM2_SHA256_DIGEST_SIZE,
>         },
> -#endif
> -#if IS_ENABLED(CONFIG_SHA384)
>         {
>                 "sha384",
>                 TPM2_ALG_SHA384,
>                 TCG2_BOOT_HASH_ALG_SHA384,
>                 TPM2_SHA384_DIGEST_SIZE,
>         },
> -#endif
> -#if IS_ENABLED(CONFIG_SHA512)
>         {
>                 "sha512",
>                 TPM2_ALG_SHA512,
>                 TCG2_BOOT_HASH_ALG_SHA512,
>                 TPM2_SHA512_DIGEST_SIZE,
>         },
> -#endif
>         {
>                 "sha3_256",
>                 TPM2_ALG_SHA3_256,
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index ee71f41714..512fb710b5 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -405,10 +405,6 @@ config EFI_TCG2_PROTOCOL
>         bool "EFI_TCG2_PROTOCOL support"
>         default y
>         depends on TPM_V2
> -       select SHA1
> -       select SHA256
> -       select SHA384
> -       select SHA512
>         select HASH
>         select SMBIOS_PARSER
>         help
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 7f868cc883..66573b838d 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -96,9 +96,15 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
>                        struct tpml_digest_values *digest_list)
>  {
>         u8 final[sizeof(union tpmu_ha)];
> +#if IS_ENABLED(CONFIG_SHA256)
>         sha256_context ctx_256;
> +#endif
> +#if IS_ENABLED(CONFIG_SHA384) || IS_ENABLED(CONFIG_SHA512)
>         sha512_context ctx_512;
> +#endif
> +#if IS_ENABLED(CONFIG_SHA1)
>         sha1_context ctx;
> +#endif
>         u32 active;
>         size_t i;
>         u32 len;
> @@ -114,30 +120,38 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
>                         continue;
>
>                 switch (hash_algo_list[i].hash_alg) {
> +#if IS_ENABLED(CONFIG_SHA1)
>                 case TPM2_ALG_SHA1:
>                         sha1_starts(&ctx);
>                         sha1_update(&ctx, input, length);
>                         sha1_finish(&ctx, final);
>                         len = TPM2_SHA1_DIGEST_SIZE;
>                         break;
> +#endif
> +#if IS_ENABLED(CONFIG_SHA256)
>                 case TPM2_ALG_SHA256:
>                         sha256_starts(&ctx_256);
>                         sha256_update(&ctx_256, input, length);
>                         sha256_finish(&ctx_256, final);
>                         len = TPM2_SHA256_DIGEST_SIZE;
>                         break;
> +#endif
> +#if IS_ENABLED(CONFIG_SHA384)
>                 case TPM2_ALG_SHA384:
>                         sha384_starts(&ctx_512);
>                         sha384_update(&ctx_512, input, length);
>                         sha384_finish(&ctx_512, final);
>                         len = TPM2_SHA384_DIGEST_SIZE;
>                         break;
> +#endif
> +#if IS_ENABLED(CONFIG_SHA512)
>                 case TPM2_ALG_SHA512:
>                         sha512_starts(&ctx_512);
>                         sha512_update(&ctx_512, input, length);
>                         sha512_finish(&ctx_512, final);
>                         len = TPM2_SHA512_DIGEST_SIZE;
>                         break;
> +#endif
>                 default:
>                         printf("%s: unsupported algorithm %x\n", __func__,
>                                hash_algo_list[i].hash_alg);
> @@ -236,10 +250,18 @@ static int tcg2_log_init(struct udevice *dev, struct tcg2_event_log *elog)
>                         continue;
>
>                 switch (hash_algo_list[i].hash_alg) {
> +#if IS_ENABLED(CONFIG_SHA1)
>                 case TPM2_ALG_SHA1:
> +#endif
> +#if IS_ENABLED(CONFIG_SHA256)
>                 case TPM2_ALG_SHA256:
> +#endif
> +#if IS_ENABLED(CONFIG_SHA384)
>                 case TPM2_ALG_SHA384:
> +#endif
> +#if  IS_ENABLED(CONFIG_SHA512)
>                 case TPM2_ALG_SHA512:
> +#endif
>                         count++;
>                         break;
>                 default:
> @@ -337,10 +359,18 @@ static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
>                         algo = get_unaligned_le16(log + pos);
>                         pos += offsetof(struct tpmt_ha, digest);
>                         switch (algo) {
> +#if IS_ENABLED(CONFIG_SHA1)
>                         case TPM2_ALG_SHA1:
> +#endif
> +#if IS_ENABLED(CONFIG_SHA256)
>                         case TPM2_ALG_SHA256:
> +#endif
> +#if IS_ENABLED(CONFIG_SHA384)
>                         case TPM2_ALG_SHA384:
> +#endif
> +#if IS_ENABLED(CONFIG_SHA512)
>                         case TPM2_ALG_SHA512:
> +#endif
>                                 len = tpm2_algorithm_to_len(algo);
>                                 break;
>                         default:
> @@ -450,10 +480,18 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog)
>                         return 0;
>
>                 switch (algo) {
> +#if IS_ENABLED(CONFIG_SHA1)
>                 case TPM2_ALG_SHA1:
> +#endif
> +#if IS_ENABLED(CONFIG_SHA256)
>                 case TPM2_ALG_SHA256:
> +#endif
> +#if IS_ENABLED(CONFIG_SHA384)
>                 case TPM2_ALG_SHA384:
> +#endif
> +#if IS_ENABLED(CONFIG_SHA512)
>                 case TPM2_ALG_SHA512:
> +#endif
>                         len = get_unaligned_le16(&event->digest_sizes[i].digest_size);
>                         if (tpm2_algorithm_to_len(algo) != len)
>                                 return 0;
> --
> 2.34.1
>
> ST Restricted
