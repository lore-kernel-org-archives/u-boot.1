Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C595C9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D560839A8;
	Mon, 12 Jan 2026 14:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="V3owGuv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4561983CF5; Mon, 12 Jan 2026 10:10:08 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE0083CBD
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=streamunlimited.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.suti@streamunlimited.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso43405405e9.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 01:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamunlimited.com; s=google; t=1768209003; x=1768813803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5203X+9BQKU0cgxEPfZG0avtYnY3f3qzU22HEvYjao4=;
 b=V3owGuv1i2zIiZRpHZKokQku3KPrG3ZMtW4N0jLgSqp1nmkxoHZMxzKzHTxTepPQmd
 OFVxLtxZ3duXsXwYVQwYTHOM5SI5rzgL9IdF5ChCoQNsrhi6P5Gn1bDGv2eYaRlkWhqg
 iK/i5EnLmK76Y4jBEck/ZEuHsqzx6vNGxYVDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768209003; x=1768813803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5203X+9BQKU0cgxEPfZG0avtYnY3f3qzU22HEvYjao4=;
 b=sJuir2tAL2I0jW2Y3+XYsfadDpkfIP1JQyd1oekEZTq/jF2nXhppUIDDUR16oHMU0Y
 Un4uq3Xe5/nVgq2tsuC1HU6NSBBeLbeU8QCRosOy1dnzDzjmYNHyDaFudBWwi+n0X/jP
 UoQvw5yLJaTdPe3eexXBjDbfnIkxD8e+wf5ALzfmsDD7K/SNjzcAf+dmehpqBAH7wHlq
 KSE8A2f4pcozSHRXqGVL4OXicMbisokkdBDtG1RzN295WwDEHytICDNPq2W5e+EWWoGG
 hCHQ7lE0297IbL9T5BIn60ueMZqy+enTDLFEmBy4FdXeyWegI028iBu8A21kYDOWD0vH
 DmLw==
X-Gm-Message-State: AOJu0YwTqMpKEvGJOymGUsuOFWPHZG2GiOCTg1Utsdjds3imtHgXVspF
 sGigbiqOcWmiHGnK/S4sF8EnOJmcxcEwap91KLGCE+ZpN5C38MPLJtPrB3/P7J/tkV/VCr/CIrx
 S4Tt+B7LOAQ==
X-Gm-Gg: AY/fxX4sm6VI8gr0QeUWfOrQ+8AogHz7EhE1ce9MjAzNklXbRZudPuc79jfbSQi+W5L
 Sbe4NXy+JBZBLtE8/zEcvVsA8NFODrt387++piN8zqPMstc8HIEljkcL6qfV3+FsSrst//ErnuO
 mHWlF7ZDemJLBNkBXjuZQkHgAmqD0Jna1OU4P9Nho4NN8KMnxO/NAfPsw9d/7VaOqJDsFhpjTGM
 UeinCLV/BCDPMJtysPjQIPh/TqTO4HOSrz3K4rEtCW6wpe/aXmlTcUHEeHLF0wW+ek4bhzAankN
 FgiHzSytxUYoCHxDFSiX6qCE0ZVtUnXexKdlNJ7f0N2/zzH8BtFPsnXdZHJOGfk8NxnX1GOSf4i
 iivD6EZT/0DuA+FcKnJhLjahbVlsalvtKZUThIywh1KyPK9B87IrMWC2m4UI/BZt2YyhQ51cnZQ
 7Sd20pE38yFGHU841HBjAbz1yOkNHomMpEZjHdfiKSk/KGFJqU1fTGW9a/kA==
X-Google-Smtp-Source: AGHT+IHRQLXg0vwB8Vz9uaM8wDfKZeWBV0EmIUSyf7x92QTCDJG2pUrEezd8x0LaVvEbyGQyBj4LPw==
X-Received: by 2002:a05:600c:8b2c:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-47d849bd639mr183204845e9.0.1768209003477; 
 Mon, 12 Jan 2026 01:10:03 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e13bsm346390335e9.7.2026.01.12.01.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:10:03 -0800 (PST)
From: Peter Suti <peter.suti@streamunlimited.com>
To: u-boot@lists.denx.de
Cc: Peter Suti <peter.suti@streamunlimited.com>,
 =?UTF-8?q?Radek=20Dost=C3=A1l?= <radek.dostal@streamunlimited.com>,
 Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 2/3] cmd: mtd: fix read failure on default full partition
 read with bad blocks
Date: Mon, 12 Jan 2026 10:09:28 +0100
Message-ID: <a192de15d6ea2fae42794e0896ca25756f442c3e.1768208815.git.peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768208815.git.peter.suti@streamunlimited.com>
References: <cover.1768208815.git.peter.suti@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

NOTE: This changes the behavior of 'mtd read' when no size is provided.
      Previously, it failed if the full read was impossible. Now, it
      succeeds with a truncated buffer. The caller is responsible for
      verifying data integrity (e.g., via fitImage hash verification).

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
[polished the comment and commit message]
Signed-off-by: Radek Dostál <radek.dostal@streamunlimited.com>
---
 cmd/mtd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 32733e8f11f..1d1845bce44 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -571,6 +571,28 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
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
-- 
2.43.0

