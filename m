Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F8BC54FCD
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 04:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BACA60631;
	Sat,  1 Aug 2026 04:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id APCvD9VKt-63; Sat,  1 Aug 2026 04:24:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1A1960632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785558250;
	bh=TyUgXI5lJskETed2EICGuw6VFqoc6RiKlaIDWE1ncVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DRgr9zlRzKCf0n48uIJwXRlqAStyIZuE47H27xWpi56fuSP4YqO0O69bEyBvXNnNP
	 rIU18dniW9DYrGd8mzkeZpB4UobmrV3a3MOD80kXnwbcIrllPHJxQ3m7V1cLZrb7SH
	 xDe9j/cz/F+GIJcTsJ1UAqzc+mu2FG54z7lFuuRTp+TLV35MoYa2UMrlN1/blcWgF+
	 NvQko0yB9LSILBX9otyT7Bi1wSvfEaKW3UVAQCwXvRGh5/kUFLyMCyWtluCDZ3+m3E
	 P5n1oYSUPHXyhZbWFbgmw2VKj/Vke/67HuFoB/gV5o2NYZQWPhK6DFr7sXgNiDiygY
	 yd81mbbhPw6Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1A1960632;
	Sat,  1 Aug 2026 04:24:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B78F23B6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 537624005F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DE9ZhJ_bvA_M for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 04:24:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7B4304004E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B4304004E
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B4304004E
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:24:07 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-80dc4a68e4aso18709067b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 21:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785558246; cv=none;
 d=google.com; s=arc-20260327;
 b=Gua0EeFAtedUkRkUMn6Z8rfy/cUNs4NoQXbDxil8yHhdN92FNP/+gR5usz37xCK0nt
 Yly/WwQL0dToVGNYSkWWGPUp9WTHC80H5BIJAwVXzqazczDUsttDbKczLigvAV3lbDhs
 vL/FBQWMK9wutm7yM1nvc3qs7uJI8UZjKV+S8V/f3aqqew3BJkJnQLsiFKnLnZvJ+SXE
 m+4YsYxduFoEPcVvSCRQ532w7fUfWfDy9tTr42b22pQYJyhmO06CxB+xmkRfh3K/TuMs
 SuRoBDPafXekYJENg24bOxDMk8knp6J+m0Gz8nuYEwXUPUC+dHNrUxXGy2bTjvFppD2w
 XmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TyUgXI5lJskETed2EICGuw6VFqoc6RiKlaIDWE1ncVg=;
 fh=K7I1kmppYBfc/sDcoPlyMgAAOOp7NLm87lAMb5nfWYs=;
 b=WYf9k1wIUFukJR7zEtkWtILZORrpThXwYSkvggjXHtCGf99lbSvJ1vHQ7vXy4enT2E
 y0NsRKv6LHLgxr8NKfz4nsCLEPInNP91AVwKR49lCvTvZn7g9jr0Ljc7ZA1RWvS2MlVE
 z3+hPy/q9C1wXQ+T+7cv1EF7yzRAS4Bx6LaaV8S/oDyigmcxiSsy6ghnHs5Vp02ge6XU
 73BDM36Ky9BMEVk9ZijTXQMpaenL7NNaTDcxgAZ0f7QxUp36q+pR2C5iOY0mPfDTLalT
 by9Puw+x+BFWX5fP6zuSxyWBUQePsO2sOGtEjR+jUHcFh9Gng1wxeEMKG8GbH9Rd4TJc
 7tqQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785558246; x=1786163046;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TyUgXI5lJskETed2EICGuw6VFqoc6RiKlaIDWE1ncVg=;
 b=f2z9612RLmh26m+Fph/lZAn7/jyPwLAlnPrrywfPuZq78RTXpD+HQ9w93J7Dnv44dV
 Xx2mQPMD++/ogckEiMZxFsokSsrdwDvwpD5Z9yFgVRfB/t4wSsLZCZ+86IqfjLhJpyZ+
 uX4IQ51sw+ahWe7hlFvecux3wWjm2giwW575fqypEt/8KBrX0UsNpV86QXE3gCaAqa9z
 D0yJqaifbRtkmv1wAzbdKiFl3LyH71NU/v+Vqo4ytGyJsI9oSU0Dq5MTbrOidzIfeQBH
 xKLrF1OAjtcz4zSNT9UqBaOFcdBzhLk1rOFr5JLLmIRI3r51ZgNJCm5FUg4u8eE+Ev0k
 f5aw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEdt8w+JRIkKsTZ9XTkBdKwAPRWtqSoVzUSNhs4l2ZvRMDo2i1JzaY46F+EnkUCWyA1M2H9KA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwE/t02vyRBAbn8EfwfkSdhkUnspPM0vrZWtXDwtfFfT1cci6rB
 kFhJEIAZmUTvop4njZRlrh38ux8MHx8SvemBYp84RNOtTMYiQ7JB56OtT8mnsJMTA2H2KTmlrAe
 EAwdHYArgpdIzDzACO8AETil7IQ9BjImNP6ctuXuS+g==
