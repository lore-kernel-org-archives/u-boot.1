Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC8606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mNb7rtci;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x5RZhlfW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 408BD405EF;
	Mon,  2 Nov 2026 05:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVf8gHInAppa; Mon,  2 Nov 2026 05:32:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F13EA405F1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793597553;
	b=syx3klKlm3bq4xKWNbiRXgOCAHX8Xs8lQ1bvvVFXmlE9+vnESqQdzVx5VzFACMsDdU5n
	 swfA6QqWvF6JyEjOJrHrZ8BwIOAl1JU8VwmZg8rth+9IMp3uzQmTgYyvru9mXP2jy/P1C
	 M8C6W0ltsLotGClEGbLzvTLMhCpcic0tYhB3BKzVM9ueAj/trNlAomipUj1EZSruDCu39
	 PaYy51Zip3KIi+rYKqmri3TP1U0vmglRvLp1Ykk6bpf7I+57BwkRwFglrot9v8/7Vb4Rw
	 J3a+Cx9Qf6YT2vWaks/Z8bDQe831ByMMSK8LuxxWNiQuiR7jtED4XWE/1JyRDkrUzrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793597553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E2MLuBv+u9bTV/dCBgLtfuifzjW1PP2q7IzjY8DpXdg=;
	b=jC7gj0wEmNiI3Ug78/22Kst3ZV8Osw8oE+8MFfS5I2UsOH5TOnj+HC60ez6UipIrDMkb
	 oD0f8heRK9NxBfY6U5zjgmuCnlvnIkrGN3NJhFdHe0jpZDuJBCVb7z8ypDYpnx1HEG8np
	 tP6XSVDFJW7YCaU63+5LK2xhEZUuNX886ae5XKbcfJSA4gY9nfpkIyLReax4014RUHzd+
	 +xlhyxFBshj+WLTUdKTqOp9rvhKg9Xs8QpplpNzoAZkAHwc+VIxwsHkxildDYEmHT9tEF
	 E5bWkhwQdiGx8yqomPoiE24pbcAmIn+7F5OE0ZfrhF/HsQQA1lV+7B88M29alD57BaA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793597553;
	bh=E2MLuBv+u9bTV/dCBgLtfuifzjW1PP2q7IzjY8DpXdg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mNb7rtciHN9toAhYjNITbah1ojUNFiiOSDeswJyHpQmsww7lGXf/NA4LrrsYrAiXw
	 M/II+vCJoQfSw4VsvhwxoRVkK0mivL+IX8kv4/3oXooPy3+mDkQ67wXDaHqsBJQ0N7
	 Aktp2AkYkwqj05W8pakKAHc2MuRb+Cbvbkye5bS4c85mkutH1KlHzivfcEQ8AL/Irp
	 EtxSCIMHv5D/UcWgo0kjvWZ3keVrEDpNTyFzMdELtdzK/0fyaRqav0Qojrkl93IK2B
	 nKK+g9s2FMkxywuzx2OkMUewUdzn9oMHcCXKOLxQeI+27F50Of2X+syQixhVLVFiqK
	 5ek3OPmQ12zrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F13EA405F1;
	Mon,  2 Nov 2026 05:32:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 15797362
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 02:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11E1680D87
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 02:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S4weA9FmHN7V for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 02:55:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C46380D66
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::72b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793588153;
 b=Y/cln6paYtZiDRUIsdM4qE3lPlKblEB+32k5CsQRQImHhCc7R+UH2dg7bGExR9z0WWKQ
 dF6uE8cdgCHsqIjP0SgOs7asfR4QfmfiKJWAxMk3HhXzuTOJa4y+SRHscVc/O2LhF5KVa
 376i+WsIwdwb40anAfGeoSkUdxpuUh3S8LHHC/N/6sPvQ76xEKI4Cc2O+22ZbuRTM0iF4
 hPUuftVjl8TMHyaxz8qMKs/wlFq0HWZ8bX6H/qVlLq3qTNzgrTbiJnYk+ze4ixUU0rcN/
 X5jv4bUpA3fFS+O2xq8juwDx8mBX2rtuTKfZoJRc97Qw7MbaptFFfZ7DSJs7V8jwh4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793588153;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=E2MLuBv+u9bTV/dCBgLtfuifzjW1PP2q7IzjY8DpXdg=;
 b=eB2zZVylvxJnSB2sUfO57hfU7nNzubsEaOYlSLKmjm4gih8TIORRTFGvn3uuIKqEHASj
 QBLnVwlzyPTwQ77mJjzAArSe0WldygJsiaBtjIN7HqcilI54L9luHhiK+YDZYJgXMAC6D
 SlkwU6uLh2BRvFc6YT+uff3Ljs8FbcMViWkFyBtlGblROABInMsW2QzAv/Xxa6V6KneRH
 nzAH1bhmG3jDoxuDFtGNasMc7n3nrjgW2I4HNgTF2eIfQ1gxTheSultqOF3hYVHErlrgO
 OuCYjeSsl6fnPwQWkbH7IoKrTkzRga0NClaiFhKT4cn+kcSg5WnKCj6YFxQxnN7sMsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=x5RZhlfW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::72b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=x5RZhlfW
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C46380D66
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 02:55:52 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-93f2b8cf037so221665085a.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 18:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793588151; x=1794192951;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E2MLuBv+u9bTV/dCBgLtfuifzjW1PP2q7IzjY8DpXdg=;
 b=x5RZhlfWZZ+p7nHxmx2/PSXtU0Y+iBW3TkNTRRlM/JjmKLs+GsFlvizoR/LzJ36R8C
 AW7b+J5RlrV+XweOuXf1LA75em7Z66wQdVLSYtbJF+A9zuMSPwNg6zSFBRrckg6cX/ls
 6d7V0qtZp4era4DIxFkXWDYys1NDtB1NndZ4coz0foakZJKt71YDfx5S9AHb6Ili5639
 8hYHKaiPQaP1L+cgSNh6qvS5nOvVYW9JbeU9/k5veBV8k3TRz5B+6yB2FIS+vRby3TSh
 omLOgiSx8KlwM9cYLPLGymuj05NM7HpO8OjFyX5seWGU8Xybk4NQxaNmogwVMJrPSygw
 SPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793588151; x=1794192951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E2MLuBv+u9bTV/dCBgLtfuifzjW1PP2q7IzjY8DpXdg=;
 b=ffoYTHf1aE+9t3B2LjixvqMrChaHIQO+fDrFuSh/HC+oU413z5Qv2+U6rWmY7wuHQ3
 uD24Lme4y8j42f9cfLuPgqUkfzSXr32F3A3lhAAnrbSotj3CrXubXLLdeXmvrtPjLoBO
 UAWMM++Jxolm7urLsmRWCp8czo2jLPqaK0JQfznADaaY1PIpHq2S63MgUt6er9UFHkHm
 NF+rAV8maX2yeYWVbVuJGMiTkXaz/L0Xae/N4iwy8zKGHmVb8qi8iy5U4+qz1lBgnA+n
 uY+kilZLRxFHJ8+O6JwN/UEgzqygfrassGPpeHc3Wu8y469XxOqqWTEAIasyeQ2H+3z7
 7X+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwV/lP/UQfoBB09Y4X5ZQN94Qo3JmO0EjRDhD+rnq1kpcij7JIIUhYex7Xpb5yh13nPrkP1f4U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLQZEeH5Lwoba6271ugG2PxRmXjUtGP5f4RZsfIQKyvspBOuByW
 YgkI6auFJbSVzij9UkyFMbeaol/P9MxTgg70vkn7d0exrAXFD//ZT4a+
