Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D64606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QoddwGdo;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ns8HsMgW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B47F9810E7;
	Thu, 26 Nov 2026 13:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fRTKBLzTb0wb; Thu, 26 Nov 2026 13:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DB7BB810E8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700003;
	b=q1mF5xEOfVgrub003magkfyKtJlXyCrlp/6qT0GWDvbfRzb8yLVKtWvpm31ExuS0kwzu
	 al0kkEK3ItZ4d41XDK8oj9T5EkcHZpOuODmJQTDL3F9AtI9vJW4gaKSbBtbnQYcPeud3t
	 RT3PasXk6GFSRH9j/pcR4Qn5qKjU4DnocAIXL8OWJnElqM7xrZOCvhWcQpBfGrzTNDWQC
	 +MXfAKSMdoqAkRjHk41llVXMo/znRIzqsyr8Za6daUkIOLoVRW9dlH4QfoWWP4piGDnzm
	 7uHGI6M1NQULfXD/mkxswkN0OPuZ+sRFEmGl7pDjQgSR9AkmGlzBs/Dvs43LoK2+X5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700003;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3ZKK8YexbAZq454DZN7VvtxkLTs9J6oN649Wpoq9LZE=;
	b=MhExeN218aPedDlZmWDc0XHGAcZs/bvfO1M/qCCvFRhtKh8OV9CWrm+AqbdMHle+n2KJ
	 FSOCUSPNe+jVKSYiYc9+E/X2ZXwCMB+mkpU/yrJFZHI7fXIvgWAnb5mm7A70JpWo4qaiS
	 NLBRnEfw384Iw2gOgdpmLpUZZf7nRXM0W44jmbhePx3z1x0bBPXZPzEJWND/FYxKWF8JA
	 B4OQ9mDHWV/T1fpSEbVvG2MD3BQjjrld/voGHNZHhEv1ap6NoyKt+/f86LfKaSojHpfMw
	 Xpuhmu+rvejqx1pT/9k024gm8vdQvbz5uS+DJeVnuF2+vD/lgpAohB75cpCFZzRHJHA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700003;
	bh=3ZKK8YexbAZq454DZN7VvtxkLTs9J6oN649Wpoq9LZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QoddwGdo6pMBsFHr4tp+djQv/fMKgCcjcnxrgRmIRo1XvsixUxzjN6vVCzM3nThkz
	 F5ww+gMOmsLj9U1yf+YMnk7hiiENXfB4G7KLXny8XoD8qh+u06vc5tG+q3XwM6qPBn
	 SSdlCztamz5iZWHNCwGIjRehNKAYQKFBl//qZ8djWH8u524c0nf5gIyzFRLriNkfZ1
	 xXYBWFQlU5vJaDcjVC5mScPmuSALacc1lFjZrcw4tXCq3tZvA1auG2WCjBqdp08xAV
	 Q2xNJpOg3OIYZgQ3PwY1zD2R8808XZSiVmnLWZLbzH2S15t2SKOx0kLiMMyO2PSWkk
	 uXW7GP39YkHlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB7BB810E8;
	Thu, 26 Nov 2026 13:33:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 185D232D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 078E640492
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q2pfVW8ilfaY for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2703C40490
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Ns8HsMgW
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2703C40490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:10 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-71b30ed75a1so3846161eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795675990; x=1796280790;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3ZKK8YexbAZq454DZN7VvtxkLTs9J6oN649Wpoq9LZE=;
 b=Ns8HsMgWCBJMOJmATEj7SV+TYfH1vRzud1KhRTEYASz/A3tt/NHVP5foBEhxIx105I
 UH/IugU8UpbRnGGgTSQvgS1cNt7tdOXg7V9LeFEITUIIw/G9EVMMFCDbzFc6MxOXiRV4
 z/LsoWK76OFVaDXDpoQp7hD2z3TTETWLTsVXTVIZoSE/JOIyKemBKwtElwt937TM9arp
 WUTrg5PtkgEbj2gtTbCiL4CVAiJ3tvpAQKFIlX5BZFBAcfgeYIlH21YjC5xv0huDYnTl
 0El97hxC52F0wh5WMEeXDpii2moV5YPdrZCdn0pJpZtxulgyCo+be7bCSUPoykCvy2kB
 fTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675990; x=1796280790;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ZKK8YexbAZq454DZN7VvtxkLTs9J6oN649Wpoq9LZE=;
 b=2lGyndmEjmhby4Az+7LiclxkodOU33PR6r62pBOJfrd49XE7LAHCb43pY2PJ2Zy0e5
 WoI8rUhlDGE9CZu4EyUNjIQmyWsZpyBM2MVmg3Oo8ZEofTz4X3sIXRehy3erRBgLEXhc
 FV84ZEgsFrUHl99XnxTIPUKjPJ3C1SuANZyTi318nOmcFT0GfzGFuCokwvOa7rVujvT5
 WbdQjPu2jAf8TDP1aEwb4OvVmGSm+l+HnYA1QhBP1uhaS8FSnBm++IJe+8OvyyUWFz5E
 At7vP085O2fGSjOV0XQbFeNynURTEnhmjQ/lpMhbQFuOPMi3ZQgBoyRc4UHO4wMMRVid
 5ldA==
