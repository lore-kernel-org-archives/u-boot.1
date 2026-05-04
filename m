Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A065FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC93B83FEC;
	Mon,  4 May 2026 14:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y63F14ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 286D084255; Mon,  4 May 2026 14:22:31 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F1398394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so634305066b.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897349; cv=none;
 d=google.com; s=arc-20240605;
 b=RjNwL91FvRhg9U2afa7wZ+BjPOccN5sQAF4ldf8W+QnVlfpRPTngZ2bj3usFmIjlRn
 YvAo5Rb2107SRlZXx8C037BhiZBVAFJJ4hqVQ5LZMagnMIiYQ6Hzs4zBzWal61RCHGLh
 bgnVvujk4qEP+8RR8eK2VG0tydIDbpGjqIIluRT3AP7OI+5h+3BFSrgZINXViqk79u7o
 t8jAx8FRP+r06snuQhzVDVzu3cxaZaWHhkP3uufjTnkniA0uR3Med9RUuSWlhVaC2FbF
 T6FTrDMEhvWgQ2CZ5ANJJ/vHEYMCo6ilr90S+JPBKTLAVk3gX+qlA+PDFrtpn4Oz+9Up
 bsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Tr9tuySTHj0lsRpMsYlMQc7h4L+vqjbyfOC0F088ZTc=;
 fh=73fUgGMxFWjsXTTKKcDPZ5aB/o+hC4jsg2TDPR5JiWI=;
 b=eySLPKV2nQ43qYI484dmb872cCGEAotg3ZmT/ZVtc6oNuqeYpSpbn+0DdpZ/L7Fdit
 8C4eLWKamLXynMlA818xWGA2ffFQmZlPwTuU6k3CVJFJdyaaL5hxzPWeNPOdcGrfszGu
 DY6EYWPoB1tOKOv3jFEAEiD4RrlJVZDkr0TxhPorPXPeAa1vJN+rmc9anZHPF7q4sPKK
 hOOVEbU8N90aASxR6FbBptICuEc9qxC5rNwDftNhjjB6fnyLDIP9LTIg4YdLdf0OtD+W
 orTKJzblnjyCye8S6FI62+OYeEycoTyK8RRdCnVnuJXGW7JaM3u/AQgZna3W12C3BYoJ
 24eA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897349; x=1778502149; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tr9tuySTHj0lsRpMsYlMQc7h4L+vqjbyfOC0F088ZTc=;
 b=Y63F14ouroXoP7Pp9Hl6swWI3uT6vBYOpC1V/IooscvSxCNvgnG4IIZsTa0Izx8emG
 KVprxQOvHBB57DjqUJYDTfjblpycEEYvI6vvTi8wWVPZKaVM2gIKMzy1jdwq9y6HpDMb
 B1pMDU5m/lV3p/o7TslZZEzPB9NthnkaGJlfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897349; x=1778502149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr9tuySTHj0lsRpMsYlMQc7h4L+vqjbyfOC0F088ZTc=;
 b=iDUO7YTlIl/5XKrZfSiYJmNrM7Lz32mk3HkKdPYs47CB+V8Ie6JQ0gzNTsZU63+Aph
 IuerDxM3AXAOPFlxOGFTI719FerLaJQXc48q/jDwF0LXtfLG/K9+fUSi7d8sQ+vlZ4Dj
 K1VBIEiHYRm0qjdpK8vJns7jNeHFWh3ynVWLvJaZPeta5IQDZsGo+h+APYBbHR+GblSi
 0xqN3Q9noSTy9xANBxz8gDZ22GZ9io+0y0ith8kI8go9oCdIXsoeJ/bxQo9RqyWnQpzi
 /eu1FhT0sOkvpHr8XH+7XRYVchz8iie+8wCBeVHXvtiZm98l/B3QqS8UvJN9m/mOxixQ
 lmPw==
X-Gm-Message-State: AOJu0YzRILUQMy9xmktUoGFfW0fK2EGbA6ZKXU/qaUssKBn41Bx9IV9F
 h/NA/wnOGh2Eityn8o51M41EfmwjvKbyl8LxDodhM7QbdUxykjiSIVog2JRMxka//kK9o6mGve+
 i2MhANvUQcrrO0ESKXT3GR4BGT0cIfOIu3lc0RqEW
