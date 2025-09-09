Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8E6CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 07:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0AE182A9E;
	Tue,  9 Sep 2025 09:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hRNHYXxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD17E830B4; Tue,  9 Sep 2025 09:04:58 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E651580422
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 09:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6188b72b7caso5744731a12.2
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757401495; x=1758006295; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C/11PvdzA7Aba/WBlBrfJXy5oXsijd4RxunmREDbypw=;
 b=hRNHYXxwTZBHNpVhDAkOxvFFPp0PjiJWhe1d87FaeE088HDi0JSaK+IGA9tAZa+ErX
 QRYdu0xG4oM8/Aaf0aemPF6jpSKDYc7XnUBcpdXzop/9JCwaAXGqgxaLZokodE6UYWFR
 SErHuFW1VgjZLvb4zeqBMfbQg4HV88waFCabnDdbi4gpt32sj69c50wrGA4wWwq5i26O
 rfs+sEhCmS9R9J/KP2j2iwdG0fpSAGUeLHFftRIQzWlXWMrOl6kiImTSHrzlbcXXfuby
 9NzCe8UzQ4a/XjKfoNypu0KV0K4DXB7Fbd6D2yzS1xpmab105CBKOWaRuo/kyskJoVJb
 mLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757401495; x=1758006295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C/11PvdzA7Aba/WBlBrfJXy5oXsijd4RxunmREDbypw=;
 b=v4MjrWN51yYBHiCZcHtkLLM4zEUT0IEFHMwaCw+WgnENph1kMYTVJi4gEXeTpDrMxL
 23k8VizE54s0dCznroNIiI0bIsnwqpOcLcAF3fGDzS26FtcCI2+OUn1orFf11Zq7B5cD
 7apzULx33PSwyKQPEik+G3DMcg5AP9/VJjzN9zemPSrigq862wTcubRHJH8VWU7EwuBR
 xU7HKFqsyhkTr0IKbvOYfEuNmgEH7GTm9RnHwiXdKE2DUG9dNNKXD+A1WPsu9rjLOky0
 oWMjTL/oaURvel25Z5bdx5+/DA2jY8BWakjDn/enbxNVh6xElnmO8lEv+EcRNzyG5THw
 QmhQ==
X-Gm-Message-State: AOJu0Yx9aNoaq7/cGGJPjs/ZaJfAe896XeVu4pnLaaQ72GY1wrQ3/k41
 N/7LDuD3e238tPWCVavcXUIG6YUDthXNUieFUonJquZ1lqgqeCSLGX5BOdvd/+FDlOEwb6PTXX7
 EXqs4Y41YUg==
X-Gm-Gg: ASbGncv0up8NkpOBfOrrKK0k4oHU62UoQRxovARVJ4a0BcsCfxzPS7XXIB79rz0Tpx8
 RZUGEr1BdtaNXDSBIkKP6NvMhEDozgSoG1Fb5ShjQXFA3fERZ5Dx60JdrSQVO9kDD0aKg10cApC
 6BFcde6xb+PNb1CuIn1XeTF8/XfUT6YicRu4L0YfYhem+29A3PXYHRixQsef/pt2sUjtvPbqjpo
 UzeIKgKIanuhjvFBaJzzOAQrqeBCq+aKY9xnberG1+q8jas1u2eiTjPcsi/kO7AttN1zCXugliA
 ZW0+ldWdGqloAv5r/yks1XHVEdjr4wLt91T/hbAGqwKeYiPW2BCW2At9RdMRrSn7AZaOKh+hOL2
 AiCxbxNKj24ngHZqkbk0pyVLcY8lzgtTGgj8qxiM+B+kx
X-Google-Smtp-Source: AGHT+IHW7sMwYJZ3LbsO6DH5MO966i8oUiGuSDglZgXamCzU714wXfEql721aXcORcZijAcPH45N6Q==
X-Received: by 2002:a05:6402:3512:b0:627:d77e:c346 with SMTP id
 4fb4d7f45d1cf-627d77ec6a1mr6674631a12.23.1757401495326; 
 Tue, 09 Sep 2025 00:04:55 -0700 (PDT)
Received: from [10.100.0.2] ([194.15.111.168])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62bfe99ffcbsm692520a12.3.2025.09.09.00.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 00:04:55 -0700 (PDT)
Message-ID: <72434802-3196-47fa-ae2b-f83c5c5f6356@linaro.org>
Date: Tue, 9 Sep 2025 09:04:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LWIP buffer alignment
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot <u-boot@lists.denx.de>
References: <CAJ+vNU38CyNjp96wH5m4FH022WxHghaASxU-gG=Uuc=ni7fYPQ@mail.gmail.com>
 <e0c32dde-f265-42b5-ba4d-29a3deaa7eaf@linaro.org>
 <CAJ+vNU3qmhCJhWbfoRFrSimOJpKxnRjx3sxKAUxqZ6tEX=FP5w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU3qmhCJhWbfoRFrSimOJpKxnRjx3sxKAUxqZ6tEX=FP5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 9/8/25 18:44, Tim Harvey wrote:
> On Mon, Sep 8, 2025 at 7:21 AM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Hi Tim,
>>
>> On 9/5/25 19:45, Tim Harvey wrote:
>>> Hi Jerome,
>>>
>>> I'm working with a board that has an IMX ENETC MAC on it
>>> drivers/net/fsl_enetc.c and when configured for LWIP it fails and
>>> warns about RX buffers not being 64B aligned:
>>> WARNING at drivers/net/fsl_enetc.c:776/enetc_setup_rx_bdr()!
>>>
>>> I tried changing MEM_ALIGNMENT to 64 in lib/lwip/u-boot/lwipopts.h but
>>> that did not align the buffers to 64B. Where are the lwip buffers
>>> created and do you have any suggestions for working around this?
>>
>> The LwIP RX buffers are created in net-lwip.c. See eth_init_rings().
>> You might have PKTSIZE_ALIGN and/or PKTALIGN set wrongly.
>>
> 
> Hi Jerome,
> 
> Thanks for pointing me to eth_init_rings(). This function uses
> net_pkt_buf as the base for the net_rx_packets array which is a static
> global and not aligned.
> 
> Looks like we need:
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 660ceb10cbe..aec05d55de6 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -30,7 +30,7 @@ void (*push_packet)(void *, int len) = 0;
>  static int net_try_count;
>  static int net_restarted;
>  int net_restart_wrap;
> -static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN];
> +static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN]
> __attribute__((aligned(PKTALIGN)));
>  uchar *net_rx_packets[PKTBUFSRX];
>  uchar *net_rx_packet;
>  const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
> 
> If you agree I'll submit that. This does resolve the issue I see with
> the enetc driver using LwIP.

Please do. But then I wonder how come the legacy NET works OK? Or does it?
net/net.c has the same initialization sequence.

Regards,
-- 
Jerome

> 
> Best Regards,
> 
> Tim
