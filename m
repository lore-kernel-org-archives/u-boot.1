Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39990D11192
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 19:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB58C83A3D;
	Wed, 26 Nov 2025 20:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MA8cW8Dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1346383A94; Wed, 26 Nov 2025 20:10:31 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18EC83A47
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 20:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-657a6028fbbso40355eaf.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 11:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764184227; x=1764789027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDcWrThDvXKoLNCyN6KBhcGW9MjhXWtjWqn9GjoCMOo=;
 b=MA8cW8DyordO/c2z4b+HCqaJdjlFeXw1DtxwAOqmzMvIcEPm96gArgdzc2viaSh4k3
 IoeWalV0TVapa9IcdZx6hFr/IVYh8oGVX5RVlB37kXreAiDuMxwI1E4alVRsEVg/TN7j
 aLHNS93Sewj5tfjG3y95xyEqnD299toujVYXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764184227; x=1764789027;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BDcWrThDvXKoLNCyN6KBhcGW9MjhXWtjWqn9GjoCMOo=;
 b=O2rJyWhdCHIRYw9d2UuV0jXtbzf+ELArckeR5zpB0QZGzkjMbTkln+aIWKm+7/QGXq
 IF3tYug1sBUK4jLvM1DWlNsqekBPhQf1T4np05WXms6WuD3JSxJwHapB+hJIKpQM04iP
 pbrq6CTWsvKPjrv7RpAuFVI6hH81EHp8GWufOA8JyjSKxPxbSR8lBJW5BmAeSVqiTUMt
 Aslk4fPBVYPolAL0bbLXaR1jWtpK3tOL+DbRKtP3V//dpSWA3unv2BDkX2yLNoDu65FR
 bQOwVWLo71MvBw3CGvrEDJcILtxm+NEkY/YSNuZj+F8EwH9azexi6jpCapWzmqCWADaf
 5klQ==
X-Gm-Message-State: AOJu0YzYOMCGJXWmHeIeX+qZYipgSKvTbObe9OBVOd5M5/Ox6VBV19uN
 +wmmLI/d5FXug5VuUxzjsgDHG2f7PEoXuzqTNXEUvnUaQ92PpgSEcJcSa9R3I59OPYUb6DlYmer
 UtxbGn5M=
X-Gm-Gg: ASbGncuaUBrqsz+L//q0uF1B+LHltelnKiD70GZ51Y8VRsMPqrrV95NxSDQOH2uPnZf
 9Q44JcQLeIVOyMXOx0kdG6Zv9jIVp3okGPmeDSbY9cYITMsT0adszBDRuWBmJCUN52EPcQiq8B+
 P1DHfa0JLT4Zfj3HyqlKj/7ZUvM8bJNmgeDdTW4oLXg5Zp60Q3opZmbd5yFf/FpFQib2nJ7couM
 cI/NGLht89nfz5OlNZ1s+12eq23D1kIif30JSySAEzL+zo+g/uoeDYlo2bT3LEMIRVTjQ8zhHDo
 vXf/ri5wGNAcUs3o6/KRTH97GqX7S0rfXPNgPcDljAiCXvZq595p6wTZZ/y2Azm9v3TMeR/HAs+
 lUWXkbfTKIsLaHbHE34N/4HA7yzE8agA5iOXj3WevIvosMBR3M/2mnTFP9WtI88jGkgOIxoEhLC
 keIwTPqjm/TWFDAZhfpxz/wICy+3Baw20A4ADT/tw4ndO7mIco
X-Google-Smtp-Source: AGHT+IG5K3DdreRxU4QI+XI4M4iBGso+XFo61hdoyov9H3MvV0j7iyb8b8wHEZesVAoi6Tddd60wQw==
X-Received: by 2002:a05:6820:2916:b0:657:7a19:1a45 with SMTP id
 006d021491bc7-657bddf8129mr2529635eaf.8.1764184227579; 
 Wed, 26 Nov 2025 11:10:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782bacf02sm5227803eaf.15.2025.11.26.11.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 11:10:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251113220956.1833225-1-trini@konsulko.com>
References: <20251113220956.1833225-1-trini@konsulko.com>
Subject: Re: [PATCHv2] Dockerfile: Include python3-tk for FATtools
Message-Id: <176418422689.3800471.13255952234388462385.b4-ty@konsulko.com>
Date: Wed, 26 Nov 2025 13:10:26 -0600
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

On Thu, 13 Nov 2025 16:09:56 -0600, Tom Rini wrote:

> In some cases our tests for exFAT don't run because we fail to be able
> to create the underlying image. This is in turn because while creation
> of the image succeeds, it seems that some way of how we invoke FATtools
> wants to import tkinter, that fails and so the test stops there. Having
> tkinter available (and then presumably a fallback to non-GUI because
> it's not available) leads to the tests running as expected.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Dockerfile: Include python3-tk for FATtools
      commit: bc4a1e56bfcdd70a5307c91c94dafcf6bb27da93
-- 
Tom


