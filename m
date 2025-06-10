Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECD5C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 15:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442FA82B95;
	Tue, 10 Jun 2025 17:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="VaZ5Ylec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E4F482B0E; Tue, 10 Jun 2025 17:19:10 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BACB82B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 17:19:07 +0200 (CEST)
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
 bh=tWGRNIYCkzhqzHe0qKlZkuc2NoYj0Vt/iWTVc76qrj0=; b=VaZ5YlecWYJ59woZW6gaSjmtdo
 i1X4ncFBNYa2bfDSJ11ZwH9BBnBvaJPj+Uq38ZCSbWOPmygRnW5h2eWrjZL7jMigd9Z9ks62Y+M7p
 nDWKTlTPqI0AlU8o83x1Gy3rY5vp+S+3MFUnLzv/G5KayPqZqSiBa6o5Sk5LpuQO0r5dcH95Ck0lB
 88hFE75kufVD4TVKjpKYmPl7Yu/99eHeWaJsQvOx1cg8pzcedSopwU9XioI4Mspg0mgG+QrKWNU3w
 IGT4c3Qs11it7FpaZR47B3DBVZ29AGkuV1l1CDDxF9a18F+rKfozSr0NgA9IP57E8bEi4i84q0TEE
 +FETEgpg==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uP0kV-00C1EL-QJ; Tue, 10 Jun 2025 16:18:52 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uP0kV-000000071ID-0gom;
 Tue, 10 Jun 2025 16:18:51 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: rick@andestech.com, ycliang@pr-suspensions-neuweb-biz.expedrion.biz,
 u-boot@lists.denx.de
Cc: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 ben.dooks@codethink.co.uk, trini@konsulko.com
Subject: riscv: start on work to allow big-endian build
Date: Tue, 10 Jun 2025 16:18:48 +0100
Message-Id: <20250610151850.1673111-1-ben.dooks@codethink.co.uk>
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

Given we've been doing work on qemu and linux-kernel we started
looking at u-boot too. I've done a quick test with our qemu and
got a few patches going.

It looks like there are only a few updates to get the build
working. The only question I have at the moment is with the
read/write io macros which seem to be incosistently endian
interested.

project at: https://gitlab.com/CodethinkLabs/riscv_bigendian


