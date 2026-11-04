Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600B6070998
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SLNUrpjM;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LhRuJOHC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2EC3811A0;
	Wed,  4 Nov 2026 21:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OEdg9nKAmKbv; Wed,  4 Nov 2026 21:52:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D0E94811E9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793829167;
	b=CX/hCRUIxBuRiTAc1HUeCDiBqoRS0ne8FZqjQzOgV9A4eWzkeUm4beIMIA9177vP5+DH
	 Lap6+hVHP0T5Po96UjoQ8KPPTA+l7Mhrr11pOaOoMZQXo5x/2JW1/5HtQSdQx6BoOIeU4
	 u8p8NeU1oFUw7f7HSLXHDkxpO/KQ3ztIAgOz+so+lh0aEw6EgyKHgiRkHlb/FXMn0xOiA
	 d4c7eq2NGUP0ZexCIOaW9Zu5gpwxoEtZsq0lG7HkIh5vxGyfkL5jr72OpAw2LvC/s98ws
	 ERIR/C7hmOitQ1+SfLWUYGRED2uQ4J6Me2Uiut/TJs0EBpcQLOVryNFsVNgzfPZ5k/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793829167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6P1oeycL3stW5W0zP/opSlpcgErz3X+rqrqpyv1l1fs=;
	b=b9lStyZLJnveWA0OPzRRjzM6j+wxNdjTpyGypkI28ADysoFIbxaVRW6zSV1F3aW3Rjlc
	 2HR0qFOmvkYl2YpAXbivESW2v8kBizqAX2HFhAn3KPrL8Vphy3Ct66xtdHzniDARxTVYl
	 HVamVoknAk90NeRC2xgOb38RXY32/3TakkcnqT5oMqmLwbtPo3H2WOrhqLwVpRjwLqn8O
	 Te294eAWjt2KHhuSB4K+z9A5tdrNUkV+YBZQ0xVHRqBJi4Ss7Av+ZtcYMh2s17302dzJ+
	 sdcFZF/9jZyDICCL6RvARScGGoQwt+AfpcahUmgoncSLhSVlwoLzTJD4whykopS4MxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LhRuJOHC;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793829167;
	bh=6P1oeycL3stW5W0zP/opSlpcgErz3X+rqrqpyv1l1fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SLNUrpjM38Saf+oTjiqTo0VgBoi1+rWkqgZN5Fo2SpMDOoKq3jOjLwZWgqmt8RNmY
	 DGQeNgtwIxC8f7y1DqHqkQmqKDZzZrYKrqI4oQxTQ+JFljKtzUoghPAMvkTwMM7zWD
	 V+VFZUbj54Rh2lFtp79BOAK5j4r38MXBgcCLsKrYTxuOGMjwCdFq9UggElBxx4reSf
	 4wP34ZxLMqbWBE7GFF/jNPkiCJxtMa+wVpRVsKe+hNxswqmAScmUjJUneqMIDP5hW7
	 gmRpRYKZWUTAQ8TrM3enej0ZIMKLPUu63bdAUMxcbneMXwxP2Q/3tfTqcpL0MrI5+P
	 L0rmxGBVkYdjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0E94811E9;
	Wed,  4 Nov 2026 21:52:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8023C362
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65BCC811E1
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nP8Vs9RlLyly for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 21:52:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C6A7811AC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LhRuJOHC
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C6A7811AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:42 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-702dedeb70dso706896eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 13:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793829161; x=1794433961;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6P1oeycL3stW5W0zP/opSlpcgErz3X+rqrqpyv1l1fs=;
 b=LhRuJOHCrWXMS5hDgw7UiqevEVM+8LXV0YrHM2nuAYhK1fvyH93bcSX7lAGRP3n9lq
 DGWRPl4RtI9tixMtVRIim89vrtPN6k5tLV9EouUhGW+bASowjCJqTQ3EVD8OI0VyUBHL
 TDy1a22YMIYXOl9/jSzgleRNbeEO/ikR88xLL3Fb17CCO/2G23BmtOIrA7G1tL+DDmPC
 EMU8kUCHow43Doa7R0mxcyGxscsAuLruVuXn4EI0BqEPPQa6AfU8ugHu+ZK3lmrg2mk+
 tLj448+Rab5NKwMi0TdOeMcw8pDko6YfxCv/zcNBrTCcz1r/jwB2N+0f2fPyGQf7Lcb8
 37iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793829161; x=1794433961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6P1oeycL3stW5W0zP/opSlpcgErz3X+rqrqpyv1l1fs=;
 b=bzMYzUakn6cMyPssVXLREhdxb885Fo6ZyU/CbyrQX3m/uc5+JNAP4pd37ghlosF7up
 GEgD3DbyuAhc37mYIYNSmTNnJ21SVMqljVv+5MgZeB8q8+TcVmLiQV4UI/nRGC8TVGlA
 m2ZaiA3AKHFKSCiX1qHwaw/hCuO79YjrzdMVBDYlc/S0+L+7DaVIdgs5krHoEJX4bMx5
 ZFMov+GHgIadj+iTWAdaktdtE42mb/ls8lG3CM+jC0JCgxLcGN01QaidiFgWRTKtsBeg
 njkVIz5Sy7rhEecmiUljCS8BJOOBD2tdkdSlC3+s4Ok6u3hyxJAPUbLeS0Y02X9EgaEM
 Uy0g==
