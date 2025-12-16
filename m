Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25DDD5E15A
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 13:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90852839DD;
	Tue, 16 Dec 2025 14:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="wJkTov0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C1DD83984; Tue, 16 Dec 2025 14:41:56 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F65383623
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 14:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=streamunlimited.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.suti@streamunlimited.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so1807948f8f.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 05:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamunlimited.com; s=google; t=1765892513; x=1766497313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bc/E/zfkCWnWdg284WNwDj+/iSFZdSW8exH7hei0yyw=;
 b=wJkTov0/4miJDjDh5QZtce+tnCSCzRTU41FY1PSQoXGpLu71JhZ+gdQ8uqMOE5dyPl
 e9/UOnz/svjABvz4H9oqesjC6rOTMA+ma5fzowCywqyscZPNHFM5Z8HMvWQLXYlrl+l9
 YGxhgiiQQQS73L9v+Ezq2L7qb3hInPeLll+Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765892513; x=1766497313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bc/E/zfkCWnWdg284WNwDj+/iSFZdSW8exH7hei0yyw=;
 b=bQZdDu8tvyZsM6MC8gI8NE/H5cSncCOhIiEn+WpzaYspmfcVH0vN7hJ979X116XGi/
 Em9kBKo8CN0+un/jK4FaFNJ4bhd7oAAHR4/YfcRv66ebtW7m7Zf/1HNR/PZq+ed7PwKP
 iqZxYOOX7VxxAgWiSejAgMya3VVEj/LCoNDHM/fPBoAt0I67Y+a0AKSEXRwpyTceLADc
 sgHVNO0WrcCymgqECyVqDRi0sM8bJesLWjt3nLdfwofWzZylA47vkIDJTymj2LCSyjix
 s/37aCju5BmmH7clG6Mef2i3v/FO5dlP3vtDnYdMh0mMHykZ2tujKSlZY5qYtAZoLzU2
 Ndfw==
X-Gm-Message-State: AOJu0YwyHN2vaxxb4oUHA9O7UhT+0HK32DrVenpzn8vOm5fJ45N9uuxZ
 XjsW2aqlRo5zCwCCI+Ajlpobz+pX7yxIrAWu0qtAgbTlMv3S+aI+Ykugx/na51bWjtdEy3EnTqw
 vdB9LzPO0Lw==
X-Gm-Gg: AY/fxX4pihoSxMk+QAViaMRJjodO3SWLVW5lWWa6HQ1r0C+B1KHVmEuiZ3fmr7H+w0b
 uT0hpSuNsPdbCk/mXNGswCR2TAVQnXXaKU8vhsp16LnQJ1QU37mMlksFKTwOPKEwv05hdeuIM5A
 4xhgXvJXJ2ALIWejqH/0HYOgy5/W/TCb5Ux7+XzbixVKOpctSxcAZWPLcTZeTp70vnBzQGlUBrB
 sz2Y/9n9YG92VDRp39Zh9S1caE2qvm4wwTZdqRSFpja9s9cUXi9qV9Xm5Jcka53ZK6e8Zs7qrQn
 W77fUMN+cK+lJiUeaQBzNhBlkuJpHkMd6Ak1b1Da238/3hByXy7xLVgpolY7M0QfdIpr9Zp0fxK
 DkruIDlKIF1i7ddPRuuCQVUryyj/sf6+55svTQ9smt7HBvB4iKcJ5RmSRtmf7XpFIBGZ50bVjF+
 wq//+1S9RmFmitAKePPim5zqiQc0vX24SwkKIdWjmur1l1yGNpmkoT
X-Google-Smtp-Source: AGHT+IF8LxIho5f0hNyI897+Vsy5iJswAbMBEfRdiSP3HGhLwYzV37RWW6YJrR9+y626gsEfP3dLiw==
X-Received: by 2002:a05:6000:1ac9:b0:430:8583:d189 with SMTP id
 ffacd0b85a97d-4308583d33bmr12786651f8f.39.1765892513366; 
 Tue, 16 Dec 2025 05:41:53 -0800 (PST)
