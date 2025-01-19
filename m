Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1A4C02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 14:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4054A805DA;
	Sun, 19 Jan 2025 15:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="P91fZEK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E898A80141; Sun, 19 Jan 2025 14:41:48 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63B380017
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 14:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4YbZPy6VNWz9tMQ;
 Sun, 19 Jan 2025 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1737294103; bh=aaRgfsxZoLGwIka+PRgS7jY7lMwbKmpv29XdaL2rJ64=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P91fZEK3A/NpYB/kPV/iUFXbHcu6iA3pkAkedH/EwN40qFUesxMsSbk4g5TJDGIbR
 gyAd9j20uhAPEOLql6GM5R/K+IfP1v042/2prnZocb7b74meLeBJk7DJRw/GRjUKE/
 AoXHXGLNHNIF32WhjdD85w3DjMsMMcTcrA8yzqMQ=
X-Riseup-User-ID: A37E282DDCF7A0610411430B2E56B9E6CA0917561EDC3920DFF1B46E1F89CBC5
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4YbZPr5F2fzJrWx;
 Sun, 19 Jan 2025 13:41:36 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 chaoyi.chen@rock-chips.com, Andy Yan <andyshrk@163.com>
Subject: Re: [PATCH 05/10] video: rockchip: Add VOP2 support
Date: Sun, 19 Jan 2025 13:41:27 +0000
Message-ID: <6563300.lOV4Wx5bFT@melttower>
In-Reply-To: <7b0b95a6.1824.1947dd3a56a.Coremail.andyshrk@163.com>
References: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
 <20250116-vop2-pt2-v1-5-c9d646b53930@riseup.net>
 <7b0b95a6.1824.1947dd3a56a.Coremail.andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Sun, 19 Jan 2025 15:46:36 +0100
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

Hi Andy,

On Sunday, January 19, 2025 9:10:10=E2=80=AFAM UTC Andy Yan wrote:
> Hi Danq,
>=20
> Do you have tests with this u-boot video enabled then boot a linux kernel
> also with drm display enabled?
>
Yes, I booted Linux with U-Boot VOP2 and Linux VOP2 enabled without any=20
problem.

> Because the u-boot video been enabled with no-mmu, when it runs into linux
> kernel with the window/plane you enable at u-boot stage, when linux kernel
> enable the iommu, there is a moment the window will read the memory throu=
gh
> iommu, but the framebuffer you set in u-boot stage has not been mapped by
> iommu, there is a high probability of causing an IOMMU page fault.
>=20


