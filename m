Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E21ACA5FE8
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 577A1813DC;
	Fri,  2 Oct 2026 21:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MwmeecPZDjAB; Fri,  2 Oct 2026 21:31:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6F38C81379
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976677;
	b=a6pb4i2xnAgDOnJs4sxae3ZK129qwXqJQ2ez5SDeRzZhun0kzwrUe5wC0PzBj5Wf0lYw
	 fFMOfVpvF+7JEXHCEzwQurZ1c70T6DFN1jfu2VZqdagFQRtC/j0816o8gf7fGi4iIeL5W
	 dFCzAEjA+wye4N+GtYoUIh8PggenRExJTKX+YAOM2VyYbd1Rp+LcR8Af8AFRup9ZRGK4H
	 QtnLw3s3tRn7tbP28Cq4Re3hatdamYNMTyOSDzphldyZjBAGw7WnB5m0ZWgRwQs/uLh/d
	 /lmAbNAVGiexJ3AoJlUMNhSH7UHxtwwL7PjsOUTf53JrURp2eA7ZGNsKR7HotqUdJxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=piRqUXzZiHMOEhTkWxFqhwZujdAg2wplI+fDu+c743s=;
	b=pCyn+wsKENAMuL7Wq0hMBaab0nmp4nPnhQR9+WfUou5XfGbqh/f3o7jRR6L9NM+PU4On
	 46JtS/SvNXsC3+k9nY7poA+rIf7dNAoMvtfp1AYLe+KJiNXOaRHKK2fX86Xsl7oz5H3AG
	 vq/PygNUSX00YvW7QSpXQasFh/Q8wovZ1eZpAh4PZt0h/o5Wlgn1sX/26ILMyMr0WvsKU
	 99hB/z8IfFCqWGwdgYfNtB6sMDrBQ//RTwkmCW8f4HBUNEBaZM1kamNZ74kzEIGGAj8Y2
	 fDK/0S/Q/re4/dHnVPAzwIHXJDADgjeYKwkmRj/TwWOLVrNk283lrgCfsP7yQo9ljbQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976677;
	bh=piRqUXzZiHMOEhTkWxFqhwZujdAg2wplI+fDu+c743s=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=S59hDmhRaLrBu+2J6YN9EJdjMzERQhUQm65w0IlzFVkCKce5i1EU/MTpWA3V3aJoP
	 FwCYvqsnxR7GqLnL0c9LBY2D92+RrJkadfESGtLt3cBu5klALsdG2D+spWxqUCzvZm
	 bdzkz9vcIkP7K3KotyVMiMPNoDlfYqSh3EqYJFG3/qD0tfYXzW5L/tP1giURcJbawh
	 fxvLpskHVdPRaWmF/WGO+9DxaayEMjKt13YlEGbITlKQmVCYpoTee8l7DQnWCweBoc
	 yT1FtSd+MbOnuwtup1VrGC86NNDFjli9sszTsI+NbBylXK5lLZEDE5J5tQ7631GKkS
	 lgupJr7JjmzzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F38C81379;
	Fri,  2 Oct 2026 21:31:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB32D282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D15A040DC4
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:49:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ANbByTBizBLT for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 19:49:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3EB5340CA6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790970569;
 b=mcTt8LwTLCX3/NJu66fYri1yvA+VSL58X+0oFahp4rj71GzCUOmfLjIb8SJd8DjefYFJ
 IMj8ML+JP7bC2SZxa1DxSgoCgWv63JXdFGd4atGeIkN09vns98rzcwRCavJzUFwRdKI3h
 JI4Qq7MdQ17eAEloN5WVrB2G+u5bVDdrtJrOlJIUTAYofmmuYF+MxwUYR4f0xTVGRhZ5c
 Z09JHiR+IffAOloVxRV7wpwMseBLq1K6e1pAhM33fFPIawW44WMXBRR8tYP3+G3iTwO4/
 /0dvLtMRzlsmaLv2dKQQJ5pElPv/kz65FGGBRwtKWED+HuPnEkCwOjsPe2q19kk04zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790970569;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=piRqUXzZiHMOEhTkWxFqhwZujdAg2wplI+fDu+c743s=;
 b=cBqCXQKZOOB/R6jLq+xecDx48Gd4YZefjXsv7nnKHAs4o85JWxOZ/hQdDk1pdqe39rPR
 LUh2CUClK+6PVi4LGPMUGkf2bowegzQjR0TVau0xhLbhIWsUPKAkxX/0Oqyju3OY6AW0s
 YLSASC8Zxht2Jk2W8JsIJjGL8UVQlmqexHG8W6/69ftucDAu2cS5dYakMyK8rBpAs0/G5
 7+ltyayZLjyx1gQmIgegbqV4om2ubn2MGmvB/MJGxqGkvEFiuaP0bEhxSDInZJZGCw2Eg
 xw5wdEBZtW2QF74Zp3OWul4QOvgczw3NAm3LYVg02Tm0zAnkz56Bg4oibuhIaBAUZ9A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GXgxeC2q; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GXgxeC2q
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EB5340CA6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:49:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 56DCE60AAF;
 Fri,  2 Oct 2026 19:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A6C7C4AF12;
 Fri,  2 Oct 2026 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790970567;
 bh=xuwLwvaxpGJ1SnpHxf9bXaliu/rB8vOjLhSw2Ho66h0=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=GXgxeC2qQzECu7SifG79kcOcWED+C5voBQrqT50L14j40XHAzzoiPppkTTRfK3kqo
 k8a9TFrzC4v44eo+dFieQD+otMYG0h6StLcrXhUUl84YAsKMbZ0xxcu6/JesJ0nmol
 KcT0mf1K7eRNQ3YPnnZ+zZ5r4TeLPsgQQW3PHm8+kmBfUVbxnxUpXptajqDnzuW2Yb
 6QoIwCQAf9cfUoMbL4Xb2pS80lDQTf0rDv7u7EHttYbERZj5e9k72JraazGDxStS22
 AS4u2GDD0bvbMzaeFtQO+jcKbfpQJ5Wr8vDzMDpkhywzwqgNR1/vpWD9jA0uMOKUJv
 vcakUq/OgRjDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D2211CA5FE5;
 Fri,  2 Oct 2026 19:49:26 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Fri, 02 Oct 2026 19:49:20 +0000
