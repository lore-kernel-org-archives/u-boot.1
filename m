Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916EEF46126
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 14:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F86684154;
	Mon, 23 Mar 2026 15:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mb6ddPVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A763C84148; Mon, 23 Mar 2026 14:52:14 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56DE384114
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 14:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=charles.cc.zhang@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-50b2b2aa276so33749841cf.3
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 06:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774273931; cv=none;
 d=google.com; s=arc-20240605;
 b=XPEPHNSIu2MJFnFcxZxxop3FA6bxgUnvhgEtEcGggdb666h6Mhnf3tx0VC/gaP2MGW
 h+wi9Psluo73RmgF3R//fILXcNFlzNAcumR2hg8GLlw2TRmBohBGwXAbBircdi74+9iL
 myZL/RwhtYNslbt71hvuyQ+4qz/ChUwcmDk4Pgw3I+Owq7beTLI5Eixebni3W5cv7/Pe
 Hn+23N5kygOioL02rzDytMzA5+0QTKDjCMnxtNAC8qQEsWz8E5VwN/o1RqByx5hvNS/X
 wTwRG7U2zb3O1zQmrNtBruLqfYjBxs+fkv5/n25/UNQHdaPYEGhcUwCHjq0gj3XVlpUS
 ERBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wBzH3lNYpyZCYKKCdmACJZomT2ppYmon4IOG8UFwfgU=;
 fh=zL5PnHyHNS1kIg8FqiWP46dB1IqmBQwcT+IW6D0Qz3I=;
 b=YLSat4xIV2HVveGyrXE5Ov9eWofFQN8H273s9BlfFYvgHcuomdQMDB68nZnwDetBao
 YofjbkTAhdWaBJF1mzh57C6XX8cba0SdnpdvNKAI90FLL4GGqlDrjYlyNsH87uf7J2Kz
 HsNjLkckP9dMotAEAGJWZ+WtnSoPdDULp78T/VkyYGk6R8GBLE0uQ2fYHT60PNj2zX/S
 aLCYGSj+mG4w4TRhiYCgKPpyfmx/y4zW/ky0000WJuYp4dfkKpBF+CjewP9gNeXtsHHT
 GRoiKg5hhQhwXrYySVQtwtG4AN4j921C0+i39Mo31fUeSItAQUALRolCHggO9/T1B4aK
 4/FA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774273931; x=1774878731; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wBzH3lNYpyZCYKKCdmACJZomT2ppYmon4IOG8UFwfgU=;
 b=Mb6ddPVzD2qhwaD6mVG1PWPsQnbboXS7L66ewykpc/gvCDBy1nEO3yYcw5/dmmRFH3
 aIdwp3flwmY3vAPJYUjg9/yd5NU9K0pK7mI8fsZsmMGSl7Gc+1qdkgEs3xbFBTBlJPHg
 fBdyt7Y777S4ht3Kg7z7fDcypdpz/dDacD+mO7pIoDma8kPlwNZStb37MsFayh+yYBrG
 vTBbtC4jZIDQJ0hNh5MnF00bW/nitwz699R5kzE8DHpj4EwWgIGp1KuhySBF4CSLbcgl
 k8QOoP+60M+I+gHvUZpm1TmnZERwq3KSSVtulW74iu569KsXmo7F1vWt0Tw8zxjAhgJ0
 KVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774273931; x=1774878731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBzH3lNYpyZCYKKCdmACJZomT2ppYmon4IOG8UFwfgU=;
 b=S/KgziABXA6Y8wv4SCXjaxMWuXMcmz0JWAw3aVgKNRliauVbXPg43rAEDsD5WvRy4V
 W6FQpBW7aRscpeONPzypLu5WIXPW/EE/oIzj0hRiVaAZUgliZxc/oTAiUr/jgL8exw70
 tCsrFHyiuTiwj7gqIXx0J4uI24244i3HaKsaV62QJ5JkmmsAsmOpEkO4NFJjIG7p0D9o
 eJW80XcKe1m49q7mCe5zCPPx+Zrk/rfdMQOiSE2Lo0cUtZycVAfdFNhKbWPNNUe6X3W9
 bC8oWOV4pDPpR2wC7yhPzbfkCzilwm4QVbIJvT320XKylOgOe/t8nmwWocdbqxrJEcYj
 pCrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDwk9F68TyYA2c/lrF3KGBsnmZF6W58SUQjMkC49EwhBhMfv/Rzeian8KKLz5KsvjoKBjUKcw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywo8eiJkxWCH6+6ITxb4u5+TYTegzhxEktYkYFpJdNiBnb9NhWE
 aTPUgWymvf+jrTaOpTpp7skTGxDic59KC43uNFDFY5NqhJv1+a7I8hib0ZUHeFHv7h01yGZN58a
 yxxKqknNe3EBfcj1zXMxuxIApD+sQowc=
