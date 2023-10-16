Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EEBCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805FA86F03;
	Mon, 16 Oct 2023 18:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697474818;
	bh=RnFcYe3kqRe9ucVQx0K0++RKP5zXlu2pOhJzvPTdTwE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hmUmEOckJtW7K4Pyu7cHcFX5xUslRr3L8uY6DC5U4OYT2DD2zIaVqLTvUNUXCE00C
	 uHNkk5aTt0+kogDe56smQHbviO7641dGtNlQ9j0SjEvHu5xI7hw1HNWztpclwrnZiB
	 QW4OqOe9XcergKDWi8GsItdHCC0ImxDs4TkXRzIiFGY5RCbaOCer5kqHP7O/9A6KMw
	 kMvrE0ohS7QUO8ciPXamkJtD7Z3VIjiwxhPm5wrj+LZvTGwxKezVUVx/wuR0BOIVjv
	 CaxkoS8xbI+qaWLEKjakBccdP4iUkQa9XRSace6R1dKYaVxm7ShZKsMHDQruPKzpE6
	 33l+qj0KeVu2Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3003786F1B; Mon, 16 Oct 2023 18:46:48 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F6B86F16
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8NLC2HDwz1sClY;
 Mon, 16 Oct 2023 18:46:43 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8NLC0tyQz1qqlS;
 Mon, 16 Oct 2023 18:46:43 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id o0FLGWfbsG2P; Mon, 16 Oct 2023 18:46:41 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:46:41 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: =?utf-8?q?S=C3=A9bastien?= Szymanski
X-Patchwork-Id: 1812304
X-Patchwork-Delegate: sbabic@denx.de
To: =?utf-8?q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/4] clk: imx: add i.MX93 CCF driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Message-Id: <20231016164648.3003786F1B@phobos.denx.de>
Date: Mon, 16 Oct 2023 18:46:46 +0200 (CEST)
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

> Add i.MX93 CCF driver support.
> Modifed from Linux Kernel v6.5-rc2 and adapted for U-Boot.
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
