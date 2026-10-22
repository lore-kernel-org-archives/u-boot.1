Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D8606A31F
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QT2di8NN;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DOm4j7dt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 613B16087B;
	Thu, 22 Oct 2026 16:20:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oNf1VCREF66n; Thu, 22 Oct 2026 16:20:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 883CC606C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792686032;
	b=f1ivtr8b87GZHMQru+MPE/BV58ZihacpejSsbRNSWDQgn4NQ9E9DRyLN37f8Y+eeCsMA
	 guyZMvvnyQ/bwkl0uB4d+JFkqsOPOLpBT/jcnNe4gsu0M8EVKCFFFGjC+nMaSpoOVHe4V
	 klEcWKB3/n818NQMDlellN3ugoLS9yV2UDBwVVYmHZm6axrPDF0XbL+trb8rMZY4e6WOx
	 hDjxUtk2MpHdcCDE6xYTCTayHcFb1WHHtHhFxb3qowRfbRac1cyEiCdQK+yCgwv7hJqhx
	 94VWkK5E4klgygTzjM74/80BKllwrHyhWf59uF8mfBDahiyLGJD6xuELYd+YKGa1lCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=m9YheZS45V9QoAkiQZXbPLRo+ZyTvSuDcU0c3CZigoQ=;
	b=ctXhgMdzJYYkOHW9zcSnqJiFAxlltrLinOvxHO7ru49Z7Pq5BD1oZTOEnvtodL01QWOe
	 pjpAAP3v+qFOSKRRyaz8P682Z68VEOrCb14U5EF5NDBO/FM3pAory3TK9RGUNil4L4NwN
	 gFoG4lQZ+squI4HpRcVZRs9IGWcVlpEcN3x3URd5V42IkwkDEWcLBHkpOGlcob7IKuMw3
	 GglgitzuX0yiXak0Rer8pPMwQRmFwOKMb/IFV20IZ4/FfgySHq3+iLZzEGyvnOda1nq3o
	 I9Px5KqEWvThFSRum583avgCmNhZ++ZP0nlUlhfrulmdJHs0p9cfgWLDA46/SurB5sQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792686032;
	bh=m9YheZS45V9QoAkiQZXbPLRo+ZyTvSuDcU0c3CZigoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QT2di8NNMZPC8xQq87ZfzHi7WJB4/wdR86zY5BhVWucpHFLwg5bbzUhC+7bXSxzF+
	 mQDZ2aJjEJ85+qWac3Ss5SVA7sXmeIyA9Ne94NgymVHbbOnVcb3AaOez06bJfihT7s
	 7mg9U++asOWzS2Sco01rnjHCSFws8y2M/jfMZzYO/ALMdNiAC/pqdMWHVEtHNaTiZG
	 MIfrf0flzBY4dCA+hoQJhY54yvcSUSSU7KeOXV+7JgSEOYVdnNNUrfb/lnQSjqGCQZ
	 k6PVYhrufKjkxbNzoztokD0rZwz2PjMNWRPkqYS3Z+/WdzkqtMoQa4nnvkDf9PXrD3
	 prHO69qbO7iWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 883CC606C4;
	Thu, 22 Oct 2026 16:20:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6C90769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D46FD40688
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1CCk4MttFa-x for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:20:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C911040674
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792686028;
 b=i3IYygC8zu4DDwRS29T78xNED3py54hWcF5w9U3WPI41C1OcLTf70mA5dUvXxGaQL5Jr
 esGGxsduBUq1PwDati6JFjz1A09DFCoSLbJQKs0efumcAp12f/JamQXravhvMTaMAxxfs
 lIEa58+/Q+PsflG5SsY1sGmTUbuz4cRF4twrNSruJzXtXgMgjolEYIx0NYBh61f9C8Hkm
 GJCZD988nbixERTzK1+zukU0ctRdE0YCF04eCmW+NIODt4aUJYtKT4fYbGri+Nwl3Cxzx
 avrOQBayksowyAsBRGmi3CwCvZdsgueuAAAZ9BBC6R4YXXO3KdHiAAb89vzLG121DQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792686028;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=m9YheZS45V9QoAkiQZXbPLRo+ZyTvSuDcU0c3CZigoQ=;
 b=Tk7i1AFKSL6PhKAi2MSA0JCOoYxVjCOoDRoGFjp/VMAd6t3+rY081gXQAi7LRW2r4ASu
 5/u/yF8od8EicrG3Na2MMWfDJgz02AoKICkF+bgSpzb55aBRuH6RJ2jLJLyVGiXtRt7OO
 /KxPBFQ4QxM2fc4/t7AebTj/D8ABDqx+QW+DjeSZe04xVEj3JQe6QHXjMOV8v29wIINLE
 H28b1mbZh4cE4DjxZhURAY0Twk/F9NqiuhrdRjfSGxm/LhH2DGEBoYcOhBrZul64DJwWL
 eX3St9blmy/aWPg9fnPXJ3nv5h/q8XqsZKzntC9bY/meyWPiedHyC3dsqesebwb0Teg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DOm4j7dt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DOm4j7dt
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C911040674
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:27 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so15536615e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792686025; x=1793290825;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m9YheZS45V9QoAkiQZXbPLRo+ZyTvSuDcU0c3CZigoQ=;
 b=DOm4j7dtXxoBr90XHB0dVnGBOQHINPA9Sl076+w4S4HwwujWKlNjbDVxHgZZZotqMx
 K61Mzw5qxhzC6sOeyC6aLAUl9wVYVllgx6XZY8Yfvs2isD5ROOckO0FEm05W7p4fsLvG
 FxCoMwFzA1wb9ycCPthX7YXVIpgiSoPM/UROb/R4d/zeqL77MUVZ/EzWnTZ6+kM7z8lq
 CPMaXGXaF/Jp5iqk4AM8QbR4JCmt3wSEdxPhkAG3Ev3/MXNGFuwMGBV3UOTze6Gt06WL
 Ykj2z41jjMACTevE7SNY1Te0USB1D8ewJ+3ffKIhqF2xH6/v7WDtAunLhiid+kTaZWBF
 8X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792686025; x=1793290825;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m9YheZS45V9QoAkiQZXbPLRo+ZyTvSuDcU0c3CZigoQ=;
 b=voNWWPKKWUZZG4DFsvfAxNGEVvgI3i1q9fxwqgNzvlnf+5SeDhyfZ7M9jUYZL+Vgga
 EYNMekG/xkA4hdsL5rB1vJzvYvgYRlEo7/7d896DrswCELDDT2h8wQ5ItYxGPrGHq1Mt
 Eu71PchHVIUIC/qkwltO74RryO0jvfMcJMRHsIhFgy/1t6Yl7D+2wk1ylTx/3/DNRvP7
 doRea9wcCsvxMRWLp1Vxw7s0vBugr+y/4GuG72qA8IRKts2bC1bh9uu4qz/wVWG23Zdi
 NwYD1BfWMwHX3XXfrm+I6SpyS004fnWaYKlTd65nzwXMf5JBlTcYhreCKX0pA8NAfX4K
 vHBg==
