Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBC606A339
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=maeVWGxK;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+TUyTbI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40277409D8;
	Thu, 26 Nov 2026 13:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kTyYqYAxA1Pb; Thu, 26 Nov 2026 13:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 69CA3409EC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700014;
	b=YSGe0zWY9Otp8rFHk2lS8b/WLfe755PZscCVUYuUMYECaHIf/63N2BpY57UWgHY8CZTy
	 y51v46lRqmEBovGwsXgd+KvhbN1VUNWbO6NoIrGbulvTzOocGKw3rRxqp575hVLcqNJHC
	 6s/GnBsA6DsqWg/3UrGNvMJR7DuIva0IMmEZEVJ73juDBIoNciWiJrwpjKPV2dgOla77z
	 A1c6fQsDPGWhdtnZsoispf3qYX1ZxYhTd1pTTX5Cni2xoOhZnD2X109GGjNJltWRr22vg
	 wen0csWqGc7Hz6WlOYua9VmCbDN8bL4OgK9oJMOM/1V/pwzzu7n/58KbnZoURelN1/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gf2/hgzw6JzBIa+rPm6XxBUrDIqJzLwhWZE1VzvJFI4=;
	b=WmJP0aKoCnmU3VIhoyHIdbxLOTqaUYZhYDKEt0vlK+012FWWZmYFyB4WRMfBzD0wRJ7p
	 WiR+39Cm+V6MidxWkHJq0uDGboR1m+7nHhuyUhTpfo7OY5TVWUtQx39AEZd2ZybrAt5lK
	 sZK6eZd6Q0NmITxsB0yr9hk2MmfLiCQAqkLlzfxcoMq8t55WKAZV08wvq/LCehUyQ5oSz
	 cuIkMqF6bjIM6VRKd+T3wSks0eQItUYorur/05c2224ZesDPtCjCCWD+xxRVSNfjrWxDs
	 Ty7WeQehxgArQQfVfZj3IuP3f6BjDOV0iWIyqyKG21Si6GtpevITrJN77nmV3XPhPrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700014;
	bh=gf2/hgzw6JzBIa+rPm6XxBUrDIqJzLwhWZE1VzvJFI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=maeVWGxKS8jKhAcmpM/wbuk+TT/1EyE3FbiOR0yPny1Pi37W8e7GpqhChXdOF/2WZ
	 cnGUP874aWUvEHuc355+UPfP43kzZ1dC4pLLOCUFyFaRCAwMk1AAvZ53F5iN3IgqnU
	 JcXh9/bK3ZoXQHLRMI1oInSSH8qSR/V/fKvrijjyD+wntKEbZn5L/FVvhBxtnC4reL
	 SjyTqRhCbQ2cWRqDYLxq8QhAyNwPyIV0gQigG7dtuwxrRkMlaTXTrDiVqzoOgTWfwt
	 7X592zUnBunN4xagO7fS9yv8nfJ4ZQJsgz6kZl9e6OJJ2D/bZXthlf/wwlT514E0wS
	 10f6Lx1pVqWXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69CA3409EC;
	Thu, 26 Nov 2026 13:33:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E7FD32D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 807BD40492
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RyZs5z9TjuPD for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C0E3840490
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=p+TUyTbI
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C0E3840490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:24 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-862b3938d98so3298692a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676003; x=1796280803;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gf2/hgzw6JzBIa+rPm6XxBUrDIqJzLwhWZE1VzvJFI4=;
 b=p+TUyTbIIchooQ+EG6afkq0V2xNgJ3Ku5skR7BnCrxoKJIDzEUaYBkQptvbW2RUfgl
 Al76d0UDw4UqsbaXFviwenGtYzYeK4dL7Yi+9JL3ejvjasQAXwfJ8zr39MlR+t4ULk61
 FaAcHMQb0N41uqESihzO62XrvbTZCjQS3cbjU7xU5d7ZPt5uDvd42RYbxmDlhaqjAt56
 7ILi4XnrKBzZz65bD/rvfLSNAFQ2SXxQrUVV5XcPzmYW9+RN6zVvei5i9VP9SitU/H2J
 /V9+DEhTahUDhPhbRWQ3ZtbaWETkRIgiQZshNJLJkVt3LamAJrA3W1v6dYtZsG7eDcvk
 1TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676003; x=1796280803;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gf2/hgzw6JzBIa+rPm6XxBUrDIqJzLwhWZE1VzvJFI4=;
 b=KDh+iP/E9BjTGbtgNRfLgvKVfGl3GbPWY2aBit5n2a9dw47w/3/Jc9VxgQxcYG5Uv5
 3GhpIhj26vhBAmGGlL9iMvy1A9S/XWNrELFJROnOIKw+678wJLYraV7k1akfnuL1Py+g
 9Zihf035hp0NaVuNOhBEVjlk3iWaWCry3NcUeZFBQKOEdj4Fqh2t+lr06L4MfpyYUBUV
 5RIMzMVuktSzqgzN6qQLNkvSotvyMwHCLfQ9x3xaXGNrrAc+HObjgw8vYfDxNw55iGiB
 ZIusICln5gllLJnyfQ9Apvp6RAmczX/emLJji8OGzyqQrxbBHWFJ5FygLEe7+68wiQPs
 XHjA==
