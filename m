Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151D7EB270B
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 19:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482EB83A47;
	Tue, 10 Feb 2026 20:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YekULnhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6964F83D0B; Tue, 10 Feb 2026 20:58:22 +0100 (CET)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD898388D
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 20:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-1270adc5121so1534817c88.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 11:58:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770753498; cv=none;
 d=google.com; s=arc-20240605;
 b=kgrU6KFTQd5332I/aIXPrTtzzV1ua4yuu7xb2oqnCmxIHiHWQpdSQjvJDovPE3XFnw
 oJsYbB8SGJJfa39l1vyOvfCCdY5LyI4H27yAeE+ahEM/X6q3XVEQq2CosJUzZ7BVnSmq
 ITmLhcpcaaqATuQLvvEqXcVlTKq1aLwX9kOP0y3I1LBJ1RQkWGBXTnl4+4XgKihOOYuu
 hnsiRbzSqq2FrYcvFnrWP54u1fpMjVhOPHUuGDQ0SHEiLj9+4b9sbZPQJ0Nya6FuD/Ii
 PVCE0Gp8Xa445Xf80EBeBTQa9gmYsQt+lvLozbfv2w/5SHnx/ufbudUYziohy9F+9U3/
 Gdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xbFWs9uz4joHvZ1vEqGl0gz2wbYwSVklpClZZ0jfqj4=;
 fh=/B5fBfg2sMhFhoINgGDU0QzG6tK6U+rcMA763j+i8Jk=;
 b=VLHsBv3iFNBKDEGSwTXfRAY6mc8MXRWTP6qN6ci7Yy+XuUZ0+TorYG1UDP1/A8ocez
 MLQiyD5nqvNRNUWpYurDKhH6f+kn89UF+9Zg5+TSR3INxZu/QVUc0owrIA+Gt/CNf8BV
 97JULyJGRedsK0A0aMBAbBd872JlAi9IJW0io93DLtNHL4S0aPz/x+DbAkIij0cUI91O
 BuVZZ+wcbKth5rLu8v4LX/nHyg8hKL3gzrFqxD00Rw1JyAA2j8pkynM02TnJzwMUPVC9
 kdkCqjSPG5oV8LQh9jIpWE5vZwxsf0gyAqtzbZqAJHCZRdbv1LKND81X63jK0OdkM76g
 MrTg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770753498; x=1771358298; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbFWs9uz4joHvZ1vEqGl0gz2wbYwSVklpClZZ0jfqj4=;
 b=YekULnhZNU14FaSjY3qCnNPMKjSNHSsiuHhEpoqovZXCY7CQW9FRWql38a4G59xgAX
 sZTyv+7nJGx5fXYa88mLDpF0HJP8hPSwoKlLQu9J+a7nDFqJFUAOGAiMVKahT4AAZ14D
 HBJ0ROnFGvkhms9cEOvlhfUBxbw9p2gMWvS2U2hWIqcUiznVu4ex8xKqWQJOehkrs3xY
 j/eDoZFFf5pef39K2yPVHUq6sVBBPDglSa9jgDZDbwdyp0d1+hNpgsWFCAsM6ESOW/mp
 M2Pqmyep13Gr+b71GVpGodENWB0e/2nyclZbIbGTfq1sfCYKEH720L3z5L/0c2zE0INp
 +G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770753498; x=1771358298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xbFWs9uz4joHvZ1vEqGl0gz2wbYwSVklpClZZ0jfqj4=;
 b=aPMBFe+nLjQX75Da9MtlocXPmU027Wxj6qKZADipi80Bqq/mGU1Lyp6CGPzUO1YkES
 EwVce31djksGJ0mPjGGD/ypbrfXKJv6sCb++aHs0aU7eocaZPiPQCyPY6NfPQ411tMnA
 wySAkjUH8in9lbSpkMEdm+1sGZ0ETFC9hkyd0ZWHwHDw/ZDD4gMxFzkj7MVwZEx0G6Bi
 TA0F/qyL6yl3LR9m/6V3uUFiU0ijz6anD/Y3w8198/awPXYFLn/zXba2Xuj+aIi2tzRK
 VL9MI8ga6nt7gmlFaaNdQdOB9NtJjxsJCADkR3ssJ05IEKAqEUtDHnAI2U1ihtnA0NOT
 QYaQ==
X-Gm-Message-State: AOJu0YwT1GcJ1PQx5aweQ2/8boCpctQLSYHOvOQeu4ofY8Vw7i3fVRuf
 bF6dc8ay0heeNS93iZM9Y3IM+DhrrW7sWoDMxKQIJK1HsbAdLipUvLa8YI5kbHMq7iDuVLy1HZi
 fjs6dqdXxH4Ve9eE0s25gTZVKakPsSg==