X-Gm-Gg: ATEYQzwy+ZziWCSbLh/9zJBf7LWQWgswaI6pmKuJwT9jF/rvmTb0sr5sFticqwPy34B
 EmAvJjbnDylAaPzBk3o/CF9YDCxP/BQlmyVrL/4QRZasTiZyOPGezY25Z5P5V5xtIAG95NWzAKM
 eClYS1eSVFXufPrLueno7ReK4eMa4fBMoXsKkPZtWH7YZ2LjtyxClhhIIay4OQ+qBDkgNWhDCSf
 mPJE7lKIi4R709Ug7aA6z7qHctrpESta6pP6DDeDDYFpERon7Fx6zR51aDly3d1ljBqkpHFwgJe
 koG8y8w=
X-Received: by 2002:a05:622a:1882:b0:50b:3a6d:db5f with SMTP id
 d75a77b69052e-50b3a6ddfe2mr184977001cf.64.1774273930924; Mon, 23 Mar 2026
 06:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260323110516.84423-1-charles.cc.zhang@gmail.com>
 <63086c74fc1885ded988325e3a3e474310919493.camel@siemens.com>
 <be0a3106-69ca-43f3-86de-0fd018e96e22@arm.com>
In-Reply-To: <be0a3106-69ca-43f3-86de-0fd018e96e22@arm.com>
From: Chencheng Zhang <charles.cc.zhang@gmail.com>
Date: Mon, 23 Mar 2026 14:51:59 +0100
X-Gm-Features: AQROBzCQFXIYLk1IoJfr4dKNiUGePm5D0p-dF3DCOfSoXXbimibi5JFFRtDl7Ew
Message-ID: <CAB08KXL5hBrbXS91SrJy22Ca7ZTPzb7D+3V0stVNvNibOoT=nQ@mail.gmail.com>
Subject: Re: [PATCH] net: tftp: fix malformed option string parsing
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: "Sverdlin,
 Alexander (SI B PRO TI EAC CCP)" <alexander.sverdlin@siemens.com>,
 "y.moog@phytec.de" <y.moog@phytec.de>, 
 "alvin@pqrs.dk" <alvin@pqrs.dk>, "trini@konsulko.com" <trini@konsulko.com>, 
 "l.anderweit@phytec.de" <l.anderweit@phytec.de>, 
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>, 
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
X-Mailman-Approved-At: Mon, 23 Mar 2026 15:12:56 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Sverdin and Jerome,

> Do you test with commit 1bc125becaa5 ("tiny-printf: emit \0 as %c")?
Thanks for pointing that out!
I have checked my baseline which is TI u-boot v2025-01.
Clearly 1bc125becaa5 is not included. I patched my baseline with
1bc125becaa5 and it works.

You can reject my patch.
BR/Chencheng

On Mon, 23 Mar 2026 at 13:10, Jerome Forissier <jerome.forissier@arm.com>
wrote:

