Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DE6C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 16:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDCCC82EC6;
	Fri, 13 Jun 2025 18:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="UsM602C4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 520DE82D39; Fri, 13 Jun 2025 18:13:16 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E6082D09
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 18:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=srv_ts003@codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a8XL55Vbore/7WGssKPmeAIh119NlaVhIWsFSSo2htc=; b=UsM602C4wL3iQPrxzZGacDAN3I
 UP/cfE51QI7xoJ29IPEtGGVB8Ovg40S+Iz195HiQ9Qg4A6lYhad4eJPKMPqDiFJ9SUww2v2o517OQ
 57BqON7i09wWG+j8MJkNhxccL/2au2EIAe1LFE4exBd/j3GB+QaWS90JI6vi66DGuIPEp11zHRszH
 F6E0EnO9vk1tvkJ6wHQO7NMrB8koogJZekfu0vDnFi8xOE0La2zu7tCmFDKFGg/yHXAvEZppHtYQc
 N2EwO2VAbH8/lfJZ9yKunk16zpV3E+EBr90w5wdlAfkoSEDVl+yA1iE6d0IuskLU2xtErPYmdSWd9
 Wf7KssAA==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uQ71X-00Dpwp-B1; Fri, 13 Jun 2025 17:12:59 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uQ71X-00000007ZpS-00B9;
 Fri, 13 Jun 2025 17:12:59 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: rick@andestech.com,
	ycliang@andestech.com,
	u-boot@lists.denx.de
Cc: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 ben.dooks@codethink.co.uk, trini@konsulko.com
Subject: Add big-endian build option for riscv
Date: Fri, 13 Jun 2025 17:12:56 +0100
Message-Id: <20250613161258.1805957-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add the option to allow building a RISC-V system big-endian.

This has been tested against our big-endian qemu/cva6 system
and is the minimal base to allow a system to run big-endian.

We don't yet address IO endian which has been an interesting
issue, as some code seems to assume big-endian means big-endian
IO.


