Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4C9E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 12:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713EC89555;
	Sun,  8 Dec 2024 13:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CWWC+Q4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D7489525; Sun,  8 Dec 2024 13:00:28 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C2389183
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 13:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733659219; x=1734264019; i=xypron.glpk@gmx.de;
 bh=kTRjBa2PLN3QD4asyaJ0z7j7x0x8Cp0MalM1IShafbw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CWWC+Q4DCSBCEUYDjxAGDgIXmrHwKuPLdyqay7qxvena5DX+PJJ08s2UBW8aT9cy
 bKrOFF58qRchGr5MXPJwQbKnpA4vpODuLZUnlKadxdEiVKDVPzzEJCUTvW8d5YuWz
 KC9QmzuNoJtmuWfyVLKYlm5f8Ht0mIOb7jXyKEbradUzR5jMFLb87c9j9BI7pYqC2
 DB4pmUBWJuUBz6lDUQxI4D+NxGfnTw/6CeYJP+hy/yi/939cQ5jc2kOfmi9GmaShF
 +t77amd26zpTtnG9a7gYm9HNp9O6Yu73+pI2yAPEp7Zd+m7v/U/EFbpCd4gVhh/g1
 J1vyI8X+dTbuDju4iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1tVYVN2Vul-004BtR; Sun, 08
 Dec 2024 13:00:18 +0100
Date: Sun, 08 Dec 2024 13:00:14 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
CC: =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Nam Cao <namcao@linutronix.de>, 
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [RFC PATCH 7/7] lmb: Rename _lmb_alloc_addr_flags()
User-Agent: Thunderbird for Android
In-Reply-To: <20241208105223.2821049-8-ilias.apalodimas@linaro.org>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-8-ilias.apalodimas@linaro.org>
Message-ID: <14396C54-AE97-4D24-878E-16E73E9F0CA8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5JZ2YwBILuKJIiqmCjQepW6VgmfuMV6m1KhUS/STNu5Wr/Lzijf
 EunTvUDAWdfdQMEB3qXnmR0MZxTRqWp3yQqB10GGHXyhdPm1RNL6sILb/Rg9Fdut5/mjF97
 UzH1UHmyhghn85cS9PnWPL2GtZ+v6YJa1QOWUyMxTJv7MgrsQSS6XBjqUOw2YewqJ/10xKO
 WOxAAJTLh4Z0w9Bd25Rqg==
UI-OutboundReport: notjunk:1;M01:P0:BEzirVGfelk=;EuYDnDqXDRNVm1DOCQFUToWxg1W
 jDayFZSsTmpyWFzB7I1IaT82B8xKo1a9A2zh6rOklhdIyMqFDHwjMpGe+crZVXzwlaN/WuGId
 Cj8S1X8gOUQphJrqMUM6xbYFBBqRCaxwlUOQJhyPlNRKMOpuuxo5KWAjHOkVya/a7Ku36zcQ6
 yR6ze3RGDjrG+fyXuW+LyEtkVj9BQoGm/efonTnjaQSc+ERjWvm3urcmfpBAwIR2tDdO2cKOL
 PEIAssJy+OS+jR/UcwiLrIsqDMULV+kEMSlvotwQNYDDs0UsKKTlDcOu0WZimF/KrF5yjWEJX
 T4wD/pxGKrwMHbcc6SDOxuBydMUXtV1TULzOjQOVH0LKa+4s6jU/bAEGJIOO7/lGRbibD8Zep
 TszadBt8HM1vEy6ZrhglF4AjgKdTtU5A4algCSxk9u0V8HPLsgiVhJ8hpwuyxUp4hd9f4TeDi
 SXg/A1MnZkUJdcIOJ+bnMuYQbpOXqbulej15KL7AWwZUNDWJBfI8r2/GaXn8apv+KFYycyNsG
 Mk6LUfzREro3hyBGcmuJH4jY05Q2iaAwVPPatGabmTPGivMpAEOOs4TLSieJBya7s2A93NSOJ
 gvg3UIEsa67pG5H1imYygsMwtGs0p9+tI9ZoBiQ4t1C0izu6qeR2Lo31InZdvZRfXdCpRWnrv
 8oJDH9h3XrAdhjlNRUi4SpqJ61TyTh/iiqO7sAY00S4DpQYjBEbXn8B6y/47JdOM9l8oziUyQ
 jINbO2NnU5NpgAsVOd6pBN7brlbfns49locjXvkuwcheP5Pm5b1nojbsQ0AuXGZ80O+3xqyqB
 5m/gWOIl7HSxeeT3/mdEkdLjcK9nsQCX8VgZ/rcjGzuQK1DpyUbYI1vBFua+ClZLPoQaI2/wS
 PV2fL+3DmR7nSl2kLEjZydtdGeX4dPlThz8UV5KpSmfJuyMWlJkccNSZsdEfbR9eIvBsLtBmh
 9ei061DQLBW7So87M2Knp1EIbC0RxY9w/x2FzQ8ZwpnNt8EhbkAjhPImJJYpF7m8zyh4B9P68
 ncFCxNMPPkYi3JdHu3YZ4ydEEfEfN/OQ0DpLiValntxI6aK+nU/ZUWM9MneykCUECalbZU+/O
 CDd+6/L3b6v3NRm0O05fvzAQWZIJQc
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

