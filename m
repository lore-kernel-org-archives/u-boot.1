Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5310ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B08386F3B;
	Mon, 16 Oct 2023 11:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448288;
	bh=3QHlN49jY/L/XnNVbFa3ZnehID/Lv2+qbGxKDfkjhO4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cjRlLBfJVhRxAF4LmZBAfgX/HuWmM/R0Qz+Fgj3LgH6tksppEFFu/cZ8ID0BZ2lBu
	 P8WRMGaF43rrrOZ7hJiyncjM4AcgE1GRy5keh3jJj6Cjhc/XLAaqnqrxIbSPlMxxi2
	 faJpBtE/e/Sz6L066A57sYenofeyJa15rGxRCUssgnC9vAIu2UfUJUSdgPmXtPftfg
	 Q+6ha6MAne0OAyagcofN69YIxnnUmJuJV6f0Uww1qLuCD/3LtNj8A8EOGCBWM320bp
	 3tx73szub4fWje08J3kPlnmMbKvLK45UEIObRILwOXxVvq2UvbUdSt83ArDG4XOyJS
	 okgUUyzX/OlhQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF6686EE0; Mon, 16 Oct 2023 11:23:32 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C30786F11
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BV8325rz1r3fC;
 Mon, 16 Oct 2023 11:22:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BV82p4Tz1qqlS;
 Mon, 16 Oct 2023 11:22:56 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id jPmJo9OF8KlY; Mon, 16 Oct 2023 11:22:55 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:55 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Andrej Rosano <andrej.rosano@withsecure.com>
X-Patchwork-Id: 1837607
X-Patchwork-Delegate: sbabic@denx.de
To: Andrej Rosano <andrej.rosano@withsecure.com>,u-boot@lists.denx.de
Subject: [PATCH] usbarmory: Add DM_I2C and DM_SERIAL support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092332.EFF6686EE0@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:23:24 +0200 (CEST)
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

> From: Andrej Rosano <andrej.rosano@withsecure.com>
> Use DM_I2C and DM_SERIAL as it is now mandatory.
> Signed-off-by: Andrej Rosano <andrej.rosano@withsecure.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
