Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F79C41513
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5102A86F28;
	Mon, 16 Oct 2023 11:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448198;
	bh=HI+PvKRjUuvJT9ma5otMLhRIH+ida9o6yaC1bJQK0N4=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=CXjl42jKF4FxGKTTQrNiOxALNZYoEnsFL3lsWtUGe8dh4NTN5Fzx7TFsbMGHqBz/R
	 lYJ+RI8RIn/nDOZzPiYqAECDGMgLwKLJ2wzOJmUUWNwuZHsANqOn4rFktEdH0pLDmQ
	 b58/EO8dI2E92nwu8BjWRmp04NzxLzx7LuFPRFp6U5snOKsxaA0S0tuihH5IlyL2/s
	 OF5KpvWsy+uU6UhdathCePCEMN6uQ9iBn8sHsBJWNz/W/sBfpSv6/7BjkwoULeTX14
	 DbI+T/fLJCt/d+E5M4XndP2HbrkpQJ/QoFWZ3/D0yDfATU3yNe6AXjb0GUyzYJBf3E
	 FGlMazVJcnuvA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC2F86DCA; Mon, 16 Oct 2023 11:22:35 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BEE286EF2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BTX6p0Kz1sClY;
 Mon, 16 Oct 2023 11:22:24 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BTX6hz5z1qqlb;
 Mon, 16 Oct 2023 11:22:24 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 4ox1k2RrCZe3; Mon, 16 Oct 2023 11:22:24 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:24 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
X-Patchwork-Id: 1837172
X-Patchwork-Delegate: sbabic@denx.de
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,u-boot@lists.denx.de
Subject: [PATCH v2] mx8m: csf.sh: pad csf blob for u-boot.itb to CSF_SIZE
 minus IVT header
In-reply-to: <20230920103352.154366-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092235.EBC2F86DCA@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:22:25 +0200 (CEST)
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

> When built with CONFIG_IMX_HAB, the full FIT image, including stuff
> tacked on beyond the end of the fdt structure, is expected to be (fdt
> size rounded up to 0x1000 boundary)+CONFIG_CSF_SIZE.
> Now, when the FIT image is loaded from a storage device, it doesn't
> really matter that the flash.bin that gets written to target isn't
> quite that big - we will just load some garbage bytes that are never
> read or used for anything. But when flash.bin is uploaded via uuu,
> it's important that we actually serve at least as many bytes as the
> target expects, or we will hang in rom_api_download_image().
> Extend the logic in the csf.sh script so that the csf blob is padded
> to CONFIG_CSF_SIZE minus the size of the IVT header.
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Marek Vasut <marex@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
