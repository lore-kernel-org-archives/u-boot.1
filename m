Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E22DC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5390C60B71;
	Thu,  3 Sep 2026 14:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uyYjhoDkZd5S; Thu,  3 Sep 2026 14:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6EF7560B66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446025;
	b=cTL+zkhBrx29EiTWr7/v4xpj1NYw1iczfWOI6NuraIBTogxig+caEaVCdTVqHb+oDAzf
	 /15I+7tNurszSZ/+uw2b8pWc7PgoYymi1KT7VhBi3SWd6lT6+aDrF4AqXSwYbGKgv1mbi
	 40xGCSPHTpqnG7SOMx9rFLzY26yG8asyNeg1u+x59yOGDwYQqm9VbGCy1kTfHKSLAI5ss
	 8p6+c1L2yw9PtP/SLltXcyQyJI00zjEzCFIXSQ+Xw74+fZ9KTlZFFkFJAmBOmkwnJf2EA
	 BrutyzKQaKLshhOVcuYHtteGvDiL8h1bIXTKmX8ZrMWdibw4Ak5RMcpSDkpskde/F9g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HgIC350AlYnt8zxxqmr2FE/zbKdRm5UGQwQlh70Edag=;
	b=mu6f5UPRCtkyAAy0fMzruASNYeF8/Rbr8Yt4TEKTbNcUA/nBzGECvTRh/BHvgn3BU0Cb
	 66U5gss3S/EEw4YE8bK2YtJrEjqJVr23MLjfVsLau3By3Ec1Cq7RHIMjrm+DnY7lX2MjY
	 rr+JrJo/SCfeSUJgPPXbnrcQHGTbh3bTStZz1nSFejs9z+IYCLWmDAQM39Rg7kYJ4pz9t
	 ShMTrMdMeY6Srh3L4C3F6cf+dphQK1Xapy7ovnuZnGokJ6Vs/ce+9w+OXfpsCagdsgKwH
	 UMvKGUjwf1twZ2/3IJqoA496Zl6Rg2VPKZIbRr1xRU7srSZ6HrDXVrejcFM765TnMzg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FOQB5Q2s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446025;
	bh=HgIC350AlYnt8zxxqmr2FE/zbKdRm5UGQwQlh70Edag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tjl690Mf2a4u+cAQX8/24vrjKvjK4Zu8HpKnMKr7qVMow3zOe1DtfhSPdIgIPcQFq
	 O5rsuSQW5AsKiOzMc5hvhDKDGsO+sYxW5MD3XokAbZb06zBHdACCWzmjykb1K8fgRI
	 laA4cxWVFB91pdaBdIr0LY21l9puOFt1vrTbjZksXI8ZzNUbBQfC5lF7m7sJDSNgz5
	 drczIJvLWzLbrC2soyGp5lgGaQElFEABIjYcuFmurwf9Q9rbXofABEFMCif3azdCB8
	 6rECkPPGTlWalijSpvwk/CL79fe8GJ59KZfYYG9z0qNG34UGwVs9mC+J1Q95bQ+1wK
	 TW4G+vXaU4SOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EF7560B66;
	Thu,  3 Sep 2026 14:33:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D82412FE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA06C60B66
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:33:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id emT9CSSNUxNH for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E0F40607F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e2f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446023;
 b=QxTc7JT0V6YaaQiXTJBhFFBOYn1CWmjqAXWc22xXZGrHMGWUuVauN0VRSnJemMmVkmV5
 Z46897B4LTA6Ds19WRI0EkskVI4m5U4fyhIng5OfpDw4HiyHtdvCaoQmQNNhqMKuIYY6X
 Du2IfmKEeB/weYac/e4vVr6hnX76NfujWL1vnjUF4TNMrVhvBvx8dTzEInahihJhob+0M
 zjjOexa09mw16VQptdvce5th+0v2iJ66UuyC0+FPhxWAGR6ovz7rVlnXYdLK2IhAqhmir
 kWbs1OWfUYdVbQ3a0jM1YMGA0U7BPaUaXlfht2801meV97hPftjFU6fvNs1XZprNCtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446023;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=HgIC350AlYnt8zxxqmr2FE/zbKdRm5UGQwQlh70Edag=;
 b=XroJDw/ugcAiKRaCNrt8RCN4y+HNBWbMAGifkDDpIpdjmanKBLidyMAhBogw4HOynLYN
 wiMTW+0r/wV3LrGzFOYDaQ/+msmN3o+1NPqSFtjejfBFDQvccrTE+3kfcFKhLmscX+Iwd
 GwL6tLJcDDy9cxRdARQhANTCEAdRvwWBUWLONLRMfSV/osK7mZZSU7RV1yVwuXGp0W7Z7
 bPsw33QK7/cLFg9G8SD6QL9qjxz7by3XW1DCdK9NZEDAumQi74X7RvupJg8tRJBLPf/ns
 tRLswCmd3IRiuZWgk7wMivKkgoEw+5gRJtQ/Xn3xjQEBIiwwxVXXxt44bSlRPV1T+gA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FOQB5Q2s; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::e2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2f; helo=mail-vs1-xe2f.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FOQB5Q2s
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0F40607F5
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:33:42 +0000 (UTC)
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-75e2905c09aso579260137.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446021; cv=none;
 d=google.com; s=arc-20260327;
 b=jH1iMyHFONzVBHftERa7At1QqlIzvwFpxwH7ZvicMv/HOC301IGpkXQwpErEowAk8I
 Rp2ExiLC0cO9q899JtT5nN/rzsEu9gS0dyw/l03V7sGH8LqJUkzvHJgEz5VLcKPXvHSg
 mifzWVkEbhK7X5W470Dq+JQYoPKKt6it/dBDjB0tCWXFdqCjmvJHO63IR9JWT0wjj6qS
 mFgQwPmNBOAv0rsTrAYRbFJYW8q2fqzfNmadpnFhfCeAH8ueg+AHi/z0NxuCSGXbMKQN
 baSFyNXBFHXC+zc+EAmo8n1sLX6PNTX4u1ETWaSLIgU+oBbL5ABPfVTpLVH5MwPoLZQj
 jxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HgIC350AlYnt8zxxqmr2FE/zbKdRm5UGQwQlh70Edag=;
 fh=kABJAN0z8vNvuio6PwQStEIhq1Xiw6aInZKLCjmtm3o=;
 b=GGKcg5n68sfZ/Y4MyWtBi79Jh7mpt+h3eSdZOGKqTbN25BFmP4Qu+Zw1EITlgVZvKy
 eFpgWG9qEafbaBeENlDgC1hO8NRBdXA296+H+5vLALXoikpQIXrYq6uAl8gUwbJDXXz0
 QQh1kr8rlE6s22Lhn/6FaJN9JJrlZWnobQLX0EYDZR17XKYwHqDGYHjmNdUjCqJWFItL
 SCzcMIhCxVgOFo2B7zhgbLc4FuobtO/KrBlqT9xXA7oo9EBRBmrSKQ/zOuf9J2QRBtHw
 HQiTannNRahWWiwbNOLStVIDzzjSMe3xQYKR8tzNFHlEex+uI5uTGLeNUDxOw4/oVlhu
 Qw8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788446021; x=1789050821;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HgIC350AlYnt8zxxqmr2FE/zbKdRm5UGQwQlh70Edag=;
 b=FOQB5Q2sJLKGdAyXsjlXBpejYlXUlr5b5DUppQPBMljb1NM/MipTWtsPV54MJnZf8Z
 0Y111JECH27YSHGu2EsjElqIp/GFLMg9PgQg0CWsFF5u1VNqUfmutsCU8EYorw1RosbC
 53Mlxed4jHwlXu7WiW7mGbkE9Fs+kjbzD0H2g7v5Eu8+1ZE5MXeYkHYxKN9yDxuSGtb1
 n/HJQAZx4nl7qf7TnDXbt3DB64u/use9igxSbNem5Cv/0JykY2uHfQ2HoH63GK6d2qvE
 ltBG3d81RGMEX3Ly6mIppda5ImYn5UBkONnpaSG40Be9pNE5suzgzxUUeKsKsUJiH722
 iTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446021; x=1789050821;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HgIC350AlYnt8zxxqmr2FE/zbKdRm5UGQwQlh70Edag=;
 b=aLiiQVOnOHpcoQ94eps6EFLctRscTXrJXD8VakIjQukjRhlkwazOvSSui5VWrmSaLp
 3AVt3D7J9Zbd2gBhNJ+BLAxOaBc5XdJtNwBTdGcXWPmrrSKszx1mOXUJkaZxCg6FCuvL
 9tXTvoSJ2UoDyMSPwNKquJM/zNg3Lf0U/3vPdhkeLrauFHc4EkyG3eRlClxUSkU+7t1X
 HQLj0i+GWM3xuaXpK+j2WX7yqdX0MIMahpbOq1flwUlYVJOYmdi5mFxlShfnJ0OQPXAg
 8GVpNzhwq68XfLeOOzH7wcrl9Y4ZuMBmAECxcQwN2OjWjSo8oJUYOKhNZMWta+wAbjkU
 3wXA==
