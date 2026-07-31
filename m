Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BE3C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FEC541171;
	Fri, 31 Jul 2026 16:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vA2gnQNgAg2a; Fri, 31 Jul 2026 16:36:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55B67410D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515766;
	bh=MMqeHZEjvxh8hl8zgBw4hNlo90pBjca6Ht62kxDNFLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QUT1hH0VWgOyvtEZfjQgaZyOoA8epK+pcaaKmdcr1VqTFnLP9V4OLttzpkd9lSAvD
	 zooPYix5xHqwhzqUpF/MtIXXfr3K/mrKrxp8WvQ/0ahDfPWPuALY7pNQvqGYNF3ivD
	 ftqX6o5+LkgsomsYU7v8CNhOFDP+tQxcuEEt7Ak5iKuQRKAgZAVyzTshTJ1KJwNNnT
	 ZHkQ3HGqEQf7fDDKFbM+VGzM78yYweM5wPQGlz7PkHyqOFgCweK9DrmUZbKMiz8mBl
	 AnoRB4t0DGsVByMKmfvkFgTtdzalTP4sXCgF/M128+zEW7mknPvjY+MAxQZ7UE0zcq
	 QuKmpHjQJYgNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55B67410D0;
	Fri, 31 Jul 2026 16:36:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 22F0F4B0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 057064008F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yz9l0x3-tPkt for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92e; helo=mail-ua1-x92e.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 30B8740025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30B8740025
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30B8740025
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:20 +0000 (UTC)
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-977168e4f3dso662125241.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515659; x=1786120459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MMqeHZEjvxh8hl8zgBw4hNlo90pBjca6Ht62kxDNFLc=;
 b=kcz0NCLC6LxMJvV4oebEgVoysQYFNShzpJ6OzogPVhvD13FoVug180wyy2KGP6eMkY
 Mz2bSmk9boHf2pXfbDxSffD1RlxB7u9IYWiSl0NGg/avtZnl24pTbUrwYf2bhLaSUoVz
 0KtpCLnEQK2jVjs8KhmRtijt22hvXs/RV4Wf7d0uCrfpUWQLZW5JBs3TB4YDsXfPcpjZ
 hhqYNhBgP207++GPVLxG7XVgaqrH36b9EUHVSHP6zqXxfViWJAGX/qlvNzEWEpUP3c8n
 QyWE5ec9JfW4CO/xUVAQQBpN7qlF4kCFyXw02TahOCTOaPVjW4GvRbO1hA4j0zlsRXEQ
 +CwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTW9ZV+T5LHOH/X3t4kc6DeSWHOkJA/W4AB0aTmcyglHLSL+ar8jsO2owB7gxphWhW9cf1kVI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw7bhyUirKL+OorESk26jk2DD1MmtkCs1xOKslU6jMX/mNhBGof
 bSpNkJyjfEQjn/xAZzZw5LsSSzHBkrBtgR0KpsjnwCA0vjtGWFQZ2aKVSdRBIIW/PR4=
X-Gm-Gg: AR+sD11/SvL6XjawWXOfw8M4RDiKLPjF7VjZ4M9sJrnjCzx3rVbH67/1EG9hYWFhFN4
 xncO7W3OEA6HA8qLqH+ugORqSXCK2FjwKf8rNvRxp7KnuD5W3N6w0ozddYnjW0PfDocet78jY1x
 vBaERKUVr8RJUviEvJzfWfAfm1ZuunEiWyvrpoYMbwmAYSKyalQHcRvgFmk9QnwgJw30DKND1Gy
 t90sKtCQGO006ZQKAC5NfvR86wuEsPjnAh+ufYFAgS+sdLMBXsgosYWZjB/y7+L3SAzzjH9jU+z
 IBFavhcNGqQ8GOBVX8P08gYmoesl5Y9Jq1VGpT1lUVZelowsGaQIhosL0b49y8cgWx2OpDC/mSM
 U3VeqOh817O+L0cxp1XooUL36BAKn+8LdaOuFNugHZmQ/ExSS97lMoThPUOTSd5BypX67Cpstst
 bvx9rem2ncbLbTwNP0LOojxHv6mtUC90Snj2pcZceojiz6yLWZf9fNJu/i6gNUMP/bvqlNwlK1X
 NIxdO62O8aJXIZYHGSTcFa3sdhvNYJt90zaIHoD6K+ZtVpNDc4MADf+Gdg8
X-Received: by 2002:a05:6102:5125:b0:74f:4162:3f58 with SMTP id
 ada2fe7eead31-75b21e5a005mr764014137.6.1785515658776; 
 Fri, 31 Jul 2026 09:34:18 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:18 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:41 -0400
Subject: [PATCH 12/17] board: schneider: rzn1-snarc: update MAINTAINERS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-12-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515626; l=797;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=/xYAHR+TjpImFvIqrlqjftL/3RA3mqRSUw1CsbTIwcg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAXOz1hetpBzEpolaDKNGKmsLXQaR0EStgUjdnts9uQP+MaEgScx9/avczv99z20Mazzw+Wyelp
 afDLs1G0UkAw=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515659; x=1786120459;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MMqeHZEjvxh8hl8zgBw4hNlo90pBjca6Ht62kxDNFLc=;
 b=FaKUgGWH1C+RkoZxUeDeOFhJ8S4KHw65x5wFWExMMt0Xq2wm3qshhX/7BKtRCbarfY
 26g0DOJ01cZnqZxjEU98nLHGNllMguGgAwXREo4UrjLG6fZAYU3hm+0/8uglxPaZ8cMs
 shvKq7xN/x3B8XWXInWCwS+pPHtQYdx0ytYsl3XypemTf964OYYpQawKH/xxCr0Qdrvu
 RM/8SmftnFQBq84PX8L2IfgFhAxBM0EQVNzCcFMNxLhSly+1wGmsaVw2S4dbb0riQghi
 bPAnI/kMWz3EJuMiMqf/9wVmF6rQtV2vJNE2UZ65AftqCGSzTLaEXiEHW+C4PlSgGh4U
 qnxg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=FaKUgGWH
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add NAND, ethernet switch and media converters.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 board/schneider/rzn1-snarc/MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/schneider/rzn1-snarc/MAINTAINERS b/board/schneider/rzn1-snarc/MAINTAINERS
index a39b96c1163..f8ae9e1cb6c 100644
--- a/board/schneider/rzn1-snarc/MAINTAINERS
+++ b/board/schneider/rzn1-snarc/MAINTAINERS
@@ -2,6 +2,9 @@ RZN1 SNARC
 M:	Ralph Siemsen <ralph.siemsen@linaro.org>
 S:	Maintained
 F:	board/schneider/rzn1-snarc/
+F:	drivers/mtd/nand/raw/evatronix_nand.[ch]
+F:	drivers/net/rzn1_a5psw.c
+F:	drivers/net/rzn1_miic.c
 F:	arch/arm/dts/r9a06g032-ddr.dtsi
 F:	arch/arm/dts/r9a06g032-rzn1-snarc-u-boot.dtsi
 F:	arch/arm/dts/r9a06g032-rzn1-snarc.dts

-- 
2.55.0

