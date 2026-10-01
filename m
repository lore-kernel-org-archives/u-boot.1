Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14082CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 17:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58CB281258;
	Thu,  1 Oct 2026 17:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qKwlTjx5tilO; Thu,  1 Oct 2026 17:22:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B656D8118B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875323;
	b=SMZW72IJAewIHqOaw7Qs/VJoPcTN2ldo3Pf2zJrnzWo9p2RqDAPEpRE79xap/vMmJ9EK
	 W1yKfuv7FlLE/wzmTufq4TA/8B/bZF1brBsSm2As1DLYo7GNoDWxdeMDoWL7Wzwq+d4+u
	 CtgUGCinGQdFtUU+Ypd02vs41OEWNFamp8rtsDM8HdDH2tu/zGjWr7uqc8gFNhc/JNhrG
	 O6qIQfStbFk42JltOSHmKYirVCwBg4enSubNDXfsFYsRFp6XCUGs7Z3waswsnMd0/3hfQ
	 Hp5nfE6owD2rSLJNBB7oIASfUg06l/P7QuWusSFDwx1Bak54tmWdmkBG8jLDL21QHfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790875323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FLinN+kJVHrT7KPs2ZTONY6Pe4+X5LZoRZTaIAQYdDg=;
	b=Uv5r/y2MEtppKwKuz9DHC7rF5AZqtNR7atHGRKkGrYaGesu0pIoj/0ZQeHkthfaQ0Op/
	 b1h7NWdYHMqajr6XGh0ax2IggsaIPaWoQVuZNN4tFxOqJqmTxUHt1jx+9F1VZFrWcmeye
	 q/UuqGSDsx2o5IvKMvkvigWoh4Id7QM+/reI3ETPPQkoxowXan3KY+AAQtb6pYx2UMuiU
	 KOJWyXcHdEYIABqbd8k6zCBtQjD1TuEGGJyoXIdBFAX19W+/XSHq33lyuryRyKTcucPcm
	 V5RZUZGo/Utz/tqolTobPPccVaxNMvdng6qJxtEvNm+RO5zLDK/VLP9NjlSAfp3/nRQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790875323;
	bh=FLinN+kJVHrT7KPs2ZTONY6Pe4+X5LZoRZTaIAQYdDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L4HtMeFoFszCIaIN6FRX2pj5C80Ff9RrUinsq7zVb4D34FUuq8jWhSAgIfL2Uh0/G
	 2vpTOYL2GTQ53QyEkPof+uCN8AJpucwdmGudKtngCi9TEtDf76T7W5oKNQ82KqNszP
	 Lai4kHcw06kvR7X4Fs8O1BYd1fdbaWe2BDnaVX0+hMm/rfm8FaBmigq/EpnXQ8edOZ
	 7dQbDPIeMB7OURKEXiYOCCmgc2t+Sup+ufQQOqfGP3981exdpn94S9G8p541XievcE
	 AyFDPyZ2YAzaF3DvVMETeeKFJL/n8JxPS9GjN+pSPKvTM7H7tL/Lqr99435PFcrAaM
	 ZShlDovdEb1rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B656D8118B;
	Thu,  1 Oct 2026 17:22:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E665B22B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D821F60823
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEgibkzf8fTl for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 17:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CE11D607EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875321;
 b=CY384yNoRX7LaZC4LZYG9tc9nuYUB8mTb/Jo5+rTg9uuILfLqOnJyc+SQPGoQ33fUAQ9
 gM14H84mgnccplUK5/M7ml6oc8CgtNWSbFrO8TosIFHVF8zyTO8GpVcw3DIC1mmeKNUt2
 CJOvkYnseqd96shX+QZEbCgZ7YBSZKifa0gs5VWFEE+X90ThNWEBTpikHYjxfTvylPRGe
 633KTffaASbKjEU9zhSlfXhes2MQWpaOrygGY6GCtZ/L6a/CjaGzQAnPesYv/Y+je+hvx
 9a6+Ibk7yfvocutgUNcw0b2vLOwWd7xW2vm5pgdSlOvfN5jZcWt2PzN5LCamTrIXA8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790875321;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=FLinN+kJVHrT7KPs2ZTONY6Pe4+X5LZoRZTaIAQYdDg=;
 b=Sxb2/mFFy2Fanh4iNhuXNhQmJh7iPnj7Z1u4jIm8y5afr+x84+yc28ONpZYD19WECRrL
 PMt3txVPsxwY3AgWE9pgjR0z3UbVULi/5TmYeKWIymIbcR++pGKliLqKrf5VI/3RtKElw
 VUx4VIZq/OwO5imbQiajU6phRvt1vAcNVC38d649dOijuA6mxlg1Oyv7BoLUn2+8W+ggC
 O4QuT6ez2vr3Hw9WhYcBMJO4+HQqeVZSui+l1IaeOgO73zJaTIR4Pcfuoho3uP4hQFgRX
 IxIvkLzQH+9NwQxtmSOAw2wHJ3Lm7kqlxQKbszg0vORnwsV1r4vQaUTAjuBdkgMLmAw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=P95G6Lgy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::2b; helo=mail-ed2-x2b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=P95G6Lgy
