Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE8606A32C
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nPOinvsN;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ArB5FKHm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0272D60728;
	Sat, 21 Nov 2026 12:35:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k5qtAtdJpoD5; Sat, 21 Nov 2026 12:35:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 406A160653
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264547;
	b=Z+f6lAqgTT6umqhRqgDRlwcGb39vG1CW1DuLIaNngvO2lKPs2NQENMgzeI7vtJgYdGmm
	 ueSUFIsxRJBG8o0VpdoBiB6ZFGjU/f+5Y8GWxo6MywyQnYB6cmZHptkGdyoRNAVZ4hpIY
	 M1WQsDNxZEajYFa0jZBJbM1/83ZkBFlU4J1u3QU5LGSWo2mfC6VFzZd68Xnaw4pON0nDg
	 1H1OkVuu0UHLSYpmq57I68jboF5ekJpx6+SbUaCiQ70v6b5SANaHTR6VIaxh27yVufohQ
	 hiTY1k0LMfxA/xzRXy7zq8VXrYGOnNPHHkuCPggA12lynHN82VbFr/nDsjwJ70Gccwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264547;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LcqMOx4jnndg7QE3awjk0S1ewyycJHqa+Sty7Kr1Nuk=;
	b=ta1F8JWxMG4baLmtHwQeX5uUrauRfdMEAsxnQwzvxF5vbNnDGw6v4G7/vv2WUYdwImN8
	 /SI9dzsjj1pEsGJvPn1UJGxoVmadOVR6wbncDLEtlwW6CXyXBdo9/5GWu/nEaUQTrHhRO
	 KcQHh1H4rYt4X7HjW+j37tiEcxyKPmU/IE5wZHYls1YdEzl2K6i44HmkHpje/axk5Kfx7
	 EGIGGyeqRH3KMOLeuzYT8rcIqdf8+9X5dWmxBbDR5wzKqp17Zle88alCUKxKTGuswFEhV
	 WOskOwTawpv6+Y3A6bGFOxyI/K+44NuHIUthyz2MZtcZmw2QLVCQzGIqp8c3EUC6KVg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264547;
	bh=LcqMOx4jnndg7QE3awjk0S1ewyycJHqa+Sty7Kr1Nuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nPOinvsNQpjFU8fnYsZC9YkyRmRLtV0c4zntdd0cjZpaoRUtiZkl9RNIRvyQejQUF
	 Q4GOwfBVuWdSvDiUDrsvEfIvh2sgRzscMwvSpHv9GXwpaNiKAioA3mdLB3zpN2Cv4E
	 OsQS5zckX76KF+iUiC1vGayEn2mQjlA9Hm/iPnmamLSHaj2DeSb/Kbq4m73kyv9Apa
	 7XvS/E5LRga5fONvYOQ/l8iTHnWNHzNMCIisPcWPunRKlXNOLo9nRICSWuW9iDp5uh
	 mFzaRU+FUNtMV8+QKFM1kHJB1aAl/aRxhNZQInIhECruNkqP30oF65u5aJr1kMA8/N
	 bnc6FMDO2leCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 406A160653;
	Sat, 21 Nov 2026 12:35:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C427B3A8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA4B280E8C
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ai0eAUs_S4WL for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D8C6D80E22
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=ArB5FKHm
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8C6D80E22
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:39 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4a357b1c649so1050166f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264537; x=1795869337;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LcqMOx4jnndg7QE3awjk0S1ewyycJHqa+Sty7Kr1Nuk=;
 b=ArB5FKHm4pHEG395hmm8GCKUXD7uIc0HQhs3M/MI5t7iVPja4tUpMkXeUWyKkmBM8X
 VspedOPb2xjz4TdVNpFxTaGK0leP+u1BfgAzi2L/SVy18jPTynDmVISspN+G/kG8MDmQ
 eylNG1wEmuhXLSNqJ4CbG0qwCw2jyAU9Zsnlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264537; x=1795869337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LcqMOx4jnndg7QE3awjk0S1ewyycJHqa+Sty7Kr1Nuk=;
 b=WpaY671nJme/7/0cm/ZU0ksG1eZ+xv07xKOSfQXkuIM+tjNoVHrW9HmIVcPobk3qOD
 jjCgHLCIv5BeN7EfmFd6GL3Jxdupd9kjPjmL/AFsJKZ6xhXzKJEB0ys2SegROSTMrNAk
 G9fi7tImlSeGg++HTjf/YiX7S3lelMB3BX6VTJoXhg7DP+L8rNAq5qBjWSuorLNlUrkr
 oqsdDdJn7VN/QgvhCRy0SSiHqlaNPh7JgjQVTXzP//s5CwxcPWBbwHSMJhrxhQmnd0cn
 Jv/TgBwL3duP1JlqAox2amta7vJl67CwCqkBuHg9fyM6/N/WC0dxoIoEAKApuSgaOnPm
 FQxQ==
