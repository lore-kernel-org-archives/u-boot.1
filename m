Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F86CCF2C0
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 09:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCAF940A06;
	Fri, 16 Oct 2026 09:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q0MMDcbugbYi; Fri, 16 Oct 2026 09:06:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02DE840A01
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792141603;
	b=nExwQN0h5f6aABXaIvJa2mAkME8U7dbZwKGXueLElbhGJ0uerFoeAq8I86A5ErKyMSHs
	 3z7RZCffGGSfhstXb19JmP5+qfc/BMkvr1uT4oUENvvnCjjGZw0+SQUGI1eupIr9+R38f
	 JuL2euKTBGHEW/Eh9vrSg8bB3Xc4saXEVm1dkXIWojqAw41XwvagNzPOxHIVZrioRo53S
	 ceViYm0Zl+/Znk3TSX0+ZD9k9kG0YioqhMgwBGNGOBeIY+9deRLEKSjODMekXgp99aQr+
	 MZz40VzR7qGCuxJQz+6JbFBFtQ/wTGE7OBBJCZgtJHq5cynIRQcrVFkU+CaSMTvIZ7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792141603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=z+A18/bIQ2UGrserQHpwWQ5XCW01dF6W9s8MajIJj4U=;
	b=DD2TFaOsgjKpbc2hA0lrXIdBYgfaWgGGohPl4oRtx9nOinPe8Om6P7vnCDP5EM5XNZtn
	 74Aah8LFz3/boxi27iPUDtuqIkw7Xeoz9yBsgYcyN5e9GwS3LujVbf9AKbLATwiDTxr9C
	 YxmTF/9ltmi0/6TFhQh95XsXzg7jgvnP1j0AkJsgvn3/xoBMpByzVPJV7xkBraBCPHOg/
	 M9BcJBLrqcMcXDo1S95e25GyPtb6Z6WqZ4ehc2EPwZqsE81bCBKIvURHErfdS/M9wA3Mx
	 W6eLDVI9xc9fmy3xA8Ssu+hoW4T812QeI7NwOkuK9pjaTIIWeqQuYxvDUANO6yUslFw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hCGj8HYv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792141603;
	bh=z+A18/bIQ2UGrserQHpwWQ5XCW01dF6W9s8MajIJj4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JLYp36Yj+ntK604KVXcp7gY9c1iEVFBz3kkj+UZ5BOwG21hlB0aIKG5n/5IpVppXw
	 femL/DBIm1Yp7h5LJnxRPcWEsZ0uk4PRsbsPtc6V1OUDDphOu8oiyUd/oe/K6z26rO
	 8v8nC87x/4ENq95TIYfre2qhjnMP6pcZ4qPjAtxypf7XEKYNjUjZRj3MNisDJuPEg6
	 lC7ZOgRwP7JDGp+3mj6cBgyMcYZwsHs18YV6E5Ivm/YxOm12g//GjPCONGv7rIPG6C
	 SOu58Eca84vBxfHC5ls918fh25wKULSAO9i+xKS5m2MIOGfjw0WObYIYfxuPnfGcIO
	 EY90xeQew6vMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02DE840A01;
	Fri, 16 Oct 2026 09:06:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 878EA2A8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7922C409E8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IGODshJLQZzO for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:06:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5F225409E5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792141592;
 b=qJOhEFH1Nd4jkS+zcT3m4XjMZla8AUuqxhN3yqUEebEambNW2c6ShiKOfRHfEcnpOsjM
 /TCYyBFxBtxQw0dPVIbxdBcNaPKMu6plMGR4NlSEfL13s9ZOgr/9qS8ZFJjSamy+fOSIM
 k+G0VVdyge0UQQ5Duy/iJdbSKsmnpHI/aik5YzmxwV+nlMXUDCvqzfZ1zZI5OJVxm4uY1
 k8WfbStyHtbiZUDogtSiULhkvkK9I+36Gc2RxUUQuHx0/McD02/QOYSOhwSMnlo74JgnP
 yWOIyNO1V1crn5AzB3qGoqTtBSLTqcfqS+DzlEd3ojn/XGZD9T1gDXFAq/ZrPGcFsog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792141592;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=z+A18/bIQ2UGrserQHpwWQ5XCW01dF6W9s8MajIJj4U=;
 b=fbTqZAbfBXFGx/ocYBszuE7tswMH8cOyHpUa31Ua3Oze70P7ba4bJLpZPC3DSqAIHa5w
 XvluCbQ8HaaTIq2wbJeui8KfQCIyF7g0dKGj7Xwp5reSZal6LhlVGRApYWvV1jCOgm9K8
 nJG9vMcBt2OH4jWB9ZJFV2vrOq6KSf8zHwXjirJF2fPoM01GUtuWUOal6mYPekuk7TdSP
 YlFJ54qTzxqeL9veMO0pHCyxC8GeafmQHhuaQXugruYf6HW/gdbYU+m8F3D5Hmkrq0FWh
 28v5BprHQx/oms4+oW3bjM3RnBgfVZeIq5LhkmGcB2fP20q+uITqonnbJLJVMALIjJA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hCGj8HYv; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hCGj8HYv
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F225409E5
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:29 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so50453505e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792141588; x=1792746388;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z+A18/bIQ2UGrserQHpwWQ5XCW01dF6W9s8MajIJj4U=;
 b=hCGj8HYvGu6jAQ7wRWbJv+dExhtFLyhe7z0KnclIjTXmjW/YYmzml+l6SKAotcEm7C
 Ar73X9+c2+oEjxFLgDD+D0o1Sp8UtMWV4+U6RPrWZqSBkeO9Iy9eBI8i2Scb/mKR11Pe
 2SXFUdQdemVKm5k5gnPr65vRONwZECPlgSJQZBrGPApEfgYL2FU0p3y6fzoGPzQCwaoK
 oUKuYQl//FDydooTrsg3H+SW5eg/7LhMdwc5HccRKaSQUguZML/PVkHTwiVnL/VdwX6j
 zngyVkvfSWO0LalktUq6Ws00hlhBFnP8ly0sl6XydXwdyoUgbgvXOSHlWnLUEWQIQp2/
 WJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792141588; x=1792746388;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z+A18/bIQ2UGrserQHpwWQ5XCW01dF6W9s8MajIJj4U=;
 b=i5sOjjymMVvZYa/X4Ueby/sL+0u3wx9qgPjU/QyzVgiRzx3AD2tqqXSa6rb8cufPi0
 MD8MsNSdBaB3hGUx35gT44iooUdmbCrPc9PLTLgYPIoUuc4gFas7QH3u+YxhyJFa2jgI
 0wk/EmXwUifyLY1N1GurVXYDqjPSt1UUhxWgrbHiMioLnNhcCuYls0kbDT6pumcZw/E1
 q1bRJ3O/X5KRDf5YbbnmoeN3zDFb83py/BEatLR6I87rbw2szJd1QFb/CuRvM5YzrKbk
 MybDa6G+7Y8Xu6BIscDJk4mrc68/FOiDLcIvmUarN1fBcwMiuAnqfhDDiSfTemoCi4ho
 EaAg==
