Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E83C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04AB581306;
	Thu, 13 Aug 2026 17:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0uXNYNTL3jpn; Thu, 13 Aug 2026 17:59:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44C5F812EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786643963;
	bh=xt1aVluazd4OaQAMEs07yOAjuVaY6qRKQoFOIV2dI4U=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AG8EcWQAGgNypFK/o8KP8CgRGtqhDvA/Todym2O6eDPRC6T4dNcE8gqCc3ilj1mcH
	 B8Id1rSgaYYHVluNAKXdpBE2lWVvHx0Saxf2YSoHguvfNpK4iDKL3IEMpWT+At73Oj
	 aZASBMWpYjTwsljcGUCSc5wXzeFWoH4S/hHehQbztDJTIma8jRp9SJCXzrgiTafng5
	 gHH5NDprS1n6ipOFksNVtexhh0F8jthyPsgMqocFVNZpjQKj7zbcosU1xUUWGh5Lt5
	 hhoaVHwg23e7OwPdiMrLMJ4tXJv0VQlToO7hjGOKXAY5EBuyG3zCJOrNJ8jNAVP08I
	 evrClq8dEVLZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44C5F812EA;
	Thu, 13 Aug 2026 17:59:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ABAFA388
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91E7260685
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:20:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cB_6ApmZyrUn for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:20:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3126E60684
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3126E60684
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3126E60684
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:20:48 +0000 (UTC)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5AE0D3F442
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:20:46 +0000 (UTC)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6ae4622d842so66961eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638045; x=1787242845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xt1aVluazd4OaQAMEs07yOAjuVaY6qRKQoFOIV2dI4U=;
 b=jIr3uwmhwGxNYEfIUbMAc8kmhkgL6/5H8jtZ9mYd1WvfKjgozFRLJSs3fOrzioLifp
 1edOWu+orvZQe5xe4E8OAZwnjvViXuWF0ZNDlRj+kAGobel76+dCbr+CoJTNm6pec5e8
 7/v4G+Jimu6E2uMbtA68ijFpeCLPTfGbd5loQHLNazpUsZAM1OKdW1BsBrkxZ1FEvr1j
 wJL5++cAhFZ/rMVAft3NxPuVOsg3RdiJGxgINT2+0zUXnHVftVyPMp5zZZeX+XrhCJFV
 S8/Cmqih6s1il2sxV6+PA8PrxX+BPB2vjSx1fabkcIUhqGhGr++wgcGwb+OMFL9Ca0vv
 aplQ==
X-Gm-Message-State: AOJu0Yyw1osJgAFCDVhDLuizVsZ0LWwrNaz6ZX0eTdKTXBbRWws6X+NX
 r9U4wXM2mpvXgHHmk4RD/RHzPR5R50NzIygfaEsYV7w2QHuPzUWOQ4A0oDn0P/b1h6pWTsxcBHY
 +dCUpKSWqA2vaiXmRJZEi7Rj/R7Z4jI6zNYeIn0dE6gU7rzu6b6iFyMvdDWIfyAGJAQq6Uzjl/3
 k1dKx7Ti30qTszYrMp9w==
X-Gm-Gg: AR+sD10lnb7139qHX7sEgBvSpsqHWq1AvC9XG9Ghby3oEntzbbG/U/oZBJiDJMtFgoE
 on4pfd6UEvWOgCFU0rNuj1lyf5tOFa+3lFJhWVKhBiKmY9AdWNZcocTxC1REJxfIBodq1vF7T8u
 IazzkEJU6HUo3PGsm4VOWdabXwl6DKt7tG1V9ILhhQzsMbYwj+9zKpm1Uc6QIoBoIF0lzYP3bvH
 faNgq/V9cksYhBIVYQIkgpALC40ubx3o/RxUBAewmX+egskb/1sTMYYaVZqzQ8QpZ9flYm76GaT
 GQcq7wRnZU1uVsIvx0FOise1QKW5W5pex4sLJBoWFQ4iwx+hhhKSk51m1/0VwI025Zddd1u7MjR
 LCVxrsFjMQ51vfJOYKEXorPWaCDHvSIuk4/KgIDHFF3yNGlzaoqw=
X-Received: by 2002:a17:90b:2d89:b0:38e:5ac1:9517 with SMTP id
 98e67ed59e1d1-3931e0290d4mr8084855a91.3.1786636601156; 
 Thu, 13 Aug 2026 08:56:41 -0700 (PDT)
