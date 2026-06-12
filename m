Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EC1CD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFA0E848F0;
	Fri, 12 Jun 2026 14:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NS9KDl5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E542483FEC; Fri, 12 Jun 2026 09:47:41 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B946A8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 09:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piyushthepal@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8423610ec93so640024b3a.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781250458; x=1781855258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IMrdpBLwtgNudIzjWDD987f63Qm2qC8/+0JNe44FmBw=;
 b=NS9KDl5pYEun8QYRi+ZfKiuP97RMfwfG0MU0OZUkSx6GkB+UcXJ/9vhvWmzaNzk/jr
 loEE7DcCG3BRvXSbcyjW2RYs2qJLx0ZZKM/kfbSthyf/+voe8wGkU1AsMGc46yBfmN3M
 qF4XxEGcA5TIQXCTJtbH+UJztKXOZvTdUNK4R2l7FC+I3cXDoCPHLvYlScQYceBIcJV6
 AKmQrP8eiHK6B3tpLKrKRurJ4RjbjikumDVOceJwTA5aAjRczHkQx8hihTuxQi4+3oZk
 KXcrrCNPBXTYyRylAzX7o00PmtAAzkUypGgHvX1GJLQtSIMFWZwmkS7bATxcUAqBoWoH
 G4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781250458; x=1781855258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMrdpBLwtgNudIzjWDD987f63Qm2qC8/+0JNe44FmBw=;
 b=hGb6D6aiQHi14zxo97MJ8SpS1RXVZIF5DKLMGxG/JC/b69us27jPpiYcIhcNwNDy5s
 FgIzZdf2DlL5IeXLjemRo88RhnzvbfURwCmp/1Cpe+VGhG2pRBdnC1HcDyXFYylS9wuT
 Nk7r9xVhtnag/fqKN+RBqqNqs4XQSPWJxVAj2wbZ4/iJpgu4WIxAUHCd2P/TyfrH18zI
 GwjQdK8Ph2Xr1sD1ef476Y4XPIRnB7IsI9bDIKADanldSrHR+XaHCaqSTgakxpSIAW6D
 t+H7YvAA2mKgSmgWNBrdCsSDyi9AdOGnrrLpl/wZmKr8ikXduK6f2YIv2H3I8bQ+370Q
 0W6A==
X-Gm-Message-State: AOJu0YzJSOibJ3GBlote4dYjyVZD/Vn5/aQg7Ll+Rn9g5/dsFPj85JYf
 8C2unwAqVagJYhuLIYd6sSLe4T4++MHOGRbwExYZt8+ylQ03QnTEXI+omP0FTMS/
X-Gm-Gg: Acq92OEr780OM4y7XjQuZw7JOIc9IHhGOnb848Lx4kK9a7Ct3Oh5Z5DmdIGOHSGkLZk
 c/idXpJRNzThWQPjp3IKdq8jsRfwl1ZecSocAhY2prQrOGrUTMVb2xY2z8T9zehW2N7QsQyovo4
 844yh3OoUuL8mab/zZy+/rf/oeLzNxVOC0ywpp3zTizQLW30WaIzsGUSj7W/ZVK7s2I5DrcLTw8
 asEin1y6C/c3oe7iZAXYYdTaTWD5OoS8yVAOoUTw1+9KwlSitf2iGPIbxhvL+GzPjyhE+JYBBv+
 kc/Ol+iJLTPXwHP/2pjFbJjiWnp5Xw8Xg7Z1prx0maT8DsXRKLTxO0LjJf3tvCv4Viu/KfRfLag
 YNEZRVLFA0fzb04M6XGLR2dVfR4JInzeJG62EpAS5yAmfYf75e6gsOx6kCGTTqsEMdDqCV27m4v
 oWjYrOxLr9xx+1gFUFBA5Ou2/LPQcOIPA0hQzQUnJV4s1RVYnmu61rimo=
X-Received: by 2002:a05:6a00:84e:b0:841:d7f6:7297 with SMTP id
 d2e1a72fcca58-8434ce6b927mr1957626b3a.40.1781250458164; 
 Fri, 12 Jun 2026 00:47:38 -0700 (PDT)
Received: from localhost.localdomain ([116.72.140.90])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434afd50e6sm1337683b3a.30.2026.06.12.00.47.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jun 2026 00:47:37 -0700 (PDT)
From: Piyush Paliwal <piyushthepal@gmail.com>
To: u-boot@lists.denx.de
Cc: jerome.forissier@arm.com, trini@konsulko.com, fberder@outlook.fr,
 Piyush Paliwal <piyushthepal@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] net: cdp: reject CDP TLVs with a length below the 4-byte
 header
Date: Fri, 12 Jun 2026 13:17:30 +0530
Message-ID: <20260612074730.82719-1-piyushthepal@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

cdp_receive() reads a 16-bit TLV length (tlen) from the packet and only
checks that it does not exceed the remaining buffer (tlen > len). It then
unconditionally does "tlen -= 4" to skip the TLV header. As tlen is a
u16, a crafted TLV with a length of 0..3 underflows tlen to ~65532-65535.

For a CDP_APPLIANCE_VLAN_TLV the underflowed length then drives the inner
"while (tlen > 0)" loop, which walks ~64KB past the receive buffer reading
*ss each step -> out-of-bounds read (crash / info-influence). A length of
0 additionally fails to advance pkt/len, hanging the parse loop.

Reject any TLV whose declared length is smaller than its own 4-byte
header. This is the same class of bug as the recent bootp/dhcpv6/sntp/nfs
fixes (unchecked length field), in a sibling LAN parser that was missed.

Verified with a standalone AddressSanitizer harness using the verbatim
cdp_receive()/cdp_compute_csum() routines: a 16-byte CDP frame with an
appliance-VLAN TLV of length 3 triggers a heap-buffer-overflow READ that
the check eliminates.

Fixes: f575ae1f7d39 ("net: Move CDP out of net.c")
Cc: stable@vger.kernel.org
Signed-off-by: Piyush Paliwal <piyushthepal@gmail.com>
---
 net/cdp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/cdp.c b/net/cdp.c
index 6e404981d4a..300b3d5c409 100644
--- a/net/cdp.c
+++ b/net/cdp.c
@@ -276,7 +276,13 @@ void cdp_receive(const uchar *pkt, unsigned len)
 		ss = (const ushort *)pkt;
 		type = ntohs(ss[0]);
 		tlen = ntohs(ss[1]);
-		if (tlen > len)
+		/*
+		 * tlen includes the 4-byte TLV header, so it must be at
+		 * least 4.  Without this check a crafted tlen < 4 makes the
+		 * "tlen -= 4" below underflow (tlen is a ushort), and a tlen
+		 * of 0 also fails to advance pkt/len, hanging the loop.
+		 */
+		if (tlen < 4 || tlen > len)
 			goto pkt_short;
 
 		pkt += tlen;
-- 
2.41.0

