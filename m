Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33286E6748D
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 09:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8845883BF1;
	Mon, 22 Dec 2025 10:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="DviZLVFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BFD683BF1; Mon, 22 Dec 2025 10:20:33 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04ACE83B99
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 10:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c1d84781bso4263502a91.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 01:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1766395228; x=1767000028; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cYjw+/V+Z8jVhqkAp/e/+PGuJNLuaa7qHhmgSNtWrPo=;
 b=DviZLVFL8j2UOa6sK4rJ2xap3oSdBkdBO3GeJtAFRrnD4qmEGtSd0ZnAIpVpwNoV3M
 YRAKyMmpvkYB/pXB3WMKnVn5I1F+lm8yNPaUJbS8/Nwl5PoMs3kOm8aBA2SpUkMsFF4W
 a8PwZELsifF/8ield0sXlj/xBgRvQz1VIZ3hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766395228; x=1767000028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYjw+/V+Z8jVhqkAp/e/+PGuJNLuaa7qHhmgSNtWrPo=;
 b=qZWz+K7efSn489ISL81pWS42elMSyWBeJ+TBmSOvppyJIbdeAUdQY8HVBm/YksdAjQ
 uZ7ewpZyGvULX1Mnb2byhf/Nr3BygqyjotN6GWgPtoAxve0jlxKJxQwwxf+wPfS9R9Tj
 U60kZb0Ebq1z2tK58+0V5v7oTfwkgUTzMJse3ANQYDGK1jmnwqNgFWd0CjLOM/udbGND
 VbXzpmJpkuQ1rfN/iijAMIoe+fNzwEZowNpaaC1IkIUHaAvh1Hi+hsbbqVEV9QrziQQo
 ApvZD8D9y/v39SrwBnM6BO1N37a6kmQL8QSI5sxhf3ig/ETa900zEKAiGHMr7NE6gDLw
 6TRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWdOKq5oNjJZvyrA7RBpPd9GqptpLKqG74B/hNb7d5APE0WhtZCmVROo1AAqw/H8iNYZcBbCw=@lists.denx.de
X-Gm-Message-State: AOJu0YyWb+835vzY9kVLatpHumWVaZxfo8F8r3B00iTJMQX8Knz1baVv
 ErKOgpDrnpQr1Llb8aetoYgCvnSavKVkRofsemObzai+sm2U4NhQtla+tWZ1s1MOVcWUINDQWU4
 BmyBFTQQpEKdsLP9QzgVL0VZuKthXgobcaecBpedjKA==
X-Gm-Gg: AY/fxX47Xp6ZSQ9DDKvLUUY7gnXy4UnnepbbmzbjkLxpucOeAaIWXYfkbgZxu8uL+iE
 QmeuxXLxNyynxcPMwHV1+0611dtUBcqqJHRuSohbsPFAWbt0x7xCfrqkaSCiXC6wYIvsKgBg008
 n3eIzSj6BFcvbgTGDgxlhopZh8UQmNKjc4Kgsr89F3xL//F6WsqjH5U3iNtfPSTwCcCYZh0Zx+d
 a+o8Vc1s6VNvCIICTSIqY5J+kFvQP7wdf2xu2ue0FlqUCxs398vsyb3fTLuSjyjSN3wHFgz6BV9
 JoWWyVA=
X-Google-Smtp-Source: AGHT+IE2heDnCl0E4Xm1lynBv0s+4Kk48xqLx/i5hUPIsUaopa0GHeVxS+KjahfBEHNJTngMShVMf5+S5fJ4n+Prhko=
X-Received: by 2002:a17:90b:6c7:b0:34c:a29d:992a with SMTP id
 98e67ed59e1d1-34e921d6cbamr8412541a91.34.1766395228208; Mon, 22 Dec 2025
 01:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218190059.GM303283@bill-the-cat>
 <CAFr9PXkk3eOYDZbjTvZPgT8Cv+Wd-+hiEA+hPZVOVD0BJZ378A@mail.gmail.com>
 <aUkE-dvbDyZA_Ewy@google.com>
In-Reply-To: <aUkE-dvbDyZA_Ewy@google.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 22 Dec 2025 18:20:17 +0900
X-Gm-Features: AQt7F2rdu-Cjj5kwDXc8H_cCn8IyBS2NoZ3CEs1pYLQ8Yo7uU1arxJh_BHjrAX0
Message-ID: <CAFr9PXk5v0vBHibUgyczDqZth8tZCWw2VgD_yqgKa9cxKsUg+w@mail.gmail.com>
Subject: Re: [PATCH 0/3] m68k: Add support for QEMU virt machine
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, alison.wang@nxp.com, angelo@kernel-space.org,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

On Mon, 22 Dec 2025 at 17:44, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> However, I noticed that your branch contains over 100+ commits with a
> diff exceeding 15k+ lines. Attempting to integrate such a massive
> amount of code directly into this v2 series would be extremely
> difficult and likely overwhelming for the review process.

Yeah, my branch is something like 4 years worth of tinkering so there
is no way it can be merged.
But if you get your goldfish serial driver merged I can delete mine
from my tree and it'll get smaller.
If you take my goldfish rtc/timer driver or write one and get that
merged that's another thing I can delete from my tree...
I think working incrementally is the way to go.

> My current goal with this patch series is to establish a minimal
> baseline support for m68k in U-Boot (targeting QEMU 040 first). I think
> the best approach would be to get this foundational series merged first
> to serve as a minimal base,

I think this is the correct approach. If you get your 040 parts merged
as a first step I can rework my tree to work on top of that and we can
pick what to do next.

> and I am more than willing to make
> adjustments in this series to facilitate the future integration of your
> work (000/030 support, Linux bootinfo handling, etc.) incrementally.

I think for now do what is needed to get your changes merged and we
can go from there.

Thanks,

Daniel
