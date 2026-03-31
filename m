Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D657510F9303
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 22:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8839884056;
	Wed,  1 Apr 2026 00:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Gau7fFPy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NL5qgJRz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1DD583F5B; Wed,  1 Apr 2026 00:01:14 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEDB384056
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 00:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4flhs440kVz9v8f;
 Wed,  1 Apr 2026 00:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774994472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9IWM4+mXeYKruYwUERNy3XvDPy3t4B+8H60h8OPMu4=;
 b=Gau7fFPyUWy/Uo9hIFAionsuCN2LwOthnAJ/zJ6ZJmQF6/GpiGmh7WZJZPoHoF38YZXPID
 qj2ERdsxToTpeLO46SK2Syk0XOd2tg+NgmIo1esgct5Ruum1T54Kv3p++w0wGWK36Xmsui
 9LSc86/didhNvGDIVSdaK+qxAUUVLBy9Ak/4ri7W21kzH3r6i/QFGPUOCmDca44VardzfF
 qgWg3ouHHbEfSx904XCLz8cGWIczBd0aLz/TwcheOVkdx/bhkMlzWbqJHeXhDzMwzYqYfO
 diATCpdZ+Q1Vo3D3kCDDUwysvyWBAh8Ev5j/z79514d5eNTMzu+YIDlYyUOm6g==
Message-ID: <29fd4e34-2242-40a0-b8b3-29d1b88c7f95@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774994471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9IWM4+mXeYKruYwUERNy3XvDPy3t4B+8H60h8OPMu4=;
 b=NL5qgJRzACYo6ElVajFhOAw5UjX3NDrdSwr0E/TDEsp0YK7RuLuW90itMa7Ap21QmqQ6Aq
 DpoT9OclJ+nRZ4GrfEPuvNIRpOkVbIw+upE/hnSTmg3RchAvt+eSxhPNGpxcWXX2+EC7v1
 RQGwSYupfUiXS0OhV0qnjA2TQ12kbyPzl49p6THSiPCyFSp2DiWBNAlkas3PvyNbiO954u
 jSGh1Try33ihgW92xUg+5mfXbORwNDzS1tSyWJWfczfq/RVuFsjUIEYcjcTbxf/Iehfj5F
 SsaEecseXemqyQx9Kl/ls9SPUD0BMIzVvKbE5rOKHIDFEa3cCTKLj5coo6L96w==
Date: Tue, 31 Mar 2026 23:45:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] common: Allow relocations on the top of the last
 bank
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 marek.vasut+renesas@mailbox.org, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bpp4s6gt74cax7kddbebffr3piewp5az
X-MBO-RS-ID: 9346b0352a600af14e2
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

On 3/31/26 10:01 AM, Ilias Apalodimas wrote:

[...]

> @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   		 */
>   		return 0;
>   #endif
> +	if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
> +		phys_addr_t old_top = gd->ram_top;
> +
> +		ret = fdtdec_setup_mem_ram_top();
> +		if (ret)
> +			debug("failed to relocate to ram top");
> +		ret = fdtdec_setup_ram_size();
> +		if (ret) {
> +			debug("failed to calculate RAM size");
> +			gd->ram_top = old_top;
This changes ram_size , why is this restoring ram_top ? Should this also 
restore gd->ram_size ?
