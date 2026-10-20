Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29A606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hoG2jbBE;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMzczQEl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30046810AC;
	Tue, 20 Oct 2026 09:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nbzJ9cyN8YWj; Tue, 20 Oct 2026 09:26:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 794C48109E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488375;
	b=kfspcNghcisb5HL9FN8uqIDz6EhYbDh6KG+9nKEyRedDS0zt/fbQV8uR06Qp6XCSJIFG
	 x/bijBmGj0GN5tN9IcGrhOeC1nJHEqLqAXIUYc3dRDUXhERNO2zcCtvEI2FLS6piZZiGS
	 Q9bptFEikw+xi/ZTEGK0Js/78gzEHBM7sATBKYXxMQ4I9UXLlS7OZ0SQNyEUymg7r5R2T
	 F4gGcM7dov7EcWJYbHqL2fhR8h4ET0SiRosnppQkaXhBr3iGu0ZDXPGsENolgmTaC9YzN
	 KOivcY7VVfzMQ6ZqmK7/WxF349zgFsmemvIPxU/0xCsrK1G8JzhVNhsn3fiUekQyXxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t7OcByN10ucOCPnaCtTDYOQW/SPYp+ASHacUyDP3Vn4=;
	b=fd3hAyetidYWDKvg2dwpVRHXSARjoN+mdPZPIZo4C1MIp0n30U0FspREXQDNjSHTuB+t
	 j/80IuwbCK0zYl8hJVVDAXPdG/NLEpp0CYPP89MmJ3tpbpyqI6oXWAZ78s62RqFY7x/Cg
	 aZVRGavoa/jWKUXymYm8PsHzhN7tCBsM1DctZ0QyPOVgfx5EtDSROkQXWYEh7HKp58yFt
	 gtVo9enujqzURxORgJO81OpfzAiRUDEQ3Ot1rFJMmHgIwPv95gmLCxsjuyhPmEJHR0LpU
	 W30AR0Ci0S5yj0pGCx9TefhOS5KlUjPoFX8AidQPQxYpCWiKavZna+bMFcI1fu08vrA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488375;
	bh=t7OcByN10ucOCPnaCtTDYOQW/SPYp+ASHacUyDP3Vn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hoG2jbBEF2nxTYDcfqzOrK03Dyocjvrv/QjeUnDirkG55Dijt4X4+ajYy2kCTiETP
	 IbyBlg7aypWKUZ13Z5ZczDV8526Zp4EQFricRZUotFw1dfP6CJzdc9CFwwtljlUoVl
	 ftlr8f6TrMEJrBi/mjz7ddm5X4cgqZjWDv001nwUFavKKkrfmjVmb9L3GlckfqjiLX
	 cfmMgq9iTmNPUUDyWuu55YIY/D4+hpGkPR+NdGYjq83dUYsNow77jCsmqEDLPTzMrs
	 53BFwA79zgtsuTQUcb8aNW3e6EDKuewj9zakgGRJ24+3c0eaQ8O1YrSF7yiXhOru9H
	 oEb6mELVWJXaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 794C48109E;
	Tue, 20 Oct 2026 09:26:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D1F73A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E701A6083C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v2VIKnvoTBcp for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 47F8D60830
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488373;
 b=dmqTZ7mnHVk4oBnzQ4WxPcjuqf3Q0cpGtrwBvPJCPTKYj/1NBcwJTJG62UoS8us6Obbq
 pkBvzV71cSKOu9glxqvsNx21+Mg4uJ68TBWSjyCl81FOm1KIz4r6lu7HOPXLIqgQKiF6r
 pq0NDcT4wogqx6KzvVRTUBphMlrrRT8FozLoSvz9t2mrhTTJpBBOUHJ6EKWZlnNdBQAVJ
 2V7les5nDvOLLTZA2ICOmr6xDt7JsFX80yRAj6JCV3w66v+76hJI1STrDySzVaUWFpO2L
 /YyyO/4zd1Op00CM/RUmY/iZMBP/n+u/lQooANU7KyG0bAOFRfgWzTkWizhWbQhQJoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488373;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=t7OcByN10ucOCPnaCtTDYOQW/SPYp+ASHacUyDP3Vn4=;
 b=YtIt5bSm1lAJOiDQ8LgAiBRR3pp8YRYXafGcryWEwLV2HLM/iTDtO8CUyfwN3t1+TNA0
 HeXoAstZpmjZfuccsSpOQIAJL0S4uyYdrHXMnvDXStHJDg3CHu0KZTowf8ir0RcK3Hjnf
 B2Yl3QCKbDM2ommqQgScoAbQG3YQ35uZc+Dpxm8cNs+d2s/v217JRUqTLIFMWBGRjbW//
 G2JQ9u7tN9WJRZaAf9GcZ54KE3UsDqVChuLfw0V5xfc5blMyRQJqF0CCqmE6ckekakNBv
 oowCa5dkvvpH/WHW2eFVWwCKSLEO6AZrrpTfc/u7xN9x96u71EgJ57QdmPtU1X+bqTw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EMzczQEl; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=EMzczQEl
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47F8D60830
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AFFAF43AC2;
 Tue, 20 Oct 2026 09:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9051F000C4;
 Tue, 20 Oct 2026 09:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488372;
 bh=t7OcByN10ucOCPnaCtTDYOQW/SPYp+ASHacUyDP3Vn4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EMzczQElZakhg5u2Hemw5qnZ7N35xRKhdgJpwm+jv/N9LEDAhkTDxYJns3OV5lofu
 fToBQssWuLyORmKWIAN+oROFPIXgn3MyOdy5y1txMzW5IeLEzmWwycVfjhNvxaGkzV
 z8GzRu+iKEwcRvHz9DYXKvlMi4epIrjwNUcZOiaMXvno9owYLXjmQnAVygDYX7E78K
 qz1tLRzSRIknSKHcxi422/ltKwMl0IKS9crCwWlrjWMoDrbrb8YG5dwm+v19HXRnha
 50Vi3ZBY9W5W+YvXSlt9fYmkm4GSXzMrkCFmgUmRO4aWuF9MptXV+oGFNB7hobSR3+
 7PzdntvynzCwg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Tue, 20 Oct 2026 11:25:50 +0200
