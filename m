Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA9FCD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27AAE84908;
	Wed, 27 May 2026 18:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=forissier.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=forissier.org header.i=@forissier.org header.b="G96NFCrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFED847C4; Wed, 27 May 2026 16:49:16 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8327844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=forissier.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome@forissier.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-452169ae568so7647831f8f.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=forissier.org; s=google; t=1779893353; x=1780498153; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yBFADHeswCx0mDFdCqyX9fQXXJEGBayye5vfRr5/2Rw=;
 b=G96NFCrchzaKuN8ArC3nsXbFudG3MKLLeuYpBC9268NkZToNkE7+6J4z+mkyNij8st
 0/tkJsJsmY1x0a9y5DkLB0VKK97JizCkAkLmFiEIp97Vc1Z0QVj5Nm5DLUM+cXPU8GuB
 jFpkhXtg2CgrApeNQdGa+AOL3Wzr+SvXGK20avr/EzcT1e7VOqAvMtEdTuPDDpp7SWmb
 g18yK9eLBgWKfMCeGRB3a4QdQNrdLMpV1lkke8XxZyDo/OusFrXV1nTe4zMcNrkDtZO2
 ZMRGf+AYN3MU3gEhJWOOplClXQBWIN4mEKKUjzVyhnAwWGX0e9p1wgAo8FMQpGL5Sth9
 jSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779893353; x=1780498153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yBFADHeswCx0mDFdCqyX9fQXXJEGBayye5vfRr5/2Rw=;
 b=cngHH6eFVVXZyXOBGOxIMnTuH42DOA4f/PFGNsvI2OECYoZaWHMD7YSIeC62YzF80Q
 OPr9a+K9r4mKPVnrEnDL7G4cOo6LhTWgzcxTxBAOyt3e3UrqyOaK8uRU9a+T/EHnSQmY
 yMrARQoLSqOX/wjRYVJ37iqwMlZuYexj9TD/Y5j4Ob3oUMMWnzISbHtP4M+nT3VfEqV+
 FIBHuPUv3k6MSuTFOm40zEjljjgXMar6Mkimmqyhv8AgrCtcPi6OsAe44uHlulzlteo9
 i+Jj9RDLQhN4XRFFYneH6gAmHu5cnZKTTd6rdZO4caTXIGlNG70NJK/wrAehSKAjJYCl
 aqmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eaB/FNaRgF+aG2i5xDOGDCctvswspNoUvaGGvhbLWM/7pfZuZ44JXtqySZbOsWeD8WHM4V8k=@lists.denx.de
X-Gm-Message-State: AOJu0Yzd4bHeCy/7B1zKDIb22tVjXA/ysEi/2tCe4rByk2JS4KXfB1Te
 ahBXJKD8/4QAdKou9dyCS0bo+JCNRl/khcjXxE5+upSgfRLi7eZn9qT90gpX6LOQpQU=
X-Gm-Gg: Acq92OEi+A/Rv0Nq/xXZICPpI3qbP38lKQ/jDUtVbn0LVTZTGw8/96Qb1Dc0+MTLGxm
 6vhbZ5rkFuoPiaRgqdJpEae6/oeqkO90+GXfHQ9q2P108Llq2c+jxjknFrXOmQCcArvAZAF+45q
 Iep7xcwbg7UfnhLxcMeyJ+uOwhPwjW/V0LqPGVKp06AwJcUNyT41JlKYuZu6uiaNSlXQHXET/iu
 lT6FLjEX5+l5PhCwCKpVSjuQavLWT68xzkHXOKmvqjxLBS4aghTwFqzqyQZvkS2IQhRgyYJZILX
 VUHMnloqFUWCd2nrbEUdySApUiFNxRitZHzrU0oyiXTG4f9+vYJ2GF5Gwv/oQAL2ejGDGE9sKFD
 DXrnTyurrK1enQY/tTjHA/ah9XJ2+ynXy10uuZU+K6UVp4c2duXyKjDCNUzGKvtieFhwcO7xjF9
 ItRIITR5cSkrewlqeGXrvu3XRSWc/RHLJcAwm7lGzZbTmOli5cfZr0miDH1Yg2RFsVAQkQucF2d
 UEheGDw
