Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32824C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 12:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91E0560606;
	Tue, 25 Aug 2026 12:52:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JXxDWK2XfTLh; Tue, 25 Aug 2026 12:52:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787662372;
	bh=vCkEJmrIZD479Yhd5mt0DONZBN7fby0DhdtqaulWzFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iNClmNcwjeS6jm7HvlH3VeBhpsii2xziafSbpTEwNoB7daPOvtu5D91aiHmUKCEsE
	 4HfIvHzNHAu1tCmvquGYVPnIZnS1n6mjTv0Lquap3CO0TiU126t39kGGeCt5leCVEp
	 cn5J0XyLRO56VCgabisM8ymUS+048ypV4cC275Io4Xb13gNKH6ucXDZkJ/ezKkXe7i
	 JPBNxOxDvzbTiB3ENFob155nQdNsEkrjj+S6mNZ1aN8IarWeCjIVEtaaP0qe//vS5u
	 YQJN4BJMyOw5FigKM09ucedSO1//7w8kaUmGGpohTTZBXK0KUxhf3MXbifJFqVPNyD
	 BdNd8kH6b1X8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C2DF6067D;
	Tue, 25 Aug 2026 12:52:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4BA63DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 972AD80C6F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:52:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sNK0agZiGPYx for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 12:52:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=WgYjZ/dm
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4C598082A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:52:50 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so155350566b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787662368; cv=none;
 d=google.com; s=arc-20260327;
 b=jtRf6AiQYrqNciBNhqs1qJxGVYkaLXvtjG7TzlBYf6QPwckSA/iycfxYSdnNo79zHy
 WUIfYku7wpzzgcyilrwV2x2r7oiq2iawfKEVEKvNx1wE+Y2O++HcCN4y8uVbp3Ioe2hc
 r7BfMT36SQzrhdi5SwXfxYLDck8DVnJbLjPZ8eDfVvSk6Cup+EefAy4qCqju8YfgTvsF
 45bv4JHrnt/ywjHM2hVnY4fvukW93eyOx3hmHXAu8/x6SpCviCTMu4kiD8Vytyqcgp7j
 gJqVDtVjWa26T0ZRMKEVUIra4l0MCq6UuUcZ7WkHoqf1BzCsTqER9GYx1UqBGY5wzf/T
 KTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vCkEJmrIZD479Yhd5mt0DONZBN7fby0DhdtqaulWzFI=;
 fh=XzCxGnlMyhrCeKMYiADjLi/2k0me15Xc3uVw3N77990=;
 b=gVCcmnfG8JyzoKQ0dfNm3qA7IGeHYWdNrfn9aJzIO5FoSgKVtKoJMVs3efxikK5CW6
 t4dF/hDi3uXGa7hRMd9DW9Mvw5sj7sVcUoDYVujKyCasmqU50rRWzcQAqpJVM3gKqYT6
 R0P6n8AWLjCRytJbVNIjctnR4cD8p04pZ8+yfmfqx+I6akI3yuqQ+sfMfIWEbdkBIfVJ
 3PxwwCAc8VDzhFUmuDRhf52kcw57XrQAmtUywdpVgDMXUjyUdftoMGWu2tVbpKjHX9Z5
 iVMXt7CA+9wVtMfNd4orhjeH/UUi8dP/NFUENq3aZE+y9dmIBog8Qd0pwGr6dIdqhNbT
 UskQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787662368; x=1788267168;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vCkEJmrIZD479Yhd5mt0DONZBN7fby0DhdtqaulWzFI=;
 b=WgYjZ/dmtCBWiJcPFfl7uZqYBESnHROQ0p+awn9TY11i7ne+lwEJlYb8qH8Ckz57Q5
 NyeezdD6LlPYyIKvIU8FoY9ldB9K0zF1XedX2NYFIPfUT1ArpGCY4+DooO39yi3M2ctE
 hupoGT78a8IYxANw4BlMqI3ucPvL4Bo8dSvA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787662368; x=1788267168;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vCkEJmrIZD479Yhd5mt0DONZBN7fby0DhdtqaulWzFI=;
 b=Bsi2cTMBClSftHPsLszOdTB50bEV5jIE680YP69TDkB/7IlybaBbESTctIPJkKPaDG
 DPv+FIpD2xe3fzxjVh4XfCAy0UQA2CCEjS63Zsq+jlI3UmukPRTf9ePURD+nOEJG2T75
 n2o+1pI5aCN8g4XKMG4R3zzjKnN5ifGn9SR1HBC/t/U8zq9+lp1sFqB57eUcOePiubG6
 TpO+zq0D2ryx/pJzYceMfh2ThI4sJt8r+nYeELAU2jpvjq9AIfDRMfoc5zkosZ8JwyjG
 NVn4IUFF4NnzE7faDde9PPA67oHgV3Ak2148m6co077YnyBuVU9SWeGC5oLIx413iGpq
 WN9Q==
