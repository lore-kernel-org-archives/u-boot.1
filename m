Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093A1C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 01:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C8687B32;
	Fri, 15 Dec 2023 02:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dGlrMRo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB6C87B3C; Fri, 15 Dec 2023 02:18:00 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E9187B30
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 02:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5a0dc313058so40049a12.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702603076; x=1703207876; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MZEoHZbLh8OH7uCmEb5SsHRBDptv35ysvEWs56uZ/0=;
 b=dGlrMRo8/uCPv3b/He4hhrGk8VaO0+ELmW/JpaRg5eKTLO82jA9/x8MXzTJsnvTB2/
 S06hfUO7MODIjpUZ3FW0g5HxzBO6PFn5W1YVI6qSiwU1U9UJ2lKUU87WuI/L1/fcnvG2
 /oQ4VjClvfioW9Wxjkw+VcOxPM2qTdnho1pyrivmK+Oul6kWxJwiXTHUV0wJe/oSyNBI
 1hMaMSi7BQ8+rX/5oZtyZtUbDXvqAuGlysNtcHpCxDK09sb4B22Sw1O67ZEuJZis1BCX
 ns7FokxKJQJA0xlOXSERFyqvX6tW1uyPC2/tmtoeTvBlkdf7hJlWOd8bAMO02VStVuz7
 fq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702603076; x=1703207876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MZEoHZbLh8OH7uCmEb5SsHRBDptv35ysvEWs56uZ/0=;
 b=wtYn6nCGzPwSGLj3rFNMFBX4Fc1eJlDB/kTheJCHr8Vqaja/JV/sTnZtgSgf57/oMk
 iRfs/3A40nBa3Qz3oUI6FK55YVyP8vXjWuc/q0mIdZn9VCZU+LU5e6SmyIOk1EDIQ7V9
 +NHxV8cLWAtDS/MkAjUsirCudvPUUkMrH7QVPCJ4WmrGIa+5q+7DPWd9weSmYEJFEFme
 H6eDzXnr81fX1ZoVLumlHDpprOMT+yjfXPog79YeNvtxhzCmBDbeuLO5ZtEMwQy0lf+a
 vrvqAAtDZ0ZOYgKE2Qiqqj7tskPF4LhrLpkw1Z3DehAa72M/fiLD1bTvJc1BB5wR2afe
 vEhQ==
X-Gm-Message-State: AOJu0YyuTC9B9262T20Mrq2o27tdJWG3wvmLrxeRru3eIcmJJnfsS2CO
 6TpsuIMXiq2FoCeTC4Rdq3PN9GWMT5kJul+Xics=
X-Google-Smtp-Source: AGHT+IEGAyaBFjvVFuxEzSMLzZuDbeaVwkq1plBrEENSodQ4BcttDiRYcYx7rMyNQffNKYY+mG+Usj2JlFSVbhJX8sY=
X-Received: by 2002:a05:6a21:78a8:b0:18b:1f5d:b105 with SMTP id
 bf40-20020a056a2178a800b0018b1f5db105mr22553045pzc.6.1702603076322; Thu, 14
 Dec 2023 17:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20231202014906.212885-1-marex@denx.de>
In-Reply-To: <20231202014906.212885-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 22:17:44 -0300
Message-ID: <CAOMZO5Ap+r1G8UcFndtN153OLLVRucddEWoTm6HXnPibfBCrww@mail.gmail.com>
Subject: Re: [PATCH] ddr: imx: Add 3600 MTps rate support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>,
 Ye Li <ye.li@nxp.com>
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

On Fri, Dec 1, 2023 at 10:49=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add PLL settings for DDR 3600 MTps . This is very similar to 3200 MTps
> PLL setting, except the divider is not 9 but 8 .
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx master, thanks.
