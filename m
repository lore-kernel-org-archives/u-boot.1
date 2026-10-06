Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B65CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94FC460649;
	Tue,  6 Oct 2026 15:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N02HI1Gx4A4k; Tue,  6 Oct 2026 15:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6A951606C0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791302359;
	b=ilgTwrTNOPvM5aobY+gcCEGJS8lBzxL54kZxinLPC3xpknOVY8ThV8RtiYAybH25gU6L
	 puHxXxd6zXPiu3v4A79AMiaRQKLjvGlwprYcTDIa0pysrY/BjnjZnQOvx+w8Kv3FXa4Rt
	 /5yHwoCwvY7Ia7uFNzdo8AxkhGvlfkFe3WZ7RZ1RIY8ilAqRy/X9IQtv+wEAckBtpurLy
	 31bGs3Wza5WYjpS2mLIeSX2/ehWyTSO9pvvpbXOzdBIyRmj0N2fbF8DONfsIyG69o+lTY
	 uBuOD/pgnWaszyCk+aimYp/x+dcJMolvfESXUXxKBUuuIuodDRGT9cojWU6TRR7nu+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791302359;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sUjOVku3pnYQjhRe/yuzNHxnvmDAZlW3jb7K3IzUH5I=;
	b=MIRy5XHYi3qTuae55txy1v93sKAJ084z3PEWc/MpLpWZLhnik1UCeI6t9SfZ3LY+38r3
	 UqCPMliEuEbQsejXhy/G6sPwQLwvSUoiDQsmu3cJhOI+YHlnh2SV5/3BKX97aJZvRBdHn
	 My40CXO6gksKKqsJYfJK5a8WCwEvGsDywDPirCnCrSVaekzEPXa0G3F2KB6F7DhPG2wAF
	 L06f81LQogsjsNB9GFfEZTdQyhZ8j/LhrD8/AD8xMhUi3ppOe1WVEFHgZGB1QjMdMwJlZ
	 ATSBjvzgfIat2nsoU9vgYjm5NqKhVF7DojijdCBZj7/y5OM2Krsb7898ftJbAzP9jJw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791302359;
	bh=sUjOVku3pnYQjhRe/yuzNHxnvmDAZlW3jb7K3IzUH5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V6+y0CYmGmbPbGYmr+IhT5Oji7HpzMKxe3yzsDr3BnTMl+dfTOJaG3Agq//cAByuB
	 moPAImLaSC7LIuD95kRSLqvxH7UgemkfgyO9JO2GFLoOABA684GqGOR9Q5uq6DWU5l
	 ADmC2kFEA9G5lVfReW1hAgWs4ZdPyV80Fwi04QnHt6J0vNTIzSWipkE8B5OdfwwYAw
	 8dTAsUGD9yuHclrpv5VDink/3U2a3i13Mu45vE2o6Vb1duwF3sKaR1VDu6VF9oPjMf
	 mcUpXonLvdh/ajO3lU4dNMn9zyhi70jroh+CP4FTCosgIPR0RZhXyZmo82UGc5Ue13
	 yQz1Jb1WScFSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A951606C0;
	Tue,  6 Oct 2026 15:59:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06E3A356
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0F2E402B9
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKGDVqlF3YvA for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 68F75402AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791301943;
 b=qDBeV8VWheuTr5hO28YWZXsNvkzYbEqpmImvcth0KBNdcoE9BXMo4eu2fv/kWQz87rUA
 jUkRe2JtPmorCvZNhu6Vh4EbCBeZsJNT5gx5I7lc81wAW1g/kDhwUAPqo6Mj5ogpZh8UO
 9TEwC0GqGclVjigKAR3P5FauGPG8ni7PtZSGHbkOUz0HpbjjgQnIYKt+8tsnKkB2dGUhX
 NOk/MCIIDeRstBVBKuHpfeiRgiXRrR+V4NRpfC7IKSadf6uFc0b411AhmRHYs6sdnM2nx
 44LOCeaC+sg7Zf77Fb3MpaZCFXYUf9t047iPmIouJO74br4wlO9MIHp8XSy+tsZw1Zg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791301943;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=sUjOVku3pnYQjhRe/yuzNHxnvmDAZlW3jb7K3IzUH5I=;
 b=hLxpLCyX+DsKZYKhksyBkATWKd7Dc/KxHEvG0z8jgncof69ZqJPGvHuXcH/VSNZZGToC
 7aR4kOpVWVyiUcf5nhV9cAc1a6HIERoLu8QMsLjyoc+Pdbi3SUSSlICg8iY/Jf8jgwWUQ
 NCXduFx0C/0gKoGuregJ1nzRngnUw93IAM6gk1Qmu5JR2nB8XBG3+rZYbW+pHF64MV01L
 E0RFuag557NzPLIn1VUkbyxUwuiEdoLRePoxKX2VxWfH616LfQCX7G4Asbu94YGBUNIok
 h+LxCtgY/JFyXCTD2rnhsjEt9NQZrqw1v52ic2YAGCP6FX0aqom5FzWNPRWbjoJYVaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=TqFodTqI; 
 arc=none smtp.remote-ip=185.136.64.225
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.225;
 helo=mta-64-225.siemens.flowmailer.net;
 envelope-from=fm-664519-202610061552197f15cfe3c8000207f0-z7w2qn@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=TqFodTqI
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68F75402AF
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:52:21 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202610061552197f15cfe3c8000207f0
 for <u-boot@lists.u-boot-project.org>;
 Tue, 06 Oct 2026 17:52:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sUjOVku3pnYQjhRe/yuzNHxnvmDAZlW3jb7K3IzUH5I=;
 b=TqFodTqIu900VkyXG0HlQ0ICI25kunRjNIyh8T+ng/ggE2PdBmZBEofSgdXkhra2+15262
 JXeWUhE18jlkEkqVOWqp6CiGrlUd60weN+y3fvZ488hnyrpS1HcFWRrhquxYfcsSU1mMZz9D
 OIKICfbbavvqD+GEst11P7EFZmQzvMlLOFZRSWSYgFmIf5pGo0SEoJdVO4RWjgRmn4cD9L1p
 EXuUZJ/9bfmO+VDYRsrW4pclr3GCffL5RcEzb19Ztb9B255VnlROrLyV52jnYg3csVWZxGXE
 3BOcWZsZ+3YrouKtAQbmeCayTkopykJ+uiyY2PoPJowNDMUmxM9QtWvQ==;
