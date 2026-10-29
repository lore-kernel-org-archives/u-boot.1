Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F13606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e+ejwWA9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJIRJait
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2D9080FAD;
	Thu, 29 Oct 2026 13:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eqlRiukTZ3Vt; Thu, 29 Oct 2026 13:47:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3EBA480FF9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793281678;
	b=sLfIfxtpGL9dabqHXwogVJWJwMTjtjJ1dOr/Zx1PrlSvKm2OUL8TStfsZKGIUrbnyXY2
	 vJ/JIYCoK7TSOa05ch1hoeZHrc1i0zMCxx2qfWDZrBzpQVWra48lBbsUei+iLoCKEVZKx
	 RAFedZftaXW3DfLxRjWY4FwAhv97uE+wGNT0ABUm2hbEAKTXUFAY6ZGjLkMUzFSNHx6kY
	 WF60xmwThRVFeuFzx1E6GuKwLZr55GrFycdP/kYpy1JNFuFq7fcgQz1+m/NX42o89OSeo
	 adeTpiEn12qmOkt8YgQC4zSZ+Cg967J7lTXyHJPuy8hZPKBdQrMxRgpItaGk9DlnyEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793281678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mw+K96+lcaUJRVaY3uX8RE4TKxxPuDGvwfv90LtyyjY=;
	b=LhHxx9vmZBt2wSXoxBQ3jsHQRX39h3+DVfs6nx6jsUEw/Pxc5CcAGNXvDmxBGFcfdVYO
	 TwOckaqyjj46KkvAdiwV46t8G+2DkWXzODIA7fLJVA1L2D8F6frAveNq1W/owusEma8Lb
	 gBhpC4pE0WNmOUevMv79uZc4bx2/UMzlOgvuyPkJBjjn2HZ8+KZ+Fn5wa9Nh8SoGiFUOl
	 bJv4iy/dCxD4nuKzDAlbQfr6miuOhbQzf5tyhqKEOTW9iHN7cUtxlzuKhT+uvcpPUKeiE
	 uUyw1a4LoH2e0M0lpxOGF14eFxYNxeevJeHIHJ0gFdF+krxC+FtKZd1ybwZayG+Wcsw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJIRJait;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793281678;
	bh=mw+K96+lcaUJRVaY3uX8RE4TKxxPuDGvwfv90LtyyjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e+ejwWA9rrLWzo/nzxa9zXSGOGKdt2UkzKMMuICkI1oPOlC61Gj0rMgvVTIslPzgp
	 ovvMidzIFHATSCLcWeAnPU9Kuvz93zR3sn63qgQQCqIP5gTzbbukE3tplXTTjC8gqF
	 dpyoQfOn+fFBoQGjHKvLBYavOylB9YqwW8T2cC7E06tpZgRWYfu+3bhN+hjfYxfn4b
	 nbl1HfWUY0EzdcmWlac92P7zPCKbOtWiu2INMRpZZyWFVMzOrJR9g5otsdQStdkKWT
	 b7VS+KUKQ3ThRwSpdr0zpBSjvUnBNA0+XR1aoW3xeCAgewu08NHNaSt/2mAP6WPXxW
	 xUIWaAjqoPkYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EBA480FF9;
	Thu, 29 Oct 2026 13:47:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B78F380
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8943880FAD
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yc5O2oVtpM9A for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 13:47:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E120480F81
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793281676;
 b=Sl62S1dLEKtrSxZjvxHtvqjMT9ESgiZtyJezO5TryKnjba+17l75mC0QmzAj+/G8469r
 dw97+JVmjCP+WPUHWq2lA9Hmw1SrazygEYEHtyeuFZoRpOgLfdO4nIA2x1N5+5V9rzhuz
 9K4Kh+/2z9Ypszq5TX5lW/En8V+Rfa+wlrY7rucr+ACGcoHNT1Sn1RKv1Sn010KBpVx5+
 VL5keWryW3kN8k52bzwoPuOVV/lVpGiKv+dcy05a9uA1iknXyfViZFEQFfGJZtjSkaCgc
 lZ11T5IDOxkXGOVI9r49rX6hdSo4ohdeb6ciQn1etxwQ3w3gtaDs/Ot+WPuS191p5IQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793281676;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=mw+K96+lcaUJRVaY3uX8RE4TKxxPuDGvwfv90LtyyjY=;
 b=JvSECfF3mgPEO33YUZEKvPM86LYXMfCV3NPvPD7oCUVKlnW3t/pEXTS2sYZkEJx+0pnq
 bWobwA22l7rThrGosgkyxviuoEVArjccNkJS7nadq9eKYKNm5i7jBrNI7Eu5ACpo7sWBo
 0cxsuL24p0u2ROtcWlBGJbS17/gkILd/W7dT0TYAFxvahJ6Hng9nxbuhPZ5M8Vrj75aVe
 SSc1gOlW0BaG7yhFGEuMD/T5dPSRxOOgEftxKQQvPgNqfoa+9aS5EAf0hw6LoER68lTXP
 w1QGpOsb2Ko7Ua1DlUF3HJfaRQhPucKZzUlLmPQa04OtnKpTUDk13kmWnUvc9kfDU1w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=VJIRJait; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=VJIRJait
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E120480F81
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:55 +0000 (UTC)
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-3282db206d3so1212300eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281675; x=1793886475;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mw+K96+lcaUJRVaY3uX8RE4TKxxPuDGvwfv90LtyyjY=;
 b=VJIRJaitgYRP+/YdJmDc96g5PBPRfDG/EpozUoSYe67Kiwu4bIQen69j1RNgsXWn42
 mPsYvC7ZoDzh0DfjkmFN3ztpXg48J4K4OKIOBJN7AHuIyfZ3jbe9WfcHTPRTf54VneG5
 H4WkkGqSbyUVKkvwByuVbMhbLI5mvmXkmJLf0xx6QHY6sjes1hW+/l7so2zDifmHcd7Y
 AugR1TXXV7a8UVeKrpJUaN8vB7hu15pgH9jKzxATE5g0Go7EMs5k2ZvuLoiaxvoQs19N
 /Uly4TgIvKTK7Eq7CCPhXwmO2gZlLbQ+XUkL04mtOu5ZDaFdidEInHz0JePdLapPNWUl
 dl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281675; x=1793886475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mw+K96+lcaUJRVaY3uX8RE4TKxxPuDGvwfv90LtyyjY=;
 b=XV1EXOPVVOIeaKzjbanO9Ybzqf5tm1ZQ+7/a/OmRWmZjqwvCeSX91Yb59uujJdQRu5
 561s+O8rXdkqk9IVCOctXtY0c5cQkFTcYAYA993EId22yPoZaY+U99N2iMhkoAi/yCuW
 dtGzH4HTJjz5lAILJW+BUpEZcM1MDslCe+xwt9sbLEs8D+dXvL3T7Y4/uMYE9eGguaGf
 D3THBCttn9EOJ2ZQjAl65l0JIupk0REybrkZfJLwVGvwsCmSZcbdBrOJt++7CKotUode
 +ypfkpYiEZysZXpaWEjtMxdMC0U7OX1eT6/CPB7uUFLrZv/uCgxksDDvG7CvA1IRh2Y9
 ZITg==
X-Gm-Message-State: AFq9FYKwgk+jEuhvzFUhJlxFcXwaWRWnRze5e834C0e8L2XOfPhw4tTA
 OLGpoHbogYLvwTN/Idal6awoJuR7otVTUZs7Jfay5XYAsbmQDpmWj7+4Q9l1Dg==
X-Gm-Gg: AYBFou12g09WTfn6rXdmxNADnGb3XQVTFllj8AeyQMkTlbW4mnTpILEUmr+/tdmjlhG
 KlZ9HgJY7inv1Vshpx8OQ9uzsMxb16D+2JkOznERJ9TGC1RAnlpeEm+bClnperkRpsQ38fifDvO
 q07LwwzCwlMIuhIDuyb1HjWtAVwaWujlSBMk4VHuxwHQHlfxGGsjCXgFjeSYYx7TYyGx5DYmpPn
 BQkvo1IXhxIWM1yJ+qrZfL2fgyImtrAy61WGwfkmeAk7VeXeDn/iMwqvkoCleR1vmRbXiivqlxb
 2TjRy8XIYjWI3IQSGztADmo2hRXjqxUcYX2DT61DVeNrVeywM4LMJiTGK9Zq4Dxk9fkXhfG258f
 R5mht1qGtuOFH8WvU2qm15wEfmgocpyuqn+JoGe8IF9VwbG+VsCRCsoEjnEQ2GHWuo1ZWcn2UdG
 lInYLqa4Q7avDBDbCUtkvuby2BLArwn183r6iy/RiTbNP7+Sn2dFa/FHLfH5K1xLqIsBzsa+QPD
 RirMpFKxY2ZlFocjUYHyL5ls2V5sur6M9XFWobQZHJ3sZaElnxrE8rzUW5a38RTKuFzaViKYcwr
 +1u3qbHruj/v5lGILYJZYI9fLB6Fhg==
X-Received: by 2002:a05:7300:c391:b0:36a:1709:458 with SMTP id
 5a478bee46e88-36a20419d8dmr8840997eec.27.1793281674416; 
 Thu, 29 Oct 2026 06:47:54 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.182]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390a812sm18032339eec.14.2026.10.29.06.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:47:53 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: [PATCH v1 5/6] pinctrl: spacemit: Add SPL support for K1 pinctrl
 driver
Date: Thu, 29 Oct 2026 19:16:54 +0530
Message-ID: <20261029134705.3767-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029134705.3767-1-linux.amoon@gmail.com>
References: <20261029134705.3767-1-linux.amoon@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add `SPL_PINCTRL_SPACEMIT_K1` to enable the SpacemiT K1
pinctrl driver during SPL initialization.

Depend on `SPL_PINCTRL`, `SPL_DM`, and `PINCTRL_GENERIC`,
and select `PINCTRL_SPACEMIT_K1` to reuse the existing
driver implementation.

This allows SPL to configure pin multiplexing for early
board initialization.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pinctrl/spacemit/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
index 87cba336923..5770e4865d9 100644
--- a/drivers/pinctrl/spacemit/Kconfig
+++ b/drivers/pinctrl/spacemit/Kconfig
@@ -7,3 +7,11 @@ config PINCTRL_SPACEMIT_K1
 	  The driver is controlled by a device tree node which contains both
 	  the GPIO definitions and pin control functions for each available
 	  multiplex function.
+
+config SPL_PINCTRL_SPACEMIT_K1
+	bool "Spacemit K1 pinctrl driver in SPL"
+	depends on SPL_PINCTRL && SPL_DM && PINCTRL_GENERIC
+	select PINCTRL_SPACEMIT_K1
+	help
+	  Enable the Spacemit K1 pinctrl driver in SPL.
+	  This allows SPL to configure pinctrl during early board initialization.
-- 
2.56.0

