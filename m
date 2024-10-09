Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2399ACF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE3589056;
	Wed,  9 Oct 2024 03:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yv/YhH1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B7589032; Wed,  9 Oct 2024 03:51:36 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D4078903B
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e15fe56c9so969816b3a.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438692; x=1729043492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6UoeL/85EUuhnXx49i45aFvSJPulakwArYxzFJdgAuA=;
 b=Yv/YhH1SoeJCuhi89Vci8pytRSRr+/6FTluICjc+Jnw429peVeIR+TUIqTNh+jzAFf
 FPDpytJchvjaUqJ2OIEwWUvyDkXHBipODmRCUc+jgOdJ6epqKIZOOaGpdqAJEfuIurKs
 FbRcQtS8WlNgrdFeQfwPINPXpKNOK1zTxhvt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438692; x=1729043492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6UoeL/85EUuhnXx49i45aFvSJPulakwArYxzFJdgAuA=;
 b=VP4qmeayp6Va3hFTkLiXmBEIFolY2Om6oqHmdTQoq9kJZ/NunlVGzKwAPXVkM3528a
 irTdfrL8UEvtzt3P7p0SRzb4XDeWfPfIAkKCH/F3y9OJeAbH4UxEyC+HMFNElvwQWj1e
 cmbg5s2diodBJDWhwk/iboVR7NGSX+1vpCGyTcB7MAcxY3YJavgeUpdBc3JDu7SWXCzT
 OJzW1R10WINFFgHsuoI1PNk5wFhRtc+JyLUIT671MOn0MRTtZU/QJ5jF6QbJygRLDNEH
 h7Cw+F5e2eAU806rNNmsOp1yfHvfKlfvGedJFyjJE5MJMPKR4XTkkx2ZZCRfFU8F79K6
 KY2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOyJUWUR+coOYSGC4RU3G/pC/3rfWyy/XreKansIOMIq7PV/PdBaZ9lccb9AVosh6bCt+jDpk=@lists.denx.de
X-Gm-Message-State: AOJu0YwWrcEFKG8FhkMnEZpZArxO6+W1lPJtUjzfTxBJQsVKkLV5VIP+
 MAt50jZu6nsyfzBLBjvN4rwOIoKMTF52RpxhIbTXCL5NODQjzYyen+9s8CjXEtiXfn6aAnFyCti
 8hYx5qo07OrPfTvCDHET8qRslJ+RFOqbYQQMB
X-Google-Smtp-Source: AGHT+IEeAy8k2zR6cyaSb4MhdsS1rfYIyTUNBc4CqN8whHo8SB6HUzv5jfD0UTSHfu/UO/DqVwIZShoU9prUXneVWz8=
X-Received: by 2002:a05:6a21:114d:b0:1d6:e22e:1571 with SMTP id
 adf61e73a8af0-1d8a3bc46eamr1251425637.1.1728438692724; Tue, 08 Oct 2024
 18:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241002132633.246942-1-martyn.welch@collabora.com>
 <20241002132633.246942-3-martyn.welch@collabora.com>
In-Reply-To: <20241002132633.246942-3-martyn.welch@collabora.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:01 -0600
Message-ID: <CAFLszTgYxVUzvkwynZcdsQfLKTAypqBdqA=gOHpdJydzmZoJ6g@mail.gmail.com>
Subject: Re: [PATCH 3/4] bootstd: Add command to enable setting of bootmeth
 specific properties
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 2 Oct 2024 at 07:26, Martyn Welch <martyn.welch@collabora.com> wrote:
>
> We have previously added logic to allow a "fallback" option to be
> specified in the extlinux configuration. Provide a command that allows
> us to set this as the preferred default option when booting.
>
> Combined with the bootcount functionality, this allows the "altbootcmd"
> to provide a means of falling back to a previously known good state
> after a failed update. For example, if "bootcmd" is set to:
>
>     bootflow scan -lb
>
> We would set "altbootcmd" to:
>
>     bootmeth set extlinux fallback 1; bootflow scan -lb
>
> Causing the boot process to boot from the fallback option.
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
>  boot/bootmeth-uclass.c   | 25 ++++++++++++++
>  boot/bootmeth_extlinux.c | 73 +++++++++++++++++++++++++++++++++++++++-
>  cmd/bootmeth.c           | 25 ++++++++++++--
>  include/bootmeth.h       | 31 +++++++++++++++++
>  4 files changed, 151 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

But please update the documentation too - for the command and for the
new bootstd feature
