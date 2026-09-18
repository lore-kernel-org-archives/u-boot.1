Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A44C982D8
	for <u-boot@archiver.kernel.org>; Sat, 19 Sep 2026 04:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36AC181230;
	Sat, 19 Sep 2026 04:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hwIz5E1oCK_G; Sat, 19 Sep 2026 04:40:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 025BB811FB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789792841;
	b=tJtStyob9PxUItA/CpnSCxI40N/j7DMb60+oXqap2YyQwRYTcMVhU/if9qE1oWw0ySmU
	 I6zo+DrKWsOesSS1I1dSP6rgDWkuMyU0WTcAkDqrnaPHowKyj6dKObNsUN5rCyK02POUD
	 KboJlqIA4yQDDqKIcxaIB0440jzme3l4Iq4YET3MoHPzw+DJFocS2w6eKZlwor8cR17o2
	 f4zZQvNTGvJpMafeTPGymAZECGyRYyexspqGgfoBopmUVPm3N2rjZjWpSn8sZW0KLCVHK
	 zS4/0q4SwKuVXM1rsvHK4MUN+g+x/vJyImeskABxCN3quWWLD6ghWlsS8HVfNdqcaLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789792841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
	 X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VQSdkr97VvIb0/hu4LIIijZ2//mYo2u6m9H8bmudABo=;
	b=IuYTbU3Pw15fsAqzvHBuiYwW7y9akcKqG5WDWCkL1YpcJrR/8ltuUKK20L3arvZWdsjl
	 pOXeHlDypclcbxLF81kZRaIWpOuXkjULl0LYY+9rSev8CBvykHHS7TTGnu7QvocVk2ZFC
	 gLZ365ZvLAIh4Ru5sNb8ft4H5E9n1IWhDYa1NdZsK2sxvqbQLcEk58Q5a96O1ZJV4a9if
	 Zw7h97JHjtyyRJ+9ZzmGPvCrHhReb4nWKU1IWwQmUF3E9bqkAmrLhTbo237X3bojMyuOJ
	 r89t8rmxcMWL6GN+Uo33e4hetTqs/8WpXPhjeG0baTNB+dgL1By0Ta9oJ9UMkZuiy7Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789792841;
	bh=VQSdkr97VvIb0/hu4LIIijZ2//mYo2u6m9H8bmudABo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CNpEcwtx7Lkm1LzXD/qYddgdXiN84m1xEncy1bKnjky/GUz0EBfglrbW/FCO7MS1b
	 YQPDoZUY3pukM45ZUvyg+81zThBMFmjSCu98JGwzNDKvGCbiHKIah7TGgQ+FTpKzJB
	 KOBoEuzXs5dzEvKvEKph7TqvFe8MJwCgFLHAnHA1wLMcD9RCNKgD9uqYuSsZsi+Pf5
	 NaGc6hKV6rLB5oi2u7d2Ve6raSf4Mb6g3wcm/BdH1D6gHV5/aH8628zlF357uVyX0+
	 xWXHPvX1zyyMgNk2a8/Klf1ImZtYqzlQwQ72cliA8ygx7jKsFPpO53GRVfyHJ0RggI
	 MPi1Oz+urBdRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 025BB811FB;
	Sat, 19 Sep 2026 04:40:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 297A23B9
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 272F160DB6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huE_RL4Zu5Lm for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:35:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E130E60D67
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789763749;
 b=h3PFQtRP6KiPrYvFedab6Mk3wFi2iIa1qplirOWnQQaDDS1czPIgt8Pc8pRA6PzXMpkU
 P+Mej228ptsAULQL3klKyRcpzGRIefWlIlciPmUXsJMQYsP9EUHn1UZaJ2EEhWqj8dJRJ
 s7B01DcKuI7kzTABLEIB0Dq7o8oBdFTgSnioFz786aZS2k7o2tCdp1jx/JqOkV8apvkhN
 l/faBmd+yBMBRWqL42xQzVqC2M/uTeswORt+tJLhCKuAHgOar5sc/cfeatGbqV7bAjTA6
 XPpoiLu3V4DYwiQ7kUyA1hxPhqlEDB2laFHmE17MYcyeAYeHtF1pd3gs7EGMZBvgH3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789763749;
 h=X-Greylist:Received-SPF:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:
 X-Originating-IP:X-CM-SenderInfo;
 bh=VQSdkr97VvIb0/hu4LIIijZ2//mYo2u6m9H8bmudABo=;
 b=RKx0Pql9ATnsjuXGLFmL0l9O3+ikwS3Epj54kNBvN+W51wtPvu3E+PkR647yf0+Qa7ki
 171u83YDI01ignPa/mx1kn8kW5PU15LlFIyBSz3OPEcxglTu1nG+oUoCAZsg0yJdMEHNw
 SwIEEdIYUKtYXzYOLJcOG7Rrv3dE+FY/d0NV1U/TeFR5Epkx1cMD40x0OeukwBJiMNlNG
 dX23UL4RRhhsCkvkm/WiJElIouwHpYTy1Fol7pmesCRDivl/9roTk2kzc9clpjNYGjhP8
 igaqxQGNgrikdkZcfAuuemVNp4YErWrBQM/XYcEyW2B09XAwgHaiLmlPq1II/69dZAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.81
