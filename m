Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229B4C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D652A40B75;
	Fri,  4 Sep 2026 07:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CA4TNHSKeGcC; Fri,  4 Sep 2026 07:13:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DF09B40B83
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505987;
	b=BuFj1HjfJNRWd9uo2l0pSO0kWyHAF0cnbub96uZ1puIN+qj6Fdv2PwCeT1b+rebEFnpV
	 ALCX/7BUw1DBi2GaJNN0bgrVuFBsSw3u8xGbGtLF+Iy9ZE+5o1TPOjPq1wyIQ5mpaYoOY
	 Jl2tKkiTtHFCTctzMLslIW6W9JQyuLk9HVephXgbGlbTwWex138tG6Biq59AWre+kRevW
	 ZI6WV20NraVCXbzuRJkdfg/zyQKmLqa3GkQkFCHfjxYgCBNj7enWnNfnAMPykwpGKVq6L
	 Xzn+9FEka493iXF6r1JVtwUQrpIgmFfYmMZNNhpfMicCecaQUS6/WRkmNKPhLiD06ZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wdVRav7KN4RhJMJAPAAa2XZB3yIsUMvoBDBARQxk8Io=;
	b=qvmh3IRxQNrIIYDqUxEQ8gaP/KTUgLLJHDiyL3M/jjcn9m+fajmjpbKfYDFIMAyIaoos
	 GoNqS9LOKTHQiI7EcOVTZhX9X3wZyXOku6S7A1AVztJn1QIb1zMsZpHEhkS9dJosMmKi7
	 lJI5fUC1HECI0aL+6SRvRJLRAMjSHi2r1KFn+Ql08udS0cSPg7nDK1xnIieuF5AQsAbhu
	 FEJs++3L/R9n8PJSIo7GjbXSLA1Z4G3xVFlKMl2ks/kRA1jlHs8zOO/9C/35PQuEy3NlA
	 hvELGgE3CREF27Mu8EELQud7aDqg/RQve1C1OjPbZ6tg/OhWP2s7h8robBgV9+lP0bA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788505987;
	bh=wdVRav7KN4RhJMJAPAAa2XZB3yIsUMvoBDBARQxk8Io=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ay3FCJDQK/KW4l7XsnUGOEpeb3aE0tlNVxRiNLFvyVRWj4SaVwnh7xUzJOX7D1TSq
	 w7r3mTmiu/K9UQImZlfklh3+sUO8HOMUHlxyV1j11/mY2Q9yhtKYFDnOQ3qGGdNBLY
	 BPzGG83ZzDPbF58oVCyhlxjwqRRgIB0pOl0J8G05Yd1diLvzxEuk2iU+ZnyalLn5oJ
	 7o+joZS4GKCX80HoZPJsr3hfXcn44j6CjiRcrqv/tjk5EWvLZU2TGoJlIQvw2BUh5A
	 B/vLisLxXv7syIipXQ+ZXfiB/sU6Q1D9gtZFRIhvcn7WbDVSDkgO+EXDhdyLVutthv
	 wUXxawc29cWzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF09B40B83;
	Fri,  4 Sep 2026 07:13:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A0A3B2C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F04CF4008A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e-gb2RdLWkjE for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:13:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D5FDE40080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788505984;
 b=q5Vq1qMu2t7xzmyjzvKanP1sQaa/tRnUhFjAn9coXRwrk2Lz0bj7SSppU4U53yNRtCzM
 gxjUEGgzK3vzsqyqTj9rBstGzV54GGtZdMZuxE0kK26Gj4MkYFlThoFw7AMYuVNLouenR
 yXcFUR2F/kmAwhUTFzEC5uOrLla6f9FX3ocn16EDMSq9cJuel9BgkFfVsN5bqMvdedoKv
 qnpxM3rtnOfnbDRdeKy73+o0SIZCvsgs5/V4JBhT5kPAA/wRVydmZMLZMXR/fRfkxr8y6
 BLo83WOzI+RCjVUL+qx0q1iVln86oxNvRD8PiHSi5zaKWfhpESKCQwl8jM/9oJICPyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505984;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=wdVRav7KN4RhJMJAPAAa2XZB3yIsUMvoBDBARQxk8Io=;
 b=F8Gt5iaw5nQEp/2gEmXH6fPkrmqCZ+vs63oitr04GZD3aZLmW7/kA03Q6GqhXux5OGX4
 ss6amAWoOuhzkzfJhKBPxCbEzf49QNc6/3T5P7kjSairsTAHdrJiAvX3nIs4YUIoUjvxo
 VI0CAXnGhJ09SdVJdwrAx8b9gZVrUknUDK74kK+FZYD5zi1hRRiPTGwpgI1GNksDhGL/F
 v69bpeigyxG7YShNKOboGChD2cy1pe4+mq3utz1HcEoXp/+fP8yM0yIcZ9LhVDlJovwrs
 dkOhk7rC0u2kWEuGDstNntiWQ682b3wJbeGq8OADxaAypTY6u96Ppv7DV8IHczZVzLg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ZKH3RKKf; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=ZKH3RKKf
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5FDE40080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:03 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4843efcbdb2so368999f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788505981; x=1789110781;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wdVRav7KN4RhJMJAPAAa2XZB3yIsUMvoBDBARQxk8Io=;
 b=ZKH3RKKfXIoWq6XUPit6JRl5q1F7uJntfFkXCzLoDbVF9qwg9j10dzL2usNSD1OZY3
 jVG0wR3wteH6HsPzs2XvrzlUZxO4WLDT2k3IY2jSUvYzYOvaYzqPA3FqG47ckRDrTjCg
 aTwlPLU6WjVqmMuOlT+SWLwoaO1sfs14rqxYrOkai01usLE00YgAEUCLoCLiU+gKO9hK
 plzpqKxHjohEmYp2dAEUwOk8dATlMVdUlGOd8xRDF+jDBgbiv8OTujs6fu4+i+I2bGui
 HwEleXGFaGdNUr4Irt5BR7uJE3LRCM/ehJK5XY0FJigyvxYcbs4I+b2R0/x4CAxyb8jJ
 UBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505981; x=1789110781;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wdVRav7KN4RhJMJAPAAa2XZB3yIsUMvoBDBARQxk8Io=;
 b=GVpjpnETwlPpL2WDyLKt7AgbSAW+yEilxuqbsGy1BkQgC/C3Ab1jxNVoMGWqXz7IwK
 slkveQUoFdKtRUYhK1UYwQGb+xuldT1vQRD7Elu4KaVjweztSN9sdaD1ZkGMsKuqpDUI
 DsMBae7w/qOqkFocBIRuIhPR9CxU6m72kC5n1Bm1GbAt+9bbZRNRWHTIynzrI10DWMTd
 6Z+66a351x7+7QSamqJczKQYOa70XfjDbUHE224pMPKKXBWWxSvh8L9OPAXvWROv40M/
 JIDYyVrfHEa9Kf4Vw3iNMK1Ic3KhstiY0+AAatgdCdCsuCXGJGKA0vXhzJMbM8ZNT3yW
 Wchg==
