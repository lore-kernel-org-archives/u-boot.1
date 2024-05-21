Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BBEC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 08:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A057B88477;
	Tue, 21 May 2024 10:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="1vmpr8lg";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="oEB2U7c8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 430F288485; Tue, 21 May 2024 10:20:28 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ADEA87F19
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 3CF441140107;
 Tue, 21 May 2024 04:20:25 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 21 May 2024 04:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716279625;
 x=1716366025; bh=LMIa6oxiPCM+F9sUEUTnddbl2b6MoKRL9XszzWsd0+0=; b=
 1vmpr8lg+wb8FmW4AMjN5MdcbwobmDCdEfwC97JL6MXpWZlSp2aVfyCbgO5fPnwf
 Y9l2GNQ3GvEZQOv5UIqlWUamBovsP7qzRFJXuybu6e8rtJsT9QztZZp/aaYxogFe
 ijC/G+vJUuYED6DuQcyVb6vEOfmEnk+9UYV7Ekzd9o2yJVa99vjhmHkfW3u0Cg/+
 6A5gmw8UiSybq0dhLsx7jkJHKYZGgoxf5mgH9tdJAh4Dm2+QTdSk1fuOrw3q7efr
 pmj0TJBIUhgvXzFB67gVB7thihmOXHtXcc2sI9uw8qz/8DqDcm3HlOyhQWsn4+cI
 Jt+Nrd4YkuRTTfSfK79vUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716279625; x=
 1716366025; bh=LMIa6oxiPCM+F9sUEUTnddbl2b6MoKRL9XszzWsd0+0=; b=o
 EB2U7c8FFpT81Rd9+hW83dm+Yrgj3A7sKN8gnOAm9BHYRNrmAwtzTO+MoMke0L4v
 KQGYT+6hOpAat+mBKS//BGd/rhnArQmetYB/WjohYyAbhvmoplAgHUs0CJsHvAOD
 jm5TGx723AsX35W7M9VcM/0dOx2iXs1a8J72Gpn6U833LI0aZoc6epxlHfKe1lKP
 Iy3HXsAJyOuhutUhXbuvCN3Qtk0o+MhuvIb4XRX0hk7hUGFU0fJ/hSrFXfzNcfO0
 JbY+Jp1D3qtTJx2ThjIS+t41tp5y7tOO8PTPkvp/aDJQTxfbiBag6j/yf6UhW4eX
 ymY1h7/+NW5/ZQMqn2i8w==
X-ME-Sender: <xms:SVlMZgJLjzdr6tM9fVqrcQEgNQoyNufxAzkHRCID2KKEX5wiAv0fZA>
 <xme:SVlMZgLYNI-Gv0M0GseMcxIMjj2dR_b4FnHHm-Sa9v-GcwHBsryNXG0sJACCC_oMX
 T0Wdyg15jOLDeHNXq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeivddgtddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:SVlMZgsdykgBAnNVpfDi5a778Sh5Dw6S8AsooC_zAwGbaPWDAgTRCQ>
 <xmx:SVlMZtarLSlKXX54w-GvWNvSUT040ejvHOOfJQDmeAhvx5KA3h4mJg>
 <xmx:SVlMZnYyYMpHHlU-YrU63-o3futCq_HMqL2IEO0Kzkh5H8ZcHLvEcQ>
 <xmx:SVlMZpAc-vGnoI8SAs2gOoPU4uv9Nur6yvSQNKTQODuCsBZtcnDV8w>
 <xmx:SVlMZmXussD6z-kUG_Mpm9D7IXB6BZkX2yx1as-eMMxVzp8Fe3g4TEmX>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id EC31536A0074; Tue, 21 May 2024 04:20:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <2f58b7b9-fc0d-4bb2-bb34-cacc62cbefce@app.fastmail.com>
In-Reply-To: <CAMo8BfJXXozimNR8s2w+Fx8DZjMxT=t-039M+EKX9Ysb+-kwYw@mail.gmail.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-9-8fff0cb11c19@flygoat.com>
 <CAMo8BfJXXozimNR8s2w+Fx8DZjMxT=t-039M+EKX9Ysb+-kwYw@mail.gmail.com>
Date: Tue, 21 May 2024 09:20:05 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Max Filippov" <jcmvbkbc@gmail.com>
Cc: u-boot@lists.denx.de, "Sean Anderson" <sean.anderson@seco.com>,
 "Tom Rini" <trini@konsulko.com>, "Sumit Garg" <sumit.garg@linaro.org>
Subject: Re: [PATCH 09/10] board: emulation: New board qemu-xtensa
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8821=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=888:35=EF=BC=8CMax Filippov=E5=86=99=E9=81=93=EF=BC=9A
[...]
>> +++ b/board/emulation/qemu-xtensa/MAINTAINERS
>> @@ -0,0 +1,7 @@
>> +QEMU XTENSA 'VIRT' BOARD
>> +M:     Jiaxun Yang <jiaxun.yang@flygoat.com>
>> +S:     Maintained
>> +F:     board/emulation/qemu-xtensa/
>> +F:     board/emulation/common/
>> +F:     include/configs/qemu-riscv.h
>
> This must be qemu-xtensa.h, right?

Ah yes :-)

Do you mind me to give you a M: entry?
I'm pretty dumb to Xtensa stuff so it deserves an M from people
know Xtensa better.

[...]
>
> I'm not sure what CFG_SYS_IO_BASE means for the virt machine, but
> it looks like in the noMMU case SDRAM is going to overlap the
> IO range with the above base addresses and sizes. And from QEMU
> monitor I see the following address space distribution in the virt
> machine with a noMMU core:

So CFG_SYS_IO_BASE means physical address left for I/O with 1:1 mapping
from virtual address. for PTP MMU I handled it in:

[PATCH 03/10] xtensa: Implement phys virt conversion for PTP_MMU

Can you confirm if noMMU core is doing the same on VA-PA mapping?

If so, that patch needs to be expanded to include noMMU as well.

Thanks
- Jiaxun

>
> address-space: memory
>  0000000000000000-ffffffffffffffff (prio 0, i/o): system
>    000000003ffe0000-000000003fffffff (prio 0, ram): xtensa.dataram0
>    0000000040000000-000000004001ffff (prio 0, ram): xtensa.instram0
>    0000000050000000-0000000053ffffff (prio 0, ram): xtensa.sysrom0
>    0000000060000000-00000000dfffffff (prio 0, ram): xtensa.sysram0
>    00000000f0000000-00000000f000ffff (prio 0, i/o): alias pcie-pio
> @gpex_ioport_window 0000000000000000-000000000000ffff
>    00000000f0100000-00000000f3ffffff (prio 0, i/o): alias pcie-ecam
> @pcie-mmcfg-mmio 0000000000000000-0000000003efffff
>    00000000f4000000-00000000fbffffff (prio 0, i/o): alias pcie-mmio
> @gpex_mmio_window 00000000f4000000-00000000fbffffff
>
> i.e. there's no IO at the address 0x90000000.
>
> --=20
> Thanks.
> -- Max

--=20
- Jiaxun
