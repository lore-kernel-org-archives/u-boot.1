Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4960A261E
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jm0enhWD;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=eb96sv52;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0hPXg5eh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 305EF81566;
	Fri, 20 Nov 2026 19:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ao-5_m6fyN9G; Fri, 20 Nov 2026 19:01:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 236128109A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795201286;
	b=slpNkTPNgy/326XnLzEtfL25dGO6mGY28Y+mWsSRtksuK4gSCsi0FhTRqmPgNMonPT0s
	 Df6Ir2qjRruRmJdnlAS4kaBwJ0PZw0kFGz4HV8+FUDGEm7xZFVKdLWUTT/e5+OJZboHwz
	 4B/bK9A0/qT7AbqFCleViWb67SAXlwa8Yu4weyxk9zXzQ8SDnbII0F74xyBeNIctmR5jr
	 +ZsLHayEmVgWF+1taVyYfzFFQbYefAOMD3xir4tpsCH849jRMPklUV6o0PDA+KgzX0mby
	 J3j77GfbP8K2ftcaQUGzyCweEB3yy0AVO4s+lL68Ot2Sfjqghya8/dO+p99bEsqTDCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795201286;
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
	bh=wnql81BWKHaZHcyh9IFQOOcSIa95vyjDjKvhvlm0QJY=;
	b=Sr8V6JX09sc+4gFR/VYWz56EoW5laWrme03jzkDhd2bfRGYalONXNky/axEMJuG/n9d5
	 NdheqUVShNc9gsBf9uCH9bypdZo1V14KrtCAAb2WycLxLX825BTNxDrlemtYdU5RPq3Yj
	 /Y3GPsyR0dGDh/7Z/WwrS4Nu1zU4Mg3Kv2eB3ID7eckdGpk4+m7na6Y4xZmXctiVEl/yC
	 8evobRTkPuGzvAt1F4Ebw7rf/p6L4wCnZDI7IyunESm9f6JAzpR2qO1ucrbpRcakleptu
	 Dv7R9Ho9L4qJ8zHz9tYfSXTnSecwxgdQqrHeRqW1HLXX6wx80V0KOuKQiEIbV05V0LA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795201286;
	bh=wnql81BWKHaZHcyh9IFQOOcSIa95vyjDjKvhvlm0QJY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jm0enhWDbEXS6NLfhBH2JGLPUbBCFkeZs4Cf1OJWFv9c98FaHhgZHFqJ5C8EKyfeY
	 xo1j3Uhopc3hjEaAiAEkwL6dssZ2Ev7BGS6nz5VtiUUMmdAH7HCmy7wns1P/9YXDX3
	 ufWSkvuu/FX3zk3GboCRW9txRo1PbJebPcjQk1+X6IvY1BumGjNt7bSQKX71V9tJi0
	 cQujDZsPzdmmDzI7bJyghThub3oioC2MyGkwn3DZsOeJF7f7REIHDua9aFMIEMouRG
	 GrxobMWu+PLzy09UVNEMevurWlJQNFy4HKdQVVjNCB0cvHJhsogcw+QuddhStJ9BQ3
	 J24QBmA6d6Dww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 236128109A;
	Fri, 20 Nov 2026 19:01:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8856AA58
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DD9260618
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ljkZQzviqawx for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 19:01:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 28E7E60616
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.151;
 helo=fout-b8-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm2 header.b=eb96sv52; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=0hPXg5eh
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28E7E60616
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:01:19 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 78BAA1D00494
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:53:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 13:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1795200808;
 x=1795287208; bh=wnql81BWKHaZHcyh9IFQOOcSIa95vyjDjKvhvlm0QJY=; b=
 eb96sv52yGmNEnPJrxVkUwal3ptx6IKBk0igl2q00U7g7DpnvVgGyQ8m58WSqu6C
 jXXt6epP75CEYsWwo79nDmyPvK9vYmIQzOrIQ7UvSSv1eNI7m7ngtU0HXkkD8ixL
 YQeWiqoFWK2/dmaXyvP99W2JYFD7zBamHkL/aFO3tymo4rhXk+AzaWm9YZKY2sOo
 NbP4pF0de1ZGraW41BGOdVbg1iWHTUfqXN/5XQIi8WaRjPLApjU70zo8xfsqg8c9
 cNzbOmprLZpEETvccBWOBR4BWPMRptLA9vBrF7DeB/gxJ9+LtXLzv3Eag4HPmTEj
 jXZ23EKa3ga3Pws4FdeFrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795200808; x=
 1795287208; bh=wnql81BWKHaZHcyh9IFQOOcSIa95vyjDjKvhvlm0QJY=; b=0
 hPXg5eh5ue8nnGO4aWxzBB1wniMVwbYISMrgLzehjZYZXReQcYTIfmqc0iGLzu/S
 3fiaUCZH3ys00gNuSjDHQr7fp1LKxBgFO7GVpx9oNuq/8KCsoCMC/ulj33WkYtl2
 jDVGsjCxf2r3TnHYCdvMqW5GUEUYewfTLK4q9SxHGrPs2xor5lIFSYDDMZhq2WwO
 ggNXYIwfLjgeJg+6Dhoi1QS55cTW7fiiJdaZFE/pUlGse5sucOvR11RuffbqxsAO
 OkAVJBz93h5x5uEFOirhnPqSNRI7FSepivU1z9VRh+2t7riWfl2hGrC2cbFLuufQ
 toZut3CHQDo4f8OR0yluw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795200808; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+;
 s=fm2:rsa-sha256:P/5jSZizUmC9l8aisWyiqsmm5HEm4I7hQcCN1UV1znKZT5A
 b/OmNTIb4IsO9+VafjjYZ/03NzXCo0FdgvD3BLb09xu2EeIfTkCjJiXIcQpYAMei
 SdO4I9h3A6Y34hHEUKwne7oW3uRVD017+qIuBEmTkM/OX1WMXYvWDlYVzu3ba5qX
 LySSe4wWSeYQpDd+slFO2Lyy8NiAdj3FZvzQ6i3eV6/STVR5TgrKbb3q5B24TSa7
 ApTokokU4N07CJ0QPSFiD7T7f9LLVTwXbXN4sSnGpeX74OLRB3+2tPJnlYy6oNRD
 18VbKNgATRtfLqz1YuL1A2Lz2NqVoL7I5qUQOag==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:oRMn6qXfq/ZTee6WqGbcaYKMPuSx+JQIGZqaeCtzOHM=:uojPMqcnLErYgnIgNExM6qv7er8qhnePLXA1IdvhcN0=;
