Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98FEE64A8A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 12:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309FF893AE;
	Tue,  3 Dec 2024 13:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cjbyK0nB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45971893AE; Tue,  3 Dec 2024 13:57:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363A7893A9
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 13:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733230656; x=1733835456; i=xypron.glpk@gmx.de;
 bh=o71KygkpF0CCz9b90Qn0yECEBeBHO5BIgbUY+J053CA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cjbyK0nB7Jx8f7VpamCHYLDNcNwk28L1DcveIvxpxOj4nyrnB6pRrJX0UAGmZI34
 HMiKJsoEQAOKA4kncZgNqSvO7beOLApgL/bLut0/tuKumDXi5tOUzyf5XWwWZK/2h
 +2rG89sroa53IUchkZOhfjaxZvQyqbIf2zyU+DN1CVgVp64o/icrW1SEHRPJyAzU/
 V09YPP8SjKA60zufPJ8FDBBaK+eFzBIUxWBuMgWcQl8uI6UIngvEMxho36cQJTzOy
 6qMyJkiZYlMNFw8XAcEukEsUiknf0onZgik4sLI5HzkYnvTPQi9G3xIScZ3tcvstX
 jheFX7rZkRISO52CIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1thBEV1B39-010NXR; Tue, 03
 Dec 2024 13:57:36 +0100
Message-ID: <9211f24f-d406-4d57-820f-f5814fcd061b@gmx.de>
Date: Tue, 3 Dec 2024 13:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: address build warning
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>
References: <20241203134257.5067-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241203134257.5067-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3aChp7bQlitCBMKqdly7S/ldP3VrO4BF/IebF5NYsdw6Y/bY0RA
 fc5yeFDfQxXAIIH+LiWfGocSB1jGalkKFxwsdtqcMpnvQ4/a5wM5YmGiTLeXujxE5ZeDAxt
 /rwhKx+Gl16664PN2kZn8uyYcz6aXlgcUvotRywkoZHBnv07LAQ9TbcUkgugvta3w81D5hF
 XiVikCOnagL7IJaj0lVMQ==
UI-OutboundReport: notjunk:1;M01:P0:smbEQ3Jmdvw=;haTS8ivNbIhOsG26ErCGastJeh1
 1ngyDgc+4le8Oway1adEylVk6BhTYy8rq9TFrs5Cf5RpGRSXCp1tYuC/PYBdYapOzUJ9mp9CZ
 +fCd7BqoPE3hyd9cg/UzCTB7t2OMwDs2tT5L9JZDIK9JD4wWmjTBMWZIA8rTA7OmRw2WjQtJ0
 FFDeLbMr9ImB2O9Y+dXPCchMowHfvmyHlvVW9sHBLu2OrL669bA5lQZ3VpNF3uQRUPW6Dwcf0
 osR0aE1gF4x9ixalx1pDdB36iS+twMPOdacQc2IHr0mZEejrBhznSwnu4dvHF0rtL1wtnz0Tl
 M+rOHV1ZpLXJ1Ohrc4cJ8su4APs8zlvTwmknTDk5+TYLSwapTFX7j2o16qiF+bdBTblquh6Jb
 9opfoY3LYx2X8x6JdrsbnDLIPuqKCZL3zLTG3vwKumNq/RNGeoP0mdvyJTIJVWPIuHZRRuhKj
 8KYtpkz98opW3lPOib6go1KSo9sKAjh8SAYcDnxAJt+2cYHpjjq6cb6WEVlPRqnhl6Jv8NFP1
 UaMvXWKXOCFdIWCHrWFIQUf15LdLDEmU/zwXzyfZQG2Wq2U93E4msNBLmfCWsQnjeq0jzHlw9
 LH1J83xfYaKyDeD02fharmqsJSNqALKEYWEjLrQJws2Wz5jgPZSI4ZxqbBBj7QkwM+OhrfYfm
 pJvDqg1qqx2PtUiHLraj8i4Xu+2d3GRvhwwATD+5vn6shfPPukFISvwG6E9RHWp1hCL9HgOHa
 cRuJ9UDJlD1d4NHhW4AFDmdiBxNX3t/1aWnL2RhFRz/MKspmgfpucBbvqIVCu15yEWoVuFGow
 pV7UdH6YosHCjUeYdDlIUKzJnOdChIznx9L62T01uzYI6f/yPn8uk7xRwPYPnD0h85G9gyWc7
 aQ3UPq5pXIEsfaRzkahuUezedkRTneaTmPEe8i3qzgBomWHKs4+CRulEiP6G+0UoLchV69gFl
 xlbzq1TWj8iZEotNchwg0FyXYQfgdRd7Iu+TK98GEhXZ9PRLX0CzbgvmB6ha7rFV64obYgHKZ
 d6HVjXyAVMHvLZ42o4M9pqSpitmLz6dwqE8KjBwa1+e7AJzBt0eDt2ogJ4lH5f0B8UZw/P9Bn
 01i8l+GG+oqG+3Hawgi8Vv27NgEPLs
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

On 03.12.24 14:42, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> include display_options.h to address build warning:

build warning occurring with CONFIG_LOG=3Dy

> lib/smbios.c: In function =E2=80=98smbios_update_version=E2=80=99:
> lib/smbios.c:305:9: warning: implicit declaration of function =E2=80=98p=
rint_buffer=E2=80=99
> [-Wimplicit-function-declaration]
>           print_buffer((ulong)ptr, ptr, 1, old_len + 1, 0);
>           ^~~~~~~~~~~~
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/smbios.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index a36d4b4e54a..defb6b42f45 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -7,6 +7,7 @@
>
>   #define LOG_CATEGORY	LOGC_BOARD
>
> +#include <display_options.h>
>   #include <dm.h>
>   #include <env.h>
>   #include <linux/stringify.h>

