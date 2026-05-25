Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EE4CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 18:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF151848B9;
	Mon, 25 May 2026 20:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U1i3up37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19CF846E1; Mon, 25 May 2026 20:13:21 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0348846E1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 20:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bd4d7f4fa02so1648593066b.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 11:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779732799; cv=none;
 d=google.com; s=arc-20240605;
 b=jVJ+6sAifYYU/cu4cEXBiVImx7MFt/5m+zhc9ogZF7PPk7DPj1g/X8oGSGT9oK/aJy
 W1Y2JHiIsBMwcMnnIEfD7Yt6OeEK0h70TelMB1Al4U00ViabEXHYF5XIKF7IEEbhG4jz
 7xzxb/bnPqLbOTyzJLpIbRzGvlwmakSv9JCFCOEoUSzBviNNwGFtZl1mo/tLk2h2KE+U
 Tx+xEdWmW0n/oV2OLKIJl7KMgGbbo4D21uCQtSc39z3tzE9QroLt1ZSvUn54WDcckfVw
 WQZMcEiy8kXI6m9KnRvl3ufifZJY7IutOhtsJElepbZshDjYCQKyaGWK9SFme3izvybS
 xNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GJC+W8Vyfk3yMfiFxlalHBVd2CM1TVkToVKtwn3wqxc=;
 fh=+aDa/ZUJHhP1Vy9D+0mrYOdjxTCA0qEBflA301btrvE=;
 b=E4QbMN9XufOkFSuEUH2vAwnuAPwD78hUutWie6hfy2daW2nJvRPiylDS42muFTgcuX
 0YVve6shy/zTHbEcEBmlDbQQAa2h8gIYR62Ksd0EUWYhmRJJTnZhcq1E39OsS56d8w+8
 Ybwgftc4DbORByyfXKjJHhkggJ1XploEGXnRf1j9Iorg+nK0axI7AVpX1h1Oi5FDwP8L
 VPNZtwbKoXboobiw2WIuCRdcIFAodyrLZpCflyxeYSC0RV0c6ovTRJnEEe0dmSTBsf3V
 I3ljd37YFMoVDHsrzGUIN0ht4VDSH3kWcRYWRjbChRPJ59NI0twNV0yW5xg1Gzd/44y4
 U7gQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779732799; x=1780337599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GJC+W8Vyfk3yMfiFxlalHBVd2CM1TVkToVKtwn3wqxc=;
 b=U1i3up37dMZnjeLmZNj/fHrICSCuJnno9odTTSseYk+knfnLPIKrEul8u+nTjlNXJD
 RfhagtYm95oeuOpsBO8JXjoWSn52RCDFw2Zm+KXtDpcB8ddLG7/ugkXvGMAZ33EmJXcX
 8i2YEbbT8JilDwd9AHtq8VbkDIg5DjlFm8YT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779732799; x=1780337599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJC+W8Vyfk3yMfiFxlalHBVd2CM1TVkToVKtwn3wqxc=;
 b=aO3Gb/uo1xkOpPjm1gEN+6pkevxTHw5Rjs33qDPt7Nt5P1sxN16fV7Ja7sTUzPkWnq
 4nRW9mdyjtib7Bm76Drv6y/Qq7NE6Wi4e6eIWrLy3seuBKajpr9uJ5Sey+uC92MgldYj
 4v4yGLR8tLOWpVwrDmjRdvMRUlk8a7z1e7DIWrY0bqEQyoBYktdTFLdp24TQhua1U1q+
 xxf9n7i/fJ7HLUwYsqWVIeF6U1xILoFez3IMhehXZB1mN2DRqqa8sFSZlnY9wqh+D61V
 EwBq4fBs/W7cs+6zM5JVGB/AsKhHUHX9VRgB5goIm2AXzU5DCERVddZOaQjRBBTp4L0t
 CSxQ==
X-Gm-Message-State: AOJu0Yz7dgPL6Tg11/wYnTRwbhbH8ZbfxkQT6O2toQEFV2d/993jZz32
 ErKwhucVHgwDbH/XSnuHVZWuy19Wz6CNw8TWDYnyBq3REqcy73cItgDaIk0ipdBw8sx1JrV7R9x
 Naytdo6WA60Ksa5mFldBCh1BeIU7JIPfYW8dBkmPu
X-Gm-Gg: Acq92OE6wOvh5Cl49gZLrnwCpSmE0pmbFOAUipgeReiVDQ6yUo+yoLIsuDW8gHP6YdY
 2RJn4vaeI0AxcFWsdwuKvkyjkEiE9vIctZ4VjVrFlYjKkEJRaKLXZ6HuaB8vHFcixlcFsTThyvy
 +7plM8ksQtiFh4YyqtiMWnTI+TF/onMt4enlXJ0bLuwRGQV+C7u1vWB78n6lwDYmbbgNfDoW6ux
 aK0FKesp898IBjMuIPIaKhwYSkwUMq32wWV5icZKPkMcNxoKf7cU4nbThYCOEv6cTSygTOJQJSJ
 73ZBdo5As2mH/+Jk
X-Received: by 2002:a17:907:cf8c:b0:bd2:6d40:3f6a with SMTP id
 a640c23a62f3a-bdd278c8e70mr798361566b.45.1779732799052; Mon, 25 May 2026
 11:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
 <20260517-rk3568-raminit-v1-2-a24e16302a13@ya.ru>
In-Reply-To: <20260517-rk3568-raminit-v1-2-a24e16302a13@ya.ru>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 12:13:06 -0600
X-Gm-Features: AVHnY4JIa-6pw5TmX4h6LsMuExUaKeTGJ4GQbkcK11CcFeEy3L6CsuIYiU2a5To
Message-ID: <CAFLszTiJbC1uy3JzXQrt6c7ZTyhSPdj3GM=sMet6XjtVFo2WVg@mail.gmail.com>
Subject: Re: [PATCH RFC 02/18] clk: rockchip: rk3568: Fix probe with
 OF_PLATDATA enabled
To: paullo612@ya.ru
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>
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

Hi Pavel,

On 2026-05-17T19:24:26, Pavel Golikov <paullo612@ya.ru> wrote:
> clk: rockchip: rk3568: Fix probe with OF_PLATDATA enabled
>
> Properly initialize cru address space reference when CONFIG_OF_PLATDATA
> is enabled.
>
> Signed-off-by: Pavel Golikov <paullo612@ya.ru>
>
> drivers/clk/rockchip/clk_rk3568.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> @@ -2906,8 +2907,14 @@ static void rk3568_clk_init(struct rk3568_clk_priv *priv)
>  static int rk3568_clk_probe(struct udevice *dev)
>  {
>       struct rk3568_clk_priv *priv = dev_get_priv(dev);
> +#if CONFIG_IS_ENABLED(OF_PLATDATA)
> +     struct rk3568_clk_plat *plat = dev_get_plat(dev);
> +#endif
>       int ret;
>
> +#if CONFIG_IS_ENABLED(OF_PLATDATA)
> +     priv->cru = map_sysmem(plat->dtd.reg[0], plat->dtd.reg[1]);
> +#endif

Please fold this into a single OF_PLATDATA block matching
rk3399_clk_probe() - declare plat and assign priv->cru inside one
#if CONFIG_IS_ENABLED(OF_PLATDATA) guard rather than splitting them.

Regards,
Simon
