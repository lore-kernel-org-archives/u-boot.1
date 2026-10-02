Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA03CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 22:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BA5260DA6;
	Fri,  2 Oct 2026 22:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Snd4b5MyDN-4; Fri,  2 Oct 2026 22:10:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8390460D9D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790979004;
	b=kMh4guPRf8kQmrZwwcPUjikV7364kFTNkOvbCyKKrLX0aJ6f//TQ1KFs7vaw1yJW8nj3
	 LxoeT92TPVNnw+X/TG+27hTFJIWCFTz59WN1CvWsSZohr20xHrObTjWR7L0ovuwpcHx0j
	 RNdGcnCG7Gj/LWRSZWtZrP/bQjxXB7P20sr9FZZxPcY9Rvxp+4Js4g7lCvHXebmoDVwdK
	 aUWRkQy10gduC2hf3bh2i/1jWfWzb1YL8zN+/mCmEfwVkfi/b4Nbe8g6omGLCUt/2YJt+
	 zKEawOjOymEubqsQC0jVR7z8nMzwbkh0umw4Rrz6wfXAtJMqKf+GV0uYC9TfQMHwxkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790979004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9yeBvkhR/SuKw3RMY3kpeOnu8Fy/DTtCPwlAVq0rJoM=;
	b=FIAkA279914hNYpuVkIeuI8wvWx1IN2CXGMMN/uL7BV4AODH45v2O8PazrWCTTiFhKn+
	 ZO5zVIVS393aeAaIaQJ5P8fa4R0I1WnfoZHVjBwGDMg5Z2e2ujMD37DWFPEtZf2cqqrGb
	 nCd2hLc4wfSejHgm0tZnypLMuf1C+PKBoD6Ax1z3V2GmonWuZB3myA1evanXkh0w6BYEM
	 YUzqvj5vzhrotPVyY1kyJ2f/9y3QHziehjStfkBY4FNGiWo+Kj6kyt6WSBIXsQY4qlOZq
	 hy0y3b4aFMB8u2QaA+RpZpmYcWSy+AHhtECKnA4GVYBLczpkpFgPSFJrpCfVSR4S1rw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790979004;
	bh=9yeBvkhR/SuKw3RMY3kpeOnu8Fy/DTtCPwlAVq0rJoM=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sGFrn0OJ1HKkFJ4KZMwVetX/BAXpYhB6gafa8vkSuRtPWCG8ZB7TY4o3SE5rgtKjh
	 Iksx53gMCAM71kW4RYzBRGPT+fq6y3tZ61bVcMHOGgL8V+XpsNvX2wvlZVTfOj4igj
	 3M4Lj7nwjx/v42WpkUUly+negoyM+aZ663D+bj3K4e1uoQyioCe6Xyw74yDRTYYWN/
	 CgiWKqbUGEOcgJ2LjByG9CA7kQhq0Nezv93jj5luVPbSxhdgoANWPjB29Cl1+Adrjw
	 ARMYpKr9LeZvKo/n0iSf4eiw64tLW1HgIeML1bFevEcL68mkALxeAg5itZZ/TPJg8S
	 ywOmzVUdIgABg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8390460D9D;
	Fri,  2 Oct 2026 22:10:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A6AE934E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C01D40590
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:39:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xIzFNjOytmTC for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:39:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C46F840585
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.109
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790977185;
 b=dG3ydBSqOWs+7x5fuMy5CCN+ep20GJfqaWfsmPNvHXakofiCQ5zX3/66Bj/P4nvQkdok
 aKSvzWo+vRxH++3XsegxpEBrOoIgghSgeXXEMCHmyzBBWPmtmjDUsYjmOh3QSCayvW1bw
 peCG6ZBVAuQlsDgY9x1SxFZP5i0c+8qIsjZIvJosK5Ufg+rcI84kXx8x24Kvo4YC4n4uF
 zbS81sd7CLkz9jGXCLU32xbhgM89MlxTKZXB2lkPaTS/ERsBIzRz8ylRzs992loUz48m/
 gqpXtM9N7hZGmiXz9iAbzSrVW2GTh0/jjue6WRFvcbbrEdysQ8Hw/jGBlt53lfw8V6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790977185;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=9yeBvkhR/SuKw3RMY3kpeOnu8Fy/DTtCPwlAVq0rJoM=;
 b=bM4HWo8KzV9zieMPieUG3zogUPjXhOS3Dz8HnYapeaAQdSZxOuco0M2gbNHQH2Sgyhml
 CsdRBBWU6+INz1waEC0ncmhqdLsRS30zJFbintYBZ4OZXzYPhF2BvjuzuqudeF972Ho8K
 LStsGkR/1kNEyn+z8jfzl4owbR4H78+iE/lxvWpc07QXpfCf0crDx2vEjrS6zfGFs3nzw
 jIDKan/B0d7nA4Vq4ExsAPANeDhQG/B3J6SyeQQ1D/Z0q9QoHIvJjt5sktQl0j3ZlfQBU
 Kb/e7q03l0T9YSVtJ0oXZqFC69VfjdpD+jz95Sr/1ca/38zpNCfmV4IW+STTfAr0EfA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=BU+Y3VLh; 
 arc=none smtp.remote-ip=79.135.106.109
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.109;
 helo=mail-106109.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=BU+Y3VLh
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch
 [79.135.106.109])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C46F840585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976567; x=1791235767;
 bh=9yeBvkhR/SuKw3RMY3kpeOnu8Fy/DTtCPwlAVq0rJoM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=BU+Y3VLhsXNYEE0SjZIT2+/GYnbktclGrYwENIpG87dGk36tD1ICHE+mUCE93jni9
 gQqVxvYE6pvIFkBHpSNS1CW6w3G8DV904YpU8W+Q/KOYF71jmAKsLtQazNrVYaNYHB
 PqQBEwKeDcrwyQv3aD38gdOYM8UDONjhpzSTIxKNlU7Q/BXVnGkbug5+8OE4/fzznB
 MJxr19UowROCczbDi7d7hyvlzBmZHPhpMBVTUgP93uQYqgeJiYm86YKxIOMtbLLlCG
 eP3d9NInHK8SG2zGHMF7mPBJkepl+mBlhbYy7xw66fY5c1Z8IhqYRey6PALdjmScJO
 ucLvavC92i4Kg==
