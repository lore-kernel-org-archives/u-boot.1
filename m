Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3682C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D12340BAA;
	Fri, 11 Sep 2026 10:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBujjv7IpvMU; Fri, 11 Sep 2026 10:46:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8CE5340AFB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123601;
	b=hQukdfz/Jad0MX1UrEklCWT13AKWxjMN/GzSGNKvSy2wjGaOY5ZCrNyJFUiVRBjZqZDo
	 r4BAUuK+QPJOA+a+EnAe12Uv9/5KwuLMvCEdx6WJ0uQRcYu0dawjwhNGVTd05jrQRocFO
	 j5zcCPr1BaM4JdYWnQZxC+ML1yCPiRhBqTE88yOWuxWZyYNmEcNhSZB8OxE4uElGXB+LW
	 smoHcnngX6BMQj6NcF2rLNTuxeVDI7EvJesEV4ZMmvLYzlzMPGlgCXAqxr1q8TaRJUKPO
	 ocrN2Zg44eOwXPldP3rBcaBuwclxh5xhZfbWsUjvhcD84Ajp16eZdXu1QpoLY0B7Xug==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123601;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2TUZ27zpCk2qSCIDqBAb2Vq/8utHdQjqV/lMoyvG2Ps=;
	b=gfkIV3gh0guT1CzGMvuWQDU8zvfdkSPF3MTY10WI13sIVW3bMXysn4wrbQJebkE1lVk9
	 lTN9ReOmar55WImL8h5GqyZwexSY9c0grwGaeQHYZ3mm7J+qce0OvPxZBiJnqXrj49vwe
	 t3+wUPAOmG8XWJQX3lapsRMDp3Q+cIdujyj6UbpKK28E/HM1+94BMEt4y9zbPxwEFszpO
	 dthwAjx3M41M/Mg9Bg1lfg0I8osVgWG+d7eKwMrE6iInPZxTWbuiLgxuBOM2CqyEJROgV
	 J1Oay5+Bw3KapI7PUVxTutxd9dCBfj/IIGlCDTLGI+YgADOjM9eMjXePmyxILKsEaig==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123601;
	bh=2TUZ27zpCk2qSCIDqBAb2Vq/8utHdQjqV/lMoyvG2Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pr8WUW2GMvYtb2LxWcouswNX+NVu5EHv2j4euvmDl0XtHAeOOG3p5LWVV+xSGojky
	 KOdI5PvSsBUIA/m7cPxyicLTtNL7TghtKkVQnGUyJgQcrVpmhoL1n0FhQ5vi7UiGc3
	 pG1N6a8PoAj/+eCMLHopJ9P2HMVJkXSPs/5OCrxw+ZoFvS9tSPxbAcLzi2QQjxNVFe
	 NWTDqjNdMTuifcun+C8RIJ99fnUSm55uBhK1QsH0pQZxmww1lSu7aWZXnvk4qFuNRc
	 x17UdTNOUutt3HY0aLjj0KXXGduBffL7Fbb2mHSIk/HARyEB31pnZyoWi2jbz83jlf
	 0KZOGa4j+TuYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CE5340AFB;
	Fri, 11 Sep 2026 10:46:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 578E132F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D82740461
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jtJ8q6bt9I_E for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:46:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7347240460
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123597;
 b=YqXmGwpp1sSlb/+/krNAhl0bB8Zn3EyegOsZc/7wpqg29bIIQj8YETw1xAETPdZtxx78
 T4tNVGtHPENYpJndgp9mWk2Ls0OeVzMQIJ/ptlRwxBdjDAsL/LqnGCUY/tiAmi+O7KdwO
 TNJRIyPPewTLYTF/3S0hO48D5u68pAV3kc4vr2tJ4Okuhv2Xn6ShV+7VxXOM8Y11/kQLJ
 PiBpo8+8YaOPbKj7+6am3hGFZo3xjKlsaMNA7cXHNvU+JnVApq0ctdofU/rCFVOtR9g8M
 ulPGqzfX1QcxJvnrr9w+rkCU/dJwI8mMNc1xepIh+2TpDv1ekpaeFPX4xyjOQP8ebgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123597;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=2TUZ27zpCk2qSCIDqBAb2Vq/8utHdQjqV/lMoyvG2Ps=;
 b=Uq+Hxa0f0wI1EA0EDGzXC9VTJvLZbN147jStZWAFwghPXafo4pm+snReFT5Vgryb263s
 Tk777N0XiM2bAiSij0DViHz0KH94R4AWN6f4ByIk87Sv/vN2O/JqpG2CTDstOwTOLp5Yn
 cyNO7eQsI5NaL/fhaD7/oFfVwv3fSt72gEUzxuySafHsq114Jd5FfFd4qp16MG59uUoeJ
 TSJ60LgZXFgeb2oBJ9xdtc7VsijDNfS8O5OM6qtd5C7PQDOU089Ccuux9YdlBYt/GbUXM
 gcagdf/Q2CxeX2awV7nSND4/icRbiq2OU9HfHcfTDY4t7nWlY32iHxHK+fvmKylv6Ig==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=LDXeC2wP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=LDXeC2wP
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7347240460
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123589; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oL1wQynSJ0HHIZf7z/XPnKgrEI9m5XzQX0HuNoZYaqSDkiEBttYmIJQoIEdMmj8t3xP1A5ULNn6xHqeI3e0VAWyjZaNw7DLog1lqBg3ZtgNl/Cb9Sk94zDbnnGRHBYPuSriRe8V5uOTzVl77ZRL3OiYzZ9rDrTFTf+z3Vow7PK8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123589;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2TUZ27zpCk2qSCIDqBAb2Vq/8utHdQjqV/lMoyvG2Ps=; 
 b=HJNVdYuPZ6sqtH/YKBBfA14Thag1nQ7xnK+SxWtBw9ajM2N2oLONTw6h1zTalV7i+nQo3CRTmX52VIiQFtg+TcppKfDKflufmdIZnsewVk/UUItDQNdhFvf3f7+q8o/DP2Xq4jdE/pdGqgl5WkBPhcV8LTI9+eGQ9Zt10fqRSM8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123589; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=2TUZ27zpCk2qSCIDqBAb2Vq/8utHdQjqV/lMoyvG2Ps=;
 b=LDXeC2wPdeYwYdVrMbXTLZtu5URCIMHmWZuiuA1HDiT+BPYsMRrh+n7yPyFT3a4z
 PRQH1ifMNPzxXTd6RmXcX4qcHcYgJ4AXGyuy6FoeT+4sCT/+/3MMO9YWmGNHYaHlPkd
 R1V+/4fUoz2K8C3/0oe/5nfO+NvG5M1TxUPIERqk=
