Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB76BC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 07:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 771FD801FB;
	Wed, 12 Mar 2025 08:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mTBCFHDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4FE680756; Wed, 12 Mar 2025 08:41:51 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CAE801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 08:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AC8365C493B;
 Wed, 12 Mar 2025 07:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B06AC4CEE3;
 Wed, 12 Mar 2025 07:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741765307;
 bh=LwvD2/XJrgmZ3ZdQEFkg/sS2bPZQoOLuz5FTOJSOLUs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mTBCFHDgTWX+jnZPNBrVbODX9gzvyD2zABfPeRPZgLt4vepeD39XYIRPGNqcecru3
 mQixJIPDCm0gP+pFtYwzivHC2DuXY87re38vYC/PxRIlb02ImlfYZfEEtd0bEcyUFc
 5Ywa+tFunapTPIexvfNydGxEWs3hfE/dEcSX/WWUxJuK8N5IjAKJDg6MneE73I2ehE
 snei64EngnhigXDwKiTZzq4kLkQP4gCoJjWu4vS07bf1on3jXyqbm0M5DP9REWRNWf
 +AaUfXuTe4hw3VHtiUFqMQLu4BUGVheNMCnTbd0oZvKG76FHp9/t+bJxE2g+Abbhx6
 nApbHAbiep+qg==
MIME-Version: 1.0
Date: Wed, 12 Mar 2025 08:41:43 +0100
From: Michael Walle <mwalle@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] fastboot: lift restrictions on !NET_LWIP for USB
In-Reply-To: <20250312073655.2281377-1-mwalle@kernel.org>
References: <20250312073655.2281377-1-mwalle@kernel.org>
Message-ID: <a66467880e8ac96bacbf5b1a0cfde36a@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

Sorry this should have been individual patches. Please read the subject 
as
"[PATCH 1/1]" or just "[PATCH]".

-michael
