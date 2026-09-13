Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71903C88E5C
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 07:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4344B6065A;
	Sun, 13 Sep 2026 07:29:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Yy4U9n71X2I; Sun, 13 Sep 2026 07:29:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3502A60631
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789284553;
	b=A/UdAP65pm4L2RGgINrQYmYVamswfSY/XaXTst1X6L2HHQ2ufBsvkDvQK8l5sBNVpe/l
	 5HgAHsC+GW7pen0n1Ya4bppJeEyrSwrbiTPGf2lfCELk3pcxvVqo32KMKWwGP4XFGgl0v
	 1fUYQvzE7XmxKhX+xk3sOFSd2dR5n5WjJXy0DOcq7wMdFPjenSvns/D2i1sbbMjRZPjr2
	 leybbyjxAL/quYrnQRKilBJahh3LdoJyxOnmawARUmEyIafo0/OL3JyvR2J51i3RjR+tJ
	 8Ts+OPK3WpmFGEYtRgYbSxw1XVyn9zdIkw099RhmBAN4Zz+Qv4jCEdNrvzVgxJZTKog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789284553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=f1goM8T/FhJpps8XZZWvSRumdWu7KXpVa4hbsZ5rsO8=;
	b=MMEPlR1APIqDkszxhpUt+Uhp8XlGI50s+jiXB2+SuxSZ8Oy8bH1tniclSlxFsPGY4wYJ
	 DxlJLLWfztkJmTm+Vmt0hdjhDAD6qPkU1OblpuulvU23kTYtNN8Vf/yO5od8Rs39yK3d3
	 tiloklmV1LryE+rmcvNz0oRytpDf+odjteitdRhixtD2TcP4Pek9rLs8IHQr/dBHOSpjC
	 ma52hbkYaSBc2OwyINwMRsva0h0tR/KP/6rO8kQYOCJa678egMdLEqwf86qVo0xxNd8yb
	 Slh3nZAyVTRwNY6bnKtGpIcXrRNLeHWr7VATlLbfGBQVGQawub8R7DCYdjPbVKc3znA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LfW5r71i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789284553;
	bh=f1goM8T/FhJpps8XZZWvSRumdWu7KXpVa4hbsZ5rsO8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pq7TL7gwOLH0xWgU8hdLpfIU1cOJeGgOdWGCAbZG8vPLGLFxykhruZCIEaaEYNs4K
	 /dhKIVcJraQ4gWdgSHBFy5UpORLQokB+OumSJBVVg6Pfweypz95kXTe01xmq4pj7O/
	 iJDieyT+7cA37uvkYudTfukBum5yLjdNGA+qpY2RFu3sC+6c22aWUodtATPFlwY+ps
	 z/0+2NHqLS5IzJRz0SlBMTrZebuv4cbKUiz7R/KnglzAemt1LqbP1wayo71H7GjqAc
	 cUdPajpav/k5duPJUAa+GZcW58PziNBCpv1D2uTna84Praooajddcdk6dn3/FC5ghe
	 KzicgJ+GIz+7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3502A60631;
	Sun, 13 Sep 2026 07:29:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24B13109
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0770360621
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H3OzewsJ43Lc for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 07:29:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1AF276064A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789284550;
 b=iduYgTjKi6mDDD7qw5e6k47QluX1uzUSKP1kyBkeYbHAUjnmApGlK0y1BY1DAfY4V0nf
 KmFNtCEVQq3El4b3KW79LGh/cijppsRbNB766VLTikKUwYUcCu0d6bMAI9gnMIM9yzZfQ
 Z44wP0BZ+43ZhlzH9p4NPIo7K2VXPCLJToAEwoLApbOwBq8fQVl+WIt9VaJgaLZ/25tSv
 psmgV3EvywbixGiMe56/eK/+u3SpI+9K6WPj29MtCv4zlwu3D7itDyBF9BB/SRFYFzP8X
 vM3N9C7FHX96OPnDE5FiZDTToajkMiYBya1GedJkh5O7lRz1+p/TOD8y0WP7zrFsNvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789284550;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=f1goM8T/FhJpps8XZZWvSRumdWu7KXpVa4hbsZ5rsO8=;
 b=On4K4uQMbm9QT4oNdiw+yeODge6kze0lEwPv+4SFP8pNhQRVdSb2sNk/47XRlfoprsdA
 pTxdrIm5AbgH2MF2ZKTIoHs155VX1LkxQHtOzRdI5G+8HbWtzCkv8T4Gmo3w/upK+ILfC
 JwAfJr5M2RjxT4QwTFQMXWIW42myBAq/jRFlObNHmeWN79+ND5prpEItxCDgQK66d2rq/
 eMQs712sXrLKhZlVwIXg6DwgfRG2qgdsG1szk/uE1dkK2vWK2qc4xpMbEdhbIaE6GMxUc
 m2SvOzo8N/pNNVqxTEbj9+7WtEps/bR+E9damFpCV/119iEzXaeRnkHvodmlB9KdPRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LfW5r71i; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LfW5r71i
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AF276064A
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:09 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so5224945e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 00:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789284548; x=1789889348;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f1goM8T/FhJpps8XZZWvSRumdWu7KXpVa4hbsZ5rsO8=;
 b=LfW5r71iuNTzan99XdqYZj/uo/t6KBtYHVk+m+nb1zEOm2xG9PAkSHCdIbz+WRE6bh
 A0eikEQ8YBPwBX5nEzl0qEsY3m45irLISTm+KlbKOM51Law77bCP+VV9/n0Aiu8arilB
 pCONccw5KoV6LVan1CfIKgbr5sfthHz/vAcjrUAJQmoFjTi/s69QAni4pp0MNP7xCWBZ
 IKqgxRVlSaMh5xmLghDj0fx6+OBFVIxrQHeznUCaFglvnAJvNvh/uQQ0cpkRVqAldMQ+
 OdsB5UO0cZOsHcfSqpAK/pWXscxqCQbdUeR3IHc8cYgKreLyMreg6MApRLC27UVX0Vaf
 yt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789284548; x=1789889348;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f1goM8T/FhJpps8XZZWvSRumdWu7KXpVa4hbsZ5rsO8=;
 b=cWnsECUKocKX9uFhgLIpnemLowkGB5ZycSr+7LiXKSYnOLGAygWk491IUrwrGYE9If
 yr7lwr1kXpb2ckAOFU2md2wgkD5amG9xldzeD0phG8DmKinKSxiLR/jHPk0Rt89+ch39
 LCxYzZH7ajAeMPBOlGcfgE1vmRixI7rmg2vPaTmjhM8OUmiwaEpTWj0O2UAMjwuLOuDh
 NzrX2KykF2oKU+nuSPXwVwkASjoNeVwrPOfz2w/sVu3eu62s86haADnMSNymLqktEPQT
 QFqwZcE/wW/mz8uOlBt9BSbFt56Pe6BQJW1NF6zF7mQp2Mv8yRT3mmgyTCU0htJ9mGK6
 0J+g==
