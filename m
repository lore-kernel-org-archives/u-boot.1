Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51CACC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0454406AF;
	Wed, 14 Oct 2026 12:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 864BDsq5xAYG; Wed, 14 Oct 2026 12:25:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 724FC406C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980701;
	b=Tf589DL+1UCFXswmTOYSqxxPnOS0bCgp7mMPPIoypciZZwHVYgiD4JXGiu9LjtKhcJIU
	 GGD8wI1XH6V86E4u5oPzAO7Id8n3gywcrEYZIej6swY2O3bKcp8oT7MWNWBVcrrUdbe65
	 IpCrUKffg60vUCHAmG+2UIHW/hXQxtk49FqRkt7w9JvoJI5j9W1tWUZ/XQFUpEb1g4//o
	 2dsz3W5ctP8efMBk815H2/MLm0SEXIOc99it/5OuJlFFa1l60hX0Bvmkf7NL+EoYauVOL
	 Y9uNs/OMKsjjuivIu7yJY5dkFp9lyMRFfvCGasJv7N9/vp6hV1FVYWKopTBhGflI16w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=O+YtvYlv+VlWAqmQZsJ+XJ7RhAxCTn0hlWvt+whO2dQ=;
	b=CpATiIOrPGrigpa/CWF2GpDbSVdEMp6NMSHcePf50BI0gMUTo6TS9zwhiQ3w11YZYYtL
	 jM6tcQMWZYhntgxqQpxbuyxE6x1xnriauCIjvB55MFI5q44j/SnmTnktbNuMBmUzuA2eu
	 bPFdEsVfXZAalethGEdA3bR2lalN6qRcJ90iEgXyH/aBzylXm6Yqou7a83SE+f1kpo0yr
	 cFLDk+kXYS7bxSBK/Z1rpGc/TqrrCa/nqlNZKrw6z2MNzcgZIzJnie7WAacKSeO8al5QN
	 K+xCPQZ4LFhLcYm1v3f1/nLvaHH8143SXmJSDMe3VWOJOAfAVQApnhTGcMPL6xvfe+w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GvgDl2aB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980701;
	bh=O+YtvYlv+VlWAqmQZsJ+XJ7RhAxCTn0hlWvt+whO2dQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cBB7f94ZHAD2e0aCrOD2vyg/BumTtq4qmE/DWIvm5wAxrDT776MZrNR35zABAAyo4
	 /YGzse9/Qv3Ia/fAu9ib93UA2KS+gGovYMcoiQuYs/AIJV22UsQzlfKxkWJlEUWSBe
	 TE/V3E1J1yEijnJHtE/P8Vt+zlDLtPQiinn4FjXLdL9ssnuYWCxrfP5y2ro1n83xvY
	 OMBlj5BEwDW5nxeZexlCbS6vx2dOyrDoo/evmjXG/7VoV+XSmOrKCVB1dY07PYHmxE
	 JxtW5Rmh2M/rj3kjUZFw95g+6ilGBUVnQERX1Ni+Z2HpATctTOohbPny5XliyIc+e8
	 cEZ3f2qCqOeQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 724FC406C5;
	Wed, 14 Oct 2026 12:25:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C6632A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50F00406C6
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GGNFmZc80tb0 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:24:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C3C3406A5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980696;
 b=FgFUIZGiuJnkSYKtU93elHbvS18S4nJMfrNXuU+bI5HKDMIpGCTUBb1wIkBUYWdHynX6
 HDFqmvlGAk6bFlZr5rtZx8gg5W+fy/l4aq1OVjcvs/+RHL+RU//KOqYZUg7mRLCIcrELk
 DDzucW8lktFYC3O8xH2w9FXy/sN584wq1p9MQuO0dufcHdXhgfcNtwNTH3BW+WdQcSC4D
 2etAhfg2nl7JbclHbvF3RGpwgnL9Vi+ux8E7VOOR2f47lDdLkCiP+idxi/oOaqWHY7Yab
 PfjFMME1AgEJMMJjuYfdtWSRYhhpLjdJRu5rmttBQ3m7iFSskX/FlqF8ZpAj740ccKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980696;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=O+YtvYlv+VlWAqmQZsJ+XJ7RhAxCTn0hlWvt+whO2dQ=;
 b=nXbcoBgTCGk7/9mJkgczdz/igDSTuqhKUMUAaKzihIWWM/rVhqTr0aty6wFSAZ4RElRD
 kjPlH//R9a5rqOLsrCGtgV2qjIcE1pOsuNMHqkKciBgrjM8iYk/EFzOgMVTbd5LaTtj+e
 jt5kBX9HO7RztsO2r1IvLQ81XlTliaB89EJ1dqd2kBEVnuvx6wVUzUZELa3PRVmzlVe3y
 VlRJn0ixoBnwBYKNvhNrzv5fSSuTPViZ3HzroSDUXHvvwMLj4AcGJDEQNSPgWJniY7BQk
 1aXxripa/Df4lxBF5voJ/W+o6ByusZYsHTBKx8acmEIt3dSoTCaCybRSKtz+uD8akkQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=GvgDl2aB; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=GvgDl2aB
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C3C3406A5
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:54 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so481280f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791980693; x=1792585493;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O+YtvYlv+VlWAqmQZsJ+XJ7RhAxCTn0hlWvt+whO2dQ=;
 b=GvgDl2aBM5YZ17l/hcQVD8JHgrUcd8eZJiy3aqsy5dSwU0wLrxP61fdNRb7pmB63uv
 0WPAKt8EeadOFYE78Q5zECPJ+XTeCPXZZSKGGE3sdzQ825QmTDA80dTO9nlgg5ghetUL
 W25gcC7uAxJhzcoxBthUJgj/mfUHPivrv8H17MAJfapn5k8q971NwUX90wdPyGFrIQ51
 CmGgkNtnS/nG0T/+fmdT8vVtsZlPpV8TvG+rJyiW7ZBeflSxYm6sd85UshK21Ado2hGh
 jGhF6ovEr3QUReRpkU8F34Rw15l2W0M1JaJHyEfPH724KlD1FMmY96UeenL7PLVpnjRj
 DfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980693; x=1792585493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O+YtvYlv+VlWAqmQZsJ+XJ7RhAxCTn0hlWvt+whO2dQ=;
 b=VPXI+FG0A6U5Zu8jsWETaEP+gAQEdv4W0OsGQq7fFjG/46AHOXjJR3I+EPeIHt+1ks
 jMJUG7MGtxIdHOsW16uJ0vbZ2QVQX40kSWgszosbUWHIa7DEliiWz2p6aeIHQwftCa2q
 O1WgwQtpuGyvWq71tW4xv8qNA6MfeOegSKgJLMtp1t96xUyaEZh/8VQ1SqWYFN1JluBI
 IfsmaABPBx/a6deIgZ8c87A7Cico5PLM/wtenD8kagCNXUoIBXzVqJCv3AhmAoAvXRPo
 qLh2L5alMyVQPJ+dyUi2VAzgcpgz4cxf3JCb8IqGdfvQx4M2TfboJn9YoHbVaw+vfnPo
 Yhyw==
