Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D2ECA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 19:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA72983106;
	Tue, 19 Aug 2025 21:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pb47R1Dq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F3D82E34; Tue, 19 Aug 2025 21:43:17 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B87D080FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 21:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-61bf9ef4efbso440562eaf.1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755632594; x=1756237394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aVx/EtdN/KHZMikl6keW54rEPFRjasfLaF9ajp/fsk=;
 b=pb47R1Dq6qGF1fBTTClOXEoGmPgpKy1eWLNSHobNQfcp/Zq1FBhi86r25O340+vpdt
 RgHIVYqPuFKFHo+TbdWwgBlRYp4hNCgREfliHHk3qOI6pR3Bb7nmGFycllQwr9lWz76R
 DJxi9jk53D60PCVKatr/nNs7wMmpk9ISM4QEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755632594; x=1756237394;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5aVx/EtdN/KHZMikl6keW54rEPFRjasfLaF9ajp/fsk=;
 b=CJj2CKhvvUSwuXEOKZKzVOLjoGa7eFMmDBf4a09eUrJvuYfn02m33MrofiWpQMxkdJ
 vrhLnJ1MiMwS8YsXtw/96q2COuGFf8JxUNYfTAprNjNKHqC1BX6LcNAFvJBGvSX8WsTt
 gqprq8DbdKaXw+18qh/g4Poe0TgxPRxWlhBtQKcvPPN55+AgzIdxWVU8Sk6095myMqCz
 jruwuYN2sQCly8Br6fSDRP/dB4WHDRdVV6jxRYHbqVnqLg1OEAn9soshfKwIdQdfUfuz
 X5Y90/5Q+2IvbG1fWAOJorePDAE+BfM4l56RP8+nEfxx7ApzOmyldS6bYhprMjv2DTD5
 voBQ==
X-Gm-Message-State: AOJu0Ywmvu39XZTXn+mr56l7a9ecyPtcbbVMSJYrukfgOu4pDBsCwQMD
 UuTZYWm/BzX2rDhezMaI0yh8ClWEIWG8SxR0myEbQruLy2P/zHSwY/oKqZE8RURtHKknfqluSiD
 PEOVHcJ0=
X-Gm-Gg: ASbGncs9bAw9D4ms7Az36Ewk7TY7jlUa9APVY5PPpHuYZcE+L02VCCipXIwQ+Wt+plr
 6mWl/lYVROAvlbW8SZ9DzyU6rjPoJv+GahgwuxjuVs3Q/6k223D3FvggmTQciSpGpc7ytIdkntZ
 Hqc04dB5b4ldGAuBqU7eUNRa72En4TVl7ivsBr2SwZeYB7wpyMDa5q1kF+JlUDJHLiILn3Zm1oG
 lfIAEQAkQFnDb85jlAcUndm1i4NJ02hIAVMeKNGFkjXw9kzwnZ5Mp5euoAzV4euHgLLo6P8RRQU
 yoPxTTWg+/v7c9jvsKdxElqN/L0oh1skIl32/6yxWdl33Shwwhn0+xGI9Y4kGSsVoCwTHn7C/Ma
 j8TkzUshhUn42g3kWtjjl5FJto2rURaru17EVDC27YfzCLJQ3F09JaPQ=
X-Google-Smtp-Source: AGHT+IEB5f3hrfpZlEe88uEc80imlgf7AJJSdtuxuJa6KVFKflGlEsK7wj2iieKwqpjp8a1gQkaU5Q==
X-Received: by 2002:a05:6870:289:b0:2cc:4613:76f0 with SMTP id
 586e51a60fabf-3112283612dmr181201fac.17.1755632594390; 
 Tue, 19 Aug 2025 12:43:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439204e5easm2525109a34.38.2025.08.19.12.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 12:43:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250812-k3-navss-v1-0-a88f7db58998@linaro.org>
References: <20250812-k3-navss-v1-0-a88f7db58998@linaro.org>
Subject: Re: [PATCH 0/2] soc: ti: k3-navss-ringacc: Fix Smatch reported issues
Message-Id: <175563259348.3359676.4676270681873690376.b4-ty@konsulko.com>
Date: Tue, 19 Aug 2025 13:43:13 -0600
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

On Tue, 12 Aug 2025 11:13:48 +0100, Andrew Goodbody wrote:

> Smatch reported issues including a derference of a pointer before its
> NULL check and the use of an uninitialised variable.
> 
> 

Applied to u-boot/next, thanks!

[1/2] soc: ti: k3-navss-ringacc: NULL check before dereference
      commit: b90927bd0d81096239ff4a48a71c3d9e87ef7209
[2/2] soc: ti: k3-navss-ringacc: Do not use uninitialised variable
      commit: 13ca68b104ea75d54e86816ba6d86ef5e70a2668
-- 
Tom


