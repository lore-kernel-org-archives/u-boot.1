Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1333CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 12:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BA2B40462;
	Tue, 13 Oct 2026 12:09:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ro6RC2bQ6AiT; Tue, 13 Oct 2026 12:09:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D56BE403EA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791893368;
	b=EeM+Bsng01j3wpDEAfRi8GlMkyqVia7G39PJ7QbNADwEdWhCuJbXZANjuHZfEXXTMhyc
	 eJF5KxlP95Js+YLw3QJ4Y+h5kbQvW2p33Uw6NaX/ysl1GjLQBgXXLuW9/ABoY60hufgEj
	 tZasJO/mKd3ACoZhPHyGuxXjsFGJFwoptvPZ7I3p+BpJn2yWnK16osOQkYbJtOVt7CTXt
	 E8JDotnTjGoV6Q/N+iq7DAq07Hz+xmx5vKjvl9FhqY9u5P8lmwWrOT0U339kLP9jLZHH8
	 ZpPUQTFDWdYBVmS+M2HLH/uR9vjDoh94Drq0rke4FG3QRggFhwYuBMet0aqQ6tZM9qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791893368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1aD4iEyocHx7ZKJ9MIKYbtFPRXQMF9ON/XZy5zX1zmo=;
	b=neikdT/37E9SUD/H12gvGpvK2FZFrwUtuQ7MBLwvzlZNypuog2V/Y7gjpjBi0AaUH9Q8
	 j6bthP/3oXqoLZObygmLUHWFWnKxJS+0xgXqINRYWtQmlfdwl7QdfzC8dJrT2onrLrgcS
	 3uxXtg3JgFjzpcGEDgquZh35if92zGOhfdUT4sk7D0608jRANt5kycupsZLkDmWrZSeBO
	 g17GGk7Jaf8nCXbfssGhUIqX/E1qffB3Mbp3xU7Ir86TqTdT0yBtkUATdCcuPB706pPqm
	 IaIAhd8xk0SNOQTddzLGHHaW8AIrd+X6uh8YX7wSljfAw4SK7KBCE0d5Nb0znHSm5AA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791893368;
	bh=1aD4iEyocHx7ZKJ9MIKYbtFPRXQMF9ON/XZy5zX1zmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hpvG9gEoyFSSNCq4CCLn3CnggZmwyEWYKCtOABLoU/3/lw3Gwvcf77OUXH/XWT+D7
	 wWQ3Yf3CsiMOo7o08Vfr3C3NVGQ4tK3G10DhvnUxppC1yEmInA/BkzxCjEp/cLeou+
	 YQ88QOm/XZk5TuN29FGXZ7VI3TN4kWLL/bngIZ7i+y70rvLOhkejeyccSnXHFlOQXs
	 EPmdRqaWUUbAdJ4lt/gQKyKHy5tK/+4s/jTcD2p9YZsmqj5KAp9BGxdrSxA7ucTJVn
	 2zYW2gDul16oDRrExjykqj3tiJGCk9djElRaxjeyZT/un/xqLzFvv/NDr02Mdr37Ay
	 Wxv7qx8NQTqDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D56BE403EA;
	Tue, 13 Oct 2026 12:09:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F269B1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D38E3605F3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id limhik4XAk8Q for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 12:09:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 57A08605D3
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791893365;
 b=P9YXvmGdBU+WpPbgZyVbrIGY1Sqd4ea7Uu4oq1TER+xX8CHGnU/hR1ug2jom8FLQWKgT
 KSPXC2NKn6FLJo5REVrqCyWEIZp67xlg2UeySjKF4t5XeOdGkO/KA5bIh9qGGLpPQURr7
 4JaHN57+qnwETZC6SfnCiKaPec9gWdI84mF6aTiZPXHRU0Oja+HrM+yuN2Ruh1N4aVf1+
 TJFqghZFktpjakGmTdU/osnQSpTAJrMzCfVAfRNnZd2V1UqF9XzvpHvZJGtGxj7h0Qnl1
 +c7VUIRoAAwRFHZwIkvd2LrpEiNPmOplfXHkKDhMreqyrt4WEHhVaY3F+SEkhTo4RxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791893365;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=1aD4iEyocHx7ZKJ9MIKYbtFPRXQMF9ON/XZy5zX1zmo=;
 b=ot5Uwu2aytxo6JeIBMvLYp5FrX8l4z4IAzW58D4qkSZy/M0pRgKIABLSQ+0+XHU5PG1R
 /OEG73FIRBsdrVX/JqayoUa8nNKPKg5+/HsMNGKrZbVBetTiJdFO/NMm6Me0S9aGnuiov
 TnQ8xOt4NTYbE3CuDfb8/wRFVMx9WysOou7EXOSbP2llGqw8aQpMMVK/vb17IdMfkf1nz
 6Fnb1dsmld5j4m7Aul8lGT3lFa0PmVNJPU0b2LZmCyROLd7edez78Apr/E2X4kv5U5Jbk
 WoJjiWQXvvJSUHhdesg4MsPEShy1TXeBGEUbrHyONqfSDJgIrTOkkeJf8Jr9vkzSOMw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="cuv1/rHv"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cuv1/rHv
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57A08605D3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:09:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0031A43476;
 Tue, 13 Oct 2026 12:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF961F00893;
 Tue, 13 Oct 2026 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791893363;
 bh=1aD4iEyocHx7ZKJ9MIKYbtFPRXQMF9ON/XZy5zX1zmo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=cuv1/rHve+X9OktIEAyjig31BMI86PL2MUdASJe5WaDpGOrFJ985KXWPWNk6WIVhK
 LQFEU38zY5hRc9Bg19jzoNaX9wIrnCro5/xkjBnoE1XjbCLBxac2gM2irO5ST4lS1v
 tVJnyl4UUtTWDR+x/F/iDGERRAbzLFXb35hniQjAYXZL4SsXPtc8oAPb9COn30vYsJ
 5k46vw9MOs07tVqR6GogqcJVgNdubVznu2vB20ZgF7BtiwOhyLPuH+/wsszfqvNZxY
 k4cnyShPJP/bOjH1SWgcNgEhH/CFnsKLfazerk3H+wi/xfZD+zQZkUUL352xtYae4D
 yaV108aN7/ZSQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jan Kehren <jan.kehren@emteria.com>, u-boot@lists.u-boot-project.org
Cc: igor.opaniuk@gmail.com, sjg@chromium.org, trini@konsulko.com, Jan Kehren
 <jan.kehren@emteria.com>
Subject: Re: [PATCH v2 1/2] avb: Drop the mmc naming from the block IO helpers
In-Reply-To: <20261006092732.3577974-2-jan.kehren@emteria.com>
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261006092732.3577974-2-jan.kehren@emteria.com>
Date: Tue, 13 Oct 2026 14:09:21 +0200
Message-ID: <xhkdby0c17qfi.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jan,

Thank you for the patch.

On Tue, Oct 06, 2026 at 11:27, Jan Kehren <jan.kehren@emteria.com> wrote:

> The AVB IO helpers and struct mmc_part only ever touched struct blk_desc:
> nothing in them is mmc-specific. The names say otherwise, which makes the
> mmc assumption in AVB look wider than it is.
>
> Rename them after what they do, in the AVB namespace rather than the block
> layer's: avb_blk_read_and_flush(), avb_blk_write(), avb_blk_byte_io(),
> struct avb_blk_part and enum avb_io_type with AVB_IO_READ/AVB_IO_WRITE.
> The block descriptor field loses its mmc_ prefix for the same reason.
>
> No functional change.
>
> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

