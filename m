Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850C4EB8FA5
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 11:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 964AE865A8;
	Wed,  6 Sep 2023 13:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="CigO1b7u";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="SV1z4xzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28AF985DFA; Wed,  6 Sep 2023 13:34:05 +0200 (CEST)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D89386682
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 13:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from ziongate (localhost [127.0.0.1])
 by ziongate (OpenSMTPD) with ESMTP id d57c4d9c;
 Wed, 6 Sep 2023 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=
 message-id:date:mime-version:to:from:subject:content-type
 :content-transfer-encoding; s=default; bh=rHhHyfM2tXwLZnkDzR97R9
 Bi4gI=; b=CigO1b7ujjY3/+WjLCeoVOWYGACzVpSPIGxSxjvmYwVye9tRbdsQnH
 p3422gBbPJlASQDOLZRtNNqeGu+jrcH0HyfMZGZ01FWxM0dd5oUT3S7PMijAVfEQ
 VenVVfMYhh5d4oKYV2j4d745mOFhMtHbBjZYH573tsemWR2B24AlA=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=
 message-id:date:mime-version:to:from:subject:content-type
 :content-transfer-encoding; q=dns; s=default; b=ChR46EpLwwj4BoHz
 gEAgbeFa3GMz/udrOlJ9zVV58DUOaSZPaVsCj0wNCrDqLAJDkmU+2Z14KaGEA7RV
 wH1IL/AtHC+KdnH2V9R9CcYBUewApUwo6caWHpiIT9LNgCnKUVcLemxsHkBm4In/
 7mtXDULV4xOGaNN462GSRWpyhds=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=20190913; t=1694000042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ddCpiLpQ2jNFvpFl0Bnfto+EINdRnr5Z5ZhoePzsoJw=;
 b=SV1z4xzFWbX0/kWUMQ4h7Yeh8vx4QYLomglICv5I6j3oKNb/2e9ICBV2ojL+50XLdl8zu+
 ZNPbzP0SK9tdyVpLU0A1wzqohj5tIErCfY4wkdsZncb4wOHUvx3eWBqf/GkC7d4eIe6MgF
 NccJORHZQOUV5H1G/H1EweL8v3dAUhQ=
Received: from [192.168.0.2] (host-82-61-194-8.retail.telecomitalia.it
 [82.61.194.8]) by ziongate (OpenSMTPD) with ESMTPSA id 856729a4
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 6 Sep 2023 11:34:02 +0000 (UTC)
Message-ID: <4bcf36f4-5297-b635-e60d-2f2baee6ba90@kernel-space.org>
Date: Wed, 6 Sep 2023 13:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Content-Language: en-US
To: u-boot@lists.denx.de, "trini@konsulko.com >> Tom Rini"
 <trini@konsulko.com>, Marek Vasut <marex@denx.de>
From: Angelo Dureghello <angelo@kernel-space.org>
Subject: [PULL] please pull u-boot-coldfire/next
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Tom,

The following changes since commit b53ab97150314674edc25508f4fc528be2baa73f:

   event.h: Documented some newly added portions better (2023-09-04 
11:19:50 -0400)

are available in the Git repository at:

   git://git.denx.de/u-boot-coldfire.git next

for you to fetch changes up to 26af162ac8f8ab3222d32f00f06a4774a061150a:

   arch: m68k: Implement relocation (2023-09-06 13:28:58 +0200)

----------------------------------------------------------------
Marek Vasut (3):
       tools: relocate-rela: Fix BE symtab handling
       tools: relocate-rela: Add M68K support
       arch: m68k: Implement relocation

  arch/Kconfig                   |   1 -
  arch/m68k/Kconfig              |   4 +--
  arch/m68k/config.mk            |   6 ++--
  arch/m68k/cpu/mcf523x/start.S  |  57 +++++++++++++++++++++------------
  arch/m68k/cpu/mcf52x2/start.S  |  57 +++++++++++++++++++++------------
  arch/m68k/cpu/mcf530x/start.S  |  59 +++++++++++++++++++++-------------
  arch/m68k/cpu/mcf532x/start.S  |  57 +++++++++++++++++++++------------
  arch/m68k/cpu/mcf5445x/start.S |  57 +++++++++++++++++++++------------
  arch/m68k/cpu/u-boot.lds       |  14 ++++++++
  tools/relocate-rela.c          | 134 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
  10 files changed, 303 insertions(+), 143 deletions(-)
