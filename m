Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE61606ACA5
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ncayEaIh;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=f0JNfRpU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B85EC60666;
	Fri, 23 Oct 2026 07:04:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xShzgypAt2PB; Fri, 23 Oct 2026 07:04:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 079466065A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792739070;
	b=JjvIR7/cXr91tazKGiAvC3TTwgvpCF4wUqcFWINvP0Jf2oP2NnLJhksSYNPn+w/P/8CV
	 hi8/Jle/0y3mlAnhz0uvmRSkRZ1Vac7mRQVFj408NslbZP3aR4DqrJY55mhxOxj7siage
	 hZpL3pqKftltfZZp7XS1aiZVxwv/CthmmJPTMolTa3BxHCoLrZfr9eHIq1y+WvhKBqJW9
	 MLkbHCHRbtC7G6cR2X096VAL61DB1XYmW5uqrkVnx662bc2JbmmVmHpBOal0dtlG/RxWk
	 FS0/l7KDXPoW436gIcF/MG0cNhQJB1BsOeoQoRwt3qk1qbSU7ORDlrISbLAu6c9mmEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792739070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nCdY4ecNAhM2CRAdgdyTm7SnJ83dN7aWA+wZ6CcqXlA=;
	b=rdNuIsuXuM00lINnhDb/adYT25bHlCobqnelLR7tDGXFByDHBAPNJB6wdx34Bu3azNVZ
	 +NLoVz5IYzzE0kKNf1MeJ7LTz+um5vRyyEXPQ5cRikHzuQAV4DAZlsjFklQuW0NgH2yZJ
	 lkJ7mvMDwWwZA5rlubjayceWlT1xTMI9qmmqkMbw3137NMMu/5i0dBilZ7AlwYBMyco0s
	 QidGYb7qFkVsJLRrTQStOX+PRCDWNaP4ahgwg1AgtJq6vhtOvSzBkeBaC4ounBZsrw8xj
	 J1JrS6Wb3/e84lNwaBmSJkjOi5eXbS0Vm3CL9igvXeMiMSa6wNErnEFI/aKyXeJbkeA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792739070;
	bh=nCdY4ecNAhM2CRAdgdyTm7SnJ83dN7aWA+wZ6CcqXlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ncayEaIh221xv4XUEVfTU+Fov4msYJC/Q852LKd55a2ILt27rU2U4ofBmVJVXg9Oq
	 exxvcEotn5sVRyQbzIuiHE4+LbZ+UnI7WQkImIjg5AGQs6Obw9Gqa5DkSw337peDCH
	 u44jC5V4bcZ0gJrND+e6hMm82KYPq+6YEzdp06ANkb9/vnj0NYzPHcnt9/IFs+7c5d
	 Si6SOM6/SfEjeB8riqPvjNLodcNtt2cGPSXHOAJU6oYNdIf6Q/X9sePrGXYs+IlAfL
	 3wFvQ7C4KZ6IEHpddvm9WlR1lAfPzno5coWHyY8Tc7AjIOy5buRdaDYKy3hKyhZvOO
	 /t6UEoU2U9mXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 079466065A;
	Fri, 23 Oct 2026 07:04:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55B2549D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47517810E3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yUMPzPK565vu for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 07:04:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF92680DEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792739067;
 b=PjoDTjhHpJlsdPsgsYUArXAxoMeiEAON/SaWm0lRNUv08z+8NIG9Hi1M1Jn5RAMFIDnp
 gmIhNnrS7wphkrMEHlpLsz8jG540yW6Uv0zFhfyE6YPVN0B02yCrj9K8mL7hNMphEeoMQ
 GfQT0YYSfuQTWOmODYGWuxjXx0yODChN7Bmge+5PZLCoz/XT+E0PkLeGCKRme7Vwr7BHf
 LJchMFBHZLharKJnr4R5HaqVRultz9nORHN/Ro1SVxLcO2bOHchAPv57gh+HLamwenF/c
 JTWmbJwX/CiukZVi5/3GfWM8xzbfPX1Vxoh/+R5gaY11y3WUQH+3agQHXY9soiq2vfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792739067;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=nCdY4ecNAhM2CRAdgdyTm7SnJ83dN7aWA+wZ6CcqXlA=;
 b=KglePCfe1c/gd8+UAXfDLCkQzPv0C5TZnVLZWWuMmkWah5DHNt6RKtK0RjxQpiG3qDo0
 +Tjkw/I2LFxj5qq6GyUfR6GbEaEAIDt0UjZ+8j+PVPbBSs98VqsDlcPzv1iLWHGOQhnW2
 ULy5nBezG0sAKW20g2BkdmVK2BiYSCz1ThFww50GVe5rKY8fIY827X9ksm0LM/1Ynf9OZ
 Wt5ujAqG/os4toQ5HA4SAy93tVZ8SwhBpWB+DsT28fmSEap5wom17NdHgPYg+s9cNujUr
 9mAjnQzSNnDiWg+/Jnxt5mT/pX7a1vh3C23Q8aWn52mnFFXD8n/jHjBPekHV1AR8vyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=f0JNfRpU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=f0JNfRpU
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF92680DEE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:04:26 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso265694f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792739064; x=1793343864;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nCdY4ecNAhM2CRAdgdyTm7SnJ83dN7aWA+wZ6CcqXlA=;
 b=f0JNfRpUyLZQz96wnClUFjezA04/EPUyEBdD4+PbrJ9HGJm7TuhsR1vc+o9my3xNXl
 C+4qyZiur35emchN0TEykRxLERvcYoJynWx3S4CIwlfNeYbF6wLkfFwUn5/x23O14xXM
 INneo5cRXMhVO28L5uQc56MiapB9A3UfOdhqroCoxKlxNWsPtRAMmzTiY+Ay96FSTWYD
 vjFY6FPVmb0E2Vs+CXkNW4bQW5BOzNKJ9eE4n9AJAHVWddy86SbHVB9Lg3OaezGKlKtr
 hiyJTIt8xf+bHpz/vvGOEBFM1Z9WS13+bsc3xyEzn14++obsriSRVIeglz5GUZ3erlZr
 WT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792739064; x=1793343864;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nCdY4ecNAhM2CRAdgdyTm7SnJ83dN7aWA+wZ6CcqXlA=;
 b=iS9zpXJSaBc55tj90Y8C9PMLOc3tgc26KMPNojRzucRNZCrg02/SO98KalHJQGD3aD
 qht8UFnAsaTlRpUc3AoYX3a3ltMZeo60pOVGFKPB+kk7FVGFKxFkdFbNE5b8SBWhi62C
 pKbUCdC2RS1oHQN5Nr682+UwOYT9G02+9FrAPqOKTTLoKQZ2bH32t9hKenaVn5iv4WKh
 avvS5fvrvNNQ9t7Gl1yLcrQXTDw9LVVfb6C5wTaDttkQiCWdFZaJ2l7sfu1AlggDPaNP
 EVaz3hXaljRT8efUrFdzEX/nduOsuwa/qVNxKDAZK/4IKj7W3DX5wysstKkQnTrUgTkE
 CxOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHd0oPifMABVrxI9Aqb2bmDbHXj/Z56zAoSFrgZ94RXQhbeGQqLp445ukl8Lv3T6oNqXHtTzs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIWHQTXhcWuG4ZvinFvyPWtZt5zzPZgziUrUP3DNPCcQrCClG35
 Gcop+0Nhg42EbL1ZzU5He5SUcs3WgB/UY+PP73oyuwbHaHY5i7USt3soh3dcnXK8VtMsocDz20C
 or4iW
