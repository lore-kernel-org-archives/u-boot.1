Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138A8CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C967845E3;
	Thu, 30 Apr 2026 10:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="V6Pn7wAe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC398460D; Thu, 30 Apr 2026 10:10:48 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4082C84198
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joaomarcos.costa@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B9E031A347B;
 Thu, 30 Apr 2026 08:10:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 893B660495;
 Thu, 30 Apr 2026 08:10:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D7261072B764; 
 Thu, 30 Apr 2026 10:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777536643; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=alGUnEg2ZynRoRvctq6bT4dtay0RXIjrUS7xQmrPUgM=;
 b=V6Pn7wAetl3zyg3xcqpXm0dqEok9u1RPFlximLLDcCvGl5+kdpXsSToolzac3W6869McRB
 0wZms9yDh9ToWGRvHD1EO9XdOUkKRthvDFdxLtMoVvd4Z6wz6gmgqdsnSdYAl/MYPTvQF5
 GU4zpWZ57Rn9ygWI7pCq0ifsTkkaSKKB6FAMtKfm8O55keeQ5AruTsH2gbzAGk9e59UvRI
 rOhsogoTw24JWS2G/bUf+ExSp3ICR7ENaKxW+SDCaJBGiV8DwnwY3ByCJdHNrWAsIjdgz3
 b5RSQLJ+66j4wyfhq46jpmeev/8igeCSpxVjW/u9eqGF8kGudeOpks4QSP22uA==
Message-ID: <e2621e78-428d-4a59-add3-a57658a1151d@bootlin.com>
Date: Thu, 30 Apr 2026 10:10:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/dtc: drop yaml in DT validation
To: Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Greg Malysa <malysagreg@gmail.com>, David Lechner <dlechner@baylibre.com>
Cc: thomas.petazzoni@bootlin.com
References: <20260429144615.142350-1-joaomarcos.costa@bootlin.com>
 <01c1fa30-6dcc-443d-a217-b032a0a8b53b@cherry.de>
 <e037306a-86f6-4df8-8486-73902792a914@mailbox.org>
Content-Language: en-US, fr
From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Organization: Bootlin
In-Reply-To: <e037306a-86f6-4df8-8486-73902792a914@mailbox.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello,

On 4/29/26 18:08, Marek Vasut wrote:
(...)
>> I'm kinda worried we've been missing other patches since our last sync 
>> claims we bumped to 6.1 so we should have had this commit.
> 
> The last DTC sync should put U-Boot at Linux 6.17.y , see:
> 
> 0535e46d55d7 ("scripts/dtc: Update to upstream version 
> v1.7.2-35-g52f07dcca47c")
> 
> So I wonder how this patch got missed or slipped through the cracks.
> 
>> It'd be nice to know which (if any) issues you encountered when 
>> backporting the patch (e.g. things you didn't backport on purpose and 
>> why).
> 
> I agree, and it would be very helpful to check for any other missing 
> patches.

So, this is the list of changes in the original patch (i.e., git show 
--stat):

1) Documentation/devicetree/bindings/Makefile
2) .../devicetree/bindings/writing-schema.rst
3) scripts/Makefile.lib
4) scripts/dtc/Makefile
5) scripts/dtc/update-dtc-source.sh

As for (1), the first and third chunks were already applied. The second 
one (below) seemed to be N/A:

-always-$(CHECK_DT_BINDING) += $(patsubst 
$(srctree)/$(src)/%.yaml,%.example.dt.yaml, $(CHK_DT_DOCS))
+always-$(CHECK_DT_BINDING) += $(patsubst 
$(srctree)/$(src)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))

About (2), it was already applied as well, nothing to be done there.

About (3), I might be wrong because I'm not familiar with this file, but 
I skipped this chunk because it also seemed to be N/A:

-$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
-       $(call if_changed_dep,dtc)
-
-$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
-       $(call if_changed_dep,dtc)
-

another chunk I skipped in (3), because it seemed to be partially 
applied (e.g., the || true and the ifneq on top):

+ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
  DT_CHECKER ?= dt-validate
  DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
  DT_BINDING_DIR := Documentation/devicetree/bindings
  DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json

  quiet_cmd_dtb_check =  CHECK   $@
-      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u 
$(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@
+      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u 
$(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
+endif

but now I'm reconsidering...please let me know what you think.

Still regarding (3), I skipped the 4th chunk (already applied) and this 
last one (below, which now I'm also reconsidering):

+$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
+       $(call if_changed_dep,dtc)
+

Finally, (4) and (5) applied fine, so not much to say about them.

Honestly, I'm not familiar with the way you sync those files (how, when, 
where, etc), so I'm not sure how much I can be of help here.

I hope this clarifies my backport, but please reach back to me if it didn't.
-- 
Best regards,
João Marcos Costa
