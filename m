Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1C7C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28B5340B87;
	Fri,  4 Sep 2026 19:31:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUKLxhHbzgoL; Fri,  4 Sep 2026 19:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 625F340A76
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788550275;
	b=e7MOe4hIrS+8f1Tq1QzeC/UAIFysShU76pVhSTETerQ2KW12HnKlvcCGcQQWeDy3vpPp
	 Y5YAlhIdiS7VdyUFd4IBtSbgQGw6JMcKCmmkf0PJLrkTRVSKunbTvMhS7L7GhZK8V3A37
	 fcYT+xwwxfRGPTBp7UPr5+qms3J5IsKYbP2W2sZRprfzATOCMI5UPOgaV3QzMenKlURUE
	 W8PV1bHxH12KCiPilSjVd5W9vU4ixUfeUqvT9x6AS6wgBrkWs8ql+v4M23FQlGA3yCPOt
	 C9z2hez37Sn/TQtXXPYIx0SFihM0RcIUw+IsmuA4y1zFAtpH65CWarMEDpDnfrwSA+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788550275;
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
	bh=uS/UUjgYaEFVQ2qhzZuj5UG9XAwmjHiYic6WkzHF+TE=;
	b=K4NJKPJb1N1RsLf0uoZlIud4gm/yG8iTUc/zX+5SFCCsDp/CIySLdQLIIqOj/cyh+NTZ
	 ZE8dRGAycLUzTjqAtzIZOAE0gQATY3UYsDyCkhvpS0bBmTeAAonVnj0kZITOJ5k9oL76q
	 O4qgH6Feb3gQ7zsNJ2+QwZ8GKhooBSCY/mSWTbzWyr+middbUCEZueVSJ9Ch36tySkxw2
	 tpcpaoOcZiHbwtOXxy6N/EZjHPmV3X7fdcf1Ey1bhl1gdgTaF3YQELueT8mUz2zk6xq24
	 3Ujlo9Z9waFlAI/sGXFREKfKgykLGIXSaE4fM/5XsrYaY4V4AJcCTxcnikqc7Zq0aYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788550275;
	bh=uS/UUjgYaEFVQ2qhzZuj5UG9XAwmjHiYic6WkzHF+TE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JOS/Tqt9sPGVTdxZAPfqdk3SECRlhK1PdeC5jgk5zBPTu1hn8DnHxe+qdF5FQ3QhL
	 BFMEljZ+DqGCyCuRrNj1hH1nDj3xD0BgKR5Tm97OL0qiZ/nek2wKVAuUUQHqnL+Rsv
	 xWcMaSCcRGnSBJhCr2ElCmgGC5nGTiV+DLfzcBr7kxBb1/WjN53OVOkVr4C/Bc12of
	 84+mM4hiH9yb7NY5n7T/GWFr5AMuewHmI2ZabSMCHqywKbeKwazxcq7eX3iDftOZpr
	 Mo09hL6MqTf/buo0MZZTSIYmMNAX43TjjLLaG2XrgU4/t19MaONZs/75x0EHEQPBn1
	 4RwgyUd42AJkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 625F340A76;
	Fri,  4 Sep 2026 19:31:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 32195724
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23FDE404FC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4NktxaE3w_tU for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 19:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0D0BC404F9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788550273;
 b=PEm/E1Wu7lZTsJCk3irFrROibFl+VFgEY0zknH0n00eddX4+Cr6JsbaxPUdi8hVeDtfs
 EEh027Hhrz0dI4qRcgOSdzRmRPQDQGoW7N6cXxwJdAghopAbQTHYDrySVmfB22Vbh6tsj
 29uM4Rzl/weX/9Vee9SMqc62qsTs5J8BfoPtSz62ZCh8fSbYn8rKsH6g+7ZLK5QBVJGKN
 dZVNRuklh6hU3V2JFAAiJjNopyNBW/xJ3YUzH56CRRA9uhOvoMDHVb6KrNiOOofM6c374
 ZHKCwzDU+TCoDzbFNsHcJ5tYc2415eh+aR2N3JcasSPLql/yh+NBPlNW3xaWC20//cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788550273;
 h=Received-SPF:Received:Received:DKIM-Signature:DKIM-Signature:
 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=uS/UUjgYaEFVQ2qhzZuj5UG9XAwmjHiYic6WkzHF+TE=;
 b=lAmHqgcqx2bztw73KJ6kV+MnskAbHT6DFgixlIAz6RsHs/IXQXGxgG4YZwzMQBn+UFSF
 YljhWX8g0VMvq3zdbqi64dPwoszHjtCMID8v2deeMwji1xwCffLGsTfAF3bT4Pp8j+VVB
 tpA/rbAB+4y9/8e7aJbkwZoZxnPbj+RZM8SnhKZ1CVLhvMON1aVLSzbHmshIJlnnzkF3z
 hcq5/eUOXy0dURkAPINuMBZY96twVQZuhjQUkUvV8rUg9YciQ+lxEKjfTFRZcP/lghr+n
 THbqXKCHYbqvnnFbEl/qdybeT6eQ+rDR6l10c0kzXxGXZmsmTCBcQyYRY96W4kVORdQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=jannau.net; 
 dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256
 header.s=fm2 header.b=UeaDHh1q; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=kKeGTNZW; 
 arc=none smtp.remote-ip=202.12.124.148
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.148;
 helo=fout-b5-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm2 header.b=UeaDHh1q; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=kKeGTNZW
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D0BC404F9
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:12 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 32AB31D000BF;
 Fri,  4 Sep 2026 15:23:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 04 Sep 2026 15:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1788549785;
 x=1788636185; bh=uS/UUjgYaEFVQ2qhzZuj5UG9XAwmjHiYic6WkzHF+TE=; b=
 UeaDHh1qV8SSBvgRTIkmEIvDYnlrYK653yGTUsxcAuVj185sJ/QnsifYXG9PJkIM
 OHTVMQCIZbrRbBFpbpHgUEy9t0rOjbhNP7IX6PlR1pvfRTFsyf//vRn6VJkMCSZr
 xZ01s6VQTazsM/EULS+m7DgHsYMnPbNROqtyQWS9Pgh/5WqOGkKqH1+X/tYPw3aA
 5ZKV6Bt4I2gTp/Cek6ot8j2pU3mqC/oic7WItOl/3Hx/3xFFJjufLZtLmr/sZFmn
 bujUpZxjhmLvU1dQqftoXsjJqxnuYWdFXo2rwoa4tCKzq/U7kUQ5rzGokf8OwyHN
 QYqgwu0Dn/sZN6xMrEJ4uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788549785; x=
 1788636185; bh=uS/UUjgYaEFVQ2qhzZuj5UG9XAwmjHiYic6WkzHF+TE=; b=k
 KeGTNZW0XT2A9IIuYr4c6km/RBMX4N1qkoK59gVtPdha9MQSaa+QP7BjOAM6NMsW
 mjJa3dCXdCovPu/FudnY36teOEBNEk245Y8e87vLT/b5dM5FXbr8ACU5N4UBa/hc
 7AQfnqM+xM1Pkf/xmJ1iejKnwnhJynmJpV3Ji8rbdoZ6KzWo6iKlFE9tXiTrZI62
 C2uTh/lJXayBfiEoCg2JrPhkifKLt7FoyVA9Ll8JnpLsULDcyXNV0FCQkRcFAxBq
 xyBez/L+pr4fN4tb+p9l7yZtxkuAY4xp37xULOJcJM+0SQbB43OJSS4rSQHiMQg+
 XiP/wRgTaWzUWasyxu+Rw==
