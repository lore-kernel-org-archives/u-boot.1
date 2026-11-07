Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516FA606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WvncM73Q;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cyGxfr8c
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D74860823;
	Sat,  7 Nov 2026 12:50:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gftFVvJCQvJV; Sat,  7 Nov 2026 12:50:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6097060A44
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055819;
	b=UpIbhdKpktmNadmKjC68h/W2SmcS8NyAJjMzACQvNySIRXK7RXREoDFJgLbNK12UlONv
	 piPDN3cVbbBNPb9pDy6m2tTxotPUVrZlsxCQJjeNjSp/jxa9jRPeCiqyPQ/e0ejp4c2m/
	 /S9Ofov+jyDdoMjPIwiAam73wnjKV3mwA6xv9Z0G9eL5Cfuw+m2fxEVVZaxeLeHB/MSJe
	 pzTsvzisWwrnxGC4LnPoV2J+z+ttCfmRFMKF38qxMxvI4cojIScpQj4Wa33SuKPcYRPPO
	 i504c3kCBmCzlKl03Rl1wi5YeBe9+0od6JRVYTVGPUqg/Nj3XbAv0LHHIEBvFrlDmDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055819;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ysEC47GrWCxRUA6W5i95x4yDcl8YXgfb8irRd0NP1Cw=;
	b=AIEGzN24rCczwl/zVdDas8xdtVRqDCVCUOLXQsZVSi3TEH7xkPz/rjycjdc8TzLsq+eY
	 4ADNn3/eOxhw8uY+YmqfBv4yD/WEAEgtwttyGDWnsdmQaKf+/6e8YJ3HOPp5CnVuZy9B/
	 bYA++W4vP1x9q7TqdgR/qXAzXRbbXhJW/QrEbuvoARv6LIlBco/QVLi7MRHywf1TGXGfc
	 qlYZo4iWEnwXBGnU9+LOQCtcTDj8IpXzVBlm2MjzWExTLM1ke+VbytHYfwKQW/u8kla6d
	 hxdEMs4KFMTDIWsMhJmIyqlyO0maFn9BfrOw0eA4DpNcFuRjuGF0E42P9dg2lOFrSog==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055819;
	bh=ysEC47GrWCxRUA6W5i95x4yDcl8YXgfb8irRd0NP1Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WvncM73QT2yRDDsv1NRhACV5s2NuGDznuSfbhWzzlL0lv3rD5f1w0L97jWIxb4HKk
	 oQ+FVOFGG2cvzxTz3dOfAbpOpA6/CJDwlUJABVMMlazRUMSDyPgCz1iG0S2CIDkzEV
	 jwg+MNGEpbm7AMSyngpsWwOsmdMhS8RbWdtcSHVbRJRubDKWUJV1hM7namJAXlv+Kj
	 n6IG0LxBHIzPhRZjBuyNSBrQyVj7BWlvY8lPc4TLtOCN7cEyptabpcJMvfGx3pgeN8
	 dKYI2W6JCUzD8fkccXbe1KWCu7pDf0AwFKWJZOh8GY8Jyk7d35A9jLkgetrVT/7GbV
	 Od45F09z3mcIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6097060A44;
	Sat,  7 Nov 2026 12:50:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5990E34D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BA7B4005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TKK2XyNoeUED for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6E61540042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=cyGxfr8c
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E61540042
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:24 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b5816be7d0so189475a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036203; x=1794641003;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ysEC47GrWCxRUA6W5i95x4yDcl8YXgfb8irRd0NP1Cw=;
 b=cyGxfr8cxxZmOqL3w+MuPRiSqFytEN688aaos2SOhhEolDvQ1+3XkXeTDvxX32vxMF
 qDU6L712MMG4+8A8sJ2jIGq6ThiYmFTEaN/B+i+JEX1xu6AFhiPJf/6aceClrrsCxl9B
 UzlWfr6alGQMgq6n3wQVNMYvNrFIwFEaE4CWdBbOK1+6i0LP4sUW+51f6GDr2iuO7S+H
 uoCE7JDpCvqsr1knhJP5OZTRPAtPYHHMJ4DD4J78K/uC/wbPA2QMs46IPYBBVbpkF0vA
 B+IDglwmVRKFEdRKpgShekzRxfPO910m70JYVGh+7FlFfi8Mz9L5ZQ70qcl6LkZaR/e8
 3APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036203; x=1794641003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ysEC47GrWCxRUA6W5i95x4yDcl8YXgfb8irRd0NP1Cw=;
 b=IgiwttTsRwVx8afkbal/wkOeIA1cG1YO7kGSDWaT2gTp7PxPr95KcyGURDB74vukbY
 JA0exD1YeuJyx+q2w/Y4X/N7MwZGD+D5NL5VX4hluUoXhevTbDhW5m7YT+jOOuFaBilI
 6q8R/MsK0eZdo/v8BVzB+ylmTZWupf3YVPQrQE77lF9By94g9uf9UWPV4OEBVQwa6kb1
 +1Lmbl9oVUT7pqamhf7Y6NHcL7iQ612wkGnH03pQxfLsKf/d/tFw1p31Y9GmV7s4l2AX
 I7cW+AFW4tLLFIUnPTdvJB7/i1LPHBl8UgNo1Cvd+lTusx2XSk6oKSjFNWgkfEz5KXpF
 0PFA==
