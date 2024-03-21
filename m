Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65CBC6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 17:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450E4880F1;
	Thu, 21 Mar 2024 18:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="BO2Qz4k/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E967880FC; Thu, 21 Mar 2024 18:07:42 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E881880DB
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 18:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 29C5A1FA90;
 Thu, 21 Mar 2024 18:07:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1711040859;
 bh=09LZvVrpAbEb6DlzB/4l/eDgZfyoqFTgN7cHnq+JrJc=; h=From:To:Subject;
 b=BO2Qz4k/dlHpEzR/Mto5wqnzkN/XIbQkYmzilqzlBppdrc3JRI9x8zGPhiRh55mwa
 8I8tNT+TK2FCoVI85FU9vDQDtAyzzYaJ42vnhk8CqQMSNB5440S2z5mx6zBDoJ5soA
 MtvMUhmNXRHyZ84YI5pLgd35Vkwzk9MZ8ZsMCJS0hhjKtuEQcGYIp4NaFY9OSJaq2o
 AVI2PjU5Yg8H1V0IUkkVYcnRFfJgIFSyxvwDZc0aecsnW2pE7XJWkM3uXIn0R3xxVf
 jmw8AJNBJKNKVemPTvCuouXx50b2PIrQxffHfW37sntUqZ019mq9BJ+85Jxh1sOjrA
 WUQvYUNK45Rkg==
Date: Thu, 21 Mar 2024 18:07:32 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Hiago De Franco <hiago.franco@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] board: toradex: verdin-am62_r5: Increase
 SPL_STACK_R_MALLOC_SIMPLE_LEN
Message-ID: <20240321170732.GA12388@francesco-nb>
References: <20240320164845.141894-1-hiagofranco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320164845.141894-1-hiagofranco@gmail.com>
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

On Wed, Mar 20, 2024 at 01:48:45PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> Increase the SPL_STACK_R_MALLOC_SIMPLE_LEN to 0x200000 to accommodate the
> size of tispl.bin fit image. With the recent upgrade of ti-linux-firmware
> from version v9.1.0 to v9.2.5, the size of tispl.bin fit image has
> increased to 1.4MB, causing allocation errors in the R5 SPL:
> 
> ```
> alloc space exhausted
> Could not get FIT buffer of 1325056 bytes
>         check CONFIG_SPL_SYS_MALLOC_SIZE
> ```
> 
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


Tom, this is also a candidate for master, thanks :-)

Francesco

