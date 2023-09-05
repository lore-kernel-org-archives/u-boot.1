Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008B5C83F2C
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 03:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156DF8652B;
	Tue,  5 Sep 2023 05:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4CD86549; Tue,  5 Sep 2023 05:02:53 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7EA864D4
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 05:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38532eBC077510;
 Tue, 5 Sep 2023 11:02:41 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 5 Sep 2023 11:02:37 +0800
Date: Tue, 5 Sep 2023 11:01:39 +0800
From: Leo Liang <ycliang@andestech.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] riscv: Rework riscv_cpu_probe for current event macros
Message-ID: <ZPaaEyaBss-XDc4X@swlinux02>
References: <20230904190635.3896494-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230904190635.3896494-1-trini@konsulko.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38532eBC077510
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

Hi Tom,

On Mon, Sep 04, 2023 at 03:06:34PM -0400, Tom Rini wrote:
> This function should now be a EVENT_SPY_SIMPLE call, update it.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/riscv/cpu/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index d64aa330f206..cfe9fdc9df55 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -66,7 +66,7 @@ static inline bool supports_extension(char ext)
>  #endif /* CONFIG_CPU */
>  }
>  
> -static int riscv_cpu_probe(void *ctx, struct event *event)
> +static int riscv_cpu_probe(void)
>  {
>  #ifdef CONFIG_CPU
>  	int ret;
> @@ -79,7 +79,7 @@ static int riscv_cpu_probe(void *ctx, struct event *event)
>  
>  	return 0;
>  }
> -EVENT_SPY(EVT_DM_POST_INIT_R, riscv_cpu_probe);
> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, riscv_cpu_probe);

I cannot seem to find macro "EVENT_SPY_SIMPLE".
Is there anything that should be added?
Or did I miss anything?

Best regards,
Leo

>  
>  /*
>   * This is called on secondary harts just after the IPI is init'd. Currently
> -- 
> 2.34.1
> 
