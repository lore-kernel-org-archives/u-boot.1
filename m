Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49473CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F9A83214;
	Tue, 12 Aug 2025 00:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="igbB+7hm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6143831C5; Tue, 12 Aug 2025 00:21:01 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC62083214
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3e40212e6ceso20791345ab.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950858; x=1755555658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wD5eySSYp2wav8PxSSXj34At0B5orX3Ckgev/XNjgNg=;
 b=igbB+7hmPlinIakjFxfkvAM1DBT7c0sFYGxgOVuEgoDdOmS9lnD446K15MQZxmoWrn
 5i61HMp2ZcH2nK2sQZz462qmiMpq3naNM0iS+kX3/scMz18k3Sb6IFvD5klTa892Ah8e
 WROJZ9WzEC6RTqywedrE5RL3CamUCeh9Qa7/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950858; x=1755555658;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wD5eySSYp2wav8PxSSXj34At0B5orX3Ckgev/XNjgNg=;
 b=Q3Zm/YYryJGdT3+8/08SOi6DkKq56zcJnQV1tDPdLUTQk6LBnDdQs21Vg7Qg1y/O+3
 FIYQQKvJTdgRxBWz1099i2YJ6U0AIf6BsAn+bR5yvqzZ/DsknrtwMxewJsLCXBGQEYmD
 kHFK9okDBDqzAIpgnWHVRGyfCqudfs9thpdW+F8DRUL/HWZVCzHwK4lpt9ZavS36CBFb
 SIVrr9ztCu7cE4g/uvyxDHL2mD7phLK0ATgeA8HFCWuZhtg90nHvAx64gthnMA8fM1qp
 N+NCRXNjwXAIPt8EizdVaI7/dXcitIaquz72t1DBvdVuwcNPJup0rWK1J77yWNt+GP5T
 BctA==
X-Gm-Message-State: AOJu0Ywi4qwXilDYz3QSyx92EpTgf1ctYOqbDg2PyyrK77TbQBfDH7sr
 e0/Eo/Fs/mwaUx3gbHvSNUgYFTpxoV0GDYLqrwRSxS7EsqOtQfJ6pyioqj02EMt6AhCbbG/PCl1
 z/SB4+Kg=
X-Gm-Gg: ASbGnctejcRNDFQuK6Sq1e7RpeKhcAqjaomgaqkFaGGpWiHmIgSrW4qKAVXtJ+je0Pl
 qPl/H+EoiX9UllBNskEyy15A3c0/NBaLQB3ES2UcyULxSXG6OyBmK9u5goyS9zv8nk8Vi332aDk
 ovJYA4WDhsNv5x2d6CIxMnaNFineZgxgc7xDhYLj9aty2u6Q2VuiVdD/WnnSn+d3fYczEkVDmk3
 7OJBUpGNPrt+lR3Ok5sJcWsZCoLHJiiniwC2VHB/ZfpsgGrbbt19ayRXBlvcLc2+tMh8r1hKT2N
 5pAfzy96AtOdwFZRs7z7Qs6iuiBcTvE7hyhKVzVcPU/l3Dxo2cDI8Y/S++Oi8NH337Gl8xyoPWf
 ERjhNK7ptE/u/g0/rKFtlmgJs34cprPvPFYHN3XWqEPYxtxxgOflfZ/FXceCvXwWpEQ==
X-Google-Smtp-Source: AGHT+IEP86q0HwW6IryU7wBM8LNSSonLa05qBU5704XgrVcL3E3Vwdd12asodnVUl3glcZbrieU3HA==
X-Received: by 2002:a05:6e02:148e:b0:3e5:568b:3cb3 with SMTP id
 e9e14a558f8ab-3e55af98ae5mr17636515ab.13.1754950858561; 
 Mon, 11 Aug 2025 15:20:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:20:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250718011530.1333880-1-trini@konsulko.com>
References: <20250718011530.1333880-1-trini@konsulko.com>
Subject: Re: [PATCH] nvme: Tighten requirements on NVME_APPLE driver
Message-Id: <175495085780.1657597.7148658795378754900.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:20:57 -0600
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

On Thu, 17 Jul 2025 19:15:30 -0600, Tom Rini wrote:

> This driver requires Apple rtkit headers in order to build.  Express
> that requirement in Kconfig as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] nvme: Tighten requirements on NVME_APPLE driver
      commit: f0572603514c7a5286121ebd1b13ba1b450512e9
-- 
Tom


