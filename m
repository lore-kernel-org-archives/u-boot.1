Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5963CAC592
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 13:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B2583496;
	Mon, 15 Sep 2025 15:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E288309E; Mon, 15 Sep 2025 01:46:08 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9221A82AE1
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 01:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wangruikang@iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.87.235])
 by APP-01 (Coremail) with SMTP id qwCowAA3kaOzU8doX5noAg--.33344S2;
 Mon, 15 Sep 2025 07:45:55 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Mon, 15 Sep 2025 07:45:49 +0800
Subject: [PATCH] riscv: qemu: Remove fdt_high default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-qemu-riscv-remove-fdt-high-v1-1-661178447396@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAKxTx2gC/yWNyw6CMBAAf4Xs2TUtikF+xXDoY4E9FGRbGhPCv
 1vlOHOY2SGSMEXoqh2EMkde5gL6UoGbzDwSsi8Mtaob9dQNrhQ2FI4uo1BYMuHgE048TqiNe7S
 t9/pmLZTAW2jgzz/+6k8WWrfySKcEayKhW0Lg1FX597hqheLu0B/HFx6+4CecAAAA
X-Change-ID: 20250915-qemu-riscv-remove-fdt-high-1ac688dd13bb
To: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID: qwCowAA3kaOzU8doX5noAg--.33344S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4xJFW5Gw1rWr18ur18Grg_yoWkKrX_C3
 W3XFZ5ur47ZF42krs5JFyfKr1093Z2yr1xJF1rJrZxGFs7Ar43Z34xWF1xtw1q9w4DCFn7
 Z3WruF4qkrWFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb4kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
 UUU
X-Originating-IP: [114.241.87.235]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Mailman-Approved-At: Mon, 15 Sep 2025 15:06:01 +0200
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

Setting fdt_high to all ones is discouraged and does not appear to be
useful for RISC-V QEMU. Moreover, it causes a boot failure when the FDT
generated internally by QEMU is used while booting. Remove it to allow
U-Boot to pick a suitable address and relocate the FDT.

Closes: https://lore.kernel.org/u-boot/8397369a-9b0b-4798-9c30-3a81165657d6@iscas.ac.cn
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 include/configs/qemu-riscv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/qemu-riscv.h b/include/configs/qemu-riscv.h
index cf4fcb90b047bb641d702124f2efa451408c0b16..dad59cc0d5827981396b10d9782766d4d9aa29c6 100644
--- a/include/configs/qemu-riscv.h
+++ b/include/configs/qemu-riscv.h
@@ -32,7 +32,6 @@
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	CFG_STD_DEVICES_SETTINGS \
-	"fdt_high=0xffffffffffffffff\0" \
 	"initrd_high=0xffffffffffffffff\0" \
 	"kernel_addr_r=0x84000000\0" \
 	"kernel_comp_addr_r=0x88000000\0" \

---
base-commit: 18973d4b0801ec6d7fddc0084601036b5c3b08ad
change-id: 20250915-qemu-riscv-remove-fdt-high-1ac688dd13bb

Best regards,
-- 
Vivian "dramforever" Wang

