Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BE1C47DB7
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 08:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF7486BFA;
	Fri, 19 Jan 2024 09:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f7/5AYm7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7529886F67; Fri, 19 Jan 2024 09:59:10 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC9C8640C
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 09:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e7b51b0ceso640992e87.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 00:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705654748; x=1706259548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6aJtraZCz1RT2vDQM/LF+VHwVOgu3/L89kq8WlbiwKw=;
 b=f7/5AYm7EzZhxBKfXKQL7pXVtpV5QAWnsdCohodb9XRRGj1GwayBOz0xyhB2Sl7z7B
 YTK/IYxxvqj7hRAma4Odo3aLXOr8g7Q0fduuBOCoKimELSfgxsJbDQiOQ/W2/1CMZtvm
 ZP4pcUNlDN1izDpa7SzyNJany/VOpmYB9NbiD/jaOaApgrCT7WZc2DqBAELJFCJyXIEq
 4mRejGY+VBk+Ekz59PPAkkauSlekE6S6gA1hE1kdfz90doTCROIUPBOXaOGXyDKswI/y
 gBiFRq6jMUwOogXxpDzgUusVqEUR8O88RbYRQJ4jpDi/TvtDHxaEM3d5QnyI4g4oo0pQ
 RPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705654748; x=1706259548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6aJtraZCz1RT2vDQM/LF+VHwVOgu3/L89kq8WlbiwKw=;
 b=fTbuBy1WcUyO8teClpqO0DVrux12hgWpxRd+i80f+QduXEFbLttUW70jPy9n0LsPbc
 7n4ACmJ9swUBf2odVOsO80jXAq9xi/bUEvBa3Q8q7CIGMo2nEfGYv0i4FNUz0Ynt3D3+
 Hp6+eEivE7a7a7wy/wQNnXirYlqqtXaDk/pCQ2Fvk29Z4fArHD47X+gE7bM854JdK4pe
 7Y2tCFYLSMu1MJP+ABzotsk0ulmAGDRwxHgirYNjzdlfkAjn4P8VFyH3N2UfFytEGimu
 6IKM25vGWgHzHckBX2PWapcaBDKYdvgTRPPzqV5Yp6rPVUulKw55ivDoH6cOG2+aNvmY
 /oDg==
X-Gm-Message-State: AOJu0YwCvM1eWyNDv/VnfU3KL4rDEITZCPOXnTIhjJgD8TEGPXaxBrBF
 ip8A0B2v9OJzADif+VFqJed84agnOvalnqDZzoZpGVhX+Tw7rez2Np/n5nvdULXWDs8+6pg82pq
 xvHt9MtsuzNcsjXv+6iv6Ff7qx9mqzFDhGrciDw==
X-Google-Smtp-Source: AGHT+IHyPQktRDnjOhn2JhmKZGgyXaYcy6AsAJJtCFMKawvAjbkv3aiimYXQd5g4NSNYKB42puT3jaZysnDZY8YNsog=
X-Received: by 2002:ac2:55a9:0:b0:50e:6a65:fa97 with SMTP id
 y9-20020ac255a9000000b0050e6a65fa97mr406400lfg.33.1705654747647; Fri, 19 Jan
 2024 00:59:07 -0800 (PST)
MIME-Version: 1.0
References: <65a933ab652b3_da12cbd3e77f998728e5@prd-scan-dashboard-0.mail>
 <8cf878fc-88ee-4c27-b95f-d1bce5ddaf34@gmx.de>
In-Reply-To: <8cf878fc-88ee-4c27-b95f-d1bce5ddaf34@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 19 Jan 2024 10:58:31 +0200
Message-ID: <CAC_iWjJNm-YFXy35_fjyHx0AQBFb0GXSDH3mcHv1uBVNp6D_TQ@mail.gmail.com>
Subject: Re: ** CID 478334: Memory - corruptions (OVERRUN)
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Fri, 19 Jan 2024 at 10:56, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Hello Ilias,
>
> please, have a look at this warning.
>
>
> -------- Forwarded Message --------
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> Date: Thu, 18 Jan 2024 14:20:27 +0000 (UTC)
> From: scan-admin@coverity.com
> To: xypron.glpk@gmx.de
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to Das U-Boot
> found with Coverity Scan.
>
> 2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 16 defect(s), reported by Coverity Scan earlier, were marked fixed in
> the recent build analyzed by Coverity Scan.
>
> New defect(s) Reported-by: Coverity Scan
> Showing 2 of 2 defect(s)
>
>
> ** CID 478334:  Memory - corruptions  (OVERRUN)
>
>
> ________________________________________________________________________________________________________
> *** CID 478334:  Memory - corruptions  (OVERRUN)
> /cmd/eficonfig.c: 534 in eficonfig_create_device_path()
> 528             p += fp_size;
> 529             *((struct efi_device_path *)p) = END;
> 530     531             dp = efi_dp_shorten(dp_volume);
> 532             if (!dp)
> 533                     dp = dp_volume;
> >>>     CID 478334:  Memory - corruptions  (OVERRUN)
> >>>     Overrunning struct type efi_device_path of 4 bytes by passing it to a function which accesses it at byte offset 5 using argument "fp->dp.length" (which evaluates to 6).
> 534             dp = efi_dp_concat(dp, &fp->dp, false);
>
> How about using
>
> dp = efi_dp_concat(dp, (struct efi_device_path *)fp, false);

That looks good. I'll send a patch shortly

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> 535             free(buf);
> 536     537             return dp;
> 538     }
> 539
> ** CID 478333:  Error handling issues  (CHECKED_RETURN)
> /lib/efi_loader/efi_firmware.c: 413 in efi_firmware_set_fmp_state_var()
>
