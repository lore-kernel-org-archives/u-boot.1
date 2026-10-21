Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F72606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lUGztXz6;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=d8YXsqpo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6615481176;
	Wed, 21 Oct 2026 14:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v5Zmq9XILqma; Wed, 21 Oct 2026 14:05:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 850B081179
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591541;
	b=eRlpIKHIYKvHIsNO5hm1Z7a9Cm7SyWltYpfXiKJTVN4cZgm8Eb8ERULMsA+PsIXqDM1f
	 ShOBex6aKcKCAicYk2R2esXkuHDdBhndx47nea5imEDtLHxhhlHPcg6lmzCokC9oV44Ax
	 RJpZJ4x2FiBiiccPstx4u63p/+QI4DmD5r3FCBMEtCJ540YeDuMx/kGbzOM7l9wq48oWg
	 V+I5wI7dufSugfBgglEU1xkNCu4q2do1hJWVcItXjlAW4/2dIcWqONNB0QfSEdyrUeTVW
	 rYt82jGLJfM871LJEvEjPdEWnDxwKjnOi8oay7Q/GknYeB6YZoi0o5xeIeWe2IUOyaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591541;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BhQy5mjPEkhHRJYNaAOqumLSshThuPL4drLaEqGHPRI=;
	b=Z9FKJp3Fo0sCDjPUDTbvVS7Yc7g5akw/WZM5q498Udl0f9zrpiz/FGO3PHWc5K6CAJeH
	 /HoF6rmhe8DtnAFQrBdZfhdsElI5bY5oSoTzUitHjw4xGsLKKBIw/57fo9SdbC1kzpEkb
	 ecPR3t2W6SVJGu2BjguutEDdOHd8oiP76ZRzB4hOVADocft4awVrNIOauuYubqoQvnewB
	 Qte16bEZEi40Iekgah5EbTS5giyXVx6B5U4+PFtREUx2KM+6JxBVjlM8xk3V/QHQlbTOx
	 KTMlibilm7zq8qTb0TJ+/uSIpBQLDviVOPeh3/K8fLyGZh8iHWWLkgtOFMRmzqkYUhQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591541;
	bh=BhQy5mjPEkhHRJYNaAOqumLSshThuPL4drLaEqGHPRI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lUGztXz6qI0Y87k5aMtruvBBuW4RuH0IoNzs814MWVRE0iWig0OFCw+21wAqw4r4U
	 5UIKJHLFreLyrAIfq/yC9u4IYEojceMrJHB9zSUTH57fb6GOIzmmFk+ZUUWZ89pdHy
	 +vGsYiXGeBuCFhJLmx2lTOpEMQwycacOsbCwv2Wqeb778CEqkNqrI4pAze5pYd6u0g
	 tQh5ZdoEZY+47UYuPoeAL7bxjOiJo3EX7oMwGXkU8ET2+ojtPsmteGHveY/jno3PvB
	 sDfchWoAXPDcufxM1x8vpEakSp+Mb5mUKdwvY1CD3ct3+h02Z29MI5U/g5doVX7bPX
	 7limemmV/lCaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 850B081179;
	Wed, 21 Oct 2026 14:05:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 93CF43AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8546D60823
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PFMyY97hLunx for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3EFFF60844
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591538;
 b=RVZM6x0eqpyNkSzH1ghIDbGjlKPDWJlfhNm5fcZdaGvGiMF9YSDA83JhJjBzduHlvYAp
 +S1tcJVNkmo6CgyWwbJZY+jlV2tJVIZEF4ZkQzVypMJ8HqBohwDq14nz8i6gxhzImaarW
 0YEUQaXOWCqQmvVmRsLkiuxVLLmafmXEIJRPZizB4bLZUDeqHCnIlXF6sQ+Iy66DDZWB/
 7vAVpgznHU+K8gwAyTE898TQ+/ybkYY70Gt+/uCfrlgeTdKHW6GZcQaef8COxNkk6bTNX
 C5rA6pwJqZVECzcPCO/06Qk4gIeSE63qNdUdc1PHE1KVqrnf8T8Bin1X7pu7SIaktpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591538;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=BhQy5mjPEkhHRJYNaAOqumLSshThuPL4drLaEqGHPRI=;
 b=PYwrMRjaQtUukqFYG8eqilGbC8tGmyTNhaf7bgjglSVV3AYOg0ZsHsIezsevFvwNSFPw
 5SipWZBsiO1pDXG1oWlxFryWHbTtbKXK0VsFYgNLcyZiIB3DihT0gOu9gmND1RsObIW4I
 5SQj6EGH8ByExIVqBqbmLo0AbbN+oSrJsSUoObc6Vc/b6WfJ+jxyCR0syJ5nlWCZdCAy3
 ooXkqbT2bWxISPbG5fuZ6WrRtnKbyggOnmns5/aXZf4EjAwm8XPKwwAzlN2IYPH094lvY
 R11uRXfNPgs3OWnLa3s2gksXF9BQ/idGpHz/g20CY9EyUcYvSmpEvpaDhzJIycDOAvw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=d8YXsqpo; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=d8YXsqpo
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EFFF60844
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:05:36 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so6270115e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792591534; x=1793196334;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BhQy5mjPEkhHRJYNaAOqumLSshThuPL4drLaEqGHPRI=;
 b=d8YXsqpoeneS8pYkQgiZqKQg8U2rZtacyuBTSm64Qm3CK0BLv/UX9bxfa4+cPPY9qU
 0jvEB0XaLo1D8uwFGvJL5QKxEjJhQ5JBWPRFMPZcyIHzzbAfOzzmV7Dym41OAv2DsOKz
 W7FSmZvQklqXPitm9F3wV2EwGPcCdbS0CmF5SktB53mgnlQhw4F1DJC4RzOuv1aO+45r
 6vI7SQx8f3xazdGTOWqWveTwvj3QFS4wpEsbbmOAEl5zO87hLqhLmXm7I7muUTzrdr72
 AMhQ+PPwHcU6JxB7iHc19ZmUjbbbhLi0Bm6VBcGctdEsc0MvqGwHOypa9INxL4mVAOxA
 bFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792591534; x=1793196334;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BhQy5mjPEkhHRJYNaAOqumLSshThuPL4drLaEqGHPRI=;
 b=L9omuwVQBaObbU2dZYpgUWFvpWh87Xw33IrknIlr/yUOqgFS0kApVIwyU/nm4cqGYi
 GhkrWXn4Cvr1SX+A6YKBAfbCuXZcXzez6CWCku4LHEi7ywX3Ypv0xAnYwPdX9FWXmM7F
 OsNc5BDDJAX5jbXY2tR4RdXXtHaaOsJbvebDsyU8CI9bLd+yPsyr5Am5pdLX4+KBkwKu
 p1RaaUr29ca4eh/PQ/yWM9tknvZJYa/SkVG7yNESFMng7Wn4yiv6RiKbE0ZLJaKcpZQo
 uyk+613LPagF1vHucplb9BV/y0xICpoPy2UQwGAbSm71Ub4pTtgSIwSeiTSWX5U7g4JL
 ILnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlCSAOPG0k94EBgN5WJnPPuz3QX6CRJ0SyUS7kv1mtHkdVp0by5LtqmE9x9XzUfpEukXo1jXI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL7ihxJWgDWzLbyxx6NvhQigv+uXUUdQF2eQBrPDSLPRTVmHhcI
 zPGDTlFCVNMNwwJad9p0J3KhX1MSwt2KvFNL3/+qsN6UFB3qMgJlwef4+XnZ1hpG6wMYt/Lg2od
 BjF2N
