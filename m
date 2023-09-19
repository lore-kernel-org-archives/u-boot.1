Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DFFCD3448
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0060986A8F;
	Tue, 19 Sep 2023 09:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WeOHXz3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 195BC86A21; Tue, 19 Sep 2023 09:19:45 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EF1F86A84
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so668918166b.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695107983; x=1695712783; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVgnBsgKXzzJ/V41MylawU+dpqdnFLRdP/g8NkSCyNo=;
 b=WeOHXz3J28km1ziHTyNQgHH2+TsicE+zOhNqX2jBIJJwqfsiyHLlAWEab2V+ty57RF
 fpmH9CYRnXDfW9fC05UIBBS8H/bzwJF0Ml1dXtMJIMyxg9DAncPGORp1SQdOua1G8omi
 ZqgjEtEI1n0wFY7FnbxgHdFn0cYBvbKgg27KsL6vejWHdLQHufRQxE7tZUtPKK/Jlw0U
 ZtzL1Ph2Fsy4v88VR4nnUW9zoun7Wz2eheo2sF41ixjonQib1C2LlppNyNA1PXjhowne
 iGo/MmRQ6HCsE7jtmNMqwA5wg2L6b26SRm7MGvagAOIKQE+OV45GN2iWqlbiMvYshFrJ
 uy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695107983; x=1695712783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVgnBsgKXzzJ/V41MylawU+dpqdnFLRdP/g8NkSCyNo=;
 b=ZnE7HVLGHSsaDcsomhGI/Ij4vmbOrEVCiEPVCRN4jU38gIcmlVNCAenLccOJ+QnXot
 cYokDk+By0UMrsKcMR7zdLJobZTlKYQhWNVclKenrHGG1ekUlU7BQTcjDGD97CweunVJ
 J+o1xGTCPG/6tMinnFYQZkww7RMmtnILrIwch8fOA03JzHO1ST7GhXXg6CWxHZgIKunq
 dTa+6oeYVMC3otLJw2IYwEEPa79GAI0jZWLwBB56ezFG+gZFEUBm8RACC/vt8hRdk6wp
 SJX44pgNoDt2tPSt5qSNOwoPTBzK37mGlEx1UFa7c4Gchd25qWQt/P9ZxsyXTlDE6KqO
 qiAw==
X-Gm-Message-State: AOJu0Yy097K6jUQWcSF43sHazVNBKg9afrRFrHb2ceLL1P3u7dt62trL
 k2oV2Bune+ZSvmzPbO5mtHDqzhP8/0A9zcLlflM=
X-Google-Smtp-Source: AGHT+IHlpPD0thzSj9TXgKbb3OUfx2/u7LuwHuJ0waBXqGshu1Cci7UUE7FaOuAQLkSrwWMe/nppMtUAsGA7y33/gEo=
X-Received: by 2002:a17:906:5a5f:b0:9aa:20b2:35e7 with SMTP id
 my31-20020a1709065a5f00b009aa20b235e7mr9020082ejc.9.1695107982784; Tue, 19
 Sep 2023 00:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-6-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-6-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:29 +0800
Message-ID: <CAEUhbmXg24aiPR1YJivd6S4cJZLGQ8U5S0NA-f1p4c51+JJ6ug@mail.gmail.com>
Subject: Re: [PATCH v4 05/20] x86: Allow APCI in SPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> This is needed so we can find the DBG2 table provided by coreboot. Add a
> Kconfig so it can be enabled.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
