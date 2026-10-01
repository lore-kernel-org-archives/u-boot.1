Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D7ECA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 09:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 373D160C2C;
	Thu,  1 Oct 2026 09:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mdoDknm6Rs2H; Thu,  1 Oct 2026 09:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 96EF560C1C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790846337;
	b=gQnDAhQMvjGf7LZSg9XE8RvPeFMGTdprWz0wXdcbIFM/WxWg/c5C71cBQG85hfU/SCU2
	 zQMS7/KwTkbXiqPTV/sjKafZpznJOQ4bKHMFXCQhc/ElPJMMJ6jOxPY7frPIMy5+NWJSV
	 bkBAYqA3K+Oep0RAaW+4RklGvZKQBTWrY5LklOBRE7HnVuK3hwlyZ/6I12JkYT1hHD6jy
	 5EGuFcted1+m9pEMp8VfKRziZGiMhyzS9DY8V07x/BQen7FK3jozYWEaeI4makJm3vpCb
	 05sQtv/jIPH9bw4K/z8iRP3RxQYtbP7uzaOsBVrDbm6ZDDNyovYc8EiuK94YHCLF7gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790846337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XFKoyC6RHVTBZuZstkIMnamnDS5LKaUyCMP+Y9WVN1Q=;
	b=h+KzoigH4qR6iQNrVJE4EIV5lg60ka/ucPyGWEE7vzIRmPPsxWsGRVKRQ53qalS/6rTw
	 UtlGBMl6XvaZd7hQGNbAm4itU++7bJfw/sjHbN5Yjmo+uwq74Z43WJOf9hp/Mkq0Qr93/
	 /2zNVY/tkQoGCNA0lT4MLbUGU8fbXpMOx1JMQROVFJQBpbcP2WWwRpT734pbygOKZVnhP
	 okk9YwLCaP3d3nyCcT2l3Q2XRT+WKy/wNc6A5jZAtzwuIfim8dmYnexT7lUzec25XqgxN
	 satE+32lAnmG1MdfILHAPRKmnr3haIJx1w7YjAOt+9YPFadTlYV3KnFT3Kuf2GMw2Tw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790846337;
	bh=XFKoyC6RHVTBZuZstkIMnamnDS5LKaUyCMP+Y9WVN1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CrGQ3+Z/9QxMrIzN/i6TjMDpYobJPIcRRCpW+42avy8Qg5bcIDyfxeSx86Qkp2Vey
	 CWWc2l/K+esLKsDewQceldGEPWIF+Oma1J3mSM9VusCU7CsvP3nOqdaykvZUDz5Odp
	 oVTSxZEfVIVMKX1JKbIKxZ4s+nM4A+fDPKe6svqHYrF3QdcXYd0DFyMROmcwZNCqQK
	 EgZzLfjXgG0d6JF3aMLo9zKaiVNbnuhAR/lwFe7SBoy/1dMQiE+prEJdY2S52dtV7D
	 mwyYxd+KP23+0JqLQiD8GT3uLLRkTgraIKwKJzy03ejidgjt0qrPAAH20OsTmdpYt2
	 2AUNHi5eYwWqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96EF560C1C;
	Thu,  1 Oct 2026 09:18:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7403922B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6586040CD2
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:18:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzTCaHFfXHR3 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 09:18:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4454A40CBF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=84.16.66.170
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790846334;
 b=aJz+HeczOGLbT3e6NlnL/saJ2mWkTQUzMsvU8nX4OAhaalRliu4PXlxyZ7m8Rw7tlz/l
 Yr+WMqoZjit3dSnhL1+AgAtY0rvjPjlInbAg926OyDC0ZIy+UuxvAgdO9mC0K6L1Hq6pg
 Vn8m5m55SRbnnTWUpTgd6y3SpDUYwoW9U3IVr2q0wdVrWY567DQ2En+PhcSEPZnC+M71U
 q8NaleH79L5BsytnXxXRNwvaCnSLpV5IoqXDP10fmRXI6jIcNRBIFMIFferfW7/KxLTil
 Tm8bc2zjUsAwZsB8IdHw32HRjnbBMcwlIRShV2Sd4+7sC4rmfcu5yYxhKfsrH1Ik8+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790846334;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=XFKoyC6RHVTBZuZstkIMnamnDS5LKaUyCMP+Y9WVN1Q=;
 b=Wn2QEkyid1LrQ7EqBAINchBCULh51jXhcUKTfTdU3WKaPl2dc6PsD1dvUVJP2x+Ev4hC
 38Wtis1N6gZA/IoF6bXk6eEiaCadrDr+QNRE5OjIX6/QE6dtt/3U4A/u+Tf/39rsBapvE
 gu3OywynXkARfl7xU/CK8rcoPdoZYFYf0ZVlpWztvOw4jYVY7tUby2wUgSmQ8EDB8IOGp
 3WHWFgTHlKkXPKCWYDWL14oD81kU00yP6RljBVJgkBy6cGr9KeOfSwHp56++fY1w7C72j
 d5xvDQ7Ou2PVru97yxJEhQdewY/0l+GxNDZ1pzs6GmOEce4EjuyWRkKu9b5vlcF5z3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=D1KJ+DzN; 
 arc=none smtp.remote-ip=84.16.66.170
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.170;
 helo=smtp-42aa.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=D1KJ+DzN
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4454A40CBF
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:18:52 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hwRDQ3fPwzYyb;
 Thu,  1 Oct 2026 11:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1790846326;
 bh=XFKoyC6RHVTBZuZstkIMnamnDS5LKaUyCMP+Y9WVN1Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=D1KJ+DzNdTmVv2bCAOeguO9FYwvAQVfDmdKCVJ1eJPcJoU9AWP5G+iSyokk7QUXZt
 1n4qRjzxm1MVzGz4lQcve7KtoFsghP0BbvhctvVVn9w7T+DDEQ9kd5uXccpFUsaC0Y
 97gSre5fxkl7je+j8hx7VuKNEwpg1ht1GDdgWNUFghKVkhxQ4w4c+VLPVlD8KjoFGt
 kYMuz8N0K0g2T2a7iuHrVK1h8pnija1EmA2Y/Ki5y8ULiGzG0EVYya3l6ushSEl418
 9IC4MmQoddOyF7sOgNzV1jBX+s8POMIKDparGHivPP+kjyfUMPyQUnuv/UlAXlK8Wj
 nt1nz1N+2bhHw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hwRDP428PzsD7; Thu,  1 Oct 2026 11:18:45 +0200 (CEST)
