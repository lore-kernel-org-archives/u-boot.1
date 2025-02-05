Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54DAC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 11:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C48800B3;
	Wed,  5 Feb 2025 12:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XdaraTTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6BC380562; Wed,  5 Feb 2025 12:22:21 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E628980040
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 12:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D068DA434C8;
 Wed,  5 Feb 2025 11:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED65C4CEED;
 Wed,  5 Feb 2025 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738754538;
 bh=H8Lx9J9Bepyfzpc1/jDZfNpmgwWL9DjbaJazmiJv5b8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XdaraTTShExQgBnGipJq31111pDc6/UIiDTCFLzNIZZw7Dlmkjn9NedKDsV3uyCrs
 jD8o5ZDCykK2wnjDAA6iq0QaWxOnazk6tKftsX3YB305Q/jSh/bufDznxSHxMX9GhD
 CT2siQyHzSJrRgI5PbHUHSjqn8wH5PjFk65tlKhJPOZ/UTyo0odBkBSD7Zer8O7MBM
 q11nn0KwRwRGyuBeB1K5nLSp4LKnHU6KGB6vNWpT2y1PH/rwzyt9JL6M0/QHDTKnyM
 KklfT8pq3syLsKys0qVSDdPgTpQ+RBvpaIJ+/CnnyzO1S3A3r7G4aqxVdqFg0J4uzA
 0Zd6u9WXYlGsA==
Date: Wed, 5 Feb 2025 12:22:13 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v1 11/20] drivers: gpio: add support of RP1 GPIO for
 Raspberry PI 5
Message-ID: <ntfq5rruarnksf3xwqu5uzql2m7nkuaywsxq3jrcpuon3bdduk@7dp7kr3wbbgp>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <3f36c2863ec3dfc5efe297b80c25e315a59260e5.1738749764.git.oleksii_moisieiev@epam.com>
 <jt6m5lrewwhn67cmc56zaitgklldok73i5vm76quraeqogt7af@l5wytci4amzg>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jt6m5lrewwhn67cmc56zaitgklldok73i5vm76quraeqogt7af@l5wytci4amzg>
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

On Wed, Feb 05, 2025 at 12:09:02PM +0100, Marek Behún wrote:
> > +#define FLD_GET(r, f) (((r) & (f ## _MASK)) >> (f ## _LSB))
> > +#define FLD_SET(r, f, v) r = (((r) & ~(f ## _MASK)) | ((v) << (f ## _LSB)))
> 
> Use FIELD_GET and FIELD_SET.

Sorry, FIELD_GET and FIELD_PREP.
