Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C708C105D98D
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 09:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214A183693;
	Wed,  8 Apr 2026 11:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D27YzHoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB4B884106; Wed,  8 Apr 2026 11:26:59 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6813780433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 07772435C7;
 Wed,  8 Apr 2026 09:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69624C19421;
 Wed,  8 Apr 2026 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775640415;
 bh=LCzuF5+el56TpnAraR/GZcEQrwxuHG9sNasxdb+cJbQ=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=D27YzHoopyxt49k0buQXVixoqsazvP2vBwyInXvVYjejihRu5ExvzAy9jItvAAdeY
 /YsxNAPxq7XfaJ5EvUwMfYEdlU7zuoED3K8WA8QDrIrZMyxdQxzkloLc2fNJz4vGeh
 DLUZfaznQtQ1rBYvDZBNWbTNQNa2mcxku+mN/qHUHVxtQMtoK1Mvgo8DxboQ2aqKIX
 kmz1BMSjYEZyHEVpESZLguKyZ+9MKHcJCpidTAB8rrzD8uqBIsvsSACaWMVwR+qfYK
 CWLlBZpi2aYFzE7B/3Mj4ncPgYqqMe1eR4331P7YRGpsXi9vU98IZKoCWJDRIsa8/W
 sBZpWS6DSo2jQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260317012435.4162538-1-trini@konsulko.com>
References: <20260317012435.4162538-1-trini@konsulko.com>
Subject: Re: [PATCH] dfu: Correct dependencies for DFU_TFTP
Message-Id: <177564041319.8234.7142996489355432881.b4-ty@kernel.org>
Date: Wed, 08 Apr 2026 11:26:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Mon, 16 Mar 2026 19:24:35 -0600, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue with the dependencies
> for DFU_TFTP. This really depends on the legacy networking stack being
> enabled, not just lwIP not being enabled (as it will fail in the NO_NET
> case).
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] dfu: Correct dependencies for DFU_TFTP
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/93a362d9f29227b94927ae1534e765a45cefc807

--
Mattijs
