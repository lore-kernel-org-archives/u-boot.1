Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gB9V/BsZ;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LRCThZSY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D4784082F;
	Wed, 18 Nov 2026 00:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BiZbLcHdlv3M; Wed, 18 Nov 2026 00:21:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 298A6407F0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794961319;
	b=fR/FjG2lVUKfMn0MP/Nhrc7AhnHvsB4n+IdZd2zAuEdlS5OU5gzfar/JG1Ltv4TZ3s4s
	 Kc8MqFIgnp2VEA8LUSIvGa7X8wrbxhlI8O+SsHrTGU9idpyemSwdX/MRMwnRZxC5JM8BC
	 YsYUrrbA+de+VwEAn8Dmb8jnUjtvSlfTy7B22+5aREI7YnvmhHcPRX+XlOy4FwXdKwqQK
	 RfPwFreNqNXqE5d+29yBjCleD5ff3HOJdX+OUhGZ6+n5S3KDxMLVaeu/oQo6RK1lOih0V
	 I+pYIh+VNSIS/1KtBKGccPwLOQb6WlFhS7YzHaJSzBALecUM328611u9muTGuT/6mbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794961319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WzGVM5l/bBY9UZnfFfysvdHozSt1w0mu3Xc1MF0OQbM=;
	b=joKYm8Ewgq3Sr1ICDO/gvJHKM/t+JU0/7Vo1053DZmKy8mz4J4WiVg5m0l8GuPq8m15X
	 EnCHXVkPmxImu7CKr0k9fdiPzSXqRIz491xrbAL4neBfA6Jk/EmbRWMmW9N9/DxyGwlKW
	 wGhM1S5eGgkG0GpiBnGS6j2pV46Z8cKJIuwy+MJttJLCr17anX3VHytjo8v7G9ZVdSERR
	 c1//N0StOqZ/noixjSRjG6QVY+NhKVZe1tUO0jnmNQxVTmBVKenzmuM870uTjNtw+0U3z
	 5ulGPn9WuPds8d4l/pfCNaDltZN24EDwke0c9Qdn2zWkgB9wB41oxrd816D+EuPMuig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794961319;
	bh=WzGVM5l/bBY9UZnfFfysvdHozSt1w0mu3Xc1MF0OQbM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gB9V/BsZvEkjBfiye4gO4cOgnplpC8sVMFr/jdCzjdlSPoqcta1r4cnihBjtd5Gga
	 +h+cRJAiYdOBXbBOKUdMdX06Xkzho7z1p/C1i7xD6mIPiguN+3e+ySDK6H6Ru51c4H
	 yaIQzNf5vy+tXeRroOS40CPsAlbsTW9iDpTj6vYSULLbfYAV4dfoHiRJDrKwDwhcmD
	 GR1bWjUG5PPHWiFGN/udsnTA26SLRYH6EAboa7tnwmifj34UCS1Mn7Pso/tEU7rlmF
	 KzvvS8Lrz59VuVuPb7Vm0tduWZ3ecZp4VLE/Vb5xgttcTEUtlJLFVUcH76oFEvkZ5E
	 r8CqF1FwdA8fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 298A6407F0;
	Wed, 18 Nov 2026 00:21:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73DE9A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 00:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A07180E5C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 00:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vd8cqnbDXePD for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 00:21:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 396DC80DF0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LRCThZSY
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 396DC80DF0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 00:21:55 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-8479f46ecd8so235991a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794961314; x=1795566114;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WzGVM5l/bBY9UZnfFfysvdHozSt1w0mu3Xc1MF0OQbM=;
 b=LRCThZSYew0ccqIlMHXaw3cgQmczvdrOi0Wb11NQ4xGAY2VfRaW3tMIAHyT9cLO2RA
 0K/OWXRl0QQwTBMhCeVxlfeas8s0uIh9GX2GfjQALuoILG+8VnIgwIUwefWDqawAX7PM
 yodh0KmyDkW54gHLJpmHaGIzBXXMcYTH9g9nJTUd6ofpTx+a6na3EYhNCcx30slZvqyU
 0DnzwyxHPa5Ujsh3g5OzREceG3Cji70wsGz/5t9wc4JAi6SCC9yXfK9/0+10vYtvweVE
 Ld9melO5Wv8EEwXj0PwEhDKeLKiCkF6Dr0rqYkJqprWGvTmBfMLROyjJIIh/BPcPR1hj
 O4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794961314; x=1795566114;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WzGVM5l/bBY9UZnfFfysvdHozSt1w0mu3Xc1MF0OQbM=;
 b=P2H7PLt+KUHi8hlQs+H3jiBDUsijv7vqK6sGdrOo8qRDaXfy0VGCPMrDmJW8kaFWiM
 sk0zAwNKELuXxdyEqdjsbJnF+70Tu0rAN/cPjnRwCa41jq9/AF14KszOAK2IwDjyVZ13
 3ZKwbvVcveTi/D7kdNIqgHtvsOyu1Ky+YZe25IadNwhd08G0IFlxnyZTVqCfsg3lKvlD
 4ukltp+oU8V01zxZYPsbWuOsXKlK+prwZrNRiDQOSy/zP+NY+FCbVHRpB3IZbkSYzTXV
 GtLrwi84xx0VPqYn9PW+/gV6vSeVZ53I0lKDzkUXPMdsYGR1FyvYSaEhBDBYRhGnfKn4
 tQug==
