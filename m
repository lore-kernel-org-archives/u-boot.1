Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545B606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uXUfJ/AQ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Eeo4FdbE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6310B80C5C;
	Tue,  3 Nov 2026 21:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eN4f4PAHuvuu; Tue,  3 Nov 2026 21:26:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C97780C41
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793741206;
	b=CwcimTCkjuSHcQX7lYe36OqD6EYuTbdZ6MlVRwJiJX0vyE6LTqymLVsIMT8B79zM6ySx
	 LZyFOYl82jLr8HZzI33YMQ2zzUyOG2FWpLlpH2bYZlukyH1nkl7dq2PjvF25Y7/4SaR1n
	 885MKUoaMzF50AzTfLKohChTJPm++i7nWCKgRxP9T0NY2W8autkVBMJpSYYYeCPtE9em9
	 nnfumd2XSZdKQ09T5ne2V/X4V2RkZSvEFv8Gw8QJE6fuUSgqtRl4YWTrQCsmRXcgn89xx
	 fpY4XLsDyw1vsUvF7i9lT9T/IXBXvPy0+2HPKlEylBx7EpSlzStdkIUTM8w70OeJDAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793741206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tL2XGn+w3Mv1PakLus+jhQODJCjPknL9MDLIV6EEDi4=;
	b=p7GrRo42gEtqod9d3Ewm7BLHxXWkxMMvG1wwgPz6ccSfZlsFjBj2WOWSEp2Waag/N2Oa
	 GfnTZC9aIVnLKj6KNhu9oQ2bYtIvnZgu9VNxxuHwnhYHZWyYadeeVZ6rmtqZmoV0JDtUv
	 Cw/ycuvA05SxtycSYAIfvIbC2qFE65MDnfYzHTQIZXFw1DqPSXbI6arrBXuAmrh/pwtvP
	 U/HHgkNQoH3DI9Uxo8Lk4dutjiTyssHE3rw0S/rQnnFGd1Wt64R7qIvN8p+uqOnQZ0S68
	 DAlSpiLpOAzNJ/XWyc1J42SfK5Mv4q0+povco3+9br9IS/qtLswSvqHJYoA0XAAQF0g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793741206;
	bh=tL2XGn+w3Mv1PakLus+jhQODJCjPknL9MDLIV6EEDi4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uXUfJ/AQq4Cr3B59aDVS3pb96rMVeGQK502JtcSQaXQqYbx0allVugiQmVjvbAH0r
	 I9OznSPQ8DTAX9xkL4TcSEDrrRqZBn1/JY54j/m4Wa8NpmVv2mgd2HGspp+L9qOT3w
	 xvabyDTfZgh2kqrfVw9Jwprjg6DIhDamYAA/2wZ1om/Qo1aUfMAIm7uxrCaScSmzxH
	 GBMFvrAixGwd/LJGiNCTavDSlXZn1RNMYkxe375fOjg+WDCp39IPBU3yGuiP29sZYp
	 +tPIGdk5hCCL6fzzHUMEShyF2eb36sV4xYcDTWyzwH0sbAHHMzw6Sz9VBsWRjdDAaM
	 iJleHUv4A6H0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C97780C41;
	Tue,  3 Nov 2026 21:26:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2006784
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7DD460686
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mGgLb7SprV5p for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BCE82606A0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793741202;
 b=HPq7O092hV12h9E6sTPrdaltWpcC4inTNZfhnQ8eq4it7cTV2awtUrHsj9+Xzs0z9cRG
 1uM1pNlIEMqcoZNeRXQDQDq5QcpdC9/XGAVWg32Zsckdeg35F2A8gC1oryq2akHVSboAx
 6naEUKNS09dFtDME4kW/9MSnsrU35584mPaP/6r+mJtqOD7KRY9Pazul6RIXIiKKuS8Rl
 9CIl0/E2bXvrTsCOQBUQKmmnkyMFK8sFSI8smEKo3wcAvcg6fUsAKXwJKzDTgaK8Swczs
 /6bv2DFSm/w/1XpwiRfWpMWHepyhvUIG5hZ2UfKninZegXMwrJ/7XJduDxSxi9mOEeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793741202;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=tL2XGn+w3Mv1PakLus+jhQODJCjPknL9MDLIV6EEDi4=;
 b=dbomhybwYliWMOt9mi+nm9yKNcaSWrlL/v/uGrf8+Gi3Xaf3OTr2lBn3iilJl64fvc5N
 NlmrgUBQS1uAX150ZIa3aDIianJ7w/VMdKjr7RjSNKn8Zplodjt5stzy9MXi14lShFf9X
 j/4E8gQ/9wdP82WwcLKyPDfKiu1CFB5Z3AyQVfVWRPx7EPg5vFb/4xCHfjQUICdw75Xth
 c5DGgPDiJEh0R6DHyxC1mBMmI4x1A8H26AkBfnlpI1xn7cRkLqzNV8c32GYjE37iDt9o8
 Ol30gQiDN8M7CHBTkCPiXAhXtibjaiA5fPA5M52Q0ZGv15SVmVVll1e7GSMNoni5XqQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Eeo4FdbE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Eeo4FdbE
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCE82606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:41 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-823b938464fso7898a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793741200; x=1794346000;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tL2XGn+w3Mv1PakLus+jhQODJCjPknL9MDLIV6EEDi4=;
 b=Eeo4FdbE+dtWZ6Tf4LQK0IKCV42Zt4RWLLxh2cjuLbjT2ATA1QTGdf6QikE6AvoWVw
 saKZYZHlfavN4oyWDwe4llKYb/VIIpPIy1MoR2tP5Av2oPHP7DS6iYVl0RLI116EvYry
 dxACQHHYU5HIAB+nmNbGZVkd3CD+xAL64FIItHvDD3wDosDTm/ocmm5yzLBMWPctjQGc
 Wk5wGzQMqwFCcK7KHlqTQIOrB5KdlO+26msw9bMu9snhxeXAk3nhVhy45oeSV+ZAxYTy
 H4yJS7ucRiK9dGPjI5H28+wwcAyQ1P8ZUQnD0MGrcFzlJhqHMhqTe3sAONDRHOAt9HBp
 nFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741200; x=1794346000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tL2XGn+w3Mv1PakLus+jhQODJCjPknL9MDLIV6EEDi4=;
 b=se1JWv6saxfxPM1Lw3ms/0o/GIuaU8bydxuBRlq0h3KM8szYyUHeO7dYr8GIC+wlRg
 18t/WahAo12E0S9SDFJZGzt+FczTcmvCeAqbPXP1CkFWw1vuO6E29FpbidliqPiud1hM
 S0O77NPWCbV+Z8XY9LAoaPkC4CN7MhEloW0tKdbhtE+Bw58T3nFnQ0fGB6DflXS1I4jh
 b4eaadLMy1C5IpQ7sCD2Ga5diGdIygxl6ZKAoU0x1eUTuJpH4cy2TdZEQP+rJ5pdnmMx
 7HyBXJUkC9QsRAGfQmrwKL2OFAQ6yp4p8FMJpINhhIVH7O0Usjxwev72RImPm3RXCOKX
 RnoA==
