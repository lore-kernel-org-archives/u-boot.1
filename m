Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9F2E77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D65980141;
	Mon, 16 Dec 2024 16:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ws9opQl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE822801BE; Mon, 16 Dec 2024 16:02:04 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1B180104
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 16 Dec 2024 16:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7fbd9be84bdso3922519a12.1
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 16 Dec 2024 07:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734361320; x=1734966120; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VIfNKn15psGAhvhv7t+1cSP4tMs3TIrtM8qX4wVEW/0=;
 b=Ws9opQl5p02wVDZzt3D3aKgRTGJAfHkF1YBEAJvlynRkwJfDrbUlBvuppVpQWBTB6H
 o8gz1p1b4ImL70V7V5t6A7ZPRpDr5tFXlrYkuyDGtoSZHxVs4hLdpe0sIXUEqPTZMfyD
 ruutodFkYzpa4oNWVX4/6/22bonCPfsWBNXa4gVp/6AT/KrRzgOQzAKqyNN6mmZICNeZ
 yhzmatkgXYbJ/JSszI8PxZ4uqwl6nhFRxsBOVhanbNKpg0vvXufADnpWWy5XBsVDn5LM
 I0kvVgeZfA+bskdF7tqG6AeyUsw5AQ4ZzCLOV+zwLgGTbShh4BpqJ4F8L0JPdg85MgXF
 HrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734361320; x=1734966120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VIfNKn15psGAhvhv7t+1cSP4tMs3TIrtM8qX4wVEW/0=;
 b=dAxFcQP3xYE2+HV8H8jemrCF7VkxhnocfNd49JWO7boksED2qKyErLOCW7f/Ti1+4o
 FU0C3n8B640BpVlry2ORwL6x5yYFltqgccy6sAnd/wt2ko+8jUj3T3gJ7a4uDUAq1lxr
 eOPMgZQLluLqn0V6LcZQAR3Xf+wc/+wyI+F9OANa7VjrsPIkER/LX4fhKTbK24zVa2PP
 UNbMwgzBVU1+AbbRStmu11k7Qu/j5aqyDAWb/PENnhOd25iO8RYPEkPH5HJ+EQulilxB
 ZalQhWS1xK/LuzgOUxG/QFf/AxCxMKmnH8qviVmkARmlr2IkOZLWstU0LDSGYxzsyzSN
 A8/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDRLWYtA7s+jewNmgC4Qjn6L/nuMH5ijab3xeaHQptC1ihjDGA1wBUFxJ63rt3E4BaGlwDSMY=@lists.denx.de
X-Gm-Message-State: AOJu0YwaBMfdo9EqG6SxZTm9T4FJJkir4wvTUseJ89gOpA+ExgSpAAHw
 hJcGQ5OBVbYlMhO/RWJHnq4FOG8L8bsMBaAIXh2tADyecv1pss/SqEkVTifEuJpEZ01MnUOMuha
 LwGJC5MXCzxMGIQXCO2wWoAxpTx4ldluDeSyAouMI7Te1WUTJJR8=
X-Gm-Gg: ASbGncu5qdN6idpzdFLPD8Aj+GPfE2xNUvOgsvk8FBJ1dDZaN/eN4Bdx49u89OAHhP+
 Bb/ERA8hYF8QmvWmPoqvbr3qkutyxY/3MLe0tFlzIL80KDo4xVlkqYi75a9ZiJeivrctCT2U=
X-Google-Smtp-Source: AGHT+IGZbvkRKhMB1BFFMrVZNo9d9zSczkg+AjKT7IqIRO6d13ImXPdDaBNEb/mDS8wMDn404zI5ndKLcEMrCvHnVco=
X-Received: by 2002:a17:90a:d450:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-2f2901b3661mr19542971a91.33.1734361320521; Mon, 16 Dec 2024
 07:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-6-philippe.reynes@softathome.com>
 <CAEfUkUKiV1dy4iOjmo_46Wg=Dg0Pt93XYJJNB4UFD-08__zxbA@mail.gmail.com>
 <255d5a83-f8b9-4d13-9b76-efb6b8dc18de@softathome.com>
In-Reply-To: <255d5a83-f8b9-4d13-9b76-efb6b8dc18de@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 16 Dec 2024 10:01:46 -0500
Message-ID: <CAEfUkU+uegW97fCaOAypasDmS_5g+gvwnT6f2c-zEpenn9SSwQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] lib: sha256: add feature sha256_hmac
To: Philippe REYNES <philippe.reynes@softathome.com>
Cc: raymond.mao+nodisclaimer@linaro.org, sjg+nodisclaimer@chromium.org, 
 u-boot+nodisclaimer@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Philippe,

