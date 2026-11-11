Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD8606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TAOq2bYC;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=LxWQ3IhB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27115605E0;
	Wed, 11 Nov 2026 17:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rf2F8YSRoh8t; Wed, 11 Nov 2026 17:51:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3D216073B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794419517;
	b=kM/4v91hoycCnLRxMfw8TA0/++txBvI46CU8qvL5ZlycFjb8D2RvtDc5xSvF6YFiTzn5
	 ktzP1/wOMONy9d+T+vKhFuUOR/PKym6ZmrzfVkBQO8AfEmwdYhhl+YFkTqDVyUydoq1OI
	 CXaDngtNSKQQE1rSQZgSOdmzbRbB7vkkX4U8A/QlAag0nOKVP4LR03wAjM+PaJppyDi5X
	 LHl3VeMEMaOO+uSJaqNMWj38qj3bg54/oBOtdlrHUBRHXAjRELFavzOWuMj0TEFQFcfWo
	 dSHS8o7Y2F+v+2ltQ4QhUpPK+v2r/foo1jdyjVnlVPmIfyJq0ikMRwVI0IdflCU9gzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794419517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RQaJXsbc/VX+HJANnInrE6BUJOk9fcmgIU/HjBgZdmo=;
	b=ZNawhs4VYb7bNI/kQ50oG3RAZlbc9MOXqLvJ+tcAhQEaM47U5OIgx26e1fq5Ol1ym9bc
	 zJgpLAFiqnbKS1hz2Q1ZP2iibuhKhy8V0wSGVvqr8jUTi4MCrcVKl7WShY9VDmj6l52LO
	 eFkPZMRWDg7XpA3ImGPM9ahZtSlhqN9B+yxGndwLuuBuaXHax/y1r3XpomWjRJhkgzBfg
	 CUFnXmwNHcH1XYHoIWeIM6Gcz+tsVIQd97PdipzPKB86lWXO4b5OmqJ5WWUR2gygLCM5D
	 U9RC7UcNevsj2gYh8p/NhMV9RbcPdHd/voZgOYXSU7UZQUTJ36PjwU0M66r6UmhfgSw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794419516;
	bh=RQaJXsbc/VX+HJANnInrE6BUJOk9fcmgIU/HjBgZdmo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TAOq2bYCCpNMWR6H9PUlqssgO26JZl5bBZVRC4BOER/7zkdX+fl7+3APA5+I5IDJR
	 EHd8coTW6brY4thz5dMj7FymmNuUxn1x48A9vcpnW0UmDdAKHD078JvefXyMQ+4ijF
	 FNQFr7ShTzybyu+4lWQISTw7ac7VmF4QHSsmG62LYlg5l04PeRQTfwRwYaIRkRxdUT
	 THVylcOCdvVJ7oQuHrWcf16tvsH/XWlDyQsDS7JOJU/RgPbqg6Zax+aNtmUP/9PGbX
	 vmM90ypmcqvUI8EYTPVxShxiG5u2IEVA7/fJnrmlKHrnXKA1KeLtVcy/JjN+29vain
	 n73HduZNiT0vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3D216073B;
	Wed, 11 Nov 2026 17:51:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 571712FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C56D40854
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PybktK73XC8P for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 17:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4DDE640801
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::190e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::190e; helo=smtp-190e.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=LxWQ3IhB
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::190e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DDE640801
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:51:51 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPrgS5mXpzDg6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 18:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794419508;
 bh=RQaJXsbc/VX+HJANnInrE6BUJOk9fcmgIU/HjBgZdmo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LxWQ3IhBYcg5KTU/Jqq/M+CntasZeMpjYKnmu8IU/hwPF1E/XKrilm866rt1wppfj
 lb028CWz84Q1s0XQMJOarOHgHMV/xFP9h5auvGbrMZIW+jSgjF9sgx0NVXSG2kORwR
 ToIbart/Vm6OAsD8g5a6muFRWe79tDtQpcyMfhz9gEmoFTP+gskgrSNSV3bUbopNKf
 TlUgIM/e5L/god3ux0lbkHFJEN/pCQyy2F9AbFxl8X5x6R7wtmZd3eiRzA1apPdPoe
 yZYK7oumljvWtQuuTfMzwqOSbSIOgyIxWAayU01vPlw+PbJFezMXmBGw5OyOQzCQt4
 1R0AD2nSG3UKg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jPrgR4c1czfyy; Wed, 11 Nov 2026 18:51:46 +0100 (CET)
Message-ID: <7f90a097-1b57-417d-9e35-d66b1cf898f1@0leil.net>
Date: Wed, 11 Nov 2026 18:51:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: Add LCKFB TaishanPi 3M
To: Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>,
 u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20261111165135.245826-1-220110626hanxuechao@alu.hit.edu.cn>
 <179441628581.251684.11046053143224226025@alu.hit.edu.cn>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <179441628581.251684.11046053143224226025@alu.hit.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Xuechao Han,