X-Gm-Gg: AYBFou2FRN2Lfy+2BvhLU78mNF29CvFIVRn2SmQH3YCTM90Ks0bJhqH8qztMjYAX6I3
 9PFqaC3ILe1h7qpDKezEjhpXCUY/vwd17svGC7mT36P90wZr34/kjtXdBvlBFsyVtSmKzMtsTfU
 M5rXX1gO9F8Bw/+ZXFY+W2IGd8WoMT3IxiYkFAdCKWVeonfuhFDHq9s+tgecSzD6pMaNpby+/rR
 oMgDIKpqnxOifRAhmIhgIluk1BzQv9A4RjvkO0M652+MH3G1pC3NKhvpGlmzHMuSVyYTduy9W4P
 vqfQ+HHM0Yqs16h+oiclm2/+yFunwCmGtaurGUcVnQJHCNa1EVw06J5gcViPhq8AMMt+zMmDPbz
 53KciO/Swa/SzsJPwT01IVWGWQJiemKVd1XP9eyEbdBhdB9tNgtL07axBx2tZyYFQosN8iVlheH
 s2x8BLTXnQzYUvqQ/y9ZjixxIhGa0qxhmV+xE95vLSQhff8AVD6zNUonX3qdIOCdaYXPXktGYA8
 OJ6f3ug2U9MLSI8OcBGf32sw4TUP/LPBpuXRnKUxvUHpRf+2xm/P+guO7fjHBvTqOkys7PuOUjQ
 6csnIhqViZ2jOfj8M1PaYoB2LIK9fgL82tnl+6mDyyU81/GhMZfxAaim7rn+e38Apk4fTZkozA=
 =
