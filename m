Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B5606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wx6PvuZq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c/KS3PcP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39FE3605E0;
	Tue,  3 Nov 2026 20:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cF2cuiufJT4o; Tue,  3 Nov 2026 20:53:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8239560697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793739228;
	b=W0jYL94Cf9mzgqSkPjSkKAHQYJQ0O/oS0Q2vzeuhwUKIsi5ZZIMkDPPvfgeYLvY/A87X
	 1FM9BVk2EbRySzX10yTBZhLPPJ5sGeNTLVceEmbv7DPFwgqmcvOAOmtviA9gIGxgHItBx
	 SsftLIxzB7F1YzUtr/B6a35n6q7LjZWX/3uZJgEB7XaKQMVEztATXTJrd/i/bjr4ZAoX4
	 gMnozd3QnY6nz5tr4uxujYfKb1VW/DJRKKYO9b3tueOHfRI/5tSBfk9Cm6/kliE7e8rsU
	 W4unKRcrjaVbyHw32pDQbyCbvxVO9Us+aKqog572O1j6bb6/J0qGDDquQ1RKpFCBoNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793739228;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CtrErwkH1V+5Mnrc8h7ATsMykG5jOjGH8jIeGiz+U/o=;
	b=q6AItwtOScHsuip/jWzZ/Axmi4P2PU8gC5dD9txIvdn1oZL4q95voShD8R45W5RVqEXv
	 KrwdakX96fVr8GGkPENg1HRnTyUDGXSMj8IbxHtXbpssG5bdEUlwV9S/aaNcHj7FoQtPX
	 fUtXpnt+D3UPLnUswP9MeMN0unt+3Pfs5+3T9r6lRxRD7eIp89K/FAPu4xrpcX8r0y8PQ
	 X1Rren8WaMw0el3r/OHSQR1MqEeHv8jaZWzm8DEXyH5AAxKVfZ3hyhPvNMZNlMHSUpCzC
	 kiDmHEAsuPa0xnShAIiCkpIirPWG7znqnCQUpKr+FaGJzqZVI+L5VJ4unNMmsLXD5jA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793739228;
	bh=CtrErwkH1V+5Mnrc8h7ATsMykG5jOjGH8jIeGiz+U/o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wx6PvuZqZ06rhN1hpM37Z9X9w/Uy/PdhV6t993qpP7M5ENTSi5c/8JmiO7gXHgcnM
	 w8NkERpzceKY/4yHlDkgcdLLvqt1Ffur8vSQ0bPoq0X1twdAQSSDbrLfHKlIthDe8q
	 9niWQxRe/loIThggJE59P6hg0kv+sFJsALzdmMhGmzS+3TZGvHTU/3+u7IXKl3No9f
	 urUlYEq3OJSUhNljC7QJoWSzfG0gRb2WMmwXD135p+AyAIt4/83GVjVjMFvAQGBr+d
	 nZ2ckz/Xccfzx2reEYmP3Tajfjd6wHAyZK/WJ9Y5/fm1CoebUSmCiLHQHFvAPoUoQe
	 NY/tX7TqvYm4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8239560697;
	Tue,  3 Nov 2026 20:53:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F7DDA10
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 19:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44DD74009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 19:05:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9eY2XAujzq3r for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 19:05:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7A5C740062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::834"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793732744;
 b=CDpl46ojxz0cA46Zyr2gUT0FZazMnIaIjoMYdvmsAGMmpqII4ubJBKVd504AlQhFgvJf
 dMns0u00ry9Gy9WX2ZvvsveRUEBkdz0wY2caffdHukS1R/IzwP5kZ73wuO8Ad09t5k6d8
 MSMYTsmwnJq1jb9dS1sxT6DajKW8pVG8X8dXEK+a91NMDwkzibVRSKMCzSqfVZ/I5aXVy
 3xLQaUEF71s1OFCLEROL7cQ9o+pxozgVH/43mkexw/nyvFHJgPMYQy2Xd6/oxMrddeRRu
 yKTilxWQQ60w++w0whtvedNAU8m4Ea0lOFlIdN6MqYKypLd2VpzEwU3pi2qVwiWRhgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793732744;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=CtrErwkH1V+5Mnrc8h7ATsMykG5jOjGH8jIeGiz+U/o=;
 b=jHRTwtsVCpsnQUa3idy54iMi3ozsmJqPEd106puQG5ejKEA5jpsF2Z44yir/nbmJmk64
 JVE6Hh/MgxO051dAhziQODZm4NTqi4z8fx1orI66op+1oAXwWD+0YdYRZm2z9VL8Ow2dY
 ZDvqkQXpiuJsr/rcHT6f9l3ddsXnJ/JPWSh9tB2CMhFebvU9oKAE5kackn7K8KDyLCBh1
 6PDj78pDwxYYi8FSvU7+/qSg+7nznrauRdXfwucat9TXbLW0WNdGicImVe+ExtL8ZEDMq
 xeb9A8jPRrxRA2p1ezUGwkmkxAN/OL9vge7PtqWzyVn6vNQuIS+C3Wl1nkm3yoZfSBQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="c/KS3PcP"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::834"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=c/KS3PcP
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A5C740062
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 19:05:44 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-53e1d40628eso13330091cf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 11:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793732743; x=1794337543;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CtrErwkH1V+5Mnrc8h7ATsMykG5jOjGH8jIeGiz+U/o=;
 b=c/KS3PcPk+6I6X7u2ohYH4mpwEgmOPX37w8Ku18oYXFt9TKi8qIlm5+GJT19q7D0FP
 cK7MJ4i2078P+5LUc1/jqz1GUoO2b9l26L+DY2znsdPKVds1MTpiksC2cAPYiZ94bZMc
 Wvzr2UFjd3Rkd6BTda5CiCnGkdDxpfnYS849salTf6uXWvQJIkg/uZWvG0PUXxdADvf4
 8b+w6YXF5ViMvWNzmxJsBZAMfZjxpnSVKMft13thO5usA+ZhuBzwQsObY1OyASPCWLDi
 0R7CiWfuYFdjzIqmM0EXbeB2jKnf7B3RJmmoBeJFZrdJ9N4zCYzZkpXx4oKzgQF+AaJd
 rRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793732743; x=1794337543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CtrErwkH1V+5Mnrc8h7ATsMykG5jOjGH8jIeGiz+U/o=;
 b=jXdvJNCq8fQKjvzk6wudXbgiwIHeBo1n8cpnJkgEXX6rPQP74MBFmCg+9I7u+zK2xL
 FwGGQtpGBnXQEfdoNaiV9MJe1iur/wpqzNi9vygizKbyMaObWclWKy9wHakzsw/nEGUb
 MTPh+JvwIl2Vp3Hf10AYUfsXohqyzEKXAIPt1KOatz6CZYgd7xIg0wvv+ZtWX2r7mbGz
 WkVgd9i/SZQIqzI+cQFB/FQfWEDRrWYEwmBD6nKpHRSRTZSzVm/gFftwzwvim6btJzCf
 /XA3bSU9YPAizUOOrjVX2voHlXs5PvzrMLh8gav/GvgkFGAJ/RfQ3ohsC5hXhiJezyA7
 9RYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0wfw5c0BQ6bvbPiImly3cZT5ANAcPydu7H6XNopLlGl+JoGAAtFDRIpXOuun4vmEJpdRhpkA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/JDPYzs5AFQKaqi2123cN6TDqHIy1NAKtCJv0oaJmQRlfiv1lQ
 Bkx7zgRzO5RMuk8p17dpyzCVm09r1pMYbvuzekmVp7FWdYSlV0kwoCPI
