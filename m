Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE65C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 16:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351B5881A2;
	Wed,  5 Jun 2024 18:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717606233;
	bh=zlrEQjyurdPYpmkAA6glk8XDmjByRPG0GB228v01sjc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pKfANAkcjG/WKhS03UZRWSm4La/Vaho1p0DJQ5BQaRhUgyBzKpbFcHzQTFS/0l0af
	 usoUltU1lWgu9JTcfQo9fQypdQNP0IrtE+/QKL/gYGFIb7CV0U2HcpgDERFEIewAU0
	 ryJW5WjWXt7E5KYxyopzxGoKhE5JLqMQV6a576EZhYFxKNJhbcYTWskAzyyQLPNohq
	 TdXjgC7yokkPp9G6vstg4A/zS3WS8L6Y59pDs35F1mFunFv7nJnW8geMKMLwrZ0dbb
	 tWfEwoOK02WJkUsCyhH+rFtR7ObfeSh35BTRRAztHCcA9V333beigFAi9XsjgkycH5
	 ZQCvquaKwaDBg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9011887BF4;
 Wed,  5 Jun 2024 18:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717606231;
 bh=zlrEQjyurdPYpmkAA6glk8XDmjByRPG0GB228v01sjc=;
 h=From:To:Cc:Subject:Date:From;
 b=Vt82s9PDr1I1dA8VTKulXeTa9VoRtP5m+MX6BW4o2rEbiJrHmOHWoVAdfMHKPmuaQ
 p2a1kxNf8OKUJl2nCIk7MC9cmmMgsjPyvWDa4xLMDWXiJqlg5CCFA8FvHUaRDchqWf
 s+1gOIgKUQVV5ADHLcORL3lCZ9wq0LxwB4B9xgRG5KvJgtqt+n3IZOMVVELCmfDGEO
 eVHFHVHSBrZ7vWHNQeWtCpu7AkkFLyrgxgP1Ry1mOm2STasdK4JCk5ddMb7g6+tdy0
 RhvrRaYpKHljOTclZ2wjndOtZFAsWPLzipeWzn21HG7VZie0NZengw5kejqJ+LagEK
 4GJS97kATS6Cg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	Heiko Schocher <hs@denx.de>
Subject: [PULL] u-boot-usb/master
Date: Wed,  5 Jun 2024 18:48:53 +0200
Message-ID: <20240605165011.11850-1-marex@denx.de>
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

The following changes since commit ea722aa5eb33740ae77e8816aeb72b385e621cd0:

  Merge branch '2024-05-29-assorted-small-fixes' (2024-05-29 11:21:14 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 8f8b4b0833fb8e890d053860ecf1c39d037c8039:

  usb: remove not used variable in usb_ether_curr_dev (2024-06-01 21:42:09 +0200)

----------------------------------------------------------------
Heiko Schocher (1):
      usb: remove not used variable in usb_ether_curr_dev

 cmd/usb.c | 3 ---
 1 file changed, 3 deletions(-)
