Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70824CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 08:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B96998460E;
	Mon, 25 May 2026 10:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dzpbAjzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46B0D8465D; Mon, 25 May 2026 10:59:06 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 540F48405A
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 10:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so97907705e9.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779699544; x=1780304344; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9V83EtDbrfpYRiJ358CGAdACDRmgI7Syw6l3piaj304=;
 b=dzpbAjzbuuHZ9zJAh125lKiVSYcpWVFRmQa+/Wlmr6V8Tl1/pAuUdjBxd94PGb2GG9
 kgeDtvHetyRlJM5H8Gfo/DI0xH0P6NsA6Ynzpxg4IZRya2fjSm49DrNsgKyxmtPA/uqX
 Ms8K3dUDaScRamSd8KPFXCKP/deBiSYCKglS3lsqsOs6uduXpjLM8B91V5fREWVfimwj
 CQRgKJn6bN1GfVyHDCIbeYYtbd+R2b/7FAedB001aCTXI9miz8+2AM5xEjwdpNP2Y2P6
 9V6gLqspIPnbvqeSt1G542z1LGoM/Nx8Hn5XjCqznGHqcGqRvL0m0X7HgsiisiooCkkD
 pUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779699544; x=1780304344;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9V83EtDbrfpYRiJ358CGAdACDRmgI7Syw6l3piaj304=;
 b=tLXb8Y5q6tBmXao4AH97N77RfSCWFAQR67AjvoDznWfJf9G7i4bDNSoefRffDcEJqD
 mFAD16xw4Nxhlq415AvSmJZnGBy3EV2X2SNBbsyw+CrXBrAt+2xhXi4xrYwZpHIA+uss
 iTZ5ujozDNoRN3UtgRmZYLmGdRO24/VNKd0cT5VlTuL4Ybywrm3gFrSFmfD9H7ubwNOC
 P2ouTVGGNG7tRQVgZMf5qfjj+CGy5AHGk7tgEB95ldw+HyuUe6hgYOzbrNj2XLYqlaQD
 Z+s2DggCPsr/EH+gsQzwT1ElUawmyYS3TD9Y4O6dUz9+bei3XZrDiVMwPl+74nurT81p
 LtOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gkWl9xXD/WXaFTiSP+qDJhfMOuo5T3hCBKdeLIKChHBAiwQyXpLJELnZfevHy8Ef9ARBgpl4=@lists.denx.de
X-Gm-Message-State: AOJu0YwKTelzcdCNt4yQtLNMBTvI84Jytzl7mgJZxOsAJmO6kNUxqrZK
 7pVA7fG0IhPuHXmggDNH0a/t8KjTQ8w33mXovR0ojSHOvoisLk40o0Ky0JiuzLR2sco=
X-Gm-Gg: Acq92OF+A9UH/2xRKgIDXODtk5Wf1IoYIW5lydq90gvRx6+8pP4yE9k+Buzsa+a7iv0
 M6M1cRFu5NC/ZR6mIFQKbn9GSxDsu3eaPIDO5DaJWuJSBk16R7TABIdznMTtD/jSM4VjOxNpBM0
 Pj2zuqicjNpcyPCvDueDe5XEUSX2qKkqZHs6BMURWxe9lOOvx6bBtpUIAgUf4sHET8v8iYcLoZb
 Oidi4Rxyf6JQ2J3HklSeEVVLxxzbeVdApy/Eqsy9/d5cn/1pTtrj5skCXvDVbKkUVQv/XiDtw1c
 ewzem8lwXE38iKHvFKK8HgRAbK/dJ2zhIoBVacEY4KUP9HZtAGFgX4hh87mkiIPCIHY9cCvEy63
 /xGJSMqfilSykhk0YijalqZZ9ZnSEAkco0KedzKFOy5CCKV3PTaxuCsL/37mTcl5mFqO0I5EzL4
 Yn4b7jcJy3GBVTnnR0uEakHQvY+Aosrwomf6WfSkbfiaO98Y15tyOCW/XCYNhzdHhSrw==
