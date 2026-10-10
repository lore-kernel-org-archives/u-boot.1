Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B1ECA9EBE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 12:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 881CC60672;
	Sat, 10 Oct 2026 12:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4AFrkKK4Ljz; Sat, 10 Oct 2026 12:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D46260663
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791634877;
	b=oWrbD9EOr+EYLlvxCtp1EfvQ+2AM7vggCELBgQEcpT6mDyeh+OMW9WLppbKBNiztSbBu
	 VmFNXbjoAf3wucVQkmWTTnRF3yWrSx0OcirHwY1it/iAu/85V+KKtOWIMY+YPrr70Wx6O
	 9B7MYNkB87z7sFFu/BfJYA5Hs3llSlcpYILVmA58Gfo+VXHHTYQdGVW+pUAvOiWzNzoWo
	 H0pYrj1DQwF1TqMBpdkfsnM3UHhvy3cmovbPUCJDous0B+UFkij9gRRWiPrze1xHRmIcp
	 RtdGX+EAGiyh0oJ1emmocJrKYCB2sl5z1hrHva4Y2Ba1h5ehzN9+/tRafSYBP52kltA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791634877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:X-DKIM2-Info:DKIM2-Signature:
	 X-DKIM2-Info:Message-Instance:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pH2ZSSrEkbK8zvPbZi3q/ueD1GzZZWWoJ2/oevJmUr8=;
	b=OHugXwp83wIUudO1eIx3UCWHbDCGBcosgza8MfLQa2J5wK91bhVWm7wAIyZXwR57rxpW
	 7z6K9ncLvFX3frTi2YHDsTACbf63QmzOw6nsYSgijNVWA4c7EJnZNaD33CZAfnAWIDIAx
	 Ow+y7Pvo7HmAWsnWr2miIP30TfO7EcU2PrSXI83vw7XV62Y7o9jlXPfu3nMO8r/KokeTB
	 F/cT/zGp+ElYSyAWaGgLIEKZ4IT1QUnrIuV1LiYKAoyD+wHwzGu4yEfq1VV1idLYym8nw
	 IdvTLHe90QOMK0Z8ym251Q/wrqXENhAjvL3Ymzmq9qoUuDmQTikrEyVMJnOix6zMj0g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm3 header.b=Tr8UcHOW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="Sms/TZRN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791634877;
	bh=pH2ZSSrEkbK8zvPbZi3q/ueD1GzZZWWoJ2/oevJmUr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gyMma5FS+sn5SJAPGCyPIwnrftnwqr34zJphmhIytqn8eGy6GDDUhon0GSMzqNhdl
	 ddAyeZ9lUG91OafG79T2AQpkj8aXKrtFN1jhu3tFumvU6PpKCBOMw/jacFUJIwhi9f
	 IVJVtSw6MufJZIj8dHiJ9NQ4hLgLJ4yYaKRg9z0jEe2qFngQTOtezx6EnN+eHZTREH
	 HGpGqMBo6Spj2D2RqmAIl69cxgZx5QtM/F8YuWWBk4XvNlr0lF/pDKM3TxEnAsbL2/
	 R6zTNdXTZ4QEkqGYnW4p8TUH/1ccsfyDhkmKYb0MJS16PeCfkwv0rma+XRkDpkSJJN
	 QTghc/PwnNE6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D46260663;
	Sat, 10 Oct 2026 12:21:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0F6D1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A21CD60601
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EZDVvhZHIj_I for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 12:21:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D9B260629
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791634875;
 b=c+IGb5mVGubwzqqIivOqgGlMCLYAaverDN4q8QwY6VuLg+BvCjS16A4ABalbqGwRNiaj
 23e5dc4gq2yz0j9JkHZMLOqoi7WyVz/TM1ouO1m9pGOEXPDYWhMhpes0EnrGX/SzGQ73s
 J00quIFwKi9OuGGtDtN/uP7MZChIxodNmGx8XOzqeBqHt6voI4Kgx11U/8zE9wQ8c86UE
 CJtg5sj9DdHj98X1EP37OrxyqvCgZBxR5EZ8ftqCvJljfKuka8FfxAGoemM/MCiZhjCzW
 1vx6ZRrS+xHbt30tU7EYySqV3KJzT58kcnMlpKy/9t+KHojHoLk1FTW9dMuT2cxu5xQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791634875;
 h=Received-SPF:Received:Received:DKIM-Signature:DKIM-Signature:
 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=pH2ZSSrEkbK8zvPbZi3q/ueD1GzZZWWoJ2/oevJmUr8=;
 b=JBTacArx6S8g2sUWW1MUO4bGvT4wyMHngDCwfjs5NpkmcWepLvqcnHTeq43YCdAQjmV6
 Q1HKs8FINRLeXxItC4PTnl4sIotmgWa0S/hxZDQYT2s30Pgg834Twfp1Bpt8Cb5j3us64
 N2C5ct0OmUJ87dHAwsPVQU7mlhLsmHVCwxJgmbA3zxLENsnfYYrK7o0cP6jQElFLv/foC
 wUHfIVEUx8iLvAXo6/M7HGdMWTQDDUND8onsTQUX8k4FUcrTCf922eQ1UI/+nCgDD4ze2
 w75gG7uHei7XTvDicq2OcIJg+COLGapL5ASTan04TPkcIU7c2eBlyqyOq9/BLEPYhTA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=jannau.net;
 dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256
 header.s=fm3 header.b=Tr8UcHOW; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b="Sms/TZRN"; 
 arc=none smtp.remote-ip=202.12.124.148
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.148;
 helo=fout-b5-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm3 header.b=Tr8UcHOW; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=Sms/TZRN
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D9B260629
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:14 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id E20F71D000F1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:14:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Sat, 10 Oct 2026 08:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1791634455;
 x=1791720855; bh=pH2ZSSrEkbK8zvPbZi3q/ueD1GzZZWWoJ2/oevJmUr8=; b=
 Tr8UcHOWh0so5TB+BrZf4TtL+WM25bmf5UxUy43uuFQLPJjRzuYJsci/NCiEwLdO
 EMb54XHylGq1qIZ88h6YodM6cdPzdTahQ9b6AljxN6+ie63AQ49HmBuOPVoBOBNm
 //z3tvcF/qF+8vDkyh/7CUfAHfb3wl9LxD1HCqxG9UoqU4pob6fXAGM7YlDuyaRn
 jaCXIESfOQHYNoHIW5SZtDwhKwqSO6QOtMP0vMz+HmK03qaS4cbHS4KIW17j0D0R
 /cRiZAYaf+/US4wCMJO7KPryKmm/08V21uQ2H/HWDnUPxsuc9Pg6sdt5gqKCF6AR
 CtJyxRz6JNXWDtNINH+U4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791634455; x=
 1791720855; bh=pH2ZSSrEkbK8zvPbZi3q/ueD1GzZZWWoJ2/oevJmUr8=; b=S
 ms/TZRN6sx8T6O8PRCZZyYLII6BVgzH/PCPRShpjqlhhvmGtEULV8rULjvA7Np4r
 Od6fvjKthbY6ueFMXU+Vr8iCgrE+mY6S1iEgD4dZRrLd0HWBJtxE3BXiSuwK9arN
 KM4RUZuo5OviT8/YuXr5bT6LaDcLRYsqQL2u/kMsm7/XUJLI2GlnvXFZYrZYL3xm
 ltuvw/KUhGlIuPTyqfL6aL24ec177qXVaW+ei3IbbgEoPC2YSKeG09ZYHrwBoe3G
 bmBGqPgHlCG72C9wt8+0nAA0MxFgEcBntGBTm2i1Howq6Zw0A7dC5bEg/0iNmuEg
 OHeAYXuPIp0v9r8mjILZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791634455; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+;
 s=fm3:rsa-sha256:HHWQD2TTKbVWNVjy0kJ15kd+Z3jqHqX1GR7dnLOVY0+SI18
 En3gZvl/c4V7g+bdmgiIQIBvuK9+bwUxz1M1cqaMJnqw5kGrMFKGEuLHnaTEA3H/
 5aLhwpLwH9kROifZRaUmOAbmeW5tnyf+gxLLKdvYXbE1Da2M3BiXj4kCg9wjbboh
 UNy8nzuC/8V9pvfHcNkwka1DxzkcKfEhkFrGdiIjvTzADiB3hpGNVifKuItRzo9k
 eLuPt2N64vZvkB6bv51/186FOKWnFQblFSa4UlClRG0jpyfAg0Wpj6CqViGxNfXi
 xBS/mxBkhAicZ1JQOo4bAQVoV1SCJjr3eESrPYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:Ch+0ZGnLGNjuSLMEbnyZbEFC/apbCN9ElNqhpie1PfE=:UMoiybBG3EjMyc1B7IMzWmINUh/I4jezQPJ2/PB11ec=;
