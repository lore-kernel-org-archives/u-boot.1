Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7D4C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 08:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58AE380C83;
	Tue, 17 Jun 2025 10:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bYQshI2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADAAF81E18; Tue, 17 Jun 2025 10:06:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406578070C
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750147593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zvvvTMDsUdI21bcuesylpBcQpmWDJVMJbvUyxc1puVQ=;
 b=bYQshI2ZcFbn7SGtohrsLJiiBdtYhR0VG8UA3Az1Uz/iwSvw/cUfa9cJzN8ymA8I7dkwPa
 aq2FRFRbtdkHQQhndrtoyzevqz3XLNTle2zAD4jCxeT7EaOhZqI8Y0mBq3cLVnHffdNLPf
 rYWXZg87coEtO4M9ukRW29TU3z5JbUs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-JxGZUd3SPEm_Mm2_kNKp9Q-1; Tue, 17 Jun 2025 04:06:31 -0400
X-MC-Unique: JxGZUd3SPEm_Mm2_kNKp9Q-1
X-Mimecast-MFC-AGG-ID: JxGZUd3SPEm_Mm2_kNKp9Q_1750147591
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4e9252ba0so2697539f8f.0
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 01:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750147590; x=1750752390;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zvvvTMDsUdI21bcuesylpBcQpmWDJVMJbvUyxc1puVQ=;
 b=NpxsrstitgAXyU6x++MWm5IBAP6ZATNpSIbxfa/caP8K4/BsXEi70XxjoV8o1ARuWL
 ea2qt7z8vkeafeQCrA2Vv3fP2RR2sawZuTZJnIkVBM3vOQFwmE1nIIEJXJg1ZOg/9moa
 CLK2vGD/XIii4XECVGU76Sjobk9wYShv/8s4uaphXXkB/RzEcJBqd62x25yX8FyurH3E
 ZlyuH/fSa1o9WCVCzfIxo4I9Q7K/cVo8ujNrHa9xS/gDI4aqnABAHVss/mBvMLbMj0Yl
 Z36+2hs4STmAd3hWtupTChh3KxEmJdRxtQM+pNp/+VyIDnoFssm8WfCfGu3dO6I1poRa
 wGnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn9aUxO3twupI5rEP/gOfAKVZuRn7Eif/zptAeVDwW2ZO0q9EIjU3AR0xM3TMQg2qA+TuClb4=@lists.denx.de
X-Gm-Message-State: AOJu0YwAiH2aNhKRVsy+8ZypOGKFxVftVR8gUnmqxg91yIYUrfayc4ka
 frGqo1nR9sWYSBUTAHm6yneS1wqP+rgMOuX+mdf2x2bQ5Y1HOISa0sUlEvIoOQe1pLEya49bX3D
 liTFgN5vwO86tHh8qheLQDiQ3JQrir981SRtWn7Teaf6ZqBPvrZnjIAg=
X-Gm-Gg: ASbGncseTr6/LzProMnukyFfMEjcnJ9eZYuPmfcHZgLywl4WkiFR0+pChHHHsDa8Mkm
 08bWVBCS4/cD+RMXroE2H+X188m/p/7aeZLxxOpYsqh3vQyqQmiIispJRT87bF8JBFxMJ1/dazq
 z7LVTuKxVSyDAeeA/0bIjbKeeslMXf7hUC2vzYw3MYIBEmQehRVxDYVRDpLAd8McjU4IS+yV5Aw
 vH5fri4BBgaIM8X42z8H39zeOv7aOu91X4IjnMc+BIjiDIWJl6kwB7UY/riJlkW+NTKlyj4x5ZL
 /v1pIab8BzOpqxwWcXVwgC23OQqMGHaMIassIs+ye1ZRoclfi85XD5IbQ0U2ILSD8VXpiw18VqJ
 TnoZA
X-Received: by 2002:a05:6000:2884:b0:3a5:2ef8:3512 with SMTP id
 ffacd0b85a97d-3a572373cdamr10944204f8f.14.1750147590500; 
 Tue, 17 Jun 2025 01:06:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0/HTZW6bQSBpkdCOJuEz4t/NobpOQ7TU46po6ipF5V2Cj4WveYR+NBfxw0F1QzWi+joHq2A==
X-Received: by 2002:a05:6000:2884:b0:3a5:2ef8:3512 with SMTP id
 ffacd0b85a97d-3a572373cdamr10944179f8f.14.1750147590138; 
 Tue, 17 Jun 2025 01:06:30 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45320580af6sm192865425e9.1.2025.06.17.01.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 01:06:29 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/2] test: disable TCG test on sandbox
In-Reply-To: <20250617061945.9266-2-heinrich.schuchardt@canonical.com>
References: <20250617061945.9266-1-heinrich.schuchardt@canonical.com>
 <20250617061945.9266-2-heinrich.schuchardt@canonical.com>
Date: Tue, 17 Jun 2025 10:06:28 +0200
Message-ID: <87ldpqdc6z.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ISWjJWmZfdtWXVHIAIBXN9NcCf-e5D-VJB92yTwUMpM_1750147591
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Heinrich Schuchardt <heinrich.schuchardt@canonical.com> writes:

Hello Heinrich,

> The TPM emulation on the sandbox is incomplete.
> Even basic tcg2 functionality like get_capability() fails:
>
>     lib/efi_selftest/efi_selftest_tcg2.c(886):
>     ERROR: get_manufacturer_id buffer too small failed
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Oh, I answerd to v1 before realizing that you already posted a v2.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

