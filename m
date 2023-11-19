Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C51EC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FB88709F;
	Sun, 19 Nov 2023 21:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pJJps0Wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 937C687250; Sun, 19 Nov 2023 21:05:58 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F3286F44
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 21:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4SYM8F50X4z9sR6;
 Sun, 19 Nov 2023 21:05:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700424349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czJVG7IArzxeq1rrfp8MMf8rgtxDZrNPA4IOgTIv9vI=;
 b=pJJps0WjfJ1d43L2oPRh2lMKPa2ygD7kJYcggHp6Dr66X1zFQKKiL+JtKUa5d6xZBtyznP
 Dqtp/lDE6DaozfnCTM0hNZyBvOjw2IyH8tdlkAx6cJWfdoaHwibOjUjxrIZ8ULylvAGm4Y
 96QSqGJeipd7qcx19hXGYci8j9oOp79EgdZr9oVWDqMaW2RCfA3VFqjijIZLsVx3SlvcJA
 utzblZ/NRAB8+JXykE5+Mm8mxa+UWb2G8xgZQdBCAgWNRhlNmPInS9iEOTxD6abFdzXYFl
 k0N2DSUyGrrn5PEGHN69Io+pt77DLNRNIgdVZUPg9Hqr8JTDGCcZgvXTm/fbmg==
Message-ID: <aab776d0-c1d5-4c78-826f-a6723a856c42@mailbox.org>
Date: Sun, 19 Nov 2023 21:05:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] configs: rzg2_beacon: Realign ENV location and offset
Content-Language: en-US
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com
References: <20231025231311.8701-1-aford173@gmail.com>
 <20231025231311.8701-2-aford173@gmail.com>
 <CAHCN7xLZ2xp97nnb4JBj8tWEd9Zhj6mYX61bjrtGKRhPOUm7BQ@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHCN7xLZ2xp97nnb4JBj8tWEd9Zhj6mYX61bjrtGKRhPOUm7BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4fd6707b6579e3ea5ed
X-MBO-RS-META: hd3mor4kqje8b5f9umynki3izxbdnuue
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

On 10/31/23 16:13, Adam Ford wrote:
> On Wed, Oct 25, 2023 at 6:13 PM Adam Ford <aford173@gmail.com> wrote:
>>
>> The ENV size and offset were changed to different
>> values in Beacon's downstream release.  Change them to the
>> same values as the downstream for consistent behavior.
>>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> Marek,
> 
> I know you had some feedback on other patches in this series.  I'll
> drop one, and refactor another, but is this one ok to merge as-is or
> should I re-post without the other patches?

Please repost, and use the right To: address (+renesas@mailbox) , I'll 
pick it up shortly.
