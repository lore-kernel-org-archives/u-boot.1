Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67A910F3DEC
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 16:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF43C8394E;
	Sat, 28 Mar 2026 17:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o584V+cI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3E1883C5E; Sat, 28 Mar 2026 17:39:30 +0100 (CET)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A53E83642
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 17:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-12a71ade78cso3622537c88.0
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 09:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774715967; cv=none;
 d=google.com; s=arc-20240605;
 b=IO9DUMwrpGVp6OqS3hx8Krcw7RRZHznbrWbhTXeJRo5NrOX/YvMVC4e9PwlqOrTrGB
 ZrLdBikOgGiyzcUNr4/zqCaqkIOxv3PTGlytd2pxSW8isoUskyMh6Wb/lmVjymq58Ub4
 uq2Ptc6pdMJWTSeEXKweO/7+61A1YWseYT7JAU8vM0dSLCXsgfUlhKLDfCF7bjI1pBjZ
 tOg0XsHM5P8n0XPCdOXlyhccSVpzHGniH1e8IPIDZmlNmc6+xC0xGLb/AlSD080C0M0f
 fXhkZq3aeuwJ41OMjJU27m8vxwL4vBj7MEL08dnSyiIxhtD9GPGH9XilnBq4tA0YcQNx
 vhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IUNMjnFINi/uBulrbeyylVxjH0b2fxcmcMz7/plSFPA=;
 fh=omrPosZ6QQxGZKpBczaGuNF/XJfZEqAGlxphZHmf85g=;
 b=By/dt4f+VjY2ngY3E8yfvZp7gfhlojh+PRUhtwL5l1vsHtyxnPGxtvn4Z/6+AxE2g7
 OA4jbIJYdSfht86d0crgOdx57oF5bME3PmBa+eZrRIvpBDFix9JC+kAZMpBM0ZmUcJBn
 7pBwdS0cXgVya8luCxXIdcsSBF5YYcOwBJkJncp+zS7p0tnhtawQVEcQ7D1srH784sQC
 FJw0thsMvpHJzNu0+YWpAEyzs2fGURCQOtb9MWuOIBv5KXMUQcjUyj2LWjmLUCXZ7XSi
 nqyziVxo2UiNMJG9im8+ur4Nbw8nidfF5dE+7aa6wlILfiK7WpiqvFDjzLEGSupC5WA1
 zhww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774715967; x=1775320767; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUNMjnFINi/uBulrbeyylVxjH0b2fxcmcMz7/plSFPA=;
 b=o584V+cIyZbnv21MO03jsQOWjwekZSV6tVwkHMPZGFCzg5TjpcSzCdb4b8bHq6vqsr
 vYNfkWHsnzLTwvjFcB3qxtyL/JFfvY2V0L0FboG66DscJyDXi5AXQMLuozMQoXj7PdQ8
 R2b72v859FGE/YIjwI2E62tmkchp+N3bbIgVZrJJ1oE1aOg5lDRXOq18Bd/6VYh66VtA
 ucyaZI9u+OkSNXomfdrcRAe+VgKdXzgGs9cNHvFJL0jubzomvf7O7fFQMvF9SUQkm59N
 3OSN3fRkuKAQhXGUgLydAJkH/hMcK9N7ey6+q2HDO/qX1RnLC+NxMUuQ3OBQI32rKJf9
 /35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774715967; x=1775320767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IUNMjnFINi/uBulrbeyylVxjH0b2fxcmcMz7/plSFPA=;
 b=NvWYmCYl6cH7t2LPDo8tCWXkd9ps6xGXBepTZjtqtBm06zu2ddLaymzOYIHib51O9v
 XrGGD4jFsM/oAqCgHwI8cGfkn+RZQsMR85I40EgyrwfaguBjecQSSxBQkGh1t9ZGkZlL
 55YN3aW+Kv2rzGAQlxOizjPgktGGk0NoKYL5/6mKDa5A56bn+1Zhovnpz3JP47VnDEzP
 tk7Yk13T+7z0iEpXl2wRVLVxm7tqUAryYra8aRngJsoYgm+gaC/iR7Y0rbXQMQefrtGP
 d7GmwzMFJhEZ/+ULupfj8lETGZsK5Ihp1yPJYrxsSyvb0H4zpx3iuN0meFYFZqS5Julp
 NO0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbkCOug+UElMTPS6bLCWb3CW9l9LXgwHjiwbZ9eKCGJfWK1itVPuepfpMqmkqB98lAPk59qwU=@lists.denx.de
