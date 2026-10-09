Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06B9CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2777608C4;
	Fri,  9 Oct 2026 09:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TH6YbSLYXN-l; Fri,  9 Oct 2026 09:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A016608AE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791537402;
	b=HcJZ916SMllc0BX6UGMpkJdtuM2SferHnd3SMm+t/x9x1OFPhMa1fQqMTYi4ptxB253J
	 cP89zBmuVXFov1yz2/7RCP83frPIXJL8U41p1PRDWUcRZfKGNC24zO6wdluynlb3A6ca4
	 jDyQAz2HLH66njP/2AIs3i0f78IVZC9CIgdpSS88W76jxsEwQd51m8QLlioVzO+2Wml45
	 Wo9DiL0fL4xo6Mul9Loffo/539EvixDZzFwecrlLp9Yjl87lVJD3XSA8DZnH/muqws9zF
	 OfYA8T0X9hF2avAKei+x/takkuL8bRCGHJyYjhknLPkois7rd0DJItx1Y5dZLX3Wdgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791537402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xl5ZBp0xU1QNeiG+/e9jXLSjpvxaqXzYlaNmoiV5f0I=;
	b=Gv+7Zg7E2P00vtayoYd/kUsMVhNhVEi5AgxDr4H6DkLJ7SeZRG4UIyOgxd+YmSEpt0ft
	 eDLu4mE28a17a9N5aTgBoEE7ZMvz+bq8YtFZC76knMDkf4bJ/dS+qgqALWhaJDqxIye3S
	 dwclvK4a7CztTs27u7JyHfHe+De6GE90KXZLkqWOcHacozDzHOxSrA6GZcvgcsA/KQ7FU
	 4at+yNoJobjHWGRixgnBzscEqOyTbiRp0ixHbNI2xf13/i/Al/gE9MQnVUmy3z1LXCcbX
	 k7f/q6OfX0Eqtdhegbiu2JuEaJnfX/8kfZYZpYEM12hk8lfV+Uc3JgYfEjI3hbKxO8w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791537402;
	bh=xl5ZBp0xU1QNeiG+/e9jXLSjpvxaqXzYlaNmoiV5f0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w//QeUq/cpfgmKXWsRg81T4IaHrlBt4KR+L+uXpzoKpVGKsks+n8SAOAcW8G39jqg
	 WCw/DQwnVsY7dgeWpHJUUAoQ4dxKTy12KT5Xkd/2pH8AHa0EH3XRh+fG9+E9cXkZ9l
	 1/7NC8xkbHZ5c+9GGXnQ/YEB4mFOico2iMNTSvJz0FsiHN9Z/rcAKsHxMGJRlqlMen
	 U1QfQ+z2CDdHa4tSL9HeqVUxp/E0b5tpgGktib4jO5nTwmScTxIoAz/57/kU6mNei0
	 lxSjZnP3cihHNIlVxNCrDmy+p2feM6jCtf04/narUN/mipCUA0r4dStN7eOCLEMYxW
	 cNCwlaa9/1QKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A016608AE;
	Fri,  9 Oct 2026 09:16:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 304A42E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1676140889
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yRxyyvHtOP4t for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 08:53:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8BCB340887
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791536003;
 b=ao0JDcA1tU4M0aPpSSV8Sx0z0DqQ+DeTTZt+DkG6Qqfl1BO5AFcEpJ/VdSnik6bsrFhA
 KwzDhyoSgS36cJnhoUUg5M1Zci8u1/WZX2eBCwJwXQoTrF1Uxi4tleyQDChEh63QNscTM
 opSpOo/Eh56iZUKkCeKqOVgb5JodKRIhk6cn1UiXqFfkVzYhNv269DE5nl4hNTHmSzE2T
 skgEzcMAD4OBa3D+MjQXoek/0IrmZdt4vbs+cI5B3Vj7aStFRaK4rrllvKQhHTlbeXYTO
 CoJbTMwh8z1Jlz40VGgb8Au72QlfSonLDRFfjINZvtp1ifEtd5k7HhZzTuMR51U3APw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791536003;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=xl5ZBp0xU1QNeiG+/e9jXLSjpvxaqXzYlaNmoiV5f0I=;
 b=Vfjac+NlvOxU7a8JDlTlRKvc0Shpd/WOh4MnAvPopGiIeI+UE11/DQDdrT6tutBPw88J
 2xB1LhCCQC6MVbt2ImJW0cjtlWGSlXk8tdZOps2hnlQLRUkfuXY33Zkscsw2SNaYxuzUe
 FdzJGsFJy1CCByVmcqYaEk+qsHIS1GdkcZDCBUtV24S9gvvKfKXqdxhHnxwdqrp53a3ar
 50HtV07XhiLVmDsvfYGTgs4Mi+uH5VNdHMUGp+mGumR8Md+yNME+yCnShqS02t/pL0uxN
 LGjJi5qmY+EJKsUHeJ054wwqUYFUe4xOaF3IlGeLZl+EyxFJgpuP+5Kk92rDBh5KzOA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=eRiMvpzD; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=eRiMvpzD
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BCB340887
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:22 +0000 (UTC)
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5D3323F982
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791536000;
 bh=xl5ZBp0xU1QNeiG+/e9jXLSjpvxaqXzYlaNmoiV5f0I=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=eRiMvpzDLcE1xXKRjvr/keTeinRQdd5wv/MyWoKf5PVllj/NYQ42sVqsDj/k0epx4
 bHZvfW1klc1cGov/+d8ItZw+UwcAzwjv5DnR4X3ApMPygwMPXkBvwRBORDRFzNj8yQ
 E5StyNCsCiZqGUNxSEiaVw7vip/K+uhp/e5UVtTMKGuFmHEh7AfL2JXO95Un51OEeO
 t2I75pFdsv7ccx3Vvn9yC6SAie2DHHQPEsG8oJDJaoHhjNoJ5xqFb1PZAxNJVcPYDl
 DukWpxciQNxFOc6mvy1EgHoqhq3dMV/QYmVmswY7lxMfpOLJh4BNRln8FYDQJDVbR1
 03qn7Rnr9J2VFd6hEjIQYY+vBHzMSGHAG30oeAXNSjVV6TbSyH0UU/1FsXFO9K5BGa
 frwQlAaxHdJcTSTUYpNdQRq0XPl0ySGhx6U8iW70Qdsh/72ZoCCd2R4o5fBEjZw0n1
 LKQZ7eq9110WnJaCXFkFkV+lBffPA6smZQZPC2r1PD7uBO0SzGxVzQfKYKjrNgVt2b
 e/4P2DdB89/SRYSUmoGs90qvqCXgObilbL+B+7MK/TmuJUrcs31oEmyGzzanGqUnsf
 0FOYuJ2zhicovCkKiwhh4dE9BcHIZLha61rdawMut/+MAhVT62W6zXB6KVTYMOxwfv
 w6v7bS1XDvGJxqyD/knkShpU=
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso7858034c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 01:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791535999; x=1792140799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xl5ZBp0xU1QNeiG+/e9jXLSjpvxaqXzYlaNmoiV5f0I=;
 b=dEHJUyypiMA2rWzcaVcYLDoNdyptcGRrZVfvRdjjmRbm1Tn50S9TRtTIoXB28ZpE9A
 AGF0cM8N47tv+tFOJ4hfV1S4H+7vtpreByCsFPLR/N/IqaOUdnl/uF8uSRLrEIEiECU+
 iEOasdwPYouB8beHrOGZfJXUDn9s42VU3qbbKIEdKtShx78jFCASPhV3J8Q7GY73VDbm
 pZvnnyU/8qXRdrsT+1bqR0y/z9D0MaLhkzoRKi5Zry7jj1J/tB+7EJRnUNhHhDBWTNE5
 CcujcEtUGHi7jdjB8hnlZeQC5PP5ER9ytVKEVH3JDZvk03qlrpzVGsik26yWuoacVu9W
 nhWQ==
