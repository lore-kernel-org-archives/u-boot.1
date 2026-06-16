Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ECDCD98E7
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 820DD848D1;
	Tue, 16 Jun 2026 16:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U0LDYdAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE9084869; Tue, 16 Jun 2026 16:53:35 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024F1848BA
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-69e1eae4eb4so3650964eaf.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781621612; x=1782226412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9C1QxsFTB0EhUC6/BDO07qYte8+mbHXlXWvaejLZM84=;
 b=U0LDYdAYmOyXfuUusou+rZtymUalKJEfNDkXDiLacbzn+RU5ibq/9St+lAb6YScV2u
 S5yffQvoMa5Gx+5PLyMJi+UzGBWvn9W/oz4SUfV50mCw6Tc//FzoYPHACNNfFOl1/UJv
 jgZMly2bugwNTJWfCjdmsClm7AhdLBnml3E+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781621612; x=1782226412;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9C1QxsFTB0EhUC6/BDO07qYte8+mbHXlXWvaejLZM84=;
 b=jsgz8IhWbu6eXi+k9yNWJ/znsj09S0vCtWyU1kI5dlWLdeDuKfoBlfo/yL1JnvRG2M
 gbUt2nMdMF6n0vEBpPT9QrCp5tMKU2Rjm3l8KLAep1LEuGPh0FfMabnhRNpxLWPwHjN6
 PBbA2PVHi9TCHvCiS7vAwZuLpdHk1XdmMtTIns6Jw4cKwE/a6RZ/ca1Sg98wQLuyzO7K
 F61oAxcIZn8YrcBVskB4LXFYZ/UKM9+6KOrY0meyq0bKRe3MUUsQsiL22C+oqO7qTvTo
 8tBPhHrKsU/WudkFbdB1yn+QTFF0W/Xikos0dCqN0Pi1smgplKXwBSQePClv/jeuvda/
 7cgQ==
X-Gm-Message-State: AOJu0YyOuXEoJnDGHrdlDZ+Gy71wqOxc3SkQ15rPi4LWdobw/5BFhdHH
 ELdRiCNDp+9YHaXJGNTDbIOzCKARmcUVztDMLSVrsDi5h4qkPZA0gP+fit0jSiadtRR5BQEo8Op
 6mpJ/6pU=
X-Gm-Gg: Acq92OFU4ywQS6xTdpoADrNolZy4g1e0Gzqe7v889IVbq6hyBtA/i51uzDgaepxj/gc
 PmU+6rDkl3Agb3LkL/WWCekTvSS/B/mt3rRWfa8edmq00SDneU1va2lXSiIKONNzDu8I/u+zMDR
 bvMR4BwDHL2PeNDqrwxsgK/HdjbSNT2r1wOILrycK71eI8DTK0F5qDXI8/VQ9fgLIKWqcgbuYZq
 FIhOdOpl4dfrl/yC1fRQgrzsrMdH4m/ffQlqWBxHv14y0UfTmg0eS1nzg6okNzle/MYx/7pcNxa
 3g57iQMXCl9bQN76MRGt200zDhZWrvksuNY7kaxzTw1HvnCy06/Z5bsVJOMwpVixXCIFCcMITsi
 ExIulDU3aS1RfvpvjBv7YUiauV3VariqXRKuOZRbk+D4sIOJdqLbjjHIgRFHOtA43KuRnM+hOxv
 mU4K2o2xkiFbWyQM4vO/MO6p66pgR6yUdzqb3N9mLpwTw+Cz8pb0HJA4FlxnLx1GJ4aKb+d7UbD
 tHjc2+cU7J/NvuTvHh8D14zKq4+3DyHt3269pg9QUUHJc1XuA==
X-Received: by 2002:a05:6820:178b:b0:69e:871a:d144 with SMTP id
 006d021491bc7-69edc6e78d7mr13031044eaf.31.1781621611730; 
 Tue, 16 Jun 2026 07:53:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69f00edacdasm4966357eaf.11.2026.06.16.07.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:53:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260611140857.1522036-1-rv@rasmusvillemoes.dk>
References: <20260611140857.1522036-1-rv@rasmusvillemoes.dk>
Subject: Re: [PATCH] Makefile: let 'make clean' remove files created by
 DEVICE_TREE_DEBUG
Message-Id: <178162161115.1615775.6647777858699026810.b4-ty@konsulko.com>
Date: Tue, 16 Jun 2026 08:53:31 -0600
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

On Thu, 11 Jun 2026 16:08:57 +0200, Rasmus Villemoes wrote:

> Originally, 'make DEVICE_TREE_DEBUG=1' only generated extra output on
> the console. But since 6cdd7597a2f ("kbuild: Produce diff between base
> DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1"), that has also
> left behind lots of files that clutter the repo and are hard to get
> rid of manually.
> 
> Make sure that a 'make clean' will remove those files, and add them to
> .gitignore.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Makefile: let 'make clean' remove files created by DEVICE_TREE_DEBUG
      commit: 79f3e2f8be956575afb339a26325fcd4b15ff1e6
-- 
Tom


