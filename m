Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A24C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 14:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECD6960674;
	Mon, 24 Aug 2026 14:22:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PH0fQi_gvg2a; Mon, 24 Aug 2026 14:22:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787581341;
	bh=fgndoZZ8cXCx2So38+Ml1gqAx/MMmta5FtitmL07d8o=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IRCCRIMvnsqZbkABuP4bBr5WI9IdT7Kmfr4UBeVCxECfV/llK+LM68q7hwlSqqHNv
	 psIoDLR/+ZDGfNy6Exu8smn3fzLkTwr0eZRIQvIcNz2Y1AkbmgzvyFsyv1hEgU7ll/
	 CkP8LFuKjSII5NYW1HAAq4ZErx18uYh5BcDFeyy/Q0FTd+xrDKC0v4plx+LBItBvxu
	 4E2YuPLu3z8ikdeT3PKlQNDo66dWAiGhPdmXH2kO7G8vGU7rnLT7kwVOi4Ti2huOnp
	 fRE4Lgc64hqIpH+ZgQwBe12CHjKXAgBZy3XVWSnX4o5bmo/KQmUZnWhXyBdULfXZGx
	 c687XVWZyVvkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA99060624;
	Mon, 24 Aug 2026 14:22:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EB872FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 757936060B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QD5FS8yz0omK for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 14:22:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=W6/9XUo8
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCECD605D5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787581297; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YcWVaGL90BXrWO6K0kZ1k5xjnliK1gGFWEPIgCzrASDaRnkG9YA/NTWeK2S+xjqW/iFCfwmY842pUyCH0qNMrVCqAfDGGRSwfstnAOyJU0+Bpz7ziaxtAod4OPQxFcSUayRiuhs2N04IggxsVXKrz3LfD1anNWiTP4/JyuP7mrc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787581297;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fgndoZZ8cXCx2So38+Ml1gqAx/MMmta5FtitmL07d8o=; 
 b=VNJHtxVYWLlS6lT9gXFpcuyRx3zxA8UuNjPE0w/dlOKOp8cvwLMMXFkfBFNN+nn64nimfq+WZktyLoHsYM4Xgsy40Jx+KEf4Z4wPgXGX6xUlay/ECn+oHcWeZr6PKZtOH9X4cqcUCheWCj6AOcO7uZPvTkLe4J0q5eil91U8kK4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787581297; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
 bh=fgndoZZ8cXCx2So38+Ml1gqAx/MMmta5FtitmL07d8o=;
 b=W6/9XUo8CsxL/6jPVbXTBG59n6oGsChIVEVECRiUDUQt0sq8bt1arPF11ORk1d1z
 WPnj3hn/NvpHbgIJw5/FpWeexGKw8iMWzvpRdKbn3PRe+51LmFWstSSn1DTWJmoGhzX
 5smXEdXeP92dSFefAvrBR4SSAIVhk9pSr3fHQ6Mg=
Received: by mx.zohomail.com with SMTPS id 1787581292982886.4757022159525;
 Mon, 24 Aug 2026 07:21:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 22:21:17 +0800
Message-Id: <DKX8OE4FZYCZ.29V2B6GDFTPSY@pigmoral.tech>
Cc: "Huan Zhou" <pericycle.cc@gmail.com>, "Guodong Xu"
 <guodong.xu@oss.qualcomm.com>, "Tom Rini" <trini@konsulko.com>, "Raymond
 Mao" <raymond.mao@riscstar.com>, "Lukasz Majewski" <lukma@denx.de>, "Yixun
 Lan" <dlan@kernel.org>, "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v2 0/4] i2c/clk: spacemit: k1: fix I2C bus configuration
 and clock handling
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Heiko Schocher" <hs@nabladev.com>, "Yao Zi" <me@ziyao.cc>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>, <u-boot-spacemit@groups.io>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <aoQBacTKiBXUDddj@pie> <e4ad1d7a-ad9e-3cb1-e1ed-ad95f22b5b14@nabladev.com>
In-Reply-To: <e4ad1d7a-ad9e-3cb1-e1ed-ad95f22b5b14@nabladev.com>
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Heiko,
Thanks for checking.

On Mon Aug 24, 2026 at 4:21 PM CST, Heiko Schocher wrote:
> Hello Yao Zi, Junhui Liu,
>
> On 18.08.26 08:53, Yao Zi wrote:
>> On Sat, Aug 15, 2026 at 11:40:20AM +0800, Junhui Liu wrote:
>>> Fix two issues in the SpacemiT K1 I2C driver and clock provider.
>>>
>>> The first issue is that the controller bus mode is selected using the
>>> functional clock rate instead of the requested I2C bus speed from the
>>> device tree.
>>>
>>> The second issue is that the TWSI functional clocks incorrectly include
>>> the bus clock enable bit in their gate masks. As a result the I2C drive=
r
>>> can operate with only the functional clock enabled, which diverges from
>>> the device tree description and the Linux driver (both expect separate
>>> "func" and "bus" clocks).
>>>
>>> To fix the second issue without breaking intermediate states, the
>>> patches are ordered as follows:
>>>
>>> - First add the missing bus clocks (and their parent chain) to the SPL
>>>    clock tree.
>>> - Then update the I2C driver to acquire and enable both the functional
>>>    and bus clocks by name.
>>> - Finally remove the bus gate bit from the functional clock definitions
>>>    (except TWSI8, whose write-only register requires the combined gate)=
.
>>=20
>> Personally I think it's okay to break booting in this case as long as
>> you explicitly point it out. Merging the conceptually related PATCH 2
>> and PATCH 4 which together fix description of TWSI controller clocks
>> would make the commit description shorter and clearer. But it depends on
>> you.
>
> For me the series is okay now, if you (Junhui Liu) have not prepared a
> v3 with the merge Yao Zi explained already ... I will pick v2 up for next=
...
>
> Please give me feedback, what you plan, thanks!

I don't plan to send a v3. I think the current structure and patch
ordering in v2 are fine, so please feel free to pick it up.

Thanks to you and Yao Zi for the review.

>
>> For the whole series,
>>=20
>> Reviewed-by: Yao Zi <me@ziyao.cc>
>
> Thanks!
>
> bye,
> Heiko
>>=20
>> Regards,
>> Yao Zi
>>=20

--=20
Best regards,
Junhui Liu
