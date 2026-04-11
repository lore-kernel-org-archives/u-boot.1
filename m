Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F52E937E4
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63EAB84227;
	Sun, 12 Apr 2026 15:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WxJmxWgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E1784154; Sat, 11 Apr 2026 22:31:05 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90A784118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 22:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9bff57cb62so508646466b.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 13:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775939461; cv=none;
 d=google.com; s=arc-20240605;
 b=iOlyNaUnGCEkj7hQ2bsfCmhHq92JdcXTDan/ev5whlqCs0bhDNgneLzfZgZeP7OB4m
 355kDgoVS2XYLRG+EzqdaoKL+sHF2sG1vgF7b3JbymBlGmkZnaYjRmtRw8TNLRARX+XH
 5WRN48fD4iob/+2FvcaKgRBnW6mA8AJRb05X6M2tnxWf/za98O/t/UiEXOPryms6Sijh
 PEO4N10WUaf8QBhnyqYz/aGk9luxkGC5KsRurV/gBE3mnjg/uDtVTxpkTrEc+MMokGxH
 v/1+WPSrgikHs4laUFaqdftLeZbgKYWk9pwsucAMpKfcii38fwKsB2o8WnAWg0XDgVFv
 SW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YyhpgdC/vgSQwEPJiZDuYR7qNxz09GzXJ4UNzNoBPQE=;
 fh=pKV29h6PBf5SbuSFTM/GZF+KoVG4OaOclZXc+5Qi1tM=;
 b=bGHjjsbIMep4bccnqa12wJiuq9A+Cam9ksSnFqSsxQJ/b5KB4B7F3/2bvL64dJb+eb
 VVLrtCTO9t09GRTbkWJoXePCGipI8ht2F0XZ0f0E22ogg+vBzA1lVAm1N1TEMQ6PEMhR
 aYwjwQqRPfQMNii++9Q4RV5LkJHDBe3dMXV4E7z/MElMr8MuTKjpeX6E+8JOFZ0VRK2b
 9pQrUt84w1Zih85vh5cIyu6d4jwxV4uN+/MkArDUaV5T5foPV1jo/h1WzL61QQbUFZd2
 PCkPYMJzAJr9jPLC7srV29k7jIa5YkwJQVjIoN+AJiHSbwVwkDq+SP9Zv+JgIdcduTCw
 mkkQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775939461; x=1776544261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YyhpgdC/vgSQwEPJiZDuYR7qNxz09GzXJ4UNzNoBPQE=;
 b=WxJmxWgj7QawswClavW0yMbHIfkSGO5pxq0oHiDqwhJV8CDePx/Vz3U+zRl5O276eU
 xiYl2sJkMkRqLFHXWw84JJZMhDKwDuXjKl2sjDkpsuG3inRAulMZxXoJqKgjZSefZNbi
 4o60GkcJL+S3vDmayROL1VykUFEbBkz4+W0Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775939461; x=1776544261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyhpgdC/vgSQwEPJiZDuYR7qNxz09GzXJ4UNzNoBPQE=;
 b=WApvVQ1UCeqegIekTHkeEV0Dkf/Zuf2ZHuLaPEJu7RiCKv8qq2G+2n1FoL+qoJD6W3
 cqhzrWWwW8Te0fqRACDRIQ/lClxZMBooX+WILruTr/P9XDyhA6CUblA3d7q+16mvIsuq
 gEfFgzbi08zfPp6W7LuzJ+0MWsRgFmHAkdDNQE2+UyHuGc725zmeAqZiZH0BsWnTbdCN
 X9/i6QUY1J2UoCAk7JWlC7wV0GZRF0mxUMY/AO4RoWESntVAtR5vJbMxftpz+DbdFnDQ
 N1RAgLCyg3pe+1QR7VF0fac4+5d6VTOUWrxdCzG0mDwXp2mSZJ1fgGuo2GT5becXeYyy
 7bZw==
