Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76842CAC582
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 00:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9BB2830A0;
	Sat, 13 Sep 2025 02:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mer7fGaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01C6833F9; Sat, 13 Sep 2025 02:38:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BDBD82ADA
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 02:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1757723909; x=1758328709; i=xypron.glpk@gmx.de;
 bh=A+XX7wAVZxBMng+o6cZLbH5tu10qhEt1W106aPyhwQk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mer7fGaSzh3jTb6tVjFAdeiRd4cYh7yqJ4LeDxyRBKwkypAzKJMXwp0LqNqIAdEG
 +CVE2kmTKEof/UgmRhmV3puQAbVkvc6YGnlv9a7XfuWZX69tQuFcuJkyw6i/x8Prc
 3SKd/5+bO3EDHnujGpsnKYOLmRkCsjIp37vejEiJEqdolP9u5SCJGqLVO9wfNAbGe
 IZU8JJp7KewbvK63mflJTDerlNnAwNawcC3UtsphWZnaWVDB8t8tfBw+jNp6F3m7Z
 O2HG3qyI1K+5vDOOmOuIbITTHJVrh/wC/aYuBOAy6fRnWtSP9AIx9OFVaHu3dDUIg
 j7R+Y555WytvbJcg3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1u6dfA22Nt-00w8aK; Sat, 13
 Sep 2025 02:38:29 +0200
Message-ID: <fc56fec2-68d6-41b3-ba0e-ee649d443456@gmx.de>
Date: Sat, 13 Sep 2025 02:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Remove README.commands.itest
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250912230252.4144988-1-trini@konsulko.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250912230252.4144988-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3kY8wnqmvm5NU2OON0o34Vnu5Vsmt7MUjKkMG7XiEyEN4mtCTBm
 iqCzlupGlzgU3wNlS90N0ncno4QW42Y19ZAKPSXkKtyzPlTGN5l1czNBhzQjrr0spH7v9fN
 DnM1WH4Cz+XzwNXoRHwJ9PqcLflOApnu8N7oTfc8Ue4J+aEDEJzyPFg39dNkhemaqnye97m
 q1jSfPy7TFA/55y7MeIPw==
UI-OutboundReport: notjunk:1;M01:P0:K307HusQ5jc=;IV5zwaQB96cP3+OMeY3FuEQgFtz
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

On 9/13/25 01:02, Tom Rini wrote:
> We currently document this command in doc/usage/cmd/itest.rst and this
> documentation is more comprehensive than the older README file. Delete
> the older file.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   doc/README.commands.itest | 16 ----------------
>   1 file changed, 16 deletions(-)
>   delete mode 100644 doc/README.commands.itest
>=20
> diff --git a/doc/README.commands.itest b/doc/README.commands.itest
> deleted file mode 100644
> index 5e0fe86247a8..000000000000
> --- a/doc/README.commands.itest
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -A slow day today so here is a revised itest command with provisional
> -support for comparing strings as well :-))
> -
> -Now table driven to allow the operators
> --eq, -ne, -lt, -gt, -le, -ge, =3D=3D, !=3D, <>, <, >, <=3D, >=3D
> -
> -Uses the expected command modifier for integer compares of width 1, 2 o=
r
> -4 bytes of .b, .w, .l and the new modifer of .s for a string compare.
> -String comparison is over the length of the shorter, this hopefully
> -avoids missing terminators when using an indirect pointer.
> -
> -eg.
> -if itest.l *40000 =3D=3D 12345678 then; ....
> -if itest.w *40000 !=3D 1234 then; ....
> -if itest.b *40000 >=3D 12 then; ....
> -if itest.s *40000 -eq hello then; ....

