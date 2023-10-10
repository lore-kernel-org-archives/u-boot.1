Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53FFCD8CAB
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 16:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F4B86B75;
	Tue, 10 Oct 2023 18:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H5OKr7bO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1D3386B84; Tue, 10 Oct 2023 18:19:51 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B20586B74
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 18:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=monakov.y@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-66cef33a4bdso5629446d6.1
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696954785; x=1697559585; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzqyc44C/N+Bi5nP285ENTzfzE+fKy4jg+WpWPYT67M=;
 b=H5OKr7bOy7uRrIG+Pxd/JFwCLOxzwMWboR3RPui3iZ1GZcU549Im6Mldm+Ct4HCeIv
 2mbOYqKadQ7dwcP2OnJ7CVVfuGrrY6qneV9wVW8DiEnXXks1Yy3XZ9TJKqhMITUzEE7Q
 Xiw0PcskG6RqweO1/LIjinMwrOKAStNT74c8rFTRSE8x+0yJIoxkTT//4LpLIzZCANvJ
 ZWoCgQz8joDwqO8oePXbvKfzI/APPc6qPCkkNGGF149yZUqgmKK1cw/YY5FEaA/eICGp
 n2VFT24f+RQecCWMRLyI44Xjz9xqX1JbJlMp3Q16cFh4MGQ9AYjFTsprcOVGbGjGdglH
 X3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696954785; x=1697559585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzqyc44C/N+Bi5nP285ENTzfzE+fKy4jg+WpWPYT67M=;
 b=QyHSmDVUb5il2BGJJ8hZHhy3Wdis02IzZMj/qLILj9PRI94B8N6o2lQOw5SiHmGWjH
 Jdj21AWsZkistQWiqipErx5gNQwj6PbRW3YPOGE6R0aBHjbpSZAAO/RiuiAOagHkz4E2
 BFQ0d/STU9DO9IbA/wjhBq0/tBdFoDf7w6WXCsrYwLCbM43JndIpjR5RXASgYtFF6iIc
 HYcJ1s1dbzaSKjlVxZdZGbNvpvx6BUtasZgwXZanwDuDr8RO+FNXGuQwYfDb+0zg2M79
 L5OMMnm8H9gVTPaoHMjUcoUK1F/3Q4dBF2QT9/gYJLM3iVGerSi0Gd0G1WkCrmkWqbSX
 ZDZw==
X-Gm-Message-State: AOJu0YyB13hvJInRueSGV9p6l/VarhTuEcHz2P7vrJwBVRsVd9YHr8nV
 aruf0g0pvc2eSyauBMNA8mxmJMJX0wg0iL9tMZrRsmsaP1XIzjrW
X-Google-Smtp-Source: AGHT+IFxn0ObGFKdJvxgw4ZvVRM2ZjPP4HsjbjRqlW07HCBY9lnKXk9fufVcdo3yiw9Mg1h+eIi/4CkZpbVK8GFlTUA=
X-Received: by 2002:a05:6214:1907:b0:65b:1ad4:ca7e with SMTP id
 er7-20020a056214190700b0065b1ad4ca7emr17764348qvb.56.1696954785307; Tue, 10
 Oct 2023 09:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <775fa336fa5bfb2b9e1e892ee631bd743ea12364.camel@gmail.com>
 <CAPnjgZ2Zp6cCPxLG7g=F0+FkDLJMheuiw-GeGbsTtH5KoAPGjg@mail.gmail.com>
In-Reply-To: <CAPnjgZ2Zp6cCPxLG7g=F0+FkDLJMheuiw-GeGbsTtH5KoAPGjg@mail.gmail.com>
From: Yurii Monakov <monakov.y@gmail.com>
Date: Tue, 10 Oct 2023 19:19:34 +0300
Message-ID: <CAM-z4v6y5pRKofG6XaO01fvPkDmqL+1D0sW8fG2_=yOPjUufMQ@mail.gmail.com>
Subject: Re: [PATCH v3] cli: Consume invalid escape sequences early
To: Simon Glass <sjg@google.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Simon,

On Tue, Oct 10, 2023 at 5:58=E2=80=AFPM Simon Glass <sjg@google.com> wrote:
>
> On Tue, 10 Oct 2023 at 02:16, Yurii Monakov <monakov.y@gmail.com> wrote:
> >
> > Unexpected 'Esc' key presses are accumulated internally, even if it is
> > already clear that the current escape sequence is invalid. This results
> > in weird behaviour. For example, the next character after 'Esc' key
> > simply disappears from input and 'Unknown command' is printed
> > after 'Enter'.
> >
> > This commit fixes some issues with extra 'Esc' keys entered by user:
> >
> > 1. Sequence <Esc><Esc><Enter> right after autoboot stop gives:
> > =3D>
> > nknown command 'ry 'help'
> > =3D>
> > 2. Sequence <Esc><p><r><i><Enter> gives:
> > =3D> ri
> > Unknown command 'ri' - try 'help'
> > =3D>
> > 3. Extra 'Esc' key presses break backspace functionality.
> >
> > Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
> > ---
> > Changes for v2:
> > - add tests and reword commit message
> > Changes for v3:
> > - fix indentation
> >
> >  common/cli_getch.c  |  2 ++
> >  test/common/cread.c | 12 ++++++++++++
> >  2 files changed, 14 insertions(+)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Unfortunately this shows a design flaw, one which is hard to fix in gener=
al. But this does improve it.
>
> The flaw is that we assume that character sequences have a time gap betwe=
en them, which allows figuring out when a sequence has finished.
>
> But when starting up there may be buffered output with no gaps. I don't t=
hink there is a general fix for this problem. One option is to have a speci=
al mode at the start, where escape sequences are ignored. But the user may =
press an arrow key on startup.
>
> So I don't have anything much to suggest here. Let's see how this fix goe=
s. Perhaps it is enough.
>
> Regards,
> Simon

> One option is to have a special mode at the start, where escape sequences=
 are ignored
I think that there is no reason to emit parts of invalid escape
sequences, as current code does.
There is a very little chance (at least for a human being) to input
such sequences by intent.

> But the user may press an arrow key on startup.
As a fix, autoboot code can check for 'Esc' and keep it as a part of
input string.

Best Regards,
Yurii
