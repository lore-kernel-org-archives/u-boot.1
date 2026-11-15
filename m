Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993BC606A329
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 04:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=evFCMnGt;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vr13kvae
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75D3A606C4;
	Sun, 15 Nov 2026 04:25:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WutUw59gCv_B; Sun, 15 Nov 2026 04:25:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3E00606DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794716731;
	b=NEJXGXhXHP0yTgk7C3g8A64YueP4mj3X7QaO1UXNqof19CbDSvsIKvZ/nJjO1rcMYDjM
	 vLArOJWYIEwdN51jz10+EUdoz+frHzmOsjpaAVMBDlUeTy1I+utXBaa4OkQUNhZ8pS44Y
	 FC6JTIjnaitHhYSj9iLMnQ+8m3i981cLshSt9QvkElAEzADZUsAUzUtDGbHj/szVUB0HE
	 dDzEEAnOurG3ytRKL38RzQMaBPWL7+vgJ9SBB7etUDoK+tFVB0Rk1LapSXGCT+T0/8ilg
	 rm64RnzVsqbuOydDX1VbzY8lbvuVmpoQONrj3KYVYirxJa53dTIzpUX+sEZroXzQafA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794716731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CaVs1RiHIsZXMOEAEgEYfKhWrA1PJwwpScVkv/lp8XY=;
	b=aDaIMjNyprBJRpuaZk+1GzVhWpDuSDkLWsrngBbtMHACstv7ATEaU+HJk7MvzSMzWZF1
	 pXVMhjSxGWsrEnysFblayE95vOenOwED+PIrBAKmTxmZax3W2YtnN8N1aavQuWazszURg
	 zZ/EYDeDrvisfPVC07tBD0xhmxiS0rvkgqBe3c76rJFPj3h4k7Z47o0hMlFeM9rFDfNgm
	 IfzBcSJ9hRxpcw6DrPxxKtTd/ZR+/Us3/vYp7nTRBvkgq3166sV0BHMqd3O9z0I49hKTl
	 kkI5E8XcMJCrKCGYgcZ6pSrrZgK1BUUTAhWeJCdh/FLQ9wt0YAvZuD5qIkfKFk/4Gcw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vr13kvae;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794716730;
	bh=CaVs1RiHIsZXMOEAEgEYfKhWrA1PJwwpScVkv/lp8XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=evFCMnGtkh4TmPGyjBKcr0oXlbs3nDVyjwz2X1ply0aFPezcLCBj0nmsms52wmGB/
	 r2OdEAi+u12Y07qP+/JnO9wzWPFDZ1yhQ+WS7mrahyiZFTU97Av/GcMUTZbzaEmP3+
	 jhNF1xad8mlQhWHANhJksltDZyNL9nL/xZaNz3JuBcceCo99bQoiB4iLNOEdMOPoH+
	 XTqSl3LFdXTIhGwPslbAvDgQDJB7n4iEALueF80ZWoRZGBGYufYhG4TPQo6PAgUiDc
	 urj+b+r2eK0KymXv7zdqibkJ9ACdQGpo/AA4VlfsXT0XJkNl+z3LXySEJUSM3MEM8Q
	 m5Y/0lKa1ewLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3E00606DA;
	Sun, 15 Nov 2026 04:25:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7ABF109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 04:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A965C606C4
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 04:25:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NPf9xyjFidI5 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 04:25:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D5520606DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=atul.akella@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=vr13kvae
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5520606DA
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 04:25:27 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-37071c0f42aso3450405eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 20:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794716727; x=1795321527;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CaVs1RiHIsZXMOEAEgEYfKhWrA1PJwwpScVkv/lp8XY=;
 b=vr13kvaetRNTUMkWWvyxAHUgjSEwxi30xoLoFVQeLsIAizEEjqIW7VhRNoVcb3bQ2O
 yQh7Fb2U6YGGviPkvsNPD1qoGph6tMAxhdGpI13sIhfG1tdOsUhaOYlj1AD80r71u7nq
 hbKBKVk9yNtA134jn4zzOjNGJ3zoqo/UmfI+Uj3uu6gS1HCsy7O4HkK8mdz88An4Ook6
 /j/UB4K+JOIrQ/oV/TrN8XkTjtkTokTamcfq6zZ5pjVyvlRhPJBtTrhu4E772Mus3v3Z
 /J0lJwYod/zcKzh1hHA20BuhLEMrlv6vsLDg5gTBLqLaXVG/ju5ba8Tk8kMYv0ubtsvz
 Po5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794716727; x=1795321527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CaVs1RiHIsZXMOEAEgEYfKhWrA1PJwwpScVkv/lp8XY=;
 b=zFyWdpmhdRfrU/0g+5bqYaO3X63/gfODqbSVKBjsfuZnmCD3AUofBCszFIY62xPI3h
 gP+Rt7hczA75ve/Yp6Pj5DbIUFimO/flgIZeUAd7rhjiv8KiFry6VcjrUds1Vz00TLN1
 1bXHACbaAkZ1S0/GZMPNc6DEZMpzhf7LcB2wXop7FRPgc1LTcNDimosWGeBiBcGAmFeH
 McQmXIEZ/tWKCwt6IlvMzmH4TVmCOXzA3hZNHzUY+1qoFAJzBau0ORtB5wAbAzOxQHFL
 /LqGvVlfcype3wDr8AlAkSYnwjaz6QlvVPIby+nqdMvYwHOQwtIe7uNKcB0aiRkUyCxW
 i5zQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFpBCk8M4i07p35mWBAfAzXwb4z5hd84cz8/fM147sJOy9MHq6iLZ46C8S3Kp4mDzq3RQ3T9Ys=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/wQjEmjLWLtnZgk6wWIwZf7y3pe4Tuw2XTZMLvwOV1BXPZpg5/
 VkAWOt8iT4+GiTiGwZ1wEqLIuxOjEQ3uw4kYvAIzMLzXR0TcF6Z8sLRH
