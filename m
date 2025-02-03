Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C840C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4104805DA;
	Mon,  3 Feb 2025 10:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="IoqxIlBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18717807A8; Mon,  3 Feb 2025 10:37:15 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D0F801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 39C7E148306A; Mon,  3 Feb 2025 10:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1738575432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UcYOOFatcAT54nNWbsZWjW15qURl/nda02xSseeWbWk=;
 b=IoqxIlBBBoPyI+I8r9DzZbWgf35MKeJPIoe7Zy0f4cEOaNI59tRlpPtM+ClRwPFQr5RizM
 pCbv/sVh7yMGGsNoLehKE5jKUwfpKowerav3RGEtmhAVwcnh6pNbxrQRFQUORXJQIgVvg9
 4ahWEGe/TYJi2k1n2+ol+xdJwaX6bkm1smD9pOOOg4Am1Gavn4yTMfZvx+8ZLGdVXDczdi
 38aAHlS6zOV1gAZflqy34OtrRDhoHa/P1QzVtY0H4yKbDV8Md5IUwp3go0HjFNWovOPFP8
 GDg/Skb5DAA8+d768jbYSPLvfOJDDlf7l8tWlOr1NE3ePxoJJRYv+v4eR6E7PA==
Date: Mon, 3 Feb 2025 10:37:04 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Alexander Dahl <ada@thorsis.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] fpga: Make do_fpga_loads() static
Message-ID: <20250203-anime-playmaker-4d002bc315ec@thorsis.com>
Mail-Followup-To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <cbe93e4eb33752aaddc943b15fd04731d4f75b68.1738574893.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe93e4eb33752aaddc943b15fd04731d4f75b68.1738574893.git.michal.simek@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

Am Mon, Feb 03, 2025 at 10:28:15AM +0100 schrieb Michal Simek:
> do_fpga_loads() is not called from anywhere else that's why make it static.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  cmd/fpga.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index 212f421739fa..9dc7b63db5d1 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -67,7 +67,8 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
>  }
>  
>  #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
> -int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +static int do_fpga_loads(struct cmd_tbl *cmdtp, int flag, int argc,
> +			 char *const argv[])
>  {
>  	size_t data_size = 0;
>  	long fpga_data, dev;

Reviewed-by: Alexander Dahl <ada@thorsis.com>

Build tested for our custom boards.

Greets
Alex
