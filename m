Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA70606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nQt37QeP;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=otHmbiQ5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C8BE810ED;
	Sun,  1 Nov 2026 07:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c5EDpsm6wtUf; Sun,  1 Nov 2026 07:02:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 87FBB810E0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516540;
	b=bSaxEqgh/1kw2fgw7s3Pb9G/b+Yyeia38j3hLkOfa0yBcwfuG17j3EyZ89VTe3ImJ174
	 WeBFXIZZLvWCvUFWKEFrnYOxEhaf7cCCvVOxuNaOmVOvGxkmAZx02TCmQ1dniaCcuwUjG
	 ukMiG5OG+ysRuyamfw5kKHjzoSsRrsJbQVbdArdkbbCuDeHJskim6sUz1maeg2fpqJ26U
	 Xaz0ZnEkJjWvN/lIKjv+W2afpK+E/lcX5/GNeDpRPRReJHeP1A1CWnKxy6cb9fshhIbso
	 Qg6UUdL9pPIxu4oUhD3S2lkFQHwlIFHNlWYOVLOqUXA5ZvGfy/uZq5fM34mTi+go9eQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516540;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=L1CznMWH3B4wyUTp4/Td1n6u+MSKkpzPbFFHbWmJcNo=;
	b=W0ge8Q0qR1vJecE+Uz1Lk+f06H0fyKLQqYJnK1OO2SSim/ZaKp0UeiBkLI2jAEh0df+p
	 UBfjsHKUQ8uSjc4abwYkTvjQCdAgsUo+1RZ3a2wNgZXXHivrCVmlcqqmQK5YWTfGt8nO6
	 ThsbRJgVB4A5Dv8zKUeh57aykzs0+gHvBGEuN7iNKMxNeOr91VXObTyj9HImx1mMXaHkE
	 P+1djMydQ2QCgIBHKYeN7DKbiTmW0M+w3zzleBOGXo8ceJxCBNkN5TLKkPEnpbbvw+pkx
	 Mv8rI72vFGI7TejflHPIQlfVpS12+NbHe9WcAV+KDYdpTA/w2k9gUR1HJ+3lAy860NA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516540;
	bh=L1CznMWH3B4wyUTp4/Td1n6u+MSKkpzPbFFHbWmJcNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQt37QePQsF70Tdvaa1C1w0wo3UN99tyPSdrgwDWWaMt5UQZ42lwz/2fvHrMRKCdp
	 nLlYLedt56MepBDy1rMCbQL2xpY9WddHTC2O6yR3emcU7u4xsrGJ4ypgR//592LwOF
	 5tt9d/l0oWUDvsymxVx+3U3JPUC8qoacO5GzZhZH8vE9PRaCFDP4JDbSzva9iM32dO
	 +FyzNxh1YFVKGU53A3tmr4AOwbZ8yspJ/v4oFcMS9kP+qPEL6MdLFzMOsKST1o+IDy
	 Lar9hSZFcDQYikopWKpe9iMYC2/mEpIHyn2Qf5yV91TrXmHM99SG5RlR4kbeKPugzK
	 CIKqAiUsp/t5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87FBB810E0;
	Sun,  1 Nov 2026 07:02:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 75127380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6725D400AF
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pdGr-WKwaVVf for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:02:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5DE0D4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516538;
 b=HYQgoQeDC50nPsXYjx3LTrnGPVilqKfvkulmyc1RspINbzfKEz2fT3S2tyDFE0rxIMCE
 OQoY+Owy6Cd88ip9mZFZeL6csdgZjdRTyPcHpn77DgSP38xUnsKTvEJnFh+nBrrqYwHEC
 zDBBzW8NJUOrMnl/NJ5/J/YQTq2HGQTSM8MDPfRGav1kzOCqZrsttAjPXUOqhP8+t7mTM
 HxeMdRwdDYl+VafIfRdMhKNecJrov2I4bN0rQCaDPWan28wdsRP5wFd5DHPG33OFSb+9M
 oATc3AHH633fwJ4sMYQUSg/h/S8lR2waFPFQA5x6b7uSAb0WIN7ziAAGz6DwHkwtQ8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516538;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=L1CznMWH3B4wyUTp4/Td1n6u+MSKkpzPbFFHbWmJcNo=;
 b=he21pwhmcYEvA751zSM6fI/Rz8ciJAph5d8kthltxHT8Yko7TyWtpTrcWxrj9kJkynAe
 CTh6YcIw2YFRKO53AlI6SrOJPTnEcZ4/X41MBERrHGvhR1vzpidvm5QXMivnRiaiYkpz1
 +9YU5T7wBMl+CnC+81XKjkzLRr9R83HEOXVuqo/XZNscL3kNJVANSF/NLOn0koODWPukN
 NyFtLLWpIOHdAhXdpk6T839GdmxGqOSyCF9ShqLRrnQvl7LD37rR7ekAJ0YPZyG4D6HSL
 rs97ZdOoq6w78n6MxfKlJmUC/Prtbos83AxX9V6cv8k7UMKpn5r3EH/NdGFVCUdGBvg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=otHmbiQ5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=otHmbiQ5
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DE0D4004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:02:18 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso23685685e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516536; x=1794121336;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=L1CznMWH3B4wyUTp4/Td1n6u+MSKkpzPbFFHbWmJcNo=;
 b=otHmbiQ5s8Wd81fAKqPgRAjytpMO6kHXJXTzloG25G3WB9NRnfVijwzaYKHL2UJjBW
 9zHSY7cpozlrfZ5YWaUdQ7qcAwXKlImz7h1NSRt8iKba5ymZKawSBt2NrydEd+u3SPRP
 Sxp/MSpQvMiQ18U0p8rv1eUn4WOTlNQBwbnvj5wjMTS3bmbCeqDhzS5JwICX00o6YHkD
 I2Zwt0s0Jzn/kWsuGvmUxG2Z0Ic128MedSy6bXmLlrkUW9/4GZJydhMGHtJuhgKIR/Is
 PHlahzXQJZovQ4UHBbeEGRQfi/x/GRzjtUfFQxZLmd7vlKSEN/0MsZel6AUb3UkndzYS
 MmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516536; x=1794121336;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L1CznMWH3B4wyUTp4/Td1n6u+MSKkpzPbFFHbWmJcNo=;
 b=l0GswPxTJkjKEyyQW/HxwyhQpPjjBkCS6xWJtSUG/wTU0Y1V/2VSjLNqMZxsiz5HsZ
 Mozv0aN1TieUpabvHLZAYv7RPXQkZCBioR3SXKyhIVUW2En30NoH3XynqxIkKGwtmJMX
 HRuqNN0+Xk1Aovn25goiXH+iVW/8rqUPOwPjM8EQ6vj44CvRLEFZL0BA0YgY/0ihjBec
 Y5SNlVuXvZV6uYhA9D6JFiCWLqoFXDU8EdJ4m/N4wa0GvrT+V5MP7tb9yhS3JMVzTmL/
 4VZ0ATm8RC60FeZgXsx77R+dpfDGq7rpMn2Ed6eo00+Ar6r1PwOpc59KBoheyfFQy9LY
 7+fQ==
