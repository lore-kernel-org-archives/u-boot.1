Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C41C79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C49AD60BBA;
	Fri,  4 Sep 2026 19:26:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBMQG_gOATan; Fri,  4 Sep 2026 19:26:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E5F5660B8F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788549982;
	b=D6m34oTyF+10434/7u93s55KhS7VFHNM09ceSd0gFQDbltNIR4Mz53kN9y0+vRHTVwZE
	 hADngxedf/LdzqF4MAdRDX88p7FGh5hCByWb7Jm2h8MBAVzZNyLkkLbHtVTjGC8Qe3mvy
	 6ib6IepzV2WnmwWHrCZTkSW4Rzjm9VrZas1pRjtoJjV84IIhDFyEIkGoAs7X0CZiRPzbP
	 9rCn/GjMqFRMqJtOTLGXMWhlRPdU+MHknzEUbqRVVTyRnEAwT5kbpUIp3cSCIaJOPMWo6
	 v230xzXQpG8O9QtLKbCfcokzilo0LOoSYrsUM3MU/b3EOZawlJDvSNropY9R3QJfTVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788549982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xyB2hSBeAG1AJmv+0zCV4wF3Wy7/XoGlQxheT64jeVs=;
	b=HsoD00YijqIflvxYT5YyZGiZHiYh3dvuofHFBPzmTuEwzH0fXzRurzLcqHJSI+v4qYBO
	 sq0GBrXNtXVGea9o6/C5pGPIqgn41xb2zLheKXZQf/lZ3LU5+LANmca6Ee2dbkrh5Ce60
	 +pdzqbdvRxOCxyFox3a4j7V52IBT8QibHS47Kr3hdSNIGRdbyfaCbCiWfKtZ5mqTtyfDV
	 kWiGNHuviKzOFW7v69N3aYQK5j5nPp4DorKH/SS8VuVz/5vWLHkt7n6B5WvIivJC3YuLZ
	 5itgQMmiH05IFV/S2Fqt7UpREownvncza08XFXL+9UuOQbNc8QjgL+ZnvzWSTXeDS+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=iscas.ac.cn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788549982;
	bh=xyB2hSBeAG1AJmv+0zCV4wF3Wy7/XoGlQxheT64jeVs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FRP13TQN+GCU9pPnt51gGigsy+6nCiGMW+6UoWk30rBd0Z3S5q7L7C6FfKm18Elfm
	 DypH1PiKMMrbxAu22ueIPL53MkO0NQrcHmBceKxgifSkvJxPVBdkgbFP9mTIH/5Rz4
	 uu9tZMvPdxRW417hy4To3a7//xII8IEwoWqCUncEKNjqx+Hg8z6iIEUGpvIvEzzSIo
	 XKMu651bGCDkuEl8gsjmnbWBgc1v9ED34ery4C6FyW6KcVYcjB8h8QZIEWb4b//z28
	 Pq+zzpp9HynhRfLpsolgOEq9jsmh1Ia8B2d0fcmrCztTWu4IuT15iTByNXAOOzMjt/
	 DK93RlI1lCxfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5F5660B8F;
	Fri,  4 Sep 2026 19:26:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7598910E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C08960BC9
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7LMfiMZpznW for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:21:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 00D716083C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788528110;
 b=scayQFQwvI6UbnF3nkI8lmsuqAYzLbkk9VlwbJB8q0AsJJJrhFGcHz0P4FJNfZgvkVg9
 dokiZbBSvwvDlVngiqb+g++qGc3E87gVeLXmYcaoamGpsbwdHEwmQaJw+H6+l2lR/lA+9
 1cu4Nk3vRCv+WTwk3sFz1Zwsrt4daQVhevwdO4OrypaiRXRBHot+USXEFnBb1qq5Cv1Aq
 5D0jkJWXRNFi1xeC1TOIeXb9sSlC+KaXINqsrkUblLJ2rq8LML+M3gSUZV6xyDqI/aLTl
 YwJCxl5x4wFCR5Nwo338UXspxtTGi+TAmVbp78Du/7wdAh53rLvybEnHETerbpcaCrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788528110;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=xyB2hSBeAG1AJmv+0zCV4wF3Wy7/XoGlQxheT64jeVs=;
 b=Km4KPlLdY0Eo3A0dtESif6jr4O++Pzu13wfwiUXWyy0rg5JAU55vg0jGEtMJCpVnmV2b
 UAtS/woxez6hn354pEaPncBHliArNKu9eraICm2f8XwoPnNoY2+qkyNaOWarqopTnbjKt
 MyX0w8c2pKHrQMWSS1ILd80FSbREN1nSgK+P0XTIa+VO+8zyuy3xWmidy4RXmXCTvUcB1
 MDjmTSXdYslcxPZy1Ob37PsmnTMEke5zqPcNX/q0uRYP30KJd/ey0pFzyYyvLLb6cOQY/
 09Gvrwo12eWmQH6UpH2OlihNrtaTpgYu6Lg9NkZ8xt7pwSS+jycTBQBxRDU0VUXZQyw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.25
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.25;
 helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00D716083C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-05 (Coremail) with SMTP id zQCowACH8TtWxJpqxdJYBw--.8713S2;
 Fri, 04 Sep 2026 21:15:03 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] power: regulator: require SCMI firmware for SCMI regulators
Date: Fri,  4 Sep 2026 21:14:34 +0800
Message-ID: <20260904131458.42324-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACH8TtWxJpqxdJYBw--.8713S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyxWw13Gw43ZrW5CF1ftFb_yoW8GFykpF
 WUW3W3Cr10vFW8JF42kFyxWa45ZasrWrW7Jrn3Jw4rZ342yF92yr1Dtr15CFn7AF4kG34j
 va4fua18Z3Z7GFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
 6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
 IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYNVyDUUUU
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

DM_REGULATOR_SCMI selects SCMI_AGENT, but that Kconfig symbol does not
exist. As a result, enabling the regulator option does not ensure that
the SCMI agent uclass and transport code are built.

Make the option depend on SCMI_FIRMWARE, matching the dependency used by
the SCMI clock, reset and power-domain consumers. This also leaves
transport selection to SCMI_FIRMWARE and its existing dependencies.

Commit 80bdc86db5a5 ("scmi: Rework SCMI_FIRMWARE implementation") made
the same select-to-dependency correction for RESET_SCMI after randconfig
exposed the incomplete SCMI configuration.

Fixes: 1f213ee4dbf2 ("firmware: scmi: voltage regulator")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/power/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 00a25acfdf9..924d38e17ff 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -524,7 +524,7 @@ config DM_REGULATOR_TPS65941
 config DM_REGULATOR_SCMI
 	bool "Enable driver for SCMI voltage domain regulators"
 	depends on DM_REGULATOR
-	select SCMI_AGENT
+	depends on SCMI_FIRMWARE
 	help
 	  Enable this option if you want to support regulators exposed through
 	  the SCMI voltage domain protocol by a SCMI server.
-- 
2.50.1 (Apple Git-155)

