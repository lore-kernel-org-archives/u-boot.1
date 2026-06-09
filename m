Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C3BCD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDD88487C;
	Tue,  9 Jun 2026 12:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ktSXTo6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5EE78466E; Tue,  9 Jun 2026 12:52:28 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F3F84704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gZQj51MRZz9tvP;
 Tue,  9 Jun 2026 12:52:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bh6fv0enabY4Zgh34MLnEJA/AM1CwzGxLvvP7hi5rpc=;
 b=ktSXTo6E5YPljA+A77GAil2Hx80zxjHXk0y1sIdRQYjPlUWUE9svE9+3Fgkd1V8khOO3L5
 QygHeVvU2Vz9g5j3geTTFdUU1JTVKbN4neZKkqY2d/keBS+vFoEkbj9WAkBHn9g1BRFr7R
 0PpfcJEoSYafqMoNRMOh4xdXMkTOn5bqeo/vQL8jP1stymvWdTkYOX+II27Cr9Ex61vcf+
 z3tVmWk3NiIiuv0rfOrZNvYwakkprW6IpGPlYfHbesatVmH5+ylR8a8k9W0navbFNW9mlL
 jD+kB8dpacYAzh+nnz9yo7Bje+iX+alCyUW4N8JotKuItZTTL1uj3KdpFaJUAw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] watchdog: rti: Use dev_read_addr_ptr()
Date: Tue,  9 Jun 2026 12:52:17 +0200
Message-ID: <20260609105219.1172564-8-stefan.roese@mailbox.org>
In-Reply-To: <20260525-devfdt-wdog-v1-2-d8142b674ba0@nxp.com>
References: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
 <20260525-devfdt-wdog-v1-2-d8142b674ba0@nxp.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cyh7njifbc938yr9dfh11orcqoowmypg
X-MBO-RS-ID: e80b829668f390de0a9
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
