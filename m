Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA60CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14174848A6;
	Wed, 10 Jun 2026 14:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xpGWxjyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0247484996; Wed, 10 Jun 2026 14:21:54 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD2E3848BC
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gb4dl1LDsz9txr;
 Wed, 10 Jun 2026 14:21:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KC4bCqeeF7iusDWh58MVGLkJc1HWXnzj7UnXZJnBD/A=;
 b=xpGWxjyZCOFV3Ik4xCHMWeajdNd8Y1xN5J/QJ9EcXr+CJWLi/HrV+d/dzoNIn1wIOus3xJ
 4MFcVrl26GctIaXQohaqqphox7tZY/IMr1OxhCQPQb/kIHh7ftV1jGCepc325cOxvx36fg
 P7aJiUWNYnsdCXbmTLumG5plInFDdx96bRl+I/kisktj2EgXfZP83j44JHWreFCUS07EYx
 znlcT0GP3/8hSCuSOJsYbA9iugxWtvA22JaYMxSp9u0i3YRLfq5HQpRw86BXcVD2mx0VUY
 8RVjtRYnjtZBxB6ARzGtit7ovB43uaWUdtECUbTVf2uk+dsOAV6APcW/HdlMBg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Vincent Jardin <vjardin@free.fr>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 1/5] arm: mach-mvebu: armada8k: cpuinfo and SAR
Date: Wed, 10 Jun 2026 14:21:27 +0200
Message-ID: <20260610122132.2674311-11-stefan.roese@mailbox.org>
In-Reply-To: <7a54c11bd4b0d1c757186f63fa4fe0b78e4fea2e.1778247592.git.vjardin@free.fr>
References: <cover.1776762022.git.vjardin@free.fr>
 <cover.1778247592.git.vjardin@free.fr>
 <7a54c11bd4b0d1c757186f63fa4fe0b78e4fea2e.1778247592.git.vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 45dd9b2d3cbe246f4ea
X-MBO-RS-META: pxp77opxfgdhqkbzjj9niom53thsdzmt
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

> Add CPU information display for Armada 8040 platforms.
>
> The soc_info.c reads the AP806 Sample-At-Reset (SAR) register to
> determine the PLL clock configuration and converts it to actual
> CPU, DDR, and Fabric frequencies using the PLL frequency table.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Applied to u-boot-marvell/next

Thanks,
Stefan
