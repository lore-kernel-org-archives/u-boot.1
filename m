Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E5ACDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D60086ECB;
	Mon, 16 Oct 2023 18:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697474774;
	bh=UZpBJjsO/Jc5ygGJTrN6R+X13RILYiB9vgM21D2xm7M=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=jzCn39JoP6UUBwywl7QcI56V185LxiWzTAa9aKz9BE6iIFimxI6XbUZho96ifMpEB
	 WZqXNg6iq6ITiGdFqxroc5OX8ro5F9fpZs41A15cxVmj3X2PAOBjhxw+m5TTzP7mCz
	 /NvYMnmtL3652ii42rwlZ71vCHi3dm5Q0ZfJleDamjmgpcxiOl8iPRTmfsfl7nxlO0
	 +LBEDpSE/qHKVSYKGXv4BHggFkl0QqHOFF55jgWQHJq7WIVzK782AP/kNBe7xgGUoz
	 dxPwPf6UYh6k5XMsQrEN5v6LxmUrT2tsCgmPqeLP7NNQZFlc4MwDj8QvuqeBIxV9sC
	 gg+gjLpE5enFw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D01286940; Mon, 16 Oct 2023 18:46:03 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC02A86DCA
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8NKN2wpXz1sClk;
 Mon, 16 Oct 2023 18:46:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8NKN2Srwz1qqlS;
 Mon, 16 Oct 2023 18:46:00 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 0n3CDOVhE9PQ; Mon, 16 Oct 2023 18:45:59 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:45:59 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1837758
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH 5/5] arm64: dts: imx8mp: Add DT overlay describing i.MX8MP
 DHCOM SoM rev.100
In-reply-to: <20230921184420.45186-5-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016164603.1D01286940@phobos.denx.de>
Date: Mon, 16 Oct 2023 18:46:00 +0200 (CEST)
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

> The current imx8mp-dhcom-som.dtsi describes production rev.200 SoM,
> add DT overlay which reinstates rev.100 SoM description to permit
> prototype rev.100 SoMs to be used until they get phased out.
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