X-Gm-Message-State: APuU4Z+Ja75by0+pAu19OIR41t8RJBvN7DhYtn0Z1wzF9Tot+9GT+oKu
 XOBcAkfHAOIJDE9c2YYUmgM9RHnH7GxO8mjFr7rgHXBZ9vLsiXPoWcDCkAaEhg84zLO1/95lr+E
 nCx5S
X-Gm-Gg: AZFdTZdj+1NzV81o6x8XyILNC1tamtng+2coRLl+obsS/Eya4BN+YghRbUjYFcjDBfW
 VX/COlB44a4DgD4SNDdwSqJSWYI/XboT7s2D3v4F/9fQwDL6GevTioDjwfP9Zlf4oZ5wj1D0Ob2
 dWYgmLTXUACZGo7WvY7V/Wv7xjm7EMRcya09WyyIDOGaLgH7KXiN+HaFqrcppVNk1JzwZiLLfMt
 /El7p9kVaddjEg90zpDgyVAg4Asifox1BibDh89Y5IP++C+4iKKZxzrGMev2uhI5AVxzOKEcml+
 VIkFiSXlii2hHBIP7uiPKQZ9IsKMDcq271waNowJqOVsehW1R7cThsJEK+PL1N1dzQDyEOcrpvt
 ZQ4lnEwhCm8SntrJ8QvHUyNp3peWAQLRj/7i/vFZBwHdop6nb6w0dBFEHF3Moz/PtFWshrD9Odd
 6nx/H6ZFOlo4em0R4vv454oyuQRLfc17j9cvRa2GE+BzpVqJKvCeeVO56JIepbhON/v7KjLpepZ
 cxTq0+/QPYyYh+Limi+ZS+p1an3jPCK7xyECMslVIved9emswKd2hYC1JRJRchwiz+KqWI92dtC
 QeKjHQPGXih0gRvtT/SpHIKiWpsj64XFmPpvXRyuxJKyu4sNigsgyBEt5MORtITLDxApM/ouKoR
 Lfm80LlAwRsynjnSDAirwtR4c0+R5gi0Lxl9LQaDy633jaV0nEdkZL5v9JPdQ/oxWQtafaPYlQA
 mViko4uD8Zq7EKvotzmM3JfObgnjWTXkrtV6fnC7WkQQg9Gs4=
X-Received: by 2002:a5d:5d87:0:b0:499:9f62:d64c with SMTP id
 ffacd0b85a97d-4abaf64be07mr13832053f8f.10.1795264537528; 
 Sat, 21 Nov 2026 04:35:37 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:37 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/25] boot: fdt_simplefb: add a debug message
Date: Sat, 21 Nov 2026 13:34:10 +0100
Message-ID: <20261121123451.2471185-21-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The printed information is useful when adding support for the simple
frame buffer to a board.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 boot/fdt_simplefb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 69c7c2e24c03..73ab29e29e9e 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -58,6 +58,8 @@ static int fdt_simplefb_configure_node(void *blob, int off)
 		return -EINVAL;
 	}
 
+	debug("Simple frame buffer at 0x%lx, pixels %dx%d, format %s\n",
+	      fb_base, xsize, ysize, name);
 	return fdt_setup_simplefb_node(blob, off, fb_base, xsize, ysize,
 				       xsize * (1 << bpix) / 8, name);
 }
-- 
2.43.0

