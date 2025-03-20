Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39040C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 17:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC4C8070C;
	Thu, 20 Mar 2025 18:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vn3mTeJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21082803CC; Thu, 20 Mar 2025 18:40:32 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6C668141E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 18:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso19246385ad.1
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742492428; x=1743097228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcaNaTVv/izIdChPgGBFrga0nzm9rNzKOUC82DIKo/o=;
 b=Vn3mTeJESzALVjbuWWvvfyRgusOS4OH5d+Z6NKZWFLNebKrCmdIYL0sXYBSkppmljW
 kOhIVOeTkrVTy7r199IyQfRazxCGSb4KMZTEH8r9vKZDAt2btrM1VVCTX4xYu5JEKfR9
 U3k4lP7mEy5wYNtK+rxSSABJOeC3bzNi59CW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742492428; x=1743097228;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xcaNaTVv/izIdChPgGBFrga0nzm9rNzKOUC82DIKo/o=;
 b=JRgiaEGtLBlxcNk+jfqoA99QIbSs373Q6KvdVk/9Ei86a7r2IfgyGW8tg3ghUaC9j6
 WLtAQFNBP9s21r79qqQn0Q8PzPMtc6xMx+GkRgMq24SPlD6M+oRxwtTAAJf1+om6KnEo
 WaTVoCVdu+ekrTRkkSkfxMQM+iD4vZNJSnIv29fEk1fG9CSK91rCHcz3RU+dOrfseoqN
 PSRichTVm2YLYSVcubORKhEGZdGJUu1XMQDw5EybhISoSE0gkVpgkUWR2NYJm2yi4c7i
 CnSUH+BcFrYr1cpGQ0NHU7JLZeHOguaYizVSZvZm7IlPmCy8I8lHk9Eq/9R9JVZf5rzY
 VBEA==
X-Gm-Message-State: AOJu0YzEbPTcYTch4G7xaSHwAYgG6wcx57kDJZQpCJ0g++G1Vl4D2B0W
 VaR65xm9KBsYRgynLUl/e5uzWwxvjtN0M53fiK6lnZRvpqgPeLp76LQSQuXYbkk=
X-Gm-Gg: ASbGncvUYoPEAnsFfwU2fVpdqh4dNSvJrOdZ8OsKYNct3HEBLjdL2Jk8TzU0KpS984c
 kF0vj1+eUFHAUpnC2RevmWv3CuhP5GrP/eGUrDDfmdbq5USGgkwynmZQFnlxJlE1OMve0Xb12Dk
 RtGdhq8Q23QpUX9urspzIwn1+so5Jd+wfKLHMT5INTPyIt0vE2TnANFIXWHJOVCabLYec0daJ20
 4WXb0Ecr9TGl9VQTuMoScQLhuWYF8Hi5Y+IdlhCQ/qyrSMpL1qdVNHvlAZIMDsnxrjGGHG7giHl
 AXovMHMg/Xbq4Wcf5E5JxishDgnWHbLB5lKIsAw3H5rV
X-Google-Smtp-Source: AGHT+IHbI/rw+5QJAmhvqh2RBtUl6KrsCniXihArtp32JxWJWJXzXnQgGu66r8WyGZaudoE20CPqSw==
X-Received: by 2002:a17:902:ce0c:b0:21f:5063:d3ca with SMTP id
 d9443c01a7336-2265e743fd5mr76063965ad.16.1742492428270; 
 Thu, 20 Mar 2025 10:40:28 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f45e1asm670475ad.80.2025.03.20.10.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 10:40:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: francesco.dolcini@toradex.com, Stefan Eichenberger <eichest@gmail.com>
Cc: u-boot@lists.denx.de, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
In-Reply-To: <20250319161704.1618876-1-eichest@gmail.com>
References: <20250319161704.1618876-1-eichest@gmail.com>
Subject: Re: [PATCH v1] board: verdin-am62: remove spl_perform_fixups
Message-Id: <174249242733.2082429.3990320978456535754.b4-ty@konsulko.com>
Date: Thu, 20 Mar 2025 11:40:27 -0600
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

On Wed, 19 Mar 2025 17:16:23 +0100, Stefan Eichenberger wrote:

> spl_perform_fixups is redundant in the current implementation. SPLs call
> dram_init during spl_enable_cache in arch/arm/mach-k3/common.c. In
> U-Boot, dram_init and dram_init_banksize are automatically called in
> init_sequence_f. Therefore, SPLs and U-Boot always determine the correct
> RAM size. During Linux boot, fdt_fixup_memory_banks adjusts the RAM size
> in the Linux device tree, ensuring correct RAM usage.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: verdin-am62: remove spl_perform_fixups
      commit: 7ad543619463e8817b3044041ac74749a217bbe0
-- 
Tom


