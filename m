Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9FFC79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D0AF80DCF;
	Fri,  4 Sep 2026 07:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TlBXiBV_OMAQ; Fri,  4 Sep 2026 07:13:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5297380DFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505990;
	b=O4HHnWYgNm8/rXBgraruZeySlZes1992Y8MgkAfcg5Xcry5Fwx8LpFPVMt7Xii3/qljf
	 RXMVqvPdbpyTB977Rl0us/Ojm39QEL5/6Wbxi4fQdfSnTHCg476zkw/J7j5HU9uX9QqLO
	 Es+f9EJhvN6W3nuCJ2DbTzokp+n3cMTek9hsu27vGhFQLzVLAmeMbsqCLLG/WkI6yMLAc
	 n0Tycg5wXFqXcEAOuwPFFb5QSncs+2CSQnnmmqVSA2a0oJfWamJSWbgVfUZ2J/4BllIlZ
	 MUXCQDfyLbCKDEJxj93K5WDrr0MRq+2M9h8WAv0QXG7BMJF71fYuOAat3mRl/SXZXkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=noCc2/jgZYlNyEHJSgIWVAnlW8VXhiziwHxfH8NDmbg=;
	b=hRWke29Gzdq/otQDn9lGubF1oqsBw6T/hn511y09Xoehk0O2vOrJscODuc/AhU2TnVRq
	 j6te96W1cZNvXJx82shV8SwVvOHehBhNRSy5vvrBtb1EjTfpqZ3TWNhWkfFzmOeEYzQgQ
	 tQFHY5qU6ClCC9cvC3BIvixokt+SmLDg2KweKR4KTjbkl0ZmHLxxqR9i/4Z7a50EhO1zj
	 B2ctYxjjLJamZDLQdTWOCAkzoIpN7gIz3ns11tfPObwzVRNx+Vp7P+AiwpRLQ82Rni568
	 10dDCcCqWhPAi9lIK+x4wfb+dJiu6jZ6WaQ/sC0ikH+FVAfA4shY0lMQOrDOZ747SYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788505990;
	bh=noCc2/jgZYlNyEHJSgIWVAnlW8VXhiziwHxfH8NDmbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xAPFYZPvQ5RzjYhquD8Wk0//Paj2ShhKGMw924DA/bPOAJz3iir6MtlXSG8YZ1y6A
	 Tm7rtn4UCqWF7soF1JQdjVKVYBxnj3BUce0M7FHBvIhcIlGTe2Kbf8AEMu+z8JJgPL
	 WvM47H3y64Dzx3j0RcKps7WrEScX0C/4bVH/O+/HC7Sfhd853pdvphurVSmrsOyYnu
	 hjrPOuluSSBZO58fF0t3CDSJLXhCUBfizl7R4Cg1vITW4PY+3CbNX3pkrKcArWPcRu
	 TNayMpcqxT2RXjWzRv/FQ+YBCLWiYz6nqYxCP1yiOqIfTEf6/I2mmPsXLv3wWQV3IB
	 IUg1cBqxXJ3GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5297380DFA;
	Fri,  4 Sep 2026 07:13:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A6A4A2FD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CAAE60BBE
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dK-VDLUERbol for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 97B3C60BB6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788505988;
 b=g3gGP+9WXLpX/istVkQZG1SCqVdJ1sUQ0kEGXfEBKX3OcL1X7hWp2Q0gkpQlcZTvWEM5
 NTqdUdjyXsTmWMr071gWVT6qi6gt1NR1uhe+5CbsqqDPLZL4lL76Ru0CHkWNolDQbQQNi
 37BfZq26yfc7dvGs6wp3v/ftQy3HhRqyJ3xLVSpCqFKHbvi90GrIRRTPnDgrlJVZDatVV
 zKQCm44q21gxB3LzJhOiD8wP/7UxuNPPsh+6Esu8+oqgmgOM7ZLhchIaaKiJW9RtUFiZV
 FV3BgWASDdfsaZkEz+aAgO0LFk4G8dzgo9wiN/JPBncOACeUO49qznluIdrKumkBVJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505988;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=noCc2/jgZYlNyEHJSgIWVAnlW8VXhiziwHxfH8NDmbg=;
 b=Pq9AeuE+CEfTTendRtlLwyihVsoViKzPJThUJDU+QO5qeNcVG3EZuADU6PIUFtj2nYlT
 6gLScvFylZnY3oBjB2t55YABN9FUIR/huO9W2ZkQSIGyjXTsfMu2+dsUErNXMDoBrcHEa
 Zj72YEVGC65ca0ZJdk5vkY40i+yAFclbAeoYOUXekiW1FXno/3/1qpY3GImHb7JUPvNrk
 oa+8Vehm5Jb8AeOWba/faed5Cvdr+jmqLgQarbBnyxJjBlLKNWxePn35U86HcMl0u0fm/
 Tm8F2QwUnuOloHANHgYpm49UWO0XokuJ/ZQPbHYN+Cdc+0vgpdfcMrQ+MbAATZFGdpA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=Ljv6G4kR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=Ljv6G4kR
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97B3C60BB6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:06 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4843efcbdb2so369031f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788505985; x=1789110785;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=noCc2/jgZYlNyEHJSgIWVAnlW8VXhiziwHxfH8NDmbg=;
 b=Ljv6G4kRIN6vwG4uP4ApbNmTZn5pl/M0xTSc5MF4ksK5jfvInRBocgXJudUxrfHP61
 psUOsiucawItXFgQ5VwOIX14MBkMTELXkttCMCUjpX2dLj2LXP+m/7L4rgKpIKDzYXN6
 mtgw4e7qy0QOJNFoijEDfx8BDGxNBV785V2jp5U/rWKZxtigs/Fkw9lCdZtL50lJHmDE
 jtrOJL09PNFTUTd488M1R8EhvR44y4udIvw0raBFBfZsf3wS57mIE6x/7ivSQLLnrLnI
 9oWAKufELEKMyNb+p+X7//8FgAtFsMsG7lRpHyV7ZRWc0aBtz44DyvVU2NesHeUFEuHt
 0D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505985; x=1789110785;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=noCc2/jgZYlNyEHJSgIWVAnlW8VXhiziwHxfH8NDmbg=;
 b=W01IJulXs5HXohaeSuuiYDJgsuI7m59zbrcMa7l43gACvX9o3ZSk1J+9heXI+F1EWF
 JIeSGhMVW4jNnvUpnHN7ctcPzq/AgXqAHHdUYmuMYyWgIwLVA1i5k2QQ6Ec1MQQK5/HN
 gLcnt97iYy+yv7YplKpwSkmrW+FT/ovCjdcdx8qvqq4xF2EQDDMoiBoBLXPLm9q/GJs9
 Aplh5bYbO2Ylt6aCGtbRYyqYXCL1VQEpASFyiVon/Cyb7i4KS/GSNoXk9VVSPiW9e60k
 GpA0FwtnYxPBQ48e+eE1eOQOTBUHhz91XMBmTQ1S3ww9tN2KQpL54R/C9hnyDWE8BuKM
 wueQ==