X-Gm-Message-State: AFq9FYIvvVyH58m+IL+H+bh2guS/5/592c81EiP/ImjLbYa/xYrusm5H
 DRFaxtdLEZhtJCRfBvEJ89yWk/NHCxOyD1684Toi64c4zSbCKa9qLActBMyMrXj9Hld7OVjRP1E
 tO5Kl
X-Gm-Gg: AYBFou0KQtVCVW6AW9WxxVptnjiFeXXH/QhXAeSN/RYh3NpkFL55V1iQ5hrhrQEvjfC
 DCPV/iUUtv8IYHOF6TJ94lNmEcRlJagoF+lGmCDBNFesHAJzlVln7HHfmVWyeDKaenyAUpjjX+a
 VoeWSfkLyMeUOamaTxGmtynIRQW6DF/w8QP4zToPP+rPmKuGQPJXENwZV5+AR78ULTtbFp/HNS9
 0bOsd3SmjmqhetdgqB3Put5TUvgrRu5Vh1kFDEUmJb5j5aiINEiGKbYV/nU6zBq+JB3doUpZBk0
 QsONvgtC0jdcBdgB22i1nfJcij7WpsfPGCTlF2Uzrfau3i9xZ0kPSbCPY290WuQgQWS0wrWfDMg
 4S4Q8qRJaw5Jvu+tvdZiysNkvXNrolzz5wmwuZK1yxq0j82g6/dPPfIiqHpjTNnWsGyNFh2V9Un
 vsgc/EHLlNpi35ueeZeWRw7IHa+I/4COEydAN3Ow13ZJWY2U8RctyuKS8QX+tHRjIeVCin1Xsxl
 1bqCOsZkIJMAus=
X-Received: by 2002:a05:600c:4ecb:b0:4a0:c01:1902 with SMTP id
 5b1f17b1804b1-4a18e43a29fmr442109135e9.2.1792141587890; 
 Fri, 16 Oct 2026 02:06:27 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm121287685e9.0.2026.10.16.02.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:06:27 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 16 Oct 2026 11:05:55 +0200
Subject: [PATCH v2 4/5] arm: mach-k3: am62p5: Wait for TIFS initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-4-c7ab53f79b34@baylibre.com>
References: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
In-Reply-To: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=msp@baylibre.com;
 h=from:subject:message-id; bh=VOTZUT8wTSGQKtREYaA8BzYjmWPh16ZdllisT2Jd1ec=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyLL9l8WBlzxHj9rnLZMTWE3v6T4XYsceLRDY/s127U+
 nZoa/X0joksDGJcDJZiiiydiaFp/+V3HktetGwzzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGDFwcQrAVN/tZ/jF5HGmZsHdzATDN1GvE/3dnC9+PF+TqOh4js0/V3nGhF8cDH+lpA8o+x6
 LVf4k83vC803MNQK3K1bFbs24ERt2XcxVrpgJAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
the firewall on the registers at the end of initialization. On HS-SE the
U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
leading to a race condition. This leads to a broken watchdog since the
signal configuration doesn't succeed because the write doesn't take
effect.

Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
ctrl_mmr_unlock(). Note that spl_early_init() needs to be done first to
setup DM.

Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 599ea7cf2dd8..5a27e18f2063 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -116,13 +116,14 @@ void board_init_f(ulong dummy)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	ret = spl_early_init();
 	if (ret)
 		panic("spl_early_init() failed: %d\n", ret);
 
+	k3_sysfw_wait_ready();
+	ctrl_mmr_unlock();
+
 	/*
 	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
 	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.

-- 
2.55.0

