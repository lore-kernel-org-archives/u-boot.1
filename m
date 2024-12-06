Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32139E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A55CF8937D;
	Fri,  6 Dec 2024 16:22:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cmpEevyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D41F8959D; Fri,  6 Dec 2024 16:22:02 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F268932B
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  6 Dec 2024 16:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-724d23df764so2194368b3a.1
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 06 Dec 2024 07:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733498518; x=1734103318; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QWX9qVxJIex9KmXnEjR/fx+LU8npYj2ZTwl8CMrqU4I=;
 b=cmpEevyWyHPim3Zyo9YGV7Kliy6I0qbu4B6xhCk3kG47KdXTmnkp54MJK/xvCjw6Kf
 VRxBxU5bqDtg7xDFoFut85ou2/OIr/kmz/0xsuc2QivnKhOnlnr+CbKb3I6UaybAIEj6
 tnLxZXEDtW97jMD2IYfRL7rOTzbrjs7oBXdIJCm5EgbPEBQb70SGVX7oNUMf/eykDb2x
 8o9xq9zQPj6uiG7q893es3+ft8yaQhPcMgrKkBW7uqwL1rP3+A60cbCZj34kRLwaDaNv
 QWv/1dDvBvmZ2Qaf8V3vMwXQEcH+LJn4KTccF45ew0sm/xkb+aRtuSiV1P98GGDAg+nV
 MbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733498518; x=1734103318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QWX9qVxJIex9KmXnEjR/fx+LU8npYj2ZTwl8CMrqU4I=;
 b=TkJMvUG3sYPHYLrdS+BUJUOwy9f7jIDTS3lV6dx2i15BDRlLo8dhtkaMdrnku3BZIk
 J4d/oOTMVhsgPiV9XZfVzCWGCJ6iTRkKfMKv/gclO4UsfHQtjNHGhGt+ors5IL6L4ybG
 aRYbuPa5RYkXHlfIEmvlyUqX/dAmVq2Vaq/KTWvi+HDsXBqI/Tp/l08H8mfEjyTIuE8v
 X8xlZ4eosY0NwiYHlCkP13Yr5/QzhCAJlJROPtuqDlMa4s1t01Frs4yD5PuQLXPtD5cc
 uQkg3QAl0zndDTTujEUXAsIjMUbDlQta0wzY6ivdPlUWsgVN6/jLs/95/aC0KHutGtkr
 Ltjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAHsMjoMoZWOgIpzrF0QaSpmCjA/2TquLFxoEG+pVDWshcENeNmww2TOmxLWH1PstUf/F+DB0=@lists.denx.de
X-Gm-Message-State: AOJu0YzJBPDd/Z9LRpj07/Eyj3+jRgStGxJx44+PGz+4S1RqNVIaWXX6
 ynvhl976Q3+0UcXW+CY0Af5VFs1ik/JIPaqpMNI0gN1m1LWxR4W9KtmQnF4UW6U7CTDQ2ISw/JC
 RCLtJg6o8JmLYSY5TsBlFdrW+NrVatu7KXEubwg==
X-Gm-Gg: ASbGnctrwMqvEUo/gI/QEGNOW9saT7FrTGnuZxEwiDHkwdS1jom0xU2rxfYCNWqTrrY
 /P7G96U83S/7Hqgv9aRrGHqduosNln+mxYcjDc6+wMELbduikZwiClH49/BODT01i
X-Google-Smtp-Source: AGHT+IHe7nE+L+/gLWVo1nzCQ4FQ2Fff/1NfSIzrS3CZ1RLGiaykyoSWADonfr0exDJuY5wikhwhcusG0OSvFAqc4NM=
X-Received: by 2002:a05:6a00:4613:b0:725:a39e:ae1f with SMTP id
 d2e1a72fcca58-725b813e1d6mr5070323b3a.12.1733498518482; Fri, 06 Dec 2024
 07:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
 <20241204175437.185449-3-philippe.reynes@softathome.com>
 <CAEfUkU+peqy0T9mhA++xhrm+6x-_pogkLr_DE2C-yb6QiZkRUw@mail.gmail.com>
 <e0a7bcbd-7804-4d50-8d04-95f60cee99f7@softathome.com>
