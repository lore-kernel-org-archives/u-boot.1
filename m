Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BB4EF3717
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 11:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C72183F1F;
	Mon,  9 Mar 2026 12:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JeeJumW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D5783BC8; Mon,  9 Mar 2026 12:58:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C4BF839D5
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 12:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773057522; x=1773662322; i=xypron.glpk@gmx.de;
 bh=HtJycvJZkhEtboQlSqdpgyjnjof71pP0aVn/K+mays0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JeeJumW3Wxhkr8TOSyps/LC/0Mufbj45kqK7tYf21KO49edh9BHHt4IDRGwkO+PJ
 uJSLTgV0ltb8r85u6UDB7myNuyzKulsl+nGsmzzgtOG5+k6IphiETElBc+18q12TX
 XiRNVmCCgh8yT0zCrWjPc14Fa81es+PnUmuEwDNmWf+ZCM4ImkBBoPTl/C7RM2+N1
 VfliBm/U7NDYE32+2hHBVACzhpIBFXo4BsUk6qu0MSDXvEP4daNTIFVDCpbfT38vw
 yG6+/ntRN8u4IqfsWDVzgobawb3CtpG2lmtB/xz8IXSPQa+7La4HvQ3NZUJ6lplQi
 1AkP5AUVkoDzkUOwig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1vX9Ee3tXd-00z28L; Mon, 09
 Mar 2026 12:58:42 +0100
Message-ID: <8a5724d6-11dd-4eee-ab07-ade052249243@gmx.de>
Date: Mon, 9 Mar 2026 12:58:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] board: starfive: visionfive2: Add Orange Pi RV
 selection by product_id
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
References: <20260305164328.33789-1-e@freeshell.de>
 <20260305164328.33789-2-e@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260305164328.33789-2-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ZIR8K704+q9WSAOtroHsi7dM9gFPqgQVTS+brHCVYSeozQb1Yw
 m+hQMxqu8/JkTEtUi8LEpH6Kb4kwKUv2NcEn7SbmJWi5s2xM5n+PFdUj8b5Y/kS9QfZMfDU
 DYOg+BsJbTQWu0eLiIZ3mif/YeU6kC4MlXpRWE8QvTzq7CxWDQ/Ii1jnl0Wnwa0ZfInubfb
 2bMXYHhOd/3xILZ3Tb4Tg==
UI-OutboundReport: notjunk:1;M01:P0:08SHZf22rkk=;q2qUBD42fAvR7yZdPCV7LAKBIJC
 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
 +psr4zV9iGr1/1WpopGh
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

On 3/5/26 17:43, E Shattow wrote:
> Add XOPIRV identifier for Orange Pi RV to dts selection callback in SPL,
> and to fdtfile environment variable default value selection in payload.

Did Shenzhen Xunlong Software Co., Ltd ever respond to the suggested=20
EEPROM change?

>=20
> Signed-off-by: E Shattow <e@freeshell.de>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>   board/starfive/visionfive2/spl.c                  | 3 +++
>   board/starfive/visionfive2/starfive_visionfive2.c | 2 ++
>   2 files changed, 5 insertions(+)
>=20
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfiv=
e2/spl.c
> index 2d9431d2976..684605278c0 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -131,6 +131,9 @@ int board_fit_config_name_match(const char *name)
>   		    !strncmp(get_product_id_from_eeprom(), "MARC", 4) &&
>   		    !get_mmc_size_from_eeprom()) {
>   		return 0;
> +	} else if (!strcmp(name, "starfive/jh7110-orangepi-rv") &&

This matches the name of the device-tree in upstream Linux.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +		    !strncmp(get_product_id_from_eeprom(), "XOPIRV", 6)) {
> +		return 0;
>   	} else if (!strcmp(name, "starfive/jh7110-pine64-star64") &&
>   		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>   		return 0;
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/s=
tarfive/visionfive2/starfive_visionfive2.c
> index 6c39fd4af35..d59622f6b64 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -63,6 +63,8 @@ static void set_fdtfile(void)
>   		} else {
>   			fdtfile =3D "starfive/jh7110-milkv-marscm-lite.dtb";
>   		}
> +	} else if (!strncmp(get_product_id_from_eeprom(), "XOPIRV", 6)) {
> +		fdtfile =3D "starfive/jh7110-orangepi-rv.dtb";
>   	} else if (!strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>   		fdtfile =3D "starfive/jh7110-pine64-star64.dtb";
>   	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7)) {

