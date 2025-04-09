Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B288C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 16:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB5083903;
	Wed,  9 Apr 2025 18:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dYLF4+Bs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FE983900; Wed,  9 Apr 2025 18:35:30 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 512B6838DD
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 18:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac6e8cf9132so965385566b.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744216528; x=1744821328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=glFp+iWWaRipfK1+coPjpgLX7lCbFL6BoU5PF8am0gM=;
 b=dYLF4+Bs+4OyoLNqITOVKqUL8ZsIyxDiNYq96GNoJSVKaud50cYJES6oCOBZtVKYLC
 dTAXJcn0iwSqXx819uh22ALISiVFC50MI/ktUtS3ESzdjaPNvd+EreyWcDadefIGxXuh
 RQVHNTFr6irEv2+z9oU/QaJoA6g1HHTY9W1xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744216528; x=1744821328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=glFp+iWWaRipfK1+coPjpgLX7lCbFL6BoU5PF8am0gM=;
 b=L3H6VUPLqjQpG8bh/btOD/ZarxS/5VUFnywqaqIeIVLV8TNh7Qe/46KOq1nyLuPWdP
 lZ+N49Z23dRJ6r3KqBS/QFkp3wyDvVH9al1HOJe4kRlvoMbRMsuNpsAj4pwnAwpaWZhW
 juEmjdBRP4+MYEQE5/qSQN135qJ7Yvw/m8r91QNZu+89AVw0znf57ravJzTMrKMwTFPg
 h1HjUoDpswEHsoqCGnxmf3GvQalw13UrNzeu/Ls4q5ch3h8+V5jf71vEHX1QbCXG3/Fn
 ARIF4jYcC7gr+WFwFQzI7DILUwh+pg8xyQzVJ/1aFWKX21IICL3NKtR12Js3Ssh/W/m6
 M5Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjsaYkjcoHngFp/iE9JhIIyYpJ+MagQeM6VKzLd80NfWo3GtYgZRVel1cG5h+EjnUtWrePbjE=@lists.denx.de
X-Gm-Message-State: AOJu0YxJLDeb21veyx6GmHd88XRYZOF77SvgnIE56NsTFk/wWHRDhbpm
 Utz6DNBd4RtazhnNUtJp+6ixiKAeIA/dPu/4so3KXs+B3j8/P1RiowAmmmRVvO2Ie1fJsRwTOBE
 8VL5wok1RG7DJxwv9CrlmBnZjl7JSx1U0KeR6
X-Gm-Gg: ASbGncs4slnA3iqO5Qq9AySxiacQRDLi2VrdgR2uBKV7e3tkMWl7WD6nJBp04FGE/ab
 8TRYAJpoMAVjVQbuy/6hJ1a9hdQFpepm6loW1P8LHM8A2BIAdlW02u0EzR1MxxnLgpPPUsrFYfg
 +OUQDu3oDf7VAcqWopJ+6FWA4=
X-Google-Smtp-Source: AGHT+IGhzZIWT9yMlBSJfsef9XAkQ+pkd1Am/NxFzj7JqMyOICj5tkXFDE58GZZmbgx91GgqG4yKFQpw1xL75WiWeqU=
X-Received: by 2002:a17:907:3fa0:b0:ac2:2ba5:5471 with SMTP id
 a640c23a62f3a-aca9b69523fmr338622166b.24.1744216527387; Wed, 09 Apr 2025
 09:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-10-jonas@kwiboo.se>
 <5d3c9e7f-336b-4b67-a7f4-a25a61b0908e@cherry.de>
 <ac68b883-021c-43ac-b834-bafa54e7182b@kwiboo.se>
 <887d7a5c-0ba7-4e62-bee2-8e5c159710c8@cherry.de>
In-Reply-To: <887d7a5c-0ba7-4e62-bee2-8e5c159710c8@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Apr 2025 10:35:15 -0600
X-Gm-Features: ATxdqUErNYXOFKmzJJYCGJrjMiOvcyYFAkwWvlwzoYsa3N08Bn7mzzWXVoXROfM
Message-ID: <CAFLszThQQdU2v0TjkmdhFNC8mNKNmOWhZyZS6VtwYG_z6fFypw@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] rockchip: binman: Support use of crc32 for
 SPL_FIT_SIGNATURE
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
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

