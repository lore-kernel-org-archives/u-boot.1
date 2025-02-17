Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B42CC021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F08380F0B;
	Mon, 17 Feb 2025 14:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P4p2Wohc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967B680F0B; Mon, 17 Feb 2025 14:14:28 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5CE80017
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 14:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-abbac134a19so66208066b.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 05:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739798066; x=1740402866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4zL5WLM+XGGKQbx+Kuz56TgLIbD4ufsTEuFj/QwjWEM=;
 b=P4p2WohcZOtENiusakY29zvcLQu9jBBnQWXKhIWq872r+rMSA/3feEC2sdCGqJGphX
 mA5U8/rUV5pbbfsCwA0asdR7WPkIwNAvqlxm2724MrWSUThNrzHSGk+oFkP8WMnNp/mT
 /hh6caS3ToztXwCdh4S6AX0i/A8kD09E8A/1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798066; x=1740402866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4zL5WLM+XGGKQbx+Kuz56TgLIbD4ufsTEuFj/QwjWEM=;
 b=LU9RPc5D5vtcQWARdop3s/KuMGEZcD1h75wtDsaoZ3xnCn59B7crWcLVUUjI7mjPky
 ZUUEiFgKmS53bqtIrBjz+wouVG2g4Qdh6jMAe8BcFtSPSwecPlGfPc7HVig7MR1He2HW
 yifeG5toDV3CuHYHqdhBlazqsHKngiWuj+WJFMri+1rX6h9YdT7EJm+JK2I0Le6qzT9C
 d8hGY5xPO/Bf10J82bgxn9jha+th3cGo36rh4AIgD5bcV9Uk/UA+b57rBfapaJkjCerQ
 tVaCZVpLx5uNFqNNJ/xrrTKCMEGQMk6JTP5QgfU3QCiwUUPxG+fb/U6EAs+q/VZJmnfI
 8pPw==
X-Gm-Message-State: AOJu0YwLkTvmVcHjVgr22w3FWGK6NI0SvcylLYvXcxzxXNx+8C8SAIwE
 hexP4QUtzLUSrog0PF11i5hio4qFIJNNpierwx+J4enYruouEWClcgZyr3OEteW9FDLOQDBrx3B
 Et2PqzLblRtzN6XPEmjvjUS0XL2nrSGw/xkNefKn2OkZUv8Y=
X-Gm-Gg: ASbGncsyBMLIbf1XxQ8kwE/kqRlTauhvblGiRYm4TwsSYJe+VKn7roSFDlDhhbDG062
 jGK9t26ecjkS0myICJnPCGpbAopogzhpKhv5nHIHYFKBSEQQXqSmPzveZ4j6264Y9ZchPh29m+Q
 ==
X-Google-Smtp-Source: AGHT+IF/1iySFLb/kDUQfPf8UNpTdOkk2BDD7dsLGOxxYAC6p1ZDdCRdBybZifO/RAfR1VF2Hil7XBIQDR0v21votOM=
X-Received: by 2002:a17:907:86a1:b0:ab7:cc43:c51e with SMTP id
 a640c23a62f3a-abb70cbbcf2mr866851866b.13.1739798064479; Mon, 17 Feb 2025
 05:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216215738.GF1233568@bill-the-cat>
In-Reply-To: <20250216215738.GF1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 06:14:12 -0700
X-Gm-Features: AWEUYZmUIzyYmihCb9G0hTZMkSSZaMXJeifIx5Ci_JOZ4oG1tkt8BoAi4q1MRs4
Message-ID: <CAFLszTjtgMT6Pd9_MG8t4irU-jyoHTd40MwX5m1iqj4rjVED3Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] x86: Improve operation under QEMU
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Love Kumar <love.kumar@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Oberfichtner <pro@denx.de>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 qemu-devel@nongnu.org
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

On Sun, 16 Feb 2025 at 14:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 01:43:45PM -0700, Simon Glass wrote:
>
> > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> > is not perfect.
> >
> > With both builds, executing the VESA ROM causes an intermittent hang, at
> > least on some AMD CPUs.
> >
> > With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> > is done in a way that works on real hardware but not with QEMU. This
> > means that performance is 4-5x slower than it could be, at least on my
> > CPU.
> >
> > We can work around the first problem by using Bochs, which is anyway a
> > better choice than VESA for QEMU. The second can be addressed by using
> > the same descriptor across the jump to long mode.
> >
> > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
>
> This seems needlessly not against mainline.

I just tried it and yes there is a very small delta. I can resend it
rebased to -next if you like. I'd really like to get some OS-booting
tests into CI.

Regards,
Simon
