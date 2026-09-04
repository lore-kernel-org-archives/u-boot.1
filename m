Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5D6C79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 15:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF02E40CBA;
	Fri,  4 Sep 2026 15:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ShCpZZa0PU0; Fri,  4 Sep 2026 15:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 40CE740CB0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788534121;
	b=n1QOEuu+Wr329en/dvlJsZnAEO3dv4BCaoUepGL9DK9sQcPU71mNrLZndSyWRxpNC36H
	 1NwLB0ZWq71KRmaBdNEyGQCSqIPT4IHAtxSfuZitGSTzZyajHv58wOHKfie88xze7EqEx
	 l3OUPEygJgMpdRf3qRSNiLvIxpnxjdls8jegeC+H15TnHhYob/nQYHl0S180WrVP+oTM0
	 5Yoza0poFcrM3aKL0yzNhFnSnCd+jkJwuxh8qxBduylkMQGJakB8MgdvkmfitouUmL9de
	 BVios6ZTh4ADTw/PO94XNNi24U9BtZ2bxiKfe6TthSOAYFM1f+kHPl4NrMO104t3HYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788534121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9x9X0zFVf6J38uQtG6Pungizx1wWLYHMJ0RyPZwC0W4=;
	b=lVA0Q3P9tDtrlIrg9Upom1XZ3V3RFU4HTmdcMPAdk4HnanPfH1L9TBW6igMHXHtH893y
	 zhWOpWwQvD1xmMr9yOGytCrzofv7pT4xX14cM/cEAQBSi8J3Xl8mT7Y/9PHRTEZDHWpVD
	 0y30BahtZ/TDxrc1bgyX9gY+/Lz5QNFiXNyygHmjANfPH6WdoQVMc6DSBdq+oQzbdOXEy
	 7IXmOG87EKDO2Kv2vFn0ec37Yu6XrghA4N9ki+FcCovume7QxF6R3wcGtl/W1RfEcmUvs
	 F/8TaMiGT8CaAIhtv4U3E+yOEOLZ8ra0guGhOrYAMmbVJQyNR6PidLCEmKWs17kVVxQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=uM4EjdJX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788534121;
	bh=9x9X0zFVf6J38uQtG6Pungizx1wWLYHMJ0RyPZwC0W4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ddcLDRKclRCLjxee6FRPYUsjP4dKy94xAEstev4c9ehumldmJYvxY/e3iw0wAzgKB
	 We0bfjskXGpMR1b8W3rcX9vj1bmAFK48nFfWd/AvqasmEs1BXyOComOi9RDRXtVkIb
	 htotaKxp8T+B32jBUNTyCNtVO1C5PbZswBEr2D/BOdwPyiZtTe/fHysehjtn01IHXa
	 iC+HJm6yGTRND7wPad2Z/BC/QhOVkmL2aBU4/VkWwIHlDn31I02E3qmPR1HvLm7wJ1
	 VgKb5y2xJEPCUckBhOvavQoYD7bgpr0ygnHBeFHaUlT1hAO8wLj79NzYBwqqw2Js2x
	 Ox0u3KOp1QnWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40CE740CB0;
	Fri,  4 Sep 2026 15:02:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A62F3DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D9C040BFC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wN9ToUkO0aLj for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 15:01:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5004940C88
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788534116;
 b=I9tDeN+NNuIL5xirmG+YwMR+w5+0g7DGEzhKD86Py/ZhaztyyYVezab2pxZJjLYC9Bjv
 M0C2f9GXCETjC5e+kOkAcWnlVFXpZ0NdXxVaKbckv/C7k92jHI5o890z8U9UzN2z1714K
 wTcLKlmFafG8F0BH2wdhnRb2z/oNAOJbe+nsOmWNdpVWcYnU0UI8OVAhAb//X+v/pUb/B
 HUlmsv7rgs2KPauwfX9SKJZmT36JZ6/aQt6AVQwYyQlLKTxnIu8ZgxvOi3pvKVBmuyJJj
 Ia6fMlLOFgKedR9VUcl74MiIzbcyE7HMuzCgn+QiMyekRQrKP/nR7zLI267NtgR+w2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788534116;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=9x9X0zFVf6J38uQtG6Pungizx1wWLYHMJ0RyPZwC0W4=;
 b=V3++8ty7hK0W6oPrhvilS50/TKf1mD6by5PtWYPJ8wQbkOcb4687zZIs2T3MqoWQbxCj
 Fr4kRGN0VAAF9eHQaI3GzjO/KE2jGwt7wOXE1jJADpmpM7m3NJys+yGHppb3FFirodyBk
 k0Oy+IGkJv4KnR4v2MtAQAQCFuQdnJVomJ3lg2OqWYb8DTl6UKProfKDkQrj3ls0CdjO+
 Y/sX8OZeIIZQtHl0YaUDvXUnYk7RgOBI1W/k1bPqMuHl51UFV7eBD55KC4AsLKXIPoigK
 ghUMqEUnE/pJjvAKooArO5fzj2HnQbKF8bgDafeHlyyEDCYdAVij8VV+8vn8trBZ+2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=uM4EjdJX; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=uM4EjdJX
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5004940C88
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:01:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA9E01595;
 Fri,  4 Sep 2026 08:01:51 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.49.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B07FC3F673;
 Fri,  4 Sep 2026 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1788534115; bh=ylZ7WXXrjkNmk/gpZ5AyCMVgd+87ar9X+LWSh3CUasM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=uM4EjdJXq+bwGLML4/8Vd2uz3k10ws/tanJY/qZY4SlU+SolZ4s6b8ZCKNLYyjCT/
 dryxGw7/9aPdtWs5c7ammQqvb9zmUV8u7qLq2PCR7O+iOXTGlwWjiUmmMeNCpbpayE
 vjIi9rzkYhcSi/m2fW1rjhxRUSKi0oXwNKEIIc3w=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 04 Sep 2026 17:01:39 +0200
