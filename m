Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DDAC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 11:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAD80874E9;
	Fri, 10 Nov 2023 12:50:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=indel.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14339877CA; Fri, 10 Nov 2023 10:58:42 +0100 (CET)
Received: from ms9.webland.ch (ms9.webland.ch [92.43.217.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EB978779A
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=indel.ch
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0+786750800b3c4517=GX=indel.ch=cenedese@ms9.webland.ch
Received: from mail.indel.private ([77.56.24.72])
 by ms9.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202311101058390134
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:58:39 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.indel.private (Postfix) with ESMTP id 270501D27478;
 Fri, 10 Nov 2023 10:58:38 +0100 (CET)
Received: from mail.indel.private ([127.0.0.1])
 by localhost (mail.indel.private [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ME9Ui1mQQsH; Fri, 10 Nov 2023 10:58:37 +0100 (CET)
Received: from FABI21.indel.ch (unknown [192.168.1.75])
 by mail.indel.private (Postfix) with ESMTP id E40831D2746F
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:58:37 +0100 (CET)
X-Mailer: QUALCOMM Windows Eudora Version 7.1.0.9
Date: Fri, 10 Nov 2023 10:58:36 +0100
To: u-boot@lists.denx.de
From: Fabian Cenedese <Cenedese@indel.ch>
Subject: PCIe layerscape ATU
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-CTCH: RefID="str=0001.0A782F20.654DFECF.003F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
Message-ID: <6de482622a11ec4373381078f6e07e68@indel.ch>
X-Mailman-Approved-At: Fri, 10 Nov 2023 12:50:25 +0100
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

Hello

I have a question to this code (drivers/pci/pcie_layerscape.c):

void ls_pcie_atu_outbound_set(struct ls_pcie *pcie, int idx, int type,
			      u64 phys, u64 bus_addr, u64 size)
{
	dbi_writel(pcie, PCIE_ATU_REGION_OUTBOUND | idx, PCIE_ATU_VIEWPORT);
	dbi_writel(pcie, (u32)phys, PCIE_ATU_LOWER_BASE);
	dbi_writel(pcie, phys >> 32, PCIE_ATU_UPPER_BASE);
	dbi_writel(pcie, (u32)phys + size - 1, PCIE_ATU_LIMIT);
	dbi_writel(pcie, (u32)bus_addr, PCIE_ATU_LOWER_TARGET);
	dbi_writel(pcie, bus_addr >> 32, PCIE_ATU_UPPER_TARGET);
	dbi_writel(pcie, type, PCIE_ATU_CR1);
	dbi_writel(pcie, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
}

/* Use bar match mode and MEM type as default */
void ls_pcie_atu_inbound_set(struct ls_pcie *pcie, u32 pf, u32 vf_flag,
			     int type, int idx, int bar, u64 phys)
{
	dbi_writel(pcie, PCIE_ATU_REGION_INBOUND | idx, PCIE_ATU_VIEWPORT);
	dbi_writel(pcie, (u32)phys, PCIE_ATU_LOWER_TARGET);
	dbi_writel(pcie, phys >> 32, PCIE_ATU_UPPER_TARGET);
	dbi_writel(pcie, type | PCIE_ATU_FUNC_NUM(pf), PCIE_ATU_CR1);
	dbi_writel(pcie, PCIE_ATU_ENABLE | PCIE_ATU_BAR_MODE_ENABLE |
		   (vf_flag ? PCIE_ATU_FUNC_NUM_MATCH_EN : 0) |
		   (vf_flag ? PCIE_ATU_VFBAR_MATCH_MODE_EN : 0) |
		   PCIE_ATU_BAR_NUM(bar), PCIE_ATU_CR2);
}

void ls_pcie_dump_atu(struct ls_pcie *pcie, u32 win_num, u32 type)
{
	int win_idx;

	for (win_idx = 0; win_idx < win_num; win_idx++) {
		dbi_writel(pcie, type | win_idx, PCIE_ATU_VIEWPORT);
		debug("iATU%d:\n", win_idx);
		debug("\tLOWER PHYS 0x%08x\n",
		      dbi_readl(pcie, PCIE_ATU_LOWER_BASE));
		debug("\tUPPER PHYS 0x%08x\n",
		      dbi_readl(pcie, PCIE_ATU_UPPER_BASE));
		if (type == PCIE_ATU_REGION_OUTBOUND) {
			debug("\tLOWER BUS  0x%08x\n",
			      dbi_readl(pcie, PCIE_ATU_LOWER_TARGET));
			debug("\tUPPER BUS  0x%08x\n",
			      dbi_readl(pcie, PCIE_ATU_UPPER_TARGET));
			debug("\tLIMIT      0x%08x\n",
			      dbi_readl(pcie, PCIE_ATU_LIMIT));
		}
		debug("\tCR1        0x%08x\n",
		      dbi_readl(pcie, PCIE_ATU_CR1));
		debug("\tCR2        0x%08x\n",
		      dbi_readl(pcie, PCIE_ATU_CR2));
	}
}

For outbound *_BASE and *_TARGET values are set. For inbound
only *_TARGET values are set. However in dump it always prints
the *_BASE values while the *_TARGET are only printed for outbound.

Shouldn't that be the other way around? Either I didn't understand
ATUs or there's a mixup here.

Second question: We want to make an endpoint with 4 BARs. Is it
possible to configure the internal addresses in the ATUs? The function
ls_pcie_ep_setup_atu uses a configurable base address but then all
ATUs are placed one after each other. How can I give them arbitrary
addresses?

Thanks

bye  Fabi

