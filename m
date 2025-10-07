Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03243CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 23:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A958397A;
	Wed,  8 Oct 2025 01:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OJNTz5Ne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE7583981; Wed,  8 Oct 2025 01:49:12 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C66228394E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 01:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7b4f7a856acso2345803a34.3
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759880949; x=1760485749; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xu0EZFMeqT+HvI6ILaWjGU+WN7lFBQguhUSiVApR1Xg=;
 b=OJNTz5NeQpHm18L+Oc1bfxiNxhYkn7WGnrW1ZhCR0gN/Ezt0yIIECnbwCR5sbdSfWP
 z76Ne7kqxdegXRWFDXSJmfrKLcdv+nsPsM5cFhuEFLBg0X+vKEBPE0drT+sH98Ajw7Uv
 DHOG0vj3yi9nEzwkQaIegl3AnftCsjADIJYgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759880949; x=1760485749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xu0EZFMeqT+HvI6ILaWjGU+WN7lFBQguhUSiVApR1Xg=;
 b=H2bLSjyycounaM5vUfy5+YUJhN8zklA0UNqq8KyRgYGvOWKxoViAtSNlPS/Qczx9zd
 XtjUxG6hkjZufON4TSKfGDrcQIDcdRUbcYAV4Fn3ytMtp+SjHpMjKp4VjQzU6p51OE5y
 +e4SfRt26CrKzOl70bfHZhdAWnkUKtjVn0nnCyh/vqtqOREJJLnOeHNiX5P+S8zkdZ1p
 VtsCF7QhzLWY9KHKrDkpbRPaQAfv4iw2fJbnVelR19KdNhwO7v6MmfJ5+rntJFUs2GOV
 ZoOKiJHMU97dVUSWdPzfwlPTAkJjKVniWiXOnTVP/SlP5WOoAny/2UP/QR5yV+AW/afU
 Q4ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiD/7BUncxbrrjAbkodhde7zw/EF1rgQB+Y7dw6BdIzXcYdhneO5j+DxJMwzUhsBhN4M01FT8=@lists.denx.de
X-Gm-Message-State: AOJu0YwJNc6dWOz+zRpUbBJKCrNcHfFssNHBnoM4qe803BLVUx0I9daH
 T3UUvRakhHiQRr3LyHICJwZSDQt1xYiR3HZDe/oJYbk9MbF57jk/7PJ4pI2K2doFm+Y=
X-Gm-Gg: ASbGncuyaIexMtNrUyy7XVLR+ZYZuP8Z/KIwfMHa3QR6PZUz1xVtQep9xSKxOIkUPZQ
 4ZSN3FkGoR8DP5fSYXkSqHpSqISi/q5sD+lrks4hY4QFwhU+Qre4WLsqRtiqwYjeB1PJCl88qwz
 TMW5g5FdrrgYCtPRFKXSArrIIE9hlBKjImzY8H+3IP1cIiOstcrFjkAXe7cdob0/Uiv5+5QaV0G
 EEq5+eokTX5Zn9uaiHnq8HdwB5RaiuaDXkORrlxZovA/41A6+FxjNP2ZXn0fTSWFOmpQ/jCIBor
 zF6yEkPh7OhjBpehdo1GvxKAVht0ovbSaXlVoQOOrR77sTIBNw1Zls5HvNFwHNlH1Pyzyozz9/t
 H1P+hIU5U6w7V5j8HDHybT/ikuIVe9bm4I5tJipd4yB3kCieGWee75aIFjBYvU6danylHDHY6M/
 gBCoysb+/NPQ==
X-Google-Smtp-Source: AGHT+IGA1C4lyo3Zai3u30S1/skYNWYYAPPDwbTtWUvBtlbOthY2DlJ781XU2WuSzmKumCkWssN3/g==
X-Received: by 2002:a05:6830:82e5:b0:758:71cd:895a with SMTP id
 46e09a7af769-7c0df813c44mr976979a34.29.1759880949500; 
 Tue, 07 Oct 2025 16:49:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf89b23009sm3246471a34.20.2025.10.07.16.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 16:49:08 -0700 (PDT)
Date: Tue, 7 Oct 2025 17:49:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Benjamin Hahn <B.Hahn@phytec.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v3] bootstd: make it possible to use tftp for netboot
 with standardboot
Message-ID: <20251007234906.GA577000@bill-the-cat>
References: <20250924-ip_dyn_bootstd-v3-1-f67864b81a79@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h+yv5F/GteIPjzzJ"
Content-Disposition: inline
In-Reply-To: <20250924-ip_dyn_bootstd-v3-1-f67864b81a79@phytec.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--h+yv5F/GteIPjzzJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 09:41:41AM +0200, Benjamin Hahn wrote:

> Add the option to load the bootscript with the tftp command (static IP)
> instead of the dhcp command (dynamic IP). For this a new function
> tftpb_run similar to dhcp_run, is needed. The selection of which command
> to use can be done with the ip_dyn environment variable, which can be
> set to yes or no. The ip_dyn variable was chosen as it is already in use
> on the imx platforms.
> Also edit the bootstd doc.
>=20
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

OK, so this fails to build on qemu_arm64_lwip (and a few other lwip
targets) because tftpb_run was defined just for the legacy stack and not
lwIP too. But, and this is a question for Jerome too, why isn't dhcp_run
already in the common network file and instead written again in
net/lwip/dhcp.c? And for both of you, can we perhaps have a common
function or functions? The lwIP one does handle tftp it looks like.
Thanks!

--=20
Tom

--h+yv5F/GteIPjzzJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOWm7wAKCRAr4qD1Cr/k
CuKjAP9v7zkSZ7q7zpp8SlH57x8wn8XqY2Fs3r60x65iNLTTGQEAovuD08WxYtQ3
blqIypNhkNYI4GptUjFeaJTnOlOnTAg=
=ycJ3
-----END PGP SIGNATURE-----

--h+yv5F/GteIPjzzJ--
