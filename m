Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634FFC5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5BDC8843A;
	Fri, 23 Aug 2024 21:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aeVF9LAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 154F088B39; Fri, 23 Aug 2024 21:16:53 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 371BC8843A
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-533496017f8so3127467e87.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724440610; x=1725045410; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pH5KcBkhDtJZ12oWMfclPO+0g8aBM78hSm3zqz4ukMc=;
 b=aeVF9LAoG1lnScrQL8f8kScye7uSAtKqnLMubgRGjBxoAa0JhmgVkUFa9TjJK5blQO
 n9y/vijZl5IxHCpHIZuCS6sbrfInedODWHuH1r/gEAH75YS2ce3JsqhLjjpGCop8HwAH
 lZNksR1k+PGNsMrMi4Ijyqms7v2A8uaNzeJJAcAt7dXnQpcMmLuQqxqclxLUdYFJwhJB
 BvKGwPFP/63OntmJtwTroqClSfR+rPdqh0PGrwjH2yN4eMEs3sFKCXRV1Qcdu6dFxlH8
 vAMXYb6neWHNeyRwe/OsOtQFzwPFPDBGosEnGfHQM7WE+TO+5X72xqFLsjJGn4VPvwS7
 2RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724440610; x=1725045410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pH5KcBkhDtJZ12oWMfclPO+0g8aBM78hSm3zqz4ukMc=;
 b=MmulP02LUg0QVPF/JfaZDJyrzBnFVNZJCfXwa3ovBs5OlPMX+/waOLHJizvHLMNAzm
 V+ZVLskXQTvUqjS1FRkp/se0CE0G4riubphEY2UzlMjZSJDFeOlM8fOcK2BES7M2GiiN
 JEQ/50nT+TFTnoFv41jww+MPm2HEULsDljTeiXiWcdUNAHU6NhfY1g4g/SBt7b3s5soz
 NDIEdS4u0OmLBRgYg4SYAk3xbSGhZsLVOzk78EvJtNNT+3+HPOQSoKY5NkrJTULjwVZE
 tbrNoKHM31cUZLBq/ZprbrZI+qPn4/3dH9O4KMiQG7aimdhUXSmWrtgtETlRZrVZbHsz
 8Rlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtpi2biP/OAGbZ5Blg9ARa19DvHeCfg0i2E8Q0PJ/MeU5ilKvFjwxxfLrQjSL3v/Vg5pSCC2g=@lists.denx.de
X-Gm-Message-State: AOJu0YwXZrhSyM41FTBmzPji/RT8vuOeP1XjcXj4QsAhl0MA8HF5cBxR
 rXM8O4GrlazB/JBXBoRMFuYXGBi07fRdnnkpQ6LgOYTFLsW+7pV74111I9OWNCYSbYwbW7j+o+L
 M1QKVH/0hJr5d7Iznvcxw1wjUF0Q=
X-Google-Smtp-Source: AGHT+IGscgOpyni9zRhBZrviNMxhjByORZzraY6a4ajIzB5hy/UOS0MIjWSmwWcD8ap7P3P8i+2IsBI+GBYOYXvKdnY=
X-Received: by 2002:a05:6512:baa:b0:533:4668:8b86 with SMTP id
 2adb3069b0e04-5343885f620mr2529150e87.41.1724440610010; Fri, 23 Aug 2024
 12:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240820154630.78976-1-y.varakala@phytec.de>
In-Reply-To: <20240820154630.78976-1-y.varakala@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Aug 2024 16:16:38 -0300
Message-ID: <CAOMZO5DoZhihtKw-29ytQv19ADYGhv_r3MmojOKRT=gdn+x3_A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add and enable mcore support
To: Yashwanth Varakala <y.varakala@phytec.de>
Cc: t.remmet@phytec.de, trini@konsulko.com, sbabic@denx.de, 
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Tue, Aug 20, 2024 at 12:46=E2=80=AFPM Yashwanth Varakala
<y.varakala@phytec.de> wrote:
>
> Added m7 core support in uboot for imx8mp by adding
> the boot variable prepare_mcore and enabled bootaux in
> defconfig.
>
> Regards,
> yashwanth.
>
> Yashwanth Varakala (2):
>   board: phytec: phycore_imx8mp: Add mcore support
>   configs: phycore-imx8mp_defconfig: Enabled bootaux command

Applied all, thanks.
