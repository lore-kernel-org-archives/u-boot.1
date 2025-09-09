Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4416ECA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 18:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 138B8831A4;
	Tue,  9 Sep 2025 20:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OixRF3ii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E4E830A0; Tue,  9 Sep 2025 20:31:43 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D76F831BE
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 20:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-4023132bd4aso18406725ab.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757442697; x=1758047497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tv7MzrYax6y16rc+2Ok9qV275ZkNazDB0itpPp0O0UI=;
 b=OixRF3iiswrLcXdT9ZWP7CX6k3pMWAnPV7I7lzr2tKNW08eROk6kfyuoutahmsE1vq
 MZeEqrkG9sTZf4Jj/tuIoz90eHAV1iDa5jJoPkwM5Y0KwSgI8gtR0GjCIZh3Tvo09rsQ
 0LWkMimidgJTfCD9M9HcGQW++jmC0w9r/Wn4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757442697; x=1758047497;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tv7MzrYax6y16rc+2Ok9qV275ZkNazDB0itpPp0O0UI=;
 b=drT4xrzWjHcD7Jn6fktbsJIfp+JAvzW146RwhgtP0fIc6olZuDjg+0XW4uDeUpQGSB
 dXQy8VHUAD8sI0JTiyCos5EtkXfEHW1BQWaMzJ2soMZR7nNAtRbTLFSKZinzjDbD1ueP
 qvFXSWHruJ8h5JMVCBBvVRU7ZYg75bfXnOz9ivqo+HOlJkn5oR9zHFHsnvXMXAkWrV2N
 jJTNF5qNOcPI5PKzXZE/wxVYPbPG+rzEwgUDmeHDsfL8rQYvKWfjyg7soxyyM54DGOWI
 yCcEur/13KaRCGncRPvJBfNkHoCsdk7lkK+CdHDsRO3qyhev2MjzBWitPWZ63GNR/aZA
 6aiQ==
X-Gm-Message-State: AOJu0Yx7L6peYsGIJ7XKv/WQSCOAVmBC3Tb+OTwkIdMlHCT02qYAIvZe
 NM/1NTVgSnNkKEZU1oavqEySMYdJPBFo8QfwIIE10/vFCBBuEoxJtB+SlD6lAFGPhZY=
X-Gm-Gg: ASbGncs1eaYwR1C2cRTIE3t3VB9b+Cn/LReu1moK0li1LYH4MVL9YikL16HZVzLIbwx
 1GnVzs88q3sARtaBrektyeFbhhR2RTcIPYLxFOznXtXNkvrVp2m55ul4sUDG02jz0GMIVl3wPMQ
 Siq80T6crGHey1KT++9gh6MPN0CL++MgxcCw+D8Gq2BQymQgi8rVpNcrzYLTxrPM13I/RfWzZsR
 tKzO15bY/2j2tHdCvnqi1Qd8bX6dWMIzsV62K1pxkiR+Ndk+DXtTOQQullnnHQMTfy9Zw4A4D0W
 Ed6JOb6dzhq4J88kUVjzYP6ap9O6+QroW71ozI/qSGHksmDry6w0mKqUq44G8xLgtrs5mUFvYtZ
 mcOJ+caTigtxoj6gLJ0Nx39nlB5eiZG6erZWFl+1oJD8IqLWHjr7ONr/53HMJuRAmJQ==
X-Google-Smtp-Source: AGHT+IEg15PYBDbh1qS9AgWgjNWYRw2bKMmkTLYeJmqdIZtlDevWElQxOx2ElrKQbwZqKcHemKbJ1A==
X-Received: by 2002:a05:6e02:1a81:b0:3ed:a4b6:55d3 with SMTP id
 e9e14a558f8ab-3fd7fa3761bmr196378005ab.10.1757442697057; 
 Tue, 09 Sep 2025 11:31:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-403c8eb8884sm32715295ab.33.2025.09.09.11.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 11:31:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Sascha Silbe <sascha-pgp@silbe.org>
In-Reply-To: <20250818165119.3193853-1-trini@konsulko.com>
References: <20250818165119.3193853-1-trini@konsulko.com>
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
Message-Id: <175744269617.1809471.12193838473241850193.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 12:31:36 -0600
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

On Mon, 18 Aug 2025 10:51:19 -0600, Tom Rini wrote:

> At this time there are still major Linux distributions which by default
> boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> DISTRO_DEFAULTS to ensure these platforms can still boot.
> 
> 

Applied to u-boot/next, thanks!

[1/1] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
      commit: aff7f1314a14ab2af5dbb04a33744c1c4db5aef7
-- 
Tom


