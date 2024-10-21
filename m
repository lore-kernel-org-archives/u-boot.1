Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4926D15DBA
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4F188D54;
	Mon, 21 Oct 2024 18:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LeUYRJPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261E888599; Mon, 21 Oct 2024 18:32:57 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBDB88F2A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso730415766b.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729528375; x=1730133175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pAjQW1GjzltrPGiBPaJLUrIlzJifqVjOAtzGXCSBYRs=;
 b=LeUYRJPARlYcaNOCmoSG57ZVA44ACHUFuTHQf7QHu32FUD9med8hlybOAG0AJenJ0P
 /2Rn9SibBmYqZ/YYM/pGqvyy6cDiaAxOydWT1kp6GTOot+QruLyL3iL88s7UDm7kydh7
 PUbosGck2JTMPJnr0Wn477IdBDaOzJUpV38xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528375; x=1730133175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pAjQW1GjzltrPGiBPaJLUrIlzJifqVjOAtzGXCSBYRs=;
 b=qdcoVkp89AeCw76mjN0MzN1JUpEncWnmVpeNz4iiMxfPUB7W11icuN1qVAX+dLnNSl
 XJkNCUJ6BO9bHE4OhSg5GBuWJMQaplHs5ftRNYH+Mm14eTOe2kP33l3V9oMD7b75uAq3
 mBuBw6Mw7mSNc4dhcz71e3Id85j+v0IVW6r64qHu9rhWrF1Rf7ATwMLyPJtlszkODmgo
 6Xg5DsFw/H2Ngs6eegz9uqAIxYdYWgR7Bnx/7/dfCOrVeH/+ral9SiYSz8XMJyezpt8I
 sD6yN29QKMX16ccSisXc3wXY6cy5FP1asB9DCJHz/mso7lqGZMrxx0GCvCggt1VlG5AM
 kgZA==
X-Gm-Message-State: AOJu0YwMlgi0MfIuriA2me5XydiXe6b+hAQUZ1bk7aws+VprxA5O/ClD
 z4Ngny/dfl2tx7DaDJhsGlV32jxRScYupSN5nty+OCXsTzbVHCYCa9iqEwhI4gqlj5EB0Nmiq4o
 2PH14RUFe2PW6ALoyvVL6iDnYiGaoVM57HgdwY/9k8GFpS7wM9+FA
X-Google-Smtp-Source: AGHT+IGknAKxKCXr6T8CBNm3ch/pkP9730+pA2/SH4hHk9BL74eCVyj9gV4cDF68kVXRqn6TRz2U3F61CEWa5D9qaZc=
X-Received: by 2002:a17:906:730e:b0:a9a:2e12:1a06 with SMTP id
 a640c23a62f3a-a9aa8a05e8dmr48985966b.51.1729528373267; Mon, 21 Oct 2024
 09:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021113839.318572-19-sjg@chromium.org>
 <87r089r50l.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87r089r50l.fsf@minerva.mail-host-address-is-not-set>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 18:32:34 +0200
Message-ID: <CAFLszThEMyk4ppCjK2XuG6vv7=HSpy+krwpVvPt92dJDxmXV1g@mail.gmail.com>
Subject: Re: [PATCH v2 18/25] igep00x0: Drop unused status_led.h header file
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Javier,

On Mon, 21 Oct 2024 at 14:53, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Simon Glass <sjg@chromium.org> writes:
>
> Hello Simon,
>
> > This header file is not used, so drop it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
>
> I've already reviewed v1 but you didn't keep the tag.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Oh, sorry about that.

Regards,
SImon


>
> --
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>
