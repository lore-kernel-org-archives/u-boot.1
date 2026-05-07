Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A2FCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FE684A4F;
	Thu,  7 May 2026 18:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MSM1Ia9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF4784B02; Thu,  7 May 2026 18:39:46 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04DF184A4D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so1702571a12.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 09:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778171984; cv=none;
 d=google.com; s=arc-20240605;
 b=SwyOzsEBVUvNuCtt5W2/8s2bR8JAIETjDINTMpt2gDj6cwc/p5OOVGWclbj8AIYPSC
 nfBSsoWNX3FmNzqB1uda7LLXuGpkA6yEqT9k7jByggVhDbCqBG/meBaapjxnHKo1+3Ko
 bCbakFO576VqQKktmpysBSeExEtOXx5uEZl8ICZGeF5hGgk+rrSBiva8hgsATvICYf0t
 x3h9IHg6rHsOwyrr3v/Ouzrxgfu0hkhtAHeYN7gHPNrhq/YcB1kPfXWVHENfYLqTbg0a
 tJEoLuLkGdd0+sbamexFLOvzmD3G5r/WIlNk2f8BdpCM7FffdmJMeFfJsWDR5nP8uqbz
 +woQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=t5PKjOmp9K2p1STBMVXPZ1lsnMprWf2ICkw7Z+rjtwg=;
 fh=PKLU0xSNpsrGOfl0gQ17G1VaKViMSq+Ysfr2F1w3zVg=;
 b=LEZOyR1BEAi836bp1Iujs3ghXPXK6jVqZB+lr4LUV/VbH/d17Oyt95kkMxYyFB8I6J
 KSFMz4EQOjsbR0U1xc/tSWgu86riw+UgyAQr/er0SvWRR7ARU2rvevxjuYbMLrbdpK3o
 1QdeEV4uBXMG5FRZQauM7b5xp4IJ+aDHICl88g5EqG3hWRwXiULORwHBi1qfZBR7KN/j
 QaIqOFlPhpyKbwbB+KsZMLVKJQ6UULWF5heMd2Cfm+ritCYYPPL/i1maVR2JTSj6dD5G
 Ua/2E3031sx0baX6VYZL0b6nSQ+zqmL7puxowwOlNywPs+3bYju0BI2oIB7fs1/bK6Uq
 YCrw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778171984; x=1778776784; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t5PKjOmp9K2p1STBMVXPZ1lsnMprWf2ICkw7Z+rjtwg=;
 b=MSM1Ia9f77/4bN1yQFmnPH9D+wwkenav8+LdxDdt8jY7MR5UlNI0CKmnvuyVTGMeL+
 Gs2OADjMq7MvnQovK/zy9SI3g5WD+USGXBd7PioY+MkFVbtHeYAR2WGKeR043xw8Fb04
 eOkc3emp7ZvPbPcgTWjpbujvAJTy2Gf0g+uu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778171984; x=1778776784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5PKjOmp9K2p1STBMVXPZ1lsnMprWf2ICkw7Z+rjtwg=;
 b=ZI9PihjvDXAMEWvj7Mz96A06jlUG9iS/JeZMcEepeMOeiKBvHB2IsXXwlv3hGdVd7q
 VGZ2LVc3Tq4anCRNxzMdWqoZ7NPtSHdzvb23T3nqU1wtVQbZ/4ZSMDSWqk4G+YyNg11V
 GQ7PaVoL6OHVQMfqpjoYJmxnpcCjL+AjyWoFQQsCu4Ubh2NhK57DchsX+DQ8NoLyAb5V
 FWovGP1C2UHIbKpqukbX9zeiPMSRZ8qzo9LxmfCR1KBi5gkG6kWPeVbkOA+lxvAz8ehk
 BjhxSjGYupXdKZBzzVVPHtys4/RGnZSLVldOIFpkSXxXiCyEcNoIJhBDgnCsfF8jMbi5
 45Tg==
X-Gm-Message-State: AOJu0YzEJWGJk+w1OhhQV3jAbOile6xFziCvJ2q3YSa8Iv9QYDWN3oGV
 YHnPNz7ljKzGuQyptpWCu9gy0b8nWkv/TUh8EXLBK+q5F3xWy3KJjBZqaK7LqaXWWlL746u8QMD
 X1nHcKKYDAVdaB/Meqri0I9Gq3J1G+2gePP+FWKV60GwqYpqp5aw=
X-Gm-Gg: AeBDiet13YGuuBeoGfPwBgQNELfhK7B424GObt1OLPtcmG7nosrQ+bP6i+gxVKE/qbW
 PqZpTgd+/IAfS+2yTuNLT1uD/zANDvnWY8WvOgNxYsVjc8dvxSDa/zBX9kbgjkPQ9n78/0i4qun
 W+lR8THmZ3JFSMqYoIwVvTAPNLnsK8K3TBDvLM9Yn636c9r1Xs5e6Q7+YOOYJNBg4OndEGHVEm+
 q7EfOolWPHGJYb7kO7K3vqSGv1mt9ACXIYh2v0weTpre2/F0F/IFInreAkHxgYL4Hu3LFCzNQp4
 EbdL9w==
X-Received: by 2002:a17:907:c9a1:b0:bc5:ac7e:25b7 with SMTP id
 a640c23a62f3a-bc5ac7e3229mr345427266b.28.1778171984109; Thu, 07 May 2026
 09:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
In-Reply-To: <20260507120735.310325-1-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 10:39:32 -0600
X-Gm-Features: AVHnY4ItoJre4IWfxDi9_fbaLYACM7PfQdwHj1477xvXsB0wRKQSXIt_U1g2yZ4
Message-ID: <CAFLszTjc1w3WTmXLbgQifH8ZBUyN-sF-NQ-bvYq45tqWscVuZw@mail.gmail.com>
Subject: Re: [v3,0/4] Improve FIT signature handling
To: ludwig.nussel@siemens.com
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

Hi Ludwig,

On 2026-05-07T12:06:22, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:

> (optionally) enforce signatures so we can't accidentally boot
> unsigned fit images.

Since you are adding a new policy knob (FIT_SIGNATURE_REQUIRED) and a
new verifier path (fit_all_configurations_verify()), please can you
add coverage in test/py/tests/test_vboot.py for both the
required-but-no-keys case and the iminfo signature path? Without tests
it is easy for a future change to silently regress the fail-closed
behaviour.

Regards,
Simon
