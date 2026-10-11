Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F552CA9EC9
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 07:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EB614084B;
	Sun, 11 Oct 2026 07:24:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BiCKtaMHmp0o; Sun, 11 Oct 2026 07:24:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68BFE407C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791703492;
	b=lo8lqVy+Sj0kWfntab96GICLvuIq5qImDfMavO0m9GR5dj4JjMzfH882K5cvzeUo2hfR
	 1fr4Esl8iwaVdrM8zEVJwKTOhO0tqmdUv7k7TqF2lWgil05JB0EZ+1dHSXGsxQOX0McRE
	 yvBcvYbRjbiV5MlrzCvI9TUiy7UQqXdLy/acPxo5KIu/sEy33MU8UgROflVjbHvH5LUtL
	 jL0EMRUsVCA4wV703tAD51iLzhq7O9FETL1JAJv8kzmQwKs/3PpzTLQHLHZFDTOx8ahXo
	 PgWZIL4WQWXL9OwI1VwmpXoVSbBGU82HeY8OgBMJ2Sjy7yyKX04tqsruKr29teKL4qw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791703492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CMz1qiAIycRjLvR0HY9MF2QYC/fIJXvs4owwXyCNu9c=;
	b=pIKrh+bfrXjUQcWcxM4VRpPG9sk28oth4Mpv6Xemb0IHPWSiveh0ZOSUwx/bX5bciUtE
	 sHTwoTl8n2g2Tt3ITJw8kldAOm7owNnj46DAcPqJj2qO7bn8bHI5N2ei2PanNbx6PNJxG
	 Sn21+t+UPQvZKoDYnYP+TYFWu5kvd97oIxPjrqwQec6nR/BfNov8eRlRrLwxhFK1aj3+o
	 IZpQhWJOpc+/uGzt2HtDkzDOLyLQEknHt1UX9meGJ2IPyu7OjT1Z9ctNmGw+6fXce7tg4
	 AEQvAURfLOrBGTgdoc8eXRtjsgBcE1J19GKnS9yb6dUwu8VhZyCaGTgybKxIHZSgSfw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791703492;
	bh=CMz1qiAIycRjLvR0HY9MF2QYC/fIJXvs4owwXyCNu9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nm856kM5vrIhmMfL/VXt8B/MCsQ8Bqgo4kC8N6UIOgzkhBqcRH04TzM/P5J9arAF6
	 NlY5doeiUZHEWbhQRotSqyhEgcGCLy0nd1aoBXw3+Z/wyaefdA6wH3GOyuo+sOCPtE
	 cBg9U1sVfJNrJfJCkFFcuPf7a4FXvuYrzNo2kpxdM27R+lO2D+cknEbUqElJASA5Xh
	 FcaVnUAigKhmViOFedNDZ+zxqnwWqFn3y45JcQMlGF8NkuggTdmW/OPnba9Q25ddtY
	 Grr3GjSW0AdkPPeR9B9MUj+G0gNKnPnO7+5rWsdPjbslo8Rwcr4HuRxYdbZaaALMbt
	 ijGMvcLXI+wYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68BFE407C3;
	Sun, 11 Oct 2026 07:24:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CBF491A6
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE106810AA
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:24:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j-aMWKmEwLVR for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 07:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 223A681082
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791703489;
 b=rS0BM2XG7DKiEkqcwGNWHDkUNXrFipYRRbPNzbgQX1l4ptNf5nGgiCpftoiv0pj7GxnN
 vWOVvGiC8UV5l3wfPmDjlchEr8V1IsVQMvWqzDhmyTObvS0AKdnWNBkLxzpYYzq7MlrNn
 +PMLf6w1hibRJY0zErQjkORikBpxuOpgmP7Z+nNev3AcVrCTB5KhIIUmhJWGmpGU+FvD7
 W9WgYMZZH7zjD2O7gWMNyKM+pufkNjAaonJdM83IfaZPdSxdGmkpAT7yya5zm3pr45pDD
 Ecpp2AIlWJxxd5KbGGw/CQoWYUyHnulZQOXgNeMQNK1bJsIMUdLEZbf0VxlqtMe4mCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791703489;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=CMz1qiAIycRjLvR0HY9MF2QYC/fIJXvs4owwXyCNu9c=;
 b=MjSzC4gGO3yV7Y1T6R60XQvsUgeQ9f2avn17k/RXckApw3U31btA5X1JQj1gqiq8PBcY
 5XTfTmSY316via6kMUhQUcG5rOVo9mMKxXRwGcGte1kUNrmiEj5c5IZqg4P7sUx2EEc+y
 0zsEpT5tX6W4EcgBHZNxslo4zGOxCryBIDyPDLn1+NOxvyFt8HFGy19u52q2Wz7e0Byi8
 E42NoTtAMqDEE7MkBBDm07rqaCkQr8dVV3Buqhr0eCa93kQSuMBufDFjOYTXnUXx9Zuf6
 QB0btmsrZvK0cVAXkuj2eLsqXyWcCpG4/nEPYYxQV+B2vTuM6lIqL84ZWLW/hgch2dw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=YHje1ZG9; 
 arc=none smtp.remote-ip=212.227.17.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=YHje1ZG9
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 223A681082
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1791703474; x=1792308274; i=xypron.glpk@gmx.de;
 bh=CMz1qiAIycRjLvR0HY9MF2QYC/fIJXvs4owwXyCNu9c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YHje1ZG9xNnumaJdaoNLXds3S2XRybHwHFNiUhVmRIImvcv/4vDJBcYfY8aSmsRV
 gWtPfHOuq90DQ6LoBxwG9aKGJfaRWJqVNPSMefrBPvAJULOUKfaFUG0q50rnzQzmy
 Ory0j04CANoUJC7Sa0Bj7UiXMzR7+7Wkn9NHA8eTcYYlAjvYvZaidTHXkBBHP35lM
 YVvk/R2Q+oWABPJVuPYaLmY9Q76q9xDaAW57qElIUaRQdXTsr2rBnyyfIXTE2R9pg
 783gskvWpZTMp0MygjLq1AIp7JjtM0s1yZmDSjuGJkpBHJxprMs3ObV9YohVcq4SZ
 Y6AZavfpgABP9UtOzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1xDazy1hUW-007dKM; Sun, 11
 Oct 2026 09:24:34 +0200