X-Gm-Gg: AYBFou0kMBL4xMJcsRO3I5eRnE4c7pG9wDyBZT1jTBWMuxpGi4ghuwTI7+0PMK4/9y6
 OD4RM7A6DfD1EOyX7gSP+LbMWNk5n02AqERZfmzk6ty6lRFytHfKtah5TFv0cBO1xK6sefhW6Hi
 jYzN5GAOyGiey5mM3ClEXAx0ZCDPzOwyYjbXql/AAX5JzeYeBV6FUC4l0gLaqt8nL+Z8qQEFg+m
 fR+suwUrNik24VhO1oV6viTbCGWQRBP8UJIW3G2W7WPQLWGvmlDnoE1VogXhaaaRNT00de5ex+7
 P5pXCagB2gicyr2NEuLWsDB8wLs/AlMEj1HjxaIoVgFBKK3kjGTHP0jcCw+eGmEJotY+BOVFl7G
 GPm87TMzitrCNn1ZLtMV1B/exuJzQWZV5e+Yw6L7Xy693D2mqgVxGPiWszdrbF5NlIJhURihund
 hUMWf3TM4TzSRcEtNDV/NPaZ7CvItq8nDl/By3LCtZZOmAV70DUJahowwJjrOEEjR+wT+YXaMbZ
 5bt9+gA8pZJzCfm8k7Jxxvwn6dW5td03jDY/xcuMJjzC7rwxJZI9AmOEqal045TvaKiJrR2jy7l
 CXo886hR3jrjEqBwuQ9VGZxA0VZFXG/p7LWzex5HK013V7/ruEWU
