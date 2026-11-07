Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66417606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qmUBCgmt;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zuWk2Yll
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31CF7608A5;
	Sat,  7 Nov 2026 05:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id adzCsCRNOKpW; Sat,  7 Nov 2026 05:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6CD60608CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794029760;
	b=N93FYd4rhWtH9a6VDEps2rER+gfusLloqK66mOkN2+2fE8tNuebH5Pgn8b0BRChm7d74
	 +chO/bhAkP7b1TZElrjmeU+HDiWbTnXlogmMEmnxVmhBrv6wrQm63xMQvbIupaK9x0AWi
	 lf5P8mY0d+QbZZahwEoU/bM1rg+s9IhV9EqEXG0uULexnzKgscnltBlks3GYXyWoYWHXw
	 9U0h+KdoJShQOrvK7cI5xnD3Ncru9ifC/jFj6iOLYKIzOe6FhMpgDkpKX3YRrRrb6k/mS
	 hh1Ec8VuqwumpOGm6VtpJMm5ymCw+qI31+n9Qro7s9d8E9apDodsGuU3X6p7GY9DRUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794029760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0ZwBSgKiTHKdOChfYY+GpuMfyN5jSlc0S7Xve/lbWUw=;
	b=QXF4B8mxR4g1b8dwn2LcJfr88LEu3uOH98C/Jz2KRwRgaVGIFfvLDWuY2i9KjKiMBv7u
	 VZZ0E0zqQz0ErPaGX2REuDuy/xi7NiSv1l8RehRWS1G/szZQ6MP3uZBsSI/Hra1AgtDUt
	 SiPNXcqkIj66VCGfnFHIffTQPs9nTovSipL9/LHvBYRK/RNdzpCJ9LHc7j7hRD6IYt4zI
	 V5bNEKC/RvYvVNxI0ZaPj+nZS28y7D7C8++Xzm6MyKRIMwZ8LSSt3C70y+TSK7roJP/zC
	 s5licondqVfnFQSEGaQPOShzQVf6XZdRF4m1wTokwt8XyRzAG9b6LSpz+knKah5XKjw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	spf=fail smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zuWk2Yll;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794029760;
	bh=0ZwBSgKiTHKdOChfYY+GpuMfyN5jSlc0S7Xve/lbWUw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qmUBCgmt96MT1yOcvg+KSYb1qcEfvCe2gL+qC8sYowrw5Q5kfLXEr1RyGYki/Pvr8
	 y8cH5a2ttQMv0Z5O79zOwRDnf4Naegz/qblYMVjnp64IRcP8UOSj1T+LgdrKScDLCq
	 LFI3CD83J+76WGITzIariKtu1HldLr6O4/faeDjEvvH6RGP7wnSyoLGr3S85U+zK98
	 71Y1CkKdqaKKlw3/6MAbMRMLMTX5tMDU39xamV13i+e44dq/swtfPe3wF1ZVkO5Tzx
	 IJMYDG1Vsi08k1F5kNMLYb2tcD2jNf6i/Fo+CNYwUmFbS/Wwlzgy6jH3zEUEmBB7/0
	 N+b/geZHtgTiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CD60608CE;
	Sat,  7 Nov 2026 05:36:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A31A834D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8934E608CE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O00ZK3ZFYMY8 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 05:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67D78608A5
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=zuWk2Yll
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67D78608A5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 05:35:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E988482B; Sat,  7 Nov 2026 06:35:54 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCAD84820
 for <u-boot@lists.denx.de>; Sat,  7 Nov 2026 06:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6df5e315bd1so1276926eaf.2
 for <u-boot@lists.denx.de>; Fri, 06 Nov 2026 21:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794029745; x=1794634545; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0ZwBSgKiTHKdOChfYY+GpuMfyN5jSlc0S7Xve/lbWUw=;
 b=zuWk2YllzlCQa2wXkMQaJNikkqXqsu7WRVVGhBfhZt7W/bYfDZxkK+DQ2iv/xdapRQ
 FB28Dj5snFZy/cVIVS8YxRGud0AryVq/PND+X4GVRP8Fk1p2VeRnMaddKNMypFZTgJ1m
 zZTO7PVhJZtqSWavOb8PYXvgb7oujvfenZLRKFW2YBRXLf1zilPNKuGN9oq5WqqbL2V+
 x54jM/bpocRA1/VFxe7huPPJRs2G45B5LVAcHTuICM7YU95UHJ7lqzgxHVJY7QBu9Az3
 9XTK78upT8oZ+6meWEZhIE5ki3QHsFsfrJ2Oai0c2DTTh7Al60CzPwi9u8KIHZDZYELc
 JMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794029745; x=1794634545;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0ZwBSgKiTHKdOChfYY+GpuMfyN5jSlc0S7Xve/lbWUw=;
 b=SKKESKVYN0+BZLKu9fxcmePxdUvWRjFzRIx3c75UxVEiy/+OIncS8qGBBnU3w1CH6R
 T1yaIwYIMsNxa7gy/Xf8A2mjII0Fe9k9atkIeYuY1qX5iV95MlhAU20FwQpSC3tIrlqH
 O7HnvB20swP5SuBqTRYyL9BFeh7KEhrxtS0jw7RjjU+oTdIoCj5xfIFeVO7Drg789WEC
 VopWyg5KN/DTF+sn6R0WjBfQngdtEUdSUWkmAwbeMqYIJiwx3wYC/6wL70IDf70emH5Y
 ULim+98rXdTMLT66BlGDzc13zmrHDB9VlnETlzn0MH9oz2MdzwN6DGiHKoLbpX+SLC+u
 S/hw==
