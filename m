Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615E7EE6B43
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 18:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F7E83C2B;
	Fri,  6 Feb 2026 19:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sbishmm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1781283BC4; Fri,  6 Feb 2026 19:15:28 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0695383B86
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 19:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7cfd95f77a3so669775a34.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 10:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770401725; x=1771006525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DkBv+9FPlklIVt7aHZIa22V7+qCWLHm96W1vI9GJpY=;
 b=Sbishmm3n7Z6Rw6+rrcH7uCUs1uSPfSk7z5eaJW175VnSZkQsT23Jve4UF5gyF+6p6
 SyrWgBpRYM1kToqXV4iT0jfcKmlnGat0+fsQolkiEO3ErSACC26HGX3rET+JICRwoydJ
 j9yQQLC9+4zNM+1l0tZbfgZcYU1bz8c/QKQL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401725; x=1771006525;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5DkBv+9FPlklIVt7aHZIa22V7+qCWLHm96W1vI9GJpY=;
 b=wxoT6gJlUS5SYCk+xvZWW5WGh8b5lIqXALB1RBHLz4s8PcG+eaQQuK5UJTo7UNElVP
 J+a0SoDPy1gNpeumTIGbnX55bwOew3MEObEOhqrxJ4u1Fh/LQmrpI6INoTPTkDYsheUn
 D/8cr3hDfYAHphI9BMBm0uTZD4WhXstYgP4Fpwb3cWEx+XThj1SDOmPZKoyoC439HlHR
 pFEvoVHdy2G1vjGSGpY5q0lCMY8OPftuCnW3KrExyFzyIHuVczJdDDYH/GMCRnvQb1M6
 KrVB22s6pZD3ckpgt1SBNRSPevCTgCOVAursBzRpQIz8c3QpoRT6jYJqTDsDsyczvp/L
 loWw==
X-Gm-Message-State: AOJu0YwB72eNmDfxYsMkxALa2PSHEp4/WlX1S7FHvCR9eCEiFVJArpA2
 pxNlfnZgFR4/I5GXqtgWqqj5Hrwjuqx9ht0fj6VqMZ+6tAaUD/DNuV9lMSu3w4TdNyI=
X-Gm-Gg: AZuq6aLf+vpADYY03qvJgg+DF17iDf/ryv6eHoTAyHIykCaQhhUdWqT8RAQ3cQSfAGT
 JST8KP12RCW7s75HlKQtb6Rya/9MEkpAFooJh0nciKLFNKCk6iPo3Mci/jzFw6p5nclHhPawP+8
 P0Vprhziwn0L96y4AMdmZKMfQLe/oDmP3z2bWY+cMFH2ccOkcZrwaEwregUDNofLoWzh5ASb4az
 W0v50Oz/DSZuLmMFsRwp93dXFvCVLTor4W8guufiNKpDoVxWr+qxKY9+nbrDGMpL6ys1bEOVXpI
 L1raEY0vLQ1IVYKCQmb7BzZq6JcY7VzPv3H6xq6cBnguXy9aI9mfW5XSYSKiVtbOESjYFW6EXn9
 do9swAVozFyiX5Qo1zIgX7qEQAHVEZ+bLC8u1dOICLRHZXUMJBi7tFOlWZDY0qRyb+KNRZBzPTs
 5gAu1Wk5l0+QqvfcLNfBxzX3JUVDx8yEuJHgATRqKhfLBS7qVALFG7zCyTj0apNi+VfjjTotqh8
 jnH3ra6ME2aIlLlHqow7f70cL0CsEv3lpYt9w==
X-Received: by 2002:a05:6830:83a2:b0:7c9:5bef:e9b with SMTP id
 46e09a7af769-7d4643e5575mr2000932a34.3.1770401724756; 
 Fri, 06 Feb 2026 10:15:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d470914a1bsm97426a34.27.2026.02.06.10.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:15:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alexander Graf <agraf@csgraf.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260128194117.278566-1-marek.vasut+renesas@mailbox.org>
References: <20260128194117.278566-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] cmd: unzip: Use map_sysmem() with buffers in the
 gzwrite command
Message-Id: <177040172372.4023747.16519136555322028408.b4-ty@konsulko.com>
Date: Fri, 06 Feb 2026 12:15:23 -0600
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

On Wed, 28 Jan 2026 20:41:04 +0100, Marek Vasut wrote:

> The current implementation casts an address to a pointer. Make it more
> sandbox-friendly by using map_sysmem().
> 
> Convert 'addr' variable to unsigned long, as that is the return type of
> hextoul() and address parameter type of map_sysmem().
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: unzip: Use map_sysmem() with buffers in the gzwrite command
      commit: f2c704c0e8aac1b846fd55b7178151b2c879e185
-- 
Tom


