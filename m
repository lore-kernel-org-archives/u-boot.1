Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E4AC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1B1881276;
	Wed, 29 Jul 2026 13:41:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDSDWNebAcSh; Wed, 29 Jul 2026 13:41:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AD958126E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332468;
	bh=LFLmmM/tdRnoeRfeoIRq5KZXcd25l9sD/fdn69Q7k3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NaVHVZDPwiY6R3867uLl4ROMw2nWm49yag3ocVtpB52C6Tg2ZEsBqU1Ml9FiKIxnX
	 rjvTaf7VrouvFPLskhdAWltM48m/o11YGhx32dp+eLPL+ynyBqMkZgXeTDuv+RRYiO
	 /I02hxskFZ/QRz9ceD3XERUm/yNHQEItamUH5cfSydC3d9PmiEiXzZVyXnjgmwc6/9
	 slHV+CGHu8gMIGoCbH4t8jt6ruT2iEkE/v11P+RBCa4UViDRhETqpYqDTYi7KSZjy0
	 YgF21AmPDetmquYK39GIeieoa0Kt6p3PFQVGkRQLytKtz3btZsvY16CjBQHq0R2beq
	 qjVAHFv9H1/VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AD958126E;
	Wed, 29 Jul 2026 13:41:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A0C42E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C76460B20
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CCrxq3PEwhxK for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:41:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C78C660811
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C78C660811
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C78C660811
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:04 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a051b73866so1220977a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332463; cv=none;
 d=google.com; s=arc-20260327;
 b=QpDJKdqd3ZYJLZwqi/GpHaEQrO8S0Tmnv+oPFhmncML6qvVLbCav7+csfNoCbAPzTy
 A+3X/srBGuUKX8EHIj5Kv1ELAtO5bEZWT5J+NRUzv2Pw2QBb2WFnu145egYIWDVLcI2O
 i+Nvmkyt47jfEMlxL8YHbk8Nh+LTywbCtsU+teIT1n33Rck/k4vWyHaa0Du2Ll0o+yoq
 UDiou607quanelGI5qC+el7HHM1EbTy3+EEEnvKzPxZfvliln0JLZDK3ETNrBa8gXshf
 d1YwQ0nCVq/LpIdEmGWQ9f1Tf0jiL/E0pwKIg7sFmiP9JFjlBWHVxxg4UK3XahzMVS5h
 vOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LFLmmM/tdRnoeRfeoIRq5KZXcd25l9sD/fdn69Q7k3I=;
 fh=L4Q6LOIKVe7Uvc6BPeuDGSs647vmmFg9ifv2xaIzDbM=;
 b=RnXAIbry9fd8hXwAW5on2RlAl7wVDiYWkpSI+XcLhaqehJ8Fn/eE28RLVVxI3/0sxV
 Mr718Dxk+UYbX83laGU0L663N850QIWyn9xSjdiP/biyQ7L+A37MrO+Z2RKCT5lLMM35
 JJ4ccH+T9lo7HiZeHB+hsQ06PycIQEdljjvnPXWPM7DIuJ5dUjn1AkdEAWqYPRmanl9F
 A93j3iPW07ji8jMlMh1Dpb7qqlV2i5I9QdWa5CyUPsvnMtOiIIO7le6vOC7zEjcLffUy
 u0OUHK4PDkcHiUpP5eObbGDTmrfv/56ms5gM8OP9mE9UFkAqoebsrcvoDq38YqnwmTe5
 kyVg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332463; x=1785937263;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LFLmmM/tdRnoeRfeoIRq5KZXcd25l9sD/fdn69Q7k3I=;
 b=a+oELN9X3Eg4V9ofKK2W/goCuf2+FrQf+zEKQSGiAvOmZPq7s1eBjwAXem8xDX9dtf
 pXbZf+facc//RT+xsvQPg4dSWMCItQ5HoNuAosnXaYoai56yF6v+4aWha8qgqPROyLs8
 EBmtTsfPnTTwKyMF2PMxM/KTsSAyUhGYhxWwedRmyMfTtNcFD/EoTvDHnySOUeRF5pfD
 BUTuA55jk6AtbmnNmvK1IAg597RjQ+JfDWbS+zOl7x7/xTls6xJzNsQBkldT/Ebl6axg
 iiZvPjSTzsp+w/Xs8HEcXEgJs487ZIAwWJcgYaqaMhTqX8hiZQIoRZ1CMHPe8FnVLGA5
 TE2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnxLth8xdOYx089An+WSdVp7AbbsJHHDyp+GKsOIywXFHF8SihKDid5emieFOley+Pbq1dDro=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyt94ZfGeozyMwaJvKkn89l0yGp7jzCxiyI4MdMoGJlHQyF1EIg
 u4MoRLs7xTr8eDWbvSLq683KZxJ1NKZ+hipj6onz3XKUeQ+m72Sl4ZWIKnIrIQv1suWHP0naF/A
 7ZNA9sCkkV25f66fZDmOP66rFVFW5gtD6RCwaBlRe
X-Gm-Gg: AR+sD12Buul913Ifm6dmTJkHbhsBeC58Rlay9fY3IP261z1iyWJGZKN9YNvujelCT9X
 7C7AFS1qh0aW0R8Lf6r/ssrfB0uTnuYETjP0Oj7BhXqItew/kNW1GJjdCicDd+A1mQGbpIoK0GN
 UwCqNHuIIp4hF9U1al+IR55tT23hNno6Fs/xo75HSamQ2krT6FQqG7t/UtHxuIT1V96Nqa0eZoF
 QDVZBxOEv6hynpnH+fPOt4zbiyOuzDoGp9prGNujfG/rdYsKb1NIuYi4t0VkZwHnuk1OXXgZaNk
 RIcUQKLlpwYl5qeSv20pFp5Lfs9GKnFUPdec/tdCWzE=
X-Received: by 2002:a05:6402:448c:b0:69a:a94c:424a with SMTP id
 4fb4d7f45d1cf-6a034a9c001mr3202745a12.33.1785332462792; Wed, 29 Jul 2026
 06:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <5d5c8f18-ebad-4d85-b0ed-2c5a9c0a3d27@gmail.com>
In-Reply-To: <5d5c8f18-ebad-4d85-b0ed-2c5a9c0a3d27@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:40:46 -0600
X-Gm-Features: AUfX_mwsgFaX4uAShxs7NOS7nr4AT7IiXOVijDcDpPM6wTTAzAgaRy9ow82uZq8
Message-ID: <CAFLszTgHRxcLw6TjhUv4KNrCJxv0E48uHfkg_U35WEna2mKmmw@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] rockchip: doc: add more building instructions
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332463; x=1785937263;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LFLmmM/tdRnoeRfeoIRq5KZXcd25l9sD/fdn69Q7k3I=;
 b=WD4TVwJZOiZk+lDCGvVUtwgPdgtPUahhxm6sykoUs3juYdiAAdQoB6jxrHMaX3VubP
 /gy/d9gWOyT/ShupEp1QHDkIoxLzzzawtoikGdnr3ACmeS6oUUjlAKlBcNag2p3lh4yI
 JC3dD1MrW59HeFjEiXKJCcGrFK+AjwDW8crAw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=WD4TVwJZ
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: add more building instructions
>
> Add more building instructions for existing SoCs.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/board/rockchip/rockchip.rst | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
