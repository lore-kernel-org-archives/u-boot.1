Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mtq0AlAe;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PojQDhKz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FA9040661;
	Wed, 28 Oct 2026 14:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gFdtJ5CXGhko; Wed, 28 Oct 2026 14:47:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E7A340744
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198840;
	b=ghKee0NtxaZs4mfEqdCOg9gP/LQ+4Q87f2YBDruO3GQIbk3E/cGwb/IIk8QvKC6H/zlx
	 /SxJx4iYPNpvOAwTftkKaTMneFGsQC9dfOdm3xlrusfqKt6SaRmJSbdXaeiqNlCGATFaJ
	 W2lZPdBWKaP554jbz9HpYPHZX9eZXb8/pgriHm7ogf/UOV/VfqHhOTq0AbO76J4e/bfTw
	 EfTS8jM/qcTQmYRYeCu9whdqMi99uMEuhd20fXQXa7uhWXzfbODmlCqvg7hpaDtzxOT7R
	 pS+DvzkzUBBFDB7bT0lmuYFsy/pcwimleYmIvPBcW/9IEmCtcJ645ezJbKYBOLujXhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198840;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
	b=VHgOZ4GcNt4jY3+rhdi3+n81JV/CVZ0kazCOVm5rkvpFWy6wiYfJF3QjB31qcNMt3mjy
	 4HJmA4MojFGBC/Afs6pcMlxAnObJg74Hg+bFTSq2GHuVNQbKKZYF4BXYahuX8q4gY7lRp
	 GbZB/P71vG0JMOYEKG/QnSfkFl5+oK0gPbig6eVYURaQbeJZzNqYx8NakmUK8mDui97Ky
	 prDbu68oHpUV8xy4l7Tgk6DKz1QlUr24UjGoTtpqrbF8ukru2aqAgmPIaaYbPdPWmDpun
	 kUH/jP1GKRpDKdKC4RbAh2WJ83CdElWd4uIBoFheOZkzXhh+KTaegQ3QTW+7e04PUDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198840;
	bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mtq0AlAeuYh2G/M2LdJMgjYYe6DfNIG6S2EdpRSDyV53VAVPrab30xrl8qvY/PHxx
	 MdQ8LShlBwT4LYVzPzTKPMW76gCjZU8nCUWwq2YX4e5W0SSjCTTIR4TIOR5+83buFj
	 iQSslvAOsMSmFAXGZBQ6f6I1rMSVHsyJiBupkOLPtv3w0k92lPEyxi+OKZ59YunXVR
	 IiUdLmFoA1fidxJLimmhxfrVUSUaYZO1un+WUFmFkt4ZlMNlrs592sRW48Vo1ezjrN
	 s23d3z1HFLygoYfDPn1Xdmp8QklktmGFAGHPGjUI/TXFFcae+SSbKwruHgsQVxEMqO
	 iW9ysIxfg8XLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E7A340744;
	Wed, 28 Oct 2026 14:47:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BACF4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2DA4680C76
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OuWnWIVb4ZKF for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:13:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2779480BDB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196800;
 b=FC3MSJYV15mZha4oK2ng/5ZcM4qfkguF+Bzd06Z4v8Oxk52yNRjMeBgITyAc8vtkmcbs
 B+NQf3TBoOZG2icfe8HamDaQGcfQdq9mCja3Be7HKjujWWkPnjIVCKrG+HF/tI9f7Ip/F
 YdjmevfQyOkXPDZ4w3uzvX7ZpC2urTt43oaru/VlAibCJr4jOyFsd4wK1G6bMXYec4uDC
 RLLDMeEqCw+m56j3cGsFn8SXBDar1pGzVdcvJvFgfRxgr+dDiVLGgRiroHwUsWSP8vu3A
 Dy80HBO/0tc+gg4OyJEyhrjfSez15/jIbnc1E0nAWRLpYgw0Gqv7HeHckKdu4oJCDMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196800;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
 b=fgQJ0fimQFYxDAdkqZ+jzD0+sZu+9cdv8SVZmJT+1eViJYk6ZzM12DcjgXh/NN306OaO
 VsxNJPf0D0++SmvDS0nqdYLiEK+fphbWLJR3TbePPd4bYi++MB6v8wpArwEi3aJ+BU+b8
 1W1hs+m0ntPuA0SpwiIYaJBJb96RoJGLlmm0jLCQUQYAL3W/CyoQzv7JkZhD433SnxmGk
 KOsJggAS9Bzc0WK4Ztt9QFMBo67Nud4c++y+Ha0+wMypxZe3XVRPp1GWg1hVXX6hFVsao
 n8eM1/x49iwyf1GLbgBSR+zRbeaxeIfgm1FYsYco75y7KQ+bCThfSXGAPRxEfY7ZKPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PojQDhKz; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=PojQDhKz
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2779480BDB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:19 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c41d20c016fso10189966b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196798; x=1793801598;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
 b=PojQDhKzQcBi/5jgdbb3ca5xTvKKr6oGmWxZbmo2smIKCzbUuO91YlWe/SRpDI1Dex
 5YyOgOK9XMVqQMD+a+tKgVZyZatI0cPE6DpzLCha9WvPYuXmFqlSDyizZK5j5nyYTEDQ
 JoMxql2rDbuBAm8zUGSxeEaEoBewRXFjnchs7/ZiWGHF9wsWvMvNbMaZOexZ2y9ty0Xe
 wzX0mc71rv+WkDbApCItkqejCpTKJEilqrycbmxmLmIsVpjeNEuoIzg32eCiCt6CEbhH
 IwR8+pHD0Lp/Vw3AryB62/nFcR7k3y4z6FgAAVA/2nigCXe4iwVbhLgIMzt/bh9R2EZb
 f+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196798; x=1793801598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n13yg3LQ2s0DO5i6rScTOqPsAcWYpifeDqKsAJOiafg=;
 b=VAUYhfk8IGY2GGQboGGFrxN0TAvxC5Cl8XarTEsXjCqCetp9aLp0lRc2wtIXatKCIQ
 vrqMOhEXZUZo39NMmjNSL6A5zT87d+sAQfxfC4NyBYDLl4XipPnUOa3SC5QjMrpZupXy
 Zf/77Mbdo9RPnwW8eMfkjh3/tV+0EMUBYeXp42HuNHGu2J/eelK507u7AaxYeycBmAi3
 TfsCWF0hj8qOWvPYwo2Pd/TV+uv2or/pP5XkUjHwuZ/KHUKRswgQjk/pZq0grMlYbm6A
 9A3oAw5FCd2ZZZBBYY8nQONKBCQKOru+O0K/XKuzMkQGrttE3F940Fcvb5MkY6hJu4IY
 pLXQ==
