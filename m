Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F9606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uJUqV+S4;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fQY/Vl5P
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 201CE8108F;
	Mon,  9 Nov 2026 18:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QcdZXAG3Lu73; Mon,  9 Nov 2026 18:00:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C0B58103B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794247208;
	b=pDw8Le+rMra2nWevNWjeBtWRjuh3gL1kfdbAQkGzK4W8W23YbwC2s6uQLyrBpP+870/h
	 DNuUaxG2vFBWymh4AXVg81yVzwKL98ofIVfqAkYIgfpLrClYylvbV/DWrRrq3y6YQb1Q1
	 pNEeeIUES5jz+O5O4mMLsGCKXzELQzfjHEjVa+UFkbY1U92QZmRtpT/F/xHZcwqdeyO4/
	 6eNviD0pDw6SpxLHzDGO+kd0cAR4ZPnnrcAZA5Sa0qz8eNcTRFriaQCOTmZP/V5aCY70j
	 BkAEWmCsAtq4T3mb33ozD/yh2ieiB/U9RAZDhMNslfRUCwGY9C2O+PGbvC01yM/djiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794247208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xC954Pu4FlJ+tCuGMFT0+vP+MDZvMDz+HKq/v/smks0=;
	b=gO2j1IYdy+l70AzDiN/Lz0W5vMLEneKPZd/Q1hJPowy5b1LNaGZS59sMGnIL1hWoPkBW
	 a2ECqVu6jfTjX5CL40ttU++b0DgGCZioqCulwyQPoKAlja7/r+/keiYrq5sSgFeXlPC+w
	 GaOs3JvCEEkTETNJMiWH2FubzPrwl/YiACBWBRy5JLgXXFp2TUaVrJ91yGjLYnMGQYM0/
	 bQ0kExSXVcah1oofxdAYi0qJE/Iu5yTu8hSl/lEMk5q5oxjMSR4ztwEu+5Uz/nTYfwHES
	 EDzmqIlfwX7CFuxbKswqqkKn2+OAwZllGNchn0zoeyNuQemYlw9vCpbN3reoeuNS5YQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="fQY/Vl5P";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794247208;
	bh=xC954Pu4FlJ+tCuGMFT0+vP+MDZvMDz+HKq/v/smks0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uJUqV+S4DGPZXrB3c8Fuq75qQLm9AmrDDjluZMr8PTOlOXLZsldyhjBmgOn1URv/l
	 Dmpw6pJ/4Ao0/Tpa5JR3qEJR3IPAjHhsHsEyncioaC+nEc5ZcIosRurFj73Q7yIPIk
	 LFymOuELNmp4I0SRaQk5wTrb5bTIpoRiMJ+KBHgMrkOA5xYDGX9B6FXuOhYb0rz6UJ
	 4jFafqElmj92P93nO+tJxQjNC2wUKzrlZt5OrUeEtPScjlCsm5VVuvKKPy5I+YSfcZ
	 6l9MImt4GlsuVBRRQtQeQsqs0iynr7TzKxPZNNddjcRkw3czEstyxQqhFSz7YGD5MT
	 ndgzxHjx0k62g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C0B58103B;
	Mon,  9 Nov 2026 18:00:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DC6D971
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 035AA8103B
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:00:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rAvotsndNH3s for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 18:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4263881024
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fQY/Vl5P
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4263881024
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:00:06 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-475920b9ca2so343359fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794247205; x=1794852005;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xC954Pu4FlJ+tCuGMFT0+vP+MDZvMDz+HKq/v/smks0=;
 b=fQY/Vl5PX/vCSelNdpbKpLaLxGsKdQWu6otZTGLZwfXKd+PzN1EGkECgXlpF1UEawJ
 cFHRDgixxPoE2pFQJ7A60jRCESWEL9QSuYivf7exkAjIfHcgSlI0O8uLpC2Xc1L0Xtxt
 77/VvhrA5z7eOrPkWDif/KFtjVikX8Gl6nxUqqhuAcnTXPnud7+zt4DIUPx7xpRzQc2g
 MmL9hQ+0Ph2Yj3k6H4Kp+u2RoxGx8ypmUcL0G/REiRCQEWBzERr1Q1SKioDlPU2TFLVy
 W3CzDrEpGoJJoTArA1tlxMljSB++M7lFJZTDSHIxYsfu2nLXsIR3md11Y/9wY/9RudtG
 VYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794247205; x=1794852005;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xC954Pu4FlJ+tCuGMFT0+vP+MDZvMDz+HKq/v/smks0=;
 b=2rw/VuSUNGTf8GcDvBRBkT7aDYnXmUEFJGw4cyZQ4H+GaG3LS3Lzeis64IZJOjmLzF
 LThpE+rctVuLyXeHQhwTHs1uedOSn2Uw490I0ARLS3Sgu2GHTksVg1WR+0YqSw/p7Od6
 b4N8TCW95AgsGx9F0fwyzP9LM60htbzhwwyHrOduCNeYrZIRJLKEoFSu+WJqHZy7Rbaf
 VL/fd/rUYEIMERYxAujNuA/faL1jr88Gy+AmF3b8dkOT/271SHAxGZDpjadgUZXMpqhD
 spm3UGweQq9ngVVPUo9NtUc9v11em7nYpXqfR5V7qORObsgQMFGnsQ3HUicLvZICVzu8
 HkFw==