X-Gm-Message-State: APuU4Z8jDqe7z1RPatOFs8J2L6/70BzD0N949VcgrdpNphX90X9c1Qol
 FVJ94viVNzQClYocAtt/2f4HpUp8ZLGxhQf/s1NAdrY1TFwhMkcQqlam10zlk9EMz9I=
X-Gm-Gg: AYBFou1or+fDtLYpZGzmOuBpelC0zu7CmwbdtSIwSFrU2xVluCffhGPAuQpFddVNM8l
 8NSoEFmIDJUkhHRookb01dUFUTqk/cFDlc/dTUk1qScg4e9Rc+rI7dayCj1Q8kf67BE268Pugwv
 lMqTlS5yk/L8m1yRqUt3cNcn8Z8MpvjZqHs9P1uqM5JtfoYmJeRF/0LVKfmRSFad+6FeWfHPVOk
 lqF7V64p7dc7dxBhhs1mXQ8UmiM8wq1818itDHZC91S0gIWZiamrwTwSQbVbhSo0wTQxhrKGGd9
 BCFELCZaM/iyS5HQb1uDgK0cT/Z9D3VnWZMId5AaNuKJDaEpr60nHLaAn/s6sYMl9FdSmdwIm4h
 o5MqjuN79ydXQoJaYiONwqALf4pqwQ9N9VINgQqdgjbAWrYISKit7Y2VazJ4n2em8INrcWDX4On
 xJUocDHnMYzq8xP0R5+hS7JDGYaqXP64akUYep24/P4zR0qhnEIqOMYjl94Ai1xwC5FnaD+VD+t
 AU3WkV/QSbP2bE+qNjdXGl3zfEFH9lkIYWMK4KcCp/rcMe2JCjSbTEjbFpANfc0ZIepIlDXNmI0
 EzX/3Td9Me3n5QlFyM5s5wmQNnQKJtA5
X-Received: by 2002:a05:6820:a659:20b0:6f7:fc58:b7a5 with SMTP id
 006d021491bc7-714f27e6a18mr7185279eaf.85.1793829161079; 
 Wed, 04 Nov 2026 13:52:41 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12d1f36sm2479415eaf.8.2026.11.04.13.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:52:39 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 04 Nov 2026 15:51:56 -0600
Subject: [PATCH v2 3/4] spl: optionally pass the bloblist to the next phase
 in registers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-spl-bloblist-pass-regs-v2-3-3126de1b77e9@baylibre.com>
References: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
In-Reply-To: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3789; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=mwu/HmNVau2MCshxaL34cMRFWLoq6wrxhZwuvOMYy70=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq66kRQ274CJA2SgnyxCKy85oYg0CXodwP52WxD
 p3hoC/MAXKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauupERYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABs8H/13wvzJQ3lXi/dOs6OyBn4Me99pYxMsAoB1J/xM
 X5g75YKxdYRVqE7yibhhgr8Cm0JQFliLJZSHuz7B9sBYQP1KK6G7+xjYyzzQC66qpO9an0Kp8GV
 lUlfKQ+qSziJ51pUNXMI2/niW3MXZSGgq0HlLMFokemyPj4O0CleJqpzsRXhFrjcRrYAmQ/CrPN
 N+Bt8biY+lB+3pmI1y6POJVPHkS3+KReCxkRzN6b9Txfyda2C4hJ1tSkDYk8NXXqCaO1qjcHB3T
 JNQuxUe8eOiD4LZkKcPHV3IrTw0aoXd/wiwmgz6ry0wRCPw03MImn+IVSow6E5C5vd3SpHOu5xU
 BUDI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add SPL_BLOBLIST_PASS_REGS to pass the bloblist to the next phase in
