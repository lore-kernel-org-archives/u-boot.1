Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C8EC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 17:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FF984A52;
	Tue, 30 Jun 2026 19:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AcrND6Aq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5422484ADB; Tue, 30 Jun 2026 19:05:37 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FB484A3C
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 19:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e9483cd614so866410a34.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782839134; x=1783443934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCP8PhPdl22O4vwUm8SoC6gLK4Ma9DsxWdL6uqRXxeA=;
 b=AcrND6Aqgjnqgb+VJy2aaNwwTyDYTPYYv626TEbc5BnR/fz041SlvTlkeuXv73Jx0Z
 efm6fodZFaSGkZHiTS+3304khJj3PrLT6dZnbrY+/aD9dcR1inDzWf0OEfi0o4h0k6rP
 Wr4RbB+JsSkm2J6EnWDiyh4sXm8CRqhlEwN2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782839134; x=1783443934;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KCP8PhPdl22O4vwUm8SoC6gLK4Ma9DsxWdL6uqRXxeA=;
 b=JRRFaA4eurSI1KD9vIAGeT5LZnTACourMLek+D2Dtio4zWPsk6XKlSVH45wqvEC8kt
 DP19W1+wleehZSzg3lv2ioegK8xSCB/z0p0rzkIxDuQxO5iFKpqdf1FUwzmuwixygX6f
 X/+ep8W0nJ3p6cK9tGKPC20jb8YFpYcn3A4WPDlFSYObv+unGjceCtXciXkOwuwL/gL7
 cYxGsgVkGK39FNZk14AF6K4WKgC00uh43++Lxlc7rnmqARrnzjXjv4q0164vXI4Wcs12
 4xQfhbBTBsH/1hMfuEfUrbKBH4cRpNdnJ0v0Q1z9PxNKxlA4RhFrOHcXN8G6JaiKPPhj
 j4AQ==
X-Gm-Message-State: AOJu0YzSBAidnIAcIYd+06NLm1HJsOv14HgIRoesVZ5ynAal/+L9QJUg
 +deH14lXGhp47MgBdalbYwDBtxEcpA9BxGy9MvA4ktMZjfDr+OdVr9RgS/ZK5iTvFbQ=
X-Gm-Gg: AfdE7clWm1BqlVf8+RMUrJRwsByOWdA1m6putD3TsfhJVDjMdnJeurfLIM1hfLmPaLZ
 qppG7w7voXycha46TuGS5WwV3nald6yLNqMFv6nDHM6BFU/KBIKkMbT4lyhwB567krBabWDLOIN
 3AL9vt35JeIdj4VFc9tlfAGtbgLcTyn4+EJVIg/IUJ8L+J7/FWDTCLdh3YJdo9qdwzRpa/DmlYb
 afaxE3Uu4eHScFHhaPrFTs4VbhC5X7ARFBh90OCjq3d43hU3DOnOEAuG+8KKsFXofBDaEoxLhvc
 qVApInZCEvD+kRS1/v7Hwc9PDNeehteUTQHQq08kz16QhGnyCTutmjy6Zpsnqpn4U0tu+gSM4KF
 GkWGq9kzPyhOx0gv/VySt4HWvpCqYOT7XoErsgddZtkSKqwHvSpn+SQCZQiE++Pu2AUXpEf4Qc9
 ZbSgurvWVyd0gke15q171A86eZJYjWXN4aWewSEaJvmRaLkJN9aL9jIKEbi51td9tf0WUVmTr37
 qn3ejv7xsT2x+8zRaYI8sQgabh64GRKnHnToS29ayv7DiIE+w==
X-Received: by 2002:a9d:550a:0:b0:7e9:df35:ff99 with SMTP id
 46e09a7af769-7e9f5f7516fmr1123887a34.16.1782839133840; 
 Tue, 30 Jun 2026 10:05:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9ebf89825sm2786550a34.3.2026.06.30.10.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 10:05:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sam Day <me@samcday.com>, 
 Ye Li <ye.li@nxp.com>, Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <878q7w8nab.fsf@kernel.org>
References: <878q7w8nab.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20260629 into next
Message-Id: <178283913292.999303.8742394721833922749.b4-ty@konsulko.com>
Date: Tue, 30 Jun 2026 11:05:32 -0600
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

On Tue, 30 Jun 2026 10:06:52 +0200, Mattijs Korpershoek wrote:

> Here is a PR for next with the following:
> 
> Fastboot:
> * Add support for CMD_FASTBOOT_ABORT_KEYED
> * Enable CMD_FASTBOOT_ABORT_KEYED for qualcomm phones
> 
> Usb Gadget:
> * f_mass_storage: Disable eps during disconnect
> * f_sdp: Fix spl load failure error handling
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


