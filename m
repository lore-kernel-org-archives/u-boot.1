Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0F606A333
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=suZYBhBL;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gFYGjByc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D859D8102F;
	Mon, 16 Nov 2026 20:45:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VJVzqVOS2ffg; Mon, 16 Nov 2026 20:45:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93EF681061
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794861942;
	b=fgc6Qp9bVt1+KQ8Ntd1Nse+Vdihk5cPyEgaAmrEi4Knikf1xNkt4/duoa9KA6ByjaP9X
	 cYvCb8umPIr6ykkXMCTMroq1NSB0CL5BX/9PzuRMh7vkVbbVixckC/x/E3eG4uWaFp1lP
	 B7TxteJDeclDY9nQvB+u7gAaMSuvqPJOnVLBMMtbi+n8NegTJmf7iU/RXmqR58zwMNsqh
	 T0X6+/Dr0DoIyTR6uYITwhzJxGAAxovGGn08Eji94/XiD8pYJxZe+My8JT821159zpyco
	 Geoh9K0bQIkUNNlXO/GhIy1RDBT4r5pEdiiWp7CNyUBgsyRMvM9uiynI6IqcPG18lNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794861942;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QtV+/YTJ4c5LiY71sMjL4OhEn1oiw9+wR7qA2hZBTE8=;
	b=QhVmenI21HmfM2BIOFhc5xulvuK1r7ImhAoXCQysPKOfdAitV4MlFF1lQoGWZXgxXaMh
	 wpVF3zo4gndDMh2dOkQoaaTwosh4yXvuh0Vhxl5K1o2rr0WvvtP56YNP5OSPZuwIU/nI0
	 j2h2ZVLLhNO2vSglO4fLLAGAwhw4gV9k0iJ1iWDyY8uMtmo26K+glup0heEkXoUO6fqOY
	 OP9BpLhP+DSdNJmrYu2INHnsMrqrkUCGax3qoAiWlP3/EtWPFrLE/Gq95Kmon1cG91Gw/
	 d9X8gbn66dm1egSTb8OYVpyHfHVVb9W1lYHy+36EQlBH/gP+dZfrebF6XlJyOz0NCOA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gFYGjByc;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794861942;
	bh=QtV+/YTJ4c5LiY71sMjL4OhEn1oiw9+wR7qA2hZBTE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=suZYBhBLq2AteYRDJWaz1IyTP/78lxinN4q9H8fB+MYaRE7WQxGeWk8WMRAj6qaJ0
	 r62Csy926tILKiu5it9sHYh6EFJUvJCa5ZIiE8Jp7ukusCDEVOBkGlc3uZI6lLy2bA
	 laPr57YtcBqGaBZzqg+sHUKX1xemz6gfA2EednRhQSCOum6fd3X8dy42R1RqnHQY4O
	 brZKhLJ1dqYsMYM9xqHcxyEwVa4FsJM/du8TPDP15366yJc9d0HMLyaKU8A0RKHrCr
	 cf32PGmhfRVm1SUH7EopWeAMcX+KJLEfpxY2w81/BZtjnMfw/DEf/iGinmxdk39jB1
	 ujudTRsFDDwqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93EF681061;
	Mon, 16 Nov 2026 20:45:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DA274DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 689A080FDE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6FjFiiFfdgau for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:45:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C01180DE1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gFYGjByc
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C01180DE1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:33 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so24317925e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794861932; x=1795466732;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QtV+/YTJ4c5LiY71sMjL4OhEn1oiw9+wR7qA2hZBTE8=;
 b=gFYGjBycfHUAzN9CFwf8RqO3zZRpwxtCHYRyiukqjA0X4591dFiZ5z7HSgH/SmOb1z
 ChxiUlkWgvdKvsZ/Zvb5b2N2h3Z5EwTWHCifMHg5fVkpQ2oSHb86Zq3tnDQ5pUftcQqh
 HcilSeEMwd7QJtg4T9Tyw6IhoWToYV/fVz7PsV2ufI5Sfr1XQ9YeDtxX6VOJZwhFBbO0
 foGx19lzcUPXyldPXlC+H/r87ErSaY4/Ak+8KgvYDVtAM6+iMofTN5A0fX2OhyNzDWCO
 EEjEWkK18I52LdNZ6/58B6NYq/dq7mt3aHxZFo5t18jdCGcEjTFzz9q3iegt0VZo+lyw
 tr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861932; x=1795466732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QtV+/YTJ4c5LiY71sMjL4OhEn1oiw9+wR7qA2hZBTE8=;
 b=JesDryre2g6PTuCgmE8h4jO91JOIm3f1Omkso6g9w26YFgemtNgKLGwiSXFqbIL9ma
 hhgMTlb5y0LIeSg+9QW4Q0rIOYwSIqbyGpzzinO7ppNuoek4Uom+SzmU5oMUSyWBIasV
 CdoKRihqBBT5SLgA4GXfWFIeCKd9qHGd6KecZjbMUJ9oytMjBWLu0lRma8MzyNem/5q2
 JfNc8hSqyp2/w+P0BNUEMgejrvQDUxGD1V4Mx5UCu8M7wGlOe0VC7JR6f/vrDtnsZMXp
 Rv26iBpAVYzCJLVYzaGUYhVm5yjdxJPadCMU589LDMPKAPbM/xJ7KbFQ4Gf+pU/VXK4y
 KoLw==
