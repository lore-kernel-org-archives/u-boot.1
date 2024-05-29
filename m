Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D6BC25B78
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 02:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B91B88590;
	Wed, 29 May 2024 04:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=testtoast.com header.i=@testtoast.com header.b="nPnzWxFF";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="TET9+Ue6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26AD4885C6; Wed, 29 May 2024 04:47:53 +0200 (CEST)
Received: from fhigh8-smtp.messagingengine.com
 (fhigh8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7227C88554
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 04:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan@testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 430E811400E1;
 Tue, 28 May 2024 22:47:49 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute5.internal (MEProxy); Tue, 28 May 2024 22:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1716950869; x=
 1717037269; bh=BvBDPauIC1DYkzBNK1wKsa/FTIBZeyAC9LV4tlQkQ+4=; b=n
 PnzWxFFsOYYFpviKOvCSRMSzhokRr7xXLNf7jxo7tDlOXStYG0GsaiPmbQpBj14X
 GBgt2XxnFEuyQJVfOFetQUS6hWur8fRHsT37R/EhAl15HU6aKV/YVB7U1SV+6Nkm
 tOPBGaRRwC9sazVZL7bu86VyRVGMBhy3j1c/5fFiaO9UY8YHRSftXkogcynVz82j
 OMKQYrxM5nHDW0hnik5i4dWLh8zzna3zBXrUtXXwOUaKUIGD6oFruyukhVO8kwld
 cUaEolmVgpia1Wo2Krr2DyvvpUd+CepAFijNp7Dnr6N3tOcQOMiAE4aOu+LkA590
 7pwKhslRT6cNs9tb0AJcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1716950869; x=1717037269; bh=BvBDPauIC1DYkzBNK1wKsa/FTIBZ
 eyAC9LV4tlQkQ+4=; b=TET9+Ue6JY2LdlHIlacDrkKQcP4B23ZS3nA2NoMrUnND
 +9r1uukYqafRU+DIoLKsdihf62O3ISA5hePLXNLBy4bB2ULXu09eOhgib7smRUyG
 YSoAgXvUx4vj68RC4URGv0VGCs/rLXvPwzpbT6Axa0yDzCpN663mAbxu0moaMppa
 bH8ZOxD3B6mtJ9kFLwTmc3LcsSBylIAnxUjHZScnvqMdnpF0Cd0zJXacUiV/M+Lm
 ZkTM4Z8TphCnN73ViKd5B1q8g6kO1xTqSJkLD1Wow5jG6jybj+MTA7o4VH0cH0r+
 hHYrqYMAXThmMtzl5pIkB04HI4HbG8Oe9ZJ/oDTtxA==
X-ME-Sender: <xms:VJdWZiVMawFH1FZFSF8pSw77D1EFYgLrrZkmt_XmFo3qKUT30uJydQ>
 <xme:VJdWZunFKpFmQ0xso5U_556C7hTC9PXzcmNfAAh76Z72h9fptWqqb2kxQyNBVH7Je
 bR_fRGXu_XHOjMnCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejledgiedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftfih
 rghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecugg
 ftrfgrthhtvghrnhephedvveeigedujeeufeegffehhfffveduhfeijefgtdffteelgfet
 ueevieduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:VJdWZmbyMbUFZc-Tezk_WzLuCQU70SpM3LlhbiCUZIEhzWAvfMYA0w>
 <xmx:VJdWZpVF9zSQtIxl05-MxzvSkgqlQ-lPkOeW1bHrLSzVRAdSA95Wkg>
 <xmx:VJdWZslCbE1lTq-7mSbU_ZsoOa2j006Ms23y6hoLm1nNbMmOKGnBhg>
 <xmx:VJdWZuehS5uyDqFDNnCpi-SzjGzplB6slwEeDxKLF-DVfgFp_r4TkA>
 <xmx:VZdWZtC01HEiE2XQ0dljeyOtCY2YqCmpozWyP1FQsRLYZobN-XmS4q9Y>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D1DEFA60078; Tue, 28 May 2024 22:47:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
MIME-Version: 1.0
Message-Id: <e71e336b-a621-4c11-93b5-2485fe24bbaa@app.fastmail.com>
In-Reply-To: <20240509231316.11391-1-andre.przywara@arm.com>
References: <20240509231316.11391-1-andre.przywara@arm.com>
Date: Wed, 29 May 2024 14:47:28 +1200
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Andre Przywara" <andre.przywara@arm.com>,
 "Jagan Teki" <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 "Chris Morgan" <macromorgan@hotmail.com>
Subject: Re: [PATCH] sunxi: spl: h616: fix booting from high MMC offset
Content-Type: text/plain
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



On Fri, 10 May 2024, at 11:13 AM, Andre Przywara wrote:

> Extend the existing offset calculation code to consider the different
> sector offset when running on an H616 SoC. This allows to load U-Boot
> on any H616 device when the SPL is not located at 8KB.

Thanks Andre,

Confirmed with an H700-based board and u-boot at the 512-sector/256KB offset.

Tested-by: Ryan Walklin <ryan@testtoast.com>

Regards,

Ryan
