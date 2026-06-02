Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DF9CD6E5D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 20:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF198486A;
	Tue,  2 Jun 2026 22:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UqqrwVvs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R/4uDqpK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432228486B; Tue,  2 Jun 2026 22:47:06 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9408184852
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 22:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gVNDR2STLz9sQ5;
 Tue,  2 Jun 2026 22:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780433223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38qgKfXBRu1i4QIHVU72/09zKK2mu3c2VPiFzLJafkE=;
 b=UqqrwVvsp54c0gJ2wd9XXfwIy0y2dbdtneU25bx/uw4+i0Cc3ZUJk0tz7BSG4ADHHFsioa
 lnZEytmly+rLh6IS7Ipawf/lriSc3H+WbcS63Ovi2xXzbAhPe6DtrGfGlQ/9yS399AhraY
 d9AB0Mch4an7lncUss+bawGks4gWQdkbwxazRuPQgPzAzQJxUnjuGaVmbgNdbZ8k5BU2tL
 M+E96yVAgv+lasSh+M8CGg/MJwvSt2S5wJ4JV/W1Q9lN+oi0nfSDnbqHv8BwGa3/vYcje8
 dCe+HLIvO7+rvE/Y7NBgoqTrZ2hgL33NsECqCEGdenrqj3N7CxhJp4hq4g09qQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="R/4uDqpK";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <fd63b428-d508-458e-ae94-18b669d8a774@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780433221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38qgKfXBRu1i4QIHVU72/09zKK2mu3c2VPiFzLJafkE=;
 b=R/4uDqpKSpIqfNPilVMCU3z64GM2wqgkH9aE9ooD0TkcPgLdmj1od6qc6TgqIfRxwo/a64
 jn0/XOqIbG6TLd+5C1R2T41UOEuy1ZRyQPJ+ZkA5URnE0ACNOaEXV9EzeR4t/0OMwyRQ4N
 Uq0oKdwn6Piphl1LbP52qFsTyk9zx+Cehm9ihK60TYKZ1w5GKAta+35izjDF69MtKP3EyW
 GOxfndIsjZ4rEOsqMDxpCCFUh04VSOkgcNL/jghid3HEigvxXAeW4ObhRGyD0B8OHAkOWG
 4NFEUo8jmhEEWANSgP2+uceDv43rkF7mHn8yp2i6bGY9RbZnphpzv4VDVcfNqw==
Date: Tue, 2 Jun 2026 22:46:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: xhci-mvebu: Enable Armada 375 in XHCI driver
To: Tony Dinh <mibodhi@gmail.com>, Stefan Roese <stefan.roese@mailbox.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260602192524.11108-1-mibodhi@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260602192524.11108-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fa765bcf005c2e624db
X-MBO-RS-META: fi6m7c44o6zicg98mkg1aqt5hr8xask3
X-Rspamd-Queue-Id: 4gVNDR2STLz9sQ5
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

On 6/2/26 9:24 PM, Tony Dinh wrote:
> Add armada-375-xhci to the compatible list in XHCI MVEBU driver.
> Tested with WD MyCloud Gen2 NAS.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Thanks !
