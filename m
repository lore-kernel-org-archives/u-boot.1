Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30897C55167
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9CB640A9D;
	Thu, 30 Jul 2026 13:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DYAvtx3cEStZ; Thu, 30 Jul 2026 13:34:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07D2740A6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418485;
	bh=lqLXMfJXIeR0NKpV2aGXEWpBEsJQdyRekzFltQTAZTA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ts3y5cPxZQ37ZBgSNqCmqOsHHPWTxPM7ZldSjKXrQz9Or/2xm/sE0OzBfs3N2v7hv
	 fVC1qnJeVw/MJg4VNc35JVQwnpLwLdmKUKMx8qpeVHwi10Uuw/ig0vl8nQD+BjAFVi
	 f3a7gO+cUr2oP+eY2p8gt7nMo0INEZNrJWY1fWt+agXKBiYAbTDTFy7jpo3ABTLTFQ
	 tyezB8qGhlemJ1PRf5SCwLtRKwWVDUoOz4rDLSajzZ6uuyZnH+xXg48CYFuJ+kn9Jq
	 jrY0WXi8K2ZrTKe+c0kjAxnh+LKfE5s3vVXQXr0p/2jX9+OnQQHLTGuLkQH1vq//9/
	 B6NOdDAT5JFbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07D2740A6D;
	Thu, 30 Jul 2026 13:34:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F7AD197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 061B460895
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juVVPvucxvVe for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:34:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B28546085F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B28546085F
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B28546085F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:34:40 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c1f1f5631f8so20470166b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418479; x=1786023279;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lqLXMfJXIeR0NKpV2aGXEWpBEsJQdyRekzFltQTAZTA=;
 b=SQvBLjVS1QIP+CJJhTtakkVKcGJWvDSQuF9HLTXccVU5TUvB/SddxLYpn4O6wD6Lwi
 b78vxFtqTwgK0BovkOOUFYzKol8RNQHpu3cr9//hmsYxMXDUZSZA/vMPA+ThMlhAKZfw
 ljtT9omlvwXsFnGCP+dOuCz9SiPW6+VyGcCQe2wk6mQN7uwgUxHAK1cmuBudCf81W2ri
 BazNhQjgU94tlk8Dvsbjb4oK0Z+yt16rz/c/LidOD1BTca/3HH71HmsqGP2hHWGlY5M8
 vscV9Sp36s7x3utVDzNgRmx1UZn//8zNymbh+0leYbm1Uvzys1jlPHNHFpsKHS7scKZo
 WSGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2rIHBRgoAAQbmjSz4d2h+kan/KwrjbySn1eUuG75UCkZCmqvBmhBiaYXsk45ECWSYPDWmzX4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwFufLenySJeNrNpqL69Vwv8rMcPagNe9ynf1FvVYC1yFA5DPWz
 mNUTBzQpcAFO+o8FSO1f5tJqeoavJHJtlT8pcj8AXKBIiRnPZRXSvFqC
X-Gm-Gg: AR+sD10PZPk2VN4UMRSme1U8St4ZvE62njUDF+sv3EW55n5/w8E63ro5yhh1YOoHt6x
 AYSc6bE+2zVfT/Iw4mPAXS5gAdHpUmk0XJtnBD4HywTUTGwLZEjRvCKTxGeg0PkTaSxmqHsTlg2
 QHdGOeVz8y/AioJfImCAfDowhIKU1OSadIQas1Bif81ouU8zzz+ROTHLg31KAcS0+WqzFgOWXSr
 xwhtp3pSvoZKQ22gsAjDjLtp5pcMonU05+jv81CCKPE3RCshz+Hrf7fbppra9Z7JUjq/X0mY+zS
 uCTRY92wFbLxILoiB0dMTzvHIvV44vALvcHy2NTNFSBIjgJQibH/nx0uyYdsJbichtJWz9HCRVL
 FQ+qGQPVVwafEpOBgSjON2XyoyN9NhEqI5nKj5UxApCaLCuX3w1XW+TXQM++JeufLLl1XXj+1HF
 pdjxgyHaIRMRB8gGNk7/e5P4RhWhMc51F6T1VqHYWjgDPgPKqVjNudHUHPhyIw7VNJ4Zi/+6Wt0
 g0+FiEPp2hBOpY2dsgpq+C8I7I=
