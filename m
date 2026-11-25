Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1655606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NSLbh0C2;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EpQq9GPC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 754DF80C6A;
	Wed, 25 Nov 2026 10:58:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oCfmuO6j5Sob; Wed, 25 Nov 2026 10:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C82D980C6C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604330;
	b=hETJ8GbMF/hqXcAW+U1u6gzLl7ID9ZSODkQMpZENjmb4QxnomFyQvhwlFCrTO8PY0twr
	 FJIQTATleqgoi9XPz7XfuOvXpwWZUQRy1pmJyNJNDKEMizJAXOaYu0L7811sqoqyDASRI
	 lY0UBWcvryNOTLWbL/gMZF5AXw8IJPLQPR5VT0J2eW3eUHijtxQwJr2m6eQucn43nbCDc
	 PRd7dV/YAofMKRFCfdgHV26n6UDiP4jLl23chckttmIiv+VbQk7sCXr2BasigRDqPW0kL
	 KX1THR2MSbH+gIjpaXoeOgxNHfLl2BX2mEW8vXJCWFE7ggB4U7KztFPJR77CWfsk8Ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604330;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4Uz681lneC/lp0T5k/9szNHWhNsqOFezSbuvDyI8uJc=;
	b=jqw3uMVZyp7DSLf/pPiUnubaHBpvqEP2mLx2Rd6C0AZHnhjhW1SrDNA3ybLE+QxkRDb4
	 YLNtDoJuFOjHUVLPLJFBqPqrEAa6Mkfrgqr9ODp1TldW7tHVhIQwHeICmy2K5sAvUG3Oq
	 ACo56fatVykEWeX8UscVOHEDs2PFo3c+sal4qgHZY58YAxmz0fM/gGp6vsOLMXUG3R4yh
	 UYgKSaaCyO+rEvEE2GdpiVfY9MRzC2RIid2Di9AWUzoGeHcnfh+h878IBqJCs083mSCE8
	 lHuCe67Jbv6l7MZpp7Bbbhjw3yj/1Yhn6LI9yleyAKaD72mJClvpEdcDHEMxOTwV0Cg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604329;
	bh=4Uz681lneC/lp0T5k/9szNHWhNsqOFezSbuvDyI8uJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSLbh0C2vSlEyawBwrUFESpOlAAgxwd2JGM/PxOIlIeXyTst06zXV75DSPTlB0k0D
	 Zhfriz+/99vcISWwLQL+rhmy7gTsiT1TkJgD6DFde+Uaf+W3FH52i8SDPl9xcqItxF
	 G8CFgMMMZ1mW5+13+bkN2H6DzRPe3BEpOLVdkwSCJ/l82MGsQOEO97C+HRanw7elab
	 REPPdcqnutSHJfyYc8wOD7tOMvXjfa3CIwUx3f9K6ZBDtyFpQOJukOpOevHHQduFhV
	 wk7kBVZlXYnHWW+ANia6/VG4DikegXDw+qDgy9lUdAt//GjVmLGd+zr5bj0RankIwk
	 +X52XA3nphByQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C82D980C6C;
	Wed, 25 Nov 2026 10:58:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 84593325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6ACA440549
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MtvC-OiHkVZZ for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88522405A6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EpQq9GPC
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88522405A6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:37 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so4872662f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604316; x=1796209116;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Uz681lneC/lp0T5k/9szNHWhNsqOFezSbuvDyI8uJc=;
 b=EpQq9GPCJTl8PNksEdaa00jDV30Nm77d7tx8y4T9kQ/mc1oGbbFz4hRTNRmkvIwcsr
 jSFvWNaGRpC0/ObtXPQVRSkOkONsyVCassd4suEqXOhc2PrgAEeQNhIBFIClaJlzORGg
 GI3Ru/MgNyLwOqn3X9WmEx/bZVpaad7MHg0YspS4FjhGRAe53O/7hjkl8x909oU5LGl/
 6DWd2vgE61tLG7JX8+cUb561KwbqELWu9t100FEe5sV/po/68s13QI1otB6oUmGMQnCV
 B0ujHnY15+2Xvs59UVuUIPIwDm5/kTEzj2epOGhii3HkmtIE7cnWDIeFLvhcaeEYi3hz
 Xrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604316; x=1796209116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Uz681lneC/lp0T5k/9szNHWhNsqOFezSbuvDyI8uJc=;
 b=SV6jPC3rzkilMy3dnBNP2070YPgw0WG1KIzoLy3+fekT77kKEMWJIV50zAN2252oI6
 WLDnr+8hRFaLMYbdbqipPHP8WdQPf+YKHfTLzHRTI+w02lbhV85qDfIDITemzwZhDWiy
 OU/c0VuuLn9OAXJBPMVkPuUWJxOglrxWoKQL4l9Ql+6Yp4dam12biURdZtp2PHnSjRzN
 cZ4i5cx926f8qGcPTBwbcTqnoplSBrtUAWdIugIqAUR810fiQ2ZTEeZh9nWHlkCRpXXe
 mPf7Z/BBkvNsolQ3tsxW2MWARHs0yADFvtNAHl+mcLnL8vBfzbM0IJRtZI7MfRdxcNIN
 VcmQ==
