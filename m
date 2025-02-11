Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40030C0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 06:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C902D803CC;
	Tue, 11 Feb 2025 07:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739254432;
	bh=uOFoZSzP2PUdogqq2p2zti2sCjg1Xjq3sQJ1XSBBOqo=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=B3ZiDWHRA+a0PvYPL88EblMK9y2O06xiiQ4kYz5sHiruSfARrsWJJU/rdSVz8O6BL
	 APwom4R+KcQByYedFSqMsdVKGsGjd+8XtcqkUFPJ+iglpn08iG3KThn326aU6Z7M70
	 9oJlzHfmU0+SfF+Yyum0RH6+LBsLXzeV7jXI7y0xfBzgqBrAnul9LzCKspN1Xm4H9I
	 MMNsNDywYBYqmpEqu2g9Ph9oI+IXIvS9MUY2gwNnzBYU3mn/60Uf61h5x2WHTpz3+b
	 KKKpQF0a8BPgaNNyV9/RfkPPPNGBUzQVcKRDkXR/qA1nJSz4qSOOPXmCOhImN1T2VA
	 Q81ctD4w+0LoA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0BC18043C; Tue, 11 Feb 2025 07:13:50 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A27800CF
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 07:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Fa6La8vZ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 09A5410382C25; Tue, 11 Feb 2025 07:13:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739254426; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOFoZSzP2PUdogqq2p2zti2sCjg1Xjq3sQJ1XSBBOqo=;
 b=Fa6La8vZ5SIvfP+gHcv2uR741O9LMtqOZZ61Y9gd/D4XmHovNGXn/ctgb0LJNu2d4/vF3S
 m/octKbjjFe97Ct+H4DYb1gVnoIXxONNhs5C/+j8yM6nFNRdYVJbYjLUgUbYhwZ/PRxgZD
 +mVmOb6W154b3dJhZXNznbSDuOwRaLJmZ6Y3v5imcY0eNaOHeVhT+NYSdDVYz5z03I1niq
 9DfZ76TKcMD2LdEmSVRSXiXiSTtf6WtXdNpfdcU6ukwFCs5MbIYVuOX25yBstN1v7qzGrz
 EGmpSXAFNUxvClmk7jSn0QUBfT25F+qG9sYdaBSRdYRAxwRKZmUVxVTjVhRaAg==
Message-ID: <50aac486-a3b7-7f56-b133-b28f1de0ad25@denx.de>
Date: Tue, 11 Feb 2025 07:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
References: <20250210222622.GS1233568@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250210222622.GS1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 10.02.25 23:26, Tom Rini wrote:
> Here's the latest report.
> 
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Feb 10, 2025 at 4:12 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to Das U-Boot
> found with Coverity Scan.
> 
> 3 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 
> 
> New defect(s) Reported-by: Coverity Scan
> Showing 3 of 3 defect(s)
> 
> 
> ** CID 541281:  Insecure data handling  (TAINTED_SCALAR)
> /lib/tpm-v2.c: 77 in tpm2_scan_masks()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 541281:  Insecure data handling  (TAINTED_SCALAR)
> /lib/tpm-v2.c: 77 in tpm2_scan_masks()
> 71      *mask = 0;
> 72
> 73      rc = tpm2_get_pcr_info(dev, &pcrs);
> 74      if (rc)
> 75              return rc;
> 76
>>>>      CID 541281:  Insecure data handling  (TAINTED_SCALAR)
>>>>      Using tainted variable "pcrs.count" as a loop boundary.
> 77      for (i = 0; i < pcrs.count; i++) {
> 78              struct tpms_pcr_selection *sel = &pcrs.selection[i];
> 79              size_t j;
> 80              u32 hash_mask = 0;
> 81
> 82              for (j = 0; j < ARRAY_SIZE(hash_algo_list); j++) {
> 
> ** CID 541280:  Insecure data handling  (TAINTED_SCALAR)
> /cmd/tpm-v2.c: 307 in do_tpm2_pcrallocate()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 541280:  Insecure data handling  (TAINTED_SCALAR)
> /cmd/tpm-v2.c: 307 in do_tpm2_pcrallocate()
> 301                      * first call
> 302                      */
> 303                     ret = tpm2_get_pcr_info(dev, &pcr);
> 304                     if (ret)
> 305                             return ret;
> 306
>>>>      CID 541280:  Insecure data handling  (TAINTED_SCALAR)
>>>>      Using tainted variable "pcr.count" as a loop boundary.
> 307                     for (i = 0; i < pcr.count; i++) {
> 308                             struct tpms_pcr_selection *sel =
> &pcr.selection[i];
> 309                             const char *name;
> 310
> 311                             if (!tpm2_is_active_bank(sel))
> 312                                     continue;
> 
> ** CID 541279:    (TAINTED_SCALAR)
> /drivers/led/led-uclass.c: 284 in led_get_function_name()
> /drivers/led/led-uclass.c: 279 in led_get_function_name()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 541279:    (TAINTED_SCALAR)
> /drivers/led/led-uclass.c: 284 in led_get_function_name()
> 278                     if (!ret) {
> 279                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
> 280                                      "%s:%s-%d",
> 281                                      cp ? "" : led_colors[color],
> 282                                      func ? func : "", enumerator);
> 283                     } else {
>>>>      CID 541279:    (TAINTED_SCALAR)
>>>>      Using tainted variable "color" as an index into an array
> "led_colors".
> 284                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
> 285                                      "%s:%s",
> 286                                      cp ? "" : led_colors[color],
> 287                                      func ? func : "");
> 288                     }
> 289                     uc_plat->label = uc_plat->name;
> /drivers/led/led-uclass.c: 279 in led_get_function_name()
> 273             /* Now try to detect function label name */
> 274             func = dev_read_string(dev, "function");
> 275             cp = dev_read_u32(dev, "color", &color);
> 276             if (cp == 0 || func) {
> 277                     ret = dev_read_u32(dev, "function-enumerator",
> &enumerator);
> 278                     if (!ret) {
>>>>      CID 541279:    (TAINTED_SCALAR)
>>>>      Using tainted variable "color" as an index into an array
> "led_colors".
> 279                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
> 280                                      "%s:%s-%d",
> 281                                      cp ? "" : led_colors[color],
> 282                                      func ? func : "", enumerator);
> 283                     } else {
> 284                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
> 
> 
> ----- End forwarded message -----
> 

Just a fast idea:

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 27ef890ed0a..fc15a0811e0 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -273,6 +273,10 @@ static const char *led_get_function_name(struct udevice *dev)
         /* Now try to detect function label name */
         func = dev_read_string(dev, "function");
         cp = dev_read_u32(dev, "color", &color);
+       // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
+       if ((color < LED_COLOR_ID_WHITE) || (color >= LED_COLOR_ID_MAX))
+               cp = -EINVAL;
+
         if (cp == 0 || func) {
                 ret = dev_read_u32(dev, "function-enumerator", &enumerator);
                 if (!ret) {

If okay, I can send a patch for this.

Or may better, we move this check into a new function:

int dev_read_min_max_u32(const struct udevice *dev, u32 min, u32 max, const char *propname, u32 *outp)

which returns -EINVAL, if readden value is not in [min, max] range?

So may this function can be used at other places too?

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
