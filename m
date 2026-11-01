Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC8606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D5JIHuRF;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwc+ui84
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AABFF80886;
	Sun,  1 Nov 2026 05:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPQGuS0-6qTJ; Sun,  1 Nov 2026 05:53:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D5D3A807E0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793512414;
	b=A+xQYEjYhBT+VBPnHvaO9+KUYdHzxJWr4q/6QBCe3Duzc3YmpogFFA4sFnus1nsGa0Jp
	 Ihr2zMouv1Kd0KpQTPYI8VQKhT5S8sdVZx0jpl+B0feeeBqh8mIToGxZkE9OKwxD0EqiI
	 nfDDlLMK6aCSvnyLTLWN/LEFRuCsD7XuLa7RXGiFP6Kr2vHQHjlM/nXo9UGFkLdw0OAJw
	 4i4oIAYYuRB/jolQKobMwazI8bjOTQKXCfCNWeFtCkov6Q0gJnGe117JIrFImsIzWceXd
	 X7PXYqb2GKABDDa2ZsQykwOgGtefQu3bThVPiHfhW8QhS3fZQ4z6B5ZYCkqS8UaQCCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793512414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=kxvREACi8LjW4XWoIyDYpv8iQHc4dqsiODxlrhQt5ig=;
	b=fSKv5fsawRCNXMwpgjVG81I03uKkAauBLmSLueOraVpRlhoE1wO274uCOKPEopDhm9GV
	 eLtM2jAGrxANfvuz7KcaI8K8u0sg7T5yJncqjK54gj/uGYYSIN5n/MHyUfynm3bnMGOP4
	 PDFitlWyvZuTk8atf0CL7j1dBJjMaH7vozihMq55aVx8IDt3UIFcStiqOjyt451Trejey
	 9EisuGQjq3A/mec72QPnugbAhUd5zRJV4XbJJFTqahBfGqjWBOCWW/z+iwlzVdJz+Vtff
	 rfwMyjSufkwrbMOl8nnZLfSGwL68pyjrjwA56NzsxxDRKjk4UZk1aSaD82AH/f7C3Ng==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793512414;
	bh=kxvREACi8LjW4XWoIyDYpv8iQHc4dqsiODxlrhQt5ig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=D5JIHuRFQ6mdLhWT58FyPtlVS2eMcE7Ee7vuhf5yoSmTATCVylBDt9ifrngjnEFL8
	 /utv+csMoFXcpvbIrJKhxvkeSJoUpyYoHjRKdAThnyONrM465/xKLQmS9VCx5/ZugQ
	 z2au3V/UKDFmP6oqBSYG2EYASivbLPA7DClAXVOfUKaq96a56Rngd5Ng4al2SIaX61
	 a5MZ3gPbWKXv/uv1hV8wxFnJx+2rumaZXgn9NeW+dW8En9b+dswQ5roXojQoAULCHF
	 1aUK8dLmiqSoValVygk2Yh2Dczv99dKTWiEAhYpt9owuNtetg9udpZaMlgZknlVqkU
	 l4UOCLYVjYCwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5D3A807E0;
	Sun,  1 Nov 2026 05:53:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AA7F932A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C5A640783
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRpgzosIMNdf for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 05:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B513840647
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793512411;
 b=LIAYaxTd8cS9nJSjKiNl6SCIpEiNMPUa4DIQvuQqYHXMFlqs4OS9/SQvpwYaKZONlOhq
 HPjZNuO1TEE1/xw2qc6lhj4ZdfHTiA24obbdNdmUtoeTa3Gr3vsqOmZT3pfLSQSyx9HxT
 PMtQ2pLyuyD/ZBb4Aw2dToVEHzQoVBpuJ321RUTGb3iea7mZGR1FS81vzxKGBcIH3o/wp
 SR3PiIEWAiFyi+haRuTCgy7JYb0kVipR2b/hyCObQdWCO6HBF93T9mBh44XjypD60urRv
 rUtuP19ousFwNDsGRik/WFmoas8nbf8hElHyjvVGChTN9NSvG6fpq8tGxtLWAtUQBPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793512411;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=kxvREACi8LjW4XWoIyDYpv8iQHc4dqsiODxlrhQt5ig=;
 b=smNsdsaZF5xCR2m80/L9tVFdMnSkuW4MD9GU8x8PRrIsqFZ+HKzIPiNN0Jbe8RJXRgTW
 i4725TeplYK9+9H5YwUM0xY6vdRxQFEuzNoKiSw80o+y5ql7w9/DqWo23qz39F8wNKeME
 QjbWjLb7AL/nEd7LruV11XJX44wFWSlMFao8HV7TMoiD1XFgNThkEq2Y7e/XjJm1FHZ5n
 ZPwQhscOMRiov6VieacBMAmCtMfscBG2ZmPs9w5poZY3aWFzIlT0+esAtCra/VSHy4DKg
 izKjK5hgbKhF+c22JvSM0FDua9uJs3PR+FSA58U9JPpcAy17Wl5Jm2EXeaWdaLgH3nw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lwc+ui84; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=lwc+ui84
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B513840647
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 05:53:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 82887600E2;
 Sun,  1 Nov 2026 05:53:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793512408;
 b=IB+wxE1GmPKalmqhZfsBU1g6tDpZ2G/iBtBnD4GInPNgpdTk9VHYMb2dpVJCJvN1CkMa
 PsX/WLL6gUtrh/jn6QAr1xda8D4m37oWQuKLiIz21DnFdF4Y55/Q6mzeMWQrwE1HRrAPW
 TzVFTZvKRRg1rgsStlW/ngPTf+65dyIzL+S6horGyfmo7LevFfcXS9KRT2qa2pnGgMztj
 DHEHY1tZ63en74TOZkZc1U07PIeG1hn2RBfAv0seMsvdfv1NU5WST0zZOJSCTz84ZGW4p
 uYrhMw/9tmK2YAKLUd/x1KNsQ/Tcv/bR0SwSgQhddlLkO+VrDkMwX2aMjW1WvNlOt9A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793512408;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=kxvREACi8LjW4XWoIyDYpv8iQHc4dqsiODxlrhQt5ig=;
 b=ZctWs5wffO6gXzNDrxrF9KZuQqhKHiDXHvAxBk7LaOOz29bE9RnEpNnqv0g97KCHQcIT
 J2DKpUWtoRA9bEGtcmXmJpXtpZhM8nVwfuTKm77SXEmPbwmrT2RZDxm63OYiz+nM8wbqs
 DqrYsYda7YNOfdCRapNQAebDhk17JItG9Wif8emZibDHSJavoWmiI6Ye3QDMelw30kFMy
 kWBhFWEWcCAEaXqOfP7O8ZkaLF3Kd4nruAmRa5S6t/b+BQNhsBz9Opk53f6VCYpvrxIVt
 r9ItR7eyBKjrLFMtdaAfRDK4najm/3QjIkcN6EZBv/u6n0584TKoGHjyD8g1ZN3oVEw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B0AC31F0093A;
 Sun,  1 Nov 2026 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793512408;
 bh=kxvREACi8LjW4XWoIyDYpv8iQHc4dqsiODxlrhQt5ig=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=lwc+ui84yz67CQ/daES2BYruzd9ac3PjEuhJKCxfwfIZN1m3O2CDfiG0iLPK1+fZO
 SGR029xyJdNglIiuBOOwaHWW0EWkYqii2LfIPHMhVsoGeD7se5fcO2xY3hSLUco/mm
 e1oLZ98/bj8oOiCI5nlfTuS1P1iEsSPKfF3jVKpZo73bpcbLklfS+PqvHes8rmrsq3
 ROXYm4kdJS74VuJaLv87BCrxu/LOw29aF27zHHL/YaIhJzYD6DSf052VyW9GaFAsQr
 13AC49c76wbUQHN7srQR/mPCiJsJ76e911J4z8PEl6WN/hytkgHwFpBn0zeGn+Tdaf
 b0EIO7JmqehgQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 348CA46067;
 Sun,  1 Nov 2026 05:53:27 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 01 Nov 2026 07:53:23 +0200