X-Gm-Message-State: APuU4Z83WULNfQdk2aOsHgposbTbA0lFnoBBLKQD0PQvkyGfu/mdEvS4
 AeJZGEX9dXzjimChdS/btWSW9MAJrHLk3q1dkRcBxZqgNFkT5bzt1GReMXHH+ZdhK7k=
X-Gm-Gg: AYBFou2sHw5mh8+Lfh6dBCkOjFPHaDSQ7qqXgy4EBeXC+doKzp4QHu8kMRaIqKmkjXs
 DM8zKhMF8Zc2LZxaO8QlmMVRKE5dKg1Bs94h9Vmle0SQuEUbKm3hsp2IfF/OsynWPmlgW8yvFsm
 r0rVXH6nttZkm0tkNaGSBl5iJelD3j/fRplE0dQvchpYBCJ2F3f6S64+CiaS9caofURkUWVF5oa
 OQ821gkW7ofArxoHLgW2AwKI909lEVRqw7W5noqz4dkC6Nj00zZPxfYr+F8CKJbVL65e/dGuBYg
 lCG1e11L6xtaTzDycgjSW4NtaYJ7lKrT+wjlcHevsaJsS0Yelt2XKnObKtzrG8DTsKGKNZinYIq
 b1DFgj9XC0RWpG7GjX7WFmMTJ1xtQ8+NgGeZdeT/MHANRR3OYYscD7O4ylN35SseCFFsYJtJtOS
 uRgX1jaIIJt8Og3HFy1U/1AaqF3d30RTB1Y0fNR7sXWYP9Vjhq/cakV89MSwUQZvTsdpGaF+oRd
 /Y1O4OgtGwty+H6wnVndRaTIU/zQnCGe8IfdySYh2jkA3inWY6JHZpnE749ocZoJePr67dz8t8Y
 zyBRoSG5qeUvJJdYsQ3d642wc2xy7bNV0A==
X-Received: by 2002:a05:6830:2315:b0:862:ca2e:919f with SMTP id
 46e09a7af769-862f090aab0mr1119747a34.18.1794961314090; 
 Tue, 17 Nov 2026 16:21:54 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4c3c:99a4:6f4a:ad27])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f0212ea3sm818260a34.17.2026.11.17.16.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:21:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 17 Nov 2026 18:21:43 -0600
Subject: [PATCH] fastboot: spi_flash: fix getvar partition-size of raw
 partitions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-fastboot-spi-flash-blksz-v1-1-17965dcd19e1@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAyA4VchPdvEziDqqxgOHXRSJYys0xgI7
 +7U43f4/xVMkorBpVohyUtN41RAuwq6gaeboPbF4PbuSEQNBrbsY8xos2IY2Qb048MW9Hzm3h2
 oOYUaSj4nCfr+ra/t3/b0d+ny9wfb9gGRc/nAfAAAAA==
X-Change-ID: 20261117-fastboot-spi-flash-blksz-ba9ad23178f5
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VpOg5b3z9LXrWzpvCyUFqY637YwKdhNC5DnvEN1F8gM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/O+YgmlLBbH1Fq/cEJVskRGMDoL3AiKU/j9rv
 2pwknZ8aCmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavzvmBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/APy4H/3RRhwFMPWjUuKrLefG2PT2LbSVavHm0JkQyouo
 /GB5sF2rHsxrQGgkJ9XiUIKTEjsNr3LnP/GaGw3noB2jQuSZ3hhjzx4Lh7f7yqUMsDAJH7cndCC
 DFSmYGl2mmIf7PjjjuAK4fAz1ePN1IIDCoTzAacM7vZqnZ6wgWiMfm8n/nk27JRfq+y8zFF1Vwu
 V2WdUZYM6Pj2Nx1hpuDit5kxkrXNKUY5CHxWS+f5oNerPmFmuv8YGpsGWieox+BT8sa4a6ukbOm
 yxeevD/7h/fD/CupDalQb2iCxloGeIoCv0TaOh0jtQxFEFN5KQusuKjDY9fh1WqdgzVoZ6yxcdy
 rEIc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the block size of a raw SPI flash partition to one byte, the unit
its offset and size are given in, so that getvar partition-size does not
multiply the size by an uninitialized value.

Fixes: afca60620ad7 ("drivers: fastboot: Add support for SPI flash memory")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/fastboot/fb_spi_flash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fastboot/fb_spi_flash.c b/drivers/fastboot/fb_spi_flash.c
index 691be7c7ef7..b15e633acbd 100644
--- a/drivers/fastboot/fb_spi_flash.c
+++ b/drivers/fastboot/fb_spi_flash.c
@@ -52,6 +52,7 @@ static int raw_part_get_info_by_name(const char *name,
 
 	part_info->start = simple_strtoul(argv[0], NULL, 0);
 	part_info->size = simple_strtoul(argv[1], NULL, 0);
+	part_info->blksz = 1;
 	strlcpy((char *)part_info->name, name, PART_NAME_LEN);
 
 	return 0;

---
base-commit: 6201222134cd704b5717211fc917e2ca6263577a
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
change-id: 20261117-fastboot-spi-flash-blksz-ba9ad23178f5

Best regards,
--  
David Lechner <dlechner@baylibre.com>

