Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C0C25B74
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3234788365;
	Mon, 13 May 2024 20:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="oRnd8IPN";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="blEuad3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B0688054; Mon, 13 May 2024 20:13:22 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE28882ED
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id D81FF1140173;
 Mon, 13 May 2024 14:13:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 13 May 2024 14:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715623998;
 x=1715710398; bh=hXyfIt/Nf4DgaoGMQpBQwyFkQdzcF0MKkHKNpMrvmBE=; b=
 oRnd8IPNpYtxJZQhSOMYLLFBAJjQgkq7dMi5Uq6n5qe9QGwpjfPCnAQ3Yu5lvsoq
 ZaKt/UanbXtCe4Nu5JhTRSFfDh51jqaW/IIi3z/vLMgaz4ymkQemEPzQ5eiBDOep
 OtWF2qKhDNzs8BKoA7eBjUanZ4Zi4y00rRFCgmEtwC2GJLPoWECnBrbMg7APUB/3
 LzEoQn7AS8S57m2xj9J82kagypzEBt6NcjWu7Bfyz2kxhVswk6bOyclKblby1JCl
 aJ6DoTe+1PzMBaPaO1bXdeSDaQPNbQ/X1hfzQPnQkVUvz4miTig0r6iCECy0I/3z
 gA8oQRKFDcV2EHkbLlEsFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715623998; x=
 1715710398; bh=hXyfIt/Nf4DgaoGMQpBQwyFkQdzcF0MKkHKNpMrvmBE=; b=b
 lEuad3dHZlm2x/6UiPewbv9JcPGeMUGyKMOq27TLoY1PDIjDhzZeD99IXHCtTVQS
 AgS4m1Djgv9yf5krhUibJ3eoH5vRu38WvQFMtv8d4NXHkrTUVK8d+wc9taKTrFrJ
 33kdxb/6cEbRGc0phQvglYEMBU0FRO9ih/Mdp+mAdMcUVkNEhIQszH99dubMOTSX
 aMpqHIz0/yMRjy7c2kVHghvGdHvWetQukHBzfqua6lvCpbWvKcQ64eLlawtlVIvv
 zsmk4+nI0o2g82okPK6ldr2zxpLx2mjwWX+yL/rNxRueqSN+/QQQn1UI2ZHo9qCM
 U46Qj6WcJ1MEPubn1D7ug==
X-ME-Sender: <xms:PlhCZpO6BtvvyJvRHZhqmK1FbMkkglTQapDHml0o_xSKW866b9d_Rw>
 <xme:PlhCZr-e9w5mvXGJBc1xNLMWDe7bku-dJP2vQGVKQoIBvK47fOxy6BlNsP9PoSRlm
 MCU5HNoyXWWBQ2FWkc>
X-ME-Received: <xmr:PlhCZoSJgsmCja7u1gtjkJlXv7_OkPo1ht_VNNs0gofHzpTnl6JilYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:PlhCZluRtJYOf9YglBGTcM7evi-Utti_vZUe7PHaXJZ1gUabiCGu5g>
 <xmx:PlhCZhdqoYsz2VdGxrl-a7ceGa9zZDxDLQJEy5s5PiXnnEpv0zW9aA>
 <xmx:PlhCZh1yJbnkYH8Ym63qzCuG64T4MiFnrhI1rmgON81KjKPNgyODjw>
 <xmx:PlhCZt810UQTdcdlfwjQE2dRi2KprD2RPkgUfNHPhZ3cSUpA0uWFuA>
 <xmx:PlhCZiWwovm0S9uh20PX7xP-bf8tqYT0zJ-5Q9upqGjgd4iAOm77_7Z8>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:17 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:13:03 +0100
Subject: [PATCH 06/13] MIPS: Provide dummy acpi_table.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-6-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=667;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=yr3ri0QU64OToHT56T9aYUBzi4wcreWomscT3Aiz5G8=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCOP77nmcr/t9wkzSQ7svpKxVi1hR8uKnk9QOxU993
 ntXP27pKGVhEONgkBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIm8imdkuOkyS237ueO1O/1e
 87w6EiDy/MyfJX8+725Zz1QdsG7qmzeMDOc9vjmLRp9y2qYdenjvWWapPU1/NaM5Avf+XmImrHC
 ilQkA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-Mailman-Approved-At: Mon, 13 May 2024 20:17:26 +0200
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

Some drivers needs this header.
Provide this dummy header as riscv did.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/acpi_table.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/acpi_table.h b/arch/mips/include/asm/acpi_table.h
new file mode 100644
index 000000000000..b4139d0ba328
--- /dev/null
+++ b/arch/mips/include/asm/acpi_table.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __ASM_ACPI_TABLE_H__
+#define __ASM_ACPI_TABLE_H__
+
+/*
+ * This file is needed by some drivers.
+ */
+
+#endif /* __ASM_ACPI_TABLE_H__ */

-- 
2.34.1

