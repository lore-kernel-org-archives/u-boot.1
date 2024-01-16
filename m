Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3118C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 08:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A227C878E2;
	Tue, 16 Jan 2024 09:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="irmGIzbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1682C878E2; Tue, 16 Jan 2024 09:05:57 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C9E8787C
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-336788cb261so7868729f8f.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 00:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705392354; x=1705997154;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FSds/LnCV56LkUGHOm+VI61zVI2cJiens6JMkZ+ekos=;
 b=irmGIzbfHH3oGQiWJUSodV8IKO2L146uQlsPf2+iG9W7UkoBB4jGb2zRQd6NxpN6GP
 cU2glK82HTG1Pi+hdM9rmazjfkb5ouZdEFbHE1yfcvh2ilOmyNZRrmARkOonXOCf30O8
 6wDXw/FojDG0ZcH4Em8FYnvJKxyals72Fgdckrgz4rfgClFa3pIvPoJn0Q2iY5g/XNAf
 yvKUVvQRiqocoljFQHzl+plUSJXj0t+z4uStfPL5ZBlV2oAEsiJfNFzrPwJm8jrnE5Yn
 puf6mP4o+lohDd3AJ3oucf9qLIqeUTfkd6JUNVmZkE5RoFYSiIKhGPm9hsfULZeAvhRt
 4Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705392354; x=1705997154;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FSds/LnCV56LkUGHOm+VI61zVI2cJiens6JMkZ+ekos=;
 b=WEF5UxnPYqzPaXTGyunXD3NHMYttCNnNZCnTNNvk8JzVaDgxuxYkIaRutjZoin6LDP
 5oy90fWB84bL7aDTzwwnVmo4z691QsSWic0vB3x5vbLh0TpyGuTLP3fbvGhRwMre/AYq
 8G4rVqCGtsap3jQOqnkLsXdOuBPeoNgww7/dFCm9ZmhOjii7iqKeA1kFiN991kbVOyLC
 aYbyiyFH0f9Tbaar3z/XIbEwvB6GTnGSJ0GimoTiWswbW+hc/DWoy+GkekzKgdQzalUH
 88hnp6lXZ+94Fy/bYqPxmOY8fSqSd27JGkwQDQjH+CrXOJnrBAhGnk2kxuyk5i8mbBcB
 fwdg==
X-Gm-Message-State: AOJu0Yy4OgzBGdCtE3N2Hs+cdTm/BOqp43w4nPeYOQuT+Vw+eS/AOjxM
 ZtQqIWP9MgwICmZygw6FqAK2L90/Z/jo1w==
X-Google-Smtp-Source: AGHT+IEyICyIc5M4WyUTDgbFfcFm/1cvvpqUS43EnReAUILuDrQOcgpVuRatuvWlm1bEnOpJ+wt3gQ==
X-Received: by 2002:a5d:6383:0:b0:337:5b64:7414 with SMTP id
 p3-20020a5d6383000000b003375b647414mr3770173wru.100.1705392354043; 
 Tue, 16 Jan 2024 00:05:54 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 d13-20020a056000114d00b003379d5d2f1csm8666751wrx.28.2024.01.16.00.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 00:05:53 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] MAINTAINERS: add Mattijs for Android AB / AVB
In-Reply-To: <20240112135044.GA1610741@bill-the-cat>
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
 <20240112135044.GA1610741@bill-the-cat>
Date: Tue, 16 Jan 2024 09:05:52 +0100
Message-ID: <87y1cp4s9r.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom, all,

On ven., janv. 12, 2024 at 08:50, Tom Rini <trini@konsulko.com> wrote:

> On Fri, Jan 12, 2024 at 09:40:43AM +0100, Mattijs Korpershoek wrote:
>
>> Igor has not been active for quite some time on lore:
>> https://lore.kernel.org/all/?q=igor.opaniuk@gmail.com
>> 
>> It seems that Android AB and AVB could use some help maintaining.
>> 
>> I'm interested in helping with maintaining the android_ab
>> command. I'm a long time android/aosp developer and my daily job is
>> still doing android work.
>> 
>> Add myself as maintainer for Android AB and for Android AVB.
>> 
>> Note: the patches are split because I discussed taking over AB
>> privately with Sam, but I did not discuss taking over AVB.
>> 
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>> Mattijs Korpershoek (2):
>>       MAINTAINERS: add Mattijs for Android AB
>>       MAINTAINERS: add Mattijs for Android AVB
>> 
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>
> Thanks for volunteering to take this work on. Please use the u-boot-dfu
> tree for this as well.

I will submit this through u-boot-dfu as well.

Thank you for trusting me with this work.


>
> -- 
> Tom
