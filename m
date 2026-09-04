Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A903C79F85
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BAA440B82;
	Fri,  4 Sep 2026 19:31:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYHnzJDnj5R9; Fri,  4 Sep 2026 19:31:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C0F0940BE6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788550284;
	b=DhY6gQU9c8B/6n1syTd0n2qk7071R3g/QjXzH5gRpcx6BF8zkHrCpmyOCP1ppKcYQ5sC
	 8pUxnv2M1MYrH4NxXSZvmEjtaUsswnzgy86MqE/oD2FGwgpZDhvs9P+DPqQNdyhM/Tzcm
	 6YCKXt8ntM+gYyPzd0bgmDspCtux4gEUuvczXMxrDFH5jZr3+TkrHOR5pFrCeOJ0JJdLl
	 LQrO+guzW1TCN/oqMnpjWSq2xOYi5DHFALPa+umpJWePn0v65ONMUkbIFnDr1W3Pywg9c
	 2rf5Lgi7kupSSgCVBi+SUDOUjP7nK5UFF0giub5fjcACHmPVqrvNF98Sio1CVuopoRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788550284;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NgAYkIVz3qqE8Evm69pEQadiQpGzFTgARH7DryhLzks=;
	b=DUMivCM+EeC0JmOJvNXa4LjsdSy+eOP7m4X9kEVrA3CDTOOW/cjHdeGjUfix1VECOhAW
	 2pM26kFECKGE3qdbNNwMv7yKUS8JG3Xlfnl/uIxIbaY+4RNe5gZpzMvcha/0PAeIqm/gj
	 cK2GEwYHCZ7MJ9rf2MCt9QJFupLbSza96/bksxtPiSe3wSaAFf2H4BBI1J+7uaP+X4Rpj
	 +E3DY+vTth4QE6Ec2OwGWKM5Tw31q9Mpaz3lprpCBd3ta4ebY51GEBFIT3ZGjJzvDFnyH
	 BszQkZtH47HZDQkUIQyNY9Yqb01ffD3cQXTzPOGZzuKLED72V8dzw0bNZZDYp1Eo3Dw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788550284;
	bh=NgAYkIVz3qqE8Evm69pEQadiQpGzFTgARH7DryhLzks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wClWpBuK8DbnmpQhlJSV4PhnelpfVrcc1BXj7B6zazib5BlFA6KNDoOZL0S1TBMQq
	 ttOQi0yulhcnE6cPuyITtnFiy4MRWfg4p2EKzhX5Dg59oNeZmIT7sCBM3xhCF06wKP
	 l6DwNfsdrHEHIMXhCP9cwy6S9w10oZrt4R8tcV1EuSGrez2IrU2C7i2g1NC+dcmqbI
	 aisOqAuRWAdfstZQIXapseVyOtNGNDLco0oV4Ts4hdRKp86EnX3mCjQYLk7w80TwOF
	 4cKsSUXfpfXKXXWwykmBLD6cHgYr9waYl9eS0UhErAcWfxClWXwEW8goSpas/37TCM
	 7rzGphE3LZRjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0F0940BE6;
	Fri,  4 Sep 2026 19:31:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74F1429B
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5697E60B86
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0sxQiU4KUP9m for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 19:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 09CD16060C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788550273;
 b=bEw1URBCT9YFk2bECJC3Q2t4r1NLBSAJ9ghJ4zOZnTK47K4WtOm8b7SXCzOdnc58Plwp
 kDcfbDeslvd9kqvQ+xF/0cRpTwKp+yJtcK/iC9CfSo5WG6KB3FAM3+J0x30BbhzojzIsz
 xywOBw6XKjGbXgzI4hbWJ60JsvqCbkSLw5dZ95w2Lwwer5L2TrAXFeFVbzxQju3qJizjf
 MCpyBT4d8FOM3zpICXr3ShSGtxWWNrvQoOCEKQ9msxPn2Z8QdbaEoogaWpMg6eVAPtyIU
 3PUHIfHzucm7mugfYREJLmQXUbHrKrl1EYqk2YsAKGpQ3O0JkPVW8ibuNKxS2mDx7Tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788550273;
 h=Received-SPF:Received:Received:DKIM-Signature:DKIM-Signature:
 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=NgAYkIVz3qqE8Evm69pEQadiQpGzFTgARH7DryhLzks=;
 b=kVjgIoPAci5ox0iG/gzfmBWYF8+TqEDfpUlAALBe4x27ufVGgnEHodEyrktaOPuBjUi+
 F91Yj8bdd8dGt+6r7hK1rePrXVystUhm+ioPN9oFIBzkC90ZmnwxCAIf81BnF0LkyXPzj
 y/5BIsUZc6yr8rFbkTubB5ATsIlzKQrOyFyo1usAZebcijx61lp41hCpZ9DEwFxUozT2+
 cUEh76jgXSp/Rx1S00GULEgUeC4jEOCif9rcUBy1dd1gEt2ycZpwjM161pKZAXp6DHyf3
 KDmte+TWmNVvCwouv9Kkgrk9CAhsvOp5yffbs6r3k6jSyrDat+3ENTwqAlpZEYPPPUQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=jannau.net; 
 dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256
 header.s=fm2 header.b=CPBf9+GE; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b="i1E1/XLk"; 
 arc=none smtp.remote-ip=202.12.124.148
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.148;
 helo=fout-b5-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm2 header.b=CPBf9+GE; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=i1E1/XLk
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09CD16060C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:12 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id B98851D000C6;
 Fri,  4 Sep 2026 15:23:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 15:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1788549787;
 x=1788636187; bh=NgAYkIVz3qqE8Evm69pEQadiQpGzFTgARH7DryhLzks=; b=
 CPBf9+GE1b79vDZ8fdGbDraxE/4s7lqTd10XiaL6lUavt4hPxmuDefWZK8y4APvz
 2Fm4h+Lj/NQTxF3LK03GLSdzS3z4FZARnlh0USu4ZD/dKiWcTWp9N8zW9sWSoOHz
 xwSfL0my7OoYjxssEsdciKpI73hYrtS1HTT8L8JvAu1Ma3jVdFmSs/PFOqFaXw8n
 H5nPA2TbrS6AlL+hXbAsrpdaVThHkGT06U5XlO+8250PFqGw1VCeCrflCm3KXcAS
 e8RZpTy9cVrTERYhKSdr4kaB7Tpn+G291bMxmqpn7vQQ20w9qEmtOY8tGx9JeMCs
 e8fJ7S4GEkww/bwx84lSGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788549787; x=
 1788636187; bh=NgAYkIVz3qqE8Evm69pEQadiQpGzFTgARH7DryhLzks=; b=i
 1E1/XLkCsRS+pP4Qvbx9UhGolC9SoQBN1uODBYU+TsLRq7611zXJsWbTwNIiYh1j
 RTzBLkuefzs3WMcRfTni6RK/GSNMQ6dFXUJOi/wP3oCUmVN7lp5x8VgNm9XUUFb9
 jSh1bcj/Gq5KBnZ2k6HSyo46RpT1xD8cm5OWKOjX2AV72yNfvA2Ld8ZsGzqfbSvm
 9rQ/kSVuxvKRFlDYiP0GunPeXwIjjgZx4oaM9AH86R/Thqhw1pPe8tLgbo/cF828
 s0XdP1qOJDuCp2pYSMsD01hQrMJCvwfQYMLvvAb7LQLj9mrRc0ypEHBvWw6u+ZNz
 BjDy325hQRsrL/kqKApJw==
