Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB8FC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 12:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A80882EF;
	Mon, 27 May 2024 14:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pj36C1qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E5D28833D; Mon, 27 May 2024 14:45:06 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1916E87EF6
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 14:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6302bdb54aso90193266b.0
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716813903; x=1717418703; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Szrz/uvkpOZ4F5mTgsUaY4J9/vHL6m1175BZWirA7lU=;
 b=pj36C1qnpl54jIJGApSggKKw3BxAz1tLP1+7oRPT9FrY9cKLyEaLLuyUSJHIHjlNvn
 ZqZYlVx0dx9UYFTkdu9CaGs0Jd0muC0x6q05sHtVCSV9bEvAl/0Uat1buZrfQoOfd+w7
 yWDImv6PkM69mMt2Tu+NWGeoJCFCLZ/tky33Laxkx6BcvN1hnasXJ0akUPMNoLpKgnL9
 C1EJOPulQtwLnx/cgzbRsSG3KZElFtZNzOCPRTzLIjE03oIrL+YS6S2fNlzLAoFxu0A8
 UhRxrttoEsc4xqi2Qt1YNqA/9ldGZUhaWfZHnzXLAKeEzXr27muHhTKYnswiWhzvdFDK
 QDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716813903; x=1717418703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Szrz/uvkpOZ4F5mTgsUaY4J9/vHL6m1175BZWirA7lU=;
 b=OxiyuIndfk22z95yOprzoqt0lWcz2nMm5JciAe2inxQ7YSy7t252UGXjq/iKkrvw1s
 /UBaypzLb+2WxyQXAwVAmRcb7Eo1107z/bR9K7ISqty2SZfiSCTLTRbHJrCRozKwCXKJ
 PZUFbWuDImvVmKmf5d1gQyDnK/CZfuRPcaX6XEO+lwZOCeZFUMKGiq5GlYE0jH4W+LR+
 oPD4FDEbAg10zNQQ4oErhve55Ay1Fqxf4iutD8CLZiwu42TN76+2wKoEYKOOVoZghNar
 3s8LziHVUd5Atj58681rfsbcEGGZ6UeyFvXg1669Lle7/LuvTifKokVo3u/0YyW0/iZp
 CpWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtt+l5uCTcVeuGFZAFxcYnDtIz0e3kgQMdwbggMDJpf21R6TKOyOBgryeMMX2oOE6+NJHplMOaVKDKuuL/rThg+hLCVQ==
X-Gm-Message-State: AOJu0YwUQysP/EIqkU+9LGW13xwSNn+JKmUcY6TLj/6fhCbTTxnmYH6h
 W1qNX1duZ3PThM8l+EVuYYgz0m0T/vp5Hx5namIDhwHYjggM67iS/2KbOtOihTI=
X-Google-Smtp-Source: AGHT+IHgP9EJMsF+RoOpXcMKpplGjdCBtjok6lj5ZvKtgkCyMfInvlfw9n6dKaQ2gzBQR+uxQSQdRA==
X-Received: by 2002:a17:906:6402:b0:a62:3228:b374 with SMTP id
 a640c23a62f3a-a62642d888amr587608066b.6.1716813903467; 
 Mon, 27 May 2024 05:45:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8c860sm485849766b.168.2024.05.27.05.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 05:45:03 -0700 (PDT)
Message-ID: <ce97ef0a-29d1-4735-b44b-0ce517bb82d7@linaro.org>
Date: Mon, 27 May 2024 14:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Introduce the lwIP network stack
To: Martin Husemann <martin@NetBSD.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <20240527092301.GA7851@francesco-nb>
 <23a33323-35d8-4ece-b57b-cdfbc318d3c4@linaro.org>
 <20240527094522.GA22281@mail.duskware.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240527094522.GA22281@mail.duskware.de>
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

On 5/27/24 11:45, Martin Husemann wrote:
> On Mon, May 27, 2024 at 11:36:26AM +0200, Jerome Forissier wrote:
>> You're correct. The point I am making is about using a secure
>> (authenticated) connection, and I should have clarified that. While using
>> HTTPS might not be critical on a local network, things are different when
>> downloading from the internet (think man-in-the-middle attacks).
> 
> (Sorry if this sounds like nitpkicking, but I am genuinely curious)

No worries. Well-defined use cases are certainly essential to
proper implementations.

> How is it supposed to work?
> 
> You need not only https but also verify the presented certificate chain,
> and for that you need up-to-date root certificates (e.g. the bundle
> available from mozilla).

Yes. I will let Javier comment further since he's more directly
concerned with that part.

> This sounds a bit outside the scope of u-boot to me

Maybe, maybe not. I would argue it is a matter of deployment policy.
For example assume the device is an IP camera or some other IoT thing
that comes with the bare minimum to boot and fetch its OS on first
power up. No guarantee about what is on the local network -- just
plain internet access. https would be quite helpful in such a case.

> (or you should 
> avoid the man-in-the-middle argument, which leaves the still valid
> "sites stop offering plain http" argument).

As long as there is at least one valid argument then I'm fine :)

> If you really worry about man-in-the-middle you need to download via
> https in an environment that does certificate validation, and then
> even better verify the hash of the downloaded image. After that you
> can offer the image locally - via http, https or tftp - for installations.

That certainly would work but again, isn't it a decision to be made
by the device manufacturer or more generally the one who builds u-boot
for the device?

-- 
Jerome