X-Gm-Message-State: APuU4Z+LLO7ZQmqHChxnEDJISaWY4slM2B6cfnjS2Y+AjucUReRK6Om3
 mROknf4SVKoh59HAcKPoPZKX85sCsYcheI8TrYTZcJuPwcN7ZuvCNT62
X-Gm-Gg: AZFdTZehaQPtqwFTYCS0NEt0rA5zEgRdnEIzSiqGetB+zW3KopeWnFrP4U8W0k8fc/5
 /1/FHnHKjJ2xrComNs/77caw989Ti/Lr+DuJvb7COtYZA63ZcknUPIw8+gzBYUtZBlzNVJkq0ly
 f8V5b4lGm1Byy7pyG8BngIbbKC9vASSYyocUc5jI+0tCvP57R1V/TkR+KQ2HYrX83NpYXN05raX
 VBs6dNegWNJ3OOuy3SoE/6/VLLDPx7P1Rls324yHEIY0NuYISLFo/gt0zpOWIwPzNeaKj5/u9s9
 nCsoLfxnDN5fwxl1MvVwCyrFnZMyOALI3y1mlNY9HWElKE6qe4SdQLKda5zQ2BZQpIkkAvZqxp2
 1kxJ/lwXAEoJCQcVh+WOIMXfo51/fdVHzqVnD7vxPjAqWrT6272NKNlqEgFWyjoxZf2Ay8Dg5Ke
 ilGvbDu9RW0hwB3fUGAHLDEi3pIgybFxQKWQFNR7cP7DABMrsYj0YsSZmfc0dNiNXuKAD46N0FA
 4MLi4KBux/JDDxgSsTUhGs+YAjp82Ja0LExWA37pnRmitkNhHR8nUprwDlUCF0JPgz+msV0u9UO
 OruXrFtUOfRy3+OTKODTNu/lXy+ZRJ2gwWySMDTu8gfWrhHfr8I53sfzmbC5UJxlbXYW+A5aK+E
 raf3X6FuWtUh4YD0+FV4SCZduPZAEOzVVL798uAL2cWhSMJlqPXX7kaXiAZXx0EodHRG2Em5dnC
 JearIZkRTL2SGWwcwElYh9AW3Om013xm1mXey0uJTrcv902mLx1wA=
X-Received: by 2002:a05:6820:4088:b0:71a:e62f:62ee with SMTP id
 006d021491bc7-71b39404b5amr15390168eaf.23.1795675989929; 
 Wed, 25 Nov 2026 22:53:09 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:09 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:52:50 -0700
Subject: [PATCH 01/19] env: invalidate caches after bulk imports
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-1-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After himport_r() replaces environment entries, env_get_id() must change
so cached consumers reread them. Otherwise eth_set_current() can retain an
ethact pointer from before the import, leaving network device selection
based on a value that no longer matches the environment.

