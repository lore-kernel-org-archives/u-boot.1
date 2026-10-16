Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4212ACCF2C6
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E655240AD7;
	Fri, 16 Oct 2026 21:01:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zjClxau0gFSl; Fri, 16 Oct 2026 21:01:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3142940AC2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792184508;
	b=eG2B/0K5MecE8WFyAkp7ErUOcpZ29t7mlrEXX9kR3GOS9yZ/saS8r+1imjxLFgP0/Pyx
	 H+ljdezH1pUc2fY6ztBmy3Ze3QejmIAA5lTzz58NL/xDFtHJPxfW75Ud41aA8D2xQIYRQ
	 hhYq7Xpw/x6L6XofPYHG4xKVU6ihkNN1Jy5sPodaqvbfwLalLWHyv/VBhJ176o6PZI+Uv
	 gGPvzrzMm2j0KYp3oSTyVxBjF4IV407S0n7n7MLf3XU4n+YeWejNRiiWhE9wQNeU8XK7j
	 yWPZLKvdlj+kfT36V+3UDA2J43OL4vZ1yy6nnCRV8uUbTp8cuR7PJbZ0h2VVENwzzgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792184508;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JMUq60y9/b9x0gXy8tKMU1n2kFD63aS5HJ44DuZMbAc=;
	b=S0e2t3J79nLCMAmp0SGO/y96T2hcctT+dY4Olak8K+KyHKG1OQw1xudOQCFIoPTCkoV3
	 qmDlp9e39JoSNzKSesEfTJ01EWRczubBL/e4XSwew13wxoqpEzper5Pf4t/xGLHoCffEt
	 EHHFJPAkyM1piOZOobJUDAKmTx1bBsFHkknTyqEiXdf3jOZMXsjLn4EY8uzm3Uhov2bq6
	 +qov7qBmd+zEhaI2nansqSiDWjNMxMZB/Ebkoy0tY6+8u5yXiTFZEmzE5tzg9UNqLd9un
	 v/u4fhx76dFMFdMDXurnQQugJnZagx6YYTsVaQzl9xue0znhO4fKKLjreoD99mwIVFQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792184508;
	bh=JMUq60y9/b9x0gXy8tKMU1n2kFD63aS5HJ44DuZMbAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P0T/4w/Dl42dwla6mxUZuxc4bu0NqMfGKrQCMA+51z0C6U8PQFvOYX8dyjwk6SWoM
	 gsRafc9pv6+V3rGVqNcrfnOr9tj1cY7gAssWefPsXgjTLCJzKq+FBpBzgJe4Zu8UZd
	 CkfQB8Q71olMMiE51VOq/r9mq8CZDUb5E22v3Qp3SjLcAYzXw/wN2yhTj/+1IL25jQ
	 magtX3ewdexF1/mXsXQeb9+3EGQhJJwTx+gYPmYIFTVEr2yZZVfjq1ZXA9fIMAbaLN
	 sQKVUlPjpTyNs62Ly0f5wz2E1e7niLEcl/8xhC+l/MrEsFaxDaSXeISbb02Ugson0n
	 FaVCxyQ/OTHNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3142940AC2;
	Fri, 16 Oct 2026 21:01:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EA29F105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC7B481770
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NLaMGg4KA9sc for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 19:53:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E4B68176F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792180385;
 b=EBl+2dqkG6oRjlZAzM3W9mg5i87KO9K+8oo7d8k78XhPNDmI82+5W3KGjw4dVutyfax/
 QtZTuRjuf227ZISySeITBftvQT/YBUxcBrKBXiJej9HQEjQPd9QbgDgvnl3wBkBADUjjk
 AnmetQZ8aW58gYeTcBitmghj9f398O4wt+D0A84+kuyGJOhQdDvrIDz1ezxQdg4akCVmH
 ljMxNw8Nz0GF8f7pz1GfKsOVuU1kqkVQ2g/c8GXRGqp9e457XYFXlQFQZvuWxTodkSDuU
 hI1RZFetjWIhdPh6nrJ0YI4xA8TEwiQTZBE+LrrJTZLSpllJpsiUdUfeW3934jjUfuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792180385;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=JMUq60y9/b9x0gXy8tKMU1n2kFD63aS5HJ44DuZMbAc=;
 b=c4La0F2GLIrcKMMJ6rKuK1eCSwaHfAcD1ohXPs8gyMbYN1EM3XrhspMocRa0qq5hQ8FH
 cRUwS4LybxbVw6zNEF5PEIq57P5FNw1xLhIE6vJy1LoGrmfVumVntJJKGsWqs873S+h88
 ZKLZ3Jl6NCNaxBL91E21E9eYWEhw/wTSPehm/RxHAmy3PdnTboqiNMAyUd7fTh218fKtN
 Fz0UGcsFZXanVh7VeQmQCGFYE3EDmbdgT0TP48BEHhjo3I4UytBB7j7iQ0Lg6pQghYEGe
 hbMBwRTY2gpTtNgcRZBCAnIZDEBGisnUZHd5pNCSGhzXTwNT1wLBq7/PjbgwvMLpD/Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SJr4St5H; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SJr4St5H
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E4B68176F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:53:05 +0000 (UTC)
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-9906c3fc88cso126625241.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792180384; x=1792785184;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JMUq60y9/b9x0gXy8tKMU1n2kFD63aS5HJ44DuZMbAc=;
 b=SJr4St5HYAX1XeIAou1v0/p5Qb8IqRHo9Yji1271xAT6MexqVBoQpZQ5riLGGFiHUi
 ymfOC6yy//WiqiortnT87LgEnZ3lW7yAneD/FS9h+1Y1NVUYRn5w0MJQunhQmsusW+fc
 HYI+i9boKN7Tn5DheqybuGJB7U9a3eotlKQYRxQDy8iiFSbGlu393zufoVlKmod1Vwpp
 q0gVGS5HnOg6VjQsfc8tyIbWqgwE2d/KEz9jrIt+drQUZkj7vS0p0tZba3Q307Ck+RWX
 va16DWKtGd7xJWFJTdP6bzI9lvAqKUmr6ZkGuAukqCiM/RySKXNJ72h259EHeaUnSeSl
 H28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792180384; x=1792785184;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JMUq60y9/b9x0gXy8tKMU1n2kFD63aS5HJ44DuZMbAc=;
 b=Hsdk2tl5lHfVf7T0aRpT2Ado+uNWO7B8yciNWJW01BnRwGhZUt9VhYoO9ZqspIdBul
 gFNQgdvmcKCzFJOtgHJio2kq69eZ+CAadjaaMgzfcmT0BqJqUjG677eaR9cn7/SgVVAL
 ftNxysM6INxewO6K04PPugfPT6db1q1G7FYvj7lPQH+/sV1+p6CxNv8cBGX8QYzgJ+pI
 H6FqWViKXgqqPPacR8oVjkTGQRUkpmCULdHsV0K+35jEnF70eCPEbfsiRGLEyREhZYa6
 DCdWQtG1cT5Q6uLfZ6zyxvpIUNwt8Ij/2mzUpBdVYRdCvFM2/61MInNpo9UDZtgnlRdg
 8cqQ==
