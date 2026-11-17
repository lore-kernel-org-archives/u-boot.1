Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DCD606A32C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d90d09nj;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZY8Yyg7L
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E5A881166;
	Tue, 17 Nov 2026 14:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-L7dqFo_MSa; Tue, 17 Nov 2026 14:36:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 67BFB81160
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794926172;
	b=BDJRdhc0n8gj+uEluluGHX+5Znirx6MJxUi59ijwSGcIFFMfxzLA9OwjbMl8N74POWQ6
	 kY8yaEQOWUZC0FJPfPfUGmpeEsSBRSMuIMqNnNbhj58LBk7jwI/PE80naB8FHkjI01ar/
	 unyBILI1JcwSgG9/TEoPinrXUFvG1wAySk7Bt23oVouZubl1kA8dOf+lYFjFXenkOhS00
	 uIjEvuef3MdUv6iy5dommwf9Sw+cBx1UVcI1BQIO+Q+QQ2c7diuHAHZunPnDqFCgAszff
	 jtecMPkcwrnSoElrGW3bcPlI4gJ/hVqoHVmMLolG5x9cAC7nGMZV/j6PHK6np42urHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794926172;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C+qoU0BWfVzZvg3JcPXGBBCjwaLAtnEytm4JD2EU0pk=;
	b=QZE0QaJcKBobCQek3f1B9je+MhWoPT6hOyU8P56fDP/t9Gko1wugjo0DhoE3mn0+hA04
	 NbVzkYND4oS0DmFPy46ydqEnsunEHVQDoNxMvHUjPlE3R4ud1FaDx0DSIMvHT0wyMt7jX
	 s5nn/CIW6UXOeqpvsCGpNB5PcqnIoUyueZ/WNqbcFDz2KLc19nARTQOtufZ3cwUtArYpk
	 d5jbNs/eWKFOjE9ZOMX5nt1dID+6K7+rXfK8YqAss5bPvqoxc0gpbBks5EMpRXkhhPu3s
	 3ITO8UqkM+ExJ9DLIyvQmKqmbbpGcQyAxsDLFR1UyuIMpLlIuelHvt8jmOgYIY9NNOA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZY8Yyg7L;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794926172;
	bh=C+qoU0BWfVzZvg3JcPXGBBCjwaLAtnEytm4JD2EU0pk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d90d09njWlQCj+0q/5PPKJg51hg0o0ZPWSEUrJhS2U+PSTPKV85m6NeMU5sRkcrKJ
	 IvQG4cC0z9depLspkFBZIAGGSyUA71pQKEcun8gRHrW2MKm/FQOMARNGcVJZNKBCKh
	 tN1NVeQoOlW+Nt/pu2FUj9IjcQ/TOaiA/pQP2TTM+JEAAY+RKaNMhKhWv5+mbAMQc0
	 vVbMZGN9d5m6uccn0Bit+aOONnLKjwXTR3mgKqhESDZRAxKgpH/XKMapx0C+jxiPgH
	 YEIHfltUiv49lxghnCNS+kNb54l593kMhi6EE8RErQeDighRRs8pNSEKGkUet0JmZ+
	 gWe/zf9Og2Itg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67BFB81160;
	Tue, 17 Nov 2026 14:36:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D44670B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3ECB481160
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:36:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TM7BbGa3B1Nb for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 14:36:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D4DA80C81
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZY8Yyg7L
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D4DA80C81
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:36:09 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-92107df3f13so4882026d6.3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794926168; x=1795530968;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C+qoU0BWfVzZvg3JcPXGBBCjwaLAtnEytm4JD2EU0pk=;
 b=ZY8Yyg7LWcTV21IADd4y0VL3Mr1yLkYqlZRtLU+oi4LJqVxLds9Hv4ERb8b0dS0g+e
 C0zR/WhgiIZbvN823OHfmA4wzJfY5/NdupheZuPHTzeG1nXX8swFpFP3kEWvRDjJqrgQ
 o8+yobJwd+ztUVx1lxMe94Ul1yESZMHZJP3a9HkIpA+lpIqX9FYjtxztnAxqp9kGlvRx
 05i6dXMuNLKemX3q7GIqRyAV7TocUmXnspItJlWuP79JqR3L8IMcdB1F6hSeOdBd37s9
 WGz4fEbEVKV2HVhibU9yZP1cfswA+Iin3DBxhJ5ixUeYfxxwNeEls4FsKhEaboo1mW4U
 lNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794926168; x=1795530968;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C+qoU0BWfVzZvg3JcPXGBBCjwaLAtnEytm4JD2EU0pk=;
 b=sjE5VpbgGLkbG5Tz12VG2o7xq+YkrQN2vugn6OQMrAzFUTFx0PB0PPguKszD6y7dez
 M/gDkf0TSQzTjDPfpLEuneE0+LDNiHgXhq4qoQ3PQ4AvO3GZhecy/V3jO3E99TxRIAM/
 fUWxkKOgZG+KRqt7XAqyg5ZY+ic+dmfAZT6UYuaARpSp8+ZllQKltzCNuQ82UbPZhknB
 4Ekw7thlvvXdPQ6V7f+jhdJrDqbsfupqsJKQUZ2LiV0Xt1WnHTXsCjjaVy/90hAAqUlm
 Cf+Wd3nV0jZ/RTsM3kR9wEIMVFvJN9IgicmHDAT/HvShjusN4U7fCa1dxlcLfPQ63An6
 FwYQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFu6z86ray5q9CQZeV9XLGF08KTdE/a97/XXHlp5cote0Io1/Uljgk6/JU2AgAwcaZDgURUzhI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/NnE+gdylp4lJ/4UpKKr3CG4jJfb+BI+FNCItKLoTpqvZGZTNW
 k26xSUJthJ9uajTggjyU9DIbOblzgDjaK2j/0TgkYFHb2gdF0LfWRFHzKqTYQ1cyXV0=
