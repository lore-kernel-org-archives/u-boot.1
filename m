Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D0CCA5FC1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DF4040AC9;
	Wed, 30 Sep 2026 17:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vM5ph8VkJYYN; Wed, 30 Sep 2026 17:41:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 73FD040ABD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790790117;
	b=nYmxwkTdFuGSPzmQu6FcQBGP7aPXjVSQMFb4nMlZz9IXH+9qegWeR0zDJa7WJHbsoBMT
	 kQtWCrue422VM3Cx9MAq1y0sphlngwIExP0ysBkqwmAkF2qyTKCAwUEeNpTt+GA80r32o
	 ZOBRHZNtr+UVgtqS1Va3Yq9v/5BEQAw46SFNPdQmQNIOKDkYNiTssAFRzz/IQtbruAHox
	 TDL4EQrQQS6rXWjEO+i3qx8mF3vUplergRB5zMGuE6B1/QO5vewMsXI05ybhvrOfvmelX
	 Y1ZFjI/WQDNnOITozgfv0r7rTKBrlnA9ikR+ZChENzlmZPZkFDV93G9VE92km/tHBKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790790117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=t9T1jggI8aAWgecXKxWfjKo6MAod+mKha3ceGj2eVns=;
	b=Lm4Q2ZqHKdn6Talq/7AxB4rR5VJNbGD8oJNmgI8Y8X9OkIlsNb/ulfTIjmXWSa7A1Lm9
	 IPm94dbHzD2Mz8tdQEWHt/nmFU4VfPhmsD7sKI7rp96VJhl6e2K+KGROnUM3OolpW/cFy
	 JFvQxcAYkCs7A0gSQGb5mxKCd7w/DGegnn7r1c00vRYpIToZPVBjvFb/tFCAeE9yRMMbO
	 Hboxa2V+qIrrJPEQxrDlkvPx/BAt+SZjNGBNAD9hpK76cE+wd4Kh00B8KydeyktrbDzmV
	 Qw4X1BfG8vtz+Zmo/QUgWdYn/3qfCFkbXV0J/0OIFgOBn+q7SE12Dx2OuQcBJNqqQEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790790117;
	bh=t9T1jggI8aAWgecXKxWfjKo6MAod+mKha3ceGj2eVns=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=CqpaPZdq3D2tNKBASp2yS4w8ZlWEQHjzbCjtbU5p/kV7DZBVY77xYY7b+WfMR55cr
	 R3XRPhAzX3fF/6grC27j3/V5KCrj5Z3jCtfahDwPBzLaP2XDTo31kradmXqk6B9Pfo
	 T+Ij/cJg+ZzL/WnSUOlj3A6LP1nBnh+CA++gZOMCP11vdlDwIrtAQhvyzuB0kK/94G
	 euLxwMVd7zb1bpuA/5yNR+RZoiU36lb0gCnrFUpmkUnBaMWjuLO+7RTsDP7Os4wATy
	 orMhzvAknn0oGf0Zs9qpGyR6o1PWfUBP2S0NG/XfZnKTW/plittP/FXm4Ach8ZvGpS
	 9/fDmV1+ZdZfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73FD040ABD;
	Wed, 30 Sep 2026 17:41:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC2583AC
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1F7660B68
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:26:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yx2X_7nu5lKN for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:26:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0AB1760B20
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790789216;
 b=Rc5/zGRSwTvkiBd94rcCfqyozxXr7C2m0Z/s/02+u9ZIacRLQqRqpx5lDNPLEGwQMxpo
 Hk6uzttP3KEHc6JEJhZeYYLpTN1nH+J9qIHAcVqMEFLFZhJy1cvSuPG97OIO/gKMZcjSo
 OZ9FskY7HcbvIAhEhuRv2ixUs5VFeTry6aXz5ct3U7Mdy2euGR87tCdwMWPoJNlr4vSWG
 Gcq85YzZJmbFhElHUPRiaxd3QGCp+eAWtMtZ1h1dahBDPdg7gvemhENC6CgshjmO1vsFN
 +f7HApjZtdSUFWYaltWSqv3xsyJH/63cDEOJ0a/cvqZlZcBY74WrlIqxDGcy/taY6Kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790789216;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=t9T1jggI8aAWgecXKxWfjKo6MAod+mKha3ceGj2eVns=;
 b=FjNqg3zG+5eQ72se8rlM4UBCaGM+lk21JBHOa7O/88ACmK4PefFTagUpECNv0iDGHQSY
 uZSqeBEec7MEjTiYt5pDYj0X0+XbSx1W+Xyb4dwrvRj5ATYn4oVyL9a0uh6AlzCh5CteX
 q1OMHwdJJkjsQS2tzDrvlezqoOIwzQEF6+vvdq1ppVrLikfjHS89Z9oo8znWbkI34EOer
 esVm2b9NWZwcDyluqs9DzfsziGTAzTxtFSYp3nDsaDMHV5tD5CI8rnxmnl/ruj+GYLZ/K
 NWYhKf6m8/MwxBc0Wjol3gFlP3ZgW/SflR8W4OiqrLv1Xw3Z0umeZIviERfoBS1NVaw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WbpIpgCV; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WbpIpgCV
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AB1760B20
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:26:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DC7F741B67;
 Wed, 30 Sep 2026 17:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD3CEC4AF12;
 Wed, 30 Sep 2026 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790789214;
 bh=fOffxSvXJClxBVKup8ErFpNbJjlnNiKqhb15FGaIkLU=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=WbpIpgCViG07sOdcX4zgw1Ac9AExByDLyaWBzgiq8EV3VZGKd6bCYy1pC4nlr+tiI
 tPLJOnGzSxWZONlrNQYF55FmIQYUwsXOxjM0bGZQW3oqDRxlEIlqb3c7a85lTN3o3L
 HVCJnanemIU09Uo6OHZEXnVhe3OLSK7lVBp+sS4OZ5LQLL5vZ++dDYeQR+o/Js8Z3g
 brhipAfeWXaxYsRiAOckNMsEy3KWciOrKg2w4Fvb5HfnxM8JIsl0bG9Jc3gJIVqvYf
 qwf1mDwN7BV1owQc1H7FQmRAirPAPbflPriH+r8ddmqdUA2PYu9Up0NNvEYK8CIJie
 rx0ZYSnalKBWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A9A91CA5FC4;
 Wed, 30 Sep 2026 17:26:54 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Wed, 30 Sep 2026 17:26:47 +0000
