Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A21EF3717
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 12:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C0E83BC8;
	Mon,  9 Mar 2026 13:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LkLNlnAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CDA83CDF; Mon,  9 Mar 2026 13:00:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A91F805D7
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 13:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773057614; x=1773662414; i=xypron.glpk@gmx.de;
 bh=a61U5k71punNQ9IWdmYmA+x0Dw1cnskO+1FUCcLd/jY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LkLNlnAAr64WARUcF5w1QXQBhD9ejfyJN1DmSC1cBgFCElGTxG8fVTORGHKPXTnQ
 o991dutxpTvx4z42Df9c7J4LD2Vc2/qCrxBeUJMBYtHAjLNSgdDMba5rvV7ZKMJuR
 SlD+JjpYo0TpZcpCPqUwRYGRCCONokNJq0niDk2pLeDVD4XitCIPFeqxPp12IGot7
 6LpwnbuRR2KPC4iZoBZcnoMmRYCQsLflsRfH2hSEAeKhDF5eMooxLz8Y2qej434xj
 V57t3wllUtftsrhwxnB0AExCrbSFp3cO6ep7nhTOXroLBlKZdrlxNkbRZlJSKQPhp
 KvL/AV7NCf3YGVupXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq24-1vfi2o2MMi-017WUU; Mon, 09
 Mar 2026 13:00:14 +0100
Message-ID: <e64fbdeb-9893-4665-8c04-87fa3c044a5f@gmx.de>
Date: Mon, 9 Mar 2026 13:00:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] configs: starfive: Add Orange Pi RV to visionfive2
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
References: <20260305164328.33789-1-e@freeshell.de>
 <20260305164328.33789-3-e@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260305164328.33789-3-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BGFQXMKb1/9kN3pSCUYFPFVrFwYY8eUmRy5XbV2U1Ip+rx5GQqm
 iEOdec1Yp7rZwu7rOJulTa5irnjEps2bSSSH/sVvwNqMtiyQ+1v5fFLk8D45A9lGSrxGxDl
 zCckm9RMfm1BF+NVRx5HjueYSTkoz2FV/sJafqPbDVBPHTJadsGYmg+qwYPSyxKp0iv2DuW
 J4RJj+fFFmuCFMtGZ3BVw==
UI-OutboundReport: notjunk:1;M01:P0:/UR4Rxx9fq4=;JvA1+E7IxwlW+4+is36OVCmw+Lf
 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
 bwcEyjMmEt7aiQuoO6TnBNuUNW5bR
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
> Add Orange Pi RV to visionfive2 CONFIG_OF_LIST
>=20
> Signed-off-by: E Shattow <e@freeshell.de>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   configs/starfive_visionfive2_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_v=
isionfive2_defconfig
> index a754134a313..7c957cc0ea1 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -80,7 +80,7 @@ CONFIG_WGET_HTTPS=3Dy
>   CONFIG_CMD_BOOTSTAGE=3Dy
>   CONFIG_OF_BOARD=3Dy
>   CONFIG_DEVICE_TREE_INCLUDES=3D"starfive-visionfive2-u-boot.dtsi"
> -CONFIG_OF_LIST=3D"starfive/jh7110-deepcomputing-fml13v01 starfive/jh711=
0-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marsc=
m-lite starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2=
-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
> +CONFIG_OF_LIST=3D"starfive/jh7110-deepcomputing-fml13v01 starfive/jh711=
0-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marsc=
m-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/=
jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v=
1.3b"
>   CONFIG_MULTI_DTB_FIT=3Dy
>   CONFIG_ENV_OVERWRITE=3Dy
>   CONFIG_ENV_IS_IN_SPI_FLASH=3Dy

