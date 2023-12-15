Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6912AC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB43687AFD;
	Fri, 15 Dec 2023 14:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mG20VwSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0872C874FB; Fri, 15 Dec 2023 14:49:17 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE04787AFD
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3363ebb277bso429493f8f.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702648153; x=1703252953;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K01rLP9Ql3YafEyNVwCeXmqSld9DlVdioIBFR/LHwMA=;
 b=mG20VwSOsOfhKS/bJw3bVzOww8QnVVAPJ4Pf40641snoO8aAesW1N/GqjbQvA8IMkD
 Vlwg+B76ijG6BWcxgliefeteXHXc4gTDDJBsAnsLlbjL+Yhc6gPtrqYvIkH7RHE2M8wG
 bvysKfmhjzj0+9QIm6KzcJN9kmqPfBYt7XpM5CH+GpZGJ4PUPCI4Jrv4ip9FNFlyv9vD
 KrGZnE1esAu52KQ5Qcs7VvHqy5rNpgRR0r6cb/u+uklEF+ZecTtJCDSaeq5h4/hMYnL9
 l9lmUcjkD7qJNMu8kFi616XxQ/pF/S0crb/2vh39LPjIOEbIxzi1jQQ8GZ4zZCUnoGrA
 V+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702648153; x=1703252953;
 h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K01rLP9Ql3YafEyNVwCeXmqSld9DlVdioIBFR/LHwMA=;
 b=syZVKniVkpykiglJuTMfC5hbtNqDes7FlZFqsBuXFm48+6uY2p1TaoiaF8X7pA/uLQ
 MDkEGFNdTUCuU1Z7WiY6E0u9EfeLjfY6rptHE2erv5ROHwaFWvJtgxgRkpIc1i1tfNGU
 ehtX7mUCDIQGjCbWxbtSu9K8iL/KuRLtNnT94noaC6wJZAp2FhIQyThTmFGM2+W1w5kJ
 SIbCfLzd06OJ1aLJNT8neAFVt4CVPkXWaXh4Cv4afFi5ODwcPKnl+N6BimjTrV2zPKY+
 GhlLOvRJIUFzjUo543hOM2zm1kFmDJk6SFOS2Byj2g2uV6NP+S25Vi0SFiOwdOU1/rkf
 KKIw==
X-Gm-Message-State: AOJu0Yx1b00X05R2ts0dhvepJnngjJdqkcKvXTSjkWbKBJzebMMTMsNh
 eH9v9OFTPwtFEWFhmzFOasPbcg==
X-Google-Smtp-Source: AGHT+IGAOA/8oq9LjCox95PWvcJ8xlnjtEUOwbG7JvKy3vwlVkGIdp47qKKqwAjXDR/9ihG3Rgvahw==
X-Received: by 2002:a5d:6a46:0:b0:336:4b3a:cef3 with SMTP id
 t6-20020a5d6a46000000b003364b3acef3mr1049238wrw.5.1702648153293; 
 Fri, 15 Dec 2023 05:49:13 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31]) by smtp.gmail.com with ESMTPSA id
 d9-20020adfef89000000b0033342978c93sm18848417wro.30.2023.12.15.05.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 05:49:12 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] clk: fix clk_get_rate() always return ulong
In-Reply-To: <875y0ztylk.fsf@baylibre.com>
Date: Fri, 15 Dec 2023 14:49:11 +0100
Message-ID: <87plz7vanc.fsf@fedora.mail-host-address-is-not-set>
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

Hi Mattijs,

Thanks for the review.

On Fri 15 Dec 2023 at 14:38, Mattijs Korpershoek <mkorpershoek@baylibre.com=
> wrote:

> On ven., d=C3=A9c. 15, 2023 at 13:34, Mattijs Korpershoek <mkorpershoek@b=
aylibre.com> wrote:
>=20
>> Hi Julien,
>>
>> Thank you for the patch.
>>
>> On mar., nov. 21, 2023 at 15:42, Julien Masson <jmasson@baylibre.com> wr=
ote:
>>
>>> When we call clk_get_rate(), we expect to get clock rate value as
>>> ulong.
>>> In that case we should not use log_ret() macro since it use internally
>>> an int.
>>
>> This is quite subtle, it only happens when log_reg is enabled via
>> CONFIG_LOG_ERROR_RETURN.
>>
>>> Otherwise we may return an invalid/truncated clock rate value.
>>>
>>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>>
>> I'm wondering if there are any other places where this happens,
>> but this change looks good to me.
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>=20
> Thinking a bit more about this, shouldn't we add some check for
> downcasting in log.h in order to make sure this does not happen in the fu=
ture?
>=20
> Something like this should work:
>=20
> diff --git a/include/log.h b/include/log.h
> index 6e84f080ef3d..20088399617c 100644
> --- a/include/log.h
> +++ b/include/log.h
> @@ -332,12 +332,14 @@ void __assert_fail(const char *assertion, const cha=
r *file, unsigned int line,
>   * use 4 bytes in rodata
>   */
>  #define log_ret(_ret) ({ \
> +       _Static_assert(sizeof(_ret) <=3D sizeof(int), "Cannot log without=
 downcasting"); \
>         int __ret =3D (_ret); \
>         if (__ret < 0) \
>                 log(LOG_CATEGORY, LOGL_ERR, "returning err=3D%d\n", __ret=
); \
>         __ret; \
>         })
>=20
> Downcasting just when logs are enabled can be the cause for quite some
> subtle bugs so breaking the build in these cases might be a good
> warning.
>=20
> Any thoughts?
>

I agree with the suggestion but in that case all the macros in log.h may
need to be updated with the same kind of checks.

And that is not the initial intention of this patch, we should do that
in a separate patch I guess.

>>
>>> ---
>>> drivers/clk/clk-uclass.c | 6 +-----
>>> 1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
>>> index 3b5e3f9c86..41dcd14be5 100644
>>> --- a/drivers/clk/clk-uclass.c
>>> +++ b/drivers/clk/clk-uclass.c
>>> @@ -488,11 +488,7 @@ ulong clk_get_rate(struct clk *clk)
>>> if (!ops->get_rate)
>>> return -ENOSYS;
>>>=20
>>> -	ret =3D ops->get_rate(clk);
>>> -	if (ret)
>>> -		return log_ret(ret);
>>> -
>>> -	return 0;
>>> +	return ops->get_rate(clk);
>>> }
>>>=20
>>> struct clk *clk_get_parent(struct clk *clk)
>>> --=20
>>> 2.41.0

--=20
Julien Masson
