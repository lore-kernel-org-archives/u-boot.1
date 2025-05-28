Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8970C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 07:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D9C83922;
	Wed, 28 May 2025 09:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ugrqjp7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E53A83923; Wed, 28 May 2025 09:57:52 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4254283910
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad52d9be53cso625723066b.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748419069; x=1749023869; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pr/vbkk+YYRSSQNMXY+PRrFxpsUkoqbnhFYQS7jm9VI=;
 b=Ugrqjp7PziP8QmVl2uiZ0knigX0ToPQ8u/6hQ5KnZ/cEyXsCq0IkAjs/IAvmBEEVqS
 rZuycwXbnOHo+51l67e/CLe2jL4TuIdzo9DdwqlEnZjxWH6KBrjSmvZP+4+Vi0unr3sn
 xEyxTc38v+kR0oV0erkIqix5AZ+V3sUfhZ5NbFNNljHwwa58RxLxZphoVe5VzvJ+aEHA
 HeIJaWeT62vhnMI9r28/Js3pPCEBKDcGZLR2eN5g0z3wGX+QGlreWlLDs7MsELRIWf2N
 RNdmaW64gJGZFtqSBNKFfv4HSLQQiAcOazwzDuo1I7lACz3xOIi5A44bv7CCOPJUkBic
 UluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748419069; x=1749023869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pr/vbkk+YYRSSQNMXY+PRrFxpsUkoqbnhFYQS7jm9VI=;
 b=DOinH3AHb4ELcNyzbaZNma7cgYHCvycqzfiG72bdDhpw2RF+DeloTTxyCeToSt65Tq
 sKK4FfgZMjQRnU1x518JQ/c4/J3RTLFFzZJgQxIHrRYcrzkqForUBB2QMgl7H9RWMRay
 LxlaZ5h2S9jEzlOCF9Ie1f7T6A/JX4jJ98YN2CD2+LFNlh58yNBxxL7XCD89wIzYMoxh
 9sYzzJrY38tmGL+7+sxB3+5LSL+bP2gRn0BAzla2dwzRVBqJrKjmcX+cp4gLld3AG05R
 uw55UpiI/ThQH1H+hlq3t+Xwq+eCvOAEUEox/laXN9o7hdjC7C0Hd7HZyKQdV/PdXSmI
 f9xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh26XZsTr8dwI5qamiWxJxpkX2CNWXK6PKZe/LCmc41y+YZslZsWC9GxwHpW5Qy6Rg1ITwlfo=@lists.denx.de
X-Gm-Message-State: AOJu0YyTO3tDOuQk5zQDkVVciz8/5Fdi+T4GG10SQ9nBD0jmTHmPLfbV
 z0+bFTEg/TnZLObwpHlKoyEXHPfIWyCXVBzYoNMLWw1VS3DswivBxTNWNgDP++KBOM4=
X-Gm-Gg: ASbGncskZg13BR4F0/WHnrtu/6nMeTAX5lGXDxR4lg6ufUBDAj13L+v0rbNCVhxclZT
 VmC2GovuJRFi+ev/e9OfMTviw58Wx5nALaT63PUJeBR/fKXLPZV/eyXwR9e0f4+sdey2+A/S5Nd
 FYJ4CQspIUfThyGoUtOyPFWzhzoDgLp36r5zqFCJ1nB16F8jskHHKW9etOIOtMuogdXg3ZPF8Co
 DUOCksZOfzqcugg/JZbJLNaZ7MzUgGIwZplNkcP6dl04317hUBV88zljmbLKMaydkrNiZToL/0H
 aW5pNOa4fwIfj0tMpD5q5BW4WGmjvA03tHdkbKT7DAs9FkqbbOtd97c4MEoqm5vy5Dqc/3Y=
X-Google-Smtp-Source: AGHT+IGnRZxWHSwZR+NoCxIudpxU682HquTMt0gtMoZ1FrDCmo5mcFC3BikR/PAyH/ealiy01UX5eg==
X-Received: by 2002:a17:907:7ea3:b0:ac2:a50a:51ad with SMTP id
 a640c23a62f3a-ad85b0d1dcemr1524330366b.14.1748419069215; 
 Wed, 28 May 2025 00:57:49 -0700 (PDT)
Received: from [10.5.0.2] ([94.101.114.227]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8a19ad565sm65828966b.13.2025.05.28.00.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 00:57:48 -0700 (PDT)
Message-ID: <2b22423d-36db-4dba-8844-9bab22579158@linaro.org>
Date: Wed, 28 May 2025 09:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lwIP watchdog not being serviced
To: Tim Harvey <tharvey@gateworks.com>, u-boot <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
References: <CAJ+vNU1=maNegZ=DiVR+OQG6B+eaGdn9v9Spz+KhYGCbzhRaFA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU1=maNegZ=DiVR+OQG6B+eaGdn9v9Spz+KhYGCbzhRaFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Tim,

On 5/27/25 21:07, Tim Harvey wrote:
> Hi Jerome,
> 
> In my continued evaluation to see if I want to switch my boards over
> to use lwIP I've noticed that the watchdog does not get serviced
> during at least http/tftp which surprised me. This causes board resets
> when transferring large files such as disk images.
> 
> It seems lwIP is missing some calls to schedule(). Do you have a
> suggestion for the right place to call this for lwIP?

That's a good point. Anywhere in the receive loops should be OK, for
example right after net_lwip_rx(udev, netif). But for simplicity and
to avoid pattern duplication we may want to call schedule() as well
as sys_check_timeouts() inside net_lwip_rx():

int net_lwip_rx(struct udevice *udev, struct netif *netif)
{
	struct pbuf *pbuf;
	uchar *packet;
	int flags;
	int len;
	int i;

	/* lwIP timers */
	sys_check_timeouts();
	/* Other tasks and actions */
	schedule();

	if (!eth_is_active(udev))
		return -EINVAL;
	...
}

Regards,
-- 
Jerome

> 
> Best Regards,
> 
> Tim