X-ME-Sender: <xms:FyzKakPtCTt2Go-UqAC-za3FKN2El4jWdaH_cr3B-DXJlMx9WP_YRA>
 <xme:FyzKak9VEVcpVVY3kaLDJEVhZaIh-CpOWSdhL9O9cZF0CRlEMnwcaQcaQys8vuwHt
 3gMjdTCtknyySoKpHp6DTkv3-V9OjTO7bxJOE-trElWRv0-1hGGwwI>
X-ME-Received: <xmr:FyzKah7bGPTtP27s5iBJzrzDqOxdKPA8JhCCVUaXMwKvy4PSc4ujmzPSXyJnc-qi8D0G0M_mgz-cQz7GhackCL0bnVGf_9D5TYHW_A>
X-ME-Proxy-Cause: dmFkZTFqpbXI6Y3+CoqfhNPZi+DG5Qw8jkDyXnjv8Zl/hcPn3S78Zk6eoCtECVWjb8Y2mP
 PIW0cluxF5Sc6nA8ZXBbZHx8G7ibOOE8hxiBeWn6zFftUvVf/TcCNPG9UjdVl7tkgXlBTM
 LIHFh5/qAXUQUGnZjrmiiLHT6Mhx9NZvwa2FwbUQYPStfkEM5s3u9Gz4n73nwucxxl+Vrk
 0OjGShLCaE1QK0a/CZkhOjweGMDOC/NfzcH4E1RuSEKg9vyf3c3eEfXLFETICuYPbtU3Nm
 g7JoKw89k6iDnZDjcXV42ma1zlizScl/jHbpW4kCJPOna53gfhZsymwqsPRvp8WnWwvdF3
 bbQNlwDZO6SmBoxq02G37YEcBn8LRuEyIMFQK4uZ3cl5hRw4iib6ceKweuQTa8inIknqmA
 SdR1c7z2Jikm3fbDGUIgY0xg3t0TjkRYLdKK87l8zESOq586v56uYAG3TPluxkrlyiddDk
 R00iqbFYM4lEhx2EUsHgYrVpo0SaRNqFf35uRG6sAuD+P/XPKaSEJMgF2j/9ljMLhMgAK8
 XGuijlR2N3MT62lbsXSOSw0fbuWWUVsCAxty6brHlmull2YYrWpobQRCyXEdiBCrQUp11Y
 QoUjckR0asNShN6TOW5H3EkObMAPe57HsBWIJbwvXLR0Z8cAxPoiBRSvPA+g
