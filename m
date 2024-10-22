Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DACD15D9D
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10A9A88D8D;
	Tue, 22 Oct 2024 13:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595503;
	bh=A36lEXZk4d7QwvtPQoF8nONPBUwROH3coIZ2gn+Mkuc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vehln3rc8DtsYozVv1aEY8xZaTQN9IxBmtELyekqIPpJ3u2lgg1mKhsBf8bJFRJDf
	 JKlWJajQQoGt5v0wyDN6DwjtE2+eFstSnODo0ZZZ6lLf5Hdx46GsXfmRGj3zFEl1nC
	 2W2fwI6JLq5MpEa39EpRd0EHuskTXKkR8cRWgCYXNDNoMZReObTcmKfTNlZFMcGoep
	 hm/kk4pfPmTY9dl/bfRWnBsxYcvij0EGdYMMDtDbsNIiZ9LThFerKqFIwsEPeRcEuI
	 FstMyPF9VH0nTgu3k2+LtKqgOh3Yg9ZLPgX+LLhFX9apJGaODbNOxZ5YVKlWT011/m
	 Xr5/XP3F117vg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D54588D91; Tue, 22 Oct 2024 13:11:41 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 758BC88D8D
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XXqHs3FZWz9t1F;
 Tue, 22 Oct 2024 13:11:37 +0200 (CEST)
Message-ID: <8294dfc5-9891-4fc5-881a-14e6c6eceb3e@denx.de>
Date: Tue, 22 Oct 2024 13:11:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 04/13] m68k: asm/ptrace.h: include linux/types.h
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-5-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-5-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXqHs3FZWz9t1F
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

On 10/3/24 23:27, Rasmus Villemoes wrote:
> Modifying a generic header like watchdog.h, removing not directly used
> #includes, can apparently break the build of m68k, because the
> asm/ptrace.h header relies on whoever includes it to already have
> included something that defines the type ulong.
> 
> Make the asm/ptrace.h header self-contained by including the proper
> header.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/m68k/include/asm/ptrace.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/m68k/include/asm/ptrace.h b/arch/m68k/include/asm/ptrace.h
> index d419824806c..5decf73a1d1 100644
> --- a/arch/m68k/include/asm/ptrace.h
> +++ b/arch/m68k/include/asm/ptrace.h
> @@ -9,6 +9,8 @@
>    */
>   #ifndef __ASSEMBLY__
>   
> +#include <linux/types.h>
> +
>   struct pt_regs {
>   	ulong d0;
>   	ulong d1;

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
