Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC30C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 09:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC3987F6F;
	Mon,  6 May 2024 11:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="PEHiRbJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264F887F8B; Mon,  6 May 2024 11:16:21 +0200 (CEST)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E66887F2E
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 11:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1714986952; bh=NS7Mia0u+DtBf72bw6i1glbNsGj5osAS3vbEa0U2bqM=;
 h=From:To:Cc:Subject:Date;
 b=PEHiRbJ6azobIowVb8czL/VBfuGPI+WT6sbtmuWGWQiwknu4HmnG556qiWtrL/5pU
 ItXVJgRfclK7xPhZCAG3j2U2tOfxMbLVZMZ4D8LJ+j4CLqh5EnGbFj4Ni+WBYNCsHO
 dp0oUaoRWNPvh3pBnuHiosqudiwdk92LT1mnwa0s=
Received: from localhost.localdomain ([183.172.232.66])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id 3F20A033; Mon, 06 May 2024 17:15:50 +0800
X-QQ-mid: xmsmtpt1714986950tx4g6rvwp
Message-ID: <tencent_6178F4CBD2326AD3FE5FBAA496630920D405@qq.com>
X-QQ-XMAILINFO: Nd/Exl7W9DK522sxvvd6T4Fq5owKqP2jiLyvkicvztycteS71L5qjo17vyp7vJ
 cdRT/i+2AIuKX0VJFreqKU4AmTXl6M+NbwZpF3r/OGOLdiXTej8kvgW1ISCisBSyUt47LerUl1hx
 9+V4hx9DhKzMvTXPQnnGG+FDX5Wq1Evx1PsrYTv0cfWcmk/BYQXbLZIXAFTueyVL5Le+TpnpD9Oe
 XRXSy1C3iqSsPURThlMd2x4JrejgW4HkA1vmBNnj8yZe1dDZkzQJzXGyCQMeNR+DDujuY7XqpgyQ
 cqbsfSJDomfqDsY1+UZfmJ1eGoUkFnuV1iXY0zHzvK9o9Opp+DFVbedlgQAZnNdtErJLF1nk46gk
 iSB2IrIaTNmN+BXAVh6lmypGbk9OVSuuKRhBoyLsjoU4MvxJ9g28MzbmpIKBp0szBGnyk57j1BBF
 caTrdVlf43AEuMDuWRZdozHnWXyWhyRRw6SoEdK+iOCY1YfqLS2A759Vdd29+QtCaUo2DABDkJkj
 CE+w3s2KVulfr4wk3hIWIb6s+MB/w4Kvgv/coxfGd2G4dvn0WbEHHnLHPzUbyt7OUQiOG/9BdMAk
 oFwgQvmlai+vzOl7gM929jNZCa0htgjXj6eR6snHinPkncQ+qRUNDwPrlAHJfK4kI7pMxJ1FoWd4
 TB02geJUolHXJTMZh8BvKr+i1i8S6eVAGxXwRiS2O9Zkg5wiBpnvoUb/U/NjvOKapr9croLbAV5o
 XO0/Yg5XSx3tDoB1d8h8+191I2H5aUF/X+nfqhn9mO7AcEdpDj0fvQS1QViTQg2Bg22b4n+rrdhg
 9hakygSxr+lGWSFi2mB95eIN3fwtUnS6z0BmahNZxXu4tzdVf92GSfI8wscBzpNjBOSFZ28bAb4Q
 N7SzjX3cRW7REaAgXqYuRC44Oz9tepGPRAsr2vn6YqhfXegRcdp29wF1OTTCds1YsVMz9zgFZpzk
 RH0btUh3al7tuLlwvnH+kE5FqcwvwNh+fa9D4cdHe2jIDdA21CeA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>,
 Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
Subject: [PATCH 1/1] riscv: add NULL check before calling strlen in the riscv
 cpu's get_desc()
Date: Mon,  6 May 2024 17:10:06 +0800
X-OQ-MSGID: <20240506091005.11063-1-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Without the NULL check, if the devicetree that u-boot loads does not have a
compatible property then a store access fault will be raised and force the
machine to reset, due to the NULL pointer we passed to strlen. This commit
adds this check and will return -ENOSPC to indicate the get_desc failed.

Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
---
 drivers/cpu/riscv_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpu/riscv_cpu.c b/drivers/cpu/riscv_cpu.c
index 9b1950efe0..d39a943cb8 100644
--- a/drivers/cpu/riscv_cpu.c
+++ b/drivers/cpu/riscv_cpu.c
@@ -24,7 +24,7 @@ static int riscv_cpu_get_desc(const struct udevice *dev, char *buf, int size)
 	const char *cpu;
 
 	cpu = dev_read_string(dev, "compatible");
-	if (size < (strlen(cpu) + 1))
+	if (!cpu || size < (strlen(cpu) + 1))
 		return -ENOSPC;
 
 	strcpy(buf, cpu);
-- 
2.34.1

