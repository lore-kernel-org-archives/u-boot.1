Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4A8C531CC
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 01:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 182D960B0A;
	Fri, 24 Jul 2026 01:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XUqMd3dHzZya; Fri, 24 Jul 2026 01:02:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFE1360B0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784854940;
	bh=CorLdmEx4+TtTxj3ZZ6iBJzfaVMy1holwd68pC1rSiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GdJnaHK8oyqgrQ6wn63dqcciru9VqkQwrssy0GbJYpUwODAOodu+ijTtLg7G+rhuU
	 4HVcI0ikbOQEb0a6RbQhIc4kC7TfV77i56Lb+z9WoJuHUBKOXDcyn0gAH8ZXhS9lak
	 gNQiaBlI3lVT18w3iMz+V1tgUEtvJRIczcKZ4cpgOg/8M2KYgYP+rp6lH4bxJ1xy+J
	 MSu/cspe9TzNjmGRDSErjZwFA5uK7uw3Ni6ozgju5HFES0QITD26Q+tn2qK3AhiGO2
	 ArcTpeRUj7WZK8YwxUaxUAoYLoEj9TezaZT+6OzK8NMd4UdzaNTvw9nuxp0Re76mgF
	 gCTIsjI65YbBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFE1360B0F;
	Fri, 24 Jul 2026 01:02:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 125972E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08B0580F89
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ablUxLtWS69J for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 01:02:08 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 205B180FBC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 205B180FBC
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 205B180FBC
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 876F7848BA; Fri, 24 Jul 2026 03:02:06 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767B9800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 03:02:04 +0200 (CEST)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-4513435cdd2so566198fac.2
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784854923; x=1785459723;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CorLdmEx4+TtTxj3ZZ6iBJzfaVMy1holwd68pC1rSiE=;
 b=g5noKTVGWQA6RmoaXJJUyQZUkJ2WpFcdMPVNvZKMKQwVXSEMw6+aC4uXvZnuNjd0fI
 qn8k6ECwy2gigqjh8mK/8K/4lo3NWs0gPyw3AmT9zWvLjBsxmMeI8TTyq0s2UMvR5vF9
 vNqGIsnpmv5OlrWxiDcCmXs5J2BAFhT/bC6iYDEctKBBHuY+blGxzGIJUJGE9qSYavBh
 PF6sqzRrBv+Kmtpr3sKYY0T0hGdqediBKdO3lFvliMAMhpxY3vAbtKoDBKFrvj7Tr8tM
 6CPpmsvTKvtw6zU94vR5+/9Ku3HK4EaRE6NIVKpgCr7IK0/TpDz5MC8PJCOw+TC29vck
 c8ew==
X-Gm-Message-State: AOJu0YxbNknRJzzq8mGHKB1fD7+zMLmpRBsxprDGh3tUGbB4cHOdjxqA
 wjIXVoMWKUjdeWb1iJXEMet0h4fkljzPlcO3XHSyXvRhjMzLiyvOAoayDKKkfDNJP7TazwU2QxK
 vp+LYviE=
X-Gm-Gg: AR+sD10iUEH+JTWqYr9dm/YlR13npei2KnMFTCOyF2mrTGaES6y7//l7xH/GRz6lbTD
 LqeJXzvUcKwFAef3DcyvwgIlyJWdh/jJYBxqsXMXNRzHp5xWTjj7X9A0qV82lFI2Ew9F6W2IGEO
 eYBhEyOjah0t+AMovrEAQjsL/gO8L/hwTqUazZNCeGdk3yoiXKktUmExlBig8T3ARFkMUJ5B+dO
 +uFw+8U20gXex+EhhKf18UgP/SBHAXLfFPGkZccGVDoW4wCU4oVPMYLDX0BJtRzAEVjDwESVhQd
 DzpupBbgdmsFeMUZNd0YJp/M4S4EfQ26boGn00WULztpUb35LGglqNMQDqyA9LnnhcbRT6Ya/hj
 n+oKa5b0ixF9MfBYZShKij6ZaztBA1k+cm3ZgOCqsSzpgdrcj3uYholT5Y2VinKfRGyAytJl64i
 Hw5yK0rFHsmB5xxnv+olDv+b3nFySwTvcHltxRvEJqcPMC53FEVW8Ku7eBHQZvIfuYiYkHJeVGD
 3SJdeYCFJWJGZlar754KjFHSg==
X-Received: by 2002:a05:6808:1a09:b0:497:df42:1e04 with SMTP id
 5614622812f47-4ab35309b8cmr2524750b6e.18.1784854922999; 
 Thu, 23 Jul 2026 18:02:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0c7a01bbsm4196177b6e.1.2026.07.23.18.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 18:02:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <do7oqauhs54jgjz7h6zaajwmxzhdcppmm4dt65zxjx5onwn2xr@iufsnhhebnkx>
References: <do7oqauhs54jgjz7h6zaajwmxzhdcppmm4dt65zxjx5onwn2xr@iufsnhhebnkx>
Subject: Re: [PATCH] cmd: mbr: return false instead of NULL from bool
 found_key()
Message-Id: <178485492201.3246206.7601726828847830473.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 19:02:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784854923; x=1785459723; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CorLdmEx4+TtTxj3ZZ6iBJzfaVMy1holwd68pC1rSiE=;
 b=MYuySihs30rmp6cERHFU3zaGbktQL99jvqWX9JGIN/WfcYbnCqtxuov6vy1Fq8+7Iv
 XHYbdUbY+eB58WMXcFYmZ6yJjumijb7DdqAjTN9ZsCXC18I34Z5QAF0ZqSGRxhgl6ObL
 CAVC9WRe1g2TtLeDxS8fAFsuhUnIv1uXBeumw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=MYuySihs
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MYuySihs";
 dkim-atps=neutral
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

On Fri, 10 Jul 2026 20:52:15 +0530, Naveen Kumar Chaudhary wrote:

> found_key() is declared to return bool but returns NULL when strdup()
> fails. NULL is a pointer constant; while it happens to convert to
> zero (i.e. false) it is a type mismatch that trips stricter
> compilers/static analysers.
> 
> Return false to match the declared return type.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: mbr: return false instead of NULL from bool found_key()
      commit: f7b525a8bc5396b84cf873bdfa5750731de398e9
-- 
Tom