X-Received: by 2002:a05:600c:1393:b0:490:3890:605b with SMTP id
 5b1f17b1804b1-490428e0bf3mr223845855e9.31.1779699543336; 
 Mon, 25 May 2026 01:59:03 -0700 (PDT)
Received: from [10.214.129.160] (93-33-1-176.ip42.fastwebnet.it. [93.33.1.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454dedd9sm210601525e9.6.2026.05.25.01.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 01:59:03 -0700 (PDT)
Message-ID: <bc9d68f2-da7a-470c-9841-f78da9c150dc@gmail.com>
Date: Mon, 25 May 2026 10:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, fedor.ross@ifm.com, marex@nabladev.com,
 joao.goncalves@toradex.com, ravi@prevas.dk, ping.bai@nxp.com,
 ji.luo@nxp.com, qijian.guo@nxp.com
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
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



On 4/30/26 10:33, Simona Toaca (OSS) wrote:
> From: Simona Toaca <simona.toaca@nxp.com>
> 
> +/**
> + * This structure needs to be aligned with the one in OEI.
> + */
> +struct ddrphy_qb_state {
> +	u32 crc;		  /* Used for ensuring integrity in DRAM */
> +#define MAC_LENGTH		8 /* 256 bits, 32-bit aligned */
> +	u32 mac[MAC_LENGTH];	  /* For 95A0/1 use mac[0] to keep CRC32 value */
> +	u8 trained_vrefca_a0;
> +	u8 trained_vrefca_a1;
> +	u8 trained_vrefca_b0;
> +	u8 trained_vrefca_b1;
> +	u8 trained_vrefdq_a0;
> +	u8 trained_vrefdq_a1;
> +	u8 trained_vrefdq_b0;
> +	u8 trained_vrefdq_b1;
> +	u8 trained_vrefdqu_a0;
> +	u8 trained_vrefdqu_a1;
> +	u8 trained_vrefdqu_b0;
> +	u8 trained_vrefdqu_b1;
> +	u8 trained_dramdfe_a0;
> +	u8 trained_dramdfe_a1;
> +	u8 trained_dramdfe_b0;
> +	u8 trained_dramdfe_b1;
> +	u8 trained_dramdca_a0;
> +	u8 trained_dramdca_a1;
> +	u8 trained_dramdca_b0;
> +	u8 trained_dramdca_b1;
> +	u16 qb_pll_upll_prog0;
> +	u16 qb_pll_upll_prog1;
> +	u16 qb_pll_upll_prog2;
> +	u16 qb_pll_upll_prog3;
> +	u16 qb_pll_ctrl1;
> +	u16 qb_pll_ctrl4;
> +	u16 qb_pll_ctrl5;
> +	u16 csr[DDRPHY_QB_CSR_SIZE];
> +	u16 acsm[DDRPHY_QB_ACSM_SIZE];
> +	u16 pst[DDRPHY_QB_PST_SIZE];
> +};

Hi Simona,

Would you consider reserving a small u16 board-defined field at the
end of struct ddrphy_qb_state? Something like:

	u16 board_ddr_config;	/* board-defined tag, opaque to U-Boot */

Use case: boards that carry multiple LPDDR configurations
(single-/dual-rank, different sizes, ...). At QuickBoot time the
boot code needs to know which configuration produced the persisted
PHY training data, in order to load the matching timing table
before DDRC init, in OEI. A 16-bit board-defined identifier is enough; the
value is opaque to U-Boot.

A generic placeholder is equally fine for our purpose, so each
board/vendor can use it as they see fit.

Cost on the persisted blob is essentially zero: mac[] (u32) forces
4-byte struct alignment, which already leaves 2 bytes of trailing
padding in the current layout. Adding a u16 field there does not
change sizeof(struct ddrphy_qb_state) nor the on-storage size.

Thanks,
Emanuele
