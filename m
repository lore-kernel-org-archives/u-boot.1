Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B779CCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 07:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E18483A71;
	Sat,  1 Nov 2025 08:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HYvs60AT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4705383A8A; Sat,  1 Nov 2025 08:45:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56BC9839B9
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 08:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761983150; x=1762587950; i=xypron.glpk@gmx.de;
 bh=mbk82QXD+JsGm0r5qgFYmuS4YDM69x/FNC9omTdse1s=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HYvs60ATZKBS8kcpGnP3EejkabB+waSqlca+l2zliAX607wxwiZBQuqXX4eHZX6Q
 r2JsEPqwCWj7S+BfkotvAuWKdSpxmCR9lZEKheLhL5TkK+JTs84QTzSf9+xr4MM7k
 Qb3hqJytjKOFsyEnMCA+aAVLDRxdVzIkwjWJVg7dcPpUolrgU3iAXfudRyH/cGuY1
 sUKNWMnp37k5zfW1vnVjzNy/Hc+L10tvRWbXanGdlh6pvzPxTxDPhKb4DpqlkWfNW
 XrI3kFxSad24ls1dswwqTJpUNOw7JMvYasYbRG3NzSxt61tutgyqHD4JB1ZLoPQ4I
 SF4vIHH4jOtBHcPKCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([93.94.208.154]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MacOQ-1vqtpU0tyc-00eugP; Sat, 01 Nov 2025 08:45:50 +0100
Date: Sat, 01 Nov 2025 08:45:48 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
CC: Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 5/5] test: cmd: fix a typo in md5 test
User-Agent: Thunderbird for Android
In-Reply-To: <20251101064907.5037-6-hs@nabladev.com>
References: <20251101064907.5037-1-hs@nabladev.com>
 <20251101064907.5037-6-hs@nabladev.com>
Message-ID: <1E10AECC-9A4A-4432-B6B2-977154703D21@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k4ZQ5O0y5IJ/wTWohWY0O+/EQIjFxJwmKDJ36mq3jujUtwXqbz6
 RkcdilW7Re+7qNbHgglHD9iBhgaMPk7wLWEVfwUit8iAG43BWvcEnk0cEcvyEt+83aKDBn/
 or7yApTug/i9dxGqr+rCd8YWzgAhGPdBenhUPmfCxWy/3VpQSX/1pXu/QnbkLmBO9fjySa4
 SJxrjw2xoKxLQFZYJEwmQ==
UI-OutboundReport: notjunk:1;M01:P0:+lm+q79/DgQ=;xv+MLHdFlBty/hOXkta1Dr89e2Y
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

Am 1=2E November 2025 07:49:07 MEZ schrieb Heiko Schocher <hs@nabladev=2Eco=
m>:
>In dm_test_cmd_hash_md5 accidentially sha256 hash
>ist used=2E Use the correct md5 hash instead=2E
>
>Signed-off-by: Heiko Schocher <hs@nabladev=2Ecom>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
>
> test/cmd/hash=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/test/cmd/hash=2Ec b/test/cmd/hash=2Ec
>index 3f7f64d27d3=2E=2E3a3869831ce 100644
>--- a/test/cmd/hash=2Ec
>+++ b/test/cmd/hash=2Ec
>@@ -38,7 +38,7 @@ static int dm_test_cmd_hash_md5(struct unit_test_state =
*uts)
> 					  "d41d8cd98f00b204e9800998ecf8427e"));
>=20
> 	if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
>-		ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
>+		ut_assert(run_command("hash -v md5 $loadaddr 0 foo", 0));
> 		ut_assertok(ut_check_console_line(
> 				uts, "hash - compute hash message digest"));
>=20

