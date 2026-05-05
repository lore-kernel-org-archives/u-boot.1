Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1E0FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 02:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF5BB84884;
	Tue,  5 May 2026 04:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="r2LPsScd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pJTpwjJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B2AC8486A; Tue,  5 May 2026 04:44:00 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 834EF84866
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 04:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g8jWc5GXCz9tKj;
 Tue,  5 May 2026 04:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777949036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpsXJ8DSLOAbOjiubTrhA2gOlZC4QBroMHb+Ww77DtQ=;
 b=r2LPsScdZRH2PwSEV8KLKwRN2MKGEfqnEQDda9P6i0IKG1ocpQOvemWwylTZNW3lX98axD
 nS4+axBZbRQ+oWEXIjrnXaGXLKVOYbgtEYI68DRG++ujCbLtcHI8nocEhIoq/+3mI05EuL
 dRxwnFtqAfSL0/9mAR4DfP7e3lAySgx1RRcxwUDXrlx5j4x9zQrEYOdDRPq7zPyOcjF87g
 D1ffxgxkx3pcgegElb5eIjBLXRtsUTvHvPOl1GWYkVSWKl+N2Vj1Nr2CpvG+zDXiem6xNH
 ZaUV0Wtw5FlGOrvovT9azO/gDFIZq4EdUCfiy9dWNENvcHNpWuTy6s77OQE6xw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=pJTpwjJy;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <fca7dd0f-1037-4b9a-aff9-a490bb1639fb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777949035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpsXJ8DSLOAbOjiubTrhA2gOlZC4QBroMHb+Ww77DtQ=;
 b=pJTpwjJy4Yup+i2XS5c5mS9PGZkHHyDc/uF7scAdtQhzntdhOPieqcYue/T5H5jmG6aMhU
 FWY0yA06moi3T1JyxkPPa7k3uiF0LF2S1gS0kv8CJZ6/Na1gxn5iOoAr3f/wojLyMK2N8a
 Cfm/01V/rEQehSkTGUv0f1hKdbsjApGdcddR2WzT3DZpXpt1TR6gblOe+QaYu66zipDyXO
 6A+qdSiK4YBzcECG1lqnLXN8ivmQT1cWAAjS4afNRpAhtLR6RWWem99FGHWpa29vzhwPes
 rD3v07obVHaglgO73lhm9rTCjXbfSVXnj8fw3vA8QwfewMcQSJC3Ba15Fw8MGg==
Date: Tue, 5 May 2026 04:43:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 00/13] iMX8M: Covert to OF_UPSTREAM
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>,
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>,
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a2baf2bf967a2eab4d8
X-MBO-RS-META: eib5m1cjaisy4jjg5fygwyo865j3ns9z
X-Rspamd-Queue-Id: 4g8jWc5GXCz9tKj
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

On 4/25/26 2:36 AM, Peng Fan (OSS) wrote:
> This is an effort to convert i.MX8M Boards to OF_UPSTREAM.
> 
> The only left one for i.MX8MQ is:
> imx8mq-cm.dts
> 
> The left ones for i.MX8MM are:
> imx8mm-cl-iot-gate-optee.dts
> imx8mm-cl-iot-gate.dts
> imx8mm-phg.dts
> 
> The left ones for i.MX8MP are:
> imx8mp-msc-sm2s.dts
> imx8mp-rsb3720-a1.dts
> 
> These board dts are not in upstream Linux, need give a look to upstream these
> dts to linux, then move to OF_UPSTREAM.
> 
> I checked all the board dts, but I not have the board to test, best effort on
> this patchset, but this change might break boards. I would appreciate board
> maintainers to help test.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (13):
>        imx8mq: reform2: Switch to OF_UPSTREAM
>        imx8mq: phanbell: Switch OF_UPSTREAM
>        imx8mq: pico: Switch OF_UPSTREAM
>        imx8mq: librem5: Switch to OF_UPSTREAM
>        imx8mq: kontron-pitx-imx8m: Switch OF_UPSTREAM
>        imx8mq: Drop arch/arm/dts/imx8mq.dtsi
>        imx8mm: mx8menlo: Switch OF_UPSTREAM
>        imx8mm/n: Drop unused dtsi
>        imx8mm: data-modul-edm-sbc: Switch OF_UPSTREAM
>        imx8mm: icore-mx8mm: Switch to OF_UPSTREAM
>        imx8mp: dhcom-drc02/picoitx: Switch to OF_UPSTREAM
>        imx8mp: data-modul-edm-sbc: Switch to OF_UPSTREAM
>        imx8mp: icore-mx8mp-edimm2.2: Switch to OF_UPSTREAM
I have the DH, Data Modul, Menlo boards on my list of boards to switch 
to OF_UPSTREAM , but I did not get to test the result on real hardware 
yet. I would very much prefer to avoid switching them to OF_UPSTREAM 
without any testing on real hardware as that could cause unforeseen 
breakage, so please either wait with applying those patches until I can 
test them, or drop those patches from this series for now. Thank you.