X-Gm-Message-State: AFq9FYL4XiKhQ/pb3N6mV06VAJ+ddTWNCTZztq0V2JU9gmn8U4D9BRZk
 lVuvK2VEPEJJ+WgMZi9WDUK+4BFme2+8NPlxtTsKwRj7H5EtnMBjFN9oVxqNL3GaQ3IMn8tko6B
 eC7l0
X-Gm-Gg: AYBFou1BFNFm9xgGQgkx/BSMXhWw3iCa+INaH9coTuwp0j+LGkhMjd14asxhGee/3LV
 OIPqUBu6meOWCbii/12kRS9m/DuvlCpQ9ZTd3BB/iBJpdplgITj6dPvtlHn98WQrfRPEoNcK7SQ
 XxjZjjAv35Og3cRxXdUmWxRx0x+1hu7AZ5iJI2iGJXvviesKMflYxO7onw1sEVG8dhk7Hw/c1OH
 ghtO3QAc31mTGMCzI8D3nQEpXYIHDQNX5r2Vd9tHxft2EWxGEauLBbtt1N2R1jZTS18GEyj1i+3
 kCjK+mMgyv3ktIaeqgzyrxDJjPX1qpVjMoitNr0DaAKFNuBV5G8qsJxYNAVZCDahDtj0osMzZjt
 EfTyTJV7CGwDQ7Vig0qjHpKkQNPwkMn5VzR0lvBJEyvxMxaLo5yqBZTzqbdLsPwK7zFk61k26c7
 Wxtw2IeViUGZjmxE/qr88nonqlENVWksqBe9eqwo/FyzvKKPzyCyWUrkRqU4t0NEfgAXt0Boo77
 i3sam6Ix8IgaDijN2lxM3excLNDWnuqOJTUI7J4BDZW+rJpzw/9UpPTdg06Fd0T9krlBCYeX7c9
 OAB0f2i59KBz7TfPVu8XGPU4VIrcNf7VwfGGs97z/2bRwM9j6v34fdy8YxNjWXhgIBRB0FU9HW/
 ChP5lag1e7P9g6CYHYcSm9XIAQgAG9Go=
