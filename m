Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B76606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L0eD3LPb;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhKrrRCy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79B0F6088E;
	Tue,  3 Nov 2026 15:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5w07sbFThckb; Tue,  3 Nov 2026 15:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B17B7606E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720030;
	b=kgUvMGgg95TVHxHOldYWo8wYFrbK7JH0T20os7b4M6K7pxS9OftFkPWEOMaLpiH2mIE2
	 xsUvZYS+nenGT2tH8RsiHsaqAzZZsAxAeFX4R5VGsTnzmGs5Sp6k3oLaj1z5Kn2cTwUnS
	 B6Xm7iZHY2aotlsDm4+aos+BbnnsR/ehnqu1XWj36nIzjdAQB8fWKP/xp/GdrPLnNDhW2
	 FyGbaDvsxlo7RsE8ayfOkTXnTGPMNeo9QeYLTsJ1R91tjfj5ZBBXQdZMUeSi8UdamkjuI
	 g52eVGLZ9ujpQWFmFlWaDM0j+IeKWfeQlK4MGaizvdm5BJ7l06NU3HfSip26CLr0TkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tdejc/ufOmnymGEBUCiVDezEymlK4tcFhtmJwTh2Fow=;
	b=mGsWroXYRy1qxvLCyh2Kwc0YpAEsuW+Sq1/s+akaXvZaeJ9IhtkVhJhjjiDtIzipjWfm
	 doqGcFjB28ilyYhnbersopU/k6QszYKXyk358wcUfUNBKnK/CuwlaUGVP9Xl5AqB1svXT
	 Fioh59sEYdZjgkREkS/QmNoA/MPPU16+OqtbKKuDQpXl1uOoVaEiaW1ChZj/8B06sqgyU
	 L1E2dYqfeDPneXH4Bxo+KB0svBPD5jj0xNao+r0V6DDFIH8mcXTxAd786RVz6CQZYKdYx
	 +DZwzURKyK8fak5375aMcBhZc2Rb0NnYcqU5rfZzCO94KQmvDtyQnQv4HIL9pTOiXDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhKrrRCy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720030;
	bh=tdejc/ufOmnymGEBUCiVDezEymlK4tcFhtmJwTh2Fow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L0eD3LPbqXpJdCmhqJqs3ljQ9XqoT1e2UDZddPYMGrJaDnhKeJsNKvf/txGVjJZzU
	 PyJ5nEStk0Xl9Yw5oQN9ED6IexjE/cfi0Dxns4D/YAJjuoA8oo/sy4KvpMqw++LFC7
	 GQjvYGy2w//TWpj78ergZsXkEU4996wo7L/AvsiHE4Ndtn54/ousItCBbtfubH2GrM
	 imTlq/zsGw2ozT8bHNZO9KiybZv7qAJYCj2rZRlWD4wRycaEwagx8lfRbByDbpTffz
	 o+mKZeAz4OZFNl5wLbYlm7cC1xSGkBoBtFuQYspItru0nvZEa+njQX3QmF7s09BPt1
	 1Ds9+45AraQaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B17B7606E6;
	Tue,  3 Nov 2026 15:33:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D4BB5A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D22406085B
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JDe--4o6wqrn for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A087E606E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720027;
 b=UGIclwubDh41TeDdO1Quz6TlMmtlsF8Lws8kC8H7xnjsv7OzosxQeRCyUMAuS8W8jkXS
 vcD/g5Y/4j/p5rfyOly4eXef6AY4zeyttdoMQdEc3flVZ+uTxV3NIrMC1MojJHV4mZKjD
 eCv1xf/VUv6/eQ0aNdfLSoWvOAZWPHsAPhsmioWeJOAe19N/E9d/hQdwV9ybzwneaLnD/
 nv8GnMK6ENTBuDIbS77+REoSay/kOAKzO850FCBTvRfH4eg7ACbcQiU/QYm+ORWmI7zvd
 2uyTl5KQohzm31M11zrepQRVGptIIZvXK38frs1I6gsa9UJ0HTjxdSaw1rFU9y0nveA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720027;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=tdejc/ufOmnymGEBUCiVDezEymlK4tcFhtmJwTh2Fow=;
 b=CXz9Awx7+cJog11ONr8YvzoUi2SkIWMevJj4eyZU4dHlWCj9hHcMPomcsFFGsZH7SX4m
 vh3bI0HvVEsLEzkgmqUQVgQJjYuRCWZbQzGKZbtIjIWg6YinAf0GjEpjB1hivrfDhyWWr
 Ly4dX4kR5dBjyRON7u+DVAYNoYI1YcdXxC8mx2st3Hc49apLcWUHIPPtmBr9yFjSjuD8y
 2H6bQnXT4HcuDlMuHSIl6qUbGhqgVN/6zAmCmm3G+IFe/U05MoO1YOurouE21GbQBSjsw
 l+buKnR/5ff419OjVsczna33/tVX6Ygra/6/AhXrpoMOmrgHM+wS1ucDiG6kGPl4xFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=hhKrrRCy; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=hhKrrRCy
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A087E606E6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:33:45 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48dfb76b304so464666f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793720024; x=1794324824;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tdejc/ufOmnymGEBUCiVDezEymlK4tcFhtmJwTh2Fow=;
 b=hhKrrRCynMbFkrWqZ6Oiv+hY2zPt2c7atOKYuvqlOkxKvoJtPvQy7R3tEAs2QUyGVQ
 AFG8V6/fqAWucNPL3zf8Q6q9BHGikjOCkZdbQHITXtC+xGFtkwOT2lpVLVI89zkUC2DC
 6KYtw9Mdm986K34Lm0nfPWM17aEGyVP6TJP6tiNBs2coa8e45uetU2mDD2qWNKKJW15S
 ncT+U71daVMYsXa1h+dnKCi2yQcC2qhXLWJJ182cZkwsHWrHv1mGyJfmMg9vJW0/Ii7e
 79o/gm3tAbvuQ79j3kdrAUY76T87f9C49FgItRixHZFr+bgm/nt8Amhbjk7hYVX2j/1p
 EUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720024; x=1794324824;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tdejc/ufOmnymGEBUCiVDezEymlK4tcFhtmJwTh2Fow=;
 b=yKXfixCTS/kn3/AAsg4kuVLA7NbPD+SlqVoMzZaSXuKNEltnnh+HjenTC9AdsTAZxE
 CQ3oSlM1ibm4NQrGkIWu80co4G91y2einn6osuNvvunkvGmgb2J9O+opEwXAJtdBjOus
 0ajdGyS6Qtn7WbQY3Hnci6XWYPa+ZTLbGS3cz78E4U2gd7TOMZ5iGBfgZGMrO46ILFs8
 ggOaKJEOoU6SF/fOyAOuNZCofohMR8+rtYEwHlq72QZ1DPuHP6GPAOD86Y139LN0tAua
 2cC41PxTFIA9TccNg+u6Pdpfp9J3v/4mqZe3XugfkU1z7R53iPsUj8KWTfxhCP0+EfDM
 4+QQ==
