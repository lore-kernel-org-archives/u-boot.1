Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDD7C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 16:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5899B82E25;
	Mon, 23 Jun 2025 18:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77E5782E36; Mon, 23 Jun 2025 16:27:34 +0200 (CEST)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6786B82DA1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.buira@free.fr
Received: from localhost (unknown [82.64.135.138])
 by smtp2-g21.free.fr (Postfix) with ESMTP id C2627200411;
 Mon, 23 Jun 2025 16:27:30 +0200 (CEST)
Received: by localhost (Postfix, from userid 1502)
 id 951BF1519D; Mon, 23 Jun 2025 14:27:29 +0000 (GMT)
Date: Mon, 23 Jun 2025 14:27:29 +0000
From: Etienne Buira <etienne.buira@free.fr>
To: u-boot@lists.denx.de
Cc: etienne.buira@free.fr
Subject: Git server issue
Message-ID: <aFlkUUwIm2JYKj0Y@Z926fQmE5jqhFMgp6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 23 Jun 2025 18:36:34 +0200
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

Hi all,

I try to fetch newer commits from denx.de server, but it keeps failing
the same way:

u-boot.git $ git fetch
remote: Enumerating objects: 81513, done.
remote: Counting objects: 100% (25013/25013), done.
remote: Compressing objects: 100% (3154/3154), done.
error: RPC failed; curl 56 OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 0
error: 51980 bytes of body are still expected
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output

Maybe a hint: numbers are constant.

Can a sysadm have a look at it and report please?

Regards

