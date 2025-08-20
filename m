Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179BCCA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 20:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A08481FEE;
	Wed, 20 Aug 2025 22:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qQv0oIxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE3C82E34; Wed, 20 Aug 2025 22:54:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71A7801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 22:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755723251; x=1756328051; i=xypron.glpk@gmx.de;
 bh=0JZdiG7T8PodFnaEprMnMlt+dkA6uepwWrZCLClx2AM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qQv0oIxAwkDWUBBPjf5pwswadRJZL+mv/AKX7ZDX6LdYKIKdokkN/WzZVM6GvjzQ
 JMLN941JscQ6NQxCESo5DAdlPBKWaaCp1HHJh78YQfJXhisFu5bVsW2y743zZ6op3
 kIyX5vZ4BmUncjoCVMeDcytJ1u0MQsaBug8IupvWZCtv9qcxs1HLWGN+soRMcOlwp
 wjDXAz2fO5dnz/d3NEonMrVv0mvXvse4bIMDHDiUdFwAcY45pfEi+fTICRTZEiad+
 i++BHoSTFq8Ce5q3ECRvhwSpRNozbXZaPyudLHKwSc2N6Qa0lqSkWw+8w/sVMc0Fa
 wfz6CDWn4hsRlsNjww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU4s-1uEfah2Vjo-00bTXM; Wed, 20
 Aug 2025 22:54:11 +0200
Message-ID: <cd2e240b-0108-41b5-b2b9-74514c93c01e@gmx.de>
Date: Wed, 20 Aug 2025 22:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] doc: Fix typo in doc/build/documentation.rst
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-8-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-8-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KooqJwMKZ0DCBngg5+Dr+pMKWfWyjY4H7QLNDTArpigKHmRAPWz
 aN/6k2uFsUMoGQ3/1oA5ldHlL8UtITi+yEvdIx7DS24+WAxyvH8yeHv6JkoTj5cJ2qcZC3C
 wkSwzEil0266h1XfEMkiKB8XvMgeQ6jPbxjzTL/Str+slC13Q21mqow5doS8gSM98ldLbCs
 DHEoAzrscnqu3PXkA/4tA==
UI-OutboundReport: notjunk:1;M01:P0:BG8QKq/hqUE=;Aqpq6XOxdf/7U/cznRF/q4Golnr
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

Thanks for looking into all these typos.

In future, please, use scripts/get_maintainer.pl to identify the=20
recipients of your patches.

> ---
>   doc/build/documentation.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
> index 098c96a4c4f..f102fbdd86d 100644
> --- a/doc/build/documentation.rst
> +++ b/doc/build/documentation.rst
> @@ -64,7 +64,7 @@ PDF documentation
>   -----------------
>  =20
>   The *pdfdocs* target is meant to be used to build PDF documenation.

Please, also fix the "documenation" typo.

> -As v2023.01 it fails with 'LaTeX Error: Too deeply nested'.
> +As of v2023.01 it fails with 'LaTeX Error: Too deeply nested'.

Building target pdfdocs for origin/master on Ubuntu 25.10 fails with a=20
different error:

Cannot determine size of graphic in boot_diagram_am62.svg

Please, improve the description: How about

     "Multiple failures have been reported for this build target."

Maybe we should simply drop the build target.

Best regards

Heinrich

>  =20
>   We can use texi2pdf instead:
>  =20

