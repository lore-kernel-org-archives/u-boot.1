Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6FEC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04C28070C;
	Tue, 22 Apr 2025 16:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RkBRRJSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B965C81F4D; Tue, 22 Apr 2025 16:54:23 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B389F8059A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 99B8E41A1B
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745333660;
 bh=fMmkUzYx5mkGgRAd+fjXaK5fZpyOiQ2GI3izTXt/PIM=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=RkBRRJSKh9VxqSCUwOxsDNjk9VM6nrrqEknvJh0q4zm8i0Z7IXOa6VHnpJwVDG62p
 C+CvSnTPALTpnZWrLCUUPauCniob7K3paJdMEYejrB50qZycu4bsb0d/kEfcFq71hK
 wVSYI1GMdqbCVS/6EEFThvOo4e7KHmGeGZwACh40VAObvppJNOQGTGVybEQvua5ZHU
 CjtrbSfPqQI57K22NXFyX9DLAwcZtO+8aszHDL/x6efdlUojBn4tb7phX9R610kzsz
 4jNxqjoWAhy2UMouaoMT1kh25e/7Jla2qe0w7AsODxQQXXHfsOUPakLAdSy8faZ2DU
 7gUrCv9m8cXjg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912539665cso2668974f8f.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 07:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333660; x=1745938460;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fMmkUzYx5mkGgRAd+fjXaK5fZpyOiQ2GI3izTXt/PIM=;
 b=GNAcKGxbLYoPtd3aRdD3YWUP1bgtCnZiORkNG5snH/ezdBvKBSfPD/JI1bB/7h11vT
 UhhBIqkK46w2ZzrkxXFyKm/0q0+fVD3WmxrMwaBRk1vam8uKANt7BXMGkhnyYPNCRD8G
 w/d9EMni2di1BUUgwjaw8Xk4yvxoJPn1rJoWiyTBUVy/ehjy0+G1Ro8u//F25h1W0+29
 sxUNwAM+hWSP/hVDsN6IJCOpuGd3gJX0LNKn9cnlcWfT5RZ0zDbHFiHtgJyZJ8lQiITe
 2KjBhmRZOfBwKjvybpi8/A/jOefY/h53/wEDieHHkeJDxSQ/7HGLm7vZ9sm7RDS+8WDC
 1R7g==
X-Gm-Message-State: AOJu0YxF4IkNofmLahbMWXK5SnOOFtDkieJuOI4SxJe5IHneUjjWuHKD
 MIFGq1kdKPktevY+MCWDNf1wlmNLjMmMxXp/c4EeAKdmy9OHfh+xxFvPxLFbdnpUih0ce2A8n6v
 L42DnfZx6LRIg/EO2SH5c4Dxwk1t2JO9YjwdkApQuaWn9FaqC0bBqmwcqOosKhhahc2M=
X-Gm-Gg: ASbGncunA28erUNmS3KZVeBhjTgPoE2t/1OdeZY4TaQ25g6aKyZiQ8+jxpqYUNhnPgG
 ly6MnBeYY3TBhN24Vlu5ngTvWTAszVgWZNSoItY4mJ26fxza7U4UcxA4ZwvCwIilRlpmqnlkCGm
 YGor0FgT3N9IfYk6WKQR69XCVXZc0738YPtmywwWx1j5oRUNuQRURD5qqHimHqxPGGGWtdbWSmm
 ysvOqxGKJ8T0y7PqUwSTgm1ypIgquDlgHEtV5xvIOcATsFAmGP8ZFecNK0bW0F/+VjsGrYGZ2Gc
 aN/f1U86YEDIRLgOA/NiEW9f1BEekWTtHofNBgwLUQnwzUlb0qw0l3hok2PJp+3LwbMvMRpWrzH
 mikJ26ycU
X-Received: by 2002:a05:6000:4212:b0:39c:1258:d12c with SMTP id
 ffacd0b85a97d-39ef9468079mr11985938f8f.28.1745333660053; 
 Tue, 22 Apr 2025 07:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+bpm/ojpIyou9nUzKsogUYgfXmHbNnH70tVXJAhYLof2l0FyEqkCHbls+r001/BvfOaw35A==
X-Received: by 2002:a05:6000:4212:b0:39c:1258:d12c with SMTP id
 ffacd0b85a97d-39ef9468079mr11985916f8f.28.1745333659671; 
 Tue, 22 Apr 2025 07:54:19 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa493255sm15663663f8f.69.2025.04.22.07.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 07:54:19 -0700 (PDT)
Message-ID: <c301b266-ba62-47c8-a484-4006dab5036a@canonical.com>
Date: Tue, 22 Apr 2025 16:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: PXE is broken on LWIP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Jerome

PXE booting from standard boot with NET_LWIP just stalls if the server 
does not respond:

Using ethernet@16030000 device
TFTP from server 192.168.99.1; our IP address is 192.168.99.47
Filename 'pxelinux.cfg/01-6c-cf-39-00-2d-29'.
Load address: 0x45900000
Loading:

If a server cannot be connected, the network loop should be exited.

When pressing CTRL-C multiple times I see crashes with a call chain

tftp_open -> sys_check_timeouts -> memp_free -> do_memp_free_pool

I guess in sys_check_timeouts() we must remove timed-out timers from the 
chain to avoid freeing them twice.

Best regards

Heinrich


