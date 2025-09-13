Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169F8CAC593
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 19:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0888D82AE1;
	Sat, 13 Sep 2025 21:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BIQpr4+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D854182AE1; Sat, 13 Sep 2025 21:31:27 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A50D80B9B
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 21:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-55f7c0fb972so3029107e87.3
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757791882; x=1758396682; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnvU+SEvyGABBmnE/Vn+0iFfdkFxly3UjoFjtz4rdRw=;
 b=BIQpr4+dxOnK7ouIwFKykvCFtbh1B5hZ5WD2QUbztr+wV0KdZX56mV0Cxb47irGpKY
 m5pLZoZbR4/wQy7HIfHVRP0pJh6IZaO7KWO4xq5nH8DFKUlAInvPTGLfqatKJiQ7i7KA
 /J3dht+IJsfLGOgsmaaYglCgdc1EeUWoluVBzpuaoNOr2R0mWGBSY3aPtJHXVl3JDIsq
 ATC2fGIlO/uzbER6KRTsag94/ZZv4gCxms79LDPp15AM/KwiIi2DjH9IWBkoIhfHjcQ1
 tMX98AGWsGAsH0NWlCQqO47DbYCi6Dh3d3UxbOxlpYsiaLnvvTm1VpTWthMnq5uzAgzy
 n7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757791882; x=1758396682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnvU+SEvyGABBmnE/Vn+0iFfdkFxly3UjoFjtz4rdRw=;
 b=mCDG7hAQUH1GNQ2D/fOuzFA9RMa5TQDlxb5uY4fDlckYnEb1YDD/UThWhntCAz0LOh
 gcsBLvLH5JUVkj/NmaWbZ4mtYb5rCMKq+lWroSoqIGdLQtd8S6RnMt5EupVWLXlE91xB
 kxh6OjHzSRENZyW2w4prP910AhezhIwiF7lPzOdQWDnck2V1+5RM2PwME6QXfkWHZUIC
 8ROwPQCh+TmzdSXRcV/xXRd4xfQbPPG8CaXf6mwkGMRhYJxgfLXAtSPmC5WDO1qMYDak
 rKDQU62GY9bkH0FYRbLp4OiMWJLU5SIsFbH9iE8zHWkBxs6n1LSvPy4UC4MIKHqaOJyc
 KkZw==
X-Gm-Message-State: AOJu0YwPnNtgQHKlzCDMTJ7NL0sN3RLfX73kyNReEpzV1kkKLgqq4Djp
 a1aE1EA5bTZ6ytB1be5N4CQuxNCrtUVnfQZnbxxTDhqSO7u6QBISn9Rhc729UTy9YtVN+8ptGms
 9Nw5YHRTVHvo4xshfWX/W9kzx/E/ccUE=
X-Gm-Gg: ASbGncsATwtZLU5B+dgF1M4gSVHEYNX4GBg0x7C4thGtlNTfCm2R9tYYAqe/i/wwAA4
 ldKaJNI4z4KOVHTT7lWQxHJexeHmhGwvoqvInD3iHiaOt6JQTTEDH2Ur3duRXiNyohXvrlEqZik
 85BozTUkxz8+HatfqLwTauim+pGO5OI+cHQisGQaz4lY2NK2+4lQZL+tqUH11m1wncfk9jM97KW
 duGRZaIaKxJI3mbCoxp
X-Google-Smtp-Source: AGHT+IFJADRYqsg7hR+qEiKNASnpUGmW3DtfZ2srm/Jjd/JY1JJISBIMBYIq+unfb/jxCjGrFuC1j3FNxac5iSMa6FI=
X-Received: by 2002:a05:6512:601:10b0:568:e790:ae29 with SMTP id
 2adb3069b0e04-5704e910761mr2056864e87.47.1757791881521; Sat, 13 Sep 2025
 12:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250912094111.319680-1-ye.li@nxp.com>
In-Reply-To: <20250912094111.319680-1-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 13 Sep 2025 16:31:09 -0300
X-Gm-Features: Ac12FXwNXuqkctgqCrElIEofYvgk74pbXKp7bMV98lub_bKj5KWXzjN0safHWpI
Message-ID: <CAOMZO5BJ0Ds=1JT7p5e-UoK1Y1zmp1r2TE2VQ4=_de9RvojVFw@mail.gmail.com>
Subject: Re: [PATCH] arm: armv8: Fix spl recover data section broken
To: Ye Li <ye.li@nxp.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 alice.guo@nxp.com, ye.li@oss.nxp.com, tien.fong.chee@altera.com, 
 alif.zakuan.yuslaimi@altera.com
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

Hi Ye Li,

On Fri, Sep 12, 2025 at 6:41=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> SPL recover data section is broken which causes reboot failure on
> some i.MX platforms (iMX8QM/iMX95).
> The global variable cold_reboot_flag is assigned to weak reset_flag
> function which always return 1, so restore never been executed in
> warm reboot.
>
> Fixes: 1c37e59bfbba ("arm: armv8: Improve SPL data save and restore imple=
mentation")
> Signed-off-by: Ye Li <ye.li@nxp.com>

Thanks for the fix.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Tom, feel free to apply this regression fix directly.

Currently, I don't have any patches queued for master.

Thanks
