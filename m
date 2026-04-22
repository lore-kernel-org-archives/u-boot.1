Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122D3F94CBC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 460828412A;
	Wed, 22 Apr 2026 03:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KijCAcfk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="H8dMfGJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7971583FFA; Wed, 22 Apr 2026 03:46:28 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A353C83936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g0hsG334Mz9tgL;
 Wed, 22 Apr 2026 03:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776822386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZ+4o81aV/zvRQm9j4NB6u8TSyniFZJyHcO1Ex2kGYI=;
 b=KijCAcfkENyVm+2A8HHpmqWj0gAvhUlJv77fFlP6XtMDPqWpsQnKxFNEz3GlPBNUwsIrA1
 0TwiVLkVbC+H/w1nnuZJLqF9Pm8A+3eOFW1Xxr4jtkLQ1zi2ncVnmDs/gOVObcM3FRoIub
 wn4ZSscrVUB2ard88Oq03WyAsS3KUG+8CKi0gj2jUPCgcB7szM9Z7Dhno+EB6LzmGD6acO
 1CKPqyTpHxKSvsEFFKrGOHEDV35j2uPbfQ0QYjDsjASgoiSLjYkpZa2fWgvOHoNMBlwnfO
 vx/JFtk+GCW4xPNuI6bPgnKA1ldn5WhFaApP8wzAv0v+AKht3s4/gfahwCJIeQ==
Message-ID: <41c9c73f-63ac-4ddf-98f4-d2762e94f0c8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776822385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZ+4o81aV/zvRQm9j4NB6u8TSyniFZJyHcO1Ex2kGYI=;
 b=H8dMfGJ9t/UFPD4xlwNU4jxeZX6SU9PBrEu4Uw+gMb5HdPEPcN8fM59jPFfg7XyXi+Otvm
 ZfvIeJKkOJmRiwoS+fCEuMaIaX9vCsSLh12a4VsDjAh7pcXn5aR3Yq+VW+gNR48mCZ81gx
 oPcnOYUQjmQEMqLl4Ro+lKPNexuC7KCIJ1Xz8DtbE7Xs2B/zgO7OlukFCCLqrvWVuoRQ9I
 R8BF3wjQu3ivn7+LpkPwxJoJc8luMi8gdSC1Z6b3JygEXoYqBkvot2OWToZJOHN4poEhaP
 +XIByfybfh6/4hiqvycMpaT8t8O/ycaIjzftCFTHydWuWf5RBwUU8vq2u913kA==
Date: Wed, 22 Apr 2026 03:16:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: renesas: add support for RZ/G2L SoC
To: Michele Bisogno <micbis.openwrt@gmail.com>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org, paul@pbarker.dev,
 jh80.chung@samsung.com, peng.fan@nxp.com, lukma@denx.de,
 mkorpershoek@kernel.org, trini@konsulko.com
References: <20260415172113.273702-1-micbis.openwrt@gmail.com>
 <aaa1648f-7aa0-4a76-b21f-3566bf40f528@mailbox.org>
 <CAP8xZ6mEb8A8epx+j_f=NS80hdOD7MvzzuUHDb3R70WgXioBjw@mail.gmail.com>
 <5aaaf387-f48b-4fe0-8461-7c3f05e27fe2@mailbox.org>
 <CAP8xZ6n3=ryYZF7hmx1-m-CHneAt9eyKwKy0qWRzLNCpF+mwRA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAP8xZ6n3=ryYZF7hmx1-m-CHneAt9eyKwKy0qWRzLNCpF+mwRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: gznszw7ardmk9mitxd59xxotdieyuu7w
X-MBO-RS-ID: 48db31876a797ca9372
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

On 4/21/26 9:32 AM, Michele Bisogno wrote:

Hello Michele,

> thank you for your comments and suggestions.
> 
>> If Linux also contains the PIO code, it would also benefit from matching
>> improvement, right ?
> 
> Yes, though I have found the fix is not strictly required. We can maintain
> synchronization between both repositories by utilizing the cfifo_byte_addr
> parameter for the RZ/G2L and similar devices, allowing us to leave the
> existing PIO code untouched.
> 
>> This should be a separate bugfix patch.
> 
> Agreed.
> 
>> Ideally, let's try to keep the Linux and U-Boot driver code base
>> synchronized as much as possible.
> 
> Understood. I am currently preparing a revised patch set that aligns with
> this approach to ensure consistency between the codebases.
Thank you !