X-Gm-Gg: AZuq6aIPqa23c2mcZc88Pa0BueVpopfjns7iLAjSuvy/O5YQVLj8UW6AVTINu4v0Pnk
 Iq6g7fWss79jRbY+HHdopj8ymUCwkjZfd6qaUl5A/KXjfUHE4wbBbMDIWIp9yIeF4/PTz6UrdfH
 maCBg7zGGRjUpRrZjr50u6h1wFsGHLTtWCTmMCjj/Bi5kpnXCdLlsNlaGdvcs+dLffNu6vVix+z
 ZXVByqwxbLn8eoQ+L8m2xjv/iRb9kMmpsbUdrfExbYYmbrvDmo4sRdQOGvo7LPcGL6Xqji967G8
 nffPeaDm5BYoDzbT+kAP0+FVG+dPlfyDj1HmLu4=
X-Received: by 2002:a05:7022:221a:b0:119:e56b:98a0 with SMTP id
 a92af1059eb24-12703fce95fmr5657886c88.7.1770753498190; Tue, 10 Feb 2026
 11:58:18 -0800 (PST)
MIME-Version: 1.0
References: <CAA=Y9tY1pJV5O=23YSgM-1TnRQNpg9zrPJsSn6YaL_uAPxUo=A@mail.gmail.com>
In-Reply-To: <CAA=Y9tY1pJV5O=23YSgM-1TnRQNpg9zrPJsSn6YaL_uAPxUo=A@mail.gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Tue, 10 Feb 2026 14:58:05 -0500
X-Gm-Features: AZwV_Qg2VJbV_ebz8xpR6_2xwEmGPV_ZD6g5L7YQES2EadU-ZOp8Fksz_Jvj4xI
Message-ID: <CABdDSeX1Kx-+N_dPptXmAJJ40mDX37H7DsmySrGORoc=JYod6g@mail.gmail.com>
Subject: Re: [PATCH v2] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
To: Caleb Ethridge <jcethrid@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "caleb.ethridge@analog.com" <caleb.ethridge@analog.com>,
 "linux@analog.com" <linux@analog.com>, 
 Philip Molloy <philip@philipmolloy.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Caleb,

On Mon, Feb 9, 2026 at 10:04=E2=80=AFAM Caleb Ethridge <jcethrid@gmail.com>=
 wrote:
>
> From: Caleb Ethridge <caleb.ethridge@analog.com>
> Date: Mon, 9 Feb 2026 10:00:10 -0500
> Subject: [PATCH v2] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
>
> Updates the polarities for the GPIOs on the sc594
> EZKIT carrier board for the newest revision, Rev D.
> The new carrier board revision has different polarities
> for some GPIOs. This patch updates the sc594 entries
> to match the sc598 entries that were updated in a previous
> commit, as both SOMs can utilize the EZKIT.
>
> Note that these updates are for the EZKIT carrier
> board used by both sc598 and sc594 SOMs, not the SOMs themselves.
>
> Fixes: be79378 ("board: adi: Add support for SC594")
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
> ---
> Changes in v2:
> - Updated commit message with more detail according to reviewer feedback
> ---
>  arch/arm/dts/sc594-som-ezkit.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ez=
kit.dts
> index eeca6d17504..11154e65ed6 100644
> --- a/arch/arm/dts/sc594-som-ezkit.dts
> +++ b/arch/arm/dts/sc594-som-ezkit.dts
> @@ -22,7 +22,7 @@
>
>   eeprom {
>   gpio-hog;
> - gpios =3D <0 GPIO_ACTIVE_HIGH>;
> + gpios =3D <0 GPIO_ACTIVE_LOW>;
>   output-low;
>   line-name =3D "eeprom-en";
>   bootph-pre-ram;
> @@ -30,7 +30,7 @@
>
>   pushbutton {
>   gpio-hog;
> - gpios =3D <1 GPIO_ACTIVE_HIGH>;
> + gpios =3D <1 GPIO_ACTIVE_LOW>;
>   output-low;
>   line-name =3D "pushbutton-en";
>   bootph-pre-ram;
> @@ -70,7 +70,7 @@
>
>   octal {
>   gpio-hog;
> - gpios =3D <8 GPIO_ACTIVE_HIGH>;
> + gpios =3D <8 GPIO_ACTIVE_LOW>;
>   output-low;
>   line-name =3D "octal-spi-cs-en";
>   bootph-pre-ram;
> --
> 2.34.1

Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
