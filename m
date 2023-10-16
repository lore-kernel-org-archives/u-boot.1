Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7BFCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5025086F0D;
	Mon, 16 Oct 2023 18:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697474794;
	bh=BuHakO2uxdK6FdBkSBlMEPGoY6ACb3AtRxzvJJlYZCg=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=D0rSnv8RWSzPfPepWRCq3GQmH8BM8/KYibqOhYKOZhqtd7LF4J08DQb5LU4HEv6Uj
	 RUjIhVPAru+HnoPRvf9XlCcxAbGNKnWTPETvJZuOwecydwrjVNwgv/31vYv5C8CYHk
	 M113ZGPi1DED4+nhshbVKLIDP8Th5iCvfnUKSGzW5/xJXhxs3fzzfVDDetlrtfsT0z
	 bBi1VX8A0jeXrqEsCNLDvhOrMBQZG9g1/DfWCrqztYjBc0R9KR8CvhcZTqQTYzKuqa
	 7hxfB6D37svrb9MuJT9EHy4dloj3aNg6EhYzu0/N6nMlzYSy+y1lVSeDNgoUj0lSCK
	 QtOW6pcUljArQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF47A86DDE; Mon, 16 Oct 2023 18:46:26 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9D6D869EB
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8NKp4kRqz1r1sW;
 Mon, 16 Oct 2023 18:46:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8NKp4bpzz1qqlS;
 Mon, 16 Oct 2023 18:46:22 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id moCNRlyL04j0; Mon, 16 Oct 2023 18:46:22 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:46:22 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1819033
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH 2/3] mx7dsabresd: Convert to watchdog driver model
In-reply-to: <20230808214040.1382330-2-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016164626.DF47A86DDE@phobos.denx.de>
Date: Mon, 16 Oct 2023 18:46:22 +0200 (CEST)
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
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
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