X-Gm-Message-State: AFuF++nlMvsKtGcpJwoqwCy/7QCLwGCcDLiNt0sixStugzMyZhdZc64y
 pWlEEF6NfspvobcsfmFZ0oohT2QDBjHWOAj7TGMOwiYzLd+6Unxq8U3uD8N2lQHLXmg=
X-Gm-Gg: AYBFou3QohFsXrG8QY4hK7NrjmFp4/ToXQ025VkhXzgrt8VyJoAGmiKU1KYAnENk4pR
 KD37vAzr9JCoEmsbg/O+fQ1Ab3aKOhIcRwGY/EUlRCFsLzWEIFFiVJcR7J7VOwoK3AltY8p8szT
 Fxq1PdDU565IFqYKq1jMQmBwSDMNBKjpeediHkpoVeYIkpt2nNOx0/Ni+NZzuMhQcL1CbqWwtl/
 OWkxu0iOcCop4FXNP2dBxHGILkoNF57xgZ3GV9owI9YhnjcWJZ93HXHOLxy98QypUzWvREh5Njm
 KlTKCj5YPXtXQU6tYQhSBfC9lio0VSTeN2R/B9eH0tXmyuOQenY77931Bf3964Xdr1kcGm1i7rU
 t8x1e2qnEaetMhJHFa2747ahtWAvkkSV3j7IgyCVPE4GaL/rUBqT5f2mNsIiFOVK0BpsI0YAMio
 D/r8b/5kp9Bro3uREaI+Vd6+KHuVG1fTI3owCpgXG+hooEA5t1MGZBA7CHxva1d/icfwL/7f1vz
 SaixBaECZcmDqP8lfyJRXcPPlZwXwVVfu00j365
