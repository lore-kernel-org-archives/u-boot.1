Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D5AD10374
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 20:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB7C8901F;
	Thu, 24 Oct 2024 22:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iu8rkXAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDDB88D61; Thu, 24 Oct 2024 22:43:12 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2600688F47
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 22:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b13ff3141aso90697585a.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729802579; x=1730407379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A277xoIpvaFVyYg8WWJGFP8naE9gtrPeMyDYiu52z6I=;
 b=iu8rkXARRhlPxSm1Rw9VwDsKMtIUcOPp19G2bd82EUcUfixHsxXCn94Nlw+1bvsr5Z
 yE4XsryKRhKrqvgz5B+SjiZRcvu6gj14t3pske8u5R8DbX2JKTbnS2+Ac/Vp946+7H1Y
 E82CK4ARtaUxCSq9B1zgoRh4NF6/fALW2NPHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729802579; x=1730407379;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A277xoIpvaFVyYg8WWJGFP8naE9gtrPeMyDYiu52z6I=;
 b=LwXjcbtKqmBPFJipFyQd5vGSYOQAd/EcyxzwQK3YNcLWMGHJVqxgpY3xfWNH0Xl4TF
 s5lbD11dwHi4a1Z6lmyhwpxc+YB5Wat2WhtJEZBHjkfvgtuILb5zzke7LjQ6IF9v2Y4A
 3P/dIcqsT44OYd0DM5t2jIw7WhAupGRGiR5KHUqHRXah9e/W52xnkFneGjU/salD272F
 XV8qRTz8CJX70nu8Aj+ovvdLRoM/e+N2UIhAYfu5+sxbdtHUMKrxP9ZKIPVyu+LbmLPz
 Dgcz8yw3LP1Cx69LXM03OCO9ZdHpUqnlICTv/l8ezUcokArb3cpa6AmhfUR3kWI/qmAU
 uZgA==
X-Gm-Message-State: AOJu0YylKbhgHVHD5pe4NicClupVyVLthUBM38BlKf7ZABTesf7az694
 GNrsxiWaAXGMZdkSYlt/x6Lv3cEZpfikmLcZhMggPPl8U+XqblLqg6Sj5ucORnz1YM2JFoNpdr+
 mg0SPgQ==
X-Google-Smtp-Source: AGHT+IG5eZQWcEh2fF8KYQ52HMwUpI0mztK+oZt1n+JkMtBTOTcHVH1JKsUc+pIGjpmSz2kZbXcDJw==
X-Received: by 2002:a05:620a:1921:b0:7a3:5f3f:c084 with SMTP id
 af79cd13be357-7b17e57a10amr946598485a.30.1729802579083; 
 Thu, 24 Oct 2024 13:42:59 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659c0361sm521428985a.19.2024.10.24.13.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 13:42:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241021142045.2981425-1-andriy.shevchenko@linux.intel.com>
References: <20241021142045.2981425-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] : Mark a few functions static inline
Message-Id: <172980257840.160410.10671359942791515354.b4-ty@konsulko.com>
Date: Thu, 24 Oct 2024 14:42:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
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

On Mon, 21 Oct 2024 17:20:45 +0300, Andy Shevchenko wrote:

> The function prototypes that are defined in the header most likely has
> to be marked as static inline. This helps avoiding the compiler warnings:
> 
>   include/mux.h:120:14: warning: no previous prototype for ‘mux_control_states’ [-Wmissing-prototypes]
>   include/mux.h:125:18: warning: no previous prototype for ‘mux_control_select’ [-Wmissing-prototypes]
>   include/mux.h:133:5: warning: no previous prototype for ‘mux_control_deselect’ [-Wmissing-prototypes]
>   include/mux.h:138:21: warning: no previous prototype for ‘mux_control_get’ [-Wmissing-prototypes]
>   include/mux.h:143:6: warning: no previous prototype for ‘mux_control_put’ [-Wmissing-prototypes]
>   include/mux.h:147:21: warning: no previous prototype for ‘devm_mux_control_get’ [-Wmissing-prototypes]
>   include/mux.h:153:5: warning: no previous prototype for ‘dm_mux_init’ [-Wmissing-prototype ]
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


