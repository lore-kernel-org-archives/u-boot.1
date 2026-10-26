Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829A606A325
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sw1oDHuT;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ThxlFhci
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDDC04058C;
	Mon, 26 Oct 2026 09:24:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Vo3Tb6SwkiW; Mon, 26 Oct 2026 09:24:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FC0940591
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793006683;
	b=HP0aCueNI9dXpVviORy44FFPc67AekflZCrGVqeei6eJx2IlH0KykaZEqhGN47kVkjnu
	 +XgAaYLhHCsEK20xGEGPsNdffguwLEIPrC2gOZvvjieQxEEcXZobYn4POn8iJuPyC3wIw
	 yW1B86mhXKYsJqxug1l8aXeUJioH+zzV1CevrYBqXGMvKUucTwWX08cNN9Jnuy2HoRnMb
	 OwNmnbt38S/fRUxs0MPUBZHHfp0wWEX7sRvucHonGYb8OrarIPhnvKeTMteVW0/f3D4MW
	 ZZWJiZWIv5WFxJqXj4VIqUKifMJUobN8LtIiB3jPWYjGmRDzmM+CFGOGUCAeu2R+LYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793006683;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5faB0VajbRYDbpAzksNSSGC7+nKbZcUg/WSSslU9POg=;
	b=M7K55TWGc+vxwdnn2M45j8M5MO8sq4oPvdlRhni/Q2rl3mL7vlx+OXz2s02H/0FvCYqC
	 8lHvwLzf55D1R6cwoWbu7HV3/TQrnQqLKyjv2PcemUc6tCq8EvstNnwba3yUuW3XmRL8a
	 HnPA80qkW93Q7/lvYZUUOXqRxcJ0D8M8FMGkECpy/hy/M6OWfOwUyWfts7hPG5LFRSpUh
	 BCxiU4hVsdBHE/ceIaTxRDJwEimoouf1ERxKk4bn1IlidYK1xS+keu/ERL3BcffI6chBZ
	 ZWXXqgRqhWutm342Vt+pNlBKwSODYRGBOU+4hrsPIstQGQdZb9FGkPQC7gcn/BDY8PQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ThxlFhci;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793006683;
	bh=5faB0VajbRYDbpAzksNSSGC7+nKbZcUg/WSSslU9POg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sw1oDHuT1u1S3av/AX5fI3V3rzwV0hos7hmrIDoXjljb3r8WqU54ucXCOrNBB4lnN
	 cMSA7bsJ2c0mf/x9/Af+7ntuAnD5K5Q2k2gB7A4rPFJAcMgWxj5Pfqvwjnu6983uOt
	 lU02nSts6YPRPOqh1qbuketqs6by2Z0fmWh/E3bhtENqgAb0f1WHewOJjnJ6BGtad2
	 Ddm4icTyWymBO0Qosp2hv5v66csgMvdhKsyjO30WLze/GFfd0cDSpRns4cxIAy5UfX
	 s4rTyEj52FshQn/5Ivq2zTuhjCEnEiLALXshKwLevTryG01cXU9k4wBex1Wkv/YjOq
	 RXXnykqFv3ZQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FC0940591;
	Mon, 26 Oct 2026 09:24:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC801235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2A0140591
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:24:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C_KqZg4cgJzQ for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:24:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2534C4058C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793006681;
 b=P79BYge4WlE/I8SFNHXqhnIvhl9fUgaBUB4Ib6fONO/+xnJiDpaHDK/Y01vXcp+/ljF4
 OkcD7aBzsyycUoY+XPtRodq0X/3yTbU5dGIZHUqYVUQhmZCwcZOlrXWVDnymhhecXWoRy
 ZQleCeqzEiDqF0Jel7aP09Ego+ZIH1AKFSTHqKArsV7EnOsk4nSWq0sIp/PMM9W6Et88d
 sIfoklunKotWnTSJllt7Ywli2O2xKv+prsYMdXO9skIcOGj0gaASawTzBIIKZtMTduthY
 ZJuKYHCH+0xYY1PeKVt5mx5xfMHROgW8HdPADFGKt5pQilGacEOwp/2Tk4+eVOt49dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793006681;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=5faB0VajbRYDbpAzksNSSGC7+nKbZcUg/WSSslU9POg=;
 b=ATswEtGhnc4aE/GgEqIeWrKPO/Eq1qyncGBZqyvL66MkaY0usQkMf1RpVUvERv4VQZwp
 BJMP81Die/3MNAgC8GLuHpEk/k+uO47bztuNSk+5PQD82Ib/1wLqAaK+1BAWIVYiTtLUc
 hzElHw7fapeWZKgIAyOMk1UJEqvg67+I0K6NdNAVox5ZTt9vheVQjLfFK9Fe5C8bxReQI
 Ta6fomICfHf6UI7A8vlBrojwrsrTOtAbQEfKspCWrq09I/28q/wRxp62rPcZhcSIp0RiN
 PyF3Gj9p+YZe9G+tuoKgpenBDnIWQy+KhaKLxr3bFYC0H5jjV3e17U9Nc2jrLxRQhRw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ThxlFhci; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ThxlFhci
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2534C4058C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:24:40 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cd6acc50b8dso851332a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793006680; x=1793611480;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5faB0VajbRYDbpAzksNSSGC7+nKbZcUg/WSSslU9POg=;
 b=ThxlFhcii/OP2kYmfCjBIL1u+TwNpDsMeeQ6LpgVwtx/rl2Z/nqDqMK9jw52SDtuEL
 woil7W+ffjOns6uI4KIWWtyzPgHpffOAIr2+Z9ONHCy/BpqW1nRlMysIdOWCFTR31SZK
 /QbUJ7lNr30y9YSx+CPk4aqdRr34KXV9cosi7X/UrbtZyUs6Oy4JyMXPiekhtNTEEadB
 HWNaVgwX3HXRsifGfwjcQxUA890dcFrueLwy7AweeGY7m44efe0LVfOFfzw3RH/xW2Sd
 AdbbC6HAws343H2oQCl5SASQOVLcNvGT1AbtvNdQkGB5iuoLfcR4ZGVNga8UT0pT0uc7
 ZWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006680; x=1793611480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5faB0VajbRYDbpAzksNSSGC7+nKbZcUg/WSSslU9POg=;
 b=ev+o8F5HdZzpq+kagKCgt1rs/nB35DYqhtJIzxv1XJSBOjB4XrCZeD6pj5PbJuna2V
 5M9tOpaNaxdDxHbtbJiqnhFcXDf6dATinL7KiosMLXnVHmexJtUP/3fCYksEDta6MSFH
 ws9J+jZtOiaufWLqhHt/kd1+vvCvUhvCeohTemU0uN96CJxKNw3/BSqby3+lwBPqIc2J
 0g9C/b5qxNaPzhclwGMEUE85+z3MbLptnWVqH6qGa6ANuqltoj23XUo03L+dRA8s0ehG
 b3i4BJdOdvbItB0mmnSKHxYfDcWDYb3ZjCS/jcCU6V/s7lrIzO4fAjV1wtg64rqr87S0
 S5xw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8+UasEP2OdOnt/ztBTjjnfVuWBCTPaJ8vLZTyb42EVIjWzErdr6lBWZDGL91rEuVILvxdSd8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJoS00tZTa1D0niwhBM759x1vZOy85ySWzHVDH61vy3uLA5J+9B
 ZudAtLyL96F/FMveFioK5JujynZ7bah7B9pNhHYC91ZLTS0y+XHJDfvV
