Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BE3CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14B584374;
	Mon, 11 May 2026 15:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZwnkhazG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B166783CD3; Mon, 11 May 2026 15:09:10 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F4783A41
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c7358a7a8d1so3177884a12.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504947; cv=none;
 d=google.com; s=arc-20240605;
 b=h6TsupRGOJgfsH+wYLLfPwrrJ1vhiy1SMuh50rK/X8aYuejW33AI8q+UwYu8cZHBcL
 mglvo6BwICyANvwtGXTTjFEEaaARlARc2V3yNN/Yylh1l7xE6P798Fi29WvpIY6+9E1d
 NvGIPpXd9J2Ddk/M0cibGTDRSR/GKR0U9BPPSwnVeN3bJv/BNcoF0UmbY+MEnFBnMYDL
 cjKlxYCOVdENPw1PGRrWPglpAZ8nUPZR1x9IOWA5/+9HoA7WwxukNmQEY+4mfX3ov76S
 q1OHB7KJibwP0D4DWNp2sdFVrJHanVZenJYja+xclLgSu1bm+ndFpHrtmBJpaoqaaKOw
 6cuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kPP9CsC6aEUJWv8sgTEQueqAO+GTQv153T9u5HE3pCc=;
 fh=vccyXcg6NYQn+ONT3RyWJXdVoBuJT+WRq+JmsexiXMo=;
 b=dikK5Z71+agrMFFJ/y1cJW9BfD+DMlQGZRwWoylsBIlRJrSdv4pjkTMtXO6J09G6PV
 UP8zYydEhUcE/DvrCX1kFBokH22mAReM/qFrHLFbZUYG/gD9hDkeDqxx2gLZb6gEryWY
 /f/Q6wrJISe2VVAHfge5Sa8ZfjpRGUC3WMa77XNGpH6N3+00Pe8XJJZYOd2ez2y0iZPP
 hRnrnujs4RxY7QOaN4N6MJ8U4bHWyeFPaUYoRXNwOg69JcKbsibnQSszZpAuvWZwvyae
 GkplSw0O46m3Er+1SrwVuncKUwEWMfxWRCFabYukWyp7XKnJviReLznEO2iUiT1y+iPu
 v6oA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778504947; x=1779109747; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kPP9CsC6aEUJWv8sgTEQueqAO+GTQv153T9u5HE3pCc=;
 b=ZwnkhazGqQMNB2KX+TJnEWoGVnOrnJlXC9s7qnXjTzy6x4llI05xq0jX7vrrOlCdCw
 61jsE5Xwi6ub75y+OywIl/9Hsv+MwNyndWY3She5mZc9r7Iv/GAFfZvPmZSuzisArZBg
 LibTuKQMzb81vlBS5QwScYXpBi0wUAz8OGI74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504947; x=1779109747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPP9CsC6aEUJWv8sgTEQueqAO+GTQv153T9u5HE3pCc=;
 b=Pltt/M4f2hY/t6+LquVaAy968IHNxsMcF4Xua8ZIIMVl+IQTNPjTRUpH/uNoGk7C6j
 yM5X3gGrMVMUoDoEYLPxT4Mw8knxeSFJCWF9ak2UT3IttsFhXKSnkbpLhnVtnbG0mu4Q
 GQ9BxX/GXCvWGJrfciz3H1sI+ZNqSHSmK4BsjUvFC6mfnuqNAP3lI6WcF1F2MSeneZTg
 z2f8N6O3yXVHFvILrZfgmigM91NHWvcxQfdvGt1e/jGE1Z8qRqwZWisHHnMTNxAsR8hc
 kMWt7CiRO/U0YCZ4CA7i7HQga0ndvjAbMtoWpt0b/7u/cOag217vpziY89wvb2jmaCL9
 jNUQ==
X-Gm-Message-State: AOJu0YwskXyl9fpfDyJtT1YT/0GQVSTl+vGUyrYxDUnRo5h7w6T+NAlI
 DFG6sajR0me1DCbAL0uMUa+J9n4lCGjeyR3evQfsIXxJoQqxQpeJRl7/z6ltHBfyTxWj/N9MALb
 aIPW2L1ZHo9QwNnE58M0BrOV7ztsqY5QOqyK3IJIf8eiWgt9ndRw=
X-Gm-Gg: Acq92OEG5NQkko2RjUjmKFVR8tuHWk08h2/i+Vbqh7hEs2VJWcNJiZvdIcnuq3BkipB
 B3b6OtZqoTboEyiplLaGoiNsIX8G1tGQ3bRLC5iQelTHri5AlOPMbiB4fviQLeVq0S3cEuWfsF4
 XYnyqrdnQxqdnLkWDwwJxU4XqByqL/qEY9bokvhHvas9thYDVxKxyKVQhvAgv5qycoDjkGLrjpt
 qkSDqGpN+InvxX+xo7mOsDyMWn7x6HKBdWdjlZfrQmfG0XDWWYyu3jlqHYkj2T1DDyh+rx20ZBc
 c+gWdQ==
X-Received: by 2002:a05:6a20:914e:b0:3a1:76d3:c1b0 with SMTP id
 adf61e73a8af0-3aa5a93d8efmr27163042637.22.1778504947142; Mon, 11 May 2026
 06:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-10-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:08:05 -0600
X-Gm-Features: AVHnY4KFH1rG7OPvoSySdE3CNgG8Re_4nM_qv6gqWKasTxPZDXEKW6PKgFq4YAg
Message-ID: <CAFLszTgGbOY2CuxB5+g8o4t=FOQH04OMrzG4bmY36wTL6q_rNw@mail.gmail.com>
Subject: Re: [PATCH 10/11] video: tda19988: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: tda19988: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/video/tda19988.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
