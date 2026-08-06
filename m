Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D351C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18C0960806;
	Thu,  6 Aug 2026 11:11:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7iUl3uZ8rZC; Thu,  6 Aug 2026 11:11:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F93B60784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014690;
	bh=B5a4ZNmrAScg5+hVqhCZRbwPH+JTZRPMLMw4sPOzQeg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YXf2vuTzNSPq5Fqqo4X54YBs251d4ZRR+LAKy+e0J0bg9dWiaU/Z2V5IUF7czg5wR
	 Ts6ks6eeBAh/gKO0vauRtE5IyYCyewVW0gtnW2dfOBtJMh2AFi1pd0SK5x7vVHBG0S
	 i8XUXhSTBHsl3Ux4AEA8/otETyA4b/aiDuvUrAlNIkyaGogs0YQ9Csj9ZnVRBRIAY8
	 KiKr2N2s7i2S5HeK//Qt+XnseH/3UK4l+z4En5q1QG6Kr4LVTC6Pku1oJYgw2ozkMj
	 TaStYt6b6OMzNd0zo4//RNPK49yBKo5fqDQmMbybLWSxAHqCwSWOrwlS+X+s8/LV3r
	 I4xCy7vNVuYfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F93B60784;
	Thu,  6 Aug 2026 11:11:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E52910E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1462560784
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rWbGX8vrYVlV for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:11:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 259246070D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 259246070D
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 259246070D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:11:27 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c160d8760e0so26317366b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014686; x=1786619486;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B5a4ZNmrAScg5+hVqhCZRbwPH+JTZRPMLMw4sPOzQeg=;
 b=SGeq14rg18L3wQWXZBH7WOvUs8QYKAlOravn6EFwIw/eIXnJxBhmoNTnq2W/RrR+eg
 7FCdqvi1IoyIs0Ivt3LYeMREnHsazOTJf2bVO0LltwW+9f5pZeUMTNoqzIXRLgjR0eee
 nasVVUCNrYm8GRH1yWeaqijwCjG1XHQ2+InY3gKC+VH7+4+0jrQqbU/5Phf+LGOROWMd
 NsXFkIyUK9CZly9/NfhCUDLosJU7gGmmDv+F31jQRbbHsz7Imr0kGLQvY7i3G0/1NVG3
 tQDeCi5mzKnz20DWYUa4M7TKZBeJs345LhBjdKmKmoaPfhhq7uIuUmm5/1VLY/xTVkg2
 Ay2w==
X-Forwarded-Encrypted: i=1;
 AHgh+RodLRQUgCJU3asHnIJRPsGzh9OLib4nE33qnE6daozp66VB8d7kawyK9BTpQxrT03nH/N0Axc0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwBgVce20KuhWRH9d9sV4/ge2YCYBkCmRqoCFnsv1b4+AynlxOK
 1ab2CNFW/GefXAtYqieBMEWXbHyZ45eMmjNWOSf7GcDQJ78iS4s6fmbo
X-Gm-Gg: AR+sD11I6ZhBp+4JRL0WV0YkQ/oPRMwfZgr6ApdmMu9Pmt4hqdkvjzE4JwBPJqfvs98
 CTnOMxg3Z7UVVjMYrI+BpzOyMJqXwAW///JJw6Y+iIX0EkkBGSsia5l8O9Ems3GhHKCzjTDyFXW
 PJAO3jq2T8WTBD/27DIsWouGlkU06t+YyF1fMa9C7Gm0V/zkFfLTwaRGD+f1REvH4l51Rh5+gzM
 fU8VIKbqNuZZIyJGhLI14OxnkT2qTnztzUhSuUhilClSAVj9zSZFXTwdvjZ8USZ+70dC9tkznzj
 6wAs/k41Lqi5HU7LUjIHnWcu8HvlI09EOlAK1pthueqo3KrhyrRvKe4T6Q1HtrC/YpPoZfrtmVj
 Vmx/FzB9kJjji/+lFpwiuKYNgzW/l/8l8CS9k6zPRH5Al5t6Qt6QEpbDAcZ4raFSCFfV2JDrrjh
 2NC9M3QjqqYBDy8lnFZEMhLnBnlE31++/ze0ejrbTNBZRpJRD70TiAo5HgYssPmHCkk0jkiLxlu
 D9r6C0q0BJ+Ch0rQXJ1JOklc/Q=
X-Received: by 2002:a17:906:ee8e:b0:c1c:4820:65d2 with SMTP id
 a640c23a62f3a-c2039edb9fbmr423822266b.2.1786014685640; 
 Thu, 06 Aug 2026 04:11:25 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2036428e08sm244407366b.48.2026.08.06.04.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:11:25 -0700 (PDT)
Message-ID: <5f60ffd4-273b-4f2f-87d1-5a9f1fe74543@gmail.com>
Date: Thu, 6 Aug 2026 13:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 4/9] rockchip: doc: add more building instructions
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786014686; x=1786619486;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B5a4ZNmrAScg5+hVqhCZRbwPH+JTZRPMLMw4sPOzQeg=;
 b=lBu7jXCorQKglfxMsfEI8S+BfhFh/IyjsNYgC0d+2FyRXmxnWDoA01OBCwnaGlHkDh
 TCLhtI46rbIsS4zVYrOfTclt4EW8zXsX7mp+zpetRtRXYa+23bb5w5RpO3hl82r+YS3l
 31J9RhgxJXYZgBVNVIyaoiMSih8koncpXK8s1EuswWl1pDl34lf/X78eW25ZkVG155hS
 hikOQftg5HzBYj9L2RsTjU0XPNYNZC1UVdpRn3pC4gTk+s+idVFn16gY7k27972co+kN
 Vm5K3+msWUwWgXjMvUNTmQCuxlWWi4gceec5QurBINZwIFyKUfMefo0a/wUUXUs//OY3
 Ebgw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lBu7jXCo
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

Add more building instructions for existing SoCs.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/board/rockchip/rockchip.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 369dadbce53f..046f70d4ef0f 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -241,6 +241,13 @@ To build px30 boards:
         make evb-px30_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
+To build rk3036 boards:
+
+.. code-block:: bash
+
+        make evb-rk3036_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
 To build rk3066 boards:
 
 .. code-block:: bash
@@ -248,6 +255,27 @@ To build rk3066 boards:
         make mk808_defconfig
         make CROSS_COMPILE=arm-linux-gnueabihf-
 
+To build rk3128 boards:
+
+.. code-block:: bash
+
+        make evb-rk3128_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
+To build rk3188 boards:
+
+.. code-block:: bash
+
+        make rock_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
+To build rk3229 boards:
+
+.. code-block:: bash
+
+        make evb-rk3229_defconfig
+        make CROSS_COMPILE=arm-linux-gnueabihf-
+
 To build rk3288 boards:
 
 .. code-block:: bash
-- 
2.39.5

