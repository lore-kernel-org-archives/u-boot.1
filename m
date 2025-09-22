Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA07CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3982A8349B;
	Mon, 22 Sep 2025 16:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S0kKOXjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 586E7834D4; Mon, 22 Sep 2025 16:24:51 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6974883443
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-366ce79fbeeso18493181fa.0
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758551089; x=1759155889; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/SgYUoO9NiexQDFCRtL4lXhuY/H0ZM6suHOCkGARNA=;
 b=S0kKOXjWLAOIRiv8Bb9gi9BAj4RmWNi6mod9o4/YH0asX4maKJr2ruUcy0qxEYNwep
 OW8DOrUlGuXgvg0S/xtM3SxvVTLvtwQvaRyrSnUDqgp86S/u3qOJaWImc6Zy3hQ5m7Ak
 Vb2WRlJlr+lfhNGAb17WozrMfVvsLgsfJ8D/rkt6pfupzDTjPd/x28BcHN19v0ks0em1
 zXVBWVCz6uk/G5CRkCCEckO1OqIiEQS7xyKDEr8n4gTe7EKc/9wo2MoNRVENGV3iMNSY
 D1lbQA1edXlvwgERfF3kZLlkFhoISFo9VxwMRK8SbRTfXbiy+BgcVQjThLnp6lc5jE0w
 MKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758551089; x=1759155889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/SgYUoO9NiexQDFCRtL4lXhuY/H0ZM6suHOCkGARNA=;
 b=VvIDBCUt+3ZBaN1+RKb/mNiZAp/nFtZJjJmsaXWY70M8bIFcDDLctDF+2hWqF1P2H2
 Tiv+etsviy9vlL5EZNiTI4IfVqicIEsYX+ibvdYYJtJrs0WwK5c5LJr7d4Wb2yZ5kzH5
 PmX35gPvpHw2KvtyzIEE+oWNMk0aJKXn8BjAB6ijtTFzTOojsgMpkla3oBffwYfGPoJS
 AgzYfiJ3ncsnCxsBbzAE6mqmYnL3lWaikuFZN2hh4ZB32SnnQ5IAe9M+5Vw8nBkFGj+n
 htrfWVybkOkFhK6GepfzwStr3h/Vax5YLyS6FPoiO8PpnBx2Ygvl3dQbNJCpEdM/KKpr
 53Bg==
X-Gm-Message-State: AOJu0Ywuu2h7yEn+/NwCvEfUYjm/54Yf52C6RPqBz+5VqQBTTBsCkGLp
 ZF8033q9rV+gffWv0s5HcR4ThMSVBIhVctIUiYGr8eRqVEioTfCXLVP+WyWZmKEDXYkXG+K6il0
 B7zvIjFaJJXzq4gopxo2CS/eWv8Qn7Mg=
X-Gm-Gg: ASbGncuA5I/Ea2rD2HfoyIONWT8POhuYAe2U+BeSh4k5/cU90u2pnkbgCqTHAtzgpUx
 Fr6+nKEEYCDdDclO24a+Xx/dK3uyV/7QQC8cmnJifdFBx/KDuCjtZGhf781VXFjXje3Nhe9PG5E
 hlEp33FkoZ1HVyww8rwHXsD/yvKcKjz29tvRmRmVVDHqNDkyl5+6A3aCApMw8HRtFJD+CLs0aFU
 yUGTe0KVLl4a1MQADoaYJ9U/0tRmmGRX6vqBfo=
X-Google-Smtp-Source: AGHT+IFoTJTpG+9iR86uz6pEEinhkt3egNv2sz5QCK1cWg/p0E6iaHP814gWlfKYqYZIK1+htwSKoCxneyWISabbtzQ=
X-Received: by 2002:a05:651c:1509:b0:36c:259a:c916 with SMTP id
 38308e7fff4ca-36c259acbb2mr7660171fa.20.1758551087117; Mon, 22 Sep 2025
 07:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250919065834.1497068-1-ye.li@nxp.com>
 <20250919065834.1497068-2-ye.li@nxp.com>
In-Reply-To: <20250919065834.1497068-2-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 11:24:35 -0300
X-Gm-Features: AS18NWB5ywhh5PUoX41JNHGVC-akWsRR5bgaz5VknRLZeFkCvWXdA0BHB4O3zKg
Message-ID: <CAOMZO5Abi64vTgjj0N1jQBaYa3dvffFF0L-HLppGVYGfq_LcTw@mail.gmail.com>
Subject: Re: [PATCH] imx8ulp_evk: Fix ELE FW version print bug
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 alice.guo@nxp.com, ye.li@oss.nxp.com
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

On Fri, Sep 19, 2025 at 3:59=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> According to latest ELE Get FW version API, the FW version word is define=
d
> as below. The patch version only has 4 bits and minor version has 12 bits=
.
> However, the codes use 8 bits for patch version and minor version. Add th=
e
> patch to fix the issue.
>
> ELE firmware version
> [31] - When set indicates a dirty build.
> [30] - Reserved
> [29:28] - Hotfix version.
> [27] - When set, indicate that ELE FW is authenticated and operational.
> [26:25] - Reserved
> [24] - When set, indicate that an alternative FW is running.
> [23:16] - Indicate the major version. This byte is checked against the
> version set in the fuses to determine if the FW execution can be authoriz=
ed
> [15:4] - Indicate the minor version.
> [3:0] - Indicate the patch version.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Applied to -master, thanks,