X-ME-Sender: <xms:KJcAazPzV_XjXe-MFxlYVOPVvjORJJZBuua38WNdPyuHZatQT_rjsw>
 <xme:KJcAa39831zivdkUsXOCp2k0BuoGPn61brsNb8IhP-HKJyWpMXEp4UTGVvKHWZL66
 ZCrAAwCCoSswayl9g_XzmwjY3059MxHgsDhS65oj_GJOGLp0_trSLA>
X-ME-Received: <xmr:KJcAa46qVGR94jqXlLWNt1ACLrMuZoE6DHgEQCTgPTfkPV-K1EC4ZmB-VrO9ATkiEI0rUq4-coUQtL5TJ8R5uiXGNYkYwyoQym3OFQ>
X-ME-Proxy-Cause: dmFkZTF40NY3j+ynN54GON3MNlAVzxJLtPAx2Hedsg+UjTHj4zhL7JTRhAJpFoXsLtvn+d
 lqP28eeB/BzEKpHqS1aE0+eMkKY3CaL4Kd1ab7pTKj71pDm6Q2932xedD8+/6RWYLt1Czy
 se4sW5hWg3zR4ZwAPtaB4BBpz3CUPGBBKncmjcZVDZeuALhJjD010wD8WQDSVMVovLzHpd
 eX6y5K5z3VcfqK/1d8wCfoxHFm7g39w/fJGF/1QrK6LIeZvtqkFpz4Xv5ssVbGumUJwN71
 AOtPCYYcwZGGBR8w+SJVJHQmuAE4PQ82dv2/TzBiysxC0z9kpgUlKX564Oj2+rPjlig4hY
 /HHnrXgeBt3jyW5M4RHUQsjhR9YM8R1y0yBKOkqoKj7PhB1tg5Z65dalBfzSDgjrqtS7EQ
 W+bOxM3gmiRPsn4xU2VGiu8i87K+Lo0Nh5G69PPa2VxdCeE8gHX2e9/gMANyuwqgjP1VQS
 Lz3nMiBOFAU62DroZJAtzmj5QcVrERAjXMiK9eNzm+AIAbBo+ud9ihYq18s6ac1DCBUPeh
 FzCTU8lKthDAcHemy1tHl9RBnA+Is+jMuA/PBq73mtbP+59BY1u6ZlBsZhy3A9fthWBK5O
 45xJD1M60+N7hlBeLxxUAX6rk1PrcdQWaG7At1y3kd7L3/BSYPjuCTJASnsA
X-ME-Proxy: <xmx:KJcAa14w6AgwSbs7jLlOlviyOVS0aHsxyo4tmHm9D5AP0QZDvXKnag>
 <xmx:KJcAa5pcvAPeKJohXIC8BjpLt_2LDrewJKjyQxH5Dt5NjVqVrMCykw>
 <xmx:KJcAa-OpEe_5OsN2BeL3-gJEyQixizKRO_RJhacX49MhqPC-3DKf_Q>
 <xmx:KJcAa50ciackflmNaysmWGp-UWeCr2zGyl_q6Q2kHdo6i7Rym64RCQ>
 <xmx:KJcAa48nGWBmFFLdIqobBVb7PhidQmydr9gv0KzSMvB13-ni0EfoKMMQ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 13:53:27 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Fri, 20 Nov 2026 19:53:10 +0100
