Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010131073CB6
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 13:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 495AE84118;
	Wed,  8 Apr 2026 15:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="zybm1ysF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8ABA84120; Wed,  8 Apr 2026 15:26:23 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E8B284106
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 15:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1775654780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=llwqSqEU+O6NlHstTY9vQBgELNX17XdljNuRvm+yQcI=;
 b=zybm1ysFzDyn3pidbpCTU3O4XtPFwZ0u/4f7E5XtoVRuS5o5nSIUJvddF17zt1aGzf4LJV
 BtX0MLYyuvEvB+ycPVfcz2AQLkTrZwKIdqte95fZHCbGhStSxtKXQTW4SpIKJ0Ct4AN2r8
 7cBPrZF57+YhULjjC2y4L6uA/0NtW98=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 6cdba40e
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 8 Apr 2026 13:26:20 +0000 (UTC)
Message-ID: <3c748627-9273-4ab2-9d13-56869dcf613b@kernel-space.org>
Date: Wed, 8 Apr 2026 15:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] m68k: Fix writew(), writel(), readw(), readl()
 endianness
To: Daniel Palmer <daniel@thingy.jp>
Cc: visitorckw@gmail.com, bmeng.cn@gmail.com, u-boot@lists.denx.de
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-3-daniel@thingy.jp>
 <c300ac4f-f38a-4a0d-bed9-65588b3308d8@kernel-space.org>
 <CAFr9PXk-fJ_kbqd08LHtCdNfid=MVAr8yEj25o_yJghh7qRB=A@mail.gmail.com>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <CAFr9PXk-fJ_kbqd08LHtCdNfid=MVAr8yEj25o_yJghh7qRB=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Daniel,

On 4/8/26 14:49, Daniel Palmer wrote:
> Hi Angelo.
> 
> On Wed, 8 Apr 2026 at 21:12, Angelo Dureghello <angelo@kernel-space.org> wrote:
>> mmm, "currently broken" ?
>> If you remove bigendian read/write the driver framework will fail
>> to work with coldfire/m68k stuff.
> 
> I'm not sure who/what decided this but in Linux at least these are
> meant to be read little endian and convert to cpu endian.
> Classic m68k in linux works like that. Coldfire in Linux is currently
> the same as u-boot on internal registers and but everything else has
> the "correct" behaviour. I think that is so PCI can work.
> 
>> I tested the patchset over master in stmark2 board, seems this patch is
>> breaking dspi cs init:
> 
> Thank you for checking and sorry for the breakage.
> 
no problem.

>> Please find a different solution, that may be using "xxx_le" stuff directly
>> from your code.
> 
> mmm so I did try that for nommu classic m68k in Linux because it's
> also "broken" there and got told to fix readl() etc.
> 
> Would putting this in some #ifdefs so coldfire keeps the current
> behaviour and classic m68k matches Linux be acceptable?
> 

yes, thanks, please try to find a solution protecting coldfire for now.

I will try to understand better why Linux operates differently from u-boot,
i think pci was involved here but actually i don't remember, need to 
study this deeper.


> Thanks,
> 
> Daniel

Regards,
-- Angelo

