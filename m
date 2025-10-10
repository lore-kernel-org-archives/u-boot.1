Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB53CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 05:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F3AC840C1;
	Fri, 10 Oct 2025 07:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BoSaXxEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF02F8409E; Fri, 10 Oct 2025 07:24:08 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C09983FDB
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C55D103744; Fri, 10 Oct 2025 07:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1760073843;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=WRVV6/QwxHsVQ6fnE6XFS2r1USn09tdg0gYwPM83m3g=;
 b=BoSaXxEMN/GyPFV9unujsB7fiGdLyPgMRCmBWktd47zlHVHj9HAnFheX9G7z1MMuStLBb4
 yNdmszUtRC3o1awlebKPV+IpmnUnmLgooY3rC1CN9N8rDi/FEHCuqgubTXusADFWMULXmH
 UpCm6QhLoN+PIlri0ORKzQJ8UD2zolGd7mDFCHyWgy88t27Yvs0rho/FiytT993sikJVIi
 lub974ZTAsxDS7FflY42UhpR+uCE1fZtzIgAdCNhnqSvBza7XEVFTl4BPqeM29Isz7XXcw
 T2W+nXp6L1aYkkzGxgGHya7j/YQbuHtV5F5i1ejCO5Gf1RHGhx7rstHTvdxxqQ==
Message-ID: <8191fb47-67ef-cacf-f300-89fedc92f191@nabladev.com>
Date: Fri, 10 Oct 2025 07:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Please pull u-boot-ubi
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Benedikt Spranger <b.spranger@linutronix.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
References: <1f803ccd-9743-9be8-a594-58fcfeb0f687@nabladev.com>
 <20251009190641.GS298503@bill-the-cat>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251009190641.GS298503@bill-the-cat>
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

Hello Tom,

On 09.10.25 21:06, Tom Rini wrote:
> On Thu, Oct 09, 2025 at 06:23:06AM +0200, Heiko Schocher wrote:
> 
>> Hello Tom,
>>
>> please pull
>>
>> The following changes since commit 92dcb3ad5d98f494b2448a7345e1cb7eefa50278:
>>
>>    cmd/dma: implement dmareset command (2025-10-07 17:49:15 -0600)
>>
>> are available in the Git repository at:
>>
>>    git@source.denx.de:u-boot/custodians/u-boot-ubi.git tags/ubi-for-2026.01-rc1
> 
> Can you please update the .git/config here so that it looks like:
> [remote "origin"]
> 	...
> 	url = https://source.denx.de/u-boot/custodians/u-boot-ubi.git
> 	pushurl = git@source.denx.de:u-boot/custodians/u-boot-ubi.git
> 
> Then "b4 pr" will be able to fetch it for me :)

Of course! Sorry for the change here, but I had no access
to denx anymore, so I started from scratch with the repo on
my side...

>> for you to fetch changes up to 0cab29ff467e297064a9fc30200347bda06ee0c4:
>>
>>    fs: ubifs: Fix and rework error handling in ubifs_finddir (2025-10-08 11:36:05 +0200)
>>
> 
> Applied to u-boot/master, thanks!

Thanks!

bye,
Heiko
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
