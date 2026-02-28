Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F8DFEE4ED
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 13:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9151883CDF;
	Sat, 28 Feb 2026 14:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OSADhOl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5378183DBF; Sat, 28 Feb 2026 14:28:29 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19D17801BE
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 14:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fNQxj6LRZz9tRk;
 Sat, 28 Feb 2026 14:28:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772285305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mcvLDOZ1DrY/H/nYMkShXaY9i/yvIx6wsjpBaht6EcU=;
 b=OSADhOl+eON8lTHgr+wGPVFtnhiDWrScDAR+ns8uYvIfUvz9GCUtP1Ha7Z3B0VAFaLzzn0
 WgbQBtSSqTcN4GK0bcWWU6XD/UYP62kW86wz0DvzVScdC2RwY+zaKmz14AkwqKEM04TL6f
 kAUzYShvKMUzLATVORivz3WQQoULnyCACOZ6BMkdkDkqruVHJzMYc21KCfhXyyXeOzMjPE
 jqfgi/Bzyq2ossbcoxoX5MKCAq6ONoVfh3yV4pVXkCaajB8SbKTyQIb99SfLfeUe/j7wte
 uP8Vz6z2b8b8PJ4Xu3ULG54w0yu+LQlKWtA48MGEx+0z59qFbSggAycpI9kYAQ==
Message-ID: <93faafda-d8f1-4e3a-a91a-51a84c04ee68@mailbox.org>
Date: Sat, 28 Feb 2026 14:28:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm: imx: imx95: Use arch override for env_get_location()
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
References: <20260228-imx95-arch-location-v1-1-b04896b35b20@armadeus.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260228-imx95-arch-location-v1-1-b04896b35b20@armadeus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 93541fb94558f679716
X-MBO-RS-META: kd4jk5jrtr4943fecb4fh1zg8mnef4eg
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

On 2/28/26 11:09 AM, Sébastien Szymanski wrote:
> Like commit b9e48705e0b6 ("arm: imx: imx9: Use arch override for
> env_get_location()"), use arch-level implementation here so that
> env_get_location() can be used on board-level.

Excellent.

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
