Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32760C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 16:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851B4820EB;
	Fri,  2 May 2025 18:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oHYhhsb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A2A820F6; Fri,  2 May 2025 18:26:17 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA37820E2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 18:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-606668f8d51so1368984eaf.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746203174; x=1746807974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Etn1SskDsy+lNOkxOtYL5wb8lePbyJj/AbFPF92Ck1g=;
 b=oHYhhsb4/y6ThTK+Th0QesEhFTMhdSz1jY/oTLyvKaUsDYsEmH+vdjOV3dRDPz4p2v
 6Q+pTI4l2TVmPAVsB1EE4i4zYWIGTRerX5O1+2Dlmx7y4358g9uaQUsdB6hZeDGDgWAS
 kG7n6lZ7fh9BLgqVe2+YUBYLqSj7y1S4l8P1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746203174; x=1746807974;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Etn1SskDsy+lNOkxOtYL5wb8lePbyJj/AbFPF92Ck1g=;
 b=O+VUHDRy5uNzMesUHCTRNg89ssXq72rE+AqzJBDGtC8/PdWKjGF70z9hRJM2mF0INd
 Ml+0MAARV6/S5UCPrrID+aOTRJZa5gmmsVZBS5/9x8Pwd32NZvEKcXhEh3/8fUWysuUs
 Xw4zc0lH+19TV6qz30eYgF05JDWXlRACoO8iXzIlwTDLzW1P95sdHXwAZOxMbn1imUsc
 WtqBF0XTtywLeEFTMcnp6Nvtmkn+3ChpuCn5wRE79dQ/r93rMYrUsfDeRgochDmxnH5G
 C0T5r7kQihjkSjCaufCddNfUAQ0ASgbXgUzkUyoLEfJMB2BJXQG1nEkFTmUt092u9ZOK
 FrrQ==
X-Gm-Message-State: AOJu0YwRYp9RgHvF0ziergW3EgiYrJ1fDTWEN7EpTJbVGwHo48KIy7um
 j3DGYUwy2gHq6eorGfLKdXiO2I7okSEMENJ7XBkIm44VNWbdsrIj/wNObEBul5c=
X-Gm-Gg: ASbGnctih72l38Dv255ivvhnq7c/u10CD2+Vor4OI12p6IGz6FjyqiVA1myA8VRBcoi
 uYfxHGA1368h22/fUFn0RhvD+I2Mtuga5cPrstPYPSUWMiIUqqKpYn1dWnNrmjDwpsNSmapLXKl
 oNEJnDKhEmfSN8KFGodgGmbyvCGlhdSr8xOOh3wtD8aOGeSnAdT5ol0XiPAXlWCHsu1fBir5Ivx
 +dG+zSCvISYLCGk5V1zPP8KQ25wuDXRDB8Nb8ADnOMPzqJfjmoVJxxUelTuehW3d4M9H4K3KxdG
 U4pRlXvG0RfriubMnyVkFOupLQyIBIhyjZdF3Nyq6TsE8clceWAgSndXcYg1Pi7s2DzlK2Uw+XE
 7IbLewYpcTek=
X-Google-Smtp-Source: AGHT+IHp8Yq26Nknamh4jW9RcaqQsa7SFRjm4auyEKFAA0SvltVysZ0NKXFdJAWF+Jma+PySKL5h5A==
X-Received: by 2002:a4a:c899:0:b0:607:de46:fa94 with SMTP id
 006d021491bc7-607e2043168mr3687215eaf.4.1746203173775; 
 Fri, 02 May 2025 09:26:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7ecff54sm597977eaf.22.2025.05.02.09.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:26:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
Subject: Re: [PATCH v2 0/8] Qualcomm: cleanup OF_LIVE fixup and fix RB1/2
Message-Id: <174620317246.1348341.13335565510376078911.b4-ty@konsulko.com>
Date: Fri, 02 May 2025 10:26:12 -0600
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

On Fri, 11 Apr 2025 14:47:37 +0200, Caleb Connolly wrote:

> Introduce a new event to signal that the live tree has been built,
> allowing boards to perform fixups on the tree before devices are bound.
> Crucially this allows for devices to be enabled or disabled, but also
> allows for properties that are parsed during the bind stage to be
> modified (such as dr_mode for dwc3).
> 
> With this in place, mach-snapdragon is switched over to use the event
> and some hacky U-Boot specific DT overrides (which had to be undone
> prior to booting an image) are removed in favour of fixing up the
> livetree (which is not passed on to further boot stages).
> 
> [...]

Applied to u-boot/master, thanks!

[1/8] event: signal when livetree has been built
      commit: 993a9db918af451c68851522c8770e582b717629
[2/8] mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT fixups
      commit: 5a1dfb27f9170d35a475ea8be46b5d7c037ee837
[3/8] mach-snapdragon: of_fixup: skip disabled USB nodes
      commit: 0ec337d03410a4a0b7402ae72968470cf63f0c55
[4/8] mach-snapdragon: of_fixup: remove confusing log message
      commit: a6cc4ef343dc39c17fd5b833d983aff2f26c94b7
[5/8] mach-snapdragon: of_fixup: update comment
      commit: 9bc7eef9bf58c4c1d453cba81060dc61375f5354
[6/8] mach-snapdragon: of_fixup: set dr_mode for RB1/2 boards
      commit: 3b983cf48e70ecb6aadca788d0d91a021340c802
[7/8] clk/qcom: qcm2290: show clock name in set_rate()
      commit: 229fd3f9a8d4dbaad7c9a2e9c1b62d14d0753b0b
[8/8] pinctrl: qcom: qcm2290: fix off by 1 in pin_count
      commit: 2803a466a96153ab01c5789321e48397b6bae9c7
-- 
Tom


