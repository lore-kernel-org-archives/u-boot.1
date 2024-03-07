Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1543BC54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 09:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F07C87DED;
	Thu,  7 Mar 2024 10:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="jn74sIHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DD2C87DF6; Thu,  7 Mar 2024 10:17:34 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9177187DB0
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 10:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Thu, 7 Mar 2024 10:17:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1709803050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fphSFlCN6RlRYlMlBEAVbtcY0R4Fbgojd4ccLMfdxE=;
 b=jn74sIHlY3ketrG57VHSca6L+MpypwipGrViREVyKe4OaRAgBDDC6ScjypEY5zI3mQXYUC
 SLW/WJV0FZub04ekzUxqqp0p30bbv3Y5qG/BhLNgHbsCieQLh0cRWF8Ky9G5zyutPaSuBg
 CiK/Mf9aWoF8OVOjqi5Tixeq6wabfXYfUWeE+EiE+4eL+VYNDnsksAl0lLgxGZB4WP+bHY
 8Z5Vz6UO+0jl8VwL97KzLP2JYsJaBh8iC3vjQW3aM8amo1XMmgVzVfefOmyyctmyes2PAB
 qzQPQ+qTF5HMTW5MVi98V0JjnbOzZk2yIX5a91DmaHYOyyqS42QXlXADkTLSkw==
From: Alexander Dahl <ada@thorsis.com>
To: Chuck Meade <chuckmeade@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Can U-Boot create mtdparts from device tree partition info?
Message-ID: <20240307-expenses-trustable-b320aca2e2d6@thorsis.com>
Mail-Followup-To: Chuck Meade <chuckmeade@gmail.com>, u-boot@lists.denx.de
References: <29244d1c-ec74-4d98-8137-aefabf4fe253@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29244d1c-ec74-4d98-8137-aefabf4fe253@gmail.com>
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

Hello Chuck,

Am Wed, Mar 06, 2024 at 11:48:39AM -0500 schrieb Chuck Meade:
> Hello,
> 
> In looking through the source, I'm not yet seeing logic that allows U-Boot
> to actually use MTD partition information found in the device tree.  Does
> this logic exist and I'm just missing it?  Or do I need to parse the device
> tree partitions manually and create the mtdparts env variable?

U-Boot can use the partition information from device tree, but not
with mtdparts.  Try enabling CMD_MTD and run `mtd list` and you will
see those partitions.

> Sorry if this is obvious, I'm just not seeing it yet.  Also, if the answer
> is just to manually enter the mtdparts env variable, and keep it in line
> with the partition information in the device tree as a manual operation,
> please let me know that too.  I'm just hoping there is a way to have U-Boot
> get the info from the device tree automatically.

You could do that, but it is probably not necessary.  The 'nand'
command has some nice ways to enter commands using those mtdparts
labels, but the 'mtd' covers the basic features like read, write,
erase too, also with names, but with a different calling syntax for
the commands.

Unfortunately the 'nand' command uses mtdparts only and does not work
with partitions defined in DT.  The 'mtd' command is organized
differently and you might not find all features the 'nand' command
has.

Greets
Alex

> 
> Thanks very much,
> Chuck
