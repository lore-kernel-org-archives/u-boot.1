Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBACCDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0922A86F18;
	Mon, 16 Oct 2023 11:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448287;
	bh=MLLAOWsUBBD8q8mwrNr+BD1cH4toU+U1eZJHEAythoc=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=HLtDuFsGx7UqBnmUQY7p2IPRLrCPBbJMU/3XDS8Z9t99jRDwl7GOKAIyPNmRFsMPV
	 qX6MFcI8iE0C4/MKCWwwZ2L0U5uBUfo11HAQboC22pwLbBFCKn6e65t7RysrRBooWD
	 /p1AucdD7ZdMwiEH6iXLcU+o99P9tP3X+Beb+ZRRb6OkvsOlWx3uq3NXpLKZl80HMy
	 +HJz75Ih+w5+gvxfzZNCeXHOdwd8CneKy4mQ96T1gVOwXOOmPFJYzV4LQvwVGdk2zU
	 dU+1yF9007iYWRztWSvJopo+GkrOq1uB05WvHjeEXJOm1C3WJu/AMfLY0ki52hgnjL
	 hyjBNRuYq3wwA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8CD686EF6; Mon, 16 Oct 2023 11:23:05 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0420D86EA8
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BV33Bnwz1r3dg;
 Mon, 16 Oct 2023 11:22:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BV334c7z1qqlS;
 Mon, 16 Oct 2023 11:22:51 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id jSMRGnNhTDZF; Mon, 16 Oct 2023 11:22:50 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:50 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1845248
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH v3 2/3] usb: ehci: mxs: Use regulator_set_enable_if_allowed()
In-reply-to: <20231009131536.3475878-2-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092305.E8CD686EF6@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:23:04 +0200 (CEST)
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
> Since commit 4fcba5d556b4 ("regulator: implement basic reference
> counter") the return value of regulator_set_enable() may be EALREADY or
> EBUSY for fixed/GPIO regulators.
> Switch to using the more relaxed regulator_set_enable_if_allowed() to
> continue if regulator already was enabled or disabled.
> This fixes the following error when running the 'ums' command:
> => ums 0 mmc 0
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0xece000
> Error enabling VBUS supply
> g_dnl_register: failed!, error: -114
> g_dnl_register failed
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
