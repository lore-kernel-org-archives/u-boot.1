Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567BED1CA0E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 01:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2A9B89009;
	Tue,  5 Nov 2024 02:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TJ+HAg7d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E96E88CF1; Tue,  5 Nov 2024 02:07:16 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D38589000
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 02:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b14443a71eso412761185a.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 17:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730768831; x=1731373631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OKgdyUdFBsRyeEmbYZMrW4F3Jwk1ZwBDKIz0N35mmtI=;
 b=TJ+HAg7dBRVJPaIGXsIn4ScWGd2ZcVinFCF8qXD7SuJsplEztGN7QR6jpdH4BGK0ow
 /JgQCJPtE0qc3ANgY/k/5P6yqKXNCDwrbHXwykcMv91j7rF94K8TlAFnRbNlusuiELIB
 /LmtsYIMFHtJMCOjW6Fbo+h5bv3HLRFt0lKoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730768831; x=1731373631;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKgdyUdFBsRyeEmbYZMrW4F3Jwk1ZwBDKIz0N35mmtI=;
 b=uKIzMKSbKFntNem6+XdgXjvxTEzjq95ajppeWaU7u4kz2agWBLnlot44HDrOl+fNpr
 TjHBrt7N9LTxNQ2YUFpAUpUQUIg8oo2DrRtYzhGAOjUYnk7lUbJGzoPAKVSE02ZeHt+q
 kXUqTag0IZLtgBJ2Qz8xkqucdmWUE7g4Ql6XJauaGzYcU106MLg6dYAEugxVSpOBCWhN
 AENcaylL4hIaxY5cjsTFNqepvz8pJPFqFQRCZvggyUE350Q6Ib8I/a/dCOZuyx478izD
 EX/iCC9ey+NkwFN91zaU9u6G5Vhnazg8ZyVmkLucEUp2c+bVzD4AKEhKWeyjoociAJ8T
 Cthg==
X-Gm-Message-State: AOJu0Yzj6c3YNzoeKVD2iImOAEA3EfJvZWBmWrRSt7RcQho9VIbCAOar
 YSz//jBSEumKpTJqnVuRtwkg6dLrs0ZTWFgaERqshOt9WN3r281L4xl3dTvTe+4=
X-Google-Smtp-Source: AGHT+IF2oVgYGJyL1xK0phpxDwTZWp9Y3YdC4CEsQ9M3WQ0Iapw9ShHKqvyQ94TeKwb64rEug7EIqA==
X-Received: by 2002:a05:6214:2f85:b0:6cb:fb58:3d23 with SMTP id
 6a1803df08f44-6d35c1aedb4mr186341566d6.43.1730768831522; 
 Mon, 04 Nov 2024 17:07:11 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fcc777sm54436686d6.56.2024.11.04.17.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 17:07:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@vodafonemail.de>
In-Reply-To: <ZyKLLBASJfMDk0QX@qrv-systems.net>
References: <ZyKLLBASJfMDk0QX@qrv-systems.net>
Subject: Re: [PATCH] bios_emulator: fix first argument of
 pci_{read,write}_config_* function calls
Message-Id: <173076883058.3917422.16778774532285473707.b4-ty@konsulko.com>
Date: Mon, 04 Nov 2024 19:07:10 -0600
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

On Wed, 30 Oct 2024 20:38:20 +0100, Yuri Zaporozhets wrote:

> When compiling for riscv64, a bunch of warning is produced for the file
> drivers/bios_emulator/besys.c. This patch fixes a portion of those warnings,
> caused by incorrect first argument to pci_{read,write}_config_* functions.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