Message-ID: <bff9a1a4-4b5f-4497-ab2d-affba4e6881c@gmx.de>
Date: Sun, 11 Oct 2026 09:24:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] efi_loader: add EBBR 2.2-2.4 ECPT entries
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Shantur Rathore <i@shantur.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
References: <20260921-conform-v2-0-daeb00359af9@arm.com>
 <20260921-conform-v2-2-daeb00359af9@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260921-conform-v2-2-daeb00359af9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cTJ3NHBdp1JrB/TOr4Curut8uIOvCyb76oYPMNPqw+aveDQqgme
 Fci9QZ+t22X9xcu+p1KYOfVQ/gfGMZGD8tca/3MfPqr4aTYDhCEYwI92t4w0NQ/cqxOiox2
 zEYnzQOERVezDTne7vRTEZ+AzhKurTEgALD/c6F6M28804VMPIwkNEY+uDxTj8y0zy9m/Qm
 sWmZDCe0YtcNMNVG/iQOA==
UI-OutboundReport: notjunk:1;M01:P0:cvQI9sv7AVA=;qotzbxlZNP9kkmwXGhU5SiZ2HBt
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/21/26 15:12, Vincent Stehl=C3=A9 wrote:
> Add three ECPT entries for the EBBR versions 2.2, 2.3 and 2.4
> conformance profiles:
> - Define the three EFI_CONFORMANCE_PROFILE_EBBR_2_[234]_GUIDs.
> - Introduce the three HAVE_EFI_EBBR_2_[234] non-visible configuration
>    symbols to compute the actual system conformance status with the
>    dependencies.
> - Add the three EFI_EBBR_2_[234]_CONFORMANCE configuration menu entries
>    to control the addition of the corresponding GUIDs in the ECPT.
>=20
> Following what was done for version 2.1, as many entries as possible are
> added optimistically by default in the ECPT, and this can be overridden
> manually by the system integrator after inspection if necessary.

Hello Vincent,

This patch causes a CI failure:

lib/efi_selftest/efi_selftest_ecpt.c(63):
ERROR: Expected 1 entries, found 4

Please, update the current patch to set the correct number in the test=20
based on the number of enabled GUIDS.

You can follow the existing pattern:

         if (CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)) {
                 ++expected_entries;
                 if (ecpt_find_guid(ecpt, &guid_ebbr_2_1))
                         return EFI_ST_FAILURE;
         }

Best regards

Heinrich