X-Received: by 2002:a05:620a:3954:b0:93f:35fc:5266 with SMTP id
 af79cd13be357-94421744be3mr1501369585a.44.1793588151451; 
 Sun, 01 Nov 2026 18:55:51 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9442584f028sm725948485a.17.2026.11.01.18.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 18:55:50 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] sf: dataflash: Don't free the SPI slave in the probe error
 path
Date: Sun,  1 Nov 2026 21:55:42 -0500
Message-ID: <20261102025549.257639-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 05:32:29 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the legacy status byte reports a density code that is not handled,
spi_dataflash_probe() calls spi_free_slave() and then spi_release_bus()
on the same slave.

spi_free_slave() calls device_remove() on slave->dev, which is the
device being probed. device_probe() has already set DM_FLAG_ACTIVATED
at this point, so with DM_DEVICE_REMOVE=y (the default in U-Boot
proper) the device is removed and device_free() frees its parent
private data, which is the struct spi_slave. spi_release_bus() then
reads slave->dev from freed memory and passes it to
dm_spi_release_bus().

This happens when the JEDEC ID read does not return the Atmel
manufacturer ID and the density code in the status byte matches none
of the supported legacy parts, e.g. 0x10 (AT45DB1282), which the driver
does not support.

The struct spi_slave is owned by the device, and device_probe() already
frees it when the probe fails. Drop the spi_free_slave() call so that
the error path only releases the bus. The add_dataflash() error check
used the same label. add_dataflash() always returns 0 at present, but
point it at err_jedec_probe as well so that the label can go.

Fixes: 11b93228a7c5 ("sf: dataflash: Fix add_dataflash return logic")
Assisted-by: LLM
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Tested on sandbox only, with a test-only change (not part of this
patch) that adds an "atmel,at45" node and forces jedec_probe() to
return NULL and the status byte to 0x10. Without this patch, gdb shows
device_free() freeing the struct spi_slave before spi_release_bus()
reads slave->dev; with it, spi_release_bus() runs first and the struct
is freed once, by device_probe(). Not tested on hardware.

 drivers/mtd/spi/sf_dataflash.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi/sf_dataflash.c b/drivers/mtd/spi/sf_dataflash.c
index 9094e008f60..3651a585f7a 100644
--- a/drivers/mtd/spi/sf_dataflash.c
+++ b/drivers/mtd/spi/sf_dataflash.c
@@ -647,7 +647,7 @@ static int spi_dataflash_probe(struct udevice *dev)
 				info->pagesize, info->pageoffset,
 				(info->flags & SUP_POW2PS) ? 'd' : 'c');
 		if (status < 0)
-			goto err_status;
+			goto err_jedec_probe;
 		else
 			return status;
 	}
@@ -696,13 +696,11 @@ static int spi_dataflash_probe(struct udevice *dev)
 	default:
 		printf("dataflash: unsupported device (%x)\n", status & 0x3c);
 		status = -ENODEV;
-		goto err_status;
+		goto err_jedec_probe;
 	}
 
 	return status;
 
-err_status:
-	spi_free_slave(spi);
 err_jedec_probe:
 	spi_release_bus(spi);
 	return status;
-- 
2.43.0

