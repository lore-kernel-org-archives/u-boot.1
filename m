Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67346CC6B19
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2561D80A76;
	Tue, 13 Oct 2026 16:48:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9eyEQ6qzCzAf; Tue, 13 Oct 2026 16:48:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D08980A88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791910113;
	b=TAIGGN9ta1dhFy4+XRQPRhBYdJPNmHYquyNUGeMvFZiXJrQzQ/rb1UMV7ADvN1S5Xh9O
	 mVEw1Wj3u4SkkFDKIw8eOCxRhW7kioDUyixlEIru4yQMkzs6aNW75m2wU/sEP6JtJyW+y
	 k/eiD/0XI3wA7a1uBdh3GzKPbRp4aTPuoTOcWsRMU50HmaAR9qgQdguvG+QmtzqBgm/xI
	 t1jUiiVKMY0lhQTTJgZJ+fyCsAwwk0KoDqAN21zSUQ571dmekiZ/9ME6+InHyVMd+66ow
	 47yQLmWalQuF/dLn0nwWuVSXh3olhsSgKpQ7kAHV46SvlGICeMs8Vr/i0W9BCSkGzVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791910113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=j4XGP4xl2SWBh8r0lXbsf/zSNJw1lx8/F45ZE5IqlTo=;
	b=IfRhqLnjmcBxkZlYaTb/zBP9/bcAFc7hgjlbpDPGC1Y+vUDFfIIT3wjm8qQItu9w/DW6
	 Eo890kGi+GKHIgVfCFYOxNpJ3hKRy76x3P32sUYQWFT7s6K5DVu16nsILEdsjZUl54uzF
	 BDX5r0X3TQMKhgWMMphryFx5NKfBDst9FKoSmbKojVp19E6kt21gVDzqJ/0f1NLJ9k5DB
	 f3/CtbsEMoE371c1lgS8Q+m2hxMI/le5li6wqlotkRSb/JdxHZJIolgtaOgOj3F7qLAH3
	 Edvcnb3abTp8NQgNFh/6uAVzyY/1UXUTSFf3oEQycYG/D6JygVD7sBV4wHdpnOI2VGg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791910113;
	bh=j4XGP4xl2SWBh8r0lXbsf/zSNJw1lx8/F45ZE5IqlTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=L34hxlGiEfVzP3/3pnOB7U6m0jYvL1YzF8PjphRCLNjfFcfz/quCw7r7IjHXx/i0V
	 QvPRJP7xLSGayH4xrNKiKR2IhV/TwYQ3SvTTIKm3v+44rOn86wjcccPfvwRidYcz3X
	 iLntGw/jTBJoG3zUWHpsbxgrPNazXEVCvF9+d2kzDDafAUnvH5Fjb0oFKF8p3zTndk
	 JJuMf2cM3+/RilkYYwP8ydJzWHuCPDSDhXxY9bF3KdRtmezo0ZpdulmFzL8MPshyS0
	 DB4RT3l8XNyxXhaOoC0+nZGDETf3WT+blUtE41FFKkw9pgZwlkeCCJ7/IaAX0GPzT8
	 RLnXe3LskZQiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D08980A88;
	Tue, 13 Oct 2026 16:48:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C1051DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 224DB4009D
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0CVen0R0s1vl for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 16:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8CFC240049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791909218;
 b=muNjvQ4ya7Jyx0cFWReRROf1Hs8YS5xGnmDZAYCDGx6vMd91AaYH/6eqoLsiyDwOeOCx
 HvcPALmOsAP7fcbeGNZ9KsQRoqxugD6H7Vrljf+VNxqNo8ZfKoM6xqIKG5gT4RlAnwuYL
 6Mu/yBRxv1ngzdEZ0MC+eulsnuBt+iVMDpvyb4TnlAvFwshJHUSshEZQIDRssFUn3ZsGX
 ltouJHRyqD45FDA6bPTSF62ojjnjUxo16WIHbu/Kw2KCN41qH6T/8qXayVx7PsmRaYbKf
 +OhKa4BrRxeGtwWO9sIIMEDrevOBCxxMbnrVzTmYQqKVi373NBfEUkLSEZ9v4ZepxqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791909218;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=j4XGP4xl2SWBh8r0lXbsf/zSNJw1lx8/F45ZE5IqlTo=;
 b=bxrULT7Z7P4mENv2KYIZRAsxVwC8YLS+wT9GbRJb9Eh02HxHK9En+Z/9bBf6yjg4c98G
 C/sKtie/0+CAkjnMCh1/nJ8pCHuOTDt5fDVoY7mkqSYPKjFJYdDRKiGVE0oJaJwdj6WUr
 jOxTQ9EAHsLwM+vzuFlC8L8s9MLyRvstMf5pGlrer/ewtAw8R/17Q/hv1UAQojZpERf4m
 9hVCmhyz+Wxj3IUk8sOUDEhSngP/zOsUo21iy/ckuKo/nw4832ovMOD4BW5sgsG0ky2Jd
 U+z+EME6wJfLje0UYOd6bLVrItiU2Z6CTUERDMRgzugO94+1tCxFiv6jC4IVlVoif6w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gwbj6CW9; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gwbj6CW9
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CFC240049
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2095641A1E;
 Tue, 13 Oct 2026 16:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0330FC2BCFD;
 Tue, 13 Oct 2026 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791909217;
 bh=rcLjF6TEpSDJjnEo+5tIqtcWIZ7l/BHEPyV3oLz4DUk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=gwbj6CW9LQZp8y1OA5wU693BPAp7eFvWODIdLziWHISc3MrMAcJKenTFV7+PSkDAb
 Igh6PeRxv8trQXxAldeVwEdNIo+gEiFfvYlaa4Q0saN1ZtPXfj8gbZUWwml9hVewcG
 bgthgJLOtQGtyqlMkG4YvgenJ1c/fXFugwtbhHxrc+XEI4LmtD4YhDxidIQ7p7e+Fu
 NwcwXLSbTfaD49L9r+MBSVyvzyzpcRvZ+nfNAWvycXbVYS66+AOqjle0Rv18zBUNv6
 dcbUQPDNJmksIXKMtwE8NZ3MYfqUTbrRR4Rz0CnORGgvBkibTi/pOyMWxmwelzCK7j
 2Vg3OPzMyYBeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E3B68CC6B1C;
 Tue, 13 Oct 2026 16:33:36 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Tue, 13 Oct 2026 18:33:33 +0200