>=20
> Conformance cheat sheet:
>=20
>    EBBR  Additional requirements
>    ----  ---------------------------------------------------
>     2.2  TCG2 & capsule "on disk"
>     2.3  Authenticated capsules in FMP format & boot manager
>     2.4  Non-UEFI (privileged firmware)
>=20
> We do the following configurations dependencies approximations:
>=20
>        Configuration symbol  Used to approximate
>    ------------------------  ------------------------------------
>    EFI_HAVE_CAPSULE_SUPPORT  Firmware update is performed in-band
>                      TPM_V2  A TPM is present
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   include/efi_api.h                | 12 ++++++++++
>   lib/efi_loader/Kconfig           | 51 ++++++++++++++++++++++++++++++++=
++++++++
>   lib/efi_loader/efi_conformance.c |  9 +++++++
>   3 files changed, 72 insertions(+)
>=20
> diff --git a/include/efi_api.h b/include/efi_api.h
> index d4fdd50c49e..17e55118cda 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -238,6 +238,18 @@ enum efi_reset_type {
>   	EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
>   		 0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
>  =20
> +#define EFI_CONFORMANCE_PROFILE_EBBR_2_2_GUID \
> +	EFI_GUID(0x9073eed4, 0xe50d, 0x11ee, 0xb8, 0xb0, \
> +		 0x8b, 0x68, 0xda, 0x62, 0xfc, 0x80)
> +
> +#define EFI_CONFORMANCE_PROFILE_EBBR_2_3_GUID \
> +	EFI_GUID(0x7721fc77, 0xa724, 0x11ef, 0x8e, 0xaa, \
> +		 0xf7, 0xc9, 0xb1, 0x94, 0xba, 0x75)
> +
> +#define EFI_CONFORMANCE_PROFILE_EBBR_2_4_GUID \
> +	EFI_GUID(0xf2bb0422, 0xda8e, 0x11f0, 0xa6, 0x7b, \
> +		 0x1b, 0xe2, 0x20, 0x85, 0x40, 0x98)
> +
>   #define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
>   	EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
>   		 0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index aad8f860868..81231533946 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -577,6 +577,26 @@ config HAVE_EFI_EBBR_2_1
>   	depends on EFI_CAPSULE_FIRMWARE || !EFI_HAVE_CAPSULE_SUPPORT
>   	default y
>  =20
> +config HAVE_EFI_EBBR_2_2
> +	bool
> +	depends on HAVE_EFI_EBBR_2_1
> +	depends on EFI_TCG2_PROTOCOL || !TPM_V2
> +	depends on EFI_CAPSULE_ON_DISK || !EFI_HAVE_CAPSULE_SUPPORT
> +	default y
> +
> +config HAVE_EFI_EBBR_2_3
> +	bool
> +	depends on HAVE_EFI_EBBR_2_2
> +	depends on EFI_CAPSULE_AUTHENTICATE || !EFI_HAVE_CAPSULE_SUPPORT
> +	depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT || !EFI_HAVE_CAPSULE_SUPPOR=
T
> +	depends on EFI_BOOTMGR
> +	default y
> +
> +config HAVE_EFI_EBBR_2_4
> +	bool
> +	depends on HAVE_EFI_EBBR_2_3
> +	default y
> +
>   config EFI_ECPT
>   	bool "Enable the UEFI ECPT generation"
>   	default y
> @@ -592,6 +612,37 @@ config EFI_EBBR_2_1_CONFORMANCE
>   	  Enabling this option adds the Embedded Base Boot Requirements (EBBR=
)
>   	  v2.1 conformance entry to the ECPT.
>  =20
> +config EFI_EBBR_2_2_CONFORMANCE
> +	bool "Add the EBBR v2.2 conformance entry to the ECPT"
> +	depends on EFI_ECPT && HAVE_EFI_EBBR_2_2
> +	default y
> +	help
> +	  Enabling this option adds the Embedded Base Boot Requirements (EBBR)
> +	  v2.2 conformance entry to the ECPT.
> +
> +	  Version 2.2 adds requirements around TCG2 and capsule "on disk".
> +
> +config EFI_EBBR_2_3_CONFORMANCE
> +	bool "Add the EBBR v2.3 conformance entry to the ECPT"
> +	depends on EFI_ECPT && HAVE_EFI_EBBR_2_3
> +	default y
> +	help
> +	  Enabling this option adds the Embedded Base Boot Requirements (EBBR)
> +	  v2.3 conformance entry to the ECPT.
> +
> +	  Version 2.3 adds requirements around authenticated capsules in FMP
> +	  format and the boot manager.
> +
> +config EFI_EBBR_2_4_CONFORMANCE
> +	bool "Add the EBBR v2.4 conformance entry to the ECPT"
> +	depends on EFI_ECPT && HAVE_EFI_EBBR_2_4
> +	default y
> +	help
> +	  Enabling this option adds the Embedded Base Boot Requirements (EBBR)
> +	  v2.4 conformance entry to the ECPT.
> +
> +	  Version 2.4 adds non-UEFI requirements.
> +
>   config EFI_CONSOLE_DISABLE_ANSI
>   	bool "Disable ANSI escape sequence queries for console size"
>   	help
> diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_confo=
rmance.c
> index 470141af483..c1234681bb6 100644
> --- a/lib/efi_loader/efi_conformance.c
> +++ b/lib/efi_loader/efi_conformance.c
> @@ -29,6 +29,15 @@ efi_status_t efi_ecpt_register(void)
>   	#if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
>   		EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
>   	#endif
> +	#if CONFIG_IS_ENABLED(EFI_EBBR_2_2_CONFORMANCE)
> +		EFI_CONFORMANCE_PROFILE_EBBR_2_2_GUID,
> +	#endif
> +	#if CONFIG_IS_ENABLED(EFI_EBBR_2_3_CONFORMANCE)
> +		EFI_CONFORMANCE_PROFILE_EBBR_2_3_GUID,
> +	#endif
> +	#if CONFIG_IS_ENABLED(EFI_EBBR_2_4_CONFORMANCE)
> +		EFI_CONFORMANCE_PROFILE_EBBR_2_4_GUID,
> +	#endif
>   	};
>  =20
>   	ecpt_size =3D sizeof(profiles)
>=20

