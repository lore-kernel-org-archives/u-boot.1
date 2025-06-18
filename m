Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504E7C7115C
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B4282B18;
	Wed, 18 Jun 2025 09:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QuAAeIDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F3C082BF6; Wed, 18 Jun 2025 09:08:19 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9180A82B0F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9780DA523A4;
 Wed, 18 Jun 2025 07:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4486C4CEED;
 Wed, 18 Jun 2025 07:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750230494;
 bh=QaddolRz2bvyebeiAwBoqVaHI/C+6/lsoBm+md8rW9s=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=QuAAeIDoyzVZWOapVSJDLI/oFQh7CEQLnzWg9Hl36fxHMfUodwhYzFDB7dd0Y97m4
 iFQ4mSMvFDLGu4aJqwfHmn/J5DJjMtvhbAdY+reR+bagVHpxUxo2lUeqUbH4SqCmoD
 IRzZkIU9RwyaqWdxRZ0EmkKLgJy3MXwSJSYRfE6LBCu8F9Z9NrzXGKrA5wHopodCYB
 VXIZ1QCALM3lIB3bG/S/xpB5rFPx7Yh23QOAlw15LpixlFI8Xshv9KtMdGhXRuG3D3
 fxXoVXwllcD+G445jDQYdTxVSUIMLjMgZLZppZEKRSnVFnpO3zdDgE0BIv/+GBe4XJ
 hWwbVzORc9cjw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [RFH] Future direction of the U-Boot project
In-Reply-To: <20250602222738.GC100073@bill-the-cat>
References: <20250602222738.GC100073@bill-the-cat>
Date: Wed, 18 Jun 2025 09:08:11 +0200
Message-ID: <87msa5ttlw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Jun 02, 2025 at 16:27, Tom Rini <trini@konsulko.com> wrote:

> Hey all,
>
> Something I've talked about in release emails earlier this year, and
> promised a follow-up on but hadn't gotten to yet, was how to manage the
> project moving forward. The email I made last week about Simon also I
> believe highlighted some of the problems that we as a project and
> community face.
>
> As a starting point, I want to thank all of the people (and companies)
> that have been working on the project and doing the less visible but
> important and expensive things that need doing. DENX has been running
> much of the project infrastructure since inception. Currently, all of
> the fast AMD64 build machines are from Simon. Linaro has been providing
> two of the 3 fast ARM64 build machines (the other is from Simon). Our
> patchwork project is on OzLabs group. A number of years ago, Simon
> picked up the u-boot.org domain. There's likely other things I'm
> unintentionally forgetting here.
>
> So, what are the problems I see and would like to get some help and
> guidance in working on resolving? Well, in a lot of ways it all stems
> from one root cause. The project was founded on the "BDFL" model,
> which was quite common at the time, and a relatively reasonable option
> too.
>
> But now? It makes getting resources harder. There are a number of people
> working in the background now trying to get things donated to the
> project (thank you, again) but I also know historically it's been a
> challenge not having some distinct entity for U-Boot. Individual
> contributions are best done as "I have a server" or similar. Conferences
> are a strictly individual thing.
>
> Then there's the day to day parts of the project. I feel like I
> shouldn't complain about taking vacations where I just handle pull
> requests and not patchwork stuff too, or only doing a few things on the
> weekend. But it also means there's no real way to handle contentious
> issues other than what I say goes. Which isn't ideal.
>
> What to do about it? Well, I've talked with the Software Freedom
> Conservancy (https://sfconservancy.org/) (SFC) earlier in the year (and
> before that, years ago at conferences). There are number of open source
> and community focused projects that they provide a legal entity for and
> help with administrative things. I've personally been a fan of what they
> do, and donated yearly for a long time. I think they would be a good fit
> for the project because they do this kind of work for a number of other
> big and important and community centric projects. I would encourage
> anyone interested to look at their website and look around.
>
> But that is something like step two or step three. The first step is
> that I'm hoping some members of the community would like to formalize
> helping with the project. SFC can help us with creating some
> organizational structure for the project itself, but we need a few
> people to do it. And before we even get that far, help with the mailing
> list moderation queue and triaging patchwork assignments would be great.

I'm happy to help with the mailing list moderation queue. I'm in Europe
timezone.
I will be away for 2 months (August-Sept). Please reach out to me if you
think I can help.

>
> Thanks for reading this, I look forward to finding a sustainable path
> forward for the project and the community at large.
>
> -- 
> Tom