Subject: [PATCH v3 3/4] doc: button: document monitor subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-button-live-monitor-v3-3-3563b4d3ccdf@protonmail.com>
References: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
In-Reply-To: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791909215; l=1710;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=V1QHc3j+E+u6j39lWYuquKXtDVoLT3DspVc7Br8oKdQ=;
 b=I8Mv/Y6mIGQNOSg/KWbOfeRqVtQWBDkvgGZuTHAyjSqU0vtc1/Xrc9pc6WBSBIbBadnCLqI2e
 NElnbFxbhLACQEQzJtTejE6CdJQYw3JFHehdmVh/FWIuhBUO6UfOJec
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:48:30 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add the monitor subcommand to the synopsis, description and return
value table of the button command page.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 doc/usage/cmd/button.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/usage/cmd/button.rst b/doc/usage/cmd/button.rst
index 6c6794f31b8..49bc373b5d3 100644
--- a/doc/usage/cmd/button.rst
+++ b/doc/usage/cmd/button.rst
@@ -12,6 +12,7 @@ Synopsis
 ::
 
     button list
+    button monitor [timeout_ms]
     button <name>
 
 Description
@@ -43,6 +44,19 @@ A list of all available buttons and their status can be displayed using
 If a button device has not been probed yet, its status will be shown as
 *<inactive>* in the list.
 
+To watch the buttons live, for example to verify wiring on a device, use
+
+::
+
+    button monitor [timeout_ms]
+
+This probes all buttons, clears the screen and shows a table of their status
+in the same format as *button list* (*on*, *off*, *<inactive>* if probing failed,
+or an error code), refreshed every 100ms together with the remaining time. The
+command exits when *timeout_ms* milliseconds have elapsed or when Ctrl-C is
+pressed. The default is 5000ms. A *timeout_ms* of 0 means to run until Ctrl-C
+is pressed.
+
 Configuration
 -------------
 
@@ -61,6 +75,8 @@ The variable *$?* takes the following values
 +---+-----------------------------+
 | 0 | button list was shown       |
 +---+-----------------------------+
+| 0 | button monitor ended        |
++---+-----------------------------+
 | 1 | button not found            |
 +---+-----------------------------+
 | 1 | invalid arguments           |

-- 
2.55.0


