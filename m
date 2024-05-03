Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3591CC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD72F88416;
	Sat,  4 May 2024 00:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JskG6/hc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69188826D; Sat,  4 May 2024 00:21:34 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEACC884B8
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6a0b4622ea0so860466d6.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774890; x=1715379690; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=itQ3cHT+Vt089mZKo2caN/Ao32d+ZPkg7zG22tflmBY=;
 b=JskG6/hcvhKKq40rtpss+V9uSRpgPwmBsAdRiE0gWJ7aqxQ6rC6JzX/dZkfJAiWYJF
 hxjeyiZB0mw3LJtPWxs+8Fi2ZhNwpF61jxNcAXRvlWFVltEFTQV2Y0dgQ6KMImAmGfHY
 MAB+PbfQAUFOLtCw9aJzD57kXdzrx8hHt//oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774890; x=1715379690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itQ3cHT+Vt089mZKo2caN/Ao32d+ZPkg7zG22tflmBY=;
 b=j5Muz09100swWm2CyQaSD84CUqdGFMvqwH6nIau7khwZwqWp8QokO1R7oB0fEZmWFY
 LX9zkNng4fnvHBBAIlQuKeMIe2NQqI7tTHi8xJZa0N0JATCq5dEGkNTiIwuoG2kBUs95
 ONoItl3NSHUVXh2T6PUR3o8O6kumJl+vSmbt2BtPiYEN4BZH2k+e9Mor1GtymDGs0lCq
 PittPbReASHgfkYMk8ax4Asi69+btnD4zN1rCPKllUvwl6z2hDKtgXjwh/6oN8z6L7ho
 jiMstWWrZs5Kh7RmeuFRsFQRzGGBOxgVKgYRzIbeujAnJm8XJzEkhUrhrKqDHHUFEp1H
 c//w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMY/+rH7VzIXcce/rtuGb2R2NU1w9ZkCA/ynbCLcyx2m7z78tH6x4e5IG5dnxzVN3H7GED/EOKbF5Ih/C6Jmj57uPo3w==
X-Gm-Message-State: AOJu0Yw3QJ7b/6mACjj/3MO5UrSB0sCWZ8iqvabNeSViJA2+LXnlEwla
 uPrq4F28+FbKYE33V9sShsPZ/7+SfI8yzTnA0b5TqeT+csQWX6cGuS0xkL++OkjF3pEubbaVAgi
 Js+4=
X-Google-Smtp-Source: AGHT+IFR24DR4AKTRE+R4gWQG/Xj7xnHDTrFpZXCH0wpGhsuUl15wCJoITE0kG8g6QcA45yYjmMiFA==
X-Received: by 2002:a05:6214:1cce:b0:6a0:6bf1:446f with SMTP id
 g14-20020a0562141cce00b006a06bf1446fmr4555689qvd.48.1714774889857; 
 Fri, 03 May 2024 15:21:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a0cfcc4000000b006a0fa7bc030sm1553422qvq.25.2024.05.03.15.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:21:29 -0700 (PDT)
Date: Fri, 3 May 2024 16:21:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: YSCHU@nuvoton.com, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/3] configs: arbel: increase u-boot mapping size
Message-ID: <20240503222126.GH2568172@bill-the-cat>
References: <20240423072210.1926141-1-JJLIU0@nuvoton.com>
 <20240423072210.1926141-3-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jBpgyPSapGECitI4"
Content-Disposition: inline
In-Reply-To: <20240423072210.1926141-3-JJLIU0@nuvoton.com>
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


--jBpgyPSapGECitI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 03:22:09PM +0800, Jim Liu wrote:

> When u-boot enable CONFIG_SYS_BOOT_RAMDISK_HIGH, rootfs image relocated
> from FIU address space to memory address before jump to kernel.
>=20
> Since Arbel reserved memory from 0x00000000 to 0x06200000 for tip image,
> and rootfs image may too large that cannot found a suitable location
> before 128MB(0x8000000), so increase mapping size from 128MB to 192MB.
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Applied to u-boot/master, thanks!

--=20
Tom

--jBpgyPSapGECitI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Y2YACgkQFHw5/5Y0
tyw36Av/cl3jmSZ9nDTizNfiu+iZpFdTwTg58rpoR9OS9XsQnNfWDjikhSfifbLx
DWnuP3bn63SpFIDnaopcJzC55JnnYKcOapGcI8FngIxEhguE+34t3euHyHhZ870K
xzeI71M6n+Z1Pkqtff09FwkJFuimfKMkyHT53AjuSgnVPwP9o8Tyoq1d42wU4VMM
rogGToJrjyLOy/tsRVoSX3ieDYTqFuTk2kOte30wh/YVN3uctO0HIn75fsoo1fPg
vk2rYyTFoGk9DzDLj4VR9dtHjuJS2mPo6l2xBUkmOO8NgBpROG1lwF6D7lFFJSBN
CZqiSsAvrYT8sD6Y+N5s/5mkbClaS2uMZjAyZvXDi1G29VUe7FvyUUBB76xuxkcX
MXbIs4uXCHW/muXxPQ2SnkSm5IP0bVLZwTBbPVbpZo8x2F7i3J9x3xaoEqkd/564
hq/x01jT+/yVyUqoHIR84JSf8J26pqcGyVVXtcPFqfTKTprRqm00K0AEsEzsuj8C
gsbXq+3H
=BCpo
-----END PGP SIGNATURE-----

--jBpgyPSapGECitI4--