X-Forwarded-Encrypted: i=1;
 AKwUvByWAlXQ7SJGNcbFN1B5QEM9LR/hFKa/EbWh7/Mp7Yx6/JfVZ7R1J9RoN2Hupx8DkBXdlT/JYds=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mfGx0aJ6pgzGPPiXs22IMLzequLMK7WnJARrUbdOeT7JB3RpYJ
 baYB0AXrxbehmtKIbVNfj46pM4OmBT4hs+L2oY/P1IBEbfh3BoOH3+T2iDpdlEkos+Xu+jh+tDr
 T3MKbrMpeCm8dSZPhGaDDFFWLO46Y6P/tJ36M
X-Gm-Gg: AYBFou3rVdLOTFxikqtIY80Uh/LH/2CEnnUViLhqLyGFAKaYnPDG791mN/ylXWF+/tM
 TPgjnHYnt6C5ajfMT7nlsFr7jSvcPpERrOrfHXe2dKGvcDG+gCI+7MZIoYd/Vg7RuM4mxq0gs9u
 XSAgviItjz9ZaXgamw8JHeZMsxWhy9QvxP8FISpaMfjNkZvpEpwgo9mz1N8EyUn72s7YW9Kp6NA
 tv75T8ydhI5HT1Yvpt8HQ160dk5zCitxhMQoAW8dROJnHhnCij0qcVYI3RhULzbP0HuOQWLJqT/
 Z+aE5jUWUooyATpOIfVq+cmy0WAxwu1kyxeS/mwUjwfc3OM=
