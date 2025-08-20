Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB55CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 20:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C79281FEE;
	Wed, 20 Aug 2025 22:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uRZ2xVGy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E415482B07; Wed, 20 Aug 2025 22:32:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E98C68006D
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 22:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755721976; x=1756326776; i=xypron.glpk@gmx.de;
 bh=uCZCkRhfHOvvxaWQZXrSYv2+yPlIy+p0B6JP3MYVXg0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uRZ2xVGyaqPHMvs68JyeWadILU/xXBq5C+eAwtkMjWgrWFkxM9EZRyK5LztdhJuL
 LpYgo4paxFTl863DyhMMbOzZOjmNVQAwm+8zrYnojFPoJHOEnu9nqrHsbt7oPC0nh
 nHY/T0fZZuB0Fw5M6UVcghxEuvgU2Bv/0Kr6vlqi31RqRQ8oiv8bllHssdA3chkTj
 exKaBEVG5nF5s+jby+EE94e9JR08fELIPt/UMN4lwm1AraK6XxWZGdgjWzHx1qjHH
 Xvtd94PI8qo+xUmVl7MLBle0aZJ95qy6a5m4dnSvsNf8M9fSFOznog7OuWt4bHBQ1
 hxTjRpo7eallTwlzRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1uaisV3Mu4-00xQaN; Wed, 20
 Aug 2025 22:32:55 +0200
Message-ID: <e69d0df0-aadd-409f-82a7-b65a5b764a48@gmx.de>
Date: Wed, 20 Aug 2025 22:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] doc: Use a long dash instead in
 tools/buildman/buildman.rst
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-10-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-10-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AXmmp1Uvsp7zmz5v8Ky0H3bjydikcRaQgwkEl1cLDwyWEBf9eGl
 paq19EfTrUY23NiNODxCHI89elLGbCNWorWwnEIvhIoQ/Hn5vI3fke2iFRAzPXcV4oRTVBl
 0YVmtXZqjd7T6Z5cu9G0tE4K+ws4QsCNTbDw2l2W3aKYcahux4E70L6URcp/dRcCwRhDpJi
 fIFI9/CDgYFqlbXGMgTVA==
UI-OutboundReport: notjunk:1;M01:P0:C/Q4OmxuT0g=;gc1Dz+/HQN1K4OWEUjd9d9VD37N
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

On 11.08.25 01:37, Adriano Carvalho wrote:
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> ---
>   tools/buildman/buildman.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> index 7944adcd867..3e41d6ec304 100644
> --- a/tools/buildman/buildman.rst
> +++ b/tools/buildman/buildman.rst
> @@ -1360,7 +1360,7 @@ Using boards.cfg
>   This file is no-longer needed by buildman but it is still generated in=
 the
>   working directory. This helps avoid a delay on every build, since scan=
ning all
>   the Kconfig files takes a few seconds. Use the ``-R <filename>`` flag =
to force
> -regeneration of the file - in that case buildman exits after writing th=
e file
> +regeneration of the file -- in that case buildman exits after writing t=
he file

Please, use the Unicode character, that you want to display, e.g. U+2014=
=20
(em dash), or U+2013 (en dash). This way readers of the raw rst file=20
will not be irritated and the rendering in HTML will not depend on the=20
smartquotes_action setting.

But to be honest I don't see great value in this typography change.

Best regards

Heinrich

>   with exit code 2 if there was an error in the maintainer files. To use=
 the
>   default filename, use a hyphen, i.e. `-R -`.
>  =20

