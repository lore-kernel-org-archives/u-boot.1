Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3A606A331
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AcYEwW+e;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KEifISwX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF0DC60EE1;
	Sat, 21 Nov 2026 13:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XfwaFmbN82RY; Sat, 21 Nov 2026 13:15:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4DE2F606DB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266884;
	b=pQIYEyjTLFSjwZkdW5UOx/vCIZrjYQoYNB5p1Zn+HpaR859v0GEdpg+G+QR/FFhi1XrP
	 t/6j0idOCJFeHYDdhx2/glafZNk9KofcQG8IiL4tOM2WFnG0353eXo53hOM6whYWRtu4H
	 29eAST8XQtFaYCOfQAN+vX9BAsVrqJOr2Hl1c8T1jDC0oShrWEHaObxx5uqNj5/ypYAup
	 mcciT9LneIVivPto69eQc75STbn7KhMsl6ex/R2WCXCEW5ppIDm9nAVy4gIX6zi8n5akk
	 GTGv/7Khontjs1892UIQ9miEDSaCaY9AB/ATpjDsyF0TqjZEm7WbJ5Cx0KZdKxcuT/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FdVQx4/ga62i3MFyfsnakke6hvdkKXfnbqNXpuaZe2s=;
	b=MbuUF88pscLKltISetBCKWLEW8U+eDxABPCA9Ih5yqhfuwFT93A8HvksOCLlKuBKBXhT
	 mR3poeRQ03JkySmomQO+mi/fIVNox9m3bDNIzyx3C5h+MHI2W7r4xQAk1mZNuCSMmvq/h
	 xgnVApWjM1meVcprWs7hvUTFFmY6eRPISJPJkoARnxJd/fsxyBqRJTHw2/gdwEkmW3doL
	 1K5is54hrep7xXmaX+kW3PDLBywMCRa9vLKfppWgVgDvO+Hc3Kq2uKbvxULibLuZbl+aB
	 iZ7rpK4pjHc9sYTlrBobAdx88opWB5nym4cQuU0XN+ce6mnauQAESRKeYBCZmMfSKPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KEifISwX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266884;
	bh=FdVQx4/ga62i3MFyfsnakke6hvdkKXfnbqNXpuaZe2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AcYEwW+eRVqTVAcyD8BDEkfvsEHTLk7gO8KFk601OORWOnUDbWfqBj5M1Bsh1PV9c
	 lrQL6p5ws9zPCl7WOeQXw6xhvQfBya7DZtJwRMmoMj+bgq25arpsfzLM2OIwACqCau
	 UJdXTobiieRqmGdkP9hzBRnApREF6oDF7TNqib2LFX6hmCB8tCRfVKfqPAiRzILWIa
	 POqhn2Rc2a1cQ5FC95QSosYEkgUxGneNEDmSLci+g0jNMOpD77wsVw5W+kNmubwdNv
	 PoRt1WQRyNnWvK287JjOnDuS1QvSK3aZ4+pfVmZjDZezLRl6g4jPQJiy0IPUHtzJM1
	 Rg8QW8uupOHXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DE2F606DB;
	Sat, 21 Nov 2026 13:14:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 47F3315D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E45B60623
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oqCle083u2Oh for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:54:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4EE8A60621
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=KEifISwX
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EE8A60621
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:54:50 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c50686daf9cso43133566b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262088; x=1795866888;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FdVQx4/ga62i3MFyfsnakke6hvdkKXfnbqNXpuaZe2s=;
 b=KEifISwXNLWlj9aKMfsivNQPq8ceYdCj3tKyF/6VAEHm3a7wIEo9oEZ+iGbyC9oQSh
 tnhEWeK1Gy67tFB/0YsP3fYC/fDah9nb4qlebrMEZBJy+Zo3k1txYYqscOp5ORsGT5kX
 mBduh/a4FlrJWxhn5lTO96p+E67zrve9s9S7Pue8zW84sJ1NmWHHZeA4WMaQpRY7xKY4
 DJqlF64HH5wLjWMNJuCM67ZuSDijWvW8BEuwJwFcV68++Sj1WKS6l33WD0RLiAlR3VGc
 DMmcvvP82YDAP37NgloK+C/ehsKaERVRwhhkx9Vq+qPtvLuNj1GeEc8f5CSj0ITv12hr
 dVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262088; x=1795866888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FdVQx4/ga62i3MFyfsnakke6hvdkKXfnbqNXpuaZe2s=;
 b=pEfoTsHGX6BcWpUjCAPuwRUh0/ZvXS34WNvfUnSNU1iUpQMDsM0y9NakZL60TezsoI
 Ayxc0ikilX95+PaciIa70ipa1ZCAHcrZJRHneK7gb95jAa/FWKLFDil2/IffIfpAmN6m
 g6MKvkeYaTbzfxW0AU++Tt8RI59aY3DVmoAa4iD5AHbw7/j7qTK/7FZYulG9HDhHY/XE
 a4wVKE0AUWPd5WQ2w/mFthcEqPhiq40vgyT/ILVOYb79lJRQCO1k412Okp0nQAkDVToh
 nlHMiq/M1TEMoPiktX7+exO6nN+nAw8ONA0oNeFvyXGy3j+2ikR3tysYUtXK634lSlvm
 KwAA==
