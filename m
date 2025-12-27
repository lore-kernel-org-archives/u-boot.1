Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B46E92716
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 20:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF3DA83CF2;
	Sat, 27 Dec 2025 21:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CQrDKLzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98F6B83CD3; Sat, 27 Dec 2025 21:11:59 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FEF783CB9
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 21:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3e89d226c3aso5928046fac.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 12:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766866316; x=1767471116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBEK/kf9BfCnhm6ziAIRHqFXw1RpTBjoYZvjwVrphmc=;
 b=CQrDKLzNNMXbO/Xbi9JiuZNLPoV60fv7GbXjkl1IqX40d1mBEui6iC/S4uXCdxcZ38
 1XPZXfPDyR10+ngUUKAcQNumr4bykeEsNhPWfwZamGkm8hUwV7I0GddBekP+7brbE8TC
 200d0ENqUJt6sbW5zG2B59k5TjiExH5R1RDDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766866316; x=1767471116;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IBEK/kf9BfCnhm6ziAIRHqFXw1RpTBjoYZvjwVrphmc=;
 b=a5NbR19lNcPb+/SELt+qyonhEQAj0QM3KaFjVkUGuuz/v9+pin79UWhVBHm2u97E8c
 RA7zVMiEimL8izpW6yS98fy9zASzLZsH3+rU5h9DskAzXm4FVq284O+ouDmpAVneA5Zl
 2UH8NmQgQhVr1RzGil7nrtNzKT2bf8wGwNMeLH5P1m9tpkrZU8NlnZNBU1WLRQBwBLFE
 uTdPQElr5e06u44INU2T0Bs9B59fJkelRQwUpn4fMmDS7sA0YZsA7YY9XTSZXmC6WfQX
 WzR0KMwJsA/wDWTevIrjtK+u+YPGx+nKPUhohsbKw7Qw5FEIEIP0NVGos0q17u1+WC/V
 i26A==
X-Gm-Message-State: AOJu0YzMaChZvyWsiBEMuBgz1YnvO1L//VKXEl8Lz6DX3iECDSLjANF2
 IJ3KCLk+ViGunaA158nyH3zYuI9FnKuPgUrJu66j1vyHgOozpT8RLSIEarMHL4179LrUQtICxQl
 rWWy3apY=
X-Gm-Gg: AY/fxX6AjF3mtKhmvtY2Zyjtnfj398pJ2M0wQdisdGpu0laFfmwXu8ht4orHwdobQs3
 mGkP9KbOi6y8TaktEg4UMkH27SUnfQiHSVsZAiFbyxXS21dscIsFYsaFnq4NWP9Cqtd8URRRs3e
 uCVVVoMwadf9qaFm9lYhWTg5YEc1RONCrHTsbaQTHrW3e4o291++xbCM0AaXlrUhXLATe8NymRL
 DoHx2UOoALOM0igKJwtYW3EfZj/1h9V9TamArAzs55kmuDjQeP8KMzPTTsFDmXjMaj2hrLqUF5D
 eWiXe0xqpRuQ3FsDCivCrSAEvW772uUNhffRcIHM2fi7koZxuwSplO9Pb06StFhstxzlGL2orWW
 lZ20WrdHP/EqSvSBVJDDGPeGzkdQUuSp0pghJTp3vF1QBmUHvctHwxM/L4CiQ5c0kADh8A5XZvs
 TXPGIofbbcZMRx9nD1pgQ7VSncxxcJb12LjOK4SM7moHJxl8W6
X-Google-Smtp-Source: AGHT+IFHK9q1IcJz+ppH9MUPWoJjUwFvsyqd2dcMKgE0NjD1WqZm/3xFxbn80QDiiVoxoHvMMLllfQ==
X-Received: by 2002:a05:6870:fba8:b0:3ec:a4ed:cf57 with SMTP id
 586e51a60fabf-3fda5239acfmr12786841fac.15.1766866315878; 
 Sat, 27 Dec 2025 12:11:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d366esm16223040fac.5.2025.12.27.12.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 12:11:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20251121161820.11883-1-marek.vasut+renesas@mailbox.org>
References: <20251121161820.11883-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] gpio: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Message-Id: <176686631477.2992512.678750567876362794.b4-ty@konsulko.com>
Date: Sat, 27 Dec 2025 14:11:54 -0600
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

On Fri, 21 Nov 2025 17:17:55 +0100, Marek Vasut wrote:

> If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
> with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
> call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
> and passes result of ofnode_to_offset(node) as an offset parameter into it.
> 
> The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
> fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
> because libfdt can not handle negative node offsets without full tree check,
> which U-Boot inhibits to keep size lower.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] gpio: sandbox: Avoid calling dev_read_*() if CONFIG_OF_PLATDATA=y
      commit: 00967665f6f91529b6aad266c4b09128da88550b
-- 
Tom


