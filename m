Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60940606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vQ6phbuZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DN/7k9rD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E3DD407B7;
	Mon, 26 Oct 2026 17:32:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tF8DcDWraIIZ; Mon, 26 Oct 2026 17:32:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65DCB407C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793035965;
	b=pfDaQYdSFwX49afJ6yCd/qR0WhbA/WG1wJvWgWKEVV/zG02maQe2UVlVJBuEVg5vhcev
	 hvTQe+TJidwYPRIcxV/h7HYz8mHJKpYUNeP1NTBWCEuayePn2YO4GoGDz+WFc2c72mr4J
	 e7GkeNdFwIgbGpE7nkKpHyBm/6vx5SRKKQVGeFy3Og4n/Z+9fDjCknwB0zPJ7WIvTODyP
	 BnmQsEebSXvc7PRc5zWZRt7UeTuvIa8UNWphSM9fyni+8EdL1HEvpA0bU7M+kqKsZ7zuK
	 WtT6+SFBumf4koa1M0CcXeTv5FGeFj81iFBLmEVZIQDFlUl1YxYfDTHtUx3tAM54xnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793035965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jCuGb2VpjXDloCdVrhBCpNcmpPo64J7RAQyh/JM6yO8=;
	b=aZZXuOxxUG2pEE5tnhGJUwVB1J2TZK60B0vlx9F8D7eEAhQQ/2AAMmnE5FsnLrtIB//t
	 iYqnmeX2OFNhwKWmpk6h7Zul7UX+YFjGha+MU+kSsGzBsipEt1t02t4u2eQM9EolSJcGT
	 CYhS8gRJJdgRNcQgZzZodb+zaQkK5OtksH+7yh2JqqlrQBYPllJVsj5brzW/GTQAcQU7N
	 HAFtJTc9/qJlJu6MJuwsS21fd5dLlgJXXGKmB6HL/ts7X98ry8ZreyAaV13lsVecbIBFw
	 CuWyjDUJDBM5h06ymiWPHMRo7qJM1bCvzrEusYlkyRa0RBUu+LQsbTTpaWlJpnAv7/g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793035965;
	bh=jCuGb2VpjXDloCdVrhBCpNcmpPo64J7RAQyh/JM6yO8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vQ6phbuZoME5185nTSAh4Srtg8lJo0C4ZKTvczou98+NzNfKEBrxTlWVZ0Qzp/9uK
	 uCuNYAq3C14QKb/YgMxUlBgZD9ypatE+i5CyEEbfQQ8w0KuYPAFTvQ9roOaLQnn0uq
	 EPl/EheUrgGJHCDqr75Pg1CWw1D/sWOzzCbVerIUbWh9FCa/TLQcjdPkradlWfD/FQ
	 5o96fPrGKpeqwlAbFtbacbHaLwF9fQfDxC73vEL7uYiPyd3FJWNoWQ8enik8xzGume
	 HDmlB7b8pND3+qCDq6ipLY/hV6sGX1lf4NCkSxy7o+mw2ojVmkKg31J4UwgS/kwOoW
	 wX5wZ+QV/wvyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65DCB407C0;
	Mon, 26 Oct 2026 17:32:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AFDC2F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 208B480E09
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:32:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0G6uUgcI2LDg for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:32:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 405E380CB0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793035962;
 b=NsWY7IdjYdZBl7o2c22Esv5XM9bHZpmWub0zBq75V6tjRwKxwnZEXR4iES/kJgoQbGjn
 SP7i720AjQJ5wP6bJsGMDaOuvIR165Ys0A7c53YZ/JVoBOPSVAEudhdqWvPoKJZzBaEz9
 q6sBc285xvOKE5gA3R91fk5twh1LS4q3UoJvws0w2CO935dgeOF8LwuGCewaSZEqmDqpm
 2elYyRyPMNzB+EU5vf3FcipidsaCUerWggcTVVrl22nASlcYtt/BXpxaNxrLoNENf2daK
 jUQhh2Vco23/jxO1+qBt7L/JqZK9BttaQd9DYYnrJwxCO8JatFu5M+l8aDYrOYayQ8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793035962;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=jCuGb2VpjXDloCdVrhBCpNcmpPo64J7RAQyh/JM6yO8=;
 b=RTlmIwEu1lR2Jnga93qW3MEGFxulBgL03EFSv5sOUTql3G83nJjTmMk7qq5tHaADBU29
 Db8Rbz+FHLThHIVSbxL4MDJtzeUkkwTMVmw5KdtvQr05Lr4Rx8bS2xt5xIZ46zWbcbMdS
 cWqpS2f3a9BapP7YPx0URmuAtx9Dc47T/achQ6bwwHjBcYf8MZAZYD8b61G9wQzmo0pyZ
 RThYzFlOuflXiTjPDPhiC5y3VOt6vbcAq2n+MgWz6OkeuohFiRo/6hErITUccTpvZeMAt
 mA93nmKUubeD52jhPKNR/ZCDXTcFWBJ5Y+zjWu7g28OQ8RlIk9BTGefAT/nOAr+patg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="DN/7k9rD"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=jernej.skrabec@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DN/7k9rD
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 405E380CB0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:32:41 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso21374675e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793035960; x=1793640760;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jCuGb2VpjXDloCdVrhBCpNcmpPo64J7RAQyh/JM6yO8=;
 b=DN/7k9rDeOdkVrJqOY3OiIhtZGs1tbgE1M4LTPHaWpehOrX8dS0e39xzX/6nGSmJdR
 DDTIV3G7ipBZxH2bot46Kkc9gqvmizEEBCTgZMteiZWg9klo4VKwvItNHTj+0pyWaMKO
 NaRvBiv0CyuZ0plysP9ZFBT//GLDWmC88aJfLKUBy79wgJUfImvA2PCLzMEZs1ymVnLC
 mLMthxf5VzvHDFriu9HPrbFNqUwy/xXosuGRiOHYZS+FkKYT00Kp9dxlapz/71qOIf3t
 v6itX2KyKYDqGodKEH3bq7wxFs4yUP0xaXuy45C8+/tZVlUkO5yTsggr3liz8cCyxKq4
 Xh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793035960; x=1793640760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jCuGb2VpjXDloCdVrhBCpNcmpPo64J7RAQyh/JM6yO8=;
 b=eBzvOzamHGonFG6gUjdtmZGQZjEO490QrgOB2IhYjMFyvYUK3TcSCU3aZfqeUGCuqd
 T0j1ydWViCJfCBVwfxcbyhpArKGDEdnUlJJpS1QZ6P2QIpT4LK8mqcQHHDFniSC31WAT
 TXB6jfyovPws0K23sFDUYnzhLvcZYAHPxhAe1XNVvoI0zaqAB2hFnGoypMHmKJL+cII1
 aooI3Q/QENNOgL6WfoPmnx5yWEaL2OtKusDCT6LMZQ87F0Usza0ye1RMr9CqGF3GylfE
 jKkeO7Odq2XIWz8AnQxGPca8U8dKqL441ntkwVIT0dooWaPFbVqJiyMdqospBsql64ig
 IUpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1FxiDW6c0O+8+XFc+0cByO0uhlhxaM0KIc7xelTLlFMsoeEPy37gdxRjeVmh4cVM2hJDMpuI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJa58mJTsiSOWa6uKACYP6TlTlwa2dxjH/pK1v/x6Bx5qntA/fp
 TvXr5VMocYIHR3/9uCCMLKvReb8OOUwLO38RbedcmksZtItukibBNRAo