X-Received: by 2002:a05:622a:17ce:b0:535:70b3:fa05 with SMTP id
 d75a77b69052e-542b88d0440mr228707381cf.33.1793732742698; 
 Tue, 03 Nov 2026 11:05:42 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54b100ab8e4sm3527701cf.7.2026.11.03.11.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:05:41 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michael Chang <zhang971090220@gmail.com>, Stanley Chu <yschu@nuvoton.com>,
 Sean Anderson <sanderson@brivo.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] net: designware: Release the clocks if the PHY supply fails
Date: Tue,  3 Nov 2026 14:05:21 -0500
Message-ID: <20261103190537.1096121-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 20:53:47 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

designware_eth_probe() enables the clocks of the MAC before it enables
the PHY supply. If regulator_set_enable_if_allowed() fails, or on
NPCM8xx if setting "phy-supply-microvolt" fails, the probe returns
directly and skips the clk_release_all() at the end of the function. A
failed probe does not call designware_eth_remove(), so the clocks are
left enabled.

Go to the error path instead, as the later failures in the probe do.
This uses the mdio_err label, because clk_err only exists with
CONFIG_CLK; nothing between the two labels has been set up yet. The
PHY supply itself is still left enabled, as on the other error paths
and in designware_eth_remove().

Fixes: ba1f96672522 ("net: designware: add clock support")
Fixes: 8897f91a5397 ("net: designware: support phy io micro voltage setting.")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Build-tested only, on nanopi-r2s-rk3328 and A20-OLinuXino-Lime2
(CLK=y, DM_REGULATOR=y), arbel_evb (NPCM8XX) and socfpga_arria10
(DM_REGULATOR=n), with no new warnings in designware.c at W=1. I also
compiled designware.c with CONFIG_CLK undefined, since CLK is selected
on all these boards. Not tested at runtime: I have no board where the
PHY supply fails.

 drivers/net/designware.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 9470804ebd1..52dd08da82a 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -927,7 +927,8 @@ int designware_eth_probe(struct udevice *dev)
 		ret = regulator_set_enable_if_allowed(phy_supply, true);
 		if (ret) {
 			puts("Error enabling phy supply\n");
-			return ret;
+			err = ret;
+			goto mdio_err;
 		}
 #if IS_ENABLED(CONFIG_ARCH_NPCM8XX)
 		int phy_uv;
@@ -937,7 +938,8 @@ int designware_eth_probe(struct udevice *dev)
 			ret = regulator_set_value(phy_supply, phy_uv);
 			if (ret) {
 				puts("Error setting phy voltage\n");
-				return ret;
+				err = ret;
+				goto mdio_err;
 			}
 		}
 #endif
-- 
2.43.0

