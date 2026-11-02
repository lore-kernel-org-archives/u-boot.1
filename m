Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EE606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KM0L2ysZ;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=TsSp4aUd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1FE2605ED;
	Mon,  2 Nov 2026 19:52:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fQ189eU9TwT; Mon,  2 Nov 2026 19:52:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DAE3605FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793649137;
	b=UqEVX9H5cIS+L1D4m5GEMlG1OauZRBNcy0lNWZzRJHGso8T8YRW6it9zf9XJN+N3nAIc
	 TSYYSylUSw3cEXUy7lXyvR+f44WC6FfoiQ600eYkAlkl19YosmeJoQhOxjdqbIbxR/Tip
	 N1gAbxkWD0OxzvVFcdBWOTpXcw5MRMJ5M7sbgH4BVPSzfhTDZzfUUJ7U9e4U4ZijrRO0T
	 pl69lxeLIQNnxfKMs1LWV9jt1GMHg6SMd2MEgM1qixDezfSNVJR9b1fEslayZVRhyJEBX
	 Tyy5RqpDJoUVyun1zMZknqJ3F1Z5GYZ8GxYV5YLmVN320d4UGqem2oKujZs7YeoZing==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793649137;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6GFVfNly+WueVL9BUJoXIhsy73rNDYy6Wc/LqNB2o+o=;
	b=WENHTbjATWm0wxVhw7WJip6R94KH1goH/QfS/ZmAwnSRZR31bijl9uShNZWiKgeD+Gip
	 aa/yBddS0g4hEbuvVdBskbwqyK07n1Fc0XlsJWOjyiJ6xhuf68EzGW7FU7TZDu+BNJj0h
	 e1xES4900V3VwJu6S5Dt48W9ggyRegD8y7VmQrus3XxB1r3FIpLaS5+J8CRfoZYcsdEgZ
	 NB8hQwh9+7qLucRkT8Y1B8tlbLhFHLhmVjG7oYnxDEDBFCgYCj/Zw/MSrMp40iOESyDEt
	 2i783EDUkopnr8ukOWqeuZTm7Vq1DSU0FbxE/gcvZXl4ao+XdPxc/rS2ikVUAmINg+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=TsSp4aUd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793649137;
	bh=6GFVfNly+WueVL9BUJoXIhsy73rNDYy6Wc/LqNB2o+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KM0L2ysZ7CK9iIK1+dfDcmjyonvLa1X7NWoq1+EZ9s256kZqbd0UQl2xuZDxa8N+z
	 VgoW0QYLCPuBIqMHDiwmrH3/Gtvn09TGos6/ueS4ACaZL1/8hN80SzNoPLi5IHAkRF
	 IaK2KX2l7iYhao9yzCBQIMY2ET0bZKueuComiWZCxp+MT0QBwBMj1Ga/+Dy1aEGKj0
	 hgay5OwA9kSIY/sjTe30L87vwcAw1efxII7UYZX3wSdns76yOcpMelFh94uFD3Dlaw
	 5craswG/crzFeq0IiC1Xk/rLi/NDguWO4UsZrfDy4XaCUNpLeI6PD9Pu13tAGabRMX
	 D1mtGcBs6B9jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DAE3605FF;
	Mon,  2 Nov 2026 19:52:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F98B235
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 410DC605ED
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aa1DsZws_Wfj for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 19:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66B86605FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793649134;
 b=rNAtZHye+o5yH93FL3umzlm+VOSKNco4bZHj4NPQQlsd6orcCkiu/Bh/V+jilKzRJGAB
 c8T08QGNlvmhyc9f6e9pDxw0YHSzW5WVUkfg/XWd9NCbX4eqA8vbb/1RhEIWppqAX5o3J
 pDxqowEw+PqP8/IaAps7fn/ykdiMZ6P6ErVtikRFVM2caXPkl1yZNWYpk6Z+oQG6QdVxC
 RcMwIrp1v1m2osPjTo9uaOFTIXwStQmTMwn9ZFYPJF9aAgHkAc8uswC9fFU3U4/HsYWFJ
 qAw/lSa69P1uRVcMjINkLhhL9LVSFXijjaIBsVqgOUAzPHe+PFAyc1/jyZHx6pVAR9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793649134;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=6GFVfNly+WueVL9BUJoXIhsy73rNDYy6Wc/LqNB2o+o=;
 b=klrkmS4bYAeiAbdmQ+jinfWKfW7y8NlDsO6L9CCoC8GI/Zod0NPWixIF4U49vt4CMI+A
 jpwmm14IwkniVF7fAY0kv0ORq/6zv/j7I0ePdWOrZZzcJMkl6n9twPoyun1MscbenZDTn
 O0LFBYm+sJmaMYuS5+ug0lXp0TGyyUlPx586edbgYVkVHAIjtPOi7bHOEKq4GrZ3XdVcz
 CoVqYfUXzZfMbDlv8jUDnu+ixJZ88UxgSGE6u2RDeFel7qn3tVkTqIWiJBCHPmsVtyT59
 nz2ZOKAK7HrRJkUkckDqAkQXAnLw8ZkMM6Rhx2z/uc2peUceMA/z10bjLg0eIYqhPQw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=TsSp4aUd; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=TsSp4aUd
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66B86605FF
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793649098;
 bh=6GFVfNly+WueVL9BUJoXIhsy73rNDYy6Wc/LqNB2o+o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TsSp4aUdcJ1NhaJ0/cOLbUkiE0N96DV4OoNKXFjGEfmMApFJqYOITq5/kUf1AiaaR
 ufT+TvEw9MqdiJcDHcfovaX6kJWQO51O/H1mHX5WmV37a88PGT9mS6kM7/fP9SZvOq
 036LhiPQR1rB7o3WYu3nUCwzYrTXEkSVsGHtOiBFEEHteyBQFyGMEQos1lt3Pn7JtA
 Y7/qzZaylA+DwUC2W8U7fTetjPvW7Dox3NGZNUueD7ceuJ98DQkUQdJXdKHCBXsoCO
 jspHkU8k1XrfXPuC8LK7Mc5bXc5voW9aBa/OYPibGvDKUpm23uPsiBgU0m+vI0qzK5
 dgDR504y++tjA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 03578B220EEA;
 Mon,  2 Nov 2026 20:51:36 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: [PATCH v2 1/3] riscv: dts: spacemit: k3: override reserved status of
 mimsic and maplic
Date: Mon,  2 Nov 2026 11:50:40 -0800
Message-ID: <20261102195101.103363-2-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102195101.103363-1-e@freeshell.de>
References: <20261102195101.103363-1-e@freeshell.de>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

S-Mode Linux boot stalls when probing peripherals unless M-Mode OpenSBI
has the enabled mimsic and maplic nodes. Override these nodes so Linux
can boot.

Reported-by: Yixun Lan <dlan@kernel.org>
Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/spacemit-k3-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
index 352e85e7de87..278b36acc79f 100644
--- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
+++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
@@ -3,4 +3,8 @@
  * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
  */
 
+/* Override reserved status of mimsic and maplic for OpenSBI */
+&mimsic { status = "okay"; };
+&maplic { status = "okay"; };
+
 #include "spacemit-k3-binman.dtsi"
-- 
2.53.0

