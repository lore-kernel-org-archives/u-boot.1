Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03119C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 16:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF36582958;
	Fri,  9 May 2025 18:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="lGoTNwdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B80A82905; Fri,  9 May 2025 18:32:42 +0200 (CEST)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A16082162
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 18:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746808357; x=1747067557;
 bh=sy31hWg/+9es7qC44sjXGlQgD9gxM8ZcqvulSRi7WF4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=lGoTNwdgryO8LGeIhEbI2zKRwq14XhtWhQki/X58N6tT1tDItiiIQCOi+gKBzrILp
 T89Kw/Q8g7B8ClLJxpWs+bm1uJruOn+9/G5gaEOTalSs7G5XYCyqjeBtISZnsbRHrA
 JGtTybM9Z6fmC5NfaM8EfSvZzv2Xa5sZKfx3uHTTS07PvMQSD8mModOomLOaGZfluK
 foPPJQ2DQz2/TYYcfqjEEUgwAagRoCq15Ujdu4vBkj6m37Yf/ute7zghgSir39prJL
 OpUyDvPpCUe0LzjBb+F9FfB8krPG+2kfF2tFoNog5xfYA0e2KHzQCHE61U4cCWp1LP
 jgFujNXMEh1nA==
Date: Fri, 09 May 2025 16:32:35 +0000
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 09/10] dts: upstream: arm: st: add STM32H747 discovery
 board
Message-ID: <7747b6f1-279d-4d0a-b039-67781abdfa21@krotti42.com>
In-Reply-To: <8cb35090-e326-499f-9e4b-5d909b19a4d1@cherry.de>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-10-johannes@krotti42.com>
 <8cb35090-e326-499f-9e4b-5d909b19a4d1@cherry.de>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 4eec802f02eb8087dbb204ee64553d76193160f6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Quentin!

On 5/9/25 13:23, Quentin Schulz wrote:
> Hi Johannes,
>=20
> On 5/8/25 11:24 PM, Johannes Krottmayer wrote:
>> Add initial device tree for the STM32H747 discovery board.
>> Copied from the STM32H743 discovery board and modified for
>> the STM32H747 discovery board.
>>
>> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>    dts/upstream/src/arm/st/stm32h747i-disco.dts | 115 ++++++++++++++++++=
+
>=20
> Manual modification of dts/upstream is forbidden.

Didn't know that as independent contributor. But I have suspected this,
according to the README in the directory 'dts'.

> Please use tools/update-subtree.sh pick to cherry-pick commits from
> devicetree-rebasing tree. If your device tree doesn't exist in
> devicetree-rebasing yet, you need to wait for it to appear there or put
> stuff in arch/arm/dts/ instead. I highly recommend to wait to lower
> maintenance burden.

Yes, I will wait for that.

> The kernel seems to have merged that, c.f.
> https://lore.kernel.org/linux-arm-kernel/bf7eddfa-ca7f-49a6-a3f9-574f2c4f=
e972@foss.st.com/.

Good to know. I must admit I don't looked into the last commits from Linux.

> You'll need to wait for it to reach a v6.X-rcY tag before it reaches
> devicetree-rebasing. You may need to cherry-pick more than those patches
> if there are conflicts (or simply if it doesn't work).

The primarily motive to release this patch series was only because I
have must to add the board support, because to test another patch for
the ARMv7-M architecture on real hardware. So I have thought if somebody
helps my patch series so it's okay. If not then it's also okay for me.

Therefore I released it here. :)

> Same remark for patch 10/10.
>=20
> Cheers,
> Quentin

Kind regards,

Johannes

