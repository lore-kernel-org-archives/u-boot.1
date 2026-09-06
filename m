Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64C7C79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 20:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1534E405B7;
	Sun,  6 Sep 2026 20:02:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I5WXQtgDrJb6; Sun,  6 Sep 2026 20:02:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 034ED405A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788724939;
	b=PQu3nqwTI2Y1Hc7bL9XYZM/Q11o35Aj0Mk0HFaxGaNde84tQh1b1uiFf59bv+vmjvJzG
	 KCgcPbXbhYml4Ow4RoJGXHswggWKY83s8XSyrkGmvprOwtnMW1/JkF/Q2ZuWwH3tCNBUx
	 p4JgnTBGgmygFBqAkewwfamFfPY3dNCKmjsMM8hdFJsORruzLE8FTAweifTO50Z5Xo9Mr
	 iTXTV+h0cVB9Oc2RyeOlxwOQc6pFxTGip0lp3SYO/BQodkIpB/b40mcpYiCwv/5h68L7Z
	 MqjsyvxwZx6WYtQWBFTNTTKhVMhLctsoDDaGBPVjBpTOkubxKYZeHZsR4mMQ7Rn1yWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788724939;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=64kp6PRI2tRYxm9ynt0MSthSCqIxNHiSb4dvvXdrJMU=;
	b=jeVeYgLDGtz49qpygXMZpj3Qzoz3gk0YCKk7/DugASqD+pcHTybqz844B4GS9AnqzhG+
	 /ELWaROh0Wq6HExLyr7bAeDaQ+QR2nA5HQA2+xtoMetmc0PF6C+EfpASHbN2fkMjOklWu
	 x78lBL3LCiPnW5uyit65/6D3yc8hW0SnsRWkxPFCFYLun/WxYX9sz5MUhBCmEP7BNRXV3
	 iAvolnF1RJuCFLKGqh6OzPwLF9th9e9qXgyL5CNx4cLa1YyGyHKIunJvk+fiSKyNJAzJC
	 DGSn+HvnM4ptamdWvlaOKHFhq5o1a7hYfxL7SR5knro2S87gxnKzQ8wnaSqdlySHFZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Vv+X8JH+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788724939;
	bh=64kp6PRI2tRYxm9ynt0MSthSCqIxNHiSb4dvvXdrJMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CdyLGk8cZVzYm77zXMAX12KqiQy9yI0HhLKvBc1FvgJw7a1B82PApxG9rZ33cfhtr
	 R1ga/22v7BFKgIlj5MNaSH6O4XwMR2/5bmV+7Z/UZ1AUE5JyihP1SsizfAwg88fl22
	 6+v1z5N5mwkyNPqVqTCnKFm8VVB+l8rwwyeFBJ8vUM8lpY96eIiSTFFp5y3E5vSt+e
	 8GBzrk5GgFNegpqHTmVEY/xnLxIJQv6O0EJaQOLZ5ETJ/SqVrtvTM3feFrLyi2MvKB
	 2OoIZ0bwa+g+h3EDsFxpmvI3+vz4lN8d0RCWOvY0Cq2xGtPyY40JnP+tNpLFqoQrw6
	 UlO4DwIEwdH7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 034ED405A3;
	Sun,  6 Sep 2026 20:02:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0146B72C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E71524059A
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FCGiZMdgCX-f for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 20:02:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EB64D40569
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788724935;
 b=L/dqI1KWelz3hrYRw/0SSTkNuaWjORxvMbS9hZbRjK43VU5RSuAr4YUwX4kBcqj3lFoI
 ZhGw/EV0VypiQlhtp3mZYKGp4zU5+XOfPXH/2v27n/XQNacC4kR3PYWFSXcUrzXz8z6gR
 w6GZfBhTeTFkjA0Say1Hoca5Km4cp4NqUURCwMN6AKpJ0wEGT45eoNNqyTDqcPl9BHB8g
 YHiy3qiJht/JHXC2s5a+KwN/bqnr+Mw1evhXw43erAxnBSJvt5wqjQdzJ1Xg9JV5iRhfI
 i5OLf9lm+Pv9KXcfO69Ko3DwL2KKVPIoNISRahGnYQvhBvrB/nRSL0RmhUUQDe5AS6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788724935;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=64kp6PRI2tRYxm9ynt0MSthSCqIxNHiSb4dvvXdrJMU=;
 b=Xaj0gS8AJ887W1POL/5Y2Ea4twORpsLtXTUdPd/b185TOEwdlur6UTeJh+hb7YFYxfoS
 ubgoJXE67+iQRgM6OkReBDQG6CqCpsYjt56jiYxIazLuYbxQofiLObOJ25aT9MLWnQAxo
 k/9s2EIdNz0m/4rrjUB2QXeKDLhUA8LdSGZbB7i9iXq2B5AynP5tUHl4F1P5DTu2mNesD
 w84azQQVUkBAkJlNsfobgKhSZvxlqF/u96Eovai+NiBrl6cTF5tjmrvUmz3Oq3IX8s9Sl
 Sou3kBhBoFmTEbxsxBXpfRmSLBQJQ+MkCSec6X2/jNN3rozAn5w7TMtSvD/HfHUc07Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Vv+X8JH+; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Vv+X8JH+
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB64D40569
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:02:14 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-485850cbac3so1736108f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788724932; x=1789329732;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=64kp6PRI2tRYxm9ynt0MSthSCqIxNHiSb4dvvXdrJMU=;
 b=Vv+X8JH+MKLoK/45xUeb0ci021goBM4hOR/EAvGM7lbmNr+pYdPVzXmoO60QqsTyPQ
 V7IfCf95lthvYpg1dWp1+aJEWvQ2AmfzPqaoOUSrkpr62GHp2IW/t+tNfzbV8r8h8yVg
 wYueMKNNVYVb+eB3qkF8hdvWRV1qXH13ylgntgJ2SyCywTpmwd5AvE2u8TDEsujqYmZk
 mg/Fl52c/VL+Qs12xSWCzljuGNgPgxJs9WG3wg8doqZfHnnw0oZfZ81EMz29eJfebCtP
 bKCxFrD0idlxHnJbofJ8RHqUy8iuSL1rtDpAsK3FD63zCdR0+lJ1SV9QthVoqdEZv9nc
 vTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788724932; x=1789329732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=64kp6PRI2tRYxm9ynt0MSthSCqIxNHiSb4dvvXdrJMU=;
 b=naHedVS7ryANlWekKQNT+U44ygv8fg2bd1fLqofBN6zFjNgR66m6fhKeSEN18FVBjx
 gea2mroduzigmNm+OYwIqD0BsdwtbeTEpivli9av85d6irWRg2+1C2L3rg5SgpWFUW/7
 MESicNFUKar461UlbZeHDRnvTkzoP5KI6pHmxXRyDI1b+HDy1CAvjkSYmRjs99LadFF1
 jKPstJ1o8IH/CERrQIVvZWntQIHdZJpdio2YvRQ4mqwrJsC5jntH3+pbYkdrHpkkpFth
 XTrz96c4YRQeSO8TdNdH22htjAzEZegwR1sukx2i/dGD+ucPnCO/r2ckn6cs0oU7Yh0U
 klig==
