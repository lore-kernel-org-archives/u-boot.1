Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D55CA0EF8
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 09:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0207580B9B;
	Thu, 21 Aug 2025 11:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="c/+fLnT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ACA480EE5; Thu, 21 Aug 2025 11:02:42 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13FC880422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 11:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c6y5B0Gfbz9tKY;
 Thu, 21 Aug 2025 11:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755766958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9aRmOYNErRqSs1+XLviIMa/Sj9m7MS0KLh6e4rbtImg=;
 b=c/+fLnT1vx8M0PpiMYZanKDW2dzHkFw/CoXvp4tcQWN+VhdhI26sFWdLG4x0k+DXn3Hc+9
 ufXfoNR15bKORtxHad+INejrBKZ/DRlcvyHMAWgpW0PD33RjdFVsfzfTZFxWEro1J0lu2z
 +OMEzDB4eUEFJt4fTKDV4D8mcg+APueoj9shX3sp/VrqHR86SiSQj3ktgziy36qcThZ5vh
 nKx9KOsLZtwpfsibTe9hOfokIgZncBUfMxQjmWnpbCAW3SzSxMvcUlmyI6k4CU623OSEm6
 x8aSohjv03i3v6eGUtOuy2l74jkp/+3G3e4WRJhX39BUAviCeOGwcp6k5pqiDA==
Message-ID: <b24bcb1b-0c0d-479a-82e9-168ef0bedd93@mailbox.org>
Date: Thu, 21 Aug 2025 10:50:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arch: arm: mach-socfpga: misc: improve help text and
 usage examples
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
References: <20250821033531.12750-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250821033531.12750-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: in4a7ddh8jx5scacbnxccg1ij7ynnm89
X-MBO-RS-ID: 8d64501b784cf379a6c
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

On 8/21/25 5:35 AM, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> The existing 'bridge' command help was incomplete and contained a
> spelling error. This patch updates the help text to clearly describe
> the available bridge bit positions and their corresponding masks:

The command was primarily written for CV/AV , that's why it was 
incomplete for newer SoCs. Instead of the bit handling, why not add 
support for symbolic name handling instead ?

Add 'bridge list' to print supported bridges per SoC.

Add 'bridge set' which handles bridge=state parameters, e.g. 'bridge set 
h2f=1 f2h=0 ...'. That will be future proof and scale.