X-Gm-Message-State: AOJu0YxoBwJXK6Pie41m8k+bdRM4GOcOzcyTsfY4cgohMGX9PN5vO1uG
 a4qP/PUJ8swHlyhlZzy22FvA2G+Jm8byMvxlXe+61zIl8+Nfombk7xRNxZaqhJG7HQtNGt/LDmA
 H3YcFc7wd6YtT/DWmmKtgj8FgGVwKmHI=
X-Gm-Gg: ATEYQzzedBEHbdhYBjmRDMneSorcrZqya9ol7FapVJRUwu/FtoH5v6Xr2FRyb/DpgdA
 E0zPw7LioVs5zU3IrXzv+8AFUxed48lkFyG3RAq+NvNLpWLvBvXMT2BnW3wE9C2nfzoqlEnzKts
 J+dGBwNDuMGsRrwF6aD4rvB1mcIX/j3AsjxmXZX31TNDZIxFs2cViU0foXcKuNpes3MmilU+DUv
 ILjfookK3/LcJidMY+jMgGB+YRMzrsDHKoi3fRfoN1rpaR4v9IootRmBroq4gNaeW4DUWFz8IJz
 4PIu2LG5Xrp97hEi4Lhs6YYwuWTt90MDwBWUMDKXucSc+lOb4ENvS+9B33kuqqCMtKZFx1WYgIw
 fn6tbiiV0CXPBwQ9rvTxeWFru7Y8=
X-Received: by 2002:a05:7022:ea25:b0:127:366f:8bb7 with SMTP id
 a92af1059eb24-12ab28dc2bbmr3621260c88.25.1774715966690; Sat, 28 Mar 2026
 09:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260317223800.776581-3-rs@ti.com>
 <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com> <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
 <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan> <aceOvTK4JGQvET11@kehys.lan>
In-Reply-To: <aceOvTK4JGQvET11@kehys.lan>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Sat, 28 Mar 2026 11:39:00 -0500
X-Gm-Features: AQROBzAU4HXUON9vPRB7NSlX1DypY_ZxYMEsnDn3-NrTvAm94ELx930cPTG0YK8
Message-ID: <CAOCHtYhN42myMkq9zTUM2ETMP6oBA4mBAzPsYcOqVRG=ZskgfQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
To: =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@iki.fi>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>, 
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com, trini@konsulko.com,
 afd@ti.com, u-boot@lists.denx.de
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

On Sat, Mar 28, 2026 at 3:18=E2=80=AFAM Marko M=C3=A4kel=C3=A4 <marko.makel=
a@iki.fi> wrote:
>
> Hi Robert,
>
> Fri, Mar 27, 2026 at 09:15:35PM +0200, Marko M=C3=A4kel=C3=A4 wrote:
> [snip]
> >Can you help me enable the USB serial console, first for u-boot and
> >subsequently for the Linux console?
>
> I just found your reply on this topic:
> https://forum.beagleboard.org/t/pocketbeagle2-with-techlab-cape-usb-to-se=
rial/42940
>
> So, I must wire a 3.3V UART to a JST SH 1.0 mm 3 Pin connector and plug
> it in on the opposite side of the USB-C connector.

Side note, here's my ci builder for u-boot.. :
https://github.com/beagleboard/u-boot-pocketbeagle2

For debug, if you have access to them, grab the Raspberry PI debug
cable: https://www.digikey.com/en/products/detail/raspberry-pi/SC0889/17877=
576
 and they are available globally..

The JST will plug right in..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
