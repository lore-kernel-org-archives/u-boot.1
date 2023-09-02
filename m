Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9CEC83F2C
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 13:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B95BA86433;
	Sat,  2 Sep 2023 15:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="JcP7f1nS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E928643B; Sat,  2 Sep 2023 15:45:20 +0200 (CEST)
Received: from s.wfbtzhsw.outbound-mail.sendgrid.net
 (s.wfbtzhsw.outbound-mail.sendgrid.net [159.183.224.105])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E1A6847C3
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 15:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=qUsPtrRtKKq3ldpBYHh60fLVAZVGOcV7akPQpjj9OIo=;
 b=JcP7f1nSHKWjQN9Jj5EEL9tERaSzEM65P3kMVKsxknGI+K0hEaEUV1xTPWqSN6HY3Y2W
 VvnMMcm0kyz/zDYHFoH6ATCBk4hMhmFwOEzINCOlj27HaIu3TkD4iw3mgo0r0eDAz6I1FP
 JBlx5s8rNt6UErPsqilXljnTpYWjZ5JoMnbrLrNp0jAnWVLFxXpoTXMFjgSdrsoH5uYkml
 ZyXepXhPJkMmryXeEKdtVwDuCk3TxHcJOukZUbdSq9PIHWdHgm997agGf63EF9HFavloDy
 r40Jvu2kVbPfqvFY5fIaODB/ivMY3AHQcA/Y/Kygl+d6Ld8bfOFGT1YON1MQXLQg==
Received: by filterdrecv-d7bbbc8bf-s5hdm with SMTP id
 filterdrecv-d7bbbc8bf-s5hdm-1-64F33C6C-2A
 2023-09-02 13:45:16.356790058 +0000 UTC m=+9900338.293538723
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-canary-0 (SG)
 with ESMTP id yRGK12vnRSmTQtmiaQ-1XQ
 Sat, 02 Sep 2023 13:45:16.007 +0000 (UTC)
Message-ID: <d27f6c83-4b29-25af-9991-574f2e79b8fa@kwiboo.se>
Date: Sat, 02 Sep 2023 13:45:16 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Issue with mmc_power_on() and reference counter of regulator
References: <CAF1eZtvEmjZohyJfa=Jm=Dm76bhkayKk_tzTMM8ooQUQ-OL0CA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAF1eZtvEmjZohyJfa=Jm=Dm76bhkayKk_tzTMM8ooQUQ-OL0CA@mail.gmail.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h5iaH=2Fh1JhP=2FQzowa?=
 =?us-ascii?Q?IrK=2Fa5+nYEK9gvYSwh0AWV3ID2rmRchXV8eeXpK?=
 =?us-ascii?Q?LX+24qSQXHDJoJg1n8HVQk0U59tNLc4U4pkLv8Y?=
 =?us-ascii?Q?wgwKT2xFHnAq5LZYbtcA1GNlo+ty41E6SlQMt=2FT?=
 =?us-ascii?Q?ITMbzy=2FsyGQ4XMMZeyYiIkJsfai2b07QpcJ9P8?=
To: Kenta Sato <tosainu.maple@gmail.com>, u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
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

Hi,

On 2023-09-02 13:35, Kenta Sato wrote:
> Hi,
> 
> I am using the FriendlyElec NanoPi R4S board.
> When I updated U-Boot to a recent version (0fe0395922), it failed to
> boot from MMC. Here is the log:
> 
> ================================
> U-Boot TPL 2023.10-rc3 (Sep 02 2023 - 08:21:08)
> lpddr4_set_rate: change freq to 400MHz 0, 1
> Channel 0: LPDDR4, 400MHz
> BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
> Channel 1: LPDDR4, 400MHz
> BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
> 256B stride
> lpddr4_set_rate: change freq to 800MHz 1, 0
> Trying to boot from BOOTROM
> Returning to boot ROM...
> 
> U-Boot SPL 2023.10-rc3 (Sep 02 2023 - 08:21:08 +0000)
> Trying to boot from MMC1
> spl_load_fit_image: Skip load 'atf-5': image size is 0!
> NOTICE:  BL31: v2.9(release):
> NOTICE:  BL31: Built : 08:19:59, Sep  2 2023
> 
> 
> U-Boot 2023.10-rc3 (Sep 02 2023 - 08:21:08 +0000)
> 
> SoC: Rockchip rk3399
> Reset cause: POR
> Model: FriendlyElec NanoPi R4S
> DRAM:  4 GiB (effective 3.9 GiB)
> PMIC:  RK808
> Core:  264 devices, 23 uclasses, devicetree: separate
> MMC:   mmc@fe320000: 1
> Loading Environment from nowhere... OK
> In:    serial,usbkbd
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> Model: FriendlyElec NanoPi R4S
> Net:
> Error: ethernet@fe300000 address not set.
> No ethernet found.
> 
> Hit any key to stop autoboot:  0
> Error enabling VMMC supply : -114
> Error enabling VMMC supply : -114
> Error enabling VMMC supply : -114
> Error enabling VMMC supply : -114
> Error enabling VMMC supply : -114
> Error enabling VMMC supply : -114
> ================================
> 
> Does anyone know how to fix the issue?
> 
> I looked into commit logs and the mailing list so far, and I found the
> below commit that adds the reference counter to the regulator. I could
> remove the above error by reverting this change. Of course, it should
> not be the proper way.
> Maybe we could replace regulator_set_enable() in mmc_power_on() by
> regulator_set_enable_if_allowed(). However, I have no confidence about
> it as I'm not familiar with the U-Boot source code.

I sent patches to fix such situation back in July, see [1]. Those
patches was merged into next, but should probably have gone into master.

Please try next, and/or apply patches at [1] and report back result.

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=364753&state=*

Regards,
Jonas

> 
> ================================
> commit 4fcba5d556b4224ad65a249801e4c9594d1054e8
> Author: Eugen Hristev <eugen.hristev@collabora.com>
> Date:   Wed Apr 19 16:45:24 2023 +0300
> 
>     regulator: implement basic reference counter
> 
>     Some devices share a regulator supply, when the first one will request
>     regulator disable, the second device will have it's supply cut off before
>     graciously shutting down. Hence there will be timeouts and other failed
>     operations.
>     Implement a reference counter mechanism similar with what is done in
>     Linux, to keep track of enable and disable requests, and only disable the
>     regulator when the last of the consumers has requested shutdown.
> 
>     Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
>     Reviewed-by: Simon Glass <sjg@chromium.org>
>     Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ================================
> 
> Any help would be greatly appreciated.
> Thank you!
> 
> Kenta Sato