X-Gm-Message-State: AFuF++kJjjIlrBj8gcUM+8iyVk2eAmLlWct38FHk5bVU5Hb3QyWyQFSp
 VMgh3+oxzJ/edqh37XehbMQg0x1E0nodubjcfllOkQRAUwoiwe8cz58P+claEeNl2es=
X-Gm-Gg: AYBFou3AC7WjiASPKRk7zCzfs0dzt5xaZVgIDKV7dE5tIn/dYJPGHz0QS8toI6FvcOR
 S7fdeHNtgWTTmc4Orcy0fIW//gBzZI1YZm/xfJkkm6bNzm8rrO2a/k5u3PFnJ/M7ylHs2n9b4s2
 SkjSwx1riJRoCzGULVUlnfPf/HR77gXKcAKcz6lxFAC63Vf27eWz5TfhhD+/Y2gKZh4XdGM/9Og
 58NTXiWydGbTxcnOdUT/hrAg6U1jBzTq6D9s0XMXaAjqa4H/jKqayFAi9ZS/6gM8Rbwi6O0iF+9
 6saeVwG71wEl+ocEQd60oXh9aVYAUFW8E00F5lgvJvdryLDlhpCLILkG9uRFGV4CHNnT8a+LWtH
 79v5Qq6DlgIU0KnNJ9yuv7X3H63tkI7+B1HsZ7bch2owoRYyRbN9vsFApB26wg6HBKSqr1BQjcX
 giTPz1YEHXhDQX27iVNiRB02tv1fzTfovl6d7xSmZZvPlc9IQzEq+ID+dZkURGzq1lN2lPB9ABt
 3OVQcZJe6WwEx6UtwrHDbsdfNA5Jv65PPZzoyXEFyfeFTqYNMzn0hEvuXOVE2Y=
X-Received: by 2002:a05:6000:4304:b0:482:e22f:a2b2 with SMTP id
 ffacd0b85a97d-485872dbea1mr19309314f8f.20.1788724932488; 
 Sun, 06 Sep 2026 13:02:12 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfdf6sm24592173f8f.34.2026.09.06.13.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 13:02:11 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 06 Sep 2026 22:02:00 +0200
Subject: [PATCH v5 2/5] fastboot: use the common handler for USB reboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ccaione-upstream-spl-fastboot-v5-2-023516e77321@baylibre.com>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
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

USB fastboot resets the device directly from its request-completion
callback, while the network transports route completed commands through
fastboot_handle_boot(). Keeping reset policy in the transport makes it
harder to support callers with a different reset interface.

Send the USB reboot completion through the common handler as well. U-Boot
proper retains the same do_reset() behavior, while execution-phase-specific
policy can be contained in the shared code. Drop the command header which
is no longer used by the USB gadget.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/usb/gadget/f_fastboot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 8df0e3f331d..1971755721f 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -9,7 +9,6 @@
  * Copyright 2014 Linaro, Ltd.
  * Rob Herring <robh@kernel.org>
  */
-#include <command.h>
 #include <config.h>
 #include <env.h>
 #include <errno.h>
@@ -422,7 +421,7 @@ static int fastboot_tx_write_str(const char *buffer)
 static void compl_do_reset(struct usb_ep *ep, struct usb_request *req)
 {
 	g_dnl_unregister();
-	do_reset(NULL, 0, 0, NULL);
+	fastboot_handle_boot(FASTBOOT_COMMAND_REBOOT, true);
 }
 
 static unsigned int rx_bytes_expected(struct usb_ep *ep)

-- 
2.55.0

