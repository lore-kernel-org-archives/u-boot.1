Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DE3C369D1
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 17:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1C4D81F54;
	Tue, 22 Apr 2025 19:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="gJOw4kd6";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="q4R8HHp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1BE58144A; Tue, 22 Apr 2025 15:06:07 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B272D81273
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 15:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1745327165; x=1776863165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aFMYSnHunPlB2OJMSWda72yk3UCcGlURvuJHJWPGD3A=;
 b=gJOw4kd6+rCphUBBjGLv2yoNsxhEzYEadpqVnTWaFePn4Y8sbzEVyaaX
 evRk5xL7jXmf5t2v9LoF2BITADIfwdkitoccj0jyVDgUsi4oHJpwyQAau
 eGLYOEa6MQEii6GHj/xlMNHv135UObSnwKOYkUTLP/K9ST0ASjwTzLF7G
 zbQRVJlJBYb3XZijUQ0QFmKyboC3qGckZN5Hak3CwHChCwb5vDbCXjlwk
 b2FcZd5aW7hB1zej60WKV2hPdmxSv0iPH2KysmBGAenTagfdZYmg39Hbk
 YCT40sQPtAfipSrMLeuy8hj8Rj9NQL3+k+vxtv54vQ+DMIkcojICsFIaU g==;
X-CSE-ConnectionGUID: Zsfs17voR82S6xdHTN5O7g==
X-CSE-MsgGUID: e7Nf0S0FQa2TyUax6hJ5aQ==
X-IronPort-AV: E=Sophos;i="6.15,231,1739833200"; d="scan'208";a="43648204"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 22 Apr 2025 15:06:04 +0200
X-CheckPoint: {6807943B-23-2417938-F0170C2B}
X-MAIL-CPID: E5AF5D15C40B67F2DE69016C762CB1AA_2
X-Control-Analysis: str=0001.0A006368.68079449.004D, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2E08C164A91; Tue, 22 Apr 2025 15:05:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1745327159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFMYSnHunPlB2OJMSWda72yk3UCcGlURvuJHJWPGD3A=;
 b=q4R8HHp0sNyU3Q1JhEtJyMhW/s5Pygzt0LL8wJUX3B6yzhWQGqNFwVy6SS6YZjQprqKKiM
 jNXS98tpQNAoOvqIMqw8rZFxjOx7Hl0p/uOYYUWaT5axgRv0Xz9z8UVX9NF+HAIk6zjkow
 a6jThVac+VWuqhf6a9c+laKsYIqetzjTN+FBPHuX89uMReo1upKw6rtWrifBzeJxxmMdbU
 6j+4RYXZ7EvAtk/mrNHS2z2aH3Mxu1VBKryeYMO17EJP3dIY5TbZA2UKivK2l7zASwTJ5R
 qRzpQdbwkK7F+Tk4/uPVjp6st68UjoWxfbCXBcX8uQalC6cYbycr7BuHBmcYww==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.denx.de
Subject: Re: [REGRESSION] [PATCH 1/1] mtd: mtdpart: Support MTD_SIZE_REMAINING
 with unallocated memory area
Date: Tue, 22 Apr 2025 15:05:58 +0200
Message-ID: <6153415.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250422103732.GA117260@francesco-nb>
References: <20250220145808.1911832-1-alexander.stein@ew.tq-group.com>
 <20250422103732.GA117260@francesco-nb>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 22 Apr 2025 19:29:01 +0200
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

Hi Francesco,

Am Dienstag, 22. April 2025, 12:37:32 CEST schrieb Francesco Dolcini:
> Hello Tom, Alexander
>=20
> On Thu, Feb 20, 2025 at 03:58:07PM +0100, Alexander Stein wrote:
> > If there is an unallocated memory area before the last, filling parting
> > the size calculation for MTD_SIZE_REMAINING does not take this hole
> > into account.
> > Fix this by calculating the remaining size just based on total size
> > and partition offset.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
> This change introduced a regression on colibri imx7 and imx6ull.
>=20
> ```
> Booting from NAND...
> Partition size must be a multiple of 2048
> Could not parse device nand0
> Failed parsing MTD partitions from mtdparts!
> Partition ubi not found!
> ```
>=20
> Reverting commit 1ca97ee90392 ("mtd: mtdpart: Support MTD_SIZE_REMAINING
> with unallocated memory area") on top of current master fixes the issue.
>=20
> Any suggestion? I have not looked at the code, I just did a git bisect.

How does your mtdparts look like?

Best regards
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