X-Gm-Message-State: APuU4Z/NMEf4D8M8yawSXiR20FIJmKpnsg7+121+mCuWOV4B1xG1dwoT
 gC9CUYkye0Fq3prlPoyVNlNSX3+wolCOFqp+7SgRrhX7G/Bvur882A3X
X-Gm-Gg: AZFdTZeaAek6d94KFlkqSPc6BQ6u4FiRnLTcWHmDewkiI7RPn0N+t8dDKLEEQlTmm5K
 TcIIwCzQDEzng+ifUwCParsBmIaGH6JLcwvpXtDUFfUO3W+wS6wB+LgxiWWKJBlBom/0eIC3tZo
 L1VsL4PO8FbexLJHLGbOK1/KNIyQd5rLGJmLZmSM6MBeip4B0HeBlez5A7GdCSIYiiUX+Pa1Egl
 JbxgHlJShnDkdZY2cw1jGu/Z2WHkmpeavH7jV/AdGwjFeV/71dmKu8OGvlysTvEVm5SlWhKlSD2
 6oLzoqq6sZUvM9EzBHIyZ1g138YvzNAXKNuCZt4TBNx47b/g40PSm6IcDVv4BNA5JVc1NxEpvn0
 l9LeeUe1Rq2ZpluPW25JQK76nCuD0naa6uQKe8K7nP/AGMC4bjV1ceG+6H+ttnCckdkZ0SQaRDO
 pW/l4Vqz6Xmwbe1etsuQNFdMEtPNR7/1yNYSHUHVqEjya7579E3SJ+c9HbBbK2iKNNcpLgHtFKk
 t409L8+kkpWXelC4RT7fv0m7n34XkaVvez+kKhD0YPrvRLb1kHq5MuvlsYxMVDtkslQr+ufcaL0
 t7QNriZguSeyYeCuR2erhN6Mez/q+VL25N2h6wDZ4+ScCmilB7qPNccy060P4FLP9jeVcapw0KN
 vkHQ/SSiUof+y2JNuIWV8WC3c9M7u8LEw0d9xLIjRb7vmDuS5TvrL8VNvj3JSqSwTelMuYXaIci
 2yF//ucBaOQWAyAhqX9j3X3zCdtPRGbdT3Y1FhsWdQLC8VTnMwEN8=
X-Received: by 2002:a05:6830:82f5:b0:862:9deb:85c1 with SMTP id
 46e09a7af769-863157866c6mr25271137a34.14.1795676003446; 
 Wed, 25 Nov 2026 22:53:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:22 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:52:57 -0700
Subject: [PATCH 08/19] net: lwip: bind NFS requests to a reserved UDP port
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-8-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux NFS exports normally reject AUTH_SYS requests from unprivileged
source ports. The lwIP client copies a port number initialized only by
the legacy stack, leaving lwIP to choose an ephemeral port on first use.

Bind a free reserved port before sending the first RPC and have the
sandbox server enforce the same restriction.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/nfs.c      | 17 +++++++++++++++--
 test/dm/lwip_ipv6.c |  3 +++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index a389aa6412f..6b00c6ab3fd 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -75,11 +75,24 @@ exitfree:
 
 static int nfs_udp_init(struct nfs_ctx *ctx)
 {
-	ctx->pcb = udp_new_ip_type(IP_GET_TYPE(&ctx->nfs_server));
+	u8 type = IP_GET_TYPE(&ctx->nfs_server);
+	err_t err;
+
+	ctx->pcb = udp_new_ip_type(type);
 	if (!ctx->pcb)
 		return -ENOMEM;
 
-	ctx->pcb->local_port = nfs_our_port;
+	/* NFS servers normally require AUTH_SYS requests from a reserved port. */
+	for (int port = 1023; port >= 512; port--) {
+		err = udp_bind(ctx->pcb, IP46_ADDR_ANY(type), port);
+		if (err != ERR_USE)
+			break;
+	}
+	if (err) {
+		udp_remove(ctx->pcb);
+		ctx->pcb = NULL;
+		return -EADDRINUSE;
+	}
 	udp_recv(ctx->pcb, nfs_recv, ctx);
 
 	return 0;
diff --git a/test/dm/lwip_ipv6.c b/test/dm/lwip_ipv6.c
index bd68ac0e356..193f4ee0b5d 100644
--- a/test/dm/lwip_ipv6.c
+++ b/test/dm/lwip_ipv6.c
@@ -661,6 +661,9 @@ static int ip6_test_rpc_reply(struct udevice *dev, struct ip6_hdr *ip)
 	const char *uaddr;
 	int ret;
 
+	/* A normal NFS export requires a reserved client port. */
+	if (ntohs(udp->src) >= 1024)
+		return -EACCES;
 	memcpy(reply, query, 4);
 	reply[1] = htonl(1);
 	switch (++test->rpc_requests) {

-- 
2.53.0

