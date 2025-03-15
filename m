Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EE4C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 11:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F5580C93;
	Sat, 15 Mar 2025 12:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W0edXipa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA4D80E93; Sat, 15 Mar 2025 12:58:17 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC212809A4
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 12:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5493b5bc6e8so3051106e87.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 04:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742039894; x=1742644694; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJQgfXJkXdbPmWAM2BOhG+tbZI3GcNkLoS5ljXa2wmQ=;
 b=W0edXipaLs7D6DxjbrYwSiQKtqgpkHyRhpCpDRmccpMqPzI8KuW6qBKYm7l4Q4rH/7
 GvilYX+UiSRFodQEQ/HnR3AcwJfQ9WpNVdf33ariYpfjlWKr6KQ3SKjrndSTaJIrblGJ
 9UrMGB2ftYYCa2hCVGiQ2l1GOI0p7eWWrzpu9kSH3GvOIjPC6p+yGK5yAkdFg2Sdcayp
 XyvbrF7/H202YYZb9+2vKzGBdBXR6J99F5349spr0TNnPpgIhGc8AAzXaZozdM2ZHUDj
 uGEbm0XG0HLlBD0tg4vS9VfxDAiWW5d+qbNBNDJH2nlvM6Xlr8ZfuJLup2iHLiRAibqn
 oRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742039894; x=1742644694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJQgfXJkXdbPmWAM2BOhG+tbZI3GcNkLoS5ljXa2wmQ=;
 b=AZV35YAqGR6zn6rRLuvKnUjiGylEpSwVjzvS3NIIkPLsOCyZpzIRBKEdQBNoB0RQEH
 0L8AneB+oOxT20WY/l7EZ3i4OIn4XOjMLD/+tAAq+L9k6u6XhoOoSmokFWQ/EIbxYMhE
 apD1a4HhRAdLypzYX+sfNf6Pb2dXMeA4nETy1mv7bQhQEgXzhiKouiXQyDTQzluw1liz
 jub1GOkDbrfpsDgoi+h5RwZ9G5bYcYaQKw1sKbQMMXTGvQIp5SRoSzkFjGe/Qvao6vS6
 PXma7BrI6Yz3gfkY5PMTPOUXhZK88mFe8zHsmjz7RgnDsN0VslVyxpqePMZ0tpMIe3ym
 Yc6g==
X-Gm-Message-State: AOJu0YySweyc3VzR9cTqGfoqvyb4mhX6Ox9mVwtgOKU2tbIDq8S9q+Jg
 iRpLftBjOiMrA3Wp0fqNzucd/Jzny0qAOL/+7fIWuW959wWi2DAj8kIHgIYXZNZsNB44BXODmJP
 XdczIqD8ObjQzPwrA4z0SBSqWM9k=
X-Gm-Gg: ASbGncuyg2wJlBXa9B1ANr4CMtwwA2Ogz2wmct25/0wbAuWCV8TDicgywRLt5WXheBU
 BOJY+8ep7TOWm68fFD3/e3tQE9xNU3OqgRjyLwYNHieBe/qVEDMelxyFp3PuMsvfcxzsEiuzxay
 VbKdEHiY8IZq3aSfwutVfAdm12YifPBuIDvKoy9/3Xe8ORGQMbJlCkcUH79A==
X-Google-Smtp-Source: AGHT+IFJW3FzuoIVXOaxkOYdE51E3W5mHPnDGGWVRgw/mkU+dJsb7tfoDPSNev5dkb6+3b7KJgVyPlVnhh4ATIygl4g=
X-Received: by 2002:a05:6512:3192:b0:549:7394:2cd0 with SMTP id
 2adb3069b0e04-549c3907dcamr2343369e87.19.1742039893829; Sat, 15 Mar 2025
 04:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <2849ff05-ef67-4471-aece-422daa57040f@cherry.de>
 <20250314200832.154758-1-hd@os-cillation.de>
 <20250314200832.154758-2-hd@os-cillation.de>
In-Reply-To: <20250314200832.154758-2-hd@os-cillation.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 15 Mar 2025 08:58:01 -0300
X-Gm-Features: AQ5f1Jq4DlImp1T4zeF1jVuDDqvlBbVOw4YYx_jhbsPMwu6ukz-aRM29cfA9X9Q
Message-ID: <CAOMZO5BEhVGq7JGOcL_hsNAe8Qf84tKkFY1_+mm18dk7842p3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] imx8qxp: Do not use CONFIG_XPL_BUILD in device tree
To: Hendrik Donner <hd@os-cillation.de>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

Hi Hendrik,

On Fri, Mar 14, 2025 at 5:09=E2=80=AFPM Hendrik Donner <hd@os-cillation.de>=
 wrote:
>
> In c9713c155127 the device tree was moved
> from CONFIG_SPL to CONFIG_SPL_BUILD and later to CONFIG_XPL_BUILD, but
> the CONFIG_xPL_BUILD defines are never set for device trees, breaking
> the build. Move the guards back to CONFIG_SPL.

Please provide details about the "breaking the build". Which target
fails to build currently?

After applying this series, the previous build failures return:

aarch64: + imx8qm_mek
291
+WARNING 'mx8qm-ahab-container.img' not found, resulting binary is
not-functional
292
+binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n
spl/u-boot-spl.cfgout -T imx8image -e 0x100000
./mkimage-out.spl.mkimage': Fail open first container file
mx8qm-ahab-container.img
293
+
294
+make[1]: *** [Makefile:1133: .binman_stamp] Error 1
295
+make: *** [Makefile:177: sub-make] Error 2

Please check:
https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1062980/viewer
