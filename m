Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8AECD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 10:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A456980398;
	Tue, 12 May 2026 12:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pbarker.dev header.i=@pbarker.dev header.b="Ty2tYVjD";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="aBZMAN+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96FCD803C6; Tue, 12 May 2026 12:39:41 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0676801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paul@pbarker.dev
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 3C8A01D0006F;
 Tue, 12 May 2026 06:39:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 06:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
 t=1778582376; x=1778668776; bh=tv3PHmur2o8clTN4xFoAAb3WRgALUCDd
 bUIfGPumFj0=; b=Ty2tYVjDylOf54WLwar/gE26eEjwUMkCSld1WyLcbb1UKk8H
 zblwyfBDMyZiBqBNxSmjtCCmWQNkqfGEPu6vYJXqIrDDA9uOLXU9s5Ewh6cNfGi+
 AnVSezPk0lreSiBBmIY2W0e+A2k1MSjhnMMRZ6WcdKzMKkW1PTKpLkBIGn2yKF77
 zymRWl6P3Z3Y0dDdnEKRaFtZ1huOGuVZhL1kC2EQ0QFJXvFVeHrNXVHA/o7XNsHB
 Rw266wu4omNvBzY3RWenbhqWWptUTH6M5T0TK9Qeg2dEsWf1kC7QmFAKGu6dLq5o
 ay+3ZUbqUvWzIRPkXnVkTV0jAnKGHyUyTNHu/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778582376; x=
 1778668776; bh=tv3PHmur2o8clTN4xFoAAb3WRgALUCDdbUIfGPumFj0=; b=a
 BZMAN+Yl0TRZRJUl7RtFdsaEv2wX/mMxWhZiW/Rv71NR0wy2s6v9SaSpa5btWlo8
 REPpeArCH8asQjuPaLEGtq7sV3+WC8+yI/DTzPYatcew+8flYIuHK8RJ99j689Fw
 qOEsTXOpSIHFYTe32yjhC6WptPutsS6f0cuwSQS2H9O1dDf+u0hHlyWQQ1b2KV4m
 cLKzl+300x87sp9PPhOdNiwYRA/5VxqVbb0z371nH/USTEY6mjLcmyuSdTCseVQG
 bj6n+tbzbxGJxdhLjUIp5L8cTf4/365D1ZM6+X7INCNNqDx7WF5mNIDPC3WwoZRy
 jHV+E4s3Hhgz37m+6booQ==
X-ME-Sender: <xms:aAMDaiyERIIQ0G9qdcMEZS6xv-n_MPf1xHP1raPMiW2K7D9SPaClrQ>
 <xme:aAMDalvGTbi59DKxkQrY8OcJZoaTbtjyGroiPc92APSfkix5g7-BcypUhfvGSkLcn
 8TJFTuzs06M62w2xE9TO3Qmfvd_7KnNwcqPmZw6Ba_PQqS5GOev6m4>
X-ME-Received: <xmr:aAMDahs_tVMaW7CndULfEV7FbG3ofD0I3pHz2o-gNXXbFjm9kJxXcB4GdV3NYokebQLZaN2cwBgYvaFlF_vuUhgZH8cBuBTpvBzPVxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduheekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdlqdeimdenucfjughrpefkuffhvfevffgtfgggsehgtderredtreejnecu
 hfhrohhmpefrrghulhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqe
 enucggtffrrghtthgvrhhnpeetgfegjeffgeehleeutdelgfejleeufedvjedtffdtjeej
 vedvieelffffleegveenucffohhmrghinheptddurdhishdpnhhishhtrdhgohhvpdguvg
 hngidruggvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopeefpdhmohguvg
 epshhmthhpohhuthdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdgu
 vgdprhgtphhtthhopeihohgrnhhnrdgtohhnghgrlhesshhmihhlvgdrfhhrpdhrtghpth
 htohephhhonhhggihurdhjihgrseifihhnughrihhvvghrrdgtohhm
X-ME-Proxy: <xmx:aAMDaiOkjPpYTMZwtySuCHnu-UpTHNkv6i46ukuhi1ILs90PZVZOjA>
 <xmx:aAMDan3Q_h3HzccgFztYYOgcmhqhjeHePfHQz3T6ooUNj-TmtfLTrw>
 <xmx:aAMDamOUnFgVn3tdGn6SqRIyA3EgTlkvqGBrpW8r29l_hvOjeVMpIg>
 <xmx:aAMDav0pE3tWHhzqBu5tUT0MtbSkb-OFUW1jDZxK0FnhXcYzFABXvA>
 <xmx:aAMDaoKFuO3dR9PgH-R4DZMs09cSQX5s0ipUcjSfOCmyIUzL9sW-kM90>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 06:39:36 -0400 (EDT)
Message-ID: <cb01c903e27bd1aa6198a51b138409c08abd3373.camel@pbarker.dev>
Subject: Status of CVE-2025-24857 in U-Boot
From: Paul Barker <paul@pbarker.dev>
To: u-boot@lists.denx.de
Cc: yoann.congal@smile.fr, Hongxu Jia <hongxu.jia@windriver.com>
Date: Tue, 12 May 2026 11:39:32 +0100
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-ev1odA6KmW31p5OtQb3H"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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


--=-ev1odA6KmW31p5OtQb3H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

We recently had a patch sent to Yocto Project to backport a fix for
CVE-2025-24857 to our Scarthgap branch which uses U-Boot 2024.01.
Looking at the CVE info, this has confused me a lot. It says [1]:

  Improper access control for volatile memory containing boot code in
  Universal Boot Loader (U-Boot) before 2017.11 and Qualcomm chips
  IPQ4019, IPQ5018, IPQ5322, IPQ6018, IPQ8064, IPQ8074, and IPQ9574
  could allow an attacker to execute arbitrary code.

The NVD page says it affects U-Boot "Up to (excluding) 2017.11".

But, the patch that says it addresses CVE-2025-24867 was committed to
U-Boot in December 2025 [2]. The first release containing this patch was
v2026.01.

Is this commit actually needed to resolve that CVE? Or is it some other
change back in 2017 that fixed the issue? (A yes/no is fine, I don't
need a link to the exact commit)

[1]: https://nvd.nist.gov/vuln/detail/CVE-2025-24857
[2]: https://source.denx.de/u-boot/u-boot/-/commit/87d85139a96a39429120cca8=
38e739408ef971a2

Best regards,

--=20
Paul Barker


--=-ev1odA6KmW31p5OtQb3H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCagMDZBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bjqmAQDAdKpgGe4W1yCMN89wy1YQaNB9U8SkR4to
Zgp5WhCXbAEAlbba4v1jEdMpmWy6B/BbfPznqmSfXHP9K95uu352VQ4=
=vd+C
-----END PGP SIGNATURE-----

--=-ev1odA6KmW31p5OtQb3H--
