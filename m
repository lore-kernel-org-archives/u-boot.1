Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BB0CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 20:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 400B6836D1;
	Mon,  3 Nov 2025 21:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AvgehIeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81EB5838CE; Mon,  3 Nov 2025 21:16:42 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3A58331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 21:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c51f56f3fdso2451806a34.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762200999; x=1762805799; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HHQWyjuJYWIEAxwMPsYOS+2ODdwIhbwOclZ2BENRXt4=;
 b=AvgehIeMFuGHFUEVIAAnxecmX/glQP/sSjNeIyUzK7PEr5KcngDHDHLBSfHgS9Zwwv
 DMJhA5kI1Uegcge8beRlfrejm/hy5DEyO1XP8HSRtuh1Y7KsT90KPh9v0QgO6TfkinY8
 KCgHKpSaQC/2W01sD2JeGxJuf0XJPKPM1CKtYNshTqz8QMJWA8mNnF+3OOowM8+YJPrU
 wdINno52ZEuFlYOo48rKbEDVSiZdC/nndghzIQs1X1Y0lOtdTJJ01NxRNBEFctjEok8l
 ZJt9wg2eKCSc7sl/bUdAFpEDDAr2k3G+O/m6kXcpPr715QmmPrudO1BYP4Ktk80rSl/p
 3krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762200999; x=1762805799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HHQWyjuJYWIEAxwMPsYOS+2ODdwIhbwOclZ2BENRXt4=;
 b=nVMGsaXMkzgIk2eeLJxlasUlcBSLM7ZexbXO1V31ZxCKmFRc8qtqz7e9ypV8trTWPd
 fDUzzcPknbzebfe4fDB8F/v2rc9sdxO/5WaH/rBw0WxnXk02GlGxVjyAELXthoSXJ6KH
 tJqayKgKPJFqadn4ElAYNmineWKiDR6foo+L2f1HuPMB19QKfKYZHvj3DvQydMEnGvPX
 dHT03loNYrFeaWXtuovqZRrCbGEYsYgusNIII7W2JpPLeDUkhV1QoLnW0OCvX2jIHwEg
 zOWHtm9ZW3LHNr6qVGTyk2OOpuxyXnEJwNoL/qEAs4kRgVVqI2+eXzc5AY7bE95jFjb0
 UJdw==
X-Gm-Message-State: AOJu0YwdYP6uGDj8spbJA9mMnUh0Hx4xHiMEvQMd/4BHLuenlkbPrpwc
 hcwRey0ddEIIsq3XWxlX8q1vmUCMT/VICRu292TaXYGZbSp1OW40gNTMc8jJG3Q8Oo5wLPEdE1t
 gv0USPN4QTO5K0El8tjOO3QfjbX+SeOFwWNCs
X-Gm-Gg: ASbGnctTFt8Wn4yx3jnZejHEpaZQOS9uqM5hahX1tBbthB/ticdOvYGJlL1KTWBndLB
 jwxUzzNMqrsb7Qy1rf68+WQ11T05BB3irHR8IogSmC83zsFb4B9RCFdK9bNOkxcbAN6C9ayWOZD
 8uQobR9XJK7t1QEXXJ92Y75W4Hee/VXo9MNoUlH/U795+GBwWcuKhRrHIJS8tBQA5p6EniWQIYX
 /ZOK1rDOx6GWF3PXFAJxnwg1VD1jRDvCtceicXqSJs+n/rqaRjWq71ediVdlO+II1ARSamj
X-Google-Smtp-Source: AGHT+IHphm/Ou+dXQ6O1VNevP8S/oXch0QBfAtIRvlpMy72mTaw3sBc5dVoQRL0qcRE1dGYIp+JhXLes8m/L5gIjlTk=
X-Received: by 2002:a05:6830:6602:b0:7b9:7d41:1031 with SMTP id
 46e09a7af769-7c6966f87fbmr9002980a34.14.1762200998917; Mon, 03 Nov 2025
 12:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20251101035252.261-1-briansune@gmail.com>
 <20251103153657.GO6688@bill-the-cat>
 <CAN7C2SB0b_YjcJ+LyVUJwi5DjdjR5Ssi=yQwuCvSvBh3XVj+dA@mail.gmail.com>
 <20251103200959.GR6688@bill-the-cat>
In-Reply-To: <20251103200959.GR6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 4 Nov 2025 04:16:28 +0800
X-Gm-Features: AWmQ_bkFBYiNW_q6CcxR3VRXhlGORv_fctHwBvLqQN3WwZwyjoSPMUCV6w5HjlY
Message-ID: <CAN7C2SCY1Q2_YcJWVMs0Zv+ymcuXLXEhrkX2JGcJviOaKDf0sQ@mail.gmail.com>
Subject: Re: [PATCH v2] Add make feature support for SoCFPGA Handoff
To: Tom Rini <trini@konsulko.com>
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

> On Tue, Nov 04, 2025 at 02:55:53AM +0800, Sune Brian wrote:
> > > OK. I was hoping that we could just automate as part of the regular
> > > build process seeing for example $(BOARD)/foo.xml and invoking the
> > > script to re-create foo.c and so forth, but that doesn't seem to be the
> > > case. So, no Makefile logic. We should then instead start on some

My previous mail would like to know what need to be done for the
Makefile logic automation works as you expected. I can give it a try.
And what is the current difficult?

Should the handoff compiled folder just place in the board/xxx/xxx
And let is auto build or not?

Brian