Subject: [PATCH v2 01/10] avb: Use map_to_sysmem() for flush_cache()
 address
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-test-avb-fixes-v2-1-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
In-Reply-To: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=hXG7Yi43/x/Qj6hdDzu+8LpSHpbXxWDSq2N0tyvKl0A=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq1zOu2oX7rrlJv4KN2OJNSaK3olfHBgg2I7BDX
 s7mw00JzLmJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatczrgAKCRAZDR20Zk4Z
 NUc0CACW4y5n2VZ0H3wANz7X98uZ4C3CTc+6PiQZnbI1sNcUtd3kVSoBCDXzlRk0AG45hSFbBp4
 JitPkBOqn5QEMoZ4vr7eBqLEfZmRG2saDm9LZSQW8sbNXKaRlc6JS3ViXO4y2SsMswCgVyWlQ5d
 Vy56W5UfRgEbQYYUy2G4qqSfiu9MyCOMo6vCjvgHHkQ3USmw6PMQg0kciDtUh2dAfNoCLq03e/X
 w6sI+XZv0oOnlXtPabFnElJUWiLPvQq+vuQbeFWUWy4E8WjPfIT0tpbghn4xzutR7VoRvVWWkOk
 cry6Rnf3uE4jmg4BQHZ8W09ZZOVvhpQa/B/REBLNf3rOMmE9
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

flush_cache() expects a U-Boot physical address, but avb_verify's
mmc_read_and_flush() passes a raw pointer cast to ulong.
On sandbox, host heap pointers (e.g. 0x1a27ee70) can be outside the
emulated SDRAM region (0x0 to gd->ram_size), causing map_sysmem()
inside flush_cache() to crash:

  phys_to_virt: Cannot map sandbox address 1a27ee70
    (SDRAM from 0 to 10000000)

Fix the crash by using map_to_sysmem() to convert the buffer
pointer to a proper U-Boot address.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 common/avb_verify.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index 09f1534c3cc5..d157adc4af07 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -7,6 +7,7 @@
 #include <blk.h>
 #include <cpu_func.h>
 #include <image.h>
+#include <mapmem.h>
 #include <malloc.h>
 #include <part.h>
 #include <tee.h>
@@ -346,7 +347,7 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 	blks = blk_dread(part->mmc_blk,
 			 start, sectors, tmp_buf);
 	/* flush cache after read */
-	flush_cache((ulong)tmp_buf, sectors * part->info.blksz);
+	flush_cache(map_to_sysmem(tmp_buf), sectors * part->info.blksz);
 
 	if (unaligned)
 		memcpy(buffer, tmp_buf, sectors * part->info.blksz);

-- 
2.56.0

