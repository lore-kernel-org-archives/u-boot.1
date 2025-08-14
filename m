Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D24CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FD783A81;
	Thu, 14 Aug 2025 20:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t6Qb3dKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 074F083A31; Thu, 14 Aug 2025 20:48:42 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E818983A5A
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3e571d400daso6794855ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197319; x=1755802119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SPn7Q1609yVaIiyp6bnQ+LOZjyYtlSz6LlGkfVQCBpM=;
 b=t6Qb3dKr1LQRKlK23WsmlZk5tJbtROZyyxxvGrwKWH+4YMD9CP70BQq3AAuRxm2bOB
 Lr05u+6Bzob28k4Qjr2+HQecEX+KlKg97yGHRQckMT3plUSkGWLlhi/ERX257pKYcNjy
 Bicg5YAfjvLA880SkKfpAxldYGyP4oRaEVoCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197319; x=1755802119;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPn7Q1609yVaIiyp6bnQ+LOZjyYtlSz6LlGkfVQCBpM=;
 b=U1PmFhDWfHvhy/TJteuaEdzSXsAMQmDgpk5+U/xw9ZvHbkidpdPR3j5xbZIll5Qoim
 WPsZn9nrFUYKE4yUOnhCcXOg3614bcy2t1dB70D5xwaskeqbwzWRpjQxlIXFI62w5VgG
 7hYXTRgBap6WqMkCAj8Try1uQpFRwKt6SCtqrLUqZ0xHjurbyqKeI+JQIqdzI9dkMY1W
 FpLcmtyUaWHhRjHb7e+2qpaVqZQADW+e0m5yYJuJbDdQMGYES3eLdnIToF9r1ogAIg8y
 sh7DrGGN9kIf7D+3BqRi1o5M1DCQPZ27cRueJCsO4pp3MewBEZtS/b+2W/VBhljj8pFn
 zjTg==
X-Gm-Message-State: AOJu0YxwP9zElUq8K+miChe7PVw5d7JXUG3AOoFL+nygMwemIMv/Eh3Q
 4pq8hT6hiaiCC9mAtONQOKVDA4nA0J1/4n4PT8l9jBF7NjvYF/V6Ar/7z+Art0YYeXpvNnWtkv/
 SVoQBBIY=
X-Gm-Gg: ASbGnctDKsiPHp/0R3q+nhdeQjxCEZ3GdGtn3m4YjlQtpXMCxD0uX67QYdhR8eotFwN
 fyNkXLPCZwtvpS40CytPavrlsq53sWg7OVTyT8ircgxCdE6t0YoLujai/VSngroUrdo+swrpcMt
 ebbu9RaHCIFtzl++fCKtfvx6IjLBSzEiVcIfB/tmez0QbeX2z/tCH8gYB+R3FsRHhGAW8Beu8ge
 e656i7uE7i96WGd9kZMrcuJNmPXnK4vBZz+qVhLoBiOPqNQUNJOUwITHQE4TZXOtv/f0VzoNsEB
 o3ghKmdWQVyBwuV2MABtRoBJgbas5oE50ywDBvefpb7ci3jeq0r1U5T3e3Oyz836zePeBwzffPB
 lpgd7Wrtiirx2TvFi3+yaZg9vsrDE3ffGsxxPpYe+skq/khwcC6FiSdc=
X-Google-Smtp-Source: AGHT+IEddcESXJzqLgbnCKFT/j99y4i/url/gaPYTiuKtOMGD5QKEHryRelre0oJStnocuCi6g06uA==
X-Received: by 2002:a05:6e02:1845:b0:3e5:504b:420c with SMTP id
 e9e14a558f8ab-3e57089e692mr81280965ab.18.1755197318547; 
 Thu, 14 Aug 2025 11:48:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50b3d6ff137sm1219762173.41.2025.08.14.11.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:48:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250804215719.1413106-10-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
 <20250804215719.1413106-10-trini@konsulko.com>
Subject: Re: [PATCH] sysreset: Tighten some sysreset driver dependencies
Message-Id: <175519731762.3600102.12185474801922435215.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 12:48:37 -0600
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

On Mon, 04 Aug 2025 15:57:19 -0600, Tom Rini wrote:

> The MPC83xx sysreset driver cannot build without access to some
> architecture specific header files. Express that requirements in Kconfig
> as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sysreset: Tighten some sysreset driver dependencies
      commit: 38931172edd71c27101ac19361819d945ae337d8
-- 
Tom


