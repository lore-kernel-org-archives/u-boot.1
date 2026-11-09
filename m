Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D08606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kp0rHg+w;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=m9gA60/8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B116B80FF2;
	Mon,  9 Nov 2026 17:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PW0WoygR_cUj; Mon,  9 Nov 2026 17:27:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A32ED80F76
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245272;
	b=Tvrqo2xI/kPHsC6OfRcj3bNIfHW1QG/IeeJtGethYIuuFuYht/iDXuR1lsUveJOJRUI4
	 eQeLxZGwFsUMSgBbi6654HGe8MB6Psy3rdrPtnmXosqCenqAB2+zqAKGHUx+Ri2uGlFUH
	 1Ld0j4lLX6ClDMjYitxUqD2PN+nezZq7s8U17/p4z73QOAu0q3bCuI9TkqinXlNd+v6Ui
	 By3+95Jm8Ut2J0iNPs4/bM/ZztxbTUXoCoUHn70nZoSpcFsS5G8v6ugjs/SppWeriQ3to
	 BUPgyGuCTsEG/+Zh6jaug8a/pqT944DUrtvfDX6pWB2uN4zXTwtGZUB+bqaDIUMUliw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245272;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yMK11XhpeRaADnzdG3y1sSRpIM52O7kaHdTqdrnTrxA=;
	b=oPXvT2MJPk0Usdc53ithVhy+44kMEVOloZKlg4vppsxy9hSOxuG6PNO+CIhoFpuBPQ6D
	 /1BIJscpHK1q/v3gGDnGvCkP8UfYpXf2RC7n1EgVs1PPzQZCxlSdAxCzsj55S0F4NW1Vb
	 AGrjeIGcCd9V64AzhItdk7OqztCFMsnsWmi/eRR8YE7w3ZTEkEaNqhgIqRfyrgS/gJPK2
	 eYPPo+bpOfrsaQsIafDWGNmfD2+Fxi/XUeYnaVgaeOG86RyTUuUZWrU60UH0eOSXZzJco
	 5ns+5Rz5imKeZuzl+yYdghS8AuuPDSgZefYHlS33kk+yCreOZwBykre/O0avmc2jJrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="m9gA60/8";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245272;
	bh=yMK11XhpeRaADnzdG3y1sSRpIM52O7kaHdTqdrnTrxA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kp0rHg+wAmXUSbu/sU3zk+w0Ak61Jb4ZdBBZIt70Hxi8BEnNZ33VN6t/WgeO3Ibw2
	 HcgU7uG+ohqEC8iZnqTxBAfrrrySlbH6EPGi8HzxeNzOA4W2A4s708MV9ZFEGcTGNY
	 09V2ZiIzfl37d321Vb54b7peuLwFbvmpJ9bm43n3B/qze3R3aGtkyLYKYSGKaYF92c
	 HO/9RtBCGrXgUdGdSkLn8HLOJvXln77zO8pmHsbkieqbFfQye0ixANlDfat6hPzKWc
	 MOSJcmyY5CC9zyX89j/ueLwNJ9yAV+sLYNiUmO/Z8/lYz5OINiMMHDblQJ+7h95FiB
	 IOUX1wB1Khzaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A32ED80F76;
	Mon,  9 Nov 2026 17:27:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89FDB28C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B07580F76
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:27:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dOybKsLWhItC for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:27:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 78A0A80F48
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=m9gA60/8
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78A0A80F48
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:27:49 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6de1fd5f572so400607eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794245268; x=1794850068;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yMK11XhpeRaADnzdG3y1sSRpIM52O7kaHdTqdrnTrxA=;
 b=m9gA60/8kyJVRttADKJZ8Tx6XkaX5f1j7V10YTcHKg2Mux4Qdfcn9Tkm0e01+kfGxa
 IUADj5ubjzGU+FQV/Ae1E4mkl2d4T1HvEss7/zMh4W+hkm/9Zj1ZPnjxjNWm+TtMm6dL
 fzIOa9HO81L42Lop9qB+Fb32gg5m9IrJTl/eHPd9/jQnbX4ZCBERFDH+OqoY9p5xfd1V
 ubftV1IQffXGe5eUI5DYuIi8marxHaKc6ETbU8adm7DF5gXqQU3+2dpZNTPuRncHprCN
 TP5gU9FXg8LlavtrgqXGtVJV22rUvuI8i2PGtC94dzBYqNTqRp9ZSGia02l8eDJainq5
 /yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245268; x=1794850068;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yMK11XhpeRaADnzdG3y1sSRpIM52O7kaHdTqdrnTrxA=;
 b=RS0QOUNT/ZbHUzDeF4sIdC4BYj04eMN9SXQbj5yA4Kd2GFNl3K4bXC/Adfc/VfvqKN
 DazTrO9Nqq6hFupZfSNr1vZUTMz0Rm1e7vn4Kssxz1ngw0TRyV+p6h3H+11eiAajpRzu
 vEZuvzS8wk/hu55bjeJgj0hKPVoilSoDeWsgTGbM0X98N8sujjcSwoGERScOeLGoU58S
 cOCSRBt+Gvi0kpzpVWVYMYyKHbKb6CvfgsnfOVz0xACd9M5nbdI4iPto69+TdYncADiW
 nHAalYDAOEsH1R2g0LFPhV3+njeVQE6fAkxQHKaISzka7hHFgfdCXZ5UgwK4CjA6PfWS
 h5pA==
