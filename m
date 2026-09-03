Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDC3C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 13:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D431F40AF5;
	Thu,  3 Sep 2026 13:10:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eEJCUYJm3sxn; Thu,  3 Sep 2026 13:10:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 95C9040AE5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788441011;
	b=rTbAyVDU/Ws5k0TcQ2wk7hfmLDu1aHk4o8bV6cjIMfswaMBazGDVJGtQbcs0wPjxD/Uh
	 L8OoZkC5UjdKvNnvaZvC7kF6bHaqKLcut3IC0ze+HmYyxFFU7UL6AithIKiSzYyLnR3Pw
	 85Y7dk14kOb8MzMvNfQ2CjDJhxvcCl35qaEok0HcoElhwHwWWYszeBpx8vAAK9iizG2oJ
	 26+BkcS0duXfj1RySWJSNz5x9wNYX4WgP8tt1W4ksBoVe5Wb4rovnA5jyIdMDykY5hamw
	 95alKWNLVwylia/0L7brqPmCkLcQWI0Facfk5I/TXXV5r+p95HksVqkSqgYhrBXC56w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788441011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=T9RMNXHLMqFO5ZldhEx5IUX9rExemcuTy6s3PBr9kB4=;
	b=ZHXesKQPR/l4FNrk2aF+65xtLwiSU4b0MMAQTntXDyjmf9LQGnW3H67b8qPL1kV3cOGl
	 rXl/5xOX0muQrNJ6ymBokXdVR9Eruavp+bHnALJhBCr2HpquvicweA9h8MYV6PaE8AF5/
	 KcdU378ew4H70SeaeommlXXUy+jkPl87TBI7Wqd++Z1RwCQFGHOjwZlgm/NH6ewYhYDYa
	 j+aheSvQGNC5/ws1hjGR2Vxj53HAOuP3tpNJ6BPU7MsXCUab3L/WXwU+JbSZWe4nB6chS
	 VZo2OccEzkX6h02HuKjHnvXR3Y1ECOatPZ0pXzIrH9IY+3S9Coe/KvljcdQ0+eLkrqA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788441011;
	bh=T9RMNXHLMqFO5ZldhEx5IUX9rExemcuTy6s3PBr9kB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=apKG1EXbjxbPTsvmbj8DUgtIIXcxCqoXukhtiPLBqHjZz/WaCe5JQbJDwmffjDnon
	 MZwUlpP1EIM347LUeYw5fyGG17C/xTXS/Hn1gZ1n8RbGCu/y3ZCS/1L0Gep1PTuiZH
	 qat6qPde14EDHr6zk+zEVsyYqcV1CL+Gey3mkI02XnbuR1xGpMlig/p26aUPPjzyTh
	 IG9iezA0rnZkYDRAmVOZgJyMr7xV7d744WRtKiwDkXayQUiVV6N0D+W7EGWn5eYwW/
	 N6P2zZXNA8p+m1/St6vhwXwRQQ2CwjfAUerB/G05TqizczA380/m+vfZPhaJz2tG0j
	 H0gep/vNOcuBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95C9040AE5;
	Thu,  3 Sep 2026 13:10:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2AEC363
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0DF760B8A
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aMhocZ_mFDqn for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 13:10:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C8A9A60B4F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788441007;
 b=DEJGQp2nHUR5bwvDKauT7NRx2T837HvxmUTScA8E1Z4goiRapKSG2FdnpHNggkfkpCFY
 afhhc30rlbRTd7kugIJ4acbP/00qGBjAko9SVLj0oUaa4dd3PdVQ1kjkwFf4F27Q2w6Kw
 Z95GMKuPi8eLDAGwfXpIuipE7GgGqhSWzMMqu5h5/vigx+gjyyJ8CrjisLY2s+xC2PHGy
 DLk292IHBqb6ZoUmK9jGwNYfJDBYrkRqvJNUxHr9Owmf/W4bqN1mp2bvGE9VqjYZU5b1E
 D5XYmhHF18zO7c2l/Pl04uCvosMewwgHiVjm4SqWllZ0shyFeIKLFXsZrrq2ZIttc8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788441007;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=T9RMNXHLMqFO5ZldhEx5IUX9rExemcuTy6s3PBr9kB4=;
 b=XzQiNjCXSp54HGQMI2e69tv+tqCtOefSO6WISI9qPvgV4RkdGUJ1rqxTahqh6tV60faT
 mwxCcz8pGHSYfW6dQIi1t1p1dvvGIjtugLZ2kjwJMrERE4dbB/VOyW9PUZ+D826Ri1PxP
 beQZcEkwR3xGdduYiQ4lSWLEyTwVhQkLBnW9mlzkQksdX0gqM0DxXVnpS/KmRhSCGhRv9
 aTQoaMYv1NYv9GTiAUXCEuRdKZwosC7xVnRwi8hSOvC98XCzXQ4q8TI6DU9sE2P22Pn2x
 cifsxWen55J1eC08JoKXBPTasIhdHjWocYZhcDBpj9qiSoYPMjBRMEr49AYORQpqRwQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LSEwor1l; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LSEwor1l
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8A9A60B4F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:06 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso18274705e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788441004; x=1789045804;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T9RMNXHLMqFO5ZldhEx5IUX9rExemcuTy6s3PBr9kB4=;
 b=LSEwor1lAFDF+KPpYcWR8onOxwxiW+YEJ4d6J4slN4/OgEBcR7swxEHQQpMQd2pUV9
 Di0/ijtBO4rG3pTXun4N8hmSZbwj7WeebbzLsIc50Djgz0SY5AlHBChlpsEZlwTgKDoV
 rRqdNhCvMoGYvfIEeJBd/xMLfHWcZ2NxO6kl5MIT3N+6zXvGuNvL1EOLdJ1GFK5DL+S0
 wQsWpy2SNwculyiYBwLS6VfJEhkAQ74kFjT1mlRGdcs2WI0SGMaNH7ygITdI9YwS/Unl
 enr3Q9amKaTzULiko/KVunDy+dC+S31B4BatTeWdnChf0M7BEao68n0yrnxylveml19T
 lgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441004; x=1789045804;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T9RMNXHLMqFO5ZldhEx5IUX9rExemcuTy6s3PBr9kB4=;
 b=G7DQ/C6eSxt9OmstP/CTnXSLb6BYKKEO7zbcgLSRIOhbu+TtR94jQcljua+74/48BV
 XHUO4qWOcLsMBSHgFIsBCJvB8JQ/ljPXlAblwu94DclCNoaW80ZyzD4lBJVNTUj9r2rH
 p+OXAXX6n8zChdZALF1RSAg5nl8Cb316l0xPNASgpY/qz97sbymo0MPPbW/pOm51x5Ho
 JAQo++h74BV8mCN16yiCYN/mW0sCVFNdZMVgbjrxibqZ/nyeD9PORxcKPYQ0Tzs4fhWa
 tz3O3l2wiM7c3gGCogYL78tJFeQlhTg2Ex43BlnotMxvNiXiBnjhSnJn1BY1URHXyWQP
 NFcQ==
