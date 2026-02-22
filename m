Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E13BC636B3
	for <u-boot@archiver.kernel.org>; Sun, 22 Feb 2026 16:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51C3E80FA1;
	Sun, 22 Feb 2026 17:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T9ppPh7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD29D83C39; Sun, 22 Feb 2026 17:49:57 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F214801BE
 for <u-boot@lists.denx.de>; Sun, 22 Feb 2026 17:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d195166b2cso2548259a34.3
 for <u-boot@lists.denx.de>; Sun, 22 Feb 2026 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771778994; x=1772383794; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PZ9PBpAnaPZ29aagbKJbWCHniFKQIIbGKh0eHC0b/os=;
 b=T9ppPh7MpZGg3OWrRJVRP7nbtDYdbdEHdyFCSuDjq6vbrxrIJDqK80lUc5egHp2Vro
 DmMIkDMNNjwvhNssCJCrEGGsGwF9GOiD+Dql5pvjIZxR22EpWWuUn7bFiMETNSP5jMY1
 2awcU3GTVobFLA0egbIi1ea9m+aLCac58bd6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771778994; x=1772383794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZ9PBpAnaPZ29aagbKJbWCHniFKQIIbGKh0eHC0b/os=;
 b=hT3bQNx/7FBtdvOHLnklCPOvgjD4LQaS9b9gsRhTUOkraM+xoHzcMsgVIEMCMzwcdv
 fK4PpXpSdOl3v+LmurOWRgfSO1qqJYiLn+R/dgpUXAyjkxjwOoZnAu7uTN33dCOlL6EN
 vjyc4By87X9cjjqkNiVzpmjnl070nVuGRHe1HFYZlSU0+nkvmhduxohlXNT8tzJXuhtO
 NbwFILzyTuREkgrcIPKBIYvJG76O6xRS6PSoyfUHBXZVdxKU8fQ9UndGsO3pLqHQ5VlX
 J43+o0cf7zDv4UzLUc//YqprJB8foBDWTQ7cdfQqJ7n/6rizEbpMotb2MLbb2hKaA9Ay
 ioKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU811YmXcMaD9dtERBci8CwFq+wLxxRfNEKVxIpF0A9ImO5AslxO2QHt8X0NCwNWomSBYLbWwg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxf5VmKEwmh3LX3tXwmFk5J10ToXqYeXfsRNm87oKG+PSbSvXOg
 Q9G95mLKXXuC+eZw7F/Y4w5uRUdUmzq9nttNtTP6XEUs4Ttt30FFBl157o4lY+oSXCg=
X-Gm-Gg: AZuq6aKtEZZgrT4yYg29V+PWStBXpkcvEgfUgtYiBFrLm8qvkfsqDhssTqdycGhHI57
 JkiuWqQssX5j8nUJikVc2dgARz7lFhf3u8Svmu56CrII7xGLtqlCYR0impLh7Gks2T+Skfnpt03
 NQGUmScgs/mQ4v0Sp9qPEXVHUAC2HCqy3anr2kxCia1+/5fizLdwNFJH8XYEHlI+uKUYbYaZZ/6
 /hxnAd3Op9MwRz6NsGgXwI/5D9HdgGZxUmRdSe/nPTBvEE14GHTeFsDMUmv/xDT27ieQov0QGtJ
 EH+HfiHJxPVx990rwM6l/zC6BOdiQ5qcSMP0bWdzwJ5O+Rr//ViP50OUty6VymYhTA1gt0C/et/
 7K9FXwSDsX8wtLgDLXwrlb+n5y5nfsnYueNydjrUgq0Ra/ErK9GVI8Nc6Ua1jDI1lE8Cun8oxhb
 c8+mJnYLVrD38oJew7sLn7I37LLPyUwBkjKjKBQmfP8ezwLfGwNxCaWGtHrpdhks7YHIR7Ic9iV
 cQjb6gnl1X19fiOCd5rjyWID1yDccgI+fYlFH8hVGK/jelm9Xo=
X-Received: by 2002:a05:6830:40ca:b0:7cf:cc2c:1d9f with SMTP id
 46e09a7af769-7d52bf52e93mr2974384a34.32.1771778993920; 
 Sun, 22 Feb 2026 08:49:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf9f489sm5081134a34.7.2026.02.22.08.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 08:49:53 -0800 (PST)
Date: Sun, 22 Feb 2026 10:49:50 -0600
From: Tom Rini <trini@konsulko.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com,
 kabel@kernel.org, vladimir.oltean@nxp.com, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/4] dt-bindings: net: airoha,en8811h: deprecate
 pnswap-rx and pnswap-tx
Message-ID: <20260222164950.GB3233182@bill-the-cat>
References: <20260221163114.87553-1-lucienzx159@gmail.com>
 <20260221163114.87553-4-lucienzx159@gmail.com>
 <20260221164556.GZ3233182@bill-the-cat>
 <8e1c4274-797e-4f2d-b1ff-c6ef67bffacd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TWMEKImH93pOHXAe"
Content-Disposition: inline
In-Reply-To: <8e1c4274-797e-4f2d-b1ff-c6ef67bffacd@gmail.com>
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


--TWMEKImH93pOHXAe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 12:27:02AM +0800, Lucien.Jheng wrote:
> Hi Tom
>=20
> Tom Rini =E6=96=BC 2026/2/22 =E4=B8=8A=E5=8D=88 12:45 =E5=AF=AB=E9=81=93:
> > On Sun, Feb 22, 2026 at 12:31:13AM +0800, Lucien.Jheng wrote:
> >=20
> > > Deprecate the proprietary airoha,pnswap-rx and airoha,pnswap-tx boole=
an
> > > properties in favour of the standard rx-polarity and tx-polarity
> > > properties defined in phy-common-props.yaml.
> > >=20
> > > Update the example to use rx-polarity with the PHY_POL_INVERT constan=
t.
> > >=20
> > > Link: https://git.kernel.org/linus/44f62aa1b1209232cedcfb39097fc1bfbe=
75bbc7
> > > Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> > And for clarity, my comment about cherry-pick also applies here. The
> > script tools/update-subtree.sh makes doing the cherry-picks
> > straighforward.
>=20
> Thank you for your comment.
>=20
> I checked devicetree-rebasing.git and it only has the v6.19-dts tag.
>=20
> I will try to manually cherry-pick all phy-common DTS-related commits from
> Linux.

Outside of extra-ordinary circumstances, we just wait for them to be in
the rebasing tree and do a proper cherry-pick. These changes look fine
(but waiting for other comments still) for v2026.07, so there's time to
wait, really. Thanks!

--=20
Tom

--TWMEKImH93pOHXAe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZszqAAKCRAr4qD1Cr/k
Cq+3AQDpyv+l1Lh8QP8lIZVv3P6y7MfSxUgU3tme1azaO3n9yQD/Q/g1cELG7RCf
1CeDYpkdEH2IH2zPoE36kJFlnT1Jpgg=
=0S7V
-----END PGP SIGNATURE-----

--TWMEKImH93pOHXAe--