X-Gm-Gg: AYBFou3Ru93rXQkLdvS8vtV+71/v+Fl6snu+fqAx0drGAJEybsOKWhppMGP+/DFBEAL
 cWyOdgCvKM+S9L/ohHtGwky9P2KGyIPc5YaQ0MKIaL/+qAzPNkmGcGeabCPAl4EBG/4dpgCdJ2c
 b0IjZ7yiVdzsule6ASW8xb3gnrM0JtpCFb6YoiRGHoiFlPWIGYzQksedbrh/vudBGPlnoBNnrQG
 Hy4w/07bEiO0JRvy/4jgzktlecTx9xTMr6BonvbGf0zNOx8w8ceqKzHyE+7zvjePi6HzL+rzLv3
 LdyqJa7f4L9v6nYrOAwLYJmXOWBpr7lT51mfGDeu0nymyt/PtPlvYELMP3dWfB7Pvppiz7ppjtG
 rsRPDpgpOMJ8WOFxPrMOnNz+enU2rS3ciRdMcDwxMgVpey+VjI1xFwflRU7ZnOhDgp1X5fkTUlL
 dEmOiZ2IwLh97pBB4/V5k62bkrmZnCSIpbcb8WnhmV5oVHDHusZ8eR7ixTlZjem9cM6WRHQ6NdP
 7V899wRf6nvHqzj3dTnO0Gdk+3eGmWCNJ0+ImRz22Kk/Cf5MZXobuB7llbPOoaST99wv6FLWczq
 NEtkOwMzW78J+AhLFZvhjF1t0CzGwAc6Qewmoo2jxopDygBG9ijjpdNmfC8Xp7FPnw==
X-Received: by 2002:a05:6000:986:b0:48d:ef7a:e59f with SMTP id
 ffacd0b85a97d-48e3859df5dmr1814679f8f.17.1792739064515; 
 Fri, 23 Oct 2026 00:04:24 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-21-165-229.retail.telecomitalia.it. [79.21.165.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38025d98sm3924146f8f.9.2026.10.23.00.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 00:04:24 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:04:21 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] efi_loader: fix image and load_options leak on FDT load
 failure
Message-ID: <atsGpiTZxKzqohmb@macbook.homenet.telecomitalia.it>
References: <20261022214433.93112-1-oss.patchbox@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022214433.93112-1-oss.patchbox@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 17:44:28 +0100, Yuho Choi wrote:
> When efi_bootmgr_run() attempts to load an FDT specified in the active
> Boot#### option on non-ACPI platforms, load_fdt_from_load_option() may
> fail (e.g. if the file is missing or unreadable).
> 
> In this failure path, efi_bootmgr_run() returns the error code immediately,
> skipping the cleanup code at the end of the function. This leaks the loaded
> image handle, allocated memory pages, loaded image protocol, and the
> malloc'd load_options buffer.
> 
> Fix this by jumping to the cleanup label 'out' so that efi_unload_image()
> and free(load_options) are called before returning.
> 
> Fixes: 39bac24a48b0 ("efi_loader: load device-tree specified in boot option")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

I think this should be 39bac24a48bb. Besides that:

Reviewed-by: Carlo Caione <ccaione@baylibre.com>

> ---
>  lib/efi_loader/efi_bootmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 51ecb6ec1f..934f0c4060 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1323,7 +1323,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>  		if (!fdt) {
>  			ret = load_fdt_from_load_option(&fdt_lo);
>  			if (ret != EFI_SUCCESS)
> -				return ret;
> +				goto out;
>  			if (fdt_lo)
>  				fdt = fdt_lo;
>  		}
> @@ -1339,6 +1339,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>  	 */
>  	ret = efi_install_fdt(fdt);
>  
> +out:
>  	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
>  		free(fdt_lo);
>  		if (fdt_distro)
> -- 
> 2.43.0
> 
