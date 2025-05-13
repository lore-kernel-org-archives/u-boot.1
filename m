Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4DCC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 04:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DD2080C83;
	Tue, 13 May 2025 06:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="XBtnPFfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E6581F66; Tue, 13 May 2025 06:07:12 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4667A8091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 06:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A0FCE25CD2;
 Tue, 13 May 2025 06:07:09 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vz83l-1RVQ47; Tue, 13 May 2025 06:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747109228; bh=ZXMWVLZ3BGX4U25XaJLrBAlVdIX/4QbrELzSiD1Torw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XBtnPFfs9UXujD6S1mwTYcvfZuZWz9+YDuUzvgAuOq5UFiz1uuIOF+73jPdKTWVYF
 hwHjdvlER1XZXYI5dnb1g5VAQIyCnI1jShr27Jonjsy0wVRwVRGOO4zuc0jb6WQRaT
 uN9boO9e1DutJHnB4AlTbE5ZsA7S3kVb/N6GN2VLZa8qDDN2bLy+CMJVg/5kU8oxIV
 Hmsuwg0mDgFuvno8vExsjjBR6zzJFHw8rPHNRseEypmGV0Az9Vkipbkx9v5AVxi/Vt
 l5aApt/k5O2drNbcIvwcHzi8j9P3UopToEG5BoRow/VkRWa/fp35H7aojKTDEwAocb
 Z8m5+CYxwMUIg==
Date: Tue, 13 May 2025 04:06:46 +0000
From: Yao Zi <ziyao@disroot.org>
To: e <e@freeshell.de>, Leo Liang <ycliang@andestech.com>
Cc: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, u-boot@lists.denx.de,
 Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 02/10] riscv: dts: th1520: Add clock-frequency for UART0
Message-ID: <aCLFVtUNo6sj1N3S@pie>
References: <20250426165704.35523-1-ziyao@disroot.org>
 <20250426165704.35523-3-ziyao@disroot.org>
 <aCHF-zLg41oOXdTl@swlinux02>
 <c37ce687674984589e56d2edb0184e48@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37ce687674984589e56d2edb0184e48@freeshell.de>
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

On Mon, May 12, 2025 at 07:53:01AM -0400, e wrote:
> On 2025-05-12 05:57, Leo Liang wrote:
> > On Sat, Apr 26, 2025 at 04:56:56PM +0000, Yao Zi wrote:
> > > [EXTERNAL MAIL]
> > > 
> > > The BROM of TH1520 always initializes its clock and configure the
> > > baudrate to 115200. Add a clock-frequency property to provide such
> > > information without introducing CCF to SPL.
> > > 
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > ---
> > >  arch/riscv/dts/th1520.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> 
> NAK from me. Quoting Emil "The uart0 node already has a reference to the
> uart0_core clock, so it shouldn't
> need this property." If SPL does not support the clock framework to do this
> parent node lookup properly from device-tree then we should not be adjusting
> the device-tree in this way; use instead the codepath in serial driver that
> checks a compile-time define.

I was not aware of the codepath, thanks for the hint! It should be the
correct way to go and I'll try to take in v2.

> See for example:
> https://lore.kernel.org/u-boot/20250503115301.972550-1-e@freeshell.de/
> 
> - E

Best regards,
Yao Zi
