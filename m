Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE2DC28B30
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 01:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB21481E5B;
	Mon, 24 Mar 2025 02:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RI2uH0qa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UzOEwsHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 982B481BC0; Mon, 24 Mar 2025 02:15:30 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2363B8198B
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 02:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZLZqM21hGz9smV;
 Mon, 24 Mar 2025 02:15:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742778927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkKVEfcG23bk6snkvAch8yZ6yiXmLPjC+bri8bQw2Ro=;
 b=RI2uH0qaXyhdCX01kQY3WmiS3xCE/r5+PdKKA9CefB/JJVTDP1zzXWQW/ta+9YmlzWGEl9
 qIT7JAuEBBnHY89bMJWXQY5YOSqQvu3Rv37c6rJnV45wwlkobPMBJnozoxSmq6jceX9Ggm
 1n/U5LUXKLXY3wGLfTgboxPK937Ioi3ktkfv39HfIp/mUyq9FVrFz3tcarMJFoaVClrkWh
 iFVtZ0BjNF99qlZgxEHh2GMVMkBqatqaQm5IP4oRV2iiXpfvZwbYHbcE3rjGwAl5pbmNMd
 9JJnDdygtBYiSneN1FKVCoqay+HYjwjvgBemHtuA6AaGvWi6uZV1XFraoi+Uig==
Message-ID: <f239e5d7-635f-4db1-92fa-c9ddc2190590@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742778925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkKVEfcG23bk6snkvAch8yZ6yiXmLPjC+bri8bQw2Ro=;
 b=UzOEwsHoMY0+O+NGdhOpj9uga6ugQ4KqS7L6C1oCRSbB7FieiL3yel1LEUZPOtTOxfiwZO
 nPmbNJAxLCFGt3oN64dXNR9MoqPMECJ+L4WcnA7/tChe4mjMCAd9XW/+nR2RxZuFeTOP/a
 Ajz7zhQ5n0dbS5HAu6w04XioCjzVj7O6T/MrQsPss0hrMebA+MZ/3t2nfbW0zglOOzDzYW
 eIGM0dh0YFc7ulslcaYOxvnTNc8kztCpKF2jYl6rLuIW7SpeHfEsaFed/FZc+OPbRsUFjj
 gAPA8kgQdHB3VR8pvms/MQvh0NWahiKhhGo9bFWoGAI7El1dE/ZF01HKoKYP4g==
Date: Mon, 24 Mar 2025 02:00:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] renesas_rzg2l_smarc_defconfig: Enable networking
 support
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
 <20250319120401.8297-5-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250319120401.8297-5-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d0a5d5c4cf4bedff6bc
X-MBO-RS-META: z66pk471dr3j4qgya6xcqko3hmwekef8
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

On 3/19/25 1:04 PM, Paul Barker wrote:
> For Ethernet to work on the RZ/G2L board, we need to enable support for
> the ksz9131 PHY and enable random MAC address generation (as no MAC
> address is programmed into the board).
> 
> We also enable the `dhcp`, `mii` and `ping` commands so that Ethernet
> functionality can be tested and used to boot Linux.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
