Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A6FC79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 06:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6438F80FA2;
	Fri,  4 Sep 2026 06:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mjVW0EhDo-EQ; Fri,  4 Sep 2026 06:08:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B641880EE3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788502094;
	b=CwgBcuw+qw3kYO4xvoagPyeX7eUisjdoT+iVRU0jI+mlXJU3DzpMPaveccH0p3TJEdpO
	 s87OMTbql/IVM8w9M4k8+ikMZODnUmf3khu+ahY6S8SdAJETmGjz/O+HHfC049FYDjxn1
	 piliwXE1PUZKgrNkOSs6mUhGQl+p110an66T0EHbeXiyOwXgqifJr26V69hN9oEC6W5Io
	 VV6jGRJea4QyXpahRfkQEvWRF8CIuVI8ad16xxwQ+F0+69eX/tdjy7itWaN5yktkV+8dx
	 u57BEcPsF3sYHGKOH5rjp3Olh4827IOCGtGM6KGhi+j2LGndvSiLEiYAjV1W8g8vI7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788502094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:X-Yandex-Fwd:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8IENWDCjALzlkdbA3bFtPYNRHFWNLbQnyYt+GQykiZs=;
	b=OjkNgmfVSL/BnbWoQYqSbheSDGgUEcZFVwzMldAw3ptXQIY6TzzZfleY6ehkBert4nKp
	 ztllfiLAvR1gYTSoos1FUzTJkh8eMNkCxNUeDLA2DVfnGXR2KCvnSdn/PXE6EyMXD+2g0
	 GwVkolb6deQ00PjgPCQcrazpC6HMbIXaYydKMq1fPd4GsyWeSIeIZetwy6A0MqdS3ihJ9
	 sIG8rM+Irc7U8hXimiSfWlGc9co4YOIti95njSXSQ4OuxdAVCBuwLUsg/oewAIBRVoCrL
	 yw8FlfYty37c9o+BVhvsIXyCoiEklUvChCCHDTNrbP/OF5yAhfi7M78iPvymucVTgmQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788502094;
	bh=8IENWDCjALzlkdbA3bFtPYNRHFWNLbQnyYt+GQykiZs=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Um+gmwMGve3cxB9Lt1ue/1eAi9f79Lq6BrsMssa6tCBIPpy8k2dMvUq/8qPE+1drn
	 lIXilaubW6OD3VGQYZu3Jh9kV2dtcrYd7tzdjRDTNZrjYiHwOJk28TeE0b4/uyMvtT
	 bHRm74Fu0tXyzUNdVgHX/zNmIwEcBgxVukgYKZ8P3XyZfmdMbUMpg+3Ne5YF/FXBGp
	 J1iRV/s29igYP7OgMCgalT8ksjGr4NRO4co4V88V1ucgUq3TNckFzu1E63rfirfjRB
	 mzoZvbV44tOUuebxx1K3XMg0jl56EOsmBzazQ1HORdpCTORvDddxYGbKJ8VXRiesPe
	 erYvTJ4ZJVbhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B641880EE3;
	Fri,  4 Sep 2026 06:08:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A12EB2C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 674CE60B43
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 17_091fAWFTU for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 06:08:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 22ABC6063F
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788502092;
 b=gHUni+UGxzsR6Cd9D8+eU8lFk3lB2X09a6hiDBzqhlasP7oFX24XX1E7mB5jMBluEv6g
 qDGytzXlY6JVMHLS6/fYmGS1TrEOtPUA99v+/t1NkTKtpXvDarYPSapWR0mF1CDyMYlFZ
 VMD5mnRX5RWrCA4duGlwBxC4bsqAefMKCPEnK8YAAjEDXWwV1OAjkZZj387PEowgNYe06
 6hLyifgM4GPV+HD7qCBOmk9h9iaXs7z3c+aokQDQQSsBWa1Prdgc8qRABIN7VcLR5waSB
 vQ+VZY5YHxvyexVm27TkRqLTSk1otZd4t+4DsCZ+HbLhrv8OVqE5cDUHsKm2NM99K9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788502092;
 h=Received-SPF:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=8IENWDCjALzlkdbA3bFtPYNRHFWNLbQnyYt+GQykiZs=;
 b=KfSkTyuQhkhe3HVm6ekfEX+6jMNL1ucMAY+CtpQR/hI9skpITrfQaqHYM+gHQyM0BOTx
 bMah2B9fzzoHcir8c4kGIIWGTTURpXaod6dEqyzDg18AkampgqhloKw9jW+FE1dHe2JKS
 VgKkSUR7jmcRzW7+RCOdlgnefn4HDlzaKGHCLifeRObZvLw1u4JptTOb+uq4/7jMGKxmF
 tdntNQwwIBvxC5937sK8MeZSyUXKFCVKoPdaUS/QMhKg4FQU+1uGvIbAnPcOtRqtg3fal
 3xx7dIdZfC7lWViuKwSjrNGS2A0tmBt8J1RNImksVhEefVB3cptj0RwBIQZrWO79gLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=maquefel.me; 
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=Xg4iZuph; 
 arc=none smtp.remote-ip="2a02:6b8:c0e:500:1:45:d181:d102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c0e:500:1:45:d181:d102; helo=forward102a.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=Xg4iZuph
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22ABC6063F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 06:08:07 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:582e:0:640:200:0])
 by forward102a.mail.yandex.net (postfix) with ESMTPS id 475C6C010B;
 Fri, 04 Sep 2026 09:08:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id n7C4ldbhFCg0-uBqC5CvL; 
 Fri, 04 Sep 2026 09:08:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788502080; bh=8IENWDCjALzlkdbA3bFtPYNRHFWNLbQnyYt+GQykiZs=;
 h=Cc:Message-Id:To:From:Date:Subject;
 b=Xg4iZuphSr+0rUcemLl8wjZXAMNsJXBV4IeYCOmd/jo2Cv2DIMoni0kd+wMc0e+Rh
 /yH5bubwR2d+2h5zYyFgzXPJLJEXmX5zQJQRw7PTh0LO3daFY5sWliJ8t7X/yTWrIx
 wAvzcADlCkxwMJrfaQ1bUB2SuSTkNj8lIDrgnuxY=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 04 Sep 2026 09:07:50 +0300