X-ME-Sender: <xms:mxqbagUq5nqRe6y5LXF3Ni3RrLJw68RUlQsXq3JxjJcAiGqiQp0Z3g>
 <xme:mxqbapgX6T36YreLXaWsx9jo0SuTrE1AGtENaBnm7NzZH8nggj5p4FvvH435Fsl4Y
 oYwzAnj0TR2UeGf3i0Pn-Y_4FpjCkB0aNf_8CDIAuVF7OUUe8wMQFpH>
X-ME-Received: <xmr:mxqbaorLEdmPgHaYZiwFrcyBPpdpAEp2ad8p05K8pZgXOF4tFCi_O_I4FOuSZHjAn6bELWZIxm9b-u8gQEMM11equPKV2UbP8LQEYg>
X-ME-Proxy-Cause: dmFkZTGE5u1UdZxmTiONsLlgAgk1Upsu+uCvGB/VsgdfAX2dMLyJQAWoEyM7Hh0aP5oFp0
 +loYn89F63ra14QUB1ZnCrimTyLeACWE6DTONQA+wsQVbcFnaXDT2wnltHUtR3uvu0GYXi
 YJl9eAqqa/NMqYlqY/YUfeocpekeqyKkWcM2a7K+bYiJATu3nX8Sa1ZwiJwlKu8PuPzAN9
 HjKhSslaBogp3SYq0AZIoRYXLxl3vPW+rxRxTfSwWKWn6HyLfiOSdCO3VKcRZm2xLZNCwb
 A2N4vuLhQcULsgb+gjoqon+76I9WP6rBq2gDKnQ1OhNWQOrMofW/0K+BXJ+VJnn8JaJmcm
 S4DC3oQT3IFnCjLgNarx2AICjuU5dfeAZnGRf9QsYVOjsqXI/qIUhGdAAvjnq7zKLGHstg
 af3ZxhuzeSqxCBWhKI6Xfw+VLBJWEMh8Vdc/54Sd3UD0sKh/8nheP/TyzBavMtSOfY4MBo
 gRX2MdvL1+zIDE7tJ+c4NzzoKZ0dfZwxayrCDJU1VUiB92GXBcg2ofadUYkCirBL+mQQPB
 dN6/k/fIRGGnOd2BU6WUi7R7vXa4Diqw7esKM3r8zcDnJ8gP9Lx88iJFP5DO2DozaohBYy
 3OLLaDjKvSCzAGVHfC3bspe5fEGSb6UdhVB8xnmCayn5A/Y45pkqgRZeJiAQ