X-Gm-Message-State: AFuF++kWAqGyng1szc56j8HPKrdtbfy8/jRR99DmyNJQoO/3VYy4cV8A
 J+QXGaEr35JwD3C6Wkf0pGHBvD2uxFx6V/V1AA53UJfKNChK9TxEmxqzEC1kutzJjhQ=
X-Gm-Gg: AYBFou3Hu2pGyO1cAQ+wqzB7K+uIvspAy9qKcGcv5q6YAlaME79wP49KkzAXxSMEM6u
 UwIDSdaBv+W1B1ILO4kU39B7MbRYsO1LtQinnfHHU/U/mcA4BxaGS+1OoRgVTowBXg35grZug4E
 ldoQ8XlGj/mgzqRFYCeIJhgnXKbTfxMnLReKmhzupwilAdnXl7AAfigbM7W7ddrXUlwt8LwQEUE
 sMyhKPI6qvBYOWXJtpdRyFdS0W7kO3FiUthngGIFF/jCRxWYnd6OclB/HgZT4V7+NlFHq25R+PB
 DYyYpHxaHT2w/PKALVN832d/ZIK239CWtfl+29UgDzdL4WUXK8iN23trZndMqsB3r57++2dCQul
 2wnsqohOQGkIHZUlxZoKBjAB63oI+l3GCi4tiQlipWBhVUf9r5lgSoxpH6Zvjd92Zd+zhpK45Ac
 LjXcfKTPYPayKqxLdywVQ+jwQj+8RXOY8mrkVocKs7BwSS+Ie91DCcP5PyAvCTh5Vl/rcgMwn+1
 UhsRjvqWGKXkjeYqTuyg9ECuNuYyWcKN9eflZqoQCRYdOPggB/HrxHt4u8rnS0LSqXze4yu9QOW
 Ti2kLAaWa6otat+c3PxMiowyuA==