Subject: [PATCH] arm: mvebu: helios4_defconfig: enable device tree overlays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-helios4-overlays-v1-1-2e03eb306e38@iav.lv>
X-B4-Tracking: v=1; b=H4sIAL8KwGoC/x3MQQqAIBBA0avIrBN00IiuEi0kpxoIDQekiO6et
 HyL/x8QKkwCo3qgUGXhnBpsp2DZQ9pIc2wGNNhbY1DvdHAWp3OlcoRb9ICEMVpvXfTQsrPQyte
 /nOb3/QB8ehiSYgAAAA==
To: Stefan Roese <stefan.roese@mailbox.org>, 
 Dennis Gilmore <dgilmore@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=wEpmrk9QbEB6mk+TlnWcyRteT/tXf6DXqjhPx4OuQZg=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFkHuA7u3Nd6Y1FD1p3qfQn1yqlTbx5eKBGmaLj2ypK/2
 Tc4VcKmdpSyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJvJvPyDB7T4ps2i/mvMLc
 Raq89rVcR79lVoV9Lgpdd8jnjGNz6HdGhtesFo9nLRHvjLH/Y7s1K9faTvdOyp5Ef5maAIP5Lxo
 jOQA=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:31:06 +0000
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
Reply-To: iav@iav.lv
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Igor Velkov <iav@iav.lv>

Enable OF_LIBFDT_OVERLAY so that "fdt apply" is available and boot
scripts can apply device tree overlays on Helios4.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on Helios4: with this option "fdt apply" merges an overlay into a
device tree in RAM; without it fdt has no apply subcommand.
---
 configs/helios4_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index d218949e307..9b56d87ea29 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -11,6 +11,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
 CONFIG_TARGET_HELIOS4=y
 CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC=y
 CONFIG_DEFAULT_DEVICE_TREE="armada-388-helios4"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x4002c000
 CONFIG_SPL_TEXT_BASE=0x40000030

---
base-commit: a6ab6a66146ed0bf1420db0ee858b49005783222
change-id: 20261002-helios4-overlays-82e2dd1514d5

Best regards,
-- 
Igor Velkov <iav@iav.lv>


