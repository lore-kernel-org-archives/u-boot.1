Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB00D3C92B
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA5E83CDF;
	Wed, 10 Dec 2025 18:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z4ZyXOag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3BD483CF2; Wed, 10 Dec 2025 18:12:55 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C50183CD3
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 18:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c7bfba3996so73670a34.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 09:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765386772; x=1765991572; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QgE1GyOKG8ZVg61dZbysRPCWERvzUiSs61qB3Zyayc=;
 b=Z4ZyXOagTdPLKXkt2Ld9hqeVVQA5lbz3Nz2YF+I7Ab2m5CKILEBMnlCSv7/BZPvoOU
 F2/NDcwHoXliPizdDZOk0XQ6kMDBGJbCGdbQKCnPfiBH6dxTNXa8I5Stkl0UKOzCZjli
 WpO/s2pUyAJtIPpmoISybY4c3opvIkoUjycaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765386772; x=1765991572;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1QgE1GyOKG8ZVg61dZbysRPCWERvzUiSs61qB3Zyayc=;
 b=nlZdVrma7NEyCCqvDcnDJ5pH4NV+LZIJR4/nsoCVMNMLcYIGOEv3xQqQ0tjlvPpYL/
 pFIjWCKJOL0pzSGjsHvVyHGrGqWOFIxSAXIZcO6OELu1kcqcVzQoCKEam7JZphEhf/Xs
 yrBb9huvlvFQd7C/2rpKAOBDxmSeMHxMrbV8GqbJ+FwFBlTtzijLSKWQCdSLEHtrNVYt
 0JfXM6Xb0k60UJtoyI5tyhZVmcjBSufYNTV3AUc9fk6gJWQG6d4IQkxt5FDAaW3XMYcu
 lmjFdG7wapwyEcrKiT6mwKbHJvtSOyrrpVRI182VrPB/UAoUZurksWcDl1CfLkTcVQP6
 qTUA==
X-Gm-Message-State: AOJu0Yzz/CJ4CmdnhGj1RiOj8mrdk3GK21Dc7pTVaCiXvveszzijGumq
 KVHUJVPoccZ7vEXbpnY6cxFvTY/jnvwZQ57G5RICAygrYGl4a1EtZBR5IDogcTZ4ko4=
X-Gm-Gg: ASbGncsSMwjIvHdSVn+lzKEhipsNY62vG0FUt3wMpqZOqzaWUiq/BtOrT5Wh61diDZ+
 BPAp97SGNOPiofHQWocVD63DbuFLaWAcY5gjLyB7wwPDF9B3QDRQogBYRB9Kn15MDVUj7d9xXh0
 a7SzP80HrndLPKXbuvwFtPtV3uyxyAkbt0OW7y/T0YjrVDwmrw+cQamU3IC9jtnpqhGyYxVWdSf
 SaGdanZwjC0nv1/kSO/F6GKqbkN+A9ZEc6QQP3qtglI7F+mda6hnk+iL1pLkBECCRHWvAcCSGNM
 2mHuDhEzdFPhQeRB4F6LDJ0iUhECmTrArcC9QgW/KST5zW38D1xELrNSvrLpTT+gjTsefQwSg/z
 G0JYXqNwtHM32+3AXDKJqmAw+k2xNrDgejKtVDbx5QXX9oZIEOwnD1R+1HXhnUSbm/+zt1A0Jez
 CJDm5VnSKAjilFufAhIhdHJ7DzFho9/XfTDZU+7HIjjl40VPaZ
X-Google-Smtp-Source: AGHT+IGtAWN7j941islDuMGOcPbdqa5eidk5Y55Yl/ySj12Bi3s79rUYrfxzNmarDMzmbUQEA6XBfg==
X-Received: by 2002:a05:6820:4813:b0:65b:336f:f33a with SMTP id
 006d021491bc7-65b336ff4a5mr245520eaf.38.1765386772089; 
 Wed, 10 Dec 2025 09:12:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b3480fb94sm34528eaf.11.2025.12.10.09.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 09:12:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Adriana Nicolae <adriana@arista.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20251209-fdtdec-v1-1-614003860c32@arista.com>
References: <20251209-fdtdec-v1-1-614003860c32@arista.com>
Subject: Re: [PATCH] test: dm: fdtdec: Validate FDT size in unit test
Message-Id: <176538677122.3321367.6244553014838072781.b4-ty@konsulko.com>
Date: Wed, 10 Dec 2025 11:12:51 -0600
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

On Tue, 09 Dec 2025 07:55:38 -0800, Adriana Nicolae wrote:

> The current FDT decoding tests calculate the memory required
> for FDT manipulation by directly adding a fixed margin to
> fdt_totalsize(gd->fdt_blob). The static analyzer flagged
> "gd->fdt_blob->totalsize" as a tainted value being passed
> to fdt_open_into().
> 
> Ensure the size is validated by checking that the total size
> is within a reasonable maximum FDT limit for unit tests.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] test: dm: fdtdec: Validate FDT size in unit test
      commit: 93d000bc5237a82e74d437b5fc3c5fdf5237df2d
-- 
Tom


