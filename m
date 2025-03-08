Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B43C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 14:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B7538043C;
	Sat,  8 Mar 2025 15:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LkEoyota";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C468058A; Sat,  8 Mar 2025 15:04:07 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 315B2803CC
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 15:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6ef60e500d7so24713577b3.0
 for <u-boot@lists.denx.de>; Sat, 08 Mar 2025 06:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741442644; x=1742047444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EMes9PGF/ll7W4PWUjcW+J3Ste0xtMpXY4/42FOnc8=;
 b=LkEoyotadDoG4BhHcOhuMRommwKGQXxToOEnSTd2AVgQX8Q1wYF1R2avqgEhenAFR9
 9PNUyKTtxfnu+S1wYKA7LKIfgI8xoMp0w3HbWp2mBYWJSzguJWye8IDIuz4C7D1G/br+
 zgUYl/VrQkbnM74HGS1RBhh01YulAt53oLTgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741442644; x=1742047444;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EMes9PGF/ll7W4PWUjcW+J3Ste0xtMpXY4/42FOnc8=;
 b=M6v9CQMMXqR7Lc8pwzaNdH3GQVAt0U8jDxDE6ss1bdR5tjGH+fJ5YvgSriPki1BCp5
 OmO65WF1oJRM3wM7qOiDXd2pYLWt5UoGUtufiZ9VZLjFhNB1NBPsMBgPYyuoLPYmzK0t
 gnDWBBgEIPiEcHoVTj/hSy7OLbRBARqzXdJ1FogwtLSKa4Pia8SY9KK5Rt2T3tJ6FUCZ
 ie52UTlNSrCxL1Ct6hCWc0otIsOWEtryc0rsfgc4S+jpMauWjZ80IjDqCpD9e3W1vwUB
 dXW33ZRGx/666ao4Xby1TCMWlnz4PrBqK5KdBcwGz1IPRB5FzbMOeoa+Qg4ZEJLB57V2
 Vt1g==
X-Gm-Message-State: AOJu0YxyDrv3sGYwcHMS1CxR/gVHr7oTQvhjd74VQPe8dNrwYK01I4Rf
 d2kU4Lnn5xYVSpvZ9sTFc6x6KOJq7PNZmR7dBRuZSijHve6p+3pT+Xn/IYMziL4=
X-Gm-Gg: ASbGnctI9CInxrzCXJ9w2ApaeebXFHLMTVMR2YOPPCjMVc1HI/EYiUHFV4jWnCXBR4z
 Cn6mZfD5ZNxGipomEYA7jirrvHng/m55j5OoZXjVnJUnyWy3Tk2AiFT5cFfTLSWiU0VqJT6Bcu6
 jxMu8p/n/Z7kDCNR5AREq4M7+H7d5TJFoJXnMDzfh7b5pTx5c1omPXfRK/cNya6ozkSHHnsi5sB
 D0esxyEAtQm/x+xE2ILT+0AMzKeN/PPioF3yJpmI9SwaOCDVRTb0smvD89KH7CzmoTD9+bcm/gs
 FKtyEtfZ7/CjwcJHeOaNCGRqs3CAY16OUE0Oy0mzmQ8c
X-Google-Smtp-Source: AGHT+IHi6J8VhgmCTxr8wMTtVqCQ0IxQw0jcWtVDIPDBZzwkpVtkr++THcGOw+nADMK9y0CdOfdxuA==
X-Received: by 2002:a05:690c:7013:b0:6f9:af1f:fdd0 with SMTP id
 00721157ae682-6febf3dbe3emr102443247b3.31.1741442643947; 
 Sat, 08 Mar 2025 06:04:03 -0800 (PST)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm12031107b3.6.2025.03.08.06.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 06:04:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
Cc: Adriano Cordova <adrianox@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
In-Reply-To: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
References: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
Subject: Re: [PATCH v2 0/6] This series adds support for file renaming to
 EFI_FILE_PROTOCOL.SetInfo().
Message-Id: <174144264113.130645.15260475333576292085.b4-ty@konsulko.com>
Date: Sat, 08 Mar 2025 08:04:01 -0600
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

On Mon, 17 Feb 2025 13:26:41 -0500, Gabriel Dalimonte wrote:

> This series adds support for file renaming to EFI_FILE_PROTOCOL.SetInfo().
> One of the use cases for renaming in EFI is to facilitate boot loader
> boot counting.
> 
> No existing filesystems in U-Boot currently include file renaming,
> resulting in support for renaming at the filesystem level and a
> concrete implementation for the FAT filesystem.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] fs: fat: factor out dentry link create/delete
      commit: 1742b8484e797c56c720c24fa7b923a6d7275cc6
[2/6] fs: add rename infrastructure
      commit: d9c149664fa7a0c2eabfc046dcf89637f655364b
[3/6] fs: fat: add rename
      commit: 06159a1465fc97d8d7b72b9bea39a396f6e7057c
[4/6] fs: fat: update parent dirs metadata on dentry create/delete
      commit: 879eee641b6ddd4cd8299cb14803766935536b3e
[5/6] efi_loader: move path out of file_handle
      commit: 8465ee528b84f242e403a3c6e67dab5b244bacc8
[6/6] efi_loader: support file rename in SetInfo()
      commit: 0165e1a8bd80ee91216e901064bfd4b0ca7f623a
-- 
Tom


