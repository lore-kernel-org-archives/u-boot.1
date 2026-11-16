Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE080606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kII5xEqS;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=YDxK7AsV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56D1C60666;
	Mon, 16 Nov 2026 10:27:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T8BHyhuMoR4z; Mon, 16 Nov 2026 10:27:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C928A6067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794824849;
	b=Oi7WFvou6G2AlIQGQwK/0pI6rKBD8T0H74JnEGzAR+9PxuegwgV6qSAOvlD8CnaXsovv
	 xAU357RwIvYb9/O4vZcmUX46mOcJEMRWvHp1l/Tvs723uWU6x5ETVN8X/QLoau5y7BtO1
	 WQbYQ+RzILbCILoK6Cz3/1Lph6+oRHAfIcvmpLctwzeHzXftU7/mKj3iFqRIjR82cELjI
	 AsmdOVdckD1ZaW3v5cpSICqDBi7BVBIAuxOLG8OTxD3+BSc6Zjn80zGkNqQ0tT6rGjZVS
	 kjm3TLLHmELV1cqVYhijWP5A9TmgKfxyZGChUnxiRA8KZUiBqH0UIeQ1srx1J3zL1Fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794824849;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s7vCzcQddX+Qc//5FyxXi9+B/TsFa/VdxD+9V1Z2VNk=;
	b=hWoN2G+KHYUVwDxhDdtRVe+kLOzeXbeyt3OelHTEWEG0E5KepWmjMZ+ipzNsG9xaBQtp
	 JHRnLqYRxLqbpn6g75PUW4h4z+bJx8uzbRw7OHiGg5WMbB6o1g2Uf5DVZMy2807PnrbLf
	 8+mbe4vaboJ1/aFP4O/bZjqz+AeBHlXWF21MQ4DbfUNmr94l0q/KB1oduSB2qbevCTO/0
	 6grN9Jw558MlDVLq1t5jk0Y6Z/RhTjFaI+0sooM+ATiuLHjbWmj/l+FaC5gjkFRuZ5d7w
	 iiJNVREVLanl8h3aBR4+Gzh867f17MmJVUD66nkhdzO1kIMMxuwJlspgUr+KLAyWhxA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794824848;
	bh=s7vCzcQddX+Qc//5FyxXi9+B/TsFa/VdxD+9V1Z2VNk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kII5xEqSuKb467DW4WWME1q7epML44DZuX7r7bu7X/GcbJBbVpXaq9qqHHgO3BdTM
	 q35Rl8oO/P0l6BCCpwazptkBruHpWxFKpWr3zov27EzLqyRLP0EeL2wfTM6nmhmSST
	 KLrJbcnBFiPJ/pWxyLSCEHYuUWSO9mv3l995DYlTiCTaVoJFJS5dHCjq7++jbeBJ5x
	 cmPHl9feT1DlimdJ90Wdmh19mznntaygao00Q8j/CwMMa55KpclHT/UNs/3TdFJW/e
	 AVzax12Rr87rO2Di1wCSnpCcUhlv6djobTDeuGRhAcs+1XtLYHLssVKE2JHVvduBj+
	 09SUEfiYxjY9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C928A6067D;
	Mon, 16 Nov 2026 10:27:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CA431A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52AF9400FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mvlhXOHUTxpi for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:27:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D5A644009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=YDxK7AsV
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5A644009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794824833;
 bh=s7vCzcQddX+Qc//5FyxXi9+B/TsFa/VdxD+9V1Z2VNk=;
 h=From:To:Cc:Subject:Date:From;
 b=YDxK7AsVO/YKBXuRfVgyQ2VKki+52WigqYdsSc8pwOprZ5jthSKiWZtV59vd/drJo
 RVm4sDerWhWJOH5MJ46s8sRMlTboZl3BS+FiR4gTf9IFBysWv/jOCziM0CSsyblARf
 b490Lq/DqXgNgJ0FTUp5fMPU1tf9jX6IH3wQegIxmVOlSdfmlI1jzDsuW0dIli3Dzr
 sD9FZcFDL9+c09WmZ4SjYMuFY04Z8cmle77pb3yYriPjp2Zo694jv0ovMedZ+T2VwX
 COUYgnSIFwfsQOcaBzt7Dob9PgsccQrNnICdXnEuYDP/rKEIfq+KB2XJSS18UOFRBZ
 g7iCJKLkhkLtw==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A8077B22148D;
 Mon, 16 Nov 2026 11:27:12 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Yixun Lan <dlan@kernel.org>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v3 0/4] Spacemit K3 enable Linux boot
Date: Mon, 16 Nov 2026 02:26:26 -0800
Message-ID: <20261116102653.36927-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adopt some fixes needed for Linux v7.2.10+ boot and enable
BOOTSTD_FULL together with minimal env addr variable defaults.

Build and test only with vendor BSP k3-br-v1.0.10 having reduced [1]
configuration to avoid a memory resource conflict. The vendor BSP SPL
in its default configuration attempts to load opensbi separately from
u-boot main app, and also attempts to load an embedded controller OS
image, neither of which is useful for mainline opensbi, mainline
Linux, and mainline U-Boot.

Changes since v2:
- Add patch 4/4 which adopts a proposed Linux series [2] to reduce the
  initial memory configuration to 8GiB for CoM260 and Pico-ITX boards

1: https://lore.kernel.org/u-boot/20261029003327.1890979-1-e@freeshell.de/
2: https://lore.kernel.org/linux-riscv/20261115195112.32120-1-e@freeshell.de/

E Shattow (3):
  riscv: dts: spacemit: k3: override reserved status of mimsic and
    maplic
  configs: spacemit: k3: enable CONFIG_BOOTSTD_FULL
  riscv: dts: spacemit: k3: adopt com260/pico-itx 8gb memory override

Junhui Liu (1):
  riscv: dts: spacemit: k3: Drop guest properties from M-level IMSIC

 arch/riscv/dts/k3-com260-ifx-u-boot.dtsi | 9 +++++++++
 arch/riscv/dts/k3-pico-itx-u-boot.dtsi   | 9 +++++++++
 arch/riscv/dts/spacemit-k3-u-boot.dtsi   | 4 ++++
 configs/spacemit_k3_defconfig            | 9 +--------
 dts/upstream/src/riscv/spacemit/k3.dtsi  | 2 --
 include/configs/spacemit-k3.h            | 6 ++++++
 6 files changed, 29 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/dts/k3-com260-ifx-u-boot.dtsi
 create mode 100644 arch/riscv/dts/k3-pico-itx-u-boot.dtsi


base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
-- 
2.53.0