X-Gm-Message-State: APuU4Z9sXHGNcH3JPBtQMDWEpBtrLKDGwTrwOqnzxYWZSlYTqVswRzLv
 ftO6mlYGGxpM3gW0dE9Hz4VBoF20xlgGyynpvSxXTmm3QOin2KAdwY3n6MsKPHWVtyXtiS9Ilv2
 4jggwwAXPYg==
X-Gm-Gg: AZFdTZezFJk2hU4yB4Hn4NDSaELGrUpD7noWHitC2YtQwlVWol0mcmXqipTwsAJqIrP
 +6QA16/71/5Bag6TKpzgcJI8lPuCLqOa/YxdK/fY4vifhHZb6rvf6rz2z6HoQ0AWKpOC2T5ILqo
 E+ZqudT5Bz9k+I5yh+8zwCqC8ETo27lAVu2HBfm8VVmNWAB2Y7/beDGs2iaA1VASinooE/gGsqM
 liCxRdyHPXBSJqJfXIsm/v7MsrzHCKxzJaxDXgo1zRd2m1jb/z0yVhJuBpiFxv3A9vmYYe1+Zj6
 kGZE1NjxA3aFs6DoikdqYT+/guS4J2OUfOkOKvVva215LxRBJfPmMZVK/7asvNb4eC6zEHPu0WB
 GFvzdzB/N39GH3S3CJnvyi0c1u0Y9jf/zaNOCailyVxc/Dcj27OgbnaFQkgyF2021a94yC/G2ve
 C2mIUTr594Thq7QqwGToHoJnvDjyv+PbI+znKeWAAmFMOSpzlWrmumMP0SfCVJyMxItF7iero8g
 QczA2hxqJPsBatr3f8tUFr/re9VQDRHJkwBFQ2HOZLkTaFf71spNyz5VJSaFLEngvz60cSvQh4t
 HB+gw3jj90JHZjMjCtNJJ1H2IlVYpnMDlrrfHkHAZr0qjOUTWzW80q4K/MdmjrEtoYmEB6Uw
X-Received: by 2002:a05:6000:290b:b0:4b7:8363:682 with SMTP id
 ffacd0b85a97d-4b7836306d3mr9369143f8f.16.1795604316146; 
 Wed, 25 Nov 2026 02:58:36 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm31583847f8f.26.2026.11.25.02.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:35 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:14 +0100
Subject: [PATCH v2 05/11] env: flash: Add an erase operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-5-8d31a33a54d2@baylibre.com>
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

The flash environment driver has load, save and init but no erase.

Erase the env sector with env_flash_rewrite_sect(), and with
CONFIG_ENV_ADDR_REDUND the redundant env sector too. The driver only
builds save and erase with CMD_FLASH, so ENV_IS_IN_FLASH selects
ENV_SUPPORTS_ERASE only then.

Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 env/Kconfig |  1 +
 env/flash.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/env/Kconfig b/env/Kconfig
index f3b95fe64f57..82d59fdd8d7e 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -158,6 +158,7 @@ config ENV_IS_IN_EXT4
 config ENV_IS_IN_FLASH
 	bool "Environment in flash memory"
 	depends on !CHAIN_OF_TRUST
+	select ENV_SUPPORTS_ERASE if CMD_FLASH
 	default y if ARCH_CINTEGRATOR
 	default y if ARCH_INTEGRATOR_CP
 	default y if M548x || M547x || M5282
diff --git a/env/flash.c b/env/flash.c
index 7697afa340e5..fbb66ac2a4e7 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -284,6 +284,21 @@ static int env_flash_save(void)
 
 #endif /* CONFIG_ENV_ADDR_REDUND */
 
+#ifdef CMD_SAVEENV
+static int env_flash_erase(void)
+{
+	int rc;
+
+	if (flash_addr_new) {
+		rc = env_flash_rewrite_sect((ulong)flash_addr_new, NULL, NULL);
+		if (rc)
+			return rc;
+	}
+
+	return env_flash_rewrite_sect((ulong)flash_addr, NULL, NULL);
+}
+#endif /* CMD_SAVEENV */
+
 #ifdef LOADENV
 static int env_flash_load(void)
 {
@@ -340,6 +355,7 @@ U_BOOT_ENV_LOCATION(flash) = {
 #endif
 #ifdef CMD_SAVEENV
 	.save		= env_save_ptr(env_flash_save),
+	.erase		= ENV_ERASE_PTR(env_flash_erase),
 #endif
 #ifdef INITENV
 	.init		= env_flash_init,

-- 
2.56.1

