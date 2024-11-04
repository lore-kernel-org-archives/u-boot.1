Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540ABD1BDF3
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 20:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8978A88E1C;
	Mon,  4 Nov 2024 21:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="e0LYdd0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1123188E50; Mon,  4 Nov 2024 21:46:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27EE688DE6
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 21:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730753173; x=1731357973; i=xypron.glpk@gmx.de;
 bh=PPfmaNj2PyPXel49b8InGGKUiP8b4Ji6XocA4eW7jy8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=e0LYdd0r4f6xeWZ1SlsWfKSj4Motg1j19u7ckFYT86F4aRNLup/ohpxYt9Z7YWup
 ekamSr9rL+W1sHYqwHGQXgf+JNuzQZhWCt5Sr5BXcqzB5NKJdgBWqsSfOX0gJe8Do
 verfmB4r1BklHZoGnT5THxXsGWVXk/fr41wY2elWtsCDvfDgfSlaJSVK2yQVaazw1
 R9AnBp0p/+EcfDYZMdfWqXpu3idM20A3/i7eTPvfuNsHtu0kXjJtPUtLYT7xRBVs+
 pPuQhftyDl7QTmZtUxGf6/wsP5g4HQ0m0jQw1PO8a3JsM9wHVh9E2l7BPHiNcY+JU
 Chd88IwX7kb/NAFn5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.108.63]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1tPjN70qh6-00PTst; Mon, 04
 Nov 2024 21:46:13 +0100
Date: Mon, 04 Nov 2024 21:46:10 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 2/9] test: Adjust print_ut test to use unsigned char
User-Agent: K-9 Mail for Android
In-Reply-To: <20241104133954.840994-3-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-3-sjg@chromium.org>
Message-ID: <F9A7881F-1242-4B52-B48E-F0512264989C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nWoMqEBgXv7gIA312Poye/q76psZBxYyAIAhDgF3+4Nd8zGdtul
 RnFnEFhw5VNBthWTYXqsjqcygabiP9zmgIDsj8UZczaByMu+3WWGgwCwHM7psNtem+PJrcd
 6BPf2Cr2vThvy6s4UeshjmKiTj1j5nwsa3RVTuuN9nD7weUs+G2B2wPHJs+C/URSDXvAFPs
 I4voTQwAAD+MbboFTueWA==
UI-OutboundReport: notjunk:1;M01:P0:YavS/pJnX5o=;YpI9ykoLEvG2q+4NhCqy5XNvnZK
 Gh4ynCcrGFNFPDIw650AQJvZsYoT4h3OuI9rTIJqpmQwWRWqrxsse4GtukhEt2UxrkJIS8Z91
 1cDJqP/OWUxZGvE9wK7jrNsyRcvhyEboEr5Gcm/T+DVRyAL1+nZJyKXdgDBWWF/oeNiG8QRe3
 Oh7RszDgEsCesbLhX24Kn3ecSpCLeZ5iMgGNn64uGnydxy2fjclXwYG0YAc4KxgwIqcT4bCJg
 Ns/CsN+4+GYo2xOtA8ww/v/kqJZmfqWjZ0Z0bj7fLRsFBUUvYSonRmjsFswMtOXPtDC1DCHty
 RRFKnHMZfCGZ6ZmI/InkV3T6/Ic1plUXwAs3uFqiAm2eQTdHbuWI+qJClbroi8AcdHgg5y0QP
 nnvP0ol7tLgJtOizbsP+hBq0E4qFWolXf+tbLbGyiZLG5Ozg6Yu2hMH9qATxIdYL3+B5qNIbU
 SLAYsT1RZUx7+5kfDFzLeyS2NWKto/MKCrpl2HbjOQcw+BgWw1Xc8+MCtwWBxL3JDakFedzIj
 hjIIHfIKtkosEMbN9QxT0he7w0HdIAlgFWHR5JY5tRL9W9qMNhn3+sfgWjV2mBb/8jU9t9ZhL
 KPh151ZonYnx+cCe7OQcMfeNfEoJywfxW035F+3U5e7UuCH9nHCyvJ15XofBQAfZm3hgO7Dbr
 STLizzz+PQk1KSZhv1p55Nq73547dWC9mxauPQXK9fEL7YBfj3PD1f3wNaoJ4p8jECUxpshJA
 ZTXaPj4C6hvNAGYiMVSpzs7u+ffF2zltKVk3lY8WaoNMZImpZ0lWWPFVT9eHtyURYYkw3G/W2
 HIKGF4++NxZUVqD3VLe8ksXg==
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



Am 4=2E November 2024 14:39:46 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Since char is unsigned on arm64, this test currently fails=2E It seems
>better to use unsigned anyway, since 0xff is written into the string at
>the start=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> test/print_ut=2Ec | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/test/print_ut=2Ec b/test/print_ut=2Ec
>index f5e607b21a3=2E=2E7e5c015f3a7 100644
>--- a/test/print_ut=2Ec
>+++ b/test/print_ut=2Ec
>@@ -242,7 +242,7 @@ PRINT_TEST(print_display_buffer, UTF_CONSOLE);
>=20
> static int print_hexdump_line(struct unit_test_state *uts)
> {
>-	char *linebuf;
>+	u8 *linebuf;
> 	u8 *buf;
> 	int i;
>=20
>@@ -255,10 +255,10 @@ static int print_hexdump_line(struct unit_test_stat=
e *uts)
> 	linebuf =3D map_sysmem(0x400, BUF_SIZE);
> 	memset(linebuf, '\xff', BUF_SIZE);
> 	ut_asserteq(-ENOSPC, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 75));
>-	ut_asserteq(-1, linebuf[0]);
>+	ut_asserteq(0xff, linebuf[0]);
> 	ut_asserteq(0x10, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 76));
> 	ut_asserteq(0, linebuf[75]);

Should we add a ut_asserteq_str() here to check all characters?

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>-	ut_asserteq(-1, linebuf[76]);
>+	ut_asserteq(0xff, linebuf[76]);
>=20
> 	unmap_sysmem(buf);
>=20