X-Received: by 2002:a05:600c:3594:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49e6cc14055mr66818795e9.30.1789284547281; 
 Sun, 13 Sep 2026 00:29:07 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e71e300f3sm100788875e9.7.2026.09.13.00.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 00:29:06 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 13 Sep 2026 09:28:47 +0200
Subject: [PATCH v6 5/5] fastboot: add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-ccaione-upstream-spl-fastboot-v6-5-dd3ba81a7ed2@baylibre.com>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
In-Reply-To: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Some recovery and initial-provisioning flows run before usable firmware
is available in persistent storage. In these flows the SoC ROM loads a
small first stage, but that stage must still provide a standard protocol
with which the host can provision the device.

U-Boot already provides fastboot for this purpose, but its implementation
is currently restricted to U-Boot proper and coupled to command-line
support. This forces platforms that need provisioning from SPL to maintain
a separate downloader or an out-of-tree fastboot implementation.

Allow boards to run USB fastboot as a service directly from SPL. Include
MMC partition flashing and Android sparse-image handling so that the SPL
service can provision the same storage images accepted by fastboot in
U-Boot proper.

Keep the SPL interface deliberately narrower. The fastboot boot command
is not supported because SPL is being used for provisioning rather than
OS boot orchestration. Filesystem probing is also omitted, so partition
types are reported as raw. Reboot support remains optional since reset
and persistent reboot-reason handling are platform-specific.

Environment-backed USB serial numbers, getvars, MMC aliases and raw
partition descriptors are available when SPL_ENV_SUPPORT is enabled, but
the core service no longer requires the environment. Document the full
printf, allocator, reset, command and shared-buffer requirements.

SPL size remains an important constraint. Make the support entirely
opt-in and phase-specific: when CONFIG_SPL_FASTBOOT is disabled, no
fastboot code or supporting library is added to SPL. Enable the core
service in sandbox_spl so this build path receives CI compile coverage.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/sandbox_spl_defconfig   |   4 ++
 doc/android/fastboot.rst        |  48 +++++++++++++++++++
 drivers/fastboot/Kconfig        | 104 ++++++++++++++++++++++++++++++++++++++--
 drivers/fastboot/fb_command.c   |  68 +++++++++++++++++++++++---
 drivers/fastboot/fb_common.c    |  15 ++++++
 drivers/fastboot/fb_getvar.c    |  16 +++++--
 drivers/fastboot/fb_mmc.c       |  13 +++--
 drivers/fastboot/fb_usb.c       |   3 ++
 drivers/usb/gadget/Makefile     |   2 +-
 drivers/usb/gadget/f_fastboot.c |   6 ++-
 10 files changed, 260 insertions(+), 19 deletions(-)

diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 3b6d18d7d76..03301e49021 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -214,6 +214,10 @@ CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_FASTBOOT=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 96c544ae11b..8e15f287f9b 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -72,6 +72,54 @@ platform. The location of the buffer and size are set with
 may be overridden on the fastboot command line using ``-l`` and
 ``-s``.
 
+Fastboot in SPL
+^^^^^^^^^^^^^^^
+
+Fastboot can be used from SPL without enabling the command line. Enable
+``CONFIG_SPL_FASTBOOT`` together with the platform's SPL USB gadget support,
+then start the session from board code::
+
+   ret = fastboot_usb_run(controller_index, NULL, 0);
+
+The call normally belongs in ``board_init_r()`` or in a board recovery hook.
+It services USB until the host sends ``continue`` or detaches the gadget, then
+returns control to its caller.
+
+A ``NULL`` buffer and zero size select ``CONFIG_FASTBOOT_BUF_ADDR`` and
+``CONFIG_FASTBOOT_BUF_SIZE``. These Kconfig settings are shared with U-Boot
+proper. A board which needs a different SPL memory layout must pass explicit
+values. Unlike the command-line invocation, an SPL session cannot be aborted
+from the local console.
+
+SPL supports ``getvar``, ``download``, ``continue`` and the ``set_active``
+stub. The ``continue`` command ends the session and returns control to the
+caller. The ``flash`` and ``erase`` commands are available when their SPL
+backend is enabled. A recognized command whose optional backend is disabled is
+reported as unsupported. Commands omitted from the SPL table, including
+``boot``, ``ucmd``, ``acmd`` and the OEM commands, are reported as unrecognized.
+
+MMC flash and erase support is enabled with
+``CONFIG_SPL_FASTBOOT_FLASH_MMC``. The SPL partition-table parser matching the
+storage layout must also be enabled, for example ``CONFIG_SPL_EFI_PARTITION``
+for GPT. This backend requires the reclaiming SPL allocator; it cannot be used
+with ``CONFIG_SPL_SYS_MALLOC_SIMPLE`` because sparse and block writes allocate
+and free transient buffers.
+
+SPL reports ``raw`` for ``partition-type`` because it does not add filesystem
+probing for this getvar. The special ``flash:zimage`` path is not available
+because Android boot-image support is not enabled for SPL.
+
+Environment support is optional. With ``CONFIG_SPL_ENV_SUPPORT``, the USB
+serial number, environment-backed getvars, MMC partition aliases and raw
+partition descriptors work as in U-Boot proper. Without it, the core protocol
+and partition-table lookups remain available, while those environment-backed
+features are omitted.
+
+Reboot commands require ``CONFIG_SPL_FASTBOOT_REBOOT`` and a platform
+``reset_cpu()`` implementation. The ``reboot-bootloader``, ``reboot-fastboot``
+and ``reboot-recovery`` commands also require a platform
+``fastboot_set_reboot_flag()`` implementation.
+
 Fastboot environment variables
 ------------------------------
 
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 90212fcf9ef..938fa127db8 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -1,5 +1,6 @@
 menu "Fastboot support"
