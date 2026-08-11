Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE277C5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A12B560A4B;
	Tue, 11 Aug 2026 23:05:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aeYkWKMDFum4; Tue, 11 Aug 2026 23:05:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A779608B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786489511;
	bh=PB81JLhwiWFmGoZEbwCVu+aKL9M+NtHny5NHwMRzxlk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QXujRK7icdhx3G0iQFbR73zl8mqRKb1vxabdvauHG+POtjESjn4d74NV7fKfVwK8s
	 QAg0AjvcxAMDZYuhq3ZmF0YEU0iEEy3OuQKulnsJhi1vyAuMZwBCya83lwnzSVExTc
	 vYIRQ9enxsLZ4LJ72Xa1HX+j+TOrmLXBXCBS0UlnNXtk5Ybb3aaJ0WGJCb6ymtagAW
	 sMGIKKj+cBe2zLz3XrjZuDe24/ohJE2H+eVbWOyznsl9M9IaURlc2Exwyl7yGzp6eN
	 i/NLrZAzp2LRJQL8CsfcSiC7YNQ7E+8CwqYQoR8SlWNHjA5iFlUxlAvkhXFkGyUlFh
	 TAiH85s3yLp/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A779608B9;
	Tue, 11 Aug 2026 23:05:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 32C2D28A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18AC54059C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3-zKyVQY387 for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 19:17:42 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 13D334054B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13D334054B
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13D334054B
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:17:41 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a1f80fd2e4so395652a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786475860; x=1787080660;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PB81JLhwiWFmGoZEbwCVu+aKL9M+NtHny5NHwMRzxlk=;
 b=NmJL8a3kYBVuYdxYky0rALDTx7eVG4D935kMrshJ6xYJv4vN8+IuLqSpByjiDxowZU
 R0ZCBxUGCAkyvYijyvR0e3isVlgBHp+0iDOfScZt5Kksf8oshgEdo+rxCneaJQmU+gdU
 nVFjm6mJi4O64SZu5X7cA5piJelyxncxy4hGxMyMm18Fi0+Ar6Gm4Uo+aJRoQaXaEkom
 9MNEkoa2I7lQ4XCgqhihRMKAJKca0zqbDU5nS2q2ayLgHCI0YNDuptXU+YwQmdKiXkms
 IaFACs8YeC7TLUeHnYr+cmx8bO7X7NU9hXhwLCwkc4Qqk61ik2x61JP6PC8puUdKnsSi
 hVCw==
X-Gm-Message-State: AOJu0YxqWutooD5QQsaaRZw/6usAC+11rnTSMufa4A+/rY2HEbmielXN
 9GI4K+T2PBy4KoKAgrJErcj0VY63eqF+Uiku5MfkU2P5+Efn34/SEtT/qJ2nZ/V+gDAk/D1Gl0v
 jMfze8dQ=
X-Gm-Gg: AR+sD10mdJuDZOvevkSq4YBqEt17Ieis1EUkF7L43pH7uYgJssRfc/+aWvTg4Zd0iPf
 Rl3BvYu4LBrdGlKEBITdUoNPhB7oBX5AQN1RutXF9ZLSnflPW7oMzAmmUHgaQQuqFGSXai4J/XK
 vUVSu06VyiWexG/qH4+XpZV+LMK0N30VN+u/WDBT4GcWhQI5u89JY5aZM0U39MU2OFIifPdcTkN
 WR/b4SgU+Q1f+QUW0QRuUL/U2mez9aJo12sQUBSB46NGUVpL5IJu0n8xZNktAePLAz/a0f7VFkY
 4y7Wx7B+e9zcY8Js5umD5yBmmpWjLmJGYkj+W1Mxj+gb5CHXL+MDhr70I+S6JDZ+DAVS/tjikzU
 g07xyseFGPMl7i7TXS2Iz99vuNzqxJeTDAgui62mza3KIUsvDbtrvJZ9jXTHMCxSJ8EspNnGBfw
 DJVxwscbSwlCjw1IA2zEkKRo5wSh3n3NwScA7Bu41JlULNx06s/bQIhE7AS4YPNFH+qNFV3Cb9L
 LHWFzMt7qtprxrCI0pj4c4DxZ5p35s4Nd5fsa3/vEF0+P94MWS9iQ==
X-Received: by 2002:a17:907:6c12:b0:c1a:25cc:e585 with SMTP id
 a640c23a62f3a-c20ed8d1033mr101492966b.5.1786472178124; 
 Tue, 11 Aug 2026 11:16:18 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f001cf8ed71865ce089.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:1cf8:ed71:865c:e089])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20f0a9d52asm2288066b.33.2026.08.11.11.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:16:17 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 11 Aug 2026 20:15:48 +0200
Subject: [PATCH 1/2] net: nfs: reject a negative or oversized NFS read length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nfs-oob-fix-v1-1-5444d86d28d7@byteray.co.uk>
References: <20260811-nfs-oob-fix-v1-0-5444d86d28d7@byteray.co.uk>
In-Reply-To: <20260811-nfs-oob-fix-v1-0-5444d86d28d7@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 11 Aug 2026 23:05:00 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786475860; x=1787080660;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PB81JLhwiWFmGoZEbwCVu+aKL9M+NtHny5NHwMRzxlk=;
 b=vklWHFiJFcfh8MbdVICT+mYsUaqwf2n9oKCQvdaWnXllRZKho+r8IJEg3vyU6ysUP7
 zejmIR8rZadWyeRa43wlZidHqxgM/F0uOz22KfP8r5C5f50/MZER2lQ1zfwuG435TB0X
 yWftvbTRyQJ2bGFsvrS+jSqUcoU5cmd9eCX/SlyQZlqhfC5vqJ1cKMmsbFqAni52ZW23
 UAkumNG2c2q+7M1rr6u4ONAzkRIJ44uFxzRyBaH8ZKtOhwRfhGh96zE1dQD/EmFDLKzg
 fL/NZhE+7PnzK9r1pOGwIgMTFXGb82sMkdo4ThxYPF8ict4W3enAEvlktPoARNpMiLnH
 QQCQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=vklWHFiJ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

nfs_read_reply() stores the server-supplied read length in a signed int
rlen and checks it with:

	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
		return -9999;

On an LP64 target the pointer subtraction is a 64-bit ptrdiff_t, so a
length with the top bit set makes rlen negative, the sum stays negative
and the check passes. store_block() then takes rlen as an unsigned int,
so 0x80000000 becomes a ~2 GB length. memcpy() reads past the 1152-byte
rpc_pkt stack buffer and writes past image_load_addr.

A large positive rlen is also unsafe. The check bounds it by the packet
length rather than by rpc_pkt, so on the NFSv3 path (data_ptr at offset
128) an rlen up to 1128 still reads past the end of rpc_pkt.

Bound the length by NFS_READ_SIZE, the amount a read ever requests,
before it is used. Both the classic and the lwIP NFS clients reach this
through nfs_pkt_recv(), so the single check covers both.

Fixes: aa207cf3a6d6 ("CVE-2019-14194/CVE-2019-14198: nfs: fix unbounded memcpy with a failed length check at nfs_read_reply")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/nfs-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index 72d8fd823e3..020b0185ad1 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -738,6 +738,10 @@ static int nfs_read_reply(uchar *pkt, unsigned int len)
 			&rpc_pkt.u.reply.data[4 + nfsv3_data_offset];
 	}
 
+	/* reject a negative or too-large length */
+	if (rlen < 0 || rlen > NFS_READ_SIZE)
+		return -9999;
+
 	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
 		return -9999;
 

-- 
2.43.0

