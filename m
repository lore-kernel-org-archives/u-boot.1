Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B677C606A336
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=faWdtIge;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=nY+CRd6k
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92543608DB;
	Sat,  7 Nov 2026 14:33:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dvnhp5U6KFNM; Sat,  7 Nov 2026 14:33:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E67B5607D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062032;
	b=VMqzgPJoXSMRGvRTIZ9hB5P4t6Dggn247DB5WOdqoyidC8gp+B43T7Ql/zuCBnkg0uom
	 li202mC5xaiLvNSKcZmCr0BoYMXpfE7u24reKsxPuqw+R6dXrmzP+Fmfxa2eRd8L2eTse
	 2qfRz+N7bA0tbqVV1vPPJc+H9ElSjE6tRfj8qITBlEW5m1DGkwgwKpdh6J7Q+im8vBzoz
	 ZsQZ2X/a5ck9qe/n3VINlLbP68QYuiBpZzFug2eqC51izZWHPNJtDHlhgTBoP42TrQBlF
	 h4EbrFQTBvQZuHPR+kBwDDHCiGgQcNX+PKKjp+wI4ZKLAlyIFiIRrD0m1BSrylXyM6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EIZKBHOPL2wtdiA/DJaPFJgDLEGv7OdB48KzoJIZfGs=;
	b=pfALv6GHRhMFn7XCB9Xquq7OIw1HpI7HDuMrMrX3lY4tUmsCyBoAvdsFahcu3Q2ishUT
	 agN220Nvl3esyNAdkmH4hRgUgtcXuGiD/xZLxuEytlst7Mh1kvbzZSrc6SEA/5XUvG7f6
	 A1hhWp+/rMWHOrKeQ2NeMBAzyNej2LPI2ie99DCYe+hgM2x3WmkrQr6ndxCsyup48VQvp
	 aqwXQ0nfT8htpSb+J/qrow+VFYN31Mtms0CGIMp+sx66vjO0dh410zuWXE7xfwFTVNFJM
	 jTWFfJk4NTAek5KY4hVQHT5fKoqaRJri6uvDqK0PSn6tRN795qPrnL2v22inMdU9HQw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062032;
	bh=EIZKBHOPL2wtdiA/DJaPFJgDLEGv7OdB48KzoJIZfGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=faWdtIge4yzqi60THSW2SkeB7+6lBLjXxMJoqCvf/u3Qsr6ztGjUSI2vYiLGSjtpY
	 nIZvWVwmlCLX8Mn9fMkvNr2nCG6L4mEHYLvr4dkNXpfnVJgR7gNTb94DBHPzgOgzs7
	 KimUtVf3YJ8k4p8A1pUbnM8202CVPWjhCtpnT9AsUUfRsFKvTR8n8+Kk3linevUEiL
	 xzfRJpOYbOM2AkGq37iSlWGKn7mN3wOQTF6lCZ57R/BjKNA3JasgEaLxsafKm7lHzc
	 kE0FhECp7TTgVZJXTIPHxweyS7nfyysb/fpYcrB8tzNBB+ggAap9X7r7dgRwyl/TB9
	 9vexYFCSIDGzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E67B5607D2;
	Sat,  7 Nov 2026 14:33:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BA31C1E3
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3C2181749
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pQ8LnKjq97rs for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F42781704
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=nY+CRd6k
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F42781704
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:32 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4919a880834so834698f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062011; x=1794666811;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EIZKBHOPL2wtdiA/DJaPFJgDLEGv7OdB48KzoJIZfGs=;
 b=nY+CRd6k+/JzjcRrvVk/D+E9SpnZ8SvOe4Gbce/s2c2OgrtT7sjIWMNknaHMxUFPqT
 yHvEWubH9Lx+pd4D0U6f6Hq3QWf8ikVqhO2fnuQ+3UE4RDq80ozTO1cGsFfNXwpmrHa3
 ZDlHG9SASk2clulA7B6z9d703YXML1MvH20no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062011; x=1794666811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EIZKBHOPL2wtdiA/DJaPFJgDLEGv7OdB48KzoJIZfGs=;
 b=Wh5W22siOS+zdLX1BMGqneXJoxp2D+7hoe00ryZp4V+Zgf6KyDJANVit5WtoE8n9IA
 dSNBbtZk+Iw8cYMxGR1aatyYqu6rFsjUR3Ao4IHATSFeB85R/oC/G+KaxJQKAyTszZhz
 4CMk59AUpDqV82jScCLH5GI94TMFrmawQgkcXYPr/z6raDEe4gumNOToOFZ7tHsoCnm+
 lSuDlJGB/iAr8bY8+S/hsDFYeBqPOjBnIKrgFUrnO+IHOajSi4/DDzaqfIiGhoNsNFES
 BJSTouBZ67ELVmxV8hIjLxvPr3PgcVxV2cy+Y3GnA2DG1ec+kMUPtP5AN76pS+5li2JV
 D2BQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFx9FYioEvlrG1s3nrGdu8KXMxZT48fz6E0ZyqhtwqFq/EY7M8zUw19Rj/HNWJNuQxE71rvUzI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/aenoKKyoFuG0q6E7Q9uAs8wP6v8A2Ne6u60NFFEoGpctiOsSn
 Klg7x3+a7jF3srfBpltqDDP50lhEJ869JoIdnSRqGSgiUF2BtrV74mhvMym5q+5VwJc=
