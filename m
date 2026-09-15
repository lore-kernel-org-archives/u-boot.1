Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19014C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 11:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C07B160743;
	Tue, 15 Sep 2026 11:20:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Ilj6JRBwWe5; Tue, 15 Sep 2026 11:20:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A849360681
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789471231;
	b=jXE8AAOlvblZy788Vgb2dil4T8kmIJGAYbQVGJdRxAvwDc3/EOqnqsK+mDF58+DbS2IT
	 GZihtx3rLLhgrJmsso6IouCLG0T3pmzHkqbtf95pV/I/ITHZ1jxiEzdL6ppa/5j5NOHp5
	 /IzzS+u+PnNxnAZwO9yJgE1D+zOQcOzWR0zj72Yxbij9+/s/JuaXwHpTCDPCQ6VE4AB8V
	 6FwgNPMWK+pgb6VBw6/3ecHYh6liH7kzDSI+fhb1gDXaOtw0b0aQNx3YOrnhOENRjR3ZU
	 FaQlY/k+NFcpkQcN8tanw+kLQ4IsWuDBW+PzV6r2uvDx6GfhF56xu1j0vlPE+DXJDEQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789471231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TtJdOeJKdwri/qD0wESssgqxfPf8yMFWTNsiNk14ZY0=;
	b=oniVQipJ2clNwz8nGEkZsHQVPGVhjlS0fLOLP1AHNBopcnKkHcCbkDh3m5frzE/ZKLbX
	 UWuPMNC1nZ5p5+86h3aJ/cO/gHAuRheuU+k/YwGrzBD4Bj31Z/MQgqVbokSjPWUaUxXoj
	 6z2UZCWMPlQU3zx5rtS8TR5LPFn3iCJUqIik3LHy/iEK/VhuQcPyGe0d63lL2/F6CaZEE
	 nkTW1oyn+Xtaqn1WMUSp0IYr5M2NNP98ArgKvGwM5+j6QidPFPtRVIzVSXYb0PW6Ry68u
	 ftzE9+LGzSZXHLzxIgRk9wO5DY/DeV2OxEirK3PrvipnDxPhoppiE4Cs2znEiLNZL6g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mEpUoARB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789471231;
	bh=TtJdOeJKdwri/qD0wESssgqxfPf8yMFWTNsiNk14ZY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xv06aSDaFcS7INaVxDp9uzeppuUDnENwHz8xeWRhn5Dk7nPTjpUOvzmnMr6s3NOU4
	 x3brfr/PQYhM8+BSbXdildR+JlMLo2V2JJDzd8Ob/TFt/XkWqR9CGOL0ssipKU6wqh
	 ETM8ghEvSpN3xfA50afxg9dG9dRW7IgBfl2NfEth048UbogPZ212ac4ZQ5IRmCb6/m
	 txg1T2VJgLJdzcU8kioiMYN3jYmMrI4rziFJkt2nSrfa2MFsF1YM4DU/RTv3GSQymC
	 1EwA3BiLjzaRA8vvEzmOH5oTXIhff1O9hB1UkXRAi+YDKBUaSza4Pq9juurqF/bWbe
	 HRuXlzqc3HLqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A849360681;
	Tue, 15 Sep 2026 11:20:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E2AC4259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C89BF60681
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:20:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tqIx_kzJXl3b for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 11:20:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E59E5605DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789471229;
 b=eOrvAmkvur4lnusz+kwKN1ROn4NFozJWxSQGEh+9gtIiA5v7Gauuxtoi9ttZoINMFM6r
 CSpyr1ur334IRkgHSSx/Kx2BgVlpoURHqIeFv8vO1kEergB4zArZ4MzupdEx26cZ9az3U
 /+7sS7KxVqAZtG3fRB9781RfCYcJXajg6m6ru8c/ebbgymiBq+ZvhmrLlQZUWFa8nTkT4
 M+DbYo2g6y6xvaSo10Hw4dJDBsvSWuLp/8j+eIj7RyfVoDFmR6oBtgWj86CbD7KQ43/Fv
 lzXOCErqDU7ibciTygTXfSyiMPZddIF+k+zVrJpZ0iraKH2U+YziqPJOBC3VNWILx7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789471229;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=TtJdOeJKdwri/qD0wESssgqxfPf8yMFWTNsiNk14ZY0=;
 b=YqNYY4MQUmWvg0AVrW5Fo5IwwwRZ7SVfyrAGfM57fPTJm5r2LpBKBajQ29ysQMl0lyiU
 Kz+7E21utV3gW7wTnVPD+qkIXwXurcFr+wFAgOLfvTmLvLOZlx63HMPKELyaf5QwAFX3Y
 jUiaFaP0xT/5sHD2J8q4cXSE+HuTppHbYPxGS+gGO2DiHgPLPTyIlRsgK2Wq76ERRcwTW
 4WhIrj3jOFZNZixxq9Q8PzpVGuxHfR9uNKbf/2zymUoppxg9hURR6SkoXNnLEEnnYRVxI
 96Sa/X5HPfjwbqh1IPPG0ngSH4Qp04R5QF8GyGvN59YCjYO/4XatxGWkytCuO4eBIHQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mEpUoARB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mEpUoARB
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E59E5605DF
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:20:28 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so2708738a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 04:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789471228; cv=none;
 d=google.com; s=arc-20260327;
 b=ZzY3/vAfupjA/V6UsAnIqzTSwHRcZE58KgtNO9fH8C/pvSG86oZ6fluzaqD53P1lYw
 4zDfBCpg0WufhD7Un8+M5o+dGXKzgTlSBoV+FGC3E84xmjwbJl4G4hFxIXwDJIkVZaCl
 vkesSAvCovh2QwGn4OwaQ6YvNmHKHM6j+BjZ38swPSnKjD3anclzQKBnklXtKIx5LzI6
 QOWlzOxSf0/axn/KufWFgxETGz4fHr9xQ+dQeKLUXpLHf+yzGgAOnCZ6dSNKTYiVtoOS
 Tdh8P01tvBTSkqkpI2yXoso8c9J5uz24crq88LxVZyf+n8e0ji2tma+76ULWZzLJB1dI
 RqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TtJdOeJKdwri/qD0wESssgqxfPf8yMFWTNsiNk14ZY0=;
 fh=JdpJnjpEswc6OBSLoyhxMV+BGbEbnsGZatwvGASgBtc=;
 b=AwsYeghV/Rz1/EXuDL72oDQKHMuHtR5G+DrmpQDmGUIx5UVOpIcSiIldawPaE1toOb
 /imGRcYMnDbTjFg299Har/zCI7flEjeSF8v7kZ17QscqivOo9iah4LXY3+ZOkqAWGpDY
 HSv1amaEpMVrunOOyJaVkuIET2WutsQ5ZNXKgQB6CdLyx98jxcOVGVne4L6qKmPZcctk
 Tp9DL4pIrolgZtsHjzSRtTJ8esTm2ck8JkY8SHvyuzwuNZumJSdrgxtIty+X1btFHZ0Z
 3SdEg1hmAVQ8FMJ2CKYAIyOdE7CJVa2YYlxzNQa8wFG8aPFLOzVY9bj+Q5bJnHh/LJGq
 +4ww==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789471228; x=1790076028;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TtJdOeJKdwri/qD0wESssgqxfPf8yMFWTNsiNk14ZY0=;
 b=mEpUoARBd/gYmQqnX3GWpQ7Lpflrg0s7kRTQOx9cbIbhyCT7B5le2Lg8JT+jqN8gd9
 d20AhVffmg0ymURUSiRv22iyq2NiZHy1SHGlsezBfUCv/NNwN09/g3ydZnWaKHtkz+d5
 OAsHidb1JC+HiY5HDGLDsFLa6u3hY4jRVWZ9Sw1D9s1jnqkTT1+JCBeHbjUNQ5SpwXnV
 bimoKAkc5BWcK9/QUnEYw9Ec3x3K4MQ4zS3jWjZdrUEZEsZ0ZMmhi5m+sbvic/pW0hhy
 g7p2xyH/dqQfTKqfcasth/FCc1PBtKz9uK9M0FzKJSDMVB0Jep2+3hNV1egfkR2tan2l
 PUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789471228; x=1790076028;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TtJdOeJKdwri/qD0wESssgqxfPf8yMFWTNsiNk14ZY0=;
 b=mMQ9T1ifdhe62YhfVaooU3cVejsxCnIlBYeSXdl/uyKhVq8wCJ2Kou2/xEwmT+Bjen
 DFlOORwsBBNRy842DsZcUo0FiVWn/uUlxqnJCak9GcyDzHfMnbIdampATF1wlMTpCyge
 E31M5YO92tEy4PwVyN6AxhI8txxCCMxJW//9XKn9YtsW2aogJ07qPwgpwFBDnEd28Uo6
 EIkJSqJN6v1oQ5eV2J7ZaSNsp5U4poqwXxp8aItlX74SviCyeKSU0mlVjopvXQYy/Uyz
 t6g3SCfzVj8AAPPB9wvfyEY1XYvc9Qu8QvNOET5J/mKibL1XUmRXo6Bq50b7Ut/kE6/O
 eMvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBZeOMf5bq08YyVCJ2xh2USvOXm2SEKeqzityb3pQ0J9mAMZjWOlmbDKllQ5nW7Bf/GhnNND0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l3//BASMTW0rlz5HYBA3ef5P51bz6NmDCDsFftg8ZwI5XIBPQQ
 TxXJVtGj1UxXmReT5qC3pecpgSr84uQ3Kg07HTVUJsyvF9aCmEgg4k5GfdIUYL2tzrGqGtW6oRK
 OjoZEoTbmyoXmym4my9LEeJbwHUi4wGQ=