X-Received: by 2002:a05:6000:26d3:b0:481:5b58:c589 with SMTP id
 ffacd0b85a97d-485870935eamr5326237f8f.10.1788505981160; 
 Fri, 04 Sep 2026 00:13:01 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:12:59 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 04 Sep 2026 11:12:38 +0400
Subject: [PATCH 03/10] scsi: size a well known unit from the unit it stands
 in for
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ufs-spl-boot-wlu-v1-3-59aeea16c4de@flipper.net>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5594; i=alchark@flipper.net;
 h=from:subject:message-id; bh=kMExhkVoLU68lJyI+tRYe7cIAaNxX/l9WO5DiW8YFtw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNyi88cI3thuY6prhr+r7qUsxTGU/bnJLWmBBp21WhY
 rdg5ubpHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx1RiTDPxs1nbYXFnNPX1XkX7Zc6+r2wGyFJ1Mm/7GZYXG0JP+JeDojw+rLt3Z
 Ka1e8Pj0/fNuK7n+xlW+2XCoVulDyLPs5++y5p7gA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

A well known unit can read and write fine while refusing READ CAPACITY,
because it presents another unit's medium rather than one of its own. The
scan wrote such a unit off, since it has no geometry to build a block
device from.

Ask the controller which unit it currently presents and take the geometry
from there, leaving the block device addressed by the well known unit so
that the device keeps resolving where a request lands.

Note that in cases where this matters (e.g. UFS boot W-LU) the physical
underlying units should anyway have identical geometry to be usable in
the UFS A/B boot scheme, so switching the active unit should not affect
the geometry for real-world use.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/scsi/scsi-uclass.c | 10 ++++++++++
 drivers/scsi/scsi.c        | 31 +++++++++++++++++++++++++------
 include/scsi.h             | 25 +++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 54afac6eaf51..ca6a16cd8206 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -50,6 +50,16 @@ int scsi_get_blk_by_uuid(const char *uuid,
 	return -ENODEV;
 }
 
