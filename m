Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224F3CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 08:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93AA48652F;
	Mon, 16 Oct 2023 10:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697445094;
	bh=v/TJs2cEqDmddDDd+TF/Ru2Ej5abWHvR5Tg4p8PJ524=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zyTLBRrqbHfStrXOCfEPSkkUgLu7xtWelbyDeiIkDLcwBWuPQejKzgqO+OAPYkh6m
	 q9gL91XbCOLpGw6Q61N+J2brMGV2iIHmrpjjxzIMWgt5fcrWCeQS1t5eZwu+qBMFp/
	 pIDYGjGggpH5YfYAmu5vRj6RB4ycenCNr6ss1Rjx2+gyNvoxi6mTPaVlyKUwDgbVbP
	 LChPW3ePBMP5Zp4rMTa+TXRIdsPdfPId2j9fb1+49VDeh5NvmAT7vgI1NgTEuQU46V
	 S1T6TM1ArwUIJYzFBpPDnyILaIkxplTrF68V0r6HF/9sbTBTm76Tnx/QdoVSRj+dz3
	 Q1gfIWeElBTmg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF4BF86784; Mon, 16 Oct 2023 10:31:24 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E23C68656E
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 10:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S89Lc6jpbz9sZS;
 Mon, 16 Oct 2023 10:31:20 +0200 (CEST)
Message-ID: <4f447979-49e9-4873-905d-52b965f90892@denx.de>
Date: Mon, 16 Oct 2023 10:31:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] cyclic: doc: Update documentation for
 CONFIG_CYCLIC_MAX_CPU_TIME_US
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20231007105236.155361-1-o451686892@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231007105236.155361-1-o451686892@gmail.com>
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

On 10/7/23 12:52, Weizhao Ouyang wrote:
> Cyclic now just print a warning once instead of disabling the cyclic
> function when the cyclic function upon exceeding CPU time usage.
> 
> Fixes: ddc8d36a7455 ("cyclic: Don't disable cylic function upon exceeding CPU time")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   doc/develop/cyclic.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
> index 43bedacb9f..be70a54f67 100644
> --- a/doc/develop/cyclic.rst
> +++ b/doc/develop/cyclic.rst
> @@ -11,8 +11,8 @@ on a high frequent polling (e.g. UART rx char ready check) might be
>   delayed too much. To detect cyclic functions with a too long execution
>   time, the Kconfig option `CONFIG_CYCLIC_MAX_CPU_TIME_US` is introduced,
>   which configures the max allowed time for such a cyclic function. If it's
> -execution time exceeds this time, this cyclic function will get removed
> -from the cyclic list.
> +execution time exceeds this time, cyclic will print a warning once to show
> +this potential problem to the user.
>   
>   Registering a cyclic function
>   -----------------------------

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