X-Forwarded-Encrypted: i=1;
 AL+hErFA+BMtV+ypVjJnetF9CEPQ6Q2eaBNlRBzdt+EpLV8fgKCGocv7rvpvF9XLLMl4ck0gMMMqWXs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8CFloVRsVynha8byzOwAcfUHvoSgMwQ7eZhAnQCdbOOfP4yeKM
 l8QvmoVpJ8I//e5gYM42ZVqnis26m28kZZSXfdKLnHLC0/C9IDG5y5CV+nuETGDRoZA=
X-Gm-Gg: AYBFou2fjGK7/EtgOhnXo5Gu4Kr+KXdGiruJ4/J/uZrBjMBmwE3zlnzldnMgMVvrbO8
 iqM1AhDMhZXYWxQxDCX9hQEGHSipmDRFQk/rtgaUAtex5k1edoL18vFzvuWUT1dDkG4v2yxEGUW
 Y0zwOIEnGYE+k/J1GcTHJWORpiSvfAAxhp/4/eaT6GvahSIdss8ifp+YUKj4XMi3Dq71BniBGj/
 fvOlKF1WLsz7YsVjBa+k+VoWM6BHe4YAoYwqQnkQaZVW7yEVKAN8mqjJ1eq8viEkU67+zZX5mdN
 W39OW7FeJS7yzlYqfqByevgYAmTIrOJdE1in8VeBjuwTHmfJE5QDWVFGf02zKxnTjiiLneTj8vD
 c6/lDIsl+j6v1IR87xRZhU3K/MGdzApwB6c9JOdm4AeUan2mDJU7OJ530ysQ1PIWdFsn0Cmd6oe
 0vNBFVCTvYiy7eCqEytk76Ybuzk8auz9OCKm616AX/Z07TKSdT6tm78DDwQAvmgCWECFB++dH4u
 z0lyl/W0Ud+uTcIRg4bHNPGpnMd4ak3xoR7wTWRE+I7prbHIv5cHzHew119214cOd/HaDWExhVx
 ksBaNka3nR38MOXxt1VZ0NBN4T7F9VKAHr+jQSDXnwG9QkpaCIJM+EFEqk+2fMVY4ahCoE4SsIX
 jOg==
X-Received: by 2002:a05:6870:b14b:b0:491:993d:d9b0 with SMTP id
 586e51a60fabf-4adebfea1f9mr2599877fac.13.1794247205045; 
 Mon, 09 Nov 2026 10:00:05 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ade6a326fdsm5970345fac.17.2026.11.09.10.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 10:00:04 -0800 (PST)
Message-ID: <a15624ce-599f-4fc3-93d2-9e084a5179ea@baylibre.com>
Date: Mon, 9 Nov 2026 12:00:03 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm: dts: mediatek: configure Genio 510 and 700
 USB-C hosts
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Alexey Charkov <alchark@flipper.net>, Macpaul Lin
 <Macpaul.Lin@mediatek.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
 <20261104-ccaione-upstream-mtk-g700-usb-v2-3-b8dc65b47373@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261104-ccaione-upstream-mtk-g700-usb-v2-3-b8dc65b47373@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 2:50 AM, Carlo Caione wrote:
> The Genio 510 and 700 EVKs share the USB1 controller, onboard hub and
> USB-C PD connector wiring. Use that connector as a fixed host in U-Boot
> and connect the xHCI controller to the GPIO-controlled VBUS regulator.
> The shared device tree assigns this regulator to the Type-C controller,
> whereas the U-Boot host path needs to enable it directly.
> 
> Keep the USB0 download connector and the USB2 M.2/header controller
> inactive in this host-only configuration. Their OTG descriptions would
> otherwise also select host mode when USB_MTU3_HOST is enabled.
> 
> Put these choices in the shared U-Boot-specific device tree so both
> boards use the same settings and the OS retains its existing connector
> and role-switch descriptions.

I dream of some day when we could actually use upstream devicetree unmodified
for U-Boot ...

I suspect that would take some major work though to get to that point.

> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> index 6e84dfcc6f5..1aad2514b8c 100644
> --- a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> +++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> @@ -85,3 +85,20 @@
>  		bootph-pre-ram;
>  	};
>  };
> +
> +/* Only use USB-C PD as a host; leave the other OTG controllers inactive. */
> +&ssusb0 {
> +	status = "disabled";
> +};

Is this going to break download agent due to #include ordering?

> +
> +&ssusb1 {
> +	dr_mode = "host";
> +};
> +
> +&ssusb2 {
> +	status = "disabled";
> +};
> +
> +&xhci1 {
> +	vbus-supply = <&usb_p1_vbus>;

Are we sure this is safe? What if someone connects a charger or another host
to this port while U-Boot runs?

> +};
> 