+int scsi_wlun_alias(struct udevice *dev, int lun)
+{
+	struct scsi_ops *ops = scsi_get_ops(dev);
+
+	if (!ops->wlun_alias)
+		return -ENOSYS;
+
+	return ops->wlun_alias(dev, lun);
+}
+
 int scsi_bus_reset(struct udevice *dev)
 {
 	struct scsi_ops *ops = scsi_get_ops(dev);
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index aa7f9f1004d0..a60843e505ea 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -504,6 +504,7 @@ static bool scsi_unit_attention(struct scsi_cmd *pccb)
  *
  * @target: target id
  * @lun: target lun
+ * @wlun: true if this is a well known unit
  * @dev_desc: block device description
  *
  * The scsi_detect_dev detects and fills a dev_desc structure when the device is
@@ -511,7 +512,7 @@ static bool scsi_unit_attention(struct scsi_cmd *pccb)
  *
  * Return: 0 on success, error value otherwise
  */
-static int scsi_detect_dev(struct udevice *dev, int target, int lun,
+static int scsi_detect_dev(struct udevice *dev, int target, int lun, bool wlun,
 			   struct blk_desc *dev_desc)
 {
 	unsigned char perq, modi;
@@ -584,8 +585,25 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
 		return -EINVAL;
 	}
 	if (scsi_read_capacity(dev, pccb, &capacity, &blksz)) {
-		scsi_print_error(pccb);
-		return -EINVAL;
+		int alias = wlun ? scsi_wlun_alias(dev, lun) : -ENOENT;
+
+		/*
+		 * A well known unit reads and writes fine while declining to
+		 * describe a medium of its own, so take the geometry from the
+		 * unit whose medium it presents.
+		 */
+		if (alias < 0) {
+			scsi_print_error(pccb);
+			return -EINVAL;
+		}
+
+		pccb->lun = alias;
+		err = scsi_read_capacity(dev, pccb, &capacity, &blksz);
+		pccb->lun = lun;
+		if (err) {
+			scsi_print_error(pccb);
+			return -EINVAL;
+		}
 	}
 	dev_desc->lba = capacity;
 	dev_desc->blksz = blksz;
@@ -599,7 +617,8 @@ removable:
  * (re)-scan the scsi bus and reports scsi device info
  * to the user if mode = 1
  */
-static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
+static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool wlun,
+			    bool verbose)
 {
 	int ret;
 	struct udevice *bdev;
@@ -612,7 +631,7 @@ static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
 	 * size, number of blocks) and other parameters (ids, type, ...)
 	 */
 	scsi_init_dev_desc_priv(&bd);
-	if (scsi_detect_dev(dev, id, lun, &bd))
+	if (scsi_detect_dev(dev, id, lun, wlun, &bd))
 		return -ENODEV;
 
 	/*
@@ -677,7 +696,7 @@ int scsi_scan_dev(struct udevice *dev, bool verbose)
 
 	for (i = 0; i < uc_plat->max_id; i++)
 		for (lun = 0; lun < uc_plat->max_lun; lun++)
-			do_scsi_scan_one(dev, i, lun, verbose);
+			do_scsi_scan_one(dev, i, lun, false, verbose);
 
 	return 0;
 }
diff --git a/include/scsi.h b/include/scsi.h
index 2520a8b8fe63..72fb6e4bd90d 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -296,6 +296,21 @@ struct scsi_ops {
 	 */
 	int (*bus_reset)(struct udevice *dev);
 
+	/**
+	 * wlun_alias() - find the unit a well known unit stands in for
+	 *
+	 * A well known unit may read and write fine while declining to
+	 * describe a medium of its own. This optional callback reports the
+	 * ordinary unit whose medium it currently presents, so that a caller
+	 * can take the geometry from there. Which unit that is may change over
+	 * the life of the device, so it is resolved on each scan.
+	 *
+	 * @dev:	SCSI bus
+	 * @lun:	Well known unit to resolve
+	 * @return LUN it stands in for, -ve if it stands in for nothing
+	 */
+	int (*wlun_alias)(struct udevice *dev, int lun);
+
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 	/**
 	 * buffer_aligned() - test memory alignment of block operation buffer
@@ -336,6 +351,16 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *cmd);
  */
 int scsi_bus_reset(struct udevice *dev);
 
+/**
+ * scsi_wlun_alias() - Find the unit a well known unit stands in for
+ *
+ * @dev:	SCSI bus
+ * @lun:	Well known unit to resolve
+ * Return: LUN it stands in for, -ve if it stands in for nothing or the
+ *	   controller cannot tell
+ */
+int scsi_wlun_alias(struct udevice *dev, int lun);
+
 /**
  * scsi_scan() - Scan all SCSI controllers for available devices
  *

-- 
2.54.0