X-ME-Sender: <xms:mBqbammbVidbImeAA3tMP2R9r9WqKYgcCrmKlnqMPKVG-VDanK2sCQ>
 <xme:mBqbaiw32e8afn17GOIBLqFZfbXqksLa7lFj4pfhbtT6vKyu1TbJ10S4sRMa2COGC
 TnthYiyVmFJn7uHaP6TVvBbWm3hEzao4aJf_SrTni791cXLhDOgdwQ>
X-ME-Received: <xmr:mBqbao41Hs3rlFuctxahHvwODATLu00-ZrYdOevmfe0zSWyPoVUVdvwatJtVw6oV1MmspHTHKpqBBWjnv2WJOoSllypvwmhMk9QHTQ>
X-ME-Proxy-Cause: dmFkZTFbtEfAjjlSVyltyqEEyjJV7S/PVuuOhMj29l3ycoAQaU9HvbnRmvm9Wexk6whG/1
 JijmIqGyHbV2w1aV9qTQchVDlW5U8NVbtrcqa805BzandVH1kzwvYWbCyPp4h3/oRXKNKa
 s6V+RLdaEBpcRsIoLrCTrFC75girfJndXs0UAB17LcixOiiNvuMy5JAPaFoEFTtzRNFCbD
 5o3/z9N4+CKp6RMaoPOjOqXztQRIYmOF8GNbfy0kw467QXJGgFwvYkkbD6CNrGZ0PKd/0J
 sq5jrrnjuAPk5+yuJQfg4O5ZxDrR5Dp2iYRP5aswkWYF9urjMB/RFzIziYqOZcyLGeLyZF
 1/SciHGpghrEYdqFZ7T2QHs7JQoXcKl9nuXhzThuFsNsSwWjSCy3WwL1Riey1cBpSNlpwd
 TPdy7KaW2Xwkd0ssyoW9hqSOfxkYk1fjCuukwuVZVT5gqorL5QqJWVK1L1NqI+kbkDEDAP
 7DSrk2AQhL3FpgtuhaQtofq4enl2mte7Sw/+IoOYvgSwMh2RKryipoTaTK9vxBwmeRW9vd
 fmTkhcem//K3Ud35BdCTtpcU8ptpccTxbxyij4BZ53FZpkKc7AKR0fFtLz0Y6oRJ+Z2xn2
 c+3GcMXAbJC1UxIYa5cuKySlfqNZIdrgpaOJKKRDM4sUh9Wv3JyjsqEquehg
