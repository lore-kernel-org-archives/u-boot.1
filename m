Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A00CC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94C0580EFB;
	Wed, 16 Apr 2025 13:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ng6cuXfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB7080FDA; Wed, 16 Apr 2025 13:03:15 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6681780050
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e6deb3eb7dbso5369732276.0
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744801392; x=1745406192; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/zW27HIIp9ddIu1XXdiVL0IZXy+PDXGWzA9CABP+dHY=;
 b=Ng6cuXfvVImOMMwbsMhDu4MetzJUKNaRNJBAwb6t0dvDDQnmOclTB/YVqsy4lLA3lS
 SeN+5+MwG/lQnbhnPmvk44VUrQahew3wv8gf7DA9AklarT8d/1/QNvJox2mH/bSNZV+D
 llZ8hsBVTgQKObE6/Eri9BmcPbZBnk4nLii+HNgSTEwHv3FR4FK1Tm5Q1jG0BDWPtMsO
 d/FareKbKrtXVycOSxgdyKFZcijp/npAMoBmtl+ect8SETIXnC1bc97a98ekbgc3E5dt
 RfFLpriJ7ABMMX7EmO1YZkzVT6iNFKmUJE8LVYWmedx06EPqV6wubb0lA/O6jSHcWgyv
 NhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744801392; x=1745406192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/zW27HIIp9ddIu1XXdiVL0IZXy+PDXGWzA9CABP+dHY=;
 b=Z2B2MaeQ5DqsO9gwN4qUyt3ZhH46R/7JFNxWuLDEFbSnEyzBRR7QOmYVVVKx3VCy9G
 octRs/zXk0D8MNSACePOn+NYA04gwRARjcoP9Ymtpod4ZgiSA68JpM0mXTBLlDqprFVb
 Eqqrew7Y2px21Uu6eLhIKGCHlqX4BP6+W1AEfg8ExJub+1MhSRjxLKk4IwjNXgg4IptZ
 fOkx4efLsEopE/T0tRuiBfLJNkcCmwk80mujQq0yHNe5MvtStlfpxAS9O5bJaNIs+17H
 Omg+q5xFC09928vh6yItCbbAJ/isFDLrPsOVtASdrltseXW2pi8p+LudCYxqyFrf6pm5
 jt/w==
X-Gm-Message-State: AOJu0YzB7XAV2APfqHeLtpLE1ZDj3hricY4CMz4iQidKY6MCyd1H19di
 kSFjYVaa28/FPvI/50yQO2QiLr1BNZXtV5FrtQSr4J7Aj8Yq9xfhoyzPd84pJAQ7EJYPMLrcyy4
 4dX+arPGIPnDjjSItxppP1RJCCyRjQR6kzQ0IDA==
X-Gm-Gg: ASbGncvQIhNYQxSAGRA+k3Izj3FwM3rYjCXzQDn84jXBn+X/qUnsj3YOHCzOD0YxhF7
 nGw1SmN8lDlW2S/a48bgcw+Li3Zpg6E3m6Nn1DWkzKsoSoBWcpHMJmaZO+4DAel59AwKWetylFe
 swgE1zQ0RmThR1LVp+DDIi2vzhdxdVGeLByg==
X-Google-Smtp-Source: AGHT+IG58UcF/PuMy7fAWupDNiH4amxILnWToKaBQw183Av+NaEJy7RExd6i/3iUwR4eD5swUA2DqT3uQQWxYKkRF1g=
X-Received: by 2002:a05:6902:2e0a:b0:e6d:efe2:f3c4 with SMTP id
 3f1490d57ef6-e727574a5bfmr1885217276.6.1744801392134; Wed, 16 Apr 2025
 04:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250416074839.1267396-1-jerome.forissier@linaro.org>
 <20250416074839.1267396-2-jerome.forissier@linaro.org>
In-Reply-To: <20250416074839.1267396-2-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Apr 2025 14:02:36 +0300
X-Gm-Features: ATxdqUGpSg_DJJFkqH4LMIFHLpatbA_cl8_psMmBWhurs7i7xnHidGqsatJUO-8
Message-ID: <CAC_iWjJh2DGino2j6zzBr_C7R=m+jdP-t-kAZRDvbx5bK85rAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lib/uuid.c: use unique name for
 PARTITION_SYSTEM_GUID
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Wed, 16 Apr 2025 at 10:48, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> The name defined for PARTITION_SYSTEM_GUID in list_guid[] depends on
> configuration options. It is "system" if CONFIG_PARTITION_TYPE_GUID is
> enabled or "System Partition" if CONFIG_CMD_EFIDEBUG or CONFIG_EFI are
> enabled. In addition, the unit test in test/common/print.c is incorrect
> because it expects only "system" (or a hex GUID).
>
> Make things more consistent by using a clear and unique name: "EFI
> System Partition" whatever the configuration, and update the unit test
> accordingly.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> Changes in v3:
> - Use a single entry in list_guid for PARTITION_SYSTEM_GUID
>
> Changes in v2:
> - Remove useless braces in if expression
> - Change partition name and make it the same for all configs. Update the
>   commit subject.
>
>  lib/uuid.c          | 9 ++++-----
>  test/common/print.c | 8 ++++----
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 75658778044..6abbcf27b1f 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -67,8 +67,11 @@ static const struct {
>         efi_guid_t guid;
>  } list_guid[] = {
>  #ifndef USE_HOSTCC
> +#if defined(CONFIG_PARTITION_TYPE_GUID) || defined(CONFIG_CMD_EFIDEBUG) || \
> +       defined(CONFIG_EFI)
> +       {"EFI System Partition", PARTITION_SYSTEM_GUID},
> +#endif
>  #ifdef CONFIG_PARTITION_TYPE_GUID
> -       {"system",      PARTITION_SYSTEM_GUID},
>         {"mbr",         LEGACY_MBR_PARTITION_GUID},
>         {"msft",        PARTITION_MSFT_RESERVED_GUID},
>         {"data",        PARTITION_BASIC_DATA_GUID},
> @@ -182,10 +185,6 @@ static const struct {
>         {
>                 "TCG2",
>                 EFI_TCG2_PROTOCOL_GUID,
> -               },
> -       {
> -               "System Partition",
> -               PARTITION_SYSTEM_GUID
>         },
>         {
>                 "Firmware Management",
> diff --git a/test/common/print.c b/test/common/print.c
> index e3711b10809..c48efc2783f 100644
> --- a/test/common/print.c
> +++ b/test/common/print.c
> @@ -45,11 +45,11 @@ static int print_guid(struct unit_test_state *uts)
>         sprintf(str, "%pUL", guid);
>         ut_asserteq_str("04030201-0605-0807-090A-0B0C0D0E0F10", str);
>         sprintf(str, "%pUs", guid_esp);
> -       if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) { /* brace needed */
> -               ut_asserteq_str("system", str);
> -       } else {
> +       if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) ||
> +           IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI))
> +               ut_asserteq_str("EFI System Partition", str);
> +       else
>                 ut_asserteq_str("c12a7328-f81f-11d2-ba4b-00a0c93ec93b", str);
> -       }
>         ret = snprintf(str, 4, "%pUL", guid);
>         ut_asserteq(0, str[3]);
>         ut_asserteq(36, ret);
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