-	depends on CMDLINE
+
+if CMDLINE
 
 config FASTBOOT
 	bool
@@ -47,7 +48,33 @@ config TCP_FUNCTION_FASTBOOT
 	help
 	  This enables the fastboot protocol over TCP.
 
-if FASTBOOT
+endif # CMDLINE
+
+config SPL_FASTBOOT
+	bool "Support fastboot in SPL"
+	depends on USB_GADGET && SPL_USB_GADGET
+	depends on !SPL_USE_TINY_PRINTF
+	select SPL_LIBCOMMON_SUPPORT
+	select SPL_LIBGENERIC_SUPPORT
+	select SPL_PRINTF
+	select SPL_USB_FUNCTION_FASTBOOT
+	help
+	  Enable the USB fastboot protocol in SPL. The board is responsible
+	  for starting the fastboot session. Full printf support is required
+	  because fastboot builds bounded responses with vsnprintf() and uses
+	  formats which are not supported by the tiny implementation.
+
+config SPL_USB_FUNCTION_FASTBOOT
+	bool
+
+config SPL_FASTBOOT_REBOOT
+	bool "Enable fastboot reboot commands in SPL"
+	depends on SPL_FASTBOOT
+	help
+	  Enable the fastboot reboot commands in SPL. The platform must provide
+	  reset_cpu(), either directly or through the SPL sysreset framework.
+
+if FASTBOOT || SPL_FASTBOOT
 
 config FASTBOOT_BUF_ADDR
 	hex "Define FASTBOOT buffer address"
@@ -65,7 +92,8 @@ config FASTBOOT_BUF_ADDR
 	help
 	  The fastboot protocol requires a large memory buffer for
 	  downloads. Define this to the starting RAM address to use for
-	  downloaded images.
+	  downloaded images. U-Boot proper and SPL share this setting; an SPL
+	  caller needing a different address can pass it to fastboot_usb_run().
 
 config FASTBOOT_BUF_SIZE
 	hex "Define FASTBOOT buffer size"
@@ -77,7 +105,13 @@ config FASTBOOT_BUF_SIZE
 	help
 	  The fastboot protocol requires a large memory buffer for
 	  downloads. This buffer should be as large as possible for a
-	  platform. Define this to the size available RAM for fastboot.
+	  platform. Define this to the size available RAM for fastboot. U-Boot
+	  proper and SPL share this setting; an SPL caller needing a different
+	  size can pass it to fastboot_usb_run().
+
+endif # FASTBOOT || SPL_FASTBOOT
+
+if FASTBOOT
 
 config FASTBOOT_USB_DEV
 	int "USB controller number"
@@ -294,4 +328,66 @@ config FASTBOOT_OEM_BOARD
 
 endif # FASTBOOT
 
