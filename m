Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68242CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 18:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94889835C9;
	Wed, 24 Sep 2025 20:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JLXbbaTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A5C835D8; Wed, 24 Sep 2025 20:16:38 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5D2835C9
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 20:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-4248a13fbe9so507185ab.1
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758737795; x=1759342595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dUff/BDD2EVqxcD6Whx8cFi4cIxD5qNhj3hmZHXvKg=;
 b=JLXbbaTUbt9UQiWl15ngqwKithmldzehGR3/Vmnq2k/2WT+SsVBxuVfVK//Ed/wm+7
 0iYIGOtLs4hgz3HGzES7KCYuibWcK4oazHKKI/BJgOzhMVobVVg7KJ88A4WDaV9oQCon
 Q/uoTVBL4R8YNFW4fUz7vKg6bZdSc3QN4tCjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758737795; x=1759342595;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dUff/BDD2EVqxcD6Whx8cFi4cIxD5qNhj3hmZHXvKg=;
 b=XI1SKr5NcpJBkWbyXG6R7sYKfpRr+Ja/ARw54voLo8Svcd8wbF3SwN5X8NKyhvSDjW
 PX9K1igPxWFDv3kNDMPMPFGFcQ7ynktlgAK6KGo/U9xQiZT4GTDlkysJmafX4EBe+09Z
 8RfcfH4qVCQB9IZCljDPgPdwggmvLbqHtdQlk0W5u64rciCvZSkA89u/Zf3bjihyQK5X
 pXQPmyI6o7Dub3u0LMwXgf41Pf5DL22KG7pIFzS3YL+TULegaGvTP4ruKvoGhegYBBkl
 +HViUTtewXBGlsIr6Mtru4QjLR4TFXdr1J2bOKVXwUE7V2+le5wkfZn40p7TxL782HOw
 S1jA==
X-Gm-Message-State: AOJu0Yzgc4iK3O+Oiy3YRDjY1F2LUDRy0LFKTnuwB3swkC3zp+ntpRso
 NW95QZLXKOZ6mDfxwuWwCdTTQIdwFpnhOWVnAvz16whmLg38XBQsSP8F6+x7Kl95nxo=
X-Gm-Gg: ASbGnctxtFEwvfXBT+5RHMBDg6a1ZcpkeLRBv0kIdhhr5iF+i7UHCcqv8LoxUg34WTE
 l7L9lMqm4dqnyLyGZhhaEWRBk5TzQi9YtB+8JVjcS2jPW3z3/c+YyxoTcZKyT1ZDrxgse/YyJYu
 9oE9RAis847vPIZYB789RnvFU2RBoW6LGKIxKhm7MWZ7fhA9bsdiY0tRU70ScPVa5zXxPJ4rLJ7
 Fs70iH4x6Z1pgOVX4FTfjhleMkLauO/+wd97inQEYI4K0rXc3IDIWNqbofDiACKS+y9BX23tXct
 XoyfBIlCZ+fhvr9tejUhOKRsvtbxkSxxU6M+3AgeiCUpHS1a2TvO0oTNlhfhF/lDpPq6YKi5zWj
 rAx8NpYt6ftFNMlwqSlLnm2P/qVv3VyBsq1J+99Iej0qSuihfxHNBXhc=
X-Google-Smtp-Source: AGHT+IE3JX82EVbtJj2Cv8rxaiDouHufqiE8ndTdo7NsawH+V27LPyPxk5BQevSJ+A3IEViPfDG1EA==
X-Received: by 2002:a05:6e02:3313:b0:423:f924:c885 with SMTP id
 e9e14a558f8ab-425955ed8admr9009575ab.13.1758737795455; 
 Wed, 24 Sep 2025 11:16:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4244a493b40sm84122645ab.12.2025.09.24.11.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 11:16:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250914152727.784016-1-osama.abdelkader@gmail.com>
References: <20250914152727.784016-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH] sandbox: use env_get() for time offset instead of getenv()
Message-Id: <175873779459.361751.3860884266527575580.b4-ty@konsulko.com>
Date: Wed, 24 Sep 2025 12:16:34 -0600
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

On Sun, 14 Sep 2025 17:27:27 +0200, Osama Abdelkader wrote:

> The sandbox time offset is intended to be controlled via the U-Boot
> environment, not the host process environment. Update os_get_time_offset()
> to use env_get() instead of the libc getenv().
> 
> Leave other getenv() uses (e.g. U_BOOT_PERSISTENT_DATA_DIR,
> UBOOT_SB_FUZZ_TEST) unchanged, since those refer to host environment
> variables needed by sandbox tests.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] sandbox: use env_get() for time offset instead of getenv()
      commit: 8558aaa3cf9065ab5ec9a0b241ce567e7393dbc3
-- 
Tom


