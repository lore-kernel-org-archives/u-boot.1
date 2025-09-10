Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF34CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 06:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA687830B4;
	Wed, 10 Sep 2025 08:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="jc500GJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E528318E; Wed, 10 Sep 2025 08:25:45 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD5A830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 08:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d605c6501so55533747b3.3
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 23:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1757485542; x=1758090342;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SGTHGDJHRZspo4SlZ6WwtxZbUtNyN/URAALMXRI/eA=;
 b=jc500GJg4qdoYDMz3MCNsV/i63Q8uaWa+Sd6Jn/rcPbIfb4pufLO79ipokzR35iTkO
 Izr9IeCyn8LkCyXLKeSrxpIu0O4KFA5h7aK9IkoHFi/CzNV2kp8msA8MeLNdAhuiY4jQ
 gOiBSsJbjhm89la4S3exg/j2J5DQ98AKh6wOOeRsi4oCEXD1eFSEPyZzULGc6Dxh+x5b
 qFlAl8hjSkqRSwBZWplM6CbVDg3WIK8qqlDaEmq4zSyV1szb1NVpom/4oUfPw9t0qFYk
 IdfCPUenGGgJKEUksDfjnd00Xj68fXity7/Qg34Ryz4qujaMPwVase14uz/oocrASDxq
 V03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757485542; x=1758090342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9SGTHGDJHRZspo4SlZ6WwtxZbUtNyN/URAALMXRI/eA=;
 b=NKkLfcjDfFet/AC12xKDcsluMdE79/SfsZAgTR+wHsOTYoZAQHCtQ7A2nRB9xOJ6UX
 pZz88sWA/vHKy3+0MGbntMjSotfOnbOa0FW35y+KzeSmG3Cs++arwA2XYuKa6HmtlT6r
 DwA6TR7gfVNbiEb4LxuuFJNVuioSlPmH+BK9EapvJiLOduNWMX2j1XWXTBcEWCHIil38
 2DJy7EMwOYavHGvubDpweCpEhRDtPHPnKWUfYPZnPwLfff45iMBPYaX3e0rEt1E+PwR+
 UUwAmwOV7ggtI1BVhQbVE3uQJSYt8A7CMyyILrgwFdRiJQNSEpUCLs3knmGoV8uAvys/
 7TmQ==
X-Gm-Message-State: AOJu0YxSgdTgo1k2yb7K7SB8i+18vLXDwHMcbQPGNIOkZh0sIBEPixcY
 ZNsTPTJzizx0T9dIZ38fA9ixd0Dz2ZGeWo1u8TOvIMaJu7Fx3gov2hn2FDTcWGM2hxTAP008lg+
 2Kj+PWWZW04CVcxt0l14HHYb2wNwRHIDAr6Hr127593N9O99l9hYqgI8M
X-Gm-Gg: ASbGnctNr6FPv2/I7A2OXBklsbO6ex73ZKdPGH5PAmqaABOcm3L97w8E+pojuRqDw2i
 ZZQwLk+IAu2bTGqTSFDpJEHNs5Ayo9CoYO7isfCuaOLj8Qh2GOgLnxCxlrilvCFALZnw/YNcglA
 QNwu3QT+UvWK8Hh4saVsYOxy5EoU+xAswqsoeyMtIiYNR1MkWKLra9iUKANkInzzS/A1nhslB99
 V+bR1fuMglmDhRMJzQ=
X-Google-Smtp-Source: AGHT+IHv/2XPmWOfHTnXtvKJCoe87CaRdNfqoy0su54iTqJUxGvUonRxQrR+/liRATE3ECkYhyz0u1TNLEIzpmePfAQ=
X-Received: by 2002:a05:690c:30a:b0:723:8be3:a678 with SMTP id
 00721157ae682-727f553e67emr121202077b3.40.1757485541997; Tue, 09 Sep 2025
 23:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250708134142.327224-1-padmarao.begari@amd.com>
 <20250708134142.327224-3-padmarao.begari@amd.com>
In-Reply-To: <20250708134142.327224-3-padmarao.begari@amd.com>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 10 Sep 2025 08:25:31 +0200
X-Gm-Features: Ac12FXyO65PpvZQoHUzi5NBz5Bm_SeJCeO15WYt-26h695h2VyfR_OjF7vieDtI
Message-ID: <CAHTX3dJR+kDZuKTb=Zpzy8gu+TRNrbwrUYn4cCpF7rK6f07naw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] board: xilinx: update guid based on metadata
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=C3=BAt 8. 7. 2025 v 15:42 odes=C3=ADlatel Padmarao Begari
<padmarao.begari@amd.com> napsal:
>
> The generated GUID applies to all Xilinx platforms but is not
> specific to any individual board. For FWU multi bank update,
> use the image UUID (GUID) from the FWU metadata structure
> rather than embedding a generated GUID into the U-Boot build.
>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  board/xilinx/common/board.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 8ffe7429901..c1fc8505761 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -712,3 +712,29 @@ phys_addr_t board_get_usable_ram_top(phys_size_t tot=
al_size)
>  }
>
>  #endif
> +
> +#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
> +int fwu_mtd_platform_hook(struct udevice *dev, struct fwu_data *data)

as you told me the name doesn't fit with the first patch. That's why
please send the v2 version of this patch.

M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
