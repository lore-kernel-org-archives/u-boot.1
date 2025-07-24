Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92DDC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2568B836D2;
	Thu, 24 Jul 2025 11:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IYmO4KUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8531B836D5; Thu, 24 Jul 2025 11:29:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA58C836A9
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753349338; x=1753954138; i=xypron.glpk@gmx.de;
 bh=3bEkJzTl1up7eSHokzpNUFvff4vpVI9la36QyeAvneU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IYmO4KUw9S5FHAr8eRvlbKoAEkiko8KLdh5BdYwa2Nxni2qz2qx04yJMzogXyj9f
 w+m+FLnvD374WBWjn3EthxQyxL+7/m/Z2ex/2zLOi5WUuau9vKShvmkIGaet4X4+b
 3xmFPuan2PhGVEl4PPv0UU4MmQk9lmXHYvaXvXSN2KUJrLFTI2HWWgeyqpDTaZWg1
 uV+NXTUgJx/kJwXKTcIy197s7U4HUJLXMXrTeofIjjN2CzmddKB7rYi8JlpisKZZ2
 mPwm4tUDqd6VMQoaCd/4NH2wsEdOYcCq1mWqSe9JTgJBj9cp0ek6+wtZZFentCB4G
 5VwCh2XpglMqCi+evg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNt0M-1v2yg62myW-00QXd5; Thu, 24
 Jul 2025 11:28:58 +0200
Message-ID: <2f556050-c9d9-4120-98ee-5635dec30f24@gmx.de>
Date: Thu, 24 Jul 2025 11:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] binman: bintool: use apt-get instead of apt
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, U-Boot mailing list <u-boot@lists.denx.de>
References: <20250724091342.59902-1-jerome.forissier@linaro.org>
 <20250724091342.59902-2-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250724091342.59902-2-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vXgHSIY+TJCaCWLjFrKDpLhiAPz5Q65Cz6F80jLwjmie0ASxLg1
 lLHBkXQXy28pwQjVZr/3BpUS0U9wrsdpTjXJslmVCmK3/OP5qhTjVlJ5dmCPR7JRnRDCT7U
 7Kx84CCLewo+sxmVQCQ+JKkQxnA34rifCgomn7hBh6l+LZrpoELU1/eFKlLcl5VQwrbc4aS
 27R0rp3iMFnAXXvpRL5Qw==
UI-OutboundReport: notjunk:1;M01:P0:jF9va9wQMuA=;Pfw79zKaqH1rHRvF4Ymu6jtHA71
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

On 24.07.25 11:12, Jerome Forissier wrote:
> The 'apt' command is not meant to be used in scripts or tools. Please
> see the man page [1] for details. Therefore, use 'apt-get' instead.
> This avoids the following warning:
>=20
> WARNING: apt does not have a stable CLI interface. Use with caution in s=
cripts.
>=20
> [1] https://manpages.debian.org/bookworm/apt/apt.8.en.html#SCRIPT_USAGE_=
AND_DIFFERENCES_FROM_OTHER_APT_TOOLS
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>=20
> (no changes since v1)
>=20
>   tools/binman/bintool.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
> index 81872db377f..f46bb52a7b3 100644
> --- a/tools/binman/bintool.py
> +++ b/tools/binman/bintool.py
> @@ -421,7 +421,7 @@ class Bintool:
>           Returns:
>               True, assuming it completes without error
>           """
> -        args =3D ['sudo', 'apt', 'install', '-y', package]
> +        args =3D ['sudo', 'apt-get', 'install', '-y', package]
>           print('- %s' % ' '.join(args))
>           tools.run(*args)
>           return True

