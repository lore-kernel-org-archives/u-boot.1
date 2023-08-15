Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915B7C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 08:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9394A86725;
	Tue, 15 Aug 2023 10:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B9190sne";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mVe8l7sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A248675B; Tue, 15 Aug 2023 10:24:29 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F10786604
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 10:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RQ47G0c58z9skl;
 Tue, 15 Aug 2023 10:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692087866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eh9WSqn6cC+SL8X8SqgW+f+ct+enqovFk9iDFicaQGI=;
 b=B9190snebRmrvAb7ZY/gbG3cofQbXlGCcODuL4nzB28IMaAG4LWUHqgNeQw4UkZNPW5Qp6
 x6dPQ/A7Bs0Kl6tNPN4quyw5rLcG9wwMpuXuDY4D1x8Usm/VD4PGJfX6Fe5l0II21CDsV0
 kv8JLxLBtpQQeGNlbFh13LUEkQKoinaTxPDkxT4HNTlMqsplIMSj0knBvWCEajDbk5e9UU
 bHhlyWAmMztqwQc0lWJDN7oNPeDMwoVBeTaWKL5NYFe+o9MKhpNHaDex2M7hN7Kq6n+5sH
 kPIE7mSZ6ml+a2BtOjgwKTuYOwIKEq2Cy4XAe0hJ+jPsQXX98zskflrRWBYdew==
Message-ID: <507f1311-132d-57f1-ed0b-dd3aa3d7695f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692087863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eh9WSqn6cC+SL8X8SqgW+f+ct+enqovFk9iDFicaQGI=;
 b=mVe8l7sfGWRWrua3YX/J5EM46HrW9HjvSd+FXgJ2elp/62B4a1TqwBleB8QclaWkDz34sh
 TAPG3wMvJ9cJG8K9liH1x6LgjX/TUdwTCnVqqcvd6V4lWPT1geeb+XDHCkVe9zNxb6eIjb
 b+ArPhxJJadK6XGfmwPigexnYfb0J+HYWzwXMkf9u2dvKKFcadT7+snR+v+7I6/vQyEBzu
 Zm9kB0mYM7697dv4fHeXF0T+iYohdyIe+kwVA1RS0AsEbE0toyKz6z7dCgorY9Crrzi7Ad
 JCGDHrlSHDhnFHETscTBC9vRAVdCdG9F7pxdbCeaT3OCfWbo/hYNJvEigzWrig==
Date: Tue, 15 Aug 2023 10:24:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 8/8] disk: Make blk_get_ops() internal to blk uclass
Content-Language: en-US
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Michal Suchanek <msuchanek@suse.de>,
 Tobias Waldekranz <tobias@waldekranz.com>
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
 <20230813234648.591083-8-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ2GHvNE0q1-r8VqRJhAPy-EuOsMqkmDq9NPPiDfMBz6wQ@mail.gmail.com>
 <ZNrHSX5atPqd4x/2@octopus>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ZNrHSX5atPqd4x/2@octopus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6c599dfab4fe0cb08e3
X-MBO-RS-META: j95b3r4zmodcbxnzqf1oeqr8fm5zutsq
X-Rspamd-Queue-Id: 4RQ47G0c58z9skl
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

On 8/15/23 02:31, AKASHI Takahiro wrote:
> On Mon, Aug 14, 2023 at 04:42:57PM -0600, Simon Glass wrote:
>> On Sun, 13 Aug 2023 at 17:47, Marek Vasut
>> <marek.vasut+renesas@mailbox.org> wrote:
>>>
>>> Move the macro into blk-uclass.c , since it is only used there.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> ---
>>> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>>> Cc: Bin Meng <bmeng.cn@gmail.com>
>>> Cc: Heinrich Schuchardt <xypron.glplk@gmx.de>
>>> Cc: Joshua Watt <jpewhacker@gmail.com>
>>> Cc: Michal Suchanek <msuchanek@suse.de>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Tobias Waldekranz <tobias@waldekranz.com>
>>> ---
>>>   drivers/block/blk-uclass.c | 2 ++
>>>   include/blk.h              | 2 --
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> Unfortunately this does not stop people using the ops member directly.
>>
>> For this series, I tried a patch myself [1] but I think I stuffed it
>> up. So I will let Takahiro-San figure it out. I would very much like
>> to see this clean-up go in.
> 
> At that time I thought that the necessary change was small and trivial:)
> 
> As for Marek's patch, let me first explain why I implement that way,
> i.e. separating disk_blk_*() from part_disk_*():
> - Initially I tried to implement disk_blk_*() work for both UCLASS_BLOCK
>    and UCLASS_PARTITION, while this idea was rejected by Simon.
> - Then, I implemented part_disk_*() with direct access to the devices,
>    and part_disk_*(), as helper functions, with block caching.

I think the later should not be part_disk_*(), but rather disk_blk_*() ?

>    I thought that this approach was aligned with the implementation of
>    block devices (blk_[read|wirte]).
> 
> If you don't think the second point makes sense, I can agree to Marek's
> approach.

Does it even make sense to have accessors which bypass the block cache ?

-- 
Best regards,
Marek Vasut

