Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4412606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i6YpVhD2;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bia3hq2i
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A96B607C2;
	Mon,  9 Nov 2026 17:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFdeRT00bX1d; Mon,  9 Nov 2026 17:59:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D55F8607D4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794247177;
	b=XGDSxrbYy8QTx5CszoZZvl6nGSLNTd33N2n51ScOGX3SbUYG7y+C/gXmrg7+RKYfzrLW
	 h/Zv0z/27pxxkMfKVMRPC3fooePX45NT9VCPCqgOiNiNc7UnCXgLTlROLfqqZz/+PJVSq
	 EFHeq9g+Yol6EwJme+a5SHexh7BJTj9e08wBf+s2ZUX98u57kBxQGdIs/UwlASrebk1uc
	 ae+R+2jULfhBc1LjFMlVB1dmjmSR6orFY4Hwddhp8pFosePKSdcUFOvbv70XcwSbvHgki
	 buXl/h0sy6QYLFsIBD4YGwqncNEx+FpGnIvkjJAGzactJ/qB/ACulSbABAFKh64NRIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794247177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WcvtrjhxYPJnZTFNqF2MaiFcaTCDT60EspHneXvIoaw=;
	b=ILS1NT2ilI6aPFBpG4ECJIkBCCKqlCtfPDMhEgp4hGAk7j1smShcY/qy6hfEdNYu0KOd
	 a5lOsLnKuxPqNObkewIGIQwUl2C+YrQMh0M28A9u+Yepz98IVHZDY6XbRMWPqpg1at5eA
	 7Q6czCfE5tUrrESdpbXSIV/+m03sVLMoGb1KNjfgNnU/eoDYO6Ux+y6HfWTcGrWXEnu+m
	 moVPAgFechM45IxvJLHMTLnOHuVnpBfXYi91WAvJgd4yzrxXe9HWD5upXaYekyhvp2ymP
	 JNkwebUk4NRbHClWk0+djbzICTMSHXBUG7GPJK8QyySyQrNPovkaPFblW7dBcfRtL6g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794247177;
	bh=WcvtrjhxYPJnZTFNqF2MaiFcaTCDT60EspHneXvIoaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i6YpVhD2m57W2D172cQ9TrBVUnBoDaDozStfKbQy/ogtQs4nWJQV2QV/+aMGGwahN
	 I7ihZ7uCpp3h7mYtFaN3x4NFwEBdDtTZqfZZVaJpsqLUtcTPoeVfXaIN3XNLzknoa3
	 J/c/xY/KTnXd1VFMY7wUteZ7WjW30pX5F09kQlSANJ+o4mqR1+BIBUL9ckbjTvGSd5
	 lQKvX0CAzXW99r2Y40IddqqLBpNOhwhrQp6Mz0natALOtLTlh/Xu7vphRdd7P4LHJj
	 18BkIwizFkGLKdTQyOAu77jCHGZNb52RwBqIZT+HJTfHvUir1JLn5UP0jKciC67JUv
	 0QMC38JQuwLAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D55F8607D4;
	Mon,  9 Nov 2026 17:59:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B9053AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CD214075F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9QDFkclKVxg for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A2ABF4075C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bia3hq2i
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2ABF4075C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:59:34 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4b28d9537bcso796513b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794247173; x=1794851973;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WcvtrjhxYPJnZTFNqF2MaiFcaTCDT60EspHneXvIoaw=;
 b=bia3hq2i+GjkU34/Ih8npQdm4V0Pcykt8MlwbqQqwoeHODJgu1b/sASiKbbN+a7dHg
 rO6HeKApL61fxII3cqo8YA8hd2kbhS1l8KXVk71MfTLxqkb2esYNTgqRho8e6LRZa8nS
 KgZQVboZfA3kA1bi/WPEMXBsK0DgNz/wv+qAioXkGchiDb/jrxgkNF+flCDFd2XJSWjt
 jkRTlO210/pVKTwB31hDUDQr7r56HiO5UlAb10/5GxqZypgWvHeaiXEY1OmFV3krAJXx
 60az4BV1J5tZzivfm1gtQAulVyXCIA9O5m18unLw2d7Itqs6qhtWrwVokYvNFWdFZFl+
 mMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794247173; x=1794851973;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WcvtrjhxYPJnZTFNqF2MaiFcaTCDT60EspHneXvIoaw=;
 b=jEXI//xruRGV4XPSHeIaRCU/2NfIwpPMejWuUjysUbiWhG1MW3TSDhBTl4aRYa399N
 vMZPgnv6Y1wfA+BK2vf9F+4rwlJ/H626QnlP3tHj4vznQbCDqHG3Lev4qK4kkMmYI5yT
 c5v1ImJUymyrXPtp+0drS7kfuddrTdfUM0pGAwrqVdFZHXSpylsHO9n1POX5uCf1KmaL
 5THvXrn9z91Mvjfu4TGZLdz4SsKqAObVu4IyJYPWh9zJjDDvy7k6Xrmo/IPih9IiN8N3
 O44pKZujam3u4FPEnDNJRlMD4OGZUl6U1B5GUmXlO5yG5meFrfTSkBSGjnOINZOETxw8
 CKAQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH5P+1BYT1bdjb2sC1ZoQrqiMPOMlxkNOSTgpPewjQZ2HN+o+Flj8fEMJd+rRmpo2Sr4gzwTRk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/RL2RpSRnVxfJmMHNYNiHnJb+iCH5h46i3G6iMzT2XxBOdkGUK
 TJgkHeeEH3kHrtS7v2mtxwcdGrlS6g0drkB1tt4WPZH+RsMj/XkiuXMxWuU99l15cb8=
