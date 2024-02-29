Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645DEC54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F0B18809A;
	Thu, 29 Feb 2024 15:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lI91SLLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CB1880CA; Thu, 29 Feb 2024 14:03:17 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC2F1880B3
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 14:03:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinguyen@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8E916CE0A6A;
 Thu, 29 Feb 2024 13:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC412C433F1;
 Thu, 29 Feb 2024 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709211792;
 bh=iRFbGQ6UnrSgShJs5+zI1pzh6Cvr6FLpx4qUtQZTRlc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lI91SLLPQrKbi5IeAioYa+KlC1ync4iXo6YlL2N0U+bVFdiJ4WdNjjiLx9W0bhYks
 ydv3dfwhXaH8pusefKnRUNM50jcfx8BdWzbBSE+ApXDji1OrupeVosjGVUSQGMrLNJ
 VvV3AIFglIR112NlXzJ8RQBtE6PGYSI3ntrySS6y6+ObKsUw5FKSbEyT6WhioIbEqR
 wYYFh59uJnW7fcIsMs9Kk0Djq4w7CYFFB6FVh8GysRL8A4j3NoJUGSN7tMjKiG5ych
 nGa2jd/WkJy57PZSIY2zEfe0gU2N1Rm//u7xiSMYUc5EBP6u5cCpmhLoGttcw7w3mM
 4UpmQoyNwF/+Q==
Message-ID: <a83ca999-aa53-4d81-a570-677ba644b0fe@kernel.org>
Date: Thu, 29 Feb 2024 07:03:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: socfpga: arria10: allow to reprogram FPGA with
 warm reboot
To: =?UTF-8?B?TWljaGHFgiBCYXJuYcWb?= <barnas@google.com>, u-boot@lists.denx.de
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut
 <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>,
 =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>,
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>
References: <20240222152102.1677445-1-barnas@google.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20240222152102.1677445-1-barnas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Feb 2024 15:22:15 +0100
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



On 2/22/24 09:20, Michał Barnaś wrote:
> 
> By default, the board requires power cycle (cold boot) to program the
> FPGA with bitstream. This change adds Kconfig that allows to enable
> reprogramming the FPGA with every boot. This makes the update process
> of the bitstream on the filesystem to be applied with simple system
> reboot.
> 
> 

If we want to enable the reprogramming on every boot, would it make 
sense to just do it and not even bother with the Kconfig option?

Dinh
