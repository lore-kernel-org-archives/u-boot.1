Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781B606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d0slTFsa;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=muUxnS7o
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69696608C7;
	Wed, 25 Nov 2026 10:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vf1Ngy-_cR5n; Wed, 25 Nov 2026 10:58:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 541E5608D6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604339;
	b=mu8uu45lo1CqMp/T1CxSTMBhfP8ScPab847IP8sr4j4odWuFLBtHPFV1ZggLLwlucEf9
	 QAM8z1BoSauh0IjTHOwnDZDhIeczlairLygRH1zckITrTlfP7ASyydp4e6NV0HQNwfmHO
	 ceAv7YWv/Rvx1Fc7sqtS8izfDruNwcxecDD1rh7zcrdiceLSUQ979W5ZFaPVfghPfHcKh
	 6ErmVUM6ABrjeWuMlzwZga+VZXTmZKo+OZ05fiCsw49A3+eg8iC9coL7rMrik2chly/n8
	 5JW/EGflSGvioa1KuyuoJO11MXmwtsX0+JxvuWJoTdfwlfBtQRPTvyC5zxkQc9g/D6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aQELfehkovfW2qUKFz43KbnHANssTssPBhlVqDtYN3I=;
	b=V3WtysHmpwJKFF31hX8oGU6eZCDlJmrSgv6fNBR6X9nldDlhAtFANJRAEWgXMks22bIj
	 gIFvuetSbxGKY1Hz/ctQgAYr3saImAfI3H3PTveeNgDKNJlPT/FxmLC1+DIQhNfA24waK
	 6xAvch/fLwe1ta8jKTQmgzM5PIUcsP6WOB39P/iWJzwmzBxwSpKYZenJ1Mzz6cqrVuXxv
	 u/wz/Ig7lQW0NDlNwFqgYKC7cMdiwtLdsCBKj6DG2KGZCW+F3++orFkuHQRxa5oGXd0nu
	 fAUwM8yFfoK3NqFKqictNpnApQMSu0ESbfOabV2AqXadNtbCSKPIEz4A5Sh8ApAAeMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=muUxnS7o;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604339;
	bh=aQELfehkovfW2qUKFz43KbnHANssTssPBhlVqDtYN3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d0slTFsavi00Qy22ZMDiehnBW0rJM8LDpzRr/S5uELR0z/uznBkYbc253kq746ZLE
	 4phwjAhoX/vdRsMeT7+MfkHHnATupd33rt4GSxVc28a6XAv2265geRpFb1yEL25Jg+
	 0vpzdoGkHGQB6x4xXW7/pW359n1dlg/9lPTAO9UUGghSujFl/q9KflNSHUy+J/48li
	 veezo56TyNALbP01nFBdHIbJUJ831ehC076VtmogaZbgkBGaS7/HvN7m7SmexnkCSh
	 eMkpe2ymbJ1ROyUml3X2e74fUECUmX69SlBRISWOAC3hGlLYsgqD9iFHNrzMeCsZeO
	 JVnZF+WQtRgvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 541E5608D6;
	Wed, 25 Nov 2026 10:58:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EA32325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FC35606D6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlgTmeaepZln for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 18B4360893
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=muUxnS7o
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18B4360893
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:41 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so43159195e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604320; x=1796209120;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aQELfehkovfW2qUKFz43KbnHANssTssPBhlVqDtYN3I=;
 b=muUxnS7oCUxqxt0p5TNO8g6oiXIOhBFs4o9mvuH6jI39RXLqgGf4q1h+CS775q0gb4
 8vTHYfA3MqmNZQmBT/5+FyBgZwzywxjeceIgwj9ZNsyMgfcvjYXL5TRIPvAXIfcDoFbe
 5TvSmo/6+7N4dXkmaVdHgRPSieg6nw2x/AJQVic5H+NGT6hQpXlaI8tC3M4WAA2unXeB
 6rDonqHClyIpnNVDuKo9li1rgqUrUGTem2O823epeP0B7zd/wCtCKdqvmXi5XTj+iqci
 1Qog0ZWzSKItQoQLX6DnmNOiWUp3mj01T2/SgCgbOM94C3u6AFbq5h4tvHk0WpXRRlai
 AAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604320; x=1796209120;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aQELfehkovfW2qUKFz43KbnHANssTssPBhlVqDtYN3I=;
 b=EyShsgsy1bPp0QddMRCB3vnvIz9YXk5C8gvKaAw4+4SVi36DKaWvItK0THTxf6/7QX
 iiim58FQr8Q1OW6qs22pvOh8sNf5yzR1jrjBvmegMjcmIOSl4lOr78vN95HCmRCX1kE9
 rg7o+BjRY6HRoCDZ1U39b167o9OFVSYVnlA5Q+dllX4XVdPM7QW7v2zE37etmz03m2co
 7bVNiNLmZae9i9zNLZ+8baBEgTfK+xoe3/Y3Z/bSdLN2Cn1xRDTnuLaula6FqFcpLcQt
 XpXBFWIB/UqFJwy8KS0VZtM6Qq6rwU3/etJMNzrBQwJx8F96/bnuoefrpptAo2vXfkqH
 6+7w==
