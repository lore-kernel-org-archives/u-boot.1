Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07A60A2604
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U8ePZcRK;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rcAVuiLy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CCDA810C5;
	Wed, 21 Oct 2026 11:07:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VpgPmWPxw05l; Wed, 21 Oct 2026 11:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 666B6810A0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792580839;
	b=BF9wg2CmF628iVH5lN9GnzpAGokqqLcCFGZM+lgsoSS010KJHld3ee1gnN9aqvtjYPKi
	 g7mBgRyTsiS8sgcH6nMjJ4L+TtaMhY2JylO5NO/xAKjdgVvWgzf+2LICB5/95yNvtHPa1
	 Akvz3DdzLI6x1e4e+Cmf/gMsKh+QzeNebpsVviNU9buJTr58VdBYstRxC1m+CBlAnsN+3
	 yzDDKMEQ7kg1z2wRqHMFQyn8lKizihK1yg2H78p5tRw5dzpvv5k+gu6tWc470PpetAThp
	 Up5y9h12FLjNg7Uyyn3zJg2tHGZiQxTIH2fNTfvehK3oXXz/Xakf3NoxErw3aJkR1mQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792580839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p2v70atNY8sisTBFK2/xMmTdAJpD1uT+2WhlXKTx1xM=;
	b=FNWGvpbdUU+RuztEQDqgxfhq/RxGPFJWS3hweWaYVb/CZeguJkCuHmFC4PyZC01hds9+
	 ryPEjRae1hFrf3ujSEZCnWCOVIPXq8yTJBf30gppET+g4aGU5uqKSUjfvXhV0EaxpRaq9
	 kfLtg3CxtUhhVqqg0PHux9SzPwpH49pcvINTujoI7LXvYcAZ8zhE5icvJCXeOUV4dx2J4
	 GBu8SnERYkxgYc5sloRQHPoj9xCWK40IAXgD8g4ZqrWgxGE50DLcy7hi0jbikR23h+Icy
	 Nvcihsqk0x3kRmy54TEYewZy5SpG8crF61YNuG7lDOpgT1JtNL0GX5Vxnchw79yZVYw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792580839;
	bh=p2v70atNY8sisTBFK2/xMmTdAJpD1uT+2WhlXKTx1xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U8ePZcRKgyPzLkEaCvGSMtf0BBFTu/KIFe57qcKGKLN75ksNm0GZaL9bEaCrNpS+k
	 fVmmW4D3VrROKcUDcr9qkLAQNpUa3tDPs8FQBh7FBfYWv1rLpxRwJ72NjoFaCAyan1
	 zxBIt1n/F+M6/GbJjEKgzTTDY70vegSvW6SIZn4C5lN9z1+9hQG/Afsh4ODdVtPlTs
	 w2htB3X79slL5oidmi3NTB2MhrCIga1B+2NgG9Y5xuJ14+cdD4hme54OS7vgHV7xTK
	 ObiedCkwa0MywL2alW2Cm37iu7+tK0WCEoXd1ITYMOS1DIJgNGtPaRlCsdrtrp0MLF
	 jHjLRNfmFB53w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 666B6810A0;
	Wed, 21 Oct 2026 11:07:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BE32380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79453606C2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oP7O4hqSoL7t for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 11:07:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CD15A6068B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792580835;
 b=TKGB/sAmOs/fbqiVt+HdOSYawIIfstazurY/dp1HPQmo2VNEQRh8gSrB7Tgx7E506Ele
 Hx219oqQ+CdIlC9FcBig117FTFDBlEby+Guk9CjqY6d/rftEHxNqtwkxmjjzD2ErNwLca
 OiDAWILsr9s5E6k8LpTP3zstFwXb1y+xAVCE95J18JqZAQJwiRuxd28ypjQO3kS9+lGMS
 yLZhdrGRELp4EStfw7YR3tDfFDKD5PP4S5a5TwVfgB5whaqFQ+jgC9GU2Fcz7JmCy6uNp
 fVuosAOVoN1YugNj57qyRkJ0FDkZ/edWVbD9sgOlc5rGv9xInZiOqruRMpNyhb2a2oQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792580835;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=p2v70atNY8sisTBFK2/xMmTdAJpD1uT+2WhlXKTx1xM=;
 b=hg6JBsg1/yOi5XXuxw5PPX2xDtITvEAmrLvZF9usz5YyXBtqmUhCXPuAD9aEzdpdVplm
 l6k4lQKVhqBu7gUKnN/PErygr2+KrheQxnd2mgR2VeNiQtGRlu3TBiQQDGPsvkepQ9waN
 4HVi/S9FQIimWEr+lz/PCLVL0R13uA4n4/+o93yH0MYgYuK6+1CFTpuMd2yBqefczOWWj
 DkdrhUIpYbYBMU2ATVlKcUUxumBjNGdwFyDka0ON0hK5gevzGVVEE2a58wcgjLkzxVBat
 d7qDQvfauUbS18tygBrQmc6MkTmoObByeeaH3SOu3n73DOjd8bXX9BGg1IZ6qioFwvA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rcAVuiLy; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rcAVuiLy
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD15A6068B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:15 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3ad787e0593so364906a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792580835; x=1793185635;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p2v70atNY8sisTBFK2/xMmTdAJpD1uT+2WhlXKTx1xM=;
 b=rcAVuiLyikWN21zuYEsgVadB84PN8R5m73kiD4kcXCk7MZKDdHPzMsyxc60xXMjUyI
 h/GZC/NMKNsCuWvhMa08oWHskW74jcsuZS3rJUGJf/NnqQrzCPNyV7OUnemUNKeWrwDR
 xYuBYbRJ/2byABDaDENsJNMKq8aH2Xsd185z+eC5Zd4vmTpDKusSfgwYoSqwmPiScEBf
 cd68cM8dJHKKbDb70SZt0bi9tBnKRp+fGQL6YFXr20x09bKE4SWo/o6Tvw53e5nKqNIc
 gWvQdg9so9qF8j2ogwX5i3wSHgzLnLrxVndM1uWYCxdnXkDDRMyD5K7Pj+t8lXcW59lM
 GAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792580835; x=1793185635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p2v70atNY8sisTBFK2/xMmTdAJpD1uT+2WhlXKTx1xM=;
 b=PpyDIblnwalIm/HtTqOGMMA1m7kdOK5veV2Yvhd5wFs/VkDspaEcyJbo8+nIUgkefu
 cEftG/l4qSWP1ef7+vFsBXg+ggeDfYplYP9Gxwm4lC4gz5+5KTUwUDucY94ZEyU7h3AW
 DhqBV33RpxV9UMVJMYKnW/MUPDqSj7uB1/OXCtyAc1VqB8/ifgezR3EqtJHvOqgHFBEd
 QIhvQcrvZ81x0Y3shqO8SPgSg95NnyNdXLrVx0OM/76xZJhDS/ZN8i4yTH5utVJ/mHlc
 lRiVYal4Yp2mExE/MU9lg2hYV1f4Arf1XdkqhgGfgCv383Oe+XJzpxokb+wBUowb93M0
 4EWQ==
