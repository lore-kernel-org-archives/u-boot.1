Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2BBC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 12:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FEF587B24;
	Fri, 15 Dec 2023 13:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UEMUEOl9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F09887B99; Fri, 15 Dec 2023 13:54:53 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8368B87B24
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 13:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c339d2b88so6628115e9.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 04:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702644891; x=1703249691;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qcXvOebjJMINlMWcqeUxZXYIiesXif3h5YiqgIddf20=;
 b=UEMUEOl9dIkwnOW+av9p6QS/egFEE+sKoqYcbiEJg3LKnEfVeY6BSTA6IMMUYmJgcf
 TEbjabrOF6dGwDa+Ye+VTgV9CnqLtQwpxHOa81QW93HaqhqqJVuqKZEGqaWl+4P1EXyt
 Qpu/qSTjcGEjxbkelRwYficW40uPA+nQOQc7iyylchGlpTestfM4xKhsPsy43LB0Jhz7
 4kbUUwnYIW3DsAj9/sDgzzXLgHAZUeizY4H1RY75MO55oLirMBd3n3XwyTUh2/WG3id6
 Fjh5Xf7iLJPlZHzMwhOmkdOhGtoWIOeGDse7KuZgKWe9FooFwGpylOLscsEfMT7Mah5/
 AiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702644891; x=1703249691;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qcXvOebjJMINlMWcqeUxZXYIiesXif3h5YiqgIddf20=;
 b=Aq2HnC59mEr1OmgfQbMMvx6yu1utIHbj/64h8AmgbrXs6iXVtaJp3a4i2gq/BVGqYF
 uwOih8D1gZlGz4Cy91gDWAANfxLTkGemdTBNh5TubXjvuWn+nl15TOrKSdc0mbs2Z+BK
 CrBEmRuLv3pWKgfBUoYWt9ofFbySt8cXOy6hO47+QOiUu/iMRYWOJFlhWFtDbyIifzgx
 N8onzbOWI5LB9TJh7wfb7Ebk8kViHyVJ01lKdKgG8QK8jOwrLrPceXUKUUB2Hb0qS7is
 qvbiLEM1vLrqRCw0kJyAtikaMioKZu9k4R0D6W6pAaAVsu+xWx4j9KDsHXMXAvSiup7D
 ioqg==
X-Gm-Message-State: AOJu0Yxu3x32IgrDD0uae7u58nhe4mFArADEiDJfkPgzgXtVj0FJV8p4
 FHCstoLwgEq1cDvfroYEPgnhqw==
X-Google-Smtp-Source: AGHT+IF8/9gvDb9eDXVJWc0hPJOqIzWU75xBNAGOlR3FhUofA0wPwLHrRaoOnVwTKXs8Y74pgNwepg==
X-Received: by 2002:a05:600c:2317:b0:40b:5e94:e2db with SMTP id
 23-20020a05600c231700b0040b5e94e2dbmr5944053wmo.78.1702644890823; 
 Fri, 15 Dec 2023 04:54:50 -0800 (PST)
Received: from localhost ([89.207.171.106]) by smtp.gmail.com with ESMTPSA id
 g10-20020a05600c4eca00b0040c11fbe581sm28740280wmq.27.2023.12.15.04.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 04:54:50 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] clk: fix clk_get_rate() always return ulong
In-Reply-To: <878r5vtzjv.fsf@baylibre.com>
References: <871qcj5frz.fsf@baylibre.com> <878r5vtzjv.fsf@baylibre.com>
Date: Fri, 15 Dec 2023 13:54:47 +0100
Message-ID: <875y0ztylk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On ven., d=C3=A9c. 15, 2023 at 13:34, Mattijs Korpershoek <mkorpershoek@bay=
libre.com> wrote:

> Hi Julien,
>
> Thank you for the patch.
>
> On mar., nov. 21, 2023 at 15:42, Julien Masson <jmasson@baylibre.com> wro=
te:
>
>> When we call clk_get_rate(), we expect to get clock rate value as
>> ulong.
>> In that case we should not use log_ret() macro since it use internally
>> an int.
>
> This is quite subtle, it only happens when log_reg is enabled via
> CONFIG_LOG_ERROR_RETURN.
>
>> Otherwise we may return an invalid/truncated clock rate value.
>>
>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>
> I'm wondering if there are any other places where this happens,
> but this change looks good to me.
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Thinking a bit more about this, shouldn't we add some check for
downcasting in log.h in order to make sure this does not happen in the futu=
re?

Something like this should work:

diff --git a/include/log.h b/include/log.h
index 6e84f080ef3d..20088399617c 100644
--- a/include/log.h
+++ b/include/log.h
@@ -332,12 +332,14 @@ void __assert_fail(const char *assertion, const char =
*file, unsigned int line,
  * use 4 bytes in rodata
  */
 #define log_ret(_ret) ({ \
+       _Static_assert(sizeof(_ret) <=3D sizeof(int), "Cannot log without d=
owncasting"); \
        int __ret =3D (_ret); \
        if (__ret < 0) \
                log(LOG_CATEGORY, LOGL_ERR, "returning err=3D%d\n", __ret);=
 \
        __ret; \
        })

Downcasting just when logs are enabled can be the cause for quite some
subtle bugs so breaking the build in these cases might be a good
warning.

Any thoughts?

>
>> ---
>>  drivers/clk/clk-uclass.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
>> index 3b5e3f9c86..41dcd14be5 100644
>> --- a/drivers/clk/clk-uclass.c
>> +++ b/drivers/clk/clk-uclass.c
>> @@ -488,11 +488,7 @@ ulong clk_get_rate(struct clk *clk)
>>  	if (!ops->get_rate)
>>  		return -ENOSYS;
>>=20=20
>> -	ret =3D ops->get_rate(clk);
>> -	if (ret)
>> -		return log_ret(ret);
>> -
>> -	return 0;
>> +	return ops->get_rate(clk);
>>  }
>>=20=20
>>  struct clk *clk_get_parent(struct clk *clk)
>> --=20
>> 2.41.0
