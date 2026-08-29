Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED15C61DBE
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 04:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C340780F40;
	Sat, 29 Aug 2026 04:49:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCmQLaqGBre4; Sat, 29 Aug 2026 04:49:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787978963;
	bh=q6XZCCFwBOTHVA8+/H/TAQXAB9jbh+TwU7c1HhDzz6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dkZdb5t3z715+uq9lijt+wBu8/XMs6c9bDSFyuK4wCeTwzw3qN8Wy5/Ig85EbmkUj
	 vxRh3j9BzdRtoEZMDWWr5oS8YFUWuniXm8YJYMrRLBmSya706rsAQlL21pcKqX/8He
	 ksP0dmFtEAQ7/VLe/ofCrvi3qKFbctuC3CIjhfF6uofQ9pKQ7tziY4eqqquJgDbgj0
	 MHsKfRcKpGhJlXkyfs0J/BnKodgTd06BD0r5EWDJFOL/YgK9wyzMR/OONSIyyvk6GH
	 3rs2E7zNy/iby0BJo87diZe1Aojm6asWRAhopuBPPuB36HjD42rlpUZxZKpMLR1t+L
	 2j5nZWvHy7iYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D153180F2C;
	Sat, 29 Aug 2026 04:49:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E0135336
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 04:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1B474082B
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 04:49:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LqnoCuUC_Vuh for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 04:49:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=SWI4BdEP
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62C0B40827
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 04:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787978950; x=1788583750; i=xypron.glpk@gmx.de;
 bh=q6XZCCFwBOTHVA8+/H/TAQXAB9jbh+TwU7c1HhDzz6s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SWI4BdEPVyo52ftgK9hB1IuwD22vkxT104kD3rLUfG6K02fBP6t+GFthkZDRyaiw
 FQsoTkTFfy5ayH/5Vq5kMI8Q9Xuvjrrx5hnL95VjevRucFjIdxsbvA4Qa4FMjEXzd
 7EsrawdYL2N0duqjiEf317Q+m4Aa4Vm/rup7sG/WY+WVjwL9qh21EmuO2fLG8Mm50
 hyCJgddyd0+UbM6aUY1MISVuHCpjdRdesir81HCes76l57N+l7R+nlm/qN+kC/w06
 W+eJPuBFkWcvFIbVTcBD1vRNYJNK0+6zQmFmwSwOIpNgH6FBe5+tiyWuaZ/ZTQfaX
 M19I5aGb1C7MCNb8wA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAci-1wTK9u0NsO-00q1KM; Sat, 29
 Aug 2026 06:49:10 +0200
Message-ID: <96de4f8c-f686-4e93-8dc0-babe27adcad3@gmx.de>
Date: Sat, 29 Aug 2026 06:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 19/45] doc: develop/coccinelle: update links
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
 <20260825-linkcheck-v1-19-ee7573fe3a4a@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260825-linkcheck-v1-19-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ux4AHItbG+2sU+Yl6puFm/xG85hcAIZgk380H5LUlh9RKswH7M+
 xmWU2wWt63qATzjnQOIHpunOmiwSL2+oV6MMir8WAVIcWETO67513CPoSELUFb+l2uyN+uo
 HmlVScScK7Wh1oT+UPUuuuXXKUBtegGA+3IK41W9EdlzU6IP3SmKpanBQVXKTyK+MjcbJwX
 ZlCzvI9nNHIiw2wlGDkKA==
UI-OutboundReport: notjunk:1;M01:P0:Y3+fmo1nt/U=;PP2x/V7JX/gURsCVzLKpL/YWOsn
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

On 8/25/26 18:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> The original links often time out. On the Wayback Machine[1], the root
> URL is redirected to https://coccinelle.gitlabpages.inria.fr so use that
> link directly.
>=20
> [1] https://web.archive.org/web/20251028230912/http://coccinelle.lip6.fr=
/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/develop/coccinelle.rst | 4 ++--
>=20
> diff --git a/doc/develop/coccinelle.rst b/doc/develop/coccinelle.rst
> index 70274c3f5f5a..54ea8eee0e9c 100644
> --- a/doc/develop/coccinelle.rst
> +++ b/doc/develop/coccinelle.rst
> @@ -34,7 +34,7 @@ of many distributions, e.g. :
>  =20
>   Some distribution packages are obsolete and it is recommended
>   to use the latest version released from the Coccinelle homepage at
> -http://coccinelle.lip6.fr/
> +https://coccinelle.gitlabpages.inria.fr/website/
>  =20
>   Or from Github at:
>  =20
> @@ -66,7 +66,7 @@ The wiki documentation always refers to the linux-next=
 version of the script.
>  =20
>   For Semantic Patch Language(SmPL) grammar documentation refer to:
>  =20
> -http://coccinelle.lip6.fr/documentation.php
> +https://coccinelle.gitlabpages.inria.fr/website/documentation.html
>  =20
>   Using Coccinelle on the Linux kernel
>   ------------------------------------
>=20

Hello Quentin,

The page was copied from Linux.

Maybe you want to add your fixes there too to avoid loosing the=20
corrections when re-syncing.

Best regards

Heinrich