Date: Fri, 02 Oct 2026 21:29:22 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 0/3] mmc: k1: fixes for the SpacemiT K1 SDHCI driver
Message-ID: <cover.1790975596.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 84bc8309df3ad9cd052f5743c3dd5554456e0317
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 22:10:03 +0000
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

Three fixes for the K1 SDHCI driver that went into next with
"mmc: k1: add sdhci platform driver":

1. A node without max-frequency asks the clock framework for 0 Hz and
   then fails in sdhci_setup_cfg(), and any non-zero return from
   clk_set_rate() is treated as an error although it returns the rate.
2. The SPL reads SD cards one block per command, about 2000 commands
   for a 1 MiB u-boot.itb. Multi-block PIO reads work in the SPL.
3. A failed probe releases the clock and reset bulks, whose first
   entries are the SDH AXI clock and reset shared by all three
   controllers. One controller failing then hangs the next access to
   another. Patch 1 removes the trigger I hit, but the error path
   should not stop the other controllers either way.

Tested on an OrangePi RV2 (upstream k1-orangepi-rv2.dts plus a board
-u-boot.dtsi and defconfig I will post separately): SPL boot from
microSD with multi-block reads, both SDHCI controllers probing in
U-Boot proper, and an EFI boot of FreeBSD from there. Before patch 3,
with the RV2's eMMC node lacking max-frequency, U-Boot hung at "MMC:".

On an OrangePi R2S booting from eMMC, the io clock change in probe
only takes effect with "clk: spacemit: ccu_mix: fix inverted condition
in ccu_mix_trigger_fc()" from the K3 clock series applied.

Dave Klotz (3):
  mmc: k1: handle a missing max-frequency and clk_set_rate()'s return
    value
  mmc: k1: let the SPL read SD cards more than one block at a time
  mmc: k1: do not release the shared AXI clock and reset on probe
    failure

 drivers/mmc/spacemit_sdhci.c | 45 ++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 17 deletions(-)


base-commit: a000f2af240eaa996cec92f8d44bad96fdf3f898
--=20
2.55.0


