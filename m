Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5699F4613A
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BC48418A;
	Mon, 23 Mar 2026 16:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VjVBtgRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01DA584180; Mon, 23 Mar 2026 16:05:49 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1738406D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 16:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ffc1P0WQQz9tSb;
 Mon, 23 Mar 2026 16:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774278345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6eYuOl5hoR9/TYTHlkrcyE1rrPhqgwKP+MTVDY2XSo=;
 b=VjVBtgRjT2XROn+3LyVZfCrrTB9ND3JnlB1egP0TSnwU0+PPVnaSdaaNzNE6HHGpjBVhfE
 +29A130pkxkOEIU+7YgNBPWxWCtKGHTdCCVwrmszNcRfiuPIKUrKx5jfB0M4obziz6LYoN
 qseWjmyhF75OuAN5LSUnSgv3V1hXeBfggegYs99eVb/h05+gHq2ei0OOez638f+Xz9tZs1
 HVm/WHs0cLGzS0ipketogF0m4jCAAnQHgVBaZpE1n41dRqVR1Zu1XL6LCHIN18ouwrIMfQ
 Bfrjdu8KbiFDi+YoZOOvmzaQb/ylwLV863r9OL9X78rlEWgh6lMR2uYy8SZLMw==
Message-ID: <6b1784e6-ad9f-46f4-8890-ac0f2939cf03@mailbox.org>
Date: Mon, 23 Mar 2026 16:04:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: Correct dependencies around USB_EMUL
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <f6ffc6db-c59d-45c9-964f-7fa56c320047@mailbox.org>
 <20260323143836.2274286-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260323143836.2274286-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: bb3c396432c9ab472a1
X-MBO-RS-META: ap5ie87mtzkhawskzhxshuzyptx4skwz
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

On 3/23/26 3:38 PM, Tom Rini wrote:
> The symbol USB_EMUL is how sandbox has access to USB. It's
> implementation however enforces a few other requirements. It must have
> SCSI enabled, and in turn that means it must have BLK enabled. Finally,
> we should not be using SANDBOX itself as a symbol to decide what to
> build or not build here, as SANDBOX is selected for COMPILE_TEST builds
> as well and so may not have enabled the sandbox specific USB support.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
