Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64C2E743F3
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 08:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC4886E78;
	Fri, 29 Sep 2023 10:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="vsOLiei9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A6086EA5; Fri, 29 Sep 2023 10:06:55 +0200 (CEST)
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2976B86E98
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 10:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vitali64pmemail@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1695974813; x=1696234013;
 bh=wS3Y4C6e+5lgzxDUeOmr63/et2iA8PZa3hi2Y+r9DzU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=vsOLiei9AxOj3SrPUmzCg/wVh45k1pqIqow7mEqWuV4oYtRXayzDRow/W6Copg7wW
 wHDqJHuo34ca1tFmEHuVM7U21k7llVNHqQ27DZU6+owjhJsYaRgg8xtRpWmR2rInEX
 PXYz7COWWs9E4mJFNJbJmh1pAxfBi+FL9GUDdrU3r9R4V5mGhJc+gZZa6o3yJgb8f0
 ICMU5JSj/nnXMipipoTQ5Ry6cf8qdGtEzL5hJEwMpSXQk4sqRHkeq4oV+C6ncmRDff
 G7bERSNlXq32+xLtaYpA3+ZAYbkehXeSUCAeUUrQ2scYeEiYAwNHt1+Ipca1GJ3s7S
 WKvFOcd8u7xCQ==
Date: Fri, 29 Sep 2023 08:06:40 +0000
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] spl: Jump to image at end of board_init_r
Message-ID: <CVV8VHU0VQ6H.2VWZ0SBNM9CO8@flaptop>
In-Reply-To: <9ec16f73-117c-42c8-bb97-fdfdecacfbc9@gmx.de>
References: <20230927214415.2224768-1-jonas@kwiboo.se>
 <b99750c4-973f-48f4-9c3b-166f0e5e832c@gmx.de>
 <CVV8MYJATGY1.17IBLLQ28R1YF@flaptop>
 <9ec16f73-117c-42c8-bb97-fdfdecacfbc9@gmx.de>
Feedback-ID: 37421466:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> We should understand the implications of your patch on the code size. If
> it leads to binary code growth, we should evaluate alternatives.

This is not my patch, but Jonas'. But sure.

Cheers.

