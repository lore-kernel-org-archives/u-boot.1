Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8F606A327
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uVMhOjlw;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=J1vzAsm/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3F568123F;
	Wed, 11 Nov 2026 10:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ASNEbh6oc0IG; Wed, 11 Nov 2026 10:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E102A81250
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392515;
	b=QLrVY7sgWUQLhfP1Phw00K1ZRQI5bYTsQK8PmAuHYDs8XsIzT4VUwEGndcqCRJ849wi9
	 xPYLE9FO53+395/lpo67uAyZlycGy0y2KsGklFTgX4jatrZYl0UD0ymyuU3kGiS96LaV/
	 u/uYXoEjgSzf06bXBWePhXeH+e+Jvac+BE/K8VG84S5YJzT66ubKGZRrOYGS6gcONUz2O
	 orXbJe1kvp1iZiPMpX3rAbFTRis1Q+4JJILJFR9ummHDiZwvq9xYA3jaGFwbbHKxPk4Je
	 IUYxHGJSdFpTnAn+NdL0vhDHQuuE/pmHTcdKyvXQI0rxEx02SoH8pf8Mjm4path6egQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392515;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QtV+/YTJ4c5LiY71sMjL4OhEn1oiw9+wR7qA2hZBTE8=;
	b=ZS634y2aNO6Eu9InMfqbBvBgX2l0YUpIuKKPN63W/RGwAah3P/PpMll2tGbaLReFOCCq
	 b5R9zMhpR/vVB+C1xa52adb0VD+SGJnK98qyKq53uiG3+AsK2m9E5dvjKR7fldanDAP34
	 OgPADosYbasM3nz1/4bYrWCpLVh+fh9n0+Y7xbN27p/yEEZShmrqWM/1chwVUbKsp+6Uq
	 F3n4iPPoBipt5+a+grA8XLrE1tLQgATYczcPQ+64V2UQVCX4NkEkDL3WW9eugvd1M7w2+
	 0vplhdK4lvWEdSPyy3hQLfXxi3lGJgYxmIGXbjQ257/0wjPVNkOgwQ1Ppk9cS+yzBAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392515;
	bh=QtV+/YTJ4c5LiY71sMjL4OhEn1oiw9+wR7qA2hZBTE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uVMhOjlwoNKX/YdDpehnPWJMzET1EbT7TdeFqjyVAMr7XrXHKQkT9yXkxMj/hdSa2
	 Q0MBySMIfH+gr1maRJYP2vXLN2ZlbFj/vzWaH2cwm6LssOJVmMkN/JMlsF0EFG20rN
	 zbyMykgZ9DZaqpiEVkq6plmWGqxteRxwy6HGuwS0m5ndpuT05J6zlFo7bDYEr+2+qh
	 /bdlgkvjx8RgM0pD86mBUMvg0kK1g32OL4gcNkvvff13wykksKaPx79lt/TlgZO1d2
	 X7hR+XUE/azyu1vv6iLe/TBl4deduLMWeTu4KlcZfGEPmSgzR/UT8kZ9VS4L933fD7
	 2XLf43TcuxRIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E102A81250;
	Wed, 11 Nov 2026 10:21:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EA6528C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A37340869
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XJCqjWs7RUtj for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8673B40871
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=J1vzAsm/
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8673B40871
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:48 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so23423215e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794392506; x=1794997306;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QtV+/YTJ4c5LiY71sMjL4OhEn1oiw9+wR7qA2hZBTE8=;
 b=J1vzAsm/ODISCNlg6k3V1B9gJVijOe9a1T1utX4xrgpm0rC8gpHAh5llqWhk/sDbfu
 7ZOKUagqtkoii4q+2Vfb5g5ZCSyvf259hwv8H8khPcAu2P3Vja/AI2GKpkHKpqdnvObU
 9phBsPBykrfpoC9/xp9G/nTcWAUYE1l+59S+qA7SwRIOOWyCqTi9ou97+yu4vpVyNnRb
 CA/BCfcqpLn8cdlpf14ltkaafmkcZSv4FEur09hPT+e7EGtq5zq0yCzC7enky6tyq/1E
 yOdWFfJyUB2Bg+nyhTRrzoKKSNxNhx4bIp8Iov4OomAgxqaM5uIF8FbrnIzoQfulPkbO
 VFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392506; x=1794997306;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QtV+/YTJ4c5LiY71sMjL4OhEn1oiw9+wR7qA2hZBTE8=;
 b=fNQBGFyNI+KFs2UE1dpq0F0piYFdvri8hDnMQArHWKL/Q7lCPeUQqsOBPzmc9A0jrS
 qBOY4HE7nlhnUUC3y2vq3BNaabpOACk/MJqdnMZZJZ7SQW6qpVP7Zgim/1lC9C/lWbEy
 EPjIGhAO8Ll7rXqfPXWcBiYCxuPvx/yrU3xLkCs1ZnxwO6CYio2m5jwChnM86q0CI7MB
 pBkSU7AnQzmOLsY1oLiluoswfF61c0d2Nuzq5IELYX0gM4/6VwVZpWQjLG8scU9i1Jf/
 AfU3ql44+p3/OADSRVqB4xwdea/6TBxRqPGDTfgBruVgjCYx+tePALyDtnXa6Q/BrlbI
 u/Fw==
