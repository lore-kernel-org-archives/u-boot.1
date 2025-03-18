Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D09C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 17:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A118129F;
	Tue, 18 Mar 2025 18:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LIibXjhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8BD81BC5; Tue, 18 Mar 2025 18:01:46 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197648193A
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-226185948ffso48953265ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742317302; x=1742922102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSA5k9B8OtPb4hR4U1E36U6/j1Apq5HEkg/ZPGAna4k=;
 b=LIibXjhjnVi3kCiVAdTx5b889so6/SpevyDNVoEO9APYQzKg5y3+J7McKb5cLL6GCf
 8ZgbDjQxmGnGFgVtKcQH88CfWthjg901qI3GT1e2exWt/HWQcUHM59dBauGbzOfjSkxt
 O9BYTn2ydfqPxmOJyfaBOTHJiIu+3aIvUZ3SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317302; x=1742922102;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSA5k9B8OtPb4hR4U1E36U6/j1Apq5HEkg/ZPGAna4k=;
 b=nePVTF978kSLUQfowfpSak0wzKVE6U5NYulyDYEb+a5Po+4dKLBSyG08WlOibvGlEt
 LgWlYbRX50mf1cVO3xivXtm6tm3bGD+6DPyIaPYutMeIYsqt1rddlLZEGrR/egCBv0zL
 9S9qiSPtmF0GlQrqua2VRJTtEX2mDvQt39lPcCMFX2rnkjTiRuHsEcNx6l9ximYlFv+f
 cOCkMfh5O/gHHEu1ZRgupfDxcL8YnuAoMr3T9a4M0gdsnfnGB1KAtULQ0OCvkn3yVYpg
 P25GkMzWtLyTFulri+WbsxxszUb/65+6FBpNxQ2Mcc+yDWGOFByeGUhx3z1/DwaNLgAk
 ylcQ==
X-Gm-Message-State: AOJu0YwbSMYeKQEWrrYvtVT3FcOOnnAc9It5GwnHvK06KeVnPJhA3D00
 VCiQe8KnORj1ZnDGZdiLv+9VA1lXWeHviCWhLMf4iyxeh15Wlhz8DBnWYl/rFfY=
X-Gm-Gg: ASbGncsbzJOkffpBjblPaH3FYNMI+/dWpMSzYHCXvnjNhAOjmtJC2A5adV40oCg6LDO
 j1HuDbicV2WSbkVpu2XSJ1i6jNnSO31ggYYxHa1vBQbijDPPA24QWBMdDyHI/oUbZ7anUO6WbRu
 baYY4iVw6X1eJOwgzRDA9j/A502qj4r1TNtsjeRC63iREAHVnb6edMV8f+MWa03JKOs8MT0dLms
 nYl5Kt3KnqCw03oGnrxur8iFMOuxmrEQrmg7FOhgJzO9IlrS1TUYQ1onNT6+HCFtDAWdFhhGrxD
 MitsjaTg2QjB1ZhGYXbvC4oApbgP65GzyNgGiWGk7hom
X-Google-Smtp-Source: AGHT+IHnMVYsdqK4384MYtVagXMLx10xNRH95j7bY0Jq3eujy9XMVRBvKBNj+ELhW1P0YQjvNi+J+A==
X-Received: by 2002:a17:90b:1d45:b0:2fe:861b:1ae3 with SMTP id
 98e67ed59e1d1-301a5b12641mr4680723a91.8.1742317302423; 
 Tue, 18 Mar 2025 10:01:42 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3015363273fsm8458551a91.34.2025.03.18.10.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 10:01:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: ggiordano@phytec.com, d.schultz@phytec.de, joe.hershberger@ni.com, 
 n-francis@ti.com, afd@ti.com, nmorrisson@phytec.com, d-gole@ti.com
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
Subject: Re: [PATCH 00/13] *** Various Improvements for phyCORE-AM62/A SoMs ***
Message-Id: <174231730085.1761337.1465026984189180056.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 11:01:40 -0600
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

On Wed, 05 Mar 2025 05:58:25 +0100, Wadim Egorov wrote:

> This patch series syncs the phyCORE-AM62Ax feature-wise with our other
> K3-based SoMs by adding SoM overlay handling and capsule updates. It
> also introduces support for USBDFU boot and includes various minor fixes.
> 
> Daniel Schultz (1):
>   board: phytec: common: Add phyCORE-AM62Ax
> 
> [...]

Applied to u-boot/next, thanks!

[01/13] arm: dts: k3-am62a-phycore-som-binman: Provide capsule nodes
        commit: fc70ff633eb83ae246c4ffac944300a6674d45f8
[02/13] include: configs: phycore-am62ax: Define capsule FW names
        commit: 7193c252db3578766a3d7fb4019a27fb16b418f8
[03/13] configs: phycore_am62ax_a53_defconfig: Enable capsule update
        commit: 44ac48c2bc3d31c78dc9455bdc14ac36649b9f62
[04/13] doc: phytec: k3: Add a common part for Environment and EFI Capsules
        commit: 2708c0b23fd488ae262c1c2a3449e16aa05dbd41
[05/13] configs: Add phycore_am62ax_r5_usbdfu_defconfig
        commit: adf4d5e9e8ddf8a02cd2cea4f4d19944583654bb
[06/13] board: phytec: phycore_am62x: Use custom k3_dfu.env fragment
        commit: 7719682164ee3d8a21e3b5d62d8eb28f0acbd45d
[07/13] board: phytec: phycore_am62ax: Add Network/SPI/DFU env variables
        commit: d78bc6ea9f96079e82771c8659e0e9529d85f9ba
[08/13] arch: arm: dts: k3-am62a7-phyboard-lyra: Add missing boot phase tag
        commit: fcf09a76e27828ba0f8b69389e819c30e1716798
[09/13] arch: arm: dts: k3-am625-phyboard-lyra: Add missing boot phase tag
        commit: 61b907e9370f36b29845a8262489a49410828ca6
[10/13] board: phytec: common: k3: Make configure_capsule_updates() static
        commit: cc5c55567e3abeaa64b632375c1faa9bd09d6472
[11/13] board: phytec: common: Add phyCORE-AM62Ax
        commit: 1afc1a7401775143cee7558f632e337c2d14e337
[12/13] arm: dts: k3-am62a-phycore-som-binman: Add SoM overlays
        commit: 71582e7fa83adbdeb5e0f7f3f0a441e6c2875a3d
[13/13] configs: phycore_am62ax_a53_defconfig: Add SoM overlays to OF_OVERLAY_LIST
        commit: 953af03171d94d7b2a7f587d4b0c8f1c826ff1f0
-- 
Tom


