Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46635C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00E48745E;
	Wed, 31 Jan 2024 16:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="dUERiLM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C615887732; Wed, 31 Jan 2024 16:43:54 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3F218718A
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1706715832;
 bh=jCcaIv9VznjsRafXYln25vjfGDjetw13elLa1Bfrvh4=;
 h=Date:To:From:Subject:From;
 b=dUERiLM20c9rCGnh2/tKr+qQnNC7mfg7yI1OvsV0N7BFgWQqFIepRT7hD+QJfPMa1
 jRb8QWdDaTtmS8pF2xRjHZ0aV7dJZJu5XzKxFS0ILRaPkSyMTyJpvsh7DnNFhf9Lwi
 mKTPKIF+/z0fKIyM6KwLgQ2Dvq+cgJOKikAm9tMKoAyZCEZTSdbLpfTVQtzkf7EQb6
 VxBHK/VnGJo1HMnRspqryc0oh7DBYejODh1Q1YyFOBOpEImai/SNiK4CXm2pgO2urN
 r+syc0Lh/G5NAJp3qDJqvdC2wimDJoR6tiJhJmh5e9EhgxQudi4JTNsq7cTJDCb6na
 7pfoGu173Kj5w==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 72DE037803EE;
 Wed, 31 Jan 2024 15:43:51 +0000 (UTC)
Message-ID: <3e025444-6116-4898-a718-d718265e233a@collabora.com>
Date: Wed, 31 Jan 2024 17:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PULL] u-boot-at91-2024.04-a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello Tom,

Please pull tag u-boot-at91-2024.04-a , the first set of at91 features
for 2024.04 cycle.

This set includes some DT alignments and solves a compile issue for custom nand
defconfigs.

Thanks,
Eugen

The following changes since commit 3c04fcf3137d5f694d52b8f355373e4baabe5f78:

  Merge patch series "k3-j721e: beagleboneai: Fix USB" (2024-01-20 11:39:13 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git tags/u-boot-at91-2024.04-a

for you to fetch changes up to a1c6b08274e18e4afc0f78a2f63609880aa7ef08:

  mtd: nand: raw: atmel: Remove duplicate definitions (2024-01-22 06:05:26 +0200)

----------------------------------------------------------------
First set of u-boot-at91 features for the 2024.04 cycle

----------------------------------------------------------------
Alexander Dahl (4):
      ARM: dts: at91: sama5d2: Move sfr node
      ARM: dts: at91: sama5d2: Port ebi/nand nodes from linux
      ARM: dts: at91: sama5d2: Align more node names with Linux
      mtd: nand: raw: atmel: Remove duplicate definitions

 arch/arm/dts/sama5d2.dtsi          | 74 +++++++++++++++++++++++++++++++++-----
 drivers/mtd/nand/raw/atmel/pmecc.c |  3 --
 2 files changed, 65 insertions(+), 12 deletions(-)
