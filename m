Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C76CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 11:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A4886BD5;
	Mon, 16 Oct 2023 13:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697457059;
	bh=1CnhNFVGryBpWAdmOMoJjX69kIBeyIRDS+ar40k9Wc4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I55EDwUMz+94XvorruylrPJFghyMz37uATVtZ0a/V2kWuM5huPod1+qyanPI9yEC5
	 YE8b3xnp+bS/w+gTWIrDdrkJUPDcx4wzE7Z7oePVjmtzJIBSu+As1o6ONuJbB1RIof
	 NF+seO+8iryMj5Gzv+706bVo0arUVcNNZpOMov22gVSBDYa1duL1izuB/7mn0wRTzb
	 jiCJcAuValdFR2zv2K3BwC7rhDhF5Xu2Si7bKKR66/+JE0WzW1tEusmDbQxW/sUFQA
	 vO7fmv2KTva2WBPJWHc/eP2IOcX2rCruMx3X3f2XhdYpDeHSQGWqC2p9IBjZTEeIY5
	 txnc9acMSntpw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB8186BC8; Mon, 16 Oct 2023 13:50:56 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0419A80090
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 13:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8Fmq5cydz1sClr;
 Mon, 16 Oct 2023 13:50:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8Fmq5MSbz1qqlW;
 Mon, 16 Oct 2023 13:50:51 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id AnUufmAap0mL; Mon, 16 Oct 2023 13:50:51 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 13:50:51 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Teresa Remmet <t.remmet@phytec.de>
X-Patchwork-Id: 1822206
X-Patchwork-Delegate: sbabic@denx.de
To: Teresa Remmet <t.remmet@phytec.de>,u-boot@lists.denx.de
Subject: [PATCH v2 1/6] board: phytec: Add common PHYTEC SoM detection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016115056.6FB8186BC8@phobos.denx.de>
Date: Mon, 16 Oct 2023 13:50:54 +0200 (CEST)
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

> Recent shipped PHYTEC SoMs come with an i2c  EEPROM containing
> information about the hardware such as board revision and variant.
> This can be used for RAM detection and loading device tree overlays
> during kernel start.
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> Reviewed-by: Yannic Moog <y.moog@phytec.de>
> Tested-by: Yannic Moog <y.moog@phytec.de>
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
