Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF5DCCF9E3
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 232EF839D6;
	Wed,  5 Nov 2025 01:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bh/ztj8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D07DE839E2; Wed,  5 Nov 2025 01:49:27 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C028083981
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7869819394aso13835377b3.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 16:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762303764; x=1762908564; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxsKXdHNujsVDuiKMRjC06+JEz13YPdmEt/7A27u4Dc=;
 b=bh/ztj8DWRCtMFrzA8pi6LyELS+JCnZoRh3mrsK+mnlCRgq1bI9TkBfNiPGA3PI+JD
 a2kkQ3Ed3qx0SIuJZ0LZyHOUZjS7bVeUQz1IMzxp2Gftw9iEezO7vGhWTw1c3FvBscJc
 csuGoW2uBy8pavkmsa0NJI9b5xxPn5ATpU0PpQyKpTBV5D9Q9ywQdotQwEd4cJyHlx9V
 ffePaSOPJJtzneroBRggORk2nO2oVPzWjEB/gzzkL6R0qSQgjYz77bCYty2HFtFxqPjO
 CUalSc910SjUrAJ1YdegTz0OYlTIVlTRJKZvB0YBXUqu9HlSkgFlXX+ePyhMjplCE9YW
 virA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762303764; x=1762908564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxsKXdHNujsVDuiKMRjC06+JEz13YPdmEt/7A27u4Dc=;
 b=tOPtpPBHjIiXI4v+e6d7vwkFSq72g5I5R4zy93uokr5czSFKuJWRfosl94hKcPmIbI
 C+Ji8HcKo2gXhoTRoVXbUHy2H0IvBdUpkJSlipPvm1MqVOH0S3T6OR/reoBRHW0F+I+t
 aT1Tbxa/z4BIJvFonnV4Mbrrgn0Z0iS/bzEhQbJSnsdUVUFbZ8ZNV2Bhw1iSwUDojZGf
 NQMnM0kXk8R1CO21RId7s2Q8xMUm1WovsQdsaufs0tVcbu0l/ODvn7/+fx/qfYd6Dc3u
 15z1VV3ZtGxw7QaSwHqhPo+92TcYoiP/h1Gjp4z/NxKz0Kj9/FefPse93FtK2yP5d37U
 1APA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM29EDWtc5ogRJMV02BNdSW+XwfC1+FOijlnzx8WGltJeADBMDlB3sKov+juhyXPalOniER6M=@lists.denx.de
X-Gm-Message-State: AOJu0Ywep+VLXeJnHV50NkzniG1Qb1013zTkPgoUXslnhFKEMplHnt/E
 YYM6DjiEq/C6+XDTD1zbgAMjv7bi1NH33DlZtqu4Hnllm4IRLIUSlUQCCEeeXb7fJc8PnNUtRxg
 nImXR2tTnLkoE0JTu1R4vw6103HDd3nU=
X-Gm-Gg: ASbGncsmMtcFAMfWlsqRffaByGx5zfimC2WqtiG89hDOiw/ArMCN2Zvj3nJE3Gb10QV
 PZSR9NI3snBqYcoZ2T11B7T9nKBqquL7bi8FMBk9vn6Mwu0GnMDj1i5Vaed0XT/btiRc4z+LNgO
 J+HaS1yL6RvKhl9VeBchQcBI83JQdXOuo1WhxD3DZdxAuXaYBrBL1Mm/8qStuT5UBXqoq+LFTPc
 CCS5FFb+aAjj56rCiKRSUN6EkLjoL+LpSD4FxC4/1ub2QCwO0M0wByQokNh
X-Google-Smtp-Source: AGHT+IHfyyWlLCAtmNIQB2x7HdncMdMdGv9eXAtWOYBh1+MA6hhHa1cL1aP/z4QsR5a6sciAtwt1TWm16uN86bW50ZA=
X-Received: by 2002:a05:690c:55c7:20b0:781:534:e754 with SMTP id
 00721157ae682-786a40f8622mr13973737b3.21.1762303764622; Tue, 04 Nov 2025
 16:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20251104232933.88528-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104232933.88528-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 08:49:12 +0800
X-Gm-Features: AWmQ_blYe7P1AMm6ghWAGfb3GLV8k7Fvh0fmwfQozje1oKjrd2yOXI3A7hxBxfU
Message-ID: <CAEUhbmVes9kfiktBwiEgg4JnK+sTPmvtQggucWASACXvN=SaBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_driver: correct formatting in efi_uc_stop()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Wed, Nov 5, 2025 at 7:29=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Correct indentation.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_driver/efi_uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
