Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD10AFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63798841DF;
	Sat, 25 Apr 2026 19:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QrO2uaH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB3984440; Sat, 25 Apr 2026 19:26:21 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 495B9841D7
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a402b2d102so9572538e87.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777137978; cv=none;
 d=google.com; s=arc-20240605;
 b=L1B6eDWC0siDU0X/pzg5BKkkb2R+9r1Bd2+w4fb73eGgU/4eKOqKcel1dMy7sc07Ir
 nCEXC+u7Xkh+enA1WsWSkVDavMCYCvo5p4/aRzXUMGjKGmHjJy49OC+Rhmz8wI1yx+yx
 5iFL0v4cD9AX6co0Qliix0azpYNe7YrymLuwdF6FptVRnT2mr535sZled8lvK/cEgbI5
 c9YsSBlTsiMnTAvZpVddQxoIFMEDdm5hIUVHmP2JdB0V/um7aGf4SAlLfhbwdnW5YNLX
 RUhEdBEA8tq2VlwR1l9pWgYGG8NOz/vjv0W8ahX5jQxJg2khQjL1KS2YMM6tu/WfnKEg
 CM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iDkOzAxqrWJnisC2m24XXwX7qUgE4XXQ+RIru1D/Fnw=;
 fh=7Vgn4PQjIvSWcBjYWh3xKwuIw8VGOYDKmEHiv/J4QUQ=;
 b=TcQMDWZRI4yw499UHRKqVEQOQnoyvrhAXqUfc+5Mv7UFIe5VDG64DPXXy6NjFQmKLT
 oDBiS/ah02Tb+rReL6tdtDqrlNccOo2tYpQBlaTCtYLDDRlia1PgrR22HC5EKAtEH9+p
 PkzkOW+6dlYWwLM0fbDJrFhCd90s+Sr8jsfKzgSj60LDhw38bwvXN7vNkMPBwkEDjuch
 dhp9cMHdrOOT515EWfs1r4mQIIvfeFqM4taSlMM2TkqiulTvKDA+U/IihzqCjN21Yh6s
 SUGqeGZMo6kA/Zi3GLn7EgKvXUQpLBpYnM6EP+lcLWDty79++8q2sA36L7Ys6VwGq/uc
 kiHg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777137978; x=1777742778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iDkOzAxqrWJnisC2m24XXwX7qUgE4XXQ+RIru1D/Fnw=;
 b=QrO2uaH3jVg3jssFGA3YNAomS3ol6FUDyeFids073Ety5FOKakU2TXi59QIjj9uZJC
 94PXXGNG/uoOoyAxHkEmR7athAlkHhVwspqdlnY2BbvyO3MNxgJTi7B7IS4I6bK4VpXH
 JgVMeV9m/1k3adHFnfan24/VXK5uin3aOdHNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777137978; x=1777742778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDkOzAxqrWJnisC2m24XXwX7qUgE4XXQ+RIru1D/Fnw=;
 b=EbeA5Y4BzBtmdDUvDtLzW+gU1dd5csOJ5Ww2z+gsEkIIAMkHFlD8gxXpXmghZupLcj
 AEOpzm/IZXnnXi7nvhxKMUqAnWYtfBzK0DyFcjiVsGi5wtXTVCiO8HIAaeOoB3cxKmgu
 zp0NYviwZQcB/grIEzPCsKSKiq5l4oJToUJRZYYrHQSbPFGwXv935ml84cnkI86xTZBZ
 8Q2zzR4uiNP+Ky+Ugf65YY0T67lmBZVrqYpKgsBJbzP5J1k56J+C9G551mun1KF76A5H
 TukvxZtx+yjSZjNZqT5nAjIMWv13szuMRjvs397U4vHQTNY5fjNnIg8TAL1VywZTPzuT
 NKVw==
X-Gm-Message-State: AOJu0Yw7U5pKwhgo7i8BiXt7cE+YonsPrIcI4BqeGJkM8j3jSnGoj8gZ
 KwopHf6gPaGtwhXPronjiyPBB9px4Nirnxm+v8QZl8fCcamfv+DvBPHVPFycOx6sB88zu74Hj9g
 9kCMofzo9hbdA41C3Khr/A9GbPolYjGGEvvmsT70YOET+FLYjOrWfiw==
X-Gm-Gg: AeBDiesVaPVXsXMb2fj/hoUX7xLhRZJ1iG0VW4LtezLbwxwKsrg9/PiSl268qt1RXLA
 jijrZ6/j6CH7l8qBh+y/bFUMQVOSsTfBIfu58lCq0RyXjntN/EfHmZpWwaqnd78BRtQlmdEsaX4
 YeHeZhOWvVrU8bOMRWS9I4GuX7IubhRQEvfXLbNRhI7LplTuyqs4kDS4aUeMgT4QrS9InIgW/ol
 eEiiRsmAR57vy1pRPC7/hjlCCl79ugMjvnB1sMBt3wZUDE5c+BV83cFGgvYH67/tmrj8j77YAKY
 bcwW2G8RsLC/fcNufa23
X-Received: by 2002:a17:907:c248:b0:ba9:13f2:95d5 with SMTP id
 a640c23a62f3a-ba913f296dcmr576590766b.29.1776895038976; Wed, 22 Apr 2026
 14:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260422193846.1333146-1-raymondmaoca@gmail.com>
In-Reply-To: <20260422193846.1333146-1-raymondmaoca@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Apr 2026 09:57:04 +1200
X-Gm-Features: AQROBzCpBiXXG3r3EMQZYeUwscOijzL_Ppr3VT8Bwb2EG7XE886VRccqskvQ6sM
Message-ID: <CAFLszTg6qH5JOgNyEHz2cC1Zk-6jD20v2_-mm=edEH3gr26Zhw@mail.gmail.com>
Subject: Re: [PATCH v2] smbios: Add an explicit bounds check for Type 9 length
To: raymondmaoca@gmail.com
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@riscstar.com>, 
 Tom Rini <trini@konsulko.com>, Samuel Holland <samuel.holland@sifive.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On 2026-04-22T19:38:45, Raymond Mao <raymondmaoca@gmail.com> wrote:
> smbios: Add an explicit bounds check for Type 9 length
>
> Fix Coverity Scan defect on Type 9 length.
> Type 9 formatted length is built dynamically from peer_grouping_count.
> Although peer_grouping_count is a byte, the resulting formatted area
> still must fit in the SMBIOS header length field (u8).
> Add an explicit bounds check before extending len, so the size used by
> map_sysmem() and memset() is guaranteed to be valid and consistent
> with hdr.length.
>
> Fixes: a8442c226635 ("smbios: add support for dynamic generation of Type 9 system slot tables")
> Addresses-Coverity-ID: CID 645487: Insecure data handling (TAINTED_SCALAR)
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
>
> lib/smbios.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
