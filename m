Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A9AC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 07:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9098E83BEF;
	Thu,  7 Aug 2025 09:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754553577;
	bh=MREfnKG4vv8KFqWIZWnvBMENvLlCGs3b2x0yCR62+yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IiPNpughFrVG8biwM4cu5nvcleXyompw1sDeMAkypVhgFEpOf6smGgJ2d26VAwesw
	 5PuOJEgjtw+dxHn5qhkakXhic8iMki7pX6iSgoOPpOc1VlLtdtOwumkGw6Kqlu9Jz7
	 G+OvA6l4YVhmF3aDbdduMyZhK0QUV2u5iuI0CVUepCwRBMcQDKQZsqDg4XZNJAUObT
	 nJJDMhWK2PJEpMP1KpP/9I9a0mAjoImyiwfPSPnPitP7iE11IdxXxqclwQeBW4KcWE
	 47SqjDn5XPDg+zBuX0i31PTbTHgN7fkEdQQC+HJpJtA3w7mXac++qH2qTPUTKjxhSU
	 sWT7ypMCFJXKw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1387D83C0E; Thu,  7 Aug 2025 09:59:37 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3737783AE9
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VRq2u1eX"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5483D1038C12C; 
 Thu,  7 Aug 2025 09:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754553574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=MREfnKG4vv8KFqWIZWnvBMENvLlCGs3b2x0yCR62+yc=;
 b=VRq2u1eX8utA/aXLOWAf0/bIyW9NGXLDLXScZ6tnR6xs0KDnbAJ5mUGxsGfEyqKywd2fba
 Pbqm0UHBa3aNDf8lqJOWnglmg6aZHR5yD3CgYXPHOaMm8gDgWVowCtECR0pmD74uep2oAa
 9ks0U/UgJEPnxo165ED3DFzOL7sZyUiGi+QIue7x5AU89miThXErQb8xqryAiMSUx7Y1iG
 1N97sX8N6AScKSGCNrfZ5QHuv8NFPdbBngi7QiqWlNlNlVz1AyaWi1m8ffnk30rC12WBzP
 SFyFHR2akAS6EEwp37Xt93Sck+FaZX8X8MAYSZ0Xfq5Nvrz8Z+HWv/GixdaF0g==
Date: Thu, 7 Aug 2025 09:59:33 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v5 4/4] mips: mt7628: Add Onion Omega2/2+ board support
Message-ID: <aJRc5cPgYz_8f_w4@antares>
References: <20250730123833.249923-1-pro@denx.de>
 <20250730123833.249923-5-pro@denx.de>
 <97c97d83-1e1d-413d-9838-be865d531b9e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c97d83-1e1d-413d-9838-be865d531b9e@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Daniel,

Thank you for the detailed review. I think I have properly addressed all
the mentioned points in V6. 

Best regards,
Philip

-- 
=====================================================================
DENX Software Engineering GmbH,
Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
=====================================================================