On Mon, 16 Dec 2024 at 07:48, Philippe REYNES <
philippe.reynes@softathome.com> wrote:

> Hi Raymond,
>
>
> Le 13/12/2024 =C3=A0 17:49, Raymond Mao a =C3=A9crit :
>
>
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click links
> or open attachments unless you recognize the sender and know the content =
is
> safe.
> Hi Philippe,
>
> On Thu, 12 Dec 2024 at 08:37, Philippe Reynes <
> philippe.reynes@softathome.com> wrote:
>
>> Adds the support of the hmac based on sha256.
>> This implementation is based on rfc2104.
>>
>> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>> ---
>>  include/u-boot/sha256.h |  4 ++++
>>  lib/sha256_common.c     | 48 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 52 insertions(+)
>>
>> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>> index 44a9b528b48..2f12275b703 100644
>> --- a/include/u-boot/sha256.h
>> +++ b/include/u-boot/sha256.h
>> @@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t
>> digest[SHA256_SUM_LEN]);
>>  void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>>                 unsigned char *output, unsigned int chunk_sz);
>>
>> +void sha256_hmac(const unsigned char *key, int keylen,
>> +                const unsigned char *input, unsigned int ilen,
>> +                unsigned char *output);
>> +
>>  #endif /* _SHA256_H */
>> diff --git a/lib/sha256_common.c b/lib/sha256_common.c
>> index 7041abd26d9..46262ea99a2 100644
>> --- a/lib/sha256_common.c
>> +++ b/lib/sha256_common.c
>> @@ -48,3 +48,51 @@ void sha256_csum_wd(const unsigned char *input,
>> unsigned int ilen,
>>
>>         sha256_finish(&ctx, output);
>>  }
>> +
>> +void sha256_hmac(const unsigned char *key, int keylen,
>> +                const unsigned char *input, unsigned int ilen,
>> +                unsigned char *output)
>> +{
>> +       int i;
>> +       sha256_context ctx;
>> +       unsigned char keybuf[64];
>> +       unsigned char k_ipad[64];
>> +       unsigned char k_opad[64];
>> +       unsigned char tmpbuf[32];
>> +       int keybuf_len;
>> +
>> +       if (keylen > 64) {
>> +               sha256_starts(&ctx);
>> +               sha256_update(&ctx, key, keylen);
>> +               sha256_finish(&ctx, keybuf);
>> +
>> +               keybuf_len =3D 32;
>> +       } else {
>> +               memcpy(keybuf, key, keylen);
>> +               keybuf_len =3D keylen;
>> +       }
>> +
>> +       memset(k_ipad, 0x36, 64);
>> +       memset(k_opad, 0x5C, 64);
>> +
>> +       for (i =3D 0; i < keybuf_len; i++) {
>> +               k_ipad[i] ^=3D keybuf[i];
>> +               k_opad[i] ^=3D keybuf[i];
>> +       }
>> +
>> +       sha256_starts(&ctx);
>> +       sha256_update(&ctx, k_ipad, sizeof(k_ipad));
>> +       sha256_update(&ctx, input, ilen);
>> +       sha256_finish(&ctx, tmpbuf);
>> +
>> +       sha256_starts(&ctx);
>> +       sha256_update(&ctx, k_opad, sizeof(k_opad));
>> +       sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
>> +       sha256_finish(&ctx, output);
>> +
>> +       memset(k_ipad, 0, sizeof(k_ipad));
>> +       memset(k_opad, 0, sizeof(k_opad));
>> +       memset(tmpbuf, 0, sizeof(tmpbuf));
>> +       memset(keybuf, 0, sizeof(keybuf));
>> +       memset(&ctx, 0, sizeof(sha256_context));
>> +}
>> --
>> 2.25.1
>>
>> The sha256 hmac common implementation now sounds good.
> Do you have a comparison of performance with the MbedTLS high-level API
> mbedtls_md_hmac()?
> I am wondering if it is worth using this API specially when MbedTLS is
> enabled,
> since it significantly simplifies the implementation.
>
> I have done some test, and the legacy implementation is the fastest.
> To do my test, I have run 1 000 000 times the unit test for hmac.
> here the result:
> common + legacy =3D> 7 seconds
> common + mbedtls =3D> 17 seconds
> mbedtls =3D> 17 seconds
>
> I have kept common + mbedtls for the v5.
> But I may use a pure mbedtls if you prefer.
>
>
> If my understanding is correct, "common + mbedtls =3D> 17 seconds" means
mbedtls enabled and with your patch,
while "mbedtls =3D> 17 seconds" means using mbedtls_md_hmac(), right?

If this is the case, I would prefer to use mbedtls_md_hmac() since it
brings more simplicity.

Regards,
Raymond
