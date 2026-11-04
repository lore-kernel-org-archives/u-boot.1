Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E550606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0y3Co+r3;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=TSZ3bwY4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF47A606E6;
	Wed,  4 Nov 2026 08:51:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5MlwOI14mmy; Wed,  4 Nov 2026 08:51:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 366DA6075B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782317;
	b=KR+ejHLVRV8E9ofIhPFwkYaD6b2QSExoljYqzhmQ9HGUSicksP12jmeIYnfBckYMzicW
	 zez3Sl3p2X9upBFM31WzV0ExFgOZlqhmJES3JIjsQVnQvvVu0Pt5Har4Q4lOnPPmXYUOf
	 wsSzBlCDMdqe/GRHViD5m8dpwvp7dCfk6qsra/ly9dPdgz8rkdaK98M61fr7iAe6n+sYU
	 59SmRxL0vbXgWrajhIDEGXvbjy0o4qjW80LMhz7Uq5/QT8JVZGSKLqKdzFOFOFxrJdZ0A
	 AKCAhQxlv1EdT5IYzhYwSd17EvJ2Nx5Ddf964JIu6WtfhqTandBnOpPVxmDjcxI7QRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782317;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3oxOrNmjKZNyDK25hSH+YHiXCFuyZv2MVeuBpBF2mSw=;
	b=C1PASXxh23YxmxkMkaCwcXBMBnih9k+hgb76WCi4DAz686m841FVm93hRMRsA0N+CXrm
	 LSHUu8dTmT/XqAaSJuwQbrxh3gwMV2pdud+8KqvIl2mrWWoIIjID7jvE2GZiZmPnH/3D6
	 xH+2bubiVptRg4/wOgVDsRPNJMy+6/bCBEJZRrvMEYExCVktsu6e+To885ULma5yBKjuY
	 eBUsFhGkmGhHzhbhAMRduIUeNqAgKyPlZ0qe/PAx6YtPnaoTgi7+NX68ApJ3zOdpfqhuv
	 6mSrIzhe/ns7jZMbhFrXQFjRoGEr4mCkxkTFsIsun0eJ6EQvVwgCQ8JOq7nM8Antxvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=TSZ3bwY4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782317;
	bh=3oxOrNmjKZNyDK25hSH+YHiXCFuyZv2MVeuBpBF2mSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0y3Co+r3NvEUaAv3n8/VVMUBhOZfwJn8n40O+LgkBwcvudibVshPFtrdbweEtGkJh
	 dsLQHublwmqEfXERNviT5qpCL8kp3exsYIAfGG4JlSyR0j0uHz+EYPswzPf3o4P5JC
	 6f7u/ICyP0+MGuWexJPQaQYHRp1QrqgYur2hwDcwBeEZ/tDPcUuTyxZCmmHeUd6lwE
	 bGUWqTUMBOA9oRlb11W/l0DqplzIrGIMNcr9mg6ihVUAFAX1SY5/gdIag0bAYDFSdN
	 karUdr4wvwzo7iEYHauk1Gxw3NO11sahVc6BHDWTlp0XjYFxcxERO1gF/Fixbztf2X
	 KLJSrVSM9D7cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 366DA6075B;
	Wed,  4 Nov 2026 08:51:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 743EE235
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A27C60777
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fLrtoC-O_i2e for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B9BC6075B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782314;
 b=SNm0sO8q8ULKL960dR3J6/J2EOQztgsuICVlC4qvj6BKZ6t+sjzIlTLdXka/6NaM0Z01
 5Hjk3KRrm8dJtvixsNM7sUK1S4skxIDwgbHYQTIRwQcQq6W5DSlhBQkpFPxaXo68jj/nG
 NZNyYzSg+T4FGPPpPwpjffOdZeUoobdB8tou87hriqUaU3kCHC20biA+sxSWStdkmZvnH
 i0E3rfPpdwJ6XcmAE4V3cOo2qzIPYVVKqFaLuMfXZW3lyLDva2SvVkRN0y6qnYDodQNta
 4n3j6zwkjuly3u1sNuFDLRJSki6EfEBTatEQ3GO6Wv2M2q/7WvHBG7np8CNYIttvbBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782314;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=3oxOrNmjKZNyDK25hSH+YHiXCFuyZv2MVeuBpBF2mSw=;
 b=rt9LEe6JzrCXOox4XttLFSR9/1+ANXQo/a8H4mnzLhDACidkWDqixKHUf0zOPAk1bUmu
 4CQ3o4w5q3KCNT2hbQL5rwPZtCfIu4tLb/2y6Qfjvku1yy8DHWZ33sMj3EOOIQZ80US+B
 /ToFk0vBWG04zY5oQeBXR9wNYNg4x3corks5YWhkyPfH5OMV7E+prm9fB/q2AWqwfj1Aj
 qRODJajYSmYiPQivNYvq1HUsmPdj5EwSo3eDJM/0ilEST79l0UzLR8B6ijhsONT5PKkUY
 trAzD4jRkWRurYGjjX4HWI8fDN/KNTN2QCRqJwRegPJhNPoIjBm420bmRdYit8BhBfg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=TSZ3bwY4; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=TSZ3bwY4
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B9BC6075B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:54 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so2145905e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782312; x=1794387112;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3oxOrNmjKZNyDK25hSH+YHiXCFuyZv2MVeuBpBF2mSw=;
 b=TSZ3bwY443P+TlrvHzrHO37ipAbbQafUHGFt/rcmBVLls06KV92hRntF1M68j2ra8R
 jjtDzDgCj837rjgN6+22iXbbVesWIs2q5bDIRLu3aG6ggA2iPEmnqiqpGUV1kjcda1Hr
 2D5YNBP0er8PyMYjnHqbnb+GUbTeKj9Lw+nFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782312; x=1794387112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3oxOrNmjKZNyDK25hSH+YHiXCFuyZv2MVeuBpBF2mSw=;
 b=B9gqJAs3VlaEkBwfw6rNdc3AH904OlJZq3lf2yzfE3P0cxOpsKDx6RiPvwIvjSvsJW
 zlxCyRxyaqj4D9B4LC7+zf7jm8ZyzNjLkrEe/nE5r2hSmBFsSKwrcCw+JHFMy321JXiv
 TvLmnYOE3jyUH5EDBqfGGj7MuJqMtbIb1JBLbY13ouiv4mMA6ICfHts0g9fkeSw2iAXt
 nfViaj5zeGlxbumn1Ku8C4lhh8XxjHMLZppiqYXcLG9puJoHGluIpmyqqHFKZ2q6tUQa
 seDvBvTqW4COt3oX3R5+NCGTIccIkCmM8CU5wr87cvGoSl40GuR6bx2xsCm4nZVdGj3U
 F0Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvBysB1qg3lzqwtPd0eqRTpbMlRgmCOt9rYMy4sw7fk/Wbmdtn/ohAbVmNyZlq9DmoLuLKQXv0wo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8dPqeIa9oGmjz8GlTNLFlDY7z8yGY3Om+wxq66T2bsnNJrqxJa
 BXTEl/QLJ5jG9zqkS/G0dVrF0uf5vHQ9Wi5Tyu15++zN76H5Ij1Nt07u+v6ktX1MZ8Y=
