Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933B4606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g+0y/fFF;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ED1gEdTK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58E2280DE6;
	Mon, 26 Oct 2026 12:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ETL-4r1EIinR; Mon, 26 Oct 2026 12:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2976680C7E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793017146;
	b=iTXNIVuc4ey/D5RnmcWkQrmKZwDu3yKWVqOdGazMWxjaYTNGxiGDCGITG54na2qXjwgk
	 upPsCeVz4FcECHpWGWMX5IDluKSg/mwdGAcWe/loK92QPe0QRgGgfMFaBJQEkc5TYADkU
	 cS2sgC2A8sYAxJJUi5vy243mLIWSHcZi/+TAU0G9NWB/wJyL7Vnaq/luNbUUmPbM3XgNe
	 BZ4Umi3U79vXRTlypy5WOyPkbGsdFpbfX0UaG56Q+ItQOH60OgD24wnKCspPS44ZUjbB+
	 df192TUsYAjur23Yq5lwm1mqg2J1Q4WJFKFuZlH7nsGhCdklrUa0iiZmA4Txof2swLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793017146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YNUW9/Yv5oUgtU2bhkwSq+JjxYqJyKvDFMVCKralZGg=;
	b=XY+AOjMauSmmcxdJea7p2+oSTM9ZvhaCq+VNw/bafsT/XxqhQRtY+h40IT7RKi0ehl/z
	 B9OB1OIfebv/wGfmhcarBIEvmOaG/aOQa5I4+3qd8dPiYHGVVvisK0U5mSTe8Pd4EbmxY
	 9UqtShZZsc0xP1uth3NziuKp1puSAdNxF240RBrlhfBOIvh5hFrqbwjtTikQl5FKAueE+
	 o3V2QvaOHWFHGsVdQBzgolCU+AKcynMS1KonTjOHKMze40a519ozHv9eRjaH9uo6FWlBX
	 RBkOTQsItKeIPEtUfsMnDVok02rzIghm43PFK16Owy+MgX1xJ+cuoB8o0wxVv2f9QdA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ED1gEdTK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793017146;
	bh=YNUW9/Yv5oUgtU2bhkwSq+JjxYqJyKvDFMVCKralZGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g+0y/fFFRyZGFxiLVXsrfWYLEUs4PUUFvjQUK/LeN+0bLBxj1twVkdJ7aqkCSOGAD
	 UAhy1Fft/RUI7DsqnsE3H4J4EyVix3y3jLNKXHZ4nEP79uanD/gz2thg7NaaUtBvHd
	 jrrJ6zPPFB1ue05O9D0qJQyo0MnvAa2MIkUmoSB580Z7jq8djVY65S9hytOiBAu5Fl
	 1KCS8FXzRLoxM/3D6gTjiyofbD6q+pK9umMDbpYfV67JafHwxaE3QUf/XSUJR9aZ0U
	 fx2aC3y0nlDn5XJLPOayB5QkJdkksY2e9fTCAC5mgOdN2MdZPaopOhcxK3CaY1m+OD
	 TgVM73xKtbfwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2976680C7E;
	Mon, 26 Oct 2026 12:19:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B67A73D9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABAD380D02
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uz6Bufl7Bne5 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 63A6180C7E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793017143;
 b=Nv322xwPjAq4b6J3A51ow4Jj05VKMkfwouVZkK9KnNgqQhdgDuCZa01CIBDvBG5+Sr2M
 2PqwD/YrxotUrWMn/JZeX6/2IwSfEBtID/T20TS4GKFm/tMI57OAcLt1trlK7S5pGBBCB
 Lq3Qpa/RJBdrg3tAiZS2+lmUqC0U668fN5JbgH7tN/Hb9HF+lsOSdwM4/V9H0Lk+ZsCyC
 8vwn1U6VGEiZdVQBNSZZwszvfCfgh2wZJHU1xg014qe0Q8FuCfk9V4gIms+9SpItjEevM
 eQjej3Mhs9EhLAZzd1dI3r8XxLhqOPPz0WDnn28z12HOCreWvLhAe9cUvGC7I//jTgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793017143;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=YNUW9/Yv5oUgtU2bhkwSq+JjxYqJyKvDFMVCKralZGg=;
 b=syASc8Fpr8USQcqUb6Hv7/APAps87Kt1X9NyQC9aY8ukgT8/3LvdfreiPTDEkxOmG3yR
 MW4UTTDJQCBMzKy9N0TiB0/kbQjHsnhzQj9aCrz7uXoP+K+23Wj9qm8LdboUaqhW416n2
 LfI3GNiI01YzMYYi1YkyVHOqCTqOCxDaXnXf5daj4h9PfAgucD0LAtzochHjLm1w6pbTP
 U/n5wHIY3pY6x/KIxaszFWyBVvXJZIXV+RYg53IIA6fJXPplnWPPkOG+dzm3kpK8Qy+rU
 C6bW3sOtrUEM8BTUvxeRN4HCOF+kfDSsMFtRrtKbXdZXxoXp1kDWpK8MIH8JU10OuOg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ED1gEdTK; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ED1gEdTK
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63A6180C7E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:19:02 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b21cf1a580so3570903a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793017141; x=1793621941;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YNUW9/Yv5oUgtU2bhkwSq+JjxYqJyKvDFMVCKralZGg=;
 b=ED1gEdTKOvTSwe3ftAbrqYhGvcH8lkHcBIqs25fnSLcxntE0yR8ab+4J/ThlLylScL
 eqHH99HNrsWonbtBRTtuE4en9cmYmETNT+1FKdNWXRnVR16/QDYhyJ0h0UDukTvNteZA
 yButozeOusK3p8rP+SaCrX/mrUxkb8Ljb2uWt6JMd1th4A17tvVcWHurOwYReMi1awvj
 hYZ6eQua1aUdTFrBGIikNoyMHaGI8/vbMHkW7i6SWp0QDIE9oxyHYjhzEOzNyyxggv2y
 ZNtOid2UPPvTmxSYZay3NaBb/ZuxtiakNdyGKQ7Li/WHBayat6Reu0YN1HrFlfK7L9Pd
 RWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793017141; x=1793621941;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YNUW9/Yv5oUgtU2bhkwSq+JjxYqJyKvDFMVCKralZGg=;
 b=onPtnnjxLNaZI6p4tqcben1Dw3CNM6ZdFPJapILt0kiLm7H+uNaLyrzoQvTxZ80lZJ
 iyKG+PM8AmOXu+EoAe81/sQCJlICuzmjE1AqpkwDy30nAVXQLZ5Jwm51YyDCos/A2/dQ
 Tv5Fm59XsSDW4TTi7uOmo3f8FjuG55Rri/3cpX1qLA3FNGorKAX2nioyfB2YUou/F/vG
 PFfBSGmiqDNyzszh7Db7l6Cw/6EHHa/f2DGNXuknffjIef2qZCs+7L7T+CCJ27Mlnz+h
 5MBK44sJOm7TVJzfLAbWE4zTaTB6AHgL26IRoC+ZyQWU3qT997PMS0lXPGoYf4bh04Ff
 F79Q==
