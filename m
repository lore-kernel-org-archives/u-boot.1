Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5DDFA1FC2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 15:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6596E84348;
	Wed, 22 Apr 2026 17:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="ix3VW4dB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C7484312; Wed, 22 Apr 2026 17:41:43 +0200 (CEST)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [95.215.58.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6AD84312
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 17:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Wed, 22 Apr 2026 15:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776872500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJVUpaNEp9JEnByoavGdkQ7NXindEcv9mIFPsPqD2qQ=;
 b=ix3VW4dBs7yHQGorvBfoSFv7tEJwG7agR1S5TeirOD7OLMiGKz8qq3ooYjEEoRX9b4wqUe
 90jWCYGLxxxDFe4lhY7Q6yuKhbTwq9UhDwlHfEdgbRsiSkd1ZeNKHMPHIOWhtMswJ8mVgo
 xIulaV5FuDhzyzYsC1b9H99KnuljrhnNSwV1XCdn4SiioosrEMMAm+CImOcR4WjgrzGSsM
 jsJWdjqm2lzL61a09PtNXexBgrNYQuzYzgmeKS9QjOBP3ZHqphuTwIrveEkkAvEQY2uqgc
 HqoaFHku59Qdc6D4RQhIavj3CNY/E/y0vllrIdUldNbJgAyVgZK89Aj39br4cA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ferass El Hafidi <funderscore@postmarketos.org>
Subject: Re: [PATCH v2 0/4] Enable EFI Capsule on Disk on Libre Computer
 LePotato & LaFrite
References: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
Message-ID: <tdwjl7.i3gvyhcbegcm@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

Hello, ignore this patch series. Didn't mean to send it in this state.

Sorry for the noise

On Wed, 22 Apr 2026 15:39, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
>Mostly everything is already in place to enable EFI capsules and in particular
>EFI capsule on disk.
>
>First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
>functionality expects sysreset to be present. As the current reset_cpu()
>function in board-common.c is basically only doing PSCI reset on U-Boot
>proper, we can replace it with sysreset's PSCI support, which works just
>fine for that purpose provided BL31 is running (SPL stays on an
>SoC-specific reset_cpu() which does for(;;);, as the overhead for
>sysreset is too high and we don't have PSCI yet at that point).
>
>Then we can enable capsule on disk. LaFrite has Capsule updates enabled
>already, so it is simply a matter of enabling CoD. LePotato does not
>have Capsule updates enabled by default, however it can be easily enabled
>and setup to update u-boot on eMMC/SD.
>
>With Capsule on Disk setup, it becomes possible to update U-Boot directly
>from Linux, without having to worry about manually using `flashprog`
>(for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
>can be handled by `fwupd` and applied upon next EFI boot.

--
Best regards,
Ferass
