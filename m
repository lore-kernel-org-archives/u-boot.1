Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A00C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29347877AB;
	Mon, 11 Dec 2023 18:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VJrEg/t1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54FF7877A4; Mon, 11 Dec 2023 18:53:10 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 535F68779D
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ba14203a34so469784b6e.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317185; x=1702921985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RKVe9Ok4OrUBsx7rHeW0KVrsgliN9Tktiargn8Vlzu0=;
 b=VJrEg/t16haPKQIQIsY6BPYCqbEW0hPc/pBItMuhyCdEvlhoydns1H8BZ1MBDwHJ2U
 oUSwMggY5Vi7M6naRkuDsvYzjEC63FYFjrEeiAfX9ZeEiVnKQwGplhHHj2mAE8HnLgLN
 Ui7Ydc6E3BdknRIzlXxP2SdlUPNKEhgb19w+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317185; x=1702921985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RKVe9Ok4OrUBsx7rHeW0KVrsgliN9Tktiargn8Vlzu0=;
 b=VgR/T7tI9/1kTh0yVji9ALd+swRUA5jMUtNu5WwkvOD4ugIpJ4INL4oerZ5PfTfmuZ
 NuPbns7QhLhaE7gxY2pTTQMufrU16rPvwxQHD5I8cEN5t9eEFXMD3lD0MZI9mc2W84Vt
 I1o7PJ4VEn4z1cSP2BXO/H+nZVlV5ajqhfG9Zr8GF3Miexj9iw+QAn1dWKhcRDnKDAR3
 dfA+mXEdlMgj32EqvoXIXNa29nHX0auB8RSc6Dq1BaYqTkz2pbun/8kansqXYsWSUKwc
 3uukVa+pewDzyZPk/P0zapsWwZvsOpby1k9r1AhPXeFN7X6F4gwBUj0JFmQ52ahI+lt5
 kwVw==
X-Gm-Message-State: AOJu0YyPhPBOOcELrwsS24KjnW5EBf1WV3+fhb94yo/9mXt8tGBs/wYG
 o0khrkoSzT/omR1nCiXgSOZNZBQcAXkUvGzHBVqvTolfgmj81jL5iiQ=
X-Google-Smtp-Source: AGHT+IF2CyspMKT2tilB+4B9U2VZ4nNtyBiT/x4eb29dmWpJSDOizZsneWOs0LBj9xvIPqcTAikd2pS5dhQACDWR5Sk=
X-Received: by 2002:a05:6808:3c98:b0:3b8:b063:adfe with SMTP id
 gs24-20020a0568083c9800b003b8b063adfemr6880687oib.91.1702317184793; Mon, 11
 Dec 2023 09:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20231209170536.104700-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231209170536.104700-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:19 -0700
Message-ID: <CAPnjgZ1swk4h6EpQ+wF9E2GDUSJsn_k0PvNWqCUydaHQfdrNmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: check argc for acpi dump
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Sat, 9 Dec 2023 at 10:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> 'acpi dump' without parameter results in a NULL dereference. Check the
> number of arguments.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

This could have a test in test/dm/acpi.c if you like
