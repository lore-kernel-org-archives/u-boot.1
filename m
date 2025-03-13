Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D847C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEC098169D;
	Thu, 13 Mar 2025 20:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eNl4/Trj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E113E8175D; Thu, 13 Mar 2025 20:55:47 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4273280FF7
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-54996d30bfbso1178190e87.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741895744; x=1742500544; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LqTmRlgyHXZGE3tZgkTAaTRPEz7ixvw8jYTENlo8t0g=;
 b=eNl4/TrjxvQdBGdQpAygZaUMVnN3swCwv3aRusMJynWyCxM7cfBl8SnAOzMFZpSXDd
 m5XQe36Es4zxEa7LnMM1lHEXZx4ttV8n8byRN5Avn32jp9eax5ULd76+/OwFpkWC0noQ
 HBgF50biCbA/MWYprywvaUqsxAjT+u0dSJapr2dNetrNkJoXaoa8yFtD9+pYIB3tK/cV
 BMbA4rhBaA+CxQ1v/8QBY78olsWkuca3kbGhLZFoTh/fX0Kylh2rKz/H1TznqPtkcGJM
 rg2QrykeXr2fryt7TpKP7CyU3iK/E7gwaEFQxtpF+3im2ryOFXslYfz7NG8kr/S+It89
 JEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741895744; x=1742500544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqTmRlgyHXZGE3tZgkTAaTRPEz7ixvw8jYTENlo8t0g=;
 b=SJaLEbS/D06SobC8jn857WzgUkMnzcFmakT+ygi+Xu88r28AbENt7xnUaBVXHRGtRE
 XFs18iccy2DSh8tvlLTbIaxHF3GS+807qWyf0+ZALtcchLqt9cmM8bxt2iz6PGJovne3
 NIuS+EapramqLch9O5OH/0fU/Lre2PzcMtKeSImuAqWWw8S+VtmjZr1WURHJ8ood3WFa
 j2Gpp9Ad8soa5j0P4qzpgALDRBdJoNeKlZJe+SG4qFkzHFWYQFAJYlLrmt3O5fHqXNU5
 2fl4ZXAx7Tg7Jt4z+WZW9BE7RnacArWuldJtRRWFZk+5WapW/OvBHsQDIVFSAROh4DYP
 lLaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8uIwSIISnLby3NiV6wQLcs82WaaRsnJ4ooSM4QbT+Vcvk6bPJN3LuRKm9DSNEeZ/eAF96a60=@lists.denx.de
X-Gm-Message-State: AOJu0Yyw4hX+GFxphD7gVSyhGACMkSDIYmY2WiezfUUcFC9yjAIrgByA
 CtfMvpPrqzciLWa+bMwBzgLCqaux+L3nUuuovNgdAgZ1+Eq/N80W5oj0biM8nd2LQvDl9/92WrZ
 mU3CDyvoYu2lHuUy5mEcDRqXotgA=
X-Gm-Gg: ASbGncuZomB5JByWD+vDZk5xODPu0mkaYLinyeTSwe8i1417wmBaLLTmunkVCpa/FvA
 T7Xuv4UW3cnus1r02WQH2ISGXk4ANOOg85qj9n4TJeM4CGD2gPimHLkEoajBSoEc4PsdZL36cvz
 kK2ZcMZUPNDMvh1mDHm/TOYYD7nsLhq5T2QO8ZWANLlvzgfEuPMFH8FJ9iYA==
X-Google-Smtp-Source: AGHT+IGMXfBhpk3iMsebAKu3JwyxIIQ/3d0vXXR2xMy8ZmgHEEk5NF8tgxu3S2DW9XK0wpvSLBWQaMuRPasSLnYT6MQ=
X-Received: by 2002:a05:6512:acd:b0:549:8ed4:fb4f with SMTP id
 2adb3069b0e04-549c09f8d51mr418572e87.23.1741895744213; Thu, 13 Mar 2025
 12:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250307103454.32661-1-ernest.vanhoecke@toradex.com>
 <20250307103454.32661-2-ernest.vanhoecke@toradex.com>
In-Reply-To: <20250307103454.32661-2-ernest.vanhoecke@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Mar 2025 16:55:32 -0300
X-Gm-Features: AQ5f1JreF4OesKFr0Q86QivPP4FHIRkDrycK3xfQnSEwonXtDRBwCnDwCmfKOo0
Message-ID: <CAOMZO5CoL4ZJSByySCeRiSBw7GqrMBwViGkadr7Qb-vzFC45_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] board: toradex: apalis/colibri imx6: Detect new
 v1.2 SoM variant
To: ernestvanhoecke@gmail.com
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Parth Pancholi <parth.pancholi@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Simon Glass <sjg@chromium.org>
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

On Fri, Mar 7, 2025 at 7:35=E2=80=AFAM <ernestvanhoecke@gmail.com> wrote:
>
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> Apalis/Colibri iMX6 V1.2 will replace the STMPE811 ADC/Touch controller
> which is EOL by the TLA2024 ADC and AD7879 touch controller.
>
> To support this new version, we detect the presence of the TLA2024
> during boot and set a new environment variable named "variant". This
> will allow us and users to select the correct DT easily.
>
> By probing via I2C we have a robust detection method instead of relying
> on the existing "board_rev" environment variable which is set by the
> config block. Users can use "variant" in their DT selection and do not
> have to map the board revision to a device tree.
>
> "variant" environment variable behaviour:
> * Empty or absent for all versions below v1.2 (STMPE811)
> * "-v1.2" for all versions starting from v1.2 (TLA2024 + AD7879)
>
> Usage example:
> setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb
>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2: Fixed the "From" field

Applied both to u-boot-imx/next, thanks.
