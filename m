Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40039C55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 087EC80A49;
	Thu, 30 Jul 2026 13:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U0zOmWimR0J5; Thu, 30 Jul 2026 13:35:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CD0980D8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418502;
	bh=x2h+dFief8CUvC1hqSoAc3vVv0+/pkPTKwdqKt1ZS9M=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DFjy3/Uh+NtTV7b9ymq3jp4I3bxHBa1tRIT45XJLfMVEcQZink2DT9diQ0q2VR0re
	 DHZvYZ3HfY1kmFkCiDZzLAduThlbUZCJt1+iML5zW26//jKk6VQUm3vAc82jfnbofC
	 hr2XrsTXDQkFydW65VWk2gOPjVlf6yfITaLnPPUAQHZl2yvNMMMKyiktcmF1EKxxEe
	 HyFAZFN6H0YSBjr4VLd0a9TSQ2m03LrqxNoFG2IS9iyT7Jo0mEU9Df1la38wFVfF7R
	 v55QNWGtiVlgMiUPECd4xhQaAogQX4ftQTfYEen2tCD0qFOLQprKe2at/kouyUZzSQ
	 dAIypzIe6JH7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CD0980D8F;
	Thu, 30 Jul 2026 13:35:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8210669
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 734A840AA3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Id7Ikn85xbiq for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:35:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3B8ED40AA0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B8ED40AA0
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B8ED40AA0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:00 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c166ec26696so34481566b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418498; x=1786023298;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x2h+dFief8CUvC1hqSoAc3vVv0+/pkPTKwdqKt1ZS9M=;
 b=bPJjHUpXL3onSf0qtwvfRgnXftM4219c176Q91tfaQBalbq41r6T3aHIQnrhdSwiKH
 /I3toQo0QGa3CG1HjpwlGqAosv47Crz2B3YvGH1CJO94jUWtT68m8Hyb3PCYCW7leTN1
 qex7oPCBQIc115DailqZgzpbtO44gEKc3RJFon/0usKyspjZXvRV1kUkXqU+K0HkV6a6
 4WuN6p9J5EkH/CxQh3fUYtkXxURSqQ3QU8Te93UepRcx8IzGQgN9mMcYk9kZyH9SuWXS
 re+pWJEKbaOXytNdOfN4SagwEY3jXnIShx8y5bXl+fzmPaAr6Y0RHL9PzE9pAdIIBx+K
 HGhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpR3S8EQgz2tpAaLZXVkzPzsH0exmwLynuTR0jiC6ULC360SL2CRxwIcY3IQPKWcOh51/qMnD8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzLGqpnDt9uCyI4PfgIWgojS+6BGrDw0T+e8sYzJdooEemi4YRE
 PYDLQRzrgWW6v6T9lnK4p3CsZzgxbZ14CJzy6NpmU82ENIXTRysNPMkt
X-Gm-Gg: AR+sD10N1QkpiDzxX36umO8OomMH0l01ANS7z2oycculeWy584OJ9EHPTKTRKkE+dNY
 4lPRFK7qsyuJxueyhDijxap0vbi34W3MIrT+7lp8BMValjyGPMBe3ENK64bvxguK2gMWJxvX7qY
 52L/aR3JavN2jikldbfWzCagfoAJz7gFTH/mhQeLoOoF66o9RaDSOB1HcOKHKgr3TayeXnyjb6m
 P967YHEEAh/IOS2QHoTpi+bIgDAXtmuME79HLmwDzImoP9E/19OX/0PACeeZ7xTpJppcvYGKOCg
 LDKxCBKq+bumANO9Ymq+tbC67VGUBxDVQNmH7hSnK6HBX41G0W/1OvPeJCvHCPNjW2nc6zdhNxT
 1ugrIti8O/erk44s92ISoKvWSeSu1djK//7KP2/kLtvObR8z99m1Sysl3oaeKIk4L+MDU0GMgvL
 Gsxw4soSLN1+WPXV75T2dB4EhZFp9X0OeqMINwZ+uZl95uemStOuNBFHcXZJbF8XKzr5ziTvn0h
 c+pVJkbDIMSMNTigCvrt9VtW1A=
X-Received: by 2002:a17:906:9f89:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c1fbcc1e9femr30073866b.4.1785418497604; 
 Thu, 30 Jul 2026 06:34:57 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8bb6dd7sm68582566b.52.2026.07.30.06.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:34:57 -0700 (PDT)
Message-ID: <4d7b7705-62d6-4b61-840c-ef1dd28f9435@gmail.com>
Date: Thu, 30 Jul 2026 15:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 07/12] rockchip: doc: add boot medium layout text
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418498; x=1786023298;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x2h+dFief8CUvC1hqSoAc3vVv0+/pkPTKwdqKt1ZS9M=;
 b=Bhl2F5wqJDEBjDuBhwhANYkUInyzESq3oQ88kWRe3mjlbQR+zc63g8AvStVKhEcY0R
 4V7UONVZO6LWAUHZtqfVx0MVJw/DOgWEZj0gvRlHNU1fIDMW6s/f3ssLJfoXWYhT4OxA
 gWgLLETFgM91BIiA5/ydldFsagojpOoB6orcns9Xx6YHX2feAbFqjF5y2LO1rjK50iin
 VTXwIEaud0MpzDuBE+oRtlgIqGgPwpjbS5UvZ/gyXxp+hi3+4eOeyT3V+0aCzqIZs+ie
 sClKEa0MFCLSSqpE3u3/Ua6C9ZJj3IjujPVAHbMKAJWEK61xArOPz5v3pwQE6p8mOk6l
 QYoA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Bhl2F5wq
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

Add text that explains the boot medium layout options.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V3:
wrap
remove 'the'
use eMMC
add unit and block size
---
 doc/board/rockchip/rockchip.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index c089419b65e5..6b9007103257 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -353,6 +353,32 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-

+Boot media layout
+-----------------
+
+The boot ROM only checks a boot medium for a limited number of pages or blocks
+for data. It is not possible to place these blocks randomly.
+
+* eMMC/SD card:
+
+  Rockchip uses a unified GPT partition layout for it's open source products.
+  With this GPT partition layout U-Boot can be compatible with other components,
+  like miniloader, trusted-os, arm-trusted-firmware.
+
+  There are some documents about partitions in the link below.
+  https://web.archive.org/web/20260501050119/https://opensource.rock-chips.com/wiki_Partitions
+
+  Write u-boot-rockchip.bin to block offset 64 (block size: 512 byte).
+
+* SPI:
+
+  Write u-boot-rockchip-spi.bin to flash offset 0 (unit: bytes).
+
+* NAND:
+
+  The closed source usbplug binaries and RKMTD use the NAND erase blocks [2-6]
+  for TPL/SPL.
+
 BootROM mode
 ------------

--
2.39.5

