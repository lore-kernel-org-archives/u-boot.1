Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3D0C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A07486EE5;
	Sat, 18 Nov 2023 18:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O8vT5Swr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9AD86D11; Sat, 18 Nov 2023 18:11:51 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A39E686FED
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-da0359751dbso2406846276.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wj5zcbCbjiRoyfTHZS+q13lODUJjSVnPkbHMcQNq1LU=;
 b=O8vT5Swr2hr3YcmanKNyJIaiCkXfUM4ICdp/iSl7CL8PMpUYNeJIVTuJ8049+ANVOh
 ivs0ZcXJgnhDyJs7W1Cr2UYdzsUtc1RF2CZbZnvPPQdE5CVuOldl3PiSt3XjTRQly5Zn
 9eIdYP7gsDPn4ZRiTAgESjnaX9ZJOHUtQ1kSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wj5zcbCbjiRoyfTHZS+q13lODUJjSVnPkbHMcQNq1LU=;
 b=WjmLg5Q0jzDE3gthqvm8eXu+TVRRkuTFt3V9m2Kmkyzi10YyIVptSKCAFY87Olgboz
 ovig28d4iPMrW71SSSmvrqBEAqPL1E5KvQiUJcOrShfo3Nr7rJRqshxZANh7KvR+f+f6
 Y/TTJgw1GVcU3SlIRik2KB1vXamMfZHF6HVEgRPFIZYaNXPF/5I3inpgaH6OWrL4dqoV
 uy2l7XPrvrkGlvdGEmlZSPy1B3m66h7728CauJY+XTjnJvRS8rYUQLEtaulg/BJFDdGc
 r39CPDCbVcxiCVyP0bmMbmx3PzW8IuwemV97+qa//Fo8+L2KZNeVYw8i/lZyYCnlcZpr
 K0YQ==
X-Gm-Message-State: AOJu0Ywqm6s+M9qa45iieuSIdk5tyqojJhQ8fVhoyi73GQUNTA/1RakL
 0fAxlTnkVjMH0B2MFLSqzpxp6Dy2Ha7nKV9ZcD/7Iw==
X-Google-Smtp-Source: AGHT+IHgpuVTeXTSHIQRKHE/a9ajfGoQE5P+fxwe9sDPtuwldiDDXtIfAVFCVCCXw8LAvx6czmUU9Fs8mFbEluz4Xl0=
X-Received: by 2002:a25:49c6:0:b0:db0:bc3:e21a with SMTP id
 w189-20020a2549c6000000b00db00bc3e21amr5535296yba.5.1700327504873; Sat, 18
 Nov 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231104203753.1579217-1-seanga2@gmail.com>
 <170022845499.752997.11727109077004834794.b4-ty@konsulko.com>
In-Reply-To: <170022845499.752997.11727109077004834794.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:09:52 -0700
Message-ID: <CAPnjgZ3A2yN6zJ+dag-P4523M9mLjyD2fxbyYxSNBBPEzPfi=w@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] nand: Add sandbox tests
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Weijie Gao <weijie.gao@mediatek.com>
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

Hi Sean,

On Fri, 17 Nov 2023 at 06:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, 04 Nov 2023 16:37:38 -0400, Sean Anderson wrote:
>
> > This series tests raw nand flash in sandbox and fixes various bugs discovered in
> > the process. I've tried to do things in a contemporary manner, avoiding the
> > (numerous) variations present on only a few boards. The test is pretty minimal.
> > Future work could test the rest of the nand API as well as the MTD API.
> >
> > Bloat (for v1) at [1] (for boards with SPL_NAND_SUPPORT enabled). Almost
> > everything grows by a few bytes due to nand_page_size. A few boards grow more,
> > mostly those using nand_spl_loaders.c. CI at [2].
> >
> > [...]
>
> Applied to u-boot/next, thanks!

Congrats on the test, great to have some coverage here!


- Simon