X-Gm-Message-State: AFuF++knlDqCZ5oHWzXZ8qZfFMeQ2aKzATv5KR79dBuqS4CBNLZNBY9p
 uNclOdmUznjPQy+PkJkcN8OcRLZDaIsrEw4sWT1eFpqYLPcSVk50hlK6O81YMWyerYBrOUXo50g
 ZZmcsPMBJwTTua8gNrCHGLTscdGACyxxNAPB0K7HRw0v4TAqK29o/Xw2gYZy3o5z+WryjWPyd2c
 V25Q3FJF7yaUAqJkxOOQ==
X-Gm-Gg: AYBFou3ayoZq2UcklkMwEkQCP9ZuCIywqI6zkwE09s/VQj+3UJ6npVi3ccBupwqM+90
 f68YfcV5E6P9PmbwJkeKpUv77bHNBvD623NOIl1cNd8gwdtL0B9tShRrKP6Nk6dA13/UqtxRRSB
 UtDPOT144rHYFymhlP3sPCyrvzj0j0MzXGIQyEHzrPmf6Mx7GCIn87UG7IacU6oFc4Yv/80jm/Y
 GtGb83Vp58LhrSc8+PLum5KQ6MLPZINZ+cd9OdKYFm5BHNPAnmu0MM2/RFo4QdCuEyAGDOBSe7X
 x4uxUbURAICMXQsQWzpMl300/MfPrv766Xz56FSMk2N5WjuhGmqTjBct7tah03GGL49rEXZmgrF
 zesc1SZKtZPJx6FzMDPYHmLQQE+DtP2zOBRINBXoi6ooOLMbR06vyVMN7aVsvVXAS+A==