Subject: [PATCH v2 4/4] arm: apple: Add Apple M3 Ultra (t6032) support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-apple-t603x-support-v2-4-606b4f5fadc5@jannau.net>
References: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
In-Reply-To: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, asahi@lists.linux.dev, 
 Anshul Dalal <anshuld@ti.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5805; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=uojPMqcnLErYgnIgNExM6qv7er8qhnePLXA1IdvhcN0=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhmyG6eIFoiYrVqZMeLJ2RnPt1gvW4qy57VH3fB6c6l9o9
 uVRxpkzHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACZy4TUjw0bhwxXnghwCNNve
 rsuLT3+/VejVj7a/tS/LT164sGs/41dGhpcqMW2sDfa57kGqzK3qfQ27L6bcMpXT9b73ujN72TQ
 2HgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apple's M3 Ultra (t6032) SoC consists like its M1 and M2 predecessors of
two M3 Max dies with an "UltraFusion" interconnect. Since it is only
used in the Mac Studio the mem map does not need to duplicate all
entries. Two of the USB4 / Thunderbolt complexes on the second die are
unused. Only PCIe host controller on the first die is used directly. The
PCIe IO on the second die is used internally to connect the NVMe
controller with the NAND flash.
Most of u-boot's existing drivers are compatible with the hardware and
M3 Ultra device trees will carry "apple,t8103-*" as fallback compatible
strings. Only apple-atcphy-reset will use a new compatible as M3 Ultra
has ThunderBolt 5 / USB4v2 USB-C ports.

Acked-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm/mach-apple/board.c        |   3 +
 arch/arm/mach-apple/memmap/t6032.h | 136 +++++++++++++++++++++++++++++++++++++
 doc/board/apple/m1.rst             |   1 +
 3 files changed, 140 insertions(+)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index c93c3bd56aa9..ae1b1a7b8a43 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -21,6 +21,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #include "memmap/t6020.h"
 #include "memmap/t6022.h"
 #include "memmap/t6030.h"
+#include "memmap/t6032.h"
 #include "memmap/t8103.h"
 #include "memmap/t8122.h"
 
@@ -77,6 +78,8 @@ void build_mem_map(void)
 		 of_machine_is_compatible("apple,t6031") ||
 		 of_machine_is_compatible("apple,t6034"))
 		mem_map = t6030_mem_map;
+	else if (of_machine_is_compatible("apple,t6032"))
+		mem_map = t6032_mem_map;
 	else
 		panic("Unsupported SoC\n");
 
diff --git a/arch/arm/mach-apple/memmap/t6032.h b/arch/arm/mach-apple/memmap/t6032.h
new file mode 100644
index 000000000000..5616d7f32285
--- /dev/null
+++ b/arch/arm/mach-apple/memmap/t6032.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2026 Janne Grunau <j@jannau.net>
+ */
+
+#ifndef APPLE_MEM_MAP_T6032_H
+#define APPLE_MEM_MAP_T6032_H
+
+#include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
+
+/* Apple M3 Ultra */
+static struct mm_region t6032_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x280000000,
+		.phys = 0x280000000,
+		.size = 2UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x300000000,
+		.phys = 0x300000000,
+		.size = 3UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x580000000,
+		.phys = 0x580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5a0000000,
+		.phys = 0x5a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5c0000000,
+		.phys = 0x5c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC0 */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC1 */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC2 */
+		.virt = 0xf00000000,
+		.phys = 0xf00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC3 */
+		.virt = 0x1300000000,
+		.phys = 0x1300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2280000000,
+		.phys = 0x2280000000,
+		.size = 2UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2300000000,
+		.phys = 0x2300000000,
+		.size = 3UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC4 */
+		.virt = 0x2700000000,
+		.phys = 0x2700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC5 */
+		.virt = 0x2b00000000,
+		.phys = 0x2b00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x10000000000,
+		.phys = 0x10000000000,
+		.size = 16UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+#endif /* APPLE_MEM_MAP_T6032_H */
diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
index 3b4fb2913981..8637e29b9498 100644
--- a/doc/board/apple/m1.rst
+++ b/doc/board/apple/m1.rst
@@ -18,6 +18,7 @@ the following SoCs work:
  - Apple M2 Ultra SoC (t6022)
  - Apple M3 Pro SoC (t6030)
  - Apple M3 Max SoC (t6031 and t6034)
+ - Apple M3 Ultra SoC (t6032)
 
 On these SoCs the following hardware is supported:
 

-- 
2.56.1

