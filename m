Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE07C79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B142340B80;
	Fri,  4 Sep 2026 19:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0S0e13B_R-Wt; Fri,  4 Sep 2026 19:26:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 641CF40A7F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788549972;
	b=T31YzcesHFgpwHFfjQS3OWKMwKcvU6Qjrxz9YXoMoUmwB8jIkDxhJQ9DdgyP4bM3J+r+
	 jxYX5RIKhFR+nL9ciazEP+UOql3OnXL3bodb+Mgnn4P8fN5ab99q1r7lNKIwBUf7Fnz1o
	 oxt+deNXcfD1LHNawuTQF5/gR+YjwINHf1ytSUNkUK/yj6PHRoFGnEAT0ijx8JPxRb7sT
	 kQN44b6ujVHmOOKT5FqrBt0yup9yjHjYIqYvwU2UZRi2n8yYL+Df+9cJ+Dyl03bkxpXed
	 5ALyS9/EbCt+W1nTnAzAycA/635HdT8xJF53RO0TszR50kTqdJDhBjZU7uKRtcnCqdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788549972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KcpwnS+oUk7edeyaOAYVkROYYD774R2jEMd/whMQkn0=;
	b=LjCuuTH1AcaYMcSYuKJncH2yWjLnIIuNi5Hc8escEXsEnj1Z44XO1MPrlcQoM7riZBVp
	 X7BEjHSWuuy/m9EISFYEtvl1gKjTX8Un2VC2MYGMDrwdwANvmQjEt0ndmq11EGVXnBSC5
	 VDKXDbXAOQaBlhZJn0/r0PGjUQ+HMrGUZqsIY6Sjou5gFTXOijfnduXsFUbPVtZqLwMWF
	 Ksbs4AsMRs2G74nciZjEci8/nnur7mBwUcA8gydhO+ghbchv52CD/CAchJKZraiYCfj6F
	 MQT5h2t97rWnhZFjELkJzdN913k7m8Cw5K0Mi6tjxF2fMh++o8wAo+ew7KvUWKBoL7A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=iscas.ac.cn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788549972;
	bh=KcpwnS+oUk7edeyaOAYVkROYYD774R2jEMd/whMQkn0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J3PU+g2ufkQY/zlS9Ne20U9AuD1YQLj6hhlZpAowOpFEUjdUVU6qKgLUjVwDuOzLC
	 6F94YTpx40YBIuai9XbUODMmowo+RgICedmI/5ObJl1AkICb5EH4BlcJXCzCw4GdQ7
	 na7AUjaQuSlK7HNBcxIDQfAgkQRw7EZAngA/dQZBlLjeQoEx8sWbD4W5Wqot32HHj/
	 CklfiNqCLL/smfRiUqI4pymv+g7ZmzFRZnvZBw8LlYobbQM8W7Ajum52l5MJWPvJqs
	 WqFFzsXooWmA+DC6Sxzk98Zi4CeEqWz6ylVr+3apFLyRKQfzix7gvXq3/5EErNfqC1
	 v+hthPlm5Z9vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 641CF40A7F;
	Fri,  4 Sep 2026 19:26:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1DF52FC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFAA740BBF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:16:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmOL2dCGXRAd for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:16:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2FC8A40BB3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788527811;
 b=Ru0lHxXMC3DBvX5tMNkJOH63A9XS8TtaVyRTwBODZ9t3wWMusFcMXLRzCN2FbHCoXFKZ
 NcTTJ17DotX0M95wHYk3VHft8e49Y4PBuOOX2V/6CB+hntJJTLuoowNtxqezhjD9sv+bG
 GBRC4bxuP5gqP7ml7/lQf+lXih8DhMhhtfiMhLrbwX5p2XSWgV2G5lawOfnMxSYB92DJa
 Bn1kyEaiXHgBWBqQVdfvJixs17fACL5tZ/h9AlkMuEQRDrJZg9Q/iDAGyFx1kI6e88P1L
 I22FzFeDGPnTOEeJaOEgZ8Trr9ljKEXujKQfliKbA0BOsW59sGPjbbHn5Pu5lQqeP8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788527811;
 h=X-Greylist:Received-SPF:Received:From:To:Cc:Subject:Date:Message-ID:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=KcpwnS+oUk7edeyaOAYVkROYYD774R2jEMd/whMQkn0=;
 b=RuWxTvHMl7oMMSQcTpGt2B3w0dj9wCMfvWJJW9MNLiMCvMXd4+V0EFvRe4O246AA/eYG
 qWqj/kLwmLwa44F70RIVcHTepU47fICok5TDvWyezl76mhKgMSP5bNc4fz9kMQND5rIYl
 CsVPi9LteVfByRegeo0XU9B1IctdfI0Ygn2E3kB1Spe4etMpwAVIE8z8B0GbPOa3Tobni
 f7uHBo6GlVgehiVl6dqUtErBgpgoedZr7kco/ij6+QnZ/WeAeiTfvsP+ZaKFqwOjPMcF5
 eno0b8CfWQmrOBmvGEbuhoQoCVRNY1LngobUbgrtxG8GjwOCxdddLZlXprIPgQt/R0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.25
X-Greylist: delayed 102 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 04 Sep 2026 13:16:49 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.25;
 helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=<UNKNOWN> 
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FC8A40BB3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-05 (Coremail) with SMTP id zQCowABnlkClxJpq5tZYBw--.1228S2;
 Fri, 04 Sep 2026 21:16:21 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] efi_loader: imply the FS_FAT Kconfig symbol
Date: Fri,  4 Sep 2026 21:15:48 +0800
Message-ID: <20260904131619.42621-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABnlkClxJpq5tZYBw--.1228S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy3JrW3uw43Xw1DAr1kZrb_yoWfXFX_Aw
 40v393Ja4UuFWIgayUZrWrtw15Aa1SqFyxGFsxtrsxXFW3WF4fJ3s5XF9Yyry7Wa1jkF15
 WFW0yFnxAr1UJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
 1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
 cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
 ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
 Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5oGQDUUUU
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

EFI_LOADER implies FAT, but FAT has no Kconfig definition. The filesystem
capability is named FS_FAT, and FAT_WRITE and FAT_RENAME both depend on
it.

Imply FS_FAT so enabling EFI_LOADER can establish the intended FAT
filesystem dependency instead of referencing an undefined symbol.

Fixes: 93f6201af71d ("efi_loader: imply FAT, FAT_WRITE")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 lib/efi_loader/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4cb13ae7c8a..c4b0c2137b8 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -28,7 +28,7 @@ config EFI_LOADER
 	select OF_LIBFDT
 	imply PARTITION_UUIDS
 	select REGEX
-	imply FAT
+	imply FS_FAT
 	imply FAT_WRITE
 	imply FAT_RENAME
 	imply USB_KEYBOARD_FN_KEYS
-- 
2.50.1 (Apple Git-155)

