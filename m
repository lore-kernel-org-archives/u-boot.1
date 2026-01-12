Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1395BC9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F648393F;
	Mon, 12 Jan 2026 14:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="07GYMWe2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C110483CF5; Mon, 12 Jan 2026 10:09:53 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E8883B7E
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=streamunlimited.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.suti@streamunlimited.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso54177055e9.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamunlimited.com; s=google; t=1768208991; x=1768813791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9E+aei2byu7vyJaQe1I+/t09I89Wa7qdwsP8ryKXWOU=;
 b=07GYMWe2oUWcanNympAPbZWsbrgjGdyX8VxKFaVs1hrnJ/s5xreSfogMLMZlfXB9v6
 FIJ72W0quls+JA4zVhz8OtRwFd+FwIz/WYPZ8eTSQHMShzpWLSKBWavg4jfbq8NEybOz
 wvIuvwkXrG7I7SrwErR0igFuumYIpzpD6fvmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768208991; x=1768813791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9E+aei2byu7vyJaQe1I+/t09I89Wa7qdwsP8ryKXWOU=;
 b=qOY14tAipVC1uEpyFrLKx/Pn++5aGX7J5RDEEu1On8g2J/gfADjKXRixBAA7xCxWem
 K4kuE7McAwW1SEUoHZLuJp3cJr+TDylkgPO9RK8n0PAqxDvHVXA/GH1Wme0T46Df6hgQ
 1QQAhyE34hmgz2pW/ZUS8S105Y0eIJJoJ1qedqVfEipdOdpmkk0GGrUdiwkyBeoQdUrt
 rx1lnccpQnfMxmC8t8ul937/4HCm5UT/OeTT1OQx0LwYfMQ8f/7U7F7odiVyFIfxRMvy
 stU8TzWlGTxJcTp7mwbIBm5AVAB5vdL653FCuj8dvUrFIxwrsAUNoUrrOYW9HCL+TvfL
 Vyng==
X-Gm-Message-State: AOJu0YyovfpE7GemlFXhslnkb18gSyoWOQcnXuojqD17cej3912dRr4i
 zB7xVwHtrAWZFRubf766U4iVjPrpTIuuWcDSqS6JDkRd81OoS/tU+V2KnlZJchuxXYtj/ktlIy6
 yHIRj8qO+FA==
X-Gm-Gg: AY/fxX6+0yoysq5np6QZrWhBSEod5kFY9vKIK5UCjaKNneDSLR95fqb39P1DwARKd0E
 wAfBK+qGTsmVO21s0VLiosHcglErtc79chB/H81oODtbict3zmXh5G1F2Lg/hDiRa8hW61BNAzr
 jD/mJq+B6+X1OiUpVm6t5d3X6BRF4/+ZZmZKMRG7CrLVxmwrdWxBSmQ+vNQFx/R3d/IT1DsiSWe
 0pPi3pQZ5O6h9IsPszbt+r2yCeC5oB0QuhKIcxpgdhQuLUC1/TQ2GUxwXVA3fQCnpBoaweVRiAL
 lcB4CQA+KJhqbAlEoRzixHLGdZ8mr/+JqHqHGjewcAi0xzsqSEceMynlOjQUBI6XS9WAig09Hxj
 dsktpFYHhk7//xHFFBG5fvt0tax1o/AH8MdfgyobCUrPQOBJ0Dxh0uegWZGZ1E0mv4rtSA0W1+1
 XEiQPekZXj6BbV1LrWnV12Vm2S9a7pCsMQsKgXDw+jnOG+TmtqkX1mynNdGQ==
X-Google-Smtp-Source: AGHT+IGdzjhZl0TdYnNk7WeGvAOt3cChvEOM6HA9PQsOl/gI2Mtcc6EuDdLkLpy8ItEu+/7XGiUrig==
X-Received: by 2002:a05:600c:c08b:b0:47d:6856:9bd9 with SMTP id
 5b1f17b1804b1-47d84b33bccmr160402425e9.23.1768208990613; 
 Mon, 12 Jan 2026 01:09:50 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e13bsm346390335e9.7.2026.01.12.01.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:09:50 -0800 (PST)
From: Peter Suti <peter.suti@streamunlimited.com>
To: u-boot@lists.denx.de
Cc: Peter Suti <peter.suti@streamunlimited.com>
Subject: [PATCH 0/3] cmd: mtd: fix default read behavior and boundary checks
Date: Mon, 12 Jan 2026 10:09:25 +0100
Message-ID: <cover.1768208271.git.peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

This series addresses two issues in the 'mtd read' command regarding how
default read lengths are calculated and handled when no size argument is
provided.

The first patch fixes a failure when reading a full NAND partition that
contains bad blocks. Currently, skipping bad blocks increments the physical
offset without adjusting the remaining byte count, causing the read to
attempt accessing past the end of the partition. The fix ensures that
default full-partition reads are truncated gracefully at the physical
boundary rather than returning an error.
This behaviour is similar to the raw `nand` command which adjusts the size
of the read with adjust_size_for_badblocks().

The second patch fixes the default length calculation when a starting
offset is specified. Previously, the command defaulted to reading the
entire partition size ('mtd->size') starting from the offset, which
inevitably exceeds the partition bounds. The fix adjusts the default length
to 'mtd->size - offset'.

Changes in v2:
 - Separate commit for additional debug logs for bad blocks.
 - Return error when start_off >= mtd->size.
 - Resent to fix threading issues from v1.

Link to V1: https://lore.kernel.org/u-boot/cover.1765891388.git.peter.suti@streamunlimited.com/T/#u

Peter Suti (3):
  cmd: mtd: add logs when bad blocks are encountered
  cmd: mtd: fix read failure on default full partition read with bad
    blocks
  cmd: mtd: fix default length calculation when offset is specified

 cmd/mtd.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

-- 
2.43.0