X-Gm-Message-State: AFq9FYLk59nZxWIngF0x0jTWeXNPqqluRWadmbxysbG2dtvpDWU6iT5h
 b0ipX5kx8mz1qDTM97lwT4Oil/GrT164yMTgnkm5LFpiDIPvzG0DphYsSWbTDqf+OC0=
X-Gm-Gg: AYBFou2lg6X0rzf2dF0zAPB1Cy2TAgYuvyDPux6jPNDqriB98zSzboPCn/V6TNey+TF
 FFgyOY2b5QYibMhgvECX5WMmRk+KDYEnYHBRzNCufjSAOkdCsBcOlakFf8JC4nQpcyP/4C6wPxj
 72CFESYwqorQzmNlak/OO07fwqj3a3Scb4Y+TPst9O65Xah2gMw8p8z5e8RXU3ukMhU0EL4nU7s
 Np2rMDGeUYNlYw0KUPo67G4v7cMotiZRV+y4Vy/LVU7XV0nA/DCvAKM5TPBtRCqc70znXPwLnjc
 iBUQsGeJMKFA/sny0EVBuwdKBmxsCqkUMK/6RwJu9LrTjNdgosnI26hWrnlMxWXdsJbyWxli9rj
 Owh0daw6KHXiRtQ0+pRWGHWFDYhXBAm+TDdq/KIim6DgdhTi4f2y5wjKvR52OSBLVJH4A156STV
 qAeSCCSbw41dqtGce87XCp78+oSA8u+QstuuaCh0jZE20OYqwc/5dsZuIeHCspFccK0pAzIeg8Y
 5CKL/JSqkiGqcG7tpx55Z8ZptJxAxKn7h9uq0mV/G03SDwu8zBwTArVQ+VFJ4Ky5tqvNgRI1EFR
 IJEzWB1Z+WDrR1n1oOT25Y35mu8l
X-Received: by 2002:a05:600c:34c4:b0:4a2:1a:a10a with SMTP id
 5b1f17b1804b1-4a2001aa275mr109182885e9.29.1792686025561; 
 Thu, 22 Oct 2026 09:20:25 -0700 (PDT)
Received: from [127.0.0.1] (mob-83-225-32-96.net.vodafone.it. [83.225.32.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21029928fsm6905905e9.3.2026.10.22.09.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:20:25 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 22 Oct 2026 18:20:12 +0200
Subject: [PATCH v2 2/5] boot: fit: reject configurations with missing or
 invalid overlays
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ccaione-upstream-fdt-fit-v2-2-4140e0c4d5a9@baylibre.com>
References: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
In-Reply-To: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>
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

An overlay listed in a FIT configuration is part of the requested
devicetree, not an optional addition. Currently, a failed load or hash
check can be ignored and boot continues with that overlay missing.
For signed configurations, this also means using a combination that
was not signed.

Reject the devicetree if any listed overlay cannot be loaded or
verified. A missing image must be treated as an error too, rather
than falling back to the default configuration's base devicetree.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/image-fit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 4f4e7b4e06a..83e731402d6 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2675,7 +2675,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	void *ovcopy = NULL;
 	void *base_buf = NULL;
 	ulong base_buf_size = 0;
-	int i, err, noffset, ov_noffset;
+	int i, err, ov_noffset;
 #endif
 
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
@@ -2752,9 +2752,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	/* apply extra configs in FIT first, followed by args */
 	for (i = 1; ; i++) {
 		if (i < count) {
-			noffset = fit_conf_get_prop_node_index(fit, cfg_noffset,
-							       FIT_FDT_PROP, i);
-			uname = fit_get_name(fit, noffset, NULL);
+			uname = fdt_stringlist_get(fit, cfg_noffset,
+						   FIT_FDT_PROP, i, NULL);
 			uconfig = NULL;
 		} else {
 			if (!next_config)
@@ -2786,8 +2785,9 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 			BOOTSTAGE_ID_FIT_FDT_START,
 			FIT_LOAD_IGNORED, &ovload, &ovlen);
 		if (ov_noffset < 0) {
-			printf("load of %s failed\n", uname);
-			continue;
+			printf("load of %s failed\n", uname ? uname : uconfig);
+			fdt_noffset = ov_noffset;
+			goto out;
 		}
 		debug("%s loaded at 0x%08lx len=0x%08lx\n",
 				uname, ovload, ovlen);

-- 
2.56.0

