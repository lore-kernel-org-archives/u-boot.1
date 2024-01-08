Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084C3C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E35F87AAA;
	Mon,  8 Jan 2024 01:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Smbq5Sk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3201A87A4F; Mon,  8 Jan 2024 01:16:41 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2526987AA9
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67fa018c116so9213436d6.3
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672998; x=1705277798; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VVX8CuSVdG+u7WT19z9nSFpU0JGR0a3Mrvyo1EO4bVE=;
 b=Smbq5Sk6HMloFHyBNKV7xm598htkC3O+57fp15L5erU2c8v7KpByHcMhFh2ZMB19t0
 WDFafrZjaK9GcLIJy/gQWq+HagAFnhD4z//RfRxtUQcyRb3Npt72+7CKUXOq516RG3JJ
 dwhi9fNRf0xPaBfYsVNNGRicMAwcm9ySQXYD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672998; x=1705277798;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VVX8CuSVdG+u7WT19z9nSFpU0JGR0a3Mrvyo1EO4bVE=;
 b=S53GCw2glKGwSuIvxiAx736r1vT9pG6NRCR5MBAj/pHqVgl1UM6OO86S9iGN7krCkG
 WdxUZo72d2fasBevuBTRrw+cY9XYMKyAaBizBgk+THxgAxCatI5dS7Ge1OtlMhJHXQeh
 z/bg0vvpyyVz8TVZGBMbUc1smLp+jevcA5EdqwJnDhQMHJwKQGwcKbEGZRwkSLaHXEwO
 jn0UhPqERLICk7Pdc/7DIPyNuzCqj47cBgMT9/a/1pGiiRJdc/m4y6EBDwj2graKYA43
 bO6N2KEORkod2vWywOzTO0K533mhU03Re8WnxyUNtcbcPT7HbX0fNNMpQkhSEhdXoEOd
 Z9+A==
X-Gm-Message-State: AOJu0YzuFfzq8HWdXThVjfJsZBcRNoC6nLrtY4a+JVzG4oUfegGJbjD9
 RLRVHCKe9jSJY1WXNQvyhGC0vRarJQ95ReUFLxXjdU2AMaWG
X-Google-Smtp-Source: AGHT+IEzOyMdxe9ZdelT87Nmegq4gBefSgpjjqrr4ll9NycfxuIl/9Zz+HXRJ3FR2gCt2ihsmMqJ54FxB4b0GIbfQwE=
X-Received: by 2002:a05:6214:768:b0:681:973:3561 with SMTP id
 f8-20020a056214076800b0068109733561mr286469qvz.83.1704672997990; Sun, 07 Jan
 2024 16:16:37 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:37 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2tJSTO7HC+_zCzxBBxSFAPmg2g+hyacqXoKWM+u1HhEQ@mail.gmail.com>
References: <CAPnjgZ2tJSTO7HC+_zCzxBBxSFAPmg2g+hyacqXoKWM+u1HhEQ@mail.gmail.com>
 <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
 <20231216081200.7677-3-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:37 -0600
X-Google-Sender-Auth: HQJRXW2aKreR4VuW6d0gjJXahjo
Message-ID: <CAFLszTgyPp9VL7E4guWdsV5BWLt8YirJQKQ1C5=gKE=bh=WtQw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] cmd: acpi: fix listing DSDT and FACS
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Sat, 16 Dec 2023 at 01:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
> field X_DSDT is filled, field DSDT must be ignored.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/acpi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm/next, thanks!