X-Gm-Message-State: APuU4Z9Eeo+gj6aXS74FiH5QAd9rBo4bWhxe5dRQJWoG5DOACpJixE+3
 xQp6xB6RPbAxfC6iWlYjwm9HCxkc3YBJMTBuuOew0GgMUflXd4qq8mHhu9r3GI4bVk9wLtY0
X-Gm-Gg: AYBFou00TOFrUtq3kkwXtD9P1NftxpOgv7RROktIcYdc6htGb235fVchStm1jle17RU
 tSim638FpnuSDqBElcY8Xm4jdZjr6hROlKjGEscuFD1ssTBD1zMMywYf9mjqnJmWOj7kWmBEOpD
 tQMVN4dGBlAh9YbllrlzEA7MK65BVslL3lF1yGDqekewA7zF7+2pBHEfxXN/nY+t5/hg3MTPMUO
 jQZU2Di3cB5mvYjFTjAg99z2A91YNplAQtU+pfyjnH3+FLCGPDRPPxrr8t8Q6AubZ79vSnMOxBu
 I4kOwSF53QiAzSJFGu4Ad9THw0/v6l48y57ERlvs64f+aQHWZPa3aWmOJz+vhh5Xzz3QUic5byl
 JoD5jNmrPJZ1kCxuZ7U6eLfuNR1uVovT1vY7VRzvG0w1sGkez9spYUsOozCchCDZNJctLFPaLnD
 l4Tm22rC0Y5Q3P56787VUxdC8ZKLkuGDbppE+9GwWVzSXMHZfwAKxprs7fwxdA1adQLC9t392nS
 xWMbEbN21r6/0O4iyJ79qsajLcRJHJyFFwJRQdPD9EHG6eaXVpllwqXTq8mMMPMksvHsQwibzJB
 D9caqvnT47stspY4EYYy4HQmodM6Dj4=