X-Received: by 2002:a05:6000:4693:b0:45e:ce49:43d8 with SMTP id
 ffacd0b85a97d-45ece4944a0mr14366459f8f.4.1779893352636; 
 Wed, 27 May 2026 07:49:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:fd9a:5412:ee36:afc0?
 ([2a01:e0a:3cb:7bb0:fd9a:5412:ee36:afc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb558dd0sm6359765f8f.16.2026.05.27.07.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 07:49:11 -0700 (PDT)
Message-ID: <f2070d0e-a4db-477d-94d9-461931669197@forissier.org>
Date: Wed, 27 May 2026 16:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bootp: extend ProxyDHCP support to read bootfile name
To: =?UTF-8?Q?Ryan_Pers=C3=A9e?= <ryan.persee@gmail.com>, u-boot@lists.denx.de
Cc: jerome.forissier@arm.com, trini@konsulko.com, seanedmond@microsoft.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de,
 Max.Merchel@ew.tq-group.com, paul.henrys_ext@softathome.com,
 marek.vasut+renesas@mailbox.org,
 =?UTF-8?Q?Ryan_Pers=C3=A9e?= <98691129+rpersee@users.noreply.github.com>
References: <20260520215944.85060-1-98691129+rpersee@users.noreply.github.com>
Content-Language: en-US
From: Jerome Forissier <jerome@forissier.org>
In-Reply-To: <20260520215944.85060-1-98691129+rpersee@users.noreply.github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 May 2026 18:27:40 +0200
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

Hi Ryan,

[Replying from my personal address because for some reason my email is
rejected by the Arm email servers: "messages to GMX.DE; are blocked by
your organization [...]"]

On 5/20/26 23:59, Ryan Persée wrote:
> When CONFIG_SERVERIP_FROM_PROXYDHCP is enabled, a ProxyDHCP server
> responds with a zero yiaddr and supplies PXE-specific parameters such
> as the TFTP server address. However, the bootfile name was only read
> from the BOOTP legacy 'bp_file' header field. Modern ProxyDHCP servers
> (e.g. dnsmasq, iPXE) advertise the bootfile via DHCP option 67 instead,
> which was previously ignored.
> 
> Furthermore, once the ProxyDHCP bootfile was stored, it could be silently
> overwritten by a subsequent DHCP OFFER or ACK from the main DHCP server
> if that packet also carried a bootfile (via option 67 or bp_file).
> 
> This patch makes three minimal changes within the existing
> CONFIG_SERVERIP_FROM_PROXYDHCP guards:
> 
> 1. Add store_proxydhcp_bootfile(), a targeted helper that walks the DHCP
>    vendor options of a ProxyDHCP response and extracts only option 67.
>    All other options are deliberately ignored so that the ProxyDHCP
>    server cannot alter the client's network configuration (gateway, DNS,
>    etc.), which remains the main DHCP server's responsibility.
>    Option 67 takes precedence over the legacy bp_file header field;
>    bp_file is used as a fallback via the existing store_bootp_params().
> 
> 2. Add a !net_boot_file_name[0] guard in store_bootp_params() and in
>    dhcp_process_options() case 67 so that a bootfile already set by the
>    ProxyDHCP response is not overwritten by the main DHCP exchange.
> 
> 3. Extend the ProxyDHCP wait condition in the SELECTING state to also
>    delay when the bootfile has not yet been received, mirroring the
>    existing delay for the server IP address.
> 
> Signed-off-by: Ryan Persée <98691129+rpersee@users.noreply.github.com>
> ---
>  net/bootp.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bootp.c b/net/bootp.c
> index 8976936b184..a16245cc7e8 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -161,7 +161,11 @@ static void store_bootp_params(struct bootp_hdr *bp)
>  	    !(dhcp_option_overload & OVERLOAD_FILE) &&
>  #endif
>  	    (strlen(bp->bp_file) > 0) &&
> -	    !net_boot_file_name_explicit) {
> +	    !net_boot_file_name_explicit
> +#if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
> +	    && !net_boot_file_name[0]
> +#endif
> +	    ) {
>  		copy_filename(net_boot_file_name, bp->bp_file,
>  			      sizeof(net_boot_file_name));
>  	}
> @@ -935,7 +939,11 @@ static void dhcp_process_options(uchar *popt, uchar *end)
>  		case 66:	/* Ignore TFTP server name */
>  			break;
>  		case 67:	/* Bootfile option */
> -			if (!net_boot_file_name_explicit) {
> +			if (!net_boot_file_name_explicit
> +#if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
> +			    && !net_boot_file_name[0]
> +#endif
> +			    ) {
>  				size = truncate_sz("Bootfile",
>  						   sizeof(net_boot_file_name),
>  						   oplen);
> @@ -1080,6 +1088,43 @@ static void dhcp_send_request_packet(struct bootp_hdr *bp_offer)
>  	net_send_packet(net_tx_packet, pktlen);
>  }
>  
> +#if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
> +/*
> + * Extract bootfile name from DHCP option 67 in a ProxyDHCP response.
> + * Only option 67 is read; all other options are intentionally ignored to
> + * avoid letting the ProxyDHCP server alter the client's network config
> + * (gateway, DNS, etc.) which is the main DHCP server's responsibility.
> + */
> +static void store_proxydhcp_bootfile(struct bootp_hdr *bp)
> +{
> +	uchar *popt = (uchar *)&bp->bp_vend[4];
> +	uchar *end = (uchar *)bp + BOOTP_HDR_SIZE;
> +	int oplen, size;
> +
> +	if (net_read_u32((u32 *)&bp->bp_vend[0]) != htonl(BOOTP_VENDOR_MAGIC))
> +		return;
> +
> +	while (popt < end && *popt != 0xff) {
> +		if (*popt == 0) {
> +			popt++;
> +			continue;
> +		}

I believe you need this to avoid a potential OOB read:

		if (popt + 1 >= end)
			break;

> +		oplen = *(popt + 1);
> +		if (popt + 2 + oplen > end)
> +			break;
> +		if (*popt == 67 && !net_boot_file_name_explicit &&
> +		    !net_boot_file_name[0]) {
> +			size = truncate_sz("Bootfile",
> +					   sizeof(net_boot_file_name), oplen);
> +			memcpy(net_boot_file_name, popt + 2, size);
> +			net_boot_file_name[size] = 0;
> +			break;
> +		}
> +		popt += oplen + 2;
> +	}
> +}
> +#endif
> +
>  /*
>   *	Handle DHCP received packets.
>   */
> @@ -1100,6 +1145,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>  
>  	if (net_read_ip(&bp->bp_yiaddr).s_addr == 0) {
>  #if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
> +		store_proxydhcp_bootfile(bp);
>  		store_bootp_params(bp);
>  #endif
>  		return;
> @@ -1130,7 +1176,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>  				efi_net_set_dhcp_ack(pkt, len);
>  
>  #if defined(CONFIG_SERVERIP_FROM_PROXYDHCP)
> -			if (!net_server_ip.s_addr)
> +			if (!net_server_ip.s_addr || !net_boot_file_name[0])

Shouldn't !net_boot_file_name[0] be (!net_boot_file_name_explicit &&
!net_boot_file_name[0])?

>  				udelay(CONFIG_SERVERIP_FROM_PROXYDHCP_DELAY_MS *
>  					1000);
>  #endif	/* CONFIG_SERVERIP_FROM_PROXYDHCP */

Other than that, LGTM.

Thanks,
-- 
Jerome