X-Gm-Gg: AYBFou0QDpEvpd0mjRuuCUya9vreo60fhuvzip+SAiadQ2PhtV2pfJX2fG5kQbxmFSN
 brX4q3AZpZAcRXWBM0Nb7Ie1DSi8n9mK6j7x851fhQJnKiA7TbUotvkSnMd8BgIFfpLTvVtOGRQ
 VQsOb3HF36YwRAGCB499nJ+f+sR3Hp4YTYOVR3q/Sr3RPUG6vLtHhil8lPPqKHzKe/DFoThuUV3
 Dg+SakAEhKNlBQAQAza8olAo00A+IIUIHHIkEtKM2KKimRO3K4tyoebFWkYH6+0GaoVmQnCmI3J
 8FiwL4QxL1+w47KExlB7fp3XVpWM/IOPyCEVSyZkZCWQYR6ayQVxykl4jou+1VN6gbVF7eTrGhn
 2s1wGeCxUcKbRqamJEaect2faTdXAzHP+15UJGES32Ch+4vIpo1ytQBfjS4HMZz1KyyZkZnQIGm
 ztc2v+z7foTmHPOAERPM1xin79KLAuFVuXJMEFutthZN++lr7vxN7ouQ99zMnDjBYMB8Ic/gAF4
 dXLyAYBSS371+YehuzLnn2ft52XlidgrPlhpiluAOIByUR8YH0dO3A98WocebWJGxiJD0xTL+Wt
 eGoVJr/nxjrgb+bVsKKNQvDEL2s=
X-Received: by 2002:a05:7301:5416:b0:375:7be3:1bbd with SMTP id
 5a478bee46e88-37967ae6b5bmr7221347eec.23.1794716726552; 
 Sat, 14 Nov 2026 20:25:26 -0800 (PST)
Received: from JMD ([2405:201:d028:10ff:6918:69a4:7613:6971])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332ae7sm34054803eec.8.2026.11.14.20.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 20:25:26 -0800 (PST)
From: Atul Akella <atul.akella@gmail.com>
To: trini@konsulko.com,
	lokeshvutla@ti.com,
	hnagalla@ti.com
Cc: peng.fan@nxp.com, u-kumar1@ti.com, u-boot@lists.u-boot-project.org,
 Atul Akella <atul.akella@gmail.com>
Subject: [PATCH 2/2] remoteproc: ti_k3_m4: make bounds check overflow safe
Date: Sun, 15 Nov 2026 09:55:07 +0530
Message-ID: <20261115042507.1054-3-atul.akella@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261115042507.1054-1-atul.akella@gmail.com>
References: <20261115042507.1054-1-atul.akella@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

k3_m4_da_to_va() callback uses addition based checks to
validate device and bus address ranges. These checks can overflow
while evaluating da + len or the end of a memory region, potentially
allowing an out of bounds range to pass validation.

Use subtraction based bounds checks instead. First verify that the
requested address is not below the region base, then calculate its
offset and ensure that the requested length fits within the
remaining region size.

Also use u64 for the offset to avoid truncating wider address
offsets.

Signed-off-by: Atul Akella <atul.akella@gmail.com>
---
 drivers/remoteproc/ti_k3_m4_rproc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_m4_rproc.c b/drivers/remoteproc/ti_k3_m4_rproc.c
index f358788f07f..2c5eed4be3b 100644
--- a/drivers/remoteproc/ti_k3_m4_rproc.c
+++ b/drivers/remoteproc/ti_k3_m4_rproc.c
@@ -187,7 +187,7 @@ static void *k3_m4_da_to_va(struct udevice *dev, ulong da, ulong len, bool *is_i
 	phys_addr_t bus_addr, dev_addr;
 	void __iomem *va = NULL;
 	size_t size;
-	u32 offset;
+	u64 offset;
 	int i;
 
 	if (len <= 0)
@@ -198,16 +198,20 @@ static void *k3_m4_da_to_va(struct udevice *dev, ulong da, ulong len, bool *is_i
 		dev_addr = m4->mem[i].dev_addr;
 		size = m4->mem[i].size;
 
-		if (da >= dev_addr && ((da + len) <= (dev_addr + size))) {
+		if (da >= dev_addr) {
 			offset = da - dev_addr;
-			va = m4->mem[i].cpu_addr + offset;
-			return (__force void *)va;
+			if (offset <= size && len <= size - offset) {
+				va = m4->mem[i].cpu_addr + offset;
+				return (__force void *)va;
+			}
 		}
 
-		if (da >= bus_addr && (da + len) <= (bus_addr + size)) {
+		if (da >= bus_addr) {
 			offset = da - bus_addr;
-			va = m4->mem[i].cpu_addr + offset;
-			return (__force void *)va;
+			if (offset <= size && len <= size - offset) {
+				va = m4->mem[i].cpu_addr + offset;
+				return (__force void *)va;
+			}
 		}
 	}
 
-- 
2.43.0

