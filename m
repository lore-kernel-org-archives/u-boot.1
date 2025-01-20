Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE083C02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 09:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB7680716;
	Mon, 20 Jan 2025 10:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737364995;
	bh=jBErVRStAHhxUehOGnei5hhFqSF7b9A8iiMyDx9puPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z7jsiEONsONoxf/aGJc2IoInH94jM8ywC3M2xWQiuvKcXw+XsH6ZIf2k2++ocd7wp
	 gMYbogg0AEp0CGWaurMZFK4jgh0PX+6Kre/9NQC6YRIY9+tI+ZZtSMwxG0T4YEQEYE
	 Z9CT9hPsRtEXBkV9ejMyjTjT5dMLYNJ7W2NcEv25i059nZKFWFi+woc2AJ/DyRGQNL
	 mZ+0qHrCknnN6OYo3DapO8W4HJW3i7I52Zjs1BEavqj1li6tod3B6bw5/JBHG4FNSv
	 Rlya51PaZ/hIb7zrygTcNWONJdvv2YY4tF88a0zCMmii3qRA+zFi3s34HWF+pGXP5O
	 TU9c9at5tzM5g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB68E80759; Mon, 20 Jan 2025 10:23:14 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB4C80077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 10:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Yc4dB44cjz9t1F;
 Mon, 20 Jan 2025 10:23:10 +0100 (CET)
Message-ID: <4b8ff4a2-2ed1-4a72-9852-34d0f4b4eb36@denx.de>
Date: Mon, 20 Jan 2025 10:23:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] cyclic: Fix typo in struct cyclic_info description
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Devarsh Thakkar <devarsht@ti.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250114132814.1250117-1-patrice.chotard@foss.st.com>
 <20250114132814.1250117-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250114132814.1250117-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Yc4dB44cjz9t1F
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

On 14.01.25 14:28, Patrice Chotard wrote:
> Replace delay_ns by delay_us which is the field name used into
> struct cyclic_info.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> ---
> 
> Changes in v2:
>    _ Update the comment which still references "ns"

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> 
>   include/cyclic.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/cyclic.h b/include/cyclic.h
> index c6c463d68e9..df8b725e3d0 100644
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -20,7 +20,7 @@
>    *
>    * @func: Function to call periodically
>    * @name: Name of the cyclic function, e.g. shown in the commands
> - * @delay_ns: Delay is ns after which this function shall get executed
> + * @delay_us: Delay is us after which this function shall get executed
>    * @start_time_us: Start time in us, when this function started its execution
>    * @cpu_time_us: Total CPU time of this function
>    * @run_cnt: Counter of executions occurances

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