X-Gm-Gg: AYBFou3E++AwkPdBUxj+1aKDovWES5CjrxgteOVaW/6Pyvh2hNQplKU/V2zZv23uOAF
 b1GT8fv4FdK+2v80G8n1a1XLEKjGQMOEHwS1yAjrshSIz0uQVo0VDUU77kd1ulJigh/WiksLbsi
 3biPPsYH/c++lwmAndpUGgoizxZaSE6GmLiryxKqMeaXJGlydPr1xIbcoxJ9g9Tw65hqEGiubBA
 Zwt1GMX5cpAAVNzzGMLepCgUMLv1+i/VnNlU+xzRvoIf3ouOXShsqQraf1ZZIh5S8KcMxZKwQDr
 UoQBLpLIA6bTq0ookMCVQL7qk/mmsafStwlzUx7GZBysTfZp2qXjxPgiGdt5payWnNcUk5dSmVQ
 v0qqk/a3C9s116+oLr6BZcRiIOD2x3YOu3Nuzx09xrlwi9t3KTndDTcyGOTa56Tf2MOHKIGqrT5
 d4lFTZdeCRCHHTeJYnbPoCDbfmJ2aCWeX1lhFoELZNHsRGeAn5tnLyKJVlYTaAX6kQLKHd9dURc
 e/4vHax0AH+665nSXcc4Ox86Qp/ssdyD2BS04y6D1523njeZofTD4INThiQtp48mxHFLb7RujPL
 y69ibR94njrQ531MXvA+YlnFOAl5pGRvVHpu0RLs1m+ZiL/7gkXEX4rzUKU16NpcVS6o0zpSKoG
 aXHf3GAS4pd6y5sm+l1n1XRq4qX7E+9SoW5P7
X-Received: by 2002:a17:90b:1b01:b0:3ab:1b1c:8a70 with SMTP id
 98e67ed59e1d1-3adeafbb11bmr5066338a91.38.1793006680222; 
 Mon, 26 Oct 2026 02:24:40 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccc2268fsm1437353a12.7.2026.10.26.02.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:24:40 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 1/2] usb: onboard-hub: Add support for VIA Labs VL817
Date: Mon, 26 Oct 2026 17:24:31 +0800
Message-ID: <20261026092432.769146-2-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026092432.769146-1-alan.tseng.cs@gmail.com>
References: <20261026092432.769146-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The VL817 is a USB 3.1 Gen 1 hub controller with one supply and a reset
pin. Use the same reset time as Linux.

The Milk-V Jupiter and the Banana Pi BPI-F3 have one in front of all
their USB ports. Without this, U-Boot leaves the hub unpowered and in
reset, so no USB device is found.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 common/usb_onboard_hub.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 0684f7bfd..0ed70a6ba 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -289,9 +289,21 @@ static const struct onboard_hub_data usbhx3_data = {
 	.supply_names = { "vdd-supply", "vdd2-supply" },
 };
 
+static const struct onboard_hub_data vialab_vl817_data = {
+	.reset_us = 10,
+	.num_supplies = 1,
+	.supply_names = { "vdd-supply" },
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
-	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
+	{	.compatible = "usb2109,2817",	/* VIA Labs VL817 USB 2.0 */
+		.data = (ulong)&vialab_vl817_data,
+	}, {
+		.compatible = "usb2109,817",	/* VIA Labs VL817 USB 3.0 */
+		.data = (ulong)&vialab_vl817_data,
+	}, {
+		.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
 		.data = (ulong)&corechips_sl6341_data,
 	}, {
 		.compatible = "usb3431,6341",	/* Corechips SL6341 USB 3.0 */
-- 
2.43.0

