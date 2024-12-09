Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6239CE77182
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 13:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A57A889737;
	Mon,  9 Dec 2024 14:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KjM/ugDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A56D8973E; Mon,  9 Dec 2024 14:28:53 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC41789733
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 14:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa67f31a858so203489066b.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 05:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733750930; x=1734355730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mGw8qiEDri0AaWeGnMu8TUQ4YtbOgTxzjnIYvmWu568=;
 b=KjM/ugDIGPnP0g3z2/XZzIa0tgkT8wPLAVLpBO0RAaTOh2xIFiejGM7JdZ3bCu+dMN
 p1KDsJjoayAwC5M3TuIT1QU6gERa9XyzjrL8krqMf5zsY8zaGY89PLDXs2aSuC2jjcrC
 z6T3LNiz39hrD+NHafdmeCiO03vxCPoEp6wjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733750930; x=1734355730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mGw8qiEDri0AaWeGnMu8TUQ4YtbOgTxzjnIYvmWu568=;
 b=mdu9N9L/aw4sxFJlKtA8AmHR3gyLMVjzCHHmLcaHjVFV9b4gOBAZpvxs7cZxHlFN0e
 NIW7+ZWmaosZ2eG+Bg+LwG4wtpg/8eYQznCFO648nuiSI1JjRfkntLDEN5hhAF6lt69+
 NEHZ/qlj0GZfP4nP47oAZqAoIueSj08xHrJW+OwQA+nq/kz54pX4Dvv5bnPu6ZdvHKYO
 MrN3c+rmNO1dlr/J3a4dD9ZhrwRwYeQF8GfHzpg7tYS6+iy8nACGQYEK+/k6ZPX2XfDC
 NSy0mW/x2hQXxt7ltOrsPvGCHd+dKcqu7ms8QFDsQa3vaZU9DONIZ3DdK6lYwp83FCuJ
 WB4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtbz+fjm/qCIiozHZiw9oMXUsSeqLE5q2atAQEzi5un86o4IwxtHMPb0IBfQ+d4IbX9WXgWLo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7gmz+HD0tE+T6xXJf4KlYLBm8LP0+sNHKt9bMI2ki8Zl7kvmW
 3iwEGl3mAHCDGllHHRxDuAmSAA79bgxwIXmYIE+NgOy6D9Sit0H87719WQV1xOUL8FA/8tGOALU
 Q1YXlQDcycrABqZ34BDSx2AmfFA1WoEWFwVMl
X-Gm-Gg: ASbGncvHx9v79IfkTweQOhQS25aTUISwrHYV+gZA02ZJ5mWiPzPo28JqTp52yKezZF4
 5jr4iskIkTm5MhPVvi9/+JMlOVMsYaRHN
X-Google-Smtp-Source: AGHT+IHo7NlTWePkibPia2Hg4LxuRP7k6Fs8DIDqQ6WkDseOTV2pF1ZR42CAH1rs0ysbO3QEmLp7P+3bqKof/2i9X1A=
X-Received: by 2002:a17:906:1db2:b0:aa6:557a:c36f with SMTP id
 a640c23a62f3a-aa69ce01232mr33699866b.46.1733750930332; Mon, 09 Dec 2024
 05:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
 <35abc74c-0936-40db-b574-da3bec78bea5@rock-chips.com>
 <20241129032858.GG3600562@bill-the-cat>
In-Reply-To: <20241129032858.GG3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 06:28:38 -0700
Message-ID: <CAFLszTizqDKzKGoDmxugXfcOaETmGM=4CdTaXBp_2Mg006i1pA@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_stub: Sync the debug UART definition like other
 platform
To: Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom,

On Thu, 28 Nov 2024 at 20:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 29, 2024 at 11:22:50AM +0800, Kever Yang wrote:
> > Hi Tom, Simon,
> >
> >     With these two patches, I didn't see error report in efi_stub for
> > disable DEBUG_UART,
> >
> > but I still get CI build error below, but I can't identify what's the
> > problem, could you help to take a look:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/963215
>
> So, with:
>    88   60    2 /150            qemu-x86_64
>
> We know two boards failed to build. I don't know why buildman
> doesn't then list them as part of the summary, and please file an issue
> in Gitlab for Simon for that. However, we can try and figure it out by:
> ./tools/buildman/buildman -o /tmp -PEWM -x arm,powerpc --dry-run -v
> In that tree, and seeing what's listed there but not in the CI output
> summary.

Yes, something odd going on. I recently had a build failure in
efi-x86_app64 which sailed right through CI.

Regards,
Simon
