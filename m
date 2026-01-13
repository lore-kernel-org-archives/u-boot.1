Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED200D2F356
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 18:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675ED800AB;
	Tue, 13 Jan 2026 19:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="RjjWKhDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A80F802C1; Tue, 13 Jan 2026 19:13:59 +0100 (CET)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 199ED80077
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 19:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Tue, 13 Jan 2026 18:12:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1768328035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hU8sOCfnWtqpDtJSRxpUWwY6K6qC1CHSpfEcPstIdxA=;
 b=RjjWKhDyZbLu0dN9Qtipv9dvhS7gJDoyycB9JfUPOgcf5JIKWCo0q+/yixrXbi/u8GTjzL
 iiFbsRlcmRUzYpbSLYWv9iv2PZeC34zlNQDhav6x/xRXsLXyxktbAevmAYMm37TKmyPl6F
 Y+byEUSRMSr6MV47bjmcczxBPkb3RKGDpSTIcEY1KQyq5Q67xnX7oIAx3ZJRPOKfqPzO69
 vWOvvfOgpnY9Kji/qEZU6eoKnFc4wliCwojrj7DO+dXRkq6UaGPlNAOrL1cgbAAuQSi3C9
 NrMDrBXmmEzBMjxxwcUrquAID1BJ3iNyQQWKwXgJkGa17WvAYzVBPIC4rsvLkQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Robert Marko <robert.marko@sartura.hr>, neil.armstrong@linaro.org,
 trini@konsulko.com, jonas@kwiboo.se, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH] tools: amlimage: include <inttypes.h>
References: <20260113110806.648534-1-robert.marko@sartura.hr>
In-Reply-To: <20260113110806.648534-1-robert.marko@sartura.hr>
Message-ID: <t8temk.1sj20mnghi4uk@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

On Tue, 13 Jan 2026 11:07, Robert Marko <robert.marko@sartura.hr> wrote:
>PRIuN, PRIxN, etc macros are defined in <inttypes.h>, without it being
>included errors like:
>tools/amlimage.c:124:38: error: expected ‘)’ before ‘PRIu8’
>tools/amlimage.c:126:31: error: expected ‘)’ before ‘PRIu32’
>
>Can be hit depending on the host compiler and HOSTCFLAGS.
>
>Fixes: 18c1654567dc ("tools: mkimage: Add Amlogic Boot Image type")
>Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>---
> tools/amlimage.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/tools/amlimage.c b/tools/amlimage.c
>index ecb06bc535b..bc6e19b9c24 100644
>--- a/tools/amlimage.c
>+++ b/tools/amlimage.c
>@@ -2,6 +2,7 @@
> // Copyright Contributors to the U-Boot project.
> 
> #include "imagetool.h"
>+#include <inttypes.h>
> #include <u-boot/sha256.h>
> 
> /*
>-- 
>2.52.0
>

Looks good to me, thanks!

Reviewed-by: Ferass El Hafidi <funderscore@postmarketos.org>

Best regards,
Ferass