X-Gm-Message-State: APuU4Z8FDsSA1nNOVQQ0zaRZWSm9/Ziz8LkqF7JanMfC1juiCSA8SM2N
 KpZ+6/mffmUS33L9dpwKlohfAzozvMVxLFyVmUOTSG9WEHQSXRN9H4p5PDbB8yYvxgV38FcAOTU
 gtuCA
X-Gm-Gg: AYBFou14MTjuqT1mqhABUDYjozuk15lR03HrzSSPllGuNAK98p3OW8U3FtO0TGfoYHq
 8JbMM3kSYSaVz8A3Q8J37yCMvlFcUcxOAPOsd/1S9F8jDVRC81PAXt/L4NEFLSfZAI3BAAvk3Yi
 r3+D350Nt4MzkMN2wo2wMfMMdPFoEGcWM3FgzbbPARHKXfcggBTTBt0AJU0t7GBw/evEYKYB4y6
 JfRWFxIV3+CihD86aGGuHuIVAEXVJciWrCP4yr6gld7gGzOySUxh+H//Cqo5Zb+0MMmwhk5vaGj
 FBXJbVHLQ5I2UyYm+lobqBRfFJOE+ngB7ub/Fj4ewqd3WJiij1p+ENTwpLf/WHF8tsGZM/+hHSS
 /uhUG6K7EEA7P9QrDyntPheTfO8Dk6kYUx0hlQkPJqcdJd42Ty90mRBKeOSZMBwRRV8GTMJsyJ3
 2B2Wz7eZiUyE3nQwBkT43pjpBwvR+XxTe2c/Dund9fYJW2VdXrsvpzUahXd/a1JH+Hc/yoZ06w3
 ShRp5UMtBiRbKqEqXmJ5cSZ++OCmxk7iXwsmnIJwqhnxl7nISn/KhOu+m4No0VeuTh+hkxmRB9Y
 hq78fNGKhpvXkuXG0BJf1+F1gu3mvHk7o76eptMIDg6cN1WtRtSACPzZsNiYEoU9kMxI1h4oONB
 aq/tNGt35tw==
X-Received: by 2002:a05:6402:784:b0:6b5:832f:10ea with SMTP id
 4fb4d7f45d1cf-6b59756b7f2mr3450327a12.1.1794036203056; 
 Fri, 06 Nov 2026 23:23:23 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664afe545sm1490649a12.23.2026.11.06.23.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:23:22 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 15/30] usb: dwc3: core: flush the event buffer after
 allocation
Date: Sat,  7 Nov 2026 08:22:09 +0100
Message-ID: <20261107072224.3492260-16-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The event buffer is cached heap memory in U-Boot. Without a flush,
dirty lines can be written back over events, and the driver reads
garbage:

  dwc3-generic-peripheral usb@488d0000: UNKNOWN IRQ type 1935630945

The resync dropped the flush. Bring it back.

Tested on BeagleBoard-X15 with ums.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index bb86b573c056..cff8a16764e7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -307,6 +307,8 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
 	if (!evt->buf)
 		return ERR_PTR(-ENOMEM);
 
+	dwc3_flush_cache((uintptr_t)evt->buf, evt->length);
+
 	return evt;
 }
 
-- 
2.53.0

