Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8154CD98D2
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868CE848A1;
	Fri, 12 Jun 2026 20:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oZ9LOIkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B470848A1; Fri, 12 Jun 2026 20:26:43 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891178056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f95so2538496a12.3
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288801; cv=none;
 d=google.com; s=arc-20240605;
 b=Fa0X/s38qMadxTpbujd6jSJIVNFtW/jAop9WC34zscN+iqBl8xp82st+dTiNKM07tZ
 rS0UqX5aD4vNeWGgyC2+/Y2gaQFo6qkLEupkCyyoHAOrk2E0WN3pS98b8JJz0nY0k/fF
 7ZDvL+IY8kXQaYILnltWwnpIwFs397FNXDmfs5GtAQqynJyibPB8hgoFLr1neTFUpKdq
 c8eGD5d0JSV52pVdUjatid8x1RaJFHIHt2YcR+8SXF/jsUHdQGE/NDLMkGYYVyqu45VU
 7y+B0Cuc8vnvdmAh8M7YMx5mhXC3FXQN1AiRrFx2u/hIbWcYJ6ZQIGrhCZI1lZ3Iy4Y9
 U0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CfyfdJL83ODFRB4ItwAS3TUkQXUdFAiKO+zmH4b6HRk=;
 fh=BiGYvZtytRDZMmx1I9p1R650v2j8hMC2BA9CZ9q234c=;
 b=jUZYmFGRzd/mdMoaDup20U57vsJVbvNG7Cccso27ouS352z906ESWZqE+1A8VcUE+1
 Uq1/Gy8EnsWouHgs5PhqXXWIWQr/I5LuKWJQqbip9TTAaY3qzxLHTHK/WYfCWSZo/5DO
 OAdmyLQa/ezL1rNFsoBg2vE0kQRk2AetXxQIi7CRXx9NWbOE6hZ8vljE9URO6s/isFZA
 gYckzYursJaZ91jl2gBHgGt7RXLJaBUqQGBFuQZCM05LwMJKbZEzqq9mrG8C1VXr06dV
 0Z26FEIoJv4v0m6CvGeNvNrUJ54wwcV08gTcviKOs0zO9M/82FvjMcJASupk6HKipYDF
 BT8g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288801; x=1781893601; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CfyfdJL83ODFRB4ItwAS3TUkQXUdFAiKO+zmH4b6HRk=;
 b=oZ9LOIkzLc7EK6MziklQdaF7Z4zxQLjpZIDZNhtSxT1kolXAev4/I6Eeju6tB64GZ5
 LvpcZOgqpqvlq3hpsciIIqcKsmgrWdtA9Wp3H6IOcD4OfKl6yzgmxEfjnvKcFR72iZzx
 4jXDmYPcSkcbsg2vW/Bl/DsIME9+SMsbS+srs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288801; x=1781893601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfyfdJL83ODFRB4ItwAS3TUkQXUdFAiKO+zmH4b6HRk=;
 b=dHfoZLegnc6fvTm3WvqyBLK3+NOF5w514ersEzRKlMLd8+RfxxPOYZwxo1Qk9uhI8/
 w36e39ckXm/tlcJf86GfAWOiMy897SacSgLXEE1AK9pjSN46UIb4/ePr8ThzazJXf0MR
 cIBC8EbVjjhmUjOiyzSGFkQbV4gy49nmoRKJnGEBAgC8K3Ybmer64sVZSTMKcTnklLCq
 Y9shKjClGng++Or2lOOoFf1Ywa51VQ0CPNMHrTT3o5MEKAwTyWyGMCk/zbcJZL3+y99R
 KWwFYQeqycexHX43IQNCdJ4gaqf53cHdf67mOnLwI4mXATmmmMaX781lqIW2UrAcexXG
 6C9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ95TBoBCo0Fl7QaSfIq2Dvh7tPg9YupJxEHsiYEzFQW55/tvsWW5QeKME/J/mDwFrAS3mzGRxo=@lists.denx.de