+config SPL_FASTBOOT_FLASH
+	bool
+	default y if SPL_FASTBOOT_FLASH_MMC
+	select SPL_IMAGE_SPARSE
+
+config SPL_FASTBOOT_FLASH_MMC
+	bool "Enable fastboot MMC flashing in SPL"
+	depends on SPL_FASTBOOT && SPL_MMC && SPL_DM_MMC && SPL_PARTITIONS
+	depends on SPL_SYS_MALLOC && !SPL_SYS_MALLOC_SIMPLE
+	select SPL_MMC_WRITE
+	help
+	  Build the fastboot MMC flashing backend into SPL. This allows the
+	  fastboot flash and erase commands to operate on MMC partitions. A
+	  suitable SPL partition-table parser and a reclaiming malloc
+	  implementation must also be enabled.
+
+config SPL_FASTBOOT_FLASH_MMC_DEV
+	int "Define fastboot MMC flash device in SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC
+	default 0
+	help
+	  Define the MMC device that the SPL fastboot flash backend uses.
+
+config SPL_FASTBOOT_MMC_BOOT_SUPPORT
+	bool "Enable eMMC boot-partition flash/erase in SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC && SUPPORT_EMMC_BOOT
+	help
+	  Enable the special fastboot targets used to flash or erase the eMMC
+	  boot hardware partitions from SPL.
+
+config SPL_FASTBOOT_MMC_BOOT1_NAME
+	string "Target name for updating eMMC boot partition 1 in SPL"
+	depends on SPL_FASTBOOT_MMC_BOOT_SUPPORT
+	default "mmc0boot0"
+
+config SPL_FASTBOOT_MMC_BOOT2_NAME
+	string "Target name for updating eMMC boot partition 2 in SPL"
+	depends on SPL_FASTBOOT_MMC_BOOT_SUPPORT
+	default "mmc0boot1"
+
+config SPL_FASTBOOT_MMC_USER_SUPPORT
+	bool "Enable eMMC user-area flash/erase in SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC
+	help
+	  Enable a special fastboot target for flashing or erasing the complete
+	  eMMC user area from SPL.
+
+config SPL_FASTBOOT_MMC_USER_NAME
+	string "Target name for updating the eMMC user area in SPL"
+	depends on SPL_FASTBOOT_MMC_USER_SUPPORT
+	default "mmc0"
+
+config SPL_FASTBOOT_GPT_NAME
+	string "Target name for updating GPT from SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC && SPL_EFI_PARTITION
+	default "gpt"
+
+config SPL_FASTBOOT_MBR_NAME
+	string "Target name for updating MBR from SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC && SPL_DOS_PARTITION
+	default "mbr"
+
 endmenu
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 111516fd1b3..a2a89fc04f8 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -48,10 +48,59 @@ static void oem_board(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
 
-static const struct {
+struct fastboot_command {
 	const char *command;
 	void (*dispatch)(char *cmd_parameter, char *response);
-} commands[FASTBOOT_COMMAND_COUNT] = {
+};
+
+#ifdef CONFIG_XPL_BUILD
+static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
+	[FASTBOOT_COMMAND_GETVAR] = {
+		.command = "getvar",
+		.dispatch = getvar
+	},
+	[FASTBOOT_COMMAND_DOWNLOAD] = {
+		.command = "download",
+		.dispatch = download
+	},
+	[FASTBOOT_COMMAND_FLASH] =  {
+		.command = "flash",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (flash), (NULL))
+	},
+	[FASTBOOT_COMMAND_ERASE] =  {
+		.command = "erase",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (erase), (NULL))
+	},
+	[FASTBOOT_COMMAND_CONTINUE] =  {
+		.command = "continue",
+		.dispatch = okay
+	},
+	[FASTBOOT_COMMAND_REBOOT] =  {
+		.command = "reboot",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT, (okay), (NULL))
+	},
+	[FASTBOOT_COMMAND_REBOOT_BOOTLOADER] =  {
+		.command = "reboot-bootloader",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_bootloader), (NULL))
+	},
+	[FASTBOOT_COMMAND_REBOOT_FASTBOOTD] =  {
+		.command = "reboot-fastboot",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_fastbootd), (NULL))
+	},
+	[FASTBOOT_COMMAND_REBOOT_RECOVERY] =  {
+		.command = "reboot-recovery",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_REBOOT,
+					     (reboot_recovery), (NULL))
+	},
+	[FASTBOOT_COMMAND_SET_ACTIVE] =  {
+		.command = "set_active",
+		.dispatch = okay
+	},
+};
+#else
+static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
 	[FASTBOOT_COMMAND_GETVAR] = {
 		.command = "getvar",
 		.dispatch = getvar
@@ -129,6 +178,7 @@ static const struct {
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_acmd), (NULL))
 	},
 };
