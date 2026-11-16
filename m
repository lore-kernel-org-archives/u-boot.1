Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82112606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pcjFdz8Q;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=j6U0YZBR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56ECF40807;
	Mon, 16 Nov 2026 17:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWS7_prFGqMG; Mon, 16 Nov 2026 17:41:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72ED140853
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850917;
	b=jLiuAyT0GwYK0rkim/+u9YFKCWUbNh2tNvpODOzryvY5bGHlvhrAnYZMt5wJflGOB95f
	 v+E0FPfiPkFhKaMLt9nEFIJa5jy3rxzE8nu+BNwoP98RG2EZ0MslLeTChFG8UttwpUkti
	 +kZgf24n5zyK9m0F62C6dQTWo/Jhu4Xv85d+BLXrXGUdm5SQOL7M0CZnMPjPdTpM/runF
	 krTtJnF2ugAwpUDszSXgRAuPVlTT4sSCx00snYzTBf/urO4yXmGCTrSX2l29Crk1wOeBP
	 SbzPbndiupXQbJn2wAXEOiSLhVtQkD5htXRsiTyNpkXoIhyEnWdgl5orWZmVdtR3bNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850917;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YfNYkpNHOOwaKQpb5u+dCO6LX+KeFgi5r9oOIDgfHJk=;
	b=oVmNlafpbeUjdk6Apig/wxGHTm6U/a+gIAWj/0eKKOfhbSrDz33M+/q8YK3yrlGiSAQA
	 LOFRAMUsu9ABHfKsjBKA8trwEij6Db58hZD5SZI3abfsdId209FIFcpJX3H++dAxVr5lD
	 stJs1Si5gLR328ykWpRC97Pg1Z5KdpphG23lrEUfzQk/GhE02BmjQq8My+ZUw2bk3VX0w
	 lxpCdK9BxbqcnOI57e85ed3Swc/x3HToAKufP6lO8/AG7pB/eiBNXKXi24DTE4GLuH9QT
	 xNWc1DeC/y03OXW/P+SvqF4BenV9TyDq0y4C4Jt4udePfucWX2Z5DWLjOXCOTRi3DMA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850917;
	bh=YfNYkpNHOOwaKQpb5u+dCO6LX+KeFgi5r9oOIDgfHJk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pcjFdz8Qb+sIlWTKmUosscv/eCZkwnIzBgGfWwLxQ5zD3y4qN7H2Cu4zNZmncCkUP
	 Lt+8Do4TNLoBdCsDSW4809rN+ox/C3JErj601s+Dxqr3+lLnLKqU3ZZBDCPQ/34Ifq
	 btdMmNlLa0v3xUn0j5ntbvOpbUMphZ8K82/1Rh3rahOV7PjPX0mQsjZSoX2mI7UwHP
	 lSg6Rh+WPtro/YK/YiMiTdNNwThrKlKa2HWDuQko6qXxRlVWp0bA4Lw8Z0w749/qFX
	 e3Xs+v0oFdbL0PnFyflsQgMlZ0WrK+wDuHqxE2i73Ukj7nruP6Uw30RM3FzNw7JBGR
	 8gqbFSF6Jbwiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72ED140853;
	Mon, 16 Nov 2026 17:41:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F188169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6132F402BB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AL6MRnT8W-1n for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ADB51402B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=j6U0YZBR
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADB51402B5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:41:55 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-8629c7cc36eso1850088a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 09:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794850914; x=1795455714;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YfNYkpNHOOwaKQpb5u+dCO6LX+KeFgi5r9oOIDgfHJk=;
 b=j6U0YZBRu54ssAMY5wNASnrWsbefFVne5SbO9FyUL89yu9lh/i8XPDolD8DjNKcMey
 t7AjZdxioWP4265ttfE5g29lrkEoUfJAHqLY/2TCTVOHkogCcRgvYvJsAamvId867q9J
 E8q28AUZzcdSydKjrhuz4zgSTXf9xcgoCwJL2F/DyGzdYPHEzUNPBux5iO5LSTqE5/I4
 FyJGurJ/msTU6/itG5CD4PxJmHrSSyKghptDdTbEfZwK3HcVl+Ihoe9zZ7jBA7rF6Pox
 vr3mL9z8ULLhAN+Y+t6VNhGkzPDq6ceBrmwq0NC5lS7eQVib3Zozdl3wdt+Qp1DIorIY
 ynRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850914; x=1795455714;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YfNYkpNHOOwaKQpb5u+dCO6LX+KeFgi5r9oOIDgfHJk=;
 b=haTwRgVM4KgfbdpdX5Ceg8ioKVDrFmsOyfEAT7YyE4rbCaSgHl87x4u4tI5LreqyfF
 nDVnR12yfLFy8pC9/tF1zVFMWo3qxAIgE8GH1f+vq/21jChQNAg9AGSt/6TTUwvAs5Ck
 ByuV0ZrRQbHcApPTjIfWvBqoIK3mGAdFhHclMppIKncr7dGT8l217BvoyK/U+156AArq
 JEwE/vqi5yuu81eC5bZ+pNAZyQ96QZX0qW/TJZqsisuy43XTYuEbhBzxpym44ucPTL+7
 7g0EOa6Cn1JXmHtgDCOLB5FpLq/iEGpI3oU2i9gPh/2jmR2vpcF1V6iMJAZ2gX2Q98of
 h4ag==