X-ME-Proxy: <xmx:mxqbavFbS8rwk1SMKRprHkgQQp50_DYDDI4zKxKpDJyAxxB3uCjsvw>
 <xmx:mxqbat6n41-MLepmoe33YUwnkO_7btdGQnpfJnV0umDAKenJeoZ4ZQ>
 <xmx:mxqbanfUMxlALehd8kwYeYTI6iXz_W4MHUwAOMWOLq8sahOc9kJ_6A>
 <xmx:mxqbao6ZTs80AWmnbOGeqf07-RWkJAoQWHWouPmpFz9vYY5OjS3wXw>
 <xmx:mxqbahuGaUWEgj2hDJCKJ7Zhr2UjNsSYT5fp90zMKXhnAdFePM8jI9Rk>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 15:23:07 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 04 Sep 2026 21:22:42 +0200
Subject: [PATCH 4/4] nvme: apple: Drop the PRP null check chicken bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-apple-nvme-fwabi-v1-4-f7ede661c469@jannau.net>
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
In-Reply-To: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>, 
 Sven Peter <sven@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=BDEA6GudxwgaelSOCprdOjpqHWFJeXmM352vY61q+c8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzZUr1pCi3zVFbcz/XIKDjPO/tNzozu+7+Ltgqfl4rsv
 Ce5cV1dRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIkkMDMy3Pu2+faM6fe9WXPL
 eRdNOuK24F3bd9HAmUdcPC7WXlxspsbIcDHuu2NK9NzezC1yIu8ab19ac+fzlLqYW+tc153+cSr
 iETsA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Now that we program the DMA direction correctly the NULL check that used
to make commands fail passes. Another side effect of this bit was that
non-align buffers on the admin queue were silently allowed and that's
been fixed now as well and we this don't need this chicken bit anymore.
More importantly, starting with the firmware installed with macOS 15,
which is required for M4 but can also be installed on the previous SoCs,
the controller no longer exposes this control register and any access
SErrors instead. Just drop the write entirely.

Based on Linux kernel commit 8ce883fd068b ("nvme-apple: Drop the PRP
null check chicken bit").

Link: https://lore.kernel.org/asahi/20260806-b4-nvme-fwabi-v1-6-bde19ce8db04@kernel.org/
Fixes: 50333c94f2de ("nvme: apple: Add driver for Apple NVMe storage controller")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/nvme/nvme_apple.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
index 54821f80c81..948a56e518b 100644
--- a/drivers/nvme/nvme_apple.c
+++ b/drivers/nvme/nvme_apple.c
@@ -26,8 +26,6 @@
 #define ANS_BOOT_STATUS		0x01300
 #define  ANS_BOOT_STATUS_OK	0xde71ce55
 #define ANS_MODESEL		0x01304
-#define ANS_UNKNOWN_CTRL	0x24008
-#define  ANS_PRP_NULL_CHECK	(1 << 11)
 #define ANS_LINEAR_SQ_CTRL	0x24908
 #define  ANS_LINEAR_SQ_CTRL_EN	(1 << 0)
 #define ANS_ASQ_DB		0x2490c
@@ -257,9 +255,6 @@ static int apple_nvme_probe(struct udevice *dev)
 	writel(((ANS_MAX_QUEUE_DEPTH << 16) | ANS_MAX_QUEUE_DEPTH),
 	       priv->base + ANS_MAX_PEND_CMDS_CTRL);
 
-	writel(readl(priv->base + ANS_UNKNOWN_CTRL) & ~ANS_PRP_NULL_CHECK,
-	       priv->base + ANS_UNKNOWN_CTRL);
-
 	strcpy(priv->ndev.vendor, "Apple");
 
 	writel((ANS_NVMMU_TCB_SIZE / ANS_NVMMU_TCB_PITCH) - 1,

-- 
2.55.0