Received: by mx.zohomail.com with SMTPS id 17891235886212.9260364572151047;
 Fri, 11 Sep 2026 03:46:28 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 02/19] linux/io.h: Use map_physmem to implement ioremap
Date: Fri, 11 Sep 2026 10:45:47 +0000
Message-ID: <20260911104604.2910944-3-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

ioremap API is here to be compatible with Linux drivers,
to maintain compatibility we need to ensure we are using
the same way to determine virtual address for IO devices
from physical address.

map_physmem is U-Boot's standard way for doing the trick,
we should follow that. For architectures VA == PA it has
no impact, for MIPS it has it's own ioremap implementation
in asm/io.h anyway.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v3

Changed from v2
- Collect tags

No changes since v1

 include/linux/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 79847886be95..ada6525a1c6a 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -59,11 +59,12 @@ static inline void iowrite64(u64 value, volatile void __iomem *addr)
 static inline void __iomem *ioremap(resource_size_t offset,
 				    resource_size_t size)
 {
-	return (void __iomem *)(unsigned long)offset;
+	return (void __iomem *)map_physmem(offset, size, MAP_NOCACHE);
 }
 
 static inline void iounmap(void __iomem *addr)
 {
+	return unmap_physmem(addr, MAP_NOCACHE);
 }
 #endif
 
-- 
2.55.0

