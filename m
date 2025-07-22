Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2E6C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 19:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 697E2833EC;
	Tue, 22 Jul 2025 21:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lXn4u9TL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A9483439; Tue, 22 Jul 2025 21:46:14 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2EE83403
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 21:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73e58d5108dso3111566a34.3
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753213571; x=1753818371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpeOMB22OyR9E2DyXS59nnWQRtuXQX9jXGPvmunvl8E=;
 b=lXn4u9TLT7iNNsZlqLUcyM894jmGttWpP5EV5yY38ogz1fiqfkUHUpuyPLty19fc9z
 8R0UTZ7U0Vk/KCB3vFVrm+kg3ARG3RyR+Jph9AxJKKAiquhjOJsxBkjYnpSyCKioEyl0
 f5Uei6AvfDc1JJVryoTgXbwiP34ZnIJzVf1cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753213571; x=1753818371;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpeOMB22OyR9E2DyXS59nnWQRtuXQX9jXGPvmunvl8E=;
 b=S24n+1HgU+zLeFAOWFl4Wvy5TuYOb2LVl7rtz5Lg0Mz/r3lfVS6kzVmv0wPZe41xFS
 oRDjIghn5vpEa5tLfoh3CUBVCVhEe6kQBipJsCR+S2+ZR+6ZlyHWuzuxdwlidVVjQHMG
 O7fBiJ8DwL6VnYAZ6VvBOQpqafivND4vw0o9wXwpDaQir5P0HUOc3zc4nZT5Wfv1UFBm
 7iWBcVfJm5hqtgiuZfM0rJMxooIJp7JL8g3LZKtISy8ZbMykKYj4+QtnU9zTDfalIpaD
 vtgmXQ3RuF+Vda+bB1DMGyPdVq+qxWBcUeE9UibKGAgRodBzm5+8hNarzD0vvoiO5iK/
 iqxQ==
X-Gm-Message-State: AOJu0YyNFFj1elPG8Q3LIe+VtKmLPnT4MfydwK88qKpVxDxlqbKxu7ZI
 xMcu1X6AQLFptw/nLvTo22N46btd6dQTo238fIxIPyw2sNEZ2xgb7Hb1eKFUF9EeqSTNYln11nM
 RDTa6
X-Gm-Gg: ASbGncta/O6jsR724gkBL970dpn4h6wWxGNCQXKr+kzR5ODpapeGKQbB5IoQ/9GyQxB
 E2ums+yzpz4Ghe/GH8WphnC2qotVknC8rzKH3hToQ5IK7YrpLW8mvKrfOeJlcD7Mmo7BKdetxUp
 tI1PLbnc/gALeTJMcsGg615JuIS/Lyk2xwnDuv5NtTVDzYGA0rhXeZsHYfvgfYaRzCB7bOCXJml
 2xuCBEJ0OZ3mE7sBVaRDufaqbpIYha95J62u/j3anYqJGM4GxOCpBo2we3lMdbnfmG3G9EpO2UK
 g1h/9PPfX0U091de/xujRR4fHcNpOM/OSgYc8j94O4JIb055Aer/QrK8oSvV97aNL76b6PmCyF5
 Pefj8tgfgVwwKWeaJtGs/zPilJpobvA7nx9W2lRDi4ukTkEQP0UzPXX8=
X-Google-Smtp-Source: AGHT+IHndIUoJliZQ9zss9JLq44B5JpsVudtbgd1EwDtvkVa4GpUWJZOKlYO4qhvFEkBbTO15yUQvQ==
X-Received: by 2002:a05:6830:700e:b0:73e:9e1b:b8c4 with SMTP id
 46e09a7af769-74088ab2b46mr396108a34.16.1753213570739; 
 Tue, 22 Jul 2025 12:46:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0c3fbsm3749811a34.30.2025.07.22.12.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 12:46:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250715-initrd-fixes-v2-1-e2ebbe543464@ti.com>
References: <20250715-initrd-fixes-v2-1-e2ebbe543464@ti.com>
Subject: Re: [PATCH v2] include: env: ti_common: remove bootm_size
Message-Id: <175321356995.77222.7854829287013798713.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 13:46:09 -0600
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

On Tue, 15 Jul 2025 13:47:05 -0500, Bryan Brattlof wrote:

> As the size of 64b ARM kernels, DTs, vendor firmware, and initial ram
> disks continues to grow, the 256MB size limit set aside for image
> processing by the bootm command has become too small for some K3
> reference boards.
> 
> For ARMv7 removing this limit could introduce issues so move the
> bootm_size variable to ti_armv7_keystone2.env and remove the limit for
> any board using a TI K3 SoC.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] include: env: ti_common: remove bootm_size
      commit: babae80169dd4c9ea94f27e3c6f0f4e004f8e71a
-- 
Tom


