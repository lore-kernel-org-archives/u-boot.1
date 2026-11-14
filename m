Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8EA606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NUdeFk6p
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 118F4812FA;
	Sat, 14 Nov 2026 00:10:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LiBzrgu7KVPN; Sat, 14 Nov 2026 00:10:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C222812DA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794615003;
	b=MIIdd8PAd9hJx7f3RQ/Il5BwvO/KV3HEfPgHskai5q0aPYC8v1zP7xjiWEdO4ggatK5v
	 zglu499GMqmXiw1hf4MaV/bRS8VQB7dcqOElLV7PCoFZJVUPDclcoJX0RKlNpWNN+yndx
	 N5bovUTGbCDtE9deX5y1ZcTbU0rPTw/GaYNzSFlSsX29UU5fjCBw7brl6plgyhNfx5plC
	 HpBQUaLZqZSRryvDGvL+bTj67jlkw9ZJPYBUds8fbotKdV7UfqF7Jt2BRRBAtagY3x4Yo
	 sLVmvqWzT11ZsNDBn5iCLDAxWiqu1lTMW168Z6P/0YfcyOyiXFOff473GxPtuJnH3HQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615003;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0H9G9uVeoR3SmPj7jzn8TNrnVblO8n1lyqBAtdcK4js=;
	b=jhcPMa4NjlEIr9HmPxrHyHyCe1uI3jpFWByBhEEgYxVrIfqPEEvO5ORsN8dK3/MlIVdQ
	 Ed1uKkpnzBkM3WAKtKsneQ39Z8ZYKwr/XXwSt8S60Nag2kdmcb7W7ho4hQybj/6l1HNUt
	 C5gFp7FUl/BQ1OUI+tUiYnAOCWGavGFexmt/NDmbj4pWeCGBE0SaxXmWDAQCBqWP9Whvb
	 m5Fp5GQPj1DVhfEiKtRGQ1iuetnNQTAlYgJetDN5lRZLIi8Dylk39h3DtO7+Vz3fN+eay
	 KVvl5Im+gzBXzICysZppu/1jm1Ohj7bXdlIGzARrH5s4AbwHpKXcTgg1DzWJ3FT/lGg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794615003;
	bh=0H9G9uVeoR3SmPj7jzn8TNrnVblO8n1lyqBAtdcK4js=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NUdeFk6pMftANv6wtqSByDIccpaKmfWcyMM8p46j3y84gng0c5GJfNS0L1lXVlq0h
	 2z3FQecc4XnykuzWPNo6WE6Outlfi/j2hqv+bjxX0uLJ/9WfniL2WemIIrQyACfM/n
	 4kWYK5hl3fZqrbW8ern5UJRo5QuargnbFgOPrnBxOHMuDsVvLPCaYkSg8lTn7celMk
	 bnkv1Q9uKgqIj3VvqWzl4P8OhUaz250KdrGDNAqYyNeFpJYIvMK2lHgcApGQYiz0B4
	 D82LiLbDjbn4mKYvJPkGUtiNgjOlJnBcfoTL7bdDvfdU4QBn5IUBAwTZvYw9FQCaer
	 soyX7CkPCSJrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C222812DA;
	Sat, 14 Nov 2026 00:10:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ECD5C2FB
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DECEF812D8
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 99K-ZEIwHHEq for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:10:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18EAB812D3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18EAB812D3
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:10:00 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS1L8-000000008V5-3NDq;
 Sat, 14 Nov 2026 00:09:54 +0000
Date: Sat, 14 Nov 2026 00:09:51 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.u-boot-project.org,
 openwrt-devel@lists.openwrt.org
Subject: [PATCH 2/9] sandbox: bootm: Reject unsupported subcommands
Message-ID: <bd8a36ed8a3c83b47cf1283588be15d2dcc7e77f.1794614777.git.daniel@makrotopia.org>
References: <cover.1794614777.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794614777.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sandbox accepts the bdt and cmdline subcommands without doing anything.
Return -ENOSYS as other architectures do, so sandbox tests can exercise
bootm's subcommand error handling.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/sandbox/lib/bootm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index 7a5f6f7d36e..da03f451671 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -6,6 +6,7 @@
 
 #include <bootm.h>
 #include <bootstage.h>
+#include <errno.h>
 #include <image.h>
 #include <asm/io.h>
 
@@ -68,6 +69,10 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 {
 	struct bootm_headers *images = bmi->images;
 
+	/* No need for those on sandbox */
+	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
+		return -ENOSYS;
+
 	if (flag & BOOTM_STATE_OS_PREP)
 		return boot_prep_linux(images);
 
-- 
2.56.0
