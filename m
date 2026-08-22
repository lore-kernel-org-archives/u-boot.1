Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38A3C5DF8C
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 20:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A658406E2;
	Sat, 22 Aug 2026 20:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id plfoC3bbUItd; Sat, 22 Aug 2026 20:40:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787431259;
	bh=F2LqNDApPBehBCDtG+Qc02mNImwd6PnH3LZfBPSIGPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uFSIpcYUjS8nWbSmnr6UzqqSkAXHZ56m2jYuNf/MOUJi6ZA+68hiqw1fzdxmoYyXb
	 JutwVuhiCWIs42pC5oP1fVdY4JDlxxY2kiNyFeLchLmLQ6g4aAw6ks32vqgMNcFZ4I
	 NzvTtK1yp6/i/2fASgevxl6nCOSR1e2ayjoJGDJeNIXw8Yyk8mqTVIojGS7G7QVf30
	 YvTqTrMFXZRCqwhd7jArp1VRK8CiLZupcAzHJpSuFE7uaJ2ckbOdtXFJmE8rSTPnve
	 CxCuWUnRc/kdBX5Oq4+bV2j7V3rI+9orYXSAGSM2idbsIKxsYzdo1/uYWCZ+YzbHj2
	 3KNf9EmNHZlLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CF13406D9;
	Sat, 22 Aug 2026 20:40:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AF1D6476
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A09A380D2D
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:40:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0atHOV0QX0LW for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 20:40:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=fQSfOGZe
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE33980D23
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787431248; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SyDVTB9l5VggQlwK87qM7BJ1ajcyx0R9pn9vEPNit5KLxhOV61wO+AvQ6mT1dV2yRvmfMznPFJEHT4imu2qkR9O6NAjs0MkYc+nYqmyDyvGmP5Bw4b0c9i+Kna2I30IQK3IxwNB0a5nczbIjHWXqY3hKdBXbe5l1c2MroWMAmx4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787431248;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=F2LqNDApPBehBCDtG+Qc02mNImwd6PnH3LZfBPSIGPs=; 
 b=EyTmVjslMK5P9nrMsbOCi0J+jRRCFGxvHoZmu4UNfY4OExVFv5Iuq4Zl2K7xstqDJEWUdZEfjYJDaTDNgKBsUrqr4LQ/Aoo0O502mePZoGA8cITr72Frc8wvzn5NMy2cZ9JDpCLawdR4idZmPLRHxu739rCUijF0JG0RcWvoCGk=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787431248; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=F2LqNDApPBehBCDtG+Qc02mNImwd6PnH3LZfBPSIGPs=;
 b=fQSfOGZenVJRf1yC0xMqsMvRu9VzrCH9JzR2g62SaMI58rGbRbgvO0qDfmWX9SRq
 bX+s39dVgf6oxookqoKQLEq96LbzQ/tlfLryMYtitob+Khm/m7dxCfqiaqEWGfccbdk
 6k/YMezSNBnGPvEZ6F3wRhM1nupM5Hy69FWW1z0A=
Received: by mx.zohomail.com with SMTPS id 1787431244793555.7206741586549;
 Sat, 22 Aug 2026 13:40:44 -0700 (PDT)
Date: Sat, 22 Aug 2026 20:40:34 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 14/19] board: emulation: Add qemu-loongarch
Message-ID: <aooJQpeCbhlWkczO@pie>
References: <20260821084219.1703743-1-me@ziyao.cc>
 <20260821084219.1703743-15-me@ziyao.cc>
 <20260821162055.GO523975@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821162055.GO523975@bill-the-cat>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/287.412.46
X-ZohoMailClient: External
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

On Fri, Aug 21, 2026 at 10:20:55AM -0600, Tom Rini wrote:
> On Fri, Aug 21, 2026 at 08:42:14AM +0000, Yao Zi wrote:
> 
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > 
> > Yet another generic QEMU VIRT machine.
> > 
> > LoongArch QEMU splits the main RAM into two parts: the first 512M is
> > placed at 0x0, and the rest is placed at 0x8000000. FDT locates at
> > 0x100000. BIOS is mapped to the first flash mapped to 0x1c000000, where
> > U-Boot starts execution.
> > 
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> [snip]
> > diff --git a/arch/loongarch/dts/qemu-loongarch64.dts b/arch/loongarch/dts/qemu-loongarch64.dts
> > new file mode 100644
> > index 000000000000..39d303798fcb
> > --- /dev/null
> > +++ b/arch/loongarch/dts/qemu-loongarch64.dts
> > @@ -0,0 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +};
> 
> I thought I had pushed everything so that we do not need to have fake
> empty dts files anymore.

Do you mean OF_OMIT_DTB? Even with it enabled, a devicetree blob,
specified by CONFIG_dEFAULT_DEVICE_TREE, is always built, but not
integrated in the final u-boot.bin.

qemu_arm_defconfig also ships an empty devicetree. I'm not sure whether
there's really a way to avoid building a dtb...

> -- 
> Tom

Best regards,
Yao Zi
