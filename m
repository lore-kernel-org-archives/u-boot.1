Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D224C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5E5540BDB;
	Fri,  4 Sep 2026 19:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsK_epLmz-96; Fri,  4 Sep 2026 19:31:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 988C040B6E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788550281;
	b=tDz9XVeruqpmfnqFgQ3yj3XiYdlo16KICQ0DIOgSA3DmDY0yNOcwASB7g0RvZVJQ8rEs
	 uRtzucwoJyL6Y8XXDwue8GkWyrKBOTq6diiNmjhWPUgu0MzJev5WeNeBifC8RI/vwiA5U
	 OnNfTz5TfIA1QGOoigOwn3lOfur1uxmrV8BJZk76Tg+R8YRvnvPXBZ+hJ8RL4AHAM/Xp+
	 CPXOsJPk9fwuG1TE42esT0s9/K0zZq2zVTE+iPzsC2p3cO0bfL8dSswwbXZ0jRanNxVva
	 R0CT8DJCxps09RsH+75R6DYeXi+/AtLbcrlMMRzb9ytqzja/DKxbRrQ1IrKXb/bJlrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788550281;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2EnhbLg28olLwFCMGhDnw1SXOG7+j1bsKN7T2RPq320=;
	b=XyuZfUC/YsGG283KEUmqYEbBwdpnPzxvlfIVAzCD6YRA/fsQklgwhpdxYRA5oamWnz++
	 CLBSiz308r0MwqIyefcLS6HSIc+X3t9pHcN4qzUlYkdM5I4/Z7pWJxD72DqkGDCr8pVZm
	 /DeIB37+nebK2cwZ7tLmrN4frpM+HjOcAentRHMIMbxgsyVggn0VVKFwn0tszVcrXPAGQ
	 FRh/VafddhQzETz0u1ZmdwpLQ3/gxYWRuh3SNh3RSLOvKqV2SU8VqdeFSswGqQ1CojNLm
	 ef9ePcXJBP1HakuZ8Ze3JsbpL/aWrJKgmf/TexYigopO7YY45MGOgiojXtYwkk7OGGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788550281;
	bh=2EnhbLg28olLwFCMGhDnw1SXOG7+j1bsKN7T2RPq320=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FwHM/uMuXcva9xhFPVbP+5MgKUchb4cxdlGVaDvVtwo8Q3/i+YlJH1gzI8B2eAz69
	 KcqOKNSKogfHSECRuTG9XJ/17745HT4YwyTFjORcwx5yabvNKsaO679OIxqK2WtBj2
	 1t1oZaFHtPPkY/ljbZMzi2Jgoq5+8IK/VJW3QZNZ1FclP9ROrzRHs7hjLd2uAiRvne
	 zIGK8LX2zO/0Zbz01/IEg218dyUQIMNS6FgDTRm+toDcABU5U2DNRRtVVmz19sgHq8
	 RWgoWxMO6IMlyxS1hkrAZ6yb0oq9UG5kyF5C/bDQ54sH77Haji+BTyWeBC5s8p9ajM
	 YSK5Y850zgJ3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 988C040B6E;
	Fri,  4 Sep 2026 19:31:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A18C747
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50318404F9
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LD08BFYZv5U3 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 19:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E503F404F7
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788550273;
 b=VT+1chkD0PDxh4041HnMS5pyTqkF5M0XLECVcP4GOXzqzt2bK3vukXuApWfRP1kwczkK
 YWJzaaNNgYgk3Slgt6CYHINdAiZ6CaPRRPcCpxPFWd/50t7rCnn/bcuJ9ZU9yznAcdoax
 toDysYBAVpnGsSrx4/y281Oq/lwOG7NU+uFuchgZKazNVWaZZsJ0Q1yaoDZbnXuYXKRrj
 rbQJFD8jBHaNKnjCE1wXa2SgfVM2wAZP/mlGC4jwJIbVvLRpj4dX01vb1g1tNfJsrGWkG
 klzgFo/AKgSnHdl/UdUGb0Lau7BxwkoSL2Xq/HU0vP9HXFG1wXajVDnRwLh7W/Is3AA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788550273;
 h=X-Greylist:Received-SPF:Received:Received:DKIM-Signature:
 DKIM-Signature:X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:
 Feedback-ID:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=2EnhbLg28olLwFCMGhDnw1SXOG7+j1bsKN7T2RPq320=;
 b=W9VWipYhf2ryreixkf9eZw2QtNrn+1BDOlHeS0a8t90A6QODz5DuP3FxwRElrLNvpBhj
 V47jyjC4CuK8khpbfvXhdgdldNzUkPB1wfDYIp9UpBuXd8lyfZH8BfxP+tIvZVtSU/qu8
 bR+dZOiUVrI/vT8PPVpnHntL8wsCNwjrag5K6BAeJmW2W1mkSO2EMdolExYW11my5TRfo
 izlSi5AwJOUwWBl9vrUpDD20cJvEaY4FktuDPWl2VszX10dBel/oB9uCtWMx4cl5x02ZF
 auJPSxXVqSfsFIXXcq78fNb4T7Fk8MwXGMifQVmwmzREuCYiktJUmoJ5ZMyf8HHBg1w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=jannau.net; 
 dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256
 header.s=fm2 header.b=tZjSDTAV; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=jTnBVwyS; 
 arc=none smtp.remote-ip=202.12.124.148