registers, with the register conventions of the Firmware Handoff spec.
SPL works out the register values once, right after finishing the
bloblist, and keeps them in struct spl_image_info. The default
jump_to_image() starts the next phase with them. Without the option, or
if there is no bloblist to pass, the next phase is started without
arguments as before.

U-Boot proper already looks for a bloblist in its boot registers, but
SPL never puts one there, so the only way to hand the SPL bloblist on is
a fixed address in memory that every phase has to agree on. Memory at a
fixed address can also still hold a bloblist from an earlier boot, for
example after a warm reset. Passing it in registers ties it to the
current boot.

Architectures and boards that provide their own jump_to_image() are not
changed, but can use the same register values.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/Kconfig   | 13 +++++++++++++
 common/spl/spl.c | 21 ++++++++++++++++++++-
 include/spl.h    |  3 +++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/common/Kconfig b/common/Kconfig
index 92bf31f038b..4180755525d 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1234,6 +1234,19 @@ config SPL_BLOBLIST_ALLOC
 
 endchoice
 
+config SPL_BLOBLIST_PASS_REGS
+	bool "Pass the bloblist to the next phase in registers"
+	depends on ARM
+	help
+	  Pass the bloblist to the next phase, normally U-Boot proper, in
+	  registers with the register conventions of the Firmware Handoff
+	  specification. The next phase then finds the bloblist without relying
+	  on a fixed address in memory.
+
+	  SPL works out the register values in struct spl_image_info. The
+	  default jump_to_image() uses them, other implementations need to do
+	  the same.
+
 endif # SPL_BLOBLIST
 
 if TPL_BLOBLIST
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6c9a1a1cbcc..6d81984428c 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -401,12 +401,23 @@ int spl_load(struct spl_image_info *spl_image,
 
 __weak void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
+	typedef void __noreturn (*image_entry_args_t)(ulong, ulong, ulong, ulong);
 	typedef void __noreturn (*image_entry_noargs_t)(void);
 
+	debug("image entry point: 0x%lx\n", spl_image->entry_point);
+
+	if (CONFIG_IS_ENABLED(BLOBLIST_PASS_REGS) &&
+	    spl_image->bloblist_args_valid) {
+		const ulong *args = spl_image->bloblist_args;
+		image_entry_args_t image_entry_args =
+			(image_entry_args_t)spl_image->entry_point;
+
+		image_entry_args(args[0], args[1], args[2], args[3]);
+	}
+
 	image_entry_noargs_t image_entry =
 		(image_entry_noargs_t)spl_image->entry_point;
 
-	debug("image entry point: 0x%lx\n", spl_image->entry_point);
 	image_entry();
 }
 
@@ -846,6 +857,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			printf("Warning: Failed to finish bloblist (ret=%d)\n",
 			       ret);
 	}
+	if (CONFIG_IS_ENABLED(BLOBLIST_PASS_REGS)) {
+		ret = xferlist_to_boot_arg(spl_image.bloblist_args);
+		if (ret)
+			printf("Warning: Failed to pass bloblist (ret=%d)\n",
+			       ret);
+		else
+			spl_image.bloblist_args_valid = true;
+	}
 
 	spl_board_prepare_for_boot();
 
diff --git a/include/spl.h b/include/spl.h
index 390d18fd9d5..2b8a2f02835 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -298,6 +298,9 @@ struct spl_image_info {
 	ulong fdt_size;
 	u32 flags;
 	void *arg;
+	/* Register values to pass a bloblist to the next phase, if valid */
+	ulong bloblist_args[4];
+	bool bloblist_args_valid;
 #ifdef CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK
 	ulong dcrc_data;
 	ulong dcrc_length;

-- 
2.53.0