X-Gm-Message-State: AOJu0YwJmWMwshSF2Hr7xcNaf9xHSPGg1r6uN/tb43xi9Mo00LviXsmc
 +sS0KPW1lO0meL+WBfHTaOzJN9kWD5Gcx0nrl9o1wSWZulQUa8qV5ApjpFCgPDYhrbBjW5Zqsbm
 uNAFlpJKinJbhqD1kwvyOrbFkzlGG2163XKcfM01c
X-Gm-Gg: Acq92OFuFRItt4K+qQuwYFvpSeEBqFCLHS8uI5Qdm96UZ0VoSryBNBfUb1NaaChtkZO
 d93bhe+JyKkdNPBhlJ4x9c115hsf3FqZplG91ZiG/4JT2UIW8mQZpWiikwAkRBixNVroxTRrj+7
 mt2D9WZMcDSziFfyJ6FlKSk//k2AZVbiuGRSeCH8Je9rz3nffx8qF03iz0fbl+dAQN11s6+z+VA
 2rR5N3RUnylDM/8vPq/ulAqUfxmqg2ojEdYrMZYfNrJQ63wUbqYZX8dCzh/1P8q5xQgI/i7excU
 Duw8gQ==
X-Received: by 2002:a05:6402:1d4e:b0:687:325e:7489 with SMTP id
 4fb4d7f45d1cf-69378a5dd21mr2029496a12.16.1781288800996; Fri, 12 Jun 2026
 11:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260531-test_fdt_fix-v1-1-a199c3d2a6cf@valla.it>
In-Reply-To: <20260531-test_fdt_fix-v1-1-a199c3d2a6cf@valla.it>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:26:29 -0600
X-Gm-Features: AVVi8Cd55jTfO2AsWOBHmVO9Gx2IR5BAB-UVRxucn_tZNNKZECUgJMZzzqhEV9g
Message-ID: <CAFLszThpbs+8nuTK5etmd3sZQfW+8L18mAC=dHCo0i0r1Nvy2Q@mail.gmail.com>
Subject: Re: [PATCH] dtoc: test: add missing escape in help text
To: francesco@valla.it
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

On 2026-05-31T15:24:23, Francesco Valla <francesco@valla.it> wrote:
> dtoc: test: add missing escape in help text
>
> A single percent sign might be interpreted as a string format directive
> and shall thus be escaped - doubling it - to actually indicate a
> percentage.
>
> Without the escape, pytest fails to run test_fdt.py with the following
> error:
>
>   ValueError: Test coverage failure
>   fdt code coverage: Traceback (most recent call last):
>     File '/usr/lib64/python3.14/argparse.py', line 1748, in _check_help
>       formatter._expand_help(action)
>       ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
>     File '/usr/lib64/python3.14/argparse.py', line 676, in _expand_help
>       return help_string % params
>              ~~~~~~~~~~~~^~~~~~~~
>   TypeError: %c requires an int or a unicode character, not dict
>
>   The above exception was the direct cause of the following exception:
>
>   Traceback (most recent call last):
>     File '/home/user/u-boot/./tools/dtoc/test_fdt', line 1002, in <module>
>       sys.exit(main())
>                ~~~~^^
>     File '/home/user/u-boot/./tools/dtoc/test_fdt', line 987, in main
>       parser.add_argument('-T', '--test-coverage', action='store_true',
>       ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                           default=False,
>                           ^^^^^^^^^^^^^^
>                           help='run tests and check for 100% coverage')
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File '/usr/lib64/python3.14/argparse.py', line 1562, in add_argument
>       self._check_help(action)
>       ~~~~~~~~~~~~~~~~^^^^^^^^
>     File '/usr/lib64/python3.14/argparse.py', line 1750, in _check_help
>       raise ValueError('badly formed help string') from exc
>   ValueError: badly formed help string
>
> Fixes: 7640b166604e ("test_fdt: Convert to use argparse")
> Signed-off-by: Francesco Valla <francesco@valla.it>
>
> tools/dtoc/test_fdt.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
