Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A4EC531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 09:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C78940AD1;
	Fri, 24 Jul 2026 09:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 92fqAytI1Z6a; Fri, 24 Jul 2026 09:25:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4774F40980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784885121;
	bh=jkJL1mDkSfeYiaH0IxG3Nxx9/scwrbrOmZYa73Ag8Bo=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=j5jiAr186h/qHZ2QUQE2gz2PL5iqwAU/Glu2pPB6RuL+D2oYdfYL+DUcu6qnFD3J3
	 ElfFPkRZiapjE9Jx/L/+5AwfF0SoqwpV/b4JuDoxV98ixmplbrcrRadBEj7PGWNIiV
	 KP/hv/kei8E6S2CSqTT294lmdm4jhmEdqnnzBHFecRt3eSmlGeyL0b8VlOMVfoYR1B
	 oSYDqT/lMwyHUItKT42KQzjrvMhstxalTANQC743DKcT9JmYd4q5Pww0zKnFCm+WfQ
	 lxJHp8U58MzqFAoQNsj5VPE+mUcQT9mN183gOxJJrOVfK87cLY3uDEFwgjO33aDSwC
	 e3KPiKhULDloQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4774F40980;
	Fri, 24 Jul 2026 09:25:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C6270A47
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7BE681152
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:25:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cn-qNJEQF8PM for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 09:25:18 +0000 (UTC)
X-Greylist: delayed 594 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 24 Jul 2026 09:25:18 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5FAA681096
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FAA681096
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.9;
 helo=smtp-bc09.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FAA681096
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 09:25:17 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h62Fm6tQGz2Qv;
 Fri, 24 Jul 2026 11:07:56 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h62Fm28gTzVg2; Fri, 24 Jul 2026 11:07:56 +0200 (CEST)
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, 
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
In-Reply-To: <5690db1e-4de5-44bc-a9c0-58ad23662753@gmail.com>
References: <5690db1e-4de5-44bc-a9c0-58ad23662753@gmail.com>
Subject: Re: [PATCH v4] mtd: nand: raw: rockchip_nfc: fix ecc setup
Message-Id: <178488407621.571705.16719413319184935531.b4-ty@b4>
Date: Fri, 24 Jul 2026 11:07:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1784884076;
 bh=jkJL1mDkSfeYiaH0IxG3Nxx9/scwrbrOmZYa73Ag8Bo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ZyXjdj0T4/3MUKL4a7mU8ql2C5QkZzDGTy3F8Zphp0YMJiyeItaqfRkmHggyP4EFB
 XAxplLBeraF2mmayWRHei5GmKoHeTfEiLZJqUSrl5joki3JADQlxOk0qvXEzzakpvj
 gZ2JDSol577baB7ih1M5f6cUqn2X2c1J77UDMc+DZiscuf7+qtBpJINiDtSzMg0pk3
 zOzYmx0S0uhvVmCyrjvS54kwPlLwTojDCza/ahu12raRyuwMpkmlRQAbCdOFePXPp/
 L6aeErooA75nH0OSAnBAg//EA763soJxHJT2+VF1B4tlG+b38RBZHGrE13Beo74hAT
 DRHNhw5sIl/LQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=ZyXjdj0T
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 23 Jul 2026 17:22:59 +0200, Johan Jonker wrote:
> A Rockchip NAND Flash Controller (NFC) supports multiple
> flash devices. The SoC boot ROM only checks for NAND chip 0
> and with reduced ECC strength. Currently only the read page
> functions have this condition check added in the U-Boot
> driver.
> 
> In single- and multi-chip nodes with rockchip,boot-blks and
> rockchip,boot-ecc-strength set, the chips that aren't chip 0
> will thus have an ECC mismatch when writing and reading.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (main), thanks!

[1/1] mtd: nand: raw: rockchip_nfc: fix ecc setup
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/d97d3df79e7bd7021dac0a1974c314c5acb07ac3

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

