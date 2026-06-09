Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915F3CD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2164E8484C;
	Tue,  9 Jun 2026 12:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E2QINeZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAB1E8467E; Tue,  9 Jun 2026 12:52:29 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD0584869
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gZQj61hqpz9twQ;
 Tue,  9 Jun 2026 12:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYh3k4N6lxaStDB57Cx2o/SICAa7FAugSZ+B1kxfaxw=;
 b=E2QINeZURmY7WPFcWQBZOHneiZig3UP0fgg+Kw54Er7ySXjVCYYLRft0mc5b3r7EI4It7M
 fxlfwbC6N0ZOfMWO36iTwkmHz+9npjWYFa+t96JLJvOsKbGyf3rEv+SzZZW14s3ZnMaCgH
 6Q0EwpyU53Igpur3gqd64c09nkBGJHN9/l64le7fdrjYXk4dtQupOHE/1/pu0Cg8FNkV7Z
 BU0qeMDb48+pe001NDnpjzbhb3FQytUpILMXBKgIkfr4bfYqfFHE5mHwu1IBBAwFCxA0pN
 AVSJFjE4AZWLQHKDNaHBI6BLNPmf0aTDgkEbXeh8o+PzoelFcO2HvfuZw4nl6A==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Francois Berder <fberder@outlook.fr>,
	u-boot@lists.denx.de
Subject: Re: [PATCH v2] drivers: watchdog: Fix dev_read_addr error check
Date: Tue,  9 Jun 2026 12:52:19 +0200
Message-ID: <20260609105219.1172564-10-stefan.roese@mailbox.org>
In-Reply-To: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 763xh75hiugk3nnkaqu11h6jpme747b5
X-MBO-RS-ID: ff94e7bad48e2d131ef
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

On 5/25/26 22:33, Francois Berder wrote:

> dev_read_addr does not return a void* but fdt_addr_t.
> Replace invalid usage of dev_read_addr by dev_read_addr_ptr.
>
> v2:
>  - Replace dev_read_addr by dev_read_addr_ptr
>  - Change error to EINVAL
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>

Applied to u-boot-watchdog/next

Thanks,
Stefan