X-Gm-Message-State: AFq9FYLJXXaSeR6NAQJOTYBM6QIqegARKv2E5uSLtvT1/5oEvXqMrQ+r
 EHMJFttzkVoZaZQQ6QEZRJRWuLKzdTANFyeI0MwhHqU7fiAZ321rS6TK
X-Gm-Gg: AYBFou3Yzk/5KGgAg6jVItMMpzH2eq2xCDmyAjbc16rLbg0Pnu0m65yViM+pIpBK+7s
 MYq4pcgZqyyR/LJhdnQ1/mwRJ65pVR50QdHMj/xAmGyuMwbGk1VhdHR207wan9iTVEI5+RArsQT
 S+T1FvXD+JYIgBmNq8pevpnuHuMzTi9+hjO8IfHLq9sZLEG5Da/T0bp5XJkxotzKM18sKs4SsBG
 DJetP36eSlOJAk3aErota86kANteXBR1VoBAEK0SsO3RdeicQQGajGD/+vDgSuTDVanRuT4qaU7
 zymDqsG+unWKoxzM4fnI5bQU4INmy+oVOgYOrM7u0MA3vYcCmJN8vi0hhRq+JApjyqa3zqmulsy
 UfWvNRJM80bpMHv2ZiuIOiyFzwP05ignhv3w2gY5fz/YpyY6n9zckIeP3tzr30ZKjfEMWfBFxP+
 jt7TBuQgh+vkeoRdgtpLe18Ok52Orf434fV39RQp6sqJIrrTt6PyJ/pEEmO9NDVJnacpF/xCsy8
 4hFC0H787kaCdLUWGfhurtX14q7bEsl8IGN+K/SLsba9E46p4M0rHq5tasBgYEtm8TmJJYtDSaF
 2SbtCmUMhiYOmzs7qYwzcWUpH4+KswE=
