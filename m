Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE45C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427EA80C6F;
	Tue, 11 Feb 2025 15:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ELBz9zii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC41A80C69; Tue, 11 Feb 2025 15:18:05 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 641C380077
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f74c4e586so57075425ad.0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739283482; x=1739888282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/V63xTQCW5zWwXUWpCfM8UViHzggvTicV2asbevUZU=;
 b=ELBz9ziibqmGfwoQhlQoKtyuRNSXVk5P6Vm4L3efI+g2euOPY5ZRllua78OZoh152h
 2JwQau93sqX+5A7+7pX/JwHYH9ZTWQZHIxKHNTZ3LOHF+J7kwft/58EMYAEzs+Vf3cE4
 AUCwyK2Ik7DzcCbjuhqq1fyA/dj5Ph4qqP0i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739283482; x=1739888282;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/V63xTQCW5zWwXUWpCfM8UViHzggvTicV2asbevUZU=;
 b=pfcqMaeoq8q61iMZqm6v58yO0/wzam5Rdb/wPgK1nldyXovHY+3EreKMyQJhUBwiSy
 OIsEQPw5gSZvWWsKgNczSl51Rcscw10tQlURExusN7m7mm0vppFYH+H/1AmJm6ASBs+n
 K8Qv7n3b3+lVRKx1WILghG3doohieCa7dLXyLFUcQuH8pFMiMs3S/d6NzPzuFjtmGZdj
 gUT5THfylr7GbvNmKYK4TW7dDBRwaDHp6P8rE0rae4SoktAux5MPVP1fzMShuBgxKJcV
 HlqzNYfRbdP8I2hOOJ9oNWCKv3wWVifgWBP5/EQEMfqT3/6od9SvWP91amKRnviyKiCa
 EIRA==
X-Gm-Message-State: AOJu0YxNNjojpnGq/4AzA213AcDIQhp/y3CTAi1kXLfssG28HqidkZ0Z
 tsLNzNU0nzBojDMHvOVUsfhPxGj8L8yQ+0bGf6XOCENcnevYzJM68eae9w/n/SM=
X-Gm-Gg: ASbGncsT8xTDdswVdPrxAweMMlQSFdybN00H39+Fkw6+2eT7RQKKK+8w+Mu/vjc/GRF
 dlHcGAOQehugk7tQbzpP1mrclG4H6FnRCQO2y0N+9EX5oVzdPLTn0ORr6lkCpCN5jTRzAl7z6sI
 b+ltg8slCZcBnRRjLTSEImknQ4NxcOT4lurLZRffNyCYMYJdAn9p37VK5/rZKjpcl44IbWKcBYz
 vLlSAv2L3F2otCSOLDY6HJrzuLMA/v+FZizxGbuvaDp3+Hh377LpfdsIYllQGu6Mk7jUmTUaTNJ
 W4ba20YcC/LkMA==
X-Google-Smtp-Source: AGHT+IFtLL6Iq5g/FclqS9vJGAfvchCPmgdlE/pahHi06BwzzkKgQrrPzwESR1pFf4aYWzSVqXJK/w==
X-Received: by 2002:a17:902:cf0c:b0:216:3466:7414 with SMTP id
 d9443c01a7336-21fb64ba33amr63633695ad.44.1739283481964; 
 Tue, 11 Feb 2025 06:18:01 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653cac5sm96957545ad.76.2025.02.11.06.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:18:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Maks Mishin <maks.mishinfz@gmail.com>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
In-Reply-To: <20250205162607.2473994-1-maks.mishinFZ@gmail.com>
References: <20250205162607.2473994-1-maks.mishinFZ@gmail.com>
Subject: Re: [PATCH] tools: proftool: Fix potential memory leaks
Message-Id: <173928348118.3071479.11537849221600777721.b4-ty@konsulko.com>
Date: Tue, 11 Feb 2025 08:18:01 -0600
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

On Wed, 05 Feb 2025 19:26:07 +0300, Maks Mishin wrote:

> Dynamic memory, referenced by 'line', is allocated by calling
> function 'calloc' and lost when the function terminates with code -1.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


