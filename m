Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6EDCF319D
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 07:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3969688F2A;
	Wed,  2 Oct 2024 09:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TdJixeTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ADEE88F31; Wed,  2 Oct 2024 09:27:00 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E8588ED9
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 09:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso77877685e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727854017; x=1728458817;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Acwtf6IMIgB95wN+5OaEs7gJfj01r4tI6ZcyGrp+Dg=;
 b=TdJixeTGHtp5kV6MQfX655bqwGdxi9JdlVple0s60H8O1PWidL96d0+tl0TyCSdk6a
 iGkhLd1LbtrjcO+NpJWKFqEcCDuSp3RmZ96y/CpIel9uyp7qPPB/fjq0IbCasam/N9Fx
 4k90iKklb+QLTcSvxzPSCRKLOq4NE+AkWxKC147M4IztICkESQh007HjkRN6SxPSq39Z
 srWpwp9UfveANSafiFhxFIO+lLFVOHU8jMnpOCL+z985wGn+yWL4vvj0e6/W7MB9H027
 G0q7z0Lsk+MmxBKKv6W18KTTjE+CGhy/TtAHXyc8ZKHW3uTXMwYi+1jeiKi1c59nipnC
 d5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727854017; x=1728458817;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Acwtf6IMIgB95wN+5OaEs7gJfj01r4tI6ZcyGrp+Dg=;
 b=kJnZzvace0zKXOQYaawZOLH66ELKC5M5COL45ct0G5VzQpsiWl3Fp8fmCD1Qra0nKt
 l/gp4dzeAisHYDuo/WnAwXWmcoTDg5neqPOPur56bdkQKmLl08gXzr14m69T1kyaFvb6
 oULra3fhtIShBxw6sZMm9zuWOTYBud+zfe6tAP/83hBB59FDTTq1d50qW/30yr8xlEEB
 giazoC545ilRktIr0ouXxnC038G0NsTj5/CTHx3F3e7orXb5ees2shNQ0UPYtX4XjwkY
 jQIP3oCyC7DdCikcZ9a50iX6kMjKT3L70pvGXlfwafw1jb3q4crw0eKq1mV+y8QU6Q1I
 OZPA==
X-Gm-Message-State: AOJu0Yw3CkIwSpC/Hqk4mXe+r1MrkZp6QE8lDW1/EpbHzUYJZ6DjSdTN
 D9jTULK23q6Wc6CUS86DxvKtEaErKGdVhTlJyLQMoZeoaeXFj6lWjriYhK6U42M=
X-Google-Smtp-Source: AGHT+IEHlMVK4mE7y1sxFHY3ljRoNUaVs8ixG2GHsE+3ioZeRfM9DVOAXtOcctAqLsz4fDikBK7fyw==
X-Received: by 2002:a05:600c:1d88:b0:42c:a387:6a6f with SMTP id
 5b1f17b1804b1-42f777c365fmr17026825e9.20.1727854017239; 
 Wed, 02 Oct 2024 00:26:57 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd565e479sm13268789f8f.37.2024.10.02.00.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 00:26:55 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, Jerome Forissier
 <jerome.forissier@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240930
In-Reply-To: <20241001184426.GI4737@bill-the-cat>
References: <87h69xmaaz.fsf@baylibre.com> <20241001184426.GI4737@bill-the-cat>
Date: Wed, 02 Oct 2024 09:26:54 +0200
Message-ID: <875xqbm0ch.fsf@baylibre.com>
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

On mar., oct. 01, 2024 at 12:44, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Sep 30, 2024 at 05:27:16PM +0200, Mattijs Korpershoek wrote:
>
>> Hi Tom,
>> 
>> Please find some fixes for master:
>> - Fix Kconfig dependencies for DFU_OVER_USB
>> 
>> CI job:
>> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22468/
>> 
>> PS: I know it's a bit late, if you'd prefer to defer this to next
>> release, let me know.
>> 
>> Thanks,
>> Mattijs
>> 
>> The following changes since commit 5f044932413694475422d4b16607dfcf9aff8781:
>> 
>>   scripts/Makefile.lib: do not include CONFIG_DEVICE_TREE_INCLUDES in dtsi_include_list (2024-09-10 11:31:54 -0600)
>> 
>> are available in the Git repository at:
>> 
>>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240930
>> 
>> for you to fetch changes up to 2f9c472dd7a91bc2d6e7840a550edcd257ff8b57:
>> 
>>   dfu: fix Kconfig dependencies (2024-09-13 17:41:18 +0200)
>> 
>
> For the record, I applied this prior to v2024.10-rc6 but seemed to
> forget the email, sorry.

Ah, and I did not notice that. Sorry for the noise, i've marked the PR
as "handled elsewhere on patchwork"

>
> -- 
> Tom
