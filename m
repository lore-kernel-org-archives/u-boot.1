Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0D3E88D82
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 05:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942E184148;
	Sat,  4 Apr 2026 07:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CiyloJUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C623D8407E; Sat,  4 Apr 2026 07:09:57 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E81788415C
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 07:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fnkDL1Tm1z9tHp;
 Sat,  4 Apr 2026 07:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775279394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qn/pi4OIHfamgZK6q4Y2w0pN/2fAViJVsdjGYCY8nVY=;
 b=CiyloJUkGRjl0j0PVDXhDfd+fr4LlilM7tfrm5yI7mQ+c66ve8qCKqFGlgOE1ez25Zuvif
 WmMWnY0IkTvYwg8x/E9iExFkxlCD6jgLOexXaQQHuKce+uBoUc8/jY4nY0mpAoNkJMXpsi
 ijmoLfV8Pome3qeL7VoDH2w5Gki01X7Cs8zeIpmvTOy0n01J3K+s8LV3rGiBvfbi4rKwgP
 M7l+vgxT706YRGbzMv2+g6n+Y4JsswVSJ0X41CT+uQlUfgxia7vQP4re2IK/5fLQtCctq/
 kKLoRCNJaQZz2h5wArgMdZjXsYHvCKGIZZveNzq3xk4Hpf9HhxIK6PRgpxh6Hg==
Message-ID: <d2901243-66fc-4d16-90f0-09fb1fdefb05@mailbox.org>
Date: Sat, 4 Apr 2026 01:24:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 6/6] drivers: ddr: imx: Fix Kconfig for
 SAVED_DRAM_TIMING_BASE
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, viorel.suman@nxp.com,
 simona.toaca@nxp.com, ye.li@nxp.com, ping.bai@nxp.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <ee1ce213e039f7036ee7dd183445934901a01efd.1775121078.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ee1ce213e039f7036ee7dd183445934901a01efd.1775121078.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: sdc5jjorq5i6dza57d5ji7zoheagppac
X-MBO-RS-ID: cf08b6af6784577d064
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

On 4/2/26 11:40 AM, Simona Toaca (OSS) wrote:
> From: Simona Toaca <simona.toaca@nxp.com>
> 
> The 'default' directive should be before 'help'.
> 
> Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
Please send this fix separately, so this can go in quickly. Thanks
