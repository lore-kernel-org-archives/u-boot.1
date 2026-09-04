Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50035C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F151540B82;
	Fri,  4 Sep 2026 19:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Fa0Q7y2B1Sg; Fri,  4 Sep 2026 19:26:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F058640AD4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788549974;
	b=As6lsAJic8SELgIfpbuL6EXmigfqSGy9SqR6hwXXijLNwM1O73bMcMJLRxsUg7OAYcQj
	 H7pLP11vVSZ/+2/9Ui+GAMZO4I4ln31mVkuG2iqIE1ODqrkj7fITZV7YGlPUzJW7ibWFq
	 5bPGs6Y5MLurm5uivu8/ap336bs7U2IRH9q/GXH6h7qgCrqrV0YtaPbzs5kE+kMvfk7a0
	 abYuOMVT1BN9YqMsHevrXaS/yCxR0muOPPhbWgVvcY6rTmZbL2wYnwQKj/qH4Xew6Fo3M
	 N+r7HSQGC5JVrwGNFAeK4fqBGqxfsNTqFK6hJM4THoFHg+9pMlmnlKrivRhfHcnLOlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788549974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YL10xCBjXEv9f/YYlIYM9yS2tCTO0ISh8s5Pf9RauL4=;
	b=XmlrhWD92kjqiOFyS/yPLJaC3Ie3L3Bdmze5CrAgSk6UFma2A7Wa8bZ3PHWY4M3qtywu
	 gWiYcC6wYgRI76zhoSIfrx52pPlLip3Ydn3ZaQHAVj5ZPrzea21rw2n+Br5z72zF2r+Qd
	 QAwaU4D+dQ3kZfxg25PTUuGt4nKxGRUh/LwOaI1vlHv4ZKewJ7tGftjU/0IV1P3w8PSHT
	 eOoDI+V6a/rgEAR+7fNspM1cayf2l7Xd3QuVByEwdpmA9DN6uU9CW7HV73XSdsdw99888
	 8LT0B9J/TMHFv8fY2WGyV3WjMYxHdmuuxTI+LiOzEU4zDYwjzid/hcFl/uNq1lkKOew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788549974;
	bh=YL10xCBjXEv9f/YYlIYM9yS2tCTO0ISh8s5Pf9RauL4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dRN9t7y58neLwD2kE+FjOujkh8ztutHe4C98l77YpVaj3Q8i4L+C7FZdaTGlnGCVH
	 9N4Pvj30fs6eIYefylrRg9R8mrRv8qhPXM5O+eSO97XkZ9TskhH/ZkEHMF0ia0SGv+
	 KGyFYiDA6c2T+DOeQ9TK02ACVXDRC7MMqJB/fzRBDvf9PHXOoKCxcsTFs7fw+egcKi
	 m6U2c1cbtiQWRjazceI+exP9ict1mnknZhrskw7RjynIjtWpyzdfov2w5/f4OUhsHs
	 WNp417zTz9Z0gEa1WOa5mwL0Qoi9wHnByK2JnRHxvPD8liMyFzjpEV8CrcoQ8GuhQa
	 QYl23yL781J/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F058640AD4;
	Fri,  4 Sep 2026 19:26:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BCAD1F14
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE494810DC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:18:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ryzi_dddv4VO for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5066E80F71
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788527889;
 b=Ty5Kx7JaIWRgKO5M0nmj3S48U0+Lqk9V5hry3quyhhzTjkvSZJ3aYf6O4MtU0PqS2zMw
 M5EOgxXfhtocYrih27DxQcAcxtcfB2PtvxRlZDICGG/j1GZYL7Jbe/zD5BXFLBJI4CrnS
 ziSdRJsreXRhoWga1lsyenbdeueOaI/Nsz/uC8fMkyWJKY20Qy0G1kPLe0iA0ajzEDqzK
 cy8f+sVd6yVmwUcYyHxv3Ea7uCklzdE8pTkf1TBIlyYnACJJ61Nl+eXhwa0nQfnywKlYj
 XD4c9NbmJ3rsdZ75qP4YsE37gZvFIJvu4cG7Ddn08J29jznjRkNTWkePm09ffNJeucA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788527889;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=YL10xCBjXEv9f/YYlIYM9yS2tCTO0ISh8s5Pf9RauL4=;
 b=WIJadPY0a7hOzZU3tIv3HKHbOz/Nw54DqUvs2/qm30uKp+Del7FCWIOCblXRRyctor2Q
 /1G+cNhyVw/6gi4CB5J8FkrW7+GPgC0fb4NdoOV2wWsl+gcbEx+WNsWHb/GEvIOKjgXUd
 vjePSkmFYPJDgE10Gsvc0l7fs7TkebsBbXun16w8dfz38GQkRoPJG8rlzc+fzjlY7BQY0
 dWSdNSbH269/sisVa5nFlOrhbkNrt2MyCl2ydnUxRzJqfJfUu9smZbc8Nqsn1Q0iHRsCp
 v8ODgxAe0BGZDFUV3aA+Ws+ichTPJjPp1bTpHlJzGIolQj1wfABWXTZvjz5QFrDwA2A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=iscas.ac.cn; 
 arc=none smtp.remote-ip=159.226.251.25
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.226.251.25;
 helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5066E80F71
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-05 (Coremail) with SMTP id zQCowABXwjz1xJpqzNpYBw--.9007S2;
 Fri, 04 Sep 2026 21:17:42 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] riscv: mpfs: imply the CoreQSPI driver
Date: Fri,  4 Sep 2026 21:17:06 +0800
Message-ID: <20260904131738.43312-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXwjz1xJpqzNpYBw--.9007S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyDKFW8JFWrJw1kurWUCFg_yoWDtrb_K3
 W8Jw1vqw43Z3yFkw1UWF4FgryxKa4ruF93Gw1ftr17A347Wr1aqa1qgr17Xa43G3yjvFn3
 WrZ7ZrySyr1ayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
 1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
 cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
 ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
 Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOgAwDUUUU
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

When the MPFS SoC-level options were moved to the CPU Kconfig, the QSPI
implication was changed from MICROCHIP_COREQSPI to the undefined
MICROCHIP_QSPI symbol.

Restore the existing driver symbol so MPFS configurations can inherit the
same CoreQSPI capability that the board Kconfig previously implied.

The provider-less SIFIVE_CLINT options were removed separately in
12a9c83cba29. CoreQSPI instead has an in-tree driver and matching MPFS
DT nodes.

Fixes: 2f7420ccaacb ("riscv: mpfs: move SoC level options to the CPU Kconfig")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/riscv/cpu/mpfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
index 8054313d182..3f0dca53665 100644
--- a/arch/riscv/cpu/mpfs/Kconfig
+++ b/arch/riscv/cpu/mpfs/Kconfig
@@ -28,4 +28,4 @@ config MICROCHIP_MPFS
 	imply MMC_HS200_SUPPORT
 	imply SPI
 	imply DM_SPI
-	imply MICROCHIP_QSPI
+	imply MICROCHIP_COREQSPI
-- 
2.50.1 (Apple Git-155)

