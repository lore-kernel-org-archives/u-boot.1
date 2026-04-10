Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB39F45A0F
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 23:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03DAC84181;
	Sat, 11 Apr 2026 01:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JLSOV3zX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B623D8418C; Sat, 11 Apr 2026 01:01:05 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C418A83DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 01:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9b1ffbb9f5so368434666b.2
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 16:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775862061; cv=none;
 d=google.com; s=arc-20240605;
 b=NgypXFdV9GusFUKrQOHtl1Im87cWkghImNEWydcjplq+Bjp06iEKhA+e+1yfm6x9P/
 Fu8SjEBeqF+QKJodVDMoHVpCfgh4t11DYAnOV+rdp/sXiq0mBgBiSA5WU/fT/J6M/iCY
 YCze4X5aOJoGGQCLRRrAymf76Tdf9HR7n0bZpGbR2DhIL8PyNaPB67Mdoz09xIS3ty3n
 ajrrx+NlaQZbJr/VUj5rHFuLEqlp+kTVnvaT8tFo6USeyz426iMRgrrCI5ZsLbLAUSXs
 plqokEAym7P4uvU0jNbHivYhXvMeLpUTWbDJV1azHlffEzmz/pIMswNDhVXvrBGJ2PVp
 CZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kV/JPI5HvE0sUpe9zY2HhLdZrEm7eIp0w3P7JuaBwsY=;
 fh=WOVsvKJBz/bhS6YncvwNdIQFC5VbL/nEBQ84w0ymC28=;
 b=GSHq3+GLGqKMYSYP2hLsQVFIx+dp3rK8McKQyj1aZpqw5Fpi3pfBiSLrCzmcQbQhsu
 h18RKdNUEFgVLKH47iVeDhciFzMUQjshIouWOVAy2PzOyQVb63q5xcxUnc67ZyoBCYJQ
 EIMDXRDXnnCBQN5k1tV10zJs6BTDDfT5t7pnxychJl+AHOQv9EPUWrkfFk3OEVX4amMY
 txZS6ejo3cEzbB6pczkJ3SX8yiGCy3+2t94gRDZ/FzaIfYIGJ1HXMajkHm/SrJWz1tuE
 QNZx1SpI+tJk+MjiRBwGX/OcSxYThqGzPWRpjfMSd4mj28J1DQBO0AaKLOlIdmiPLmrQ
 sl1A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775862061; x=1776466861; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kV/JPI5HvE0sUpe9zY2HhLdZrEm7eIp0w3P7JuaBwsY=;
 b=JLSOV3zXw3KQSwBjgVnNvdWjnd6/qZE1u4SiM/juLKlCKdbMp8Loc/wwNWbrwu5aqV
 QJdxaYyEqmxIECPNlfYkk+iacmMo7nsFgAqb7OEgFk69VWjZkvZ48ELA3P1cQ95M2vzd
 5iPESzMhKvrXzhFza3zGUXWS3IEohcNOgy8bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775862061; x=1776466861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kV/JPI5HvE0sUpe9zY2HhLdZrEm7eIp0w3P7JuaBwsY=;
 b=tQI/fWrT4p7HPDy7HZEG2e9jb3yNWBM1yCJDpVRdlVRRMvbhQkeiOhOUBB2i22aLxx
 Olt9Oe3mO2EjzGJnJUq7YMcBKxFZQzr3XQC8vxjhYRO4mFmcRJ5O+KEON0siFxG4FVy5
 mjNmhPkTyMVS12/jmmVe3y9KrEDBTRliURp6vNG++pGCpZ3d82f06VQ81+Oh7OnXLOAx
 QJn95pBrsLP9x4CggcdNPo0sbKoJXvtGzsWkAOVrJ8jsyu3tDPDbvEAhwrG86yf6Pnk2
 tqcA3SVahRZQ+/rBxsHVb8jnJgLY1adv5BjU16Nhm/DhAavSq3xXXe7IEXy/KFN/XO6V
 kcow==
X-Gm-Message-State: AOJu0YxDnnOm/TsfM1PCqIiPmJX5DRH3m2daODOj4YIW4NAqg+GKUcC4
 /O+wcj9xty1PI1MHUtoYeqvE7hED8OwhArShWPKa/a+pZWefbAYZgX7v/oc+j3RMNyZZurY2TVM
 04TuqMallWjUHoBsOv1AC/8Ket6F/SCFsVdoxpYnU
X-Gm-Gg: AeBDiesFRARUDYFSDyOfVqnMw4P5J/FP5GWEdG05tZLQii3QYKrRNnwuTh3/wkwABeX
 S6m05yBc6XjT5q1h02abVOHvVojFi74vtHyIZiVS/KexX+QpFcIjVRnbWmABHIkBRO8WLm+cPXG
 D9SLHfoa3IL0zCW6rdp2ocIlcMC0IJpt/owl2mjEag/qMZugT1TUPtoIhTA8aMiwiHBq4UT6p2V
 TnPULuBG8/pePTkKT5mA5x4bToDVICZpHHHfkyV7dtem1GdZZCQrKSSw40C7n4BFMGmZc2PAUds
 Y/ukSQ==
X-Received: by 2002:a17:906:f589:b0:b9d:6e92:8ccf with SMTP id
 a640c23a62f3a-b9d7260514dmr279657166b.23.1775862061102; Fri, 10 Apr 2026
 16:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
 <20260404152640.3297713-4-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260404152640.3297713-4-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Apr 2026 17:00:45 -0600
X-Gm-Features: AQROBzA_d63brtWBAhjEa21rLM-5r8u-jH6qi17fIaum2VHrQX4hZ2qFZmVYxNM
Message-ID: <CAFLszTi-n63QhFQV48qUrDbFVfev8hHZUT4Jt+vU+FvBPoXNcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] test: cmd: add unit tests for part command
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Dario,

On 2026-04-04T15:23:27, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> test: cmd: add unit tests for part command
>
> Add unit tests for the 'part' command, specifically for the 'number',
> 'start', and 'size' subcommands.
>
> These tests establish a baseline for the current partition lookup
> functionality by name. This foundation will be used by subsequent
> patches to extend the command, ensuring consistent behavior as new
> features are introduced.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> test/cmd/Makefile |   1 +
>  test/cmd/part.c   | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 158 insertions(+)

> diff --git a/test/cmd/part.c b/test/cmd/part.c
> @@ -0,0 +1,157 @@
> +static char disk_guid[UUID_STR_LEN + 1] = "8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
> +
> +static int setup_gpt_partitions(struct unit_test_state *uts, unsigned int mmc_dev_num)

A few lines exceed 80 columns (disk_guid declaration,
setup_gpt_partitions() signature, blk_get_device_by_str() call).
Please can you wrap these.

Regards,
Simon
