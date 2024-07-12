Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A787C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 09:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9C8886E7;
	Fri, 12 Jul 2024 11:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="M3cHSoT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 835F488176; Fri, 12 Jul 2024 11:46:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A0287D6B
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 11:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720777571; x=1721382371; i=xypron.glpk@gmx.de;
 bh=ZIRqxMwxU75wIMVwCMbcdnnmFkalgPqmk4V83xKEVlQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=M3cHSoT4FAYZH8usky+c8Gagserg6ZEGY729+6x6teGYoNPaaGI5piUvHI23M1j0
 qakljX23xTQJEvWe4gLM87zxjqCS7FK+VjT/0eUyQ9oExT87dZrPczrz5SnDWVQ++
 G2M5KP90PF3Fo/KOp7j/newlogSzx915i++7HTVW4WBBbbqqF7eQMy/lAn7myA31K
 5TBS5HYDx1/aae/sSZOlOs/f6rUraHp9aZbVklG7zE5c7wPO5vzdIaEXUxI7NPS07
 K+4LwmMOdHHn/DCTwLzyjrzOXhf2PzuKUlw8eBkskRs7XA1F5AJVdSMrGNCH0P03O
 PLVULDrEAXOJ/Pv+Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.93.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1sVm9v2epZ-00Cmrx; Fri, 12
 Jul 2024 11:46:10 +0200
Date: Fri, 12 Jul 2024 11:46:08 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
CC: ilias.apalodimas@linaro.org, sjg@chromium.org,
 christian.taedcke@weidmueller.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at
Subject: Re: [PATCH] fat: fat2rtc: Sanitize timestamps
User-Agent: K-9 Mail for Android
In-Reply-To: <20240712082454.8752-1-richard@nod.at>
References: <20240712082454.8752-1-richard@nod.at>
Message-ID: <E6A299D7-6DA8-4FA7-8864-BB6F346B4394@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hmt6v1EmBtsADHiqsgD55Z8rDX1cB2wcn+5FlAf1kHo9sKGmrQ+
 VSE1+QiSIK5Xo1K+oKwXx58smnlLgRhMAi84VJgXpwsqLkj5OfHY5DgmlQ0Qpl378/e93kl
 f+YViaLHUuTtu/1ZHYEVw7n3RqxBYnQPx/at5u6bNLN8z+r2BpQlwyJe3PdHAapKdetS/EJ
 6h7pT0sQaSDcIRwKKwk7Q==
UI-OutboundReport: notjunk:1;M01:P0:uhCCpXx+2mw=;1QQC0oPuM7buIV3zQVUgw5FathZ
 bEj4vUhPZ18+UmGbKR8jFavDND5XL4jEAmj8y8urb3AF7BGd++L1dVXYusOR9ORw55OfszBSf
 fGXp1g6HJnjKMtvXK0V8b0OYXi7Zr6w+X4Y00DbO7g8hRutLoWGxHxXrduTpZ2fSV5Pv7zckT
 U7juQ79FnAWXMZHKYZ+0tBeVzmSIT+igXH6oKr3dmiJP3B2YDHnNId87GbaaA5hYpXI2KJ8ZF
 krPuh2OdOJp9ut5w+Q2saw8EEaflXHQnJ9zWwValoEbcxIKh+K9CTIlN+mit/zFzKd91ZKDXQ
 0Z7gp6fp1hDMIjuGe9VqXlNQoERa7cDOMLVHeIoUBbFFG5iRebZFTJK6hQXNO72P+LKfJSQpQ
 Vs/tmdKsAtWg9ndHSHSO2xF6hjhvgXoJgOkzl1y9HQ6DyCAxWQcolt1tXPigxag5xe0SxPqjm
 kF+feklX4XdiXF6ofqLZioyYuCidHfbNt4MKNSc7jdM1uU9D3zCb8M3/BBw+WgggwF7b21PFL
 fLiGE9P9Ga8wCXaYj4WkLLO10prcdfyh72+J7fb0FM2M+yBZ/A+hx66gBWhgXqwFIUwwpvcLU
 AiDZWm1bTQtZNftcr8JMEEMtC4nwLLCpm63eXO1i5I73MIRJiAAliImw0y505E6stXR3g8+MH
 wIv8AFrvi/lonqb72JQKmXc6UC45qX6cp0BWUdf7x05fllZ1hscRGA1mScpto+MrJ5obiqVS8
 p7ZqyFZZ++2Txi0hxb10+A5EScMau6Lc20AeElk6okP7+fyyxgFw85Ln6abi7GbXFmyFG7f5Z
 WC/lP47T3jjz5+ZRt2/NVTbQ==
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



Am 12=2E Juli 2024 10:24:54 MESZ schrieb Richard Weinberger <richard@nod=
=2Eat>:
>Make sure that tm_mday and tm_mon are within the expected
>range=2E Upper layers such as rtc_calc_weekday() will use
>them as lookup keys for arrays and this can cause out of
>bounds memory accesses=2E

rtc_calc_weekday() might receive invalid input from other sources=2E Shoul=
dn't the function always validate its input before array access?

Having a library function for validating a struct rtc_time would be prefer=
able to repeating ourselves in code=2E

Best regards

Heinrich

>
>Signed-off-by: Richard Weinberger <richard@nod=2Eat>
>---
> fs/fat/fat=2Ec | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/fs/fat/fat=2Ec b/fs/fat/fat=2Ec
>index 2dd9d4e72d=2E=2Ef9096e8932 100644
>--- a/fs/fat/fat=2Ec
>+++ b/fs/fat/fat=2Ec
>@@ -1253,8 +1253,9 @@ out:
>  */
> static void __maybe_unused fat2rtc(u16 date, u16 time, struct rtc_time *=
tm)
> {
>-	tm->tm_mday =3D date & 0x1f;
>-	tm->tm_mon =3D (date & 0x1e0) >> 5;
>+	tm->tm_mday =3D max(1, date & 0x1f);
>+	tm->tm_mon =3D clamp((date & 0x1e0) >> 5, 1, 12);
>+
> 	tm->tm_year =3D (date >> 9) + 1980;
>=20
> 	tm->tm_sec =3D (time & 0x1f) << 1;