From: Michael Haener <michael.haener@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 3/3] xilinx: Use CONFIG_TPM_AUTOSTART on Kria
Date: Tue,  6 Oct 2026 17:52:17 +0200
Message-Id: <20261006155217.187050-4-michael.haener@siemens.com>
In-Reply-To: <20261006155217.187050-1-michael.haener@siemens.com>
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
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

The Kria boards start the TPM with a 'tpm autostart' call in the board
environment. Enable CONFIG_TPM_AUTOSTART instead and drop tpm_setup from
the environment, so the TPM is started even when the preboot script is
changed or skipped.

The TPM is now started before preboot, so the TPM reset hints for some
carrier card revisions are printed after the startup. Boards which still
have the old environment saved run 'tpm autostart' a second time, which
is harmless.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
Changes in v3:
- New patch

 board/xilinx/zynqmp/zynqmp_kria.env  | 4 +---
 configs/xilinx_zynqmp_kria_defconfig | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 89f48c03586..ed6c1d7ad6f 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -66,7 +66,6 @@ bootmenu_delay=5
 # Enabling PM nodes for uart0 and can0
 kd240_setup=zynqmp pmufw node 33; zynqmp pmufw node 47
 
-tpm_setup=tpm autostart;
 tpm_reset=echo "!!! For TPM reset a full power cycle or pressing the POR_B button is required !!!";
 tpm_kv260=if test ${card1_rev} = A -o ${card1_rev} = B -o ${card1_rev} = Y -o ${card1_rev} = Z -o ${card1_rev} = 1; then run tpm_reset; fi
 tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
@@ -76,5 +75,4 @@ rtc dev 0; \
 zynqmp mmio_write 0xFFCA0010 0xfff 0; \
 if test ${card1_name} = SCK-KV-G; then run tpm_kv260; fi;\
 if test ${card1_name} = SCK-KR-G; then run tpm_reset; fi;\
-if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi;\
-run tpm_setup
+if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 2eb4fe4e8bf..2f9d6ccf98f 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -222,5 +222,6 @@ CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"
 CONFIG_PANIC_HANG=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
+CONFIG_TPM_AUTOSTART=y
 CONFIG_SPL_GZIP=y
 CONFIG_TOOLS_MKFWUMDATA=y
-- 
2.55.0

