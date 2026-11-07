Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBD606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y+0RzG1i;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=agY7575c
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7456B81764;
	Sat,  7 Nov 2026 12:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z4NjHnw0FnQH; Sat,  7 Nov 2026 12:50:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5FDC381690
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055846;
	b=UmNqDm7NNRIu4uJtz8/QUbASAHXbtM9bPe3bY50clyGwhLOrb0IOMpv1wgeKwBv8hPlV
	 REwsgjWeYKB+fS8NrZus6d5AaePdNSErMZfGstLS/smYby3vXtzfnbvHfOIe1UBIBBIee
	 UTTEcjQC/WbD8vnzV3HnI8YReOiPB3QTRNKBTx8GLXylCpL83pqHs/Mu2MYjQG2p7wIca
	 HQcn0Oh3HjaqCL7TOH1U9MizUuCKUpJ9RkmLK7ZvT1UpgagkITluU6WSey1ABJu+qOMDG
	 f2Bexu2uCggxalT6fAHRdYA/1vXjaX5E9+FaAErqUTGoXw6Qwohj90MTENdkm2psBcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
	b=l0A+0vnve3fq48uO3DO9oMsie1q1EbpNl7nSyly28kO/rtr+izQLgKQ6U+6+VIW9NSrf
	 FjM5SlHwpVx8TtkHVm4k/wRYprVapi4xUnN3Bimn+uBVU8vWtjAFe3MIvPFkw8/CfUa2j
	 4YkjivIB/MLOwwG1MWKoY8546vdYlP9k9ovfNXnaHvfo5YSRpOKq50ZhrR7TIjd6FM+jP
	 kMq4NWADXvpMfDitfQImbXms07Fg2zLkDm+iMRCi+FgT01zuJe5mWluztNgCGfKmCyU6T
	 EmQK2yozrmvcqfd7BZkwkkMQ7CKUWupqLGANjDgbtb5Gv+4c93mG6JHG509eDWDhysQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055846;
	bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y+0RzG1if05fPh03LelOjwYLSKscsmOJkcrtSlgczrT0nnP1UGNIbbIpWqupGV1/P
	 L+Jktbm0LXI8/1YSvcfxbeUuAJHrpN5NnjNyDCTFX7juUipCtaoqKMm/BxSBqpsvj6
	 AdYeklq88AsX4PyM3mUqtELFvvHLddPtK4g0To46G+r2wtbgL1QAOb7G7h6peYL2zW
	 5bj7cGgEQA3TB/VQIHEkJxWWY3he8zW/fxH+orBlADDn7VG4ty1du+ErWofvE7W43V
	 VBkdGpstapZ1Uqg//r7XRtEgisM7Kx2mcp0w5Olh9vA/2gaO1ZzX1WTeDjbky5FwXI
	 u+xV2g7Eow2GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FDC381690;
	Sat,  7 Nov 2026 12:50:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D4D41C6
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23AD94005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NBwV1dsGowPg for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 15FED40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=agY7575c
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15FED40042
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:13 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b58332b226so163116a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036252; x=1794641052;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=agY7575cIXjrcNSyy0tytVBHtu171ZktV7HutWwY5IqKDPrrGTipSJM0T212QsU6a2
 kE6K+2t5IKS7NOom+jgMdSmxZ+C4Vk/W3JVTDCeD+rCQ9RFr2A1GUwYwygWhXOTgYCwz
 h9k2Vp/OjeR3WO2exm7H8ePtuGz7DoT3z4RUAuI+N8uujmeoyicG5vQfpozIBuaB3SPh
 q7krTpHVdMvJxTtmEpVjbBAwven7/+BeU/SM2OyL3DNLdflv181sXNVNCtpCF8U0erDq
 ptnlUD4PPjZWsak2jCU9exgA0OYrWtz8C4QZ4mP9GMVek0qEXyQWn9KBvdbQ6/6AkDn2
 wPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036252; x=1794641052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=fn8L0EKM42eQyxlUzvX18Lu6cvfFtn4WAB4Rm+y5D0k6xChg8y5cim5xHVzpKKLQI/
 dXqOrR1S1XS0hPRmMzhMtsvnl0c6i/xatXUu9M3Yi+rqgZctNISd5aG5u5E4IDScB+2Q
 Sulnz6b2ouu60O3yO+3k4hUh7xYGeJh9UkFy7Rn53F2S6n//xYT6M+WIYmd/9DSIYruD
 CcrzszvOOmvjGMYaWZxMmeyITLcjqSzU9ySGzZDIg2gv4VYE7UithdGCemNO9na8X+SH
 dVhcB5tNCPzNKTgzLAE6zy5fcUBXCJnJO67NibjX9WKqjoCUwQwgBLlwf8FNQFEUrONg
 35kA==
