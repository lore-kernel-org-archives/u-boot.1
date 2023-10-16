Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC471CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341A9865D0;
	Mon, 16 Oct 2023 23:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697491434;
	bh=IhmXKCNRMYpitJ+eQnuUfN89X8POypbKYwvLDPthQmw=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=y2p/OSK4MNBGzoIoRAbJq2i9ttkKOfaJ2+DyjEQ/a17RBDSx/TfdO+9bkVafLNuMB
	 w4bYlGgEqn8sD1VfV7I00mjyFSMxJIUYXg8hLv2XvSkyA7+gM9N8izpPw66KLZzlJ0
	 SSgMIO8GrposQN1fVl8f49Vd6PS8v6mUWBTuH5Z/OMfh1jYIxxFWn0FhpWuckWu1UF
	 /TtMYzn6aiZVIx5LWCt0Dsp5TaSRuVYtU+abU0HQltpru4oJbQrysH3QAi9yk1uMRx
	 ZAYLgxO834XV1kt8q6DCVR2RIKDW81QoJKyPq+9/yLNrg3gMRQiJ+NL9/kgRniP+bF
	 /xz3echcmPmCQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC19686A27; Mon, 16 Oct 2023 23:22:04 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150D486A27
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8VRq4LxBz1sCHM;
 Mon, 16 Oct 2023 23:21:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8VRq42sdz1qqlS;
 Mon, 16 Oct 2023 23:21:59 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id HWZxDlhSBuzW; Mon, 16 Oct 2023 23:21:58 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 23:21:58 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1809555
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH] mxs: Kconfig: Remove TARGET_XFI3 symbol
In-reply-to: <20230719012548.508676-1-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016212205.CC19686A27@phobos.denx.de>
Date: Mon, 16 Oct 2023 23:22:03 +0200 (CEST)
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
> The xfi3 target has been removed by commit 539fba2c10e7 ("arm:
> Remove xfi3 board"), but it missed to remove an entry from the
> mxs Kconfig.
> Remove it.
> Signed-off-by: Fabio Estevam <festevam@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
