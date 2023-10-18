Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE79CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D77186F39;
	Wed, 18 Oct 2023 20:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697653071;
	bh=NmcEt3o4x/9mZgRWKieP2xZFqiS0rvl/2qVZ9YXm1Zs=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AtT3yzNC01Mk08c1Dm9fw6tu2n5WX/FgKOXHdUTPFfEw1ogp6UzEU1a9YAIP+FTtS
	 jcc0pxDVH+nhAA+j7H1tpuJNgEb8oB6aKgFQsj1U1TB0e0IrqkYV/Ael/TMmQ6VPmB
	 hfBtTpJOuM1iAD8N5RQUw3OxN1Omv5j7/fS7ur3rqbmyXC0XiNjReL4yMX6jZPL7A5
	 JDgAQUpQFpExdbTtonS/0teSzUHSX6wOENx9LMpimgiwfbOGYgWPLf0EsRLKc4FW5d
	 cgA55SNS570afPejqJMVmqid8iym/q8waWB2BPT3iApimhuTC1wHNmMK4jRKmH8EAf
	 HpnJpgBpPGY5w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E206B87016; Wed, 18 Oct 2023 20:17:50 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0D086DCE
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S9fGN0Z8Tz1sBq3;
 Wed, 18 Oct 2023 20:17:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S9fGN01W8z1qqlS;
 Wed, 18 Oct 2023 20:17:47 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id yjf7AvCJmGmR; Wed, 18 Oct 2023 20:17:47 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Wed, 18 Oct 2023 20:17:47 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1849462
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH v2 4/4] ARM: imx: Add support for detecting primary/secondary
 bmode on MX8M
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231018181750.E206B87016@phobos.denx.de>
Date: Wed, 18 Oct 2023 20:17:49 +0200 (CEST)
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

> From: Fedor Ross <fedor.ross@ifm.com>
> Implement the 'getprisec' subcommand of 'bmode' command for i.MX8M by
> reading out the ROM log events. This event is set by the BootROM if it
> switched to the secondary copy due to primary copy being corrupted.
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
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