X-Gm-Message-State: APuU4Z8VvSdj9eSmWLMG0up8Lf/X++0gtdVPTEitwUdZtg+xzguOVbCI
 M8HAyAXExvlYMYYc9bSAt1K2RJ35TEKrtzjxAEN10eMvtcnUxHwLNXc/V4lfjQ==
X-Gm-Gg: AYBFou25gGziLbk+5o4PyUAKCA3zt6ikovFm6k9FJBpfEqtfrMW0mzW1xJhY0wvfFHs
 Htfu/HWO4CjUXdvcEW8y5Rf3SYLhU7levyn4MpLrgCEyvbKitEh4Xwh4y6znJcwEvrAuYCQFAkq
 vQR0VBTc5Lq+QYx5JsHbynXWa/qzvN9FLJc3AGXj2NDoteCrtP0/iPldBYR35KhSi7t/8VqV4W8
 dtwyumTdLyeNMZWTQEvyEnkKNKGzGN2zuXh8Un4Xh5dqQvc8Z4esiv/iZ0WLUBPznA4HQ15WVUM
 OEIzsss8QRiTNBkrpSOrKdGenFH3zD7pXiEzexTHHorTsu0RRqBlejrnoi+31pnH8lRnISxB2Kc
 5F7todoYch9rCIAGM6yftz7O3P6mxs4UEqVwmnNRCU5VltfmXnUhKiA9id5SYgBRcll7U62JXwy
 KxcHvL87ni/0H5Lg/zM0oyg94BD2wkN1uJQn5SgjMOhLzd9JvB9VVAByNkYGeoWKzgHFHfLCFev
 1CSeLtjaGgtHTYqFdHDZo5/FPXhBgYT0oQiMQW5XfKFgntNqSro8fNCGfLB+zq6489H6X3PM/Wj
 6crrX9ITMemKL8/H4OGgkWxPuR0jzCZOUQZKHmuaGwULZlRELAzA8xWp/xEoLzM7XDQzJYQgxT/
 emIn7WB9POdp7Ob05ZWMAYo81Ew0qSeX+wFIdB4DfLdhvRjOvP82V04F9geG/F/80f/yfnlF9X7
 oFyFIxkKKd+DARmGAOSUq/htmLDKgGFiy4foeuWTZ+DRmNkC6J0Bw=
X-Received: by 2002:a05:6820:1686:b0:716:e9e0:543c with SMTP id
 006d021491bc7-716e9e05824mr2411592eaf.61.1794029744850; 
 Fri, 06 Nov 2026 21:35:44 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716ea0d1761sm3116661eaf.7.2026.11.06.21.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 21:35:43 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 06 Nov 2026 22:35:36 -0700
Subject: [PATCH] tools: sunxi: use zero padding for TOC0 images
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-submit-sunxi-toc0-padding-v1-v1-1-87071da9235a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCQAyF4auUrA1MSmnFq4iLMYk1gtMyM5ZC6
 d0bdfX4Fu/foGg2LXBpNsi6WLEpOejUAD9jGhVN3NCGticKPZbP/W3VJ62GdeKAcxSxNOJCyEH
 OHQ80SBTwxJz1Yesvf7397f+Xcv02Yd8PJjRVDoAAAAA=
X-Change-ID: 20261106-submit-sunxi-toc0-padding-v1-c0d84c717dad
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The TOC0 length includes its alignment padding, so the BootROM reads
those pages through its NAND ECC and randomizer path even when their
logical contents are all FF. Leaving them physically erased does not
provide a valid boot-format representation.

Fill the trailing padding with zeros, matching the vendor TOC0 packers,
so flash writers that skip all-FF pages still submit the padding for NAND
encoding. Keep the existing alignment and item contents; the container
checksum already covers the padding.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 tools/sunxi_toc0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/sunxi_toc0.c b/tools/sunxi_toc0.c
index 76693647a09..6a099045f10 100644
--- a/tools/sunxi_toc0.c
+++ b/tools/sunxi_toc0.c
@@ -541,10 +541,10 @@ static int toc0_create(uint8_t *buf, uint32_t len, RSA *root_key, RSA *fw_key,
 	item_info->load_addr	= cpu_to_le32(fw_addr);
 	memcpy(item_info->end, TOC0_ITEM_INFO_END, sizeof(item_info->end));
 
-	/* Pad to the required block size with 0xff to be flash-friendly. */
+	/* Zero-pad so flash writers do not skip the padding pages. */
 	item_offset = item_offset + item_length;
 	item_length = ALIGN(item_offset, PAD_SIZE) - item_offset;
-	memset(buf + item_offset, 0xff, item_length);
+	memset(buf + item_offset, 0, item_length);
 
 	/* Fill in the total padded file length. */
 	item_offset = item_offset + item_length;

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261106-submit-sunxi-toc0-padding-v1-c0d84c717dad

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