X-Gm-Gg: AYBFou0VZf7iGX8qtH0648JEmWmgVDL+pvz+4wREPGQ2acaWQTMa2WvANDW1x7ukq7H
 Gmpv7ZgfIPOpNgfDBkXA86+qlgJLSLP7sjgIJxMI4sZ1qgu+gcOg/n0UToMzYHbWB9jOcQLLtJo
 7j07VJ3rI1viCgAWe+DYobUEaGq9BnLY5U+RAjtlpdyP/WXWUlG2+OMiaegheZzzCE6jl+CKFhU
 Mzvwi5BG/Q9wCbdDmaAmjVyosyi5Swv85LmbNRolBc1+U3XCPeuykm5fo05rJvDbFKRQyyRcaFf
 hlX0V+Z0VaOUhziXnrQ6U4ANImtUZCUMMHObOuqmeNS8W9w4dILqVw==
X-Received: by 2002:a17:90b:3b41:b0:39d:f18c:5f05 with SMTP id
 98e67ed59e1d1-39df18c634dmr10905506a91.2.1789471227895; Tue, 15 Sep 2026
 04:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260912072619.244101-2-imkyufie@gmail.com>
 <20260912072619.244101-5-imkyufie@gmail.com>
 <461c7cb9-0e21-464a-9d11-72239ead6e93@minlexx.ru>
