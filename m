Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE311C02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 08:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7B4800B6;
	Mon, 20 Jan 2025 09:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="UncEYpBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A91801CF; Mon, 20 Jan 2025 09:57:46 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B95C80077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 09:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 30BFC1489C4B; Mon, 20 Jan 2025 09:57:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737363464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tvw2M0lL/1K6hE5N0qXVHJzn2Obyock1bVBJ3k6MSK4=;
 b=UncEYpBJRvwRebs1jgyLkWH11QgvnV7iFeFOFuRDUAt+exUf0K2qTc9Lpdktceob7x29Nk
 1iB+n17VEkRROuGbW87Un3c9le8ON+yByFRNBSITSlSw48qO7qcfgfgFVAYGIQF4Q/YgFV
 Ulp3Qp9PZc8PSC4OyQ1iVYZ2yrtD69Hm0u6H2+ZCQs6KZANztUzVRADvvAJrbMk+87Au8h
 fMbSLsFrBjKSdMabbjTN/LRWIZYsikwWoF3gZyLW+78nodEBCoDM/aFWIIBFOFKKGmqMgU
 Tv1Zziwe4qQFhHVJGdzE6IKHAPCEFsWwUW/sZnrlpCj1rx3inNkz6MvUAo2iYA==
Date: Mon, 20 Jan 2025 09:57:42 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
Subject: Re: [U-Boot][PATCH v3 4/4] fpga: xilinx exclusive commands
Message-ID: <20250120-surprise-exploring-cb7738514bf9@thorsis.com>
Mail-Followup-To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
References: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
 <20250117112557.3729416-5-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117112557.3729416-5-ibai.erkiaga-elorza@amd.com>
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

Hello,

Am Fri, Jan 17, 2025 at 11:25:51AM +0000 schrieb Ibai Erkiaga:
> @@ -1192,7 +1198,7 @@ config CMD_FPGA_LOADMK
>  config CMD_FPGA_LOAD_SECURE
>  	bool "fpga loads - loads secure bitstreams"
>  	depends on CMD_FPGA
> -	select FPGA_LOAD_SECURE
> +	select FPGA_LOAD_SECURE && FPGA_XILINX
>  	help
>  	  Enables the fpga loads command which is used to load secure
>  	  (authenticated or encrypted or both) bitstreams on to FPGA.

This does not work, you need to have one line per selected kconfig
symbol.  Your change leads to this:

    cmd/Kconfig:1184: syntax error
    cmd/Kconfig:1183: invalid option

You should have noticed this when testing. ;-)

Greets
Alex

