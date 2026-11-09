Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2D606A332
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uy1MtwKv;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGJhkn3i
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D0E060906;
	Mon,  9 Nov 2026 17:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ijhBM7FpVWV; Mon,  9 Nov 2026 17:30:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF26160A62
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245411;
	b=AzxBG1a3Lua05ujXbiOGJ3k6lRItfDutBSWgxR0yWvBFns1V8C85vgP6LYATkJQ44Fol
	 SZhpRgaiJ0VSYdt376SbpxOUbXFIxD/VcBKc0v67/fPDTPjSSfYowpdIQJenC+gvBoduy
	 yYM5O4weIbxPE5IeQvo5blkU6bTUB+VcNaX2UEGA1zF7u+1456CbSO3WUEuFkRWpsj+Y4
	 rHtJFxvDCOAZ+r1RSGNPXFmltCsGy9toSWzPyicByrxnlkVxFHyFSdtvvR0W0utoIiEE9
	 s9G2IXEtvTXrr8xjHkoyxxT3w2gMRA7+rPH2QAhhlmPHPCsYWYSopUQaDtkrmJlbdBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TBBSuqQpKEq0AYFm9q32hWqsJZNg7D33ArKdyvQsaxM=;
	b=p4wW4k8fcwsDdKG1MHGQr8UJm4bnA3kI5ZUWXDa+rLHHrysa7XFUFdeTlu/kkutCqp97
	 hZKF9Rw5Pt8TGgrq6XaU1b+0GpBMmSZH+n7079xUIook9e5i1pKSbmD+y2Kgmup+8g0bT
	 NjeG44aoh+5eTUJQP5wDC5/8ZuMtZcL4gk+ZszTIuYYgTXK21dnFa6XAJkCjXt8kAw+Od
	 DNpFFV91wBOl6bgegXKcZpzoIHuWDTeNk8OQ9Ou+owyefa+avuvk18PJfLKL6wIs/Q3xL
	 c3IZJEXUcQtU68MTdYHKQv2jjAlCpeoCTfU0IUKY5hX7xoXXEUvn4mYMoZ+fYs68U3A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245410;
	bh=TBBSuqQpKEq0AYFm9q32hWqsJZNg7D33ArKdyvQsaxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uy1MtwKv8PCwfSRk63E4nWRLYEgrxrPg9Pv436NAX7npq+kAOjMJo+WpUxgOHEYU8
	 Wo5CzH+8VK/NChF8tXosa0kQJFZJIZ908UeBfGbqTHsLx2FkSYP6EykL2dXcChimKt
	 Tftx1iDBX4m4XbZp5Npza2O1U1fDCh0gB65ukIt74CdJDenoG6k28zo1ENhu8HCSzj
	 OINddYaN7YrEcg5D1vllE8XyHfHacUCJDx4q8nDsm63Butdd8QTrA6hYcujTFbMDgJ
	 x2bmcX9ze9l7Je5dBNqIu0V3qoxzKa0RxGbCx7KMG1nng+Tkz/bU1uBEauvkeA+AtP
	 g5METmyKrDC7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF26160A62;
	Mon,  9 Nov 2026 17:30:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A995B251
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F93C40176
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6GmY2UfmT1yf for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B92BB40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=yGJhkn3i
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B92BB40068
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:30:07 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so6860565e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245406; x=1794850206;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TBBSuqQpKEq0AYFm9q32hWqsJZNg7D33ArKdyvQsaxM=;
 b=yGJhkn3imxlaiO30luSd7Up50oKVU5bxMyStzWlTnv3p1hT/N2JAqCmHb3hN4hHvlj
 xFyNRfwGe/3v2DOstpXbnO5mlJrXNedEO4UBvJTXxrH9GtYHBOsOAOlGECORkNyQYmJP
 Sl0w3riUt+pij8Dejp+glX5j1Xk1Io7zHtDCzDKzUyPozwq4aFKVxAEDXsXWBfKfKqiQ
 8AKjYbM8JvgS2Lfu5ro7c6aO9mGxUy8MPR1ZCFbbDgkWidMujbc+doGwIBX+e7OgIO0p
 byEo9JzS1NerP47TpUZ3E63jeo1JS/IT7thkFYEr1SVuCTkAo5SBquiBx8zrRB++QlOe
 u0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245406; x=1794850206;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TBBSuqQpKEq0AYFm9q32hWqsJZNg7D33ArKdyvQsaxM=;
 b=jafq9XRt7itlre42fGVBwuXUyiN89TDyMP9mADTKxejW45FamO0wZ3rc26SUNa4GX/
 7dzhKQcAMWDPyNpxZZVpEgSrWwnJqqdjpD3gqv1+z+Khu2/IxNPYhiH55lXM8RGLBSQZ
 4+gJ8lH0y1oup6qVfb8sfLoG013qkA7YXx6qSDARrbHsBhOS2UCcQbH+1AsXwxYtn7QF
 YsyFqxznxuXl3G8LI/XPhkLFpAUsiUDT1ZhGuLlBe6vUOAStIg4MnghU2wDrr16jiYT3
 240KITB1NFJwn0XpgM5Z8aakerg+qm35kUf0BG+LZGGZsAim7WdcX4W3Er5VFhOLYc7Z
 v8pw==
