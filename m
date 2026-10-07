Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9798CA5FFF
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 19:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C3A0406EE;
	Wed,  7 Oct 2026 19:39:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KmC7vUF3sh6y; Wed,  7 Oct 2026 19:39:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C198C4063E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791401976;
	b=jeDlWafTUMOnADuajJNJWMw8g8A4pz5ZvcXveera2mZEKhazrDvw4pt1iQ1Tb5XE1lMK
	 fjqZW3Q+3BmzdIsSOZXDtvK6H/Q0SUkB/AuTJHmAwAEEBRlurhnsGPBb//N0tT/XS5XPF
	 AYblijZrCVQXwBbwYFQm4jygBwNOoZf9yqZ631uqVslEQa3dinBvzgdJh8OwcTO4pY7xM
	 RnbMm0LsvpldbOsfOD2lXo4Joy7LmNgvUSWHVtN9pkpu05CaaFXlJ9PhmVPLEpr7wH3eD
	 P/OKUanh/GFOEHo0oA2Gd9pWCPsFMWvXPmP9NQadLfiGR++NdxG9kgcepU4msx0qIRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791401976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C2FkYIZdrlsQsOAM8KU6SWux2iIgpkHy3vOK/UfQqew=;
	b=rVEgjsYrFwSqOy8uK+YHBdkg2hYVtT+nVjSgV6z+sHAimMu2skJaj6M99yaZTnqohWD1
	 mYmFb9FfFgeCtb0dlhfnjrAWlQj+UoFuhe1SKpnBzi4UtBAIJ1Dgu1R/IWIqMyYdSVVfW
	 q3F1xMwxmlQevswxo9igUBO6XEK2CqTnpHW23dJsH88dI3lWIJl0Fx1RIXcW9RFhpygAE
	 irymOTDs0Tj0yIHhR9+VDI7wX2kKINakGYJMkUMOLnrm9O8B6MuXRkysd/OoV1IZ6yjpv
	 vz3M2a3TGPY+ZGBanly6sMlVuF8tr3Nhxr3JJEt20CFTBMF+pYNiAT9JPve9FPD6m+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791401976;
	bh=C2FkYIZdrlsQsOAM8KU6SWux2iIgpkHy3vOK/UfQqew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JVj2kYNf4EtVQr66G7JAbdJwSDud6G0RBSpReFjEQnepPNFLrS42cygsrg0ePA/5f
	 0Wsl62Ayu8ildMeanmesmVXV/BOROlhOD9tju16xYxG4NxWwqYSPMk1jwsJIzsyJ/k
	 dE30uL7msp/Kh/aR+jT7G6H4ipYImIzQf6E9PRBiaQLkd6bDC3UekbQmf9GCb4yUbB
	 2mp3tJ2HnezeTxp+mW8fqW3fKQaieXb4T80bpNf+M6PAB8+dDuoWSh+h5Kuur1qog6
	 qLUIqytGdgNl9xTSEF/l8gE6DQtgTQ8o4SeEk2OizoSOxifa8PbZd/SYxsAr4qnztn
	 3f6AijDR5Nk2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C198C4063E;
	Wed,  7 Oct 2026 19:39:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3E2475
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA3AE6082A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lgQP4sPXe6SZ for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 19:09:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BA3E06081C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791400155;
 b=gJvYGikMRG6YFRI8dGjOL5Tz34mQYF6RGmAfFReErB1/fuqxxpu2/OtgPuAW+izBN2LO
 7qV3o/aRHrlD8G/dPE1BHdW2+D6nbJW+UlAKPBA3hBLkjUl8tTCou9x4cUsuRGCKMBvXV
 q7JMHr/Qvn/lYnUMZaBsgKEcoKtXM9S5Sd6r2iJmmB9GAwNiNfyddTLHaCb5JNzWeydAH
 5qpZCI+Fal+oS6PxtV/mZUKeJbzw7iA/0aHi7+xbDqMwG1o44/2tlqce57VtXfLTN5vk5
 wRn1BS3RA5JAk1cVQLkdWcBjOwGX5codNdA+OLxZK54VlIE0qUIG2hrZ+3I+qeYcstw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791400155;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=C2FkYIZdrlsQsOAM8KU6SWux2iIgpkHy3vOK/UfQqew=;
 b=fKKm/yQNfndZ+hxJCYXJCkjEqFP/0eofDkAaMkfvAbBWI+KZN5kwAiOxkap6btrFHXZE
 H5NlGnwiHTVjKK4tGK4PaRKK4sAOOO2uqloK03jz8ykdhtHTDD2Rj2cw7B53lLEdfKfnB
 fL4BLt90N7rlDv0DttR2DaiAQyofXzvSSfvtb6Lk5AUOSvgR5hjASo8li4FpwRz09g3YM
 eZd9bUpNVO3GjLwfRW7/EgzuMroqLJr9mjiKoWN/pwB88cd5mXRG6IxVbyLJfYO7Lv/DX
 GgE0YBZX/CCV+ps6f8WxIzsivgGC69qVqBgZOFA5Jf5qJNut6Qz9bl4TEVNpw70uU3g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="Y4+/3KRM"; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Y4+/3KRM
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA3E06081C
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:13 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5DDC43FC45; 
 Wed,  7 Oct 2026 19:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791400151;
 bh=C2FkYIZdrlsQsOAM8KU6SWux2iIgpkHy3vOK/UfQqew=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Y4+/3KRMcf9H4dby8tg3BeucQfJTYCBF3SP0yl8ezkpvw5wiKDxd2a03KMnusaiDM
 s+tCKfVMWbfqRN19kTRqN483u1/RGGBWJHCeMR1KfLbS1Da5ub3pcYWjZe98FAgzqb
 GSLavHywiHh3q3sMYX+oVEpEK1j9QXt/m5uWeUiO2CM5FCXj3sVCWQ+sLEBdMvjDWR
 x6nB3z1X5AsdwoofW6xTn+tYjRUU81VG/6zSv+3EhOBoSjjgnEqcXkggKL58hVZ2EA
 RPd6fI1TpjQm3oyvrLohDVTnbwnvCZgfzy1fCoj+GHdyJlF/sztHI/2FGo/+a3Dwo3
 FfrOUe8GqRE8Tg3T5JEhBGu3elWq1yXdzVQv0AGBRuWdRZ4Wnseexvti2VmjvTtnt6
 h0fechtDVcT/Usb1x9BrkH5Vhh7OmrFMGpfn/y8c+5y0KkcN2up92zAUBjYnH6hTfl
 ilIHn0NLbZSL9AQITz1E6ICS9vGUB51gjETAXs82SsXGmCKkfcgumO55KQyV95uH82
 CM/ffBLVKDx6c4X1OIMokaa9RUFMHpN+10SVyyUk9n0r6kQUlbVf+RsQutHom9gCmE
 ZasMi5zgcXX5aLhOOAsfj9vrDPrPDH82TnU06S1eeEDrOCCH2Hno6dQ0I1DHbcqtND
 WK8q+mytdyRSrIDIeYUcJEBg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] x86: use x86 QEMU sysreset driver by default
Date: Wed,  7 Oct 2026 21:09:05 +0200
Message-ID: <20261007190905.29585-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
References: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Now that we have a sysreset driver that can handle both reboot and poweroff
use it by default.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/Kconfig                     | 2 +-
 board/emulation/qemu-x86/Kconfig | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8d63afeb138..1c3035fd2a6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -340,7 +340,7 @@ config X86
 	imply VIDEO
 	imply SYSRESET
 	imply SPL_SYSRESET
-	imply SYSRESET_X86
+	imply SYSRESET_X86 if !QEMU
 	imply USB_ETHER_ASIX
 	imply USB_ETHER_SMSC95XX
 	imply USB_HOST_ETHER
diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
index c1564fba7cd..31bbc45c868 100644
--- a/board/emulation/qemu-x86/Kconfig
+++ b/board/emulation/qemu-x86/Kconfig
@@ -24,5 +24,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply VIRTIO_NET
 	imply VIRTIO_BLK
 	imply CMD_SMBIOS
+	imply CMD_POWEROFF
+	imply SYSRESET_CMD_POWEROFF
+	imply SYSRESET_QEMU_X86
 
 endif
-- 
2.53.0

