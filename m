Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866DEC25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 08:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B305088685;
	Sat, 18 May 2024 10:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Hg6uVCJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F8988690; Sat, 18 May 2024 10:31:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CA058865B
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 10:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716021058; x=1716625858; i=xypron.glpk@gmx.de;
 bh=jaENoWHvU51Ppq9lYComuNC8kQzbdwl26uh2tnkN1EM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Hg6uVCJeefMvlYz7pZoGsKpqO5Jg/lORMMSD3UPeXdBrpn6aPGlDphwiGm4oayA+
 p0eUFVH84q+34+6Kq+fnnn+vifVE800UtSkQPXiBv9Jl09Nigjaey9yQgV5KXTkcq
 ylspan6volB0pdDAI3sj+Ms+e5KKICNmRsoZlPzyq/NKEgHEweRXdvVMNIsSe+A3O
 Bip2gQb9qJ8I8Ph5S9VS0nmD/yyLR60xeghZA2cZSpjMZHvyVbtKabK9z06el8gRJ
 h7tn708xqsqcMUNq8akHVyk8AxDGSxecFPjE5dO4XpLVqijGjYvOrXLFkkfkX0aPD
 7k3GnhklAT38AuVhGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1shaHi0hea-00cjkW; Sat, 18
 May 2024 10:30:58 +0200
Message-ID: <acb01e6e-08dc-49f1-8af6-617f35e2681f@gmx.de>
Date: Sat, 18 May 2024 10:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] imx: hab: add documentation about the required
 keys/certs
To: Claudius Heine <ch@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 open list <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>
References: <20240507130650.713801-1-ch@denx.de>
 <20240516083614.510948-1-ch@denx.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240516083614.510948-1-ch@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o7iiebr/50ks9WtkQ4z/tCC/yHDxnazoWyIUjk2I5WAfKzZdxlM
 Vej+XL7ws/JZiZNANXpMXCF4E47exZq1Bj55jd8jr/pyLnxoHnymzLAD/AGw7ocMu0/dzN2
 WTQLkUuDJofm4eKRJzJK/uuMfXmF4xKB8da1WozCBkl3xLR3rz4VYLoST2fmGa1LpFclaZj
 LNNUxe3koFMA360zTv4zg==
UI-OutboundReport: notjunk:1;M01:P0:P1v/5BLes8Q=;svujXkNtAkK09VVvSbkTFrEXaq7
 CgMMNqndr4jOczpCHchED8jEGKbbzsc0d2CL0rQZMSLJwjGrcA2AERqyg9v0ekV9gzGNofAn/
 c+DZBCq+NWxv4Eu3IpsmyoZf0hqFyoUtnos7nXD67BsNZwghfXV+d4yBZhxRkK90E43dszmgG
 rUuVyG+V2Nk5OdkZf/kUIoPnLqlm3bKhuAxEZIynVO3ZhKPodKD8EnSuVYmAWjGzv/hTQEiLo
 avJ0QlaE9Msa17n0DY1A4haEpPkXASAtijg53IzKKnAS1dXHUlw7gLuzBkOBDYY6r3Kn5PbwU
 gXRcjGOwyETlJbO3e/5GsOTXRZ46A5F9CBER9stmQK+AFrfPztnJJfNz4W5HCXz+0DLCCRyRT
 VvcDEhVSNjPlrYB10SMQL5o4H94c5weH4I1WY6md8vVww61Dte40taEx8aVgJSpUTrxTOuMd6
 e0mm10v5LLO/hL64op2dQDAlvfnGNPz2+8CbP1s6VkKL9ppXyDMjsRFEEkgTvZt7vp1sfq7mH
 0QacBZSNAs2/uo3PkFp/GHYAebzFjzzKQ5m2bdMxihCpPn5W4gS2EjRtf8IuGshty/lFGlxss
 2QmCB8+qhibH4UrG1pj/IbqtLtzhWBWcy4JCJmpODZ+197IzELMlH4Ou+X068B4eUKpD8XBrg
 E2iREWD+SaxzKKN7YM0fvV+A1CXE1LXeLIwAC/2p9SPxDR5POoiGNTV7/VQWh8u26+JcRCXlS
 RFirjfWbsvbeNMfN2kndwZmsVTAZ0DymuZLho5nXVIsaGqCYlpW4vyQZhLPyLPtgB+GjiNjJM
 SglYEnGS2PwCSU97huojEDyikzgxTinOUrguCeLYUYwZg=
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

On 5/16/24 10:36, Claudius Heine wrote:
> For CST to find the certificates and keys for signing, some keys and
> certs need to be copied into the u-boot build directory.
>
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
> Hi,
>
> this patch documents some changes of the
> '<20240503010518.263458-1-marex@denx.de>' patchset. So am posting it as
> a reply to my earlier patch in that thread.

When referring to patches, please, use the complete title and and url
(e.g. from lore.kernel.org or Patchwork):

[PATCH v2 1/4] binman: Add nxp_imx8mcst etype for i.MX8M flash.bin signing
https://lore.kernel.org/u-boot/20240503010518.263458-1-marex@denx.de/

Currently in Patchwork this patch is assigned to my review queue. I
guess it should be reviewed and pulled by Fabio.

Best regards

Heinrich

>
> Changed from v1:
>   - added 'symbolic link' option for making keys/certs available in buil=
d
>   - `node` -> `node(s)`
>
> ---
>   doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/hab=
v4/guides/mx8m_spl_secure_boot.txt
> index ce1de659d8..75089fba4d 100644
> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> @@ -144,6 +144,23 @@ The signing is activated by wrapping SPL and fitIma=
ge sections into nxp-imx8mcst
>   etype, which is done automatically in arch/arm/dts/imx8m{m,n,p,q}-u-bo=
ot.dtsi
>   in case CONFIG_IMX_HAB Kconfig symbol is enabled.
>
> +Per default the HAB keys and certificates need to be located in the bui=
ld
> +directory, this means creating a symbolic link or copying the following=
 files
> +from the HAB keys directory flat (e.g. removing the `keys` and `cert`
> +subdirectory) into the u-boot build directory for the CST Code Signing =
Tool to
> +locate them:
> +
> +- `crts/SRK_1_2_3_4_table.bin`
> +- `crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem`
> +- `keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem`
> +- `crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem`
> +- `keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem`
> +- `keys/key_pass.txt`
> +
> +The paths to the SRK table and the certificates can be modified via cha=
nges to
> +the nxp_imx8mcst device tree node(s), however the other files are requi=
red by
> +the CST tools as well, and will be searched for in relation to them.
> +
>   Build of flash.bin target then produces a signed flash.bin automatical=
ly.
>
>   1.4 Closing the device

