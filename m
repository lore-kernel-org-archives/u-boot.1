Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAC606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SJ3DO/Vx;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TyBSF6p6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4952C606A2;
	Tue,  3 Nov 2026 07:59:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_vd5Ei3bV8z; Tue,  3 Nov 2026 07:59:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C3BA606E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793692767;
	b=Xe4lpNLbA7+BRQ/E+18MEp3ldSZQoYlSVH2YD2/5K6DiccIWIz34KBIWvdua1bvy74yC
	 4NFWrkQJF2Ahb32eI8JxxuntRWnPcUlZ9X3inedpt0eKgt+W77ZOpNFo6d3jJaL7fE9dz
	 ePwHjnyls4cqf1DW0JLrMa/B3hKjryaw9gkdFIHrQ/rkRpVEUUbvx7umZ70jR7PtNkFwz
	 DOgUFrUHtuYU0LQuWoLUmB978RwqiObj4YSPnewMuGOJ2Q1GG1XwqqwolhXW/j8I0ao02
	 To8F52sF+BCcWWI0CQ/QrhzWuP7609ZElzQCSIuaD1mqOH3nlOD3uOxsEee/vtaHPrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793692767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gwtW2Dht0kJBXIA56TaQtRiZPFcSIuLoKqs5RzeMlgc=;
	b=k9M0bAJhIC/ricihehYM6Q4VDld/TZ+a2QIuWjpkGmReYnVVYOLLeIcJad3YMyt+X6Pv
	 pcU2ZIStTEVug44DpNOdNNL7YHyDFLXzfD+CeH4eavoiol7nowwz88Q+EjU+A3dFddLwu
	 ICOaSEFVPTVEdGJEWuaGpVInmExGYJlHFvUKsWqcMrj01/CATgHgTMiv/2MkpdKTBhd7q
	 bG2VrlWDJ7ey/HoGaCxvE5kCELah1SMuw8tAx4pKa0Rg8wMgxElbJWDW9TOo0YHOsJA18
	 6I6OPQCY958R6HHXXjVoXnCHKj8eZkheLPoSkokqBibkOWumhz41+Wl8dPcQ3tDysng==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TyBSF6p6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793692767;
	bh=gwtW2Dht0kJBXIA56TaQtRiZPFcSIuLoKqs5RzeMlgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SJ3DO/Vx2WD0JuQOIFu5uHstJIiF7RclKE0t+wbcn2926OsQvH2YbTPkiwUn86Mwy
	 gkhubdXM4FrDh7KkOcpRp5HL6gepK4416ySsAVKfSx1qfHJuDWN/Q/1JGG47H55qTX
	 8aqNunEQOdMuZOSH71eFhDdjY3lZyrFMhWSQevJ1ODfoMHhLkSVVAA79I+tV26nesP
	 aNR+Ba/Pk9PHQJTzEugDcyi2Po2nY+DTt+lrbXMtHSgQqli4CJd9gwbFN2nzgJu1WD
	 Epz9An45vER6dzVM1+IuAUp+lKlQGQto/WnNKqgyTUtstWKax9WN95c0R0Na8T7Hwn
	 yjAJd/YrVi5VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C3BA606E9;
	Tue,  3 Nov 2026 07:59:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C6884BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0206C606E9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ySkY-BaK2GZE for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:59:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E138606A2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793692765;
 b=g+LT8lY/lUw2TmffaJgV9EGXaEDTB8IfR8YVFqOxiGv3gLfDK/J4tnr+ucNEa48qnYyj
 PVAuDRrPJ5G3oL5AYZzaFTSR4h/z3DFacZW0RT2SEXtOjYmHydnrZbp6+uu7U6rlVBglI
 kxThJYuIBTk7vzqWdDfVOJpuU7bHf3DJZZHxSBcuFi7K2CRpYeeoiTWJj9G4nG3qJPzW5
 Vu1mfJPyqVfeoPYbOdhtHIzgCGSiYraX1iLs9GLaYMk+JjujCVlrNGwGz14UXRMkl83++
 5FQBMcJvhR43jCVBuyzcfckeU0l1+muynGfgZWDCVvCklFT0nK5inxUEf4NZaGW8Idw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793692765;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=gwtW2Dht0kJBXIA56TaQtRiZPFcSIuLoKqs5RzeMlgc=;
 b=Rx5AXpgYn/ag1hzr8WoMHLrmtToumf/sp5x2ixJ1//IbpsqEA8nfwc8/1CYLYpz+JBK9
 pTTbxUd8kn30Kx3xDnqmmGNxqVTRzldZok3o1oBs91gFK8AQQWhmmZyusB/PFHtyAQgvC
 p2y7jJTspgLZ5vWhQVHzPZ60GaCFc6mPxrbgEzyvEf8beS2OmzX2myqVdr6CIibIaQraX
 pToM6vwswFNgVFwy9HssfWieRYXYLaAx69nnZjjlONBUj9/JCxd3lnyxM1nClRmTXW16b
 PofmyRISD+fq52wpIfOw4zT3yTaoAUjOQ7Iif2/nsIHG68q2zeAOyLH1SSm6Z0k6Ypg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=TyBSF6p6; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=TyBSF6p6
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E138606A2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:59:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 340F71A1415;
 Tue,  3 Nov 2026 07:59:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 081016046C;
 Tue,  3 Nov 2026 07:59:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0F50510329199; Tue,  3 Nov 2026 08:59:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793692761; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=gwtW2Dht0kJBXIA56TaQtRiZPFcSIuLoKqs5RzeMlgc=;
 b=TyBSF6p6XK5Hq9T2eeWq1cUdAYcNzY2JF1UTlPKkkTh0mPaMnkwWz2UOSDxLeueTZdqudC
 /8uk5kvDhf4l7uebV4lpMWWxuytAsXyMhBiQ3JMnbSMBLpLWo+HTLIS+GF2DE2tlE00cMl
 jNUbW1SKo8BnME2EX008Krs37/7ZJcdlNYpFkFcQtNn0OX7TZQVx+qzg8H/38r56nLC8QZ
 rhEFZNpoLMynB3k8nCyyGk9DV2gcnOspSPFTZtABTwpCv12TLB03JLxQ6KqllKdvuJQUUv
 UlRBpPV1zEoARNuBwUe0Zq5sEwJ8wHr/B/CJLVwk1RC/s8EH3xyGGDhvIXTEzQ==
