Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF30CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386A084B1E;
	Fri,  8 May 2026 14:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MtnzXvbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8A284AC1; Fri,  8 May 2026 14:20:39 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 339F884BBD
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBp9b4cBtz9vFg;
 Fri,  8 May 2026 14:20:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5iznigwAzeG5hv283bCR/bx03FNFT2v9fN+lWvwc4Ts=;
 b=MtnzXvbJWbEIG2AvCSxpbw/zboqhKKBI7iclX7EDYPo0q/OKihTvfi7N5Q1zxn1aNkVZ2J
 Av9svv0Wz6LXONxr9a61V2BWw+zuP1x1qxwfptPs6vubW2mC56xWDmN7vuNDUuwckKW9li
 DWp/Ck2xronkY/rWD9EBUkmk4JwsI7gJL5ceRLPzylHf0ZkBFxg/3rJiIpPmSqyLDhfdEo
 6Jw9uBSbA2HNhtHH4AYN7VK8vXGvEy4zde3HWq/nNaWaSkaHRe2rV+YNXqd++6JwW8hDnB
 N0AqKSTk/Z4tqMcvX7g9n+L9GFHb0I9QCv9lK+Oudh2WBfpqEAoSVyDFQ9DELw==
Message-ID: <7eef36e8-eb3e-4c00-b8f1-8e9fb4ccab93@mailbox.org>
Date: Fri, 8 May 2026 14:20:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] i2c: designware_i2c: Staticize and constify driver ops
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20260507220617.209146-1-marek.vasut+renesas@mailbox.org>
 <GV2PR05MB11941F63872E9E63334FBD8FF833D2@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <GV2PR05MB11941F63872E9E63334FBD8FF833D2@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 99myny7ars43cuso8edee3tmkastiucn
X-MBO-RS-ID: 703c78709bda64c526d
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

On 5/8/26 11:06 AM, Maarten Brock wrote:
> Hi Marek,
> 
> I don't see const being applied.
> I seither the patch or the comment incorrect?
Its the description, ACPI_OPS_PTR macro does not allow the use of const 
here.
