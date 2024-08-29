Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E820AC7115E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 02:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5247788A0E;
	Thu, 29 Aug 2024 04:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="m8hECCXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66EF8889E9; Thu, 29 Aug 2024 04:28:06 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9F488A0E
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 04:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WvQDc5hbxz9sjL;
 Thu, 29 Aug 2024 04:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724898480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FoVGRntpzIYZ3hcnAzUjA/EPnwiuA+6WuLsAsD20swU=;
 b=m8hECCXj5HAIeOfYpr0l9OGGBTtcz4E40inRS1EAIgosdCoaXWJPw3aaiJX/tYCbUf7HYn
 IbxqBEW/U23kslaBJNnli+xNQSGA9tqYiQRYzHCRLTPN2AOjWS1BDsm3eYzL8/DN/2RHhB
 MKQyvpYA1b/dIsp2tiUIdkqz7ko1rCHK57P6INbETdBL089qj2a989izNR5fGOU67Xv1SM
 Hw6kiBIyRxCVSeTG4p8KEKNAjnujeNaY1h6XMlv8mFXuhH0DaWBKnDszYfIIQC5avxRnlL
 afCcwBBDIk7gcoSlznoScyzDTDItEd/jMC6zA93S1YyC8kisMSmUeobQJiarxA==
Message-ID: <aaf209a9-c558-4674-a841-fa93b94c36ad@mailbox.org>
Date: Thu, 29 Aug 2024 04:27:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: imx: Wrap i.MX config options in HAVE_IMX
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20240829012247.179471-1-marek.vasut+renesas@mailbox.org>
 <CAOMZO5AnrOU87M1NigUqzF-p8zMctDv105C36XTzbcgKPbUyEg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAOMZO5AnrOU87M1NigUqzF-p8zMctDv105C36XTzbcgKPbUyEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8c22b44d1a6e2a17568
X-MBO-RS-META: m1fkymmz5giax6u5scdqjqnznzp8kyfw
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

On 8/29/24 3:26 AM, Fabio Estevam wrote:
> Hi Marek,

Hi,

> On Wed, Aug 28, 2024 at 10:23 PM Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Wrap all the i.MX specific options in HAVE_IMX, otherwise they keep
> 
> Do you mean MACH_IMX instead?

Yes, will be fixed in V2.