X-Greylist: delayed 494 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 04 Sep 2026 19:31:12 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm2 header.b=tZjSDTAV; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=jTnBVwyS
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.148;
 helo=fout-b5-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E503F404F7
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:31:12 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id E000F1D000C4;
 Fri,  4 Sep 2026 15:23:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 15:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1788549782;
 x=1788636182; bh=2EnhbLg28olLwFCMGhDnw1SXOG7+j1bsKN7T2RPq320=; b=
 tZjSDTAVNsNCTkk34aUsDYlFG+p8Q7VHI67LSW8aOoJe/K7gbKmC1JbLT69VEPRb
 2a0UdggkgRr0bYpBq5Tk1ii3YJerIQ1q+UP/DZBRXvkLQdDlpkT+tzdnSBRuiCS7
 qCknGEG6LlDQ6kn9++6TiPJI009tlcbX+JDdV+panMd4C1Dv12COnBoKk3SgIz18
 c1DeTDDyFiJGD6NMyxeLzpdwHmIDav1Wb+2r2tyZT33o6/iDczjDuD5xoXEfSlke
 FYTv47N0QVDmpyBI4fUFkfTMuCIeydm0MepL4WJo3IfOrtkIddOSOw/yUouNQOYj
 spvTeSMojCDCSBWYZ8ejRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788549782; x=
 1788636182; bh=2EnhbLg28olLwFCMGhDnw1SXOG7+j1bsKN7T2RPq320=; b=j
 TnBVwySwsHxoHVjrdqUcdUl3QG4AXxVYwmC2iYj+zhYUlMb4QujZkZs0JFgobxHA
 KgCLjwqVGOhNEFYw+4tTUQ7opf5LCQ1/iSzJ0xP763/nQEVb1J3Jjp9Hq+tLd5qH
 TXchn2Jj2yzt2dgQ5mnfzdiadsjMqnWh/83xEJ7gVvHodrBiSypmWCUh5dpjV8oj
 0ITs0FNKTY5monctFM4QQLCsXlHEZlsZX6+vSuLpGTw2Bos+rFwGRXRBn8Sriv3W
 pVZ9AzhVPwkvCvbPZewmwDEnlhO2r4hV9+dW7+71FRz3k0CDgbZrTHtIQDP+qQkD
 swSrIhlgRAPhuPQj4sb/w==
X-ME-Sender: <xms:lhqbarhC83qnYLLox1PTYP37KOOj_PmxrHNWJ_Etuhda9sY38XSkxg>
 <xme:lhqbas9tsQZaIuYRMEUPDVfLmwXw4JMzVacBGmwPeNPhKo88NlQ_eoUZ_kjvUDs_5
 trIxUof9vgJNzinLnFcQTDAgyHAJPSBqueiHZM8n9cz8Io1n2hwglh->
