Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D82FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3419284459;
	Sat, 25 Apr 2026 19:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="P3rJirsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88CC8445C; Sat, 25 Apr 2026 19:33:29 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81499843FB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-479ef2b78f3so3679207b6e.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777138405; cv=none;
 d=google.com; s=arc-20240605;
 b=VLuZVfsx/yp7aFkpRs/fGzEfv2D2kvXX3l00JPTNOrDhE01KkU4j7lEjUuzDLLf8yx
 rKDNxQVCAaMZQPidSkSshbw0Rd14hjjfAAAjFmPK9qIbQqro10vcTqWgM+ya3BuPiifK
 NvubIRIktQgMPb97FnXdy2n5wkFo9S2cpfenWgLLGfeZQElH0fOvzAUVMmO4OvQqZzsH
 kaPz5m2uY/Gt8un6jEOLiXz6JUSlnlQilaFcjh8HJAHC3NU+WxzatF+MeN99FBMVOgG2
 h3E5qTZVis4pCTh/nsl+2hxGd0xba+tneCqUl+9TwiZISu11Qv3BdjzokRNUUK23jsGK
 F5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Tb5jzyz2N5DnSvXkdt0v5yDKg6MZHCpQHIG9OzUmJV0=;
 fh=GEOXbkAnAohXAfhdq2wlnEBOK3RzZ+yaII3VlAvRLL8=;
 b=SXd6A9a0Yw4R8oBltWvjRF6TdCG0MLtUKnDvSJExcpbAYSBsdQ98X93nkTWzJ8u70v
 yL8OKZnYiGOtHF2GjVKtPSDtLoZtiQ2pUFWiFRanOTDP+cNFzEfmfBzT8tcpnzcya2Dl
 6pHAXSU5Anvtr32hQesyn2/CTX9CT0gY8lUerLJtT5/X/UsmviKzEFX1ZZ+2E5f/zr35
 nI27cBcwTWAvazHWLygyUL+3/PvnnUhi+XaW+sddx0Et+R45E23YVGg/HGoCd9oQNAaT
 GIAXQRR11h0XEBvNKnBgV5+2AVmzrQTczDYluQ3O49qWCaxtja3YbV5HREvuRfweqvHj
 +vlQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777138405; x=1777743205; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tb5jzyz2N5DnSvXkdt0v5yDKg6MZHCpQHIG9OzUmJV0=;
 b=P3rJirsTRmS2nTVgbRfvRm+7WpeGyefFWNtpmudK90gOdEd9/M+bbJ7knDwY/H4YPZ
 cQqER3e8uBxMTmEeEzeePwfrK/Xo0xTXz+WudGYtzkJaYhGsNbAzHmGCBnmy65M23F3j
 0IgxMBj8KlI9kpvkv6dpE58GgLvJ/OCEzmIak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777138405; x=1777743205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tb5jzyz2N5DnSvXkdt0v5yDKg6MZHCpQHIG9OzUmJV0=;
 b=o5uhA9vfTtAKmdKTY332ww4kTw0K1zpaKJN6V6FCIhbcMeE3a3wsFfCBtFYtbA2u7R
 8LOQ0h8j88WzixurOMIZFHpxTVvUS6T8rdiqiy2vTR9ygxsG1PYGvD0sSOA06aEVmYil
 lzHwYDxAKGvxmDfSR7FWt/TQ3yrL+SDQJC/A3fRwEvwSF41UOelngSV//VAoOLwXx+s5
 phGOHiJVGAYw/6Nv1ENmkiJu/GBTwbd0dCyGuSQvtVAW3kB56jIOEb5q7JGuTkoCuOy0
 eJU6WfFga9xBDUGbPFXXCayHm1fsOEnFDLSArjBzE32Xj/3ejLSTkafTvknlmvLpPYzv
 VA6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/c0cgH0AscdWUj9qZdNgs3CJ/ByMGrkqJQnzMEh2kIs4muXtIbCYlcXhX0EBatV5rBomeaAu4=@lists.denx.de
X-Gm-Message-State: AOJu0YxUQ7K7qXxht9cInMpzM0WKRu9MqbGawB8j5Zh8tix++HHlP9Fa
 N7mjOuB+3/0fX0dcU6gRbcr3O2rbOoKVN+/r+RlB2FINZRbCyaEx7nzxiQxuH7HdZBlfvco7iOS
 QY5SZiWoZdOKG19QeEGTP0R7pTQo8RopWY2kUlmm1LB9LQ0+PKIPR
X-Gm-Gg: AeBDievvIeyQECGZZmJYXExWDiGHtgs9voc8uXd6w6S0TXClmRBP1l8cOofGll4uPYE
 QrWxuwzr0dXWE+YnFFO+YDlPKgwuuliIK6eHOUTPLMvlHOZfeon/OVgeVLw3m4Fv7VH2lQ0TWDi
 HzswhmOe/b5CjJS8Qzb0s9d/YVhFI/Xfc7ZfGpii8WmDk55a+XPl08cryEvcO8aV2z76VJSHfoJ
 anCuMrAew1co/4+XOnWxWuPzxZQQ5xkBGanX52s3Sk/AxE+ZcvOYPPh15vqTgQ1EaUP9tWjcs/T
 75GEt9i/ZEHeNMZVz3dGsxcZHAyN
X-Received: by 2002:a05:7022:e22:b0:128:dedf:f56d with SMTP id
 a92af1059eb24-12c73fa3932mr19821712c88.24.1777081071497; Fri, 24 Apr 2026
 18:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260416093927.602613-1-daniel@thingy.jp>
In-Reply-To: <20260416093927.602613-1-daniel@thingy.jp>
From: Daniel Palmer <daniel@thingy.jp>
Date: Sat, 25 Apr 2026 10:37:40 +0900
X-Gm-Features: AQROBzBvhguPQ76asmVxH05x60Q8tU0BjOMLEcfh9cjS7J7T3owF9NJQutSUR2o
Message-ID: <CAFr9PXnjpBJh+0G42w2bod5ZMuDedf53xEU6hJJXT51+DN3syw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add virtio-mmio support to m68k virt machine
To: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, u-boot@lists.denx.de
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

Hi all (+ to:Tom),

On Thu, 16 Apr 2026 at 18:39, Daniel Palmer <daniel@thingy.jp> wrote:
>
> Lets start making the m68k virt machine support useful.
>
> First we need to fix some m68k endian issues.
>
> Then allow virtio mmio driver instances to be created with
> platform data and fix a minor endian issue.
>
> Finally, add the code for the board to create the instances.
>
> v5:
>   - Add Kuan-Wei's fixes for the two other goldfish endian issues
>     I hadn't spotted. Should be good to go!

I don't think there are any remaining issues with this. If possible
could we merge it so I can send some stuff that builds on top of this?

Thanks,

Daniel
