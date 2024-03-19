Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD76C54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 21:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2AE8802B;
	Tue, 19 Mar 2024 22:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="tEHqM3BK";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUi1nBGa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96CD487DC8; Tue, 19 Mar 2024 22:28:20 +0100 (CET)
Received: from wfhigh7-smtp.messagingengine.com
 (wfhigh7-smtp.messagingengine.com [64.147.123.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15918802B
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=janne@jannau.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.west.internal (Postfix) with ESMTP id 482CC18000F2;
 Tue, 19 Mar 2024 17:28:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 19 Mar 2024 17:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1710883694; x=1710970094; bh=rD5D0UiScm
 z288vlYj2nLMgCiKkTpoPPXJJXON/Rj1U=; b=tEHqM3BKPYGb7yALWYWyN2j3A2
 mpCsAw+krMF3Z7UhJZ6tgRHCp5YFy6WqHlCybgphMQ18ja+paJl4xN50xJno/Txc
 +cMrnycHeLVHwL+rcX7Koo1GDDWSMDEyI0C7Hc84m1l9BRaJBzCZSusCiVwJIMOr
 c4oxR+FFPk+e1Tj6zWEt1dQ2a4SKCjxe8SdTsLr49qvTYES34mL8oGzFyJa0m/u5
 +7NWr+EjWm9ZIfVM0zonUUqwX0qTGNCJ6YmGH7ctmpxYvV+wTqzooHC3Uo1Il0Uc
 Mx/VhK1YLqBPyvfscWr9dIu9WcdbXi9ouD6vpe81ZCjPJ/ZRZ1dTNHgx41uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1710883694; x=1710970094; bh=rD5D0UiScmz288vlYj2nLMgCiKkT
 poPPXJJXON/Rj1U=; b=nUi1nBGanZItUAfKozv5lJorEGv7aKVIwtksviERmWzw
 Kt+owPYpTpm0R8r/5vpV4pLy7t3dFU9SGLNdz+Eua8cPyTRksmaINaJkdgQtm+vy
 yxhb2oFfFYv9MSEZsIGLkrylyhoB8oNmA7FT2gYBDLtxHrFHaZBLhK3OW38qGjmm
 5K+q1A7DdMp34ZqZzSdPifjAC19Tj9AEq/KKDCRyoB0TREN382mtK8HmWNO87bZV
 8cfkpl93Dubfi5MtO7LDI2qF6zVHqzzBNHYT+pkO/SmzBxc7Rk4JRPSJKrVqiOC4
 RBqQVFGwN/1NmSoUcgBJCkJxMC+vsWIwjr9jD9E6ng==
X-ME-Sender: <xms:bgP6ZS8eimzZU-oUAhpptzjqy2I13ibNaD7FMXsEtthmpJnfJ5a7PQ>
 <xme:bgP6ZSswNyt9TMuoT_lxDuYlM8o3Zzg31z9GvgYo8AO2V-tQp4xuLNElx4fFWCh_8
 lmMJl5ZbwLW3PaKXhE>
X-ME-Received: <xmr:bgP6ZYB8yqSoHtrsjJSWjOdwR0-y5FeMQFC9v_rcbt75tQW6PIZFss2tM597m6JT66C1UjTjzFl2R1nAxFxGF2TxX1Vx-YT1wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdduvdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhn
 vgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpe
 fgvdffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrghnnhgvse
 hjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:bgP6Zadu9SAVq2QL--IyquCIyBy1NWHx8V8MYWGq1TRfLpBSW-fO7Q>
 <xmx:bgP6ZXPrIZpO__chdmUd2hz0dekbkNZnA-fxeUarTqOooci-xsNXBw>
 <xmx:bgP6ZUku5WLBe5M2jONGDYAyoGySjGZgiea2_eXIcRJa4l5AqyFzjA>
 <xmx:bgP6ZZvcE2-5dJ2Dy9EthOEiUgj_zHPIfDDRDBhNsh-tOIYxuH4UHQ>
 <xmx:bgP6ZScbSU0M-1PiN27GMczeghvU0td3BxvnQ22rIphM7Q165QxjG87HRnM>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 17:28:13 -0400 (EDT)
Date: Tue, 19 Mar 2024 22:28:13 +0100
From: Janne Grunau <j@jannau.net>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 4/7] efi_selftest: Add international characters test
Message-ID: <ZfoDbRh1dgz0V6vm@robin>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
 <20240316-vidconsole-utf8-uefi-v3-4-4e8a3d349447@jannau.net>
 <4630a614-70d0-41f7-8f40-d28d0966c4d2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4630a614-70d0-41f7-8f40-d28d0966c4d2@gmx.de>
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

On Sun, Mar 17, 2024 at 10:24:13AM +0100, Heinrich Schuchardt wrote:
> On 3/16/24 22:50, Janne Grunau via B4 Relay wrote:
> > From: Andre Przywara <andre.przywara@arm.com>
> >
> > UEFI relies entirely on unicode output, which actual fonts displayed on
> > the screen might not be ready for.
> >
> > Add a test displaying some international characters, to reveal missing
> > glyphs, especially in our builtin fonts.
> > This would be needed to be manually checked on the screen for
> > correctness.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >   lib/efi_selftest/efi_selftest_textoutput.c | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> >
> > diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selftest/efi_selftest_textoutput.c
> > index cc44b38bc2..917903473d 100644
> > --- a/lib/efi_selftest/efi_selftest_textoutput.c
> > +++ b/lib/efi_selftest/efi_selftest_textoutput.c
> > @@ -31,6 +31,21 @@ static int execute(void)
> >   		0xD804, 0xDC22,
> >   		0};
> >
> > +	const u16 text[] =
> > +u"This should render international characters as described\n"
> > +u"U+00D6 \u00D6 - Latin capital letter O with diaresis\n"
> > +u"U+00DF \u00DF - Latin small letter sharp s\n"
> > +u"U+00E5 \u00E5 - Latin small letter a with ring above\n"
> > +u"U+00E9 \u00E9 - Latin small letter e with acute\n"
> > +u"U+00F1 \u00F1 - Latin small letter n with tilde\n"
> > +u"U+00F6 \u00F6 - Latin small letter o with diaresis\n"
> > +u"The following characters will render as '?' with bitmap fonts\n"
> > +u"U+00F8 \u00F8 - Latin small letter o with stroke\n"
> > +u"U+03AC \u03AC - Greek small letter alpha with tonus\n"
> > +u"U+03BB \u03BB - Greek small letter lambda\n"
> > +u"U+03C2 \u03C2 - Greek small letter final sigma\n"
> > +u"U+1F19 \u1F19 - Greek capital letter epsilon with dasia\n";
> 
> The strings should be indented by two tabs.

done locally for all selftests, I'm waiting on fedback for Patch 2 and 3
before resending.

thanks

Janne
