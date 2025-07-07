Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF03C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 13:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ABA6830CA;
	Mon,  7 Jul 2025 15:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="r5/Rp9/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9867830E4; Mon,  7 Jul 2025 15:50:32 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F8928305C
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 15:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail2; t=1751896229; x=1752155429;
 bh=bd8AHTbB6f5INUldJsxIDXqYcozwPy1TknaD6qI/e9I=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=r5/Rp9/RZLY904YzvsWjwh1wrnZDxz3BPabN9WtQxDxGjNsS7TPhLYFFMChTR5EwH
 PAUKBg2mX1SJG9p6/L5zloDK5dEChX5QX8nOy1CdFzf8zjWzM4gN7fMuCqQFBgs4qM
 s4NLcnq0oLAenxaOvOpfantgW80di5YnD6oVAi+c3hfsb64lGXF7ijiSrEjKNw2cdo
 NfN+dq3NbZ59agEjIXfZsXmjdD0j1qOsQOgrgLQ/N/z8F3ltlmAk0YVT9y/smJu9dK
 uCh22PQe6bd1DNI2bFMuqqvGjURy2prgU13NFKtzV2j0LoSxUD1I0sCm2q4Yr3BfjB
 xH57ExvPIgToA==
Date: Mon, 07 Jul 2025 13:50:23 +0000
To: Andrew Goodbody <andrew.goodbody@linaro.org>
From: Philip Molloy <philip@philipmolloy.com>
Cc: u-boot@lists.denx.de, Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH 2/4] serial-uclass: fix typo in comment
Message-ID: <hqrJsomBI8gSWCszV1l0RXMGqBWx-hOWADNe7hiZ7V5wiKBwmmsdtTOK9MSKbF0tqVYH9Cc-GMuuTou5sAVmMdCntYI4h6ycUEu3P0GU2AE=@philipmolloy.com>
In-Reply-To: <18f71373-49b2-4197-9051-0eeb8c7fd6aa@linaro.org>
References: <20250707150438.3016690-1-philip@philipmolloy.com>
 <20250707150438.3016690-3-philip@philipmolloy.com>
 <18f71373-49b2-4197-9051-0eeb8c7fd6aa@linaro.org>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 90363984328f17a52eee236f61664e4b0ba7fdec
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Monday, July 7th, 2025 at 3:41 PM, Andrew Goodbody <andrew.goodbody@lina=
ro.org> wrote:
> On 07/07/2025 14:06, Philip Molloy wrote:
>=20
> > From: Philip Molloy philip.molloy@analog.com
> >=20
> > Signed-off-by: Philip Molloy philip.molloy@analog.com
> > ---
> > drivers/serial/serial-uclass.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-ucl=
ass.c
> > index a08678dde4e..32108c381a4 100644
> > --- a/drivers/serial/serial-uclass.c
> > +++ b/drivers/serial/serial-uclass.c
> > @@ -109,7 +109,7 @@ static void serial_find_console_or_panic(void)
> > * from 1!).
> > *
> > * Failing that, get the device with sequence number 0, or in
> > - * extremis just the first working serial device we can find.
>=20
> That is not a typo. [1]
>=20
> This would be poorer grammar.
>=20
> 1) https://dictionary.cambridge.org/dictionary/english/in-extremis

Ha, yes, it is latin.[1] "extreme cases" would make more sense to me given =
the rest of the sentence is English. I'd be happy to change to "extreme cas=
es" or drop the patch.

[1]: https://en.wiktionary.org/wiki/in_extremis
