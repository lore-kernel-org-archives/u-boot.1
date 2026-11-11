Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462F606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PvkxfbBx;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=V9euE8M2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E9BF40A71;
	Wed, 11 Nov 2026 10:21:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rqnRBqm45bE5; Wed, 11 Nov 2026 10:21:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C95DB40920
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392513;
	b=PjfY+cAT7PyNpG2FOY/d4wXybrMIcQQ2N/L0enAsu+SQrBvgOyh3Qb7vEWXWoIJfeRNc
	 dOKUWWOWzgNbZnNfdoxgOrMk8umgcOsIorwtqBZJeh1wcrgXhrp7MhrFXsWnoWeOyQEHK
	 h2WCNsTfW7bjUiWXAEx3u+vY2vE5emV4bnQRGmH+2bt/J/BbCFvMSVIyDRSM3HpPvWwHB
	 v5jgSkdjQ+eJdf6q5IcEXFv8KDRkOHAsQg36UpmdHirPgN+ab2/lS3NOt1AsI9ZjNRMrN
	 qNNWaG3u9Fl4F0uYyIPef9rNmdaju/qtcxvtW6j4PrPRhb5YM24Fcwhx29Nz1h1MS+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OG/jFZVAiaF1mkN6+CeQaXHRODn6hi/FAdGbtixxif0=;
	b=R8k6RRZw1VrBqYtGT+f8oR7WColxpmZZW+AUNo3DoKIr/q14S5NWiC+MgFqIMbMiBy/I
	 /5WQg02MfN8rKalL/h89/3BbAEVGGM/NxwwqZ4xzh0Si4tm6WbawxC0k1lyIoIY/C0PY0
	 AGxdMkIWfUAEO/to6VgKo7zg3uXEXn4Vva6pVkFJxF/Yf/51SiGqe/j186cilwP2qzTZ3
	 YiA4xFHoEUYCKhb6xs79iGxWjMogEptSAnT2OFlZS+eYs8mjyU4J08oo4IrtFo6Bmt9pD
	 3Ok7erNPr2w4Cx5b/TmMX6eAg64W5Sw12HAxWtORDlYnJW5WMepFkmHrDHPvm9+mhVQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=V9euE8M2;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392513;
	bh=OG/jFZVAiaF1mkN6+CeQaXHRODn6hi/FAdGbtixxif0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PvkxfbBxMepIEes9HQ/I7C43a7kmuOUidiunlajneMJO4HJyIMjI7gPJML92wbAo3
	 17gjuR3WFCA7FWJBZyPyW+HzoSCG5hVryvVEDV7BJ+bQ0JSo14m7+OBtszY0bFJb86
	 8uSWoR06vYFzOBj8UPoGFLIeLftn0CxFEHsYOn6dY4sBBS0qe8IST64xGK83PKdSjk
	 R3U0rCrPQe3ipG+4xE/iZJSYV/ROc90WJygGciyfNjkvW92iv9FAo0r+w/h901vuH6
	 jCC2vYAIPhmXZ20NEU63h6EYRkBsekJnUQ6PY84oDfEsiikhES2ADmZKYvJVew0YR4
	 q91GyxKg0vagA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C95DB40920;
	Wed, 11 Nov 2026 10:21:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E4D91A6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E819340873
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XLG4Kl19vVI0 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:21:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8AC140869
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=V9euE8M2
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8AC140869
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:46 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1927435f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794392504; x=1794997304;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OG/jFZVAiaF1mkN6+CeQaXHRODn6hi/FAdGbtixxif0=;
 b=V9euE8M253+PccCPkfUWzC54Qwwl7RXnvfVo02GzPQyqV0hbN9djg5VQ9MpI7jqKyC
 ty4BLUuXukQGGzHGV6X9x9VQUWTMFgk9Nd5H69S++RafhoBzezD32ML7/U2VD3JUoxsR
 5ZushlQpWC9toOkAKa3P7KCNb3NGCvTyMFlZ953CDmYB9vWdxNFgMr59obm5oWcXyer8
 H2DDfhus03iCFHDqATw+dWKWLr9NB/m3oHtTWjtmUnXxeO4nJ8lx3wUjvDvQfhPWdxP5
 HdsbS49GmJS8sN88RAR6+AToIai228kfCERE4gYz54+hRykZUlQSmrdhwXuPjTL7bM/o
 xqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392504; x=1794997304;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OG/jFZVAiaF1mkN6+CeQaXHRODn6hi/FAdGbtixxif0=;
 b=EX3u0H5Fds/eLAOyjS0lP/IYe7ZDsJJWPaY/NYi/M3K9CYWbR8F30DUpOAqy9y56te
 N4XAYQeuRIEudNszXqdCPCYDdBHxZFPkaRIIUe257XqvvLZHqexnQ1PwT1OWv1NbIJdq
 VJ0tolZWWkjI9vzhA6dTaX5BZL4iygugH5SdBdsCkKe0XxMR+y/mMUontbMVWwK2RlYZ
 ArWeFHnUPXLZcra0j8llrhcQM5+AOV/ABOvZXavCeSdx69Zdj/LqHDNwqYjgHp/2OmcJ
 HsIDI+lZzm3nVwcUOb9e2b1ucAHopq2YMngIrOWz03lsxtl/ZnSbUH4ehIH33ZLjiNdV
 WiwQ==
