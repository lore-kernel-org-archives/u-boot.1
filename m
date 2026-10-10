Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4A4CA9EC0
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 19:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD8C660721;
	Sat, 10 Oct 2026 19:10:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tu9Zx4Nqln5G; Sat, 10 Oct 2026 19:10:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D155160725
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791659404;
	b=d+Fj3futtdA4Y9Y8jO5kBiv40jDsqL+qr6+kuTpnKXOFlk48GPz2xN2dFZfMwGYS3VUB
	 vCtNjlYgrmBmEvjdyVCbFL4aPa80/qxpE+ST2Frbag815iirKcTleXJ48Fq8yDPDOOJti
	 dZyG+Uu83d7JF5tYVdUY7/VWeAdSq/o2rJeVVcECpeLCbq+gksD4IE3YbPCHs45SK5BwQ
	 qDUSPhnGSWiMOjCMJaTcabqQnNQh1qSn90+sBwmZ/jzXIqxvwrxvy/oFHjz/akNEDK//P
	 SsNrQVaUtbWgb/BWGWe/gfr/4fYuNYy9zPfX+BJP3pfaDZEvNK+7DFrxmiHPFTBVafA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791659404;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=l6eYhjM7Qh+vbzEtWx351S1zph+Civw0s84TyxTXw3Y=;
	b=j+3gOYh412QVO0JyCg9XgFYpREVef9jgENKyqIlIEXv8FjBbEDrPuHUKPfze5yIIudUU
	 pWIlG9GqBHSvmDEWwOOuKB0FeqoJ1zz2w+ejc/j0oOZ0wgWLAPmkNjvCSOUl4MATz3ljz
	 y7D/zP3RIRVBWaKelvCTx5oXQ2zR7JAOA3PPXS0LuVTYRmdw2XU0dQ+SI/sfnB8kbSfEk
	 ITov0i9ekOcT4lwHNwhtHB4vOYFvihNJOwgmUzfIBtQV9KHMPacoG2cg17aVhyrZzn/Eq
	 PA2lFtoDNT9wfTUCJu1G1v66/gA82LsTumjgI6cwnglYCtOziQjTQF77ecw7MLUgSmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791659404;
	bh=l6eYhjM7Qh+vbzEtWx351S1zph+Civw0s84TyxTXw3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=vMmFIxOceModWMhVQvInyWHV1A4Z1wTA+PqK+CTKjZ9VJ0OQAgSrd6zYD+ufY8Hqi
	 pTZGwBWsbj/I6PYPcHT3v6+I5qLDVMdB3BKVcS1v858XhBw3qifzzeDY3Nomk+I2Yc
	 nnpvu9ZvkCWucGQF5FGsDr70stoviR+WyUG95VYIDi1A9eTS8nX+7sZliZp4pCYWtj
	 gTO709dgHQ4yjTNSsX2h5w3+IIJVXdPTH3wWFr2dzATFH7jQoTB6epTieu3aq7JsC1
	 61RZJg8ahZdBMEcPFVTzD6ls5ITh88WIIIXgG4dg6wHGuwthv/JvU9sgORpSteXWhg
	 fOY0WSUl+odBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D155160725;
	Sat, 10 Oct 2026 19:10:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B5C3D317
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AA72408D7
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaCYjt6jJEf0 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 14:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03E34408D3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791642295;
 b=E/WEwimpz0u5mjYgBWSLksiwoteZK1X/9ogkT+dufgaFO2rqG+0wiwSpMNLB6+Zl/jVH
 OFXyL8zCSnFJkIL18XhA8ADIpMALn7Ti7+XhBLhvXxTwJndj21MzOjNW7PIo5jNc+bmmH
 zAKMEpAqMZvn2yKi9paN0S+k9MGVNWcai91wsVtcYdXK/7YaCX1A+W/Jo3A1UY7jug2lY
 otFJ347DgD2fyW9igghHHLEuNIk+AfSnXBaaGd9qovP+GqH7x/dQnHBxP/qNW/ROp86Au
 0QBDFTH2A6SPyJZBIb2LMd/3dXJuHo37Y/VJsr+Ti9rqS5PcB2ZnvQ8QaGg2PoK2T8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791642295;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=l6eYhjM7Qh+vbzEtWx351S1zph+Civw0s84TyxTXw3Y=;
 b=TzqVkrEhVg5f/I/DF4V+BNxFVjIuADUrTL08Xg/cJcLoAs+nrlRVdKZcVEZ8jxp1kd53
 kijf14XSRO+7GTYzMR+d3JBYeFcJn1mFFWVWJT1nXKgvyFNA3bumQVM3M8rqGqFBVhK2z
 B2m8qrPe51OASil9OGr7oWzB7CDLzPe8ejfxrgGOzQZOyE5ewkutwWOpX9K+deQ0WBD0k
 Qh0+JjOelbE5V/0SM2d4QNo8g9H3Pif3tCYhLdFaO64EFdgh5A5ZCgxws+ESXZaXFOgfz
 Z7DHVbgThRnYVzHBxW6aA/+Z59x8ejlWgeDABkXeaQf4jv5HpQys7UXicgFJPNZ4btQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qbnDq72+; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=qbnDq72+
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03E34408D3
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1434760211;
 Sat, 10 Oct 2026 14:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE5ECC2BCFD;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791642292;
 bh=hiHdnEcd+YLQWpWF81gt/jGq30/I+upi5Spf13WUqmI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=qbnDq72+SV835vg3bc/t1nNBw2Ze+y5SqMOC41wj2qdKy8PuSHscBh+zOPuIo1yRb
 KSDrgpyLXz90dw9ClbsnKGw99Bkbhnkyev96d5lx2L91AIB8sZ4hjOSGKwvQISDdkP
 l1ff1aAm+Ep+vqpA2QUyJUFVx38IixuR7vpAb02Vz5YdTU63wVyfrBdzl0MohZsIZI
 S2VanlL0OOlmovjblFK1xAYnyvXNEn091x1Xmuvb9klL8iX7RAxQg2TbMTFoBjIQyv
 OYWmBo7eQM6VODSRtIlbmyJq4kHMcj/F/7pHrktHXBP4tJbNcvvF7OtkTpgKwfadl3
 jPwu+Bv1oQi2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AB82CCA9EC8;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 16:24:48 +0200
