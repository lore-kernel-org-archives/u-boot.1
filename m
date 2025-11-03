Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C91CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 22:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC6F8144A;
	Mon,  3 Nov 2025 23:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LCZc1x7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D00D28144A; Mon,  3 Nov 2025 23:17:18 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD12980050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 23:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c531b42dbeso3119449a34.3
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 14:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762208235; x=1762813035; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=34Gg/RiwVkNfoLM2OZfEnjV9uzORpHNbW0dWwfM+ygQ=;
 b=LCZc1x7OJeivtjP6sERUwhOEUyS19AKOGopLB0f1qJrDNt+ImtiUpIyFgvEYg/pxZW
 gvbrz5/wGT4PFpR5/lxbeLUZt+CZ/JfvnQLQKml8XN8dhRZ//yJNnLScTaoL+F00KbrS
 Wu/SPtProvU2mYStGKdYhPxcSSqDQ/JMTGDv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208235; x=1762813035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34Gg/RiwVkNfoLM2OZfEnjV9uzORpHNbW0dWwfM+ygQ=;
 b=WQYK3cdtSVOEb00kCsXcv3+hnpTcCfAa4fWRu5N7mHc3mT8RnSTLA4WU8Q/bE/3MmP
 Dpctrn7xE64S7oBGLC8UghvhqbC1XxgkfAfUdjNsTmwcdVVVq0ScJa3nQSxPcIVpo+wK
 ug2eEX6CbEWmgweQrN+KBeFANvcRPsKRn+5RduIFz6pqGufAA8f151/Yg4/THbNxBz8v
 zARqu4CUrtQ3xe35bdnEmB24sVpZOvaadLJQOH5tic6sMNUh6P3mqgP2vvlHr6mRqDDx
 Iram1sXXeNjKnsVJhWjnZydqUOoO7nMc9i/LHWGYx1bRRxNNUix2QGpj21gKcOGeRF9S
 3kvg==
X-Gm-Message-State: AOJu0Yzz/Gre62FKDjMUXs5DsW+RpiAre4ACqMYgvfWO65UMkmZCNQd+
 goVuS86vxbKHrzp65TB1z13qiSDfA8MeHQRyjWgqrBDfGSHcUEmq/39BrYfMhOpj8Pk=
X-Gm-Gg: ASbGnctyYeaIrvDlZd0MIS4F7w1RlvE9iqCIpIUrQFlpInP4FtUbCrTmuq4xpXOP5ac
 MszW7zhOO1u4ehV4yUTow+O/EA3miIBBKtJdZKTrqZUappl0FrgShROS0wT18zJgsktbaXS3bda
 JNCRF023ibLsAyuloq56tdKaLjRbZU3f0tJqixYtAlLP+yN4Ck35QozBDJuSl/5mCQsVqEa5C0x
 e7VOVK3BDjEXHvA6dXcUGwLz8p2KqbcpIetnPlHGnRnPOrmn8Wwq/f5nhuqbWOmvtdxM8VTEVc7
 udjq4w2mYBUXBaCE3tFScZmBNgaTrXJD7Nt+R42SzhwYUsJbT/b84WdqPFDaFMagwZIwHErwfFL
 vRgClovfFHpJjI6zXLZdZK3BCKoC2be+u9CGWWUCp3hFN2v9SDUyDsZBD3OseG/zqXiJBGXHp8y
 7M6uHdLDwzUi0X7bVyQCSBmDTpX6NfOJ5z6gx26JE=
X-Google-Smtp-Source: AGHT+IF7JIXDBjEQJz6PKC7s13X77pgs//sbYN2QDH5vp6Rx/ocBK48B0GslgARI0qbim7pq6rifYg==
X-Received: by 2002:a05:6830:90a:b0:7c5:325f:f853 with SMTP id
 46e09a7af769-7c6966e1975mr7146575a34.1.1762208235419; 
 Mon, 03 Nov 2025 14:17:15 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6c25002eesm492580a34.28.2025.11.03.14.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:17:14 -0800 (PST)
Date: Mon, 3 Nov 2025 16:17:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] Add make feature support for SoCFPGA Handoff
Message-ID: <20251103221712.GT6688@bill-the-cat>
References: <20251101035252.261-1-briansune@gmail.com>
 <20251103153657.GO6688@bill-the-cat>
 <CAN7C2SB0b_YjcJ+LyVUJwi5DjdjR5Ssi=yQwuCvSvBh3XVj+dA@mail.gmail.com>
 <20251103200959.GR6688@bill-the-cat>
 <CAN7C2SCY1Q2_YcJWVMs0Zv+ymcuXLXEhrkX2JGcJviOaKDf0sQ@mail.gmail.com>
 <20251103204237.GS6688@bill-the-cat>
 <CAN7C2SACKPnE07-dtwc437f8xr38936h3RWvP1R5Ha_v1KfCng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ck30ry7dEuPtxFy/"
Content-Disposition: inline
In-Reply-To: <CAN7C2SACKPnE07-dtwc437f8xr38936h3RWvP1R5Ha_v1KfCng@mail.gmail.com>
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


--Ck30ry7dEuPtxFy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 04:50:25AM +0800, Sune Brian wrote:
> > I think I'm not explaining things well enough because I don't quite
> > understand the tooling well enough either. What I would like, but don't
> > think is possible, is something like:
> > $ make O=3D/tmp/myboard myboard_defconfig
> > ... goes along and sees that boards/myvendor/myboard/myboard.xml exists.
> > ... Runs the python script to re-create all of the C files, assuming xml
> > ... is newer than the C files.
> > ... Now compiles the new C files.
> >
>=20
> No, I think your method is just a bit more complex.
> What my last suggestion is just put the handoff folder
> next to qts i.e.
>=20
> board/altera/abc/qts
> board/altera/abc/hps_isw_handoff/foo_bar
>=20
> Then once you run maybe "make prepare"?
> It generates the new c sets.
>=20
> Flow always:
> make xxxx_defconfig
> make prepare <- this is the place it should be automated.
>=20
> As the user defines the board then what you need just place
> it new to the qts so it even removes the -o -i user parameter.
> And maybe leave the foo_bar naming for user to enter as
> it could be renamed by the user during the Quartus project build.
>=20
> Do you think this is good?

Well, I think so long as you can do "make xxx_defconfig" (and a separate
objdir not source tree), then "make" sees deps and re-runs as needed,
yes, this should be workable. Thanks.

--=20
Tom

--Ck30ry7dEuPtxFy/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQkp4QAKCRAr4qD1Cr/k
CiH+AP9Mt0kID6lg48tQYZ2IgiuI2oDW2NB0kHAe+e+cyQYfzAEAuO5a+6Zy58/F
QbVu3rBnijmQtHEQak22H7Dzd98GRAY=
=wLiV
-----END PGP SIGNATURE-----

--Ck30ry7dEuPtxFy/--
