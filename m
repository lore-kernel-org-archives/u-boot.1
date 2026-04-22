Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3D5FA1FE3
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 19:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89BB68437C;
	Wed, 22 Apr 2026 21:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kNSwvyoE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D6428439E; Wed, 22 Apr 2026 21:08:58 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC7E84227
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 21:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g18070hbsz9tr3;
 Wed, 22 Apr 2026 21:08:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776884935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HL1Vny/TOnkZcGcD+gCt0heChcL+ZWP0yqQpU5CPl9E=;
 b=kNSwvyoEU2LRPSrae2L+4SoRLQSsKDbKik/892jZArQRZp4ej3KwXLLvXq9/c12shNsHZq
 XZEX/4Pm4R0tTWrRGdAMKWLf3SiukM70rzO0JQ5+xyPVgAah2qJRID+dLnnOxYbyt6stpu
 Iis6ny+T70JgOhYSBuI13YFBzxIyHFFKhxOwb2qyveNp2gBCdmfv83evTO1s+HgRoNAiZE
 WA4Qm8v3kwx2EJohJJ4//ewJBLImTYQA8l9PA5Y4pstjNsQ0fVAEsw5riZpP67dvyy3R1N
 eFpMTDLazwnzCEG5n3UcF5p9Blt3LmLjfqC83uWV4FJzcSR0u1Otq9q0Kp1K0A==
Message-ID: <9a9194d8-65ee-4c84-a760-2a73378a7170@mailbox.org>
Date: Wed, 22 Apr 2026 21:08:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] fdtgrep: Add option to reserve free space in the output
 FDT
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260422023131.2813748-1-sjg@chromium.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260422023131.2813748-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 59319d20753677950d1
X-MBO-RS-META: ad44kocp3bi4u49t4ctuarrebdz3ug47
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

On 4/22/26 4:31 AM, Simon Glass wrote:
> When producing a DTB from fdtgrep, there is no way to reserve extra
> space so that more nodes/properties can be added at runtime without
> growing totalsize first.
> 
> Add a -B/--pad option that appends a caller-specified number of free
> bytes after the strings section and grows totalsize accordingly. The
> padding is applied after fdt_pack(), so it is not reclaimed when -r is
> used.
> 
> Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/binman/btool/fdtgrep.py |  3 ++-
>   tools/fdtgrep.c               | 31 ++++++++++++++++++++++++++++++-
>   2 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
> index 446b2f4144b..7b393241878 100644
> --- a/tools/binman/btool/fdtgrep.py
> +++ b/tools/binman/btool/fdtgrep.py
> @@ -16,9 +16,10 @@ Output formats are:
>   	dtb - device tree blob (sets -Hmt automatically)
>   	bin - device tree fragment (may not be a valid .dtb)
>   
> -Options: -[haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
> +Options: -[haAB:c:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
>     -a, --show-address                 Display address
>     -A, --colour                       Show all nodes/tags, colour those that match
> +  -B, --pad <arg>                    Append free space to the output FDT, for later growth
Shouldn't the parameter at least match the dtc -p parameter ? -p is not 
taken yet.