X-Gm-Message-State: AFq9FYKksJjjrCbFfuZ5Od8M/sAVw/IPrjy7mbnttIkDvtmN/lENs19C
 WdAuJqrRG+RGQQ6JCoeTfXoSnjuIFLw8jUwdNDo5VN9NJp1IhCgg4LScYrOpLa1dF6g=
X-Gm-Gg: AYBFou1e2KpFFEcoHT91EniamWqo4ZiSNeC5cEaTVvwvkzO+6dpiUjNzjngF2iuN3rH
 nAhUFl1hMwtbdJWgoBj170V4nVNW54i7LWXDjKANuOGZ95vUiFG2RkaAD/tdfZrmZwbWTzj1bL/
 XP3ZAZDNBfeXHbyu8clD7uinmgNl6sc1oJ0UeK6rgVQJXKsPpg4a4flRQWkvZEHSRzPS/gAFhYM
 MsyA+9w5bJW0fZjJmbhrdhots/bIUK6tVHEgTHVz557Gp+ELvQFq7PF6TUmb5NGPtlLpM+VLsLr
 eIgJOzVn+VJgNqjBYOkXRaYEmkOL9FpWpJ7PxqKgY+wHkTqp0U9VEMu2exWANh/4tnkCfB56hQj
 XATAGe/8fsAqcT2/oIw3Fv6RtwMZ9IfV5c6ZY8SvZX8xfOuNIL77EBTk2M5OF2nckjtE6P1pZrB
 EH1o3k0ggssyhf/xn79CI01jLsYsqsFnsrhPL7W52/d9hIH2Uv3Nzo74j49+ZimpAC9cUTa7/18
 glTSXW+vYsyXfubpJJ88uQCslRNd+6+D0cm2wCb/SlArlKo3o+4t32kL/Dr4D3TgREQYPZeIxx8
 GtzpFWkqejWgHTzG+YqWCgf3txs2j4eTQIZHXVCgfUx49UA70L9s7zlljeAIrijJhr9SntjW
