Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F699C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FEF540368;
	Wed, 26 Aug 2026 16:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8YkImTVjvsY7; Wed, 26 Aug 2026 16:34:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762075;
	bh=FoCLpLpQUp7NHKNo2NOe1HGborJSaeuDXlkKunYFy6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q9G1pjgpcAGlAcK8PU/v2qjtEj/HwcgPXUj6qxLfnDvkHQiH7MEOy86TUksRHVfBP
	 nl1F/E7T8B2OgtISOYYc54hPRFUotnjTSs4Ih7pZVo5aod1nfFWsqEB15t+ZIhUjL7
	 n7uGENPkntguRxr2DXhdRXBjJiKh8QKWZzLUZFR2Dd9cUzVWGFxn3KL/gtKeMdNRAT
	 iOisnVBvEZ0Gr5G5svmGDHrSYgxZY0teiG6xHnEdPIFjmQqwY61hiU0GiKUkrq5DfH
	 TQRJUQS50w/TmZYB7WMm0vSO+4DsGA9wzVoNFfyF+0eY1omrMJ2262uK2+EiaMJNHU
	 fRhFJgxiUaZsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7049B40600;
	Wed, 26 Aug 2026 16:34:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B5EA29B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E40F740368
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id srCTelNvQIOO for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=cAOslUhE
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A467840596
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:32 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so177351966b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762070; x=1788366870;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FoCLpLpQUp7NHKNo2NOe1HGborJSaeuDXlkKunYFy6Y=;
 b=cAOslUhE8Iw5futEpwM8YTjX00Qx1Y8iajtEeONcR0tsDAEVmu2PUXZyRUS8kW7On1
 JWLYW6WeCiIp456NiY6h6qqHf4PTIf7pEdd+FyjaqycDgY61I5AQFHCo//n/aLsZHYQP
 IO7spvuYWnQvKW8bgSK+u6Pz2n6T9J9DaG747vHF01pEODkI5Qhc4HHPA76Y1MsNLQGt
 xJ7FBPQe/BJlGJuoR2UUmPuN4h71FL+XbhFw5UJuQoxA7/mMMlsRhT2tUuKKNdGCejQ3
 Bq7Eesi6ZCvsxADrpRi1oNrf4ppVs1wc603eQTQ4XHQ7k8iF9sNpestw9r15KYTMU0FH
 32NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762070; x=1788366870;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FoCLpLpQUp7NHKNo2NOe1HGborJSaeuDXlkKunYFy6Y=;
 b=fJpXcsqmjw/yjh5IUbJEUPQ2I0PZ8VCOKKFokwBVhK6A3StUS0VI318tIcAHbOBKmC
 xaKqsiCjreisu6GbHCjy/+Zbplz32AQRF3mJoZvwOnoB6e66qBvsqhmNdNKsqBu+EVVF
 ojgaQ1nvSi3s4yDvGg3/q5SMK4ADr52PlE7r2QRA5oXV2st+Ll9OLzjtiYceAi8VP8KC
 UhlQm0vM9p41S6YQHipvlymDCfnTt1R1aNQSvzza9sOlu9PEMOnzGXorKf4/Gc2auDqL
 0o9MA6YtIBKxoMH9vjkX0tFf2iBX4AKQ4GahoGdEy+MOWZjK4VRCAslOoeeGseksLLmL
 F8Cw==
X-Gm-Message-State: AFuF++mudis/HZ0lavI/1pcAXyIj3m+Rayv1vZ7BIG+/jdnWIB1FkN7c
 y3g0z1rq8uAKVadcSq3FbjOjZSv4W9GpQDWnjk3Kt4x4OHhVgRBmLXle34axT6IyrXs=
X-Gm-Gg: AR+sD103Zs4BGjHKU/HYepErXFxwkyIAUa/CjohUCjuULrRMW9U3lIAN919z0PsV5Fz
 w8HF350AJR1ak4ETQM4GokDRRWBj11YVPPDJC0Cp2sCOQ7iU136MizT0CxbqWSNaoXayg7m5Rbw
 eqCLUrhx/s3H4LfqQ/ivD5TmJWlLxFp0HjqAbSp+JxxoekDrP2q9eAeTLjbhOW3YCIjv8nvwPWf
 45/MWlUJzhJaP+N6RNDhZ4V8ddY39dB+DkU+7+pe0KiMFvhqtQsqXv+ciwPx3TFSE6fHwTlue/N
 bejXjNbRLfZy0qiUANCd6Fz1BW7a3f36F8/fgSxiyqGUwBYDkMcpqJAEWtTPRgFwuyN4pN8uHkb
 geBbOhww/l4oKgjkYjKx5gKKyKCiii97xHH2vlM19DouQiuH7ovOhheYW9XGC19cZxzbzCA+BH3
 xBwJRQRTVzfH7KXH5ADKroRP3WnAodD/j9HEvdrQMR7F7bVL9LHD7zqfBgvL34YU3oE0nMuFWoO
 uglbNiQGFAuwLtLOxmKvEkd6Cqj7MS6i7W5yaRwMw==
X-Received: by 2002:a17:906:9c8a:b0:c20:2d38:e518 with SMTP id
 a640c23a62f3a-c250bb7f50cmr939623966b.2.1787762070409; 
 Wed, 26 Aug 2026 09:34:30 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:29 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:33:54 +0400
Subject: [PATCH v2 02/13] pxe_utils: accept "options" as synonym for "append"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-2-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=alchark@flipper.net;
 h=from:subject:message-id; bh=djuIkdvoSKVIaezX3eDaas9cHtHWQbkPSZrZxtBQ9MY=;
 b=kA0DAAoWsqLYjxBZ1KUByyZiAGqPFYyg5RBILbGXOHBGX/8CHrA/MTg6v0VEpNGKGHaX6Fc+o
 YiRBAAWCgA5FiEEnfakPZUyDpq6SEj1sqLYjxBZ1KUFAmqPFYwbFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMywyAAoJELKi2I8QWdSl8U8BAPg0raetWy6SRIA6Rwe363MfZxjlsTflO/CGvlFWF1P
 IAQCYuWms2d4We7fHA4sDjpAMenuuxYt3CUjLfSalDxaABA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The Boot Loader Specification [1] type #1 entry files use the keyword
"options" for the kernel command line, which corresponds to extlinux's
"append". Recognising it here lets the existing pxelinux parser ingest
BLS entries unchanged, paving the way for a BLS bootmeth that reuses
the parser instead of duplicating it.

No effect on existing extlinux/pxelinux files: "options" is not a valid
keyword in those formats, so it cannot collide with prior usage.

Link: https://uapi-group.org/specifications/specs/boot_loader_specification/ [1]
Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index f856a2fc1430..02bd43ac46e2 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -894,6 +894,7 @@ static const struct token keywords[] = {
 	{"linux", T_LINUX},
 	{"localboot", T_LOCALBOOT},
 	{"append", T_APPEND},
+	{"options", T_APPEND},
 	{"initrd", T_INITRD},
 	{"include", T_INCLUDE},
 	{"devicetree", T_FDT},

-- 
2.54.0

