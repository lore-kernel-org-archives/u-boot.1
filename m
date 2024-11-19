Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EDAD44162
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 14:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01E38953C;
	Tue, 19 Nov 2024 15:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sWmLw12v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF9E89548; Tue, 19 Nov 2024 15:27:56 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A591889500
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 15:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b1505ef7e3so57930185a.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732026472; x=1732631272; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9BrC+iqYa3DOHOZPyyBxXtt3pRe3BhC1670Qu6gVosc=;
 b=sWmLw12vLZu4E2YyMlMG8U078qWBZvv+E0/FgQXQzdpsADgkXN5oikKJlY+RFBPNEG
 Qs4FEHWuLhOVRPVRxZRgs+xQBNb281iEhEVr1LWj9kU7hcBL6S5IX6M9mxjoRLevSGT5
 bCx3sHxlH1+IvVSOZBm5q2pzlMMptcTXkG0+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026472; x=1732631272;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BrC+iqYa3DOHOZPyyBxXtt3pRe3BhC1670Qu6gVosc=;
 b=S106BQ4nJXZc0eSBpDQSCZEthZIyNF30jzbCoratpjZDmFozk1KrU6woemWiOk1X9E
 8pKels43NaG2h/LPEgFbQrPvrqRg2+qiAZcDVN8Os8N1d1KDXze+QW2mbJardF/6rrU3
 qipLM3buwqM1fkXHfZqUSGrBSTsSp3wXk/n6bBh9G+EXkkP5aKKFclWgahP46ve9txh1
 z5Wd9jjYuj4dgP9S8L9EnJZs1m+iQXZoN3OEDgEC3yF/jn90pUPmen6bzaLzsIypqhBf
 FAuyUP7vppPR8XziDUevvnbju9yHOCsMdb9hiWiSiktUeluFVZ4gYkPWcmdDLy0Y7BfR
 4mvw==
X-Gm-Message-State: AOJu0YydUkUEMO3vTMmqN9ul+WgsxkGe/OSbQbz1hqC3gqh6PbqIVZgn
 FYMM2Q21T3xxzXmSuT41PDH8xFZsJVFUDxFQ0t3Jwjb1JzdEhtwPSpXk8ZdRM/4=
X-Google-Smtp-Source: AGHT+IHCnrplTg8edls10gtEIEDWKs7wnh1PC0OPZkguDegL3y1WOKGeg6HBXxbcaVatOkjJHgTZ1g==
X-Received: by 2002:a05:620a:424b:b0:7b1:7f5f:4975 with SMTP id
 af79cd13be357-7b3622f55f5mr2568712385a.36.1732026472520; 
 Tue, 19 Nov 2024 06:27:52 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b37a864646sm97238685a.57.2024.11.19.06.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:27:51 -0800 (PST)
Date: Tue, 19 Nov 2024 08:27:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Gothe <markus.gothe@genexis.eu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] Bitbanging MDIO driver for DM framework.
Message-ID: <20241119142749.GV3600562@bill-the-cat>
References: <d7d1e0ca-f0cf-4458-a52d-0e8ba1b85bdb@genexis.eu>
 <20241027183150.GK4959@bill-the-cat>
 <eb0c7d6e-fa93-4547-b8b4-0419a11caacd@genexis.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ylKl6cBH2S/6zkG+"
Content-Disposition: inline
In-Reply-To: <eb0c7d6e-fa93-4547-b8b4-0419a11caacd@genexis.eu>
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


--ylKl6cBH2S/6zkG+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 09:26:34AM +0000, Markus Gothe wrote:

> Hello,
> please see https://github.com/u-boot/u-boot/pull/695

OK, thanks, I've taken that commit and sent it to the mailing list.

--=20
Tom

--ylKl6cBH2S/6zkG+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc8oF0ACgkQFHw5/5Y0
tyy8Qgv+LgYug7mW9IYIiY7T0Es2I8din8eCY2PCQzYMt0lS5+TdZ5PYjNiqQpY/
lZTEgua/rmHezsmNKlOMSkGDvTeKTihQs8RN93rToQ+LXORuYXIL1ZaQ1DolgakB
psRGmWfkXtAr3Xn+wc0sZQj2fISkHTeJ+g4jVUcS9AmXZHhBfA27WGgdHjjj5kiV
+B41YRzOzL/Y36kQbtzSpmOLqwsJjBn4IhZ4G5ZN4jcKvIz2izIq/Wp/R+JfE1Qu
XSh6qipJ/ApA43mZi46CiKlIXRm6hXXGb1nMSUhDmm+DyHRgsedTp4064HiMCbrL
EHXHToC/RuEESgI3dy84yJBeBZaq/P+GYZEhqMr6KQxhnQCcbkUP00WKL/JuWcDR
+8P+z3HvNUBfJFnVPaqLjGzRTfPSIz6izSO1ikQ0b7GT8/krvBvnsqWDsQeu3Q7V
9ebp6VdjA1Sk1Cg6uiBibwOnO6d4EJVdNqkFe3SAx9rXHzhyF1YOR+MVPMMtWbOO
Y1OZ24Q8
=5BlG
-----END PGP SIGNATURE-----

--ylKl6cBH2S/6zkG+--
