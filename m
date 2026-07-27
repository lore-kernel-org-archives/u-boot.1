Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF01C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76AFA6073E;
	Mon, 27 Jul 2026 17:15:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9SgCQz8Ly6f7; Mon, 27 Jul 2026 17:15:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CA606070E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785172536;
	bh=pGc6h+HL7blAVI8MB9rF7jJkSIX9Q9QicP3JbB/MJSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h82sW20p8HVFToizMa2lCYx4oZXKwdkkyGVuzU0WQj4UIux35MNMSW9pKfDwzobBA
	 ltpj/wipf1mVYpcS7eTxhePmF5iecDGay7KMPkiJztzcl+o9MzLxltRH6WTDugEDIi
	 ZVqEtgP5xrgHwGE43Xcgg16tUjB8i7kkJkHOMjbPCsPziJ7twX6KmM4iY9hhHEOrQi
	 Zvf4ES8ylk8sBCv+Lto51ueUsO96B06pW3wPawPcJTjgjMpC/8nELUXGvKcgRF6bJx
	 ka1jnyOzsxuve9iywGMNBWA1XRWZYDJbi91BCzHKwQUESQzAFcrsHT+MPH9C6UmR+S
	 I+uBoY339MGrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CA606070E;
	Mon, 27 Jul 2026 17:15:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86C2C39E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78AC7400AC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b6TNW44EAIld for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:15:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 82AFF40055
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82AFF40055
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82AFF40055
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785172520; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bA0BvdmXTPpT6SgolM2nBdeK3ftlEIXKMvDzF4r5LOc68lx4oBeG3GHQz5BpjtJ/5RkL7yw/dN8Qu8uFpjLfxYUEbNBR6JtipyTwV8DpaR8HoZ+QahcQUOBf/g0KsUZvZ3HePIt6/OJhdYf3QiFdNcLDq5F1VJfFiS2WvPZdFUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785172520;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pGc6h+HL7blAVI8MB9rF7jJkSIX9Q9QicP3JbB/MJSc=; 
 b=ZKtCufXOUHkAyRgPKTZAKk7IexJM+Qs7f+DstaZDBuAmX86DefboC52ZrIrcniBWYJxwPEwrgAp+hyHddoNIjbrBofN2IVNjpe+CmzH9K8Y7wKoK7dyRrEliiPx6Cjt/lwQFpQJ1imx0r2QVlgxVYkaPM2wcvilywz9VnlaUNLY=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785172518453892.0068112377946;
 Mon, 27 Jul 2026 10:15:18 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:15:06 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v6 07/11] configs: k1: enable SD and eMMC support
Message-ID: <ameSGj8cqvbKT-_A@pie>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-7-2f58566d48ca@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-m4-v6-7-2f58566d48ca@riscstar.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.167.77
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785172520; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=pGc6h+HL7blAVI8MB9rF7jJkSIX9Q9QicP3JbB/MJSc=;
 b=QQzoJ7Pxypel29LLarMPsvsxph8y0YCaLNxdm1Nvwc4ly68H7k0B2tzoZh/5V/Wy
 3BCRlWAnQKwXKz1vn9d25bVtO/QmjRzHPqhYAgMH4WTGdQcsGytvFWXHzFcvi2xDemq
 k2/qgcWm6/TMlla5G/L6oOKHnZ0R3J9oOD9sdn0U=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=QQzoJ7Px
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

On Mon, Jul 27, 2026 at 02:59:09PM +0800, Eric Chung wrote:
> Enable high-speed MMC modes.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v5:
> - Remove ADMA support since it depends on CMD23 support.
> - Enable PINCONF support for related power source setting.
> v2:
> - Enable ADMA support.
> - Enable SYSCON support.
> ---
>  board/spacemit/k1/MAINTAINERS |  1 +

This change doesn't seem to match the commit description. Please create
a separate commit for the MAINTAINERS file, or at least move the change
to the commit adding the driver.

Also, I don't think it's the reasonable place for board MAINTAINERS file
to keep the entry for drivers. Please consider creating an entry for
your platform in /MAINTAINERS later. You don't need to do so in this
series, though.

>  configs/spacemit_k1_defconfig | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)

Best regards,
Yao Zi
