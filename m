Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B03C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A44284A04;
	Thu,  2 Jul 2026 22:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="hIg4NBtQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF64884A20; Thu,  2 Jul 2026 22:40:01 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26499847C8
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1783024794; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dGTo7OOL0XYNlllr+aXK+aU0KySzeH5ZMEmorwE1VwEmKXcg2Kd7XnqXO1dyvyvJpHpWRVEBDY3lr/MNc8MDi1BW+pVAn9i6EaZw4sts8FnCb65oIbt+A7u6WiuXvEcNWlcWkyh4N45QeLlVdhU/iOok828L2Z4S4bKnNqZbfNU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783024794;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=jY2a04y2UOewO/7e/UjOQuKRO+h7v/rRoViwoTIU2/A=; 
 b=MaxjE/kIihsUmQLIj5MXvhGRttKwMMvt1qudd27Ua4fBBv+NtZ1wgFCz18OKXKq8dYxTTcqDfx14q2Azrcarq1UaxvL6mA3og8jH2toEkNSZfEX5hQhQex+PbxxdU7RjBnL3tj997lIULoZGC6yzl1GjWdrd8as6mQ8/V3tvCTo=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783024794; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=jY2a04y2UOewO/7e/UjOQuKRO+h7v/rRoViwoTIU2/A=;
 b=hIg4NBtQM2g+B1Zes+Cw5y9NNKm6h2sDBD/QrmV97JnEu350T/9ryyVX/dkY/hCv
 i8lpMkQtBAHwDdDJLnAPvfzGYH6coTUNZpjTlsKctu+HwHgfohCl/4q4Nh5vQ0/kXT0
 QPAFAR+xu11ef5ghRgH4Ol2HL+pMMj9HWCb8lcS4=
Received: by mx.zohomail.com with SMTPS id 1783024790749157.75821507135333;
 Thu, 2 Jul 2026 13:39:50 -0700 (PDT)
Date: Thu, 2 Jul 2026 20:39:44 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 03/16] image: Take entry point as an output of
 setup_booti
Message-ID: <akbMkCvTJtLlse6C@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-4-me@ziyao.cc>
 <20260701173940.GN749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701173940.GN749385@bill-the-cat>
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

On Wed, Jul 01, 2026 at 11:39:40AM -0600, Tom Rini wrote:
> On Wed, Jul 01, 2026 at 11:17:55AM +0000, Yao Zi wrote:
> 
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > 
> > For LoongArch the start of the image is not the entry
> > point to the image.
> > 
> > We refactor the code base to allow entry point to be
> > supplied by setup_booti.
> > 
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> > ---
> > 
> > Changed from v1
> > - Correct type of "entry" argument for RISC-V and sandbox
> 
> Can you please also provide a link to
> https://www.kernel.org/doc/html/latest/arch/loongarch/booting.html which
> probably should cover this, but I'm not entirely sure does?

It does in a non-obvious way, quoting part of the image header,

	u32     MZ_MAGIC                /* "MZ", MS-DOS header */
	u32     res0 = 0                /* Reserved */
	u64     kernel_entry            /* Kernel entry point */

comparing it to the RISC-V version[1],

	u32 code0;                /* Executable code */
	u32 code1;                /* Executable code */
	u64 text_offset;          /* Image load offset, little endian */
	u64 image_size;           /* Effective Image size, little endian */

The start of LoongArch image isn't marked as executable.

Additionally, should I include the URL of "latest" kernel documentation,
or using a link with explicit kernel version (e.g. [2]) to ensure the
content doesn't change or become 404 over time?

> -- 
> Tom

Regards,
Yao Zi

[1]: https://www.kernel.org/doc/html/v6.6/riscv/boot-image-header.html
[2]: https://www.kernel.org/doc/html/v7.1/arch/loongarch/booting.html
