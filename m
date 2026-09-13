Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4FCC88E40
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 07:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F57960607;
	Sun, 13 Sep 2026 07:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DzLRLUS-ha3y; Sun, 13 Sep 2026 07:29:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 554EA6060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789284548;
	b=AeSiEY0Xmt0h/I4rI/2RB6Xl30Z9+nbo/ls4qXjoErGY2+71pbPFbCk9QC9pTIVVkdlf
	 EjNhI7TtDQ9khJt++3bXH+t8198YwaPy52GCdxn93W20JpJM70v8nzlIeltcQ/lXGD5+q
	 MbJr8d4HRIRgg1eDJyLnb3WSFXKVUrt1Kuz1ECCK6eZWG4XqEz02G1XxRInRargp6FpT/
	 8InldO/jbjECd4PwdLxthyYisOGM5NSeqfm99yxpwWf5hdpK0DuFdHxFNxWYsN9/1D6tv
	 wqiS0LXuCF9jd6LK3G1C/QxunuXnC4IatmCnc4qayb3bCMLmw5yB7i7Z9x2TxrhEQlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789284548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=64kp6PRI2tRYxm9ynt0MSthSCqIxNHiSb4dvvXdrJMU=;
	b=hkhKf/QzHSaqyHuc8Mu9N5ovDantU9LjGqIfFo9zzA9kHoBagqBTN6Ef1hdtTTwtB0B3
	 SL0gkvV3l7qi+sdpZOOFeNUeKh5Ud1D5DXAiZDhUibdT98XySG82h6ZHyWnsLJxlpcOeX
	 HL2xbEXvyLzaNc47ORIbhFmJBuA+VT+vG4SwltLwahFAogkIDTByNZaRQSOLvhCxXSI+w
	 BYJzcEj7DUOrpPCg9p8NSGkCnO4maVP8LBQkK2NUjLf7xG6umieWnE8Xa7QhHhBuZ+39l
	 vKq8Wyxk6E+1Y2ITEAH0ZKg18uzjnzfx29CDuVfrnZ77vNnt1Z9ko8Yf92U3fBujEDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="k+y/QgTo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789284548;
	bh=64kp6PRI2tRYxm9ynt0MSthSCqIxNHiSb4dvvXdrJMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qe4mwyzlmIHXuUHZVw1VLJzU/aEF2hUEC3xmyFtQ8eVPU9YWOJD5V17OU4jqsL4hb
	 GM7J3WyNAGSfvBMRQTGZXfFZtpGDW0w4rUMQtSPobCF8B8aL2N0uxVBijugFiEtYZx
	 DOyrKw7nVtqVDdC8NI7nvJo2D4M7tZgxR/sv89f2UhQ38jYXWFDYRj67ZmJ3ARxk/P
	 CO74LDTzHycnBk8xQpwe8pUfxYtf+VWZV4PY7KlAOUuXevnY0R5OmUY6WNGKenhB6T
	 795GNUgpsJFOJoCZd2FYx4ggCsxn9sD3YCGGLpozxKIBr9P9C3xDoZl0FpTcnuf7lB
	 frq5FhRveNZ/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 554EA6060C;
	Sun, 13 Sep 2026 07:29:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 661412E3
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 543FD6060C
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zS0dBz2Mx0rn for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 07:29:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BF5CD60607
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789284545;
 b=LkrBTXPQVC4/WT+xvWw4Aj+hFJ3hyXdnLzHwfS+ZrcxS/30SGtOp21opDmBbgoeyIzb/
 y7AtmMeU4EK4O/tlKPjNmhFYKTZSXPffQM5xzrdNStnUv8jDCPIwehQdkLm3wsVxmwXvX
 oCnVbysk0pclemjKCm+OP1uooVNN69GpiA7V0Lw2+yfeRRbZW2mzcPj7W16mGj/wFM6Qq
 H5j4OYR0pY2GeI/SCNm0wX0cvBjf/K25mROz4TbICNV9buygtrCqveFUdpZWGl5EbOJzA
 oJ1AEm4JwthuMwSJqwCY4tqtUOy8kcipWoXNTw2tDf7sEYyL6M4l7WlZ+IJLRqYyOGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789284545;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=64kp6PRI2tRYxm9ynt0MSthSCqIxNHiSb4dvvXdrJMU=;
 b=PeJnM7bFFV30dFkRJyhubpPXL53r5Hdb0Tj4CQDk+fWYY4EzUJhPRlB9BPMddiuIzgPS
 iatsjMv62u++lwdBXhgzooPfgvVuA1AdiqRHEZK4+SKjuJUTLXrDtZqDoT0hpz7NkeUDc
 jrHkwM2ZwKYLQbH02pZZPs/Gjny1IT2bVxwIsDIHgcJptgju8fMpaPCMe7G1Iwakt2fA5
 Tz8jXtDfgUsQl73aKDqfYZwG0+DbJ2WjYO4FU4Noxr/+rYGquJXyrdkehWtTvIpVFKAFw
 TKkJbqajyp7e5WKW+nhjMtKAVdcjtO2azFtsrGJFIsjM/n4n+8pxxa51Z/SrknnkCqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="k+y/QgTo"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=k+y/QgTo
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF5CD60607
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:04 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso8742565e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 00:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789284542; x=1789889342;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=64kp6PRI2tRYxm9ynt0MSthSCqIxNHiSb4dvvXdrJMU=;
 b=k+y/QgToOciMKElDqNQrXaoxciCN7CzTKn4UX9WWcBtwmOsScsTPh7+Rs+CprDJylh
 1ariUcIs/kIQXjBN9HlRgQ16tIzhP6g3yJClHLeBe2srInXhcU+uaWEG7HB1rvC6WV4z
 2cJKkuxy1PQqOPg6DSaY/NmYnngK8g3iW+HudCdYGlGRKnfz8kYGsphJTMz3qs/YfL5L
 vTmHYVfaNkaTCXj6ME0cIUbJoYK1bodQTk+PNdtm5VVIXecmFac+5YNdIbyr/4Tyh3Yi
 pUD06QqAFCO3u9xRxhfjy0vOu48yFmfdI25kScih58jOyb4FRpk6lOieriMvD/P1y+tJ
 zC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789284542; x=1789889342;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=64kp6PRI2tRYxm9ynt0MSthSCqIxNHiSb4dvvXdrJMU=;
 b=r3M/xF3asxTeON09aW0ZjF2cWyRJkp90erGn2aWuzAyhvau/tY2X07PhWCXKSIc+Ht
 y1e+37oS39GoKGyfAqFqbrscMtUjungGyyPZzmOCD3w7CxktNJ4xnZCH/mqc24SZMlrI
 T6eoWEScxWIXApmiqYNVJJAuqWWhA9CnXJGvooE6woU7csrQZ+mNWKIXx28EPU8ohvOG
 QibmR15ooSV1TtlAqpyeZTwvjo74Ak51NAQRQyOfyH03V7tfLuHEN8m5OqlT7hWsJyYP
 WrSm4qN6S+PdMsIha5xZSdBoVdOzSkLDvWPwuzOzt1ZumubACytHa2Atmcp2VprWVe96
 bsYA==
