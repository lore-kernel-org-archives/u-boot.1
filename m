Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FBBF8D77C
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 074D48407E;
	Thu, 16 Apr 2026 23:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Cwug6BNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508788407E; Thu, 16 Apr 2026 23:00:01 +0200 (CEST)
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com
 [136.143.188.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C59F883EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1776373196; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F7RZD1TZdEgr+0cOBHie6e2DbW+Ho4tuIXlyl9hDPbWo0gyB8BhquoxsDuxGVNMs7rX/RHCBP5b1+VTzl4EHV2hvBZLlh0UbLJr9d5vy2NlQK17VlQeLfu2NO1DaMzBTu9Euj0qV9hpTg7Qqf8IkzQiOK2Gxy0DU19YiayEIS0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776373196;
 h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=f4JBdJ8VQDeSmHxFYyDLwgEfoM82ymiSEHJZCQWSP80=; 
 b=S6uD7f1ZuA1BpGMhMlsyMHFievXYxanP4UP4osyqYVRCL2/8MCkGvqUPZjTdL1oAUJQBfxChc+Y+c8y46hK90otnSnQgnoUJgl0Gacr2VMhqoPaA3KHCU3UJQI3bKs5y+8u9YjvCbS2YxJMnv7VgueNQ82s1Da8zyh2sJ+eKCrk=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776373196; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To:Cc;
 bh=f4JBdJ8VQDeSmHxFYyDLwgEfoM82ymiSEHJZCQWSP80=;
 b=Cwug6BNPUlCR7z30eVM9m8ezEimiqIZLMqTQqDZTZ/CNrUZkt/tkajg6JpLqgJob
 lTlp9ziDMcdVA+2GVkW9WDo/sOn59l+IiDNCiUcBNgo2tjGQa92EfUJtMAJpJmx6EUW
 Y8ltLF0VZmAxBioyFeDyygNu6U9APJoiBYI4g8Lo=
Received: by mx.zohomail.com with SMTPS id 1776373192468308.22078801825205;
 Thu, 16 Apr 2026 13:59:52 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:59:42 +0000
From: Yao Zi <me@ziyao.cc>
To: Johannes Krottmayer <krotti83@proton.me>, u-boot@lists.denx.de,
 minda.chen@starfivetech.com, hal.feng@starfivetech.com,
 Tom Rini <trini@konsulko.com>
Subject: Re: doc/board/starfive/jh7110_common.rst: Documentation doesn't
 mention OpenSBI text start address
Message-ID: <aeFNvoqalngWkL0N@pie>
References: <a39c05f8-7cb4-4a27-bd73-dd6297c19a0a@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39c05f8-7cb4-4a27-bd73-dd6297c19a0a@proton.me>
X-ZohoMailClient: External
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

On Thu, Apr 16, 2026 at 03:11:42PM +0000, Johannes Krottmayer wrote:
> Hello,
> 
> 
> I have used the U-Boot documentation for building OpenSBI and
> U-Boot for the Starfive VisionFive 2 board.
> 
> Unfortunately there is a important definition missing (will be not
> mentioned in the current documentation) in the build step for
> OpenSBI.
> 
> FW_TEXT_START from OpenSBI defaults to address 0x0, this raises
> an exception. FW_TEXT_START should be set to the correct address
> 0x40000000 and then it works.

Which component raises the exception, and which OpenSBI/U-Boot
versions are you using?

For OpenSBI, it supports being loaded on arbitrary addresses since
at least commit 0f20e8adcf42 (firmware: Support position independent
execution, 2021-03-17), which is much earlirer than the minimum version
than support for JH7110 in OpenSBI. Currently OpenSBI should be built as
position-independent code by default, FW_TEXT_START only helps debuggers
and etc. to correctly resolve symbols, while makes no constraint on
OpenSBI loading.

For U-Boot, the address to load OpenSBI is determined by
CONFJG_SPL_OPENSBI_LOAD_ADDR, which is 0x40000000 in
starfive_visionfive2_defconfig, and has nothing to do with FW_TEXT_START
configured in OpenSBI side.

> 
> So therefore the correct build step should be:
> $ make PLATFORM=generic FW_TEXT_START=0x40000000

Thus I think probably the root cause of your failure has nothing to do
FW_TEXT_START. Might you check it further?

> Should I create a patch for the documentation to add this?
> 
> -- 
> Kind regards,
> 
> Johannes K.
> 

Regards,
Yao Zi
