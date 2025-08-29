Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E599CA0FF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE538354B;
	Fri, 29 Aug 2025 10:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Vi/LDdyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D8883559; Fri, 29 Aug 2025 10:41:17 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28DB83542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cCsDn6t3Pz9slM;
 Fri, 29 Aug 2025 10:41:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756456874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWIKC093WuPPm998w3NQgugltBJCfl0+DHEc50H/3Nw=;
 b=Vi/LDdyS29SYTIPml7ESWTTN2LsryfVWMTAmBSBbtANSKVagAfWrnwPJkq9O/LOtJYpkmp
 vKhL0U7mTIcNY3IKQ1q9YTqjt7S80NnD1yWVQdnFZ6xmC55Nku1oIhGzBkUtfqBzoopGZA
 GIJX5/sbhkNciUkMbCe4WFEdeEcWt8iFF0wk0/KgVvMe5Hfn0fgBvFLhvU269vhSpzWrTX
 2WUbNgmKJcfL/h71Hu8qSY6bZIwAeB4sVbjyHkpPYQZjMToNyO2ZrGfTQ8gqr89m3BGg7+
 eYvXKNmDoLJ26YkB3ptli17pP1kkQdrfdwOGGtTIVQyE7cQCJWbnbKzEF/C3JA==
Message-ID: <7cfaf6cb-38b9-4932-8904-ce7be12a5098@mailbox.org>
Date: Fri, 29 Aug 2025 10:41:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 551f3b00e75a987797d
X-MBO-RS-META: 5u8tiww1z54wxaqothig4oxoe9e91gam
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

On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
> Some USB devices need more time to be initialized. Hence,
> increasing the default USB Hub debounce timeout value for
> devices to be discovered, connected to Agilex5 boards.
Is this really hub debounce timeout or usb_pgood_delay ?

Which devices are those, include that in the commit message.