X-ME-Proxy: <xmx:FyzKaq490if3zmWymlUAS5sb9oKKvLu9IGwJ2-mGvuUCVQC8xB5huQ>
 <xmx:FyzKaqrnGRtR2LGk3pWLZtUy_UP-uYa71JltLF1qj83VGmC8wJ1Ozg>
 <xmx:FyzKarM_lv-8QPx89gX2HBBb8s1kGA6RQE8j0TD4dLzLni1sAUCSsA>
 <xmx:FyzKai3GVUr64qvTlXehO_1LIJqwdpFMJzT3qZBOCYCBri_Hgf6h7A>
 <xmx:FyzKap9zn01jGmRl6kbkd4FdkDcNNXz9OXqMuqCOaTjsUUfIT4hbV1x2>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 08:14:14 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sat, 10 Oct 2026 14:13:57 +0200
Subject: [PATCH 1/3] doc: apple: Add Apple M3 as supported SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-apple-t603x-support-v1-1-ca529f301a62@jannau.net>
References: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
In-Reply-To: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, asahi@lists.linux.dev, 
 Anshul Dalal <anshuld@ti.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=UMoiybBG3EjMyc1B7IMzWmINUh/I4jezQPJ2/PB11ec=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxTOgKilvYaIjcYziY+udr9UePjwV3z7+7jeLkmXSj0w
 zLrN1U7OkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExE8xojw5qDd3N2WvpYS19I
 fsm0xllNrs9kjews949GCQcvFS+b9ZiR4Y+i7z7vp9XpW69dzA94el+iyiFv0pFPXpmCwk4N8e6
 7OQE=
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

Adding M3 (t8122) to the documentation was missed in commit a1a47eee6763
("arm: apple: Add Apple M3 (t8122) support").
Since Apple silicon SoCs have switched to upstream DTS stop listing SoCs
with device trees. The expectation is that u-boot support is added
together with Linux support. So the device trees might lag a little
behind. Since u-boot's dtbs are usually not used on Apple SoCs this is
not an issue.

Fixes: a1a47eee6763 ("arm: apple: Add Apple M3 (t8122) support")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 doc/board/apple/m1.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
index 900c5e6d91ea..4ed275f7ea8c 100644
--- a/doc/board/apple/m1.rst
+++ b/doc/board/apple/m1.rst
@@ -9,6 +9,7 @@ the following SoCs work:
 
  - Apple M1 SoC (t8103)
  - Apple M2 SoC (t8112)
+ - Apple M3 SoC (t8112)
  - Apple M1 Pro SoC (t6000)
  - Apple M1 Max SoC (t6001)
  - Apple M1 Ultra SoC (t6002)
@@ -24,8 +25,8 @@ On these SoCs the following hardware is supported:
  - NVMe storage
  - USB 3.1 Type-C ports
 
-Device trees are provided in dts/upstream/src/arm64/apple/ and available
-for all M1 and M2 (t8103, t8112, t600x and t602x) devices.
+Device trees are provided in dts/upstream/src/arm64/apple/ and available once
+they are merged in the Linux kernel tree.
 
 Building U-Boot
 ---------------
@@ -82,5 +83,7 @@ supported SoCs.
      - Base Address
    * - M1 (t8103) and M2 (t8112)
      - 0x235200000
+   * - M3 (t8122)
+     - 0x2a1200000
    * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
      - 0x39b200000

-- 
2.55.0

