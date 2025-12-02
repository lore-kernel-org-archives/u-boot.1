Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC67BD12668
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 18:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F134B83EE3;
	Tue,  2 Dec 2025 19:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1gVPSDTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BE183B4A; Tue,  2 Dec 2025 17:07:40 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DFA083B4A
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 17:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640c1fda178so10650878a12.1
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764691658; x=1765296458;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ibtH1ftJLP1Oi1WjT5Uv5bAvPLTWihdfcoPI+v17c/c=;
 b=1gVPSDTqU126ZRz5PMvgBA/zlQyq+MJlcDgE5qWyZOM/4sGefRRfNe+XUCFnY/J7re
 XMpAcU+7BpAZnR80sTownl25lwi4vn/lajm0VC3lzKvgQfdIjcswxErm5EvJdNe0OXn7
 SoEnDygpqHodAa0Fc3j1abINMT4+LwtNhpfyOtSC0RYkUUXu4pXBUjow5rOWMZenrPVN
 QhEOOUAh/3LKCS9FX19Zhs16bMB0RjLxbkf0emYlaf1FluPhry1HSluwQ2jIs6APMAzd
 0BKPgz++RHyryIAzmzqZrF6Rq5v1A3/yvpXe6V0f8NJhO73nCxHuwq1Kv8TlYtm6v9rr
 vHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764691658; x=1765296458;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibtH1ftJLP1Oi1WjT5Uv5bAvPLTWihdfcoPI+v17c/c=;
 b=DluSPwY+DLWIM2bDm1T/JftznziaVHFSY6TIjCrgFBT2192pCSEFYtwWf7ltD1AfX1
 dddBL5RYrW8gEvPHifWlBmPYPTmpud0Uj2I/8SukxHJlWHKc5+bwBC1ln+P9PCSILwVB
 6ylDML0lMKZL4p5YGkVWjmfwZ9gaq3zfGCVw8l9Mz3DHRH2yG9ZnVPY6EcvfOqxegfMj
 S+aLmIpl9vYG22s1rzylq4FOt1My7giKwQmtPcdCJckwS6w7O8Uu8xV6PXUtBNffI1TW
 7epOs5k5AcxveTMjERVbt11VlqWMIU9V8iS3C6iOBjTHBEB1hriLrTmR4y3mnfQk25aU
 SXGg==
X-Gm-Message-State: AOJu0YxnTKLFJSzZRX40jjnr3zMFbqyrCF0EVyQpO08IX3mnMKrzbQ0Q
 55gSahkWgqg5BV7NIQANiBmvXMsyICpRD1LCcg+sqoKBA1AL2yOtL6EAtbn1CEAfdF1h8ROT6ou
 eEBuoIJw=
X-Gm-Gg: ASbGnctmYKCpb5z+OtHdTzxCm7+ZPIfHBIGnufq75sKbGqstoxYtZBss7fLfaYmI61S
 F8TiwB6qmNDUM1adbYy4d5P150ZoP3IWelgWdxd+Sw2ZLcdh8520MSI4d8MEMsRBaCO/Mic1oHq
 dLUqvASx9YqzqV2Vkwp1QyoZ/HATvgs0+NDzHDtn635X2w0shpu1QzYjHN7dVI2cKHi+W6ks36N
 ViGP1zofQJL1xV1H49EZU2NqQi3wSF8LzRwJSzWpwHkALUBd8IO1hF0MRZifrbp095Eb63pyiPB
 mNXfWcjCc18FlLjb6YFKF9XUbVNGfdB8+lZ7FnEaapG7QJ9nWthmfb7ojwiBWIADkh2OVn4D3jR
 IDw046OJbF3yv12I5IMlMjuxIc3tjex0ViZgV9mM+gsN87SivLwttVIzMvdX6UKpoTkVL84KaDz
 KhS4UW8/4zM5Fco/kVR/eF9yWSRqOoeFevAlFURces0JE=
X-Google-Smtp-Source: AGHT+IHTfuwWc3o+FDnGFK4sRhkuw7a7k4JHBEal6URmE+w5R27vBFbE4ToWPwQdEMd4mllJXWPcqg==
X-Received: by 2002:a05:600c:a09:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4792a4c08a7mr452935e9.34.1764691248939; 
 Tue, 02 Dec 2025 08:00:48 -0800 (PST)
Received: from localhost (ip-185-104-138-127.ptr.icomera.net.
 [185.104.138.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479110b6da9sm321170135e9.0.2025.12.02.08.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 08:00:48 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=20bd4d189434ba5a37169a2032d271cc134fb05a657b6ba6c4f8fb47534e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 02 Dec 2025 17:00:35 +0100
Message-Id: <DENUU1UEFLR3.1JPDQ74SPWIF7@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Marc Murphy" <marc.murphy@sancloud.com>,
 "Rasmus Villemoes" <ravi@prevas.dk>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>
Subject: Re: [PATCH v2 7/7] configs: am335x_evm_defconfig: Switch to
 upstream devicetree
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
 <20251128-topic-am33-evm-oftree-v2026-01-v2-7-42a863304498@baylibre.com>
 <20251201161737.GE303283@bill-the-cat>
In-Reply-To: <20251201161737.GE303283@bill-the-cat>
X-Mailman-Approved-At: Tue, 02 Dec 2025 19:10:35 +0100
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

--20bd4d189434ba5a37169a2032d271cc134fb05a657b6ba6c4f8fb47534e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Dec 1, 2025 at 5:17 PM CET, Tom Rini wrote:
> On Fri, Nov 28, 2025 at 09:46:37PM +0100, Markus Schneider-Pargmann (TI.c=
om) wrote:
>
>> The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
>> required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
>> power domain driver is requierd as well now.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  configs/am335x_evm_defconfig | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> We probably need to, somewhere within this series, change
> configs/am335x_*evm_* to make use of #include because am335x_evm_spiboot
> isn't updated nor any of the hs_evm variants. Also, after this series
> do all of the other am335x based platforms build still? And then are any
> of them trivial conversions to OF_UPSTREAM ?

I tried to keep everything backwards compatible. During development I
tested both configs (OF_UPSTREAM enabled/disabled) with all the patches.
I will try to build for all other variants, but I think all these
changes shouldn't break them.

Thanks, I can update the other evm defconfigs and give a quick look at
the other am335x and if they would require a lot of work.

Best
Markus


--20bd4d189434ba5a37169a2032d271cc134fb05a657b6ba6c4f8fb47534e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaS8NIxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNV
kQD9Gc0xPN582GDqQT7xsJjSFBnMIyBYlW8N2RpL2DapDooA/0zo2/J5+qf6jX5N
PYt9o+2+FjAEQLOj6PLzsSoF7lUL
=Db3a
-----END PGP SIGNATURE-----

--20bd4d189434ba5a37169a2032d271cc134fb05a657b6ba6c4f8fb47534e--
