Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD1AC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 23:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 637C1845F3;
	Fri,  8 Aug 2025 01:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kajH9AKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70888845EC; Fri,  8 Aug 2025 01:15:56 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F9A845F3
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 01:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4byjh33W2Yz9ssH;
 Fri,  8 Aug 2025 01:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754608547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09dXbWi98V16NhtOO+4cu9cGqZuGScbz1PH9StTzIWQ=;
 b=kajH9AKlqtH65eF7H7iVA9nlHZx8rPbBxg9TYZDEpKts4ibmUxMR1VjfQGVRzei10h/Bub
 z3bv/26NvSPfso+XOfxgcrfC50r6/gdN/OeyhJTP51VsJJxVFtThvCFoZBEWQa02hBk/zu
 Krf2P5TTJQ656f+iyiSQ0tXkvAyqSgiwWcz99p9M/mfQJHtkUN4PEC3+LyGgzvl9bcnEVt
 nGqkBcKJj3kCvtpdTouc+WJvk55/BSpGw+BOE7gRFalZUBXzS/GD7TzAnGseAHdMCPO+HZ
 q5xv8tzmDqf2NM//Yy1JYC7fuPARLs1Mp9Ax8016r2p0QH0g4kzeZWwDhDqxGA==
Message-ID: <4813ce12-ad82-4170-999c-e5f816a42708@mailbox.org>
Date: Fri, 8 Aug 2025 01:15:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
To: Tom Rini <trini@konsulko.com>
Cc: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
 <20250807162115.GZ124814@bill-the-cat>
 <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
 <20250807201142.GC124814@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250807201142.GC124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ab1d5bd35d4eeec978b
X-MBO-RS-META: 1sxkwp9ja873kcqqqwbuwusyu6fhd75x
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

On 8/7/25 10:11 PM, Tom Rini wrote:
> On Thu, Aug 07, 2025 at 09:41:34PM +0200, Marek Vasut wrote:
>> On 8/7/25 6:21 PM, Tom Rini wrote:
>>> On Thu, Aug 07, 2025 at 03:41:38PM +0200, Marek Vasut wrote:
>>>> On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
>>>>> CONFIG_HAS_BOARD_SIZE_LIMIT is obsolete, if we interpret the value
>>>>> "zero" as "unlimited".
>>>>
>>>> This sentence makes no sense. Is the variable not obsolete if its value is
>>>> non-zero ?
>>>
>>> This is phrased oddly, yes. How about:
>>> By making the code treat a size limit of 0 as unlimited we no longer
>>> need to guard asking about having a size limit on the platform.
>>
>> 0 shouldn't mean unlimited, that is just fragile ...
> 
> That's a standard unix thing? ulimit -c 0 is unlimited.

This is a really bad argument, because then the counter-argument is, 
that size = 0 is also a valid size and it shouldn't be conflated with 
SIZE_LIMIT validity.

My take on this is, don't conflate size-limit "enabled/disabled" with 
size-limit "value" , these are two separate config options. Mixing them 
is not helping.
