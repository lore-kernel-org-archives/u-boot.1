Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F2606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ULUooZEk;
	dkim=pass (2048-bit key, unprotected) header.d=edm.sh header.i=@edm.sh header.a=rsa-sha256 header.s=protonmail header.b=KJ7aoWjd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5C2E40AD2;
	Thu, 12 Nov 2026 04:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rlUW9q0OhL9g; Thu, 12 Nov 2026 04:24:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B301640AB1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794457479;
	b=V4lLe57bYmbv80CFSvO04Fl6gKb4bQWGhpMYG/KRyNPl9tM5RLp9WPCutpmHrWun+QWW
	 V/hz5hVKFZCngnAQuVo1RAATAuEYhdrcCMA3h/4P0jGp/jDrntdXknraCkXcGilVfOp+U
	 2em0asUSmCMAxsF93QmpazlMPoh324H5Qvo4af7CD7mSicvf2vsZ7EUDk6tot3I7qbF9Q
	 HFr1BDBpuIVcAI+k8MbQoYK+hUvWrf8mZSNVialDZOQotAhdmiX3XJNP9XMkCd53LndhL
	 mgS66WGQ9y79n4EIdBZKfWIVkxps4dLRp2nu2YlhP83aZ1J7NHOD7MjHlBVhaZhvo7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794457479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BhERCUB5Z9hn5dC7czbGCa9749yvWElRD1ogv09yAVU=;
	b=JE2EVUAQHiAoNwVzBzKrIbtjnmERJks7IJF4D73XVu5MvIW0aQhWSgOl1w2CERDeYL+y
	 Kt2/VBMpBex9RjmpQSYowcJ/8FXWTZeJpCUP3QQ18ofol5/0BkAYnn5izta2av1039L0R
	 AUhpTsVJtU3MiClSt4pDM63M/cQWHjmfYUDOzgT0g3dC7j+gET3qP48vNKwWUcBgALExG
	 Nmqsle18Juk+rF9hM0DXVzaSqXkc9v/yezn78OQ0ohgHesygDXpdNaRaa3/821vQdUFVj
	 qiW68aTJufFWTBbcuGi2ST3OCi0fyiPbT9oZ3fvuQj6JokOX5rnMfnukaID1lZkA5pg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=edm.sh;
	dkim=pass header.d=edm.sh header.i=@edm.sh header.a=rsa-sha256 header.s=protonmail header.b=KJ7aoWjd;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794457479;
	bh=BhERCUB5Z9hn5dC7czbGCa9749yvWElRD1ogv09yAVU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ULUooZEkkwAU3OZuhll5JTgR4wYrEtjL2HMbit4FhDiKueVfx+DIMFIF7CInoEnY4
	 5p4dQHm0ULo/GEdgx8/VpF5D8WPu6ywONE6Nlxh2yLfd8DOk6y8gJCk1WDxYn7u8qe
	 TpFy3wCWLSYkyjSZeln3bI7YFIkhGczCcaVZuO4pLCrRTRMULGz8Q59Uc1qYhoiFMY
	 Jo6iSLpuCi8vQ2YMIz7yjGQmUqX6HUeVAblje6j68xoRDHzuITLAJyQ/3juPStbO5m
	 MV45IzvT9vwk1EBKpbUvxdCSlmdm5C8hSPsEggOjabNCPPOHIcA4qXe/QT2PNm1JRf
	 v9yj5/0YA/cwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B301640AB1;
	Thu, 12 Nov 2026 04:24:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C35A91A6
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 02:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A906840AAF
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 02:20:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D-EkNhhi0Vmu for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 02:20:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 033BE40AAA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.105
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.105;
 helo=mail-244105.protonmail.ch; envelope-from=me@edm.sh; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=edm.sh
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=edm.sh header.i=@edm.sh header.a=rsa-sha256
 header.s=protonmail header.b=KJ7aoWjd
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 033BE40AAA
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 02:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edm.sh;
 s=protonmail; t=1794449992; x=1794709192;
 bh=BhERCUB5Z9hn5dC7czbGCa9749yvWElRD1ogv09yAVU=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=KJ7aoWjdn7ruCdcEFpQn/zNsKSG2tqFK5EcfTZH0za04kcEO0TbZQ0Dq5Tg3F3Of1
 Unr1mSn7wlyAQjX8SfuUGLGkiUPOQGyl4c5mxgcqzaFC0raE9cF6fFqC3ev2qan9Gk
 zVICFYp4H9lOUOPVIn7acQMtEM768koBl0Y0ukRMc+AhQHBMNZhO+Wenh1jWAG8MfZ
 Iq/g5JU0PJuv9gxh3wkuah7cIxbezp4bCqXl7VFSRhMWpgkUfFZJg6sJFJCGwHY3iL
 l17bevsBZDOaYitQeJpo/tXv6/L3h/+hQ9u6mJuXnuyOlZGjb1MHg3+J+dPtnKWTB5
 ANJqn/9ku+uQA==
