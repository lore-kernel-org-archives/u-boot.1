Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86BEC83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 16:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E2B78303B;
	Tue, 15 Jul 2025 18:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wAiGA0ur";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CYhh96HT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81CE183071; Tue, 15 Jul 2025 18:02:27 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5921982E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 18:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bhP8d0H35z9tCJ;
 Tue, 15 Jul 2025 18:02:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1752595345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkAXNv9ww3xHSJL6fsmeaUR4qRwCLBKROXeu7GQFGs4=;
 b=wAiGA0urjuqHGoft4hmH8HTVO9/rhXkY+P7P+5h1DfxfVZGe8Xu1PyBv0qq10d0fRMcrgM
 rVP3q7nNq0nlfk6P929La88iflLyLCjX0ouWSiDc4aLndNId29tHD0jDNb+Vte6Z8vxwFP
 D6qCpeuxN7rAI7ALCGNOYrvOQVhSqZfKWM0ESRggfOy9neisXZ5G8/XydTarwqwjDb0vph
 8yk4QOzoe4WIO5VuIsGj/w6U0k9SVTR4XoJHtvVwuNjY8qzhI/bOvadsrb2Il+Itw0uIs9
 LCNJE0n49naQ7FrwRiAIakD0kDLTTacp/AJ69HyuAoSWoOZXHlzS6k060y4PhQ==
Message-ID: <cbf3d5e0-3634-49f6-bf5e-157b20ae8e89@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1752595342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkAXNv9ww3xHSJL6fsmeaUR4qRwCLBKROXeu7GQFGs4=;
 b=CYhh96HTh+wdG+HHRbdeTA4ByU03y0+XPaKAI4p900GrJUaiyysfUVmuWFnjfvkBDLZd53
 SgJdhX7+SMLIQcDcJp5EKMiVrjK1/CSBIEO3+0gOvUaZDBOM+4hwQdT+SUzFuTTOMp2SFI
 xpdW24p5mYnuqjbXvOfMH90bFxsBYV61iFIqqct9z+Ju9YPYd3yt76UD5HojlmxHkiwpuM
 g/wjn8UQPJVCpckoFSPwwhyWZvEwMn1KBnjGRryuo+rNa0UotNcf7cY7HtX8f2TNaRR8XK
 6dbfcYZPgKEE8QptkOHXPEXj0U+ZpqHwysI28/Fz1aoSf1Hd+bpomR1YU6OJ7Q==
Date: Tue, 15 Jul 2025 18:02:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] configs: renesas: Set CONFIG_TEXT_BASE to 0x0 for R-Car
 Gen3 PIE builds
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Biju Das <biju.das.jz@bp.renesas.com>, Adam Ford <aford173@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Chris Paterson <chris.paterson2@renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250715111103.1092458-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250715143151.GE193579@bill-the-cat>
 <CA+V-a8u4hOPNijmqO4P=yvPoyOjxApiEeT4kNJ4mBt-vY55A_A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CA+V-a8u4hOPNijmqO4P=yvPoyOjxApiEeT4kNJ4mBt-vY55A_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qc8fpnc4rfrj4mq71tfxnn16fgiyb973
X-MBO-RS-ID: 5d173a4b1551a353303
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

On 7/15/25 4:49 PM, Lad, Prabhakar wrote:
> Hi Tom,
> 
> On Tue, Jul 15, 2025 at 3:31 PM Tom Rini <trini@konsulko.com> wrote:
>>
>> On Tue, Jul 15, 2025 at 12:11:03PM +0100, Prabhakar wrote:
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> For Renesas R-Car Gen3 platforms with CONFIG_POSITION_INDEPENDENT enabled,
>>> override CONFIG_TEXT_BASE to 0x0 in each defconfig. The top-level Makefile
>>> already compensates for our PIE builds by appending:
>>>
>>>      OBJCOPYFLAGS_u-boot-elf.srec += --change-addresses=0x50000000
>>>
>>> so that the flash_writer and legacy recovery tools still see an SREC load
>>> address of 0x5000_0000. This change prevents the "Program over size Error"
>>> reported by flash_writer when programming PIE U-Boot on these platforms.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>   configs/hihope_rzg2_defconfig    | 2 +-
>>>   configs/r8a77970_eagle_defconfig | 2 +-
>>>   configs/r8a77970_v3msk_defconfig | 2 +-
>>>   configs/r8a77990_ebisu_defconfig | 2 +-
>>>   configs/r8a77995_draak_defconfig | 2 +-
>>>   configs/rzg2_beacon_defconfig    | 2 +-
>>>   configs/silinux_ek874_defconfig  | 2 +-
>>>   7 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
>>> index f5bb28cb0c7..931183cc34b 100644
>>> --- a/configs/hihope_rzg2_defconfig
>>> +++ b/configs/hihope_rzg2_defconfig
>>> @@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=y
>>>   CONFIG_RCAR_GEN3=y
>>>   CONFIG_COUNTER_FREQUENCY=16666666
>>>   CONFIG_ARCH_CPU_INIT=y
>>> -CONFIG_TEXT_BASE=0x50000000
>>> +CONFIG_TEXT_BASE=0x0
>>>   CONFIG_ENV_SIZE=0x20000
>>>   CONFIG_ENV_OFFSET=0xFFFE0000
>>>   CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-hihope-rzg2m-ex"
>>
>> With POSITION_INDEPENDENT=y the default is 0x0, so on the next resync
>> these lines will be removed. Please just remove the lines setting them
>> to 0x50000000, thanks.
>>
> I see thank you. Let's drop this patch.
Send a V2 please.
