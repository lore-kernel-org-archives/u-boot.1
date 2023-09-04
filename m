Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5F1C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 15:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 189A0869C1;
	Mon,  4 Sep 2023 17:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693840703;
	bh=BSXV3S1eubcl+a69uVtfjp4nTOMKKt6g9hJpYsmfg14=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=XFO90wX7wNvNjFnvQaMan0xDBfzcCEM4a8afF9xLhu9QoUG+39+jitJwVEOpvUiZr
	 FHv9R4yUQFzTRNiuSxUkyda+krkIa1qXg7bKQEnKZ5VJOumrJySo3bSyrLPrB1lvFh
	 nSu/g/Zl1k6xErnBGk/sFagVb5v6eI8m0jwdQKJT9vweiSU575qHo9NALXuUCKUj54
	 6N7D2bCGS+lwLGiVYE1lPKymNwMVNcXKRifE0f/nj05zzLYoxB4xavxzQeNyI7IBb2
	 C5ywDbnNJUiCI7IX6ZJqNFJy6P5Vrn4d9Sj9f3qnQUKg9vdkQNxLtEvsjfjcjwEqc7
	 aIfFhBZP1+hew==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E0E869B5; Mon,  4 Sep 2023 17:18:21 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E6A863CF
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4RfXMZ61yNz1r2ZH;
 Mon,  4 Sep 2023 17:18:18 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4RfXMZ5w6pz1qqlS;
 Mon,  4 Sep 2023 17:18:18 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id p-zgkpfnCcFz; Mon,  4 Sep 2023 17:18:18 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon,  4 Sep 2023 17:18:16 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Elena Popa <elena.popa@nxp.com>
X-Patchwork-Id: 1818598
X-Patchwork-Delegate: sbabic@denx.de
To: Elena Popa <elena.popa@nxp.com>,u-boot@lists.denx.de
Subject: [PATCH v2] arm: imx: imx8m: imx9: Fix DRAM size calculation due to
 rom_pointer
In-reply-to: <20230808115826.2213645-1-elena.popa@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20230904151821.82E0E869B5@phobos.denx.de>
Date: Mon,  4 Sep 2023 17:18:19 +0200 (CEST)
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

> If dram_init_banksize() is called from SPL, the rom_pointer, at that
> point, is not correctly initialized. This causes wrong calculation of
> DRAM start and size in dram_init_banksize(). The issue became apparent
> only in Falcon Mode. Added an extra condition to prevent using
> rom_pointer in SPL.
> Signed-off-by: Elena Popa <elena.popa@nxp.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Fabio Estevam <festevam@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