X-Gm-Message-State: AFuF++nR1IfcZ7bqV5Kn82Y7dz8KUKs4FaYmDF6zYPrqiTDVVexd6Lfj
 29Q8soaDpX49bpFJADG9ltfgQT0KlyVr9XtpoaG/llXOgkuQmIpk4OSJVZbisueVg14=
X-Gm-Gg: AYBFou1OFkybDuG+KWnnoI50wfgHcHNKuWHsxuosKyu4PvBYHrKFLRKjzoj9NlA1LHk
 5ptAIJJ5/hjH59pNLYaEeytzQFnzW1dho10LHZlYcx5n4ceeUkFC+9Qii+rwn14bwE6OQ9w4Ham
 IIAqUmO72lTb1bLdy15D9IdKhZGQcWM/0KqtwbucsS29P0dy7B6wLje0JibnDaQJ24VBoBqBABu
 FpjO8dSh9koJOfMrLn2Gr3ispD2eIK4rYzzPHU4RrIglepU6Ohmf2kr9fm3QyinMqudv5w618qe
 BjlvRNLoHWCXk7WGcbfBbmZGAyZVMULgl2ZGGrWqxpIuH6h6IaOGMUJ9e25DFojGFSFxN079ghP
 8HqdA1/4ZDGMtnQQyeFlfHTe8vLtOAX4joL064SAFgmJQsG/RAMkolc7gthTupGAU8eLChrLYeW
 JMtH+JY03MAxiHFReVbUXvX6H4zG64yA4XAPrukvo2Ys0LmIiOkBdFn6vNatC4hQc5Qdg9MR59O
 9ga8AtLzMK7iawFrh8TvcSavbTxSQ1jVqBfuvAz
