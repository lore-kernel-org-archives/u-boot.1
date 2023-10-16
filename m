Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128E7CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DBB686DC8;
	Mon, 16 Oct 2023 11:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448126;
	bh=q7CQ0HkGnhor+zeYf04KCy7Gts6Z8F0hf71Vl3YM2eQ=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=umPJeQpLevhp4wNQ08/ZJuo9H9aPGqBnYqSwBCTlvonL1Jo1nRYIbzmc+Xj1ormOY
	 42QRWHv6Z/YtXJnZ7uiEwpj+Udd02bmHMgQAXDTySL/Bl0pFwDuC2rHhQ9fBcCU0Yv
	 kRAiWXlBI9hSniAhj/t8pBS1CIDR6fPZf9mn7cYgpbaltlxMFwtE0yCfK21+e7LXk3
	 3qdPMoeQyezGGvAEj8KFYuQg8s5K6SW0xAyf6Ac4os9kENR5csxS34nq//Uy1tOlLl
	 hEWvOUnH+4mG66FJ4/I1Bma9GG3FxzYixZhWnDzXNzWCjwkph8u2GuNTGF1ukLbNHf
	 BEzkFWMFEV1Dw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B4E086C26; Mon, 16 Oct 2023 11:21:39 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B712586B1D
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BSc3hzjz1r2s4;
 Mon, 16 Oct 2023 11:21:36 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BSc2YtHz1qqlW;
 Mon, 16 Oct 2023 11:21:36 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id Giw-tmAgA3Ds; Mon, 16 Oct 2023 11:21:35 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:21:35 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Tim Harvey <tharvey@gateworks.com>
X-Patchwork-Id: 1825580
X-Patchwork-Delegate: sbabic@denx.de
To: Tim Harvey <tharvey@gateworks.com>,u-boot@lists.denx.de
Subject: [PATCH v2] arm: dts: imx8m: move CAAM nodes into common u-boot.dtsi
In-reply-to: <20230824190356.981178-1-tharvey@gateworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092140.8B4E086C26@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:21:36 +0200 (CEST)
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

> Move the crypto and sec_jr* nodes from board-specific
> u-boot.dtsi files into the common files. Additionally protect the
> nodes with ifdef CONFIG_FSL_CAAM as they don't serve any purpose if
> that is not enabled.
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
