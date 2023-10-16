Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0413CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 11:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B755D86BEC;
	Mon, 16 Oct 2023 13:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697457059;
	bh=Asc/hoyed5P/yGLTnNajBD7Lp+haor5Bl5eypYVaFbA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aYOkSELXBGgxw4PD+HtOtGDgaVKHWD+YpxBz6bIJvxlZ2bvMJiOEgaBSJ1FP0Y670
	 u/dugwgC+CO29Ptf/SiVQga5r+4cqJpOAqojYKm4EnhqQmkKcSaOLQp90tNAHHBF8M
	 s4UW7LM7ZrvubhcIc8AEWKMeQu+XaJpmFGUABRS834EGKiplLSGfCP0wOQVKHiUuCU
	 3reBvF4KXKNRyCSJIgzbJINkkc51dljHd5UNccKl27YM7+zRXOZQRgeERWYBRWZtHG
	 U+xXHVPTC3Y91922+7+vauMpRismOiSAMtXwgYh/oZiFuBd8lXP7OBVJAXFWp4pVuZ
	 KoZ9/6AXcrGdQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230238667B; Mon, 16 Oct 2023 13:50:58 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD65C86B81
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 13:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8Fmv42Jpz1sClr;
 Mon, 16 Oct 2023 13:50:55 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8Fmv3nYqz1qqlS;
 Mon, 16 Oct 2023 13:50:55 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id VqDXFyULbXtp; Mon, 16 Oct 2023 13:50:54 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 13:50:54 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Teresa Remmet <t.remmet@phytec.de>
X-Patchwork-Id: 1822207
X-Patchwork-Delegate: sbabic@denx.de
To: Teresa Remmet <t.remmet@phytec.de>,u-boot@lists.denx.de
Subject: [PATCH v2 2/6] board: phytec: common: Add imx8m specific EEPROM
 detection support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016115058.230238667B@phobos.denx.de>
Date: Mon, 16 Oct 2023 13:50:56 +0200 (CEST)
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

> Add imx8m specific detection part. Which includes checking the
> EEPROM data for article number options.
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> Reviewed-by: Yannic Moog <y.moog@phytec.de>
> Tested-by: Yannic Moog <y.moog@phytec.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