X-Gm-Gg: AYBFou3229Nozxzy/ettWybrkudOEWIK3ucfubq0yqpVjdmuO1GwNKBjDq+BjU311VV
 pKwHXIY+lgaVkVDHXamBIZm1vp+HOBLjjHItbpgnQ/vCHy1SNy56f8itxNSMNq5+rdyVfkcrArm
 fe6o7XF5nzX1OGFSD5l1u9veuZFrXwmUbHbhfmTue6pMPgbCINvU29wc3cGfxZLsuDqMJhOadGn
 NGxGPmwXIfP1lHLKsL0nKL1F+Z6nfihLxDNnmY4ieZ3nBrDVCUlc6OgXfL+PWVuEGfhVZqrl0MG
 7779LKAtNqCQv9dFrtdA26z+R4FQH3LNQ0FeysUJkfCzXA6uGo0XYELtqKKjLQzOvzbIzYc6X/m
 WW3JpJ4SOSzjmssLHk9B2VT4/+EnZMu9lj0AUshrdeCkIOfkOR909Bts7vddyOjE1xLtvJPRE/Z
 eSpKch+kk3iyxqJyezAsET/C8BrXVvBoh6zv6mxQF4ESfarOVS3PD+mWTSh59HbyjW70RDavP0Y
 jnNcu1OxlH6TJyW8JrfOQ9U8SE4BwFKR8dneqCNyMEsGaKt9klt2WjOYw5U9U4ZtcruiZgMnvSs
 GTdQUhhyIEb82SzIUjZT8l9T9v+wVJuarYTCYpS+U1QjRtwCmzhUSKQm
X-Received: by 2002:a05:600c:3ba4:b0:4a0:1a7f:2abb with SMTP id
 5b1f17b1804b1-4a1fdb07925mr51763425e9.11.1792591534126; 
 Wed, 21 Oct 2026 07:05:34 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a201d7ac99sm19070045e9.9.2026.10.21.07.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:05:33 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 21 Oct 2026 18:05:27 +0400
