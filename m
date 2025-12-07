Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5780FD1CDC6
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 22:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71DA883A6A;
	Sun,  7 Dec 2025 23:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kY/j2LpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858B083990; Sun,  7 Dec 2025 23:19:45 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C1383990
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 23:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c750b10e14so1732871a34.2
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 14:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765145981; x=1765750781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rw1/Tv8v51n5s0s3oQ1G5ZB+nsJlrMK4e1a2thZP/xg=;
 b=kY/j2LpWJNx5UoMgdOxB09pYZxadtUkQf1gVlEtow3UfLQqsJq4rAh9eDxqZjVZcFU
 Cxxd2Vy6eZQi2/6nQ5fEVdZMvPQyGndqXULDRV1sSGZbtd42mHCY7Gql/CQ9adaH+FJV
 ruP1mPhdh63JBeJXwXjvMDWqUMyryrrtHduX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765145981; x=1765750781;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rw1/Tv8v51n5s0s3oQ1G5ZB+nsJlrMK4e1a2thZP/xg=;
 b=cUGsvolPsJBCPevRnm+jQIrFaIgqFnvnF7KCT1wE2Do9Lk30FZh69UcigvphrdoOwr
 MlkuCsBxsPo9On7dIlYZ0zhm91u3zWIF86gRCXm60jMecR8eja66y1n9tC58SJX4Hzru
 2r74KEZ2baOE2kz2qWxXS81Y5EW84Z/0vOioBQyTgEBdbLMmQBcifdSe+staOrXFGViS
 CTEgkRAMYgPFwGKUgJYx8wFKSKQikicNO3uE8kAUzuIxp7doPsdnkgqGiUWWpa+ByaJ/
 Rd41UBOYRry2uHdRSx3INZnRHItyfhKZ17ccV5BTEdWueIya/qKlRelsdAqk4DES4/4K
 KSaA==
X-Gm-Message-State: AOJu0YyWwBz9OQVaGwOPMQXOgH2oi0yzWYGHnoy4yCQGSX2DKaTCC34O
 ERu1J+KGKOlUEQRZcPSH4UvcnJ25hr+WYy9URwZgZvOu2f9uzFj8J1/QySaVk6JMN5Ta2848dUZ
 DnnojDwg=
X-Gm-Gg: ASbGncuVElrQlzVIVRLFNJd6EM+iRKcdh4beHky20mJowrDkMi91BXy2bVt5uourhWk
 7CRkeT4RBNcy9522MRIxXHxzwmoJ9XXlR+aMdJka4YenbGV08oeoJLaK1MKgitnQsOnEU1Fc4kx
 +httbXRQU8a+2O2dj247W2RNW1mRmoO25QluFmaVYI+UDRrRT8U7WnLXwUkm4WHE5Jef6//T8A4
 dbQy1jl89tyTIzfIKz1oLJ5KViItChXtHZghSjaBe4RRVr6NGgQE4RWQDMDMQyJkMiZag/7YZDY
 5qwhcBPbw6PikafFjT6qWlZQFJjbaeMwEbL2hVry8iRo04Qzxde0m0yiRb+h7Ym/YIUOfkpEH3k
 DrwAhHvmyezmVM1juGoAUawBiGJsfoq9h08kasVvxsxId50djY8shxGMwiIwTqSsBwNmUiyAFJZ
 d7mUGJp4eVCzYzfOZpSUZPS+yXoBf0CtivBVpfStR6oHxRMiSl
X-Google-Smtp-Source: AGHT+IEfIEkO3PKxfAg9BGB2lGZBQJBvls2zHMKQp8Js3vWsOz21fMHrMgxXvIvI3MvgBb+wi73HEg==
X-Received: by 2002:a05:6830:411a:b0:7c7:65f4:1120 with SMTP id
 46e09a7af769-7c9708116e2mr3687303a34.23.1765145981444; 
 Sun, 07 Dec 2025 14:19:41 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acdb599sm8634803a34.28.2025.12.07.14.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 14:19:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251206200119.272104-1-festevam@gmail.com>
References: <20251206200119.272104-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20251206
Message-Id: <176514598000.2987146.474333696511514443.b4-ty@konsulko.com>
Date: Sun, 07 Dec 2025 16:19:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Sat, 06 Dec 2025 17:01:19 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit bc1819331ece7aa4e7d0573c9cdacdb8efbdb067:
> 
>   Merge patch series "clk: Return value calculated by ERR_PTR" (2025-12-05 17:03:36 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


