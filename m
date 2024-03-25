Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CA0C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 11:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D957E87E49;
	Mon, 25 Mar 2024 12:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="beHRHQTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18CF87DC7; Mon, 25 Mar 2024 06:32:42 +0100 (CET)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314E387DD5
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 06:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=codeconstruct.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew@codeconstruct.com.au
Received: from [192.168.68.112]
 (ppp118-210-177-226.adl-adc-lon-bras34.tpg.internode.on.net
 [118.210.177.226])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3B53F20173;
 Mon, 25 Mar 2024 13:32:31 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1711344756;
 bh=4zMFm3cEUu9LBU+50WlOUI5pRCFKXq9CsV+f7ujQHRQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=beHRHQTiqodIIveKZA4abhda4Sx4vCQUBVPhjZzhHKUXb4YEhzRSSBmZdwQvYvMiS
 nyr3U24DQOE5q21KejpUCInCYcihWhSNyXEjEVhUZ3Zc7Wk0WqlxNpDbbH516m49tv
 p4XF6xS1X/nPJZnwCqNNwv3yKOL2RLSoDlQ23a6opYEb7cgTmeilf8uG1ZZBChtNEc
 V+NYkoYmVKS6nWJxfjtyT2ALMIx53B13AXxaTpS+pQbAiVwZICWcAfoIkwgPwj5g0Y
 uQR1S7510TPs5NArmPJpW8DphxJuPkOUqOckaIdegAN3kSohx9KMKKbiUJV4D6cS2B
 0G5Kn/nuBm3jA==
Message-ID: <2a55a4544f3c1c9b31ecf5232a8d8409a87a6f2a.camel@codeconstruct.com.au>
Subject: Re: [PATCH u-boot v2019.04-aspeed-openbmc] ARM: dts: aspeed: Add
 Ampere's BMC platform (AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chanh Nguyen <chanh@os.amperecomputing.com>, u-boot@lists.denx.de, 
 Albert Aribaud <albert.u.boot@aribaud.net>, Joel Stanley <joel@jms.id.au>,
 Zev Weiss <zev@bewilderbeest.net>,  Andrew Jeffery <andrew@aj.id.au>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Jae Hyun Yoo
 <quic_jaehyoo@quicinc.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Dylan Hung <dylan_hung@aspeedtech.com>,
 Graeme Gregory <quic_ggregory@quicinc.com>,  Eddie James
 <eajames@linux.ibm.com>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Open
 Source Submission <patches@amperecomputing.com>
Cc: Thang Nguyen <thang@os.amperecomputing.com>, Phong Vo
 <phong@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 25 Mar 2024 16:02:31 +1030
In-Reply-To: <20240319072137.16695-1-chanh@os.amperecomputing.com>
References: <20240319072137.16695-1-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 25 Mar 2024 12:15:06 +0100
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

Hi Chanh,

On Tue, 2024-03-19 at 14:21 +0700, Chanh Nguyen wrote:
> Add the initial version of the device tree for the Ampere BMC
> platform, which is equipped with the Aspeed AST2600 BMC SoC.
>=20
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  arch/arm/dts/Makefile           |   1 +
>  arch/arm/dts/ast2600-ampere.dts | 113 ++++++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+)
>  create mode 100644 arch/arm/dts/ast2600-ampere.dts
>=20
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 37675a3277..3642d59c89 100755
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -691,6 +691,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
>  	ast2600-greatlakes.dtb \
>  	ast2600-intel.dtb \
>  	ast2600-ncsi.dtb \
> +	ast2600-ampere.dtb \
>  	ast2600-p10bmc.dtb \
>  	ast2600-pfr.dtb \
>  	ast2600-qcom-dc-scm-v1.dtb \

Given this hunk and the tags in the `[PATCH]` prefix of the mail
subject you've based this change on OpenBMC's fork of u-boot, which is
heavily (out of date, and) inspired by Aspeed's SDK tree. I've applied
this to OpenBMC's fork for now.

However, you've sent this to the upstream list. You will need to rework
your patch on top of mainline u-boot if you want it accepted there, and
follow all the usual documentation on how to submit patches to the u-
boot project (e.g. you should not be including `u-boot v2019.04-aspeed-
openbmc` in the patch subject prefix in upstream submissions).

Andrew
