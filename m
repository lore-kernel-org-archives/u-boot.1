Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF293C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C6558655B;
	Thu, 24 Aug 2023 01:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ebIoItDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F133C86548; Thu, 24 Aug 2023 01:59:34 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41FDB864FA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d749f57cb22so4013161276.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692835171; x=1693439971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0PamfPlS2gnW0APv4Mc1AvxS/J7g1YIbTup1pK3LU5A=;
 b=ebIoItDgH8sf2lyXdp8Z9V+MDsCIyEq9V+lKlG20lAm+yvlwEQ7kloUc+qzU8iOKsJ
 3QqVHviN0LTTx9V4vWZPWWolKsL0nVYugL0EqndQu3RE5SNuelwKDbJXZVz4NT0+O19C
 kGDcP3UA7VKsmN9q15zgZWvywq18+aocLwYqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835171; x=1693439971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0PamfPlS2gnW0APv4Mc1AvxS/J7g1YIbTup1pK3LU5A=;
 b=NS0ktyqgBb8RnvsYdEqGC3Cnz0IO1/h3QQcrkQfFQ6JWWGdaze3oXh4LE1R8ZXom0R
 CEeCEsyfYtIPLl/i4dQxLNyAmXwGUqD/SbtmFj+fih/A4qeZyYPGUIwkLkahjwAWY+j9
 AlpoU5qkH1U/r90FWpljoNj05Qn91XDu5f53c4cY8HYrN4VoHWAgCeqZ5MHR6ZVep1o9
 WLy/3Dmry62m7aC+rZ2TZsJUhsRWrwhR6xMMtCGEBWSyR0GPCothck9qCoQM5Up6khdK
 jMD+NtJagUlFgzU/TFFKm7Bd5I0Txa89ovoIbAlVtmGq9sIS/lJGy1zUpEQpc/tB7Z7j
 kZfg==
X-Gm-Message-State: AOJu0YyeIZ5TnyMFpijKqifMOBnoV5DOqwYIPoa53qfQMqTM5aG6MiDI
 gIL3kglD5/jHeB9OrXt9bi/rbhbGW6+PcYORQJ8W7A==
X-Google-Smtp-Source: AGHT+IGF7fLwFNlTtKMXErKIO4rJVM/DbcfD4lr2K4Y/LNYPmcIBqW/DqIfZLjFoJ6lJNKdX2fMTykqfFjC+8urkzTU=
X-Received: by 2002:a25:1c2:0:b0:d6e:3544:9875 with SMTP id
 185-20020a2501c2000000b00d6e35449875mr13467710ybb.42.1692835170786; Wed, 23
 Aug 2023 16:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230823193744.64172-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230823193744.64172-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 17:57:52 -0600
Message-ID: <CAPnjgZ0fQ1OWS+gESyYghyfm2JZ4EmsqvQU03HzT6M1WinofRA@mail.gmail.com>
Subject: Re: [PATCH] test: dm: test-fdt: Use fdtdec_get_int() in
 dm_check_devices()
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Mario Six <mario.six@gdsys.cc>
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

On Wed, 23 Aug 2023 at 13:38, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The current fdtdec_get_addr() takes into consideration #address-cells
> and #size-cells for "ping-expect" property which is clearly neither.
> Use fdtdec_get_int() instead and return negative one in case the
> property is not in DT or the platform under test is not DT based,
> i.e. mimic the current fdtdec_get_addr() behavior.
>
> This fixes ut dm dm_test_bus_children test.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  test/dm/test-fdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
