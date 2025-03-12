Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8883DC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 07:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DE681671;
	Wed, 12 Mar 2025 08:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GkgEH3YS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ACA98175D; Wed, 12 Mar 2025 08:42:29 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07ADB80756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 08:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0A2A65C493B;
 Wed, 12 Mar 2025 07:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDCFC4CEE3;
 Wed, 12 Mar 2025 07:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741765345;
 bh=LwvD2/XJrgmZ3ZdQEFkg/sS2bPZQoOLuz5FTOJSOLUs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GkgEH3YSNQcbJZzH3bqyqICq+/htqPZr95RRmollo4UCmwYCCj9V2f2tddcpUflt8
 Uv+gC9PB2Fx1ld2wBy+naBej6mnjDRpZcKzcsXJd30SkUEcm9MuHVyTFv/UX+X7+9+
 zXOZz2fVQ58FbdV2qD0xA5B/XbORIrzF8e5jZ0JFp5+ThJ1kAwdh0pGgIdxqBDrGai
 edt4X0vwogBtpTmQqtP0khiLPW9P14Jm8020rJwEx1Ifu/VwbVyyywS3c93EZVcBU9
 q7YZfnKN4yE0zm02P3ZQnh4FiC/eA43zzbjKSaMbrJQqyO+xrg9r04hSMRtIzIPgh+
 KxeUvgJZqIlWg==
MIME-Version: 1.0
Date: Wed, 12 Mar 2025 08:42:22 +0100
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] env: mmc: fix offsets relative to the end of the
 partition
In-Reply-To: <20250312074019.2281884-1-mwalle@kernel.org>
References: <20250312074019.2281884-1-mwalle@kernel.org>
Message-ID: <51f0d19085647c51f6ab28005b6abd59@kernel.org>
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