X-ME-Proxy: <xmx:mBqbaqUXhA52IdhjH6zWh4g5PaBVeK6k6fvNntLoWnRL2bmXBmNhdg>
 <xmx:mBqbaoJLn4ZNalkdTCBkAJ1VxQCdrfAOq7wnwB577TsEuTnx-LOqXA>
 <xmx:mBqbakvZTT-Zc1dNwa9tojhP1x0W0E-qfj-CYI66TURm5B-cK2bTGA>
 <xmx:mBqbatIfKbQhxUQVPwaXwlfzNlb_AZ-Q0XE1MPcI6Qf178hgAXb-Pg>
 <xmx:mRqbau9muO7-_W4xENTDEf5K0zK3OU4gQZ0DI9pudyRwksHPMXf9VxF6>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 15:23:04 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 04 Sep 2026 21:22:41 +0200
Subject: [PATCH 3/4] nvme: apple: Add WARN_ON_ONCE for non page-aligned
 admin queue buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-apple-nvme-fwabi-v1-3-f7ede661c469@jannau.net>
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
In-Reply-To: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>, 
 Sven Peter <sven@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=GIP9VgmWisWa3ANiOcObKuUXynxr0KnQdJPrclY8ILQ=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzZUr1/eQX5RML+5r81ct7Q89I6pv5s1+o/B9s/beTeL
 6nruEimo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwEQi/zEytG+rP6yzX/ORdmt3
 9uSznGufb77zN/DTpEamfcb77Bqf72f4Z72bo2zrrfuTss9ZdlxLs/Rf8PhgHtvVqS+nie69a55
 swQwA
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

Apple controllers seem to require any queue buffers on the admin queue
to be aligned to the NVMe controller page size. Weirdly, this constraint
does not apply to the i/o queue where any alignment is fine. This has
always been required on pre-M1 controllers and is required starting with
macOS 15 firmware or post-M4 controllers again. On M1/M2/M3 there was a
chicken bit to disable this requirement.

U-boot appears to always use page-aligned buffers for the admin queue.
Add WARN_ON_ONCE to make it very obvious if/when that changes or wasn't
true to begin with.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/nvme/nvme_apple.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
index f615f8fac4a..54821f80c81 100644
--- a/drivers/nvme/nvme_apple.c
+++ b/drivers/nvme/nvme_apple.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <asm/arch/rtkit.h>
 #include <asm/arch/sart.h>
+#include <linux/bug.h>
 #include <linux/iopoll.h>
 #include <linux/sizes.h>
 
@@ -116,9 +117,15 @@ static void apple_nvme_submit_cmd(struct nvme_queue *nvmeq,
 {
 	struct apple_nvme_priv *priv =
 		container_of(nvmeq->dev, struct apple_nvme_priv, ndev);
+	u32 page_size = nvmeq->dev->page_size;
 	struct ans_nvmmu_tcb *tcb;
 	u16 tail = nvmeq->sq_tail;
 
+	if (nvmeq->qid == NVME_ADMIN_Q) {
+		WARN_ON_ONCE(!IS_ALIGNED(cmd->common.prp1, page_size));
+		WARN_ON_ONCE(!IS_ALIGNED(cmd->common.prp2, page_size));
+	}
+
 	tcb = ((void *)priv->tcbs[nvmeq->qid]) + tail * ANS_NVMMU_TCB_PITCH;
 	memset(tcb, 0, sizeof(*tcb));
 	tcb->opcode = 0;

-- 
2.55.0

