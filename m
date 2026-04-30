Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1BECD13D2
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBCF1839D5;
	Fri,  1 May 2026 00:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="El3uZSMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A0E83A91; Fri,  1 May 2026 00:16:50 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E586E803C6
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 00:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-671ae79e617so1854321a12.3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 15:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777587408; cv=none;
 d=google.com; s=arc-20240605;
 b=XQU8CfD2CHRxYvcdpVbHcf3w+feENVEhJtwpcCco+aRMBl9FJOjApKhbm02ZL8hkwW
 QAJT+F48KolzJ/wZ93LYUnoCpuB3BpoXvQqz6RORofRVfmlqhfO2MBW1Qf6wRIE3nzS4
 7egBVPrLGPtlXh2cMs3Ff0HlLTT45Hvid5Z3Fg7WWek3A891RcSVsuxRYWzTp1tIg+/F
 CSDDK8r2DxVoa44eSLKzK0oXBZy2Z+/5CwOrbPe2F1yncv3012vbvQ6tvm+Ntr9b/u2Z
 1vAlEkOWGwiZRlkJAhyszN94DRsJgubAq3iDv9CrxM1/otvNBuhzslwGOsj0HpK5Y61k
 mBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0fBfSdXGzdhAxsV/xS/R0MmHEDZCRDsmDyO9+MqX0Ok=;
 fh=JojmjFcMDF/AUVh0pdAK1ViDQN4c6LuWC9IGLVncDp0=;
 b=C9OAqiYFE5uZdwNkJP847cX4ORR88hYW38/6tqNnr1PQlKCgg5/4Khhi+0+pavCege
 G3WawMaD2w+Tghg3Uhy9z/s1X/mnkVwQUT73WQRMV6A9MihrsQZUL4ipv3RMYt/7WTIg
 Kdi/yKK/+Edrp7X3utGXJo4e96GF8Mf4hFlb0OMWflorTxW1dcbJFMCgqixSebCDZK37
 SpBRlEomRiezsWLnVZteKGyVaYlu0c2fjnXGW/kQDLbTrH3SX+qFMV/ZUsbPT0jzn4Ta
 +wWembO0I9wAuzE0l7oPlYR/Vki1arPxKlwaL5SQqq5cIk0/ZJnwzShxZwOweLs+bj9J
 9xGA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777587408; x=1778192208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0fBfSdXGzdhAxsV/xS/R0MmHEDZCRDsmDyO9+MqX0Ok=;
 b=El3uZSMTyu9DH2LidEEh5oefU5jWEcz7E2Y2zEL7WYk2A/tZTD6oLSCSkI8PgkfeOb
 Q7fkGXMK4OFXywpfRkaSG9cFrCBAI4EXFpriucIWvEzGmbOQzzJe2y/8Zwfu4hGv1Oc9
 hlq6sSSfbLYKgf3xrZy4e4it++Q1W3lRKoLBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777587408; x=1778192208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fBfSdXGzdhAxsV/xS/R0MmHEDZCRDsmDyO9+MqX0Ok=;
 b=Aq2VTkjzllHZYh7C5eJaVxhOoV/seUa2IF8b1VpGpi6TtxzmQ5z9mexAHyI2coL1KZ
 qylC45d38RJTL2wAFbenlACUV7BKoMiuv5MB55dk4keAv0qRSdVuO8CBQjHMBYMCKMOY
 RrxWm2xF9s4ox9kDt7cCVujg4JmgC10KifhSV/VmyjvsTf7TZ0U6sACOQ6CMzlbRCgtT
 PZk8jdKmlRDZrOPCqK60auvg8y9OsR1XoYyG00PXPpZnC+H3Cm2S5WvQ01T0gU2Qvu1u
 Su37ezIXu3Jo82xmt9hxzw7GcCZPq8hdpWt1eJp4danbaWd4xVvUzX6g0nfxilNfd+Da
 rIdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+so7/v7z7EHD/urIdnqZsWLtt/r/4xstagz1R5WvDD70PBpmyfp6U6zKtS/g/lDOpYGkIDS8g=@lists.denx.de
