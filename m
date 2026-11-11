Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9887606A339
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CKVIQqob
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BFA780FB2;
	Wed, 11 Nov 2026 16:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kby5XiQaB5BI; Wed, 11 Nov 2026 16:58:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 022CD81027
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794416310;
	b=kpKB5eQFHyi+yfBhDAQuLMFyjv2UDFjDX2VRs0MSlCr6ZB5hTBV//XM2lLQZpB1Ck4RC
	 ue3rH6gg8Pn9JFyDGMmxcwR13mxk/ErTkubGptqF7BXDmngusuzy7qJ68bCTrbkJbVnjS
	 4W/kBRXK98BNSKSaI7F3IqWFfKCTzSJCce+xpswQAS1dWt3jOmowRzebd+u5thWWR0e8/
	 y37QcBMWe/I3bD0iPK2bd37txN7EYT9JHOsL5uB9OoarO0+4176kM6M4c6mPiDOJPBFQS
	 BMFmDKXwzSl8xP8LM48Fe4nzzkU2OIdg+izUX5gEXHkIsW5JYgBS88R/KJ/UBaMfZfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794416310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UZfQHz4V8hbGqNepH4JCCjRP9tDRTF2wutJ5KVkJk/s=;
	b=s7U5P1nkZPff2M7oofvXDWfeYluIaKYQcL/4/aHLAqaHTvWNHCFd5JTJFvPkZw14vFeE
	 9IzOY+6fFnRVnUwztsqbPz5UrksDFSwOmeb3a+siFQqBY+QnsAMZ8aVjC2XlyAttb+Q5d
	 7wDgAJmLKgh62fJpxlZ6N0I2EKmxGsg8aULW7VME9EhOlKUcaHpJjlwOWX5vBsVLl9M9H
	 RxyXjx0RjaruZHIgislVrIpI/6w9zciHrTUiQf7KT2U6FFomf9yETAHn1ndHPUmL+OVdt
	 JvcOcv4C2d4jR1RxhHsjyQMSwt4+bfUw1ZnveK6psr16SKvfi0ZgVCw2fVHNdmmsoZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794416310;
	bh=UZfQHz4V8hbGqNepH4JCCjRP9tDRTF2wutJ5KVkJk/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CKVIQqobo78d8wIuY6VjiDXew0Thkc2x1oT8ztOv9IyVY5DXziAOhd6rJYoxbnPhU
	 pERp+jOTyaUASEq1oK9j0FOsQ/TJjiiv8NVwqY1+c2JMms0nm2dgiBXXwSXjbmN1O1
	 CuRZgO2GS4QbBk5xwiFJ2pErqGP/Qe1WImbEMrwr/3jS0282vTAwxYIqRLNWJpT4ES
	 cM0Zo7HFzm/oc5U6s4nl5A5NTNzDcuvotVw8YVvP6Vil4uRCa59aWQ2wDJl+r8jXGU
	 8dOngirV4KmTGjRdln5jT9CamGk2kAjojfeeXeovMvzBqPqejjhBLEq/rVPVrZr0Z/
	 4eh2IFwE2c0/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 022CD81027;
	Wed, 11 Nov 2026 16:58:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A7A9A731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98F846088D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OLFLuuP00EMD for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 16:58:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 10A626060E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=202.118.224.62
Received: from mail.hit.edu.cn (mail.hit.edu.cn [202.118.224.62])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10A626060E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:58:12 +0000 (UTC)
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=alu.hit.edu.cn
Authentication-Results: smtp3.osuosl.org; spf=pass smtp.mailfrom=alu.hit.edu.cn
Received: from [127.0.0.1] (unknown [219.223.232.242])
 by mail-appserver03 (Coremail) with UTF8SMTPSA id
 P0WgCgD3t4mdnvRq9ecaAA--.19376S3; 
 Thu, 12 Nov 2026 00:58:06 +0800 (CST)