Subject: [PATCH 4/4] rockchip: LZMA-compress the FDT image in the FIT based
 on FIT_FDT_COMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-binman-fit-fdt-compression-v1-4-4465558758cc@protonmail.com>
References: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
In-Reply-To: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791642291; l=1063;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=6QI+S+kJkoodlMS9OYGspm8o3lEQmxd0gwRkbK+j1rM=;
 b=VBvUyzfVswrH+Z1B5zHcLoVSGVGChm+LKZVYAFTR2LuvBSRAl4enL5D/BaqsqaFZceWHIN5ve
 ZUq7vGnq5m1DbPFCUqQaUCE2LunhxCb68Dp4KdAaWRn0D/WjQwku9N6
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:09:53 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Adds FIT_FDT_COMP alongside the existing FIT_UBOOT_COMP gated on
CONFIG_SPL_LZMA only. Applies it to the @fdt-SEQ template's compression
property.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 arch/arm/dts/rockchip-u-boot.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 4ba6a87e78a..ed082212446 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -19,6 +19,12 @@
 #define FIT_UBOOT_COMP		"none"
 #endif
 
+#if defined(CONFIG_SPL_LZMA)
+#define FIT_FDT_COMP		"lzma"
+#else
+#define FIT_FDT_COMP		"none"
+#endif
+
 /*
  * SHA256 should be enabled in SPL when signature validation is involved,
  * CRC32 should only be used for basic checksum validation of FIT images.
@@ -136,7 +142,7 @@
 
 			@fdt-SEQ {
 				description = "fdt-NAME";
-				compression = "none";
+				compression = FIT_FDT_COMP;
 				type = "flat_dt";
 #ifdef FIT_HASH_ALGO
 				hash {

-- 
2.55.0


