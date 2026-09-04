Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABE7C79F85
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6971A40B99;
	Fri,  4 Sep 2026 19:26:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D0-2j2Ur07_2; Fri,  4 Sep 2026 19:26:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AFFB840BAB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788549980;
	b=dSk/LZ7M5wyeOKxGZzzF1Tubd5gjOKZkL2epdv5pllRdouTdZ06U0qNtHOhfZ77FjTVu
	 fqb/hzqUqjwXqJ2fQI2PF2W2WrFXG4QHrMrrn18JgmGGSz1bfkzPjT7fqrnSy2NZ+p0pv
	 cWRyfnoSoyBWE6l+AgwuMYb2Hz4K53IZ/ATSQ8MjLlzgox6Er/MuHS7Hg1S1dq41p5+gK
	 WuxBzIoEXhgParU+6FqTMnx0a+16GoYsiidKcQK76tCe208KUrLUsOQwyerhp2yQ+/u50
	 R5hoyjl5p9O97j/nANAqdc+7XVzTJie3fjP2t+e7qplAkPrST0NQ6ZQ0JSV6FTP+FcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788549980;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RcsR9enS2P+JiBcTIAIaodLwMcMDFaZc1R5FlZRtCOo=;
	b=MfKfMpwF7W7yJWQpXXdJ9MkNe7K8yOTS73MRw8cDZLnPnEO21gii80GZBvI9DRtl7L4q
	 vF6B9Ov709ypo6jsl88P5/Pg/pN8ZvEK10cJr2hJ/URO0XzMNg32atwTuvM1S+JJhRqtf
	 1M8L3mfxny0gilvI9bFX0oXbbxvL36goED2v13si3PYK5q1DkHXY9Z2vF1AZfQ3enW5Jp
	 GtEnEdmgsRHbPQ5fVRpocy4xFu0ijs570ALPgn9lRJ0EsS71VRn6+7ULEjBcMy6MsHcH+
	 C5PPHGZFGCBL3qQ59Y5NTu53P03fsWaT4yc5JJXzbuBO7LHA2OAXdbf6uUccCjd7uvg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=iscas.ac.cn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788549979;
	bh=RcsR9enS2P+JiBcTIAIaodLwMcMDFaZc1R5FlZRtCOo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a0yPbbVsdfKaOolEHNhgt2qutAgKFGYIGuuJWPkwy8Tegad/p8VPA/Pg63FlyWHqb
	 B722yfwO16hbsI3XFPW/qXSH2ouIw2CCuR7OjNZBlEEup0FEmFBMSnG6OQhn0TmCoG
	 zQMOc/x9e0IFs9INnd/nevAjMvmnplRbrcYNxDx3Z/dsfuDi/dKnUTKNalb6vF1UaH
	 YZJtnuqlgYRX9ZDNQc28lONu8sdsQ1pwRLMJ0M+wJahwdlcpGWNZQqxaNE65ejntsB
	 lzuzAp184+hxSwj42TzOCKvli+5XzzUQbwF2MY9CgKTHU0kfqn4OLeumEpYhbrHN0k
	 Pbc7YjzztJrtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFFB840BAB;
	Fri,  4 Sep 2026 19:26:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E8B4E3DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEA0240A8C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:20:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dD0k_mxGtcB4 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7DE1C40A61
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788528057;
 b=qem3A3NWKOud+UeCrDBkMX8bB761Q8+7+r9vVfjfDQyFWMNxcdtBgs4FN30yCFV9p1Wc
 dX0pwW/9BduRStbe0QWeXwHqjwJXX6MFMEpySpRIFnr4oJOZcoVsMhQooDkLUOTPcYJcG
 74xJe7YJzz1fq+I+sUAeOqBZWxYI91bgrDjCSNAP8tiehazYHUKrA6Ye+TweQKgRCyJvJ
 On1Uz9wDJ3SQMXsmJhcCxVQIS0WuF0Xg+iY3Hcrr/ESD9V/cHn9sQSEus9N9tgq/pwpoY
 hTkTTc5lMFOrpAfrOgGetS/zsorUsqYR8UtrG+1GqzdTA2920bSLxrS0OukpJsezLrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788528057;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=RcsR9enS2P+JiBcTIAIaodLwMcMDFaZc1R5FlZRtCOo=;
 b=oxjE6kFyEPHUGFFGIJqx03fBtu3ExfaxOXGsDqBzQPEfG+g+Z0vlrRCrwMhSqZ5ehEgp
 6icpKm0H0DRNORP627OjVF2M+RzzcErq2KSgus68Q1Lc/gmDgQ0wcsEuWm7yw7i2vUKC6
 nm2ZVxEl1bI4f/t1B3bRyE0GYDuu1JktJBfPmU0iJIxUQFMzax5J5pD+Otupo1kOIJ07A
 j0+XPEzYMbr7RDGFLMhqWSeQB429eoEVdqY0PD68gDzdOB/0dU5fMa+FMRKw7RWIJ2yXh
 Je7t/y0gndCvUAUoju42FhVXuwxIHUMtHGujM3cDO0On3eHRLLHU85cK/muf7DJZPmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.25
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.25;
 helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DE1C40A61
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-05 (Coremail) with SMTP id zQCowABXwjyvxZpqEORYBw--.9042S2;
 Fri, 04 Sep 2026 21:20:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH] vpl: make I2C and PCH options effective
Date: Fri,  4 Sep 2026 21:20:38 +0800
Message-ID: <20260904132046.45008-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXwjyvxZpqEORYBw--.9042S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1fCF4DZr45uryUWryfZwb_yoW8Xw4DpF
 s8Kw1DJF1kJFn8ur43W395uayrG3Zxt34rCrWUJa4qv398Z34qyw48tw1xJw1UJas3CryU
 Zr93G3WUtF1vyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUU
 UU=
X-Originating-IP: [111.196.241.250]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Fri, 04 Sep 2026 19:26:11 +0000
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

The VPL options are named VPL_I2C_SUPPORT and VPL_PCH_SUPPORT, but neither
symbol has a consumer. The driver build uses CONFIG_$(PHASE_)I2C and
CONFIG_$(PHASE_)PCH, which expand to VPL_I2C and VPL_PCH for this phase.

Rename the options to the names consumed by the build and update their
defaults to the current SPL_I2C and TPL_PCH symbols. No in-tree defconfig
sets the orphaned option names.

Fixes: 747093dd4089 ("vpl: Add Kconfig options for VPL")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 common/spl/Kconfig.vpl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index 434562443ac..d4c5636f3ac 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -139,11 +139,11 @@ config VPL_HASH
 	  this option to build system-specific drivers for hash acceleration
 	  as part of a VPL build.
 
-config VPL_I2C_SUPPORT
+config VPL_I2C
 	bool "Support I2C in VPL"
-	default y if SPL_I2C_SUPPORT
+	default y if SPL_I2C
 	help
-	  Enable support for the I2C bus in VPL. Vee SPL_I2C_SUPPORT for
+	  Enable support for the I2C bus in VPL. See SPL_I2C for
 	  details.
 
 config VPL_MMC
@@ -176,9 +176,9 @@ config VPL_MMC_WRITE
 	help
 	  Enable write access to MMC and SD Cards in VPL
 
-config VPL_PCH_SUPPORT
+config VPL_PCH
 	bool "Support PCH drivers"
-	default y if TPL_PCH_SUPPORT
+	default y if TPL_PCH
 	help
 	  Enable support for PCH (Platform Controller Hub) devices in VPL.
 	  These are used to set up GPIOs and the SPI peripheral early in
-- 
2.50.1 (Apple Git-155)

