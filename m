Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF3DC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 793C5846FD;
	Mon,  6 Jul 2026 17:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GRPq8zRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AFF184852; Mon,  6 Jul 2026 16:46:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B9C1846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 16:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fustini@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E23DE402E8;
 Mon,  6 Jul 2026 14:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B81F000E9;
 Mon,  6 Jul 2026 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783349175;
 bh=brx/0pjLPbIrtsCLKJMRSdKrfuPAmeeDj45TYZzCsts=;
 h=Date:From:To:Cc:Subject;
 b=GRPq8zRwdkOW2eJBU6A7QeKlcffOXU1DX1xaza+0LosuToaFcnIkkMEGkqSdvoM7+
 Y+Z5hDHWTp2y6DKnOJs2FeQboaNF59wGIXyQaCrlmFl76eZVomgy1x0pJYD2rBlzHj
 o+0vX2o8oJ9958leBdXSC+27RoclU6HxXWqyPH5h+86FS5oVj87SsoApDM8dgZR00T
 QijldAFHZzb7d7e0/j5zi3nIT9DI7ub/hLqoI4+rqGjwQ5AP0RbnHpqbZBRJpkjPQt
 OweeEOYVV4p8VZYcW3jhDYbzvjkXoHpMw4MYKwYedf6fezxNrMlwz/6cbrSWUopqjN
 SWyRyV7+EUiXQ==
Date: Mon, 6 Jul 2026 07:46:13 -0700
From: Drew Fustini <fustini@kernel.org>
To: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 opensbi@lists.infradead.org, u-boot@lists.denx.de, qemu-riscv@nongnu.org
Cc: Paul Walmsley <pjw@kernel.org>, Atish Patra <atish.patra@linux.dev>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
 Conor Dooley <conor@kernel.org>
Subject: CFP for Plumbers RISC-V MC          
Message-ID: <aku/tckAJ71i952o@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 06 Jul 2026 17:31:25 +0200
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

Hi all,
 
The RISC-V microconferecnce has been accepted for Linux Plumbers 2026 in Prague
this October 5-7:
https://lpc.events/event/20/contributions/2333/

The Call For Papers is currently open. The microconference is composed of
sessions between 15 to 30 minutes for a total of 3.5 hours of technical  
discussion:
https://lpc.events/event/20/abstracts/

Please remember to choose "RISC-V MC" as the track. It is ideal to submit your
proposal before Friday, July 10.

Thanks,     
Drew
~
~

