Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0427AD58B0A
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 08:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5048C843C0;
	Sun, 15 Mar 2026 09:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="AIuvFwBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF30184409; Sun, 15 Mar 2026 09:36:49 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 649AA84348
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 09:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82985f42664so2339197b3a.0
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 01:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773563805; cv=none;
 d=google.com; s=arc-20240605;
 b=bQF5q3stamdR8kRD5QQIJlK8YaGV/J2zXMJumd+3sML4lXnXGX/H22JJhqbGJ7uI3e
 GNQusyIFvSliBm5x5Ok/Bo8i0zJBFjCU0Y/yI//S+Uzrjv4dFOzF1QGOdmOEYfecE3Fd
 qVvc+anrevrBCKY/650Mj15NbsDMfuq+RsQw9XPKK1pO6TDH0UE7LAkS+D06gryidKeU
 PTzQhw2SEiv8vP0x6dzaWWhRzsOuJ9g8KIOUd7y46pSbmXjNedbb13wRv47OezgkxM7s
 TR7LY6FIbHSGKX/TCWzuQpnjUUyX/qw95zHLvktbArz2moe/vOmHJ9CUiUeUjpen08m9
 1CZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LnU1jOykerpTOC0NHuiDGD9qctGV793Mawmq0xUTy4s=;
 fh=17kMnYnsXQpHVhxhyDz9HfQWQ3C1Z5SmA9cxzJQSz5k=;
 b=aWim/ssXO9Wpf7/RjtRV1c3JmG16XgkyaxNgITLqn7s7CJasN2Fn5MTM/bsBFeKlGG
 DbCAvTVmOVU9O30XQjnydVO2ptYaRnJFD1iimonJjrREYloxqbESNI0z3CObu01Z5FDY
 2aUk7hA7p/vFJJWyI9R6LEn7g41D0k8DjFpxPGyZMjkVwmRu6qCmO8en9/QefDotYsfx
 aInT2C7FB3lZFKRY54s/KN1Js/+FLlcYMsorkbQKb8EpqpJ7Qj6pRqUojhIkfvKYppo+
 ezhLsZzulosfg/d2o9eZZc9P+zAlziW4Kbd6OHcJsxEsM/+xb40URCDcmi6xuGzM3aix
 v+9w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1773563805; x=1774168605; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LnU1jOykerpTOC0NHuiDGD9qctGV793Mawmq0xUTy4s=;
 b=AIuvFwBB/hi/oVQfkDHnd2vrDmOszwES9+41RktbROzvToRAGv5NbiCAbkLX5/CYj9
 JsdJzHgobceBYpxBy7+/TSvhPrUliK8vAKhvRJWRjNFWTuqj+erhO/YXS6ousJnRlMu2
 B/Pi0QKjNBY8nSOXdKPCI1Z1onGCjL6wxMpBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773563805; x=1774168605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnU1jOykerpTOC0NHuiDGD9qctGV793Mawmq0xUTy4s=;
 b=oPj6KsidfT4yeUnL+SNmarbgDWyOuEWSH9wHrmJC4uuC/2OL1vD1ZaHFoYyAnR0oh0
 kCAcg0Vp247ltL81ppKSmYgGs1+BArZikeGZL2p8NK1QBJE6Y1DvoJCZ9OL7CUm/ja3s
 wJnkTWNTogrmvwt7jj0xhuzaDA0VW52A6NtNwsuZtXDWuxLn5/iypWSM9hoY4cm64Oya
 UA4KQiR/SIslmS4P7Awzg2kXLU8uA8SdtPR68w34lSbCFh6gXGcdk2Zky6egYBP/vZF6
 6YSd07WXsbUMz6+ZYPA+ouvICnC2Oi0hG/6n8+OLYSqHZyzQBy5LpcRTn3G2f9sAlH6T
 3QOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqSwT5UoPYBrHY4ST190pZQGv+0E/n3PLWEMk1vVID0OEywDJ0DJbSbx+/vbOUWWhY4yP9PiM=@lists.denx.de
X-Gm-Message-State: AOJu0YwhjuVxl6rrkatzv2effZ4G8YhBmOyWgdvcQ3al4q6AQwZhLKpN
 Hncy38XfOjdBpTpJz62Wd0WH+LKc9Xp8BZThjwsiLkI+VAa46iV/nvMp8a9rT9iqLmUhW483PGt
 aSOi8E5aDkulpd8dMjodIIE+Tfb/PVoS62aELnUwTR7zczzY3ek9C
X-Gm-Gg: ATEYQzw+cb34RinbeQG6q0nlbTTIVkHj6ZWNNcINUF7AJte2t5CzwgrFTJDSPycJnev
 nps1sn7Msyiysg2HLpqI9DA98cEbSKYTR8x7qyDEU39qicCBo7glXPyfcBYbdliMez6BrgOVwqz
 fJ4XvtRaTqwjF9TXTOUI2PNgecbHFKgvErmDOzyfB7Wrro3ebl4IHo6QByx7MujHeg8oXnxNYwP
 1Stc/t41MTJyy+jTCv9WGsruVuLsgww7xVsYH1jpg6h6gQ2zQbLjBwOlAToAdJoSyIklXFK6GXA
 eKbTKiS9PQ==
X-Received: by 2002:a05:6a00:7585:b0:821:7307:44cf with SMTP id
 d2e1a72fcca58-82a19705c33mr6106279b3a.15.1773563804807; Sun, 15 Mar 2026
 01:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260311093048.1773382-1-daniel@thingy.jp>
 <abRBtfMjRCnZAc08@google.com>
In-Reply-To: <abRBtfMjRCnZAc08@google.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Sun, 15 Mar 2026 17:36:33 +0900
X-Gm-Features: AaiRm50cU3eigvQZ3u5-efJJ4JYKxaHPJT_rQyQrovqTp-LKN6WnMXIuGxI8Zrs
Message-ID: <CAFr9PXkkEXZQjvBqFQX0wB-a6uJnc9r7dfj-msSHyb+GOQ56FA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Add LTO support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: angelo@kernel-space.org, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Sat, 14 Mar 2026 at 01:56, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > +ifneq ($(LTO_ENABLE)$(CONFIG_USE_PRIVATE_LIBGCC),yy)
> > +LDFLAGS_FINAL     += --gc-sections
> > +endif
>
> Maybe add a comment saying why we must drop --gc-sections when both LTO
> and private libgcc are enabled?

mm I'm not sure actually, I think we always have private libgcc. I
don't think a comment is needed because --gc-sections doesn't make
sense with LTO as far as I know because LTO will cause unneeded stuff
to get dropped either way.

Other issues noted. I'll fix and send a v2 after a little bit.

Cheers,

Daniel
