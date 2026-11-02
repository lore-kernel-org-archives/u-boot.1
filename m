Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B8606A327
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZSRdhGqh;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=PjAkCQmR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FECA406F6;
	Mon,  2 Nov 2026 09:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FCwxkLxzis0; Mon,  2 Nov 2026 09:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AA1DB40748
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793610254;
	b=OEzp4A9Mvi8tcYKjKwgCDg0lTbY1SG2h7umCCZRUFxG5aiXt8+KLFoPXUnNxkmbIc/+t
	 DmEktemFc4g8TnTcskdrdQ2jHyXqMmhsNWVnObX1cLvuzkZDe+AU4srLx7RSPNVb1dHLQ
	 AWZ45yAAolAcCV52TGiVMlMwbqY6bLofNb/G+fkVgix3kCm5JVNICEpAHi9IHsy/gtsJ7
	 DL7E7Rh41ksw7NezrPTASRihJoWwo6q8/s2FlHOgAZSMb7cm8Jo4bHtbQ9XGa7cRgjfi6
	 WVfJMo9ojuxZXhG+BY8nH5V0zwyBgW65ZCYFaW/cEzo/wkDdxAVlcJbyUEFFwu2CT/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793610254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OujsK+fQICrMrhk/pt9m+qbizO9oUOhN4pQnBZR9LFo=;
	b=WcHnJwNpBNtAy5raLSSlikTghsIVNHEyeiREV0dyXni1d2ljrsQSUdC6e/HY1fy6NyD7
	 kDe0aY62bUSnT8EUSyfELwNrbMoHJUxl6AzwsU90Nzz/bSpdgwEdozqQQ49xtjZWRIC2Q
	 Ky3U08FkT1OkPAiyizG3xyzXp5irNId9Ja4TTK4szAEuuKRv8qg21oRQkQH4WM1UV5KO4
	 q39i2dt+Gk4bYuKcYiQIPdaXjXBKIrF8HznkrnGAFB99kgXpIsluc/C+gmxIye9x5ugju
	 VLjIawqRebg7A8F4hRGqYFahs+6oq10t3GC2rUFEHpZvYPU1XYcSJS6vI0O/Hs2PMxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793610254;
	bh=OujsK+fQICrMrhk/pt9m+qbizO9oUOhN4pQnBZR9LFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZSRdhGqhRR8l7J+IgE/FR/gta6XnR45mg6oWuE5l3zcmM2YjiQrYvrXj5FDAPD6ti
	 7Z1F1el3yojlM/eM3Sznfc00yOAk9VUdWUw2GZgW4TbsZouqCsh1tn0/WdeWlBcFd9
	 4SO88gfkmyP7+HeHgyaYccsg3aNVpWan5LqbNVpCPfopIjC5fPoWybMugrMRb7eWyl
	 ksUnPYVVrcKJAf9dE5n+fcFB6/xhincnIq3pMbQx0S0xLFjSYxiLD5NPQFN3DBtzsG
	 +zKO5o7P6JVR7bf4bIuvQEC4OUb/dxBTMPdTcEQ5MCB6i+XNUS8bzdGk+kJflwP6Rh
	 ukcqTtXWw2ucA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA1DB40748;
	Mon,  2 Nov 2026 09:04:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A7CEBEF4
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89C1480F66
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MwXSbJzUTq3m for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC32680CB9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793610250;
 b=aGSSA9nFrj72u7+Ql6DUZhP+rV8mLzzF87cwRzF8s1khFGjRnjf3HjxKupz2bLnhr7Wh
 yUZNL31vjBvaOEvHN8iui5GaU8HVxvZHjanTai5YQczzN53Wa/Q28q3OHSMQFMf9waISk
 3Sv/NjyP7z4nsKDHQctGQUWyiQSR/Iwo7NaW8zNOVLCU340ZO288MlpVdlGv0Iz/LMP2e
 iiPLz7Up3nwyJJ4XKsSwEXjeUgLWip03P3+7GaDqUa/8C8sXdE8YB9e9ZCyh1J3MmUdur
 VJDj9+m/Wp0747zDeUJwxEiSi2MO8UIvingNs6KHiZ1HRVJmGcAoYhE4ayBoyBPz4nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793610250;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=OujsK+fQICrMrhk/pt9m+qbizO9oUOhN4pQnBZR9LFo=;
 b=cTne6gpGZ/xB94qsL9+QC5mJ5Rh+bQg+ZC3D8qOl6iFi5e+YJnw3vqLVXRsCV5qcgXrT
 M46ywnS44opIW0dvCASuPVv7PpRRZlGA//n7WJIuQzlD8H82uFHGZELAixZrtSMSp5Dym
 MOytTdmk5fmtO40jZnjjHZZBdaGmdqoPlaG9EeXJVaqjDbqEQPNvCyAAalX67b0828MVD
 0CA7GTRzPv6C8xaZuGlrE4gJFDDZt9e1IBEaqm9POK1NQgs4y4/tnfqO/2qbplLTO8Ucv
 NCeL4V9dt3FUg+MKDoyyTHV7DfKpQI850PzcWa04amFiyr/CR+D3VmQw4Wrc+0kcJ9w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=PjAkCQmR; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=PjAkCQmR
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC32680CB9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:04:08 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793610245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OujsK+fQICrMrhk/pt9m+qbizO9oUOhN4pQnBZR9LFo=;
 b=PjAkCQmRlFyjLPsI7eHiokelouXlJSoTBRTD60QpyoKgqsyqGJ1NIfUlszl3sUIFnJJQqv
 nnv4iOMwWubzPmt6WuY+i5Ps3MgwnsVt6zlhcNg/GAniu86MLo/w1HuMiNZZmxGa6un3Yz
 q779XsEUrJgHeJ1pAQBQJEdnbokIAM3gE2IHkdLgw8vNK452Kn+zttwpPFYH1kWSiZ63s1
 +VuLVHrpQNYPVC24/G/A5G3zrJa6IskX4gD/cmZg6Vs7OB8Vri7EvJ8a7hhigvUIzR9eBO
 BSEKaTp2oDJQTwVhw5743pvS5zPb7SwkBeIyEvPE5zCNG1zPb64pYa3X7fDvWA==