Received: from petersuti-sue.lan (vpn.streamunlimited.com. [91.114.0.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f4126477sm19694532f8f.10.2025.12.16.05.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 05:41:53 -0800 (PST)
From: Peter Suti <peter.suti@streamunlimited.com>
To: u-boot@lists.denx.de
Cc: Peter Suti <peter.suti@streamunlimited.com>,
 =?UTF-8?q?Radek=20Dost=C3=A1l?= <radek.dostal@streamunlimited.com>,
 Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 1/2] cmd: mtd: fix read failure on default full partition read
 with bad blocks
Date: Tue, 16 Dec 2025 14:40:41 +0100
Message-ID: <722abb2d211a68f8a6867b2e03186245a443fbb9.1765892031.git.peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765892031.git.peter.suti@streamunlimited.com>
References: <cover.1765892031.git.peter.suti@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 14:42:57 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

When performing an 'mtd read' on a NAND partition, the presence of bad
blocks can cause the command to fail with error -22 (EINVAL) if the
requested size is equal to (or close to) the partition size.
When size is not provided, the whole partition is read by default.

This issue occurs because the bad block skipping logic increments the
physical read offset ('off') without decrementing the 'remaining' byte
count. If enough bad blocks are skipped, the 'off' pointer eventually
slides past the end of the partition boundary ('mtd->size') while
'remaining' is still non-zero. The subsequent call to 'mtd_read_oob'
then fails its internal boundary checks.

The Scenario:
  Partition Size: 0x1200000
  Bad Blocks:     1
  Command:        mtd read swufit ${loadaddr}
                  (Defaults to reading full 0x1200000 bytes)

  1. U-Boot attempts to read 0x1200000 valid bytes.
  2. It encounters the bad block and skips it (off += mtd->erasesize).
  3. To satisfy the full request, it must read
     (0x1200000 + mtd->erasesize) physical bytes.
  4. The read pointer 'off' exceeds 'mtd->size'.
  5. Command aborts with: "Read on swufit failed with error -22".

Add a boundary check at the start of the read loop. If the read pointer
'off' reaches the end of the physical device, check if the user explicitly
requested a size (argc >= 2).

* If no size was specified (default read): Stop the read gracefully,
  print a notice, and return success. We assume the user wants "all
  available data" up to the physical limit.
* If a size was explicitly specified: Continue standard execution. This
  will result in an error (-22) as expected, since the specific requirement
  cannot be met.

It is physically impossible to read the full logical size of a partition
if it contains bad blocks (as the bad blocks consume physical space
required for the data). In this case, truncating the read is reasonable.
For common use cases like loading FIT images (which often
contain padding at the end), missing the trailing 0xFF data is acceptable,
whereas failing the entire load operation is not.

Also add some logging when bad blocks are encountered.

NOTE: This changes the behavior of 'mtd read' when no size is provided.
      Previously, it failed if the full read was impossible. Now, it
      succeeds with a truncated buffer. The caller is responsible for
      verifying data integrity (e.g., via fitImage hash verification).

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
[polished the comment and commit message]
Signed-off-by: Radek Dostál <radek.dostal@streamunlimited.com>
---
 cmd/mtd.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 7f25144098b..1d1845bce44 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -559,8 +559,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Search for the first good block after the given offset */
 	off = start_off;
-	while (mtd_block_isbad(mtd, off))
+	while (mtd_block_isbad(mtd, off)) {
+		printf("Bad block: failed to read at offset 0x%llx, skipping.\n", off);
 		off += mtd->erasesize;
+	}
 
 	led_activity_blink();
 
@@ -569,9 +571,32 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	/* Loop over the pages to do the actual read/write */
 	while (remaining) {
+		/*
+		 * Boundary Check: Bad block skipping may push the physical read offset
+		 * past the partition end (mtd->size).
+		 * If the read pointer 'off' has reached the end of the physical flash,
+		 * we physically cannot read more.
+		 *
+		 * Check 'argc' to see if the user explicitly requested a specific size.
+		 * * If argc < 2, the user did NOT specify a size (defaulted to partition size).
+		 *   In this case, we treat "end of flash" as a natural stopping point
+		 *   and truncate the read gracefully.
+		 * * If argc >= 2, the user explicitly asked for N bytes.
+		 *   In this case, we do NOT truncate. We let the loop continue, which
+		 *   will trigger the standard error (-22) because the request cannot be met.
+		 */
+		if (argc < 2 && off >= mtd->size) {
+			printf("Notice: Reached end of partition with %lld bytes remaining. "
+			       "Truncating read.\n", remaining);
+			remaining = 0;
+			ret = CMD_RET_SUCCESS;
+			break;
+		}
+
 		/* Skip the block if it is bad */
 		if (mtd_is_aligned_with_block_size(mtd, off) &&
 		    mtd_block_isbad(mtd, off)) {
+			printf("Bad block: failed to read at offset 0x%llx, skipping.\n", off);
 			off += mtd->erasesize;
 			continue;
 		}
-- 
2.43.0

