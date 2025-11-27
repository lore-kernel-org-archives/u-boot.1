Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF603D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 18:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352AC844BF;
	Thu, 27 Nov 2025 19:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f37zsEU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4694844BF; Thu, 27 Nov 2025 19:41:12 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ED22842A7
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 19:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3e37ad3d95aso769276fac.3
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 10:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764268868; x=1764873668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vi9B8vCydAzp7xy+e3L+g/q23gjT53nDRmO2dMdaG3c=;
 b=f37zsEU2qBydQVsWLfhSEH0fY6xWRiEzn5r0yVk18nmrVFCFhDwvoXXC2qTz03TWuJ
 I7voaCmN9GDcxc7kLvsebGFEGwDh81OXFaB/PkpvSIbce5ggK+rFTwSAndbPcpR9zQ2W
 CcMR1XgVr+UMs6L9H+sBCsybwLhwUWboEIbgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764268868; x=1764873668;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vi9B8vCydAzp7xy+e3L+g/q23gjT53nDRmO2dMdaG3c=;
 b=X6AeQp1jtbU6BswGOcf1FiBL1U6qlEoaq+UlckFqVwqccniyaWc+Ru2u21CK2I1ZQ4
 BQwpqUTIfaTL26BFVmaPxbMxCSWvLzWBkEmuLWFugpjtHB2onTsA8GTCTo7DkkLWo98I
 EZz10epoUjAENtPRcsMlate0oDTJJpqvsDHvG4bQ20TxngcGz4GtzLcS6NwRhQqHOLhF
 taSbcyVNpUmVmKKl0xpw9SWaB3F9friYVVtG8Lq8VWcJxZNvSncjIf8iL6b1ukKDPa2E
 /gKHF7M+9WP8skr6jTJgJuRpXiB3At0TqQVoKisTRLuabBVVgX1U+NTIBY9Naqp9X7hQ
 KUyw==
X-Gm-Message-State: AOJu0Yzpa6Zts9mNJit2eB9gVSEcEw0X8rTm/VWc+iw/Bet/iWGN0R7R
 KVfUldnWVtIDofjRpxnn86dkC8tqAZN2W+109Dc9n0uL8BdYDvEwEgG+G7A7CA5yRR4=
X-Gm-Gg: ASbGncs4a/R2PacHiGdMQ5uXBtp+IOPgGYVsM19rHdPqftRVz61j3oiFDYj04niUj6Z
 4EM4dyQ/p8EzkllGfAfe1KiW9g9FpkBpC/yE3jf/SJM2F5PHUzlzegqzkPqF0Gr6MlRq3DU02QC
 7I+3L1l6u+/rwsROQ+EWUh/mbpc60IZ/g/Rz9ApIYWtWVFMqiR/0+YxAG1e/H9Wztke3mi2UeZA
 xFqRxlcKYiVrt5m69RLADP1RVHkeCkSCXM6/XrmahTToh5wAHxwbb8TsVXt0KnpkqBGPIthen3m
 JywBFa63PkOEcUDijC6j6RmIdUslkGn3OcCkAbQWcP9I++aKtKaLBkP7CHKB8jp7lMiJZDp/MOg
 I3bFDgFqGxsmxXMhjmTODCS4bhJnjFj8gj8Sr9CiKDldUrAgnxMhTKfGcJQWL6gwn26qkVUHSZg
 nqvX5uGBmhRAIGoPbo3a8u2zMjD3/5gFj+qz796KnKuFPq4QgV
X-Google-Smtp-Source: AGHT+IFRk+brpLXCp5Toz+bq+cOHA+oXIvw9gt4Bm/sysiK2sWqW5VyNCwwE/kEtX8DDfxQG1BOWQw==
X-Received: by 2002:a05:6870:9488:b0:36c:abe0:83d3 with SMTP id
 586e51a60fabf-3ed1fff5989mr5074928fac.39.1764268867872; 
 Thu, 27 Nov 2025 10:41:07 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca3ad8asm906458fac.6.2025.11.27.10.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 10:41:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, max.oss.09@gmail.com
Cc: Max Krummenacher <max.krummenacher@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>
In-Reply-To: <20251126134107.2969608-1-max.oss.09@gmail.com>
References: <20251126134107.2969608-1-max.oss.09@gmail.com>
Subject: Re: [PATCH] configs: toradex-smarc-imx95: set spl_stack
Message-Id: <176426886670.4138873.1135092642819232411.b4-ty@konsulko.com>
Date: Thu, 27 Nov 2025 12:41:06 -0600
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

On Wed, 26 Nov 2025 14:41:04 +0100, max.oss.09@gmail.com wrote:

> The SPL_STACK config option now depends on having SPL_HAVE_INIT_STACK
> defined. This made savedefconfig dropping SPL_STACK when sending the
> initial configuration.
> Note that SPL/U-Boot are able to boot linux from mass storage with
> SPL_STACK not set but other use cases might run out of stack or
> overlap with other RAM use.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: toradex-smarc-imx95: set spl_stack
      commit: 610a3eb27ea1e68363fffcb3f14b7fc097ef08b6
-- 
Tom


