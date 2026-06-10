Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF5ECD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05217849A4;
	Wed, 10 Jun 2026 14:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sqoSvfDi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09FA4848BC; Wed, 10 Jun 2026 14:21:57 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2244E848A6
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gb4dq6T2cz9v7x;
 Wed, 10 Jun 2026 14:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5d/xifv60ORoEAcrxWVSVXGyP3S2IFTAmImdHHlhFLY=;
 b=sqoSvfDimEN3Gie1W21S7rRjfCC2rnVp1WaQpEQtCeKXk9OfnjXLs/uatqZWbrhW0ehHMh
 0EV1cJrIc5z4Q6Mnnr6A9ozavvaX3qYJY1NP332gZJpFVKa/srxiam0VMXgpwOlwa63maM
 r4smtRMOOFquWjBcNcGD+P444Sz5e6M832gKLRcYEIS9ohgzFKNKAgytjz6LMpfi3yr6On
 K2BCBFx5XEHos5e3v3ziWDLTV4XDM0FHI8xw/Fjvr1WDsIcUtB0nztZ6c0bE4vUVyLXY75
 feBrAgwlPvmzGhRXTRkLPOqUSbvaDyopsRx0QLHu8zUGrhDKeK9s1hEZ6A8SuQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Vincent Jardin <vjardin@free.fr>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 5/5] arm: dts: armada-8040-nbx: add U-Boot dtsi for
 conditional OP-TEE
Date: Wed, 10 Jun 2026 14:21:31 +0200
Message-ID: <20260610122132.2674311-15-stefan.roese@mailbox.org>
In-Reply-To: <92034904751b86de64d8f97bec13b8262949c08e.1778247592.git.vjardin@free.fr>
References: <cover.1776762022.git.vjardin@free.fr>
 <cover.1778247592.git.vjardin@free.fr>
 <92034904751b86de64d8f97bec13b8262949c08e.1778247592.git.vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fsrbwphzmxise5dikcfgqw3ghpiopxci
X-MBO-RS-ID: ba3213fdfba59731e0c
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

On 5/8/26 15:54, Vincent Jardin wrote:

> Add armada-8040-nbx-u-boot.dtsi with the firmware/optee node guarded
> by CONFIG_OPTEE. This allows U-Boot to probe the OP-TEE driver only
> when OP-TEE support is enabled in the configuration.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Applied to u-boot-marvell/next

Thanks,
Stefan
