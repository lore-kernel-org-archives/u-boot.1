Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19354CCFA13
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 16:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64705848B0;
	Wed, 29 Apr 2026 18:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="urkOdEYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA43848BD; Wed, 29 Apr 2026 18:08:31 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19E9D8489D
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 18:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g5Mff5st8z9scC;
 Wed, 29 Apr 2026 18:08:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777478906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSFac0u7rQ/vvO+IlzZjwGkvh1yZPxl8b1BYZ1ZjgZQ=;
 b=urkOdEYAhHFdZIUS/Ke9eyrOLRQI1XnUoR52LtsRfyhbfc5e/NiXMGru146/Z5YQqWStG+
 mPZSv1HfB/HRym1L6rvpBdmWpLKJrlha/7y4NpD0CtSe8JnOWspwsRGj49FUSwkcaXErkS
 ILcLafsjZ0bHNyK6xWY3c3pVMiN6bY41Difa7W0GByXqq9kh6XL1ssEEU2Jpn4leQMt3r4
 SCqBeWGc+T/3fMzR3ESLcy2XXCo8wZ6VPF+i/yvxP/FpZ9D21rvcsyEMtHkww39BAw4/Xa
 vNP1fqxu6SX0jTp4ZL7gWMu7MeVU6VczjSVU5fKonTBEkYIAmN2qIv1rggZNYA==
Message-ID: <e037306a-86f6-4df8-8486-73902792a914@mailbox.org>
Date: Wed, 29 Apr 2026 18:08:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] scripts/dtc: drop yaml in DT validation
To: Quentin Schulz <quentin.schulz@cherry.de>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 u-boot@lists.denx.de, Greg Malysa <malysagreg@gmail.com>,
 David Lechner <dlechner@baylibre.com>
Cc: thomas.petazzoni@bootlin.com
References: <20260429144615.142350-1-joaomarcos.costa@bootlin.com>
 <01c1fa30-6dcc-443d-a217-b032a0a8b53b@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <01c1fa30-6dcc-443d-a217-b032a0a8b53b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kx77yhbzmn69npp9pqyzcgqa1a8fjy6e
X-MBO-RS-ID: 3e47bb2ce051f7d06ac
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

On 4/29/26 4:59 PM, Quentin Schulz wrote:
> Hi Joaõ,
> 
> On 4/29/26 4:46 PM, João Marcos Costa wrote:
>> The build issues found in dtc/yamltree were partially mitigated by a
>> previous commit (807bcd844a: "scripts/dtc: Fix pkg-config behavior under
>> sysroot"), but upstream dtc simply disabled yaml, and the same should be
>> done here in order to permanently avoid those issues.
>>
>> Backport the change below from Linux v5.18 [1]:
>>
> 
> I'm kinda worried we've been missing other patches since our last sync 
> claims we bumped to 6.1 so we should have had this commit.

The last DTC sync should put U-Boot at Linux 6.17.y , see:

0535e46d55d7 ("scripts/dtc: Update to upstream version 
v1.7.2-35-g52f07dcca47c")

So I wonder how this patch got missed or slipped through the cracks.

> It'd be nice to know which (if any) issues you encountered when 
> backporting the patch (e.g. things you didn't backport on purpose and why).

I agree, and it would be very helpful to check for any other missing 
patches.
