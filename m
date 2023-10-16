Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7025CCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7147886B79;
	Mon, 16 Oct 2023 11:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448186;
	bh=OijaMEpCHX++nYKGuAk+vsUSIbxzSH7H0TDEbYuJ8E4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rsZwE2xcgPOF3f2PzTLYebvOBXf3ELP5QivK5FurcDu6cO8rClaOtWb26aBOmIrCm
	 D8QcIoHqQ/dxV0uaAKqUWa4qyhKD/F+1Axb5sk9t7VnMDmxPbJedJNQBrP6mJtpFi+
	 o1b/ByeH4R7xAjOP4GPcWMdTN7/vvzeSjbheFF0tMaTEQtMUh3ZSrSHcUqwGX+JqpQ
	 C2pRoVU0KB759QB3mJyV0nLyxxDwEYaG9QmNBCTJfQAluxccWgXHbZrLWp1rRJBk1x
	 Hp7NKsMPxPFvEmpDQz3pNbIaE8UhQGSp8Rnw+ZnUxQMI47ZSw42ejcBIcqHnc0huz6
	 LqmrwYjeMgsxw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 963C986823; Mon, 16 Oct 2023 11:22:16 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C913586E16
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BT64F6pz1r3FC;
 Mon, 16 Oct 2023 11:22:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BT63d7vz1qqlS;
 Mon, 16 Oct 2023 11:22:02 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 6uYxtSLlCm2W; Mon, 16 Oct 2023 11:22:01 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:01 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
X-Patchwork-Id: 1818580
X-Patchwork-Delegate: sbabic@denx.de
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,u-boot@lists.denx.de
Subject: [PATCH] arm: dts: imx6ull-14x14-evk-u-boot: add rngb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092216.963C986823@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:22:02 +0200 (CEST)
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

> From: Ricardo Salveti <ricardo@foundries.io>
> Linux microPlatform uses an rngb device in optee-os in boot scheme
> SPL -> OPTEE -> U-Boot. To make rngb available for optee-os, enable
> it in SPL.
> Signed-off-by: Ricardo Salveti <ricardo@foundries.io>
> Co-developed-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