X-Received: by 2002:a17:90b:2d89:b0:38e:5ac1:9517 with SMTP id
 98e67ed59e1d1-3931e0290d4mr8084806a91.3.1786636600714; 
 Thu, 13 Aug 2026 08:56:40 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f44de1esm3603538a91.13.2026.08.13.08.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:56:39 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Francois Berder <fberder@outlook.fr>,
 Denis Mukhin <dmukhin@ford.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/7] bootstd: rauc: Fix NULL dereference in get_slot()
Date: Thu, 13 Aug 2026 15:56:11 +0000
Message-ID: <20260813155617.184928-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813155617.184928-1-aristo.chen@canonical.com>
References: <20260813155617.184928-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 17:59:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786638046;
 bh=xt1aVluazd4OaQAMEs07yOAjuVaY6qRKQoFOIV2dI4U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qaNRu4wH4sOo+WJEHm7BuapfVCnOtoKU4iqqYaX9yyD0Zg+XZ+yhlHVTMURZFRzAq
 icCWt7W2sWF2gMhvn8wdQwSDS1ql3dJCRA3tAV3nb19AFkvgqEYT+zv9r7YHg3jv/S
 Y3Hsjb0N2CwufyKEYQktavfBhNdq6h+qCzGFrrJqGszYaRG0qujEevmSknPo8HOg/x
 w20wOrMGUVGlyKRKeLxZ66o9JcSv6Ly/YceqjGt8HS/fWHTTukWwsQ2g/q8I0IOnzT
 Ia+yYPQ3rmo2ezrxMZI0dPQQ1khq/lzmGyKEk+68xZPebUb2a9IR66fPgzuEwG89Ff
 B92p9JYlleDT9l/LjhIgM0mRJCGSChD7BNgRMqyTp0E9jLt2/e1DCbU0IHjeF2sM8e
 gem75n3Td0NMjuGnfJ+DqIbJdyY9GPI8b/IywFaAnrzQLXIlZJuyiDUODV0MrfKoPI
 3uSzSJSg9y9iipIe1rIKXmI29dM04+NTJv/wgWOIkgzkU5+LzjPkaUKSiJZoezPY1W
 XdPpS/JfMtDOxeElu3VnOffnVeb+Tsj+xkPjYCHmawo+1vW8rgDGAOkb9LfhtAtVfi
 eGz60AbV4d8pMXJWvpiPQ+rEEFpLf4r7sp1SCXEqTdtaSoC0Y+Z+rf0jK9ryf6H7/F
 h/ZRPqa53c9FB3JTTPHkHj4s=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=qaNRu4wH
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

priv->slots is a NULL-terminated array of pointers, but get_slot()
tests priv->slots[i]->name in its loop condition, dereferencing each
entry before checking it against NULL. When slot_name does not match
any configured slot, the loop reaches the terminator and dereferences
a NULL pointer.

This is reachable from the BOOT_ORDER environment variable: an entry
naming a slot that is not listed in CONFIG_BOOTMETH_RAUC_PARTITIONS
crashes U-Boot in distro_rauc_scan_parts() or distro_rauc_boot().
Since BOOT_ORDER is typically stored in a disk-resident environment
written by the OS, a stray or corrupted value must not crash the
bootloader.

Test the array entry itself before using its name, as
distro_rauc_priv_free() already does. Both callers already handle a
NULL return.

Extend the bootflow_rauc test to scan with a BOOT_ORDER naming an
unconfigured slot. Without this fix the test crashes with SIGSEGV.

Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootmeth_rauc.c |  2 +-
 test/boot/bootflow.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index d7b0c686ffe..32be641ab54 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -71,7 +71,7 @@ static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
 {
 	int i;
 
-	for (i = 0; priv->slots[i]->name; i++) {
+	for (i = 0; priv->slots[i]; i++) {
 		if (!strcmp(priv->slots[i]->name, slot_name))
 			return priv->slots[i];
 	}
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 1cc137c9700..837c5a7a4aa 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1444,6 +1444,22 @@ static int bootflow_rauc(struct unit_test_state *uts)
 
 	ut_assert_console_end();
 
+	/*
+	 * Scan with a BOOT_ORDER naming a slot that has no configured
+	 * partitions. get_slot() must not crash on the NULL array terminator;
+	 * the bootflow just becomes invalid.
+	 */
+	ut_assertok(env_set("BOOT_ORDER", "A B rescue"));
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_nextline("No bootflows found; try again with -l");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("bootflow list", 0));
+	ut_assert_skip_to_line("(0 bootflows, 0 valid)");
+	ut_assert_console_end();
+
+	ut_assertok(env_set("BOOT_ORDER", "A B"));
+
 	/* Restore the order used by the device tree */
 	std->bootdev_order = old_order;
 
-- 
2.43.0