X-ME-Received: <xmr:lhqbavXqh4B4569X5STbkAL8H68133_78X617dnIQ0AT5HCeCaDFrtndgptWjv8aL80MKWyOQjkbVjjd-z7EYX7ZauRFVsojVy1jPQ>
X-ME-Proxy-Cause: dmFkZTFhLblgTp/RyFQl23C14rT0SEBDcNw88qFkG1Sjc//VwetKpmOdtpxYzmQ4HKpCRi
 WBWnCVMU2EGydlXKZXpN4GNFt4Po4D+3kDHVhKtDhcrmsA6vMw/aZ4CLxA5j0ad2EKcEfs
 SgNSkNyyQS622tAHjfnflrHQwlqXX8UQ539CSLwQKOb+S8QrnE+JnVdQQIAtSW9EHnZH+J
 aNzX4d/wSKpvcjAN04RWhdS+sJxOsdXy4Qem2t0VBqF/KObmyr/C5/zcL3D0YFqBmBPB9j
 zxTYbA2s4UrrRjKj0xA8M8I7z3kvPT/fbYJaDWqg0cwhkzJJpeLlqeJigRtHef77+eQAOV
 5S+ydIiEkPt8uv09ncpWQP+UMqT70VUo9MAiLW963vTUXVeYlal37hLGnaq+ts3EHCGi1Y
 LZxQHLjMjaLKem7/s9QCnoG1PrKDmr9nvChIOjaNnJXQ+20z/P3THjsg3VghvHTifK5VT+
 6j6Kr63egewiSKJ0jQAW9H3RVX+HmnwKyK0BPGG/LMhLNWXTXzylKlVijGyslEgOYDnP/e
 YxsO1hUNyQs1/5eZw5AGy3mFbf/ww/SKQsPdaHnvL/2yi5hirIUA2Ii2rbgm/2u7EH+Lz6
 ANLKTd+y+ENjHTbroWP0hNKR+tYSLkc1tB+o8Y/DrU7HlMgcYK7eyqhc8Bqg
X-ME-Proxy: <xmx:lhqbaoDedPgNLwShwXghkP3T5vSWnuhKC-Qs0-FbWQdfSed--VMKBw>
 <xmx:lhqbasG4sLBNFVXh23iTckEzcpXUZ7lgyrOdmVtxrK-RMnOxSuwCJQ>
 <xmx:lhqbah738yjK_oUS0XUyfBR2XHiy2vFojnh57gGiFPO79vTLq-pIog>
 <xmx:lhqbaqlkM-crlNRjYKQLhF85jTdPE6HALX_ghfwvpQvsvh68-z35Iw>
 <xmx:lhqbaseNOeLSDCxdhGEqtVOJE_lg3Vokragss2umAKpTpDRHZTvDBUr0>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 15:23:01 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 04 Sep 2026 21:22:40 +0200
Subject: [PATCH 2/4] nvme: apple: Never set the opcode in the NVMMU TCB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-apple-nvme-fwabi-v1-2-f7ede661c469@jannau.net>
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
In-Reply-To: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>, 
 Sven Peter <sven@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=0Mb/9G2e3EzKSZGS8ToiCmejzefFnnR1b8UnmKRZyoU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzZUr2bJ7Svyfz4viP/1RVx0YqNql8ST9ftjjz7XGiy4
 vUrCnoXOkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExkix7D/+Qiq/ONM1+1plcn
 XQj4q7VXXHrpj84r/Vekpv5wrLG7YMHwP+tj/8yFJ+vfL9q+b7tbysGERye1xO7cEpB22pq97mD
 JKRYA
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

macOS always sets this to zero and the firmware starting with macOS 15
has started to complain about what we're doing here.

Based on Linux kernel commit cc0fec9b42cf ("nvme-apple: Never set the
opcode in the NVMMU TCB").

Link: https://lore.kernel.org/asahi/20260806-b4-nvme-fwabi-v1-3-bde19ce8db04@kernel.org/
Fixes: 50333c94f2de ("nvme: apple: Add driver for Apple NVMe storage controller")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/nvme/nvme_apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
index dc94988e2ff..f615f8fac4a 100644
--- a/drivers/nvme/nvme_apple.c
+++ b/drivers/nvme/nvme_apple.c
@@ -121,7 +121,7 @@ static void apple_nvme_submit_cmd(struct nvme_queue *nvmeq,
 
 	tcb = ((void *)priv->tcbs[nvmeq->qid]) + tail * ANS_NVMMU_TCB_PITCH;
 	memset(tcb, 0, sizeof(*tcb));
-	tcb->opcode = cmd->common.opcode;
+	tcb->opcode = 0;
 	if (cmd->common.prp1)
 		tcb->flags = ANS_NVMMU_TCB_WRITE | ANS_NVMMU_TCB_READ;
 	else

-- 
2.55.0

