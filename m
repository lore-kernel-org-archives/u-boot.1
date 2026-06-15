Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB78BCD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A7C846A4;
	Mon, 15 Jun 2026 14:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m3hZfKtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC2A8484C; Mon, 15 Jun 2026 14:16:59 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7E083FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 357026008A;
 Mon, 15 Jun 2026 12:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BA91F000E9;
 Mon, 15 Jun 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781525815;
 bh=AeDnPZzOB2H2YWu4w3a6QgXOBBkZhoRn0+eUN+ncdew=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=m3hZfKtY5VihCWwRCUa9/yK10j4xkYyJvAVSktO+1o96I0228PJp5UUAtWGTqgPPc
 uH49Dq3H/9lyuxBhVQ5KK5hpCl88PC4+UO3JDMSpLWkRWDUIA2bdv8JSNATexcyWSA
 98gCbhcdUUrw8R2OkPtmKbmKYmnr59iOIuP9JIkDMF7aAumhvLr6H+DwSPtkoo3QWw
 GN5vddnkkAyIiyN3aEtownqcadlyz16JBPdnif3pbUmjZYXR1xLZgGMkuJbxPQDPjV
 Pl3yuIbnwNwbtZ+MdVfsxQCjf/Tqz7NVTDAxMfXxPaGC/MkfoXXvrzfBtMF6JPTtXo
 YSRomfixq1Vsg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, Casey
 Connolly <casey.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 1/2] cmd: fastboot: Add keyed abort option
In-Reply-To: <20260602-fastboot-abort-keyed-v1-1-414aac5a06b8@samcday.com>
References: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
 <20260602-fastboot-abort-keyed-v1-1-414aac5a06b8@samcday.com>
Date: Mon, 15 Jun 2026 14:16:53 +0200
Message-ID: <87zf0wgfre.fsf@kernel.org>
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

Hi Sam,

Thank you for the patch.

On Tue, Jun 02, 2026 at 18:45, Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org> wrote:

> From: Sam Day <me@samcday.com>
>
> Works the same as CONFIG_CMD_UMS_ABORT_KEYED does: any keypress will
> abort fastboot mode (rather than only ctrl-c).
>
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  cmd/Kconfig    | 6 ++++++
>  cmd/fastboot.c | 9 ++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c71c6824a19..439409d6f2c 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1208,6 +1208,12 @@ config CMD_FASTBOOT
>  
>  	  See doc/android/fastboot.rst for more information.
>  
> +config CMD_FASTBOOT_ABORT_KEYED
> +	bool "fastboot abort with any key"
> +	depends on CMD_FASTBOOT && USB_FUNCTION_FASTBOOT
> +	help
> +	  Allow interruption of USB fastboot mode with any key pressed.
> +

It seems that checkpatch is unhappy about this:

$ ./scripts/checkpatch.pl --git master..
-------------------------------------------------------------
Commit 9b68236a90bc ("cmd: fastboot: Add keyed abort option")
-------------------------------------------------------------
WARNING: please write a help paragraph that fully describes the config symbol with at least 2 lines
#26: FILE: cmd/Kconfig:1211:
+config CMD_FASTBOOT_ABORT_KEYED
+       bool "fastboot abort with any key"
+       depends on CMD_FASTBOOT && USB_FUNCTION_FASTBOOT
+       help
+         Allow interruption of USB fastboot mode with any key pressed.
+

total: 0 errors, 1 warnings, 0 checks, 28 lines checked

I'd suggest the following edit:

+         Allow interruption of USB fastboot mode with any key pressed
+         instead of just Ctrl-c.

If you wish, I can do this edit while applying.

With the above change included:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>  config CMD_FLASH
>  	bool "flinfo, erase, protect"
>  	default y
> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> index e71f873527b..f3929f88dfa 100644
> --- a/cmd/fastboot.c
> +++ b/cmd/fastboot.c
> @@ -103,8 +103,15 @@ static int do_fastboot_usb(int argc, char *const argv[],
>  	while (1) {
>  		if (g_dnl_detach())
>  			break;
> -		if (ctrlc())
> +		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
> +			if (tstc()) {
> +				getchar();
> +				puts("\rOperation aborted.\n");
> +				break;
> +			}
> +		} else if (ctrlc()) {
>  			break;
> +		}
>  		schedule();
>  		dm_usb_gadget_handle_interrupts(udc);
>  	}
>
> -- 
> 2.54.0