X-Received: by 2002:a05:701b:230c:b0:136:c443:80e5 with SMTP id
 a92af1059eb24-16a586a31b5mr1809282c88.6.1791535998656; 
 Fri, 09 Oct 2026 01:53:18 -0700 (PDT)
X-Received: by 2002:a05:701b:230c:b0:136:c443:80e5 with SMTP id
 a92af1059eb24-16a586a31b5mr1809260c88.6.1791535998122; 
 Fri, 09 Oct 2026 01:53:18 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a32eb7ebsm5765591c88.12.2026.10.09.01.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:53:17 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 1/2] fit: use FIT_IV_PROP and FIT_IV_HINT for the iv
 properties
Date: Fri,  9 Oct 2026 08:51:14 +0000
Message-ID: <20261009085250.331110-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009085250.331110-1-aristo.chen@canonical.com>
References: <20261008070116.328864-1-aristo.chen@canonical.com>
 <20261009085250.331110-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:16:36 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Commit d0215d8718da ("tools: mkimage: use an explicit iv from the
cipher node when encrypting") added FIT_IV_HINT and FIT_IV_PROP but did
not convert the other places that spell the iv-name-hint and iv
property names out: fit_image_setup_decrypt() on the boot side and
image_aes_add_cipher_data() in mkimage, which stores the IV. Use the
constants there as well.

This includes the iv property of the key node that mkimage adds to the
U-Boot device tree and U-Boot reads back. That node is not part of the
FIT, but lib/rsa/rsa-sign.c already uses FIT_KEY_HINT, FIT_ALGO_PROP and
FIT_KEY_REQUIRED for the properties of the key node it writes.

No functional change intended.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2: no code changes, collected Reviewed-by

 boot/image-cipher.c   | 6 +++---
 lib/aes/aes-encrypt.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/boot/image-cipher.c b/boot/image-cipher.c
index 9d389f26cea..535c671317d 100644
--- a/boot/image-cipher.c
+++ b/boot/image-cipher.c
@@ -94,8 +94,8 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 		return -1;
 	}
 
-	info->iv = fdt_getprop(fit, cipher_noffset, "iv", NULL);
-	info->ivname = fdt_getprop(fit, cipher_noffset, "iv-name-hint", NULL);
+	info->iv = fdt_getprop(fit, cipher_noffset, FIT_IV_PROP, NULL);
+	info->ivname = fdt_getprop(fit, cipher_noffset, FIT_IV_HINT, NULL);
 
 	if (!info->iv && !info->ivname) {
 		printf("Can't get IV or IV name\n");
@@ -144,7 +144,7 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 
 	/* read iv */
 	if (!info->iv) {
-		info->iv = fdt_getprop(fdt, noffset, "iv", NULL);
+		info->iv = fdt_getprop(fdt, noffset, FIT_IV_PROP, NULL);
 		if (!info->iv) {
 			printf("Can't get IV in cipher node '%s'\n", node_path);
 			return -1;
diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
index 90e1407b4f0..def33a3b324 100644
--- a/lib/aes/aes-encrypt.c
+++ b/lib/aes/aes-encrypt.c
@@ -86,7 +86,7 @@ int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
 
 	if (!keydest && !info->ivname) {
 		/* At least, store the IV in the FIT image */
-		ret = fdt_setprop(fit, node_noffset, "iv",
+		ret = fdt_setprop(fit, node_noffset, FIT_IV_PROP,
 				  info->iv, info->cipher->iv_len);
 		goto done;
 	}
@@ -137,11 +137,11 @@ int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
 
 	if (info->ivname)
 		/* Store the IV in the u-boot device tree */
-		ret = fdt_setprop(keydest, node, "iv",
+		ret = fdt_setprop(keydest, node, FIT_IV_PROP,
 				  info->iv, info->cipher->iv_len);
 	else
 		/* Store the IV in the FIT image */
-		ret = fdt_setprop(fit, node_noffset, "iv",
+		ret = fdt_setprop(fit, node_noffset, FIT_IV_PROP,
 				  info->iv, info->cipher->iv_len);
 
 	if (!ret)
-- 
2.43.0

