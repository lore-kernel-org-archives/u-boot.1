Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3D606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=En3yiDXz;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=dsSxLkHt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADDCC405C4;
	Tue,  3 Nov 2026 08:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GWWGL3ELUwpT; Tue,  3 Nov 2026 08:28:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 09F5C405B6
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793694485;
	b=ocwWqUCdDf0xh4jwKvH8S1iDrkmR6GeeiRBhZ2PhbsyGWHmBhZxdoBNQue8ngOPPpgD8
	 IZ7c3TzQHzglqRrA5+UdRfiDiSucncdQuHcXJTUa6oPEZQUj3FGHEz3FLthfdIQ0aCmrq
	 0/1vw9wOvnrbkdeiBLGDZ6EJ8jMJx5t19N3/5+XASDPHb798nykZXcX36+ofV8buCe7Z+
	 3//zpfp8Yx7cMkCTa9D5GxqerTtFeRh4+YDk0xquYOrdBloNIUEwVE9oUKkGXtFy+ebF7
	 aNravuiW9AZWfbDWfQ9uEnJrlEFrGgSFXLjiIThLjMNP92Bo4vAAktNWmlkurF+X79g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793694485;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HrVF3tXz3d9IzUq/NGfRH+ENwu7QrobKsLRtBPRBTog=;
	b=UIiB6h9ML0KulbChXY3Gz+MkfAkOZoylMyD+AFiZnkpw+rI2IotJ9zEyLF3qMjxzRg1k
	 Ja4DCENqTXq72gpi3n9kLgRE9hfaINeTO/Xk8mq66r5JIAfo0g4V5s89H1RlJvFj2Lf+p
	 1zceVa7uqxzxevC5miyDJ3x70Fg3MIuXh6JmuYhUSGas+5nYxiUBIV3zUumZDFsmwCMGw
	 f12eM420vX38k8HXbzqQuUAdQF5GpGfFmPztJPr6w2AphXlPcH8JmqyvQve2lTnDRYuuM
	 zJH9M66s/aGdhzjxjBVXwPkWDn2OGfFSfhJwPND3Al8m8euQMbClws8TKQ4mokSCFwA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793694485;
	bh=HrVF3tXz3d9IzUq/NGfRH+ENwu7QrobKsLRtBPRBTog=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=En3yiDXz+E+XZG0rCRJjGQd5+ziRC8vxxAeapVp/r2NEGGnkwYm29HC8VjbiLMo9x
	 fbZAc3FlSQoR6UJHTMhlnmihUYoxPOfuHblzJ9azSQCIQJ3CTgYHANdLDNQ/nYe62Z
	 C+ebPV6w0FuT85yU2KJYfDh9NDoBR7yF2AapQPS1s2xfd5+gq9BuW1g/KieajkbGqR
	 Pz1Yz3SQhNczxwnZVMNfyo/ByncHo6fWDxlZZg+2wjt6P8SXeUlya3m/R5ho6Urw4m
	 lYxQ+LPQy+2F3M3PUsTmPL29zzrOg2Y2u4r7mIzhXlVUWmIA6rfmvW5t7LJ7gOq57r
	 hN3T2r4EpVHpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09F5C405B6;
	Tue,  3 Nov 2026 08:28:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A9C72AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06FA7606E9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:28:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_cyr9mq5l_N for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 08:28:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7B7AB6069A
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793694482;
 b=ndXR6fW/0jEfjRDhpsK8ImdOwr/XdAaKr8n2LmT7TwbRatnPxGg0i8tB1qztQyKXUdi9
 dbXwwpvohEgSlMcOJJZ0kHsdJw5dOMIIVkq9WiHZPO279/7QboCM00UNO9p9nQmZuZPIW
 prkfdTZyfAE6RU4BGfm9wHwzk/VqqIH5hEWNoX0AneHd7ocSVy6ZseJ6RFdbah0aSm4Sz
 xc4w3bxuFQD77hM35TnEwvpD2Z8QbVng8uEnUvlzGxIDxbt/Osd+GcPtH2L4l/3lIxFSJ
 lNfj92WZrHRCj5XjEa0jz5hiYvS48f6RdB9TtPTjvZUVUrozK0mTDcHAqzEpmn9N1fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793694482;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature:X-Virus-Scanned:
 X-Virus-Status;
 bh=HrVF3tXz3d9IzUq/NGfRH+ENwu7QrobKsLRtBPRBTog=;
 b=TNWOhcZqIHzfyljuD84lRlQQBylox2kz+1LkGMLsfw7MFoosOHSkU28gZaavP8G2lWPW
 EnGppkUHMwFPVWkn0A/RBxU7FKPoDupXPNsAOOi+RosbT5lFwgzWQAXVtcxZvKhxx0X75
 kAGHLD3Y4cRisTB73A3Fc6a6xz8mAFGb4qMbRUIddyRXLRjgmqlZiomVvmQlo1fIdavhV
 gpstJdLl4thcZea+zor+Dy9OTJV7MIlNPkEbY9FIiWsYApD3pCBpv+GKqVDTIgNriZvQO
 82eu3n9KYyHMJu44qa0gu+FXU6cBYIAT2WDYVFjMrzKbiJV4hTe1JDsIMbIjo6H5BKg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=rock-chips.com;
 spf=fail smtp.mailfrom=rock-chips.com;
 dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256
 header.s=default header.b=dsSxLkHt; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=frank.wang@rock-chips.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=rock-chips.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=rock-chips.com header.i=@rock-chips.com
 header.a=rsa-sha256 header.s=default header.b=dsSxLkHt
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B7AB6069A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:27:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A229383FEC; Tue,  3 Nov 2026 09:27:53 +0100 (CET)
Received: from mail-m118218.qiye.163.com (mail-m118218.qiye.163.com
 [115.236.118.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF24983108
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 09:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank.wang@rock-chips.com
Received: from localhost.localdomain (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 534fc30a5;
 Tue, 3 Nov 2026 16:27:39 +0800 (GMT+08:00)
From: Frank Wang <frank.wang@rock-chips.com>
To: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, macromorgan@hotmail.com,
 sean.anderson@linux.dev, heiko@sntech.de
Cc: u-boot@lists.denx.de, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, chenjh@rock-chips.com, wmc@rock-chips.com,
 Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH] usb: dwc3: fix abort on invalid ref clock rate from
 clk_get_rate()
Date: Tue,  3 Nov 2026 16:27:32 +0800
Message-Id: <20261103082732.18483-1-frank.wang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Tid: 0aa1a085650309d8kunmec4c1a3f321221
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHxoYVhgaShlLGk8ZGkweH1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=dsSxLkHtjK7irPA83vzdAqYCb0dR74DwWawuf6eIJ6cQaVYy6m3iprqhSWUny/ZHjR9+eNpLUEHSmg1gTjWttubTiqyss1cprw+EP7/hVZiPu28uYcPegjYR+KkwfJtrd9pEgc6wuHFVEtirLcL98GB3TQiO/3ulFcVrqsL+Z9U=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=HrVF3tXz3d9IzUq/NGfRH+ENwu7QrobKsLRtBPRBTog=;
 h=date:mime-version:subject:message-id:from;
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

On 32-bit platforms, "usb start" aborted with
"### ERROR ### Please RESET the board ###". If the clock driver
does not implement the "ref" clock, clk_get_rate() returns
-ENOENT, which dwc3_ref_clk_period() treated as a valid rate.
period became 0 and the fladj calculation divided by zero; the
software 64-bit division on 32-bit ARM calls the
division-by-zero handler __div0() and hangs (64-bit platforms
survive silently since UDIV returns 0).

Skip REFCLKPER/GFLADJ programming when clk_get_rate() returns an
error code, as is already done for rate == 0.

Fixes: 6bae0eb5b8bd ("usb: dwc3: Calculate REFCLKPER based on reference clock")
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index be198041f08..9a84ec6a60e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -151,7 +151,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 
 	if (dwc->ref_clk) {
 		rate = clk_get_rate(dwc->ref_clk);
-		if (!rate)
+		if (!rate || IS_ERR_VALUE(rate))
 			return;
 		period = NSEC_PER_SEC / rate;
 	} else {
-- 
2.17.1