X-Gm-Message-State: APuU4Z85Bc4bfTbeT1i1OYSuHIiX49SfugauVxcmDKABvOHTk99EQUii
 HQkdZAkRn0NWkBa05R38pGq/Bo+jKm/EitJGjnA8xjui3ua8kA8IVFSlUGdZKLgp708PUCepLbW
 gLHrR
X-Gm-Gg: AYBFou2fOH7bmlhBRyIhwNlrRVYcZQfTPXRUilniP1bY8ZVjrGqp8Xwzms1SvFNx97z
 oDefNdOlZr7Ss3B8YWxl0gT1fCdvWIHXxLzUsrMxjyejQh7VoHNHfhK4RcG/76zxdE2BNDGGwcD
 RxnB9Gy1/jTaUNRHGO1u/6KkIGQ8Egs+CVmkLbtk/ijA2zkhynPKVoe6F0Gda1PMMetoLL6DM1r
 1ID+h17phBA2G6w880eoQSJ1jx3voJb3p0YnsVAyZZ7dHA+gbPCEzjfXiKBUMFzIwenhTMwhJ0N
 1cohw5hyvmGyav7iT/k5QwyFBBwwjoXKWlDfbaRnIGzTLkGMye/Mkknr6U4QAE0anl5fGRuJLvx
 HH8P2pCSx1JtbL67omSItFRVaqpk9OUyQDfVAFd2MP1BENBg4pEJ8PBVqAff1ajDWDVKzbNAxRe
 rhssi/WYK4N6VyBCCcR2FVl3+pICPeQ2jP2yIm3+2JOUnTbZPid4zp5zctXPkjhjefBf2+uUCGQ
 4SBl0JVpxIgNGqsc61pv7Owa9HwE+4cyFfEYa+SzCaJauK+VDIKTKUcdtBIXF7zuC5UmrZpMyyL
 G0nkjiiSKDPJq9w0Kng+rDEH/YloUYHj7kM4eKYiG2uSuWFVyL1V8BWkogppRPl4CPq0rH2qxZb
 SpR18B/ce1I8=
X-Received: by 2002:a17:906:ccce:b0:c2e:8801:9139 with SMTP id
 a640c23a62f3a-c4d34a09e16mr365245966b.1.1794036251788; 
 Fri, 06 Nov 2026 23:24:11 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ea8csm130129166b.22.2026.11.06.23.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:11 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 28/30] usb: mtu3: set endpoint capabilities
Date: Sat,  7 Nov 2026 08:22:22 +0100
Message-ID: <20261107072224.3492260-29-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mtu3 already uses usb_ep_set_maxpacket_limit(), so only the caps field is
missing. Without it usb_gadget_ep_match_desc() finds no endpoint after
the dwc3 resync.

Set the capabilities like the kernel driver does.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/mtu3/mtu3_gadget.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index da633faae7b2..f209bf47d073 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -591,10 +591,20 @@ static void init_hw_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 	/* initialize maxpacket as SS */
 	if (!epnum) {
 		usb_ep_set_maxpacket_limit(&mep->ep, USB_HS_MAXP);
+		mep->ep.caps.type_control = 1;
+		mep->ep.caps.dir_in = 1;
+		mep->ep.caps.dir_out = 1;
 		mep->ep.ops = &mtu3_ep0_ops;
 		mtu->g.ep0 = &mep->ep;
 	} else {
 		usb_ep_set_maxpacket_limit(&mep->ep, USB_SS_MAXP);
+		mep->ep.caps.type_iso = 1;
+		mep->ep.caps.type_bulk = 1;
+		mep->ep.caps.type_int = 1;
+		if (is_in)
+			mep->ep.caps.dir_in = 1;
+		else
+			mep->ep.caps.dir_out = 1;
 		mep->ep.ops = &mtu3_ep_ops;
 		list_add_tail(&mep->ep.ep_list, &mtu->g.ep_list);
 	}
-- 
2.53.0

