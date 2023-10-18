Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860FECDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F56F8702D;
	Wed, 18 Oct 2023 20:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697653102;
	bh=pXx9l80kUf1z0Lnm+GQhdQ6F1a99/7KZHOCBnaaaTw0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iI9COlzPgh8nfUP6yKauEztUFQy2/b6628tMMpFz1TRyE1YBkNUyZTKaRTkWu1KGA
	 JjoDO4ucYMrobmXivcTXnjMPzEb+WSuxTglO9RV5YxUAmMp0Hem8ArqBxr03Bnlg8N
	 SHmPuZGwkIKEB7ell+HQmplo4c3C8JIKUPh/gBDJ3V707fsl/J6bn7EJyxK+8N6hXy
	 m7voLDwJs6FVqAYOwRR99T5ZtP02pFfJulyq7fp1P3FAycgWSks17xvWj2WsrgweGQ
	 i9klVQQEdZN7NPX628u827rMzgv/j8csiKbaiXj16uUJLUFitF00TgQLhSWUoE9QKV
	 FI6ELp6KCOXPw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4874787024; Wed, 18 Oct 2023 20:18:09 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F100387018
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S9fGk5QMNz1r1sW;
 Wed, 18 Oct 2023 20:18:06 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S9fGk583mz1qqlS;
 Wed, 18 Oct 2023 20:18:06 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 2r038DZIFmA8; Wed, 18 Oct 2023 20:18:06 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Wed, 18 Oct 2023 20:18:06 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1849461
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH v2 2/4] ARM: imx: Factor out parsing of ROM log
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231018181809.4874787024@phobos.denx.de>
Date: Wed, 18 Oct 2023 20:18:07 +0200 (CEST)
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

> From: Fedor Ross <fedor.ross@ifm.com>
> Factor out parsing of ROM log in function spl_mmc_emmc_boot_partition().
> This can be helpful to detect a secondary image boot without fiddling
> around with MMC partitions. This way for example, U-Boot is able to
> detect a secondary image boot and can enter some fallback scenario like
> starting a recovery mode.
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
