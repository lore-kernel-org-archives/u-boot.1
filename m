Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50248C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 08:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F1880F03;
	Fri,  2 May 2025 10:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746173837;
	bh=kybuSHL8HElia/C9Pzny/cO+f1lC+BrkL01EdGNKFNM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uiJPa2aGRuieeCy92LOeY1hEdMd7E5H+kG6m3x+/6DlvYlTh5A+HVfPxrpNSHu+KQ
	 sNKaPkv5aGPMTxZ/lzHnxPT9FHFMMs+TgshhVVPzB4F1k26iWWh4idCJlda14B2lxv
	 NIRWTcheXJ9FsIipx/9//wqVq4D6ZYHks1nzVPcAm+MW4//9vhn7+WGoNkvdf8oLcO
	 pDaQrqWLgSYsUxaNuxCP9xiVFd9rhr6fCIl66ROJgFzNAVu96AzbXkvkr/SgOsjyH6
	 h9E14euKnQMAJ0raEFOfNX05MUYHv2VICbH9Abif5u2C7hYse/ANskAJZz5evqO74s
	 iHLMQ73ZXf5Rw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E58812BC; Fri,  2 May 2025 10:17:16 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3332F8070C
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 10:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4ZpkKz6R9gz9tf2;
 Fri,  2 May 2025 10:17:11 +0200 (CEST)
Message-ID: <6d1dca59-6dbf-4697-88c5-c3979fc0efdc@denx.de>
Date: Fri, 2 May 2025 10:17:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 11/22] synology: Include env.h to permit reading the
 environment
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Phil Sutter <phil@nwl.cc>,
 Tony Dinh <mibodhi@gmail.com>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-12-sjg@chromium.org>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250501010456.3930701-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 01.05.25 03:04, Simon Glass wrote:
> This file reads from the environment but does not include the correct
> header. Update it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
> (no changes since v1)
> 
>   board/Synology/ds414/ds414.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
> index 1a4cea87e1a..02d6a4a1ea8 100644
> --- a/board/Synology/ds414/ds414.c
> +++ b/board/Synology/ds414/ds414.c
> @@ -4,6 +4,7 @@
>    * Copyright (C) 2015 Phil Sutter <phil@nwl.cc>
>    */
>   
> +#include <env.h>
>   #include <init.h>
>   #include <miiphy.h>
>   #include <asm/global_data.h>

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

