Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B7BC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FDBE879E8;
	Wed, 17 Jan 2024 11:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="teATnWTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64FA287B26; Wed, 17 Jan 2024 11:53:11 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38357878A5
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E3C2A2228F;
 Wed, 17 Jan 2024 11:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1705488788;
 bh=zjcicHyeJWoE71E7jm1x1JExodt4lg1bqSyh8v8/OxY=; h=From:To:Subject;
 b=teATnWTny3S+Dfzk2VGr1P6GH/qsp1pe7/IdjURqaC6FPTfDZRHnCElVTmV2IcQcE
 4TfBqC/LX29F2IvnH09ClaDgt0+8AV0XoAOFGnztpWfBJqz617cG3Xk+OA8H+u2ImZ
 irvGtaJ+hGyfPDEZnURBHRvJgCR5S+FIeDzl0AWFSasfWoFa0BC3FxDgInTWQoQQmJ
 pWiw8yJY3F5MI/huMdmq6CjCPhsPeduIg6nThV19wwLFPWsDuAJDwfBozS9Q1gixHf
 8V/yhMdR84eQEvJLH6jpYqR/7YfBzLHcG4iHcWYCyOewCfjrj/VwchPc/fEuISufYX
 8ePd4Rx18u+yw==
Date: Wed, 17 Jan 2024 11:53:03 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Max Krummenacher <max.oss.09@gmail.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Andrew Davis <afd@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/4] board: verdin-am62: set cpu core voltage
 depending on speed grade
Message-ID: <20240117105303.GA7698@francesco-nb>
References: <20240117101743.3955852-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117101743.3955852-1-max.oss.09@gmail.com>
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

On Wed, Jan 17, 2024 at 11:16:45AM +0100, Max Krummenacher wrote:
> 
> The series moves the existing access functions to the AM62 Device
> Identification fields and adds function for the not yet accessible
> fields to be available to all.
> 
> This is then used in the Verdin AM62 board code to set the CPU core
> voltage according to speed grade to gain more than 100mW power
> consumption reduction for the slower speed graded SKUs.

For the whole series,

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

