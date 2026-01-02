Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7774CFC6166
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 00:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB4283BDD;
	Sat,  3 Jan 2026 01:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Dp3pVz8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50646842B6; Sat,  3 Jan 2026 01:44:21 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A2283BDD
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 01:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4djhdr5LNzz9tC3;
 Sat,  3 Jan 2026 01:44:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767401056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4lnXkNJoIEuDH8BPefRocxuIcd/aEojoQVMgbcOvjHc=;
 b=Dp3pVz8UWWL6jdzku0I0pxehCvq6vp4FMj/lyImQz5RcbYVZS0/DJ2pdqqLhCm6eVjxzen
 YYQM6ECiXzmON2ToVmGabUrREpbKbWpIXQSEhOlXs0/8DMBvl9HTpeSTfJe9VcerAJ3sFI
 I19RtB4fSWPayEwUygwJ8twhfG1XtoLrgED2OKewKPRo4kqduiWBppuKSv6uZX3wx4WaQi
 dvy5Zb5gMNzlYbGNk5xcNAgy7IHtZtnsRcpkkJkpX8PWlu7LB/5pds9ldsNCxpoE9m+jO7
 MkUcX+bBWGWXe2OB87hSpkBG6LTsJxj0lbh4hFY+hW4m+1mqmyvbFDXQCObT8A==
Message-ID: <f205eb32-e090-498f-b9b3-cef50928e724@mailbox.org>
Date: Fri, 2 Jan 2026 20:32:27 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] usb_kbd: remove match string
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>
References: <20260102144715.185656-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260102144715.185656-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: xifmf3s9f4rxzr9tggwas9ru1c63az55
X-MBO-RS-ID: 85d8995e4215693cfc0
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

On 1/2/26 3:47 PM, Heinrich Schuchardt wrote:
> U-Boot has added a compatible match string "usb-keyboard" to bind the
> USB keyboard driver. But this compatible string is neither used in U-Boot
> nor defined in Linux.
> 
> USB keyboards are identified via a USB interface descriptor or via USB
> vendor and product IDs both in U-Boot and in Linux.
It is always the USB descriptor which indicates it is a HID / keyboard 
device, the VID/PID is used for quirks only.
