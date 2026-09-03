Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A2DC79F82
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE96860BAC;
	Thu,  3 Sep 2026 22:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VsUrvQAUZwwA; Thu,  3 Sep 2026 22:13:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1884760BAB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473601;
	b=gejpjXFrBsZY4Z6DrAFO5Wx3nNFMTH63uKZanHTCbF97SkOXLiGmv8OIsSW/jsk3i7QG
	 K+fr0Nsjc2+Tk8JXfvD+PxzfvCewHbhPOch3zmSUcCZ/IIBy/4PjyxfxLKjUbasO4eMUZ
	 AWbMRJ1KgzMtw7uRTgjJJiWAoIRCNp2GA7RQhF9WcKs1YDj1mhn0g73GbEOEoKdx9Xjq0
	 zb5IrYq67KLNC7vkO3Zc34ZRqu6qK2rLrFgwRg7WhaRQaMMKkQvh7RvzAILkj1BAgyXqd
	 4rxIZzQQYGtMdoPfrtZswUB2FzIplONDt7atHtlbmQ5r3vG5leq7t7xx5oG6Bz6YHsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473601;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=N5oHV7F1FcxIq/r8mTOh4ALpWn++t5MfFfaonreWhIg=;
	b=Rw8ZHEDX7jGAzCe1Y8JH5ohAxI+KU6i6ztMT9Tc3U9rfZk/kKcGodvl92D5m2wvXZFoj
	 5MRFQFER+bI7arWmmzi1kXb+LbKRfeyr2d7YfhAHfltzbX5ZIxKWQrWg2qHMwGS4ykmve
	 q1BRGJTY0j8DmjppTztMHR7sctgym3ApmqT4wtmTiBwzhGxButTdRryvQ3TlB/5MZ5uJO
	 9HIw9KPeBIJL3q2mqqE4eZW0QIsZ8OhZxQlQj7f6kENVAKOYwifmlxm6WI9aMp6b6Kt4J
	 +Vck3GX4opdBM9dyahBc/KCObSne0t5wVHhiBXKStleu+grIZ+nIEOPIIwAMLEHEOBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473601;
	bh=N5oHV7F1FcxIq/r8mTOh4ALpWn++t5MfFfaonreWhIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GYQhjox7eGOVHOknsuF4dE6WNA6SG3lZizyM7CIK7HiSOtwW6ck7pqvdjSIJnlji8
	 HiT2dc+KFE3zyqFg7DQLMqBjSZhbK4KSQG3CmmF61Kbj4sIoCKU/+zNpnrI8p5M0gZ
	 ogkzU/UBkskTtPqaIY3kxNk249Gl7xqHrhcCb2GDPXlMgrxh8dGnWCyu1QH75cuzEH
	 mA+1w+6cYRqj+tqg/cpb6T+t/DJxR9emtC5S8fe1NiZAKjNiUb3eKxQEIRPj/NHYpt
	 IJOIwGx49U83ALCInK9ZhaXAz8/VuolzWhb3Ll54evk55J/ETK9NOom4wzFyxU4nHS
	 CRe6ue9jWUg/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1884760BAB;
	Thu,  3 Sep 2026 22:13:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B9AA422
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11B30810EE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6k-AGvyZUWz for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:37:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CF847810ED
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471476;
 b=Gjqmji+whZ+iFt3/XzsGq1DDov1+rpvJEfEtmQlLoKXzDMMRjmOcMRGECOe604sFwl8R
 Z7cYQOi7zg7bHNIq0U9MxhXOvWVL0Dfg6wNLfvHFuX3RClUcwvNHPgE4km4pljBteyFII
 uyoDxRqESvI/Wn/+wzEDofRP2eW6rjp+9vTyM3by46ShOSyiThBvyCFEx29ZJG7f31ykg
 gmgSB3++js7fJ+5Z2RjjoHdxz2litgApRcvHwU/QMSnW051nI6JCgjyoy8PDXqeHmkb3d
 gZaAPrKLNOBRD+SQi7xBejRtK1KEe0NkvVZY5bOwIXcP72Mq9S+kqlZuzq0eVDpBE+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471476;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=N5oHV7F1FcxIq/r8mTOh4ALpWn++t5MfFfaonreWhIg=;
 b=ZS+GPLRlaiSprlH5TR6CsI/8uEMOYstQ1tzq1GXccc03UYk67Sy3wave7Ucf8Zl5MNov
 kwbTGR0JKVTCskDDJaO0PW+4/O5LW0h6meLEs05iCoZkV/HGKUeAkJFxaQwEIFDgxTvw4
 R6LjDbttehQWUTcoFPxDhWmVI9lg11u2Nh87lhh4Lqbz7zDhA1zT/JmBX1wvTT/fUnrJL
 dSNbLJiW18VsHVAt7cDBbrbftUKMz/KhDQvEdWiaqnqmrVtM3Mvbf2hIUbXQ1NT6FbeBZ
 Ud9zWTdBVNPTDIdaqHGgF5oK0QYVha9yw3CIVhCSAf6RnM1eF/RQtJHYoMy7b6ja6Xw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eBuuKPNI; 
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=eBuuKPNI
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF847810ED
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:55 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-459281bc13bso185873fac.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471474; x=1789076274;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N5oHV7F1FcxIq/r8mTOh4ALpWn++t5MfFfaonreWhIg=;
 b=eBuuKPNIhBkYnheMXBeof9tWeoLB2hmjpZoLH/doXtYPkWeQV6BqehsTV2Es/RT1M8
 V/tBxxruE8XXp9t4R7/VbEbw/AvOBFZ+IUeNq3qkIkgilKp7zAfdsGrJdUkYCFjGXAsA
 X9TL5CcfWITbv3OAd95/zCGMICOoBsWW1YHFLeC9ucg3Vew71XQuIic51TKcK5ZzwLTh
 HUSPCfUwIRxqcbvjH2wf+TeuqEoz9ipCkZIkulu4dUQjnhHrsRIwDvSjfIqI75syzzWA
 hi4g8EazNpdP4bJ/Qc7nTFAz2AyRuogwjkIqN4LSrg/VSSQhzZEinG/pRPAK6YQzusKU
 QOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471474; x=1789076274;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N5oHV7F1FcxIq/r8mTOh4ALpWn++t5MfFfaonreWhIg=;
 b=PDvV5z4ggrSDT3WmGzL81wo8nKji7OUhBbULDbn7N/3s6WbTfJJGF7SKlelpqEvoXR
 WatM/c2mDB6Q3uRUGGPjXG509x33zzCJcDncSq8beVzgrZswgT5VrEJdHyNd5lYGC6Zv
 18vl4450W91xYvnJY4M6l8yh8kcmL9CkPW4R9qlOm5qcHrefUXQVo13MrJ3tcuSMkZgX
 4lZ8qYE6Fwx3qJmzoIlcxegSYFwZ8J9X/rKiky22h1+851fuctdBHEtBVm2qVRwNxUOr
 4ZvJ4SXmyGFSvXyB9m7bhb59cXZh3wSUnlxSqYcMNPhazNQnG0qbELeaZStAGlNjpmZ6
 QH4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPah0KxYQDBrzG+NV5WzZ7v1iuoCDE+BLKCoBdzI5ekc41S4TxXgqCzwqQpVqu1M6OuAXZun4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kOoRCekfWZNoB5WHy3XA0aDjUi9VCT/X2iUSyOio41+pELqwk+
 sfuqL33Ak+0UJJD823nyeyYq9A4vl/od81KQ2qSjhZfS1iMXKzA+0OpYAdb5Gptxvf4=
