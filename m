Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8564FC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 07:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B91D8141D;
	Wed, 12 Mar 2025 08:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iI06LzaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 476A78141D; Wed, 12 Mar 2025 08:42:10 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61255801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 08:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 79F155C337C;
 Wed, 12 Mar 2025 07:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133EEC4CEE3;
 Wed, 12 Mar 2025 07:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741765326;
 bh=LwvD2/XJrgmZ3ZdQEFkg/sS2bPZQoOLuz5FTOJSOLUs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iI06LzaBfsKMCBkhJKY9wL9WK09PRN4oGXVU/hprTRsddEsnh2eu8CMkfxPD7oQ7t
 Bm0gtX4sVm3jr5NRMWtUhrVN50d0ygHIhrlgUCAQvG/GYx0Y9a1RlCej9H1slrE7O+
 1gsEfzmJZbyoHKMMv2hHyXghma5J3exPM9+CjMobWF/HDRhet9yXjx1eUcCB60M9BM
 hNGvy9gLxK2VoEqZSVeMQ5b7yGbMh1tz7CIjhhcKhByobP4T/aG5xIVQef12jXYvOd
 oihq06MOoy8csuV+2G3ilRkCpGt4EwlsZwLSGtneGDUrYZ2cfh2tJQvnLvCOeAG2Jj
 OAI6ePOkk2j+Q==
MIME-Version: 1.0
Date: Wed, 12 Mar 2025 08:42:02 +0100
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] net: lwip: remove superfluous newline at tftp help
 text
In-Reply-To: <20250312073750.2281630-1-mwalle@kernel.org>
References: <20250312073750.2281630-1-mwalle@kernel.org>
Message-ID: <969cc67f1b64a6d338c2431de61b1287@kernel.org>
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
