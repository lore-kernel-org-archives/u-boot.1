Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C75CCF9F1
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F380B838AE;
	Wed, 29 Oct 2025 00:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KEL5lx3S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C3683849; Wed, 29 Oct 2025 00:57:35 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A90B5836B4
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c52ce8cbe7so3564663a34.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695852; x=1762300652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iu/+X1T23JI2WScX3+XbUTFH4jMoQXXZJuEjScAbkTw=;
 b=KEL5lx3S2e/1s0voIWhEk7zH9mfi4HYiTjv0GbcxvPwoN6yLwT10Z8GgMLElZKyMAC
 7uDrJ54ZOGhEuHZ+I5zV077qiOLMz3UVU8MAaSqYU/2CqLBCKxhR9JNfSKPfTlXfraF0
 3nwU3dNKkiJyfNFATS57mR1uHgXUJx1MTxk2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695852; x=1762300652;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iu/+X1T23JI2WScX3+XbUTFH4jMoQXXZJuEjScAbkTw=;
 b=CuCcRgVQEZ2qk4zlhhWAb60+EUkGv2S446X8vwgLkRhAB6Akki3p2fxanqlbGaA4Te
 sE52lUlG05JoLLtK9JIUbs4kyx62rTCscIeNEs0A874tIit/OoSkiK/5pLeaMdRcqujd
 p1Gc3K8Coz5cUEIs/EJZ8VVI0vy5ceJhCxObHyel80b//XdrvqxkZiZGdvTpVvewWgcQ
 PdnIfHnZn2dZwzCxds6eDtJ2ZbkJBtsg7InzNvBMAQt1Bt0Tu152FDaXJz06HAAQtRHf
 h0M41x7C5bA0NFofAFx0g05RhC1/nbRnnyUFAIhTPm3q4wTCLSv3yVpsaGteUuwrmbZQ
 OfWQ==
X-Gm-Message-State: AOJu0YwN841vQ5IqLGxOof+ZTYUlKMJ8wj8MgbSIqshfrDatp90qcjSm
 TNLxh1FsfeYz7a1IWXFZbYxfETQYD4iKIl54cipgxsvuvACcoAerKaP6lyW2EGUVu/nJ6LnANya
 N/eJMWhFU4w==
X-Gm-Gg: ASbGncuVj3DUwxhAjigM2ZFrWRDxYjKIEqgx3TPASGqa0TPA6C67c1v9JqrV7mjBcVC
 EhZ5fGThHINEK51ahA5x02GDgoORcxgxeYHhV39N2BbFMVHfRirx+E0sTUsjR0P8kOxh3Lg9eYK
 I0hR+bunrcn6zn3S2heDHgbOFhqsQnX221eX2iPkzyyzrW2WWYu0WF6446lUzHzGdwIrV7uVVrZ
 dUaOPk0s0aUuDpNuPXnld/hjaw4dCqA0onrT5H/h8YnP1ah0n5UeAThBKOrwtrWGa1skZ6IN0JX
 lwpaXKwu+HCyMmEXxXGi85bnBXeB9L0LfyNZShM1w4qxtaRQ0+IoJ7HWshA4RHrwUU2CIqG58qD
 N7CJ7d8BUA3VU9xJwe9zYnSL4PXf4dl3l7/I+9/rilI4rgpX56KXzxtVeds3wT3mYCUGb86I+3N
 f47EZ6AIjJI0+mjLIo+D0en+Ls+cUqYDpB/XWbg5nBC6n5eU0h
X-Google-Smtp-Source: AGHT+IGikjW2ep7v/CgSuigz85smdzv9jcNvnRYrMFg9Sy/pE5jcB9sWGhdWExVxpc8rdYY5Eh4tAA==
X-Received: by 2002:a05:6830:3c88:b0:7a6:41cd:b7d9 with SMTP id
 46e09a7af769-7c6830659b3mr845812a34.16.1761695852452; 
 Tue, 28 Oct 2025 16:57:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
In-Reply-To: <20250702010609.19381-1-trini@konsulko.com>
References: <20250702010609.19381-1-trini@konsulko.com>
Subject: Re: [PATCH] mtd: Add function prototype for mtd_read_oob_bf(...)
Message-Id: <176169585106.2287207.17987539032537284568.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:31 -0600
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

On Tue, 01 Jul 2025 19:06:09 -0600, Tom Rini wrote:

> The function mtd_read_oob_bf is called by cmd/nand.c but does not have a
> prototype in any header. Add this to include/linux/mtd/mtd.h as that is
> the most logical place currently.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mtd: Add function prototype for mtd_read_oob_bf(...)
      commit: 9465ca3d4559f596b1d3f65e7b2d66f50080bdd4
-- 
Tom


