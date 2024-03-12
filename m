Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D76DC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B4887E06;
	Tue, 12 Mar 2024 10:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y5hCt41U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E6C487F17; Tue, 12 Mar 2024 10:48:58 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 646C287C86
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so2253353f8f.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 02:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710236936; x=1710841736;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XWsUZlZkuFmCeBLCH27rDOo0IFF+ZEeHIianbG6m9sQ=;
 b=Y5hCt41U8Ac6IKiF2UtksAYTwynzumC9MnayGgH1XzjCCMtamk/Znqr4d55hRLIVdt
 LBkNNCiETjguCskwQeaQq5DZ6Qj0/2xqjdGB2aPlreIR15IRwQD88j4tCxcLWiMiBoC4
 MWg5Iy6DEPp2Eg2w2v5UGxN+/jvC1zwwLLItB94xt1pfjxRD0900S43ztYFBtI5P1yu9
 aoO2AqTlnbgll1/FxB2qGi1f2AJYSq6pFGkZkARvqgrdxT3Qvsf5ws1wM6h062hdxdnd
 1amVw8t+OxKCNQZc8xLY+yK7ZE+Ba26vuf3bDmJRZMpAnvDhmVGKeIX0iJ7IPEUEruaa
 ABLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710236936; x=1710841736;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWsUZlZkuFmCeBLCH27rDOo0IFF+ZEeHIianbG6m9sQ=;
 b=rthPynMkgDtxdaMmQUirSsRZ34UhgwyW+zzy7oJdoJ+7Z7ZFFr8V++VtQ246QReSxu
 fqCVwWiuE6xTqv3HCfemjR29NFxG2aLlIQcV1E1kFMfSLcM0X214D2DCvnp2Ccy6OOxv
 N6vlX0Bs/sT9yXusGotmJdwN5jDDP+dUgEUalibbiEhwOmfkOwRw6zZj+XSW+rUUnc1e
 VysnJ8bxjPwlFFzVsCkCVbtWnZcDAPA2v9Wuu+TZg6qdaXi/f5tJBY0OdBsER4aP8flG
 /XMbAEI2eANvwVTnIfS+OAXZBbkWQGUJzZCPhEca3bnQLQCtYY9Xf35eIlr+Yu4zWJXN
 wFCg==
X-Gm-Message-State: AOJu0YxDggjzmcUjMRXcfkC1SjdxxT1rz3RgCnRjiwT6svjqSsWwXQVu
 QLAlEZdWyf8nUwsaCcupa9jAyRUjlrA+mDh/nugjDstoG2RXp4j/vWxQbP8WCbw=
X-Google-Smtp-Source: AGHT+IFh9QgGHjFA79k8G16mXH5jYnKDRTd/BpQlh/8+/rBJW74gBTzPMLJcn5eXLJiIcc9Sp0jDmA==
X-Received: by 2002:adf:f18f:0:b0:33e:7f51:c2f7 with SMTP id
 h15-20020adff18f000000b0033e7f51c2f7mr6998444wro.52.1710236935865; 
 Tue, 12 Mar 2024 02:48:55 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 f19-20020adfb613000000b0033dc931eb06sm8769571wre.0.2024.03.12.02.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 02:48:55 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sam Protsenko <semen.protsenko@linaro.org>, Colin McAllister
 <colin.mcallister@garmin.com>
Cc: u-boot@lists.denx.de, JPEWhacker@gmail.com, sjg@chromium.org
Subject: Re: [PATCH v2 1/2] android_ab: Add missing semicolon
In-Reply-To: <CAPLW+4mBk-4_FsVF27FD+a=W3-wfKrDr4vjjeZ7Y8nT2mnuOwQ@mail.gmail.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240307221030.3685767-1-colin.mcallister@garmin.com>
 <20240307221030.3685767-2-colin.mcallister@garmin.com>
 <CAPLW+4mBk-4_FsVF27FD+a=W3-wfKrDr4vjjeZ7Y8nT2mnuOwQ@mail.gmail.com>
Date: Tue, 12 Mar 2024 10:48:54 +0100
Message-ID: <87sf0v4w6x.fsf@baylibre.com>
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

On jeu., mars 07, 2024 at 16:54, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:

> On Thu, Mar 7, 2024 at 4:11=E2=80=AFPM Colin McAllister
> <colin.mcallister@garmin.com> wrote:
>>
>> Found a missing semicolon in code protected by a #if that will never
>> evaluate to true due to a separate issue. Fixing this issue before
>> addressing the #if.
>>
>> Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
>> Cc: Joshua Watt <JPEWhacker@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> ---
>>  boot/android_ab.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/boot/android_ab.c b/boot/android_ab.c
>> index c9df6d2b4b..9a3d15ec60 100644
>> --- a/boot/android_ab.c
>> +++ b/boot/android_ab.c
>> @@ -221,7 +221,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct=
 disk_partition *part_info,
>>  #if ANDROID_AB_BACKUP_OFFSET
>>                 crc32_le =3D ab_control_compute_crc(backup_abc);
>>                 if (backup_abc->crc32_le !=3D crc32_le) {
>> -                       log_err("ANDROID: Invalid backup CRC-32 ")
>> +                       log_err("ANDROID: Invalid backup CRC-32 ");
>
> Good catch! Wonder why there is also a trailing space in the end of
> the string. Anyways, I think this patch deserves "Fixes:" tag, would
> you mind adding it? Other than that:

The file seems to have weird trailing/leading whitespaces in some of the
error messages.

I think it's fine to keep this as is for now.

We can make another series to fix this after Colin's work gets merged.

>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>
>>                         log_err("expected %.8x, found %.8x),",
>>                                 crc32_le, backup_abc->crc32_le);
>>  #endif
>> --
>> 2.43.2
>>
>>
>> ________________________________
>>
>> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole =
use of the intended recipient(s) and contain information that may be Garmin=
 confidential and/or Garmin legally privileged. If you have received this e=
mail in error, please notify the sender by reply email and delete the messa=
ge. Any disclosure, copying, distribution or use of this communication (inc=
luding attachments) by someone other than the intended recipient is prohibi=
ted. Thank you.
