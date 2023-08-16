Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5266DC27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 11:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E8686A93;
	Thu, 17 Aug 2023 13:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.b="R664iSmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55628869BF; Wed, 16 Aug 2023 19:15:35 +0200 (CEST)
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 213CB861C5
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 19:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=corbet@lwn.net
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id BD3686A2;
 Wed, 16 Aug 2023 17:15:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BD3686A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1692206129; bh=3p6PL7iQKwt5XtOG7NlyIqxWzZzpH1yyc7VZIgjwdwg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=R664iSmyRF3u3fM03iiYGwcyF/W73HqmdBaPM6/Wz9EVyDycJH0o2LVcqZ/hk3UjS
 FlO/5QjGwtWln6NZbgJtVInHXSM6NSaiDnF3NCPiyHcWVAjtgdPd5ovAzesOUHMAvn
 b+1WFtbdYyAeSassfMWw6gz3GKRcNOlrbSZD7QfOna7Ah0zeDWiXmKqGOIceVo/ESh
 1SyKC4r0Wur8pHJ69mDbNMdaBIeSrzVeohmdaiQWJShpXsd3WRAzGLePz8xv7dBeJM
 /wJe96UAePsCj7wTmGOILzdqFkE4RnaMStUI+gDLMEn2B/fSfaCutejrpyNX2AJckl
 F4toHRXahVz5g==
From: Jonathan Corbet <corbet@lwn.net>
To: Simon Glass <sjg@chromium.org>, linux-doc@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Doc style for method functions
In-Reply-To: <CAPnjgZ0vPwd9v+V8Pg5Bo87OELD-vokB7ZrvU3Bv5dQ_O9z6Sg@mail.gmail.com>
References: <CAPnjgZ0vPwd9v+V8Pg5Bo87OELD-vokB7ZrvU3Bv5dQ_O9z6Sg@mail.gmail.com>
Date: Wed, 16 Aug 2023 11:15:28 -0600
Message-ID: <877cpusybz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 17 Aug 2023 13:58:44 +0200
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

Simon Glass <sjg@chromium.org> writes:

> Hi Jonathan,
>
> I would like to do something like this:
>
> struct part_driver {
>    /**
>     * get_info() - Get information about a partition
>
>               ^ causes error
>
>     *
>     * @desc: Block device descriptor
>     * @part: Partition number (1 = first)
>     * @info: Returns partition information
>     */
>    int (*get_info)(struct blk_desc *desc, int part, struct
> disk_partition *info);
> ...
> };
>
> But this gives:
>
> scripts/kernel-doc:292:
>    print STDERR "Incorrect use of kernel-doc format: $_";
>
> Without the brackets on get_info() it works OK. What is the purpose of
> that check, please?

That's how the kerneldoc syntax was defined, well before my time as the
maintainer.  This could be relaxed, I guess, but one would have to look
at the parsing code to be sure that the right thing happens all the way
through the process.  I'm not entirely sure it's worth it...

Thanks,

jon
