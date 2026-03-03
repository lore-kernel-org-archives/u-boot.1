Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1B5EC1459
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 14:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE1F839DF;
	Tue,  3 Mar 2026 15:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HfL7QPNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420E083E7F; Tue,  3 Mar 2026 15:37:28 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7483838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 15:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4beaf25deso5961327a34.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772548644; x=1773153444; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LIGxZ89bJW92kIyFLaw9XU4xrJqsvTIEwxuQ4t+NJak=;
 b=HfL7QPNHtFVvjH/PYMTw9eFWg7appuMWG/TVTvz2VsyMfKBznWYMR+krFN5m9tSXoa
 C6hLn+/wp+3o0N2+5KkrZ/EXbVB9fnn0s1q5rz5FkgnLL534mI+PTFMLLml+yPTnzhda
 G2rVlNcG+MQdeTMW+SUvlgq7UPLKZNzmFRXvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772548644; x=1773153444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LIGxZ89bJW92kIyFLaw9XU4xrJqsvTIEwxuQ4t+NJak=;
 b=YvJSq9B1GN1b8xB9HAaG1Y/qzAI4itSRzeFNxqz6+ygIO9VM7vJOgp4jgoCPbA5mcU
 lvk5U7iNVtKmoUhcb8+CpuoYitn49FbO0WzDt+CMeugDiMZ6pf4Sb/QfaaJu5/rHQlbb
 MqSWsddv4+OzSdljvH2gznuuDNTZOpdumjAF+94RPHDv7C5t9Gv48x1bEWs753uTJS8w
 Zjkqy4bJxjTFGLy0NyBUbtDCXC++xaEVfReTMUup2v4qgIVt7/lndYUZVdT6L5W+O8e5
 Ne7AZ32HF2tRuwls88NFvZGRm/e3N/VBK5DVbmSZsvduMH77Ghe0yVc88QzkAKNvfpF8
 LT9g==
X-Gm-Message-State: AOJu0YwC0iNjUIk9OPmII5WKl5EOp4SezEEnDH6iro66rNaoM0LgpVsg
 Gl3uE8em5Q6GYQke/g9xXDReL4Cpk0cIjt53AltC3LahJOEqtVtjrtPiEQxlgVuhxsA=
X-Gm-Gg: ATEYQzySMeRT+5CMCdYrNkc66dL+ar66OY0SW1H0MUyZy44ZyrHRoNfVST1rBqkKHVD
 gOCuvf+MTK8Ku6ydA8a7LVLgU95PseaIBKP6rVyeeaFrXSj0YhX6Dw0/vwKsFt8WtuQ0KGGHVEM
 Zshps0zzUBNuAC4ZHGZ8bqgdoxsdxvvHyJP0J/26CNN4Cr9Oq7haWp0Q6fw7GhmOTve9KPcipBs
 EAGlpHcVxToQVWohXWH2FdK9Z5dcNPYH6XcrTUMXmGbdVM+2ktFUhNt6pS1aXhG+v5ww60uxvSS
 q5vc5imJV7sImfH+jM7awJxNpDBhUGrUThkagbbFv1EuWfHamztULzK3eWqgC2Da8Pvo6VrZE0V
 ux8YhhARzQforqYC498b66tyrO/fzNdCImOqU6hG2KVMv2NYZyVsbejVKNDf8fOgLyCeRi71YIV
 JNy2qe4qcL+bcszM4t018kfMmLa4cQSA7Q1lBnuEcRdokRW7+mvO0k8NK6YtsnTjKGW0mFf94QX
 e58f8arnEkuaMO0rU9ffFwo3pwBFl3gULaGVLzYh/w2tJURJUI=
X-Received: by 2002:a05:6830:82c3:b0:7c7:1a6:6a09 with SMTP id
 46e09a7af769-7d5be3ef55emr1461167a34.17.1772548644373; 
 Tue, 03 Mar 2026 06:37:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644eeb5sm13407538a34.1.2026.03.03.06.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 06:37:23 -0800 (PST)
Date: Tue, 3 Mar 2026 08:37:21 -0600
From: Tom Rini <trini@konsulko.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
Message-ID: <20260303143721.GM1388590@bill-the-cat>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
 <20260227140756.GP1593142@bill-the-cat>
 <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4gDzieZlX57QBwS8"
Content-Disposition: inline
In-Reply-To: <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
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


--4gDzieZlX57QBwS8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 03:59:35PM +0800, Ng, Boon Khai wrote:
> Hi Tom,
>=20
> > I don't see this binding in v7.0-rc1, did I miss it? Thanks.
> >=20
>=20
> This binding was not introduce in Linux. This is a per-requisite commit
> to support the Agilex Smart NIC 60xx board https://www.silicom-usa.com/wp=
-content/uploads/2024/02/FPGA-SmartNIC-N6010-AgileX-Based.pdf
>=20
> During the initialization stage, this board require a spi communication to
> configure the chip's PLL and also to check the chip's status.
>=20
> and it require the specific spi bits-per-word=3D16 setting.
>=20
> Can i add the binding at U-Boot?
> https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bindings/spi=
/snps%2Cdw-apb-ssi.txt

Why would this be inappropraite for the Linux kernel, once the system is
fully supported in Linux is the first question to answer. Thanks.

--=20
Tom

--4gDzieZlX57QBwS8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaabyGQAKCRAr4qD1Cr/k
CqQQAQD8Qr66reX9ZduIpSdOAd/ZQpbUyLYb0f2iZrPczT+sEAEAjHNqsYyuLT1h
jtqOjCMknsjxXKMCNklrBR/OOLKeYQk=
=ZV/p
-----END PGP SIGNATURE-----

--4gDzieZlX57QBwS8--
