Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307CFF588EE
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 16:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF868421A;
	Mon, 20 Apr 2026 18:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QtthAn9G";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Grnvpqht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 202F68422D; Mon, 20 Apr 2026 18:13:37 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2DF8419E
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fzrBj0zQLz9sv3;
 Mon, 20 Apr 2026 18:13:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776701613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEWVU/dg5JCHihrkuAsgX3jeWaObYq5WJi5zkB1DH+4=;
 b=QtthAn9G/lE2mkEiXEbRabI5Q2aglyvDbu6zLP2DoHZi1aZSTN06S6Tf1jsepAbgkM5+ER
 pRYrim7+77S0l9J72z1y6N77svdvq+rueY8jnJE5giCG7SkJlo+ufow4QNhurf2HYi+m2s
 nCoq1Ki7FuL8bgvqPUNu2DZGHyPVk1MeFuuXHusuoWc7LD88ZCYF5hwftQoeOhA5oSEEX+
 aKvUs9kxix2y8th9z57t83e0uPfzRQtOXZO9tX6plXCB91ajbQBcRx+8CWkwTysmc06iJM
 AnQ0xdze3usJepqib16CMi1VKLWt0UWG5yXqU469yvkLPR3sQ1GplSYDyLDwXg==
Message-ID: <02f8516c-71b6-46b3-82b4-f5a2b37e1593@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776701611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEWVU/dg5JCHihrkuAsgX3jeWaObYq5WJi5zkB1DH+4=;
 b=GrnvpqhtnBvsJUdTgHt33Mdi+W85vbZEqV6EA0a9zCnlR25xC+q7wkkY08jlTOeJjkQMb8
 kMHlyGZ/HQI2VVBa5TM99grnrSDwtwvoYHy3P+s+GQ01VLU8SBvHQQOtd+Yol1mjXYs5m3
 q6dTq93+szUVdeKD6R2+gHBsa4PUEzpjGEbqAQAL5EJG7VxG7xivybnCS6Rm23QOQqVTxq
 esSEhqeS6Vx8ZXcdSINj71lWDA3C4UvfEal8iEweypodqZxJv3YqZw8fgH/gpWFRwZifKT
 fYbsPndC9g/MCF3HVzJFe08TKXLQSu+AFvcDeKTXYzF16rn2Haaavc92QXgkeQ==
Date: Mon, 20 Apr 2026 18:13:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/3] configs: r8a78000_ironhide: Drop duplicate
 CONFIG_SCMI_FIRMWARE
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: ggiordano@phytec.com, w.egorov@phytec.de, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, bb@ti.com,
 afd@ti.com, d.schultz@phytec.de, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, hai.pham.ud@renesas.com, michal.simek@amd.com
References: <20260420145353.3923395-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260420145353.3923395-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jysfpzjb5ct5t7w7kicgjud9jns7rbhe
X-MBO-RS-ID: d35b2af167def3489b4
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

On 4/20/26 4:53 PM, Aristo Chen wrote:
> CONFIG_SCMI_FIRMWARE=y is listed twice in the defconfig. Remove the
> redundant occurrence so each option appears only once.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   configs/r8a78000_ironhide_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
> index 64e2c278a7e..d225d5a970d 100644
> --- a/configs/r8a78000_ironhide_defconfig
> +++ b/configs/r8a78000_ironhide_defconfig
> @@ -32,7 +32,6 @@ CONFIG_RCAR_MFIS_MBOX=y
>   CONFIG_SCMI_FIRMWARE=y

Please drop ^ this one, to keep the list sorted. With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Nice find, thank you !