Subject: [PATCH 1/4] net: lwip: wget: accept a reply without Content-Length
 in the size check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261101-b4-wget-blk-r4-v1-1-e27a009e4043@iav.lv>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
In-Reply-To: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=TDF9ci9SZKFcxvNZwjYU/0WyvOpe+mObPBtoevX1nRA=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnPLl+ZovaepyXj6qmVT3bNN6/0f9ExledQr1f5Sb1tf
 GxpX5be6ihlYRDjYpAVU2SZcEjjVsaSq3/9PcwfwMxhZQIZwsDFKQAT8QxiZOhUe83Ae0fsj9ii
 PzMUZvb4u+z6tJzr3D/Dp8Gico2yBksZ/gppTxVtKd+a88irzHt/YKdW1SEX38l92fveS/QcFAg
 W4gMA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

lwIP passes 0xffffffff as the content length when a reply has no usable
Content-Length header. With check_buffer_size set, wget compares that
value with the buffer size and refuses the download whenever the
buffer is smaller than 4 GiB, before any data arrives.

Skip the check when the length is unknown, as the legacy wget does.
store_block() still stops a download that outgrows the buffer.

Fixes: 1327c2a8d651 ("net/lwip: wget: integrate struct wget_info into wget code")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 net/lwip/wget.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 96ee600c5e1..615ea035a28 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -6,6 +6,7 @@
 #include <display_options.h>
 #include <efi_loader.h>
 #include <env.h>
+#include <limits.h>
 #include <linux/kconfig.h>
 #include <lwip/apps/http_client.h>
 #include "lwip/altcp_tls.h"
@@ -285,7 +286,9 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 
 	wget_lwip_fill_info(hdr, hdr_len, content_len);
 
-	if (wget_info->check_buffer_size && (ulong)content_len > wget_info->buffer_size)
+	/* lwIP passes U32_MAX when the reply has no usable Content-Length */
+	if (wget_info->check_buffer_size && content_len != U32_MAX &&
+	    (ulong)content_len > wget_info->buffer_size)
 		return ERR_BUF;
 
 	ctx->content_len = content_len;

-- 
2.43.0


