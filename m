Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D470FC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 15:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 468D684B8D;
	Mon, 13 Jul 2026 17:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G4zaGgUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BBB984C06; Mon, 13 Jul 2026 17:20:51 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 875BE84AED
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 17:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso4876715a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:20:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783956048; cv=none;
 d=google.com; s=arc-20260327;
 b=CgeCuw+5xzVlsuxyt7dI7mnU/wg2l4XNxoEltHZ4SENQibV+soNcwjRf1h5meGy6Z/
 YW5XrLryi3daDiMT5wvw0L9as/0DIjYwftndz9JeZOsc7ugllNgn4qJI8CYIw41mN6XE
 +eQyV+sN7Hun3cqEGS4p+5AVEJeWo8zUJr8OOeQaFCFuTJ7RKKzS6y+WusIx66s9Jhxk
 HCP00GoBQMHEwdkFffComjOX4E3AUaMoTTbGCL6jdF72RyryErk6rQVoizTkZdkh4Y5g
 ySOzXsqyp01qMKa4rVzsmbwbbJlU8qzSyagB23Vm+WfSduIVvQW3Yv0PeS5uquwRIieq
 8FNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6Rj4HTbdUHGrwWr5PeNeE7YGKlqVQhPtfgETVHJq2mo=;
 fh=pEcgj5Pv3QWacY1LguETmxA2c0tiNC7Y6zsDnHbd3k8=;
 b=kWB4sAoPqDZpKnpjx7AmW4JWtd1CQhbhrJckdmW5aujCAMwf9eTwPPKxkAHLsb0LEj
 X07mayS5sLYJelJpKFqtRvy3qFQkHlYekGxXtix7YV7uIqsEfVoEfW6dm78s1xjYCSKp
 M9ClZ6tGgsyn+s3Ep763Y0/M2r/pOYbjRmIupUw3MALTHbeFOe/hjTMBzZM9QblK8anz
 1FRVUSixhEl+/jz8N2ZSveiBAtqO83M1oJG9b7mGqQMOLU1iT5LJ6jMh6NLbJdSluwZk
 /Oqa+RMbTGAGR/8boNKl6HcohDR7Wp1u8gyfXtsT8VbKTSAu+ZyxdqXMaZQmf+o6qJiY
 K4OQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783956048; x=1784560848; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6Rj4HTbdUHGrwWr5PeNeE7YGKlqVQhPtfgETVHJq2mo=;
 b=G4zaGgUwSce7Hv0bmCZpC5pCe23qGl1KQhmnvI8dvQExIJgZU/hjrCXs2aQqvrBW2I
 uhANW20zPLEKiJiir6AgySNFTDES7GnD3XOTKyahK4di6lRZ4eQSQpqECPFW476TUDvV
 mGN5z7eztNlABnUn5y2Yyu7nmQlBZg2NjevnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956048; x=1784560848;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6Rj4HTbdUHGrwWr5PeNeE7YGKlqVQhPtfgETVHJq2mo=;
 b=Dw3wePnz/cs5mE9FNFTQ/0uAf8YiE7nYlarKTIicOF76SbaacEPpUwCenB+LcN086W
 8nwxFyxRQanT6IUEmV/2Rc14D0+mnAiy+lc/quX+7OVbAMu7fG6mFoAULQONNInepkxw
 XspIuAQt0UbaBp5avFKwDc70haXvFjEdqxf78aesb7NRC3p8/SyBZqQPon2RlELdGaT8
 lu6XBgzFSPVfEFiOIC2woBc//4g2yHbWnDQVMh6N0l6d103Uq5xjFuw5a18oc/ZzKzq2
 8PrIRCLD5Md2pny+IVsBKKp1zOuMZ4jVXeg5ozm6F7Ym7yofJNMw2sE6qbcZ6IB6GGbN
 EB/Q==
X-Gm-Message-State: AOJu0YwlUW+bXVjBfds4CoP+5gpBluPkUWHyT2PdEHI+wlFP6IXKRylK
 kL69w82BxjqDBlIIzWfO+vT37N2BPy3R4K9P+1UaUqdXEPS5vLWFF3B6JxmM4d0Z/LSM+tR4cYu
 iSEirg3bVTE0JwErFs0UsorfKVANvGgaAOM8XiHNnvfW/jPybD7UOmr2W
