Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62AFCA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 18:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA5A832EB;
	Wed, 10 Sep 2025 20:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nr6kmNad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5076083280; Wed, 10 Sep 2025 20:14:55 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8C2833F5
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 20:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-74526ca79beso6052803a34.0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757528091; x=1758132891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KiBNu18VQdyAxnwGEzZoJq8MR3OvDTp7YLekGxoZPI=;
 b=Nr6kmNadUIkTLT66QyL0soSCEF+uIGXx2dMdk05FodjL/nO72UYVMN4mCn4EJN/5dJ
 maLUEfnyZ/+dgwUYQH0ncZnum/z+XfLcCBXWfXqa++EXhiG0Yj6pD1xsKeBANMGQKXOT
 D/XlVfAp6kk4Zc42lwDlUO4kP42dy7UZKMBtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757528091; x=1758132891;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9KiBNu18VQdyAxnwGEzZoJq8MR3OvDTp7YLekGxoZPI=;
 b=tdJ8IcX2iM/2EFWiwBrK/N6yT0qszIsT9IYyi59rLyXVpEMlokywO1o+NZJES3NHTq
 uYiY+RcMUu63v7BHMDb2nLaytXhdf+O2Au25f5y9PWTLqDoPC4O5EANDhHjwXl6j9TsC
 hhOQbweTqe1CH2frxcKwh797PAOYKYTJLaMOIxTRlfv91Xxr84Ji7XzuvzN8VwYM/8dG
 chmX7o8XP5fwGkvtio3qHe8QSad/YIFwDEFB3H1b2Hd9WGu7N8nXWeCRXDkiJcK7pye3
 +GKM1d1kaMObTCbvw5giN3QjLhCrBOkdIpRjTjQ/AmKZrGNksCCs0faMiVUIfTgtgdxk
 n27g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWugKY2emFA9DoPUrASP2hhhXKmLRth8NRVRxK2uREUymPS1GDIUahmT1TNMqbfCYHhxoc5ZNI=@lists.denx.de
X-Gm-Message-State: AOJu0YyoC3Rr+5hsAg3IvpP6ZD2LjoMqIKK+F5YJf+YverkiymI4AdyA
 hAfFADuopbi6N8pwBQrt/6N2ZYAyWhfla35dPYdxQFw9Bne8RZ+dKrJf5DoQpD0Ls6E=
X-Gm-Gg: ASbGncvwg8bJYJKiVmAEmhXRQ6lJ0N6EH+AsBK31+M+jmK8QP8GTrFy7cDBUOwzy1Md
 Ql9WGHbdABqXM+XBWvjgIml81L0f41NVC0MjWak7N1yXQCGENyqMnyL+XguUougAK1Ha75Rrsvg
 /JMhWRwZMooR/6lYX2iKPMqiqJKVG4mRTxjyZK9eLhaXDyzxS5NjTY3oaqcFssfrRrkFFIaEZLS
 Pe+aC1U+BYUwJLl1wQaU5p9nW2rY4OC93cyZNR44e8sZBHRYgLnkzD4CTK5V8B82NI4WzA5OVFk
 pkqIJIBPqQZD9mSoCvIysFggwfQUpHXqrK4cnhVu7rLdB8mjgYKtYhbUUUkuN7WCWVIvhPoZZUI
 0rkIbuRRJ4+kUg6i+IfVbAhNbyjReYvzLGIwq3OgL8pDTYWyy8tjLE/6I04jiftKYPg==
X-Google-Smtp-Source: AGHT+IFe8dlJJdocWFcBF8d0aILBo0b4Q/T4rCEiGpkEl/8gfwS8Ri1djzQmx2n6n0FnAKjfTGb8gQ==
X-Received: by 2002:a05:6808:48cf:b0:43b:5335:2327 with SMTP id
 5614622812f47-43b53352362mr3321233b6e.42.1757528091499; 
 Wed, 10 Sep 2025 11:14:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75200e6a1casm18100a34.17.2025.09.10.11.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:14:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Cody Schuffelen <schuffelen@google.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20250830203954.25775-1-heinrich.schuchardt@canonical.com>
References: <20250830203954.25775-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] virtio: blk: support block sizes exceeding 512
 bytes
Message-Id: <175752809048.1959855.9760957898579406054.b4-ty@konsulko.com>
Date: Wed, 10 Sep 2025 12:14:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 30 Aug 2025 22:39:54 +0200, Heinrich Schuchardt wrote:

> QEMU allows to specify the logical block size via parameter
> logical_block_size of a virtio-blk-device.
> 
> The communication channel via virtqueues remains based on 512 byte blocks
> even if the logical_block_size is larger.
> 
> Consider the logical block size in the block device driver.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] virtio: blk: support block sizes exceeding 512 bytes
      commit: c85b8071e7d3fd333f8a2fdd28083cb5ec3a0645
-- 
Tom


