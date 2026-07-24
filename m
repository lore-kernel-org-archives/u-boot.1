Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4954DC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 11:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F9AE60B17;
	Fri, 24 Jul 2026 11:03:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eDLP-KCTpQvu; Fri, 24 Jul 2026 11:03:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A2A0607B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784890985;
	bh=anRA2ThBfDQL2+rPlvW5c820D7YgGCCYm/uzDLbO/HY=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mdXDSnUAmZLOWsO8Ak02hfVNWhMQuqLPYw1Qjmm+RjB59GGTkQgMDilDkZRyjByR4
	 VF4/poQQMNPyVQfZyg1xyN3sYeqZ+q0JbuvgX37QHvkfiitwi/txhcO6ADJ32bzzBI
	 BadGxHVO9Zw554ewSHSin2LDhhGc1nmABy9ul+Xbqj5XLrfvr0VoNiJy3947l5/WOP
	 yJiEcGUQ+EkaFxiIaM+AKIj5WKjFbrdPbej/gDzSy7Qzoh+PVUJeVUoDOvE/2CWsx9
	 HKHLi3fAfh/Bu4lmyx5YyZJbLVxPDHQxmc1e/2gjztm5yj90yBWE49uIiA3q7gUPof
	 Keu3BGvbHWx/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A2A0607B8;
	Fri, 24 Jul 2026 11:03:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CFEB3EB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B63D440A96
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EKTqjhK60Isq for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 11:03:02 +0000 (UTC)
X-Greylist: delayed 319 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 24 Jul 2026 11:03:02 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9AB38409A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AB38409A8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.137.112.168;
 helo=mx0.gmx.wtf; envelope-from=u-boot@vicb.net; receiver=<UNKNOWN> 
Received: from mx0.gmx.wtf (mx0.gmx.wtf [203.137.112.168])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9AB38409A8
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 11:03:02 +0000 (UTC)
Date: Fri, 24 Jul 2026 12:57:38 +0200
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: RK3399 TF-A hash verification failure for atf-3
Message-ID: <amNFIs43utk3TsPc@localhost>
References: <alujuCnNh13eRfdA@vicb.net>
 <CALeDE9OY18j7hFKW=o2mUA__FApjEVJ73oVV5fWTDTPeLqszGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9OY18j7hFKW=o2mUA__FApjEVJ73oVV5fWTDTPeLqszGQ@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vicb.net; 
 s=f747d04263f05989; t=1784890661;
 bh=anRA2ThBfDQL2+rPlvW5c820D7YgGCCYm/uzDLbO/HY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZFbwhwNub+6YaH8bFAwG3ueiPr6cU2WiYtOdIZWzYLzk9xxHTgA7gANu2GeXvKL3S
 84DDP9KFFHWtELpMmkRWfPEuqQuZAqsJgy+4faakkcVWf/a+55r+sz4gdpCrHCn5vU
 CdL+NeKRqYSNwiPSGdae/bAs/P5w+MQkPGjaW+MixZFXBBCpRlV4U7l9IrAd6OoBWG
 1XLT0jqb5rKqumnx1Z6Mm2tVQXkp9ThXLoVsJGz6rjrqiFWkldQppvORqevr8UUZVI
 GUcgF6nQL4jQTDGC7i/PNuE8/6Q2JDS0e1E163Lidq5p0O1UYhnBTcMWZWdvkNqNQX
 Dq86jAxRoNlFQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=vicb.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=vicb.net header.i=@vicb.net header.a=rsa-sha256
 header.s=f747d04263f05989 header.b=ZFbwhwNu
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
From: Vic B via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Vic B <u-boot@vicb.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, Jul 22, 2026 at 05:23:58PM +0100, Peter Robinson wrote:
> Hi Vic,

Hi Peter,

> While changing that setting may allow it to build the PMU's SRAM size
> in hardware is fixed, so it will cause real world problems.

I've been trying to figure out whether the PMU SRAM size is fixed
on RK3399, but haven't found the answer.

Unlike e.g. RK3528A, where the block diagram clearly says "PMU_SRAM(8KB)",
RK3399's datasheet only mentions that SRAM size is 200KB and security or
non-security space is software programmable by 4 KB step. I was therefore
hoping that changing PMUSRAM_RSIZE will cause something (TF-A or u-boot)
to adjust the PMU SRAM region automatically, but it's probably better
to assume that it's indeed fixed to 8KiB.

I have also modified boot/image-fit.c to dump whole image on hash
verification failure, and found out that while the original oversized
byte pmusram image (atf-3) of 12120 bytes consist of 3859 mostly
non-zero bytes (looking like code), followed by zero padding up to
offset 8191, some data from offset 8192, followed by zeroes from offset
8508 till the end, the image that u-boot sees in memory during hash
verification has its beginning overwritten by the part which can be seen
at offset 8192 in the original.

This kind of overflow probably also indicates that the limit is 8 KiB
(and also definitely causes me to no longer trust this oversized build
of trusted firmware, despite the fact that the systems seems to run fine
with it).

> The thing to note with the PMU FW is it's built for a Cortex-M0 core
> which means you need to build it with a 32 bit compiler. You likely
> need to add a M0_CROSS_COMPILE=arm-linux-gnu- variable (substitute
> with the string for your armv7 compiler string) to the beginning of
> your make command. EG:
> 
> M0_CROSS_COMPILE=arm-linux-gnu- make HOSTCC="gcc" CROSS_COMPILE=""
> PLAT=rk3399 bl31

I've tried M0_CROSS_COMPILE with both arm-linux-gnuebi- and
arm-none-eabi-, but neither helps.

I also suspects that TF-A 2.14 selects arm-none-eabi- automatically
for M0, as it fails to build without gcc-arm-none-eabi installed (at
least on Debian), and it builds successfully (with increased
PMUSRAM_RSIZE) when installed, without using M0_CROSS_COMPILE.

Also make_helpers/toolchains/rk3399-m0.mk and the last Chris Kays's comment in

https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/36981/comments/877be809_5abf10d8?tab=comments

suggest that arm-none-eabi is the right way to go.

> It works across numerous rk3399 devices for me with the 2.14.1 build
> in Fedora and that firmware is about 5.7K in size.

As Quentin Schulz explained in his reply, the overflow issue is known to
happen with Debian's gcc, and considered to be a Debian bug by some
because it doesn't happen on Fedora.

According to my fiddling with it so far, it appears that Debian's gcc
decides to align a part of pmusram (more precisely, the part called
rk3399m0pmu_bin, which seems to be linked using the recipe in
plat/rockchip/rk3399/drivers/pmu/pmu_fw.S) to 8 KiB boundary, which
causes the overflow.

I also have doubts that this is a bug in Debian's gcc, adjusting the
build/linking of TF-A so that it prevents gcc (or its ld) from aligning
rk3399m0pmu_bin to 8 KiB seems like more promising solution than waiting
for maintainers of Debian's gcc to do something that will fix this
issue.

I'll post more details in reply to Quentin's message.

Vic
