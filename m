Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D1FC83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 13:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9530E869AC;
	Tue,  5 Sep 2023 15:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693921873;
	bh=CurRNdZXRccOFp0t5Qlg/PaqzzweNOF1fdXPmLr4dK4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iWekZghQ38Dj1RVixycfS66d0gm/FbreavRjAViQkyiks22xVmW1yLz+VJFxausIR
	 su1Gao/L628p0rpliMwntuym9zAqMYpoiyCG7SVgdgONGTygGjk6a2lP4Uj6ipPH9l
	 5a/EMm5htSfNG3TXaGNO4SLYjxWyT+FeR9wj+ojPoyjmSphDJVZaH+ko62wwHqnI4Z
	 G7LBWWeU2eFHD9Oyb4+6LftVornPtqmjZcS4sutTbvwMG14VHgoZamdZksu0jbHGa5
	 34pRDNfi/xMJIj/rajWiwpT2dfSiCThn+GO7zCwr5ClJM5I4QHnxUmEk0fRdPHmHvH
	 75i0cGLFN6tiA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4994C869A3;
 Tue,  5 Sep 2023 15:51:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693921872;
 bh=CurRNdZXRccOFp0t5Qlg/PaqzzweNOF1fdXPmLr4dK4=;
 h=From:To:Cc:Subject:Date:From;
 b=tcSm+DBl1zSq2Vi1fnDcNxNcs46gYTIhMCewbKzMRNFhzK8bqpJbRfLuerP9mDsuO
 U9LakFCAtqmItLBHu5kqH3I71Yiw7X9ZW0WguyHWIGqs7ncIoqifB+62zNQe0kp5BR
 NKwe5DfgZuent5KfLoAEUtvtkR5pgB1pgFwDF62s13GtzMJ/1RmOKJFooiYCaM7dHt
 eaY9+1CR4xnvJNEulKO6QJxDXuGbpGAK/whjhHRr4fZB8NPsLvNRA92uoyd7RvdVbh
 hG73tw3Ct142dGP4uXZKe/VMiGaoUEXQYnGQS84M3wSmLHk7B9cLBxSSad3zheIzRD
 ZuYb+cS4kyBlg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
Subject: [PULL] u-boot-usb/master
Date: Tue,  5 Sep 2023 15:50:54 +0200
Message-Id: <20230905135054.15652-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
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

The following changes since commit 8999257f219d1e371c2fd66f255b8782897944d9:

  Merge tag 'doc-2023-10-rc4-2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2023-09-02 09:08:54 -0400)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 7f4b73fe6939761dd3891b96628efcab47a0570e:

  usb: dwc3: Fix enabling USB_DR_MODE_HOST (2023-09-04 15:51:38 +0200)

----------------------------------------------------------------
Oleksandr Suvorov (2):
      usb: dwc3: Fix renaming SPL_USB_HOST_SUPPORT to SPL_USB_HOST
      usb: dwc3: Fix enabling USB_DR_MODE_HOST

 drivers/usb/dwc3/dwc3-layerscape.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
