Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79272C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 07:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6BDA86BF1;
	Mon, 29 Jul 2024 09:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 425E383333; Mon, 29 Jul 2024 09:45:19 +0200 (CEST)
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by phobos.denx.de (Postfix) with ESMTP id 7FA88887B9
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@arachsys.com
Received: from [31.94.64.200] (helo=smtpclient.apple)
 by delta.arachsys.com with esmtpa (Exim 4.80)
 (envelope-from <chris@arachsys.com>)
 id 1sYL46-0001gw-Pr; Mon, 29 Jul 2024 08:45:06 +0100
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
From: Chris Webb <chris@arachsys.com>
In-Reply-To: <5F6E1542-AAF2-4626-A6F2-BF2E72312F8F@arachsys.com>
Date: Mon, 29 Jul 2024 08:45:15 +0100
Cc: Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: 7bit
Message-Id: <F32D054D-EBB9-4384-AB56-35A9B9AF61D6@arachsys.com>
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
 <20240620201617.GA3566532@bill-the-cat>
 <12A8F8B4-C25C-4056-919F-005344CC3E86@arachsys.com>
 <5F6E1542-AAF2-4626-A6F2-BF2E72312F8F@arachsys.com>
To: Tom Rini <trini@konsulko.com>
X-Mailer: Apple Mail (2.3654.120.0.1.15)
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

Chris Webb <chris@arachsys.com> wrote:

> Now the release is out, I'd be really keen to pick this one up and get  
> it fixed upstream if possible.

Hi Tom, is there anything more I can do to help out here? I'd love  
upstream 2024.10 to ship with gpio-hog that works again.

Best wishes,

Chris.
