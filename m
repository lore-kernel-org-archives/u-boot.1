Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D134BCCD185
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 03:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EEE983DBD;
	Sat, 11 Oct 2025 05:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="FC2wqj1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 082BE83DC7; Sat, 11 Oct 2025 05:09:17 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19B0083D9C
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 05:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8AECF26091;
 Sat, 11 Oct 2025 05:09:14 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7J_M2v02IhSr; Sat, 11 Oct 2025 05:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760152153; bh=tHPy/yNR9GvcBSE8Yiv1Wb14+cci/3Gb/XXRax9VX1Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FC2wqj1Kb0de41YygtdXUQcyeBm6baI/IW5EnjCnDurwOstKJlY60PSvX/4G90T0C
 g7D1jeXml/81oO38KD8TqYmXdRcAPtb44Tob99BZS20IJH4Gtg9PLyUCiUreBGYvWq
 Fl/NNyD1OoL1NdBc4V1vWCbVcG5IdfclG/2V2jOt33cwe2oJOGQkboOWR+32UcASJj
 Q4VhYgVMYCsx3JEnFICA9DATHIcYUBkI1kHjTtfNZ5Bs3un/J2Gt7eZbl1DDSeJ707
 SRGeNZogTtVDdDN2Z6XXEf+P8/14cMI1s5VvTcx7Ze/JPuXLFSMQH/RJwN8wcBRI79
 YJyd7eCBRMUGw==
Date: Sat, 11 Oct 2025 03:09:01 +0000
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH] clk: sophgo: Fix a warning about void returns value
Message-ID: <aOnKTWV0O2p1y5lW@pie>
References: <20251001203057.2828531-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001203057.2828531-1-trini@konsulko.com>
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

On Wed, Oct 01, 2025 at 02:30:57PM -0600, Tom Rini wrote:
> The cv1800b_clk_setfield function returns void, but was doing "return
> writel(...);" and while seemingly having a void function return a void
> function is not a warning, when readl is a macro this problem is shown.
> Correct the code to instead simply call writel.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Yao Zi <ziyao@disroot.org>

milkv_duo_defconfig builds fine with this patch.

Regards,
Yao Zi