Subject: [PATCH] riscv: Fix IPI not initialized in riscv_cpu_setup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-fix_skipped_ipi_init-v1-1-3f4e7a10efe8@maquefel.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M4QpAMBRGX0X3t9XIJV5FWsPFl5q1SUre3fLz1
 DnnoSgBEqnLHgpyIeJwCYo8o2mzbhWFOTGVuqx1qyu14DZxh/cyG3gYOJzKWuaGF+ZxqiilPkj
 y/m0/vO8HEDQuVGYAAAA=
X-Change-ID: 20260904-fix_skipped_ipi_init-aa5575f55bc4
To: Yao Zi <me@ziyao.cc>, Michal Simek <michal.simek@amd.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788502070; l=1137;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=GAWMjORbVlJ63PXYEZun6AEjhmHbc6Ok6jUFHgXEl8w=;
 b=wLcAYNn8IEqyEbYOv327x/DfzNqeE3mwRkFkyFJ14q1RoX7pbVwULRSXcOFiHLql9iMbGSuXk
 51vnnm/RY3TA9nFyh8+N5pcv7HD5ABVV6Z9Hk+jX4wH3ndj2JcJ6WzA
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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

If riscv_cpu_setup() is skipped we end up with riscv_init_ipi() not
being called.

But we still use riscv_send_ipi() in spl_invoke_opensbi(), so even if
CONFIG_PHASE_CPU not set we still need init IPI and clear pending IPIs
on harts.

Fixes: d8810e1d4f82 ("riscv: Skip riscv_cpu_setup() when CPU driver is disabled")
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/riscv/cpu/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index 3bec7c7cb6d..a65e6951384 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -639,7 +639,7 @@ int riscv_cpu_setup(void)
 	struct udevice *dev;
 
 	if (!CONFIG_IS_ENABLED(CPU))
-		return 0;
+		goto init_riscv_ipi;
 
 	uclass_find_first_device(UCLASS_CPU, &dev);
 	if (!dev) {
@@ -687,6 +687,7 @@ int riscv_cpu_setup(void)
 #endif
 	}
 
+init_riscv_ipi:
 #if CONFIG_IS_ENABLED(SMP)
 	ret = riscv_init_ipi();
 	if (ret)

---
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
change-id: 20260904-fix_skipped_ipi_init-aa5575f55bc4

Best regards,
-- 
Nikita Shubin

