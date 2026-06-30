Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264E0C43327
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 22:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844C184AA2;
	Wed,  1 Jul 2026 00:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JO/VDrSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DAA584A1D; Wed,  1 Jul 2026 00:26:13 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B7E84B52
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 00:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gqd5q5bdhz9t6y;
 Wed,  1 Jul 2026 00:26:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782858367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wkxSVpRqvpSb51rzzpmBeOurpsZYbw2H3M5Xlvsx3HM=;
 b=JO/VDrSGx98N1xfh7KOUUciXBXnANJg5z88qEA7Ooh/AiVmLgCVBzwfgxirBkvHuohuDEN
 ycFz3w2nPRsWds0V/c+rEI6kraxGCYVhBJuHOwN9/z++PltyjDqbJDDEpZzmldrhJeS/tE
 iIAua1nJ2AjRBrBcaoeKDLWd7mkUHSWKiW+w9xqMwD1D48YjgjsNxX+hySW1PD3OwWnAns
 wpIkzy2x2K3zHQF4bcXdwsQ4VnM24Coxy7uii3hokmegFXX4eWCdjteK8YHLLQ6uM/9Akn
 vDB6eYMLsj9mv5jU04430EXPjTchsQ7LUHgZmphjHextursRVwCDiaA/7enf0g==
Message-ID: <52f4c53b-0a22-4396-9bce-df0ad3efcdc9@mailbox.org>
Date: Tue, 30 Jun 2026 15:54:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: xhci: Fix bNbrPorts overwritten by another controller
To: BruceYang <13738176232@163.com>
Cc: u-boot <u-boot@lists.denx.de>, "bmeng.cn" <bmeng.cn@gmail.com>
References: <1782563839-11379-1-git-send-email-13738176232@163.com>
 <dc5ecf1c-ee61-4434-a19b-966f287f1533@mailbox.org>
 <5165dbf8.4708d.19f120e171a.Coremail.13738176232@163.com>
 <3e01c1fe-3e8f-402c-a823-8fca9f6c2a3a@mailbox.org>
 <53ed0453.9aa5.19f18b4a0a0.Coremail.13738176232@163.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <53ed0453.9aa5.19f18b4a0a0.Coremail.13738176232@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d999e0e2de7e8064800
X-MBO-RS-META: 99ru7k8hsc6b683s8kaixjo53c61twux
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

On 6/30/26 3:25 PM, BruceYang wrote:
> New patch as attachment, thank you.
Please follow the patch submission guidelines here:

https://docs.u-boot-project.org/en/latest/develop/sending_patches.html

"Send your patches as plain text messages: no HTML, no MIME, no links, 
no compression, no attachments. Just plain text."

Thank you
