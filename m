Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD325C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCD828666B;
	Thu, 31 Aug 2023 18:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693498514;
	bh=UOFulEocj09DrH8KVHIVWj6oXMTKg46E9WMvWD/yhpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GW1IuncvgZOa6ofI9nnz3MCortH5R06SafjrRBIgDNJ9tocT3LFyL/LCRyyKZN/7G
	 FzjOPN5c2aL2WNJtbuZXUnJUcZGpOOxxEYI+xVS/HhS+qBYgquRucpvqb3HoSQgtss
	 dpH4NFpSLDnIyCrzDFDo+28jaeT6VUQG9KXV48fMg6ewOntoDTfF4bj7VkuJ6YgZwz
	 T2QBXxL7602VVUmKSxckyvIn0gs2piZYyZqkpnT/3V86fArigzotlVQyOdCQmzeSmV
	 trhWzHZHAmAQEUJCIEYa2QCaxqN/C/eUaAu+lKvntY7+yqCR+P2aGsGGG3NIgTxMYl
	 3wMvrPZF2WnbQ==
Received: from mail.denx.de (unknown
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: festevam@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D2F0186519;
 Thu, 31 Aug 2023 18:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693498513;
 bh=UOFulEocj09DrH8KVHIVWj6oXMTKg46E9WMvWD/yhpM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=w2mUxxnGi/nxF6PmMppHEY1VVOznHGiWwOJr5QhPuTMMP0jRhRn8uvamw3G1farv0
 M2l/Dwgvhd+TMThkf1KCJfT3DydOwbaRNUjgd/w+FUcJdJiG60OtQAiOXnZatbxDdf
 lcQD97lDfIKJUBstijkXOtyN/IKyJJtrott+2fkQWaoadcQpd/89EmM/rO/G6pmaU0
 H/TggD3XPhoTUVAOvJBMbhLezgqI59gAUJp0DU7POFOtrh/VUttMZYDSeY98zEPOQ5
 XRUc5+dAXTdEdMRNEyDP1yS4zQAS01q0IhgGeY4FExwSfRGegPGTKyifWmczir8CV2
 m1FYlvI2PsCuA==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 31 Aug 2023 13:15:13 -0300
From: Fabio Estevam <festevam@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng
 Fan <peng.fan@nxp.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] imx: hab: Use CONFIG_SPL_LOAD_FIT_ADDRESS in the CSF
 example
In-Reply-To: <20230831145603.80139-1-marex@denx.de>
References: <20230831145603.80139-1-marex@denx.de>
Message-ID: <47ac05f428c60c6444293fe6f20fe7c3@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
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

On 31/08/2023 11:56, Marek Vasut wrote:
> The SPL authenticates image starting from CONFIG_SPL_LOAD_FIT_ADDRESS
> address, update the csf_fit.txt to match.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Tim Harvey <tharvey@gateworks.com>
> ---
>  doc/imx/habv4/csf_examples/mx8m/csf_fit.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
> b/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
> index 3d79edf2813..97f3eea573b 100644
> --- a/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
> +++ b/doc/imx/habv4/csf_examples/mx8m/csf_fit.txt
> @@ -27,4 +27,4 @@
>    Verification index = 2
>    # FIXME:
>    # Line 1 -- fitImage
> -  Blocks = 0x401fcdc0 0x57c00 0xffff "flash.bin"
> +  Blocks = CONFIG_SPL_LOAD_FIT_ADDRESS 0x57c00 0xffff "flash.bin"

Reviewed-by: Fabio Estevam <festevam@denx.de>

Thanks