X-Gm-Message-State: APuU4Z/+5/0Fha8KCkY740YA4P76xMfQFYo28SdBWxwgRgmp0efROC48
 wUez2Vb3rqcCYXQufkunu+Y0LdIHSQzihY7hZqo41rcLJOqK8OjTj9ta7+DGRXZTJmk0g9VJs9M
 L2bOA9u5CJg==
X-Gm-Gg: AZFdTZdDq74q3cVlFP8hA8r/fuMsve80Dhiv3ouW4I4KV04dsNUe+TUQGU37vQhpdMi
 Yga5Bi70zAIWq9hChsh0owfbeiXMwD1nhjbz1QUKqNiSoeCnpcuSXzA4omdCca77bUET7fZdjS0
 c6DQeXvLIq/m9pEZowp+bT1egunmjHxSDMto/Ogja10s8+YVHPUF7nHc0cOFy/1Z4BUvdYRJODv
 kNRqHXpvjV0fKvl4ZHvy5geyPvc/q3cSe+JjEoOJ1U9joQgQg0AcJ8MR4dMJETKNJf/T87qoH9B
 wEGrsQmde85INhOtoioac3Zc/Sa+8pDFj4NaQ5A4k4nlCPQOsnJ5Xr+dvHzDi/T5Y6HmOxzKrIO
 pdi22gZCmfVDSUQBRiF5BGnNKIs9MTP/Kp0xlmVqen+5jyPqS34P8ZNmKE9K9kvxsuD+hUbo1ff
 YFnFvkYv7Pnbjx3yXPbBGcT3mwYRmkwKfQLRufsK1e0Yn5VRdBkn8GsDS6NfEgr3XDJ58XdYNZA
 WRO1dwL+0Ye2FZMBmgHGfOQ5AwvYU8MQGk+iy8p1YUoBwAEY002FgTRhl+FTerJnRTHIICnXW8H
 A2cJqL/s9bOmEOpfJX3LzdMVEZ09GAds5pwTUFsCm0ODEin4E9tAmopAh9x+rGUJEczQb8Nf
X-Received: by 2002:a05:600c:4e0b:b0:4bb:6f45:2a79 with SMTP id
 5b1f17b1804b1-4bb88817920mr378475805e9.22.1795604319840; 
 Wed, 25 Nov 2026 02:58:39 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm800879675e9.14.2026.11.25.02.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:39 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:19 +0100
Subject: [PATCH v2 10/11] mtd: rpc: renesas: Clear the PHYCNT HS bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-10-8d31a33a54d2@baylibre.com>
References: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
In-Reply-To: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Fiona Klute <fiona.klute@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
X-Mailer: b4 0.17-dev
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

The hardware manual asks for the PHYCNT HS bit with DMA transfers.
This driver reads with the CPU only, but keeps the HS value it finds.

With HS set, some of these reads never complete and hang U-Boot on R-Car
X5H. Clear HS.

On the R-Car Gen3 boards that also use this driver, Linux has cleared it
since commit 5192481f908e ("memory: renesas-rpc-if: Clear HS bit during
hardware initialization").

Fixes: a405a55ba8da ("mtd: rpc: Add Renesas RPC Hyperflash driver")
Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 drivers/mtd/renesas_rpc_hf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/renesas_rpc_hf.c b/drivers/mtd/renesas_rpc_hf.c
index c94a25fe6a19..1b6b332cb740 100644
--- a/drivers/mtd/renesas_rpc_hf.c
+++ b/drivers/mtd/renesas_rpc_hf.c
@@ -136,6 +136,7 @@
 #define PRC_PHYCNT_OCTA_SA	BIT(23)
 #define PRC_PHYCNT_EXDS		BIT(21)
 #define RPC_PHYCNT_OCT		BIT(20)
+#define RPC_PHYCNT_HS		BIT(18)
 #define RPC_PHYCNT_WBUF2	BIT(4)
 #define RPC_PHYCNT_WBUF		BIT(2)
 #define RPC_PHYCNT_MEM(v)	(((v) & 0x3) << 0)
@@ -174,7 +175,7 @@ static int rpc_hf_mode(bool man)
 		return ret;
 
 	clrsetbits_le32(rpc_base + RPC_PHYCNT,
-		 RPC_PHYCNT_WBUF | RPC_PHYCNT_WBUF2 |
+		 RPC_PHYCNT_WBUF | RPC_PHYCNT_WBUF2 | RPC_PHYCNT_HS |
 		 RPC_PHYCNT_CAL | RPC_PHYCNT_MEM(3),
 		 RPC_PHYCNT_CAL | RPC_PHYCNT_MEM(3));
 

-- 
2.56.1