X-Greylist: delayed 354 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 18 Sep 2026 20:35:48 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.81;
 helo=cstnet.cn; envelope-from=gaohan@iscas.ac.cn; receiver=<UNKNOWN> 
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E130E60D67
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:35:47 +0000 (UTC)
Received: from [127.0.1.1] (unknown [223.166.93.127])
 by APP-03 (Coremail) with SMTP id rQCowABXXTucoK1qnc4RCA--.26426S2;
 Sat, 19 Sep 2026 04:35:41 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Date: Sat, 19 Sep 2026 04:35:33 +0800
Subject: [PATCH] cmd: ufetch: avoid truncating storage sizes on 32-bit systems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-fixfetch-v1-1-f1e8b54d8a87@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqAIBAG4KvIrBMyemBXiRY+xpoWFVoRiHfPa
 vnxPyIE9IQBehbB40WBtjVDFAzMrNYJOdlsqMqqLaWQ3NHt8DAzt51SjZa1lbqDXN895uy7Gsb
 f4dQLmuPdQ0oPRewbHGwAAAA=
X-Change-ID: 20260919-fixfetch-d7aa5b94d9b7
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-CM-TRANSID: rQCowABXXTucoK1qnc4RCA--.26426S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1xCr4ftFykWw15WFy3urg_yoW8JFWDpr
 Z5W3ZrKa1rJrWxtFs7trsrKFn7ZF1kJF1UCFy8u3saqwnIkw1aqFy0kryYya18XrWxZrsI
 qr4qva97Zr48CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
 xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
 0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
 IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
 AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
 6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUG0P
 hUUUUU=
X-Originating-IP: [223.166.93.127]
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiDAAODGqtR-CkeQAAsj
X-Mailman-Approved-At: Sat, 19 Sep 2026 04:40:40 +0000
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

Storage capacities above 4 GiB are truncated when stored in size_t
on 32-bit systems. Use a 64-bit accumulator and promote the block
count before multiplication so 32-bit LBA configurations are also
handled correctly.

Fixes: 86d462c05d57 ("cmd: add a fetch utility")

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 cmd/ufetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index d4b54f77b7b2..29ccbf654a4e 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -95,7 +95,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 	const char *model, *compatible;
 	char *ipaddr;
 	int n_cmds, n_cpus = 0, compatlen;
-	size_t size = 0;
+	u64 size = 0;
 	ofnode np;
 	bool skip_ascii = false;
 
@@ -221,7 +221,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 			ret = uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
 			if (!ret && dev) {
 				desc = dev_get_uclass_plat(dev);
-				size = desc->lba * desc->blksz;
+				size = (u64)desc->lba * desc->blksz;
 				printf("%4s %d: " RESET, blk_get_uclass_name(desc->uclass_id),
 					desc->lun);
 				if (size)

---
base-commit: 211de43d0f954a00a490220c1aac9db298287c40
change-id: 20260919-fixfetch-d7aa5b94d9b7

Best regards,
--  
Han Gao <gaohan@iscas.ac.cn>

