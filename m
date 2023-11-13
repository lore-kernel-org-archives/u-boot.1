Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B2AC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 20:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9F4870E6;
	Mon, 13 Nov 2023 21:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ghZ+95pt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01D4870E7; Mon, 13 Nov 2023 21:27:17 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1326D870BD
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 21:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso1215922866b.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 12:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699907235; x=1700512035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tHiwymKTlEy/YHdP7oZEiOcGJN1hAWsTJTKLzaL+yfQ=;
 b=ghZ+95pt2m1vap8RCmReyhnHrrMt/C3RNFtNsuHAhG5H4ug94t+9Z1167jOw+EU1/i
 RoiznUd2I3UBtZbWaPfpa+J7Yu2X/bzMbgtYPXcx8wbyzkjp6f0biu/MQRKlVR6ZHvhx
 NMQS5+ENLW3C9nJqgGbPFUuXalRiUMmQL01n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699907235; x=1700512035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tHiwymKTlEy/YHdP7oZEiOcGJN1hAWsTJTKLzaL+yfQ=;
 b=R7q8kGZjCn1hN+aiFZa1AtLE0CGTf61OX1TpUQaU3fnY2zxh7gNETsd5xyCOU0Caqi
 pJR88pr6OGdKCQZc66nAkdC3GqVZBlb6L3oLn5VHspskqP8YY495e5/nHd3h4DaGHom2
 mS2ZUQqNPqB5I7U3EWtYqOyuZPaeP29cwV0dbwV81j9C2adfZfZgBs5iu+jT8orO38Kk
 2lXvA8DavSkQJQmtRiC1KLIU0Npsrd4/tr24ObZVqF6dL4R29wbPiL/vWW+CmWf+Z94G
 WP4F8OfWzPjm4zBuAukLSDMq9rTqEfvCfMJ/M7wp1ZKv3dgBSSLu2/jWVMgroxUcpVs3
 aRhA==
X-Gm-Message-State: AOJu0YxIJS+FMvhh3zQvbHl6onUUnrK5KHywNm5uHWDdyjcWQFQqI0pJ
 h2CiqJ9WsFNmHvlV7PlM6EDqqXJ2FyW+SXedGCWWyCwfLWwPRUOMZec=
X-Google-Smtp-Source: AGHT+IHlTT0x/H8FXsxxEgDiQSOT5zUkAqcV4e/+isr/zucy6Geiv6bqdH2PB/pUsAk8z4G7fS++lH/99QsiBAeyUgA=
X-Received: by 2002:a17:906:bf45:b0:9e5:1db7:3199 with SMTP id
 ps5-20020a170906bf4500b009e51db73199mr557240ejb.4.1699907235397; Mon, 13 Nov
 2023 12:27:15 -0800 (PST)
MIME-Version: 1.0
References: <ca3435b5-25de-727d-ca46-a88a234f9fc5@gmail.com>
In-Reply-To: <ca3435b5-25de-727d-ca46-a88a234f9fc5@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Nov 2023 13:26:56 -0700
Message-ID: <CAPnjgZ1eCwAg=i27Kkd0mk7PeR8Eu_955utAjBfkNrMvKZyUgw@mail.gmail.com>
Subject: Re: U-Booters at LPC
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Sean,

On Mon, 13 Nov 2023 at 11:15, Sean Anderson <seanga2@gmail.com> wrote:
>
> Hi All,
>
> I'm at LPC this week, and I'd love to chat with anyone else who's there
> in person.

That would be good, but sadly I am not :-(

Regards,
Simon