X-Received: by 2002:a5d:5d0d:0:b0:48e:932:aef5 with SMTP id
 ffacd0b85a97d-48e6e302ad5mr28429023f8f.21.1793720023979; 
 Tue, 03 Nov 2026 07:33:43 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3cesm28506555f8f.7.2026.11.03.07.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:33:43 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 3/4] bootstd: cros: Check where the preamble puts the
 bootloader
Date: Tue, 03 Nov 2026 15:33:42 +0000
Message-ID: <123a6909-1d9b-4b99-a6f3-8e1947ecc255@gmail.com>
In-Reply-To: <68656bc0-c727-4d25-8066-f2633c04e02a@gmail.com>
References: <68656bc0-c727-4d25-8066-f2633c04e02a@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

cros_read_info() reads the kernel command line, the x86 setup block and
the bootloader into a buffer of bootloader_size + 8KB bytes, from an
offset worked out from bootloader_address - body_load_address. All three
fields come from the kernel preamble on disk and nothing checks them, so:

- on 32-bit machines, bootloader_size + 8KB can wrap, leaving the buffer
  too small for the command line and setup block, which cros_read_buf()
  reads from it
- cros_read_kernel() later points the x86 setup block at an offset into
  the kernel body worked out from the same fields, which can be outside
  the body

Reject the partition unless the command line and setup block lie in the
kernel body before the bootloader, and the bootloader ends within the
body, as the ChromiumOS kernel layout has it.

cros_read_info() can now fail before it sets priv->info_buf, which
cros_read_bootflow() frees on failure. Since priv comes from malloc(),
that frees whatever the heap left there, as a read error already could.
Allocate priv with calloc() so that the pointer is NULL until it is set.

Extend the ChromiumOS test image with two kernel partitions whose
bootloader is too near the start of the body or ends past the end of the
body. Neither may produce a bootflow.

Fixes: f861b1ee70aa ("bootstd: cros: Add a function to read info from partition")
Fixes: 71f634b822ae ("bootstd: cros: Allow detection of any kernel partition")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
(no changes since v1)

 boot/bootmeth_cros.c     | 24 +++++++++++++++++++++++-
 test/boot/bootflow.c     |  7 ++++---
 test/py/tests/test_ut.py | 22 +++++++++++++++++-----
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 685d5335e86..805680f71ad 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -272,6 +272,7 @@ static int cros_read_info(struct bootflow *bflow, const char *uuid,
 	struct udevice *blk = bflow->blk;
 	struct blk_desc *desc = dev_get_uclass_plat(blk);
 	ulong offset, size, before_base;
+	u64 bl_offset;
 	void *buf;
 	int ret;
 
@@ -285,6 +286,27 @@ static int cros_read_info(struct bootflow *bflow, const char *uuid,
 		  (ulong)preamble->bootloader_address,
 		  (ulong)preamble->bootloader_size);
 
+	/*
+	 * The command line and setup block come just before the bootloader,
+	 * all within the kernel body. These fields come from the disk and
+	 * cannot be trusted, so check that the regions are where they should be
+	 */
+	if (preamble->bootloader_address < preamble->body_load_address) {
+		log_debug("- invalid bootloader address\n");
+		return log_msg_ret("bla", -ERANGE);
+	}
+	bl_offset = preamble->bootloader_address -
+		preamble->body_load_address;
+	if (bl_offset < -CMDLINE_OFFSET ||
+	    bl_offset > preamble->body_signature.data_size ||
+	    preamble->bootloader_size >
+	    preamble->body_signature.data_size - bl_offset) {
+		log_debug("- invalid bootloader offset %llx size %x\n",
+			  (unsigned long long)bl_offset,
+			  preamble->bootloader_size);
+		return log_msg_ret("bls", -ERANGE);
+	}
+
 	priv->body_size = preamble->body_signature.data_size;
 	priv->body_load_address = preamble->body_load_address;
 	priv->bootloader_address = preamble->bootloader_address;
@@ -406,7 +428,7 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		return log_msg_ret("bod", -ERANGE);
 	}
 
