Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB316E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 04:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D75808029E;
	Tue, 17 Dec 2024 05:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tYKedeyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2EC801CF; Tue, 17 Dec 2024 05:04:21 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D143800D2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dcdd9a3e54so22054086d6.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734408258; x=1735013058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5G9z4mpqj1QmdjQgu14kn0RR6bGFQj8WpwjfXv9sgE=;
 b=tYKedeylWmfR16ClzgxIO6OBF6q8NpDndIg24meSDD2pPSUiu6kLHHEVn3jZwCJPk2
 LM4433ZF2xChZCf2ShVxU2UJ+TUy4QHnqQa+ogu52lesBZe2aiZaOI72jJ0UHhm6h/vS
 R3NyxjmaLmI0ksl9u1O0l3tGRGHjm+oiFyrvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734408258; x=1735013058;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F5G9z4mpqj1QmdjQgu14kn0RR6bGFQj8WpwjfXv9sgE=;
 b=J6yEAoDbyqEjEfwfWaZpk/84s5IyyR0BRg2TbQTVbVilNbKORXPPv4l0x4Yo3Q1SIn
 Ux8ptM6Bqi2LB0zx/DrW0c1a2mziOcMntkPRlJ46g38I2Rcub8Q0Qx4dONq7l6UKPXlS
 v0ia0g1HHPNV3uDi9chC7X7W4/qvq0hxBSowTjDiTHvkoG4GYw205Ypt+BgFtglSwmTg
 vtuvvof1Ha3oAniDahf5OFPxtNhLwQL0SJq7ulYOj0TQok2oFNZ4WCWzchB+0HDvIfKm
 n3wKOMv6MAVY+cH2PoQWFrOdxkWjtEz5mop7eqkiuLstUmp7TOS//bpGVTjdUBR+Lmet
 qmlw==
X-Gm-Message-State: AOJu0YyegEs7hsArvYGw+8dgBgkS9bxrrBX0g3IXDYm5lfSLWJ4NmaAC
 bdVVkvMGrsXxvp1trk2CTQcHW3qHa3208UvJ+OzqF/GprPhE6L+/12fbvt8fxTk=
X-Gm-Gg: ASbGncsjYplkKQqv7F9sSbEa5G7L/+WSVvlBBseDUxi5E7aWWQRGuTTJKvICd5fWF9s
 5/P7dZsUa9+BnlHiWVinvOlyO994IL4fNh+bn19Qsl97LIuDl0X0gkB4VuxpuP19LnOhzs3soY/
 Y6DV3+VLztVYgspL9H1Y0UvsoFMN5K92TLN/zRlAyOOAuZw2IBAjAfSjy75mRLI8YsfwraXVd3Y
 z3Acf3M/2Elas2/yXFv2aCNK6CIbJKdHIm6T5W/3j6BP6cvXIjpCHY=
X-Google-Smtp-Source: AGHT+IGJMarHjP5ug1F9SvqmagUuzEMcc/WFhwrayPTIzCF0+9+MHVtWVNeTABbFSJ6PSrrpbZWTmg==
X-Received: by 2002:a05:6214:300e:b0:6d4:238e:35b0 with SMTP id
 6a1803df08f44-6dc8ca57023mr273031956d6.17.1734408258615; 
 Mon, 16 Dec 2024 20:04:18 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd256fd9sm34358136d6.37.2024.12.16.20.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 20:04:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20241203134257.5067-1-peng.fan@oss.nxp.com>
References: <20241203134257.5067-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] smbios: address build warning
Message-Id: <173440825623.3115242.9541032808648700195.b4-ty@konsulko.com>
Date: Mon, 16 Dec 2024 22:04:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 03 Dec 2024 21:42:57 +0800, Peng Fan (OSS) wrote:

> include display_options.h to address build warning:
> lib/smbios.c: In function ‘smbios_update_version’:
> lib/smbios.c:305:9: warning: implicit declaration of function ‘print_buffer’
> [-Wimplicit-function-declaration]
>          print_buffer((ulong)ptr, ptr, 1, old_len + 1, 0);
>          ^~~~~~~~~~~~
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


