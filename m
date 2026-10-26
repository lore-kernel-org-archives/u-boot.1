Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF8606A32E
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mhVg+cxe;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JlxG24YW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ECBB80E44;
	Mon, 26 Oct 2026 14:44:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GmXLIe-e9Yrp; Mon, 26 Oct 2026 14:44:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C8D380DC3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793025888;
	b=bLVXgBfNidDvhIVz+NA1TdPhDRKONccupN2nThrzvooA2Mt+6lINT6xjySDiqyNBv+I8
	 FWAryX2UTJnaMZ97bb6C8SzoO8gvPK9porN1juD1emcG9CsdRDFaiy8AhsU8p1bYoOqDg
	 XiBCGeGeZjYIjZYMO1An1vlhQT24iPQBAo7moGYIcPQaIP7Yan17UxYNjRUk0rxIXuIiz
	 W+5h55QNaTWd5e3v4s9iRwOE37B/sdG6Lq6T5erO6pXQF+j+hXCfgUJnNlV/0CfrXeg/m
	 NU1phbY5srqWVcFfZCqdjMCRcrRi9MwGTj6+qXnlE0xg5CDuWR2/KF3l8aI4zyI+EJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793025888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3hgvqRwLRCNWbdKCe+UT8044nthIN9m3yXAM8+WtVwU=;
	b=enesbJ0n4Lto36oGfLmydkOP9broM0ZZZhUB3UzcvFXPjs21Bu+j4p802noNwDGUH6gN
	 SMofGYat3E8qOqWCN1BftbnoVhGHjnKlU3l4yT114PARUM2xIO1f1eUaKzwtVkw5XAsOR
	 tFYCtdZA+GC8pP5KqdjAaA043cu03O62AJaLO8HDMazTYi98bifzg5Jmd5LQADRF+kBQ3
	 0iuCe3O4qDUOEiBOFdJlHqK8ENjfsPWe3rJJTLAIDoadC0FKD7ttlEUzVE1e9koBUkICx
	 8AnTWw5DDyHjQp+sdf+BWysAleEOq+KwhhphUikLRxJn20HJAHMybAytf2euL0TLE1w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793025888;
	bh=3hgvqRwLRCNWbdKCe+UT8044nthIN9m3yXAM8+WtVwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mhVg+cxeq9r2mKf5wab6DC+R0NbFbq0S4R+9kFKr8+IzVXh5B5rmB77UsVuNusXty
	 ZmEiKEvxxT7dV3JPuSraqH8duZTBn1bVqfQFR17D6KQf3xMNfkKmJApSSndK5Vfdp5
	 tfXj+/PpOXJlcIGTIDcLfqN9Y8TOHcoTnh9+R9GT6WPoIQDKYLFg5YYXdtWjwdRF+L
	 WVxUzbo1vkCQaTYwu+ETkWk5B53MgWvMv70KBLYojm3W1jUj1BG+Z/Jo//d9p8SQAg
	 CFh2qDO71hpgGlBxxNYuj7/pfMYqqHG7DMxPhiEbd1pjayZsp2omUyzkFInsRiuFYC
	 zTIhPP11mm2lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C8D380DC3;
	Mon, 26 Oct 2026 14:44:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 759734B8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B4B840062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JtF_Jg7a-Erz for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4CB9440093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793025670;
 b=Im1dKy93jFchyAQFyVreE/O5vngDA2frXYessfvNYNL+SGk9zAhtsrNSn/QFRV/e/2t7
 An0MyyOT9BuhRH/hOG+qxn5mCw4N1w86nTbH19AmUTKYjnHIzUXzZz+8WZgrSJxCcRHJp
 1uqbbgusL1d35QJrEl2eFFJFmOLPiSSjs4cf/V986+lVvXhUBdHkC/b30q4KFpoWQ3Wl+
 H/vYffkLhzXEZ0pN/zIrS5Gw6sXGKwQZ8fViXmtiQZGsI2f8EHTPEwpXGRTYq5hTjKl7O
 3AAxnfv/39LZmWbbeLRNG0UYG18URgKWB3ltittBmA9Jd0KF13sT+9EO7+bMtzRgiBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793025670;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=3hgvqRwLRCNWbdKCe+UT8044nthIN9m3yXAM8+WtVwU=;
 b=PLbfGs4PO2PLNCz30WnhITU+Vqi/ZmZx9YdLee0RUyfY4VouoVgktOL1wzynfGy1mEt5
 KEpb1HDV6J+EphSIm27OG+G41a/7rUAvcy270k5290le3QU0sKtT9Dpl1oeGYNCE++AEN
 nAyGyiD5o/C5tX8XMcDUIViOlxXLOwwxc/dxk01XzN0T9ZBpzSkZ02mom1u0zqwoM+/IO
 IhUfwn1HhTSd9yD1mckNFQA7QHN81LBvdjZSnE6ogj2+YTInQKobNnk5R33uwZKOs2DEb
 wlZ56LqyBQ1ORo4NW9AI/9ft6xl4gtbB3ysa/2Z1mArUf3me57bxQs/+jSXOrURc04g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JlxG24YW; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JlxG24YW
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CB9440093
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:41:08 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so9612935e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793025667; x=1793630467;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3hgvqRwLRCNWbdKCe+UT8044nthIN9m3yXAM8+WtVwU=;
 b=JlxG24YWHow7p7iyHqxVJ8H1AKm9ZPP7aa759gN5ajrAZJWk5/Cuh/S3qFWyXTKO1k
 ++n9/REpBtu/ibrDS9mRPP1ecNvykpcSvDCMO5QD1cGwmu7cq4CvwTZGGPYO1NVpNDvz
 cEGgVq5oROHGIrKOGs8/y37LP+W5W1eGvHahnZkv534n0a7C5h5yBGAiyHtiYl0Dvbwz
 Wu/PcSQP0PgG4tNkfL8ME0CoszmKsFWIUSMdIya02pKMdWFpD+MA44KmdWFmjEZwGwF2
 SG2QicsCsQf6tgHfXSDNn8IMrNWmYWoi0uyl2ubr+JPQKNKPoyrGrDkH/NdOPbGdcitk
 blPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793025667; x=1793630467;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3hgvqRwLRCNWbdKCe+UT8044nthIN9m3yXAM8+WtVwU=;
 b=vVDn/86GiR+4UTKScI+vyJz7xyljicvLg6Coz+f9fBlHArFdIc+D34+8zEKojI/Ue4
 fd+WyaM5rg6j+7Bdi2U58kUQILIela9R/56oYsK/C6jRtJQ/YcK5hjD6K8p+jzI92tG7
 51NSt37UKd6I2eWeTx3XF6/frdNm8jDu8mEGwvTCEfZIWMzoWbThtf5O7Ez3SdnhOwgy
 fzNypy34zwmPFXUuCKJHObirTIdIN4pz7k2+nh4LQjhgH2DBAVj3PuFyjAIlIkD6LsSs
 9TyBOQ4Q71qzQ7/uKk38zi0MAyuubTUMzRQo0w62q4vfMzZtVBX6G919qF4kaShgUuhg
 GlCQ==
