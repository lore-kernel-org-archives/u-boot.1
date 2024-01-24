Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ADFC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 11:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC7E087BC0;
	Wed, 24 Jan 2024 12:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="q1a7oEat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 395BE8786C; Wed, 24 Jan 2024 12:22:49 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C4F78786C
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 12:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706095355; x=1706700155; i=xypron.glpk@gmx.de;
 bh=nb9zj3uZvIAxfQyymjmgvM1WyWR19E2NU1CkYOFACzU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=q1a7oEatdUg41IR4SU0ncJnD0V8vHmFIqlcgQN8VSxupfEqbsi4uaFKNloLA3xIC
 Pee665uYm+JY4hSs4Fn8HmfH1w4o7vCwhMpZPS/6eYtvT/ik1aOOQ8u0tTJ3YcVwJ
 DJkv8DK14WgndsgCq+v64Rq79f6GEmk+J/LMcge+i5vQDJcQohfqjmEuz1SR/NK99
 FULiUe8ysLkBRaB91icWTqTXh0USi0KUOfWRnfpTw/0SCaq+/ykPWwjtbTF0PCeLr
 MnCMZhBeVf1g5NDkK2Ss4ZCgEYl8Box/dA2Ov1shCTN4SRrEGHjZGB+4YsBs/LBI7
 uXEpkUL9/mBsQdl3VA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1rBcS03DqF-00rsgY; Wed, 24
 Jan 2024 12:22:35 +0100
Message-ID: <cd1ae5e8-57bf-42cf-ba0e-14e048ad3abe@gmx.de>
Date: Wed, 24 Jan 2024 12:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: dm: Fix typo
Content-Language: en-US, de-DE
To: Alexander Dahl <ada@thorsis.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240124074858.14568-1-ada@thorsis.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240124074858.14568-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+LLrRLMMuhX6tV65atoUBmzJBVJ4OjMFwUcje+sty1aEjFI9KXS
 uVrtJfPTfEnJiMjjuwRo6Vr/PI1iNs5oVkfDne0J3vGEUmoarQS34i55DY4wwJqJ/tA5Qak
 WhmOWfg8dFuoPNpsAt4mFGL5dyVv8ghuRu1SucLIgPHEEumsUsANU+oIMBXTA8MwJkBzJbY
 XGJhqFaY6EohQG2iv52yw==
UI-OutboundReport: notjunk:1;M01:P0:1UDbfsdpUqw=;ozuPZXp+riY3B0Vs+BVKv6TjxgC
 AXh/norSiV4zdTtF/P0IWJvjnLMDjqfEsmm+S9QSeKBBt+xVqleBqCr8Nh4g6INaG2JAmI6fY
 eBzQL3S+cSkDVZtT2tOgxkMomA+efePBfr1lQllfU8zUAg0WemjVaM7vqkJ+fsb3DjLFLViOj
 rpmRGHj4o3LeeMay1fnsY5yBr1hC5DsJNhYzrcD3j4CYGsB5uZ1QurrsTi7hafS61Ejv8bu/Z
 /FfLRyALo6fRTXhGhx/9XnzU4FeE3o43VF50UZzdz5Oj/P9rgquZr2Proz4wwOGvvxwcQC6aA
 clSGqBNrTkRHqfqzn/JWidhzOVw1ZjTKH+7TE9W0p8lQfLh20Jc8pj2InOz0y52KUp3L1avo3
 R3AVbai61RDZqgfapETeyM6UVarIHvb+xtDYuJI4Kepew+On/qgEdZex5H3h+uYaRqCvm7Ngw
 DUotd0xR/xDg7j4ZolMjW6CMB3mmI15hT+XB4B9Rxz6b7ZtGePM7MDKuJHLDNU04TWtZ+4LXB
 /i2201VziEHk8w2iZonVcOHM5EIQ3U9r3ZYvBWBOdtCsYFoDXmB6NQhFyvCYRRw4JT03+qoAe
 48Hj0f3yjUkJtk/mGEsLasG+k423JznSVXS8+znkwIgvylLdFG+XT0zKt/JKe2Z4DUGnvr0eg
 sZZ3fTv+caJtnhiCURSWhP3JjY1AfSyukQ+bJoqVtQblxLwi4F4WhOPJ6D2UBwhxZrw+aTHku
 z4PSdkdC/FAEoCnYb4ku5skjt2VplwXxpuctAPUY56b6bXTLPaZQcLZltP7zcTfobOCr/GFB+
 5Ag5NEf4OkG/OxNrV4aEGdgOyVDm+Bp2iISLblfpelcOD6i4n+2DO8XEtwKAUXngj1HWxFU1E
 GQNvjA/dhqk9pNWE8ZhuOYEHwibtotV6gXrqNEZ9VR8r69GjjZdpY6n4xybPZhgbVDqg9FuLA
 6T8vPhCkMWU1KhrOkTtHVM54kns=
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

On 1/24/24 08:48, Alexander Dahl wrote:
> That's most probably a typo, because driver model design documents seem
> to be from 2012 and there is no 2010.01 release.
>
> Fixes: 282ed24fb3ca ("dm: MIGRATION: Add migration plan for CONFIG_DM")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Notes:
>      This was still in an old local branch of my working copy, but it ap=
plies
>      cleanly to master so I guess it is still valid?! ;-)
>
>   doc/develop/driver-model/migration.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/develop/driver-model/migration.rst b/doc/develop/driver=
-model/migration.rst
> index 03fea943b29..b40a6af9d11 100644
> --- a/doc/develop/driver-model/migration.rst
> +++ b/doc/develop/driver-model/migration.rst
> @@ -13,7 +13,7 @@ CONFIG_DM
>   * Status: In progress
>   * Deadline: 2020.01
>
> -Starting with the 2010.01 release CONFIG_DM will be enabled for all boa=
rds.
> +Starting with the 2020.01 release CONFIG_DM will be enabled for all boa=
rds.
>   This does not concern CONFIG_DM_SPL and CONFIG_DM_TPL. The conversion =
date for
>   these configuration items still needs to be defined.
>
>
> base-commit: 15e7927b5a2d33666af19879577bf0c30ab088fe