X-Gm-Message-State: AFq9FYKoC4cY37A2+/6dNwmabB1bymVgXl2SGfaG3iQNRREyR+Ry5CZE
 SbMSsUXC36QVSmbObv+Fm9dPGnyAmP4H26FbHisgBhlsoCzAAKVhjvVJ
X-Gm-Gg: AYBFou3cbW1cFs7iazV0Hw/HOBdKiin/gqI4fk+v2KKRnkvFlwrMPCTERiUhzWRUtTI
 ey0myVJg34LOnWTQd09xxU2EWdYrFm01/5xY3ZM/QDrWQrW9vBqNbFA7l7xNu7lPqSXYjwFaV4V
 pLnDaZUjuxXXIinuXgTo8QCVXKWqjJYiaG+w4uhSODxfIigRGW1PmrRKCq1tiC4jzBN5nH/4Tv1
 7hiNOl1HRH6naBadJQIFE9SGnJ2y1P5P7yMQ0qTmbCTOP6bmCyKWWgBOI6DCqE5jv/IzwKJwc8E
 mIG+IHWkb1rL+S0z8Hp8jAuee6ZSXJ2Wflev+9gN+O1+COC1Jcg4b+nKHbuR31YYJBQ6FoKNL7w
 8SkuA17Ooq+cLMpST0h9iX42c1DrHOTtAPIyEEDCYvH2y2hXJ+Dmtb4vsc3s5MptVsfaDZfcN5P
 JzhpCOKmwmLFk5XmBu6757C4anqf/SacviQgEzzNFaBORWM6vcNt+ScQ5p8EvyFMjh3KqkpFYHN
 /h7PM12qBZIKwk=
X-Received: by 2002:a05:6102:162a:b0:7cc:2086:34c9 with SMTP id
 ada2fe7eead31-7cc36731ad7mr297378137.2.1792180383888; 
 Fri, 16 Oct 2026 12:53:03 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ea9b2fef79sm2340305e0c.1.2026.10.16.12.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 12:53:03 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Fri, 16 Oct 2026 16:52:33 -0300
Subject: [PATCH 3/4] clk: sophgo: cv1800b: Add SG2000 compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-upstream-v1-milk-duo-s-v1-3-e4bf386eea2d@gmail.com>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
In-Reply-To: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Fri, 16 Oct 2026 21:01:39 +0000
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

The upstream SG2000 devicetree (sg2000.dtsi) uses "sophgo,sg2000-clk" as
the clock controller compatible string. The clocks needed by U-Boot are
the same as on the CV1800, so the existing driver can be reused.

Add "sophgo,sg2000-clk" to the driver match table.

Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
---
 drivers/clk/sophgo/clk-cv1800b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index 248a69321fc1..93d71ad1c314 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -744,6 +744,7 @@ const struct clk_ops cv1800b_clk_ops = {
 
 static const struct udevice_id cv1800b_clk_of_match[] = {
 	{ .compatible = "sophgo,cv1800-clk" },
+	{ .compatible = "sophgo,sg2000-clk" },
 	{ },
 };
 

-- 
2.53.0

