Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C937BFB5173
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 01:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550988352B;
	Tue,  7 Apr 2026 03:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="RaIZjl/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DBF883EC6; Tue,  7 Apr 2026 03:00:42 +0200 (CEST)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6E48341A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 03:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-12776bebe9fso10318112c88.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 18:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775523638; cv=none;
 d=google.com; s=arc-20240605;
 b=j7NRIij5uHxwV4xQNIJqR3LyOVJGsfw4nUrsm8vQoySWpxk2UcTIIuc0C3i4kTNxLz
 aL7oVHFsbXQHAtTSvtmF5Cet3RmtptkywZ5xq0kd2F2aO1cb4JwmCDfJi76R5OphwPIb
 m8Vsp4mOHYNcnb7qRFMVqvwLnGZWDIwWWzabhwokI6SnbL0b9L7ee0rk7RlV+D0xVQGI
 nsxDc441v4owxoMFynWyWvmYwoIwx1zHIigdO2Y9wZvvl3ic4O2Bck2xK4o1gdkgVpQC
 Cibkqs9xVTpRZgDK8WGEjVQNBsahYaRGFAA/bj5e1EQaWl7igf6RE+tVLalxPEJbPSeG
 pEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U12V4bWGLE4/PugN/2vXrreKGABbB6akVYH4BJa6g28=;
 fh=Vi9N85O35269yefhoiZhkMxNkLg8OSdM7sXwjNRCm3w=;
 b=Xvl0nPSIajkKg8q1gb2o0fYQTB/23xo27a/UfVWxrnz0ahqazV6TA+qTFyECXrvWa+
 iAOe9QQPjG2UoaqOfgoCel90cwEPRyYthylx5sqxMWfdnAYHevnjNSByWFG1FIlbKs5j
 RT+qM8UgGlW/Te5V3MVi2gZgEfjg7I9nlUJ7Eol7txzUl0rbHLoIxbLFyAwamVu0Ue4P
 fmqCJHMAJRZVsEY7P/C/Zi33xDa+egGe6C7Zly5mgflwun4QmZDBmr0eDIzNcSeNyfum
 0aC1xbeHPX/vmPi7Lk3d/1rSNh3/igw/IL7gF+7xlwLMqUZ7ga3BspqRb/iiX7QsTxCp
 59AA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775523638; x=1776128438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U12V4bWGLE4/PugN/2vXrreKGABbB6akVYH4BJa6g28=;
 b=RaIZjl/MI7UUyAPQycuoRuq9fEiWT6hvMApwlsUAsNIFPCtr/Ov1MnJE9uACpkM+2J
 aOFa7N2D9swv/M5pDIyB7JvJHvAcOnLt6kesfCErERTuuGrJzaz/xnFd2Adar4xCeBgW
 z63bR8XZpqXule38hj7viRlDuPmVRHRtSeNeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775523638; x=1776128438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U12V4bWGLE4/PugN/2vXrreKGABbB6akVYH4BJa6g28=;
 b=o57W8kDAQx18IZnIb0b0bCZ2e5XnRP9yKr05wJk/eFcs+iEmTqqy9yWHHblBFmzIkB
 qHrE6rZoewvHk4pzCG97EonEG/emhOHVOkXAqBAOGD846Qd2tXKmZZgoAKZE/vrRcfu6
 QRsYEC9rRS5nxyXxJsSZ+GmHvrNzUvqpAdttDSeVu7lYHJg4TdWnIun+VWa8cfNzgtQp
 77ZHUYzaA26+un6eEIxtHhuXvJ3qzuSDgH7kadE84vcuFRI7DOM50UyL+xMLewACsHVo
 Chh43z3NBlmbwG5pnedkvj0ytGL1X8WhrkIYB7MhNMhi2cIy4RwLpCvUsoXtbWOgHK1Z
 b2Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY/FjS83CCo3DYowrvBlzGUZApSvN2UGoA/WYpBdZGSuGgmpQU0nrTvLsVpbI1+uOfK6TCjKk=@lists.denx.de
X-Gm-Message-State: AOJu0YwZtUiCQX9+rNld4QVvW5/kqLdoFEfb1eZkRB5F3KqecFSPJpxM
 fJ1tq+IwRpakyZgodA8IKxuOm8mJsSZawdKz+vq9Tl9MxfTtGuqFNoMAsMLQNVrb8HDibrZI6ij
 HuesGvMNhEE6uvH3N+Un7dI5gnmmovcHuSaPEd+JlTA==
X-Gm-Gg: AeBDieujCH7q2XChPZEL3/NT3w/DXMxAJpyBpNvXnGGy7bsSzG9hNlIQGuAP0p9WooQ
 l7GBj1iSmebpqyrG86XqWkSN6apNoKmyo8G4wsqw0liYmItnrJYr1AEb7+nzz+pwLL8ItVDWHJQ
 DPRAd22uxZ7KoXX95U8erzlpmuWL5oAM9qiF2r67dZVOFOmbjwacISWOjv7XD3uwWl3/7ftXqaX
 QhNBZr9DYKPXF6BvLhFbe/51+20qru7k50bljDLf2Aq1iM5WEJV27d035WPbVY13ep0ImbrfGo3
 boSj
X-Received: by 2002:a05:7022:fe04:b0:11e:161:c008 with SMTP id
 a92af1059eb24-12bfb75edc1mr8077649c88.26.1775523637642; Mon, 06 Apr 2026
 18:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-4-daniel@thingy.jp>
 <adPlWa9YE9_FZJXe@google.com>
In-Reply-To: <adPlWa9YE9_FZJXe@google.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Tue, 7 Apr 2026 10:00:25 +0900
X-Gm-Features: AQROBzDIuJLz-Vd7Bt694gu39YwWdC6uTDjKDLBW9zZ6NX6FehlgEmDgvMpQdKk
Message-ID: <CAFr9PXnPvje0K8kZ-zgo_Xx0OMZCYCYkhddEYSUEgZ=5jhYv8Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] virtio: mmio: Keep vendor id little endian
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

On Tue, 7 Apr 2026 at 01:54, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> For example, if someone in the future writes hardware specific logic
> like if (uc_priv->vendor == 0x554D4551), it would silently fail on
> m68k.

Yeah, you're totally right. I did think "hmmm, maybe it's actually
just an issue with whatever is doing the printing" right after sending
the patch. :)
I will move the fix to virtio-blk for v3.

Thanks

Daniel
