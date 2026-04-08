Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FAE1073CBE
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 13:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC6184106;
	Wed,  8 Apr 2026 15:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="JhGjoDdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D2284118; Wed,  8 Apr 2026 15:40:31 +0200 (CEST)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 466B7838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 15:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-1274204434bso731053c88.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 06:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775655627; cv=none;
 d=google.com; s=arc-20240605;
 b=DJypa6TfYiKZMiwkOk4yBQWaO4fbuF1izSyfe9CYgJVyo+FWSk6YdKk5ZdBW9XGX8y
 +r1NP3/carv4mzRiciH2obpZIfx/cw6zBMeMW4y4f9oYoinJRyyD6ot/DNtG+bTwbWf+
 yaju08vYW0LoRo8oyDBtpgBkHcGz1og1UwDsQVHUWwMc9bhh1LX6CUxqjq5qQWodZoa/
 /t3LUx6OPQCs4Cprq0YTzYBSIXPCc1s2rZ3OFkw0g5uB7vVMm/dg9gADJDoJYwlVSXt8
 Vy25GA5X4DAh1ViROBUKB43vMJTaX8xBtE9kV+x4VS/LFXT7GuOAMtiJ1DA0ww/bCDHe
 9P3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZKUZ2lr4CJKJBZC6pthgerfCcBUdrJdsJbxCS1DhMHQ=;
 fh=zM7ceKIFtjnXb4yy2TjSbP3O+lF6pLNtxqcHtKrRsTI=;
 b=fyL7WD5Iu6oWfP1owySP8OqF6JmxmGlyTTMT7urlIA8D0YafQYBOpakiAnkHRehnrn
 Jb5eQZ4vMyDVocag9lh4gur72nhbWcQGXIw41SKfu1+JF+dLrTEPn2u5L1s+FG/IzJO3
 wbuuXd1hu2OfLbXsbytJ4eOaXm094gHN7k5liuYXqf4BTTzDpg+kmhok4FmN1YgdAehG
 r21BOjuFHYQUVoi9oUFkU4aX8ts3T7FKbo8xgWfrNR9J5oGs9TPiSLhXDgZ9LeVIHWq0
 s9z4KxPOH6yCkja90B5TRU/LLlU8jg2aFgbECbEvAB9MezAb5mD4S1CutMqHfWl6KdKv
 8xQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775655627; x=1776260427; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKUZ2lr4CJKJBZC6pthgerfCcBUdrJdsJbxCS1DhMHQ=;
 b=JhGjoDdY4ilkbgrhp10Glzuya33ZZ/dAeon0FR6ECpqN0xYTVFpu0fNtEsxOG9X8kL
 xuERuJxdx8EYwq0A50nPE5D1fwvknlxlQHqCiwhw08tB2pQYY/TcAAcZA9lkHMv9py/a
 Geqmd+N7Xriu4jejuHp2KCp5RTaehm4Fp4xTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775655627; x=1776260427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKUZ2lr4CJKJBZC6pthgerfCcBUdrJdsJbxCS1DhMHQ=;
 b=MnlhNcZjjp4fF4z+9cFcQnESoFJJY41k0RRgY5EdxMYwf/g5Z+F7/UvoIEApEGemKs
 shzgkpUFUqvcKlP5Uv5Xx8zsh2r7cRbbuSfFaH/kWEozNeATATzg7v5TF9EZ35ePcgVY
 qS4xq7NDA1ZJafHCuULSwYv9Pd8T2WB21xDIFtbxiyzlKZq2HLxJAmucQLCsUHvBFCZZ
 OsypOkTWYXebhgJZZ/PZmVPdIrk8/4U5Cas1qQwrav8GvafYXf8dKG27kVF0WuVRRLJi
 mwa1apUMo1rRFH3qg9YKB+1NnyMJKZDIG6Jv2c8qYLj0FMqy+SlFCjOWF2qIz/+A/OTn
 1Zbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBdX3RZCyoDkc4bXg52440RFt0dzB73pQCkpTFCsqJoSAV2hCrJq+aGKft8Gr16+UJhKbFwsM=@lists.denx.de
X-Gm-Message-State: AOJu0YwPpoi76pMjCme1tiHDMcP1Q08jKrO9syrmQBmuTws1WjHfcrKH
 efCsqjhydAla+QBmKRfqOocg3BO0RKjETKYvw7093+vZZUXVq2FDLBpCn1Btd0+geI1NNLq5q7K
 4CPQ+5XRbNS7DjIEOS+WsC4/fCmmOAtpK6AZKqJbXBA7HVooE7E3SCXY=
X-Gm-Gg: AeBDieuw0UprLZEXo2DJMy3iV0zptEi4Jg6Sfc+0ScFjVf7JTzfxCtddoRTJmUKGSza
 GkDV2kolY1YCPqpwlajuVjsAUfZXGdoweFLt+lgHd/kLQcx54DitaNprjPvBCwi/nqCBZ5DsSzr
 Jg5UwWXj19iuUnb6wPmy5bKQzZJ9xBaa9lED9rpIguMiIS7kAUPsaSsM2PVOvFVplT+Xe/gcT6u
 oLIvZEyvaCEzznbQPQmjW6t8qbKPCfwuV0T7ry0y1l9k6pQNcKlz0nm0AK0m37jZhCztYW/vXuJ
 kkvV
X-Received: by 2002:a05:7022:6986:b0:119:e569:f872 with SMTP id
 a92af1059eb24-12bfaf58991mr8943542c88.15.1775655626502; Wed, 08 Apr 2026
 06:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-3-daniel@thingy.jp>
 <c300ac4f-f38a-4a0d-bed9-65588b3308d8@kernel-space.org>
 <CAFr9PXk-fJ_kbqd08LHtCdNfid=MVAr8yEj25o_yJghh7qRB=A@mail.gmail.com>
 <3c748627-9273-4ab2-9d13-56869dcf613b@kernel-space.org>
In-Reply-To: <3c748627-9273-4ab2-9d13-56869dcf613b@kernel-space.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Wed, 8 Apr 2026 22:40:15 +0900
X-Gm-Features: AQROBzCE3Yzq6IYWBf1GP03bwlSHfD3Tirc6TvTvxo7d_4vY7CvD8ncOzaYzMl8
Message-ID: <CAFr9PXmj2_0g6BkHLAeuNfo8M-CCnjtozfrB6unJ+QvQxYmy3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] m68k: Fix writew(), writel(), readw(),
 readl() endianness
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: visitorckw@gmail.com, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

Hi Angelo,

On Wed, 8 Apr 2026 at 22:26, Angelo Dureghello <angelo@kernel-space.org> wrote:
> yes, thanks, please try to find a solution protecting coldfire for now.

So for now I have put #ifdefs in so coldfire retains its current behaviour.

> I will try to understand better why Linux operates differently from u-boot,
> i think pci was involved here but actually i don't remember, need to
> study this deeper.

I thought maybe this change in m68k might be recent but in Linux it
seems to have been there since the import into git 22 years ago.

In the linux docs (https://docs.kernel.org/driver-api/device-io.html)
it says this:

Note: On some architectures, the normal readl()/writel() functions
traditionally assume that devices are the same endianness as the CPU,
while using a hardware byte-reverse on the PCI bus when running a
big-endian kernel. Drivers that use readl()/writel() this way are
generally not portable, but tend to be limited to a particular SoC.

So I think maybe coldfire got a "reads native endian, no swap"
readl()/writel() and then when PCI support was added a hack was
needed. But somehow normal m68k got it the other way around. <shrug>

Anyhow, sorry again for breaking your board.

Cheers,

Daniel
