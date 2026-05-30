Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CC3CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 13:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2405A846B4;
	Sat, 30 May 2026 15:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LXhZvMAe";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xo+ZRwV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831DD846E2; Sat, 30 May 2026 15:27:53 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B75838405A
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 15:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gSLd33nHxz9t4k;
 Sat, 30 May 2026 15:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780147671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpK7Ph4FiCwzKDy94VXTFzHXLwn/IpEYWW5Xi0OWHqg=;
 b=LXhZvMAexSi0y65UseZuXZ1Ue1k/2tDc35Mz1PzMTbxJTAWsl3r+YSEE1sys3tEKZ01C2Q
 sXjLwy5jspDFXDMx5onsn697r/DVLyXk2WjTHtdeweDo43xNQHCnQ/x6QEXK8kmvIf/8Hz
 Q9fAwGLLxrSoJ0T3gQwsU30IgJd9C9s6fm997ynQw8JXzV4mCnKbAPsLGCBfs5is5Jd4Da
 osQHmho2Rlc1rJ6qGTNlN7eVBcAKiLPfu3IQ2I+SbEuqEP6vKmk4PtgWWE69MmvkYZIHGL
 PS77psq+lXSuA89x/zgMJopfZAwMhJ8qOeGhupsztWKjCPuS44XS1vgvcZvhAA==
Message-ID: <1724b93b-6987-46f6-b5e9-3ab35a743307@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780147670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpK7Ph4FiCwzKDy94VXTFzHXLwn/IpEYWW5Xi0OWHqg=;
 b=Xo+ZRwV7ks6tY2ITXc6dkdmEwEmIL+IACFZCBa5gT1QUMia1INAfGx4DOqieySDjfjwX/r
 kB5NBYibYuWvuGJcfIJgzMv10t24twHriZrn0jpmjZQ0uGxLkzTgrADUtWcNQP8waKeLBo
 YeWCcrOddfGKHs7Fs4KXMRCPB5psxprzFGjC02Leck9sxVDUtG9CT9wRjCvMY+IY6VSiWQ
 kWk7iawhm30cNLLYL0sZ/XF2i8x3LGN/qr4Bmoj9+PJrxMb5WZh/Ho8j9KXvLG6yd+Yaku
 VlTUer3K79k+SWNSGczHZNJedxu2YelLsMgkYKdgLp/03EAAvq/aiSwZdubMMA==
Date: Sat, 30 May 2026 11:59:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mvebu: usb: enable Armada 375 in XHCI driver
To: Tony Dinh <mibodhi@gmail.com>, Stefan Roese <stefan.roese@mailbox.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260529205728.17491-1-mibodhi@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260529205728.17491-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ftmhu1aamnu7jh1qa6kodup3ocqd6yxr
X-MBO-RS-ID: 7afe8e383b3b39cf52e
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

On 5/29/26 10:56 PM, Tony Dinh wrote:
> Add armada-375-xhci to the compatible list in XHCI MVEBU driver.
> Tested with WD MyCloud Gen2 NAS.

[...]

>   static const struct udevice_id xhci_usb_ids[] = {
>   	{ .compatible = "marvell,armada3700-xhci" },
> +	{ .compatible = "marvell, armada-375-xhci" },
Do you also include the space in your platform DT ?