Subject: [PATCH 3/5] lib: uuid: add EBBR 2.2-2.4 conformance profile GUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-conform-v1-3-475b2947631a@arm.com>
References: <20260904-conform-v1-0-475b2947631a@arm.com>
In-Reply-To: <20260904-conform-v1-0-475b2947631a@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=vincent.stehle@arm.com; 
 h=from:subject:message-id;
 bh=ylZ7WXXrjkNmk/gpZ5AyCMVgd+87ar9X+LWSh3CUasM=; 
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqmt1aD6KUnYJZ64VmD8u7rfgoAWRd95Wd3uqKm
 Gfkyg7pA7qJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaprdWgAKCRDLSfhWdqMG
 lOqVB/0XDqXldiusu3cbiGY62Ekl/0G5oEz0M9b602RX5ASIfXafDunrZ0MdSTWgVdGb9oZq+od
 IkNvBuAsYanoFCZV0F8SshUBbwpVxvqko9V96kMj9dyHKt/4mPlFqW6OcA3lNLGQZEJbZ4HEWpZ
 tVbCJo8AhyDEZOjpS9RYXC+flQrdsNM2apeR+eTyyPx8+oqEhvqTYo+kd1kNDf4MCNEpRlUY8m6
 EFHuoAFRlxeZ1P7WkiBx8GW8cMit5LkHJLu/0jDBc0FP6XSVRLmI87qeMkx/bbqiWLKShOVPyb+
 uEQWyovpWi1ccaUn7T/S65IS4SeK8a86JSP/60c6/uG/aTKT
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

Add support for printing the EFI_CONFORMANCE_PROFILE_EBBR_2_[234]_GUIDs
as human readable text.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/uuid.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 16ca8f37751..18fe2a8a8f3 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -261,6 +261,18 @@ static const struct {
 		NULL, "EFI EBBR 2.1 Conformance Profile",
 		EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
 	},
+	{
+		NULL, "EFI EBBR 2.2 Conformance Profile",
+		EFI_CONFORMANCE_PROFILE_EBBR_2_2_GUID,
+	},
+	{
+		NULL, "EFI EBBR 2.3 Conformance Profile",
+		EFI_CONFORMANCE_PROFILE_EBBR_2_3_GUID,
+	},
+	{
+		NULL, "EFI EBBR 2.4 Conformance Profile",
+		EFI_CONFORMANCE_PROFILE_EBBR_2_4_GUID,
+	},
 #endif
 #ifdef CONFIG_EFI_RISCV_BOOT_PROTOCOL
 	{

-- 
2.53.0