X-Gm-Message-State: AFq9FYJAbPOIJhNNVHaysKPbhiud3OBcOFHDHQHO7o21cQzv6/E+KW2q
 bwu0gcekX1lMGkjw3NoJgL4eK4jojA7ireA9VoNEDVtGLj3mfaAokDtp0TLQOrDsJMk=
X-Gm-Gg: AYBFou2485uQZ+sQDPq+LOinhRQ+E03HP60Jq7JWZLMd04Kfy+cvVdC4QrogT57dLSh
 dd+YaD1VAkTOx1s5DHdN6ZugjFSoGbgXdjVJMnfSRJa4C+DiZXgE+Lekbx9vNVRzEJnS9sG4pL0
 tEpl66C4JNI8nU7whb2Q+d+mKdEX23lhswae2vL+StGTWV9TmCC14MatbsN4kHNRNDAld5BA51O
 SKfqaU+XVw3R+a6MzrNzvbDdTOuzymEdQ00hu+xfY1jYmzlrpTjbB9RtL8E7bEp8obvnsp93LOT
 pOXOzddGGGHypOgBqDveDT62nZx9kkW5ZFasNK925aEdO2aLee93rGeEt/cstRE+eHNO0dhPikT
 Dw/Y/pSs4uD2BaOmiq1sWfGggZZvUjRJ6T8k4g4e5m/FCu2sdvs3MiJbqPLREEyU2FNlTuu3kYM
 9UsQgjzwxMgqMX/xTvsF2rntkMK4DHKTaVw+hCQWg8Y2cgYpwb96hyEWZgBSdOZgcaUgDLMKQOq
 G+vIR6jPKTdrp7DLLZcrVsOAhCF0nBbuXD30/3/TwCGBaFP0tA2DiEdt25JolSPsjFcNK5W8O5j
 ak0olWH38wEswQo=