Message-ID: <be3cd318-cba7-4c04-914b-e859c222ddaf@0leil.net>
Date: Thu, 1 Oct 2026 11:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rockchip: rk3528: NanoPi R28S support before dts/upstream
 sync
To: =?UTF-8?B?5a6J5a65?= <HystericalDragons@proton.me>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>
References: <OjXy0xMi4UhaNlSDbglwvkf_FXX3Kg2TzBsaucWmd7YnY4tVJXGpdp-sUp-mApm8Zh9935uuKq1jhneCiItNCisIRiN66zEG8zl1jiGBFMI=@proton.me>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <OjXy0xMi4UhaNlSDbglwvkf_FXX3Kg2TzBsaucWmd7YnY4tVJXGpdp-sUp-mApm8Zh9935uuKq1jhneCiItNCisIRiN66zEG8zl1jiGBFMI=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

Hi Rong An,

On 10/1/26 8:14 AM, 安容 wrote:
> Hi here,
> 
> I would like to add U-Boot support for the FriendlyElec NanoPi R28S (https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R28S), a
> dual gigabit Ethernet router board based on the Rockchip RK3528, and

Looking forward to the patches!

> would like to ask how to handle its devicetree dependency before I send
> the patches.
> 
> The Linux devicetree for the board has been applied to the Rockchip
> tree for v7.4, together with a patch that splits the parts shared with
> the NanoPi Zero2 into a common rk3528-nanopi.dtsi:
> 
>    fdb087806e80 ("arm64: dts: rockchip: Split out the common NanoPi RK3528 parts")
>    c1e23f3425c4 ("arm64: dts: rockchip: Add devicetree for the FriendlyElec NanoPi R28S")
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=v7.4-armsoc/dts64
> 
> Neither commit is in dts/upstream yet, and they will not be in a Linux
> release until v7.4-rc1.
> 
> I have a two patch series ready on top of master (c92d8c3c431e37a17c3b37918037dbd7ade32d1e):
> 
>    1. rockchip: rk3528: Split out common NanoPi u-boot.dtsi
> 
>       Moves the vdd_arm/vdd_logic regulator-init-microvolt overrides of
>       the NanoPi Zero2 into a common rk3528-nanopi-u-boot.dtsi, following
>       the split in Linux. No functional change, no dependency.
> 
>    2. board: rockchip: Add FriendlyElec NanoPi R28S
> 
>       Adds rk3528-nanopi-r28s-u-boot.dtsi (only includes the common
>       file), nanopi-r28s-rk3528_defconfig (the Zero2 defconfig plus
>       CONFIG_BUTTON_GPIO for the reset button) and a line in
>       doc/board/rockchip/rockchip.rst. It needs the R28S devicetree in
>       dts/upstream to build.
> 
> I build-tested both nanopi-r28s-rk3528 and nanopi-zero2-rk3528 with
> the devicetree files from v7.4-armsoc/dts64 copied into dts/upstream.
> 
> My questions:
> 
>    - Would you take patch 2 now, or should I wait until dts/upstream is
>      synced to a release that contains the commits above and send it
>      then?
> 

"No" to the first part of the question. "Not necessarily" to the second 
part of the question as you can cherry-pick commits from 
devicetree-rebasing before we do a sync. This is your only option, 
barring asking Tom to do a dts/upstream sync (nobody else is allowed to 
do it).

>    - Alternatively, is it acceptable to pick the two devicetree commits
>      into dts/upstream early, once they are in a Linux tag that
>      devicetree-rebasing follows (v7.4-rc1)?
> 

They don't need to be in a tag, I think I've seen devicetree-rebasing 
sometimes pulling master early, but they do need to be available in that 
repo yes. In which case, you are allowed to pick the commits with
tools/update-subtree.sh pick <commit>

>    - Can patch 1 be sent and merged on its own in the meantime?
> 

Not available in devicetree-rebasing yet, so the answer is unfortunately no.

> And, unfortunately, proton mail does not provide SMTP for free user. So I can't send the patch myself.
> 

https://b4.docs.kernel.org/en/latest/contributor/send.html#authenticating-with-the-web-submission-endpoint 
should allow you to send patches with b4 without your own SMTP server. I 
have not had to use this yet but I believe some people in the community do.

I have seen some proton.me senders for patches, are you implying they 
are all paying to be able to send patches? (I know proton is not great 
for sending patches, see https://mamot.fr/@ploum/117285599520702326 for 
example; https://git-send-email.io suggests some tools but they do 
advise to switch to a different mail provider).

In the meanwhile, if you have patches that aren't device trees, you can 
send them now so we can review them (cherry-picks to dts/upstream are 
usually straight forward and usually don't require multiple versions) 
and you can have support for this board as soon as possible once the 
commits are available in devicetree-rebasing.

Cheers,
Quentin
