Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2328D25958
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 07:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2200D83F53;
	Tue, 27 Jan 2026 08:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L9BYgz2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6DB383F85; Tue, 27 Jan 2026 08:25:44 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D91C83F3F
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D9A5240632;
 Tue, 27 Jan 2026 07:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243E1C116C6;
 Tue, 27 Jan 2026 07:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769498740;
 bh=pmelYP2vrM3XcRZTpsgmpHMw3eV9PDqBh1bXOS+Hd50=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L9BYgz2OO1Fk6pqbY16zMk5St1W4iF+ut2xsXW53QVxXxPmrRd8awZLuSgkjpNMJ3
 dDpnx69dojaQk6zys5pg0WUtmfHSXzVudr++gQ5MY/r7/I+NS48BH/K2rgGe6GxsGh
 LvAU62DFGZ1jZ0OHvF7JTXVCqLuHWhX7Dp+MUZ3TA3aRA8tdvVzam0ZGj7cEE9Ds0y
 9sd801MMF0HTeowgOu4BKPUWdYVAlgo7IMRSsVqYPkf5iUiDS+I2hjmVdSJLjws0tU
 5iUY0rNPAuGEkyaijUVkPi2Tx4EwCPveZtK3MsG8y3DTajVt0Y3GFJoOOHt9ss1jTY
 W118mXojsnb7Q==
Date: Tue, 27 Jan 2026 12:55:31 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 david.wronek@mainlining.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, jorge.ramirez@oss.qualcomm.com,
 stephan.gerhold@linaro.org, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/3] board: qualcomm: Remove SCSI scan from default
 preboot environment
Message-ID: <aXhoa9sfIhoMZWq0@sumit-xelite>
References: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
 <20260126155938.2717540-4-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126155938.2717540-4-balaji.selvanathan@oss.qualcomm.com>
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

On Mon, Jan 26, 2026 at 09:29:38PM +0530, Balaji Selvanathan wrote:
> Remove "scsi scan" from the preboot command sequence in the default
> Qualcomm board environment.

This is the default environment configuration expected to work on all
Qcom platforms, wouln't it break platforms supporting UFS boot?

> The SCSI scan command fails on eMMC-based
> boot configurations, causing unnecessary boot delays and potential
> error messages during the preboot phase.

Say if UFS isn't supported as the boot target then this SCSI scan should
just bail out. Can you share the error messages and boot delays seen
here?

-Sumit

> 
> This change improves boot reliability on platforms using eMMC storage
> as the primary boot device.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  board/qualcomm/default.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
> index dbf6f4e7260..7cfa8e0ce2a 100644
> --- a/board/qualcomm/default.env
> +++ b/board/qualcomm/default.env
> @@ -1,7 +1,7 @@
>  stdin=serial,button-kbd
>  stdout=serial,vidconsole
>  stderr=serial,vidconsole
> -preboot=scsi scan; usb start
> +preboot=usb start
>  fastboot=fastboot -l $fastboot_addr_r usb 0
>  do_boot=bootefi bootmgr
>  bootmenu_0=Boot first available device=run do_boot
> -- 
> 2.34.1
> 
