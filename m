Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6C3606A327
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GQPgkhDI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HwgRzim3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF078606D5;
	Sun, 15 Nov 2026 04:25:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yx2INRlE-AKs; Sun, 15 Nov 2026 04:25:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1BD546061F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794716725;
	b=BbVhDcDxIoZIW3eW0WNCuY/uPjE2qFdQhnNuh850aG9AQhMrhTbrlF/Bc+WTa/VNUxp4
	 uHMKEn5mVwBeHVdCE75GgXTgitRhkSUQT7Xyq6jR7cL5i+OGJGAV9rvqW56z4FWagoviC
	 LKiCoqPG+UQ+6dO9HZvdMA0bj9XWvqcuWxL4TnXUZMIOKHlWlvUo1Z2G5nLQ0VOLcUWXV
	 t+mIAyQf0u+6QZF7qZYYktcO3DUqO61jYkC5ZHeliqjkXK1ku/FWT3iGTQr84BsBnqzhC
	 LmMVKYpRszIk2Lgo8KGASdGmbE/6VZ0KPgL27lL1zM5xIe1YqMad2qQV0kPcpJ0ztjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794716725;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BaUiYgjZE+3ZyzBfqnQF4AWqwQRMvUwp+j2aYuVrYZI=;
	b=hUeZAeZwn2AXdqxcBuJnJvgooitDxsCmFho680neXv24Ehb4FDwgt7ui69Ml7oIAn4Mx
	 LLthkml+xwH/6LO6Wa1uQUKVIvJHWzo4tlwkeKlL8PY9y2wzXaUc+Wr/WzTUi4aF4wb+D
	 WVJWPgqNRIQrPqEkjnBiW5KQiQWyIoVacGVggbqtNSc9kr1AYUlORou8HrgYubvmaoTxZ
	 T5zDKImLUT2S9UYr2+fpTGxKy7+hGNUkIz+uMaCX4JCmwe4Ar2nDLNGDs3Ts+Ti81mNsR
	 mjjxgjP+abibRxztE+ZDXNwFFvZNuANlWxFubfG1HBHGsdz/OoOEB6Sw1VleNuGgS8w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794716725;
	bh=BaUiYgjZE+3ZyzBfqnQF4AWqwQRMvUwp+j2aYuVrYZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GQPgkhDI/IYNP/PunTRhLUv/wrih1xOBjFYRZb+onCfFUEFeTxCxKDmkiaENdS2bY
	 C2D+2JoHsbhXXgv4vOD1gfikff6QbW69dlF0se+lIpMDTmiVUzh8QaIbAgLDxMwvUD
	 Moy8Kw6v25V6DZCJuIChJ0xVyAIOV95lhDHlnisLPWTMULzb3Jj85kp5agF9xZQpRI
	 jVhm+huLFcyWcZHc4YpjOseL2uitWxya8zk9EgxYY4bH/P3qj82kes8eSSR34K5ITF
	 OJyvK7xX4LKeq0j+MOFBkKnfGI9AswfgQft4XjhZbCaBGhnGaukjKmW0y/fyzmYMR3
	 0YMY5tPCiSA6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BD546061F;
	Sun, 15 Nov 2026 04:25:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 079FD1A6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 04:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2454400B5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 04:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ooHEQysoYOOa for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 04:25:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 48B5940068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com;
 envelope-from=atul.akella@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=HwgRzim3
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48B5940068
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 04:25:22 +0000 (UTC)
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-37628596783so4021398eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 20:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794716722; x=1795321522;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BaUiYgjZE+3ZyzBfqnQF4AWqwQRMvUwp+j2aYuVrYZI=;
 b=HwgRzim3v4xe4VQdawKAQWIqBCCAOhdS064qQgdeX3TXmPzaW6AYhUaK06hchqNwHr
 I4Smn1HuiPalAfdUcXt1+M6R6plLo4bNJ8BbNUGtMvj/gbBxoIDIiDHGiDIo7ux2sCJT
 91YbB1zPBAJSSNaLp6Mqh4lB/4CHCJwCif4uq7i5zvDj2D6qAE0HRJSECoonk+lG9sSL
 VKIUVt18QKfGBWlRR0j/8pC/eQJGr8p3vuofbHY3tOWh7K6j3jEMkQgPQPqPpzQQZhf3
 0Y79QG5MUHZeYlU02Amq166G6rt5r1vFCm/iqjJsilFF1VBWel/ubT26IfF8gxT6sB66
 56Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794716722; x=1795321522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BaUiYgjZE+3ZyzBfqnQF4AWqwQRMvUwp+j2aYuVrYZI=;
 b=XT1kaTjYqh2+EFB6AdG7BkoIfsHxbhcoUrd1dZzP0o2pTIBV83bWyjiWFQ1ndc1109
 tbRoE/doHCtMR/mfl77CX4I9UbSLQaBfOBwCpG5qp8Gtn2Lg9gdnpIGI54WsQdYLtmbb
 +cN2kfGQrqOnRdGab7EYwWBdtHS3brufKGQoTyA72wM1TURgIgSJS4xJYkR9nVIT5U0Q
 4DqZx/7YxsULeuUYzoW0yevd86jJ6AjINfR3ihoizk+DO/8jbNNMny/Mob/cUf+6p4oc
 yJv8CtHwYRPA1g/hYtTjoXtD6onx7F60oBSop5I//gSEcrtNXnWaxu2TcvXVDzHYChT2
 xjDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHURCx3XUMtp9/IfIOMA1rzojD3xqceb4qspC9mHK4q0mH8BaI7IYOGdPkOT3JGponT7kLEYBA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9wZGrRS7YXngg3zZ0B3q27b2omGEOXIVGIxlxS0WhcuLW7eeql
 tXpui+dzeUJBLtRvthsLekdPLm/tkB6o37V3eR2cWPVjraAgSI2taDX0
