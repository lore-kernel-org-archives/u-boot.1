Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28F606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vkCLMQfF;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hzzlsMKb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0309406F6;
	Wed,  4 Nov 2026 08:54:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgVNU11Eksjo; Wed,  4 Nov 2026 08:54:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8930440687
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782472;
	b=jHCguN5mnHDc2T9iSjDiSxT6uNYL7foTpKWOJs+WfIG9bJfpFbgj+k/tU63T0SaoRwMx
	 6U+BxG0HJR6eZsFI/I4cNmL2gtHeHOc6jK1loCHYYb6A6sOW4jGA2AiocALJrOHvCA2oI
	 d4MQL89BtvUQPuulCPr/TWrx44kfzSfQ4/JkDv87BBbL5lmVBR6O44rhYafmzwm2iLkkw
	 nowfGypIv4oD7hLYxy6ACCKLy1pJ1J1rypIi+QuuTKGqdMF4wtbkv0eVx/MuzzfUrUZuJ
	 /79y7FgMxsj0Mpa+Z5Bc9BkTkGn4DpUDztg/MncaVt7hWiyU6bafJ+hxqB4Ek7ofrVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ACgWuC6pAePK4XaZtsOjEz3f8LkFy9doD8hlbKPZUqU=;
	b=ps4o8TEPGPmW7mRtyb8fwL4ClVhB5S8VBuXUxO6PnxgvmLxCLsphaHPnn9U3PnruFUkC
	 O8TUwkCyOiT5mMB2j65CP69FFKIrV9Xaqjlp6M4RcZRcnoFlORZ1LXgmNL023qlTgm0pA
	 Qzk4JnnMOf1afmqlAqNY8S9BhXbll2FykMH0OaYxqCU9+F8FRe+S8XepVlCIhIsmGfba+
	 +BfJEaj/8ecRd4Af0Kp87glSGjNvtd9GVhpnxeSDEBktHkBWVRxey9GEtT5DlgNIrYVpL
	 BcC0GTYOrQ13/uqho84y8Ppd9ojnCYNoMKxwvW1OXf/Ogf/Z4x7UHSzA08ubMDMUc5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hzzlsMKb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782472;
	bh=ACgWuC6pAePK4XaZtsOjEz3f8LkFy9doD8hlbKPZUqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vkCLMQfFcwnZMKZJDP92BUImJR3kR2QmhTR6uxYSo/H3hdpTh20kKiqIPd/M6QCQ9
	 I6KyI6v4LPhsgnazaTRNSeEY0gai8y1+NGlnEIKtvoNOJwLuM+9aM8j1KImht43RBh
	 mXDQ5sAxXgtU9KVkR7saUs1nX8PiO/gwaMCK/IE4TissnVViDsqZYBuhXHdgg++iNa
	 Dv70M9Ydxtvvco1hmAjL4yI/Cly2jrWG4NY6wFTAxpEIRnhrtjf8IXOPCVlIeNKoTr
	 SommaIZEaHgeTD3gTxClUqFeASGUCpVWdzyfID2muOpGvMR0OXqBZrC/sgzYn4OdEJ
	 VKjAvB49FtXqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8930440687;
	Wed,  4 Nov 2026 08:54:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 89364932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EAAA40687
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2oYUpTF6tfEd for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:54:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0FAF1403B1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782469;
 b=aG9dl5NP+gaKVWay3zrmY20psNwcqF5RdH65men/izQ8zVFsyeipyG13tLARPa7VFCqq
 2aL7ePmBFxwhYaQPbQ/m6z5xQ8zEbiU7J+RfWz19w9UabfJV6kOMYSGjq2YN0hCk+Zure
 2yUaovAt4WhcpnMbehLp/d+iQ9Eogu5CnkFiueou95CWIsU0YBHC+6h1BtRZxFjCCj83T
 Q/1I6ORcmbWoRVTodbFRYi4SwkEkUkM/E1TeXwmiIaiO+3M5YR2uDXc43OJErmlTULsJd
 Rv/aRmGp13i0M83ZJkBqOnBiDES+d5wp7QaTA2ABaDlImR+5TWf2a5oI2w+uI1fC2Ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782469;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=ACgWuC6pAePK4XaZtsOjEz3f8LkFy9doD8hlbKPZUqU=;
 b=ocV8qyv7zvoaiX8YSMFbA7BNcnVxJk62aot/fGnV0z73Ez1IBLIC/Y1SrbwlXe8kll1o
 9eVgjLc6EGzXGuV5i/GohW1j9iQLHUAp+Sjbx/0+zyZy9w/cD+vkunM2fvRN7YcVdx8xx
 7qO3qYh5s49brQwQcIXahLpBXu5oFqHKKMhimet962EdbYyfPFx/WRP0uuSw2sgabgUOe
 H+6OkSAB1muVndAYcVmRyWx1GdpqE3KeAleL4RAfYWvC8gj1KjwipSzSRAxQIS4KaGjSS
 psgOO4XAybVksXPlvi1hQyONoE6UY4lYid1/V4SbzaPJ69OjTBu+UfZBYRlB6CbcNjw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hzzlsMKb; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hzzlsMKb
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FAF1403B1
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:28 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so9413225e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793782466; x=1794387266;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ACgWuC6pAePK4XaZtsOjEz3f8LkFy9doD8hlbKPZUqU=;
 b=hzzlsMKbqNra48tLn6topMEUFVeOYwmsmJPiANKOhlLeyYAAyb7VziIxc6iiWRyfZO
 PeVi2WoxhCOmz69e/47pGrAAUWAA/OIVAQhgNRC2xVfCu9/2T0ZvvZKmbI8YXQvhN1f4
 cXVJ+lcFJFTOTRCYIq7RkJznLT4e1yHKcZfOmeFpSy+Chih3nsTQIXkVnR8TvCr77OI7
 s7KL1qhGMNWkjZX8fgnDobNfcMpcFI+IDEz06NnkftQuL4Az4uaovf4Z3TWltoy6Weqp
 9mdhbFqxfL421SfRy9wyOS3D+ZL/1+ydRKWGl3tTcTYNIOjMtt2evUvx4o3ra2Sfn7Ib
 U1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782466; x=1794387266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ACgWuC6pAePK4XaZtsOjEz3f8LkFy9doD8hlbKPZUqU=;
 b=Rrbeesdm/f24vqRr6GTQ5ePhN2txc5ezG72X//r780MdLjc5Byb+wQSlYRMRGS5fRG
 iptTjBVVk8R4R6FrNncpGySLwThqo3DtdLtMCLMo3y0ePFg3hHC6tDS2wDwUrLRx1Ut/
 GgKmx/ZaJ+JYxLyJz68ENawhcTmOaQMmu+2LFveBqnC8YeJclmlgcYl2C6oVL7FdLMsF
 3pGHVj7dNeyncZI6QzMjE2higoVthORllf29XA3fgfMR03vbV/QTL0vnlgA6zDhSYHO6
 NG1G2Gx+M5M7YlzOIQ/atYk9nQeUWxpPFxKc2CutBG+MqxVTQG2JWFefeJMxESdRMJzg
 cN7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWXL5OyTArhaKFLulAgabfUsN90nxleYxeSu4BMk9yH+SHHmacV78JT4ovWssE3MNInmfTYvA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9qQEgxJWA9JlRnBkrOvT9q/e802cITQ4nA2W/o9+eYJP7DQA7s
 aU0mTGiP6f8i0plsOMJ4VVri5g+5H1E2DK015gSzZkrPqMriCAMxdQXp2/on8yFzpPg=
