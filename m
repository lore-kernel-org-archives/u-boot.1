Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA531C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 09:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA8886548;
	Thu, 24 Aug 2023 11:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77BD88653C; Thu, 24 Aug 2023 11:27:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AD4BF86537
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 11:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DF4D1042;
 Thu, 24 Aug 2023 02:28:20 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.35.67])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E38C73F762;
 Thu, 24 Aug 2023 02:27:38 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:27:31 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20230824092731.GA56529@e130802.arm.com>
References: <20230821210927.GL3953269@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821210927.GL3953269@bill-the-cat>
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

Hi Tom,

> Here's the latest report
> 
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Aug 21, 2023 at 4:30 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to Das
> U-Boot found with Coverity Scan.
> 
> 4 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 
> 
> New defect(s) Reported-by: Coverity Scan
> Showing 4 of 4 defect(s)
> 
> 
> ** CID 464361:  Control flow issues  (DEADCODE)
> /drivers/firmware/arm-ffa/arm-ffa-uclass.c: 148 in ffa_print_error_log()

Well received, I started working on that.
I'll provide a fix  after coming back fom holidays (mid September)

Cheers,
Abdellatif

