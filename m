Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309E0C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 08:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8478E83043;
	Mon,  7 Jul 2025 10:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YE2KTYGr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EWmX5Px/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A6883071; Mon,  7 Jul 2025 10:37:56 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868A383015
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 10:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bbHgP2W2mz9svK;
 Mon,  7 Jul 2025 10:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751877473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oJmSEuwwEo8N9sp1uZ43UbBzWgB7lICc58Fuzc7HApM=;
 b=YE2KTYGrv4M/ToWyaI1BVwseRKoF+OrKc8tHOH29yaqW2frmiPgH01QVeM/++sQGT8OuNc
 0oB9aI3LbmbpQe45CKLq8JBZU1VitTHOvpiSJrhripycFZ9C2EUcWmpFJO5wxQsb/7WNhq
 FBQpSYjLhJIV8+7SYvciOX1IAZHpDaEDAIjpSMpwMgm97vpslFjBidiW+jZw8SW4jGk/Wp
 p2OeM+bbJWwUj9kLVc7iBqrgRcmybdzlf7eU4wvOr5bo1+xnJRnCQ6QpXogqevCtmOFkRz
 JSiaPUkJ/fnlzJikdEBB8S9Agt4IyIpeiIzRvTljkJZOWD/j+gwUY5DF6D/JOw==
Message-ID: <6bb9f65d-edb9-42d3-9b33-603825adf49f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751877471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oJmSEuwwEo8N9sp1uZ43UbBzWgB7lICc58Fuzc7HApM=;
 b=EWmX5Px/qGzlk94IgEG/Y1Wb1Tg6s3yszh8SYuhCXgHQGWV0/HnK0EpFkYAYiDZV5pIy7D
 xxsyLu7A3KFviaJ/qlzyRaYqiWi7kpD5QwGDsOby/np1GHE5EklQiWAtsifh4UYO6N/D36
 79eIF1qufJIIsTsAmwADeYd8v2EuUK5oCMrtgkFV68imYqgCNnGw7qp3BMUxYFBi6j2fT1
 btjBlJwITTdBXeuARxI0y3cKutBp5/eYj/VjMwmne1v2xY/9j9KrIMPqV5BcD1XRw8e1NK
 kUh3vbHS8k/xpMjeSKRPIQ4zB79O5gsbbY7wo/sBD1+vL59E+e1xPj3gMIxa7Q==
Date: Mon, 7 Jul 2025 10:37:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] makefile: Adjust distclean to remove .binman_stamp file
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <175146324587.68406.3781314116200023930.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175146324587.68406.3781314116200023930.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0ddba2109d0f69ca03a
X-MBO-RS-META: n3ew9436pdbzm67witoe17sgpcgp3buy
X-Rspamd-Queue-Id: 4bbHgP2W2mz9svK
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

On 7/2/25 3:34 PM, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove the .binman_stamp file during distclean
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>   On top of cbb5672790d400e9ec6e9fceaf89ece2660c0117 (origin/next)
> 
>   Makefile |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0001/Makefile
> +++ work/Makefile	2025-07-02 22:18:46.615791336 +0900
> @@ -2309,7 +2309,7 @@ distclean: mrproper
>   		-o -name '.*.rej' -o -name '*%' -o -name 'core' \
>   		-o -name '*.pyc' \) \
>   		-type f -print | xargs rm -f
> -	@rm -f boards.cfg CHANGELOG
> +	@rm -f boards.cfg CHANGELOG .binman_stamp
>   
>   # See doc/develop/python_cq.rst
>   PHONY += pylint pylint_err

+CC Simon, Tom

Please use ./scripts/get_maintainer.pl or binman or some such tool to 
get a CC list.