In-Reply-To: <461c7cb9-0e21-464a-9d11-72239ead6e93@minlexx.ru>
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Tue, 15 Sep 2026 18:20:16 +0700
X-Gm-Features: AcwNN1Woid7Y_lLzOCzgbzBcuOSuyhCMhOvdAWg0vbPW6BVn3S_nfe_1BuM0CVg
Message-ID: <CAAq9HC4tA2CvgQxgT4fDKA7AJP-8vzOi_bOdBS31JpHcJSeDig@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] clk: qcom: Add an option to poll for GDSCR
 GDSC_POWER_ON bit
To: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

I didn't know about the submission when I was making this, apologies.

Yes, you're right, it is doing the same thing as your patch.
I also wish it could be applied first, then I could put mine on top of it.
It seems like a more elegant solution compared to my own.

--
Regards,
Reza Kurniawan



On Tue, Sep 15, 2026 at 4:45=E2=80=AFPM Alexey Minnekhanov <alexeymin@minle=
xx.ru> wrote:
>
> On 12.09.2026 10:23, Reza Kurniawan via groups.io wrote:
> > Some SoCs such as MSM8917 poll its GDSC power domains by reading GDSCR
> > directly, as opposed to GDSCR + CFG_GDSCR_OFFSET.
> > Add a poll_gdscr flag to struct qcom_power_map to facilitate those SoCs=
.
> >
> > Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> > Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > ---
> >
> > (no changes since v1)
> >
> >   drivers/clk/qcom/clock-qcom.c | 24 +++++++++++++-----------
> >   drivers/clk/qcom/clock-qcom.h |  1 +
> >   2 files changed, 14 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qco=
m.c
> > index 6b46d9db7..754ff4ff4 100644
> > --- a/drivers/clk/qcom/clock-qcom.c
> > +++ b/drivers/clk/qcom/clock-qcom.c
> > @@ -505,9 +505,9 @@ U_BOOT_DRIVER(qcom_reset) =3D {
> >   static int qcom_power_set(struct power_domain *pwr, bool on)
> >   {
> >       struct msm_clk_data *data =3D (struct msm_clk_data *)dev_get_driv=
er_data(pwr->dev);
> > -     void __iomem *base =3D dev_get_priv(pwr->dev);
> > +     void __iomem *base =3D dev_get_priv(pwr->dev), *poll_addr;
> >       const struct qcom_power_map *map;
> > -     u32 value;
> > +     u32 value, mask;
> >       int ret;
> >
> >       if (pwr->id >=3D data->num_power_domains)
> > @@ -527,19 +527,21 @@ static int qcom_power_set(struct power_domain *pw=
r, bool on)
> >
> >       writel(value, base + map->reg);
> >
> > -     if (on)
> > -             ret =3D readl_poll_timeout(base + map->reg + CFG_GDSCR_OF=
FSET,
> > +     poll_addr =3D base + map->reg;
> > +     if (map->poll_gdscr) {
> > +             /* Some SOCs such as MSM8917 poll at GDSCR */
> > +             ret =3D readl_poll_timeout(poll_addr,
> >                                        value,
> > -                                      (value & GDSC_POWER_UP_COMPLETE)=
 ||
> > -                                      (value & GDSC_PWR_ON_MASK),
> > +                                      (!!(value & GDSC_PWR_ON_MASK) =
=3D=3D on),
> >                                        GDSC_STATUS_POLL_TIMEOUT_US);
> > -
> > -     else
> > -             ret =3D readl_poll_timeout(base + map->reg + CFG_GDSCR_OF=
FSET,
> > +     } else {
> > +             mask =3D on ? GDSC_POWER_UP_COMPLETE : GDSC_POWER_DOWN_CO=
MPLETE;
> > +             ret =3D readl_poll_timeout(poll_addr + CFG_GDSCR_OFFSET,
> >                                        value,
> > -                                      (value & GDSC_POWER_DOWN_COMPLET=
E) ||
> > -                                      !(value & GDSC_PWR_ON_MASK),
> > +                                      (value & mask) ||
> > +                                      !!(value & GDSC_PWR_ON_MASK) =3D=
=3D on,
> >                                        GDSC_STATUS_POLL_TIMEOUT_US);
> > +     }
> >
> >       if (ret =3D=3D -ETIMEDOUT)
> >               printf("WARNING: GDSC %lu is stuck during power on/off\n"=
,
> > diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qco=
m.h
> > index 3a4550d85..0b514cc1f 100644
> > --- a/drivers/clk/qcom/clock-qcom.h
> > +++ b/drivers/clk/qcom/clock-qcom.h
> > @@ -76,6 +76,7 @@ struct qcom_reset_map {
> >
> >   struct qcom_power_map {
> >       unsigned int reg;
> > +     bool poll_gdscr;
> >   };
> >
> >   struct clk;
>
> Hi,
>
> It's doing the same as the patch that was already posted, right? [1]
>
> Sadly it got no reviews, which kind of demotivates any further
> contributions to u-boot/qcom.
>
> [1]
> https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-4-27704470a24c@fair=
phone.com/
>
> --
> Regards,
> Alexey Minnekhanov
