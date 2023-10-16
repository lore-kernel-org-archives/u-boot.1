Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CAFCDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A313486F08;
	Mon, 16 Oct 2023 11:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448286;
	bh=ejTKY7jBVrDCDKap4DcFZHDfSPbs6vr4c+B8Z5Fpvm8=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=LLf0QFb3MHUGbvdy+ezOJTxpfQr4C9g7GSVtlClxpq3F+DT300CzyabcHImEyo6F6
	 1mXADLQXE8swAw7wxkaS0W71+t7ITtJxD7+EQo/lxsZUO6B9BBreCrfmlF4y0umhwC
	 Rp+oREWwTuC0M75zFpEHRvFtW+Vrvz6FCRiaR8H1iGiHEbJBHtDZiUcrEMDSxwXY3C
	 NE5nlV12wJqKpBfP4HXPcIvbXGjVYtPtrikpPmWajfo1eIuEH3f1+A1rf8JH3SpUUS
	 u5tz8z9BfsCSeh8X/yzqOHkNWrhn11J8x8WQxyP9MDqAEFKuIX3nagsV+Y0EiTKGW7
	 pEPjFOPe0RqKA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD6B86823; Mon, 16 Oct 2023 11:22:45 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD4486DEB
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BTm3KB2z1sClr;
 Mon, 16 Oct 2023 11:22:36 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BTm27msz1qqlS;
 Mon, 16 Oct 2023 11:22:36 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id hdopRqVdXN5P; Mon, 16 Oct 2023 11:22:35 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:35 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Francesco Dolcini <francesco@dolcini.it>
X-Patchwork-Id: 1843605
X-Patchwork-Delegate: sbabic@denx.de
To: Francesco Dolcini <francesco@dolcini.it>,u-boot@lists.denx.de
Subject: [PATCH] toradex: verdin-imx8mm/imx8mp: Remove bootcmd_mfg
In-reply-to: <20231004191358.24488-1-francesco@dolcini.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092247.9FD6B86823@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:22:42 +0200 (CEST)
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

> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> The bootcmd_mfg env variable is legacy from IMX downstream u-boot branch
> and is not needed on mainline.
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
