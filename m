Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E906ACD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E6C3846A5;
	Thu, 14 May 2026 19:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A4AekZgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A59088465A; Thu, 14 May 2026 19:55:41 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3138465A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso6536635fac.2
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778781338; x=1779386138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fv6kGyjp26oSs5RwoqYdUefwhiYiyvG1Vb5R6YHqZnc=;
 b=A4AekZgnG+ew1Wz2m5yuTsSsxgCBVZSMIh61WQWkfTmyHQ/8jX7C5dLe94/wVosHV3
 EZIQXlRKfqIbPLhqyZEqjJx12HEayCN02WkiyphwXyObJ/JWp5t5QknqPHH/VxlFfXI6
 h2meZBFedqzTaYpnFqUcM1MdDNw5TLgMRuFOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778781338; x=1779386138;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fv6kGyjp26oSs5RwoqYdUefwhiYiyvG1Vb5R6YHqZnc=;
 b=SlRhUM39OzLe963ZD0jUFC9Elpr3qZtzkoJwcvky9300ftCXlxfT7VY2tekk3CW4+j
 bMD9gV5X9ecRwjTa1uGIhIutb7ZmBX4qW4rVlSk4NDD/HEmyjOKkPkedPDBeIBaTWVWv
 5xUUzUgzxODURKBGY5/Fqs3zmsPRbz88ryc84HmfURO+TY6GSPVA19Hk6H2WbRS2D9vj
 RZmwe7lIyfUw0F/jGpF9CZdl/3cYV4rws54jMULfIrmtp0DvncNiuiXn9wD1s/s0A/x8
 S+LOSdjEIDIm2LLwxsNcw2+bhzxZOMBZhBz2tiZ4tJ/RbQ02AUMUzEYLcLn7B6WOvtvi
 Cthw==
X-Gm-Message-State: AOJu0YzkPY0QtbrWoPoYM5ANtSxTNbRb637JH6J6yjNh+eZAPkn4uxI4
 Pdot5cbBwrg5kYz55v/5fld6XOREBiRN30oSltOFKvYbBIjlTt+Dbqit4l/n+R0pQHg=
X-Gm-Gg: Acq92OHxrjeIsct+Io+ji/HaE5fxAiTFRtRk1rb6p3F26iDK/mxjxHyJUcbwS4jUV22
 DccqDP91NqqK+hPKrLImK6nOwWMNr6VtndoVBYBW1CK6KUL+GL6RyTCmtDBi2NaTJ2J2CUe4V8x
 FnbuOKOI2jzekufrzXcMs3pwlGPYtBXyzAVgzHYv8/+xKBgNqPG+PR8byeG4qjYRfPR3/lkBypn
 kqenYq1T++GbgDG2vZemuxDnCqPjFwdHtrCgdnRYWO3aFxk/7yhS32bMofXnnqQFVTeVXj01NNo
 jhS1Zd8nuxH3SjEEnpa0WYmdvO22BK2LfHTL2AO+hqwG/p0yuuwPiaHDXuaxY3YvIhO40NWBpSr
 rg8CHMqkR9sp+JTi+0SNGGt/Sus4cZS0+xYXoq66MvCTBIVOzzW1ADdjlkIR3f+83j1MBJiIQqK
 Lguzc3wjjZDlviTomm5u1ilV8D9CIL6ffCrxV+7oEF+OyI+DQ9P0866FHdVSWNtlRh02ty6xGMO
 nKktIcpg3SnJJxqFSnBASI+/Mm9D1k2HfSL9sSugbF5l5AUhg==
X-Received: by 2002:a05:6871:331b:b0:409:5560:72f8 with SMTP id
 586e51a60fabf-43a2d48fc2dmr526525fac.0.1778781338370; 
 Thu, 14 May 2026 10:55:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc53f2acsm2401711fac.14.2026.05.14.10.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:55:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20260514091516.2784772-1-ghidoliemanuele@gmail.com>
References: <20260514091516.2784772-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] arm: dts: k3-am69-aquila: fix combined boot
 firmware image build
Message-Id: <177878133740.4050569.12206732255886124677.b4-ty@konsulko.com>
Date: Thu, 14 May 2026 11:55:37 -0600
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

On Thu, 14 May 2026 11:15:12 +0200, Emanuele Ghidoli wrote:

> The combined boot firmware firmware-aquila-am69-gp.bin depends on
> tiboot3-am69-gp-aquila.bin, which in turn requires the GP variant
> of the TI system firmware blob (ti-fs-firmware-j784s4-gp.bin).
> 
> Fix the combined boot firmware image build by adding the missing binman
> nodes.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: dts: k3-am69-aquila: fix combined boot firmware image build
      commit: 03d70a9220f1cf48a80ad1873884c89200685ca6
-- 
Tom


