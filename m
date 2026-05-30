Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06CFCD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 13:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE12284671;
	Sat, 30 May 2026 15:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TU8vF1Ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DAD7846A3; Sat, 30 May 2026 15:27:29 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 437248405A
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 15:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gSLcZ0F22z9tYd;
 Sat, 30 May 2026 15:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780147646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIdH+0Jj6zLK053M1u34dbn4uuTS/Nx4Hnfore1kTdY=;
 b=TU8vF1LlbinYOd0tcASzJHGJRHA9Lg+HGpEsA0KqbIth+sNRO0b2Lk7XUzb/4EB7coofg9
 vvB4fhQPpwkr0ofWxK8bQODvA6q//gV3QK3yBu84GqdqsVd7hV1jpSF9iyY9/wN428mZbt
 PsQKGqKjGXAhN27a1IJ+ylMf1unTJjNPuaZLpRXie/j9iA7UoQeN+jS46HWkk3KP/nXVY6
 qSkvMXEi+OnRHRWb4FgktoBfzfARhspVWplpjrhFxCtekTYOQYkXOFw/1ADEqfpFHYBtMI
 YajEQjoSjM4Z0Va/iNPl0vF1NkfL/w5uT0xrq9OVi8DBz2yn8s+58qH1uoKbRA==
Message-ID: <d0cb15bb-d4d0-43b2-bf14-b36a62da1dad@mailbox.org>
Date: Sat, 30 May 2026 15:27:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "lmb: Reinstate access to memory above ram_top"
To: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
References: <20260529162942.281897-1-pbrobinson@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260529162942.281897-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d40dd6281de408a8e65
X-MBO-RS-META: 75d4i57b85n8bmw8pcmfr6kojnp75bcy
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

On 5/29/26 6:29 PM, Peter Robinson wrote:
> This reverts commit a3075db94d49f415658bf7e961e1eae90d9abc33.
> 
> This causes boot issues on Raspberry Pi 4/5 in a number of ways,
> the mmc needs memory < 4Gb, the mailbox needs it < 1Gb at the
> very least so there's some work to be done here for that platform.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
NAK

The revert is wrong as that breaks other things, like use of DRAM above 
4 GiB boundary, which is exactly why the original change was implemented.

If RPi has limitations, then those limitations should be imposed on RPi, 
not globally. Please add the LMB reservations on RPi only. Use 
lmb_arch_add_memory() to add those restrictions per-board/soc/arch instead.
