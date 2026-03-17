Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD5FF6E9F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 00:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44931840A2;
	Wed, 18 Mar 2026 01:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LV5k42Iw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VNBJm+/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C330F83FAF; Wed, 18 Mar 2026 01:07:47 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8A383F6D
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 01:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fb8KY4yvLz9sxL;
 Wed, 18 Mar 2026 01:07:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773792465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi1mmFcgaZDpo/IzSO+n8eI/bbInBdPq1uuwmgsqWfM=;
 b=LV5k42IwTk4sdEqt7umeRuhcKFz+yFn4U4jnBzlIR3xrm3SXjluOMf9JuKt78+vqjXN6K0
 XPTMpgNwtJMwudhDwGbUTgckRgXzEF8QiQH00zU16vAKmC8MSO1avi+oNi3DfpIv9XwPTQ
 Ux6DOgglzhqkvKFuZ/EJUmq7ZEFCGeAS+i+ytk6sLSuV4Gud+lMVHPpVIZktdWjKK10L1l
 QoQ4MVncOQN8ZnIa1T6SfXOXzYX64mLRFp4eKk/nSfXwUHcc4zPHSBEtmxukw4coDfm27v
 igHUy5IgeeSG1vG3G0Z8vFf3+IT3k/J3+p7rw36sylGhW9xxDH36U7O2P8fVgA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="VNBJm+/K";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <bbdd71c7-3276-402e-a9f8-98afffd10538@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773792464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi1mmFcgaZDpo/IzSO+n8eI/bbInBdPq1uuwmgsqWfM=;
 b=VNBJm+/KNRKkGnuGgIq1pMGIk0mzJFAuuz8NDlFPfK1qcOjtK+ov9YukvEEWpa97/AbYiU
 Om40VC803p371Bsp0CZks7i2pLpYF2e88Nm9+I96WcPUfiukf1k9drZsRJ7VqCA8tzq82Q
 z8UWIwX2k6OCTfOKGQehYZ+9QkpeR7t/am0Jp2V1gJFGXhvCwe/6WgIRxsBL6UbWtKcLJ3
 oAuNDaMCG3X5chFUYpSsq4RuAzFzwqOljNdGFizVtmDwMnClAjId2+Tynr/4A6bFlW7Xnf
 LmHQB3rF5b7CT53JxrXrv+a7S5Sf21eMFUOB1O1DcO03V1Ugjpp0WWZCA+Cd+Q==
Date: Tue, 17 Mar 2026 20:42:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly
 more visible
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <bcaede64-7918-4eaf-9695-a155b1395e50@mailbox.org>
 <20260317134107.GR502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260317134107.GR502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: bbd4bf87da3db9bd73b
X-MBO-RS-META: urnyhcuoc785cp6sowgnh1wuw7g8gmx1
X-Rspamd-Queue-Id: 4fb8KY4yvLz9sxL
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

On 3/17/26 2:41 PM, Tom Rini wrote:
> On Tue, Mar 17, 2026 at 03:34:36AM +0100, Marek Vasut wrote:
>> On 3/17/26 2:24 AM, Tom Rini wrote:
>>> As exposed by "make randconfig", we have an issue around
>>> USB_GADGET_DUALSPEED. It is possible to select this symbol (via
>>> SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency. As
>>> this is a hidden symbol, move it up within the menu.
>> What is the issue this is fixing ?
> 
> Valid configs causing the kconfig part of the build system to note
> unmet dependencies.
Lemme rephrase, is this actually a fix, or is this some 
readability/ordering improvement patch ?