X-Received: by 2002:a05:6402:4412:b0:6b4:20bc:fa7 with SMTP id
 4fb4d7f45d1cf-6b4431383femr8024863a12.19.1793017140479; 
 Mon, 26 Oct 2026 05:19:00 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b467e42f75sm1452800a12.23.2026.10.26.05.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:18:59 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 26 Oct 2026 13:18:23 +0100
Subject: [PATCH v3 4/5] cmd: fdt: add 'fdt fit' to prepare a devicetree for
 other boot commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-ccaione-upstream-fdt-fit-v3-4-6c5d86c3007f@baylibre.com>
References: <20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com>
In-Reply-To: <20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>, Carlo Caione <ccaione@baylibre.com>
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

A board may keep its devicetree and overlays in a FIT while booting
a kernel or EFI application from elsewhere. Boot scripts need a way
to verify and assemble that devicetree without asking bootm to boot
the FIT.

Add fdt fit to prepare the devicetree described by one FIT
configuration and copy it to an address chosen by the script. The
result can then be passed to bootefi, booti or another boot command.

Always check image hashes and enforce any required configuration
signatures, even when verify=no. Reject chained configurations:
signing each configuration separately does not authenticate the
combination.

Only copy the completed result after verification, overlay
application and destination checks succeed. The script remains
responsible for loading the FIT and stopping the boot on failure.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/Kconfig           |  9 ++++++
 cmd/fdt.c             | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/fdt.rst | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7124b961dc2..c81534810c5 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -577,6 +577,15 @@ config CMD_FDT
 	help
 	  Do FDT related setup before booting into the Operating System.
 
+config CMD_FDT_FIT
+	bool "fdt fit - load the devicetree of a FIT configuration"
+	depends on CMD_FDT && FIT
+	imply OF_LIBFDT_OVERLAY
+	help
+	  Add the 'fdt fit' subcommand, which loads the devicetree of a FIT
+	  configuration, applies the overlays the configuration lists and
+	  copies the result to a given address.
+
 config CMD_EXTENSION
 	bool "Extension board management command"
 	select CMD_FDT
diff --git a/cmd/fdt.c b/cmd/fdt.c
index 7e2abf96103..94b2376d072 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -11,6 +11,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <image.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
@@ -145,6 +146,79 @@ static int fdt_get_header_value(int argc, char *const argv[])
 	return CMD_RET_FAILURE;
 }
 