Date: Mon, 02 Nov 2026 10:03:47 +0100
Subject: [PATCH v2 1/2] blk: Unbind partition devices when removing a block
 device
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-blk-part-unbind-v2-1-d0319d20fbfe@kontron.de>
References: <20261102-blk-part-unbind-v2-0-d0319d20fbfe@kontron.de>
In-Reply-To: <20261102-blk-part-unbind-v2-0-d0319d20fbfe@kontron.de>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=qcp+i/HAe3dvmuuMSuJFJDsrSDLfNUE4nFxoEWFHrf4=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetFEEuTzkR7ZyfPOV9jWh6u3XAj8a7+Dl2+pFDP6tVKy
 /7838vQUcrCIMbFICumyCLFb/Ha1izWR/5YdRTMHFYmkCEMXJwCMBFTWUaGB4ud8/79C9Rzu3J5
 /7bkMsfG+gPnH77XfzTN73a93IuzVxj+8Ng+XyInU6W8Ur3FJl76bCrD97enPKqKbH1XhLIuzel
 kAAA=
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
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
remove of the block device.

Fixes: bf76031d19fa ("dm: blk: add a device-probe hook for scanning disk partitions")
Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/block/blk-uclass.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 37d87be3a57..41b4f192c9f 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -841,9 +841,22 @@ static int blk_post_probe(struct udevice *dev)
 	return 0;
 }
 
+static int blk_pre_remove(struct udevice *dev)
+{
+	if (!CONFIG_IS_ENABLED(PARTITIONS) || !blk_enabled())
+		return 0;
+
+	/*
+	 * The partition devices are bound in blk_post_probe(), so unbind them
+	 * here. Otherwise the next probe adds a second set of them.
+	 */
+	return device_chld_unbind(dev, DM_DRIVER_GET(blk_partition));
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
2.56.0

