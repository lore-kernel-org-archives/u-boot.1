Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0B3C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 13:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9268482D34;
	Mon, 26 May 2025 15:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XwGq90IR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FD082CF8; Mon, 26 May 2025 15:25:05 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51DBE82D43
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 15:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-601f278369bso4671120a12.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748265903; x=1748870703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7QB7VmfK8oC6YBT6UyYu+MPWzbjsct15phkUN7nynj4=;
 b=XwGq90IR08AN86wZI1U/ROVC5unsWDG2TAEgGNGJh+YbPZ8CD2U0MFXqFxcE7ynRFr
 SmvHM52OEjUqQfz5yJTrULMuTULDWC6xbsQHziEfBUBaQ/obLZj6EivrdeOtZhTCh/8m
 Kxw77USMuBo7vmhr9yt0WJt1vpa2nUhRoMCZiYlIdOhlB5/LOuTjZE/NRXGMxijoHM9T
 eHqj5wstL9j9ATCGj+q5/UM9Gyhv22hfoV8GqSmC3I4lzityKNUu0Sr7/1oARgWJcc0M
 BrOSNv4UiwMqRAExREiJQNMSh7m4Ks8hePepC5FzR7dDfAowF9dSUTB0LRJdV5vb0pyE
 R/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748265903; x=1748870703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7QB7VmfK8oC6YBT6UyYu+MPWzbjsct15phkUN7nynj4=;
 b=VQroHp8Z2JKeBYePM2LEb1Z/djdGgIf4swFUgJJ0KP8TWiRP1Xh9yj7tPVjvG+Mocv
 gA0Lhi1+wbwtU1aSWMwjcJfIx1quWtAQaOkdESLhjLL41RGdQAbCai4ATDZKs69KVj90
 57Q/ovalYkYgnQJUwf9zXnTIacrQoxAmUhWkz22wLYY2kuZGTIfv270+21l5oYXAnuR8
 euON8gq/q26BtnzgZ6MlL96qTSrxT6TNHm/bofqsw08IKgDMNAxPdGZ48LJjqPzbiUkH
 ExUe3VftVmQmjwD7qY/R5XKfrrxkgtSeKY7a7Mrgb5ho4CMsB9agpNgDvtGuVu+t2Gb1
 wJTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDYbalNMXuCSIuDwNq6PomO0x3LKjh/GvLTQuaj+4+cqnGrjPCppMqQQfK1J87AdMs7bAQ4FI=@lists.denx.de
X-Gm-Message-State: AOJu0YwCAcKhtDleTHpUVUB6PD1NZ21MTz9WjejC8X3JCzXvaK8qK8UY
 TW6vbq27usqYtzNnSfEijtZm59ou/9PLhwQ9Yr7zfluE8fKXigAk7icT9mo8Q1kjirCO3WtEtJ2
 cgZe5F9MPS8XtErTk5vKsnmzLxS94xqE=
X-Gm-Gg: ASbGncvHIsrraZrpp4Fd7MTNQS8m1fv12WAz5KvnJW7NsgUcC85hykx3uVncHFshLM+
 lEQFFS4A4zJPBVxB/SI4a+LIF/Z3CKxBAjmiZXLOF9soSVHDNT53MGpBi/0x0LwTzieci383euC
 Ng+Ct2+MnBrqRKFmnxes9sGQuVvPw/N8b2CDqTWg8c9iBfZY9ufipmU6jwmCPaFSS+HOo0N85Zz
 H7h
X-Google-Smtp-Source: AGHT+IGdCxAA7VoThcXC2mZvUmbZHWMtkpKTFETk7ZEaNKKRfVCF9w4RxVhuqVpMu+XJv8GsEuhKQc5hthkCeNhaf/A=
X-Received: by 2002:a05:6402:a51:b0:604:6149:1c66 with SMTP id
 4fb4d7f45d1cf-6046149235fmr3980399a12.33.1748265902523; Mon, 26 May 2025
 06:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU3H1vjbvyZTycBQhufii5SqyTnk4AaMRk_ztGY10g9joQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 26 May 2025 14:24:51 +0100
X-Gm-Features: AX0GCFvmLNKhqVQYysPEXNXju3cALX4iOPUdJxSF-pH1f9cIvJuj-JX9QiQlQ9g
Message-ID: <CALeDE9NNHm+qt8pPo_Hf64DvcWD6gh6qiC1g6mgidMRVJBpjWw@mail.gmail.com>
Subject: Re: lwip tftp not working on imx8mm
To: Tim Harvey <tharvey@gateworks.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
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

Hi Tim,

> I've enabled LWIP on imx8mm_venice to see how it's doing and while
> dhcp/dns/ping/wget appear to work great, tftp is broken.
>
> Enabling LWIP_DEBUG shows the following:
> ip4_input: packet accepted on interface et
> IP packet dropped since it was fragmented (0x2000) (while IP_REASSEMBLY == 0).
>
> I tried enabling IP_REASSEMBLY in lwip but that seems to change the issue to:
> ip4_input: packet accepted on interface et
> ip4_input:
> IP header:
> +-------------------------------+
> | 4 | 5 |  0xc0 |       108     | (v, hl, tos, len)
> +-------------------------------+
> |    10568      |000|       0   | (id, flags, offset)
> +-------------------------------+
> |   64  |    1  |    0xe25b     | (ttl, proto, chksum)
> +-------------------------------+
> |  172  |   24  |    0  |    2  | (src)
> +-------------------------------+
> |  172  |   24  |   21  |  251  | (dest)
> +-------------------------------+
> ip4_input: p->len 108 p->tot_len 108
> Unsupported transport protocol 1
>
> Any ideas what the issue is here?

You reported the same issue some time ago [1] and while I could fine
the original thread in my inbox, I thought we had got to the bottom of
the issue and it had been fixed I couldn't find a follow up thread.
Maybe Fabio can remember as I seem to recall he was the one that got
to the bottom of the issue.

Peter

[1] https://lists.denx.de/pipermail/u-boot/2023-November/538832.html
