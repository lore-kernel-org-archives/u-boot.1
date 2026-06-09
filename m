Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64BFCD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A604F84911;
	Tue,  9 Jun 2026 12:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Au/uHwFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EE084940; Tue,  9 Jun 2026 12:53:24 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536B28481F
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gZQkB1JRWz9tBc;
 Tue,  9 Jun 2026 12:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bh6fv0enabY4Zgh34MLnEJA/AM1CwzGxLvvP7hi5rpc=;
 b=Au/uHwFGyOoAjgPSQAzQS/kJBV01gF3wqopaPtXsCtTAh/833M+FWbmo/7FhZxiNoZGkxA
 recx/03pieX2/lzUCtp6wCyFRfVD3Pts2/h7qh2SIHJgbsHWMDrp0yu8ZcYrqLBBGS22iN
 h0ZLOR2mpPrUfaYQWw5h0QhqWRESuIn1+LEkLMRyajNGop8pAdTTrEHmpiPwr6Cfd808XW
 vu4XOkH0GT27Ed9lcZ7KHorRxsv4VITK6jmEFBbVRNglmMfYRA2v22fc3Zx1duP7JWslEl
 XpN5NqA5utDdgLc8zKa/4KSOs379+gcjCUiNmYBC0oBQ3O3g6ldsxiN11WERbA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] watchdog: rti: Use dev_read_addr_ptr()
Date: Tue,  9 Jun 2026 12:53:14 +0200
Message-ID: <20260609105316.1172918-8-stefan.roese@mailbox.org>
In-Reply-To: <20260525-devfdt-wdog-v1-2-d8142b674ba0@nxp.com>
References: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
 <20260525-devfdt-wdog-v1-2-d8142b674ba0@nxp.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kawercsycpasaxwkxpttskb1q4msfrrn
X-MBO-RS-ID: e0a851e5025467f14a8
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

On 5/25/26 11:51, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> devfdt_get_addr() returns FDT_ADDR_T_NONE(-1UL) when fail, using
> "!priv->regs" to check return value is wrong.
>
> Replace devfdt_read_addr() with dev_read_addr_ptr() when retrieving the
> register base address.
>
> dev_read_addr_ptr() supports both live device tree and flat DT backends,
> avoiding direct dependency on devfdt_* helpers.
>
> Also use "void __iomem *" to replace "phys_addr_t" to avoid type
> casting.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