X-Gm-Message-State: AFuF++mLyiazKbe8q3aJGlRghD8Y+T7Hak8gnWT1l9s84IZP5p35wnqE
 v6+kuJdGh/TwsN9djJ3OPd99hW5u/3nIvE7ScpYF2hYxvCajn/1UsvegrqZFWiCcwG0=
X-Gm-Gg: AYBFou3cTlBgxDDiMo/RPNv8Cmjdpp3zR4WZOKCNAUl5U7dVh/P9sk1Ja7YWTBSauf4
 MFZqNdaqcjzVREAE57M/oChRSO0TMWsB9ayZkmBYapamvsk4pggIWRt8Z6b3jwUSrwOofgaED8A
 ctkFEOtfdSofgS7tBjE2+lkrW06jPYU9O3SPs4o9GzVwNF2qnB0Z0cLzewtAVIPZNDkrl4ixVRl
 tf/WXTYnKOVjHDIaviCBSqH/0NmTQfKKSWXSgT2g1lmBs1WzE6Ancbv/UZLUaENapseMoKqYDxw
 53Oh0eJD43Fq0WB5Fyq11kkB29XTH1+pORsS67itiBxrojV+NCqSPPPrcNhGF5ixSS1otwLGDnD
 k0WoxC8j15PfG1yyJOdCd3XPhk7zQ8QGBlycC5fd1+/bcyGIqauxqSz7hZqbDqQSjLztWySGc4g
 ksrT8WJ20ifgSRwjB0IUBOEo5Q+/IbDe0Un7vIDq0Hs4WY+hMjzXP++HX3Nk/M2ms/RLF9LUjF7
 8W/PebcGfeqr6IvWcDa7P1PXLtDNnqdfBuwe/+yZXXsVUtOyR3oC2/fUHpadPEARHHXigFnHkJs
 lmLeJXmAFy6KLBM=
X-Received: by 2002:a05:600c:548f:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49e6caa69e8mr52873245e9.7.1789284542423; 
 Sun, 13 Sep 2026 00:29:02 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e71e300f3sm100788875e9.7.2026.09.13.00.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 00:29:01 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 13 Sep 2026 09:28:44 +0200
Subject: [PATCH v6 2/5] fastboot: use the common handler for USB reboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-ccaione-upstream-spl-fastboot-v6-2-dd3ba81a7ed2@baylibre.com>
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

USB fastboot resets the device directly from its request-completion
callback, while the network transports route completed commands through
fastboot_handle_boot(). Keeping reset policy in the transport makes it
harder to support callers with a different reset interface.

Send the USB reboot completion through the common handler as well. U-Boot
proper retains the same do_reset() behavior, while execution-phase-specific
policy can be contained in the shared code. Drop the command header which
is no longer used by the USB gadget.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/usb/gadget/f_fastboot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 8df0e3f331d..1971755721f 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -9,7 +9,6 @@
  * Copyright 2014 Linaro, Ltd.
  * Rob Herring <robh@kernel.org>
  */
-#include <command.h>
 #include <config.h>
 #include <env.h>
 #include <errno.h>
@@ -422,7 +421,7 @@ static int fastboot_tx_write_str(const char *buffer)
 static void compl_do_reset(struct usb_ep *ep, struct usb_request *req)
 {
 	g_dnl_unregister();
-	do_reset(NULL, 0, 0, NULL);
+	fastboot_handle_boot(FASTBOOT_COMMAND_REBOOT, true);
 }
 
 static unsigned int rx_bytes_expected(struct usb_ep *ep)

-- 
2.55.0

