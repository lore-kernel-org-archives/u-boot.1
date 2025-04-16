Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CF4C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 03:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F29A82AE1;
	Wed, 16 Apr 2025 05:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LvFEwX5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF7682B44; Wed, 16 Apr 2025 05:54:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3985A812BC
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 05:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744775685; x=1745380485; i=xypron.glpk@gmx.de;
 bh=r6K1UtqwOt5YPJXckMCzlQcKLx9MTOOadpybGAU62gc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LvFEwX5SWNfDeweOdFKlHrR6/GUilaLe3rtxVn3GyG2UVWqwICPMVxksb4kBVB8h
 /wdGbv/JM3ADU/kosTAeMCnRu9YruePrBtk+JAcdor9o4ube8c8YHi3l+4alZPjMt
 Z4vP+CVeb+nGX2aM1lXlLsTvKhlGilhfFQdEVBpda2gCgNwhNTzd6YWdOsFoeuedO
 1KzSZFJG50A7tY3crHaSVvPchiMzhg1eS9Hk4yvt6GAek8iTlTOoxDC/oNvD87/+E
 LGUeXL4eT+ehaE0bWMCjVhlal4txz8joxKd+sZTtpZYE8Os3xpvC2qfD8kH8OirW1
 AxirigdPh2P1sGyKhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1t7ifd0g0m-00zghe; Wed, 16
 Apr 2025 05:54:45 +0200
Message-ID: <7de2fb23-b008-42a9-8661-90e92c87a990@gmx.de>
Date: Wed, 16 Apr 2025 05:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] lib/uuid.c: use unique name for
 PARTITION_SYSTEM_GUID
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, U-Boot mailing list <u-boot@lists.denx.de>
References: <20250415204917.1250109-1-jerome.forissier@linaro.org>
 <20250415204917.1250109-2-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250415204917.1250109-2-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0yHy9tTpb+Tnypdi8Hs4vtau6r12dFhitlXqVGHZkxEc2ruwsiT
 ywjUQKXehKkuGOdXKePrQUesodHjkcppVSde09oQ5LOSRtlmrVH3Aycur7ZcHYBi20jeWs0
 YRH/GULEWvvbaKAuCOEOlzcNaQO6D2JYS3ZW/daqKX1m/uSw5WXjZ2tGJWyxw3TuW6Vcio8
 e5qu8rk1YFNefOVS0IvAg==
UI-OutboundReport: notjunk:1;M01:P0:bWMhn/9i9hM=;iYlEkIwNol7eR1wp3VfsdBrqjJC
 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
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

On 4/15/25 22:49, Jerome Forissier wrote:
> The name defined for PARTITION_SYSTEM_GUID in list_guid[] depends on
> configuration options. It is "system" if CONFIG_PARTITION_TYPE_GUID is
> enabled or "System Partition" if CONFIG_CMD_EFIDEBUG or CONFIG_EFI are
> enabled. In addition, the unit test in test/common/print.c is incorrect
> because it expects only "system" (or a hex GUID).
>=20
> Make things more consistent by using a clear and unique name: "EFI
> System Partition" whatever the configuration, and update the unit test
> accordingly.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>=20
> Changes in v2:
> - Remove useless braces in if expression
> - Change partition name and make it the same for all configs. Update the
>    commit subject.
>=20
>   lib/uuid.c          | 4 ++--
>   test/common/print.c | 8 ++++----
>   2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 75658778044..4ad2cca64c5 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -68,7 +68,7 @@ static const struct {
>   } list_guid[] =3D {
>   #ifndef USE_HOSTCC
>   #ifdef CONFIG_PARTITION_TYPE_GUID
> -	{"system",	PARTITION_SYSTEM_GUID},
> +	{"EFI System Partition", PARTITION_SYSTEM_GUID},
>   	{"mbr",		LEGACY_MBR_PARTITION_GUID},
>   	{"msft",	PARTITION_MSFT_RESERVED_GUID},
>   	{"data",	PARTITION_BASIC_DATA_GUID},
> @@ -184,7 +184,7 @@ static const struct {
>   		EFI_TCG2_PROTOCOL_GUID,
>   		},
>   	{
> -		"System Partition",
> +		"EFI System Partition",
>   		PARTITION_SYSTEM_GUID

We should avoid having the entry twice in the array for
CONFIG_PARTITION_TYPE_GUID=3Dy && (CONFIG_CMD_EFIDEBUG=3Dy || CONFIG_EFI=
=3Dy).

I guess it needs its own #if block.

Otherwise looks good to me.

Best regards

Heinrich

>   	},
>   	{
> diff --git a/test/common/print.c b/test/common/print.c
> index e3711b10809..c48efc2783f 100644
> --- a/test/common/print.c
> +++ b/test/common/print.c
> @@ -45,11 +45,11 @@ static int print_guid(struct unit_test_state *uts)
>   	sprintf(str, "%pUL", guid);
>   	ut_asserteq_str("04030201-0605-0807-090A-0B0C0D0E0F10", str);
>   	sprintf(str, "%pUs", guid_esp);
> -	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) { /* brace needed */
> -		ut_asserteq_str("system", str);
> -	} else {
> +	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) ||
> +	    IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI))
> +		ut_asserteq_str("EFI System Partition", str);
> +	else
>   		ut_asserteq_str("c12a7328-f81f-11d2-ba4b-00a0c93ec93b", str);
> -	}
>   	ret =3D snprintf(str, 4, "%pUL", guid);
>   	ut_asserteq(0, str[3]);
>   	ut_asserteq(36, ret);