X-Gm-Gg: AYBFou27RsZ4NOMyTH2nyc0jibdTzWIkm2J4idIG70dhqIG1kob73Ti+o+m/wn4L5XX
 ILUL2iHs+6qxGXFkpBonVJ8A5ipNk7wNg45XuPdlgYhPMOgcOTGNUHb1Q8P7uEwwCJ9GmKbXtWl
 vPoLyRgfxQ8AJc2S93LQfnolYG3H7taxkqIJarHSGj8/e8vgvkncJySr5LeS/X1QgHpAyvGi9xc
 OSh8lNGwulaGkHqT/lUNJKi0JcJVdhSipE5b1XOmSqZ4DkejwHayEbG2czX1PTiEpwUJYnGT1Rb
 MePkILACZ9jObwZU/kxShPQjY3baFUf3OGf/FuXF4jZqHtlAieiGNtU7za1MS/4rSyJ1aFBSI27
 beG7ALsjvipVKXwgwexS4O6zzXpRtUK84zDu+7PPr/MpqOmt306p4g8H/06s6Wv6uq0bobQka9V
 /9Yq4+/u7nVVuN55D2IpY8WHC7XS4pHLJr5nfBfvQWDzjus8iiBqntepKb6NC2OZtxtP74j+WJY
 /WC6VmKR978mSomVlV8Vc9TiZhDK0qC3rqqcOe15gouEJdJJBWx7YJpCCJQ53zoMNzCKKsCvI3H
 CyXtUAGdjJ/rhFcr06prncEmcJXEUqzplTjdC/hlsxLdg4fw3JCeS8bjzC15TX0QU1wqtmPFLMQ
 91Q==
X-Received: by 2002:a05:6808:10cc:b0:55b:fc1e:bcdd with SMTP id
 5614622812f47-568728c63f4mr86937b6e.14.1794247173067; 
 Mon, 09 Nov 2026 09:59:33 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56813e54ff0sm5052629b6e.16.2026.11.09.09.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:59:32 -0800 (PST)
Message-ID: <accb8d40-6c20-4974-a759-5d363d40d370@baylibre.com>
Date: Mon, 9 Nov 2026 11:59:31 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] usb: onboard-hub: add TI TUSB8020B power and reset
 support
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
 <20261104-ccaione-upstream-mtk-g700-usb-v2-2-b8dc65b47373@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-mtk-g700-usb-v2-2-b8dc65b47373@baylibre.com>
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

On 11/4/26 2:50 AM, Carlo Caione wrote:
> The Genio 510 and 700 EVKs describe the USB 2 and USB 3 sides of their
> onboard TUSB8020B hub with usb451,8025 and usb451,8027. Neither ID
> currently matches the onboard-hub driver, leaving its power and reset
> controls uninitialized before USB enumeration.
> 
> Add both IDs with the 3 ms reset pulse and single vdd supply used by
> Linux's onboard USB device driver. The existing peer-hub handling keeps
> the shared power and reset resources under one instance's control.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  common/usb_onboard_hub.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 0684f7bfd47..ead8bf44cd5 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -289,6 +289,12 @@ static const struct onboard_hub_data usbhx3_data = {
>  	.supply_names = { "vdd-supply", "vdd2-supply" },
>  };
>  
> +static const struct onboard_hub_data tusb8020b_data = {
> +	.reset_us = 3000,
> +	.num_supplies = 1,
> +	.supply_names = { "vdd-supply" },
> +};
> +
>  static const struct udevice_id usb_onboard_hub_ids[] = {
>  	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>  	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
> @@ -305,6 +311,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>  	}, {
>  		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
>  		.data = (ulong)&usb5744_data,
> +	}, {
> +		.compatible = "usb451,8025",	/* TUSB8020B USB 2.0 */
> +		.data = (ulong)&tusb8020b_data,
> +	}, {
> +		.compatible = "usb451,8027",	/* TUSB8020B USB 3.0 */
> +		.data = (ulong)&tusb8020b_data,

Do we have these backwards somewhere? ti,usb8020.yaml says usb451,8025 is
USB 3 and usb451,8027 is USB 2.

>  	}, {
>  		.compatible = "usb4b4,6504",	/* Cypress HX3 USB 3.0 */
>  		.data = (ulong)&usbhx3_data,
> 

