Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF81C369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 13:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E37BD81E25;
	Tue, 22 Apr 2025 15:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NCmYFDG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A305819D2; Tue, 22 Apr 2025 15:58:48 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3CE280EE5
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 15:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-603fd257386so1021248eaf.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745330325; x=1745935125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbKlA+CkyeIxA43AQfi0tlpcDJ+SxUM373csFkU+FtM=;
 b=NCmYFDG4Rn5P6gD3UDk09o0+qtLqHBfmpaosbl8zHPCeeJ9ZN7OZPWol0+DUr7sejM
 bUl1DklROYq32FWUKY1eCnSlCeOl3EuiodcHMk4ep7/wOSNY0jJiP+F8zTvJNIPfVo+w
 i0HvzMHcN+6b5t5pYc+sQ04BZEZGHrMcJEPkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745330325; x=1745935125;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vbKlA+CkyeIxA43AQfi0tlpcDJ+SxUM373csFkU+FtM=;
 b=tB3wlNUF/iC10RWstP+BpxzQBwwgxzqQe9KPx7kAQ4kwgNZ6aIxVrMWF+o21tB9n8M
 I2djWm9crgZaUJl6jqcLN3zMxn7g7nR5MhmPoswS5vINNgol0nhHv7ZnAMbPQd01VfLQ
 VkjG9nLy72kWseYOwIhYE8Obpwr4fnylzc2zBiJgDEVkeXy27oSs1WCTfRfwv0COvm8y
 8PIayQB90eQ5YPK/a3OsgYzxG5E9sg9Pwu6vRqVz2LpKThsCrkc7WLTl+3gpryhej2mY
 PAkqvAFrgWbSOz/guUkWMnEEyb0gC4AoxNEQSD4x44vLfP5JWhp9MPtTaV9qkNfE6wn+
 jt7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyOdofHBnPa+9n4E31vfPSZVtOCkKeycl3Di9W5iIf4fL8yu/96syWxlztatJtJ/ucpUM1d5M=@lists.denx.de
X-Gm-Message-State: AOJu0YyiPl42l8k86h7SM4yXKIobfKbQkI42eyMpOMf7SAw21ru6ygc2
 Zk4B1/9bPCeTgSaUkooH5MXQxi+4DPVFQeCDGxa9mSgEDbvtAzxF4NFFPQfyHW8=
X-Gm-Gg: ASbGncvJ4DrtCQKKpG+19FQctBc7ZWjWkWMo4EpikYdCittsycmldOjWfft+cySUOkG
 nZfOJ77LpvwUDsvd+AUUuzBt5NmUO1eRt7VnE7iKvkFqJvTR+3bzC9RUDjxYRJqPyB0Pvr+c1OR
 Ym+yKhPKM4XFKUW9q29DJgpRtLQKER4LxEU0p0HhoJQ9vz09S91mORkpIc5yLdGJMHoI2lWqW3Q
 RDSYcHtyUedpzgz9Upiu+2qMkVkFiuleB3LVRhhWlxyx2o74Kr1UyTsWo0hOyR2LkjKzpbQcfMH
 uVZB72py+4R1HeCFYN4T9Nc2EBFAAfaPRWdhmWDL7Q8kFKdGzEcR6V8lyQ6XGZpcJNRN6muMdVK
 t
X-Google-Smtp-Source: AGHT+IGbpJt6AO6UKdVffJU8qIayWLocvGOLzfQ5zoViG2z0a9UBdAHEudWmIZ/w6Gx7y6z9nCJAyg==
X-Received: by 2002:a05:6820:1ac5:b0:603:fd3b:aef6 with SMTP id
 006d021491bc7-606005e133dmr6697029eaf.8.1745330324665; 
 Tue, 22 Apr 2025 06:58:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff69c9c7sm2094443eaf.28.2025.04.22.06.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 06:58:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joao Marcos Costa <jmcosta944@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, 
 Andrea della Porta <andrea.porta@suse.com>, u-boot@lists.denx.de
In-Reply-To: <20250414131924.86672-1-heinrich.schuchardt@canonical.com>
References: <20250414131924.86672-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] fs/squashfs: avoid illegal free() in sqfs_opendir()
Message-Id: <174533032322.481060.17100639062521683427.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 07:58:43 -0600
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

On Mon, 14 Apr 2025 15:19:24 +0200, Heinrich Schuchardt wrote:

> * Use calloc() to allocate token_list. This avoids an illegal free if
>   sqfs_tokenize() fails.
> * Do not iterate over token_list if it has not been allocated.
> 
> 

Applied to u-boot/master, thanks!

[1/1] fs/squashfs: avoid illegal free() in sqfs_opendir()
      commit: 185fdf5e94731df05748b1c576effb52ff7a3ec5
-- 
Tom


