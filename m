Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46C5CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 417EB409C3;
	Fri, 16 Oct 2026 06:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYLrAagp6Ei1; Fri, 16 Oct 2026 06:58:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 28400409CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133926;
	b=i1sES5DHV6wjRoCPiCIi9YeoopBEGTMz1lTA9ENL6m5rJXVPpl5L6srBPa/rqPRQbMmZ
	 KrZHBgpMamF00ZLKwMNP4YYE4HR8Br8JMhkEav/SA7D22C1YsTvgS+qvNC/vORq9QdRVu
	 mk1wHYJxQUfXtQqdq3ayniUzjnd5Gc6mg/fP1iB2YnQxdkLIHjKwd/91ZHddmoaLtU39D
	 UqfxDyBEIzPMl8YRqeoGE7NIfpXGyIZKFCYaPrmlBRhGjmCSLEUZbCSmShGq0wVw+furz
	 ri63yhhPMcOOYJPjTp9RF000BW7o3nVwc7EgE8DizVDMhB2WeNHNl9JIyh/D0WnWVEg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133926;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=c9XVJVdKbimv9ZNR3VjLqNMTtEairf+AkEi7OpPGDsI=;
	b=dX2XRT1t5Vfn4jOJDUNrpzew+pJV1LbNfdDKyiOY8QSeW4Y1cWzfUh699Z71IB+QsaQR
	 svoZvjr9GyK0kuol4SblyO+E+wgk46E6QfWk/u9jk6j4pcscjwqw0TjBoqyLNSKdtLhee
	 /zYZJmGnhCR+nmfuu58lGQ4EDJUb/k26hs46rFAOyCPdFAyzoSmxUscE6jk6obt8YBrZB
	 nwtcBRigooJYXxek3JMCX+MbL0XKEXi/sWmi5dsD4VrD9MYcnmcPERDf8FMlky0pKjqfr
	 1pwqDx9UE6Q1f/zjHYkMu5+srpgqDfDY1upeZ6rff8IZ8nQQ5hNx2ILJTpQagHmbdcA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=ebP3PMlV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133926;
	bh=c9XVJVdKbimv9ZNR3VjLqNMTtEairf+AkEi7OpPGDsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FqQgg0XTa1JINT2w0D+jLH2A6WoOJgr3WgGFbShdasURl+Acll4Mg1fYQbpbZQlmR
	 zqpyuhyf8PZqrJSaFncoT1jsWtQIxw64l9UghAI+LtnXXhehX0xLgPEZNYygaZZcgJ
	 X4I8xUzLtCqTPH1pL8/7g/ajtW7XHLPI5gCyPgbRd8f/MEi5HQHsq4Dba8uVEZrsjK
	 AY5XMZqhDI32c0jHtbgJvNQ1+fjgK8SIsXucSGqZAfk7FlWClLlSZD3djujTDrhu/t
	 teATKNCo8EslZ+xlKAmZ14i3kEEtrGNeEhbGOcnWO7D4YVE3FpsgEru+y9IJeLZqZ5
	 T/LaKT+lxRnBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28400409CB;
	Fri, 16 Oct 2026 06:58:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E81A1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A7E3407CA
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xNZj3FtHLiCg for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA80440982
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133922;
 b=tKc7nkT0tlRtjY7qR4XrGAD4U4eL2HaRXSnt50ZcAoU2C7G7DK3agHELrIayATnwv2zs
 Awi2ASR761dz99cZFKr6pWNj0YOsBhAn8/I0fV/QIlAd5w9Po2olUanQpVYYyxWqsanvG
 RCbxXnyfvjbYQEma6F3vAiA661fTAmpVbeFMJr1zb0YcwOzwakdsdBHEgmvCdmgXYzmDa
 LanDw2T39uoTDcGNfU29dxJ5cW3/To073tkqN34QYl4nIeWuUPQ0DoDdeElyXOORMAb7n
 jXofVmODDLAJDT35ggLKwHO/oFWskAeMPpemERgwWxHSSiTHU13MbtTwpH3azsIleOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133922;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=c9XVJVdKbimv9ZNR3VjLqNMTtEairf+AkEi7OpPGDsI=;
 b=fO8NCfVygV0oKOspMdPjuKs/R1SkIzW97Jybhfe/G+jKEswNuhTgzqTORCrCAg8mE9CP
 7Um+w/m7gqw4bumI6OFLtr4NJOttIzWtoFi3W+Tllafr1hehXscgqLLgMEv1GUSPADG+H
 OoLZDX2tm9nd4h73em+OWDtJxWkyOL6G0WnvVPN59jw59ac0TP8UHd/Z6VdeLKowe5weS
 urzjg5G2V04wokgxtd5beORgJGzJU94Uk8/XIiknvTeGRWSxu4XupUxyXvBWdxiwlXbH2
 CAf5JeyIuBa896bn9VO6YpkOfVc8kwWorXwhMsAH/kn3IfxBTwTrUZVo8N8CrdgbBfQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=ebP3PMlV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=ebP3PMlV
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA80440982
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133915; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XB/TtFf8gEnsLsMZb42SWZ85Mlm7sd13WgcQSNSUBJNfk8SGuvnAI/cs4c0JbCaln6OsJiqzxdLYXGb6ltBgRdVxp5wk/4E6OZ8JGIgCNjh/L7TLkmH0d1xRVBxOk/qrIA2Ua6MWLZylcs1AFKqApecbRWA+TPcOnXu+CFwOPsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133915;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=c9XVJVdKbimv9ZNR3VjLqNMTtEairf+AkEi7OpPGDsI=; 
 b=eM2ck8MWiJblPo5LSjbDZUVlEH8M2CyKm57A/VP5+zr4QtBJ3w4mjL1sdiYCSv5wqVyelSu7IG+eevnziJ+MoGRmqf44bVgM8S7OmfZP8LcN61HfsplPb+taO2dZ6QUSQht9Pi6RWf+tdkb1JXduItP9uqZsQCA5BjwgnR0dLI4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133915; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=c9XVJVdKbimv9ZNR3VjLqNMTtEairf+AkEi7OpPGDsI=;
 b=ebP3PMlVvZP+0H3WcVXoyWLFjjPFL3MrYFu1urp8CL3QBqjl9JOR7KXjLxDRN4dw
 AznSc4Q5XcWFZblfBGkrsz3tQDp78qR6mOW7F3vgfS/GUFN1MwqEKyvtZ+5YoXckh1E
 Y6j8qNGSSOWMUy8PaYx7NacTjSpMY8xQyB4p0YGc=
Received: by smtp.zohomail.com with SMTPS id 1792133914098240.71076154765217; 
 Thu, 15 Oct 2026 23:58:34 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 19/20] MAINTAINERS: Add entry for LoongArch
Date: Fri, 16 Oct 2026 06:54:59 +0000
Message-ID: <20261016065500.137544-20-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
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

Add an entry for LoongArch-specific code and documentation. Jiaxun and I
will maintain the LoongArch port.

Signed-off-by: Yao Zi <me@ziyao.cc>
---

New patch, no changes since v3
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c363..0860f9e6f402 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1171,6 +1171,17 @@ F:	lib/getopt.c
 F:	test/log/
 F:	test/py/tests/test_log.py
 
+LOONGARCH
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+M:	Yao Zi <me@ziyao.cc>
+S:	Maintained
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-loongarch.git
+F:	arch/loongarch
+F:	doc/arch/loongarch.rst
+F:	drivers/cpu/loongarch_cpu.c
+F:	drivers/timer/loongarch_timer.c
+N:	loongarch
+
 M680X0 ARCHITECTURE
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
-- 
2.55.0

