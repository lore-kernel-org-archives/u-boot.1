Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F447E7BD81
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 09:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E325280FA1;
	Mon, 16 Feb 2026 10:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j/GZpQjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F100583AA9; Mon, 16 Feb 2026 10:53:03 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A2C80325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 10:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c31ca77b4so840664d50.2
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 01:53:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771235579; cv=none;
 d=google.com; s=arc-20240605;
 b=YJ7rMraJoMbby146NWIFoSOpVCTrv/4PItx54PH5C2Lp4mn5JR/jTs0jj2Zm7YUSIz
 A9BEtLKzWPMVD2OkjUVFRW2CphhAwuenrdIM/xnIiwRpAu92MpCL1xfhMy4nHTVxDuTJ
 1YniuGvyB4uQ5//eATUdsKUy1puS5zo9hGbbOoqykh1v5PPClF/Kukba8BEf0vLPpHIb
 QtyzfHfYEchxHF1EnEKN/C8ygrj82WVEk55vyi7ChNNExMNof3k72uMlMgey3ry67svy
 D16xRzQzIyV3+bI7z5sW+MTyyKS9OH3OvAiIcGCLF/pwjB0BS/YpIUcpb9yZrXeb2fAl
 8VnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HY7lsKROVb1ZVC3Ap3l///mS8woFkhnWCygTzGk0c1o=;
 fh=27G0cErZ2ILu3KeDOyPGNzLDREuCiEn1wry2sKMpTsE=;
 b=juj4gFppxqhEVeh+2rw1hB8psUpAMGBwMeXOL/j9aeiYkQPy84hwpMf6003QsmnNeI
 PXSL55pLYAye3s0t1OWoUdaCyWeTfMDqTQVpHWqoOSmBeuoeizKCo9HcS+fwRXuFIr8E
 apW9i+lcfbD2Ugn2Z2sniW6M1xuIoSKRXrsOYeYAy3m3z+OIa6JOS9HFphCkJI99RrQx
 zIWHEDXrPii9VYRuu5b/h/KskctyJz9JfYYrevQjGx6TouES/Q/UG1sBfabnr4T9IlvM
 C6gISmH1HZNewo5igs4FcXHtu2a/8Ed845zhwsoL0jc8J22osnTxY7hMA7TGqqRfupyx
 yxHg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771235579; x=1771840379; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HY7lsKROVb1ZVC3Ap3l///mS8woFkhnWCygTzGk0c1o=;
 b=j/GZpQjBRQqbTDNetJGz2IHTAlRzfVpFXhJuXWfOvO+1akhyJLUUNO0IVNmmR+81ER
 QIqHMaMOA60vZ/RJS3red11iXJbTJXq7kUxtqAIP9lqgL9+R55aWAo/XLpqtGk2p5ya0
 BrRVXiFjZKvigqJXlY62RDcMMJXBr2upNYzLru5JUaSkCRV4So7gDDp6bwm7/hmjIV3F
 cjuX0z8Yf7UdHVnGdYzAJExiFfiuRHjY7SKNm5+29MfW8nBkEpguAsJiRmL495VOS+5j
 EOiZ9DBxSBDzRBPiiJzJ3og7WhavL6YUMONkje6aQJa2s/Fdh5CTXTvZk7xRhV5Fx73R
 ihsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771235579; x=1771840379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HY7lsKROVb1ZVC3Ap3l///mS8woFkhnWCygTzGk0c1o=;
 b=FDQm49uIQHY4EM6cYChdkzPJ1Xbs5G5a+R6N34bDGW0TFzvyWF9gtBDjUm+3f+cN64
 I94+naVYtkRJTl0kiGCkRdYaymUTo/Ou+Xb41FnGnJOKCPuBxVzhRqpDQ5qYuz42wdmv
 AJ6nl6jK+duBtmRkA81HXKeN0T4deMu2kewoVIAZTO5JJ1N3s2MteMCORRUKfRY5YqfK
 lbqdDHQatvGo2XPliUSGA4AzMGXKfzGRC686BpD1P2RtxjETADUTUb8vT1GKZJpHl6Yr
 FHf1pn3AvF1Mp6hVsIWok/zPEcGbYp4xIdRWdlPxTIdcb4MirqRoriw2e9K2Hb5vYC/U
 S+3Q==
X-Gm-Message-State: AOJu0YwpT9hi30O9MffEJFbYwC+/rYwHIWuwir4Kh6Df0mCtnTLjvSAL
 Omfk+JllLd9ZxbMS4A7oASMZDjRORkXU1U0iKACQAA0FzzC2Tm/Pd4nKEFGMhxQ7xiLmXG0KalN
 IxD9ZlB/Wv26wgxyMzIL++qIKcGhXothVskNTuEzZ4A==