X-Received: by 2002:a05:6000:240b:b0:485:8a47:5b8b with SMTP id
 ffacd0b85a97d-4858a475d06mr2248915f8f.40.1788505985048; 
 Fri, 04 Sep 2026 00:13:05 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:13:03 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 04 Sep 2026 11:12:39 +0400
Subject: [PATCH 04/10] scsi: allow a controller to declare well known
 logical units
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ufs-spl-boot-wlu-v1-4-59aeea16c4de@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248; i=alchark@flipper.net;
 h=from:subject:message-id; bh=jE+xNtL4IuFnMA+djMBfx+nr2fAsF1NdwVGZC0ijtIA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNyi/anj+R8fIPx28bl2bOrYwUmM+8SbLlpadujtiUg
 GOJ7yae7pjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqPT0Y/lf92vDn27ObstrnnpkzXb/Bvv3AVVGm2QsFLE8cco1876/A8L8u/XV
 HvVKMwanakCMMInHnnfW7pr8/s60wdNfagA1zeLgA
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

The scan walks a contiguous LUN range, so units that a bus places outside
it stay unreachable. UFS puts its well known units at 0x80 and above, far
past the ordinary maximum of 0x7f.

Let a controller list such units separately and probe them once the
ordinary range is done, so that block devices already created keep the
device numbers they had.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/scsi/scsi.c | 13 ++++++++++++-
 include/scsi.h      |  4 ++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index a60843e505ea..55915a021864 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -685,6 +685,7 @@ int scsi_scan_dev(struct udevice *dev, bool verbose)
 	int ret;
 	int i;
 	int lun;
+	int j;
 
 	/* probe SCSI controller driver */
 	ret = device_probe(dev);
@@ -694,10 +695,20 @@ int scsi_scan_dev(struct udevice *dev, bool verbose)
 	/* Get controller plat */
 	uc_plat = dev_get_uclass_plat(dev);
 
-	for (i = 0; i < uc_plat->max_id; i++)
+	for (i = 0; i < uc_plat->max_id; i++) {
 		for (lun = 0; lun < uc_plat->max_lun; lun++)
 			do_scsi_scan_one(dev, i, lun, false, verbose);
 
+		/*
+		 * Well known units live outside the ordinary LUN range, and
+		 * are scanned last so that they do not shift the device
+		 * numbers of the units before them.
+		 */
+		for (j = 0; j < uc_plat->wlun_count; j++)
+			do_scsi_scan_one(dev, i, uc_plat->wluns[j], true,
+					 verbose);
+	}
+
 	return 0;
 }
 
diff --git a/include/scsi.h b/include/scsi.h
index 72fb6e4bd90d..fea2d0152098 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -269,12 +269,16 @@ struct __packed scsi_write10_req {
  * @max_lun: Maximum number of logical units
  * @max_id: Maximum number of target ids
  * @max_bytes_per_req: Maximum number of bytes per read/write request
+ * @wluns: Well known logical units to scan on top of 0..@max_lun - 1, or NULL
+ * @wlun_count: Number of entries in @wluns
  */
 struct scsi_plat {
 	unsigned long base;
 	unsigned long max_lun;
 	unsigned long max_id;
 	unsigned long max_bytes_per_req;
+	const u8 *wluns;
+	int wlun_count;
 };
 
 /* Operations for SCSI */

-- 
2.54.0