+/*
+ * fdt fit <addr>[#<conf>] <dest> [<length>]
+ *
+ * Load the devicetree of a FIT configuration, with its overlays applied, and
+ * copy it to <dest>. Images are always verified, so the configuration must
+ * also satisfy any required signature in the control devicetree. Unlike bootm,
+ * image load addresses are ignored and configurations cannot be chained.
+ */
+static int fdt_fit(int argc, char *const argv[])
+{
+	struct bootm_headers images = { .verify = 1 };
+	const char *conf = NULL;
+	ulong addr, dest, data, len;
+	bool owned;
+	void *fdt;
+	int ret;
+
+	if (argc < 2 || argc > 3)
+		return CMD_RET_USAGE;
+
+	if (!fit_parse_conf(argv[0], image_load_addr, &addr, &conf))
+		addr = hextoul(argv[0], NULL);
+	dest = hextoul(argv[1], NULL);
+
+	/* Only a single configuration authenticates the whole combination */
+	if (conf && strchr(conf, '#')) {
+		puts("Chained configurations are not supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (boot_get_fdt_fit(&images, addr, NULL, &conf, IH_ARCH_DEFAULT,
+			     FIT_LOAD_PREPARE, &data, &len, &owned) < 0)
+		return CMD_RET_FAILURE;
+
+	fdt = map_sysmem(data, len);
+	ret = CMD_RET_FAILURE;
+	if (fdt_check_full(fdt, len)) {
+		puts("Invalid FDT in FIT\n");
+		goto out;
+	}
+
+	len = fdt_totalsize(fdt);
+	if (argc > 2) {
+		ulong newlen = hextoul(argv[2], NULL);
+
+		if (newlen < len) {
+			printf("New length 0x%lX < existing length 0x%lX, aborting.\n",
+			       newlen, len);
+			goto out;
+		}
+		len = newlen;
+	}
+
+	if (CONFIG_IS_ENABLED(LMB) && lmb_read_check(dest, len)) {
+		puts("ERROR: trying to overwrite reserved memory...\n");
+		goto out;
+	}
+
+	ret = fdt_open_into(fdt, map_sysmem(dest, len), len);
+	if (ret) {
+		printf("libfdt fdt_open_into(): %s\n", fdt_strerror(ret));
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+	ret = CMD_RET_SUCCESS;
+
+out:
+	if (owned)
+		free(fdt);
+
+	return ret;
+}
+
 /*
  * Flattened Device Tree command, see the help for parameter definitions.
  */
@@ -281,6 +355,10 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_SUCCESS;
 	}
 
