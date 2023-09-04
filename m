Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED8EC83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 15:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E415786963;
	Mon,  4 Sep 2023 17:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693840687;
	bh=EjBr1lvI5MYrc9HThGmFH1M5YJZcB4R8NM9/3FUsXJw=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=drKrshokhIsDOAlux1dOxeadJIfp80YiWGrXo8LltCjfo1Gbw8QGTEZNd3GiuM8S+
	 wWIUbkp0+ZdQAVRMJAIwgzC7h5uDHCRubNe6K+JCz19/KGk4WEtabot4aszcSWcZzn
	 LWgNgMFxBrUF+DEf06XdoUsqFYh3uJkR1Vr5U2xG9pXDqYul85AaHiGXvNvsQ3/iJ+
	 l0FgBkJlvgUulYKuYh1Zs5gSrEmv7zdJKdFXZZH8fWfW17hrzWhfkMcH018JpTPKyz
	 rdLdxDMiWrBk4Op2SzocYd4Cm5KdM7ktL5ylGtk8V6YO0S+uDyzVtVrRhiFjRRW8sh
	 gPnclXs3iIWpw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 331AA869B9; Mon,  4 Sep 2023 17:18:07 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F36869A1
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4RfXMG1kZqz1sDHj;
 Mon,  4 Sep 2023 17:18:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4RfXMG19blz1qqlS;
 Mon,  4 Sep 2023 17:18:02 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id kTee3SW6lVlN; Mon,  4 Sep 2023 17:18:01 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon,  4 Sep 2023 17:18:01 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1828403
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH] ARM: imx: Use default SAVED_DRAM_TIMING_BASE on DH i.MX8M
 Plus DHCOM
In-reply-to: <20230831144115.78505-1-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20230904151807.331AA869B9@phobos.denx.de>
Date: Mon,  4 Sep 2023 17:18:02 +0200 (CEST)
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

> Use default SAVED_DRAM_TIMING_BASE as that is what upstream TFA expects.
> Without this change, the board will fail to suspend/resume e.g. in Linux.
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