X-Gm-Message-State: APuU4Z8kCKhTEZATGYH+nEc9EfbyxxiERV1wAs/j14JsVaGqDpIkjSn5
 TyGSVaYQ0GRnUAlX3bRRc/M8tlgW1P9w+yP42TjqyzZso1MOu+M3yP/CZj53UbN4K3I=
X-Gm-Gg: AYBFou2SKoZlwMMtIkI4y6NLG9VqxNT+4WfeWqBbPjI6+pi0pA6V9d3WLimgqUsTovQ
 G97D+NrHZ/t2fPgwXOQITfPJuudHTMGu0W20Jo12ROI34/xsVIKIH+zNdk/tRzco7m5TpDHhmjb
 jMubdDbDvch3Ra0ChI8aEeCa0I/DsLLlu+tNWtLWDz62ZzQpXQA4oYkJB8DK/w69IcoJDYVjv0d
 OAtz5ESQO7fxCifSlNeVvhvjYIXvYf/sOLZqD3JxPuS31GodZe3KZAvsLp7Lwbv18B4W2gwusYm
 q2w0WCD7hBzAAbcZrFfjKNYHJGNwIxOaitMhUpAVKie9Ekf9KOwx+Kxqha3M3vc32Vgc7/sB9vu
 l/nI69QCor1eNBN3nmo/Y5a+qSUzb57U+D3Lm34rXHBv6Heb6nPqgQ+DW3BtfYkOtz24s5yuF59
 k+oiq5+cTab1F/+hwSd3tn+2MVbONYoNZBpBIHaNH5zKSzlkAV/lyjyVkZC7lDB23PA5CMJ3YIp
 BaN7brRLe+1cNQtHYg0A+GKP6EeV10Qf2I9vzf7DCZf1nNd/YI9tC9/QeZ2wKFd1L83DQL+euVO
 DJkdunwAQhgpiCGS6/jmX3Ic5gQge3R/1EHqi7on6lE5bPizmyRt
X-Received: by 2002:a05:600c:4ec7:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4b94d7634f6mr91858755e9.4.1794245406049; 
 Mon, 09 Nov 2026 09:30:06 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835859080sm143645f8f.19.2026.11.09.09.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:30:05 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Subject: [PATCH 10/11] video: rockchip: edp: Limit the lane count to four
Date: Mon, 09 Nov 2026 17:30:04 +0000
Message-ID: <2a110264-af9c-4bba-bcef-6efc436f63c8@gmail.com>
In-Reply-To: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

rk_edp_init_training() takes the lane count from the sink's
MAX_LANE_COUNT DPCD register, masked to 5 bits, and link training uses
it to index the four ln_link_trn_ctl[] registers, the four-entry
train_set[] and the link status read from the sink. A sink reporting
more than four lanes makes rk_edp_set_link_training() write past those
registers into the ones after them, and the training loops read past
train_set[] and the link status buffer.

Limit the lane count to the four lanes the controller has, as the
analogix_dp driver in Linux does.

Fixes: 5852d539eab0 ("rockchip: video: Add a display driver for rockchip eDP")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/video/rockchip/rk_edp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/rk_edp.c
index 0ba68dbce3d..85c201e8809 100644
--- a/drivers/video/rockchip/rk_edp.c
+++ b/drivers/video/rockchip/rk_edp.c
@@ -646,6 +646,10 @@ static int rk_edp_init_training(struct rk_edp_priv *edp)
 		return -EPERM;
 	}
 
+	/* The sink may report more lanes than the controller has */
+	if (edp->link_train.lane_count > LANE_CNT4)
+		edp->link_train.lane_count = LANE_CNT4;
+
 	ret = rk_edp_link_power_up(edp);
 	if (ret)
 		return ret;