X-Gm-Gg: AYBFou1f+KcWjS+oxSeslAnctPEkq75hCBf54rsOCQJlEq2RVps8T1aoeaV6qjzkKaT
 yyqTXC5wYdI9P6Z6HShjJmOJL0A9inKMiKBz4G/WUxpYnWmGHmnWLwmP0bW6Odjs0yiuAhFuram
 NS4L5H87J26Ebni05MPni/eETk8F53BhEDLZsCzCb7s2+SCZbGftAZffNs/flt4S/jCSNIbp0fp
 3xQqBWlR6B8a97hjJNbEIOovHkvoioG9LgYmLPNDP6ntu8QjjcLpdyJQS29Nm3LI5A+vCPcKiMw
 JcrmYJcWH8A8ltftU6cXlRv2q8Wp6o7S1ya/UmUZZFHg4t2eOHw4LSC8X34yN7ixM8KHTDUHgrW
 xboGsNFZdLyzFL+IWDof866fIeGSGIwmyVELYae0cxOSQBD7+2Z57Ivdv+q2RUsN7oyZLS0xEw/
 RP4AQtBwgugZ98NkokTljfRIiKX9H6t6ZJ4wShQ9yYjJyUn1MCinAuOWTKyv76Ek2ckjcnNYEOk
 Z0nWd2ErZn0d2UBV+oFILQ0Rr8R3ES1PS7D3OgxxwvUfWKmo285SvJkkvBF87djI3uTuk1ImZ5A
 LEPiIAUXJ5hvTCZHlV7JDetJoh5cYOgkK+6ZHZ2G1Y+EAF0IGxq+pEsrNMx0kAJFZoaM3ROB11w
 +wqr8qyrMFgQVZg1TDu5M9H9N
X-Received: by 2002:a05:6214:c64:b0:91f:128c:4605 with SMTP id
 6a1803df08f44-91f2424b5c4mr219397956d6.50.1794926168441; 
 Tue, 17 Nov 2026 06:36:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c3c:99a4:6f4a:ad27?
 ([2600:8803:e7e4:500:4c3c:99a4:6f4a:ad27])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23da64c1sm110955566d6.37.2026.11.17.06.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 06:36:07 -0800 (PST)
Message-ID: <1a1241cf-a113-4902-aa26-6d78ae2942d4@baylibre.com>
Date: Tue, 17 Nov 2026 08:36:06 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ufs: mediatek: skip SiP calls when running at EL3
To: Carlo Caione <ccaione@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
 <20261106-mtk-genio-720-spl-ufs-v1-2-90c578b6c43b@baylibre.com>
 <179442384949.26078.15240674797898354872.b4-review@b4>
 <9f91272a-2f34-4192-b0ae-41320ec552c2@baylibre.com>
 <avvy2Bm1ckpMBc3y@macbook>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <avvy2Bm1ckpMBc3y@macbook>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 12:24 AM, Carlo Caione wrote:
> On Mon, Nov 16, 2026 at 16:40:05 +0100, David Lechner wrote:
>>>> @@ -37,6 +38,10 @@ struct ufs_mtk_smc_arg {
>>>>  
>>>>  static inline void _ufs_mtk_smc(struct ufs_mtk_smc_arg s)
>>>>  {
>>>> +	/* No secure monitor to call yet, e.g. in SPL before BL31. */
>>>> +	if (current_el() == 3)
>>>> +		return;
>>>
>>> Can we return an error from here? Otherwise functions like
>>> ufs_mtk_device_reset() are going to assume that the function is
>>> successful.
>>>
>>
>> I don't think we should consider this an error. We return early because
>> there is nothing to do, not because we can't do something that is required.
> 
> Yes, but for example in ufs_mtk_device_reset_ctrl() we are waiting 26ms
> for nothing and printing a now misleading "device reset done".
> 
> --
> Carlo Caione

I see. So we need to make a macro for the check and put it at higher level
in a few different places to make it more obvious that SPL requires UFS to
already be up and running.
