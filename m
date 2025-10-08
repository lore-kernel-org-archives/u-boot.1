Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86115CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 04:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAEF83981;
	Wed,  8 Oct 2025 06:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dQZk9xQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 922F683979; Wed,  8 Oct 2025 06:22:05 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 725E3838F8
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 06:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7a32c0163bfso415887a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 21:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759897322; x=1760502122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+5tpJgjCTdxKCuBmOkYi8pR/rpSuqlxn3Aw+6PYDbJw=;
 b=dQZk9xQCgex/EdunRANHbFXhSKW7XMhXYM0gFngNDW8h4o8L9T7z+ZQ9cnbA1J/MWC
 EYzMOEVYW8Uwxq+iK+hRfYJLHuTFI+arqC7WhCi3EvSzW7BgkCSHfSW3njAxBk3yavNv
 h40xi2ixSwjydqfQNPC7l5V+neXiQt622P3Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759897322; x=1760502122;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5tpJgjCTdxKCuBmOkYi8pR/rpSuqlxn3Aw+6PYDbJw=;
 b=XpI4rVeMUW+10XHV7DH/CogOLXUZjdGXrsSui40vmTnHEwkVTKBFleotlONh5v3zAA
 YVp+BVzUtM2rWtaFX+nXiEyVjntsw3eXS4/gk82g+3OGUi5FtFZk3IbxMegUk1YRpIBR
 Q4RPkDc3U4QMuJGsBTEEGrakoDaAQdJa5uHgNKfBf5+ceLo6G4/rViNO649l9kFmdkaw
 rmgyobZgAVgnjapJV/gXh+WU9uVvhZ9ejNWyXln8Ohgkk1Yz7qOPg48WXELRE0Ylc/lc
 AMLiR7DpqrC+k9igfp7ULpa70JJvydGdcqAMEuxNmfblEuxl93oZ/GKChA0kdS24EbzD
 PGDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSkG1XSELR3SiMoaybZBwnKGN8z/oKVBhIZY2LNWWe4dtaHthRFbv40Eq0ovGoi02jbZUptY8=@lists.denx.de
X-Gm-Message-State: AOJu0YxkOB/RWk5HWS1EBr9z5hFBy6sjCl8k0mHLLHEtEkVZBC24TR8c
 Hw2pkQD4BmnXM70VtS6J/kHqm/7hXU8/+qR5YV8gIENTC5Dy1Vw6oDDXY8KkGicAv64=
X-Gm-Gg: ASbGnctlWJ49FQXqIjfKMsRjbuh0HjK1BKXVRLonPPUmu5Ny2Sz3yDQLMvWx2Lg2fVb
 20AAHn2wy9d4dSsjlSSSsdVsf+8JizFDBWoNr66cYKtct4vzOH93+BuiE0XPm7YWaJIzcgFDmt4
 BYzL+awjVWBJu+gGpt7TESAAdoSDNF5P3cYIuKSN9FQa/3xrgXSNmo8g4gnutkVC3sbGYjxbfaL
 iCynQnjj50QM16U2YEg9J1m9eC1N8WEk2hddVZxK92d0wMxNftbysM+IyYfjElzk4W+/LWfs+mQ
 4hPM91GnNApqAIP+He2mC9YvEXvnetXeTKp2h9we3W/TvyDjbPnLVl4uWRHNXmwpqtrqA+Vc/nt
 REUa9D7/oNnrSOEpXlt4uTxqeNMA3BdyBjMltYHJwQH8yzbVv/sSyF+NU9lP+6HOGGWd7KfnnXf
 VqnWgAYnrKxfcKi+qjusQ=
X-Google-Smtp-Source: AGHT+IFhzmo/qNHzA0BpSLoWchv4pa92E1KkUvOnSQpS9glTbwlSph2d64xSYwYdGBsk9BkqU0eLNw==
X-Received: by 2002:a05:6808:6902:b0:43f:4ad3:df09 with SMTP id
 5614622812f47-43fefc09c07mr3121179b6e.10.1759897322057; 
 Tue, 07 Oct 2025 21:22:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e1bc7f424sm3818016eaf.17.2025.10.07.21.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 21:22:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250910083737.9263-1-ansuelsmth@gmail.com>
References: <20250910083737.9263-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v3] airoha: rework RAM size handling to support
 multiple RAM size
Message-Id: <175989732044.1794629.510734599893677442.b4-ty@konsulko.com>
Date: Tue, 07 Oct 2025 22:22:00 -0600
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

On Wed, 10 Sep 2025 10:37:35 +0200, Christian Marangi wrote:

> There are multiple version of the same reference board with different
> RAM size and it's not enough to base the RAM size entirely from DT. To
> better support it use the get_ram_size way to scan for the actual RAM
> size of Airoha SoC and increase the size of the memory map.
> 
> Also rework the memory map to account for 2 memory map. The first one of
> 2GB for 32bit DMA and for safe usage of U-Boot. The second one for the
> rest of the RAM since up to 8GB are supported.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] airoha: rework RAM size handling to support multiple RAM size
      commit: 726404a66c773d8ee1b2d25725f3a6ef470f1b3e
-- 
Tom


