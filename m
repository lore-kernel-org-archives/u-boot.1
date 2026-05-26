Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9EDCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3141F848B4;
	Tue, 26 May 2026 15:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ps740q/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C1384874; Tue, 26 May 2026 15:10:36 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEAED848C0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78DB160231;
 Tue, 26 May 2026 13:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F15D1F000E9;
 Tue, 26 May 2026 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779801032;
 bh=BmngyEg588tqkf/yH1NVsR9So2+Kqs8KHKn4cPAyjdA=;
 h=From:To:Subject:In-Reply-To:References:Date;
 b=Ps740q/m+Rd403hDwzdi/fvM+Cdn/oaW9ciHp8VV5ihynIB6Obw5TCPqpGYpT4JAs
 yHW+wE+6fVAhTZoHBmhiGUsp/va9wg6MncLFW2LxYYk7ImsebCZBVyOxsoap9Z3X3E
 lTVqikGsdp9A453eba6V2mT6HIgmjXHX6QiZUNP6/8g6cu9RqnhPF191C4daVgzQIs
 caIPxwrK5f2COL7MaIqqAOpERgJe1r9HQQ9BJVvuZ52EC85m1LNue47E15mCEtCC65
 GzdZTqr0lAWJgwo5nNdFyYnFXFmRwaCftWdzqxgmnBDejRufSgLXPHn+yT3FOAZyri
 HdA8V6/HEmH7Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Javier Viguera <javier.viguera@digi.com>, u-boot@lists.denx.de,
 trini@konsulko.com
Subject: Re: [PATCH 0/1] libavb: fix avb_replace() OOM handling
In-Reply-To: <64b5a656-d73d-4c72-95b1-3c843b18c2f1@digi.com>
References: <20260521165122.17475-1-josh2@disroot.org>
 <64b5a656-d73d-4c72-95b1-3c843b18c2f1@digi.com>
Date: Tue, 26 May 2026 15:10:29 +0200
Message-ID: <87v7cafha2.fsf@kernel.org>
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

Hi Javier,

On Tue, May 26, 2026 at 14:52, Javier Viguera <javier.viguera@digi.com> wrote:

> On 5/21/26 18:51, Josh Law wrote:
>> Hi folks,
>> 
>> Since I am a new contributor, I would like to introduce myself first. I
>> am 15...
> Wow, we have a "Benjamin Button" case here. I seem to remember he was 19
> in the kernel mailing list ... :shrug:

Thank you for emailing a about this. Your message made me curious so
i've found:
https://lore.kernel.org/lkml/cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.local/

I'm no longer sure now if I should spend time reviewing this patch or
not (because of bot suspicion)

>
> --
> Javier Viguera
> Digi International Inc.