X-Gm-Message-State: APuU4Z/3BAkFfrw5MAehauecN+Pnzk34HU7kb1KIRo7gfWyX112ri3xE
 //oLzo4GO/qCcC/pxRtKWnogD4Zr4gbVm+UDQGwTe9GvYQqB2XJBksNi+3DF4eKytW5aoGVqJsk
 eEC/5odk=
X-Gm-Gg: AYBFou1TgjDkV0zENHjr5FqWuLZCBFajiZG4duNdIyWO2BHSgKL0v6tEHHOCsZtXYz0
 HHwrA2/wHDFh9fRiTUo7hlA+ww7QSVy7a+yjqA3rDV8pupRZDMI15GtubK2JF0eUkMTaPZ4ozXX
 ShcHXoCT9jFe3dLt7FcIfGF7TFhHg3bpRJUlpTHvybWjsEjqtIA8zDi+EEvExlzUyZcCDtcnEMi
 eybC++kAhWvTbrvt1YQ1fTWUDJwmwLssDPusnnv90faTV5fjLgQwyRl3dNxqI0/FLsmW4jAHTV4
 gX3RlUom0jul4DFoybG20Rq+NAvuXWzU8CMDghZdJTy9bfJrOPkGObWIqtu9i0BEGVy4mVpDV/I
 iV3/IRW+U5U42zwT8LtV3I4QLnGZ2TE6tWwy5MDLCB/63v15pv3tnRatz39y4N3satf7osqp59E
 vdPwV+LWVVHNbJTeYBBm/Re0TycE98qCos7xJQrxJt3RAtIc5MazMse57xiDgXUQq+sVTxhST8o
 k94HgvhOWtsDearYTjaKjIZBmqTpio+q2RS/ehvehVA3QH3UmNPkyxU4K0NhnE4AIPJ7tdoRRUt
 MnQDjt0P/E7FMqE3KDamj/4B4dquTiu3
X-Received: by 2002:a05:6830:349b:b0:811:72c5:bd19 with SMTP id
 46e09a7af769-85d36524128mr10645753a34.25.1793741200241; 
 Tue, 03 Nov 2026 13:26:40 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d5c1:c80:22dd:8a48])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3de203dsm289371a34.6.2026.11.03.13.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:26:39 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Nov 2026 15:26:00 -0600