+	/* Load the devicetree of a FIT configuration */
+	if (IS_ENABLED(CONFIG_CMD_FDT_FIT) && strncmp(argv[1], "fi", 2) == 0)
+		return fdt_fit(argc - 2, argv + 2);
+
 	if (!working_fdt) {
 		puts("No FDT memory address configured. Please configure\n"
 		     "the FDT address via \"fdt addr <address>\" command.\n"
@@ -1124,6 +1202,11 @@ U_BOOT_LONGHELP(fdt,
 #endif
 #ifdef CONFIG_OF_SYSTEM_SETUP
 	"fdt systemsetup                     - Do system-specific set up\n"
+#endif
+#ifdef CONFIG_CMD_FDT_FIT
+	"fdt fit    <addr>[#<conf>] <dest> [<length>] - Load the fdt of a FIT\n"
+	"                                      configuration, apply its overlays and\n"
+	"                                      copy it to <dest>\n"
 #endif
 	"fdt move   <fdt> <newaddr> <length> - Copy the fdt to <addr> and make it active\n"
 	"fdt resize [<extrasize>]            - Resize fdt to size + padding to 4k addr + some optional <extrasize> if needed\n"
diff --git a/doc/usage/cmd/fdt.rst b/doc/usage/cmd/fdt.rst
index 493ed895bc7..88222a9939d 100644
--- a/doc/usage/cmd/fdt.rst
+++ b/doc/usage/cmd/fdt.rst
@@ -12,6 +12,7 @@ Synopsis
 ::
 
     fdt addr [-cq] [addr [len]]
+    fdt fit <addr>[#<conf>] <dest> [<len>]
 
 Description
 -----------
@@ -48,6 +49,46 @@ If the `len` argument is provided, then the device tree is expanded to that
 size. This can be used to make space for more nodes and properties. It is
 assumed that there is enough space in memory for this expansion.
 
+fdt fit
+~~~~~~~
+
+This loads the device tree of a FIT configuration and copies it to `dest`. The
+FIT must already be in memory at `addr`.
+
+The configuration `conf` is selected as for the bootm command. If it is
+omitted, the configuration matching the control FDT is used when
+CONFIG_FIT_BEST_MATCH is enabled, otherwise the default configuration of the
+FIT. The `fdt` property of the configuration lists a base device tree followed
+by any overlays: the base device tree is loaded and the overlays are applied to
+it in order.
+
+Each image is checked against its hashes, whatever the value of the `verify`
+environment variable. With CONFIG_FIT_SIGNATURE, the configuration must also
+satisfy the signature policy of the control FDT, so an unsigned configuration
+is rejected when a key has `required = "conf"`. A configuration signature
+covers the hashes of all the images listed by the configuration, so it
+authenticates the base device tree, the overlays and their order as one unit.
+
+Unlike bootm, the command does not accept further configurations appended to
+`conf` with `#`. Each of them would be verified on its own, so a chain could
+combine device trees in a way which no configuration lists and nobody signed.
+List each valid combination of a base device tree and overlays in its own
+configuration instead.
+
+The command fails if any image cannot be loaded, verified or applied, and
+nothing is written to `dest` in that case. Unlike bootm, the command ignores
+FIT image `load` addresses: only the completed device tree is copied to
+`dest`, after checking that the destination does not overlap reserved memory
+when CONFIG_LMB is enabled. Alignment and decompression of the base device
+tree are still handled as needed.
+
+If the `len` argument is provided, then the device tree is expanded to that
+size, leaving space for later changes. The command fails if `len` is smaller
+than the device tree. Without `len`, the device tree is copied at its own size.
+The working FDT is not changed; use `fdt addr` to select the result.
+
+This subcommand requires CONFIG_CMD_FDT_FIT.
+
 Example
 -------
 
@@ -66,3 +107,37 @@ address and expand it to 0xf000 in size::
     Working FDT set to 10000
     => md 10000 4
     00010000: edfe0dd0 00f00000 78000000 7c270000  ...........x..'|
+
+Load a FIT holding a device tree and its overlays, then copy the device tree of
+the `conf-a` configuration, a base device tree with one overlay, to 2000000 and
+inspect it::
+
+    => load mmc 0#firmware 1000000 fdt.itb
+    1771 bytes read in 1 ms (1.7 MiB/s)
+    => fdt fit 1000000#conf-a 2000000
+    ## Loading fdt (any) from FIT Image at 01000000 ...
+       Using 'conf-a' configuration
+       Verifying Hash Integrity ... OK
+       Trying 'base' fdt subimage
+       ...
+       Verifying Hash Integrity ... sha256+ OK
+    ## Loading fdt (any) from FIT Image at 01000000 ...
+       Trying 'ov-a' fdt subimage
+       ...
+       Verifying Hash Integrity ... sha256+ OK
+    => fdt addr 2000000
+    Working FDT set to 2000000
+    => fdt print /test-node
+    test-node {
+            ov-a-prop = "ov-a-value";
+            base-prop = "base-value";
+            order = "ov-a";
+    };
+
+A boot script can prepare a device tree kept with the firmware in this way and
+pass it to the boot command, stopping if any step fails::
+
+    if load mmc 0#firmware ${loadaddr} fdt.itb &&
+       fdt fit ${loadaddr}#conf-a ${fdt_addr_r}; then
+            bootefi bootmgr ${fdt_addr_r}
+    fi

-- 
2.56.0

