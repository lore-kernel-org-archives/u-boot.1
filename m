Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4DDC021BC
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 20:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D85B6807B1;
	Mon, 24 Feb 2025 21:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="cw8Rjr/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F0F80977; Mon, 24 Feb 2025 21:37:18 +0100 (CET)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [91.218.175.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDBEF80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 21:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1740429434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMeKM5BCip4PW7dEmpwOFljqVOPro5osVXKooMOnRuE=;
 b=cw8Rjr/ud8QyavfqydkGrYQgKjEp4qQNvXRa2syB8b3HU01Or1xDbg8EOFI4IC5Jk85IDg
 PcXVLQQE5luqznnKUZNI/j/nqfG/FR/73wBBXLdsD3SfBRvKIDL8ZWxy2KuFz9SgyZUdKw
 E/4hkZArysnfRaP8NZ/AsObtPv92fB+GTpNNotv5ND8GnrFrmLAke7PNyIVd2j1edxmSLu
 Ja/vixecAOGWy5W7LPxZbJMsLzGL45gdRyhXC9kjOLIit2UHKt9C3mBJXPvlFz6Z+V16Tm
 CCwH0YGWVxWPF66XWYHlC6/CCUuRZdiH0+iglquf1Os62DiFVKWgB31Ok/zY0Q==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 20:36:21 +0000
Message-Id: <D80YQ3XCAFQO.37F9XYT25NG34@postmarketos.org>
To: <u-boot-amlogic@groups.io>, <neil.armstrong@linaro.org>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH 0/2] tools: mkimage: Add Amlogic Boot Image type
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: "Ferass El Hafidi" <vitali64pmemail@protonmail.com>, <u-boot@lists.denx.de>
References: <20250103215904.2590769-1-jonas@kwiboo.se>
 <b251b3a1-8bd5-4814-b3b9-64b8d23dc682@linaro.org>
In-Reply-To: <b251b3a1-8bd5-4814-b3b9-64b8d23dc682@linaro.org>
X-Migadu-Flow: FLOW_OUT
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

Hi Neil,

On Mon Feb 24, 2025 at 7:56 PM UTC, Neil Armstrong via groups.io wrote:
> Jonas, f_,
>
> On 03/01/2025 22:58, Jonas Karlman wrote:
> > Add support for creating an Amlogic Boot Image that pass CHK in BL1 on
> > Amlogic AArch64 SoCs.
> >=20
> > The first patch add the new amlimage type. The second patch add a eMMC
> > relocation workaround that can be used to generate a boot image that ca=
n
> > be booted from both eMMC and SD-card on GXBB.
> >=20
> > The amlimage type and the eMMC relocation workaround is loosely based o=
n
> > my prior work, aml_chksum, a small tool that can write boot image
> > headers with updated offsets and checksums, see [1].
> >=20
> > This has been tested booting a very limited U-Boot SPL on boards with
> > e.g. S905, S922X, S905X3 and A311D SoCs.
> >=20
> > [1] https://github.com/Kwiboo/u-boot/commit/6d0a17632922077a2e64b13ae1a=
6bdf0024b718f
>
> Is this serie ready to be taken ? what's missing ?
>

I suppose it is ready, but I'd wait for Jonas' confirmation on this.

> Neil
>
> >=20
> > Jonas Karlman (2):
> >    tools: mkimage: Add Amlogic Boot Image type
> >    tools: amlimage: Add support for GXBB eMMC header
> >=20
> >   MAINTAINERS                    |   1 +
> >   boot/image.c                   |   1 +
> >   include/image.h                |   1 +
> >   tools/Makefile                 |   1 +
> >   tools/amlimage-gxbb-relocate.c |  79 +++++++++
> >   tools/amlimage.c               | 283 ++++++++++++++++++++++++++++++++=
+
> >   6 files changed, 366 insertions(+)
> >   create mode 100644 tools/amlimage-gxbb-relocate.c
> >   create mode 100644 tools/amlimage.c
> >=20
