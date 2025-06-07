Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D024FC61CE7
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 00:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F219A811AC;
	Sun,  8 Jun 2025 02:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC51A826AA; Sat,  7 Jun 2025 19:11:08 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE935807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 19:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pom.pumba@gmail.com
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so24261295e9.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 10:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749316266; x=1749921066;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EqrnPqnnFMrthsq0G+JlMeL3+DbaRLIdUrF11XVAuvA=;
 b=ujUa+OwcYomW5n2juRl5IPiD/7y0XHyTUg3Gc0SQjA6kbFaOuX1xGyIoKjM1lLup3V
 fZ9EJzygLSAiCf2el/6/s53lmzeogiounAUmEsEhCiUKeEdJlK8wcHbAY7RmF443/mUI
 7/8BN+aDlztpFu25uWv966ZEx5ooswyBNlHOy/rGzMjEJ+cRinEL8u9N5tzsT4yfraqk
 k8AUM3k9LuVYB3cuKXXweQMLkTmeq8STezN/WJgs9xTLNPltmxA0O1FAJbx+4HpOFz8V
 azZUkhJSwjrin0ezJD+wgpg0PcM+9LtS5dEUtI4HarWM6wDMtTVljnID6GEcxFZhwX2X
 zxGA==
X-Gm-Message-State: AOJu0YxoB6sxTj3ZM1Kjuye2eEvWHlM0lm2XfbO4OMNkWuLpXItTqxp6
 W8xq4FAO7mmW8ljcDn28//4U/WpD/CotvhLMlN68/sGFuTKL5DAWimXLfUsWMg==
X-Gm-Gg: ASbGncuJRHLQKlzx5lSQw3oRz5qRChZ77lO8L8YKaq47Xfi503CPRzV/fHLuhfZi/g6
 ki8l6bH1Tk0xkVGPs4DZ03PZGunIsNf1e1e8ibNIqloyanktzZgeNySBlrphA45EUcjO2vn3Gv8
 n0pYS71HzoXC6hK4EXXD46OJSRpCCzknlerYNNVgrCPV849hS/ecqCPwh2CbUECcKEIBlASYDIB
 joesr0SJONWOPYdL0mJB/P55kEIMGuGwNzCcYkIdbQUb9lRsECqAlCWrjMg5OnvxU2fgLzGhwhz
 ot5lLu28TPAvPy6CO01VD/q/FiQNDHvhkh/kNTCo3wuFYf9zFVMYz/gFOfrr5nX3/z6nERH8fAB
 nArAkjmGuUxtA0eRgNQW/JjcufZcJ8cvSkPhVdLiO+yieLpYrF/7iA9+4Fz0aqvogwcxwaFzaku
 Y+7Xq23kgGUI2fCaB1S6aC
X-Google-Smtp-Source: AGHT+IGoDTEB9fm9UD/waU8la+DjfRxHPcqDPD/gfcei+EmA9+4WuZw1NAf5vpCKbruQCy0FCNBs2A==
X-Received: by 2002:a05:600c:4f90:b0:44a:b468:87b1 with SMTP id
 5b1f17b1804b1-45201506dd3mr65574515e9.4.1749316266028; 
 Sat, 07 Jun 2025 10:11:06 -0700 (PDT)
Received: from ?IPV6:2003:e0:6f23:534f:15cf:9589:31e8:f846?
 (p200300e06f23534f15cf958931e8f846.dip0.t-ipconnect.de.
 [2003:e0:6f23:534f:15cf:9589:31e8:f846])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730d1636sm57699515e9.38.2025.06.07.10.11.05
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 10:11:05 -0700 (PDT)
Message-ID: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
Date: Sat, 7 Jun 2025 19:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: u-boot@lists.denx.de
From: MichaIng <micha@dietpi.com>
Subject: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC addresses
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 08 Jun 2025 02:21:47 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Some SBCs with Rockchip SoC provide 3 Ethernet ports, like the 
FriendlyELEC NanoPi R5S and NanoPi R6S. U-Boot assigns already eth*addr 
variables to ethernet* device tree node aliases, but for Rockchip 
boards, it generates only ethaddr and eth1addr so far.

To allow the assignment of 3 static MAC addresses, with this change, 
eth2addr is generated with a logic similar to how eth1addr is generated 
already:
- eth1addr is currently derived from ethaddr by inverting the last bit, 
which raises or decreases the last hex digit of the MAC address by one.
- Hereby, the eth2addr is derived from the value assigned to eth1addr, 
by inverting the last 2 bits. Hence, differs from the first ethaddr by 
an inverted second last bit, which raises or decreases the last hex 
digit of the MAC address by two. This assures a valid MAC address 
assigned to eth2addr, which always differs from ethaddr and eth1addr.

The change has been successfully tested on the NanoPi R5S and NanoPi 
R6S: With ethernet[0-2] device tree aliases (correctly) defined, both 
boards get 3 static MAC addresses.

Signed-off-by: MichaIng <micha@dietpi.com>
---
  arch/arm/mach-rockchip/board.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 75d6693e28a..6b0d5715f5c 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -357,6 +357,10 @@ int rockchip_setup_macaddr(void)
         /* Make a valid MAC address for ethernet1 */
         mac_addr[5] ^= 0x01;
         eth_env_set_enetaddr("eth1addr", mac_addr);
+
+       /* Make a valid MAC address for ethernet2 */
+       mac_addr[5] ^= 0x03;
+       eth_env_set_enetaddr("eth2addr", mac_addr);
  #endif
         return 0;
  }
--
2.47.2

