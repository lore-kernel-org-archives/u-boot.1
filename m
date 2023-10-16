Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9CCCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB0D86EE5;
	Mon, 16 Oct 2023 11:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448285;
	bh=QG8/C2XPZRhfli2BKUB2Y3N9oIToXmPskGRFWOkK47M=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=kSVt5WYeTfk98j1/n9gvk0I4vagohh5m3XzNdPamZAFoGyQFtvb+DEg61tWggUdSR
	 RXEPQ+Lpkoyd09UVkv0ag1y7QRxsD7umgsz7N+Jqb1GvjiHgufdKYaV5l5nHcwWiWz
	 rhExYLwVLyX7Eb1kIxcQSDbEVQ5sQ4ENpfbfCWLxH9OYzVBYVESRXfS9JUEUBLIt4i
	 Sl2bcc8j+Z7vkqVVhj+++uUg2KAhnLUx4lL0bf3pDw5TExNgXUicujC2aRNSOVFcYv
	 shMJW+ZLgsAX3gL9zPv0FVcxewd2K2KNPwgCsJ4Zgtxs6L1ab873wRvO+QEEtYLVaF
	 uKd95GbSU5sRw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFF7586B79; Mon, 16 Oct 2023 11:22:37 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5202986D4A
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BTh4bQ0z1sClY;
 Mon, 16 Oct 2023 11:22:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BTh4V5xz1qqlS;
 Mon, 16 Oct 2023 11:22:32 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id UtEqaZSUlIs7; Mon, 16 Oct 2023 11:22:32 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:32 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marcel Ziswiler <marcel@ziswiler.com>
X-Patchwork-Id: 1824378
X-Patchwork-Delegate: sbabic@denx.de
To: Marcel Ziswiler <marcel@ziswiler.com>,u-boot@lists.denx.de
Subject: [PATCH v1] board: toradex: verdin-imx8mm: enable usb sdp spl recovery
 support
In-reply-to: <20230822221726.8355-1-marcel@ziswiler.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092237.AFF7586B79@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:22:33 +0200 (CEST)
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

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Enable USB SDP SPL aka serial downloader recovery mode support.
> While at it also enable fastboot support which may be used to
> subsequently load further stages like a Toradex Easy Installer FIT
> image.
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
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