X-Gm-Message-State: AOJu0Yy7w77xHvEjI3U5aZqyKr30wa3Xc9XwTmS0EAJp788eMpvSNzit
 YIHEYJ7ro6rzuhZMSF+uWG48Sq2kzJDF2fvehjlaySHCHMA2B2yD2z958vQFMYjngbHiVKjfPJh
 aISQuK7DfO2CrmHsP6J58u084wmKkQS64dlYGfR+Q
X-Gm-Gg: AeBDietRYSf0ovr0wKbNjUYfENtHeSER1XdD6OpfdkjJNNpQSRcnDs0gZF1DG34WHEe
 eim5vgTVIt3ZNufxoJHuHN+3FDuXWi8GRCxwpwuz/v+7LT7/06z+9fkW4R7C17dhx4dMNkmIino
 dRaYFHJTMmRa0TzRP1NU3Zfr+a1HX7K8NyknDQqJbdBaTJiXmIaGEKPKEAQRMI23Rp8Q+b9msHA
 5J6ijtbnRcXs/PS/Yvs4t4A89kwknydUBQu0TM/i6PS01jUGCdT2uytsDsXfsOqy44/wcukIZk6
 t6xipw==
X-Received: by 2002:a17:907:c03:b0:b98:2b83:909d with SMTP id
 a640c23a62f3a-b9d727fbca7mr465224066b.37.1775939461226; Sat, 11 Apr 2026
 13:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-9-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-9-9609557cf562@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 14:30:47 -0600
X-Gm-Features: AQROBzA8_M6hJE5UC41Z-73RA5ZlsYcprfXp14l7JMP5Oj_oDqus86bHTpa0Yqs
Message-ID: <CAFLszTiwTRJSEL--0O5TJjicD20fwSvLTOutwp7nYXXpBdZjXA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] qualcomm: add defconfig,
 env and docs for SPL on sdm845
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 12 Apr 2026 15:00:19 +0200
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

Hi Michael,

On 2026-04-11T00:00:12, Michael Srba <michael.srba@seznam.cz> wrote:
> qualcomm: add defconfig, env and docs for SPL on sdm845
>
> The defconfig should in principle be board-agnostic. Environment
> simply contains a dfu env specifying where to load u-boot proper
> (TEXT_BASE - 64).
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> board/qualcomm/sdm845_spl.env |   2 +
>  configs/sdm845_spl_defconfig  | 131 ++++++++++++++++++++++++++++++++++++++++++
>  doc/board/qualcomm/index.rst  |   1 +
>  doc/board/qualcomm/spl.rst    |  87 ++++++++++++++++++++++++++++
>  4 files changed, 221 insertions(+)

> diff --git a/configs/sdm845_spl_defconfig b/configs/sdm845_spl_defconfig
> +CONFIG_SPL_TARGET_SDM845=y
> +CONFIG_SPL_MAX_SIZE=0x0

Setting SPL_MAX_SIZE to 0x0 disables size checking entirely. Is that intended?

> diff --git a/configs/sdm845_spl_defconfig b/configs/sdm845_spl_defconfig
> +CONFIG_SPL_BSS_MAX_SIZE=0x20000

This conflicts with the Kconfig default of 0x2000 for
SPL_TARGET_SDM845. If 0x20000 is intentional, please can you also
update the Kconfig default, since the comment there says 'leaves
0x1e000 for the stack in worst case' which would no longer be true.

> diff --git a/doc/board/qualcomm/spl.rst b/doc/board/qualcomm/spl.rst
> +If you're unable to find one, you can also use JTAG/SWD to break at the SMC
> +entry and use gdp to jump to the u-boot entry point in EL3.

gdb

> diff --git a/doc/board/qualcomm/spl.rst b/doc/board/qualcomm/spl.rst
> +`make CROSS_COMPILE=aarch64-suse-linux- O=.output DEVICE_TREE=qcom/sdm845-shift-axolotl sdm845_spl_defconfig
> +
> +Then compile u-boot and specify the dts for your board

Please can you use :: and indented code blocks for commands, matching
the style in board.rst and dragonboard410c.rst.

Regards,
Simon