X-Gm-Message-State: AFq9FYJdtdZU4PFojItvKYNBCrcHAbd4PMkAScA3qOtkm+o9D/ZTpzCc
 OrUGpIJw2dlqWrMDQm3AxUHkVe2JindRwig3vYsXNnHsC4suQ7SP6lyxamlVErD6nqw=
X-Gm-Gg: AYBFou03VQcTvW0j45+MysQNtjGPFlRvOG+yhc4XZ3ulbuG37m3fUhrV9z7gPaj+fh3
 R79zlqjXJC5Dzr6VhYM+8e0ZkZdUaaM0Nbdvr9dT9dffOE3sYDM3HlYdXOfKBmS/Kpt7PvuZIxA
 jcJEexuJhoHl/lIMGE20t2ug35kA6KWU+z9a0QprS+awNe26ujedy0ckuMj1Yb7cpVjBW08iHcB
 gcAoi/Oo9iDaU+5S3CutpspyG51WSnxo/3Zy/myaEGg/TWF9j+3GWMw5coY2ZgifB7qSIRFYdEv
 7HUajnqsOcJ/pxJd4iIHXwgHP41BW4UdwTruSsewT9VAHVxyxyapyT2+suTIKZtuP/IsefEte1/
 AzCtqw6x63kgCJ/sH5CqDGdzNDY3VgDt7LS9BZGf8rjkK5y7FR7w014NnIVurEGdBJqpU++ltVn
 6028IjrZhIq/8FqwjhXpO7D/gqVq4QArlgcqyEqooppYq5Xs6BE6JVffvNeo+HeNpOzFDJYtKhe
 QOS2HVbNUItAp8FA60fZQS+/QQ6CriPxFyr7SeNHnyJARz21N99upx+zg+RQWoR6WQDOcok5tfe
 iV/HLntzoFYrfUsRiEoDiMCQXZZi1pfDtG96CI0sGpwinL5BPLkeIJEQPesw3ogDBet/S3AI4oG
 26qfuloyhYIwmNyjO06N4I7tq9Q/B/3JTOwKY
X-Received: by 2002:a17:90b:2781:b0:3ac:8897:7ba3 with SMTP id
 98e67ed59e1d1-3ad86f397f0mr1138197a91.62.1792580834711; 
 Wed, 21 Oct 2026 04:07:14 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad7ffbbba1sm4029380a91.1.2026.10.21.04.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:07:14 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de,
 Bin Meng <bin.meng@processmission.com>
Subject: [PATCH v4 2/5] doc: virtio: List the supported device types
Date: Wed, 21 Oct 2026 19:07:03 +0800
Message-ID: <20261021110706.2947351-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
References: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The list of supported device types still only named network and block
devices. Turn it into a bulleted list, which is easier to extend, and
add the entropy, 9P and RTC devices. Also note that the virtio RTC
device needs QEMU v11.1.0 or later.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v3)

Changes in v3:
- Retitle from "doc: virtio: Mention the RTC device", as the patch
  lists other devices too (Kuan-Wei)
- Turn the list of devices into a bulleted list (Kuan-Wei)
- Keep the Reviewed-by tags of Bin and Simon, as only the layout changed

 doc/develop/driver-model/virtio.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index e5da9f430..7b2f31b3d 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -28,7 +28,13 @@ queues configuration and buffer transfers are nearly identical. Both MMIO
 and PCI transport options are supported in U-Boot.
 
 The VirtIO spec defines a lots of VirtIO device types, however at present only
-network and block device, the most two commonly used devices, are supported.
+the following devices are supported.
+
+  - network
+  - block
+  - entropy (rng)
+  - 9P transport
+  - RTC
 
 The following QEMU targets are supported.
 
@@ -72,6 +78,8 @@ Requirements
 ------------
 It is required that QEMU v2.5.0+ should be used to test U-Boot VirtIO support
 on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
+The VirtIO RTC device (``-device virtio-rtc-pci`` or
+``-device virtio-rtc-device``) requires QEMU v11.1.0+.
 
 Testing
 -------
-- 
2.43.0