X-Gm-Message-State: AFq9FYI+4mLeCdMUymrncbquyediWT/p3t4EbR41Cav/UiWX4hxTw2Lp
 K/lImykuMARIg1b4GWRyWUAPB9E53jLpuhKyGUIj4dL2M2F0yGXY/Gp30wKT9jG2ooC7GgdyOVQ
 DwCRw
X-Gm-Gg: AYBFou0h0CWRgWDOkB9mphFwCYcxYfkALazMK4f9SIwLbHr3fHLxEEIMljvr+oJzdmD
 SILl9T4kusFv4XpPmM/023IIS1+QAz1WJGX93qg2Ww4zkdbVnd5qnmy8x5kA95n1cY6crgUVTL6
 JcmGZjBH3t/eIyBTPzX+CQXS8p58471pOUcAvn4Z0gVHSqjKLxMthV1U+jG8AeWiSg/sBHG+D9L
 SNVACcBIMo88zIJd0eaImFw6PoDemRBZWzappXIVRMa4yIKC+DVr4QKLS/acZ/7vphASpl+mBMj
 yg/o9eyJZUWx+k3ikY5hE7GksdjoajCZTHjN+V2g68EPzkKvJ4Dlliqn2VrK7qhBUO7AUabqeVQ
 Nm8Ahk26OHfSD2fO8zKkkpmabN+Lp1d//BoGB6fZdJqZVLGNFpQ5NnwIjnYxhTGRbxWgK2DS/7Q
 QEIfeZvfLo8QKh5S7VkN0N2OY1mKjZt7617XMumIzljtweUQLa55lgKi8dSr/OBDFa0+iJCJglW
 Mmw86s4st2HplK5RrJkchT/LoJad4L8g+B1RePeYI9iQPXfy6v8O7Vv6rHkjG4ceTv4AbUakYD1
 Lf/TLWAEJ+e5dpvK+u0Vvv7U1yM8oMnqbdhfNPR2mLM=
