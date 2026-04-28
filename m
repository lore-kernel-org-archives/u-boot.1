Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DEFFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1518384656;
	Tue, 28 Apr 2026 17:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="RZUMrWrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91DCD84669; Tue, 28 Apr 2026 17:51:42 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5E78460D
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de431da8fbso5517392a34.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777391499; x=1777996299;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McjI8tBqgrEuVH52QNXlq5ptmMzQ4y+k20nfPkgEQQQ=;
 b=RZUMrWrBuBZjvq319dAsgzY/pzcLnr9tsfpgdj1SQ/Ems0X9M4MTfe15O7E+/HdQnA
 cHsf51rA5v9P1/eF0m4Z9B5KSPT66NNJKjomiAbrn41tdBAWH2pULHlhqzUWGZa7ldDl
 EcmeIisnVKhkTd8vKMXPUbKSloZ1me8GS2VMGlNF/sFnFD0yYOFa9WM6hwDx/jfC88Tc
 7silBia/8DkZ3k7Lc5Nm3qVTx3Z3W/e6b+m29p6z+Vsiz8B+lzENSXz15xyujte067o4
 /0mhL3HHigHTWGUExuSS2qUiq11hqWndGNGbWIOLIILdZ+DgZrnk4oogTfKd+BlZLOtG
 baRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777391499; x=1777996299;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=McjI8tBqgrEuVH52QNXlq5ptmMzQ4y+k20nfPkgEQQQ=;
 b=AnzO6SCJHLzPnpqVrA5uRybs5qI9a9cWq2pnJahmDMSd44besfCEwUpcA0MOSQgY5+
 eAeHWw527N7/dDx12tAZEDn8f8V4iGxz8h5MP1OV+Je9B3ne7Eu+bDwPYNDyhDlJt3Xv
 0RIoOJ60FtIwGPlIjh/5gXgPpaKFYgL1sdAcfZHHlhBchwfz+XIKITedWotgA0BsL8mI
 M5j2SLyJJDcbqbPNYSweocJ1HtDlhkl9MHVhYeE+L3iIZRR4sPPZ+yAx2O9cpsBtsQGK
 3LThZUYm9QJuPt3fLJBF7unHpN6bu3DGFlCtOZXc7qREOLmt3Vu90J6rqPNncMYvVjXi
 xO6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hxMfsDuMlRzLUGiLbYhXY9HRwCbmBykkPoMIRCxqVwn70/9hpmpOBhYDpWthNZJ22Qe34fzg=@lists.denx.de
X-Gm-Message-State: AOJu0YwQ+jNptRAXMjSXuv6514Tv6PElA9aHMYIBo0xovfw0WZfbt6JK
 z5SafLdgggb137Mmy4r91s/R8qzb2l6kKudeYJkd/S+P0j9hjQiL+h3dqCgffL03NHA=
X-Gm-Gg: AeBDies/u70MVgcDJ2SUe1fVa5o3MlkT5QOWXr20EdCubReoFHqPj2+0NPG9eTVrazy
 yEnz1P2qyRPYjxYT4jM1apHE4ynHavOixo8eTTPMLN3j4ljSfbUQsUoJ0DRmCMj6+hVYV2ZMK0/
 Z8qIOBW+ZuEm4rf7Ygf5H1Zxq5mEwHwUCrLaCR0bEIK+g979Tpbo4+OLxQqzUD9wg090+ScDDlF
 J1uTuNr33/4uzgSL4Q0CfxFY5dCD1Bx+YQgV5EMAXZDWU7tngfZTlmtfIn17MDjMMPt0YiAv5qv
 eqvOuSyC1noa+rHQGXFGTTVYdaryg4GaILcO2FDLzl+ZiME1LE8s1G0jUPBQNhGUW9vsQ5JOOQN
 5P+igWjVETNeTqk2xc9RmUAYFZ9nQXzLOlEGauEo5jCJs1Aaq5mzxDL1pGhgbxHG+PNI5lmMHuf
 qIhTERRNr9ITKCiIMP1lAbpNB5LDiyHokp2O9B36VMze2e/dx0aQ==
X-Received: by 2002:a05:6830:7103:b0:7dc:e38b:d9c1 with SMTP id
 46e09a7af769-7de9a0b56d7mr2167994a34.13.1777391498859; 
 Tue, 28 Apr 2026 08:51:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:efba:bc47:a81b:dd0f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de9866be1esm2007875a34.18.2026.04.28.08.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 08:51:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: "ht.lin" <ht.lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Weijie_Gao_=28=E9=AB=98=E6=83=9F=E6=9D=B0=29?=
 <Weijie.Gao@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
References: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
Subject: Re: [PATCH 0/3] mmc: mtk-sd: fix HS200 mode writes on mt8189
Message-Id: <177739148534.3382222.7803122222330879634.b4-ty@b4>
Date: Tue, 28 Apr 2026 10:51:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=779; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=pJSPRryvvHYJjqKsWnXQ+p5pcsTA1yR3aEITTKCqEYU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp8NeAlBSWTc45kIk4Gzz24zOww6epRPSiegoC7
 fo9Qk2Ltc2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCafDXgBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJg0H/iuT9ynxK80ToHMi+aSZJ64WNJ5bfp91dWQi5dP
 NbbplRv8HPp+tOM36M1oSCKcRz7KlP4NkZr5m2q0Bl3YdB1jQQZOaC4ximq2zsrMq6bCBeB/+jC
 Od0l2oSC2jIfMWPom4dWanfc6ayYUN1xl67KJV7iRfFlnc01FR6pPIwSfxo+7aX774R2/U3taQb
 t9bimLPYCmV7TM3ux+X8EkLbdpjSx/DI/sijsUleD+HUXDDFxZM+wYAewe86BjbU4PBiq1tL3kJ
 zr+8vkgVuDjNee/a4u9AqG+Q7/sKiDCocdMm7Hp2JGFUQ8fQ54Y+kF2xDtKA6wyjcNYGSlSoqUg
 s3/I=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Tue, 21 Apr 2026 09:24:03 -0500, David Lechner wrote:
> mmc: mtk-sd: fix HS200 mode writes on mt8189
> 
> This series contains a few fixes to fix HS200 mode writes failing on
> Genio 720 EVK, which uses the mediatek,mt8189-mmc compatible controller.
> 
> For example, trying to save the environment to MMC would fail like this:
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/3] mmc: mtk-sd: enable DMA on mediatek,mt8189-mmc
      commit: 336602a2f912fd19eb717083306e54804bc92e79
[2/3] mmc: mtk-sd: enable async_fifo_crcsts on mt8189
      commit: 93f67d893b32606cfb723b82be783a013c16fc0c
[3/3] mmc: mtk-sd: fix msdc cmd ready check
      commit: 8436dd6b0e7e529fda238edf762076fa436bdfda

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