X-Gm-Gg: AYBFou1TM35PnXNwv1PLLrN2w5sTDYwC/BPwQVYgSOiL/scLQ1Ffm3hnU4bhsWarKmK
 Rg1k+PSFGEgjLP2BS18pAvRnmUu6d4iLKvpFPMkdO2jnzkujJM9I5OvUBvnC5RZx5ahWRbB4SGa
 xNiYi6AqtP9/6Q4BKt5qwGiW/JwJIDw4LKnx4ZjfSoylhE5VN5v9506EqSdKaFe3asiHz3SK9tV
 jmqFp2rHMbMd1lANP1t64fkn6k5w2glZ87ehcHIHbfm3WbGG8jpXyU/qJuvtWyQE/ARl8K6pNYd
 jtR0nGTmL6aW1kXiDmvsJdR7NHsHaKfu+tZBD2e7uZX8ymsRSHnJSTPqtGnP+R+Xu57tHgsUGO8
 H2OMI84Wk1LZ0YQCMQkQVuGefCm49HacQ6ujLI8NbeErAdZJyZ+LNvCk6Aa772+6CUramdAB5PU
 ZsDJKL9Euh/vUNCR7m9mGr8dsSGVmDAa1IreIEQitGhApStLf/gClTMJPurb4S804D1r6Ua6IFq
 tM4zXeCXYuAyd7/VkcgCyFEbdXZY+XH7pdmy0rn+mi0HzpQbIs3tTBVf3lrIdmjOTrybVGCEKAN
 +ETquZ6w+O0fEYrRZfxJfb7sJbtSqnHY6MfQxvocP6FOgeuRhfbnixOYH4rrIlLq+XRcaDpyZRc
 ktn1aGsld1xtLVAEL3UMGCA3ViL9Dgk+IKHHzY7hJ3tz0Ri75k7mVvC/pGkt1bz2fSWLjwrCtzN
 3zU6UZS5z7sklrxBxlAUYrwbHL3Lx03l7hqqUskU0SPE7QofDK0zdYRrcHOT8aCQ==