Subject: [PATCH 1/4] bloblist: add bloblist_get_reg_conv()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-spl-bloblist-pass-regs-v1-1-bbbbb7e65fdd@baylibre.com>
References: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
In-Reply-To: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4799; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2Jq8uJZ3dvWdZZzWmVRXmkQEznXhVjXUhUx2NHcwqvM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq6lFyFgMv9HXDkORrODswLwYCzX0rJG4T4jaON
 CHRIt1z+PqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaupRchYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2JgH/2no/ji0JOTumRl9GdJj2HaMqK3FEr3dXdFdiiv
 gpid/ZeMyWxEiStYhunEzTBdYdvBN5/7YMiqTJniikPpFyAqic6cZOkKbGVwEH4oM+dD3zoQn8p
 pH1WybJqzwlYZpBLhI69/4fJOJWloWFdjszDp+KDMHQQzh6UuBED3SFOtDj+XBmK9d3N1TPjGIr
 mn5pozy98V3NA/EEItoBvMGxCMXiKFT0BRN16+ONljqXSRZJVR2W/5iiJDeQN+AI0IIe2+1wZiq
 z/p+1Qey0L/3eR/zl2yzb07J0yKXkWcSvQJzgQI27RXd0m0a8ZAXWERW3+vZ7bHmu6ZoqZRT7oW
 z4z4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add bloblist_get_reg_conv() to get the register values for passing the
bloblist on according to the Firmware Handoff spec: the FDT address, the
signature and register conventions version, and the transfer list
address. It is the counterpart of bloblist_check_reg_conv(), which checks
these values when a bloblist is received, and shares its signature
calculation.

This allows U-Boot to pass its bloblist to the next stage in registers
instead of at a fixed address in memory.

Add a test that passes the values from bloblist_get_reg_conv() to
bloblist_check_reg_conv().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/bloblist.c      | 36 +++++++++++++++++++++++++-----------
 include/bloblist.h     | 16 ++++++++++++++++
 test/common/bloblist.c | 24 ++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 846c8047f74..4269a49ef99 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -664,22 +664,36 @@ int bloblist_init(void)
 	return 0;
 }
 
-int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
+static ulong bloblist_reg_conv_sig(void)
 {
 	u64 version = BLOBLIST_REGCONV_VER;
-	ulong sigval;
-	int ret;
 
 	if ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
-			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD))) {
-		sigval = ((BLOBLIST_MAGIC & ((1ULL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
-			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64));
-	} else {
-		sigval = ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
-			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
-	}
+			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD)))
+		return ((BLOBLIST_MAGIC & ((1ULL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
+			((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64));
+
+	return ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
+		((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
+}
+
+int bloblist_get_reg_conv(ulong *rfdt, ulong *rsig, ulong *xlist)
+{
+	if (!gd->bloblist)
+		return -ENOENT;
+
+	*rfdt = (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+	*rsig = bloblist_reg_conv_sig();
+	*xlist = bloblist_get_base();
+
+	return 0;
+}
+
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
+{
+	int ret;
 
-	if (rzero || rsig != sigval)
+	if (rzero || rsig != bloblist_reg_conv_sig())
 		return -EIO;
 
 	ret = bloblist_check(xlist, 0);
diff --git a/include/bloblist.h b/include/bloblist.h
index fcd290eeb16..cdb5764cf55 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -536,6 +536,22 @@ int bloblist_init(void);
  */
 int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist);
 
+/**
+ * bloblist_get_reg_conv() - Get the register values for passing the bloblist
+ *			     according to the Firmware Handoff spec.
+ *
+ * This is the counterpart of bloblist_check_reg_conv(). The register that
+ * must be zero is not returned. Call bloblist_finish() before passing the
+ * bloblist on.
+ *
+ * @rfdt:  Returns the FDT base address, or 0 if there is no control FDT in
+ *	   the bloblist.
+ * @rsig:  Returns the signature and register conventions version.
+ * @xlist: Returns the transfer list base address.
+ * Return: 0 if OK, -ENOENT if there is no bloblist.
+ */
+int bloblist_get_reg_conv(ulong *rfdt, ulong *rsig, ulong *xlist);
+
 /**
  * xferlist_from_boot_arg() - Get bloblist from the boot args.
  *
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index 797bde27025..23def33ab6f 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -605,3 +605,27 @@ static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
 	return 0;
 }
 BLOBLIST_TEST(bloblist_test_blob_maxsize, UFT_BLOBLIST);
+
+/* Test that the register values for passing a bloblist pass the check */
+static int bloblist_test_reg_conv(struct unit_test_state *uts)
+{
+	ulong rfdt, rsig, xlist;
+	void *fdt;
+
+	clear_bloblist();
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
+	fdt = bloblist_add(BLOBLISTT_CONTROL_FDT, TEST_SIZE, 0);
+	ut_assertnonnull(fdt);
+	ut_assertok(bloblist_finish());
+
+	ut_assertok(bloblist_get_reg_conv(&rfdt, &rsig, &xlist));
+	ut_asserteq((ulong)fdt, rfdt);
+	ut_asserteq(TEST_ADDR, xlist);
+	ut_assertok(bloblist_check_reg_conv(rfdt, 0, rsig, xlist));
+
+	ut_asserteq(-EIO, bloblist_check_reg_conv(rfdt, 1, rsig, xlist));
+	ut_asserteq(-EIO, bloblist_check_reg_conv(rfdt, 0, rsig + 1, xlist));
+
+	return 0;
+}
+BLOBLIST_TEST(bloblist_test_reg_conv, UFT_BLOBLIST);

-- 
2.53.0