X-Received: by 2002:a05:600c:3b02:b0:4a2:180b:3153 with SMTP id
 5b1f17b1804b1-4a35ac8e71emr131835085e9.14.1793025666708; 
 Mon, 26 Oct 2026 07:41:06 -0700 (PDT)
Received: from localhost (2a02-842a-9b20-0d01-a06b-e180-2ea9-f6eb.rev.sfr.net.
 [2a02:842a:9b20:d01:a06b:e180:2ea9:f6eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ae28sm204958005e9.2.2026.10.26.07.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:41:06 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Mon, 26 Oct 2026 15:41:02 +0100
Subject: [PATCH 1/3] env: flash: Add an erase operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261026-clegoffic-env-flash-erase-v1-1-18777abd1bde@baylibre.com>
References: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
In-Reply-To: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Mon, 26 Oct 2026 14:44:43 +0000
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

The flash environment driver has load, save and init operations but no
erase.

Erase the environment sector the way env_flash_save prepares it for a
write: unprotect it, erase it and protect it again.

When the sector is larger than the environment, the rest of the sector
is saved before the erase and written back afterwards, as the save path
does.

With a redundant copy, both sectors are erased: the active copy
alternates between them on every save, so erasing only one can leave a
valid environment behind.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 env/flash.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/env/flash.c b/env/flash.c
index 31dd1656e721..4b402437eb77 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -310,6 +310,66 @@ done:
 
 #endif /* CONFIG_ENV_ADDR_REDUND */
 
+#ifdef CMD_SAVEENV
+static int env_flash_erase_sect(ulong addr, ulong end)
+{
+	char	*saved_data = NULL;
+	int rc = 1;
+#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
+	ulong	tail_size = end + 1 - (addr + CONFIG_ENV_SIZE);
+
+	debug("Sector tail to keep 0x%lx\n", tail_size);
+	if (tail_size) {
+		saved_data = malloc(tail_size);
+		if (!saved_data) {
+			printf("Unable to save the rest of sector (%lu)\n",
+			       tail_size);
+			return 1;
+		}
+		memcpy(saved_data, (void *)(addr + CONFIG_ENV_SIZE), tail_size);
+	}
+#endif	/* CONFIG_ENV_SECT_SIZE */
+
+	debug("Protect off %08lX ... %08lX\n", addr, end);
+
+	if (flash_sect_protect(0, addr, end))
+		goto done;
+
+	if (flash_sect_erase(addr, end))
+		goto done;
+
+#if CONFIG_ENV_SECT_SIZE > CONFIG_ENV_SIZE
+	if (tail_size) {	/* restore the rest of sector */
+		debug("Restoring the rest of data to 0x%lx len 0x%lx\n",
+		      addr + CONFIG_ENV_SIZE, tail_size);
+		rc = flash_write(saved_data, addr + CONFIG_ENV_SIZE, tail_size);
+		if (rc) {
+			flash_perror(rc);
+			goto done;
+		}
+	}
+#endif
+	rc = 0;
+done:
+	free(saved_data);
+	/* try to re-protect */
+	flash_sect_protect(1, addr, end);
+
+	return rc;
+}
+
+static int env_flash_erase(void)
+{
+#ifdef CONFIG_ENV_ADDR_REDUND
+	int rc = env_flash_erase_sect((ulong)flash_addr_new, end_addr_new);
+
+	if (rc)
+		return rc;
+#endif
+	return env_flash_erase_sect((ulong)flash_addr, end_addr);
+}
+#endif /* CMD_SAVEENV */
+
 #ifdef LOADENV
 static int env_flash_load(void)
 {
@@ -366,6 +426,7 @@ U_BOOT_ENV_LOCATION(flash) = {
 #endif
 #ifdef CMD_SAVEENV
 	.save		= env_save_ptr(env_flash_save),
+	.erase		= ENV_ERASE_PTR(env_flash_erase),
 #endif
 #ifdef INITENV
 	.init		= env_flash_init,

-- 
2.56.0

