Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FBBC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 12:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1FB18873A;
	Wed,  8 May 2024 14:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="na8cQU7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 423A388725; Wed,  8 May 2024 14:19:32 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 287708844B
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 14:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id DAD47CE186D;
 Wed,  8 May 2024 12:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8C0C113CC;
 Wed,  8 May 2024 12:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715170765;
 bh=Yqd/ut4hQNGlvFcA0/QjFbDmqrMQh3GXAM/LMbMQgTc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=na8cQU7EI8+d9Z3QJssWCAI/agfqzCIBwBVxjUtpvwok/gj34vrKNLMoZozPOeNOE
 EW3UBX7HQCDcI2hd7zjE42COxPXEpZkkPEmUhbkbkVLl7dcHBu5LXYGSnrmk4NwwDX
 yrMEuETLJ+yyPVsnv0iZKkzuepwJQ5Wxj7qC/JhS37G+68AIVotfGM4e2MOv2YvPx1
 Y2a/O63xbUVU3bpWqgyocBekyvTlgMbxI5N6N+vXjHLXB3jlTS2rw04d6w89WKF5tx
 quDGkB6Y4/9t/ubaKppJ52WE6k6RqLKVUk6IeH0M/fBTK/C+hAXLqD8+WZKMhqQRqH
 2gFQTkFtst1aw==
Message-ID: <fdad0378-d71e-4cc6-a4f5-cb9b3b07a68f@kernel.org>
Date: Wed, 8 May 2024 15:19:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] remoteproc: pru: Add support for AM64x PRU / RTU cores
To: MD Danish Anwar <danishanwar@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 r-gunasekaran@ti.com
References: <20240430104633.1445311-1-danishanwar@ti.com>
 <20240430104633.1445311-2-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240430104633.1445311-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
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



On 30/04/2024 13:46, MD Danish Anwar wrote:
> Add support for AM64x PRU cores by adding compatibles for AM64x.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