X-Gm-Gg: AYBFou1GAgZFg4VaT0xqo+gLMvGjUaA4itGvYnOqxfudT7KT5lCL7QZEzD3GVYwAnLq
 dYpm+Kw+2M++LM9UJ3n+btwyFW2k1zXPWGZhN+BjBQDnFuycWH1+owtZBdXOMeDlY/AXTi1uJrp
 MBP+7CTPjvYwU4WFRH8DPlAopGx8dhRTse3UMYpKXT/I6cmWXstUep2NkDnUTLGBSNB4ESnSxjx
 eLBE3HTOflY8sg4iz3YKCNjwI2LI926qbkzzd/y7S1AScadhMQt3cC5UuWRmmsO34Uir06mCcpA
 pfu2GkDLcMjuo8tmvPLeG7Vvydit5MNV5j5bI5QiWDN9IjUxVzkBhsjuCUBS0z6JqV6woDYtUOT
 JQ6sDAQCvIcJbr1caUfE2+XDPN2QF3VxfwKL0bYx954UuRpHqa+Vo6UVsy/heGHZGPqwSIxAvjz
 SlSErjUprhzmUlfK8j3Xsae86mx73UL4DtMXbboOUAE8eas3lCEgjuOaf7WrF/TpAZuw==
X-Received: by 2002:a05:6870:96a8:b0:455:c1d1:9cc0 with SMTP id
 586e51a60fabf-475538103e8mr1923856fac.19.1788471474484; 
 Thu, 03 Sep 2026 14:37:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:37:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:48 -0500
Subject: [PATCH 04/14] net: hifemac: check dev_remap_addr_name() for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-4-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=3I3FX1Rcv8NHqgyh3owv3u1U4P9s6uKoIxZkhAOd/Ow=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmehRAslifHhhQDtj9gQZ1AbGE6Pvy9tKu5/k8
 rpczyCi5pOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnoURYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmwoH/jXHpkcZKOaVqQ2cGvmGjCfuIH/Iugv3fbLuK2j
 +gUzd6UAfoV8yn3aAdu3oWWen4pdOeAEjtHrdiotLwmnP/1RcYinLEaa/ZFTAaALbpl7hyE/e4q
 SKCytuXRp6niJa9PUQStUCscVTFrLQIOe3T5xlX7lYsvnCw83LdxGrBYmaLb7AeJi8DC1ArGeBL
 6Cxwe0PGcLUjcPsLHwXKmHEdIM3s53DkJ8KebRbHN5y9B2IXkdpbt2DVfZgziglcT75OnaPzYcY
 Nco/vQIe+wz2bn8Tl4zgsVVbPIPHq+si0x/UN8Xba2LTuD85ph/T67bzPJUvUe0F8Oe8Cb+EVKe
 lN+w=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:11 +0000
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

Check the return value of dev_remap_addr_name() for NULL instead of
IS_ERR(). This function only ever returns NULL on failure.

Fixes: 9d8f78a2a79f ("net: add hifemac Ethernet driver for HiSilicon platform")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/net/hifemac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hifemac.c b/drivers/net/hifemac.c
index 7dda8cb8815..ed983e0b263 100644
--- a/drivers/net/hifemac.c
+++ b/drivers/net/hifemac.c
@@ -435,7 +435,7 @@ static int hisi_femac_of_to_plat(struct udevice *dev)
 	}
 
 	priv->glb_base = dev_remap_addr_name(dev, "glb");
-	if (IS_ERR(priv->glb_base)) {
+	if (!priv->glb_base) {
 		dev_err(dev, "Failed to remap global address space\n");
 		return log_msg_ret("net", -EINVAL);
 	}

-- 
2.43.0

