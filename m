Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EE9CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E70E484704;
	Tue,  9 Jun 2026 14:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jmcC34ST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CF69848DF; Tue,  9 Jun 2026 14:49:26 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E8E846D3
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68cc6c7df99so7875000a12.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781009363; x=1781614163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFR6plWBuYjoI/RiYP/GTQfdP1UX4HB1+l+M7mgufEM=;
 b=jmcC34STWF0VR/KCaHgdGQXRukCpHs2nE45ZmpJbzFwB09dlYNUoKdeamBNDkBagkM
 LdpVv+kkzA9LJAghEDfbort9ZgNFuC+97G6gwpcC6oHQm6alEL2l1JPGewmbPtswnu7x
 zwzlPokYgPu/oizxFOhiW0+BQr0CcKqfwMapWGYRyZWJa0DtvjZamZbCnjcmK3AVvZF1
 9AGFS8OuDL2Wu8YLzFShuCTyzz35HgSpg/RJclTRhlJ6709kCeEwWmUFsCoWfRh95X/y
 k+t4Dj0duNyu3/ybMqrnS6E9av0ziO7cOIwfCd0iZjiEpvzCLm9PeiXwMAux6T7zun8u
 LX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009363; x=1781614163;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yFR6plWBuYjoI/RiYP/GTQfdP1UX4HB1+l+M7mgufEM=;
 b=SsD1UnMXCa3SVkpFzvwkMR39gkdV1ahis/GeGPuB+Kimvk6GUEblGn8jvXZFsnVl1B
 H64SMV3IZzJiBI7o/GV5f1BxnnzoY2VxazGbjteAO6Haz2htMCBbbel3m9aDrNnTlwb8
 G1aJkJXnBmfOcsyP+g8aRsuxYCCyQf+XkdjZ6SqWI1EKVPRlNMOVjrTkU5ZBHfWShbxW
 3TPZT4cvNJgzI87MieRaCchj8HKH8pAS5nMU2oqoLFZsZC45c6ha7zZTqp/K+7OSf7tF
 MZuoWsE1MJp7m11NTJ/P0GpqaI/Fat3EPgEAmIWoXt1KdDMjr0DyZqFXBV0EMh6e7OcZ
 QaXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GluC2VAJNm4w5dmQc0bQzU3o0dV0scgTSAnBXhxZ1ZUW0kCelHPl+frDI3taEDNeLCfqqSLY=@lists.denx.de
X-Gm-Message-State: AOJu0YwCo0insxiFreWYMx4dqhoyw3IPP4xquxRlBY6pUiXQhGs9RB3d
 ZDlbijPegYIiYYFGh5KGWabwuEqnDUE1Rd77QUqcOPUCmp1yfM/HhImNhp4O0lzoP3k=
X-Gm-Gg: Acq92OF4Tu++tDIJeget6h1G07fidRltPSbi05Kf3Q+k1UzreQ68BB/47hb2DW6kKaD
 MmfjzVlREpX4HKi4iR201e6+4bBKQxLwuiSdk6UCR6shcsnl3UIl88T4M95Vk69iEeLcqQNqh8J
 WCVED672jgQcCmSanTbW5ytPqntSRW0gViUc5aOVKuEasij4hDFbAa/LVCLhy0pu8lqRqCA5VHa
 sAyOIdiLrUMh26OGVqwerPIst2dlpV2b1Il4Ta9TtjSkEz9bai2XsRemEERbT+RFgx5gh+L7cd9
 v8ZeEwPkLe2Lv/VMuJ2eeRp8m801jSpk3aB9OrZNdr9FCZ67AKs49l2P1ydGoCJm0oh4XrckI4F
 4Asf1ZKV1Mknl0JgA8gZDGcayOyOraYrnY4WyELM4vlBtXOaSMg50csr3EbMQoUFdGJzhrG2xzs
 h/kUqUzH+0Va2vFzHAlkOpk+9sWhp+1XGHtA7Ilw34+oe82VS88As/GI313RBO1s8+st2vk+Hh4
 Jh8
X-Received: by 2002:a05:6402:3809:b0:687:285d:44a3 with SMTP id
 4fb4d7f45d1cf-68fa5049c4bmr9007374a12.15.1781009363346; 
 Tue, 09 Jun 2026 05:49:23 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b55d81sm8689526a12.27.2026.06.09.05.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:49:21 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Sam Day <me@samcday.com>
Cc: Stephan Gerhold <stephan@gerhold.net>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260531-db410c-chainloaded-fix-v1-1-94176aa147d1@samcday.com>
References: <20260531-db410c-chainloaded-fix-v1-1-94176aa147d1@samcday.com>
Subject: Re: [PATCH] board: dragonboard410c: fix chainloaded.config
Message-Id: <178100936114.3342853.577453465706119223.b4-ty@b4>
Date: Tue, 09 Jun 2026 14:49:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Sun, 31 May 2026 01:18:34 +0000, Sam Day wrote:
> Since c8a74db0c, SYS_INIT_SP_BSS_OFFSET only supports hex encoding.

Applied, thanks!

[1/1] board: dragonboard410c: fix chainloaded.config
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5ca344419ded

Best regards,
-- 
// Casey (she/they)


