Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519B9C54E71
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C98908876E;
	Wed, 28 Aug 2024 12:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="irWKyB5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C624C88754; Wed, 28 Aug 2024 12:32:10 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 317DF8876E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c210e23651so1003938a12.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724841127; x=1725445927; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v8MyndjmpYlCIVwX4hrZZE6CxSZzoY0cnMzUCzq76fc=;
 b=irWKyB5U/2iqZWsXSwoG1dZDZhv4RIfaSKBGePI15b8RweSqdPsxkZEeiZtWuo91x1
 o/xLFf3JGiNcRvFW5SBNaC1UiSY1mTP3o4TY+MgWG7kq2K7NsDdUabpTCPFFjVjoifRA
 ufnA8eBl0nbNyRWk/kmxgBmzfyuUrcEUk6IDUeo+PWA0fBlVhb6M+szxxIuX94d7+5Nl
 EUDHPy947/x+A1cyQJLT5oolPgMzN9rt8uhFl0JSEcTpMnhFvxMoFYVV9RBdHkkng81S
 pOCuM2/LGpFYOJgTxf2cMmpfgtokPk9uxxZUGyH0IGYC2wvxktheuDpftRqsugdfqHaY
 Lx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724841127; x=1725445927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v8MyndjmpYlCIVwX4hrZZE6CxSZzoY0cnMzUCzq76fc=;
 b=XAGfo5UYWlYRw2r4tPoHZ+jLlMKIRzjnntRp81n8r2Ig/jKFnxq0N6nzJXskyEbhNt
 uowuNK71glKvQOrxMnpkXWQs6mh9jCllkiJEQRzIVloS4uK2sHjOaiKooN0oF8qiP9D2
 P0TInGPZj0IRTIbkpzi29tkT8pA4UzxFi6rOp7nFL2OjDH+GYMaua0P1/hc00xYOc/YN
 +nZeDl0EH+Q5o10AVMJ+5Ir/ejLaIEhevf3HTS1ENCiWh3hNyFVOIhCCKtTa/jcjGTUk
 bBpILixRNszfvlPqc41ogcQX3v9j06WD9cnfts6pCPP3BClEgdxKc1B637uXLd/O2HwC
 hCPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Z9xusTui1x1clEurcGEbHU4nt4IE9oxDqccONqpI5q2mhYR+WfxwxT7a0k9+MyCq3BBAxUQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwurFr6s3YtwPmOZH7H8Q0q4tPnQH54/FV99UXvS7HAwVbE+JkS
 LEQlPlxf0epcmu6F/3sREUkzqqFyS5N4Eqn6bALL6SSj7rs1UltxWuTsY4emClsbTUdygalsgZv
 21S3xuQIkH+JeiXdpyq1VY19sTms=
X-Google-Smtp-Source: AGHT+IHAHdGqjIgc+f1i9heMG//HsE+5Bg0kjtxJ5bgycPAG+X4+nngVbZxUK/DzqiX/9xpNkvkN2QspJa9D7jXYHBs=
X-Received: by 2002:a05:6402:42c3:b0:5c0:9fca:3ab4 with SMTP id
 4fb4d7f45d1cf-5c212bf8490mr1324024a12.0.1724841126717; Wed, 28 Aug 2024
 03:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-7-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTiVnw4P=-OaoStaLHHwKrkZhfJ4rEn-r9S2JtWuytVS9g@mail.gmail.com>
 <67229df0-7776-4426-a4ba-567cb1e5b6c2@genexis.eu>
In-Reply-To: <67229df0-7776-4426-a4ba-567cb1e5b6c2@genexis.eu>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 28 Aug 2024 11:31:55 +0100
Message-ID: <CALeDE9Op2=MU8jMS92U3kNxWX30VfqMuaknLNdJt=iGPT9AM6g@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 6/9] net/tcp: improve tcp framework, use better
 state machine
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

On Fri, 23 Aug 2024 at 16:31, Mikhail Kshevetskiy
<mikhail.kshevetskiy@genexis.eu> wrote:
>
> Unfortunately no. This patch change the tcp state machine and
> corresponding logic.

That should be better described in the commit message.

>  I tried to split "initial send value is always zero" fix to a separate
> patch but failed.
> See the patch description in v4 (when it will be sent).
> On 17.08.2024 18:58, Simon Glass wrote:
>
> > Hi Mikhail,
> >
> > On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
> > <mikhail.kshevetskiy@iopsys.eu> wrote:
> >> Changes:
> >>  * Fix initial send sequence always zero issue
> >>  * Use state machine close to RFC 9293. This should make TCP
> >>    transfers more reliable (now we can upload a huge array
> >>    of data from the board to external server)
> >>  * Improve TCP framework a lot. This should make tcp client
> >>    code much more simple.
> >>  * rewrite wget with new tcp stack
> >>  * rewrite fastboot_tcp with new tcp stack
> >>
> >> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> ---
> >>  include/net/tcp.h  | 171 +++++++--
> >>  include/net/wget.h |   8 -
> >>  net/fastboot_tcp.c | 190 +++++-----
> >>  net/net.c          |   4 +
> >>  net/tcp.c          | 837 ++++++++++++++++++++++++++++++++++-----------
> >>  net/wget.c         | 460 +++++++------------------
> >>  6 files changed, 992 insertions(+), 678 deletions(-)
> > Is it possible to split this patch up a bit?
> >
> > Regards,
> > Simon
