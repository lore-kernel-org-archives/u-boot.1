Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124D606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zaPUYAwv;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=AZ2fPZDJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A3F9811B1;
	Thu,  5 Nov 2026 20:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d__Huv3jmqrC; Thu,  5 Nov 2026 20:04:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AEC28810BE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793909045;
	b=ht0nI0EidJ7op2bLJZ9Xc6qstOL0NFR4t2EJdGIBwpe5/xzCN1ahxEo+HklDJ6kIafY0
	 GzE1c6TgB5we8LJ/qp0RiPfZ7LVjvFRqINkmVQqI0g5uhvNK1xQJjPoteabPZXdbhtIaV
	 mhJpOrvYiOldU1q8jCM/ggAaadxkjRLrkAvBKnB3TrYroL39ocCPukSfZnAxjNYyAESSV
	 MrJh8XVeuWAeCqqsW00I6sl9zYd7IE+K+ZRCsd7FtOwzazf2lUbzClEs4JzMUGaw1bM8x
	 cfU7FE9/QKb3ERiliiMf6ErtG1fa6ivuzspPDccuEPKmoFOoJjDzzP1p91ECR7a3tHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793909045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9Yuao6u5b3a9VZNlsc9T3Ei0QHbyGqqiicoPMzMMwf8=;
	b=gaUYXRwq1np1Ks/ZJcNHUgb0Z5AmGd4a/tN27rEqRrxXz40roTW9tMT91UVihdtGinqb
	 1JJOLKpUFgIY8XXonqFo9G8jssVm9SOZA/JXVpjQvrTagMMISSUv4JGtIhxNlBM8FjJ9B
	 kODebkNLqv/xmkAI+rc6e0dQoWVmzDFcB3EYWEvLya3n4iJ2hkGOfWsqiBEMVzuAyrNCa
	 A3J8zJggJ8MrFIB4ZVA7UFgBJxpFmIcimJ2qAO36j0Bvl2obx2ZQRpXOohgA9oJc8GQHI
	 Wn3bhxO+S9Yu6SotA8RUyfBLBSX8rKABEUBAolX6JLPWmMu1NeU+V4I5TvDvJKk2qqw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793909045;
	bh=9Yuao6u5b3a9VZNlsc9T3Ei0QHbyGqqiicoPMzMMwf8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zaPUYAwvjLLlSNuRBkqXW3QUJWf/0BsNHcQhYB0ql+/ewMh1VE/3a5g7f6B8Mnv7Y
	 rM04oGYT1hQV5pa8SI42r6X3Fu48DSvq9or7KIwfe3iA7sdZ4Zsy8s2mUruQSfKRyT
	 VV5ZAq48RZyCGH6Frt72bHypXb4UgewvQ5OtYgovvFnEj4pYLmg6TBajzw25Myj0mA
	 fTFl5UaRtXK+NB1jDGuqP6boDZpDw0gMBDouYRLTjEesHGmXya5YBf0X73mHO2aHeM
	 knyX449vFOOw50YZAE32fvw+cTg4gRnshdaTvLH8+rI7M6Adp16fbZpajwvJh/tHsh
	 2x08YaCf5Zunw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEC28810BE;
	Thu,  5 Nov 2026 20:04:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C64CDB7E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 20:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC32C400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 20:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2NZnSdeCFXn for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 20:04:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D370540012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=AZ2fPZDJ
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D370540012
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 20:04:01 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jLCth6Fq9zMkvn;
 Thu, 05 Nov 2026 21:03:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793909036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Yuao6u5b3a9VZNlsc9T3Ei0QHbyGqqiicoPMzMMwf8=;
 b=AZ2fPZDJ+Kk0uK0lr44xht6K214nBdmw2bb3LOkJuhpiLspxwmfPGZ8npT5nVpANVpI0AL
 EpteausnOhvBJY00AWKPrhGDPnLS5Po6uf7mezxdQHQrXkSHfERKDrK2Iba//49pgLVBSH
 KmZM686U4/H3tchoYKczS1C2U5mgCMPEE14vTFnXQEqbvJ0L7lutqDDaMLQySrwk9cQurG
 XXdbqFKOO1wv4jLQn6Oo8Nl4wmZ1TWasEGDFTvg3iBsqqAPlugKIvixiKV48nW1iiF6CTQ
 D3F4Qx8Lc7/OqK4G+mau1M8zywMRWFw9AdO32AyUhQA5W+U92khuhlBctwcuEA==
Message-ID: <05e08b26-3dcb-4491-bdbb-77c6fcd5e847@mailbox.org>
Date: Thu, 5 Nov 2026 21:03:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
To: Tom Rini <trini@konsulko.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
 <CAC928HbGeoLQuHjiDN+qBU7A=wLa=EgM7xQMppv9LvFh5kV_xg@mail.gmail.com>
 <e6f06550-772f-426f-8b43-da13b58b0202@mailbox.org>
 <20261105194153.GP1164024@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261105194153.GP1164024@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3ee3f81b9a6b8147cf4
X-MBO-RS-META: 5z8iscajs1woyhsdngakhepmbwpuwzpf
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 8:41 PM, Tom Rini wrote:
> On Thu, Nov 05, 2026 at 08:10:26PM +0100, Marek Vasut wrote:
>> On 11/5/26 7:51 PM, Massimo Pegorer wrote:
>>> Hi,
>>>
>>> Il giorno gio 5 nov 2026 alle ore 15:42 Tom Rini <trini@konsulko.com>
>>> ha scritto:
>>>>
>>>> On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
>>>>> On 11/4/26 3:29 PM, Tom Rini wrote:
>>>>>> On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
>>>>>>
>>>>>>> Add conditional around REMOTEPROC menu entries, turn REMOTEPROC into
>>>>>>> configurable boolean, and update all defconfigs and Kconfigs which
>>>>>>> previously only selected REMOTEPROC driver to also select REMOTEPROC
>>>>>>> itself.
>>>>>>>
>>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>>> ---
>>>>>>> Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>>>>>>> Cc: MD Danish Anwar <danishanwar@ti.com>
>>>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>>>> Cc: u-boot@lists.u-boot-project.org
>>>>>>
>>>>>> Unfortunately this misses some handful of at least TI K3 platforms. I
>>>>>> think using qconfig.py to confirm which configs have REMOTEPROC set
>>>>>> before / after, and that they match would make sorting that part of the
>>>>>> problem out easier. Do you have time to do that, or should I pick it up
>>>>>> and do a v2? Thanks.
>>>>> I can respin this, but do you know which platforms got missed ?
>>>>
>>>> I lost the list, sorry. It was a number of the r5 builds. Perhaps some
>>>> fragment got missed? But qconfig.py -f REMOTEPROC, with a db built with
>>>> and without the patch will quickly show which oens it is.
>>>
>>> This is the result of comparing the two qoconfig.py outputs:
>>
>> u-boot$ git log --oneline HEAD~4..
>> 1e29311663e (HEAD -> master) Revert "remoteproc: Hide REMOTEPROC options in
>> REMOTEPROC conditional"
>> 97162e533ca remoteproc: Hide REMOTEPROC options in REMOTEPROC conditional
>> df3b8e16e6d remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC
>> d1d45c926a5 (origin/main) Merge branch 'main' of
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv
> 
> Wait, your new patch didn't just replace the old patch?
Nope, it is two patches now, simple clean up one, and more extensive 
change one.
