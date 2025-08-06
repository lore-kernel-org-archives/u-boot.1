Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8192EC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 18:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3DDA84366;
	Wed,  6 Aug 2025 20:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QKUUMIhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D513484399; Wed,  6 Aug 2025 20:11:49 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5F78433B
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 20:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-879c214fe6dso2863239f.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754503903; x=1755108703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKjh48cYGm8Z657RjzXYcZ8hA8QU191jzhjdvdT1HTA=;
 b=QKUUMIhCPA44hARhlDDNtfceBbXypaC93ZDgSFejhmGORi1kNgF/yYEeNjm/WwNted
 /FOGci7jk6usTDnJ/BNbAS/w9jr56ScURGJ71no9i/bp4oNqQhmiAZqS15VhacplT9Jk
 H1+avvcCyI1NbfQOSQnCi2/zgl9VX8aQHwxUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754503903; x=1755108703;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKjh48cYGm8Z657RjzXYcZ8hA8QU191jzhjdvdT1HTA=;
 b=LB7n9p36o/esBWReN28oyQj+uZQUh+RjCxuZBn8WRxGHbkkWY6W5yiIQCd+rj/cKTv
 +O5jY8MHKn3MNQ+nJ4C3oiuzbepDpHa8eq4Nwjz56XB0jNOXCbbtZ7jQ5eetKzxudVQg
 QTo7lMR+8GBOBvqjSfvZB+9keIK8UjLVXYJ/sldTCvJIjv/q0oSBP6jPqsdEzCalaX9/
 G8er0m7BVYlSe9rJgQSlAvbuw8SN/qjLcT7N8qVFvm/7xJZYBt0TDHkluSkXHP/mVYQj
 P+7Ljhp2rkXyu8MbhsLdiawW7IcbBSXBccn1p9ZrFeY1mEEfpKayI9A7jIHt/PVpLF10
 WJRA==
X-Gm-Message-State: AOJu0YyEFYtAAZ8u01QlHPohUAfTdiyhKHy/S6/Ee1GNVAjiwLAlxTtc
 2RTKMOYlkmpqVfUaR0PyFGHJJndzhSUcYU9yKNBa87RVQlBd49E06C0hCTzRmauymbmGCRDEDAS
 CcCSYkB0=
X-Gm-Gg: ASbGncuu9dQ+cwwKR2I2wWF1LHYxBmncQsh34XnQ+4QgMJZecPKcHkkGhMNj7XN09KJ
 z8IjvsFwS28n5kSLK/Vj8PPTkyuyJGpI1XCENn8sV0NHPRGUS4ip4AFikXApV/CAxJJFI3uIu75
 YfAgCfGDLakMuR7bTts7oEIVHq3GKPC6vL3PKwzmpo530Wr9QSU2G0qVYhJnKpaBsD7FFpYYqMt
 ksmOMzEfELaH64xrykVRizt+eVRmftCH1RhQGVr3VrT9H15da4K/cHZfvJ9EveEo8b/4dbHndiN
 V5z9Yyz55y7YOO09iGyeAkqwtKna9Hz07M/ysVWzYS3truEvxbroJoXAnW8rCaa/BUM6rVuva8o
 t5PJtvOubAVfPzGOeOTBXoulivuUxKZJJt258G7K1RMa4G7gKPU0Atzs=
X-Google-Smtp-Source: AGHT+IGnfWzVz+4AhJmvyJ1mP6qQE8/0GeyPWBR2NovUpeRRxQGaqbcavnOQej1hV4gl9LZFkXxQgQ==
X-Received: by 2002:a05:6e02:18c6:b0:3e3:b74e:dd1a with SMTP id
 e9e14a558f8ab-3e51b87aaa9mr60729555ab.3.1754503903545; 
 Wed, 06 Aug 2025 11:11:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e402b1961dsm63785845ab.51.2025.08.06.11.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 11:11:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: u-boot@lists.denx.de, "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <17b268fe-0b0c-e8e2-d66f-a7ec0326bc9c@nabladev.com>
References: <17b268fe-0b0c-e8e2-d66f-a7ec0326bc9c@nabladev.com>
Subject: Re: Please pull u-boot-i2c master
Message-Id: <175450390251.1682545.7307277686244755974.b4-ty@konsulko.com>
Date: Wed, 06 Aug 2025 12:11:42 -0600
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

On Wed, 06 Aug 2025 15:13:12 +0200, Heiko Schocher wrote:

> The following changes since commit 007610da2cca405ea7739fc120d90085be4b6ac2:
> 
>    Makefile: Remove expansion of undefined variable (2025-08-04 18:23:16 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-updates-for-2025-10-rc2
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