X-Gm-Message-State: AFuF++k667GR80qdhSUzSqO+CLgcay+lP+fylg8pW7KfoONNnQTarhBG
 upMJoSpcZb1asGRvFErQT0ZyEjY0UguxFJh7cyBVnEiY2JePumQP4A7GTi8lJBJtDA4=
X-Gm-Gg: AYBFou07il6ShuSVoa8ZaZT9CtVoHOSnhn84EjCsIMs2wgos03Ino5sQInl1ZjBM6m8
 z2U4L+Fi2WThSmBRbGkU3aokv/ycM50IGwD8QUcPCmVI9Z1DMZvl1Z+TEyG6jVINBvmrCU1OXWl
 BK5NUXrGjrfXzORZKSYUAgLheMMsDpOHUoFpJHk7y9ctHB8SEul/ec5RNGfXrCOn8Lobcdk81mX
 hiiGHDCjzsg6DkL0YfMsMGZiT4YSU82e56B9KzfzdCf6x4UE0O66i1f9AuTlz4v8Gm8/J054lXY
 VXZ/Kxa84tLIvxjmey2GD766EYhbiZE76Vz+eEOR36bjr+a5PZdljyN9kuXEhMpLmDzL7NyQQcI
 CeZ7X7DIbxVuQXg0KDP4W/RCE+L25kt+zyxdh2l6dZsEKRD9vI/HF9EHsCKv6di6eFggidruU2F
 c6J5b6+nDcWIwTziJZWGOGh50PKGS7jWxvD0FUUUYw9lF2Lb4yCbmJeYwL5OZj0cD942ddrSuBN
 SahGGn2ICJp4fcUNEhA8Wz25SVhQ0YfqORUiVtcKZSS4E9C9kLQCcWeFwt2Ko3cXvAor0+x/gXb
 To4CuGD27g2X82E=