X-Received: by 2002:a05:600c:4e0e:b0:4a2:397:73f6 with SMTP id
 5b1f17b1804b1-4a35ac9d227mr139633405e9.8.1793035959473; 
 Mon, 26 Oct 2026 10:32:39 -0700 (PDT)
Received: from jernej-laptop (77-38-7-31.dynamic.telemach.net. [77.38.7.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa0bcsm261433605e9.4.2026.10.26.10.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:32:38 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: andre.przywara@arm.com
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] sunxi: dram: only probe DRAM inside the addressable range
Date: Mon, 26 Oct 2026 18:32:35 +0100
Message-ID: <20261026173235.95831-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.0
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The non-power-of-2 size check probes the memory cell at 3/4 of the
detected size. On SoCs whose DRAM window is smaller than the detected
size, like H6 with 4 GiB chips and a 3 GiB window, that address lies
outside the window and the access hangs the SPL. Such boards cannot be
odd-sized anyway, since the usable size is capped to the window later,
so only run the check when the probed address is addressable.

Fixes: c47b63673736 ("sunxi: dram: detect non-power-of-2 sized DRAM chips")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/mach-sunxi/dram_dw_helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c b/arch/arm/mach-sunxi/dram_dw_helpers.c
index d2af2d57fded..ae13dd154536 100644
--- a/arch/arm/mach-sunxi/dram_dw_helpers.c
+++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
@@ -155,7 +155,8 @@ unsigned long mctl_calc_size(const struct dram_config *config)
 	 * or 3GB. They are detected as the larger power-of-2 (2GB and 4GB),
 	 * so test the last quarter for being able to store values.
 	 */
-	if (!mctl_check_memory(CFG_SYS_SDRAM_BASE + size / 4 * 3)) {
+	if (size / 4 * 3 < CONFIG_SUNXI_DRAM_MAX_SIZE &&
+	    !mctl_check_memory(CFG_SYS_SDRAM_BASE + size / 4 * 3)) {
 		if (mctl_check_memory(CFG_SYS_SDRAM_BASE + size / 4 * 3 - 64)) {
 			size = (size / 4) * 3;
 			debug("capping memory at %ld MB\n", size >> 20);
-- 
2.56.0