X-Gm-Message-State: APuU4Z9umU5shVXpS8bO8Ub/CMEGpl2aIOrjzYDZ++Q+swq/br+o5a9j
 jCRQ16ADvmD6VCFId0Y0aA9rv2GIFdmRNkuS9szVR3dn6C1Xk6sqRDHbYFiQYnojL0o=
X-Gm-Gg: AYBFou1d4fxSCS/eOeGlHvLoSPXQYqGjr1L0lAY3UMn+t/dppjmqVHwT4dVl84NEyJy
 GJ7hZCMoA4Pfuf3Ld/nPr+twUM9N1+Vqzf1KLxeLXw8SUrOLdOo+0c6wzYtpct7zkeZblX+UGFR
 Jv5llp6Y7lg+23XwXo1X7pxN8iRE+Vae4VHn2QL9B6YxArIf2FmmJYIafrA8QF/KSNfHG21Fam4
 SkjeSOvyiIulEBgdpwp5pYsk0iVhrSNnWmRriaOPe6FepfQ5FnAqca3G6TKc9dvnbWxnE04s1T7
 n75SHN4LxQqZJSGWMrOWOrqMlOhTzh6lq0ddtNQ2vjkoTRNZZ77RqRt2f2RJGX2Uw0yOiNPECBs
 +ossWRgWdgVkLqZZLNiK7+Yx7GnpWQWZ2S0ODChWWVB/vxSC+MAPLnXD5CRSv6cEz8Uy0UjGNcC
 IGYojp4M2SQ/rmm0LMcZpuUWyVybGBgIEydIiw6HNMXbNCstuP73D90Wgw7357EVW5MIRuQ8VEX
 J9hM42SfIJzwwALEI8+yUDa7lDO058G0I+Q4Dzo3WrBMHulQjlc+BoIg/4jfxPHC3F/2WBNHh3c
 psZY/p48XOz20Rzsu6dLX2YRlcbsi21o0sZ7V5BiFNOE9Tggaoc2Uu4GGFFdXOdgIliCg0VwEK3
 UaF5y6PopiR4xJqkoA4Ep+iFUqZxp15qVLO5dGS+CP9L9xw==
X-Received: by 2002:a05:600c:6308:b0:4a7:b304:253e with SMTP id
 5b1f17b1804b1-4ba09381867mr36872995e9.22.1794392506130; 
 Wed, 11 Nov 2026 02:21:46 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm10550001f8f.18.2026.11.11.02.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:21:45 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 11 Nov 2026 11:21:35 +0100
Subject: [PATCH 2/7] ufs: rpmb: stop the model string at its NUL terminator
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-genio720-ufs-rpmb-minimal-v1-2-701a62dfa034@baylibre.com>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Some UFS model descriptors contain trailing UTF-16 NULs. Converting them
to spaces changes the RPMB identity, whereas Linux stops at the first
NUL. OP-TEE then derives different keys for the same region in the two
boot stages. Stop at the terminator to preserve a common identity.

Fixes: 87094d8062bd ("ufs: derive the per-region RPMB CID and size for OP-TEE")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/ufs/ufs-rpmb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index 508eb74d976..8b61760f071 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -270,6 +270,8 @@ static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
 	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
 		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
 
+		if (!c)
+			break;
 		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
 	}
 	out[n] = '\0';

-- 
2.56.0

