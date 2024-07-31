Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D482AC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 05:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1069488356;
	Wed, 31 Jul 2024 07:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iBnodjH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63BE88453; Wed, 31 Jul 2024 07:15:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662BE88327
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722402904; x=1723007704; i=xypron.glpk@gmx.de;
 bh=1bk88DaHaNzXVa6PZz4vCUlA47Nxj3yIMrJvPabfB8c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iBnodjH6N3V1grqVUQmW9GONhWkkbHYbUrOV6sdJO1aKDNYT335QvFHwgEKKORD9
 IQwNBw9aL/SHUS6qoVP79QQC0KwQTFBU0dQd5YrtOwrLc+DAEW8YqGwO7s/Z3uRvb
 R45T/8YGw00pAEpAjJHWARkOr9ix3hDvxp/rxXx6C5rIuax4Ov38ipPqxh7KN3Eun
 2OnqGJc4voD0oBBLNI7bCoW5OVGqVUyW0ucAvsEc3q55MwvJ6kFDh5DsafRxqAr48
 ktZrmUroBbgk874NwVUA/A5qrz2PfYCWeqfjOKXcy9bFIC42ltaSGDfavwyRrWfp+
 AN9xnbzLiKPMywCbcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1sBUkX0Sy5-00zANi; Wed, 31
 Jul 2024 07:15:04 +0200
Message-ID: <cc33dbd1-d4a9-4989-a236-f6cf8d950512@gmx.de>
Date: Wed, 31 Jul 2024 07:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] doc: stm32mp1: fix literal block markers (::)
To: Grzegorz Szymaszek <gszymaszek@short.pl>
References: <41ae952bf3f45545e3c6579463df3d0408f6343a.1722014005.git.gszymaszek@short.pl>
 <789acb2e22e681aa86302d522c9385a4bae34582.1722014005.git.gszymaszek@short.pl>
Content-Language: en-US
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <789acb2e22e681aa86302d522c9385a4bae34582.1722014005.git.gszymaszek@short.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tvveUwYG9gvFnj3s33+hJkOVX7EC7HZ/dCLaN3Uh4SfUMZyHOMy
 bEQRVQqZEW3qPx9NEWbqZJ/ANddKpT0el44ZaPKh1lLc7v6Rzw50h74tsLATvDRkEnuiw1n
 5ZdmaLo1Nhx6hMzM2JfECq0+1RgaqBGoh+yY0oeqvxm5kq90KnWP2u2Un9lfS6RNNEDfbfH
 DuYVY8Yr7DzczUNBjUbxA==
UI-OutboundReport: notjunk:1;M01:P0:Ldk46YHMbdU=;1BiCQO7JYx/2u6TvDj6FmqejWua
 Frgnq9ZMJgPQBMupcLZQ2Ls/x/dWj7CzAFc4b/D0L0C5rV1z1emVHR8Iiw72Btk3gV6GRujtU
 Eu6wLDdX7uD26qpmsNKWUatNS1UWjjM8TOsjta3nSzozXMKG4DpPcxx+O/rySp0Cs0qnKlImE
 qBUFTLqyXtf5GkXLlcO372dNg87Czp4dHNdzym0mM0A7DkoIgWTo9eiFBD7yDC6fArcWoJ6SM
 KPt+zZxUrED8LlGXrAwnZ8ZCtMBoNmI8wM/q+yq7OIKHgBzrmM1GRuSwL9laPGgSwSFTH8HwS
 GDHXBLOkwGOjlx8JZ4JSO8d4kNosqeKJU8PwgY2fHxE6Hm7HQ/30QYyhV0nVs29nKY1Cx20Gs
 T1YLNb+DbxPMr4iT9RHhs56AzttjCbVLkufCyMTb4J83ECPc8qEUNoWGvDl2jSYpZwr/5d+mb
 6SMN4SNpF8BVDis+BSo5iwvwufEdV4RH0OV+j6q45epf4lMeVbGfUirMWMvmuSdpznU1lSlME
 1R87VVn3zjlCayfmOvI9AttqXKRkrU0x4owgqL4qYYshPVBm5SgU4IJoC1tPjqX/8c1cwPS6N
 4cvWSJtsX+4Lo+rgwsYIaSN3BY7EHCn8IbneW6RuD91TRIj9Iz6WUfa92xQlEusGu1qJasCUN
 69JsjFt8JdFZYwYfVWUMjjTzMGT/fqdgQ4ie43kESd/JXe/cJWIxOQCx410sS+SEa4awPMyCD
 sd49xGh30vtzPfxxFlKBqHFpumxADKh0LbmwYTilNqyy+1sIfVC0DF1mJnB6j64JEKVaylyoJ
 qj1Bm3j0FD+8/UkX5Mu+rNGg==
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

On 7/26/24 19:18, Grzegorz Szymaszek wrote:

Thanks for looking at improving this documentation.

Please, provide a commit message.

> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>   doc/board/st/stm32mp1.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/board/st/stm32mp1.rst b/doc/board/st/stm32mp1.rst
> index 239e18b5e17..98167e80618 100644
> --- a/doc/board/st/stm32mp1.rst
> +++ b/doc/board/st/stm32mp1.rst
> @@ -265,7 +265,7 @@ Build Procedure
>        # make stm32mp15_defconfig
>        # make DEVICE_TREE=3Dstm32mp157c-ev1-scmi all
>
> -    or without SCMI support
> +    or without SCMI support::

Either use

.. code-block:: bash

or

.. prompt:: bash $

>
>        # export KBUILD_OUTPUT=3Dstm32mp15
>        # make stm32mp15_defconfig

# is the prompt for root. Please, do not suggest to build as root.

Please, do not start lines with a prompt as this does not allow to copy
multiple lines to a terminal. .. prompt:: allows you to display a prompt
which will not be copied. .. code-block:: avoids showing the prompt
which could be seen as distractive.

> @@ -796,7 +796,7 @@ You can update the boot device:
>   When the board is booting for nor0 or nand0,
>   only the MTD partition on the boot devices are available, for example:
>
> -- NOR (nor0 =3D alt 20, nor1 =3D alt 26) & NAND (nand0 =3D alt 27) :
> +- NOR (nor0 =3D alt 20, nor1 =3D alt 26) & NAND (nand0 =3D alt 27)::

ditto

>
>     $> dfu-util -d 0483:5720 -a 21 -D tf-a-stm32mp157c-ev1.stm32
>     $> dfu-util -d 0483:5720 -a 22 -D tf-a-stm32mp157c-ev1.stm32

Why '$>' is used as prompt here? Shouldn't this be '$'?

How about telling the user what dfu-util is and where to find it?
Does it relate to http://dfu-util.sourceforge.net?

Best regards

Heinrich
