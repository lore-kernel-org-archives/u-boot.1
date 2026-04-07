Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21ECEDB7F2
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 10:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21D8983A41;
	Tue,  7 Apr 2026 12:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Y7A9LL68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A94483F98; Tue,  7 Apr 2026 12:38:10 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8808352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 12:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 66AAB148FE7B; Tue,  7 Apr 2026 12:38:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1775558287; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=E+ZBz78g/zkLUzKo4SaZmGRzY/sb5am2fg/tYuP2yuM=;
 b=Y7A9LL68Jyismz7qELnH1KNEmccfjEVZH2KODnMXdTbTfJcrDrraKrlBsI2NVJrOImC2oJ
 npUIlnMnzXlMTeDTUMYKUBT0P8Y4gZYsiU3oby0+XwUwIDlWQPTFkpbqkWao5PUlytMQEt
 OammgU7LgiwLHoiesklljkdwppZGLMLYsPwrg3+s22zG1edDiJdigthyfLc67cJw+1fhFw
 iq98+bmZvR2Y5kA2nZSjwwg3Gj2VkjOo1yhkqa8eVkCYPsQ9Oe5vR/H0KZOyMRx32FnoHp
 IdQYTLYugAEpy67ZkbpH288aUu2YhjKQMYNIlHmfMLJ2tih98GI3hQApzvPjZg==
Date: Tue, 7 Apr 2026 12:38:02 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Tom Rini <trini@konsulko.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
Subject: Re: [PATCH] cmd: fpga: Fix wrong preprocessor guard for loadb help
 text
Message-ID: <20260407-contusion-daylight-5eeffaaab47e@thorsis.com>
Mail-Followup-To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@amd.com, Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Tom Rini <trini@konsulko.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
References: <366dfe78e2028f53a6274da75547fb68844764cc.1775549229.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366dfe78e2028f53a6274da75547fb68844764cc.1775549229.git.michal.simek@amd.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Michal,

Am Tue, Apr 07, 2026 at 10:07:11AM +0200 schrieb Michal Simek:
> The help text for the "fpga loadb" command was incorrectly guarded by
> CONFIG_CMD_FPGA_LOADP instead of CONFIG_CMD_FPGA_LOADB. This meant the
> loadb help text would only be shown when LOADP was enabled, rather than
> when LOADB was enabled.
> 
> Fix the preprocessor condition to use the correct config option.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  cmd/fpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index d51c380d7b3e..d347a7002906 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -417,7 +417,7 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
>  	 "info   [dev]                  List known device information\n"
>  	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
>  	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
> -#if defined(CONFIG_CMD_FPGA_LOADP)
> +#if defined(CONFIG_CMD_FPGA_LOADB)
>  	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
>  #endif
>  #if defined(CONFIG_CMD_FPGA_LOADP)

Fixes: f8f378877b8f ("fpga: add new symbol for fpga_loadb")
Reviewed-by: Alexander Dahl <ada@thorsis.com>

Added original patch author to Cc.

Greets
Alex

