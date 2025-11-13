Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A05DCD98F5
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 22:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A199B84099;
	Thu, 13 Nov 2025 23:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XvoRS6hQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3088409E; Thu, 13 Nov 2025 23:19:29 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F1B84081
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 23:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d6vnn5S6Tz9t2s;
 Thu, 13 Nov 2025 23:19:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763072365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fq/jJLxxIyMv6Q4IX5VbUJOJr8ylMTWPTylz9X2iTDw=;
 b=XvoRS6hQ5AcDRllQ06KMVD0+9XlGp2dXWZeoZEQe5kGCVFfSHDMGaJ5T2nQTZozo4+g5wB
 NqwwY9FBWwOyb5Bi94t549DMQRgD8SfSo4QCmh6yWAYgAgn82VZTAhL2BdFaKdfqYUZjtW
 SzGbuZDWQZvQqiEmvcwKZjfQNTS8/o7Dgss1zE4+Tw0f2UqKwhSdpZl8WWISizeQKbHrs6
 jiN4oixeGVtZkEK7VvusiRYFAMp4B5V9XlSfeh9zwDBDvbbIKULzYA5mWF68jyPD664MFt
 wRqSPuzWq+GqV2nzh5V1vhNvXRKnHMsirmRMKge8+bSh6EOXbD5Doua3rTz/LA==
Message-ID: <4f779ce5-b0c7-40e7-b8cb-11aa37cd0eb9@mailbox.org>
Date: Thu, 13 Nov 2025 23:19:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCHv2] Dockerfile: Include python3-tk for FATtools
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251113220956.1833225-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251113220956.1833225-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d2512a595a4aedc447f
X-MBO-RS-META: eesajtcpoow8ijce7op1ad4cyzgd69uj
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

On 11/13/25 11:09 PM, Tom Rini wrote:
> In some cases our tests for exFAT don't run because we fail to be able
> to create the underlying image. This is in turn because while creation
> of the image succeeds, it seems that some way of how we invoke FATtools
> wants to import tkinter, that fails and so the test stops there. Having
> tkinter available (and then presumably a fallback to non-GUI because
> it's not available) leads to the tests running as expected.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Alphabetize, per Marek
> 
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks
