Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CDCCAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 12:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A0B803CC;
	Tue, 16 Sep 2025 14:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="odkLZSM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED7638309A; Tue, 16 Sep 2025 14:49:45 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE8780325
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 14:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1uyV7q-00034w-3I; Tue, 16 Sep 2025 08:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=ZFf1yEW8UyDsAuZczTbQvpr5mYhQfvCFT88xfYuiKnw=; b=odkLZSM7LWfCAy
 LcosMwlgZZwbt9E2ID6g9PEaPTBi2BeO2p+HCgX93JsLGkN+Vn61JBxTPK+9VAjBNCjC81+tQiDPw
 mvQICYjVxlX8tBmX9+P0mWhh1kfxzqLA5lbuQ8I2JK/YP3bQ9VKTmJCFI5VpBjeYq6BqWHyL+qn1G
 zNgb+k37jNtqdhVApysI6M2ryujvZB7RUxQY3d3hb9mxlDUv7oCweWtCUL+6Xnkm3Syqce+rxRppM
 XOtbt17vFfH+rssbg+SanJ3ky8w7npTH6TfYk6BA7PIAisKMbB5OZnjAQcaDvvpw76hwOW+0zEKt6
 6ftIFfU3aUwknBCDa+Zg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: marek.vasut+renesas@mailbox.org, paul@pbarker.dev
Cc: u-boot@lists.denx.de, anton.reding@landisgyr.com
Subject: RZG2L and DTB blob from TF-A
Date: Tue, 16 Sep 2025 14:49:31 +0200
Message-ID: <87plbqd0kk.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

I am working on the RZG2L devkit from Renesas and trying to get the
mainline U-Boot working there.

I have noticed that in several locations, U-Boot is unconditionally
expecting the TF-A to pass a DTB blob:

In board/renesas/rzg2l/rzg2l.c:

--8<---------------cut here---------------start------------->8---
static void apply_atf_overlay(void *fdt_blob)
{
	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
        ...
}
--8<---------------cut here---------------end--------------->8---

In arch/arm/mach-renesas/cpu_info-rzg2l.c:

--8<---------------cut here---------------start------------->8---
static const struct tfa_info *get_tfa_info(void)
{
	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
        ...
}
--8<---------------cut here---------------end--------------->8---

Now, the TF-A that I have compiled (v2.5/rzg2l-1.00-43-g950d6a6b9) from
https://github.com/renesas-rz/rzg_trusted-firmware-a.git is not passing
any DTB blob:

--8<---------------cut here---------------start------------->8---
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x50000000
INFO:    SPSR = 0x3c5
VERBOSE: Argument #0 = 0x0
VERBOSE: Argument #1 = 0x0
VERBOSE: Argument #2 = 0x0
VERBOSE: Argument #3 = 0x0
VERBOSE: Argument #4 = 0x0
VERBOSE: Argument #5 = 0x0
VERBOSE: Argument #6 = 0x0
VERBOSE: Argument #7 = 0x0
--8<---------------cut here---------------end--------------->8---

That results in dereferencing a NULL pointer and failing to run U-Boot
on that platform. On the other hand, disabling the two pieces of code
mentioned below is enough to have a working U-Boot.

It does not seem that the upstream TF-A has support for the RZG2L
CPU. So my question is, what is the expected TF-A branch / repository
that is meant to be used together with the renesas_rzg2l_smarc_defconfig
U-Boot configuration?

Thanks in advance,

Mathieu