>
>
> On 23/03/2026 12:58, Sverdlin, Alexander (SI B PRO TI EAC CCP) wrote:
> > Hi Chencheng,
> >
> > On Mon, 2026-03-23 at 12:05 +0100, Chencheng Zhang wrote:
> >> When formatting the TFTP options (tsize, blksize, windowsize), the
> >> code previously used sprintf() with embedded null bytes (%c). Because
> >> sprintf() returns the length excluding the terminating null byte,
> >> subsequent sprintf() calls overwrote the required null separators.
> >
> > I'm not convinced, the analysis explains the observed effect,
> >
> >> This caused the options to be concatenated into a single malformed
> >> string (e.g., "tsize0blksize1468") which breaks strict TFTP servers
> >                      ^^
> > ... as missing 0 byte between 'e' and '0' is not even at the end...
> >
> >> like atftpd, causing them to reply with empty packets or drop the
> >> connection.
> >>
> >> Fix this by explicitly using strcpy() for the option names and manually
> >> advancing the pointer to ensure the null bytes are preserved.
> >>
> >> Signed-off-by: Chencheng Zhang <charles.cc.zhang@gmail.com>
> >> ---
> >>  net/tftp.c | 33 +++++++++++++++++++++------------
> >>  1 file changed, 21 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/net/tftp.c b/net/tftp.c
> >> index 5f2e0a2bc06..5a8094791ab 100644
> >> --- a/net/tftp.c
> >> +++ b/net/tftp.c
> >> @@ -355,20 +355,29 @@ static void tftp_send(void)
> >>              debug("send option \"timeout %s\"\n", (char *)pkt);
> >>              pkt += strlen((char *)pkt) + 1;
> >>  #ifdef CONFIG_TFTP_TSIZE
> >> -            pkt += sprintf((char *)pkt, "tsize%c%u%c",
> >                                                  ^^^
> > ... of this format string.
>
> +1, and NACK. The original code is perfectly fine assuming a compliant
> snprintf() implementation.
>
> >
> > Are you using USE_TINY_PRINTF or not?
> > Do you test with commit 1bc125becaa5 ("tiny-printf: emit \0 as %c")?
>
>
> Nice hint :)
>
> Thanks,
> --
> Jerome
>
> >> -                            0, net_boot_file_size, 0);
> >> +            /* Write "tsize" + \0 */
> >> +            strcpy((char *)pkt, "tsize");
> >> +            pkt += 6; /* 5 chars + 1 null */
> >> +
> >> +            /* Write the value + \0 */
> >> +            pkt += sprintf((char *)pkt, "%u", net_boot_file_size) + 1;
> >>  #endif
> >> -            /* try for more effic. blk size */
> >> -            pkt += sprintf((char *)pkt, "blksize%c%d%c",
> >> -                            0, tftp_block_size_option, 0);
> >>
> >> -            /* try for more effic. window size.
> >> -             * Implemented only for tftp get.
> >> -             * Don't bother sending if it's 1
> >> -             */
> >> -            if (tftp_state == STATE_SEND_RRQ &&
> tftp_window_size_option > 1)
> >> -                    pkt += sprintf((char *)pkt, "windowsize%c%d%c",
> >> -                                    0, tftp_window_size_option, 0);
> >> +            /* Write "blksize" + \0 */
> >> +            strcpy((char *)pkt, "blksize");
> >> +            pkt += 8; /* 7 chars + 1 null */
> >> +
> >> +            /* Write the value + \0 */
> >> +            pkt += sprintf((char *)pkt, "%d", tftp_block_size_option)
> + 1;
> >> +
> >> +            if (tftp_state == STATE_SEND_RRQ &&
> tftp_window_size_option > 1) {
> >> +                    /* Write "windowsize" + \0 */
> >> +                    strcpy((char *)pkt, "windowsize");
> >> +                    pkt += 11; /* 10 chars + 1 null */
> >> +
> >> +                    /* Write the value + \0 */
> >> +                    pkt += sprintf((char *)pkt, "%d",
> tftp_window_size_option) + 1;
> >> +            }
> >>              len = pkt - xp;
> >>              break;
> >>
> >
>
>
