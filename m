Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0B8C61D98
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D257387622;
	Tue, 21 Nov 2023 23:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X+YFZVK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E138744F; Tue, 21 Nov 2023 23:12:18 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8BCE8764A
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-da0cfcb9f40so5981584276.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604731; x=1701209531; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wjAkgUP1f5Ay3YQVQU+fpcb2btr2ePrq+JfXo0QGd/8=;
 b=X+YFZVK+LVdRXMKKDEANdOWz79RMDuCBq/CnKIfi6FATPeKtYVOX0OUd4fd3bfIlvC
 Q3wElzL5kbhHbs457K7EZ5R849e+TIqPxUmlcP0SUutFgcEy7i8VI3rf1weuJFp+qeTL
 Nc5fvSTQL6WZMx+PXnwLT3+niZTTS61JgETBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604731; x=1701209531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wjAkgUP1f5Ay3YQVQU+fpcb2btr2ePrq+JfXo0QGd/8=;
 b=UXFHs2osrdW2aK1IoQDJ10KeGQkf3qiOYqmPGStIM1lu/8u4h9A2FHDJwJYTSWzwDh
 atIDkrJB+TxIDj7mjZRHThmW/TuCevpqZInOwPOyhMzCzxZukCJ+Zt3UDPx15cO001JX
 NAvjJwzdl35otl/skg+hJFjQqi/UsILVwwT+x1gf5GR1KNlCSL/WYaw2TM3aSNNr1J/a
 Ilb/aQnt8Xx1OY/vnMb0mgWXVevlt49RZkQlnbNDMo6NN9998ud4+HfL1EwFlPNdnZvo
 w/MeyAPM3jhCByuXO36RH3nn4E4OpaDI2X1dFdifLPT3+6dou0Er2c+yHUiCNPH8SrDq
 y95A==
X-Gm-Message-State: AOJu0Yw7QEG4IS6t8x57We7+Q0Io6r1ZKQLLjepDkMRnWe62FCWkox4d
 JMHp/ysnV6RjC+E3SYNwQ0YTXq2h4lgC+H+gdelK2Q==
X-Google-Smtp-Source: AGHT+IHWwYvd5nCNiNTV5xyGKTxT2aHd5HL5+lZYRYdS/gR+jJvipViO3RfaNRk9q8AT6aaweZhhSkIWNWbyie6kcsk=
X-Received: by 2002:a05:6902:11cc:b0:d9a:3992:192d with SMTP id
 n12-20020a05690211cc00b00d9a3992192dmr395276ybu.16.1700604730539; Tue, 21 Nov
 2023 14:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
In-Reply-To: <20231121070028.2614095-2-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:11:50 -0700
Message-ID: <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
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

Hi Sughosh,

On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add support for specifying the parameters needed for capsule
> generation through a config file, instead of passing them through
> command-line. Parameters for more than a single capsule file can be
> specified, resulting in generation of multiple capsules through a
> single invocation of the command.
>
> The config file can then be passed to the mkeficapsule tool in such
> manner
>
>  $ ./tools/mkeficapsule -f <path/to/the/config/file>
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  tools/Kconfig              |  15 ++
>  tools/Makefile             |   1 +
>  tools/eficapsule.h         | 114 ++++++++++++
>  tools/mkeficapsule.c       |  87 +++++----
>  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 538 insertions(+), 31 deletions(-)
>  create mode 100644 tools/mkeficapsule_parse.c

This patch keeps coming back :-)

Can we not add multiple capsules in the binman description? Why do we
need a new file format? How can binman decode images produced in this
way?

Also, could we get sandbox to produce one EFI capsule as part of the
normal build? I think that discussion trailed off.

Regards,
Simon
