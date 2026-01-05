Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E4BCD0422
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B7F183A57;
	Tue,  6 Jan 2026 00:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TNuPSLEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0623583A7A; Tue,  6 Jan 2026 00:30:39 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF078839F1
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b728a43e410so78632466b.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767655836; x=1768260636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KjXRw+MZb89LIGjHcLyUa/0z8XHe4sTCVqHj5U2oyA8=;
 b=TNuPSLEftSNwJZYGx76PM7iha3PNs8hfv6/uC47vZFbK3LW9XpsBZDYEZNsA5uYSZK
 4SCSo3tIrwNqcXx1L7lNtQ+bTetOzVhaStpzQx/k5gmDppNeq1ENGJUT5V300bNCbCen
 MBGug6pRoApO9pEgBqT0hFNe3YOzKRR++ibqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655836; x=1768260636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjXRw+MZb89LIGjHcLyUa/0z8XHe4sTCVqHj5U2oyA8=;
 b=EFJXu9fTPiW65rSxiY5iYbTbKKtNhN+wg1bq3LgMhFcyOoJ2MUR+x1OH5+TptLTKk8
 2IwQzJ9OmXa8Wnx7enB9dOboEwhzec1ib0zZGNvx/moYBev5J/5B+qCcBHXJkJFHo/Ck
 j0LaJw7TaLue2z/4Tl9WiEBUz7HJanqCRYersCkwoG7Hrh6n/VudXO710uiPkVgege2o
 kX+4uSkmJDZ33Us1xP1ht5H0H7HPPWmI4m8mVC6Ba9V5pcsiIr+Srnvez5qqndFBD7T8
 IB39FDgt0vEp7RztfE2UOHcWkQ7yuSjUSeu49BstrmCLBSWaBZYBcKi7HnaKpnNX4huL
 TS2w==
X-Gm-Message-State: AOJu0Yz0lMjm+6UuwhVF6FGKA/Wcq+FpJEHkGi94+CUJiPhWl5o73COS
 vTzqNzWbL57cSAheGnN+hoAh8Wv03NcX+2ynKWWWXO4nCfWC/v3AXx4f4fJxZ9za33InCvGFdil
 tYlsG+Gqf+85WhaETmh7DCVO5AMsWTO138kNYYkmk
X-Gm-Gg: AY/fxX4uw96EQXsqCZBfs9qSQQ1Snq3ycjjooM21SGmDwvNjc30B/lI0C0yDX/7g8xl
 b+zsMt95ep9MCjov+Al9K4iQpXdMXayaatBMBZKxNCkjr7/W8ejxXNTXHr4rCiVOiruMNJ5dhpF
 WhI5H7NM2v++Sn31JG53QoMI64fkiASmv0lWRGoK/mvHoRrKpnsIaOgx4d4USbrE1jT0Uf31fpL
 Dh8jK+qkn74qlfQ6U68Dm+nHfEWTEuKwuQqcYajKkzepC4x8w4pqrgRTie2d35EpndemA==
X-Google-Smtp-Source: AGHT+IHb9GepCsLiz5FZmR33AqJYDiEO49mcpbk4NQjNs5fMLNFLU2YNtHEruOXoCt+lSoeGewzrMVVUWGHUW5lXzDM=
X-Received: by 2002:a17:907:930b:b0:b83:95c7:e984 with SMTP id
 a640c23a62f3a-b8426c0b7dfmr125922366b.49.1767655835923; Mon, 05 Jan 2026
 15:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20251216150841.331408-1-Wojciech.Dubowik@mt.com>
 <20251216150841.331408-3-Wojciech.Dubowik@mt.com>
 <CAFLszTjfwkAdc9LHvq29Y=hFtZcoqJdh64LPrBP0AJcr0VMAgw@mail.gmail.com>
 <aVt65_RL1KF2myTM@mt.com>
In-Reply-To: <aVt65_RL1KF2myTM@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Jan 2026 16:30:22 -0700
X-Gm-Features: AQt7F2rS3NLp17so-kp12zyNaqDPLyAYpuqPhnH2FXuxCj940B-xg_IVe5B0H-I
Message-ID: <CAFLszThu+motR_7ZZvpCo__ekPW6GKrz=sxVXnmzoG9dOWGBYQ@mail.gmail.com>
Subject: Re: EXTERNAL - [PATCH 2/2] binman: Accept pkcs11 URI tokens for
 capsule updates
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Wojciech,

On Mon, 5 Jan 2026 at 01:48, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> On Sat, Dec 27, 2025 at 07:52:36AM -0700, Simon Glass wrote:
> > Hi Wojciech,
> >
> > On Tue, 16 Dec 2025 at 08:09, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> > >
> > > With pkcs11 support in mkeficapsule we can now accept URI
> > > tokens and not only files.
> > >
> > > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > > ---
> > >  tools/binman/etype/efi_capsule.py | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
> > > index 9f06cc88e6e5..8ab022915d9d 100644
> > > --- a/tools/binman/etype/efi_capsule.py
> > > +++ b/tools/binman/etype/efi_capsule.py
> > > @@ -125,9 +125,9 @@ class Entry_efi_capsule(Entry_section):
> > >          private_key = ''
> > >          public_key_cert = ''
> > >          if self.auth:
> > > -            if not os.path.isabs(self.private_key):
> > > +            if not os.path.isabs(self.private_key) and not 'pkcs11:' in self.private_key:
> > >                  private_key =  tools.get_input_filename(self.private_key)
> > > -            if not os.path.isabs(self.public_key_cert):
> > > +            if not os.path.isabs(self.public_key_cert) and not 'pkcs11:' in self.public_key_cert:
> > >                  public_key_cert = tools.get_input_filename(self.public_key_cert)
> > >          data, payload, uniq = self.collect_contents_to_file(
> > >              self._entries.values(), 'capsule_in')
> > > --
> > > 2.47.3
> > >
> >
> > Does this have a test case?
>
> Not yet. I have seen that pkcs11 engine and softhsm test framework have been recently merged into
> next so I will try to make a testcase for it.

We may have lost the history here. You can mock things as needed to
simplify the test.

Regards,
Simon
