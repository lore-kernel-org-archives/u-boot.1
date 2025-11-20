Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEBECF8860
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 14:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DAD883F1F;
	Thu, 20 Nov 2025 15:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="BC5lcA6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E24A38405B; Thu, 20 Nov 2025 15:48:55 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0E483EAF
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 9E4511FC94;
 Thu, 20 Nov 2025 15:48:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1763650133;
 bh=AKHhTAZuyiQTQH/5ubTOQhB0Cbh2DFv6rwWNZyLvHh0=; h=From:To:Subject;
 b=BC5lcA6gpWRugOwhMfcBjoih1If9mbxT4z87S5Zn2V8BOQrUI8QHeSn0wYeYWuhah
 vsg6d3frRZyHempYtoXuUfpKD6hp2th7zUNxqvFvUTqnuOo1QVB+j+uUk+LzX5ltth
 u12TB5+bJhqqd7SjawwEimQT4mK2Hv7m075s5IrjeyjywR/vtbSw4LitRJqrPOgCxN
 nIljnWA47ySySOBhUS4K8v/mfey7Wox40JXwoPwpXaLfPJpo8LqesirV/kaMK4VtEJ
 t+ug1TKFRbFQSa3D0rXakMOtSy7NQRcTXLfaFvrMsMyjrOsJl/s8n5jg1mS3trJBTr
 HwkZNgsJlQC/A==
Date: Thu, 20 Nov 2025 15:48:48 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: "Scholz, Kevin" <k-scholz@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 "Francis, Neha" <n-francis@ti.com>,
 Franz Schnyder <fra.schnyder@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "K, Santhosh Kumar" <s-k6@ti.com>, "Brattlof, Bryan" <bb@ti.com>,
 "Chawdhry, Manorit" <m-chawdhry@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Kumar, Udit" <u-kumar1@ti.com>,
 "Gujulan Elango, Hari Prasath" <gehariprasath@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update to
 v0.12.0 of DDR config tool
Message-ID: <20251120144848.GA58464@francesco-nb>
References: <20251103071035.674604-1-n-francis@ti.com>
 <20251103071035.674604-6-n-francis@ti.com>
 <btgc6fvqwkqlnnmqicvobikkyjpib5lgvda7tfyguwn25bmd2s@hdhibzylbig7>
 <2b1b5496-cbd2-4ac4-85cc-2b8da653bbdd@ti.com>
 <20251120081659.GA12514@francesco-nb>
 <6726eb089e2f41ad9fa4a5ff3d6ceb54@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6726eb089e2f41ad9fa4a5ff3d6ceb54@ti.com>
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

Hello Kevin,

On Thu, Nov 20, 2025 at 02:23:02PM +0000, Scholz, Kevin wrote:
> 
> ODT is user configurable from the TDA4x (J784S4) DDR config tool.
> Custom boards can modify this setting as needed.

Thanks for explaining me the tool and the related config options and
changes, however the question is why you have this difference
in your specific configuration for AM69A SK board in which only dram3
has ODT enabled, and dram, dram1 and dram2 not. Is the layout/schematics
of DRAM3 different from the others? Why?

Francesco