X-Gm-Gg: AYBFou2s3HGHO0gQ9PN6Ya3knXvtfohagHqdw0bzAtdrvvrL3mDrc3hTCdQZx/O+J/7
 hbSbrL9ol498c5ajcVKCrKfs/CARvG+7yCBXQI6nTdLxQigO4stftPcCmwtm5ZGVU/cGCiMCrB0
 X8FhYrcEjp+uUssCRPXX/KWcWxX9oa4WMDHr6HFDBrL/Tt3GB4vP9GZHow09WviWHzf7KqZZ4T+
 2VPPDPXgBBZFKwSV9sb+u0X660fIuV+O5IFuYDnT4u+80CMeWDF7y+0JZm8bc3vxHQK2NMjKBGR
 n/azeAyrGYnOeTzhF0MJIEQD7Kr5aszcgAjr7Q8al3s6NuB8yOVORv0iCtMXLf+R9kS1Cw+Gy1m
 66fexRmTMaackIwcdXJzJyohG8gQPEg4ztk0yqhv+9xgTfqsbcweTBronvMmdJc9lg7S8QQr1Kw
 zLd28MACAeQ3WgLiTQ90kbnesK7Zo3Yc3CYaGrq4iDUuzq63b8ckzZnIJlsWB869GVyE+Y3GPOs
 5kec2RNi0fMDv/4iK/XLRSAJwTbwauWg1uD8rKu1rDkXscyYRxaow9/D7ofEAl/aetUpf/ucZjb
 xLxBjCebJ2PXiUYs5T4IZGpCY26+iB1PtOxxFBI0ygz0V6IWQfhGIKn1Q0enjvpt81js+mcNzaa
 OEFHaPP3EndSC+vrOwVpjPMAQ16ASlBe42P5rBz9nHRwUNhV5NbQj1N5GhrlltaTsYv2WxAZu7J
 SSgHsnmv4SuA+u8dUzwQS+dOLafQ==
X-Received: by 2002:a05:6000:22c1:b0:48d:b650:69aa with SMTP id
 ffacd0b85a97d-4927678ebf3mr10413883f8f.50.1794062010966; 
 Sat, 07 Nov 2026 06:33:30 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:30 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 23/35] video: stm32: ltdc: stop looking for the panel once
 found
Date: Sat,  7 Nov 2026 15:32:13 +0100
Message-ID: <20261107143241.2236511-24-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

stm32_ltdc_get_panel() looks for the panel on each port of the bridge,
without stopping once found, so the panel is only found if its port is
the last one in the devicetree. This is not always the case, e.g. when
the ports are added by a DT overlay.

Stop at the first port connected to a panel.

Fixes: 35be94614733 ("video: stm32: ltdc: properly search the first available panel")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- New patch

 drivers/video/stm32/stm32_ltdc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
index 7bd6724bc2a7..da580a78a5db 100644
--- a/drivers/video/stm32/stm32_ltdc.c
+++ b/drivers/video/stm32/stm32_ltdc.c
@@ -571,6 +571,8 @@ static int stm32_ltdc_get_panel(struct udevice *dev, struct udevice **panel)
 			continue;
 
 		ret = stm32_ltdc_get_remote_device(dev, ep_node, UCLASS_PANEL, panel);
+		if (!ret && *panel)
+			break;
 	}
 
 	/* Sanity check, we can get out of the loop without having a clean ofnode */
-- 
2.43.0

