Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E3606A6BB
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Yg6RaF3Y;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y3/oDjNq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBBE440569;
	Mon, 23 Nov 2026 18:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z7PF7Gu9THE2; Mon, 23 Nov 2026 18:44:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 51E4840580
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795459481;
	b=Q8mRUftLo28k7Jo+8X44tBLhfDVWZNQdtq73SbhAMc7K4q7Af1ntLp2tZqqH9bW0OnAz
	 OQ+IE8mdbbdGpMekt8CE4LEQYtRuD7zCs/kAZ6JpIItC/8UsrGKKwc1cR8RjUvb8ps4O3
	 2z3BkcDlkjS5lepaPsQoWYq9aUoOha9n7AUVoIiJ1tgHkdyLiwHX7+5+UtCu/f2XKrVuj
	 ZNIfsbOJyvGgHRVoPlBbsyEXjcm90+yNZv7AEPt8VhC2eR6qYwjzw7Hm28BUE3evceUG/
	 CrLHLj+Yk/5aAeCw2e0iTg75dUa4sH3LWb8NkQypytdTi/jhXEf9EtpHyQJJKZsBxgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=124/3fyUMDKKXfjwCXRM/YsRWRADF9mQdk5GbsH3Px0=;
	b=PbuXnKeOW85q6/66VoniBcPjZ0PzKF4IF+G5Fy6IOEJJdypcz3VS4oZ/hxfVoMc/Wl9N
	 6VtwleLncZP3bpZ3tvRHfCw2mZS+1OgdgMwmlyExXK4O8yrF3tXbUGpMyV4KTTWY/xs8n
	 bZGNA7QZRcoZAb8XQ/lqzHX8sAPCsl1MFUEnK0g9f4DOYrUGoti4XvutGHYFlXpXS4/X+
	 8mYCKL6kfTUgiKza/+XoMt8iW3Robs6YY9Zjhb8puk0xTXJPr5aRDrj+5qE5Nch++5CGz
	 vEbMcQDgzA+bq6JRsBEs6YGOopQGBZasncdrsBGHmJOvclvAls/zJU9oDWbpa9XIr+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795459481;
	bh=124/3fyUMDKKXfjwCXRM/YsRWRADF9mQdk5GbsH3Px0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yg6RaF3Yi2pryFX6uEXitiCor6nr0+TL0XdrMrWSXZM/vR4LqrCb2FCAJOxxUBkKg
	 nACnen2NKq52Zd49duk79X/l1mNPVOY/PYPu1M5vYOZxEXMb4+Tv6Ez6Lx1dgemimB
	 +yVmqnyTr9wcA+TNDW1EP5/s2YUenbyDVCUdlj/KPsQQpWjjcYDdyyJwM7pSqJ6E3c
	 iLgJFJQfxsTNG1p3TcKd9T1ajdEP6JisFQgXNNs0eWpZeTXqJ61RWIhB12N+4+RrEH
	 AxsNKo19Uz2AKryXactNshzFLwi4zYcsneT1A7vBs+3wD81y9iPPooXY6sBEbClvCF
	 SAWfS4y4+h5Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51E4840580;
	Mon, 23 Nov 2026 18:44:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D79A93A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C07DB60640
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:44:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZAMEajszxD3p for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:44:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C8D1B60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1231; helo=mail-dl1-x1231.google.com;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=y3/oDjNq
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8D1B60600
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:44:38 +0000 (UTC)
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-170135e43c7so5122953c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795459477; x=1796064277;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=124/3fyUMDKKXfjwCXRM/YsRWRADF9mQdk5GbsH3Px0=;
 b=y3/oDjNqn4NgXLIn+3bRrUpr9Vr+6z348KGrt+JSIj11GL93/hnperdedYvtC/kdq/
 r3LsN9pOE3P+35S/jtBbpSOXQnVvGVS4HrwgDGqIUno0GnoXtHW+Yf9QJSfcDcBilbs8
 tJDd3/i854+QtjThIysgKhD27Vovw2tNS79QIRGGybZuslQBYjPKBxJTdLQSBzx4wBev
 pYE902C+3gYB1ex8Wt5vMITiNtGbDJVBvbBH+BoWVoT90X4CTkOhZX6yBtrs232x6ECS
 8IbILeqWjv+G9Bhud0AUgHfrKquUiprLne9ls7+OxzlDUpGqDPnw+TxYNmZQIgvIguiD
 JGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459477; x=1796064277;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=124/3fyUMDKKXfjwCXRM/YsRWRADF9mQdk5GbsH3Px0=;
 b=atoqN5glAjpJw9zRgusIetr/oTE7htn6OShn8d9XtiVn3S7JPJd53WQOwaXVSJfVZg
 DykdS7WHJuI4UlQs9AkM6WqSHLjbMoFrxEont+YNNLkgaQaJNRdehyOs8YZ9AiigMVWK
 12WzqlRJBMFhEb/3DVGQuM0Nwdpc4LaTLIPX9CoP40Ugd5sr5ZV9zQydWql+UWFMe1iC
 Q92Ff2IiRbFKCWqQZcfVIaQ73KejzKV68FRsxM2a4GF8ncgrH31KlIcB16HrFIcfAe41
 /lTO8r2Qv9jnOcQ6mxatrMjJWtEnutAQxYf03UuKpkFNigYb81s3vS1CVcZGNewCFctC
 EyXA==
