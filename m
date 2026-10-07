Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E0DCA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 19:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42D998150F;
	Wed,  7 Oct 2026 19:39:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ru3kOZKQV6LG; Wed,  7 Oct 2026 19:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0180D81188
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791401980;
	b=d40pB+hDWxuZUjjtSi9XChy4FJHMeKRd5tEY9EtW1n6qDcNDOPM9IkFhvGctZMl9CcyS
	 SLCDjckFeuvGYP6V59CtLEM0lPJQDiAniFo+0VJ5f5wWyq04jkbKElTkXRuuUsIqYQt6G
	 XZChj7v1LVoMdij8C00ECdKFeQrowDPvkZh/t18gzfGGUt9XLiPm1h4CiOcMgCWISOTcA
	 akWekv38ry5UHCc6kuyke8vyxejvESVD1fVPliqCx7RhbJvLafQIINo7OV3ECdWLIaXoU
	 mzGpesJH3RfnNbY7HpQDMdAMsGyylq4fshyKOvdVUptOVuXHPDuPK2RLaxB9MGE5kqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791401980;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O0thJXBVws55lxaU52LjYIo+ZBwL0YlzFwOJgCm9VTw=;
	b=JjR4fpv3VntnzdzGXHauARsEEJ9x7ZsEyckugtabDWLWC+ukNcpF2xRremiXCfhAZHqE
	 GBdvZj9pqgJ75INaDwsoM2ZBT34tvjRFoV3lBAdhGHEzIX+A8SbrQwIgW2NXJfAkfPOA0
	 N6VhWaGDjcE9c0vIYfyj8PxUK20cm8B6Fy2/XXSfNMyxKjb6mQaYXw0cXj6ICUIbhH8UB
	 uOIsxtAbRMDWBHipJ7mjnERuYPbETUB4gqrjAfg/qvPkL0wBXfWM7AFBm+aAgNEkZVo/8
	 1IX+uJpO7Pcb2aFNyaD0E2Yt/MvaJMIqBkeTvBgHuj0vWaBDN23E2Nr4RI60j4vYcdQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Jg52C0Hb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791401980;
	bh=O0thJXBVws55lxaU52LjYIo+ZBwL0YlzFwOJgCm9VTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l35jzcPACTrGobMGyNhwQQ6b3+L5MATbfX9C+GH4RMv8AXDCVZ+SNesBCJKpFMpdz
	 HSydHZZp9GD+JZSocDs/51TIjlo2liC+IKqFA3pzdGtuRVV2U1Xu2SRuyTeBOAMk7G
	 0ys/VHQm4KMBx60/iRVU476Zmat2+TgROxigBwUJpwi2/uYAjQTrXj3CTgmCGxI/6e
	 a3li1FsMgk5xD+f1gqJrS3kB8UNzkZzSr2/KcjWxj5bp8dX7JOxqFXdQG8fJ1gy1a4
	 hPkFZne5Ncc4xWekuSgAkRw8Qjtbs5vRdCpdsJoZZ4B95XUCGWevMGH0bbXltBedPC
	 3ulUzKb+CSjHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0180D81188;
	Wed,  7 Oct 2026 19:39:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AC73C75
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E5E8810D5
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id an8rR2aCLxRv for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 19:09:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9C23B80EDA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791400155;
 b=bSjGxqtKHxTtTG7qP5D+oeJhfkJYiutX3Q3lX9mlY05IEIn8N2qYOenM7xflzzxhcF7g
 dlt0yGu2Y5pBcjXknM8JjgGWWA9yd5zImC8RZPJPmA2fW/2TuSTM9vibXVDFEGwWulVc6
 nvygepbYKYBvitH1qpBSydLEJV7KQ4b45u5vWMPsEv8vUI+SXZb4AnR7AhJ4ttaoYbgyL
 KnEOPi37Ovxl3qdr4wXXS16QN5jW/7Die8b4/gFVLs5F1ryueFuikkrNjFVm6xQBMT0IM
 oftW492cpdaXmnj+E9M4Hobap/rDFnREIAi3IKMBMJkGKQBlolUvZ/zZKG7+1Mp6+LQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791400155;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=O0thJXBVws55lxaU52LjYIo+ZBwL0YlzFwOJgCm9VTw=;
 b=i64XBsiCZnS2KfHV8LRZjdAf9LuLWzjDzFkuzqvFhV+rXtx95CUMqZfmh7ufMyE01twx
 G2KwDhGriT/z55VxLk4wzsztI1l6+JlgA+sya9AoHV3oyIHFEttHw7dgCK+SI58SkHmV/
 wC0XX8gq5Tpq6Hw7mKIqmVTHNJm9oBDLCQcE469IYCdIKH801d+HkDibESFZKelpOFgnf
 NWZhC75ZodDvR7ulcnAJU5IW1GfJ4rslLk7CS/QsAVQmJT6N+yoVre8uwYKK44Q/ZqIjI
 PQGQBu8GLxZ19eciZDPbZzxnmbiFMraImlLFun0YkxNL4x4lV44weu6qpsGcsDzs4uw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=Jg52C0Hb; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Jg52C0Hb
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C23B80EDA
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:13 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BE7E93FC05; 
 Wed,  7 Oct 2026 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791400151;
 bh=O0thJXBVws55lxaU52LjYIo+ZBwL0YlzFwOJgCm9VTw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Jg52C0HbYQDz7imIdG0Fz98yUGOH012uemhXNeafnn5ICNuGppYRwvceHurNNp0ss
 cP9LZ3J0UfQgJN+OsSHhxYJuthfT4tJfAgYhmkfOVU4vvBNp8Ca9ZC2WS8QDqB6dL3
 ltJMOLHWrRsqh2Otw6g2FZOk4HQSw4LVthFDpzZBJxHigvtjimEM1khV1dHAO9QPJT
 n6fQmLMVY287SjmkVPAI2CyKFPwOlqUg4//G71JUnmcaIYdRjEEw95/pXIyGvf2X3m
 kLDPHJZQSb50psUVMZ0WJinc7T0KF0FwTSsVTC4XGefG7KuVun9BXF7hmvBNXyQDfT
 W2VUDEHw9EIs2TQl9Yg09CZUDoJiUmW6KxYcIz2D9OMSIvfTtNMleo8LsIb+mNWLgT
 ouLudji+T+ZEsuq2/AdrmNbEZhp+69WGiPr/iY9byAKA8ZEGhuNya97DreqlD4Jo7v
 PHkpmaVQkhSrhn88/jCGxRN8GTk50IDq6auw9sKEKaws6TNC3e2FVAWL+8V7cRfdxZ
 Iy4nsYHxELehqKcTnV+T89Lu3US3GubEErAlNgaY3a7acJfecM/qaOrZ0GcYRxBv7Z
 FfnQAYURQ/gHihuH7AwPXLQktzTn3E2be6wVRmu4VkLxNEZ1dsgOAmq+BcJo7Ggeru
 t6pXgUY9HkEoPsXHsvUBLwfI=
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
Subject: [PATCH 2/3] x86: add qemu power controller to device-trees
Date: Wed,  7 Oct 2026 21:09:04 +0200
Message-ID: <20261007190905.29585-3-heinrich.schuchardt@canonical.com>
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

To enable the x86 QEMU poweroff driver we have to add it to the
qemu-x86_i440fx and qemu-x86_q35 device-trees.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/dts/qemu-x86_i440fx.dts | 3 +++
 arch/x86/dts/qemu-x86_q35.dts    | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/dts/qemu-x86_i440fx.dts b/arch/x86/dts/qemu-x86_i440fx.dts
index 3bb2f121de3..c55d1c6880a 100644
--- a/arch/x86/dts/qemu-x86_i440fx.dts
+++ b/arch/x86/dts/qemu-x86_i440fx.dts
@@ -71,5 +71,8 @@
 			};
 		};
 	};
+	qemu_power_controller {
+		compatible = "u-boot,i440fx-sysreset";
+	};
 
 };
diff --git a/arch/x86/dts/qemu-x86_q35.dts b/arch/x86/dts/qemu-x86_q35.dts
index 63931cd6dd9..be6f01446ea 100644
--- a/arch/x86/dts/qemu-x86_q35.dts
+++ b/arch/x86/dts/qemu-x86_q35.dts
@@ -90,5 +90,9 @@
 			};
 		};
 	};
+	qemu_power_controller
+	{
+		compatible = "u-boot,q35-sysreset";
+	};
 
 };
-- 
2.53.0

