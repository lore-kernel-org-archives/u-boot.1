Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A089ACAC59B
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B67881E13;
	Tue, 16 Sep 2025 20:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZFqHa0YO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F578319C; Tue, 16 Sep 2025 20:56:21 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B92AB800C1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b07c2908f3eso699089766b.1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758048978; x=1758653778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=daIGSnlNdOS60936sCz8I7xXHSZwlE1KHWhCLVUY+Ds=;
 b=ZFqHa0YOyGJcfoiBRqk5zTBiS6V+ZsOXBBpPGkmTdr8WnGU3CbalM0eANnOyYd51be
 /jWa587+kyDPJrP5MZcAOpzex+lK/F/PlrNIdIU0mzkb8Ga6jbLkdhXkv6nRDEQ1aWdU
 PAWABDoGd0gizWxN4WSPU6s0a4BXLKzCh4lw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758048978; x=1758653778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=daIGSnlNdOS60936sCz8I7xXHSZwlE1KHWhCLVUY+Ds=;
 b=PFOCGMEyNzNpjDJv/L4mtMLfO8Ns/Lc8gQQaVCP0snP27HSKTBOYgq+ZeqXus6hXoF
 Ee2lz6bl6E+SZvFlSMvRV9P8UlB/6gyNf/jPsR1O8ukh1eMX5ht+1nEz7v3NkQLQiFDQ
 32BNzSHTJuqheF2vRNBwcsq677FI3B+1RAXejTKKEGyA7OVggifcWpvIIIm15oNwSXoi
 iPpKeniKMqe0U6XxETSRCJIVm9s+r3QFXborUXVVf6wN+Jt0zKFqFkDsycY7ByMzzk76
 VfmD0q1tTzZ9Xzau4WdJ2JwEiEagetYt120y5DJ8p29ybsu/EtGyPudOu5p9N+Ot2ml9
 nikg==
X-Gm-Message-State: AOJu0YzgI+mLf7zzl7WwZx1eJ4Y1gQ5xx10sAmtBO5F5qBOBVv4fv3zY
 rIRfQ90n5/9UuFCL7QQXyp4ZKfMy2EuApZOfxzeLGwaH/aMn21a99zsAqT0xTlKRiB+8WroZjEC
 uN/WB862w6CN1/M8NglDuJOnLk07dYA/SwkhlMxm/d6oXfqO+0S9PDA==
X-Gm-Gg: ASbGncvKpWiGxEGg1RNCRhLaG8DXD3PlxGT3eQuiqTIWSGLxwixohUrsFerfEXNLskk
 pJs9xHxhdHoNOIUq8BbqvQ//Hl0LMGAcOHjAUlsnTmiXYKbH82YwhJhDnhdP9nKjnl2n7XjB7P1
 SnUX/GP4eLOxBQumEPqcsUfbWHCro1tphJefltpSmgkrJ8z8RpjervjYSsSxjThI8LqvRLhCxCJ
 0KZdA==
X-Google-Smtp-Source: AGHT+IFmOq2PqanaLw7wg6q/YdB6kUzUgY75yTjBPO7rGWrc42XpGjIotXy0TNuN5f61qqYa80uaOHO56W/PC2DTvNc=
X-Received: by 2002:a17:907:1c9e:b0:b04:5385:e26 with SMTP id
 a640c23a62f3a-b07c37a7fcemr1992941166b.58.1758048978144; Tue, 16 Sep 2025
 11:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250916174402.GV124814@bill-the-cat>
In-Reply-To: <20250916174402.GV124814@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Sep 2025 12:56:04 -0600
X-Gm-Features: AS18NWDTB5FZ9mA_TcVoY6TGEVkmCRT5Tkki0-UaEGeEdbM0cJWvzZ6-IOsYiDo
Message-ID: <CAFLszThagMr7f8tbAfeKTHsFc204TJN+z-B-SxR5qNqnM15Nzg@mail.gmail.com>
Subject: Re: Gitlab CI slowdown
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, 16 Sept 2025 at 11:44, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> Currently, Gitlab CI runs are going to be extremely slow on the final
> world build on arm64 hardware task. While we had previously had 3 fast
> machines available here, one of them was decommissioned unexpectedly a
> number of weeks ago and the other day the UPS another one was on died
> unexpectedly. Currently this is expected to be restored in a few days.
> Our third machine was disabled for a number of months due to some issue
> with the machine itself that seems to have been resolved, however it
> also allows for multiple concurrent jobs so it will be slow when two or
> more pipelines try and world build at once. Thanks for your
> understanding and patience.

Is my one (alex) in this list? If so, can I change the config to
resolve the concurrent issue?

Regards,
Simon
