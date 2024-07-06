Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5569C2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 15:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B888865F;
	Sat,  6 Jul 2024 17:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720280826;
	bh=fCvJXqYJ0gcULzuqnlB4jmKv0YC97KrR/xKwoQp4N10=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yHgMa7OWoZNyJf3RvGkmi1jApZORnH8P110qMYVco0SOPwkIlIxGoCyXiA18yqmwJ
	 +nhcrtaCeFKJOzNPO5slL8VzRSYtXTnFDAB3BAAZJN3jFMSyNawmU2Y7T3UtBaEefh
	 nbwJ4VUR6+F/AAS57ENZxz5zLUhXq+jRdObKLQ6uCgJ+6FT1BM/t1TeUiXwGnJodB2
	 eDRKT2kkUIeaaGjE0UBXTgpjInVZM7IbABY+MjRbn4JALMeXCbtufiKSLQuQdiDcfF
	 zTfEZ8Yu1NEWxHEsq46DiXgghSQK7+2zCEpZGKcl2sbh0eErzoG3idy+vMZgcJYln/
	 gy8YfIu/LzsJg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CDB1388630;
 Sat,  6 Jul 2024 17:47:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720280825;
 bh=fCvJXqYJ0gcULzuqnlB4jmKv0YC97KrR/xKwoQp4N10=;
 h=From:To:Cc:Subject:Date:From;
 b=qjLSuJxdqqCrp0IsHJEtBOdI6mpbAKMjGNaYvvJRsybe+nQZX7DSMkcgk18bOk3Xs
 l8RPnHesC+UJ9xNMUkasgZKdqHc2tFjL6+pen+UW8TekJbdR++tOjQEVBsJKy3/5es
 4rvaWW/qe3++OOOMy8MqHqpNfNL6MTWlvHSEdYxqnilthYDYsG0dPVRR0xekKcr+XD
 PUxjFREyILG9nEkQgrS6DMmIPWm2mUvY+5OP00F4QgEz5igZ33f7zCwSq/vUbnVR2u
 prLsEI8A+M4+D7lnGSB0EANj5WQy0s9RtjKCOHuIW5YiDbR72xRCovH9MGKmI096to
 sVZ7/yf4AjyDg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	Philip Oberfichtner <pro@denx.de>
Subject: [PULL] u-boot-usb/master
Date: Sat,  6 Jul 2024 17:46:39 +0200
Message-ID: <20240706154651.63607-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

The following changes since commit fd46ea0e701920eb205c2bce9d527bf0dec10b59:

  Merge branch '2024-07-05-assorted-updates' (2024-07-05 16:36:43 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 2fc8638403c740e2dffb8d338bb58694779fd0f9:

  usb: Assimilate usb_get_descriptor() to linux (2024-07-06 14:45:34 +0200)

----------------------------------------------------------------
Marek Vasut (1):
      usb: xhci: Replace terrible formatting with different terrible formatting

Philip Oberfichtner (1):
      usb: Assimilate usb_get_descriptor() to linux

 common/usb.c                 | 37 ++++++++++++++++++++++++++++++-------
 drivers/usb/host/xhci-ring.c | 18 +++++++-----------
 2 files changed, 37 insertions(+), 18 deletions(-)