X-Gm-Message-State: AOJu0YyWk6QySOE6u6aQKE+5zwYkb9KHuq8absxw3LuNJmiDdHtuE+cO
 m7NSggnt61LKsjMWdRi5djYlPl+ZyKguBtZ0dYsxBmSB11tnAPfYiOu35Cr8riQjX+O/W47CPvp
 A0zcRNcLi1SrEPpu4eVfz714mfZ93q2PJDB93ydx8
X-Gm-Gg: AeBDieuLMejtD2MOBdREh16mWkxIYS+gIxtfOyWug+nG/ndUxLdUuXed51d/G2Rjh4/
 Y66nNsXh0YAnicz6OqsWDw9o4LMXJx/nZMtBHAND0dLbYNNvLDGDGjn3BpxOcRwgNKXpivcx+R8
 xjQLLoLWh0IK7i5njxWlIiPCQg8dPdJWWMDyBpZIS3JTdFw3xwuup+l6CqxuNyHIYdtwJygcIOx
 L17B6DUueu7zBf/QknQDdWgax372GKdSE72eECFAFnCEbJpmwREoJ0jNSLlsa8xqXWltzR1XaMi
 zdO84DLCdNsiLaEA
X-Received: by 2002:a17:907:5cb:b0:ba5:a3a0:4a3f with SMTP id
 a640c23a62f3a-bbac7997242mr325128966b.35.1777587408295; Thu, 30 Apr 2026
 15:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTi5QJUZ5uKAc7W1nATXSc_yv_WHaFXhzcgrpF2bhupzRw@mail.gmail.com>
 <20260430192906.4945-1-jcethrid@gmail.com>
In-Reply-To: <20260430192906.4945-1-jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 16:16:36 -0600
X-Gm-Features: AVHnY4Kh8rjzyWirAQqy8UHETQWTa8mjP1OyhM5J1bTQsG9E8PY1Nm737CP9Ce8
Message-ID: <CAFLszTiHm9MbuFNQa4+SZdUCKSoqePokQaHTFY8R8KiPf=1=tA@mail.gmail.com>
Subject: Re: [PATCH v5 14/15] arm: sc5xx: Add fdt_addr_r, kernel_addr_r,
 and ramdisk_addr_r
To: Caleb Ethridge <jcethrid@gmail.com>
Cc: caleb.ethridge@analog.com, linux@analog.com, malysagreg@gmail.com, 
 philip@philipmolloy.com, trini@konsulko.com, u-boot@lists.denx.de
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

Hi Caleb,

On Thu, 30 Apr 2026 at 13:29, Caleb Ethridge <jcethrid@gmail.com> wrote:
>
> Hi Simon,
>
>
> > The other 32-bit boards in this patch leave ~16
> > MiB. Is that intentional?
>
> No, this looks to be a typo in the ramdisk_addr_r, all of the boards
> allocate the same space for the kernel image in the load. This will be fixed
> in the next revision.
>
> > How about picking a distinct value now so
> > the future booti patch doesn't have to touch every board file again?
>
> I'm not sure I follow your meaning here? Ultimately when booting a user would
> choose to either use the fitImage with bootm or the booti approach with
> everything loaded individually, and there is the potential that once booti
> support is added we will deprecate and completely replace the bootm commands with booti
> versions.
>
> Also, currently when we build the fitImage, we place the ramdisk and kernel
> offset in the fitImage so that when loaded to CONFIG_SYS_LOAD_ADDR, they would appear
> at the addresses from the environment for the ramdisk and kernel. So if you were to
> load the fdt, kernel and ramdisk to these addresses, then create a fitImage with our
> build system with those same images and load it at CONFIG_SYS_LOAD_ADDR, nothing in the
> RAM would change.
>
> Does this make sense? It would not ultimately matter if you loaded the fitImage or the
> pieces individually, as they would be loaded to the same locations in memory.

Ah yes that makes sense, thanks.

Regards,
Simon