X-Received: by 2002:a05:600c:674a:b0:4a1:7cf8:5433 with SMTP id
 5b1f17b1804b1-4a18e443ee9mr294586185e9.3.1791980692981; 
 Wed, 14 Oct 2026 05:24:52 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2fc4724sm50351815e9.2.2026.10.14.05.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:24:52 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 14 Oct 2026 14:24:31 +0200
Subject: [PATCH 3/6] spl: ram: allow loading FIT images from a supplied buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ccaione-upstream-spl-fastboot-boot-v1-3-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
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

RAM FIT loading currently assumes a configured image address. Downloaded
images need the same loader with a caller-provided buffer and length so
reads cannot run beyond the received data.

Expose a reusable RAM FIT loader with header validation, bounded reads
and overlap-safe copying. Keep preloaded images working when their buffer
size is unknown. Add tests for embedded and external FIT data.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS           |  1 +
 common/spl/spl_ram.c  | 49 +++++++++++++++++++++++++++----------------------
 include/spl.h         |  9 +++++++++
 test/image/Kconfig    |  9 +++++++++
 test/image/Makefile   |  1 +
 test/image/spl_load.c |  4 +++-
 test/image/spl_ram.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1f51d9197d..f464e0bd2bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1923,5 +1923,6 @@ Q:	http://patchwork.ozlabs.org/project/uboot/list/
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	configs/tools-only_defconfig
+F:	test/image/spl_ram.c
 F:	*
 F:	*/
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 0c501cf02f2..ee588ef4718 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -16,32 +16,39 @@
 #include <spl.h>
 #include <linux/libfdt.h>
 
-static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
+struct spl_ram_image {
+	const void *data;
+	size_t size;
+};
+
+static ulong spl_ram_load_read(struct spl_load_info *load, ulong offset,
 			       ulong count, void *buf)
 {
-	ulong addr = 0;
-
-	debug("%s: sector %lx, count %lx, buf %lx\n",
-	      __func__, sector, count, (ulong)buf);
+	struct spl_ram_image *image = load->priv;
 
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
-		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
-				      CONFIG_SPL_LOAD_FIT_ADDRESS);
+	if (offset >= image->size)
+		return 0;
+	count = min_t(ulong, count, image->size - offset);
+	memmove(buf, image->data + offset, count);
+	return count;
+}
 
-#ifdef	CONFIG_SPL_PCI_DFU
-		if (spl_boot_device() == BOOT_DEVICE_PCIE)
-			addr = CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
-#endif
-	}
-	addr += sector;
-	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
-		addr += image_load_offset;
+int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size)
+{
+	struct spl_ram_image image = { .data = fit, .size = size };
+	struct spl_load_info load;
 
-	memcpy(buf, (void *)addr, count);
+	if (!CONFIG_IS_ENABLED(LOAD_FIT))
+		return -EOPNOTSUPP;
+	if (size < sizeof(struct fdt_header) || fdt_check_header(fit) ||
+	    fdt_totalsize(fit) > size)
+		return -EINVAL;
 
-	return count;
+	spl_load_init(&load, spl_ram_load_read, &image, 1);
+	return spl_load_simple_fit(spl_image, &load, 0, fit);
 }
 
+#if CONFIG_IS_ENABLED(RAM_SUPPORT)
 static int spl_ram_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
@@ -81,11 +88,8 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
 		debug("Found FIT\n");