X-Gm-Message-State: APuU4Z8yYSnrw1wXbKMAGDthXLC4aivUYFhIWAYYBrmUDSRYsSMZQJW7
 nQ4HU9EQUEs6wGLcHGgi6UeM36lCz4D8oGFf4pv/O4AVrHquk+5P67alxt2iC+8QyYuFWnE19eR
 qQCvG
X-Gm-Gg: AZFdTZeclG1neyBpl65vgVmzjpUtk2d1ZQbYBfq+nzYgX2j/SISrTBqed9q8uWfzywl
 ilfNblNMoifPXbER7lev18SGcYGViNVYvxeI5FWVKK/vUwFOxABPvh7jweZmHucRJ3j/MfSzCQ6
 OUsMxBy7iaZVEvk7RQHudcsJnA2ynXbHbywH2lD66NuA48dyP4Gf+x987DOhb1fLsBTuT73Uvem
 0tpAMqsc9lN9GrwIFIMsgrVBeULLEDm2m2KrJ7rsH3TjzJmF2J+xHWbrH8dfucOAw+UiHBKHpeF
 nhS7UPKtDwpynSEFK8BsKr7Qmq1uBFynM6Ry3k2V7XzWwkhaMrUAi6cCVfHkscfUUqs2tRI4ZzF
 27injmSBtKG+A10jGu378ltubGP4ms53v0YY+V4j0OoBFc7mDr+/SIpbuDemwslLSKezk6mnqLi
 +skuzzTigm3dhOtqYFWvMDj9rqi9OeJIhSAoDFoGvfebqEh9cK2lolD9X/WjxDUGOujeJwAPpR3
 6jFeNlDfWsFvPQbn0Fia9nLKOypFpX8/AvNxbLeKIQXxqk3cE1QMI1rVgLgFlps/MoFzx4Ex9YA
 GXLt7Z2kuDSkSEINxTAhBwS2tw9yzWCYL9H0NaoMv7SErp5KvHk03PU7cAL8iT5dzhX1b+40w81
 WwLnvoGiTlQ8fhC2kf9qMMPDL0QkgEac=
X-Received: by 2002:a17:906:6042:b0:c3f:98d4:dfda with SMTP id
 a640c23a62f3a-c513a5f04b2mr528017466b.3.1795262088188; 
 Sat, 21 Nov 2026 03:54:48 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513a8678cdsm186595766b.0.2026.11.21.03.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:54:47 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 16/31] usb: dwc3: core: flush the event buffer after
 allocation
Date: Sat, 21 Nov 2026 12:53:20 +0100
Message-ID: <20261121115335.548142-17-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
index dda57c2b950c..85d380e67233 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -306,6 +306,8 @@ static struct dwc3_event_buffer *dwc3_alloc_one_event_buffer(struct dwc3 *dwc,
 	if (!evt->buf)
 		return ERR_PTR(-ENOMEM);
 
+	dwc3_flush_cache((uintptr_t)evt->buf, evt->length);
+
 	return evt;
 }
 
-- 
2.53.0

