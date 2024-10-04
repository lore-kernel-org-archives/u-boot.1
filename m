Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E1ACF8853
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 17:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D708188D36;
	Fri,  4 Oct 2024 19:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="slg5CPgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D69088C4C; Fri,  4 Oct 2024 19:15:28 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F17D88C98
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 19:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb29ff33c5so19525206d6.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728062125; x=1728666925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4STutji+D1EYnKEyby8E5pWpveBkEN/P33bf5PcjSts=;
 b=slg5CPgP6n7WFJbsKWJXFKKnoiUAWRfmAwy/yweHYpcWULWNIX0J9rFjdbzywSU2EE
 z+dm7Jzice+5Sexxs0fbdOlxjF5k51cAgCcU8rofwpvXni12UKlZ5YGpL6DF3KEXcpm6
 vRQgMgjHEd+4hgWPa9pW4j94zmqEY8kJHnfJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728062125; x=1728666925;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4STutji+D1EYnKEyby8E5pWpveBkEN/P33bf5PcjSts=;
 b=OZwHgai+1NL4TJJZ7VO94zWNpuPAESH0fKeOaOIs+wi7wjMJVkPQFpEGmi2ShoyC4/
 MzdN/80t91YQV9EZAqFApBIshjVD4DLfjtmBGLC4XT+A7Dgh1qZaM6FzJkYkVFB8A8z5
 Fhp3G+gsqjVsTBDk+LoXzfSzU5n5Rrnm+Wk2zis9PUH3x6xSoL6l5RY67XWGW83dSRmc
 oLPiT5lKHOh1KRwB7prd/PsGolXJBqsC7MH5LKbKJ6nJq5hofZO/RwODN11VX7QuiMCT
 PjBlFWKyLRBR8KIwaU0UpzIjnT8mLC32mdHKuGG3+BSFYuvdtik5jqxZHL739wVUyWdJ
 kOqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxGgDZDmMeExmuqzPRjvh25N3XAHBGk1JVPrEclvtCxyb+k15hFWPurFlvE8PeWnMKQJsOcpI=@lists.denx.de
X-Gm-Message-State: AOJu0YwbcF1lIfmYjJvlha79yqxcPei0Jkz9TAMgSAoy0fKnd0Nivp2B
 dX4KFc88MR69LZih1bZYu89C6vuBeD4osCLGi2Ylh0mz0Xu2l/FDGjEpBPMPZ4+epgipvXMhno+
 5
X-Google-Smtp-Source: AGHT+IGUiigfjyOQ0fFRjV22uCmMyQRhAV5+xIGT7TMuN8cKgewyrQy1lyYv5kB07H5adA0czBXxHg==
X-Received: by 2002:a05:6214:4507:b0:6cb:4b6e:9162 with SMTP id
 6a1803df08f44-6cb9a454fa6mr41514206d6.33.1728062125284; 
 Fri, 04 Oct 2024 10:15:25 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46df36esm986726d6.30.2024.10.04.10.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 10:15:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Diederik de Haas <didi.debian@cknow.org>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20241004104055.438529-1-pbrobinson@gmail.com>
References: <20241004104055.438529-1-pbrobinson@gmail.com>
Subject: Re: [PATCH] Update directories for new name of TF-A directories
Message-Id: <172806212451.2290501.1530603422323377250.b4-ty@konsulko.com>
Date: Fri, 04 Oct 2024 11:15:24 -0600
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

On Fri, 04 Oct 2024 11:40:44 +0100, Peter Robinson wrote:

> The TF-A URL was updated, as a result the name of the
> directory changed as part of the new git URL and not
> all the referenced directories were updated.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


