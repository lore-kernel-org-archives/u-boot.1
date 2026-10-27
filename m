Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC2606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p8CGlHBA;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=gdHuwC7x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CD3480DA2;
	Tue, 27 Oct 2026 14:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJrVcat7SIVq; Tue, 27 Oct 2026 14:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB7A480D7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793110633;
	b=q07M7c2pOkpcCVR+nH4JS1GE9xUy3wIqRSs9uZBjulGSmZFKqLCyaSjEid2xJ0xPBL5Y
	 J3Lpzws4n8YyMRsaUdGNQcMqU1gpOWpjHZY/E24hcP83MD1XfobHv/xF/OodV10xEQk7a
	 MEYZMeXvwCwvTzhuqkoTBUSKa4LLmfEOhkPfLOPX++e3o3DiN4PcXJTul1T6zamF8h9oq
	 UzC3b4bW2rD1z9Kh2hSJ55jGyCoptXqEb/ZiyuWYt38hcy1+e9kCT3JNn2eRHdiCWbndT
	 XAEPfFUgTYW3wCUoB2e0/9Z0NBrY5uolqMeA5bxzNIJeYY79JRa/Ubo7PTKjnDTd/Ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793110633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=esMCluHsdBjpaKv4umyrhz380ta4hFJbwTDWZVQOoq0=;
	b=rgot+We+7qfBydQyauS6MIAqCTcI5WUj40xI/krOmm/ddpQ16ALS9fF7+Y/YM48dFTPv
	 oNKk/Wu8ZO6I3p5kF2niJWvZhwHUDfSbCybs9XdbOqO72c7NV2mUbKrJpNsSHIrUfOtwe
	 7dlmBbyzw8I0Q0ZRG5a5aMlhRo2w1j2ugEWOqti1ZuajONyHvLOVSTTaBTAtm0Ot9WTbL
	 s9oYQHZFu0OPz66yMuILW27k8MGihNlL/abrzigPaNZBl9UcMqGzxiZgtpPUhB2O7sS4C
	 55pGuWY8oRHpC3ZQ+MVPvp2Wfr2ob9uSwe9qRWa+0JbU0BRiGQjT1mrYg3aNVdfHJSw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793110633;
	bh=esMCluHsdBjpaKv4umyrhz380ta4hFJbwTDWZVQOoq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8CGlHBAgVOv0FqazDU5jqg+spo4OoZqJv5adpXDmJ02vYaSQh9viSn7ff2P9g9hc
	 MBzicZVitJPcYd3kKt9/xQq6IRyui5rKl3SHrdeLelpKujJShYRcFnlVs3MvhiHDvY
	 oLaKU+NayHswgpxIWBm3NT8lgbxNqtxjzUogatly58rBefm/7B5acWU43m2Dt6qE2L
	 RwlMvQr9gTyi9sHWzzIw55bkKNl6cfSCb/J5+6NeFDKrUrwJjhxsWnDRxTSaHO3B3S
	 PXTj1pH2Q0UmnLzOpeAtW0AJsuThkC+2Zxsl5EQSLudm4ROOq+Efp+YwXg81IS2UhW
	 CF7jvfP4EO+7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB7A480D7A;
	Tue, 27 Oct 2026 14:17:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6248279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7EC24061D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EDnIMRfvAJ0h for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4BFCA4063A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793110630;
 b=mWFwk0AVvqImJ4Ac1wCcPhZEVViiUOL48+kFUDLQS7gh7xN1rjNeCjn/epvy7jTgiJVf
 DRSY6nz4NRlgwwx8PSEQ3SBuZVptESTrDX8/1npsrgW5DF5azPsGxTHqBLiY0PGXJHGui
 s3csrNaPcDJ51uIJIgjcC8c9ohnOgXoiplaGgXuBxTNGyZBxpol7Me0fII7UFaRrZ+vqR
 SSUqm3WQeajSdp7BweAOrspkhvpEX2Eer1xVC48qLgCmnJ0R4q09OfW0iTNjNN6t0FKqr
 irrQTnas+1mG+jjPJi4D4C0HhHHQXKlmO9Rf8WgkGRN0yipoBUHtU41Jo4gi0qtiqsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793110630;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=esMCluHsdBjpaKv4umyrhz380ta4hFJbwTDWZVQOoq0=;
 b=Pe8RXA2wzEB3cyvHnR7IKNxM96QGFudjxI325xCWjHi5/Tsw2LRscbzSJtgjSNwol4gh
 ylKh9FfC0UbEFsJWT7VQO+tBwqnuMhJrwS2LyqTIQECv/8Tyuj5m78MKvHxgvsF7N43N+
 FfKZa8zXcVJjMsCi4toJNVXO9NlhgJHySBMMKGjM+/RxsxU+T3MVmOW6OLrvaTh/3k6Z9
 Pqf7cRVXduYxvTR8x4T3J8y46UrAZBScDwlchbAHyvrIsoH7x0C8XW00+tjLZS3mGZRp8
 3O/YI2cKPyiaS352cRqVtKm8RHt8GWKXAycGddIqk2r4mtgbK5wdRcUCXGJtc/xLZuQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=gdHuwC7x; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=gdHuwC7x
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4BFCA4063A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:09 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793110626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esMCluHsdBjpaKv4umyrhz380ta4hFJbwTDWZVQOoq0=;
 b=gdHuwC7xDHWE3wFvv/idqp+VBcuajYTFtexVuALlf0vJd7CEcGQxnvsL58PH2AnuRqjCHl
 L6Bzt6v60kO4ukVRyAAdRNixzTxAIWjcafjSfVlE/GGGg/2Bs9pnMi2Mrm9I4WNt7SVgpt
 x0uAF5PtFZd+eIoR9ZJVRHbAEI06M78qePym5+N2yTn3kj0zvB7A/WwDTUYCBJef1MTKP5
 jK3vdrX8LqyujZ4Z1wUXURi8gK12bOONdC59NqEGcGaY/8lQ/HgO2uk25aHkVXlrnCsZhF
 o50l5t9kExbDJxKMc8PYPbQ79u/kAM7NN7LzUHanXmAOEjHwvIvytYRnZFpzhw==
