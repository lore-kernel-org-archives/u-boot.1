Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B578ACCA490
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 09:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57EC381421;
	Fri, 16 Oct 2026 09:06:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJfMCs2I58Cf; Fri, 16 Oct 2026 09:06:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8BDD281401
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792141591;
	b=azj4BuyNE4LR657ccjrI+1x9KKLxrtIN5YGAfm1Tu5DwHf7tqu6Q50pNMrnVvP9YK8+o
	 0HscIJKcMjtrXdVGZqnAFi2M20GHvby14hkbvo/fBPX3TgDixSJlkqQvKkMwNDPhbjxtJ
	 GoHrQnfHHkGaPwzoClb4iC+B75x6BU5zYBBi7nYqLmO3fmdS/y6Eqr7jZFCP60NmYYKri
	 Ijv7M8knktjr0+UYwwd1IWZRGMH8mxsX4HN8Nurx5WFs9A9gMOKDn6Be1m3n8fVREYJHR
	 XiSUrqDtRD0dgZAEZVPU3UZ/W/kHl9aDvUFjX8gBnLdLE9Af1eM+1B80s4plqHplZpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792141591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0dBOSb9+kLXbcbnu+EJTDK+64yj2NMYPH/T36uf9gmA=;
	b=aBt4XKRDlMWNtESkgUSMfnyy38c/6bl0+7udplJ30VlZLgS+9E1ngvTIR30EtNIh/jKa
	 pnXKmX7FFdvCA0+wIYin2y83z49b612KYV9Gw2VHw3INHYq89dtGzY1ndF7cK2COCOOjm
	 nfRGwpy7Uip02iklbg9KG3L8F7RHqrUr1+FhtJIThrwlS/CUbbmK7WytoNUeF7YgvSQjp
	 4KRYuypb5znNlawnVfdvPD7InLoDdWipcxeJGrSvTUY3N5ZQTkRxgPVwaXhVA2OUXTvTZ
	 /KZmY/VCmKvP0xMQftNeNvFSju3mJzh5GN4KN4qi/E720e4XGYpLyK37Cepg3q2rnMg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792141591;
	bh=0dBOSb9+kLXbcbnu+EJTDK+64yj2NMYPH/T36uf9gmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kd1V8o5szbm/e/G+ipX+aEdVXooxjbPNTVSRoxsCzz75h3U6xkXpbmLXt4KvyLi50
	 64D59t39n2O6zG6LXb5C4NEsp3X0g7ScICSifhSe+XINFyQtAT61afE+b2G+MkwHrl
	 27dE5oFOtDN5x93kn0KM2bC+MVXxe2H2lfG7pAV6rEbITi7wK3rf+UZwQZ1Y+EEGgF
	 y+pnE7Mj/thfk+EcO65N9oJN3Ak8kp4/KjTEdr/0NYum3x1j8KZjBWcmjlCySR4lc7
	 XtlDH2vrFBkAHpvAEjhL4i39FdRckxiYBcuRQ+Rt96dPjslQ9QfKqzBXjqJjDcbu+z
	 i/as6HbgHwP7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BDD281401;
	Fri, 16 Oct 2026 09:06:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 555D0263
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4744B60A9A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDXW05GvbDrG for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E7BD260A8F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792141589;
 b=kNlGlDCpQ/SrIqvGjG6kyW0NjcQDBxGYyYoinPqJnLQ91/ddguPoBDCwRkysxi2X0VA5
 hxIIc6pcPpJNJjNSwikUh4sZAc/P38zWu1La0vb+2NLrrNKXEdmxHeh7rOFGKAPtnI9nx
 5S5bjUcl7bQQ1rMpDUUvXXSoCMCx/S1MlItpq3OAiPj5D8jzr7tYviKg337+unbSen7vF
 ybi41PTbk4dY8K++Jn4M9WIa7TzIphd4oUu3kdfJlNiFzA24kGeEYJUZSCJN2y0FjNuFf
 PQfuhf0va2NXVUlBNJWJCnfLWAtIKVA+seSz4uuHryRGzOkU9KhfHZZI8qkS4zNSN6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792141589;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=0dBOSb9+kLXbcbnu+EJTDK+64yj2NMYPH/T36uf9gmA=;
 b=D9ueSdINeGednG79mZgVuO4XCHWmIP4bPyf74HklrTpALpZy/QneQ1VVLsyNl3BZJppz
 DMsCYpxfKCzQ6OBs1Mfrjp85xVByi0ljXFyVgmEDtF+K25yAVqf1FUGG0oqM2zRVZwUV2
 m+Mp5XdsNcQHmRh/Me9moh2OxDowrAcw9fRwt1koHDJ9yaSWGPMevervDAqM/d1i9FKQt
 HYiu+Za0dsw047utIx3h2lzwEtjYTV9MDEOQEmPwXWXwM7YiaS1iZwMPa4DmKsgxZ3glW
 qzSderJuLmUtAeKqYs22IkXI//Gxovh2Nb4NUH3FiMSNdegBAX668bwkGq7d9hh0g9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lyYI+E4+; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lyYI+E4+
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7BD260A8F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:27 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so43752195e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792141585; x=1792746385;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0dBOSb9+kLXbcbnu+EJTDK+64yj2NMYPH/T36uf9gmA=;
 b=lyYI+E4+hOFtXfw9biTFY8LncjTjhHiIDX8Yv1yqZKbE1fC9fftWP/if9EskAQYeD7
 p1FCoc5bVJWBG7GMk6m6LwvQwKpon/ShZd27Gug1XZsx/EIbZ9vwKz759WLu8bcSijYc
 e2t86k42/KiK+SbqUlYCZa5PpjfVLrZGaAXn9FzsPh6qHiiP2j9Ehrrr+5e9gaFQ1j0E
 8KBjpO6mmfhtdWdzDwvSetFqSEvqq1R8nnoveDOn5BcJmMaqJV04UvvCeCsS3uHgRlto
 ydP3N91r7OhHFgmoS8UntEfJOE6JcWZqLsY7kGwnws0s1w0toTRcGRXU+ipsFex+JEvZ
 i5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792141585; x=1792746385;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0dBOSb9+kLXbcbnu+EJTDK+64yj2NMYPH/T36uf9gmA=;
 b=R2TnFYScigynwx42eqW3IwQpN7TLmGsu/+DsD7OfSSRjcRBw3cf5CB1biV39Tay+gD
 UL7s5qFmHRzF8r2Idleoc2rhOFgbbcGQ9ULjqHCq1bZ8vxLD4J58leit0PsYb1jOIgOA
 WdbJePPN+TBkb2nJHR/uCvsqjNutuz6FlCzOYoQQZPKh3pyF1F8jaqLLVT+GD8ZBh/tl
 4lI5B+vlgzXL8Xa+E0lH+wX3mC8VWBEjbgtEwYjbnuyOle+8IcEYBccU+ca7efmfWiXj
 F7Bm+9AK7Kc77iwUAmyezl457NaADgYs42+ClB9SHTNWGKFi6Ot+IlPTxd+AyWaQquBm
 swSg==