Received: from mail-ed2-x2b.google.com (mail-ed2-x2b.google.com
 [IPv6:2a00:1450:4864:33::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE11D607EB
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:22:00 +0000 (UTC)
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6ae42b3e901so890744a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 10:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790875318; cv=none;
 d=google.com; s=arc-20260327;
 b=aQM4ZWkDGM0gazcM/4jZk4Gcu+RB9Ji3Z9yjUTL613N5IDTVydTz+iv+Y97e4aEIw9
 VLORmGllVM8dZMcDDcgtJyt+Iq5gKAT2cccxqD50L9vZceF7Le2iB5GlYLV0TdEF4E7E
 AtsFcylC0ZY52Fa9hS/BwARGPzx1w+Nl4a+581S142Wjo8j53xiFkL305sCmOopTNXFC
 n2IUiRdku7dIkSG+bd2bTJo5F4h6lHPadDRp5zUmCFS4Gu677l87C0jTdwYykh+zFv79
 D7vSK+zpe48ToHTToBGaa5PqE+SjVPGLM2YxTyy3FGMjoGjvIyJWEYUrEih3fs5VpCgd
 o0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FLinN+kJVHrT7KPs2ZTONY6Pe4+X5LZoRZTaIAQYdDg=;
 fh=f+3YHrvj6jGhkBhPyVUqKuV+eWYFrOfCOWHRGid3M5g=;
 b=JmNEyZm/sFkgY3/dQ9+xjMF4Jce6taNjSO0cisY9YdtoRpyObBRjUyWgatuieRBG4D
 znSsMdzwaAiXEf5IMpWsKQqrAcsWhCkufA5o8LBqOXUza4gZrPwAOZViX/CZqAu7uA2X
 8N567OFobCT015EP4u6cpJc+pKoZEKhWJA07vTe/hVDbFOBQBHhw+GtDM+Xc1y911//N
 khm0olMSeXg+/B5U6iTNyosUxln+aSSmD5XFQrNkzhd8lCml6dHjmrGGd943q2T+AopJ
 O7tfzAx82QU2BKWwfm+wBlQxO5OPOXgFC6h1gIGawtkrtbY3K3W/7K+VLhoYamNzqNsy
 nNYQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790875318; x=1791480118;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FLinN+kJVHrT7KPs2ZTONY6Pe4+X5LZoRZTaIAQYdDg=;
 b=P95G6Lgy7r16QaW0h7pW6/6BEUot+JoHGi9BTdMrItebaGvSGIlM1citjEvo8SlCV6
 jJ3MZpFJ0oF4jDkVWwk3wt5KQHCfTOlinpaRjRVPGC+iw2+Gxjzvvy3zmax/zi56rYaY
 oIj3wiy+inTHtxk/uIj+iDWYplQmXMRNlIybQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790875318; x=1791480118;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FLinN+kJVHrT7KPs2ZTONY6Pe4+X5LZoRZTaIAQYdDg=;
 b=nn4IZlXvPKSMlGlZ9mDh8VXRTSZwYsHG1BlRMWjqZoOPR0nemkPSYp3Hb9XJeM0B5o
 /byTXTPEuR65gAGnG+q5iEAHqUk7Y3nfnWErCjBM8gCEMRVRAq/VhzqeOw0gTHACdPub
 OcW2UuzCpFToNo2X22tNk/zXOoxWBx45fwM6Ao/2hJvUHdS4J3fHZmWZgXHEP++Sn0vb
 +hWOnLlXlu6enjkl8NHBp5kj5lVXWpoPpHmC6Gq2XelIVKaiFvQQ7/9HTX9zmIqgYsoJ
 VpY9E0ry6HFD4PEAc507dJ1I1qbdm3cWFLZtIsTHDId9BQ7yWLm2z2XTnX5rVuQgrLPq
 PrBQ==
X-Gm-Message-State: AFq9FYKSu5wcFj5l7nPBsdWYH5oHMI3TqW3u4SV0wIHuQd6kcDTYEulI
 IOwUreGhn6LtA29vEq4m7FpVXDiiMjIvotA7QI5FZdz9za3Ch9IqCGMnn2Po0smNRea4ipz5I9e
 lk6X9GHjlmoeU7TJc2IiSPUOVzeuNofDAmVw+HWNW
X-Gm-Gg: AYBFou3YQ1svSwXLgvA5m1hVSJKH7N/afMZFo2biScPJXxly+kiBJRfJHsReU8gY9O5
 V+AzT4nxMJH3bd533vWyQGIvxTJAjB7ljS2u4SDepy4vn0+eyiZmWxNx1PYYZG5Yd943hapgx5f
 Loh+m2WRixHaN9i2T3VfbWSplHCblgSKbJYezutsbPrHlcUuEPJ9YzBSNhE2B5BTx1PqXnluCgd
 Ob8UI1q2JTWEgzsH1hn8WQWrlMPiUphqzt9ft34j/4D8CRadSP/wVzyGi4Pej5B3q1s7tAa51DW
 2d8mMRGM3X26pjz6HQZTElBjyIGGpPBl/hTmtn1I0ya4MkrfVlCDcHl+E/+0di/RfCE=
X-Received: by 2002:a05:6402:a0d4:b0:6a6:32e3:9ba with SMTP id
 4fb4d7f45d1cf-6ae307db1a4mr2598256a12.10.1790875318510; Thu, 01 Oct 2026
 10:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
 <20260918172127.66014-3-ayoub.zaki@embetrix.com>
In-Reply-To: <20260918172127.66014-3-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 18:21:44 +0100
X-Gm-Features: AclHuK_PNmAden6PyfWo610vm7WFyAgbvpNz7Dz7-tjl4INYA8lMo4UtvOTVPiw
Message-ID: <CAFLszTiKL72qQUFWyQgFSY5LjVj3n6VZJH1UUV836aFYXi74Xg@mail.gmail.com>
Subject: Re: [PATCH 2/4] crypto: add FIPS 204 ML-DSA verification
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 mkorpershoek@kernel.org, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, pbrobinson@gmail.com, dlechner@baylibre.com, 
 hs@nabladev.com, xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Ayoub,

On 2026-09-18T17:21:23, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> crypto: add FIPS 204 ML-DSA verification
>
> Port the Linux verify-only ML-DSA implementation introduced by commit
> 64edccea594cf7cb1e2975fdf44531e3377b32db. Include the API
> documentation update from commit
> ffd42b6d0420c4be97cc28fd1bb5f4c29e286e98.
>
> Support all three FIPS 204 parameter sets with raw keys and raw
> signatures. Do not add signing, private-key handling, FIT integration
> or an external library dependency.
>
> Keep the initial public API aligned with Linux. It accepts one
> contiguous message. Defer FIT integration to a separate series.
>
> Add U-Boot argument validation for invalid parameter-set values.
> Reject a NULL message when its length is nonzero.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
> include/crypto/mldsa.h |  67 +++++
>  lib/Kconfig            |  14 +
>  lib/crypto/Makefile    |   3 +
>  lib/crypto/mldsa.c     | 679 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 763 insertions(+)

I'm reviewing this but of course it depends on the outcome of the
mbedtls discussion.

> diff --git a/lib/Kconfig b/lib/Kconfig
> @@ -634,6 +640,14 @@ config SM3
> +config MLDSA_VERIFY
> +     bool "Enable ML-DSA signature verification"
> +     select SHAKE

You asked about Kconfig placement. ML-DSA is a signature scheme, not a
hash, so it fits better in the "Security support" menu next to
lib/ecdsa/Kconfig and lib/rsa/Kconfig than under "Hashing Support",
e.g. as lib/mldsa/Kconfig or inside lib/crypto/Kconfig. Then when FIT
support arrives, it will sit alongside the other verification options
it has to interact with. What do you think?

> diff --git a/include/crypto/mldsa.h b/include/crypto/mldsa.h
> @@ -0,0 +1,67 @@
> + * Return:
> + * * 0 if the signature is valid
> + * * -EBADMSG if the signature and/or public key is malformed
> + * * -EKEYREJECTED if the signature is invalid but otherwise well-formed
> + * * -ENOMEM if out of memory so the validity of the signature is unknown
> + */

The U-Boot-specific checks in mldsa_verify() return -EINVAL, which is
missing from this list. Please can you add it?

> diff --git a/lib/crypto/mldsa.c b/lib/crypto/mldsa.c
> @@ -0,0 +1,679 @@
> +     if (alg < MLDSA44 || alg > MLDSA87)
> +             return -EINVAL;

If the enum has an unsigned underlying type, 'alg < MLDSA44' is always
false and -Wtype-limits warns about it. Checking '(unsigned int)alg >=
ARRAY_SIZE(mldsa_parameter_sets)' avoids that and stays correct if a
parameter set is added later.

> diff --git a/lib/crypto/mldsa.c b/lib/crypto/mldsa.c
> @@ -0,0 +1,679 @@
> +      * For freeing it, use kfree_sensitive() rather than kfree().  This is
> +      * mainly to comply with FIPS 204 Section 3.6.3 "Intermediate Values".
> +      * In reality it's a bit gratuitous, as this is a public key operation.
> +      */

This comment is out of date, since the port uses
memset()/barrier_data()/free(). It also contradicts the doc in patch
4. Please can you update it to describe what the code actually does?

Regards,
Simon