X-Gm-Gg: AYBFou0p5gxVBY8hn91Lk12vv3QMBxCcxcYUqJQ9yjI6X2iqkAZEGPbtkB1/TRktRhR
 Gx3yaLwSAkMAR3WwqybVbf0jGWKTuNRR/a8hAtZ5BZJ58g8TX+mj997VkdsPtxueUQAFdqYy0Eb
 weqJ59mdOBqxj68wonQJwNev4n2XnD6ehj09Kc6xdnhijb2VyC8tpY0opzUPqtv6G8N53N5mVGD
 x1Ufswp2tlIm7u/5/hGJxcgtlRB2fGtiwmdTDB5afhril7uUDdGKNppLjvX0+9w/A4eSNDBd5Wj
 t9jY1HLaAQXI6D3duz3+Q25vcvo+rxhnz1l5QxtamUUK3P6MTJwjNFF/+ucxtn5O6Ak2TZ4h1D/
 nVkESPFoMuFElvmTnbFfaa9tCFwPinIo1ldrUos0YGGj7mRprMqZKsFmktjcjdvA0Rje65buO5t
 KCPoPtg0jA9Q9i/Rrtp+IFcUycPzCbc5G8ET1Kq4PzSuJD0uKC4gfUgtJA7PZfN61UiR8JeIqsU
 qIRCa6/Xf17GxhvJriDloG+9YBFgkgW3xio6zBfCjmmB8Gwu/KaZMxYUfsyww1O3d941MECb91B
 ZqkKCfZRDRd8wBwla0/Sv9Q3aa5BaX6vqt2W5K7qy3KaiVnMTsgxM+TcvqP5Ziu8qczKscJzrB3
 7Vu8aMxjYqWyx92AgKk8l1+70FRI=
X-Received: by 2002:a05:600c:541:b0:4b0:9803:dc8a with SMTP id
 5b1f17b1804b1-4b09803dd63mr130763825e9.26.1793782312423; 
 Wed, 04 Nov 2026 00:51:52 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:51 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 19/33] video: stm32: lvds: fix NULL pointer dereference on
 missing data-mapping
Date: Wed,  4 Nov 2026 09:49:52 +0100
Message-ID: <20261104085036.4012238-20-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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

The "data-mapping" property is only required by the panel-lvds binding,
so ofnode_read_string() may return NULL. Avoid a NULL pointer
dereference in this case by falling back to the VESA mapping, as for any
value other than "jeida-24".

Fixes: 16cfbbbe2b51 ("video: stm32: STM32 driver support for LVDS")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/stm32/stm32_lvds.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/stm32/stm32_lvds.c b/drivers/video/stm32/stm32_lvds.c
index bf1393c9e872..a16331296388 100644
--- a/drivers/video/stm32/stm32_lvds.c
+++ b/drivers/video/stm32/stm32_lvds.c
@@ -614,9 +614,7 @@ static int stm32_lvds_of_to_plat(struct udevice *dev)
 	}
 
 	data_mapping = ofnode_read_string(dev_ofnode(plat->panel), "data-mapping");
-	if (!strcmp(data_mapping, "vesa-24"))
-		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
-	else if (!strcmp(data_mapping, "jeida-24"))
+	if (data_mapping && !strcmp(data_mapping, "jeida-24"))
 		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
 	else
 		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
-- 
2.43.0