X-Forwarded-Encrypted: i=1;
 AL+hErEw+xbnWfylH3qOnXgcmimxS5Hys+CxaLLV8dTGDZra96nEyIXgYlh+eFv4QNYHtYh8hxAjBAA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9baAr99OFFFFXzOMDh0EHcBnbixQ8EhP+DdnwssM6Tn98xB2UH
 dX4aJwCUURpb9lU+dXGxd9nKB/B0SMEOpEfhQ34mMENuRyyFD2O62jTgD6V3TsSNC1JVnRG8hTd
 JlMfghGmPHN7bFqIVxfI0pBm7T1FoxA==
X-Gm-Gg: AZFdTZdNnjrdv84I8PSJUaUJW/WAyMWLrRYngLYEeOMCcxyuw1zyd1CkZ30oMPzM/jp
 XsTSaBNmczvU6HPPOX+n0IvBzGOkZQPu2d5N4B0xT71OBpJcAajXNLZuYlLL/sfKoObAPhON/bS
 7jw4H3GfKds+U6P7J0bA2/zEavaoebF7IY0HbcnLpHCd/pS4eAI8MWLkVMVyZQYmkLwlvFpdkI8
 nzkLDRePNNvkwsUyfC9BnN52w8OEXB68LJ/xQvsi6j/HrhV3O8PnSrjH8gG6g6c8SqY9k15cecd
 fBGxc3whzg7Ij53HRZDKaIXwkYI+AT8XtrO86v1xVKmYCfL+xoqk5NzlJ92T1q3OnfjUXJXq/gG
 dvbIiWoRSyl3bohEkyYHf7PuHbbxveoXPdZuG8aiatTQlVtraKzanG8woC0xPKV05djGN
X-Received: by 2002:a05:701b:418c:20b0:1b5:39a3:75e5 with SMTP id
 a92af1059eb24-1b556901fccmr12913560c88.33.1795459477398; Mon, 23 Nov 2026
 10:44:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
In-Reply-To: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Mon, 23 Nov 2026 13:43:40 -0500
X-Gm-Features: Aa3M54qnZpg4wi_Ch4ElsksOyU4vMUGAWYr5aL9UW4ZmbKU_Bx8hPbV7tIB5gac
Message-ID: <CABdDSeURr4FdkrYiHZFNyVAooA5qwOsTC=khseervB2gpkGtfg@mail.gmail.com>
Subject: Re: [PATCH 0/3] LDR format: Kconfig: fix LDR_CPU and drop HAS_LDR
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Ian Roberts <ian.roberts@timesys.com>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On Fri, Nov 13, 2026 at 12:31=E2=80=AFPM Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> LDR_CPU has a prompt but depends on HAS_LDR which is prompt-less and
> never set anywhere. Sounds weird. Instead, make LDR_CPU depend on
> ARCH_SC5XX which is the only architecture using LDR format, and drop
> HAS_LDR.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
> Massimo Pegorer (3):
>       Kconfig: Make LDR_CPU config option depend on ARCH_SC5XX
>       Kconfig: Improve LDR_CPU prompt and help text
>       Kconfig: Drop HAS_LDR configuration option
>
>  Kconfig | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> ---
> base-commit: ff8a9bc41e4e5bdd3406932af5abb4c18064e539
> change-id: 20261113-ldr2-f0386fc693e1
>
> Best regards,
> --
> Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>

Thanks for doing this. I saw Tom had HAS_LDR on the list of Kconfig
options to clean up a little while back and meant to get around to it,
but I've been a bit too busy lately. The regular build works fine, and
I agree with the changes, but I don't have the resources to run CI
locally to verify that part right now so we'll see if Tom sees any
problems there.

Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
