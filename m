Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1ABCCA490
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 01:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 338A580F62;
	Mon, 19 Oct 2026 01:41:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 92vzb8frQ4la; Mon, 19 Oct 2026 01:41:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E70B480EC7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792374085;
	b=KIu2EcbuE38ReCVWvwmUmBLJQLUuFRbKMPNNV/FGC2um6jkB6D4BVTfZLO2Vkct0qTJW
	 b3QwsUQ38wULYA8rvB4hbzXSg+V+VL672Arh+EOAT0DOQ/yUUb63+KFbZuWVPCctX5klk
	 V7IRU3kuTjWAMy3ZhYCSrbtX8ZOkK+6BGJuS8nAaFEbK/cjs6/K7IK1Ilt3sDDQ3VPgll
	 AWOcogiLJKJkOSHgTJu26RTjpXFA3ZhNFktJhN6cz6vBDnHWElCkOABJr1nkOADXlMK3P
	 RcpmjVcx0+xBCXxNan07ifCBcaEXpnqwr0X9FQhq7ce5qDKytop090LhMh/2124wPig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792374085;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Z0l9S749yt5i8xtbU0t8+NQZiV/1wIhpyfc5E1WoWp8=;
	b=hux62u+xHMLPwtWS937KJWMCUuH3TUzM72dh1HqDD3rCnUVRrBq0IRy5293+lOsCoXxP
	 Y8/WgqqYIrBDTxnO6BUUrleMcWwMTi2aR+cYD7zUr1VhR8EvuuCQNuch/m5YBNT+INaT6
	 iLv/e2N3sUsfeWSHboLD8DURDZ38PXMxsDhXIvUfqqe4o2LUXQpKHXGsiHin53cLlMOXh
	 uMKZdax5zJWaG4rZg8kvmG0foLDpjDLgdN/yQXjPIKLm3PLwxH/rLANkT7/ee1L38RfNL
	 3WQlBhxdEeoxrOrt1uq3/U1EqX2GkrGSB0qUj53QhOta+64eyUPOG/MBlGswGB9p3Ow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792374085;
	bh=Z0l9S749yt5i8xtbU0t8+NQZiV/1wIhpyfc5E1WoWp8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J7YSzwQRpc2yXDnbMUdBZdTHMUPs+w1UOQiuDghjfJXzNRowDUJMGndV6K7C3XAKn
	 0tbC3ru1CiGg4a7mcaXekEI0QVlaopc6caiG7JToIJBwolA11uKglH95XzCQZGUNcc
	 amPwpxOEE/ipdf45g2j3uPOrbromB2AlSuXMWv+/i3vTm5gXIlM4ZGA9qnARJTCcRb
	 1iSbLvVE3pwvMtX9JX5ZFcFfcoYhEW3KE3W9YrGvJIHQwRTgDnnmbXONYMLBpwvJoD
	 quHTa4Oogd3sxmfsSCf/GBGKV11VK/kwoUasxX4Qt8W4d+/v1vXWj7maYymFHR5Vzq
	 XJAboFRf9Z4/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E70B480EC7;
	Mon, 19 Oct 2026 01:41:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D49492A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5D3F406D2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:41:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ch3bVyhIYgtC for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 01:41:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C34240633
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792374082;
 b=nrHOKwZn+FwW/2P9KIxhua7bOyvwh1oBoTtyVjMoX3NMDbjzcXY5GMeJwBpOKuXNQJct
 CLSWWxLXNO8G4x+d8SdyjWkEhvFb5wwZ28hvaCaIlXho+bNCTo7ZDlJNu7H+hgqK+/zGw
 d+syc8xl07LdyEpYa9ao1dQ0rZ4ShwyzRWNZB/ZtmxNypQLiWOVjzWUSsaetXZ0120XRp
 Ga2gblw4dNdcfjiJ0HSOm2guqvXLnkhIQW4+SQCC0TsJeDztwix5sASrW1x6a3PJfVCWq
 ZtYqIBcH/DP2LhJMfrJFTktHdeXSovG+dS5zIsOPZOKlAcHmyjzUupifwSM1zP1St5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792374082;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Z0l9S749yt5i8xtbU0t8+NQZiV/1wIhpyfc5E1WoWp8=;
 b=l17T8IMSpVcW6pSpfcqjBW7QTGWmm1D/lYz4IJXkQAT/ttqhQkle4wGpeQN6rOjY+uab
 ZFOkSBHjiB7VCfGFC9nVOm48yGvl9T+xoRNJm1HlGdT1hJ/cT1ikPSRjAQNK/8Ylu5T41
 OOAAkZGcFxx7WSmFJ3lIz3PPSbxyiZG1ibzy6QIpKyaxmf0/eK4BfwSrcY5HA9XSSm1+o
 Wz/+w7agDrFOhIi7SbJzSfyecc5DWaXbfl0S4QauXgfd1XCyOibVxkemBSX2QtZH9b+QH
 wmhtlUXNAwcNcMTFwG4kYRTYn3ZWtd9lQA1FL4ieED8br8kwTCkSqm4YyPBMUk2s+fg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=F2iokDmg; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=F2iokDmg
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C34240633
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792374063;
 bh=Z0l9S749yt5i8xtbU0t8+NQZiV/1wIhpyfc5E1WoWp8=;
 h=From:To:Cc:Subject:Date:From;
 b=F2iokDmgDIrLINnEAynBr8EQwcilwOqCRbTwqWQ7nnGRfbBQ5yDVXZw8VuyWqJQgV
 memW/bVF18EqwCTq7WFSOhV9H2ijiaJzOFECuws1KAI8EOn37nb2nlYKy2rPHuPJrq
 iA0MRDFf0eLdAyhMZUkSi8nB/7/Dp/+XeA+MuHQxFIq4ftSfNxQdfGjcHR0PIG3Kg/
 9a8UpXllZqPDnmj4bz+w/hiAmVuJs+Hn5w+dGAdjY8mHBvKPEdhLdLvgRTAnEgJi1a
 slbsBQ2fl9Fup/PBoDquzypmdnuUuVenZsnfOz7EGpAAI2Xt1+KQPTp8bhEpwMR0PU
 GOHyx4H2/+0hQ==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A4CD3B22001A;
 Mon, 19 Oct 2026 03:41:02 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH 0/4] Enable eeprom tlv command for SpacemiT K3 in main app
Date: Sun, 18 Oct 2026 18:40:17 -0700
Message-ID: <20261019014044.698294-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Cherry-pick a few commits that have the required eeprom nodes and enable
the eeprom tlv command in SpacemiT K3 config. There's not any SPL in-tree
so don't worry yet about implementing such hooks or config options.

Aurelien Jarno (3):
  riscv: dts: spacemit: enable the i2c2 adapter on K3 Pico-ITX board
  riscv: dts: spacemit: add 24c02 eeprom on K3 Pico-ITX board
  riscv: dts: spacemit: add i2c aliases on K3 Pico-ITX board

E Shattow (1):
  configs: spacemit: k3: enable eeprom tlv command in main app

 configs/spacemit_k3_defconfig                 |  2 +
 .../src/riscv/spacemit/k3-pico-itx.dts        | 38 +++++++++++++++++++
 .../src/riscv/spacemit/k3-pinctrl.dtsi        | 11 ++++++
 3 files changed, 51 insertions(+)


base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
-- 
2.53.0

