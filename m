Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8401CCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AED886EEC;
	Mon, 16 Oct 2023 18:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697474779;
	bh=WDglYZ7hMelLNl4yVuSIp/N5p0SmAkd/LIi6nZR7o6Q=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=HY7JIe1t5qhVn53t51/3JErg8kliZ+EcpOBaeJh5DJlGJLKTiRvkSpu66GONDuSyp
	 g1EaT41ElcxES0vxsfLTdGajoxBhQQR2lsXG3EZr0/wGA1JTWfbRH5lUCjUqG2yTr8
	 kr8AfyonTSs6wzFMN3nXxlQtdko2JQiwpIvenuj9cf0wA1LHJcbdoQGP/vO8BOez1z
	 kDI6mMMClqvrLbql9fiZPXUCGzcSfbOX2/5dveWDslkms0XupdSrc8q3MmUVejQXvD
	 H8W88IrJbM+C+bUXwsHFK+Hda3FlYcZIUqp+X6FfsRfHAn22dkNxI9T31oQNEg3oDW
	 LDPabAVvk6mlg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB17C86E03; Mon, 16 Oct 2023 18:46:13 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE75286B73
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8NKb3gXtz1sClY;
 Mon, 16 Oct 2023 18:46:11 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8NKb3Z41z1qqlS;
 Mon, 16 Oct 2023 18:46:11 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id rGX9ZFBrslCP; Mon, 16 Oct 2023 18:46:10 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:46:10 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1837755
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH 2/5] arm64: dts: imx8mp: Switch to DT overlays for i.MX8MP
 DHCOM SoM
In-reply-to: <20230921184420.45186-2-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016164613.BB17C86E03@phobos.denx.de>
Date: Mon, 16 Oct 2023 18:46:12 +0200 (CEST)
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

> Add DT overlays to support additional DH i.MX8MP DHCOM SoM 660-100
> population options with 1x or 2x RMII PHY mounted on PDK2 or PDK3
> carrier boards.
> Use SPL DTO support to apply matching SoM specific DTO to cater
> for the SoM differences. Remove ad-hoc patching of control DT from
> fdtdec_board_setup().
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