-	priv = malloc(sizeof(struct cros_priv));
+	priv = calloc(1, sizeof(struct cros_priv));
 	if (!priv) {
 		free(hdr);
 		return log_msg_ret("buf", -ENOMEM);
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f24d79a34d9..e5b3e1fc665 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1488,9 +1488,10 @@ static int bootflow_cros(struct unit_test_state *uts)
 {
 	/*
 	 * mmc5 has valid kernels in partitions 2 and 4 and corrupt kernel
-	 * metadata in partitions 6, 13, 14 and 15 (oversized keyblock,
-	 * undersized body offset, wrapped body offset, undersized keyblock),
-	 * none of which may produce a bootflow
+	 * metadata in partitions 6, 13, 14, 15, 16 and 17 (oversized keyblock,
+	 * undersized body offset, wrapped body offset, undersized keyblock,
+	 * bootloader too near the start of the body, bootloader past the end
+	 * of the body), none of which may produce a bootflow
 	 */
 	ut_assertok(scan_mmc_bootdev(uts, "mmc5", true));
 	ut_assertok(run_command("bootflow list", 0));
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index a33f188d984..5e3b02bb100 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -408,6 +408,8 @@ def setup_cros_image(ubman):
         {'num': 0xd, 'label':'KERN_D', 'type': uuid_kern, 'size': '1'},
         {'num': 0xe, 'label':'KERN_E', 'type': uuid_kern, 'size': '1'},
         {'num': 0xf, 'label':'KERN_F', 'type': uuid_kern, 'size': '1'},
+        {'num': 0x10, 'label':'KERN_G', 'type': uuid_kern, 'size': '1'},
+        {'num': 0x11, 'label':'KERN_H', 'type': uuid_kern, 'size': '1'},
         ]
 
     for part in required_parts:
@@ -462,18 +464,21 @@ def setup_cros_image(ubman):
     set_part_data(2, pack_kernel(ubman, 'x86', kern, dummy))
     set_part_data(4, pack_kernel(ubman, 'arm', kern, dummy))
 
-    def bad_kernel_part(keyblock_size, preamble_size):
+    def bad_kernel_part(keyblock_size, preamble_size,
+                        bootloader_address=0x103000, bootloader_size=0x1000):
         """Build corrupt-kernel-partition data that U-Boot must reject
 
         The keyblock carries a valid magic and the given keyblock_size; a
-        preamble with the given preamble_size follows it. The bootloader
-        address/size fields are chosen so that, were the partition not
-        rejected, scanning it would succeed and produce a spurious ready
+        preamble with the given preamble_size follows it. The default
+        bootloader address/size fields are chosen so that, were the partition
+        not rejected, scanning it would succeed and produce a spurious ready
         bootflow, which the bootflow-list assertions would then catch.
 
         Args:
             keyblock_size (int): Value for the keyblock_size field
             preamble_size (int): Value for the preamble_size field
+            bootloader_address (int): Value for the bootloader_address field
+            bootloader_size (int): Value for the bootloader_size field
 
         Return:
             bytes: Data to place at the start of the partition
@@ -484,7 +489,8 @@ def setup_cros_image(ubman):
         # bootloader_size at offsets 48 / 56 / 64, body-signature data_size
         # at offset 88
         pre = struct.pack('<I', preamble_size).ljust(48, b'\0')
-        pre += struct.pack('<QQI', 0x100000, 0x103000, 0x1000)
+        pre += struct.pack('<QQI', 0x100000, bootloader_address,
+                           bootloader_size)
         pre = pre.ljust(88, b'\0') + struct.pack('<I', 0x4000)
         return kblock + pre
 
@@ -496,10 +502,16 @@ def setup_cros_image(ubman):
     # - partition 14 (KERN_E): preamble_size wrapping the 32-bit body offset
     # - partition 15 (KERN_F): keyblock_size smaller than the keyblock header,
     #   placing the claimed preamble inside the header
+    # - partition 16 (KERN_G): bootloader_address placing the command line
+    #   before the start of the kernel body
+    # - partition 17 (KERN_H): bootloader_size extending the bootloader past
+    #   the end of the kernel body
     set_part_data(6, bad_kernel_part(0xffffffff, 0x800))
     set_part_data(0xd, bad_kernel_part(0x100, 0x800))
     set_part_data(0xe, bad_kernel_part(0x100, 0xffffff10))
     set_part_data(0xf, bad_kernel_part(0x18, 0x1000))
+    set_part_data(0x10, bad_kernel_part(0x100, 0x1000, 0x101000))
+    set_part_data(0x11, bad_kernel_part(0x100, 0x1000, 0x103000, 0x10000))
 
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
