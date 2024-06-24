Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A35C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 04:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC05787D10;
	Mon, 24 Jun 2024 06:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ttejsS+v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F3F87DC7; Mon, 24 Jun 2024 06:36:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B89A87923
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 06:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719203799; x=1719808599; i=xypron.glpk@gmx.de;
 bh=n2hEqrW3s7XiJgEGYb1bF7RXrtHLdNMR0VgTKOcgVVQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ttejsS+vofUQ/aoCCBD1ZwfHbcieWoNjUVXEvjvdT/q1AK9lM/PRBqWVZm7Cenpv
 5jFGlByNLnBBcdjLcEdsGK+UD3kZHhJFreaLO9v0zCuEJStimz5lMd8+XcGQA4I4x
 30W/yZ1lUXAtNgoXEYX6v/riXFlAdEUbItpj/q8OPjsr9nQKNRg9pJc8QBX9wUcZf
 kxWknMldZA9Tmzri1Fpl3JsKwzVvUXpd5cTSjlc4u04KGqu5gIWIwx9EbWTdI9dLO
 JPN8xRd8bR2TjQKChJswAI4lV4vFRn46gkQHf8FCq8/k0Iur/kTt0LehDIDVpckEL
 O/6HKJkS6wLbL+a1xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([213.179.142.81]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH9i-1stZDX2ODM-00oEWD; Mon, 24
 Jun 2024 06:36:39 +0200
Date: Mon, 24 Jun 2024 06:36:38 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 14/14] smbios: Correct error handling when writing tables
User-Agent: K-9 Mail for Android
In-Reply-To: <20240623203033.1566505-15-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-15-sjg@chromium.org>
Message-ID: <8441D4BF-6E80-4518-B52F-2EAF47F05CE1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c3nm2/vteqVelnomvXgfDuf996tZQfj0fGoD1y6tWGyU1IxGWJJ
 ZynKpE61e6+mVyua3cf0zybk4H5CHXmov12mVgpjobrgj12GPpc4oSXN7ti1m2D4gjyyfMh
 zDgB4LcYaxql2znQ8hbNhpuYXn8gsEHmgEQp/W+VKwPC6EFEBrYIQivCngT/9siYmbz6re8
 kd28AwvNBh5gtQnLO7Gcw==
UI-OutboundReport: notjunk:1;M01:P0:khBhj7VUBMQ=;wDRO3eGJRvKre/fl1DP7x5EBtWm
 KwqS8WnT8xE+J4XQwhUYvhHLXuKM1a5j8d4pP1RYDRtqeUf+13Bke4hehl1J6+umeWWkI/CYN
 yxsETcxYmT5ve0NxNDkrLgWecmr6gBliCoZnqbIhlb9j+vcnPcs8hgOKXH6AqZY7rdxvaocu9
 5L+enfVYyDdO7XrWHdSi3oIi7eqmqmNGq0FmvWr8UWfZavL4wzaIDninTrlvFMPcnYEDB1I9o
 hQi7hnAmtjMkxPqcoOA+DJQ+BFnU/G9vuS5b8VrsHLhTWmdALD9tawWdOXYeKszfBoTOf4oQo
 m1GfFgSdUqtpme22X+raiTim4ir5QlnXwYplY3rV4t5yjUEkOy6taKqHtVcMPAaQVncgclmPh
 c7H0zxHk55mOsyYdu38gnay3PW2r9IgQsLLmxezmRgZ52kXXMMx5U8xorf8Si2sXV33m//ElQ
 irFLfHXWeU5ey4kJdoJZE0I7yaojDqKeLrqSlyb2qQxNT9vKhNP1BsPPR0nJRT2krMskItAic
 oMqB7KKNdrDebnfpunzyCel1JykXshVXdUYyRM6zYBu8X9u5wcVZSuOemqpfnPQ38Aef0IiHk
 G6B0gbvf8ePhTN5pa0/qh14L6Wbx7qTnFstLLt2Lz0rlk2iHRHzhj6Lmcp2QZ2c2SPxeFfBsb
 HomGptrqD/eBAe3l0GmB7ZcikjWB9Ewdr6i4j7tbHCcVVCYjqDEaiJo5wFvC4j3KUJIeqaUqa
 g+A2+AUtuwVaDiKWdHDO6WpyZh4RRsHW2062/q2+lkr2cSjHKbqZr2Lr8DYmHUl6idHtCW1Mp
 w6Km7Cwv54xlq4Ek+g+PLnbSdiEl1J3Hbb3+n7lGGJP+s=
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



Am 23=2E Juni 2024 22:30:33 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Since write_smbios_table() returns an address, we cannot use it to
>return and error number=2E Also, failing on sysinfo_detect() breaks

IS_ERR_VALUE() could serve as template for conveying errors in addresses=
=2E



>existing boards, e=2Eg=2E chromebook_link
>
>Correct this by logging and swallowing the error=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>Fixes: a5a57562856 ("lib: smbios: Detect system properties via=2E=2E=2E")
>---
>
>(no changes since v1)
>
> lib/smbios=2Ec | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/lib/smbios=2Ec b/lib/smbios=2Ec
>index fb6eaf1d5ca=2E=2E4126466e34a 100644
>--- a/lib/smbios=2Ec
>+++ b/lib/smbios=2Ec
>@@ -5,6 +5,8 @@
>  * Adapted from coreboot src/arch/x86/smbios=2Ec
>  */
>=20
>+#define LOG_CATEGORY	LOGC_BOARD
>+
> #include <dm=2Eh>
> #include <env=2Eh>
> #include <linux/stringify=2Eh>
>@@ -596,8 +598,12 @@ ulong write_smbios_table(ulong addr)
>=20
> 			parent_node =3D dev_read_subnode(ctx=2Edev, "smbios");
> 			ret =3D sysinfo_detect(ctx=2Edev);
>-			if (ret)
>-				return ret;
>+
>+			/*
>+			 * ignore the error since many boards don't implement
>+			 * this and we can still use the info in the devicetree
>+			 */
>+			ret =3D log_msg_ret("sys", ret);

Can we make this a debug message?
It is nothing an end user should worry about=2E

Best regards

Heinrich

> 		}
> 	} else {
> 		ctx=2Edev =3D NULL;