X-Received: by 2002:a05:6102:2d0e:b0:782:de7b:eead with SMTP id
 ada2fe7eead31-78a1f15745bmr4066349137.1.1788446021107; Thu, 03 Sep 2026
 07:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-7-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-7-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:33:27 -0400
X-Gm-Features: AcwNN1UYF7sRJu90E05ZvvlRH5SJsHVNhGzPz3dytl9utAmd2ZkUiZ2nF18drkA
Message-ID: <CAMDkj5yFijksGHKH9xFUYGoFzzAeuyF3f=iRvsbg=EwOCf3A7A@mail.gmail.com>
Subject: Re: [PATCH v9 06/15] test: dm: ecdsa.c: clean this test as software
 ecdsa is now implemented
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org
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

Hi Philippe,

On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> The test ecdsa was done when ecdsa was only supported by hardware.
> So it wasn't possible to test ecdsa on sandbox, and there is a test
> to check that ecdsa is not supported on sandbox.
> Now, there is a software implementation of ecdsa. So we add a test
> to verify that ecdsa_verify may be used on sandbox.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - initial version
> v3:
> - no change
> v4:
> - add a test that use ecdsa_verify
> v5:
> - change secp256r1 to ecdsa256
> - check that checksum and crypto are not null
> v6:
> - update commit message
> - remove fdt_strerror in macro CHECK
> - return ENOMEM when malloc fails
> - add a define FDT_MAX_SIZE to avoid hardcoded value
> v7:
> - change uint8_t to u8
> - set required_keynode to -1
> v8:
> - remove macro CHECK with a goto inside
> - use lowercase for hex data
> - code cleanup
> v9:
> - no change
>
>  test/dm/ecdsa.c | 107 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 97 insertions(+), 10 deletions(-)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> index d7eac7115f7..261ca3f9f73 100644
> --- a/test/dm/ecdsa.c
> +++ b/test/dm/ecdsa.c
> @@ -3,36 +3,123 @@
>  #include <crypto/ecdsa-uclass.h>
>  #include <dm.h>
>  #include <dm/test.h>
> +#include <malloc.h>
>  #include <test/ut.h>
>  #include <u-boot/ecdsa.h>
>
> +#define FDT_MAX_SIZE           512
> +
> +static int set_fdt_ecdsa_point(char *fdt, const char *name, const char *=
data)
> +{
> +       char *value =3D NULL;
> +       size_t len;
> +       int ret =3D 0;
> +
> +       if (!fdt || !name || !data) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       len =3D strlen(data) / 2;
> +       if (!len) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       value =3D malloc(len);
> +       if (!value) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       ret =3D hex2bin(value, data, len);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D fdt_property(fdt, name, value, len);
> +       if (ret)
> +               goto out;
> +
> +out:
> +       free(value);
> +       return ret;
> +}
> +
> +static int create_fdt_with_ecdsa_key(struct unit_test_state *uts,
> +                                    char *fdt, size_t size,
> +                                    const char *name, const char *curve,
> +                                    const char *x, const char *y)
> +{
> +       ut_assertok(fdt_create(fdt, size));
> +       ut_assertok(fdt_finish_reservemap(fdt));
> +       ut_assertok(fdt_begin_node(fdt, ""));
> +       ut_assertok(fdt_begin_node(fdt, "signature"));
> +       ut_assertok(fdt_begin_node(fdt, name));
> +       ut_assertok(fdt_property_string(fdt, "algo", "sha256,ecdsa256"));
> +       ut_assertok(set_fdt_ecdsa_point(fdt, "ecdsa,y-point", y));
> +       ut_assertok(set_fdt_ecdsa_point(fdt, "ecdsa,x-point", x));
> +       ut_assertok(fdt_property_string(fdt, "ecdsa,curve", curve));
> +       ut_assertok(fdt_property_string(fdt, "key-name-hint", name));
> +       ut_assertok(fdt_end_node(fdt)); /* name */
> +       ut_assertok(fdt_end_node(fdt)); /* "signature" */
> +       ut_assertok(fdt_end_node(fdt)); /* "" */
> +       ut_assertok(fdt_finish(fdt));
> +       ut_assertok(fdt_pack(fdt));
> +
> +       return 0;
> +}
> +
>  /*
>   * Basic test of the ECDSA uclass and ecdsa_verify()
>   *
> - * ECDSA implementations in u-boot are hardware-dependent. Until we have=
 a
> - * software implementation that can be compiled into the sandbox, all we=
 can
> - * test is the uclass support.
> + * ECDSA software implementation is tested in another test,
> + * so we only check that the UCLASS_ECDSA uclass may be used.
>   *
> - * The uclass_get() test is redundant since ecdsa_verify() would also fa=
il. We
> - * run both functions in order to isolate the cause more clearly. i.e. i=
s
> - * ecdsa_verify() failing because the UCLASS is absent/broken?
> + * The data used in this test come from RFC6979 and use the
> + * sample with curve NIST P-256, hash sha256 and text "sample".
>   */
>  static int dm_test_ecdsa_verify(struct unit_test_state *uts)
>  {
>         struct uclass *ucp;
> +       const char *full_name =3D "sha256,ecdsa256";
> +       const char *name =3D "key-ecdsa-256";
> +       const char *curve =3D "prime256v1";
> +       const char *x =3D "60fed4ba255a9d31c961eb74c6356d68c049b8923b61fa=
6ce669622e60f29fb6";
> +       const char *y =3D "7903fe1008b8bc99a41ae9e95628bc64f2f1b20c2d7e9f=
5177a3c294d4462299";
> +       const char *r =3D "efd48b2aacb6a8fd1140dd9cd45e81d69d2c877b56aaf9=
91c34d0ea84eaf3716";
> +       const char *s =3D "f7cb1c942d657c41d436c7a1b6e29f65f3e900dbb9aff4=
064dc4ab2f843acda8";
> +       u8 sig[64];
> +       char fdt[FDT_MAX_SIZE];
>
> -       struct checksum_algo algo =3D {
> -               .checksum_len =3D 256,
> +       struct image_region region[] =3D {
> +               {
> +                       .data =3D "sample",
> +                       .size =3D strlen("sample"),
> +               },
>         };
>
>         struct image_sign_info info =3D {
> -               .checksum =3D &algo,
> +               .checksum =3D image_get_checksum_algo(full_name),
> +               .crypto =3D image_get_crypto_algo(full_name),
> +               .required_keynode =3D -1,
> +               .fdt_blob =3D fdt,
>         };
>
> +       ut_assertnonnull(info.checksum);
> +       ut_assertnonnull(info.crypto);
> +
> +       /* create a fdt with the public key */
> +       ut_assertok(create_fdt_with_ecdsa_key(uts, fdt, sizeof(fdt), name=
, curve, x, y));
> +
> +       /* prepare the signature */
> +       ut_assertok(hex2bin(sig + 0, r, strlen(r) / 2));
> +       ut_assertok(hex2bin(sig + 32, s, strlen(s) / 2));
> +
>         ut_assertok(uclass_get(UCLASS_ECDSA, &ucp));
>         ut_assertnonnull(ucp);
> -       ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));
> +       ut_assertok(ecdsa_verify(&info, region, 1, sig, sizeof(sig)));
>
>         return 0;
>  }
> +
>  DM_TEST(dm_test_ecdsa_verify, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> --
> 2.43.0
>
