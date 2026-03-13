Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99039107BCE8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 20:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E61C8435B;
	Fri, 13 Mar 2026 21:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="is1swAJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F86483DA7; Fri, 13 Mar 2026 21:55:07 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4276E83DA7
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 21:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d743cd9e5bso1784269a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773435304; x=1774040104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hsD+enaHGV4MkdmQzv3OR3rGfVsUiUC3/w6r40xHJ4=;
 b=is1swAJrXwQbtWZ+bH6pY2eJ+npbYgXZzj/PCuPxhbMhLVj2rm8WcLPg99mYY9t+h8
 Buau25ED16pbwB99vw3L9twTyzXc/wMNriMFEbPGHfrTdkbzW7M+czyrc+TbIMFb30A0
 6++BXISozQpSRtdSeoCR15h5ZANkM53HNVnE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435304; x=1774040104;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7hsD+enaHGV4MkdmQzv3OR3rGfVsUiUC3/w6r40xHJ4=;
 b=PY8su4+Vzg2fkeFg0mtaXkidE3xDsXVW3pyDHZUTyWtBdtEpbVekdcmeH79Hmd878m
 ia5jvDLw2brH4N2d2OiVaQZKPvsJxpMzkygIUyLVMNbo3VmtVAhby5j0knVD02SQs615
 5fQ6W8RTNfjqUcSYdjc079ybCQ63EtNA5hu+djM0Re7JNWjjUGebwK0LOnaBcfdGX0nO
 KQz68b+oDRZs/wVrOqrp0HJjeNcow4NHUFc1c9YSnGgyBD32vCUQpS8M90WDGQ/EGYGe
 hM6iXBoAGPM8V2QEbD+hYoKecGZj2UlK0VRgR9awnWCWkaNDpV6CKLEzXPGvArdIWnPj
 L1+g==
X-Gm-Message-State: AOJu0Yx0gdsWbV48ITAeXs89kVh/cKB9v15fGl2Pt73BhHokS0TyUBlR
 015U3F4g8TcYIXQ/thcQBwdISH6cqbCX2dFRe6BPlst4kQ4HeFITdBa434pKHeSXlEk=
X-Gm-Gg: ATEYQzyMQ2EVve1OzP/K8G+Uz66wcloWKVjpWdJXeF17mUNef1+fPUUNnKEIFF/Z4hE
 Ttok1Yp+VRMFwEbkTRBWwD+Z03NSlFV/0ObbteAl4OaATCyfpgwy0sKUnkaQICnpGiLs7vQFK8b
 ty2dIPoXvBrplJBwmNBRNjTY6Y7fRCkVLIynkpZ1DxvX+2f82tJ7IZZApQF2r86AIIPYoOpdapT
 OH0L0vjRzeZx7QTTNvKW60bc3E7JRXQqboPZBPj9Ko7efX7kIHoB79COMtwXA/FYBvxx+QO5o40
 M1WRjkcilZzQXeksBStiIJ1rEk+vQfqjutmQtzTz8+lDhcuOX6/ZXK7Jb6awePRHXOTGQkzbmA7
 RlQIhGLo12m1Rzdtnbt6kHtZh1tWgoHqtEbtZT87E4o6yV7rU1aURONOFa9OA53hyCnbN3EW9JP
 vDIFWCu1aSxHDtiplxqSNgZkVxpjEvq+c0bUMc8pCLoBzE0PzKTdaMBs4irKaLK3kOhMy/NxFvZ
 oQ2dFY2btPMO4xSU/rKbyZe/7lMWxuKN0V7qhAIutGjNHQ=
X-Received: by 2002:a05:6830:6516:b0:7d7:38e2:3700 with SMTP id
 46e09a7af769-7d7825e0ad7mr3062070a34.27.1773435303993; 
 Fri, 13 Mar 2026 13:55:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm6857942a34.18.2026.03.13.13.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 13:55:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dimitrios Siganos <dimitris@siganos.org>
Cc: anshuld@ti.com, festevam@gmail.com
In-Reply-To: <20260217135620.2176407-1-dimitris@siganos.org>
References: <20260217135620.2176407-1-dimitris@siganos.org>
Subject: Re: [PATCH] spl: spi: fix loss of spl_load() error on soft reset
Message-Id: <177343529990.1131472.2721361681092597672.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 14:54:59 -0600
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

On Tue, 17 Feb 2026 13:56:20 +0000, Dimitrios Siganos wrote:

> When CONFIG_SPI_FLASH_SOFT_RESET is enabled, spi_nor_remove() is called
> after spl_load() to switch the flash back to legacy SPI mode. However,
> the return value of spi_nor_remove() unconditionally overwrites the
> return value of spl_load(), discarding any load error.
> 
> Fix this by preserving the spl_load() error and only propagating the
> spi_nor_remove() error as a fallback. Also log a message when
> spi_nor_remove() fails, since in the case where spl_load() already
> failed its error would otherwise be silently discarded.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] spl: spi: fix loss of spl_load() error on soft reset
      commit: e7ad95aa3f1180823e07dd30c8c24494a07ca814
-- 
Tom