X-Gm-Gg: AYBFou12XsT37muhMqaraYFMMFbamrOjkrdVTcZhKcCPfVDRAwsyXpBHEv3ehdi7y4L
 Cpc/4pjigNLXZ6Pu14MzwRw68cc4KYs6/fQXKjK5H9geL7ztVPzHjzbDRD5NqR09yLzgruYYRcl
 pnEWddA49igev/8wi71bg3GfeG9m3QRRAHWCapt/lk6wUrlEH5SRu/6ale/NZ0r6r4Dt/BgSED5
 fGfER6J06GuS0I669Gc729o0dKln8t6PJqBY+2j77aZuGy7ArkhTwEiS8JMlybDN00lEmmOu98e
 ilm+9Inp5FKJTEDei782GzreXU36Etpq5OkeDbbpPvKAVYtvZlvHQe5g1OZUKYauMJzmsOObKDR
 VRMdOy3jtJvGotRD48yfj2eekXN0dRrEEqEvJIWKSIdrPjX0wVW0vXBDXDcb5feOBEgFe8qsMNO
 ejAGn7MV7CRu3QEOq6f7G8qCf4jgFYZFwL2Kj60Q/QKb63mgyF8flzAvgEvGCLDFuUbqHS9nsMH
 3JK9MT+HxC3jhrRoGJ8oz3Zi/sIpzFA1GgPhd3IWwhT90B+yVtzGkHYKMVrariw4htaWesthlvA
 EImav0pwNpmLuFDK5cs0bVxVOHE=
X-Received: by 2002:a05:693c:829b:20b0:374:ba43:ae2e with SMTP id
 5a478bee46e88-3796628d568mr7832930eec.14.1794716721890; 
 Sat, 14 Nov 2026 20:25:21 -0800 (PST)
Received: from JMD ([2405:201:d028:10ff:6918:69a4:7613:6971])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332ae7sm34054803eec.8.2026.11.14.20.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 20:25:21 -0800 (PST)
From: Atul Akella <atul.akella@gmail.com>
To: trini@konsulko.com,
	lokeshvutla@ti.com,
	hnagalla@ti.com
Cc: peng.fan@nxp.com, u-kumar1@ti.com, u-boot@lists.u-boot-project.org,
 Atul Akella <atul.akella@gmail.com>
Subject: [PATCH 1/2] remoteproc: ti_k3_dsp: make bounds check overflow safe
Date: Sun, 15 Nov 2026 09:55:06 +0530
Message-ID: <20261115042507.1054-2-atul.akella@gmail.com>
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

k3_dsp_da_to_va() callback uses addition based checks to
validate device and bus address ranges. These checks can overflow
while evaluating da + len or the end of a memory region,
potentially allowing an out of bounds range to pass validation.

Use subtraction based bounds checks instead. First verify that the
requested address is not below the region base, then calculate its
offset and ensure that the requested length fits within the
remaining region size.

Also use u64 for the offset to avoid truncating wider address
offsets.

Signed-off-by: Atul Akella <atul.akella@gmail.com>
---
 drivers/remoteproc/ti_k3_dsp_rproc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index 9275e1b241d..26ebeed1bc5 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -266,7 +266,7 @@ static void *k3_dsp_da_to_va(struct udevice *dev, ulong da, ulong len, bool *is_
 	struct k3_dsp_privdata *dsp = dev_get_priv(dev);
 	phys_addr_t bus_addr, dev_addr;
 	size_t size;
-	u32 offset;
+	u64 offset;
 	int i;
 
 	dev_dbg(dev, "%s\n", __func__);
@@ -289,14 +289,16 @@ static void *k3_dsp_da_to_va(struct udevice *dev, ulong da, ulong len, bool *is_
 		dev_addr = dsp->mem[i].dev_addr;
 		size = dsp->mem[i].size;
 
-		if (da >= dev_addr && ((da + len) <= (dev_addr + size))) {
+		if (da >= dev_addr) {
 			offset = da - dev_addr;
-			dsp->cached_addr = dsp->mem[i].cpu_addr + offset;
+			if (offset <= size && len <= size - offset)
+				dsp->cached_addr = dsp->mem[i].cpu_addr + offset;
 		}
 
-		if (da >= bus_addr && (da + len) <= (bus_addr + size)) {
+		if (da >= bus_addr) {
 			offset = da - bus_addr;
-			dsp->cached_addr = dsp->mem[i].cpu_addr + offset;
+			if (offset <= size && len <= size - offset)
+				dsp->cached_addr = dsp->mem[i].cpu_addr + offset;
 		}
 	}
 
-- 
2.43.0

