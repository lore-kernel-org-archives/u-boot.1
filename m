Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40CFD3B7E5
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 21:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB33D83BC8;
	Sun, 28 Dec 2025 22:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DTA2JsUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE81583A8C; Sun, 28 Dec 2025 20:13:35 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 956F983A3D
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 20:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7aa9be9f03aso6914532b3a.2
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 11:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766949212; x=1767554012; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S6f+hP7GTwuu5m9YyOQEziGynKol8K2Aylj7HBxhysw=;
 b=DTA2JsUHeA4iK/BeTuTqhPC5IVIkapM+Zow7Txmi2ebMFDL68Sd2iTjJRAOFYfaVoq
 zzTBH4MbfS+bEp+OSwgH4X3Iwn6gFrsJdClr/wtnwagN8T1qxZcqx+wvkr9wl1K5GKw2
 +zn80M9tqvdSiZj6UQ55iRoYOFss4u5x1hI9K9sAGU/YEOB+xF+pwxxdWT91Zd52L9Rw
 VXzB65q6od9b/qxdLJRCIoPOXZkYip0OxPSzjnmEy1EVv7ukUqnzUsXMbZNbvXWfkTgb
 CfcauVYOio9NTr5Z1SMp26mKIMigGeEH5la8KqKzrZQ4ldqOVcv2JYanCMCtG0Ok2IrR
 71GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766949212; x=1767554012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6f+hP7GTwuu5m9YyOQEziGynKol8K2Aylj7HBxhysw=;
 b=AXOKwxR9iQ05IqRDXEuKwP3dUusT4uZw5Rg6nVwOtrFjylTR73cw1MIhRh3yZXDWGt
 ZhG/8vx4REujIskC3xOxQBHzYi/1DCxMSJrqxhO+lOuUBFwFgraH86SXwd4Uz6JqfzDD
 QkeGfM0tym2AulRYsJBaMhZ3BezTpH5eYOyQqq6CSryLGsYAZr6rt8T0ejHF/vZGaJba
 U4qBFuCCHHl4bJOqZfkvyg0Lo6G0fZprsBxoztDrAGcU9CFCmMYz0gSepJJ/c4AMeDr8
 Py1WX2w4VnTFLS+iI7ZUCEA78bnT44JSW99APdREvPtT3U75QKGLYOgcHCiPLwzMpKtV
 d3+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXibogXwYY9Q2oPWOOjSani5n7lMaEJwpZkecbSC/n4brv6pi/tzr+bqC8i+ehHsqzKZgH26gE=@lists.denx.de
X-Gm-Message-State: AOJu0YxZ4RNBL2ulSP6Z6jm8V7PujUwCtFP0FJm3IYDq2V3RCqJR5eBN
 yzwCqz1gyVSKD5r/1jq1SmI7kjIKC+Sy8zIeaPMqfT8ziBwRlQTbY4Ty
X-Gm-Gg: AY/fxX6iUDK0qC/dacfGWPjIFfqKj1f8RYgbmR9PVwSu99/B9GWeeCldEfdKag4cn/F
 r0NsEaizfLhkiaXSIl5E0GCsdj08SBn1AlIsKJaZ3OyBMjkL6zcYzMl0w0O5fNnUcH3Uk+oyZ6s
 Zu/8kuA39n2YOp/AHETMDp0gSsWdkkMmFbNygv3D+ROwvxfbJ6QyMzcXX6FHPqwIySJC8Nzuzsh
 WW3vaBqp6PuGCzc+QN+HDAKkW+dxFLcel0U5pzdLks6QcfAu7VZ8PYd6WzyhLrNcKA0z4gC51en
 CrNYGAQ1Zmp1njbaI8q4mAqiA6C1UndEbXMf6MW2oQ7b5Si+SVJCWSz1Th0LiltDTk12SGz322C
 qIY8LlHjgVSrHhD1j1a0mEJaipLZ6q/aLdgpn4Rg8UgWRcoWH4yJkiGNGYR7xa6NL1IlkPTRDLw
 u4JbsyXQvizdKHFFuExS9LYqgd
X-Google-Smtp-Source: AGHT+IHhgYXoc5DSqKZh+fJ+1bArE8gYeOFj9wq8JM1mP2dIUIblOnnYBNfEL/nZkM0916KdjoYkvg==
X-Received: by 2002:a05:6a00:44c7:b0:7e8:4471:8d1 with SMTP id
 d2e1a72fcca58-7ff66872721mr21050990b3a.50.1766949211986; 
 Sun, 28 Dec 2025 11:13:31 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:67e0:3b56:a860:6efc])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7a844d5asm27235374b3a.3.2025.12.28.11.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 11:13:31 -0800 (PST)
Date: Mon, 29 Dec 2025 03:13:27 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] board: Add QEMU m68k virt board support
Message-ID: <aVGBVwgr8528wTcn@google.com>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-4-visitorckw@gmail.com>
 <CAFr9PXnZPOw3V9vwxtpvkVFfjOt10ZmfSjY6yMLcFnGW15bvZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXnZPOw3V9vwxtpvkVFfjOt10ZmfSjY6yMLcFnGW15bvZQ@mail.gmail.com>
X-Mailman-Approved-At: Sun, 28 Dec 2025 22:40:09 +0100
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

Hi Daniel,

On Sun, Dec 28, 2025 at 10:16:01AM +0900, Daniel Palmer wrote:
> Hi Kuan-Wei,
> 
> On Sat, 27 Dec 2025 at 02:54, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
> 
> > +int dram_init(void)
> > +{
> 
> > +       /* QEMU places bootinfo after _end, aligned to 2 bytes */
> > +       addr = (ulong)&_end;
> > +       if (addr & 1)
> > +               addr++;
> 
> Maybe ALIGN() or round_up() could be used here instead of manually coding it?

Ack. Using ALIGN() is indeed cleaner.
I will update this in the next version.

> 
> > +       record = (struct bi_record *)addr;
> > +
> > +       if (record->tag != BI_MACHTYPE)
> > +               return 0;
> > +
> > +       while (record->tag != BI_LAST) {
> > +               if (record->tag == BI_MEMCHUNK) {
> > +                       gd->ram_size = record->data[1];
> > +                       break;
> > +               }
> > +               record = (struct bi_record *)((ulong)record + record->size);
> > +       }
> 
> One thing I found when I did the bootinfo parsing in my version is if
> I corrupted (during relocation etc) the bootinfo this type of loop
> would often get stuck forever.
> I'm not sure what the technical limit of the number of bootinfo
> entries is but bounding this to something reasonable feels like a good
> idea.

In that scenario, I assume the correct error handling would be to add a
loop limit and trigger a panic() if exceeded?

Regards,
Kuan-Wei