+#endif
 
 /**
  * fastboot_handle_command - Handle fastboot command
@@ -147,7 +197,8 @@ int fastboot_handle_command(char *cmd_string, char *response)
 	strsep(&cmd_parameter, ":");
 
 	for (i = 0; i < FASTBOOT_COMMAND_COUNT; i++) {
-		if (!strcmp(commands[i].command, cmd_string)) {
+		if (commands[i].command &&
+		    !strcmp(commands[i].command, cmd_string)) {
 			if (commands[i].dispatch) {
 				commands[i].dispatch(cmd_parameter,
 							response);
@@ -323,7 +374,9 @@ void fastboot_data_complete(char *response)
 	fastboot_okay(NULL, response);
 	printf("\ndownloading of %d bytes finished\n", fastboot_bytes_received);
 	image_size = fastboot_bytes_received;
+#if CONFIG_IS_ENABLED(ENV_SUPPORT)
 	env_set_hex("filesize", image_size);
+#endif
 	fastboot_bytes_expected = 0;
 	fastboot_bytes_received = 0;
 }
@@ -437,7 +490,8 @@ static void __maybe_unused run_acmd(char *cmd_parameter, char *response)
  * @cmd_parameter: Pointer to command parameter
  * @response: Pointer to fastboot response buffer
  */