X-Received: by 2002:a17:906:6a02:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c1fbc7b42d1mr35958866b.0.1785418478475; 
 Thu, 30 Jul 2026 06:34:38 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8b6dbdesm65456166b.36.2026.07.30.06.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:34:38 -0700 (PDT)
Message-ID: <44039d61-ca43-4f12-8051-66fcbe0ce5a3@gmail.com>
Date: Thu, 30 Jul 2026 15:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 06/12] rockchip: doc: add more eMMC program examples
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418479; x=1786023279;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lqLXMfJXIeR0NKpV2aGXEWpBEsJQdyRekzFltQTAZTA=;
 b=fxDVuWikkyp2PQP2w1L2I7IGo9SKMV8IzXMtiXveCzDC64j+6rfog45AdJhDsGwOJI
 xjFAFtoQ9SlWwILTlVmPhiIkUy3YdtGD96VqrbaBzoW9SnW7hvDL/prMZQ6xzN97X6sV
 VZ6SBeunNo9EnJDxNpUXBumlINoKtHg26QQjC2YXVkcThCy5WLN8fCTzLE/XH23IPFQv
 hSbZcwh5NsLslL0B/bS+yf3Xaat2zobk9yW3l6MiOEZc2E2p5TJG06sRABpmGXC2dUlq
 /5MUjbgf+1G7rW+NFsNpnIMv1oiXSJVeEcnlyNnD85fjqke+XVQwOmGMkRvsGNxoNF/k
 kbDA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fxDVuWik
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

There are more tools that can program a eMMC.
Add more eMMC program examples.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V3:
use eMMC
use list per example
mention loader matching to SoC
---
 doc/board/rockchip/rockchip.rst | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index af5c00591234..c089419b65e5 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -393,36 +393,49 @@ To write an image that boots from a SD card (assumed to be /dev/sda):
 eMMC
 """"

-eMMC flash would probe on mmc0 in most of the Rockchip platforms.
+* Program example with fastboot for rk3399 and full U-Boot:

-Create GPT partition layout as defined in $partitions:
+  eMMC flash would probe on mmc0 in most of the Rockchip platforms.

-.. code-block:: bash
+  Create GPT partition layout as defined in $partitions:

-        mmc dev 0
-        gpt write mmc 0 $partitions
+  .. code-block:: bash

-Connect the USB-OTG cable between the host and a target device.
+          mmc dev 0
+          gpt write mmc 0 $partitions

-Launch fastboot on the target with:
+  Connect the USB-OTG cable between the host and a target device.

-.. code-block:: bash
+  Launch fastboot on the target with:

-        fastboot 0
+  .. code-block:: bash

-Upon a successful gadget connection the host shows the USB device with:
+          fastboot 0

-.. code-block:: bash
+  Upon a successful gadget connection the host shows the USB device with:

-        lsusb
-        # Bus 001 Device 020: ID 2207:330c Fuzhou Rockchip Electronics Company RK3399 in Mask ROM mode
+  .. code-block:: bash

-Program the flash with:
+          lsusb
+          # Bus 001 Device 020: ID 2207:330c Fuzhou Rockchip Electronics Company RK3399 in Mask ROM mode

-.. code-block:: bash
+  Program the flash with:
+
+  .. code-block:: bash
+
+          sudo fastboot -i 0x2207 flash loader1 idbloader.img
+          sudo fastboot -i 0x2207 flash loader2 u-boot.itb
+
+* Program example with rkdeveloptool for rk3308 in BootROM mode:
+
+  Use a loader binary that matches the SoC.
+
+  .. code-block:: bash

-        sudo fastboot -i 0x2207 flash loader1 idbloader.img
-        sudo fastboot -i 0x2207 flash loader2 u-boot.itb
+          rkdeveloptool db rk3308_loader_v1.26.117.bin
+          rkdeveloptool wl 0x40 idbloader.img
+          rkdeveloptool wl 0x4000 u-boot.itb
+          rkdeveloptool rd

 Note:

--
2.39.5