X-Gm-Message-State: AFq9FYL65kdQYRKmuEnyAhoYbWeczXI6R/Orp5VpJSx1C0c3kc1OLDoO
 RlYEW8sa7yhNbqQ5qabD1Dt1VYS6xA+D1REojYS7F3gjQ83ynevkvQ+ddY0aNrMO96AmikkrLUV
 LiSw3
X-Gm-Gg: AYBFou18sk5mOBQ3tMW8FbjRcp8DPsLKFj6vdCpBsBZKkMmfYnJR7RhM8dy4313fHWe
 BRvh+Ue5nxvJErh9SaK3ntEQRRTZ9FttHx+AGuV7OaGmR1/eAeoN4eDLL3ZRiTvDIn+bbXPp8fj
 gfgsN2KMP4TWdeiwF8dAbfThYekcptWxrOZTxRT/LNPhbej3nFzr9xx4QqTgrVqDp12QbXtJy5A
 S8NwtuG6g1vXn/zdBx843qzqfUtto6ZTmJxy3bywjmnHCcXfjqcTRnDzmijlDJlqxHKTEAgjB62
 GzQJhnh1nkDx3yNe+OY6TakrIQX8caGPVfU2UlfaPH0w+0zUQUIjDA0avyrscC2WwdCT1jS7wd5
 W0wowbAw8PpvLXVklembSckaERIbXKq8IG8QySzVhB3+nK+Xn+gZfvTTphKlpfo0n6D9REtQuTW
 WvSm5sYkpr8UAkYwxzroKsYipsH8XrfvwzDAQLw/Mm03oUCa56jBnjHym6mGW5w+M51SAH/sSBA
 uKszDvyUdMg1JQ=
X-Received: by 2002:a05:600c:4e45:b0:49f:c199:e1e2 with SMTP id
 5b1f17b1804b1-4a18e4d8c30mr440821305e9.28.1792141585157; 
 Fri, 16 Oct 2026 02:06:25 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm121287685e9.0.2026.10.16.02.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:06:24 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 16 Oct 2026 11:05:52 +0200
Subject: [PATCH v2 1/5] arm: mach-k3: common: add helper to wait for TIFS
 initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-1-c7ab53f79b34@baylibre.com>
References: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
In-Reply-To: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=msp@baylibre.com;
 h=from:subject:message-id; bh=8y2c4R2e+MkXz0rDe1+F2rZpAaaSJ7JWDnhOgrKAoYU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyLL36qh63YPr3AKL+uKMz74m2P6ABPnUcpxReWtBZuC
 nz1YY9Cx0QWBjEuBksxRZbOxNC0//I7jyUvWrYZZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jBi4OAVgqj1cGBmmKcgzFDH+8OAWU/h8eOWM4+bBaoIfm48uV4y4xrxr3c3zjAxruaP2Zt5
 Kep3JJzf13z6tievY+7Rrc98HN8k57l2U1MwDAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Add a helper to wait for TIFS initialization to be finished. Effectively
this is just a call to get_ti_sci_handle() but I think a separate
function makes the purpose of this call better visible.

get_ti_sci_handle() internally leads to fetching the TIFS version with a
message and response. TIFS only responds once initialization finished.
If a response is not received get_ti_sci_handle() returns after a
timeout.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c | 10 ++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 6e382efdb3be..480c90cfa65f 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -54,6 +54,16 @@ struct ti_sci_handle *get_ti_sci_handle(void)
 	return (struct ti_sci_handle *)ti_sci_get_handle_from_sysfw(dev);
 }
 
+void k3_sysfw_wait_ready(void)
+{
+	/*
+	 * Wait for TIFS initialization to finish. This helper is used to make
+	 * sure TIFS removed the firewall before U-Boot tries to unlock CTRL_MMR
+	 * registers and continues the boot.
+	 */
+	get_ti_sci_handle();
+}
+
 void k3_sysfw_print_ver(void)
 {
 	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 37ff98d89924..146b986febc6 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -38,6 +38,7 @@ void disable_linefill_optimization(void);
 int remove_fwl_region(struct fwl_data *fwl);
 void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
 int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
+void k3_sysfw_wait_ready(void);
 void k3_sysfw_print_ver(void);
 void k3_dm_print_ver(void);
 void spl_enable_cache(void);

-- 
2.55.0