X-Gm-Gg: AfdE7clQJZjALr/uxIjck25dyr2QNWgU/9tTz6rHzDo6LL0LpRwJ99iLfsonojHNSAV
 SEz2YqOSR8qYYKtM9yMsS0ZUczWhVLrBFhSTiGyHEDNJPV7j33pWMOJgmx+5hdeEgF8C0vju0RX
 ibvWoTgJ7H3xG8qgairmDv+0myQ1Eac3LYRi6UUtp3P+N1sXLcqa5A4Gugkk1n9W4+v9w4UvQO7
 d3XdHQKR63DxwhfYwIZ5JYOBpv7wzrEx0Fx1QPXJjxI/TBZO1ulaVM7N7RibCsOR+QyKWo=
X-Received: by 2002:a05:6402:5253:b0:69a:a4cb:2882 with SMTP id
 4fb4d7f45d1cf-69c5f0bb815mr4171881a12.9.1783956047967; Mon, 13 Jul 2026
 08:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
 <20260708203711.849489-11-rv@rasmusvillemoes.dk>
 <FA-v9BFSUTj-TRyvSvaYa8kaUuphTp9fZRIO_BnXaIe0fdFBItff9747oLX6ihRtP0d73XCcmuSDxqsGffREpw==@protonmail.internalid>
 <CAFLszTi=ytF1MTd4Egvo3LZDgrP5KZ5=K4Uz5jUVFcRkOagAgQ@mail.gmail.com>
 <8733xntj4v.fsf@rasmusvillemoes.dk>
In-Reply-To: <8733xntj4v.fsf@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 09:20:35 -0600
X-Gm-Features: AUfX_mw-eLoSFURG_4ocKixQKAPYsb7g3JbKs7VcroGsbngbdMqVfDgZ2CidQeQ
Message-ID: <CAFLszTiup34hQMw8z7MRnN5NXXKUmJEGoiON6A0M0FHuwxwOwA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] test: add test of 'config' command
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Mon, 13 Jul 2026 at 01:59, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
>
> On Sun, Jul 12 2026, "Simon Glass" <sjg@chromium.org> wrote:
>
> > Hi Rasmus,
> >
> > On 2026-07-08T20:37:01, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> >> test: add test of 'config' command
> >>
> >> Add some test cases for the 'config' command, including the ability to
> >> filter the output.
> >>
> >> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> >>
> >> test/cmd/Makefile |  1 +
> >>  test/cmd/config.c | 28 ++++++++++++++++++++++++++++
> >>  2 files changed, 29 insertions(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> >> diff --git a/test/cmd/config.c b/test/cmd/config.c
> >> @@ -0,0 +1,28 @@
> >> +     ut_assertok(run_command('config', 0));
> >> +     ut_assert_skip_to_line("# Automatically generated file; DO NOT EDIT.");
> >> +     ut_assert_skip_to_linen("# Compiler:");
> >> +     ut_assert_skip_to_line('CONFIG_CMD_CONFIG=y');
> >> +
> >> +     console_record_reset_enable();
> >
> > Just to check, is there a reason the first block doesn't finish with
> > ut_assert_console_end() before the reset? The other invocations round
> > out with it, and it would be nice to verify we consumed to a known
> > point rather than discarding whatever was left.
>
> Yes. When printing the whole .config, I know that there'll be the
> commented out lines I check for at the top, and obviously also the
> CMD_CONFIG option itself must be enabled. But I don't know anything else
> about what might be in the .config, and in particular, there's no way to
> know what the last line will look like (the .config file does not have a
> "# end of .config" footer or similar). So I can neither skip to or
> assert existence of other lines after the CONFIG_CMD_CONFIG=y check. I
> don't think there's anything else to do.
>
> When invoked with a filter, I do know exactly what line(s) to expect, in
> in those cases it is also more important to assert that there are no
> unexpected lines.

Yes fair enough and I've hit this sort of thing too. When something
fails, ut_assert_skip_to_line() is quite annoying - you don't really
know where to look in the output. I have long wanted a better
mechanism but have not thought of one.

Regards,
Simon