In-Reply-To: <e0a7bcbd-7804-4d50-8d04-95f60cee99f7@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 6 Dec 2024 10:21:44 -0500
Message-ID: <CAEfUkULHtHFQ1d+6RsRRPB1U_aP44pMsQfBpt765m8Tae06FPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] lib: sha256: add feature sha256_hmac
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

On Fri, 6 Dec 2024 at 08:11, Philippe REYNES <philippe.reynes@softathome.co=
m>
wrote:

> Hi Raymond,
> Le 05/12/2024 =C3=A0 18:11, Raymond Mao a =C3=A9crit :
>
>
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click links
> or open attachments unless you recognize the sender and know the content =
is
> safe.
> Hi Philippe,
>
> On Wed, 4 Dec 2024 at 12:54, Philippe Reynes <
> philippe.reynes@softathome.com> wrote:
>
>> Adds the support of the hmac based on sha256.
>> This implementation is based on rfc2104.
>>
>> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>> ---
>>  include/u-boot/sha256.h |  4 ++++
>>  lib/mbedtls/sha256.c    | 38 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>> index b58d5b58d39..77dbcd4553a 100644
>> --- a/include/u-boot/sha256.h
>> +++ b/include/u-boot/sha256.h
>> @@ -44,4 +44,8 @@ void sha256_finish(sha256_context * ctx, uint8_t
>> digest[SHA256_SUM_LEN]);
>>  void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>>                 unsigned char *output, unsigned int chunk_sz);
>>
>> +void sha256_hmac(const unsigned char *key, int keylen,
>> +                const unsigned char *input, unsigned int ilen,
>> +                unsigned char *output);
>> +
>>
> Shall we have an inline function for the case if mbedtls is not enabled?
>
>
> you're right, I should manage the case where mbedtls is not enabled.
> But with you're feedback below, the function hmac is always defined (with
> or without mbedtls).
>
>
>
>
>>  #endif /* _SHA256_H */
>> diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
>> index 24aa58fa674..1b9fc1a8503 100644
>> --- a/lib/mbedtls/sha256.c
>> +++ b/lib/mbedtls/sha256.c
>> @@ -8,6 +8,7 @@
>>  #ifndef USE_HOSTCC
>>  #include <cyclic.h>
>>  #endif /* USE_HOSTCC */
>> +#include <string.h>
>>  #include <u-boot/sha256.h>
>>
>>  const u8 sha256_der_prefix[SHA256_DER_LEN] =3D {
>> @@ -60,3 +61,40 @@ void sha256_csum_wd(const unsigned char *input,
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
>> +       unsigned char k_ipad[64];
>> +       unsigned char k_opad[64];
>> +       unsigned char tmpbuf[32];
>> +
>> +       memset(k_ipad, 0x36, 64);
>> +       memset(k_opad, 0x5C, 64);
>> +
>> +       for (i =3D 0; i < keylen; i++) {
>> +               if (i >=3D 64)
>> +                       break;
>> +
>> +               k_ipad[i] ^=3D key[i];
>> +               k_opad[i] ^=3D key[i];
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
>> +       memset(&ctx, 0, sizeof(sha256_context));
>> +}
>>
>
> This function seems to be generic and should be located in lib instead of
> lib/mbedtls.
>
>
> I have looked the function sha256_csum_wd and I have seen that this
> function
> is defined twice, in the file lib/sha256.c and in lib/mbedtls/sha256.c. I
> have done
> the same to have the support of sha256_hmac with or without mbedtls.
> But I think that we should avoid to duplicate code, and we should clean i=
t.
>

Yes, common functions like sha256_csum_wd and sha256_hmac should be
moved to a new file (e.g. sha256_common.c?) that can be used both enabling/
disabling mbedtls.

Regards,
Raymond