Date: Tue, 27 Oct 2026 15:16:38 +0100
Subject: [PATCH 1/2] blk: Unbind partition devices when removing a block device
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-blk-part-unbind-v1-1-e44d2b48ced0@kontron.de>
References: <20261027-blk-part-unbind-v1-0-e44d2b48ced0@kontron.de>
In-Reply-To: <20261027-blk-part-unbind-v1-0-e44d2b48ced0@kontron.de>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=Ezuk7YvzAEUBIeR3bQpTYD4G/AlrCSXTtp4DotadNTk=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevBpkSVgxdC5lvES6dc1ZsdJVjyXCzyQf7Vs31ztXQ+P
 PX8HyPaUcrCIMbFICumyCLFb/Ha1izWR/5YdRTMHFYmkCEMXJwCMBHvL4wMl1wNwkNilGb7blth
 vlsvX/HBW+brvc+n3GOIXDgp46XaO0aGJ45nVMJXf1v7zeXO/NQfBsofxRysnxQplBmJT8+p0lN
 nBAA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

blk_post_probe() binds a UCLASS_PARTITION child for each partition
found on the device. Removing the block device removes these children,
but does not unbind them. When the block device is probed again, a
second set of partition devices is bound next to the first one.

This happens for example when the probe of a block device fails in the
EVT_DM_POST_PROBE event and is retried later. The EFI disk code then
iterates over all children and tries to install a second EFI handle
with the same device path for the stale partition device, which fails
with EFI_ALREADY_STARTED:

  Adding partition for mmc@42860000.blk:1 failed
  switch to partitions #0, ERROR

As every further probe adds another set of partition devices, the
block device can't be used anymore until the next reset. This was seen
on an i.MX93 board where a single failed read during the first probe
of the SD card made it unusable for the rest of the boot.

Unbind the partition devices in the pre_remove hook of the block
uclass, so that they are bound and unbound together with the probe and
remove of the block device. When only some devices are removed, like
before booting an OS, the partition devices don't match the remove
flags and are still active at this point, so remove them first.

Fixes: bf76031d19fa ("dm: blk: add a device-probe hook for scanning disk partitions")
Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/block/blk-uclass.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 37d87be3a57..cf6357d3041 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -841,9 +841,31 @@ static int blk_post_probe(struct udevice *dev)
 	return 0;
 }
 
+static int blk_pre_remove(struct udevice *dev)
+{
+	struct driver *drv = DM_DRIVER_GET(blk_partition);
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(PARTITIONS) || !blk_enabled())
+		return 0;
+
+	/*
+	 * The partition devices are bound in blk_post_probe(), so unbind them
+	 * here. Otherwise the next probe adds a second set of them. They are
+	 * still active if the remove flags don't match their driver, so
+	 * remove them first.
+	 */
+	ret = device_chld_remove(dev, drv, DM_REMOVE_NORMAL);
+	if (ret)
+		return ret;
+
+	return device_chld_unbind(dev, drv);
+}
+
 UCLASS_DRIVER(blk) = {
 	.id		= UCLASS_BLK,
 	.name		= "blk",
 	.post_probe	= blk_post_probe,
+	.pre_remove	= blk_pre_remove,
 	.per_device_plat_auto	= sizeof(struct blk_desc),
 };

-- 
2.55.0