X-Forwarded-Encrypted: i=1;
 AL+hErFTvoAXBmHW+LoQ1rA05yjI8k9JFl4FHNIsxDnhIpvQEyivXO4Av0+Gbfc0HufUeWNGlAHOMxw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Gg79FF31Gkp5nolGsKdX3on6YV+CEZjDlUEYsWLfDL4VoGjbc
 MlSTz+evLgezrmCSWTaW2/t+AutF1/fRNZdOS5+w4o4W3RZSSCZhh8XXR4XtauibgXA=
X-Gm-Gg: AYBFou0Z6BuxKU2jRlBX9CCGiM08Nvr7Fww2XM3PL77sWqmnucsgzepFLR2VTrOEVAV
 QX/E3WneU8WjZarg8oB1CAH/YkISXTl/jtqxHN/qyCfki+bkejSRAyecEr2EOYbtMxk7/FZXn6V
 nCDg/lVX1+scbh6gmxTfN9dhLjWYFjoSNGKYeFb5gdUzv1mtqpZIrdiY5GTl22+BWz3t6y7mvFe
 lA0wl+rdLl31MTKGBS0MnAm9nDCyctqNW9S4U5SMehFW+EIxvQkRxNpqVxlGSCxnoZ254TkdlF4
 zXUSLF8FTMKW1B8iRTN3I3Mn/pl8CcH39M2zaABlg4A9SQDQCqqYFSh8bLzxmwlSOBlNgUfzP69
 az2jpBGSUT9TAa7Kzx7V0Gxvl90cKoO8ufjCteVx/qwBBkGEsq1uojZAg+1VMYNIX/ov6MI5vVd
 8sjTHLvN0j93ApfD3pyuuwXQECTDxJeXPstBw1MBdIh+plI6DPWTz8q8R3llsHzdX1ywAXVPYhy
 m6y27ttG8t091mDKH9VZO1wWNQEa2e/y4p7R+BKO14NYdp/e2Zq/Jc3RBSJmG5THiq0wSWAvOxy
 2QyIqDuyZNzr03eqE5VyDSaEkYQ/B99TiLELDScu8/YCgP3XzEdMEsNV0J+tkrPh0dij6Qw3lQl
 SCQ==
X-Received: by 2002:a05:6820:821:b0:6f9:59ee:cf9a with SMTP id
 006d021491bc7-7170f1bd3bcmr2275937eaf.7.1794245268431; 
 Mon, 09 Nov 2026 09:27:48 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7170f8b5a15sm3570515eaf.4.2026.11.09.09.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:27:47 -0800 (PST)
Message-ID: <3b94de19-6589-4838-b005-633783846f8f@baylibre.com>
Date: Mon, 9 Nov 2026 11:27:46 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] boot: fit: tell callers when a devicetree buffer
 must be freed
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Ahmad Fatoum <a.fatoum@barebox.org>,
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>,
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker
 <jbx6244@gmail.com>, James Hilliard <james.hilliard1@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com>
 <20261026-ccaione-upstream-fdt-fit-v3-1-6c5d86c3007f@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261026-ccaione-upstream-fdt-fit-v3-1-6c5d86c3007f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/26/26 7:18 AM, Carlo Caione wrote:
