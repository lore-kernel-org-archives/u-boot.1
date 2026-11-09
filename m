Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4032606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wy8Xiac2;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=RZrl8jcd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E49F810AE;
	Mon,  9 Nov 2026 21:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G88gkJHto83k; Mon,  9 Nov 2026 21:49:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A22481063
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794260940;
	b=qdprxnE9pUZHaAHW9YOzRbYs6ByxbvQm7W+uBdW1GN4KO0btmZLDvT2eK00XS2X55AMm
	 2XbsnofnmSZREM4xhXml8Un7UhVESqfRemmuZBtI3K+iSq/3VllJQgt+MMa4F3Un4RzF4
	 SkTeUsu26YlS3l0YYj8TwMgkCEvkSkLv5wbGqxtMjNSMcd/rz5odmBSFM408HXb/+ZukE
	 lwEY+gdmlcw7TIEJXmFPPF4G92fjsh5XDtvCvqxhQebVWhUP+AVGgyq2fsbhS8KvpjUI5
	 QrrSRkqeD93bAMIb793iJGhus/nToKIaAKx/02wuUiwloc27RtLU1Qrkjr71nL9EOfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260940;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gii3OLXnfyU+OTmm4LzOojqR04Zcr+CRGbDZbRPeGSg=;
	b=hAqiBebvQH1PYEFblZ0kkM9hCtNr3NzIhD7GjFkWwjpoDylhGmhD5F804MEcTLJRIlNj
	 qwkTkUATX65BYsIRK0bXsyCybYkM30QYtXqMsN7xxXg+GtCvuFooBMgwa2LsktmZBQGWN
	 c/ypyVcJbEvGYEZr+MP4GgqAKVX0SA7E0wQbtV3B7k69SwfNVIYfYl58IoovJxM+F3ldx
	 Iak0COXZoLGPt+F8DXnmhQLZrr4ftt3APSsIG5dJS/DQoQXiLmGx4zeV4Tufqc4VHgMg5
	 5UIPmRA1qezmiJkwZmqzozo6gVhe6H14TCcPB5MipC0yJUCCtmPmmjEBQ82vUy1w/og==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794260940;
	bh=gii3OLXnfyU+OTmm4LzOojqR04Zcr+CRGbDZbRPeGSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wy8Xiac2CfitvxhcQ64v4baHZHGJourmXEgeq40p2DtWthfnedBGET3/QPkKIztHc
	 f8v569fTpDckDNxLMd6BXLWeEc8cdGhYp4D7utEqgGqJ0QQtaTD4pRqDw7x5BMJrmN
	 fiR8Y3CcIweXgtpYHovlBMFgCHKhu99yotvWjIzE4soVBXIhNNKtYdfKwtKxEveuXt
	 pfu57C8LAEiNkH9lnSqQgyZ4d16tXGzh4VIILrff7Ljv9vXMdKhQtFj1MKamlr6UhD
	 Lwl9sA2Y7G5IKxQjbmMigaVi4qzwFksVhD08uvEeGwCd6Uoql+zYDmCOScxMR6ITxj
	 jmb+Mvqjtic+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A22481063;
	Mon,  9 Nov 2026 21:49:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 761B828C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67C7D4030A
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DLmf5nYNegXv for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:48:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7B08B402EE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RZrl8jcd
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B08B402EE
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:54 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so12925465e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794260932; x=1794865732;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gii3OLXnfyU+OTmm4LzOojqR04Zcr+CRGbDZbRPeGSg=;
 b=RZrl8jcdkBnGlc6Wp7FlITbRdvWQUFcUCUvGJ1LRm3qGaRvKyQrkpWfwANUJN0LmaD
 QNSgdCLjAdLIbEPgnrFj14z6cjSJEcRVZtLwYVTBZY3PywSCXGubAB+2qcJWd3H3RNW6
 LLreyJu5oH+8gpcvsMSwLbMmE0h9mukXVN0D1WbM3YWlM1P07NXGJfyGlVrAgYlJKQQ3
 HpsIxXKn7M7iH0kkdQMasSbLEprD7/QUGRcuV7Ac4pkNIz4hAr/h2STYfyYrL0DOX17S
 OJ6Scs6nMmH0OGeeNCwlqE1xttVm/Ox9O54yeWWrQYS0ww/DHarlFxrufE5P4TVp6YW6
 1AQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260932; x=1794865732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gii3OLXnfyU+OTmm4LzOojqR04Zcr+CRGbDZbRPeGSg=;
 b=fJh97gELzPnkbWyRjkoWP7jk4Fkz0maZ3UcGqooR0V6XRnTPSPbI9bs5CBgLfnTcxY
 HH/dHNKbJLldHM8hYFc1+jWVWu0+osrqy1B/GtBpFs/AHe3ecqAH7vWxmoU6GJWk6Vc0
 JDTVFTIuZvRGL5eBOKbuGdoFaFkolUb5R1lJfRxatEGhlQQ6t84KCKr2yy5DTCmXqFmx
 Z1jcXNckQPsAnjx0b0cwR49HsxvC+OdqouHzbcOSx+SvUWAnzZTUe8RmpYKN4FgMoLAa
 XXUyeKmUHRdKd2jXEaPxW19PcgWDmhmAln8Goy/MGOvOq+1QDgYNX/0jFKMxo1NO6Rtk
 0Efw==
