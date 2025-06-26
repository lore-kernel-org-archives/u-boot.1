Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D26DC7115B
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 08:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB6B82AA4;
	Thu, 26 Jun 2025 10:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rKuCKqSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DCAC82C4C; Thu, 26 Jun 2025 10:28:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2061E8006D
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750926516; x=1751531316; i=xypron.glpk@gmx.de;
 bh=w4C3QDPa6XulGu83j0rAFXzgxtmEkGpy8U4Eg/7usW8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rKuCKqSF2s41vTgC+PKYKSKGkePQYjuSRqOIRWr8+vyz0WLm+EIuIUBVYF5KPxCp
 z0qt2d+lcxyuqpgK3Jh5U8IjPOOQ7Du81bH7Ur67Ey7d/9yRqn/WlFpEur260E3Jl
 Irb/R3TgMXcJpEZE9Iu9zBekzGQzThtVDSSprcIfaEAVup3lgwOOevGrZ1G6B+7Ho
 EQQFE7+gkdIbmKLB+o5OeMjmS5KoyyulhpelyetGPlpWN4Pgd8cdlrEWLgXSe5AwQ
 y+YtiIk4fkxC3jXpRkbe8Ge8gsBMFYajVi39AHBlEcLLBhkoC+ZwdMWk1Gib+SsWY
 ADKq5WTMkrapq8bo7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1uNaA60xby-005bQl; Thu, 26
 Jun 2025 10:28:36 +0200
Message-ID: <b8448f72-e0c7-418e-a133-66b95254ada1@gmx.de>
Date: Thu, 26 Jun 2025 10:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] test: wget: add a test case for validating URI
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
References: <20250624120730.2158194-1-sughosh.ganu@linaro.org>
 <20250624120730.2158194-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250624120730.2158194-3-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T54E3H0MLYHEPfU/9ZtQ3fr6KGfJnGkn1fdNhY2P1VDZbReNDes
 J1mwpddONpO9nBUvbyAd3JZ2RSG3/f2PmHRH9dlURaE6JouC09Xr0M3CDXgs4uxZo1mL75G
 loPgXlINVC0ZonIr3R9lzP0Ds/pvuAa9TEh1+bhLWmm6SFhCmJjoDANg/6m8u/NUEHwBnhX
 TVPjdxAVzRyXZqxmpz69w==
UI-OutboundReport: notjunk:1;M01:P0:5WpWCAVY/Fo=;63Dh6C347ozX5wy+bjdheHFuRuk
 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
 b8auyS+2tTNTn6G9/EhUVXwtJ8hEijoQ=
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

On 24.06.25 14:07, Sughosh Ganu wrote:
> The wget module has a function wget_validate_uri() which is used for
> validating the URI to be used by wget. Add a basic test case for this
> function.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

LGTM

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Changes since V2: New patch
>=20
>   test/cmd/wget.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>=20
> diff --git a/test/cmd/wget.c b/test/cmd/wget.c
> index 445750660c2..1005392b952 100644
> --- a/test/cmd/wget.c
> +++ b/test/cmd/wget.c
> @@ -241,3 +241,23 @@ static int net_test_wget(struct unit_test_state *ut=
s)
>   	return 0;
>   }
>   CMD_TEST(net_test_wget, UTF_CONSOLE);
> +
> +static int net_test_wget_uri_validate(struct unit_test_state *uts)
> +{
> +	ut_asserteq(true, wget_validate_uri("http://foo.com/bar.html"));
> +	ut_asserteq(true, wget_validate_uri("http://1.1.2.3/bar.html"));
> +	ut_asserteq(false, wget_validate_uri("http://foo/ba r.html"));
> +	ut_asserteq(false, wget_validate_uri("http://"));
> +
> +	if (CONFIG_IS_ENABLED(WGET_HTTPS)) {
> +		ut_asserteq(true,
> +			    wget_validate_uri("https://foo.com/bar.html"));
> +		ut_asserteq(true,
> +			    wget_validate_uri("https://1.1.2.3/bar.html"));
> +		ut_asserteq(false, wget_validate_uri("https://foo/ba r.html"));
> +		ut_asserteq(false, wget_validate_uri("https://"));
> +	}
> +
> +	return 0;
> +}
> +CMD_TEST(net_test_wget_uri_validate, UTF_CONSOLE);