> The FIT devicetree loader can return either data inside the FIT or a
> newly allocated buffer. Callers which only need a temporary result
> cannot tell whether it is safe to free.
> 
> Report when the returned buffer must be freed. This lets the new
> fdt fit command copy the result to its chosen address without leaking
> memory or freeing part of the original FIT. Also release temporary
> allocations when they are no longer needed, including on error.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  boot/image-fdt.c |  3 ++-
>  boot/image-fit.c | 68 +++++++++++++++++++++++++++++++++++++++++++++-----------
>  include/image.h  |  5 ++++-
>  3 files changed, 61 insertions(+), 15 deletions(-)
> 
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 956a3d97c42..e65114ff835 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -468,7 +468,8 @@ static int select_fdt(struct bootm_headers *images, const char *select, u8 arch,
>  				fdt_noffset = boot_get_fdt_fit(images, fdt_addr,
>  							       &fit_uname_fdt,
>  							       &fit_uname_config,
> -							       arch, &load, &len);
> +							       arch, &load, &len,
> +							       NULL);
>  
>  				if (fdt_noffset < 0)
>  					return -ENOENT;
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 60e47db5fb0..4f4e7b4e06a 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2242,10 +2242,13 @@ static inline int fit_image_load_storage(struct bootm_headers *images,
>  }
>  #endif
>  
> -int fit_image_load(struct bootm_headers *images, ulong addr,
> -		   const char **fit_unamep, const char **fit_uname_configp,
> -		   int arch, int ph_type, int bootstage_id,
> -		   enum fit_load_op load_op, ulong *datap, ulong *lenp)
> +/* Track load-time copies without changing the public fit_image_load() API. */
> +static int fit_image_load_alloc(struct bootm_headers *images, ulong addr,
> +				const char **fit_unamep,
> +				const char **fit_uname_configp,
> +				int arch, int ph_type, int bootstage_id,
> +				enum fit_load_op load_op, ulong *datap,
> +				ulong *lenp, bool *ownedp)
>  {
>  	int image_type = image_ph_type(ph_type);
>  	int cfg_noffset, noffset;
> @@ -2255,6 +2258,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>  	const void *fit;
>  	void *buf;
>  	void *loadbuf;
> +	bool load_owned = false;
>  	size_t size;
>  	int type_ok, os_ok;
>  	ulong load, load_end, data, len;
> @@ -2262,6 +2266,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>  	const char *prop_name;
>  	int ret;
>  
> +	if (ownedp)
> +		*ownedp = false;
>  	fit = map_sysmem(addr, 0);
>  	fit_uname = fit_unamep ? *fit_unamep : NULL;
>  	fit_uname_config = fit_uname_configp ? *fit_uname_configp : NULL;
> @@ -2487,6 +2493,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>  		log_debug("decompressing image\n");
>  		if (load == data) {
>  			loadbuf = aligned_alloc(8, max_decomp_len);
> +			if (!loadbuf)
> +				return -ENOMEM;

Checking for failed allocation seems like separate change that should get
it's own patch.

and Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")


> +			load_owned = true;

I would rename this to loadbuf_owned since it is the loadbuf pointer that
is being freed later.

>  			load = map_to_sysmem(loadbuf);
>  		} else {
>  			loadbuf = map_sysmem(load, max_decomp_len);
> @@ -2494,13 +2503,17 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>  		if (image_decomp(comp, load, data, image_type,
>  				loadbuf, buf, len, max_decomp_len, &load_end)) {
>  			printf("Error decompressing %s\n", prop_name);
> -
> +			if (load_owned)
> +				free(loadbuf);

Freeing on error also technically fixes a leak in the existing code, so
could be considered for a separate patch as well.

>  			return -ENOEXEC;
>  		}
>  		len = load_end - load;
>  	} else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
>  		   (load & 7)) {
>  		loadbuf = aligned_alloc(8, len);
> +		if (!loadbuf)
> +			return -ENOMEM;
> +		load_owned = true;
>  		load = map_to_sysmem(loadbuf);
>  		memcpy(loadbuf, buf, len);
>  	} else if (load != data) {
> @@ -2517,6 +2530,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>  	if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
>  	    fdt_check_header(loadbuf)) {
>  		puts("Subimage data is not a FDT\n");
> +		if (load_owned)
> +			free(loadbuf);
>  		return -ENOEXEC;
>  	}
>  
> @@ -2526,6 +2541,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>  
>  	*datap = load;
>  	*lenp = len;
> +	if (ownedp)
> +		*ownedp = load_owned;
>  	if (fit_unamep)
>  		*fit_unamep = (char *)fit_uname;
>  	if (fit_uname_configp)
> @@ -2535,6 +2552,16 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>  	return noffset;
>  }
>  
> +int fit_image_load(struct bootm_headers *images, ulong addr,
> +		   const char **fit_unamep, const char **fit_uname_configp,
> +		   int arch, int ph_type, int bootstage_id,
> +		   enum fit_load_op load_op, ulong *datap, ulong *lenp)
> +{
> +	return fit_image_load_alloc(images, addr, fit_unamep, fit_uname_configp,
> +				    arch, ph_type, bootstage_id, load_op, datap,
> +				    lenp, NULL);
> +}
> +
>  int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
>  		       ulong *setup_start, ulong *setup_len)
>  {
> @@ -2631,7 +2658,7 @@ out:
>  
>  int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>  		     const char **fit_unamep, const char **fit_uname_configp,
> -		     int arch, ulong *datap, ulong *lenp)
> +		     int arch, ulong *datap, ulong *lenp, bool *ownedp)
>  {
>  	int fdt_noffset, cfg_noffset, count;
>  	const void *fit;
> @@ -2639,7 +2666,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>  	const char *fit_uname_config = NULL;
>  	char *fit_uname_config_copy = NULL;
>  	char *next_config = NULL;
> -	ulong load, len;
> +	ulong load = 0, len = 0;
> +	bool load_owned = false;
>  #ifdef CONFIG_OF_LIBFDT_OVERLAY
>  	ulong ovload, ovlen, ovcopylen, need;
>  	const char *uconfig;
> @@ -2651,6 +2679,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>  #endif
>  
>  	fit_uname = fit_unamep ? *fit_unamep : NULL;
> +	if (ownedp)
> +		*ownedp = false;
>  
>  	if (fit_uname_configp && *fit_uname_configp) {
>  		fit_uname_config_copy = strdup(*fit_uname_configp);
> @@ -2664,11 +2694,11 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>  			fit_uname_config = fit_uname_config_copy;
>  	}
>  
> -	fdt_noffset = fit_image_load(images,
> -		addr, &fit_uname, &fit_uname_config,
> -		arch, IH_TYPE_FLATDT,
> -		BOOTSTAGE_ID_FIT_FDT_START,
> -		FIT_LOAD_OPTIONAL, &load, &len);
> +	fdt_noffset = fit_image_load_alloc(images, addr, &fit_uname,
> +					   &fit_uname_config, arch, IH_TYPE_FLATDT,
> +					   BOOTSTAGE_ID_FIT_FDT_START,
> +					   FIT_LOAD_OPTIONAL, &load, &len,
> +					   &load_owned);
>  
>  	if (fdt_noffset < 0)
>  		goto out;
> @@ -2699,6 +2729,10 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>  	err = boot_get_fdt_fit_into_buffer(map_sysmem(load, len), len,
>  					   CONFIG_SYS_FDT_PAD, 0, &base_buf,
>  					   &base_buf_size);
> +	if (load_owned) {
> +		free(map_sysmem(load, len));
> +		load_owned = false;
> +	}
>  	if (err < 0) {
>  		if (err != -ENOMEM)
>  			printf("Required FDT copy for applying DTOs failed: %s\n",
> @@ -2809,9 +2843,17 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>  
>  out:
>  #ifdef CONFIG_OF_LIBFDT_OVERLAY
> -	if (fdt_noffset >= 0 && base_buf)
> +	if (fdt_noffset >= 0 && base_buf) {
>  		load = map_to_sysmem(base_buf);
> +		load_owned = true;
> +	}
>  #endif
> +	if (fdt_noffset < 0 && load_owned) {
> +		free(map_sysmem(load, len));
> +		load_owned = false;
> +	}
> +	if (ownedp)
> +		*ownedp = load_owned;
>  	if (datap)
>  		*datap = load;
>  	if (lenp)
> diff --git a/include/image.h b/include/image.h
> index d991b4c2bc3..4ef5344c718 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -721,12 +721,15 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
>   * @param arch		Expected architecture (IH_ARCH_...)
>   * @param datap		Returns address of loaded image
>   * @param lenp		Returns length of loaded image
> + * @param ownedp	Returns true if the loaded image is separately allocated
> + *			and must be freed by the caller; may be NULL if the caller
> + *			does not need this information

It's a bit long, but caller_must_free_datap would be a more clear name.

Also, if I understand correctly, caller would need to call:

	free(map_sysmem(load, len))

Which isn't obvious at all, so should be documented.

>   *
>   * Return: node offset of base image, or -ve error code on error
>   */
>  int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>  		     const char **fit_unamep, const char **fit_uname_configp,
> -		     int arch, ulong *datap, ulong *lenp);
> +		     int arch, ulong *datap, ulong *lenp, bool *ownedp);
>  
>  /**
>   * fit_image_load() - load an image from a FIT
> 