X-Received: by 2002:a17:907:d645:b0:c34:db91:aa1e with SMTP id
 a640c23a62f3a-c49bdfbbe19mr310105666b.4.1793196797833; 
 Wed, 28 Oct 2026 07:13:17 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd350c61sm612006966b.11.2026.10.28.07.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:13:17 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 47/63] usb: dwc3: import from kernel v6.2
Date: Wed, 28 Oct 2026 15:09:13 +0100
Message-ID: <20261028140930.3025368-48-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v6.1 to v6.2.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v6.1..v6.2
Commits imported:
c4e3ef568539 usb: dwc3: gadget: Ignore End Transfer delay on teardown
63130462c919 usb: dwc3: core: defer probe on ulpi_read_id timeout
62c73bfea048 usb: dwc3: Fix race between dwc3_set_mode and __dwc3_set_mode
049142335613 usb: dwc3: gadget: Reduce TRB IOC settings

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 23 ++++++++++++++++-------
 drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++---
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1f348bc867c2..476b63618511 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -122,21 +122,25 @@ static void __dwc3_set_mode(struct work_struct *work)
 	unsigned long flags;
 	int ret;
 	u32 reg;
+	u32 desired_dr_role;
 
 	mutex_lock(&dwc->mutex);
+	spin_lock_irqsave(&dwc->lock, flags);
+	desired_dr_role = dwc->desired_dr_role;
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	pm_runtime_get_sync(dwc->dev);
 
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
 		dwc3_otg_update(dwc, 0);
 
-	if (!dwc->desired_dr_role)
+	if (!desired_dr_role)
 		goto out;
 
-	if (dwc->desired_dr_role == dwc->current_dr_role)
+	if (desired_dr_role == dwc->current_dr_role)
 		goto out;
 
-	if (dwc->desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
+	if (desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
 		goto out;
 
 	switch (dwc->current_dr_role) {
@@ -164,7 +168,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 	 */
 	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
 			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
-			dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
+			desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 		reg |= DWC3_GCTL_CORESOFTRESET;
 		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -184,11 +188,11 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
+	dwc3_set_prtcap(dwc, desired_dr_role);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	switch (dwc->desired_dr_role) {
+	switch (desired_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
 		ret = dwc3_host_init(dwc);
 		if (ret) {
@@ -1096,8 +1100,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	if (!dwc->ulpi_ready) {
 		ret = dwc3_core_ulpi_init(dwc);
-		if (ret)
+		if (ret) {
+			if (ret == -ETIMEDOUT) {
+				dwc3_core_soft_reset(dwc);
+				ret = -EPROBE_DEFER;
+			}
 			goto err0;
+		}
 		dwc->ulpi_ready = true;
 	}
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6d524fa76443..89dcfac01235 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1464,8 +1464,18 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 			 */
 			if (num_trbs_left == 1 || (needs_extra_trb &&
 					num_trbs_left <= 2 &&
-					sg_dma_len(sg_next(s)) >= length))
-				must_interrupt = true;
+					sg_dma_len(sg_next(s)) >= length)) {
+				struct dwc3_request *r;
+
+				/* Check if previous requests already set IOC */
+				list_for_each_entry(r, &dep->started_list, list) {
+					if (r != req && !r->request.no_interrupt)
+						break;
+
+					if (r == req)
+						must_interrupt = true;
+				}
+			}
 
 			dwc3_prepare_one_trb(dep, req, trb_length, 1, i, false,
 					must_interrupt);
@@ -1717,6 +1727,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	else if (!ret)
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 
+	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
 }
 
@@ -3722,8 +3733,10 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
 		return;
 
+	if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
+		return;
+
 	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
-	    (dep->flags & DWC3_EP_DELAY_STOP) ||
 	    (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
 		return;
 
-- 
2.53.0

