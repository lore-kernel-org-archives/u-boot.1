Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B99C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 16:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A1188098;
	Tue,  5 Mar 2024 17:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TPeOna4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1A71880AD; Tue,  5 Mar 2024 17:03:11 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F228809A
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 17:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-68f901192afso28940216d6.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 08:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709654584; x=1710259384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fuy4C/jLd/3/4H4B9vPIjfVwHSAE9EBHRGiNIxOfzY8=;
 b=TPeOna4TmVlOKY6xeWSHlx7Rcskof/gxYj65hlehylyH9MKVB7xI4kiXTHfY7MAcwb
 0eFmQTOckLGPszdt1IE/iWqSFBRyJvLdlQA+Lzv5nP/ZSry+O5mj5AHNllqnRXJvl6k2
 mLRI6vvpYKZUptGEUYgKrenJRjf+vj6/cJows=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709654584; x=1710259384;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fuy4C/jLd/3/4H4B9vPIjfVwHSAE9EBHRGiNIxOfzY8=;
 b=rIU3UCe5qxKbB3FdnduXiT17O2Wjb7b2Yj8gA/RIhtg8Q7hHfpVjK6JNwb2FgeNc7q
 L7Pia3YKPy3rBfqHzh32Sk3UFsbDaCq2Tpxvi/dYBHIlb8DiEj+Ls48iDLGJZLePv8Xb
 D5hbI1qzBmBTqTVkfQbMYXF/sv0/bYF/++P1alxOIEeWLWUPj3+8/Psj8EM0qXUadVGm
 FdM6ny9PB8UgSTNca1CrtDenouK00t6fX03iPu8YxrtyQp9YuGoCwvvtyRePnSwRSjM/
 wECd/IUwT+liuCp3f6gaw6bRURhwsu4tfSUMlX9NA+0XDzkZ/MikVUNelJ7N4bFbSuIR
 0Fwg==
X-Gm-Message-State: AOJu0YzfGt/rP8ejZr7h2K7JJhQzOl6c4qT7AAhQuMUxmWG/2YOqdAp9
 cZ9W0XH/Bj6IApqS1tt4mogUgLI6VNIx0X2r012cJK/U4j+Gs0MaDwPr9gtZtk7P9xfeq3kmhgT
 mjFU=
X-Google-Smtp-Source: AGHT+IFeGnyaxNU0V+wnwlk6QKt9F04a7wgzbM7+eCeSog59JLXH8xZPyGfKBZps2fw8EwdvWeB+4Q==
X-Received: by 2002:a0c:e845:0:b0:690:765c:70c0 with SMTP id
 l5-20020a0ce845000000b00690765c70c0mr2896526qvo.51.1709654583955; 
 Tue, 05 Mar 2024 08:03:03 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 jh19-20020a0562141fd300b0068fef023e6esm6382512qvb.88.2024.03.05.08.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 08:03:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Michael Trimarchi <michael@amarulasolutions.com>
Cc: Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, linux-amarula@amarulasolutions.com
In-Reply-To: <20240226071415.1705492-1-michael@amarulasolutions.com>
References: <20240226071415.1705492-1-michael@amarulasolutions.com>
Subject: Re: [PATCH V2] arm: dts: k3-binman: Make optee optional as requirement
Message-Id: <170965458287.2808800.3258729732266767225.b4-ty@konsulko.com>
Date: Tue, 05 Mar 2024 11:03:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 26 Feb 2024 08:14:15 +0100, Michael Trimarchi wrote:

> Allow boards that use ti_spl_template to not use optee part in
> configuration.
> Vendor can have module with 256 Mb of memory and they try to optimize
> the available memory just using the essential components.
> This change allow to remove tee from configuration without binman
> fail.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