Message-ID: <bfc0d874-0670-4087-a83b-8eabe85710a2@bootlin.com>
Date: Tue, 3 Nov 2026 08:59:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] arm: mach-k3: common: add helper to wait for TIFS
 initialization
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Aristo Chen <aristo.chen@canonical.com>,
 Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Julien Panis <jpanis@baylibre.com>
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
 <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-1-2a67384ed0ef@baylibre.com>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-1-2a67384ed0ef@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le 30/10/2026 à 13:27, Markus Schneider-Pargmann a écrit :
> Add a helper to wait for TIFS initialization to be finished. Effectively
> this is just a call to get_ti_sci_handle() but I think a separate
> function makes the purpose of this call better visible.
> 
> get_ti_sci_handle() internally leads to fetching the TIFS version with a
> message and response. TIFS only responds once initialization finished.
> If a response is not received get_ti_sci_handle() returns after a
> timeout.
> 
Tested-by: Richard Genoud <richard.genoud@bootlin.com> # on j722s HS-FS
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/common.c | 10 ++++++++++
>   arch/arm/mach-k3/common.h |  1 +
>   2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 6e382efdb3be..480c90cfa65f 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -54,6 +54,16 @@ struct ti_sci_handle *get_ti_sci_handle(void)
>   	return (struct ti_sci_handle *)ti_sci_get_handle_from_sysfw(dev);
>   }
>   
> +void k3_sysfw_wait_ready(void)
> +{
> +	/*
> +	 * Wait for TIFS initialization to finish. This helper is used to make
> +	 * sure TIFS removed the firewall before U-Boot tries to unlock CTRL_MMR
> +	 * registers and continues the boot.
> +	 */
> +	get_ti_sci_handle();
> +}
> +
>   void k3_sysfw_print_ver(void)
>   {
>   	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 37ff98d89924..146b986febc6 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -38,6 +38,7 @@ void disable_linefill_optimization(void);
>   int remove_fwl_region(struct fwl_data *fwl);
>   void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
>   int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
> +void k3_sysfw_wait_ready(void);
>   void k3_sysfw_print_ver(void);
>   void k3_dm_print_ver(void);
>   void spl_enable_cache(void);
> 