X-Forwarded-Encrypted: i=1;
 AL+hErE+CNS57jBmZwDviUuJpyIFJRTHJ9Eyfa8qH8sehSihh+3d4dcPYxmP8jYVu/BjLYbxHWpviKA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9RgAUp4xBgiqPQgG5tP7pHLgApMy0/Y9NY4HnFZyRxGsHOo7aB
 VUVCAaj9vlOADV2KwfQd+Xo4Wizc2zNkTw7Sp0Vn/OCRRGnV8IGuikPucmQGXrqpwig=
X-Gm-Gg: AYBFou047v0tCgyLcVd0lVDJtQrBDP0DbZF8kHeUk67SMpN/eWrLOyIvvLp8o9jhr76
 q1B2cvFRG+xRI3ww+GqwFkIACznuEbUoQ+Ab+baE2WT+LBWilhUCHf7K2nejqN8xfWatmD/wfHE
 WCvLh20iJT3apsELDHcrjfsdK9Advip1MvZGJ1fu9sWUt1MVG8hSdgdJWwvJ/MX8/kJ9KhiI1ZD
 b4hG04hGDxSO1SmMyo8eyk8hX1oCkhbG7TvWJOIozE/fsfYv7a2eFqd2E3s7bFZMd7WYgMVai+7
 M/s0yZgqM/ilnKl1eHndv2LI143RkBuA2l/mEDobL9Cv0NFtftOWjPUbnddQaYkS8suDFUsfDfA
 7AaGJn7h9oYxqG2pvq4MWMZwDUOc50nc8GUwPuZ1AfbYK6FEJ4ZurZcBe/IObLnl0eIrTd20ULp
 fWfiBItvnEtXZAQ53M8d85P/58rFDLUWDirHqkgNMZP/sON8c3eD2Xg3uDz+4ipoWF+kjQp/3GI
 eWTmdacqCFcmbovWZWK2CKT2AABN/qT4AvJsoQf3vhrOOLbIOYWk7dreT79joOuLE2WpyC19eIa
 lY5zDsjeKaH8uMophkHmZVhVV4PljhoZE6oZBamTFhHaNsVXysVeoHnPzlX6bOIST6ARfv/xu0p
 skSk=
X-Received: by 2002:a05:6808:13ce:b0:4f5:aa1c:d934 with SMTP id
 5614622812f47-56e64cf7e79mr10168890b6e.38.1794850914114; 
 Mon, 16 Nov 2026 09:41:54 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7056:3b5b:7d85:4921?
 ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e6fc3eaf6sm10463727b6e.5.2026.11.16.09.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 09:41:52 -0800 (PST)
Message-ID: <c421db75-548d-4ca3-a315-009a603409c6@baylibre.com>
Date: Mon, 16 Nov 2026 11:41:50 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arm: dts: mediatek: configure Genio 510 and 700
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
 <Macpaul.Lin@mediatek.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>
References: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
 <20261113-ccaione-upstream-mtk-g700-usb-v3-4-78b554604bbb@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261113-ccaione-upstream-mtk-g700-usb-v3-4-78b554604bbb@baylibre.com>
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

On 11/13/26 9:25 AM, Carlo Caione wrote:
> The Genio 510 and 700 EVKs share the USB1 controller, onboard hub and
> USB-C PD connector wiring. Use that connector as a fixed host in U-Boot
> and select the USB1 DRVVBUS function on GPIO87 to control the external
> VBUS supply through the USB controller.
> 
> Keep the USB0 download connector and the USB2 M.2/header controller
> inactive in this host-only configuration. Their OTG descriptions would
> otherwise also select host mode when USB_MTU3_HOST is enabled.
> Explicitly re-enable USB0 in the download-agent override so both SPL
> and U-Boot proper fastboot remain available.
> 
> Put these choices in the shared U-Boot-specific device tree so both
> boards use the same settings and the OS retains its existing connector
> and role-switch descriptions.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/dts/mt8370-genio-da-u-boot.dtsi     |  1 +
>  arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
> index 249441fdf0e..b57351bf892 100644
> --- a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
> +++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
> @@ -17,6 +17,7 @@
>  #endif
>  
>  &ssusb0 {
> +	status = "okay";
>  	dr_mode = "peripheral";
>  };
>  
> diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> index 6e84dfcc6f5..e1c446d4ee1 100644
> --- a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> +++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> @@ -85,3 +85,23 @@
>  		bootph-pre-ram;
>  	};
>  };
> +
> +/* Only use USB-C PD as a host; leave the other OTG controllers inactive. */

I would be tempted to expand this comment with a REVISIT explaining that it
is just working around lack of proper driver support in U-Boot.

> +&ssusb0 {
> +	status = "disabled";
> +};
> +
> +&ssusb1 {
> +	dr_mode = "host";
> +};
> +
> +&ssusb2 {
> +	status = "disabled";
> +};
> +
> +&usb1_default_pins {

This could use a comment. Are we just setting this to force the VBUS on and
assuming that no driver will change the output state?

> +	pins-vbus {
> +		pinmux = <PINMUX_GPIO87__FUNC_O_USB_DRVVBUS_1P>;
> +		output-high;
> +	};
> +};
> 

