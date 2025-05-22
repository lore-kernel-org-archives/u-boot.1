Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6912AC54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 12:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B209283091;
	Thu, 22 May 2025 14:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ditigal.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ditigal.xyz header.i=@ditigal.xyz header.b="Qt2UKRiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBEC8301F; Thu, 22 May 2025 10:17:47 +0200 (CEST)
Received: from mail.ditigal.xyz (ditigal.xyz [IPv6:2a01:4f8:1c1b:6a1c::])
 (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E4D82F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 10:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ditigal.xyz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rutherther@ditigal.xyz
Received: by cerebrum (OpenSMTPD) with ESMTPSA id 41b18d33
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Thu, 22 May 2025 08:17:45 +0000 (UTC)
From: Rutherther <rutherther@ditigal.xyz>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] phy: zynqmp: Fix sgmii clk ctrl GTR lane bit shift
In-Reply-To: <7d8ba8c8-49f6-43a3-af45-8a17d106af55@amd.com>
References: <20250521181620.8175-1-rutherther@ditigal.xyz>
 <7d8ba8c8-49f6-43a3-af45-8a17d106af55@amd.com>
Date: Thu, 22 May 2025 10:17:43 +0200
Message-ID: <87msb5hxeg.fsf@ditigal.xyz>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ditigal.xyz;
 i=@ditigal.xyz; q=dns/txt; s=20240917; t=1747901865; h=from : to :
 subject : in-reply-to : references : date : message-id : mime-version
 : content-type : from;
 bh=7x3pvKQH3VIN2eSykFb7+QfnnYLt4zFsEXQREbUhNMw=;
 b=Qt2UKRiICn5OeNIpsHiOHwIhbWpOiUjkPbULMwPC96sOVr1gynFOoiv8jHpoO3n1aZML5
 xqJs59ZKo0fJLgmsvYhLK3dQxQ+XClHwBDkMilmMNHhcKUspXMWHBLKiAYhEessGZM9zpX5
 Ei0iMuqaBxb/ZXmGDCuRy61KxQSbuDM=
X-Mailman-Approved-At: Thu, 22 May 2025 14:30:51 +0200
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

Michal Simek <michal.simek@amd.com> writes:

> On 5/21/25 20:16, Rutherther wrote:
>> The bitshift in GEM_CLK_CTRL register is five bits, not two. There are
>> four bits for each GEM, and one bit reserved in between.
>> 
>> This has caused that using more than one GEM is impossible,
>> additionally corrupting the GEM0's configuration, leaving GEM0
>> unusable as well (ie. if GEM0 and GEM1 are used, GEM1 configuration is
>> going to write to GEM0's registers wrong value, leaving GEM0 unusable)
>> 
>> Signed-off-by: Frantisek Bohacek <rutherther@ditigal.xyz>
>
> You still have the problem that address which you are using for sending is not 
> matching your SOB line.
> Author:     Rutherther <rutherther@ditigal.xyz>
> Signed-off-by: Frantisek Bohacek <rutherther@ditigal.xyz>

Sorry about that, I forgot I configured my smtp client to replace name
in the From header. Should be fine in v3 I sent few hours ago, I hope.

Is full name a requirement to contribute to u-boot?

Regards
Rutherther
