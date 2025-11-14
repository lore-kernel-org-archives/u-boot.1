Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06994CE7B01
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C1F1838CE;
	Fri, 14 Nov 2025 13:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="I6QXvwQs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="boqPyflk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CEEF83E3A; Fri, 14 Nov 2025 13:44:09 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 782018382A
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d7GzW1vf1z9t9t;
 Fri, 14 Nov 2025 13:44:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763124247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukK2hDRgRc7wZK+0A40Uh4QZmVfN+HEn1mgFwN79Z+k=;
 b=I6QXvwQsy1p+vI2gZE/ovYnttRaPmsOZihb7NUxD0jR8TuirE9MB3RwmcXdHcZCCljguby
 yrh2eAxTDqVlGCVXLob0yBLgs88SfG8a4aBEINZ0Pe9/ezB/f3IoJqEn/0PbI/KAxVIhcF
 GZq5eg1umQAoKqKol+wmBRgzjS6RbFRidGVFZyz/sbPYQOCMFzCJrSQ9FGokfa8/pFTI8+
 rJoAtv0oNP1ZIwdy9cVmp1qNwkZ46jsjdi6ZKgNMT0udPDYQYTd74XcTIvlXnWOarx5p+s
 KW32ycGaKDYH+eglVO8EYNoh3VAVBbqONGB6mEPCIdWPMJnGNtJG/iXc/V5YKw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=boqPyflk;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <a765190e-117c-4abd-9296-9a5792d32174@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763124245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukK2hDRgRc7wZK+0A40Uh4QZmVfN+HEn1mgFwN79Z+k=;
 b=boqPyflkGenlJi5cglOX4HBwmct1TNyvfwPrpRo0PCJv7CBu+rZSeDGi2bgND5wbJlaPQq
 GZj4B6GLcPCJzek1uPpMLJbyMSU1uLCFSYTJSPeaqPQNqNHS0C4f7ES5bsfWqu6Gg8e5/Y
 GcAxNpJlE+0dYT0X4gkcWo35uRcnT+eV9sCZ+Y6EVHV06bPJKkWXMsJ82G3X6mq5adlRor
 3jKhNFl9a5TxVfsmfGw8+erqQ24hjkK9Ht4Qz12zo5dhOKaqEjQ6KUBkVmkhT3y41b0s2l
 ZZang8BIpNH6L1DdcJW1SK46aZ6uM84F84EANjQ1P6DQB1Az9iSRJDfHPo8veA==
Date: Fri, 14 Nov 2025 13:44:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] board: tbs2910: Disable EFI partition, MP, sysboot, bind
 commands
To: Soeren Moch <smoch@web.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>
References: <20251113151858.1072774-1-marek.vasut+renesas@mailbox.org>
 <4298f3c8-5aa6-49d7-a8c8-693590dbdc32@web.de>
 <8d5f1351-5ab7-4650-a84c-d8991acc3cf4@mailbox.org>
 <36f11b16-2389-4636-9cfb-c8d05cf81b7e@web.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <36f11b16-2389-4636-9cfb-c8d05cf81b7e@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 91856c44644d0ad06cc
X-MBO-RS-META: to3gjebusiocc15qarfpfwyp6qh7ypqp
X-Rspamd-Queue-Id: 4d7GzW1vf1z9t9t
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

On 11/14/25 11:57 AM, Soeren Moch wrote:
> On 14.11.25 11:36, Marek Vasut wrote:
>> On 11/14/25 10:53 AM, Sören Moch wrote:
>>> On 13.11.25 16:18, Marek Vasut wrote:
>>>> This board is just short of overflowing the size limit, disable
>>>> support for EFI partition since EFI support is already disabled,
>>>> and disable a couple of commands which are also likely unused to
>>>> keep the board below limit.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> Thanks for finding additional useful options to reduce code size!
>> More like use-less options, 
> If you want to make this distinction, fine with me.
> This just should read: Thanks for you efforts to improve the defconfig 
> towards reduced code size, which indeed is very critical for this board.

I know, no worries :)

>> but can you please at least try whether the machine still boots and 
>> check whether those options are really not used on this system ?
>>
>> Thank you !
> Do you really think I (as board maintainer) would Ack this patch when I 
> wouldn't find the changes reasonable!?
> And of course I also tested this (on top of v2025.10) and the board 
> still boots.
Nice ! Thank you.