Subject: [PATCH] arm: mvebu: helios4_defconfig: enable the RTC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-helios4-rtc-v1-1-0e6ea4ce400b@iav.lv>
X-B4-Tracking: v=1; b=H4sIAFZGvWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS2MD3YzUnMz8YhPdopJk3RRjI9MkM1PLVHNzEyWgjoKi1LTMCrBp0bG
 1tQApVi+cXQAAAA==
To: Stefan Roese <stefan.roese@mailbox.org>, 
 Dennis Gilmore <dgilmore@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=Z1m9AfZCgsRoTLxgUsNpAbVYQPwoPwUJtO4gm0s+YbU=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFl73WKfTAhpC5l4uUXc8OW2jNV8Jsxpm9fOn5ts6z9x1
 7uCnvqujlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAjCRs2oM/z0Cv1hbZaTe9Fs6
 7/TpAw4H9rae+VZ5Uq7O83dTXsKBvxsY/rvuffer84FZ3os/+08WdK2uYA9kEpF5xM3JYiWmOav
 EjBEA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
X-Mailman-Approved-At: Wed, 30 Sep 2026 17:41:55 +0000
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

Helios4 has the Armada 38x internal RTC, with a battery on the board.
Enable its driver so that the date command reads it.

Based on a patch by Aditya Prayoga in Armbian.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on Helios4 with an Armbian v2026.07 build that carries the same
options: date shows the RTC time. The main build is compile-tested
only.
---
 configs/helios4_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index d218949e307..fa00fbc809d 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -71,6 +71,8 @@ CONFIG_MVMDIO=y
 CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PCI_MVEBU=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_ARMADA38X=y
 CONFIG_SPL_DEBUG_UART_BASE=0xd0012000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y

---
base-commit: f8eb3469e1a17c79b047b3fd38ae820e8816a115
change-id: 20260930-helios4-rtc-d325b659e774

Best regards,
-- 
Igor Velkov <iav@iav.lv>


