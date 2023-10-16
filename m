Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8785DCDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE6898669F;
	Mon, 16 Oct 2023 23:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697491362;
	bh=zpusjoyHJZekkY+nL7T6i4UKSh/7wzskxBXbs9R1gVQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YLmlS8LZXhF2kyICB4XCBs/LBbxjm+SWh7arjTbJUxndcFDKR511emBhNXnqErqn2
	 ELsaPjA4hTUP0n9pji44R1xFRSUCHmxmHqreKYhLi9MBxiZGTXQhSUMbXkENF57GTc
	 uyrKsatDoDUaRuLAp8AjDKZZjXt2Ewk4Zw3/0mAnRAF00kIOIIEqnxXLa/TlWHN+ka
	 ohJjb+kVAUvKhthsUL7HUlcoowaLhsMzvpltjxgvWv9pMZbWVOj0OOjBT4zJN03EeS
	 x98Gzfz+s6dbN8BpUPaiMuuHz/NfMh0QC5JJh76jFI+AjSQC6bdLMF4H5rJthilvOi
	 N4W5jxTZdq6AQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF39D86A3C; Mon, 16 Oct 2023 23:22:11 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9861865D0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8VRz1PpTz1r1sC;
 Mon, 16 Oct 2023 23:22:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8VRz1JKWz1qqlS;
 Mon, 16 Oct 2023 23:22:07 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id j1qxvuv3BS8B; Mon, 16 Oct 2023 23:22:06 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 23:22:06 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1849017
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH] arm64: dts: imx8mp: Make GPIO3 available early in U-Boot
 proper on i.MX8MP DHCOM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016212211.BF39D86A3C@phobos.denx.de>
Date: Mon, 16 Oct 2023 23:22:09 +0200 (CEST)
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

> The GPIO3 has to be available early during U-Boot proper start up for
> DRAM size detect to work correctly. The GPIO3 is currently available in
> SPL and late in U-Boot proper, which is insufficient. Add the missing
> bootph-all to make the GPIO3 available also early in U-Boot proper.
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
