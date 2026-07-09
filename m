Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867C1C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 15:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE6F84B88;
	Thu,  9 Jul 2026 17:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="N5kN/+du";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4CB384BB8; Thu,  9 Jul 2026 17:20:29 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 774CD84B77
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 17:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 422B3117D84; Thu,  9 Jul 2026 17:20:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783610427;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=mHha0NPkCsrkispaL3ZbKFH5drvW/I6lFGyaWrlK72U=;
 b=N5kN/+du9qfco012weJM63x6FffOieq9VLzOd7rmy09MhclUVMONlQOpDgeIXEuyTuDx9n
 rO6EGJug/oT0fMFxhu2gtml/2zH5AYNSVWQTQ4DEOoQeEHFPEl/YCh/aUOR8XM0wgu2WKY
 hTHCv4fo8ykvAX8LiXIBhs8RszFYuX9qjeINyMBMTTwE/9gYPZK55wDP/IHH2uyeQbeZaL
 xZliw5T1k9NAlMh61vNsx7pyJOeE+sDM/d30x4b/J2KvyxwiJNvqHwDt10DPnpfGv0ij5/
 sbmavV2P7IU5c+/2cuhGbsckQ2MqkdWxmD38+SiDjKBBc365v/gR+eYmxwgljw==
Message-ID: <33b2e08c-d7a0-f849-230f-bfacdf00f310@nabladev.com>
Date: Thu, 9 Jul 2026 17:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] i2c: nx: Use dev_read_addr_ptr()
Content-Language: en-US
From: Heiko Schocher <hs@nabladev.com>
To: peng.fan@nxp.com, stefan_b@posteo.net, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260525040303.2367825-1-peng.fan@nxp.com>
 <35aeead7-d969-152e-72b3-49c9720108d6@nabladev.com>
In-Reply-To: <35aeead7-d969-152e-72b3-49c9720108d6@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Peng,

On 27.05.26 05:16, Heiko Schocher wrote:
> Hello Peng,
> 
> On 25.05.26 06:03, peng.fan@nxp.com wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Use dev_read_addr_ptr() which supports both live device tree and flat DT
>> backends, avoiding direct dependency on devfdt_* helpers.
>>
>> No functional changes.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/i2c/nx_i2c.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Heiko Schocher <hs@nabladev.com>

Applied to u-boot-i2c.git

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