-		spl_load_init(&load, spl_ram_load_read, NULL, 1);
-		ret = spl_load_simple_fit(spl_image, &load, 0, header);
+		ret = spl_ram_load_fit(spl_image, header, SIZE_MAX);
 	} else {
 		ulong u_boot_pos = spl_get_image_pos();
 
@@ -120,3 +124,4 @@ SPL_LOAD_IMAGE_METHOD("DFU", 0, BOOT_DEVICE_DFU, spl_ram_load_image);
 #if CONFIG_IS_ENABLED(PCI_DFU)
 SPL_LOAD_IMAGE_METHOD("PCIE", 0, BOOT_DEVICE_PCIE, spl_ram_load_image);
 #endif
+#endif
diff --git a/include/spl.h b/include/spl.h
index 390d18fd9d5..f884c24b85e 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -989,6 +989,15 @@ bool spl_was_boot_source(void);
  */
 int spl_dfu_cmd(int usbctrl, char *dfu_alt_info, char *interface, char *devstr);
 
+/**
+ * spl_ram_load_fit() - Load a FIT from a RAM buffer
+ * @spl_image: Receives the loaded image information
+ * @fit: FIT image, including any external data
+ * @size: Buffer size, or SIZE_MAX for a preloaded image of unknown size
+ * Return: 0 on success, or a negative error code
+ */
+int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size);
+
 /**
  * spl_mmc_clear_cache() - Clear cached MMC devices
  *
diff --git a/test/image/Kconfig b/test/image/Kconfig
index 45b6e8c52e6..1cb8337e0f4 100644
--- a/test/image/Kconfig
+++ b/test/image/Kconfig
@@ -41,6 +41,15 @@ config SPL_UT_LOAD_NET
 	help
 	  Test loading images over TFTP using the NET image load method.
 
+config SPL_UT_LOAD_RAM
+	bool "Test loading images from RAM"
+	depends on SANDBOX && SPL_LOAD_FIT
+	select SPL_RAM_SUPPORT
+	default y
+	help
+	  Test loading FIT images from a RAM buffer, including images with
+	  embedded and external payloads.
+
 config SPL_UT_LOAD_SPI
 	bool "Test loading from SPI Flash"
 	depends on SANDBOX && SPL_OF_REAL
diff --git a/test/image/Makefile b/test/image/Makefile
index 11ed25734e8..feca0611fcf 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
 obj-$(CONFIG_SPL_UT_LOAD_NAND) += spl_load_nand.o
 obj-$(CONFIG_SPL_UT_LOAD_NET) += spl_load_net.o
 obj-$(CONFIG_SPL_NOR_SUPPORT) += spl_load_nor.o
+obj-$(CONFIG_SPL_UT_LOAD_RAM) += spl_ram.o
 obj-$(CONFIG_SPL_UT_LOAD_OS) += spl_load_os.o
 obj-$(CONFIG_SPL_UT_LOAD_SPI) += spl_load_spi.o
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 166cf331194..0e3bc0d6caa 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -163,7 +163,9 @@ static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
 static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 			 size_t *data_offset, bool external)
 {
-	size_t prop_size = 596, total_size = prop_size + spl_image->size;
+	/* Both the image and configuration have a description. */
+	size_t prop_size = ALIGN(596 + 2 * (strlen(spl_image->name) + 1), 4);
+	size_t total_size = prop_size + spl_image->size;
 	size_t off, size;
 
 	if (external) {
diff --git a/test/image/spl_ram.c b/test/image/spl_ram.c
new file mode 100644
index 00000000000..5874ac02a3a
--- /dev/null
+++ b/test/image/spl_ram.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com> */
+
+#include <image.h>
+#include <mapmem.h>
+#include <spl.h>
+#include <test/spl.h>
+#include <test/ut.h>
+
+static int check_ram_image(struct unit_test_state *uts, void *image, size_t size,
+			   struct spl_image_info *expected, const void *data)
+{
+	struct spl_image_info loaded = {};
+
+	ut_assertok(spl_ram_load_fit(&loaded, image, size));
+	ut_assertok(check_image_info(uts, expected, &loaded));
+	ut_asserteq_mem(data, map_sysmem(loaded.load_addr, loaded.size), loaded.size);
+	return 0;
+}
+
+static int spl_test_ram(struct unit_test_state *uts, const char *name,
+			enum spl_test_image type)
+{
+	struct spl_image_info info = { .name = name, .size = SPL_TEST_DATA_SIZE };
+	size_t size, offset;
+	void *image;
+	int ret;
+
+	size = create_image(NULL, type, &info, &offset);
+	ut_assert(size);
+	image = calloc(1, size);
+	ut_assertnonnull(image);
+	generate_data(image + offset, info.size, name);
+	if (create_image(image, type, &info, NULL) != size) {
+		free(image);
+		return -EINVAL;
+	}
+	if (type == FIT_INTERNAL)
+		size = fdt_totalsize(image);
+	ret = check_ram_image(uts, image, size, &info, image + offset);
+	if (!ret)
+		ret = check_ram_image(uts, image, SIZE_MAX, &info, image + offset);
+	free(image);
+	return ret;
+}
+
+SPL_IMG_TEST(spl_test_ram, FIT_INTERNAL, 0);
+SPL_IMG_TEST(spl_test_ram, FIT_EXTERNAL, 0);

-- 
2.56.0

