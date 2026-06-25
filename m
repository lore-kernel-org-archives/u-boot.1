Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E07DCDE00E
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 22:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A88B38498B;
	Fri, 26 Jun 2026 00:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="v7Th5HJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024BE84979; Fri, 26 Jun 2026 00:16:58 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D57E8497A
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 00:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gmY7V2vd8z9vCg;
 Fri, 26 Jun 2026 00:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782425814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=linVydwK+z+ku9ECkGJ+pYD7xh6HVtewByDSw1CQcbU=;
 b=v7Th5HJ3kfh9GHjq41G9fNfB+D+pnAYCBkFp9vzBrzq3g/umae1Qxvleon4xg7aHlVq2lf
 XHkjEVQUNRJLoeV5NqQAcx2vh+sZ/+VFBbtUJXrWTn5Zwz6wyoigFWmWpkkEizxsWVpEi5
 nhBkFGtzjwSxkDhxPgvSR58/oEJ6Y3E9jHSMPjtaAUydmSU36z6tuN6stF5uZk0F9vs9RN
 0o8aN/DwgYF33fhuoUt0DoECXlPx/n2w0J9S2bwTTzzHpSRRKOacyFr0hN76WHkHGlLw5I
 dPugbQDCwIwuNUPQiOtZu9lpqj9296xv2w9kfvkFanBAqMU4DCIo7Rwwz9RWYA==
Message-ID: <750d6e53-d48b-4791-8544-6d5edf7a895d@mailbox.org>
Date: Thu, 25 Jun 2026 14:36:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Move schedule() in
 sleep_thread()
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: dbd0ba48dc4fe241027
X-MBO-RS-META: bgrny6wgbx4btkt5mhfm6rp1tcbh6r3i
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

On 6/25/26 10:38 AM, Patrice Chotard wrote:
> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
> it may take a while to get the control back on the console,
> sometimes around 1 second.

Why does that happen ?

[...]
