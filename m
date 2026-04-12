Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAE3E937E7
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 22:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1948983B99;
	Mon, 13 Apr 2026 00:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N2wxLAvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71BC983EC6; Mon, 13 Apr 2026 00:00:29 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4371D839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 00:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35fb16e56efso364373a91.2
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776031226; x=1776636026; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ir9+1D6sdH9XXHUjnwBZQA3nWGX6pOPIHT4P9Y832Xk=;
 b=N2wxLAvUdWX5DeADbA08m4Iw86cBWDh4PpXaTf24H7DqegnoGvhXfU7u8u6TA0pS3b
 2C5Eduqr6M01/KmbDpRVbGWbrf7v112Dqm91Om91IYXPnvlUM6RxTdQD001XPViuu4CD
 3d9BNH2yWnLskDuZoMk/CYNW9GM3KdexSjyZdAamkIZuhU3yUXVGtUDW+2dO4PVKiosy
 V51rIHSvDPSsB2W0v7o+TR0jRoQ9VvbQH8Yi3N5j6S8qsCU0d8+jpmNGFkRJjxo81b8D
 Al/218OkDtERFP6TNDmcRVcGrv04v63QWQv0hPZQvxtN7I2DoB5kGq6vW6TcHtq+P8w5
 cjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776031226; x=1776636026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ir9+1D6sdH9XXHUjnwBZQA3nWGX6pOPIHT4P9Y832Xk=;
 b=nFwoHCv8AVWkynolh7VsjE3Hj0b+bz90ERZ4cM7I4tUnTdYoku31qyG21fcz+by8sH
 0bxhR+2+R2obLcOJBvCmGwNlKVb6BAp03FhRHcJKoX8KeIGqiVSyiOFRPiGi2Tz75eEx
 IptI/1nHB9/bSWLONzKvvDan5xKNUhi+UdYaXRQTFBLTyDokDV+6KPIz8jGFYHIKMEY6
 3ni/YYf3AOUYB+t/txjTWGqXEiwBNsDZguQXF9dYVIGF4xwBH7oheCvclQc1cwsl91qB
 Ji9rEhhKDAVi6LnggN/89dSF0HuFVNnN57zIGsjGdCgzcEobtGC/ah3vBnw/Yk4hLgM0
 8MHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ91/rcc1ECT/LM+Hj7SDgjq7HeBjwzyeGhmowkdpO9UcApR65TVCBDhkgfyKhZ4QbvRz0pO4wg=@lists.denx.de
X-Gm-Message-State: AOJu0YyeyOPnOjfAaianf4zLSkKExUoc+/k6/nBA77TDawiwllQtNA+r
 WgOWwo3aGRRGEPqFVueHsNkkGHIZzB5pOOHSZTmzDqHuHGrDdyVxabCA
X-Gm-Gg: AeBDiev+xBG598OASj8/lw9Y0fkOccEmpvXwdTWD+swdOLk92WIz3axAEPu9eT8eWwi
 TY9TR+TuJ3EQoOU6TlwPoXZLEseFiYr8FvyS7wFcS6/0cFojTyk7/TrReHOu01rtMi6BVQHS6UC
 2H16m8AGkqT+VY1mz/wEzM4a5TttjKTK3DMS1ewst57hd43d+kysnVJxv8o8wlWi0qQnppBxCQ8
 kmbojQgQ7MB1yAXHK/p/viJJoTBnW+QdN1B0tNFamDGTxk6IzYHjkNN5TTqQ93PsRyY3oUApcv4
 qC5aL0uOXVRdxOAe/yByPPwme6OYrUPf2hwbSdVJoq0YRiYBOkrEVglVAP6yWZzH+dGdSfTSdnF
 e+NpU60KIcxS1KkZNa8RqpzwNjRHpRY2CCUYOeZ1VgBj/GNoaqHtRy4/pcNTxJYVc73U9ZjtS0i
 gFTbXeCeoNMWcyHH8v1ikzQlz+LE7Gx54uTlJ4MA/R9uo4iA==
X-Received: by 2002:a17:90a:e7cf:b0:34c:fe57:2793 with SMTP id
 98e67ed59e1d1-35e42881e54mr11039297a91.20.1776031221827; 
 Sun, 12 Apr 2026 15:00:21 -0700 (PDT)
Received: from google.com ([2402:7500:477:c367:3a21:b5ec:1429:fbe])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e5a218959sm1167648a91.2.2026.04.12.15.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 15:00:21 -0700 (PDT)
Date: Mon, 13 Apr 2026 06:00:17 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 4/5] virtio: blk: Fix converting the vendor id to a
 string
Message-ID: <adwV8fQUTwBlo1sj@google.com>
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-5-daniel@thingy.jp>
 <adwP6m1zDjUQWAl0@google.com>
 <CAFr9PXmVeWjFNM8x0rKeLHjvZOFLyvbMyNngt8EpMqkBbugHGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXmVeWjFNM8x0rKeLHjvZOFLyvbMyNngt8EpMqkBbugHGw@mail.gmail.com>
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

On Mon, Apr 13, 2026 at 06:47:37AM +0900, Daniel Palmer wrote:
> Hi Kuan-Wei,
> 
> On Mon, 13 Apr 2026 at 06:34, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > Is there a chance that other non qemu virtio-mmio devices also use a
> > 4 character string for their vendor ID? If so, this patch will regress
> > their output from a human-readable string to a raw hex value.
> 
> There might be other implementations of virtio but probably not used
> together with u-boot.
> I think this goes the other way too, we are assuming the ids are
> printable ascii chars and it's possible to have an id that isn't.
> What is currently happening looks like luck and seems unsafe to me so
> I think regressing to printing hex is better.

I just took a quick look through the virtio spec, and indeed it never
mentions that the mmio vendor id should be a string.

Given this, should we even treat qemu as a special case here?
Perhaps the simplest and most spec-compliant approach is to never
assume it's a string, and just uniformly print the hex value for all
devices. What do you think?

Regards,
Kuan-Wei