Subject: [PATCH] configs: rk3576: Move SYS_LOAD_ADDR clear of the RAM boot FIT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-rk3576-load-addr-v1-1-2b38b39044ac@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrm3CdAAjVzEshmnVggHSUUJCu
 LujLt/i/x2SmEqCttjBZNWk85ThTgXER5jugsrZQCU1riSHNvr63OBzDoyB2ZCEohfP9SVUkLP
 F5Kbbb3nt/k7vfpD4+n7gOD6uygrbdAAAAA==
X-Change-ID: 20261021-rk3576-load-addr-2e2c3e3d59a4
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Heiko Stuebner <heiko@sntech.de>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4671; i=alchark@flipper.net;
 h=from:subject:message-id; bh=jipnJtS571QZwTaanDrbUFuA03PCImNjSqh3nizStOw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdOLb61u/QSQa1+z9P7Q+02Nhv8+uB4VsmIe3SHUL3l
 29PYvP61DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUV11i+B9iXa59+N1COzvOmnuZrsfuJJsedDz1TTDbM13obitLpiUjQ39Xh3y
 lwmo9vaOfXj38eKesbo23q+7a1C2fd3Yu2ezuxQgA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

SPL stages a compressed FIT image at SYS_LOAD_ADDR to verify and unpack
it. When booting from RAM, as from Maskrom, the whole FIT already sits in
DRAM at SPL_LOAD_FIT_ADDRESS (0x40200000), and a large FIT (e.g. carrying
a Falcon mode kernel and an initramfs) runs well past 0x40c00800.

Use 0x48000000 on every RK3576 board to avoid overlapping the source FIT
with the destination address.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/generic-rk3576_defconfig     | 2 +-
 configs/nanopi-m5-rk3576_defconfig   | 2 +-
 configs/nanopi-r76s-rk3576_defconfig | 2 +-
 configs/omni3576-rk3576_defconfig    | 2 +-
 configs/roc-pc-rk3576_defconfig      | 2 +-
 configs/rock-4d-rk3576_defconfig     | 2 +-
 configs/sige5-rk3576_defconfig       | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
index 5e25653820c2..fe2b5cde4b2e 100644
--- a/configs/generic-rk3576_defconfig
+++ b/configs/generic-rk3576_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rk3576-generic"
 CONFIG_ROCKCHIP_RK3576=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_SYS_LOAD_ADDR=0x48000000
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/nanopi-m5-rk3576_defconfig b/configs/nanopi-m5-rk3576_defconfig
index 88b6d0f9e868..ef799c799939 100644
--- a/configs/nanopi-m5-rk3576_defconfig
+++ b/configs/nanopi-m5-rk3576_defconfig
@@ -8,7 +8,7 @@ CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-nanopi-m5"
 CONFIG_ROCKCHIP_RK3576=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_SYS_LOAD_ADDR=0x48000000
 CONFIG_SF_DEFAULT_BUS=6
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/nanopi-r76s-rk3576_defconfig b/configs/nanopi-r76s-rk3576_defconfig
index af149dc4ba56..86b19f5e9ca7 100644
--- a/configs/nanopi-r76s-rk3576_defconfig
+++ b/configs/nanopi-r76s-rk3576_defconfig
@@ -5,7 +5,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-nanopi-r76s"
 CONFIG_ROCKCHIP_RK3576=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_SYS_LOAD_ADDR=0x48000000
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/omni3576-rk3576_defconfig b/configs/omni3576-rk3576_defconfig
index 13ef3112f1b8..969c4fe6c281 100644
--- a/configs/omni3576-rk3576_defconfig
+++ b/configs/omni3576-rk3576_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-luckfox-omni3576"
 CONFIG_ROCKCHIP_RK3576=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_SYS_LOAD_ADDR=0x48000000
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y
diff --git a/configs/roc-pc-rk3576_defconfig b/configs/roc-pc-rk3576_defconfig
index 53491efcec25..7023c3dd0488 100644
--- a/configs/roc-pc-rk3576_defconfig
+++ b/configs/roc-pc-rk3576_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-roc-pc"
 CONFIG_ROCKCHIP_RK3576=y
 CONFIG_TARGET_ROC_PC_RK3576=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_SYS_LOAD_ADDR=0x48000000
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
index 93faf09962cf..be8f94926e93 100644
--- a/configs/rock-4d-rk3576_defconfig
+++ b/configs/rock-4d-rk3576_defconfig
@@ -8,7 +8,7 @@ CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-rock-4d"
 CONFIG_ROCKCHIP_RK3576=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_SYS_LOAD_ADDR=0x48000000
 CONFIG_SF_DEFAULT_BUS=5
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/sige5-rk3576_defconfig b/configs/sige5-rk3576_defconfig
index be46f63798b5..01a1632f5a34 100644
--- a/configs/sige5-rk3576_defconfig
+++ b/configs/sige5-rk3576_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-armsom-sige5"
 CONFIG_ROCKCHIP_RK3576=y
-CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_SYS_LOAD_ADDR=0x48000000
 CONFIG_DEBUG_UART_BASE=0x2AD40000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_PCI=y

---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
change-id: 20261021-rk3576-load-addr-2e2c3e3d59a4

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

