Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F48C9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 048AE83979;
	Mon, 12 Jan 2026 14:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="n5957xF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D6A483CBD; Mon, 12 Jan 2026 10:10:00 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E2A83B7E
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=streamunlimited.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.suti@streamunlimited.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so58155755e9.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 01:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamunlimited.com; s=google; t=1768208997; x=1768813797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itNd+T83patQ5F9J+EzjZKuT4DglCVai+OvHSQukrKk=;
 b=n5957xF/KcKpKcML3Gf2BsPu7j5GBfrz/GcYvtuTgDPqanzTREmTbeAWRgV1NISiWl
 E0X111c6h5rRJ/ZyFyqxijGSBRDpMmthP7AzPGzjXXEl5Y+Gmy2/AFoZq6Lrs9rn1bV3
 0QdcIEAjp7CsSeLh4Lw+24HzgyTlCSo2maf+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768208997; x=1768813797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=itNd+T83patQ5F9J+EzjZKuT4DglCVai+OvHSQukrKk=;
 b=IBCm6GaWO5joWle16kR3zUlK9LymBGLlmRpOfIL3gfWjQGSDLfXhnwaYDVJkvCCkZK
 zowJMpb8JvKe8QTZcjpsa4IPYaJjVud2j57eIJdVUURmlfEHwV5J+/S7KKvbT+Tx1mhZ
 kQXGzGqeVjT+/iDweaZ5UELZVNPRxIU0Tqdeum4mw3EOS158ysSTFSimo2WZ1INNzirS
 CkCvqoIPe41vFj7jYiqa+fCHaaZ6MKJzNTxavYFooYJXY2pR7mf3PwwbeO3iIVW+gOyE
 e6lrqhX58bFx8ByOGrIX8RW/jqLVtopfBWoa2VYSteY4HD3+dAaqnIchcSAnZSt0gpWU
 vubQ==
X-Gm-Message-State: AOJu0Yz8Td2QD4KKB1cYmwzgVaLfsJyZKv3B17fkINBm/ORr5I47o28O
 enqIYdbkShLpNwCqC17ieBacNRXk63rLRwVNCzRQ1xZO33iQ/JyR5SrvroQKTZfPBHRMFhB4u4U
 hGFCySbD6LA==
X-Gm-Gg: AY/fxX4D+ML0vkoXIgSybnmJoGORxP/EtbQlXu83NHgUzXr8ndGLrXuLwVEAcPxGHNH
 idf0GHN/e30eEY/zBcpXDXcXVgGWSGIluBuUMw1xVJZEJfZy2V8ECLieiUn7t67HcAC/c3CxZxz
 gzvmuUHC8X9HkUlhLP//Wu5Ei8yYOPZTAJTik1nmk3BOxkz8Rl+X2rcUUi6YJ2BVXrg+1tRWY1K
 +oHTnhmVArUkXXONsUeWrCXzQz6o7TfbrpzbgHqoSqsPriw1dGIxRLYu5qy7YloqTEMRFwfvUdh
 iNEVtufY2sXpfvYsXkC+5orMEee/Jr6ZdLn1zrZ42B2AO7WXHAmTsaOyNsydoxy4eS2SWYNjzzw
 zLpMA+02DWi/q+kjgn2rD10jBMXB5GHZhuVA1JH7o5tU5Z2R5a5ZhpNrbx/9uUltuZBxKBxHOYi
 9EIpATg+03i1jSld9OfeiC/+Laj9UEWdDMePVYUDyTyiPZE3Rn2MEBoESCWg==
X-Google-Smtp-Source: AGHT+IH1A/pXRnw0WjilKUN/IhPnolIBeukOBq5kW65QVN8kkjOVFA00P6ZKFQzMezCZlqFRKLQbYA==
X-Received: by 2002:a05:600c:500d:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-47d84b3baa1mr140448395e9.20.1768208996860; 
 Mon, 12 Jan 2026 01:09:56 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e13bsm346390335e9.7.2026.01.12.01.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:09:56 -0800 (PST)
From: Peter Suti <peter.suti@streamunlimited.com>
To: u-boot@lists.denx.de
Cc: Peter Suti <peter.suti@streamunlimited.com>
Subject: [PATCH v2 0/3] cmd: mtd: fix default read behavior and boundary checks
Date: Mon, 12 Jan 2026 10:09:26 +0100
Message-ID: <cover.1768208815.git.peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768208271.git.peter.suti@streamunlimited.com>
References: <cover.1768208271.git.peter.suti@streamunlimited.com>
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

Link to v1: https://lore.kernel.org/u-boot/cover.1765891388.git.peter.suti@streamunlimited.com/T/#u

Peter Suti (3):
  cmd: mtd: add logs when bad blocks are encountered
  cmd: mtd: fix read failure on default full partition read with bad
    blocks
  cmd: mtd: fix default length calculation when offset is specified

 cmd/mtd.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

-- 
2.43.0