-static void reboot_bootloader(char *cmd_parameter, char *response)
+static void __maybe_unused reboot_bootloader(char *cmd_parameter,
+					     char *response)
 {
 	if (fastboot_set_reboot_flag(FASTBOOT_REBOOT_REASON_BOOTLOADER))
 		fastboot_fail("Cannot set reboot flag", response);
@@ -451,7 +505,8 @@ static void reboot_bootloader(char *cmd_parameter, char *response)
  * @cmd_parameter: Pointer to command parameter
  * @response: Pointer to fastboot response buffer
  */
-static void reboot_fastbootd(char *cmd_parameter, char *response)
+static void __maybe_unused reboot_fastbootd(char *cmd_parameter,
+					    char *response)
 {
 	if (fastboot_set_reboot_flag(FASTBOOT_REBOOT_REASON_FASTBOOTD))
 		fastboot_fail("Cannot set fastboot flag", response);
@@ -465,7 +520,8 @@ static void reboot_fastbootd(char *cmd_parameter, char *response)
  * @cmd_parameter: Pointer to command parameter
  * @response: Pointer to fastboot response buffer
  */
-static void reboot_recovery(char *cmd_parameter, char *response)
+static void __maybe_unused reboot_recovery(char *cmd_parameter,
+					   char *response)
 {
 	if (fastboot_set_reboot_flag(FASTBOOT_REBOOT_REASON_RECOVERY))
 		fastboot_fail("Cannot set recovery flag", response);
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index db6088653e5..9184bc6346d 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -12,6 +12,7 @@
 
 #include <bcb.h>
 #include <command.h>
+#include <cpu_func.h>
 #include <env.h>
 #include <fastboot.h>
 #include <net.h>
@@ -91,6 +92,10 @@ void fastboot_okay(const char *reason, char *response)
  */
 int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 {
+#ifdef CONFIG_XPL_BUILD
+	/* SPL does not provide the BCB command plumbing used by U-Boot proper. */
+	return -EOPNOTSUPP;
+#else
 	int ret;
 	static const char * const boot_cmds[] = {
 		[FASTBOOT_REBOOT_REASON_BOOTLOADER] = "bootonce-bootloader",
@@ -129,6 +134,7 @@ int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 out:
 	bcb_reset();
 	return ret;
+#endif
 }
 
 /**
@@ -141,6 +147,7 @@ void (*fastboot_get_progress_callback(void))(const char *)
 	return fastboot_progress_callback;
 }
 
+#ifndef CONFIG_XPL_BUILD
 /**
  * fastboot_boot() - Execute fastboot boot command
  *
@@ -178,6 +185,7 @@ void fastboot_boot(void)
 		do_reset(NULL, 0, 0, NULL);
 	}
 }
+#endif
 
 /**
  * fastboot_handle_boot() - Shared implementation of system reaction to
@@ -192,12 +200,14 @@ void fastboot_handle_boot(int command, bool success)
 		return;
 
 	switch (command) {
+#ifndef CONFIG_XPL_BUILD
 	case FASTBOOT_COMMAND_BOOT:
 		fastboot_boot();
 #if CONFIG_IS_ENABLED(NET_LEGACY)
 		net_set_state(NETLOOP_SUCCESS);
 #endif
 		break;
+#endif
 
 	case FASTBOOT_COMMAND_CONTINUE:
 #if CONFIG_IS_ENABLED(NET_LEGACY)
@@ -209,7 +219,12 @@ void fastboot_handle_boot(int command, bool success)
 	case FASTBOOT_COMMAND_REBOOT_BOOTLOADER:
 	case FASTBOOT_COMMAND_REBOOT_FASTBOOTD:
 	case FASTBOOT_COMMAND_REBOOT_RECOVERY:
+#if defined(CONFIG_XPL_BUILD) && CONFIG_IS_ENABLED(FASTBOOT_REBOOT)
+		/* SPL may omit CMDLINE, so use the platform reset hook directly. */
+		reset_cpu();
+#elif !defined(CONFIG_XPL_BUILD)
 		do_reset(NULL, 0, 0, NULL);
+#endif
 		break;
 	}
 }
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 9e8e8889d08..2eacc84c465 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -160,7 +160,8 @@ static void getvar_downloadsize(char *var_parameter, char *response)
 
 static void getvar_serialno(char *var_parameter, char *response)
 {
-	const char *tmp = env_get("serial#");
+	const char *tmp = CONFIG_IS_ENABLED(ENV_SUPPORT,
+					    (env_get("serial#")), (NULL));
 
 	if (tmp)
 		fastboot_okay(tmp, response);
@@ -175,7 +176,8 @@ static void getvar_version_baseband(char *var_parameter, char *response)
 
 static void getvar_product(char *var_parameter, char *response)
 {
-	const char *board = env_get("board");
+	const char *board = CONFIG_IS_ENABLED(ENV_SUPPORT,
+					      (env_get("board")), (NULL));
 
 	if (board)
 		fastboot_okay(board, response);
@@ -185,7 +187,8 @@ static void getvar_product(char *var_parameter, char *response)
 
 static void getvar_platform(char *var_parameter, char *response)
 {
-	const char *p = env_get("platform");
+	const char *p = CONFIG_IS_ENABLED(ENV_SUPPORT,
+					  (env_get("platform")), (NULL));
 
 	if (p)
 		fastboot_okay(p, response);
@@ -240,12 +243,17 @@ static void __maybe_unused getvar_partition_type(char *part_name, char *response
 	r = fastboot_mmc_get_part_info(part_name, &dev_desc, &part_info,
 				       response);
 	if (r >= 0) {
+#ifdef CONFIG_XPL_BUILD
+		/* SPL does not pull in filesystem probing just for this getvar. */
+		fastboot_okay("raw", response);
+#else
 		r = fs_set_blk_dev_with_part(dev_desc, r);
 		if (r < 0)
 			/* If we don't know then just default to raw */
 			fastboot_okay("raw", response);
 		else
 			fastboot_okay(fs_get_type_name(), response);
+#endif
 	}
 }
 
@@ -327,7 +335,7 @@ void fastboot_getvar(char *cmd_parameter, char *response)
 
 		snprintf(envstr, sizeof(envstr) - 1,
 			 FASTBOOT_ENV_PREFIX "%s", cmd_parameter);
-		s = env_get(envstr);
+		s = CONFIG_IS_ENABLED(ENV_SUPPORT, (env_get(envstr)), (NULL));
 		if (s) {
 			fastboot_response("OKAY", response, "%s", s);
 			return;
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index ae33e35365b..faf345fbcbb 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -27,6 +27,7 @@ static int raw_part_get_info_by_name(struct blk_desc *dev_desc,
 {
 	/* strlen("fastboot_raw_partition_") + PART_NAME_LEN + 1 */
 	char env_desc_name[23 + PART_NAME_LEN + 1];
+	const char *raw_part_env;
 	char *raw_part_desc;
 	const char *argv[2];
 	const char **parg = argv;
@@ -34,7 +35,12 @@ static int raw_part_get_info_by_name(struct blk_desc *dev_desc,
 	/* check for raw partition descriptor */
 	strcpy(env_desc_name, "fastboot_raw_partition_");
 	strlcat(env_desc_name, name, sizeof(env_desc_name));
-	raw_part_desc = strdup(env_get(env_desc_name));
+	raw_part_env = CONFIG_IS_ENABLED(ENV_SUPPORT,
+					 (env_get(env_desc_name)), (NULL));
+	if (!raw_part_env)
+		return -ENODEV;
+
+	raw_part_desc = strdup(raw_part_env);
 	if (raw_part_desc == NULL)
 		return -ENODEV;
 
@@ -99,12 +105,13 @@ static int part_get_info_by_name_or_alias(struct blk_desc **dev_desc,
 {
 	/* strlen("fastboot_partition_alias_") + PART_NAME_LEN + 1 */
 	char env_alias_name[25 + PART_NAME_LEN + 1];
-	char *aliased_part_name;
+	const char *aliased_part_name;
 
 	/* check for alias */
 	strlcpy(env_alias_name, "fastboot_partition_alias_", sizeof(env_alias_name));
 	strlcat(env_alias_name, name, sizeof(env_alias_name));
-	aliased_part_name = env_get(env_alias_name);
+	aliased_part_name = CONFIG_IS_ENABLED(ENV_SUPPORT,
+					      (env_get(env_alias_name)), (NULL));
 	if (aliased_part_name)
 		name = aliased_part_name;
 
diff --git a/drivers/fastboot/fb_usb.c b/drivers/fastboot/fb_usb.c
index 90380d37ef6..569a181e3c9 100644
--- a/drivers/fastboot/fb_usb.c
+++ b/drivers/fastboot/fb_usb.c
@@ -41,6 +41,8 @@ int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size)
 	}
 
 	while (!g_dnl_detach()) {
+#ifndef CONFIG_XPL_BUILD
+		/* SPL callers own the session lifetime and may have no console. */
 		if (CONFIG_IS_ENABLED(CMD_FASTBOOT_ABORT_KEYED)) {
 			if (tstc()) {
 				getchar();
@@ -50,6 +52,7 @@ int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size)
 		} else if (ctrlc()) {
 			break;
 		}
+#endif
 		schedule();
 		dm_usb_gadget_handle_interrupts(udc);
 	}
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index f2aebf4e480..9dd3abe2a5c 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_$(PHASE_)USB_GADGET) += epautoconf.o config.o usbstring.o
 obj-$(CONFIG_$(PHASE_)USB_ETHER) += epautoconf.o config.o usbstring.o ether.o
 obj-$(CONFIG_$(PHASE_)USB_ETH_RNDIS) += rndis.o
+obj-$(CONFIG_$(PHASE_)USB_FUNCTION_FASTBOOT) += f_fastboot.o
 
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_USB_GADGET) += g_dnl.o
@@ -25,7 +26,6 @@ obj-$(CONFIG_USB_GADGET_DOWNLOAD) += g_dnl.o
 obj-$(CONFIG_USB_FUNCTION_THOR) += f_thor.o
 obj-$(CONFIG_DFU_OVER_USB) += f_dfu.o
 obj-$(CONFIG_USB_FUNCTION_MASS_STORAGE) += f_mass_storage.o
-obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += f_fastboot.o
 obj-$(CONFIG_USB_FUNCTION_SDP) += f_sdp.o
 obj-$(CONFIG_USB_FUNCTION_ROCKUSB) += f_rockusb.o
 obj-$(CONFIG_USB_FUNCTION_ACM)	+= f_acm.o
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 1971755721f..9a2e9850112 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -260,7 +260,7 @@ static int fastboot_bind(struct usb_configuration *c, struct usb_function *f)
 		f->ss_descriptors = fb_ss_function;
 	}
 
-	s = env_get("serial#");
+	s = CONFIG_IS_ENABLED(ENV_SUPPORT, (env_get("serial#")), (NULL));
 	if (s)
 		g_dnl_set_serialnumber((char *)s);
 
@@ -489,11 +489,13 @@ static void do_exit_on_complete(struct usb_ep *ep, struct usb_request *req)
 	g_dnl_trigger_detach();
 }
 
+#ifndef CONFIG_XPL_BUILD
 static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	fastboot_boot();
 	do_exit_on_complete(ep, req);
 }
+#endif
 
 static int multiresponse_cmd = -1;
 static void multiresponse_on_complete(struct usb_ep *ep, struct usb_request *req)
@@ -559,7 +561,9 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
 	if (!strncmp("OKAY", response, 4)) {
 		switch (cmd) {
 		case FASTBOOT_COMMAND_BOOT:
+#ifndef CONFIG_XPL_BUILD
 			fastboot_func->in_req->complete = do_bootm_on_complete;
+#endif
 			break;
 
 		case FASTBOOT_COMMAND_CONTINUE:

-- 
2.55.0

