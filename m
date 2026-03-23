Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5996CF483F8
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 21:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9BC883FC5;
	Mon, 23 Mar 2026 22:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Bq6LRa9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A41783FC6; Mon, 23 Mar 2026 22:14:51 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A0D983F00
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 22:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ffmCD25SDz9ssd;
 Mon, 23 Mar 2026 22:14:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774300488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RwDPLtqmwD7YDB4qNIWqY5VAHTBEFiqA42Zn6EMR+o=;
 b=Bq6LRa9L1JKxq4o3pb9WO1yUWq0R29EK3CR8eRWSgcEVXltO709ELqTIRW6GzeffcpPKYh
 kt7Z446qUwKcuEpG6AGnZTGjY9LNpuJBD+RDnY2eL5EgpKEowfV+lYqvH0XIAIwxLkq24z
 RvrH5zKn+Okdbp95eHQzE4mDZZ6xT37bd8tZhT3GHa4zXsAs2m2OvtnKll8FS4zYVDO/u7
 ELA/VXJK2t3ldFtT7RVXoQLA9+FBJ9kWvPci2ghrpopLTQYbhOa9/0AN7IVCxR0YQDC3Dn
 CBNw+vd+fgWEKrngwUS9a012rlfN9HzJ8hcOZh7Isf5QcIb9BR5Ggs5Nu5lNRA==
Message-ID: <88ef4fb3-88dc-4f2d-9ffa-b6574e4e8b38@mailbox.org>
Date: Mon, 23 Mar 2026 22:14:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: Correct dependencies for USB_RENESAS_USBHS
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260323195308.2363626-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260323195308.2363626-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 91e7ee966896479cd9c
X-MBO-RS-META: 79f6wm6h1cxzbiwmp4hh7a5ifxcrgbg6
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

On 3/23/26 8:53 PM, Tom Rini wrote:
> The USB_RENESAS_USBHS functionality can only work with DM_USB_GADGET
> enabled, so express this dependency in Kconfig.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks
