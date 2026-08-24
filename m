Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E12C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B92C880B0C;
	Mon, 24 Aug 2026 13:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eHTBP3KFeVKo; Mon, 24 Aug 2026 13:13:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577218;
	bh=u0WxTZt3/hgqieQdn3mP1Bw9qYkQb/cgv/7aCB/odHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sUfsc7vkLWPGYqID7+tQlzkunGwKgCrFt2QPrGdG/t+Rq6EvvZi99HCnGDP0kpCjK
	 1k+G/G2AFFMKLOrXyPc8MQjnwX8v2bD+UFsuZ+FdmR3r73ToWEGj64Qc7ermrHY5Jk
	 q9UQPov36x2ekosRg3ma7GTQS4OIQ3SahckLA1w1th1jQbSFGKSXPtoTWiuz7kANHH
	 oc5+6mjaTtuXVYTVH43eoJl40AM2s6Lv7FeKluCiYVCPbSMQ6MvDxuK+B5N/v6nIf0
	 AB32N509Y2XY95WN9DdCnqVxHLsriKg3WuUwWbZPGT9HX9UizLnEX68JY1EiMaTh6t
	 F50iT4JxEZTRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D705280A83;
	Mon, 24 Aug 2026 13:13:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26C42279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13998406CE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8TC0pLSgAbsR for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=k23F1sC1
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9526A40699
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:34 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so1440975f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577212; x=1788182012;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u0WxTZt3/hgqieQdn3mP1Bw9qYkQb/cgv/7aCB/odHs=;
 b=k23F1sC1asH0bg8nsX/vW1HUTvCThOuom8rlHd6TSOd0UpZqlHlQbW4GGdyRYmQopR
 PJZmCp0j32oHTz1Ra1+gtMt4wB0rxzUL8TWAvvjhDc6hEB2FcirrG/CI6uK/jag9skAl
 XYZSBJRh7nJoyynAmvv9gD7rEWhVdWCbH4WsjgGt2OKN2cYvEgS8hBjn6tFswd2AUnBt
 ohhkJQmce76oV0aqDLZLsnfIwyrKCGHuAkG4KcNgRL6A2Ec5y6BYhM5ZNy7DFHZgtK6C
 YH+QLwXC0R4Ueygr3emApsTJeYuYIFFh/jgPhznlDyFEeVh0QMPcSfuc4M16xgmt0H3k
 nd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577212; x=1788182012;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u0WxTZt3/hgqieQdn3mP1Bw9qYkQb/cgv/7aCB/odHs=;
 b=E0jrOHRvLLo8rRW3fa3bVtUWDMm/O62fFubbYL4H8idO85jGaycmTIGYwz2lHMLchX
 0J+92wtUMnIfSMQ7IWczHesdnvzjqNKISY3Z5VXaTpMhSSapvIh984E0Xv8FNGZSLQ5r
 vywQKlRZELghgtDl3/EHo3QYV4jXQFc8Iqd7fWMbQoocvmIIEEFdcnVtBtDKZzSaB3vz
 EChfKvSSF4+7blFplcFV2MPLEOEhj3HVSvwvfjJVecwWPBNAtoz6YMYd9SIwLNGvF3Ss
 y2rJ60h0AQRcz5BCX0Z3ZJg4OKNKhKdg8VdGEY0pQHGwnsbQ1ZXzzDbet53qQ152y62q
 r1GQ==
X-Gm-Message-State: AFuF++lEGffKkSAtXgSkFmLQeXv80hkWa2ehUz6E8Ux0NuFtfb3mJacW
 gEIIzmHzhDfPBFfeHqKuRqzba4Z15nnn9cB/L9QSPujjDUofBGrGF5RudpnkokIWhTlQX2Y6e93
 qP+a5mCI=
X-Gm-Gg: AR+sD13qSpahzEyTr78RAx6ZV1y/ra/OrAygDXocsItG5ypq/mYFiDrkQxekIV+VkAs
 7S1pqZsP/aHr3C65K0PljG/UidIW1oguPcGUj1tkeTILoYJ5pmg+0MTA0CYLcgxE0imGTtSNeHx
 aSDO8HpmFUKzgiyN6BAE9Z4SYyapZFeHg1o0xPOHN2fbzhi9HswHiTknxgq+Rl8M9jzYPL6M1f5
 RRJjuNHL1YXYjavBQE1oyGeVCW2sag9+3X1ukL3288DtWzOjcIVARs9dJ66J4BbaAZuOID1ZPP0
 CfZOfcSTeuk0Ke15sIL0VqLNhIDeIcDQZEXvDbTucNS2lfz9Q0WSIQLXxoQCER404+mOIFfXE4F
 h4KTAqY3FFZ6ownw4EIT+0Ua6bCa33l3eoQgpSbD8rsZUg3xLSfyUEoY7VsgNzqL9dDcIIcecPf
 TxKN/kutIVcZgz1P58+wMyHAhRGhB5eDDblQ5zJ+4dVwb0GGrn42bqCLLeqbeJcG7/EI1fSdQWt
 HfzeJ6SP45gY+rUWLybO1UMsH7PN1YJO36otO6n9534PRJUatVc
X-Received: by 2002:adf:e010:0:10b0:482:d7db:9e1c with SMTP id
 ffacd0b85a97d-482d7db9e38mr2137041f8f.19.1787577212056; 
 Mon, 24 Aug 2026 06:13:32 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:31 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:04 +0400
Subject: [PATCH 07/17] pylibfdt: Work-around SWIG limitations with flexible
 arrays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-7-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Am0yYCZYb4wOTv+obknC0jTM5jYRl+3IT5pv0L8OelE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGet2vlyd5yu7ZwtJ/XqdS30zAseJdvtS9/Y/9X/3
 Esb05n7OyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhqPWuG/7VJ37kCayOmLO+ZUr2w/H3zumK/yeu6Wro5+D3fz6mqzGVkePpOtiC
 oW45l7+X7IbHSJcdiI0LqV6Td53ywcmkI89t0TgA=
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

From: Rob Herring <robh@kernel.org>

SWIG cannot generate setters for a struct's flexible array member and
emits C that does not compile:

./pylibfdt/libfdt_wrap.c: In function '_wrap_fdt_node_header_name_set':
./pylibfdt/libfdt_wrap.c:4350:18: error: cast specifies array type
./pylibfdt/libfdt_wrap.c:4350:16: error: invalid use of flexible array member
./pylibfdt/libfdt_wrap.c:4613:18: error: cast specifies array type
./pylibfdt/libfdt_wrap.c:4613:16: error: invalid use of flexible array member

Turns out this is a known issue with SWIG:
https://github.com/swig/swig/issues/1699

Implement the work-around to ignore the flexible array member. U-Boot's
copy of fdt.h still declares those members as zero-length arrays, so
nothing breaks today, but carrying the work-around now keeps the shipped
file in step with upstream and avoids the failure when the C libfdt is
next resynced.

This is a backport of dtc commit abbd523bae6e ("pylibfdt: Work-around
SWIG limitations with flexible arrays").

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[adapted to U-Boot]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 634ccd2a829a..2a7fdfb2af40 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -1041,6 +1041,9 @@ class NodeAdder():
 
 %rename(fdt_property) fdt_property_func;
 
+%immutable fdt_property::data;
+%immutable fdt_node_header::name;
+
 /*
  * fdt32_t is a big-endian 32-bit value defined to uint32_t in libfdt_env.h
  * so use the same type here.

-- 
2.54.0

