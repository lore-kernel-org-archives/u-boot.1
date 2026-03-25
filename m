Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F4F106B533
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 13:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BF883AAB;
	Wed, 25 Mar 2026 14:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="n0N8XTVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E217E83CD3; Wed, 25 Mar 2026 14:20:43 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A1B81E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 14:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DD424kgKA7DPfyHp8B2ld30/Mq3EbqFBdjqU01+avJU=; b=n0N8XTVMiFvmX/W5IFJmjuzIBz
 tihklz2wLSudHxq7pCXpLrbsNL2WELuDJn6p30M745v6DT1WGCEbAxcX1cS1SU1p1XLzaqf1hqQM3
 au5/yzCCoSwrN1LVyXjZytTzQgKO3X+2G3AsYsT8LoSjo1460Cm/hDZ7bvALrkmO/BySrB0VyLcD1
 hegnKULOfOLIcJgJ0LKuxmKE+D/FuQa16YyU9m4AQrZibKwd8ZOhbRXVQEMtb/SmAcvNZeNt3ET+S
 ckQ6zpIDSVJ5k2pZ+QuTXVJQKHa/REoI+rSdsxTqewQIroJVXVEoAvvduXLn/wkQVhwOrXydFvmJ3
 wFEhWByQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1w5OA0-000HEX-01; Wed, 25 Mar 2026 14:20:36 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1w5O9S-000BxT-15; Wed, 25 Mar 2026 14:20:35 +0100
Message-ID: <5b39b321-e318-4112-9edd-78ae6562301b@ew.tq-group.com>
Date: Wed, 25 Mar 2026 14:20:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/8] board/tq: Add common SoM API
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-3-Alexander.Feilke@ew.tq-group.com>
 <acPGEGc16f3xwasm@shlinux89>
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <acPGEGc16f3xwasm@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 25.03.2026 at 12:25 Peng Fan wrote:
> On Wed, Mar 25, 2026 at 10:57:55AM +0100, Alexander Feilke wrote:
>> From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>>
>> Reduce code duplication by adding a default implementation.
>>
>> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
>> ---
>> +static inline void tq_som_check_bits_set(u32 address, u32 mask)
>> +{
>> +	while ((readl(address) & mask) != mask)
>> +		;
> You may need to use readl_poll_timeout API.
>
> Regards
> Peng

Thanks for the suggestion. I successfully tested the patch below with 
all our RAM variants.
You may apply it directly or I can send a v3 if you prefer that.

---

diff --git a/board/tq/common/tq_som.h b/board/tq/common/tq_som.h
index d7168eb7e46..0ab01d51f99 100644
--- a/board/tq/common/tq_som.h
+++ b/board/tq/common/tq_som.h
@@ -10,6 +10,7 @@

  #include <init.h>
  #include <asm/io.h>
+#include <linux/iopoll.h>

  void tq_som_ram_init(void);

@@ -27,8 +28,8 @@ bool tq_som_ram_check_size(long ram_size);

  static inline void tq_som_check_bits_set(u32 address, u32 mask)
  {
-    while ((readl(address) & mask) != mask)
-        ;
+    u32 val;
+    readl_poll_timeout(address, val, (val & mask) == mask, 1000);
  }

  #endif /* __TQ_SOM_H */