X-Forwarded-Encrypted: i=1;
 AL+hErE9bz6XNh+CIL3FIVTclKRinL9tlqMhKsg/FldHOJ9WL7yNceuk2XbK6sGz7WlKr1jZshpJ9wE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8rFyPVLCizyGXAz/FJerEdUeXkpyG0wnkbBOR7lvZFS3QlWRk8
 LjHrQ/egT+LKpgrR3KpTCs7ZddxhGZa/B8ibi+mbhxn6+fyekuKGFD2TClrGQq2XeBg=
X-Gm-Gg: AYBFou1+2kv0LN6DcN3b4grm23rk60fXQPttZ5OIlgkds1+/Uix2YDjxCNZko1F24IR
 nFG+SELbXubYJwoiGHax3BTXe6/XpwgRyrRdTyhVfjdoc22ulVjxQeeW2xEkFWNb2g8iQSfYwSy
 SMfh0afdiG6flJVF3ES/g21H30A7VIPqUxW3dEx0MV6jqoBhgP0ciR1AKFpsaEW1rew6tXHDl7S
 mUG3UfA6nvWw/USzPKVgwuzosskfAvtNiuR6GLS190+A1b/2qH26wlfPo8G47oWau1sSNy68jU5
 SQm/AcN6tomf+U0Gtz8TiOHxi42HaawaCRKbPBBI/4BZ2CMDywO/MWaQIc0TPiilGxe56OTbEF7
 uflqfHTCeNcwozaAkDmpNKkb8s3StQEgZ0tHT8QC9t2GbsUgwRIZbAJ1xZtN9t+A8P4ZtnSHcJN
 u/W0BMNUQQy2hlsr3M1afWaKqfLDd43O+091UDOGTBRwE675qHUQTGVRlrRM4KEOMliEtoslrFH
 A5fF5MSoLcS1iqnbrKIxiE3q5lmNaCHsBINcQmA/w1mJn0Rra+k8uoY+3P8F9yTejvDJdU1Tgtw
 Ix+lg7qjqmGLruBvsroPd40Td/Q4P2wmLJr9T16njesI7fSQr35kVCeJCr6Hs7u9BJDD0IUuUnq
 IkoJYTRdRPLxI+Ie8WA==
X-Received: by 2002:a05:600c:4f10:b0:4a1:992f:d0e7 with SMTP id
 5b1f17b1804b1-4ba023410d8mr9247655e9.16.1794260932017; 
 Mon, 09 Nov 2026 13:48:52 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835f1772dsm1169903f8f.31.2026.11.09.13.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:48:51 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 09 Nov 2026 22:48:19 +0100
Subject: [PATCH v4 2/7] boot: fit: free temporary image buffers on load errors
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-ccaione-upstream-fdt-fit-v4-2-5323cbfcc9f3@baylibre.com>
References: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
In-Reply-To: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
To: Julius Werner <jwerner@chromium.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FIT loader can allocate a buffer to decompress an image or align a
devicetree. A decompression error or invalid FDT header leaves that buffer
allocated even though the caller never receives it. Repeated failures
can therefore exhaust the heap.

Track whether the loader allocated the buffer and free it on these error
paths. Buffers supplied by the caller or inside the FIT must not be freed.

Fixes: b1307f884a91 ("fit: Support compression for non-kernel components (e.g. FDT)")
Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fit.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index a9d86d124c7..fd43e1fed44 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2255,6 +2255,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const void *fit;
 	void *buf;
 	void *loadbuf;
+	bool loadbuf_owned = false;
 	size_t size;
 	int type_ok, os_ok;
 	ulong load, load_end, data, len;
@@ -2489,6 +2490,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 			loadbuf = aligned_alloc(8, max_decomp_len);
 			if (!loadbuf)
 				return -ENOMEM;
+			loadbuf_owned = true;
 			load = map_to_sysmem(loadbuf);
 		} else {
 			loadbuf = map_sysmem(load, max_decomp_len);
@@ -2496,7 +2498,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		if (image_decomp(comp, load, data, image_type,
 				loadbuf, buf, len, max_decomp_len, &load_end)) {
 			printf("Error decompressing %s\n", prop_name);
-
+			if (loadbuf_owned)
+				free(loadbuf);
 			return -ENOEXEC;
 		}
 		len = load_end - load;
@@ -2505,6 +2508,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		loadbuf = aligned_alloc(8, len);
 		if (!loadbuf)
 			return -ENOMEM;
+		loadbuf_owned = true;
 		load = map_to_sysmem(loadbuf);
 		memcpy(loadbuf, buf, len);
 	} else if (load != data) {
@@ -2521,6 +2525,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
 	    fdt_check_header(loadbuf)) {
 		puts("Subimage data is not a FDT\n");
+		if (loadbuf_owned)
+			free(loadbuf);
 		return -ENOEXEC;
 	}
 

-- 
2.56.0

