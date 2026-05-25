Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C72CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 22:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7490084913;
	Tue, 26 May 2026 00:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bh/Hs9h8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9528490D; Tue, 26 May 2026 00:43:23 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0165484859
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de7c57b52cso8707917a34.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779749000; x=1780353800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmmYs6o8MLyDMzK697G9Xx0ZbqyEl5ryb3A8tTZqvbI=;
 b=bh/Hs9h89G3NTwR147btII4CJes56PjHNA269fnqOklOB7d0rjb6ZOq5dORuTvT7A7
 NFUUZzP+ONdv9ZS/f+JGiQ86n5/D4L4vWXXVLP45oLXLHmrZj0piMbfDR5ME6rOjwtxy
 QW8ODiZQXze9lbSz4ddPtpivVZW1kJ6htrFeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779749000; x=1780353800;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pmmYs6o8MLyDMzK697G9Xx0ZbqyEl5ryb3A8tTZqvbI=;
 b=Lt4Csa4cPALpVvs9BWdvbhZhIo2OgK5+j7SZop5VST/4C2OZA+uEr2xiIxRQaJOs+R
 PFjX4fjZd4SB8Y4NGlwZVbutKLQqyc0aVN7HgT33BkqOLH2lfxJMt9akMB2FOslCs0nQ
 AqVL4skqj6Iw54D5dPhyXCWX9DjpNcIR8tZxI5scBLHytxhYj29++BLGD8OM3sT/fwoK
 kR18n8KpAzg8d9ByOHpEa6HaNS87lkjuBt+ynR78oFXbwL98Z4E4WUbYDcyUvvcSVcA3
 rx2JShdY2uaDe6TdH2Qkxh4+1sFFxF3ZmzMQq5Mk7wyRgHLrwV7Bev5tkLomdW0vqULv
 yDrQ==
X-Gm-Message-State: AOJu0Ywk0fjWT5MTNfqXdNMXrI3cGKnVx6IwBntFCqpc7ROOS02w6+MV
 bIZKrePHYKZJB07v1Z5O101HQ7fNWy6qxmqcsU7gWPvmnF+xlrDwz+3zM1gOGy1vEnQ=
X-Gm-Gg: Acq92OFf5dK8EWPUZ8gxoNMPok5FuVSUxi8j8mYIOqFX11WhwexD399eNesNuznoAzm
 DLrVAsRfTzRk42g9+7cpFONoPmDg2KqsXnM84SN0TUu4OKm4psqeGRWo2YATPMEJ/vCuscRfH0Y
 2i5+1B5kIFcFBZTQ1j++L10tKHOBYLsHd7d6/BIuq98O02CUpWuLzCATZMaDPWJkjk0Ies9U6xt
 TU19z4kD3kzOFJ9T+3SQXgRXTRfeWx+8MqrlnLfCGR+3zCWcyZ1f0AlLQos/3C4RWvzpR1iYrwI
 OV67t7mTU6Tdq/mR8LKGK5qWJHgNf2zJnVJOWQtKhGhg0te1u26aYxJ1rwI0MEe67xamx8JJe9N
 b4RbIyYU5yLVsf0mGljtjvB9gQ+Xgi1deoeacx7qQCjZXPax2xiVVrgaya7ncvVj8ietl8DQMrK
 HqMdsXXQQUPypyb4r/JCWLwaqHoODRDSJwh6WJXcitxq8HaP2wp8ngz6CLNHa3yCPhUr1j39oOZ
 5ClfUTSaeaPqsW/dNTBqXN7xajxcYjOwW82Ke8t/NCG
X-Received: by 2002:a05:6830:82fc:b0:7e1:cba6:9837 with SMTP id
 46e09a7af769-7e5fed7ddd3mr9745641a34.6.1779748999641; 
 Mon, 25 May 2026 15:43:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606667796sm8076073a34.23.2026.05.25.15.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:43:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
Cc: Huang Jianan <jnhuang95@gmail.com>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-erofs@lists.ozlabs.org
In-Reply-To: <20260511085857.3933053-1-aristo.chen@canonical.com>
References: <20260511085857.3933053-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 1/1] test: fs: Use shared generate_file from utils
Message-Id: <177974899874.3696278.287402852405420815.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 16:43:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 11 May 2026 08:58:50 +0000, Aristo Chen wrote:

> test_fs/test_erofs.py and test_fs/test_squashfs/sqfs_common.py both
> defined a generate_file() helper that writes a file of a given size
> filled with 'x'. The two functions were functionally identical and
> differed only in parameter names and docstrings.
> 
> Move the helper into the existing test/py/utils.py module, which is
> the established home for generic test utilities (md5sum_file,
> PersistentRandomFile, attempt_to_open_file). Update both call sites
> to use it.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] test: fs: Use shared generate_file from utils
      commit: e9848e30bd88bf889ef74799dab6c2a2a0628890
-- 
Tom