X-Gm-Gg: AZuq6aICcwN0IhA3GX7iaF2Ve8YEWhxsVzPx653fSfM4VP7LOMdpErAeL1+oUdZGj/N
 WP9DteNnr2w2k428rC8b0smaxQ2BThRyt+LxcmorQgLPe66F7aviXE4vaJfwmMrqLHXFMY1H2pH
 GQjJ5Din7avyZueE8YkBZc7b5wYK8vBrkwTKQGlsGXH01emySlX2cyqOMOMfwql0uyMwq/9f8pM
 YMkkbFmq2bvhi5Ckh4Mt8Rh60UNnsoOuqMWKFPNw4z8yZoc9Ux4p8Qt7RljTvmwaXjG0vtn30tJ
 d6DkEjBkvk6EwwSuujyE0fplP963NwuICsNeBpQq3M476fvhf4m4f6IGeYDG9DvQAwfpT8nOMxK
 tRioFVz9ITbquPR/HJYgycqNySihA+bUmMUAa1tIrcTkQl57FLVfUlgEassoDMysvaM0Q1lxA7a
 d23Pf2d5B0w9nOKHxzwtTxWRQSbt0tx+PNThhBR5Oq1KnBylW5EebJNglHOuHFgCSP4cKJLHBI3
 LMWc0H9jgGh0ATGrB7+WFyhAd3K/BY1+QGkLXz4Qwak9u8nkMTdTVKN0YTEzSnqTZXdsWG0HJZX
 MQHPv6nCUTglVOiI5a5OV8ByuoLozXKRwRuWGN3uO7Iy
X-Received: by 2002:a05:690e:118e:b0:64a:d4aa:4a1a with SMTP id
 956f58d0204a3-64c21b5c434mr6036596d50.66.1771235579372; Mon, 16 Feb 2026
 01:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
 <20260128080515.1275941-2-Wojciech.Dubowik@mt.com>
 <DGDUN3ZI09SP.36P8F54DEPVUQ@linaro.org> <aZLc7zC5PJyyXkxv@mt.com>
In-Reply-To: <aZLc7zC5PJyyXkxv@mt.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Feb 2026 11:52:22 +0200
X-Gm-Features: AZwV_Qg2OT1nq56-BVoR7wspbzcBr1UXBUDHqNnnxG_uUhacNpzQcL-nXy6eRDw
Message-ID: <CAC_iWjLFSg=CkDO85bMRYFHfLUYr96Q74ruFDGO1A_ymurSG9w@mail.gmail.com>
Subject: Re: EXTERNAL - [PATCH v5 1/6] tools: mkeficapsule: Add support for
 pkcs11
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, quentin.schulz@cherry.de
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

Hi Wojciech

[...]

> >
> > Can we do strlen() instead of 7 ?
>
> Will do in the next iteration.

Thanks

> >
> > > +           pkcs11_cert = true;
> > >
> > > -   ret = read_bin_file(ctx->key_file, &key.data, &file_size);
> > > -   if (ret < 0)
> > > -           return -1;
> > > -   if (file_size > UINT_MAX)
> > > -           return -1;
> > > -   key.size = file_size;
> > > +   if (!strncmp(ctx->key_file, "pkcs11:", 7))
> >
> > Same
> >
> > > +           pkcs11_key = true;
> > > +
> > > +   if (pkcs11_cert || pkcs11_key) {
> >
> > Don't you need both the cert & key to sign the capsule?
> > I'd simplify the logic here. Instead of having both a pkcs_key and a pkcs_cert,
> > replace the variables with is_pcks and have that set to true if both the key
> > and cert have been found.
> This is what I have done in the first iteration. Later I have learned that there
> is a need for mixed pkcs11/local file usage. The HSM devices are very expensive
> (at least some of them) and have limited memory. It's quite common to use private
> key from HSM over pkcs11 protocol and all the public stuff locally.
>
> The test is implemented so at the moment.

Yea that was one of the things I was thinking to justify why it's
implemented like that.
Since that's a requirement the code is fine as is.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Regards,
> Wojtek
> >
> > Then the if/else cases later will become a bit easier to read since you'll have
> > to load the private key & crt on a single if/else cases depending on is_pkcs.
> >
> > > +           lib = getenv("PKCS11_MODULE_PATH");
> > > +           if (!lib) {
> >
> > [...]
> >
> > Thanks
> > /Ilias