X-Forwarded-Encrypted: i=1;
 AL+hErHRvawXat3rDpjdigmfcfYm1wB9hsq/RrIfxwz0e9hplAKQBAZB0NteuMcHLkpWMYQKs9EU0AU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9OmKhCxB3V5LGyMPXyG24mWXFusisP/KgF56ddeACBOVsj4UEc
 nh2/ObiDSuhax+DRXdmkRdwv/3fl5/5asW4g6jU26YoWbZZ+qQn8BKnuAoviVAEdLRk=
X-Gm-Gg: AYBFou2pgbFxu8o86zOTScRGB9CcvlLgWVgmoBTt+CDpqGWIugzohBI0F7mtCWdS8VZ
 VtOsUGwFMqI/Sk/9EPHn0dfOy+oWCZGehUcyNKPqylAWP2ZXKdThq6IXdku80pFd8JVtwmAVPV/
 49DC2raz15BnMuXyTIs+35IeBD2cM/gaByNov8dk0sOG+N5MK3g6/15Z27NraaHrMvE7lbp+Rdl
 WuiJm2ZEzLOs5cRtI/Nr6pVmH82uEsuKwbHGd701Ff7/NhOmxm++AvO/m2+536dWMjrdtGSTuug
 p/tVa2RdagmiwBIpv9ZqjPg31kNtAWyjngrmWQZFdxi7pizUyzRK9NUORxQHzeMnOGSkGsRsdsj
 VnApkHcZpDMsb7jVxorsxng+jpIX34AB/iiT9SoiSsQkC9Qp2NhjKN6qH60PgN1EjtX/uXEBJYw
 nX+WXpL/xqRQ5WONnx39DEaa5N+VlxJSE91dfw/I4AvwOdGENc+3rT/U4FwfCHoa6rS0BLIR2NG
 7YSNA7VHfEFfqShQfILYESgM1KxD0tKAPi1fZ6IBQlej7pxO8ZokFBbkSPS28VLvmgi4VVJA7Mt
 G/kSW3vzgsfcT5rfqukDwu1W+/IJQ2+3t7LPgHin1+6N83QZdADHX7xIVnCijd4WAljinnScWWm
 ZzkP03JkDJTaLXjY6GQ==
X-Received: by 2002:a05:600c:474f:b0:4bb:76d6:1f5d with SMTP id
 5b1f17b1804b1-4bb76d61fb0mr47625295e9.2.1794861931612; 
 Mon, 16 Nov 2026 12:45:31 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm16855545e9.1.2026.11.16.12.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:45:31 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 21:45:05 +0100
Subject: [PATCH v2 2/7] ufs: rpmb: stop the model string at its NUL terminator
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-genio720-ufs-rpmb-minimal-v2-2-b64eefcfb0f6@baylibre.com>
References: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
In-Reply-To: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
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

Some UFS model descriptors contain trailing UTF-16 NULs. Converting them
to spaces changes the RPMB identity, whereas Linux stops at the first
NUL. OP-TEE then derives different keys for the same region in the two
boot stages. Stop at the terminator to preserve a common identity.

Fixes: 87094d8062bd ("ufs: derive the per-region RPMB CID and size for OP-TEE")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/ufs/ufs-rpmb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index 508eb74d976..8b61760f071 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -270,6 +270,8 @@ static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
 	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
 		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
 
+		if (!c)
+			break;
 		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
 	}
 	out[n] = '\0';

-- 
2.56.0

