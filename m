Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5289CC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 16:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC0A80283;
	Tue, 21 Jan 2025 17:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="W7SVdyoR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D29D80326; Tue, 21 Jan 2025 17:26:17 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50218801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 17:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 475DA14846ED; Tue, 21 Jan 2025 17:26:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737476774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nIqL73zTb71yEUZFIn1bIsRRmSvuew/7B3MMDng19KE=;
 b=W7SVdyoRnTxHvQ9nqCfOiUjYqH6oRT4K4ZFZVZmS7n8cZFCUyI0jglwpK7mv4G/dYthA2m
 a5ZU6MasL4DdZJVgC9i6vOvEyGXiQOZWjh/+VkOLbVj3KyuS3Aljf9DXaQ1x4r5679p6tC
 AsnWICAlmjd+XBhUr/m1PS0c8W9Ii9rtYubN/BoqDO98uKBU/3oxYiwUDO2vjg6CoW4UpR
 KCbDG5NRjyOPxoGaZAtWR9UcNU+oorCTEAYQEJKqDOBGzVtdKBA1ccmNj3no3I6l/Wct1d
 bqXu+CQyC4V1aMmjkM7OX/fq0k39kyL+Adq/2GjNVC7wwKWYKzLOa41yuYd0TQ==
Date: Tue, 21 Jan 2025 17:26:08 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 open list <u-boot@lists.denx.de>
Subject: Re: [PATCH] fpga: Avoid ignored-qualifiers warning
Message-ID: <20250121-shininess-itinerary-fd779c4ac332@thorsis.com>
Mail-Followup-To: Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 open list <u-boot@lists.denx.de>
References: <20250121162213.1477506-1-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121162213.1477506-1-ada@thorsis.com>
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

Am Tue, Jan 21, 2025 at 05:22:12PM +0100 schrieb Alexander Dahl:
> Fixes annoying warnings of the following type when built with W=1 (for
> each file including fpga.h):
> 
>       CC      drivers/fpga/fpga.o
>     In file included from /mnt/data/adahl/src/u-boot/include/xilinx.h:7,
>                      from /mnt/data/adahl/src/u-boot/drivers/fpga/fpga.c:10:
>     /mnt/data/adahl/src/u-boot/include/fpga.h:61:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>        61 | const fpga_desc *const fpga_get_desc(int devnum);
>           | ^~~~~
>     /mnt/data/adahl/src/u-boot/include/fpga.h:81:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>        81 | const fpga_desc *const fpga_validate(int devnum, const void *buf,
>           | ^~~~~
>     /mnt/data/adahl/src/u-boot/drivers/fpga/fpga.c:36:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>        36 | const fpga_desc *const fpga_get_desc(int devnum)
>           | ^~~~~
>     /mnt/data/adahl/src/u-boot/drivers/fpga/fpga.c:53:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>        53 | const fpga_desc *const fpga_validate(int devnum, const void *buf,
>           | ^~~~~
> 
> Do some type and cast cleanup on that fpga_desc type file at it.
                                                       ^^^^
While!

Sorry for that typo.  Should call it a day and take some rest.

Greets
Alex