On 11/11/26 5:58 PM, Xuechao Han wrote:
> Hi Quentin,
> 
> I sent the v2 patch a moment ago; the changelog in it is only a short
> summary, so here are the detailed replies to your comments.
> 

When there's still an open discussion on some part(s) of the review, 
please do not send a new version until we've agreed on the outcome of 
said discussion(s).

>> issue: Device Tree is a representation of the HW, so hacks are not
>> welcome there
> 
> The DWMMC driver does not use cd-gpios at all: its get_cd callback reads
> the controller's internal CDETECT register, so supporting cd-gpios there
> would mean adding a generic GPIO card-detect path to dw_mmc, which affects
> every dw_mmc platform and cannot be validated on the hardware I have.

That's exactly what I'm asking you to do. Adapt the driver to support 
your use-case. If other boards also use cd-gpios and you break them by 
adding support for cd-gpios, then they probably had an incorrect Device 
Tree to begin with and they'll need to fix it.

> This pinmux is also very common in the same SoC family - rk3576-evb1-v10,
> rk3576-evb2-v10, rk3576-nanopi-r76s and rk3576-nanopi-m5 all select
> sdmmc0_det in their pinctrl - so I followed the same pattern for this
> board. With that, the SD card works in 4-bit high-speed mode.
> 

It doesn't matter what other boards do if they do things differently at 
the hardware level. If they do the same thing at hardware level, it 
might still be they are doing things wrong and doing it the right way is 
better than doing it wrong because everybody's doing it wrong. Jonas 
said[1] that other boards seem to be doing it wrong and they probably 
should get their pinctrl fixed as well.

Does the SD card work in Linux with sdmmc0_det_l? If yes, then it means 
the Device Tree is likely correct and we need to adapt U-Boot driver to 
support it, not hack the Device Tree in U-Boot only to make it work with 
the U-Boot driver.

You have two options:
- fix the Device Tree in the Linux kernel so it uses sdmmc0_det instead 
of sdmmc_det_l, and remove cd-gpios. Your "U-Boot doesn't support 
cd-gpios" justification for doing this change will not convince the 
Linux kernel maintainer. You can try, but I'm pretty sure you won't get 
positive feedback on it.
- add support for cd-gpios in dwmmc driver in U-Boot.

[1] 
https://lore.kernel.org/u-boot/13bfc090-7a2b-4215-9926-259633840359@kwiboo.se/

>> question: what are you trying to do/prevent here?
>> For the boot targets, do you really always want to try eMMC first, and
>> then SD?
>> Unsure why you want to limit the possible bootmeths?
> 
> You are right, v2 no longer overrides bootcmd or boot_targets; both keep
> their defaults (bootcmd is "bootflow scan -lb" and boot_targets comes from
> rockchip-common.h). The only remaining deviation is

You had mmc0 before mmc1 in v1, but now it would be mmc1 before mmc0. 
Are you sure this is what you want? (I don't care, I'm just saying the 
behavior changes between your v1 and v2)

> "# CONFIG_BOOTMETH_EFI_BOOTMGR is not set".
> 
> The reason is that the EFI boot manager is a global boot method, so it
> runs before any normal boot method. On this board it took over the boot
> flow and booted the EFI payload on the SD card before boot.scr could run.
> The board has quite a few optional peripherals that need device tree
> overlays, which we apply from boot.scr, so boot.scr must get a chance to
> run before any EFI payload. The 'efi' boot method stays enabled, so an

How do you know which overlays to apply at runtime? What does your 
script do?

[...]

>> nitpick: remove clock-names from CONFIG_OF_SPL_REMOVE_PROPS
> 
> I kept it on purpose: all eight RK3576 defconfigs in U-Boot use exactly
> the same CONFIG_OF_SPL_REMOVE_PROPS value, so I would rather not diverge
> from them here. If you still prefer it removed, I can drop it.
> 

Please drop. I'll eventually clean up the various defconfigs with 
CONFIG_OF_SPL_REMOVE_PROPS, but I don't see why clock-names should be 
removed from SPL DTB.

>> question: why not enabling SATA?
> 
> The mini-PCIe style connector is configured as SATA in the board device
> tree (&sata0 is okay, for Linux), and the same serdes lanes can also be
> re-routed to PCIe or USB by an overlay. I have no SATA device available
> for testing, so I did not enable it.
> 

OK.

> Also sorry about the missing Cc last time; I have passed the Cc list
> explicitly to git send-email this time.
> 

Consider using b4[1], it makes contribution *much* easier.

[1] https://b4.docs.kernel.org/en/latest/contributor/overview.html

Cheers,
Quentin