From: Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2] board: rockchip: Add LCKFB TaishanPi 3M
Date: Thu, 12 Nov 2026 00:58:05 +0800
Message-ID: <179441628581.251684.11046053143224226025@alu.hit.edu.cn>
In-Reply-To: <20261111165135.245826-1-220110626hanxuechao@alu.hit.edu.cn>
References: <20261111165135.245826-1-220110626hanxuechao@alu.hit.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: P0WgCgD3t4mdnvRq9ecaAA--.19376S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCryfZr47tw1DCw43CFW7urg_yoW5XFWfpF
 s3KF4rJrWktF1xZwnrAw1xXFyfCwn3t3y5Jr1fWw15A390gryfJFn3Ka4jqF9rXFnYvFyF
 vFWFqF97JrZ5ZaDanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUU0bIjqfuFe4nvWSU8nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Eb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv
 0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z2
 80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS
 14v26rWY6Fy7MxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
 1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
 wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
 v20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
 Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
 AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUO3fH5UUUUU==
X-CM-SenderInfo: yssqiiaqwslx5dq03vpfkd0qhdoxhxllwovvfxof0/1tbiAQQIAGr0WGMIwAAAsg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

I sent the v2 patch a moment ago; the changelog in it is only a short
summary, so here are the detailed replies to your comments.

> issue: unnecessary comment
> We're in U-Boot, we know it's additions to the Device Tree for U-Boot.

Dropped, thanks.

> issue: Device Tree is a representation of the HW, so hacks are not
> welcome there

The DWMMC driver does not use cd-gpios at all: its get_cd callback reads
the controller's internal CDETECT register, so supporting cd-gpios there
would mean adding a generic GPIO card-detect path to dw_mmc, which affects
every dw_mmc platform and cannot be validated on the hardware I have.
This pinmux is also very common in the same SoC family - rk3576-evb1-v10,
rk3576-evb2-v10, rk3576-nanopi-r76s and rk3576-nanopi-m5 all select
sdmmc0_det in their pinctrl - so I followed the same pattern for this
board. With that, the SD card works in 4-bit high-speed mode.

> question: what are you trying to do/prevent here?
> For the boot targets, do you really always want to try eMMC first, and
> then SD?
> Unsure why you want to limit the possible bootmeths?

You are right, v2 no longer overrides bootcmd or boot_targets; both keep
their defaults (bootcmd is "bootflow scan -lb" and boot_targets comes from
rockchip-common.h). The only remaining deviation is
"# CONFIG_BOOTMETH_EFI_BOOTMGR is not set".

The reason is that the EFI boot manager is a global boot method, so it
runs before any normal boot method. On this board it took over the boot
flow and booted the EFI payload on the SD card before boot.scr could run.
The board has quite a few optional peripherals that need device tree
overlays, which we apply from boot.scr, so boot.scr must get a chance to
run before any EFI payload. The 'efi' boot method stays enabled, so an
.efi file in /EFI/BOOT/ can still be booted, just after extlinux and
script, and extlinux/pxe/vbe_simple are untouched.

> question: what do you need the reset subsystem for in SPL?

CONFIG_SPL_DM_RESET has been dropped. The board boots from eMMC and SPL
does not need the reset subsystem.

> nitpick: remove clock-names from CONFIG_OF_SPL_REMOVE_PROPS

I kept it on purpose: all eight RK3576 defconfigs in U-Boot use exactly
the same CONFIG_OF_SPL_REMOVE_PROPS value, so I would rather not diverge
from them here. If you still prefer it removed, I can drop it.

> question: why not enabling SATA?

The mini-PCIe style connector is configured as SATA in the board device
tree (&sata0 is okay, for Linux), and the same serdes lanes can also be
re-routed to PCIe or USB by an overlay. I have no SATA device available
for testing, so I did not enable it.

Also sorry about the missing Cc last time; I have passed the Cc list
explicitly to git send-email this time.

Cheers,
Xuechao