Am 8=2E Dezember 2024 11:52:10 MEZ schrieb Ilias Apalodimas <ilias=2Eapalod=
imas@linaro=2Eorg>:
>After all the cleanups of the previous patches there's not point anymore
>to define lmb_alloc_addr_flags() and _lmb_alloc_addr_flags()=2E
>
>Fix the incocistency of the flags type, which one function was
>definining as uintn and the other as an enum lmb_flags and rename
>_lmb_alloc_addr_flags() to lmb_alloc_addr_flags()
>
>Signed-off-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>---
> include/lmb=2Eh |  2 +-
> lib/lmb=2Ec     | 34 ++++++++++++++--------------------
> 2 files changed, 15 insertions(+), 21 deletions(-)
>
>diff --git a/include/lmb=2Eh b/include/lmb=2Eh
>index a35a69d69f77=2E=2E4f3c861b15a6 100644
>--- a/include/lmb=2Eh
>+++ b/include/lmb=2Eh
>@@ -111,7 +111,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ul=
ong align,
>  * Return: base address on success, 0 on error
>  */
> phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
>-				 uint flags);
>+				 enum lmb_flags flags);

This change implies that flags IS NOT a bitfield=2E Flags may only hold a =
SINGLE value from the enum=2E

This looks wrong looking at the definition of the constants via BIT()=2E

Defining the constants of a bitfield in an enum was wrong (or at best misl=
eading) from the beginning=2E

Best regards

Heinrich

>=20
> /**
>  * lmb_is_reserved_flags() - test if address is in reserved region with =
flag bits set
>diff --git a/lib/lmb=2Ec b/lib/lmb=2Ec
>index c09f1a1277ad=2E=2E67bde60b74be 100644
>--- a/lib/lmb=2Ec
>+++ b/lib/lmb=2Ec
>@@ -777,8 +777,20 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, u=
long align,
> 	return alloc;
> }
>=20
>-static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
>-				    enum lmb_flags flags)
>+/**
>+ * lmb_alloc_addr_flags() - Allocate specified memory address with speci=
fied attributes
>+ * @base: Base Address requested
>+ * @size: Size of the region requested
>+ * @flags: Memory region attributes to be set
>+ *
>+ * Allocate a region of memory with the attributes specified through the
>+ * parameter=2E The base parameter is used to specify the base address
>+ * of the requested region=2E
>+ *
>+ * Return: base address on success, 0 on error
>+ */
>+phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
>+				 enum lmb_flags flags)
> {
> 	long rgn;
> 	struct lmb_region *lmb_memory =3D lmb=2Eavailable_mem=2Edata;
>@@ -802,24 +814,6 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base,=
 phys_size_t size,
> 	return 0;
> }
>=20
>-/**
>- * lmb_alloc_addr_flags() - Allocate specified memory address with speci=
fied attributes
>- * @base: Base Address requested
>- * @size: Size of the region requested
>- * @flags: Memory region attributes to be set
>- *
>- * Allocate a region of memory with the attributes specified through the
>- * parameter=2E The base parameter is used to specify the base address
>- * of the requested region=2E
>- *
>- * Return: base address on success, 0 on error
>- */
>-phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
>-				 uint flags)
>-{
>-	return _lmb_alloc_addr(base, size, flags);
>-}
>-
> /* Return number of bytes from a given address that are free */
> phys_size_t lmb_get_free_size(phys_addr_t addr)
> {