X-Gm-Gg: AeBDievT9iBifNe5XxHwpNDag7F/lfup1SnB972E/rpYboyC1NTmFZaYdujDNzwQXMP
 hCu3pzBRcCCMeaUQ5CxQv3Hblb27sSLG9+tpjuRmfR5tuFXF8K9VRT/5MbIGAwG2+uP3mvVycnr
 OjEDILhBmo7QU+Bz0k4djM0KRiRS7Q3RjeB+8KZt0qGvUqZnesMp4FNSLLfaZGOP5ySDUdWQed8
 lzIvJlVvyQjXBTvAZja5K9KPgIGTr2GU6CRnbcOs2TDUPLYORu+tuXzO8XFi+jrkC7CXs2uW+2S
 ike2A5PShfgK7SPZ
X-Received: by 2002:a17:906:9f85:b0:b9c:b475:90ff with SMTP id
 a640c23a62f3a-bbffcd827f6mr532670766b.30.1777897348613; Mon, 04 May 2026
 05:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260429121324.391457-1-marex@nabladev.com>
In-Reply-To: <20260429121324.391457-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:22:16 -0600
X-Gm-Features: AVHnY4IFVeVAKeOEwGomXxeqTltw1JmRvEK_rOY_SVj0fYI963ydWaLHkhOc5cc
Message-ID: <CAFLszTh8=H20tPnhym5CHsVSVg1LFcxeHLovd0VMVRYsiArmrQ@mail.gmail.com>
Subject: Re: [PATCH] env: mmc: Use correct eMMC HW partition size when
 calculating end of HW partition
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jasper Orschulko <jasper@fancydomain.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michael Heimpold <mhei@heimpold.de>, Michael Walle <mwalle@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
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

Hi Marek,

On 2026-04-29T12:13:06, Marek Vasut <marex@nabladev.com> wrote:
> env: mmc: Use correct eMMC HW partition size when calculating end of HW partition
>
> When calculating the end of eMMC HW partition, it is necessary to
> use the length of that eMMC HW partition, not the length of the
> eMMC HW USER partition unconditionally, otherwise the end of e.g.
> eMMC HW BOOT partition will be way past the actual end of that eMMC
> HW BOOT partition. Add the missing distinction. eMMC HW GP partitions
> are not supported, so those are not considered here.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
>
> env/mmc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

> env: mmc: Use correct eMMC HW partition size when calculating end of HW partition

nit: subject is 84 chars - please trim to <=72, e.g. "env: mmc: Use
correct HW partition size for end-relative offset".

> diff --git a/env/mmc.c b/env/mmc.c
> @@ -239,8 +239,12 @@ __weak int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
>               return -ENOENT;
>       }
>
> -     if (offset < 0)
> -             offset += mmc->capacity;
> +     if (offset < 0) {
> +             if (CONFIG_ENV_MMC_EMMC_HW_PARTITION)
> +                     offset += mmc->capacity_boot;
> +             else
> +                     offset += mmc->capacity;
> +     }

Just to clarify the motivation: every caller of mmc_get_env_addr()
goes through init_mmc_for_env(), which calls mmc_set_env_part_init()
-> blk_select_hwpart_devnum() -> mmc_switch_part() ->
mmc_set_capacity(). After that switch mmc->capacity should already
equal mmc->capacity_boot when CONFIG_ENV_MMC_EMMC_HW_PARTITION is 1 or
2. Can you describe the path where mmc->capacity is still
capacity_user here? Perhaps the fix belongs instead in the
partition-switch path?

> diff --git a/env/mmc.c b/env/mmc.c
> @@ -239,8 +239,12 @@ __weak int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
> +             if (CONFIG_ENV_MMC_EMMC_HW_PARTITION)
> +                     offset += mmc->capacity_boot;
> +             else
> +                     offset += mmc->capacity;

This seems to do the wrong thing for
CONFIG_ENV_MMC_EMMC_HW_PARTITION=3 (RPMB) - it picks capacity_boot
when capacity_rpmb is meant. The Kconfig is a plain int with no upper
bound, so this is reachable. If you want to keep the explicit
dispatch, you could key it off mmc_get_blk_desc(mmc)->hwpart so all
partition kinds (user/boot/rpmb) fall out correctly. What do you
think?

Regards,
Simon