X-Gm-Gg: AR+sD13XTbqYAKgojSopmd0X+sTubkojatvWQ9ZdLW524BlJLIPN/Dy4xmSQkJJX2Hf
 Y5Fcn7ImFjEmjqbgFRrclH+sSVwDuBV+WSOSAriXB19d0r2RMuzYHXezg0CgdtXhSCptmiXDgU4
 gYgWGgy9Ym8eYHhPDBMjk1hauqfZhhwu9IxQNUX+vapbN13yMSkYSY9VvpbBqk8yL9Z/x9+HmMQ
 iK4Cj3dj2kR9yt0Sz0hwnG77vV8XDcOb2nXSm4KcwuhqeUDas+5CePbuv5VCtmSWr+vyEz8bDtI
 lVKRqpoDEnHRKEQPgYtySFHjcguhlJiyJWoB5ZleN8rka+CuD34hArApZtZtypKrAZtv2e5EG1P
 VDD7ke1u8+cyNn5t2j0nK3xaxHB4gTBGFIYUf9bkiuC07LUpMlxm9X46EVnVf5+4GqodmYW8GxI
 jcXXO11I17suWBn6WIi9ktSou7AYPYPYTcUW4kkzh9+Sp4EtfKMk1HAKJiL35eaAwRR3MpOk4nB
 4chDG/PQvyk5SjqQSk0/7A2Lap37xqWScb/oebeH1FWieNVjCm8krfp5sZ4wkcSw1A9KL/5Y3Gu
 f1SZQlSzNGcxxRllxeF7RPVpXhTkX8oMsH9Cudkb8NNbru1s7ibZDap/cUF4JS6v4gQraTOrBKl
 lGMl5Yrprd6gpCx1MjhgyJfuwuUfSxa2froCHwidpHBs=
X-Received: by 2002:a05:690c:278a:b0:80b:9f4e:a73 with SMTP id
 00721157ae682-81fd4ad19b2mr37795437b3.13.1785558246018; Fri, 31 Jul 2026
 21:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260731101950.82084-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260731101950.82084-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 1 Aug 2026 07:23:30 +0300
X-Gm-Features: AUfX_myIOCkV5tY0QwRUtkasgOKCWCtlag0ovb-2HmrhJfZ1vKIBiot22olUrxY
Message-ID: <CAC_iWjLT+QLhT55GqVqfmw5TD5U54eSXOQh8UMeMfwBY_iz-4w@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: correct list_guid[] array
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785558246; x=1786163046;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TyUgXI5lJskETed2EICGuw6VFqoc6RiKlaIDWE1ncVg=;
 b=Zn4kIOf3JdxqskF8MXJyEP9zopAKAzLh6tbL2rDu/dZ32wyk5OcX0lbzE/cbZAxh8O
 A98MoaFXBFHPXGpyLH5snpHtV6ROUTjJxj6/LSi88kTBnXXSTW3JJTPi8lgVAdStdxev
 Ib//4EWaNRzVUit6wAukUfqvbbYOe+RQxdq9bdPQVhvvbKRNEqqYs5hG/xduxk26hkVs
 Y7WsSs/5v6/UYrK+pVLd0OaW9VanOifbSLYOCWvJRo3UPDaIXaeiTa4R4kmQMAT4JVUY
 9vMmdq8hNQ4fNbpUOFs9/14ip4umeisGjHEOn3IydcSsU3xAYwXPhjHnuzcmleFleQPe
 80UA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Zn4kIOf3
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 31 Jul 2026 at 13:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The #endif for #if CONFIG_IS_ENABLED(EFI_PARTITION) was misplaced.
> CONFIG_EFI_PARTITION=n disabled all entries in list_guid[].
>
> CONFIG_EFI_PARTITION must only control the translation of GUIDs for GPT
> partition tables.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/uuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index d7c164ea06b..16ca8f37751 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -95,6 +95,7 @@ static const struct {
>                 "system", "EFI System Partition",
>                 PARTITION_SYSTEM_GUID,
>         },
> +#endif /* EFI_PARTITION */
>  #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_CLIENT)
>         {
>                 NULL, "Device Path",
> @@ -304,7 +305,6 @@ static const struct {
>         { "EFI_MEM_STATUS_CODE_REC", NULL, EFI_MEM_STATUS_CODE_REC },
>         { "EFI_GUID_EFI_ACPI1", NULL, EFI_GUID_EFI_ACPI1 },
>  #endif
> -#endif /* EFI_PARTITION */
>  #endif /* !USE_HOSTCC */
>  };
>
> --
> 2.53.0
>