Advance the ID after bulk imports and default resets, including imports
that fail after partially updating the environment. This makes consumers
refresh against the resulting environment.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 board/sunxi/board.c |  1 +
 cmd/nvedit.c        |  7 +++++--
 env/common.c        | 25 +++++++++++++++++--------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 3d1afec7c66..fb55dc7eb8b 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -742,6 +742,7 @@ static void parse_spl_header(const uint32_t spl_addr)
 		 */
 		himport_r(&env_htab, (char *)(uintptr_t)spl->fel_script_address,
 			  spl->fel_uEnv_length, '\n', H_NOCLEAR, 0, 0, NULL);
+		env_inc_id();
 		return;
 	}
 	/* otherwise assume .scr format (mkimage-type script) */
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 636bddee1be..22db0c38ff1 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -775,6 +775,7 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 	int	del = 0;
 	int	crlf_is_lf = 0;
 	int	wl = 0;
+	int ret;
 	size_t	size;
 
 	cmd = *argv;
@@ -869,8 +870,10 @@ static int do_env_import(struct cmd_tbl *cmdtp, int flag,
 		ptr = (char *)ep->data;
 	}
 
-	if (!himport_r(&env_htab, ptr, size, sep, del ? 0 : H_NOCLEAR,
-		       crlf_is_lf, wl ? argc - 2 : 0, wl ? &argv[2] : NULL)) {
+	ret = himport_r(&env_htab, ptr, size, sep, del ? 0 : H_NOCLEAR,
+			crlf_is_lf, wl ? argc - 2 : 0, wl ? &argv[2] : NULL);
+	env_inc_id();
+	if (!ret) {
 		pr_err("## Error: Environment import failed: errno = %d\n",
 		       errno);
 		return 1;
diff --git a/env/common.c b/env/common.c
index b2adbe93dbe..f217d67032b 100644
--- a/env/common.c
+++ b/env/common.c
@@ -387,6 +387,8 @@ static int env_update_fdt_addr_from_bloblist(void)
 
 void env_set_default(const char *s, int flags)
 {
+	int ret;
+
 	if (s) {
 		if ((flags & H_INTERACTIVE) == 0) {
 			printf("*** Warning - %s, "
@@ -399,9 +401,10 @@ void env_set_default(const char *s, int flags)
 	}
 
 	flags |= H_DEFAULT;
-	if (himport_r(&env_htab, default_environment,
-			sizeof(default_environment), '\0', flags, 0,
-			0, NULL) == 0) {
+	ret = himport_r(&env_htab, default_environment,
+			sizeof(default_environment), '\0', flags, 0, 0, NULL);
+	env_inc_id();
+	if (!ret) {
 		pr_err("## Error: Environment import failed: errno = %d\n",
 		       errno);
 		return;
@@ -418,6 +421,8 @@ void env_set_default(const char *s, int flags)
 /* [re]set individual variables to their value in the default environment */
 int env_set_default_vars(int nvars, char * const vars[], int flags)
 {
+	int ret;
+
 	/*
 	 * Special use-case: import from default environment
 	 * (and use \0 as a separator)
@@ -431,9 +436,10 @@ int env_set_default_vars(int nvars, char * const vars[], int flags)
 		flags |= H_NOCLEAR;
 
 	flags |= H_DEFAULT;
-	return himport_r(&env_htab, default_environment,
-				sizeof(default_environment), '\0',
-				flags, 0, nvars, vars);
+	ret = himport_r(&env_htab, default_environment,
+			sizeof(default_environment), '\0', flags, 0, nvars, vars);
+	env_inc_id();
+	return ret;
 }
 
 /*
@@ -443,6 +449,7 @@ int env_set_default_vars(int nvars, char * const vars[], int flags)
 int env_import(const char *buf, int check, int flags)
 {
 	env_t *ep = (env_t *)buf;
+	int ret;
 
 	if (check) {
 		uint32_t crc;
@@ -455,8 +462,10 @@ int env_import(const char *buf, int check, int flags)
 		}
 	}
 
-	if (himport_r(&env_htab, (char *)ep->data, ENV_SIZE, '\0', flags, 0,
-			0, NULL)) {
+	ret = himport_r(&env_htab, (char *)ep->data, ENV_SIZE, '\0', flags, 0,
+			0, NULL);
+	env_inc_id();
+	if (ret) {
 		gd->flags |= GD_FLG_ENV_READY;
 
 		/* This has to be done after GD_FLG_ENV_READY is set */

-- 
2.53.0

