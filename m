Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409D1C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2AE940B7F;
	Fri,  4 Sep 2026 19:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iktAn0Go4dPX; Fri,  4 Sep 2026 19:26:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AAAA640B85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788549977;
	b=sPY1Vz+qjexaaQEPoDwfwWxw2SqNX9R4TXu6YPOj8x65xYWRNb73v61w5Y3ZUints/TF
	 DJ5tOWabboHv+EG91mc+xw3c4X/x7OauW+x6/qLngynbR0SUMFCxLC3dyLHn2e9iUxMz/
	 7s/+weAl7TiX9nGdjXcWqyqMLpWP2mOXcmF9SpES48UrflvpgStkXUwIK6eeuPNA1r/xJ
	 EFQFDq8DRhgzBO73U/XhUK35N9sZ6y3houlJnBhZXsN1xgrsnolqLGGXQ3tzPputHIr0q
	 Ha8KOhXopJWTSwUHMoVPYTwBGOX6VK0I0rEmES9H6cJVt9gIf8h4+a6iD5+LHoDStvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788549977;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sU0ZKEfHS9LDujb6eVldNop6u49SNN95cZAoUbiWDpg=;
	b=W1elileoIPNdvcwrfBmHEIPxAbEHavPy+1yyyvWRIaZ+Tza0HHe8gUp/HmfdxUStWG5w
	 2JAR3dTv1OjDumB/zqSIdv6MnMJHRQBPG87MT5hcj8d6Luc1NItsKUeA4HFuqzVYv40Ue
	 Q3EDRI14SBAbz7rV0wLI50+2kI95os8SmDxsGBYcCBZExKrhmX4FtIrTZxOnEUcN+evTi
	 Gs/u0yUCadAjGZUTcl6Kn2Awxwal25tVdEnW2JR6Ryj1dA4MAdILRgWuJb3PFVB/ZVoEQ
	 Tw2hil8z4+dFLFeE8wS8FV2QEso7RpPeAR/IDS1IJvbijco2tOvgVonR/WlAe7xBwAQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788549977;
	bh=sU0ZKEfHS9LDujb6eVldNop6u49SNN95cZAoUbiWDpg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O3/nli87wtKX9VtwBZyk2Ia+FblBR+ajYIA+N5VAt1fvAuerc64m60D1v3spymzjm
	 czuPB22956pPXRqLJ+8JR4npP6H9Q4j+rQ+5H/x2PKdkO/tMqNMAx2B9zHdxGd+yID
	 HkXaegnkvUyTy2jDvJwLsosueDzmeV/z7LqtuE01ccTZlLvff/S9U2bF1DuMoMh/Na
	 GULrCvjC7/Lh2zi0dUq/0UzWSNlxAqeSTE9WVQZGJ5fsy/jAC/SMgptnbKgP/WcwZO
	 wOpXaK4rui8v4fqS3nX74dP2DFB75tZSAh9E6m4gPvnBtdHND4RMmporFyOE6FUk0d
	 foBjGPGjeoWrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAAA640B85;
	Fri,  4 Sep 2026 19:26:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09403F14
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0649360BC9
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CN_G8VoeABkJ for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:20:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 922E76083C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788528003;
 b=AzS3ikh3j878NSmCP40Y/Fdb2FHEb0SKH/wGvNZizz6FUZ/8FwpUlCbVALwGtySzZyyE
 Gar1i4naT4z6VvrWMdAwm8dMd2oMvIkrZGZpvZlUFngHzW6eLFbvg9ShSQz+E1egIQxo3
 5oYXG0mcPhjpkx8iQnMoDx0TDWps2YmreCx/miZcgDEIhEvKrv9QVenND+b17Aq65EiyL
 CVsaln8MgtWbZd9ye9RFrwdSCFfeO4PfD/yemHsEfwoxHYF5ctAD1OXRrgtlOvQOMRcQx
 t1kOjBcu8MdcJt9u1efDKFR3Jf+s/MKZ8Um1dpP0fmympE3VxlAGyP1ltnrbbyH1CZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788528003;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=sU0ZKEfHS9LDujb6eVldNop6u49SNN95cZAoUbiWDpg=;
 b=D21FFXAUQkyTDFMK0unPDuXOCHw99RrJFPVbDgwZ5V7omTAdstm4L+OPhv5t8QBN4yUv
 igINNykRPP+slt6EAI1qOKDiu+UWFf5bow5iGA1JI/SunbsUhwZy520HezI9fMIr48tyh
 V9+Ony3hBUn32htoyBaA4b2uYjXzRpXhIcd6gG9sYyJbQ5Od++tL4BZDSJqmvahVypeD3
 qDQvzwaFqbPK6ymOquK2aJy9hX4IoB8fISKVCplYJz+u3JbyFucjjOQ1vJro/k2wQnLZu
 9DpxY5P1tKQz2SJkEWHPqb/ulpezeNlXukZvWh111qnSUzYnqehSe3fnHHxFp5VaRtQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.25
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.25;
 helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 922E76083C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:20:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-05 (Coremail) with SMTP id zQCowABXiEJ5xZpqO+FYBw--.8678S2;
 Fri, 04 Sep 2026 21:19:53 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] fastboot: fix the RK3328 buffer-address default
Date: Fri,  4 Sep 2026 21:19:42 +0800
Message-ID: <20260904131951.44451-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXiEJ5xZpqO+FYBw--.8678S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw47Wr4xCryfJr43Aw18Xwb_yoW8Jr18pr
 4DXr18CrZ7Wa1UGFsrX3WkCF4UXan7ArW8Cr4UX3Wjv3y3A34UuFyvkrWDGF1kJFs7Jw12
 y34rKayDKF1vqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
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

The default fastboot buffer address tests ROCKCHIP_RK3329, but U-Boot has
no such SoC symbol. The supported SoC is ROCKCHIP_RK3328.

Use the existing RK3328 symbol so custom RK3328 configurations that do
not override FASTBOOT_BUF_ADDR receive the intended Rockchip default.
Existing in-tree RK3328 defconfigs that set the address explicitly are
unchanged.

Fixes: 48f6232e5897 ("Kconfig: Migrate all of cmd/fastboot/Kconfig to defconfigs")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/fastboot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 90212fcf9ef..1887f78bcec 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -57,7 +57,7 @@ config FASTBOOT_BUF_ADDR
 	default 0x22000000 if ARCH_SUNXI && MACH_SUN9I
 	default 0x60800800 if ROCKCHIP_RK3036 || ROCKCHIP_RK3188 || \
 				ROCKCHIP_RK322X
-	default 0x800800 if ROCKCHIP_RK3288 || ROCKCHIP_RK3329 || \
+	default 0x800800 if ROCKCHIP_RK3288 || ROCKCHIP_RK3328 || \
 				ROCKCHIP_RK3399
 	default 0x280000 if ROCKCHIP_RK3368
 	default 0x100000 if ARCH_ZYNQMP
-- 
2.50.1 (Apple Git-155)

