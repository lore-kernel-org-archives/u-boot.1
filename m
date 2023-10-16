Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD22CCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF3D86BD7;
	Mon, 16 Oct 2023 11:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448079;
	bh=nc0XumCFmzVF0AnCuVb2npsc9XoLkI8TswSCESWSBfs=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=qYTQSDvLI9Hf4rL4yi9RYdQ58w8hiNDXGswQWXw7CaLBTUnQ5pbadMBwBDzX9uRVf
	 GXyTDaGgIsXz7U4Un7IQKy35OMCajjHuULfrEN93mc7ggPJBZ7Y6bQcT98NbH5tATH
	 ngcQTfFmO1RYdyeLeuFWM8evuNx+5PEcuxmkFM8WUsLxjWOnETyQ2t4EsB3kTcRFFu
	 xdG3MTIoR/w7a3U+nqZhziysvYca4veKGecHzhazl2VfsQE3M3g5499HLtmdU9MjJs
	 zish/Caj+ECGEQMS/i2lm3E0hhKRBmcoPSCMJi9GxefH6W5mOP+kMbYM4kGkhlWmQc
	 LINpwtUCCFD/g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A002786B1D; Mon, 16 Oct 2023 11:21:18 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7CF586BA4
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BSD22mbz1sCHF;
 Mon, 16 Oct 2023 11:21:16 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BSD1swyz1qqlY;
 Mon, 16 Oct 2023 11:21:16 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id FmETBJX8GtxR; Mon, 16 Oct 2023 11:21:15 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:21:15 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
X-Patchwork-Id: 1836733
X-Patchwork-Delegate: sbabic@denx.de
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,u-boot@lists.denx.de
Subject: [PATCH resend 2/2] imx: spl_imx_romapi.c: remove dead code
In-reply-to: <20230919134932.134678-3-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092118.A002786B1D@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:21:16 +0200 (CEST)
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

> These IS_ENABLED(CONFIG_SPL_LOAD_FIT) cases can no longer be reached,
> and thus get_fit_image_size() is also redundant.
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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
