Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD7CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39FD080F0E;
	Tue, 12 May 2026 10:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="0z/6ert0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BBC283015; Tue, 12 May 2026 10:22:22 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 599A480398
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 8B3E72291A;
 Tue, 12 May 2026 10:22:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1778574139;
 bh=BsKLma8gCjpmBm7aopnOTN6liAn9n0Khs68czfAOoLM=; h=From:To:Subject;
 b=0z/6ert0sc1JcPRjb2Wwk7lyYDATrmz9qSJf1s1NYwnLa6pd23jVD8H9kkEuFM29U
 KVIjMjs0XS+6FyI1BOep+aBHKTcdCbkPJnq2emygLeCNdnGcJ6PTvrk+4VsEsiTDuH
 d/1283U7ADB3BMsnAWnovJy/VFyRjZszisRLtlJ87oou7l8l3L09Q7IQfrBH7iOFac
 YB07B/hSyXft7oQy2G+cT7OmGL8e1LG6heSNRc9coqNVkvm/cjHYVLPwhPpe34G14n
 cjNGhI2inaphQz3oJp/k1mhev+g5L6N/CfWsBRzqVbH72BwlmPcVud6FevSP18/SvK
 ukwVPrIfXx41g==
Date: Tue, 12 May 2026 10:22:16 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH] arm: dts: k3-am69-aquila: add combined boot firmware image
Message-ID: <20260512082216.GA27936@francesco-nb>
References: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
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

Hello Tom,

On Tue, May 05, 2026 at 06:36:24PM +0200, Ernest Van Hoecke wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Add nodes to the binman configuration to create single binaries that
> combine tiboot3-am69-*-aquila.bin, tispl.bin and u-boot.img into
> firmware-aquila-am69-*.bin, with the proper offsets.
> 
> These binaries can be used to flash U-Boot via a single binary of three,
> as it is done now.

If possible I would appreciate having it in v2026.07. It makes the
update flow so much easier, and we do plan to use plain mainline U-Boot
v2026.07 for our boards in our upcoming wrynose OE BSP release.

Thanks
Francesco

