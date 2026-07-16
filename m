Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E6FC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 23:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D27784DDB;
	Fri, 17 Jul 2026 01:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hz7kFD6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F98384DD1; Fri, 17 Jul 2026 01:25:15 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE54784DBF
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 01:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4471b489240so2477123fac.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784244312; x=1784849112; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m4A8HhdNAoRpjFIwXwK2E8ruIfGdoZu4Mf86s8YYUU8=;
 b=hz7kFD6CIIifEwMjRbhUYGO0ICxeFpr2x4qEV853OMvP8DEF8QEjY4A59aN8hkyQW+
 plPySqUhzrFNqP7xcU9x6k79PuynpPLkEiWXimZ2G5BdLNKlDqEMYxM+QzsbrnCN30cC
 APiS4TjfQrFbGIi9Vg790ENytNp0i00QS1DUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784244312; x=1784849112;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m4A8HhdNAoRpjFIwXwK2E8ruIfGdoZu4Mf86s8YYUU8=;
 b=N8Dw4bk6ugGygzOBX7stVrIrUgeDX7EU0qx4LNw/GDlKi+F5DHVxtL/uQBQCXs5FEY
 DqxYXCy93oPQ6uCGD3dG+DIq1KDsynnuF9fO+vB8fn++SN6Fgd57wbl44AygxNIkYll/
 FNwFZ7/AtHnPeojZZOV869YCVsUCEHF8PSx/An59Op23CXtxFOXvVygIL5h8CpLWymTD
 030wBEhup8KeEj5aQqRjCuZxKKYaLaCKFva606Q/SkxVnzQrC3VfI7l9N9jkjy7ZGexs
 YBv+QldlayHmKbw4Q7BLhsXtJKe7yH9cTDWYOUxZ6TncNw7/HH4BC6Q2P1qJ+8smgMKd
 fXgw==
X-Gm-Message-State: AOJu0Yx9yOzC1TdbDR+1s2yxvUbBdNgiLWOUUXdxVEC83twTEUgEsC3Z
 CyiMHGIkVThE8qCXlTx74gO1XlA41WXdfgfVXteULqE+qPuOQuHXCc/56dAMnOTNKg4=
X-Gm-Gg: AfdE7ckxfBVt4De5rmyBz7yrKXKyT2FxIWfVGS/NaRXo4TGlOb9GsSvAgiSziclxgPO
 9TW07SDsx0V53AQkgfAUS2QaUUoX2vtvN5kdJ17hMN4VPX7LKn9z1bxdP3YnBmAfx2BPJbn+arh
 9eUETLRvcGbEgv/RcG1ODSXx8w85owgvePKBYEZnvtFYDxwrbgBXqkqWnif83ivDhmVcJxZy22G
 lMeRKiVvEF1mDidYCJyMMfDS0hWwpar0HBaQx5sDODGvjYDSCxBUL15miReac69bABby2x0oz59
 xrof05GPFS6oa5lrU7gbcXBLme6yPn3bY3TS17k+UAai1UJAGeEtURq9/CpB0IFbHxOwTt3UHIz
 t3a6ONSQlk5y5B4cYybZgHK7RPkTjvR+MnMH7JVHm1DbtUGbMvaY197dsxiL82p6uPyrOhV/42t
 VFsqM1wqo+0ZMsoayYZj1+heHqNpFTc7OM5aG8xvkWygY7K7rSJYGT09WpdB9+bykLFt/t43Hxu
 8cd5ZfOkek7JRwlBHyBYbfiwdFslOoiDMhP
X-Received: by 2002:a05:6870:940b:b0:451:fb50:a594 with SMTP id
 586e51a60fabf-4562b55670amr5994456fac.4.1784244311619; 
 Thu, 16 Jul 2026 16:25:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568da4ab47sm27308fac.0.2026.07.16.16.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 16:25:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260623141540.618272-1-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260623141540.618272-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/4] arm: k3: replace tifsstub runtime filter with
 per-state FIT configurations
Message-Id: <178424431068.1470194.10671045238552718846.b4-ty@konsulko.com>
Date: Thu, 16 Jul 2026 17:25:10 -0600
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

On Tue, 23 Jun 2026 14:15:14 +0000, Aristo Chen wrote:

> The AM62x family (TI EVMs, phytec phycore, toradex verdin) ships
> two or three mutually-exclusive tifsstub variants per tispl.bin FIT
> image (tifsstub-hs, tifsstub-fs, tifsstub-gp), all assigned the same
> load address 0x9dc00000. The current platform code loads every
> variant and discards the wrong ones at runtime by zeroing *p_size in
> board_fit_image_post_process() (arch/arm/mach-k3/r5/common.c).
> 
> [...]

Applied to u-boot/main, thanks!

[1/4] arm: k3: select tifsstub via board_fit_config_name_match
      commit: c85bf61b14f9caa34662d9b767b61ba2b5da74f0
[2/4] board: phytec: phycore-am62: select tifsstub via FIT config
      commit: 857c2151ca8d41add88fec01a7fea8965d0d2c74
[3/4] board: toradex: verdin-am62: select tifsstub via FIT config
      commit: feb2b13377534725ee0f428ed4252db7fddaa57f
[4/4] arm: k3: drop redundant tifsstub runtime filter
      commit: a5567f46697a733a9ad03eaec9941c8d80e6fb40
-- 
Tom