X-Gm-Message-State: APuU4Z9vmEHAPoCTokXz60riVH6xJLn6OMIMa6IcKuidjVgofri2OaZO
 3Z0L49mmdflAlQoM/P3h4Tac9FcyCAtodHXMPky6e9uauT7JSDM16lzRwYOtVa0ZEqs=
X-Gm-Gg: AYBFou33Rys5orsxpZUixYSMp/TZCEz5bo546nQjLzIgonRN/9X6bcGC4LlGb39ev4N
 kC33QQ5JQmH58tAL+VntjwiYSBf7KWEl1HSgaL8jG6BMOpTwWQqaJ/LPH6/NW/+jrFkrWwjYF45
 S1cwCIq5gN2GNcnDnrwAR/j3LYhwqOeiwI+J8YYrJOumPWRQf/CYH/I/M1XGib6QZntHqQ1odgK
 96KnveNF1kFN7dDYgXoQ8gsAfXFn3lOqUZAu9fcBQVuO+xMpsC95IqqXxMAtQCHlOTXW/nA3+wy
 mDg1RYOn/McXac1nCz7MpSlrBAFdp5WBApPmKwhYGB20x0hJqvCTm1Gpqdag+MCaAenh1hAXrx2
 YhKifq50Q4LV5N2q7pHv3eWMicMfgkEKwlgjMnCK4O8iAkd2AJXMR8MkbwQGQzsk+9PBU1jt5Lx
 cq0MLviz6rvLjckxLZgJpK88D3w1Q1zkGL7l5sxF2WRkvyFIc56qjdrDhXu0obMoGbHpNJXoLmn
 QRtLFAW18/K1VrxKKj0JWedc6FH6q5iwG5Ij8V/XHF0IJyHCnzf7EDiR7ebaEFoWbdUxldAp06U
 hiHOfhNM9CfPXjkDolX74BAcJQuxyp7wyQAwha/d1/kmUBKDlcX2AcXkCoilTCiQ4NOti5beAeX
 iiLOnoeq1vD8PB+0pTGhSgumv290ZIlaOYrECaa+A6H6aLA==
X-Received: by 2002:a05:6000:2489:b0:48e:7a41:d78e with SMTP id
 ffacd0b85a97d-499c7552a56mr3162813f8f.19.1794392504631; 
 Wed, 11 Nov 2026 02:21:44 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm10550001f8f.18.2026.11.11.02.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:21:44 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 11 Nov 2026 11:21:34 +0100
Subject: [PATCH 1/7] ufs: rpmb: validate requests before issuing commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-genio720-ufs-rpmb-minimal-v1-1-701a62dfa034@baylibre.com>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.16.0
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

Check frame counts and response space before issuing any commands. A
malformed request must not program a key or write data and then fail on
response validation. Use Linux's request shapes so surplus frames cannot
be sent or silently discarded.

Fixes: b3cd7ddbbdd5 ("ufs: add RPMB transport over SCSI SECURITY PROTOCOL")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/ufs/ufs-rpmb.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index d9d35a06439..508eb74d976 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -157,16 +157,25 @@ int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 	int ret;
 
 	if (!scsi_dev || reqlen % RPMB_FRAME_SIZE ||
-	    rsplen % RPMB_FRAME_SIZE || !n_req)
+	    rsplen % RPMB_FRAME_SIZE || !n_req || !n_rsp)
 		return -EINVAL;
 
 	request = get_unaligned_be16((u8 *)req + RPMB_FRAME_REQ_OFFSET);
 
+	/*
+	 * Enforce Linux's frame counts before any I/O: a key-programming
+	 * request and a write counter read are a single frame answered by a
+	 * single frame, a data write may span several frames but returns one
+	 * result, and a data read is one request returning several frames.
+	 */
 	switch (request) {
 	case RPMB_REQ_KEY:
 	case RPMB_REQ_WRITE_DATA: {
 		u8 status_frame[RPMB_FRAME_SIZE];
 
+		if (n_rsp != 1 || (request == RPMB_REQ_KEY && n_req != 1))
+			return -EINVAL;
+
 		ret = ufs_rpmb_send(scsi_dev, region, req, n_req);
 		if (ret)
 			return ret;
@@ -178,20 +187,17 @@ int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 		if (ret)
 			return ret;
 
-		if (n_rsp < 1)
-			return -EINVAL;
-
 		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
 	}
 	case RPMB_REQ_WCOUNTER:
 	case RPMB_REQ_READ_DATA:
+		if (n_req != 1 || (request == RPMB_REQ_WCOUNTER && n_rsp != 1))
+			return -EINVAL;
+
 		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
 		if (ret)
 			return ret;
 
-		if (n_rsp < 1)
-			return -EINVAL;
-
 		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
 	default:
 		debug("ufs-rpmb: unsupported request 0x%x\n", request);

-- 
2.56.0

