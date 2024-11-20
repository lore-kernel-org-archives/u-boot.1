Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B573DD63935
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D67893EA;
	Wed, 20 Nov 2024 13:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1268489533; Wed, 20 Nov 2024 10:32:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1AAC6894B2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=leo.yan@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BB4E1764;
 Wed, 20 Nov 2024 01:32:25 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D15593F6A8;
 Wed, 20 Nov 2024 01:31:54 -0800 (PST)
Date: Wed, 20 Nov 2024 09:31:53 +0000
From: Leo Yan <leo.yan@arm.com>
To: ben.horgan@arm.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] board: armltd: Make myself maintainer for total compute
Message-ID: <20241120093153.GE23512@e132581.arm.com>
References: <20241119172558.438470-1-ben.horgan@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119172558.438470-1-ben.horgan@arm.com>
X-Mailman-Approved-At: Wed, 20 Nov 2024 13:56:12 +0100
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

On Tue, Nov 19, 2024 at 05:25:58PM +0000, ben.horgan@arm.com wrote:
> 
> From: Ben Horgan <ben.horgan@arm.com>
> 
> The previous maintainer is no longer involved in total compute.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  board/armltd/total_compute/MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/armltd/total_compute/MAINTAINERS b/board/armltd/total_compute/MAINTAINERS
> index 3dc1cd188a..92486f4193 100644
> --- a/board/armltd/total_compute/MAINTAINERS
> +++ b/board/armltd/total_compute/MAINTAINERS
> @@ -1,5 +1,5 @@
>  TOTAL_COMPUTE BOARD
> -M:     Usama Arif <usama.arif@arm.com>
> +M:     Ben Horgan <ben.horgan@arm.com>
>  S:     Maintained
>  F:     board/armltd/total_compute/
>  F:     include/configs/total_compute.h
> --
> 2.25.1
> 