Hi Quentin,

On Wed, 9 Apr 2025 at 10:11, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Jonas,
>
> On 4/9/25 5:38 PM, Jonas Karlman wrote:
> > Hi Quentin,
> >
> > On 2025-04-09 13:06, Quentin Schulz wrote:
> >> Hi Jonas,
> >>
> >> On 3/29/25 4:06 PM, Jonas Karlman wrote:
> >>> Use of SHA256 checksum validation on ARMv7 SoCs can be very time
> >>> consuming compared to ARMv8 SoCs with Crypto Extensions.
> >>>
> >>> Add support for use of the crc32 hash algo when SHA256 is not supported.
> >>> Also use a HAS_HASH to simplify the ifdefs when no known hash algo is
> >>> compiled.
> >>>
> >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>
> >> I don't know enough about general security but this very much looks like
> >> a bad idea to me.
> >>
> >> https://web.archive.org/web/20170210173741/http://www.derkeiler.com/Newsgroups/sci.crypt/2003-07/1451.html
> >>
> >> """
> >> While properly designed CRC's are good at detecting random errors in
> >> the data (due to e.g. line noise), the CRC is useless as a secure
> >> indicator of intentional manipulation of the data. And this is
> >> because it's not hard at all to modify the data to produce any CRC
> >> you desire (e.g. the same CRC as the original data, to try to
> >> disguise your data manipulation).
> >> """
> >>
> >> (yes I took the "first" link my web search engine returned me, thanks
> >> confirmation bias!).
> >
> > I am fully aware, and the fallback to use crc32, and current primarily
> > use of sha256, should not be considered a security feature. It is
> > intended purely for a checksum validation of the binary blob after it
> > has been loaded into memory and before U-Boot otherwise unconditionally
> > jumps to and execute the loaded blob of binary code.
> >
> >>
> >> I don't want to give people a false sense of security. If it really
> >> comes down to it, I'd rather have an explicit Kconfig symbol to set this
> >> value (maybe have a `choice` even) and be very clear about security
> >> implications.
> >
> > Prior to the addition of the hash { algo=sha256 }, there was no checksum
> > test and U-Boot SPL would unconditionally jump to the loaded data, even
> > if it had been corrupted, was only halfway written or otherwise
> > overwritten.
> >
> > The addition of crc32 instead of sha256 is just to allow older board
> > variants with weaker SoCs to at least have some sort of checksum
> > validation in use without affecting the boot time too much.
> >
> > On my rk3228 board, validation using sha256 could take a few seconds,
> > and with crc32 it could be measured in ms.
> >
> > To me, having at least some default checksum validation is preferred
> > over none at all.
> >
>
> Except if this confuses people into thinking they have a secure system
> except they use CRC32 instead of something more appropriate like SHA256.
>
> It seems like the "hash" node presence doesn't mean a FIT conf or image
> node is signed. I also don't see many device trees with a signature
> node... which is kinda odd. Looking a bit into the signature node in the
> spec and binman tests, it's not clear to me if the hash node is reused
> by the signature node if if exists and if their algo should match and
> what exactly is checked by the signature node (like signing the hash
> string contained in the hash node(s) listed in sign-images property, or
> (re-)generating a hash of those and signing it at build time?
>
> If
> a) it is not possible to have a hash node's algo differ from a signature
> node's algo, then I'm fine with this as crc32 won't be allowed
> b) the signature node regenerates a hash regardless of the hash in the
> hash node, meaning the signature will be "appropriately secure"
> regardless of the algorithm listed in the hash node, then I'm fine with
> it too,
> c) it is possible to sign a crc32 hash, don't want it :)
>
> @Simon, do you have some hints about this?

In fit.py :
                # The hash subnodes here are for mkimage, not binman.
                entry.SetUpdateHash(False)

so yes they are independent, so far as Binman is concerned.

But of course, configuration signing relies on hashes in the image
nodes, so at least one strong hash is needed.

Regards,
Simon