X-Gm-Gg: AYBFou0TbO2CE3SfH5ULcb9E3fpVfwEHAxB9N585oIDzfPvly69knn+KyoqbOkGn9vn
 yeM5JGCCRus9IhZ/AF5soeNVQJyeHNhOfSyv4IxtgbZiHZyUy2cxzozTOdjjGO3ORTY9X9RlHQK
 olJqgiOyIe8yXa5syybPAdqWbVQL5z7IwmFFQx0qQI/kJiZe3/AbcN2vTc0WMrQ29b+RBlZWkKS
 Er2yaEGgqj8hq/hxRRHSdPLLG0QwrGVUkcDDicaJa1dFhByI7uUz4exoI5YmJ+QaEAQIsNJYENr
 CPyYuFw7pkWF8cxxTifW/CwP93dTFb3J8BRd1x0mmASantApUC09pB/qekql8tlQmAlzCfo2XfP
 T8QPDYtXS1WNyhTGUBX9py8LqvjkiSqID5HQoqLMZUuW7qZ/kpY/1rH2hifEDhysm1r+BtWIFT7
 kt85SIqVFkm62vZnPOo6tvErzHI4ERgb7bR1P5rTTcJGPpzfW94gZXC0Tp8HQzxQTujHhOh/TqR
 c5hH2jjwiuYuincRXeEDmSKfWxZrblKKcaEghA2MGY1MLLhRYsfuRoymSk47GqNV2Y3B2Thj7le
 tGumxR8MCKh3ioN/RxPAA9UfiHD7rzCOBKsCNi6qMTNiI4nwjVVl/GNrIfzg0CeTm1QRwv3B1Da
 zDHZb+T6oFvP5dWpuBn/rDDbtsSLmA1+/MIxV/0Sg4mxZP7OI1h8f2udYfTO/WQ8L9kA=
X-Received: by 2002:a05:600d:6508:b0:4b0:b9ff:1e7c with SMTP id
 5b1f17b1804b1-4b0b9ff2129mr169741415e9.15.1793782466434; 
 Wed, 04 Nov 2026 00:54:26 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4107b7198sm20656245e9.0.2026.11.04.00.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:54:26 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 09:50:30 +0100
Subject: [PATCH v2 2/4] usb: onboard-hub: add TI TUSB8020B power and reset
 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ccaione-upstream-mtk-g700-usb-v2-2-b8dc65b47373@baylibre.com>
References: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 510 and 700 EVKs describe the USB 2 and USB 3 sides of their
onboard TUSB8020B hub with usb451,8025 and usb451,8027. Neither ID
currently matches the onboard-hub driver, leaving its power and reset
controls uninitialized before USB enumeration.

Add both IDs with the 3 ms reset pulse and single vdd supply used by
Linux's onboard USB device driver. The existing peer-hub handling keeps
the shared power and reset resources under one instance's control.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/usb_onboard_hub.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 0684f7bfd47..ead8bf44cd5 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -289,6 +289,12 @@ static const struct onboard_hub_data usbhx3_data = {
 	.supply_names = { "vdd-supply", "vdd2-supply" },
 };
 
+static const struct onboard_hub_data tusb8020b_data = {
+	.reset_us = 3000,
+	.num_supplies = 1,
+	.supply_names = { "vdd-supply" },
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
@@ -305,6 +311,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
 		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb451,8025",	/* TUSB8020B USB 2.0 */
+		.data = (ulong)&tusb8020b_data,
+	}, {
+		.compatible = "usb451,8027",	/* TUSB8020B USB 3.0 */
+		.data = (ulong)&tusb8020b_data,
 	}, {
 		.compatible = "usb4b4,6504",	/* Cypress HX3 USB 3.0 */
 		.data = (ulong)&usbhx3_data,

-- 
2.56.0