X-Received: by 2002:a05:600c:8183:b0:4a1:f9e6:f418 with SMTP id
 5b1f17b1804b1-4ac19802178mr133619755e9.34.1793516535874; 
 Sun, 01 Nov 2026 00:02:15 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b72715sm12231635f8f.18.2026.11.01.00.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:02:14 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 06/14] ide: Refuse an ATAPI block size atapi_read() cannot
 read
Date: Sun, 01 Nov 2026 07:02:13 +0000
Message-ID: <01ead749-12ac-4dc3-83ae-eff40ce3ea7d@gmail.com>
In-Reply-To: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

atapi_inquiry() takes the block size from the READ CAPACITY reply of an
ATAPI device as it is, while atapi_read() asks the device for, and moves
the buffer on by, ATAPI_READ_BLOCK_SIZE (2048) bytes for every block.
With any other block size the callers' buffers, which are sized by
blksz, do not match what atapi_read() writes into them: a 512-byte block
size makes a read of several blocks write past the end of the buffer.

Some CD drives report another block size although they read 2048-byte
blocks: 2340 (HP 4020i CD-Recorder), 2352 (Philips CD-Writers) or 0.
Take these as ATAPI_READ_BLOCK_SIZE, as Linux does in get_sectorsize(),
so that a drive reporting 0, which ide_probe() skipped until now, is
read with 2048-byte blocks too. Refuse any other value: a device
reporting one is left with a zero block size, which ide_probe() skips,
as for a drive without a medium. This refuses drives with 512-byte
blocks, such as ZIP drives, whose reads of more than one block already
overran the buffer; supporting them needs atapi_read() to use the block
size of the device.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

Changes in v2:
- Take 0, 2340 and 2352 as 2048, as Linux get_sectorsize() does (Simon)
- Say what is skipped in the message (Simon)

 drivers/block/ide.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ide.c b/drivers/block/ide.c
index 44ce054bdf5..56e55bc8bc1 100644
--- a/drivers/block/ide.c
+++ b/drivers/block/ide.c
@@ -450,6 +450,7 @@ static void atapi_inquiry(struct blk_desc *desc)
 {
 	u8 ccb[12];	/* Command descriptor block */
 	u8 iobuf[64];	/* temp buf */
+	ulong blksz;
 	u8 c;
 	int device;
 
@@ -514,10 +515,28 @@ static void atapi_inquiry(struct blk_desc *desc)
 		  iobuf[0], iobuf[1], iobuf[2], iobuf[3],
 		  iobuf[4], iobuf[5], iobuf[6], iobuf[7]);
 
+	blksz = (ulong)iobuf[4] << 24 | (ulong)iobuf[5] << 16 |
+		(ulong)iobuf[6] << 8 | (ulong)iobuf[7];
+	/*
+	 * atapi_read() transfers ATAPI_READ_BLOCK_SIZE bytes per block. Some
+	 * CD drives report another size although they read 2048-byte blocks,
+	 * which Linux takes as 2048 in get_sectorsize(): do the same.
+	 */
+	switch (blksz) {
+	case 0:
+	case 2340:	/* HP 4020i CD-Recorder */
+	case 2352:	/* Philips CD-Writers */
+		blksz = ATAPI_READ_BLOCK_SIZE;
+		break;
+	case ATAPI_READ_BLOCK_SIZE:
+		break;
+	default:
+		printf("ATAPI block size %lu not supported, skipping\n", blksz);
+		return;
+	}
 	desc->lba = (ulong)iobuf[0] << 24 | (ulong)iobuf[1] << 16 |
 		(ulong)iobuf[2] << 8 | (ulong)iobuf[3];
-	desc->blksz = (ulong)iobuf[4] << 24 | (ulong)iobuf[5] << 16 |
-		(ulong)iobuf[6] << 8 | (ulong)iobuf[7];
+	desc->blksz = blksz;
 	desc->log2blksz = LOG2(desc->blksz);
 
 	/* ATAPI devices cannot use 48bit addressing (ATA/ATAPI v7) */
