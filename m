Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C207BCAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 12:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39187836C1;
	Thu, 25 Sep 2025 14:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KULKc6C9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134AD8373B; Thu, 25 Sep 2025 14:05:57 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E208D832AD
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 14:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cXXVT1tbFz9t3C;
 Thu, 25 Sep 2025 14:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758801953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CcGVnnwhLSK7B00nsxTdqfvTyKItOlydOaAP/r5EoQ=;
 b=KULKc6C9OVbfAgzfL5845bLUP0mFF9fn6O26ZDHZSGMwpuH9+HDhcpkXL5X/CiJbmnNiRX
 enkaBehfTZrsHEPxrDogNAw+EeQgPisDEDWnzyxUdMNDfYUkz7xdInq09R2+pxgRvzVhoN
 SIMrOc+n8ecytEW1IdErtNCsK7MRIHzeye0eHAuEYZvBJ0htzsb+PY73U6H8qsaBHF+6BW
 dP9vMPgi1M/feJyEfmbWEYMS06QVIugPoAxTGw7FMuxT0esIHWcEBpGD685ZDiViEMbsaW
 BGCYKxwbop/PtrSOe8yHpcV2+kRzAYWiWsty3xJQRjPKfmQ/AZ9x++id9G/vOQ==
Message-ID: <59c05121-0145-48b7-bde4-e288f4d80d72@mailbox.org>
Date: Thu, 25 Sep 2025 14:05:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: fsl-dt-fixup: Return an error code on error
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sriram Dash <sriram.dash@nxp.com>
References: <20250925-fsl_dt_fixup-v1-1-c11962904d5b@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250925-fsl_dt_fixup-v1-1-c11962904d5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3j94wa3pcrbzzf1zkeyirequoegu3s7e
X-MBO-RS-ID: ab2496e7a4a10dbafa3
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

On 9/25/25 1:56 PM, Andrew Goodbody wrote:
> fsl_fdt_fixup_usb_erratum uses strcmp to detect an error but then
> returns 'err' without it being set to an error. Calling code may not
> detect that an error occurred leading to a silent failure. Instead just
> return -EINVAL.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/usb/common/fsl-dt-fixup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/fsl-dt-fixup.c b/drivers/usb/common/fsl-dt-fixup.c
> index 6a68bd76c27..55176f7a871 100644
> --- a/drivers/usb/common/fsl-dt-fixup.c
> +++ b/drivers/usb/common/fsl-dt-fixup.c
> @@ -99,7 +99,7 @@ static int fsl_fdt_fixup_usb_erratum(void *blob, const char *prop_erratum,
>   	else
>   		node_name = node_type;
>   	if (strcmp(node_name, controller_type))
> -		return err;
> +		return -EINVAL;
>   
>   	err = fdt_setprop(blob, node_offset, prop_erratum, NULL, 0);
>   	if (err < 0) {
+CC NXP person.

The change does look valid.