X-Pm-Submission-Id: 4jQ3xc6wrBz2Scml
From: Eduardo Moreno Adanez <me@edm.sh>
To: Andre Przywara <andre.przywara@arm.com>,
	u-boot@lists.u-boot-project.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Paul Kocialkowski <contact@paulk.fr>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-sunxi@lists.linux.dev
Subject: [PATCH] sunxi: a133: dram: fix DDR4 MR0 to match the controller
 timings
Date: Wed, 11 Nov 2026 18:19:45 -0800
Message-ID: <20261112021945.71942-1-me@edm.sh>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 04:24:36 +0000
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

MR0 is set to 0x840 (CL 18, WR 18), but the DRAMTMG values in
a133_ddr4.c are for CL 13, CWL 10, WR 14:

  DRAMTMG0.wr2pre        = 14 = (10 + 4 + 14) / 2
  DRAMTMG2.read_latency  =  7 = 13 / 2, rounded up
  DRAMTMG2.write_latency =  5 = 10 / 2

Use 0x520 (CL 13, WR 14, DLL reset), as boot0 does with the same
timings.

Write-then-read tests pass with the wrong value, but copies corrupt
about 300 64-bit words per MiB, so U-Boot hangs in memcpy() and TF-A
takes undefined instruction exceptions.

Tested on an Aqara Panel Hub S1 Plus (A133, 2 GiB DDR4 at 792 MHz):
without this patch U-Boot hangs before fastboot; with it, 16 MiB
copied 12 times with cp.q all match.

Fixes: 7a337270c076 ("sunxi: A133: add DRAM init code")
Signed-off-by: Eduardo Moreno Adanez <me@edm.sh>
---
boot0 also differs in MSTR geardown, INIT7 (MR6), DRAMTMG6, ADDRMAP1/8
and SCHED. Changing those without this patch still hangs, and with it
they make no difference here, so they are left out.

 arch/arm/mach-sunxi/dram_sun50i_a133.c       | 2 +-
 arch/arm/mach-sunxi/dram_timings/a133_ddr4.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-sunxi/dram_sun50i_a133.c
index ca3e2513c69..b5ff6707571 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_a133.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
@@ -754,7 +754,7 @@ static void mctl_dfi_init(const struct dram_para *para)
 		mctl_mr_write(MRCTRL0_MR_ADDR(3), 0);		/* MR3 */
 		break;
 	case SUNXI_DRAM_TYPE_DDR4:
-		mctl_mr_write(MRCTRL0_MR_ADDR(0), 0x840);
+		mctl_mr_write(MRCTRL0_MR_ADDR(0), 0x520);	/* CL 13, WR 14 */
 		mctl_mr_write(MRCTRL0_MR_ADDR(1), 0x601);
 		mctl_mr_write(MRCTRL0_MR_ADDR(2), 0x8);
 		mctl_mr_write(MRCTRL0_MR_ADDR(3), 0);
diff --git a/arch/arm/mach-sunxi/dram_timings/a133_ddr4.c b/arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
index dec208e22df..359b11aa42d 100644
--- a/arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
+++ b/arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
@@ -67,7 +67,7 @@ void mctl_set_timing_params(const struct dram_para *para)
 	clrsetbits_le32(&mctl_ctl->init[2], 0xff0f, 0xd05);
 	writel(0, &mctl_ctl->dfimisc);
 
-	writel(0x840 << 16 | 0x601, &mctl_ctl->init[3]);	/* MR0 / MR1 */
+	writel(0x520 << 16 | 0x601, &mctl_ctl->init[3]);	/* MR0 / MR1 */
 	writel(0x8 << 16 | 0x0, &mctl_ctl->init[4]);		/* MR2 / MR3 */
 	writel(0x0 << 16 | 0x400, &mctl_ctl->init[6]);		/* MR4 / MR5 */
 	writel(0x826, &mctl_ctl->init[7]);			/* MR6 */

base-commit: 8c1ea2aa66386fa3c8ea829531f581847814a569
-- 
2.55.0

