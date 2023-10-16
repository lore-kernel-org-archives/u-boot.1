Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C484CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080CA86D2D;
	Mon, 16 Oct 2023 18:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697474761;
	bh=5JD84AN0t92lz4TQO9Ko7Gtxr23a0WJJykAoroQLVk0=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=KOAdYyGxDEqoBCzMaYfWUhT9EezIpSlggTZk2mwMnCWFBtnsCvZqLlfufxF994Lud
	 pLNhuoeehW5R9tk1NTLPBWE7I8SbXS6Ll6c7msw3JOntxWHOINr/VhUcokhiBb8RmT
	 S7TVvS3tY4tDruBmsAioYaDgLRNljJHLs+Fh/l6T533D2VBgI0IvKqQ+xYIi7lO9Qm
	 QqF532yGHJdc4iLQMKaLPyQiGlHgl5v3nyL2XqYOR7FwdYdFkloNaxhP7qobg6vrx7
	 f6zC2goMq8UmgzrBsO3O6hnK1eiaYjJugfNoFOygy5QIhOfU89TF9Rdg85eW4Z5hY9
	 rzhLn85X1tEFQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E21686CF9; Mon, 16 Oct 2023 18:45:48 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB26865ED
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8NK52Sjcz1r1gD;
 Mon, 16 Oct 2023 18:45:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8NK52MRMz1qqlS;
 Mon, 16 Oct 2023 18:45:45 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id pJW0IGdJ9pWZ; Mon, 16 Oct 2023 18:45:44 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:45:44 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1808229
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH] ARM: dts: imx: Switch USB1 port control to GPIO on Data Modul
 i.MX8M Plus eDM SBC
In-reply-to: <20230715182416.788761-1-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016164548.8E21686CF9@phobos.denx.de>
Date: Mon, 16 Oct 2023 18:45:46 +0200 (CEST)
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

> The USB_PWR signal operation is not reliable on this DWC3 controller
> instance in case the signal is active high. Switch to GPIO control,
> which always behaves correctly. Perform the change in u-boot extras
> until this hits Linux upstream.
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