X-Received: by 2002:a05:600c:3495:b0:49c:ee36:10fc with SMTP id
 5b1f17b1804b1-49cee361162mr138574235e9.8.1788441003625; 
 Thu, 03 Sep 2026 06:10:03 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed38cfsm12755807f8f.19.2026.09.03.06.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:10:03 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 03 Sep 2026 15:09:51 +0200
Subject: [PATCH v3 4/5] efi_loader: bootmgr: install the firmware-owned
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-ccaione-upstream-ebbr-v3-4-016658d0b6ba@baylibre.com>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

SystemReady DeviceTree can boot through the UEFI boot manager without
going through the per-device EFI bootmeth. Use firmware_fdt_stage() here
as well so both EFI launch paths install the same firmware-owned
devicetree.

Keep the firmware-FDT size in an ulong separate from the EFI allocation
size and retain the FIT filename for diagnostics. The precedence is an
explicitly passed FDT, firmware-owned FDT, Boot#### load-option FDT, then
distro/ESP FDT. A configured source fails closed, and assembly failures
are reported as EFI_DEVICE_ERROR.

Route load-option errors through the common cleanup path while adding it.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 lib/efi_loader/efi_bootmgr.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 6b5dad21b06..4049ebbc0dd 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -14,8 +14,10 @@
 #include <efi.h>
 #include <efi_device_path.h>
 #include <env.h>
+#include <firmware_fdt.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <net.h>
 #include <part.h>
 #include <efi_loader.h>
@@ -1296,7 +1298,8 @@ out:
  *
  * Invoke the EFI boot manager and execute a binary according to its boot
  * options. The devicetree precedence, from highest to lowest, is an FDT
- * passed in @fdt, the Boot#### load-option FDT, then the distro/ESP FDT.
+ * passed in @fdt, a configured firmware-owned FDT, the Boot#### load-option
+ * FDT, then the distro/ESP FDT.
  *
  * Return:	status code
  */
@@ -1306,7 +1309,9 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	void *load_options;
 	efi_status_t ret;
 	void *fdt_lo = NULL, *fdt_distro = NULL;
+	char *fw_fdt_fname = NULL;
 	efi_uintn_t fdt_size;
+	ulong fw_fdt_size;
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
@@ -1320,13 +1325,30 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	}
 
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
+		if (!fdt) {
+			ulong fdt_addr = env_get_hex("fdt_addr_r", 0);
+			int err;
+
+			err = firmware_fdt_stage(fdt_addr, &fw_fdt_size,
+						 &fw_fdt_fname);
+			if (!err) {
+				fdt = map_sysmem(fdt_addr, fw_fdt_size);
+			} else if (err != -ENOENT) {
+				log_err("Failed to load firmware devicetree '%s' (err %d)\n",
+					fw_fdt_fname ? fw_fdt_fname : "fdt.itb", err);
+				ret = EFI_DEVICE_ERROR;
+				goto out;
+			}
+		}
+
 		if (!fdt) {
 			ret = load_fdt_from_load_option(&fdt_lo);
 			if (ret != EFI_SUCCESS)
-				return ret;
+				goto out;
 			if (fdt_lo)
 				fdt = fdt_lo;
 		}
+
 		if (!fdt) {
 			efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
 			fdt = fdt_distro;
@@ -1339,11 +1361,14 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	 */
 	ret = efi_install_fdt(fdt);
 
+out:
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
+		/* efi_install_fdt() has copied the devicetree */
 		free(fdt_lo);
 		if (fdt_distro)
 			efi_free_pages((uintptr_t)fdt_distro,
 				       efi_size_in_pages(fdt_size));
+		free(fw_fdt_fname);
 	}
 
 	if (ret != EFI_SUCCESS) {

-- 
2.55.0

