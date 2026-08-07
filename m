Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92605C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 08:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51114811DB;
	Fri,  7 Aug 2026 08:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PlOgjxNa183z; Fri,  7 Aug 2026 08:14:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2543E811D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786090445;
	bh=37Ta4bO7piz3N3nDxZrfTdrIG/nCbi4S6bCr7Fq6ox8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FDN+GR1E7mBtmbmNrvkZsHvDr4T0bCvV4zB8+AIhnf65vk8eIrsRLXNEX68xI0yCR
	 g++keTBFHjhNv9lefOf0PNz7b39YmL0Ti3cEjcDz12TzUtFKQxEPAJ1JJ1D7to9nf+
	 504zWJU6X/tTpZwmaZHrCW9LxXppVv9jr81+54p33XGUXdzD77lWJYO2VxqMceyW4w
	 7k/+wtmnOmDIOLJdbJPcTjMkXvv4dH3CHzn+/+Ot6lFSUEeVjMvh8R8SBAfQjXIPrv
	 9MGSyY1gY7heZ70cTgUaL1xPsMxLfuKHYdc+NH+n+gkxRmgXesnXET8yXSCLwQyIWq
	 SOGzZqkUH8tXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2543E811D5;
	Fri,  7 Aug 2026 08:14:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46126522
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C0A8811D5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0SZ9lCI2aelk for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 08:14:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.155;
 helo=forward202b.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4B2C0811D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B2C0811D3
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net
 [178.154.239.155])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B2C0811D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:14:00 +0000 (UTC)
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
 by forward202b.mail.yandex.net (postfix) with ESMTPS id CE710C4087
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 11:06:33 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
 by forward103b.mail.yandex.net (postfix) with ESMTPS id E8580C0099;
 Fri, 07 Aug 2026 11:06:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id L6FKBuIeKuQ0-7saIv5hb; 
 Fri, 07 Aug 2026 11:06:26 +0300
X-Yandex-Fwd: 1
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 07 Aug 2026 11:06:38 +0300
Subject: [PATCH 1/5] image: fit: allow IH_OS_OPENSBI in fit_image_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-riscv-full-fit-support-v1-1-21a34f79c350@maquefel.me>
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786089998; l=946;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=2RoJ7hL5ybsriOKtkdLVSDaEYhYrWO707nk1yzVW5F4=;
 b=fFbq1PUImCCl6dANqg5827PuuHLSSQ/HosojC3xQBx4ZxgizcEhK626n6NCi/cOsuAOUmE2T0
 CjZGMPOD2NLB85BOiaUUbv5JLkBP1h1VGKJzUOQvr6+1WVWZZ/InyZT
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maquefel.me; s=mail; 
 t=1786089986; bh=37Ta4bO7piz3N3nDxZrfTdrIG/nCbi4S6bCr7Fq6ox8=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=khWBjsfv5yFKk6BZbHe39P+PVpusxW9HxcPwGQVfQCWCCUeN42rRIhbc0jKtGBj8k
 METsJv5Sann1Bvyj47OkOKxfMfKCiYR03bRSn+EWVKZAEGGm/uxkMM/9b1oWswgZuE
 ZMy7ySUCHSOIqcXKnLLVADqpqVLxGYmoban+Rwz0=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=maquefel.me
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=khWBjsfv
X-Mailman-Original-Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add IH_OS_OPENSBI to the list of supported OS types in the os_ok check
so that FIT images containing an OpenSBI firmware can be loaded without
error. Otherwise loading OpenSBI in full FIT Image is not possible.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 boot/image-fit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index ef90c5abd18..865edfeb1b5 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2274,6 +2274,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		fit_image_check_os(fit, noffset, IH_OS_U_BOOT) ||
 		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
 		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
+		fit_image_check_os(fit, noffset, IH_OS_OPENSBI) ||
 		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
 		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
 		fit_image_check_os(fit, noffset, IH_OS_ELF);

-- 
2.52.0

