Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD43EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE809864C5;
	Wed, 23 Aug 2023 13:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vchbfp46";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eR4ijUL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACFD1864CC; Wed, 23 Aug 2023 13:23:16 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50DA864A1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RW3jt4wSnz9sX2;
 Wed, 23 Aug 2023 13:23:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692789794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkNj99qJHtUMRS4D0NuWtPcmGxCJeO3YSyWwwPm90uw=;
 b=vchbfp46Y6uF12klq/56JCVbWv/bBJOz5qFr3FWyPKUKnuDgprAdFnNvYLwbubD8xlWYp2
 1lyo15ZsCJrQGdJetcUcmiE2Cn4bJGG/CQniZiMfZI48dElfMyfv3T50RSBhEIIs2HXE3d
 UAcZmrovcqusSidj6XMEpFhYoKV58+F0mVx0RgL0CYQSZnzi7E3sEiTrKAKk5JFQpuL7tY
 lw4KUz8s+knLuq07uuJmi7rUb8QUYI8tUWw20Ama1tGo4r0Fqf8zQtkWSXgumxj5o1VMPm
 WpjN/945LH3hZZQpR8VRlQomhnLsd1KgENLVXP2iOokG1KARMsm1Y62SOygFmg==
Message-ID: <8e8e738e-89c2-82cd-8dca-3680bd095a58@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692789792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkNj99qJHtUMRS4D0NuWtPcmGxCJeO3YSyWwwPm90uw=;
 b=eR4ijUL71Ja7Zhzxe5AxbUDOXYCUgwpHc6UDrlxlVjOPVqy8e4koiNsZVSAYjpUkcYWaQu
 FmpRIx+qQfv+FIFNmn5d+4xbe/UCS8AYnMnFN7QFBS3g3EcWHj2/Q1dy/im0kq0eU99OKb
 maL99ni4U73cOv+ujalZWWEYINrZGTM1qukBYCddPxc7/CNvHWud6Ymu79FP2noPScwH8V
 0rs2z16A38EHIeeM1FAh4H9aDXfW5wXDZ983EVkZMv4tFkyoOFihp8eUGpTGiLlrCjuuPD
 ZtqCbx4XFrAre3WHiV5aPE84sAMHeR8Wmbl5MJhAoqd1HRaM+F8irEHOWT2Kqw==
Date: Wed, 23 Aug 2023 13:23:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] serial: sh: Tidy up pre-processor directive
 indentation
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
References: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
 <20230822181025.339748-3-paul.barker.ct@bp.renesas.com>
 <0b3dbe70-c0ae-9b83-1983-520b4c7df41b@mailbox.org>
 <6d463cc3-ec6b-bd5b-b40d-c1dd57be3961@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6d463cc3-ec6b-bd5b-b40d-c1dd57be3961@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qk79e4pi9zyj1qzg3zm4xce1fheitziu
X-MBO-RS-ID: 1a61eb8c1ffadaab0c1
X-Rspamd-Queue-Id: 4RW3jt4wSnz9sX2
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

On 8/23/23 08:33, Paul Barker wrote:
> On 22/08/2023 22:40, Marek Vasut wrote:
>> On 8/22/23 20:10, Paul Barker wrote:
>>> Let's make the indentation of pre-processor macros and conditionals in
>>> serial_sh.h consistent before we add to the confusion with a new SoC.
>>
>> What exactly is this patch doing, adding spaces to ifdeffery ?
>>
>> I would be tempted to say, can we clean up the ifdeffery instead ?
>> It is some hideous mess.
> 
> The header is a mess for sure. I was hoping to make it slightly more
> easy to follow with this patch.
> 
> We can drop this for now if you think it's not a clear improvement. I'll
> see if I can do some more extensive clean up on this header while I'm
> adding the RZ/G2L support.

If you can give that at least a try, that would be much appreciated.
