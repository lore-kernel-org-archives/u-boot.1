Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8806FCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30AC86BA6;
	Mon, 16 Oct 2023 11:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448075;
	bh=rKAALl90Brc6QrMaaUntcR9jX4dygEjJaEPKbrmuldQ=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=oOgdUMR+Mw/9LD+3HIhqEhhJpHrcm+Lc3x94uIK60xDEIHdF1RxhROjwburdQB6IW
	 3cn1CyQxlqZ8PZOohLAREPwTfmgN0K3QwlTg+Wb1V1z+JTeWYLM3TyFX7LH29DfZUZ
	 VbSl5dPngEVawWZ5quWuN+9LW73PoVJ7D/W7F84ro56+dUHEoRkV2MbnbVcPwl3Dx8
	 m6RWAV4bomkFnkSlrpIUvSKkCf4HFZCK+fqFVScm8FLKtObOt7UiOLtTf6DUha9Iv5
	 hupJKHWbGS426v0KOH3ztsRNCJiAMcZ3OzPsck/LcJAaAv/YLKU9Q/V57Cpm/Kqp6E
	 cj95HDhDVf/8A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF87A86BA4; Mon, 16 Oct 2023 11:21:14 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99A186823
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BS83hH8z1sCJ3;
 Mon, 16 Oct 2023 11:21:12 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BS83MsKz1qqlS;
 Mon, 16 Oct 2023 11:21:12 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id T5SYOl5h4Qtp; Mon, 16 Oct 2023 11:21:11 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:21:10 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1845249
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH v3 3/3] mx28evk: Add USB Mass Storage support
In-reply-to: <20231009131536.3475878-3-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092114.DF87A86BA4@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:21:13 +0200 (CEST)
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

> From: Fabio Estevam <festevam@denx.de>
> Select the USB options to allow running "ums 0 mmc 0".
> Signed-off-by: Fabio Estevam <festevam@denx.de>
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