X-Gm-Message-State: AFuF++mtWvoU9SpV+bz2ZLqFwsgTgwcVUYKGTFzXqLyIY8OSwNQkQZ7/
 4z1ganICGbAn+yIrHlEA42nn3WWeqpMrjlE4ATDM6cS6La9/1Tfo5patJ2pQd4YJ0AD6MxWO+Sk
 7e0TKF5RVZGZyRFPCzl6Hh4E1Ltsx4fYHiZ9gdTsR
X-Gm-Gg: AR+sD10J8PjF+gMXL0Er5s0zrM46CxnxY6pV1y5BUxcHpzj5DSGnaTFYS4R7SlkDmc5
 A1tGeCalFT31QFvTYZDzP45qjsV+mdy/BwrVND1BTzmqLwFvDgPnX9DjomYGrFABxjjZSUIL5Fh
 J8wrJmQ7euadWpz2YHEMThfHEKyBaS96V58ehK2OHHMMcEp+L37EU7wNdXLI2I+g2aFMnIQH6yp
 L25ivxF8DEmi1V5se2Q8BXSCacrjWjaaRFX/L1KGaRDgo42jcvpmPGFW3glkVk85VLj0YdD9hcp
 ikNSy2P3OVun3WQ2A3jtRD2GOAFdGj7YdYFhXnY8xD1TtrEV85fgkw==
X-Received: by 2002:a17:907:c8c5:b0:c12:3cbf:9f6d with SMTP id
 a640c23a62f3a-c24e2b10f38mr777183966b.1.1787662368364; Tue, 25 Aug 2026
 05:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
 <20260815220754.11724-3-pranavkasthuri@gmail.com>
In-Reply-To: <20260815220754.11724-3-pranavkasthuri@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 06:52:35 -0600
X-Gm-Features: AcwNN1XkZr2tfRZnWqHrfjGWbivntjioikZPwjtMQo0pocxeCHAVVhGdvHsgPTY
Message-ID: <CAFLszTiMeD8_6-oW_EkJm=RLECACnc2BNcJAAOL07g+swfgRVw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] image-fit: check the length of the
 data-size-unciphered property
To: pranavkasthuri@gmail.com
Cc: u-boot@lists.u-boot-project.org, philippe.reynes@softathome.com, 
 trini@konsulko.com
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

Hi Pranav,

On 2026-08-15T22:07:52, Pranav Rajendran <pranavkasthuri@gmail.com> wrote:
> image-fit: check the length of the data-size-unciphered property
>
> fit_image_get_data_size_unciphered() passes NULL as fdt_getprop()'s
> length argument, so it accepts a 'data-size-unciphered' property of any
> size and then dereferences the first four bytes of it. A property
> shorter than that is read past its end, and the bytes that follow it in
> the FIT are returned to the caller as the unciphered size.
>
> Ask for the length and require it to be exactly one fdt32_t, as the
> binding describes.
>
> Fixes: 4df3578119b0 ("u-boot: fit: add support to decrypt fit with aes")
> Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
>
> boot/image-fit.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1040,11 +1040,15 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
>                                      size_t *data_size)
>  {
>       const fdt32_t *val;
> +     int len;
>
> -     val = fdt_getprop(fit, noffset, "data-size-unciphered", NULL);
> +     val = fdt_getprop(fit, noffset, "data-size-unciphered", &len);
>       if (!val)
>               return -ENOENT;
>
> +     if (len != sizeof(*val))
> +             return -EINVAL;
> +
>       *data_size = (size_t)fdt32_to_cpu(*val);

Please add -EINVAL to the kernel-doc block above so the contract
matches the code. Otherwise this looks right.

With that:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
