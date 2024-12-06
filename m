Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5048BE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 06:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4AA3895BF;
	Fri,  6 Dec 2024 07:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e+cQT2jN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B7F5895BF; Fri,  6 Dec 2024 07:01:55 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 342AA8959D
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 07:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ffdf564190so17259751fa.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 22:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733464911; x=1734069711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+l+boOem9NJi57yq3nKO0uwxKy1qV2Cv+SXSD/1IDcg=;
 b=e+cQT2jNlGnohm+E9w2rZH+gSfhlCL69bRXyMuKzxpDjwwrGpt8oO3/vli5zbBvqQq
 gUcWRFciTwkJj2Qktc/IRzv2y4nI0xug5iNZM4kjYPHO9V52pZvny+MFy7uU+bS3JuNh
 Pflcau9FAhMr0GBfKbMhXnyyZtVIr2F8/scsMQUV7lwtHtXokhwBZCcPQL1Vbt0cOiZx
 qeb1WtssfAXLj2v2R7DEzsZ0YlJH5L6SepGgllSRa8ciIZ+KKzEwMXhiVmGM0PJUy/Sb
 4udUYynqLcRTLKY3ue8ZNTroU01tDUrCv5vInBxQ1WxFRemXgf9Gp5f5PJWk5XW9TReW
 mA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733464911; x=1734069711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+l+boOem9NJi57yq3nKO0uwxKy1qV2Cv+SXSD/1IDcg=;
 b=xGd5PIruH/P0F+fOcU7rHN3wiFCKNwmlY5ePBhfru1dmNDMVGjrGuI4d3CnoAAu//q
 avxUHm6Xuuc1X7Sl5GpPWyYQMezN6gvEsLyUIbgyzJSWYfSiljQ/fp9BYVcg5Gi5pad/
 Skiji5ni0udpDhdmABb48pCtRI2xwZ8QHJRsOU587eyWYfLBrFUiFWC8kLV0vblkKJ5a
 05CAeLlPAH0xzIaFuDPyD/PKcFs1AaQoYXPmUIF11Mlt0YdRc9VzYX/pxehFyLi4CsE7
 s9etCt/BHYMq9Eof6vsfi/IaU4Knx+EgrbzY0v85hVCJTbG337j/TdPv6JTs6SWXjoK6
 1WlA==
X-Gm-Message-State: AOJu0Ywpx4jEqK5IAytYQMXHZf6FQwNvlB8AM5WQxisKI/0ytpJoZYWi
 AwFaQ0lJQCv7fdjQFfj4rrFvhcWZ21JifV69OJPvzxvvmF5LDV9m
X-Gm-Gg: ASbGncsukUDPN0r6aeuwoZFtIz23pVgysNCc2pKp4nYhDHCHSx7DoAocuasY8C9teZo
 BCqNt7CcrSsBUgyaSvphrDU/kLTpudITRwc5By9jinpk9dWqJ/sDUxKmj7xdfTjeD86f+7SwumM
 cWRnrQSnqX8Kz5DdP1r70DMmY2EWiJ+Jq2n72wdOoukukvF57nINF5UZFdRIeSLRqHITfbHIQ2t
 hUuPT2SoPweAglUN0cD2NZbyYMyOl4fnZC+AS1J
X-Google-Smtp-Source: AGHT+IHP3ZaqVQvNAeYWpyG3oYFLN0afCYl8bgsPdxqTPiDnTttBSfChZ57WFvuaJS6Xgjr/z6XFqQ==
X-Received: by 2002:a2e:2408:0:b0:300:330d:a5c7 with SMTP id
 38308e7fff4ca-300330da718mr1942521fa.13.1733464911232; 
 Thu, 05 Dec 2024 22:01:51 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30020e20e23sm3890941fa.88.2024.12.05.22.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 22:01:50 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] driver: clk: tegra: init basic clocks on probe
Date: Fri,  6 Dec 2024 08:01:15 +0200
Message-ID: <20241206060115.4346-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206060115.4346-1-clamor95@gmail.com>
References: <20241206060115.4346-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In case DM drivers probe earlier than board clock setup is done
init of basic clocks should be done in CAR driver probe as well.
Add it to avoid possible clock related problems.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/tegra/tegra-car-clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-car-clk.c
index 9078253d100..4f8405328a3 100644
--- a/drivers/clk/tegra/tegra-car-clk.c
+++ b/drivers/clk/tegra/tegra-car-clk.c
@@ -111,6 +111,9 @@ static int tegra_car_clk_probe(struct udevice *dev)
 {
 	debug("%s(dev=%p)\n", __func__, dev);
 
+	clock_init();
+	clock_verify();
+
 	return 0;
 }
 
-- 
2.43.0

