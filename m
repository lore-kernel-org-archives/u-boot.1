Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C12C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 17:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 255E381ECA;
	Fri, 14 Mar 2025 18:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=3mdeb.com header.i=@3mdeb.com header.b="AtZrjQGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1485881DCC; Fri, 14 Mar 2025 16:16:30 +0100 (CET)
Received: from 1.mo560.mail-out.ovh.net (1.mo560.mail-out.ovh.net
 [46.105.63.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC90D81D6C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 16:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michal.iwanicki@3mdeb.com
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.139.172])
 by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4ZDnyM0z0zz1g15
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:16:27 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-blkps (unknown [10.110.164.45])
 by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id DF7D41FEBF
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:16:26 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.109])
 by ghost-submission-5b5ff79f4f-blkps with ESMTPSA
 id kUp3K0pI1GdVDgEAvpYnQw (envelope-from <michal.iwanicki@3mdeb.com>)
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:16:26 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S0034b3534ff-455f-4abc-91d8-593bc28a1b1f,
 A5760D5565C7689DEFC3E27E2DE7AC66CF08A156) smtp.auth=michal.iwanicki@3mdeb.com
X-OVh-ClientIp: 213.192.77.249
Message-ID: <9287d243-5639-488c-884f-d1b81413505a@3mdeb.com>
Date: Fri, 14 Mar 2025 16:16:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Micha=C5=82_Iwanicki?= <michal.iwanicki@3mdeb.com>
Subject: Trying to port sitronix,st7701 panel driver but nothing shows on
 display
To: u-boot@lists.denx.de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5209257394342551209
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfhuffvtgfgsehtkeertddtvdejnecuhfhrohhmpefoihgthhgrlhcukfifrghnihgtkhhiuceomhhitghhrghlrdhifigrnhhitghkihesfehmuggvsgdrtghomheqnecuggftrfgrthhtvghrnhephedvfffhheefgeelgfehkeeukeduvddvudfhudeguddtvdejfeekveffgfevueeunecukfhppeduvdejrddtrddtrddupddvudefrdduledvrdejjedrvdegledpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhhitghhrghlrdhifigrnhhitghkihesfehmuggvsgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheeitdgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=LiYKAeiRw8ogaJN0lMsQQTZ0YE6DuzFZOatrVKyV6mg=; 
 c=relaxed/relaxed; d=3mdeb.com; h=From;
 s=ovhmo3617313-selector1; t=1741965387; v=1;
 b=AtZrjQGpSwl+13wnRw38TzSisWf/H4YnHma/bTfVrKWTuNJa7PKNNf4GKu/G58WZjVw3fucI
 AYQmB+/06qoQF2S+u4XHln8ZzXvUtaOyZv3UYG7MExeFNbj2gpWV6+7ajUGCmZy0L4D1n3cnLF4
 dC6fxzTjUKXgsj5Ne5Mn7+WgZUoU004uoj1Mf7gKLtnmtrfdj4ADw/H1FsG3+7lMwzhAnXWbodJ
 H4SqPdCSFpmVlOI5mpjLQAevRaZwyjry2TDgJ2u3mLJmRUoDi2KVKPkXDwVYt/95MEaeCaB+s8o
 oR0KAzHi/WB1r920BDOlHqZyOPvWnwfg2SE2Nk/kmIbTg==
X-Mailman-Approved-At: Fri, 14 Mar 2025 18:09:42 +0100
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

Hello,

I have a question about porting MIPI DSI panel driver (sitronix,st7701) from Linux to U-Boot (I'm using custom board 
with embedded rk3566 SoM.
I think I'm mostly done, though I had to apply Dang Huynh VOP2 patches (sent to mailing list on Thu Jan 16)
to get anything probed (dw-mipi-dsi-rockchip, dw_mipi_dsi, panel itself).
I don't see any errors in debug output, I made sure that init function in panel driver is called,
'dm tree' shows that required drivers were probed and backlight is on

  video         0  [ + ]   rk3568_vop            |-- vop@fe040000
  vidconsole    0  [ + ]   vidconsole0           |   `-- vop@fe040000.vidconsole0
  video_brid    0  [ + ]   dw-mipi-dsi-rockchip  |-- dsi@fe060000
  dsi_host      0  [ + ]   dw_mipi_dsi           |   |-- dsihost
  panel         0  [ + ]   sitronix_st7701       |   `-- panel@0

but I don't have any output on display (just black screen).
I know that connection is OK as I can send commands e.g. ALLPON (All Pixel ON) to turn all pixels white but I'm kinda 
stuck how to debug why I see nothing on display. Could anyone direct me how can I debug this further?
Could maybe lack of rockchip,rk3568-iommu (vop_mmu node) drivers be a problem? Maybe I need to modify device-tree
related to display to work with U-Boot?

Best regards,
Michał Iwanicki
