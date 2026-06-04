Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2294CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04848498E;
	Thu,  4 Jun 2026 17:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="B7F/jxxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D11E8498C; Thu,  4 Jun 2026 17:31:29 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 973CF844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so1311071f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780587087; x=1781191887; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qbRSdwJuB4t8pq4j0vGo4lsWuuYoZOoK1c1oPRDaWaM=;
 b=B7F/jxxcZp++5iLBYsSypXf0TLamF4rKhhkwM6+1gCbKwfI+V0Mts7Q+Mbt+Ja4Iz6
 Ll1t/X8gYbQb7KF2JkXZm/rRFsYOaunh51S7mtxO6OL9VrjQAUozlB5RorDAIK8ocfNr
 5DgJjAX0uIWpbgg/X0ZYS4oGnvjs20Kt030NWM0LNYThIs5hyb844rP1GhMJdq9xbSjQ
 u1f8eOtPqnqCR3c+1Ub1tXfJkXTO8I/ZHAJGk3jwZO9Cc1Ck5SH2o1Rsshi3mLFYZ/sz
 QnB/xfRNMCXWWCRZ5ihGuqiQDK0ToXwibSknbycvtalQUoP8fny7ZNSl3CGhutc3I9cf
 iNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587087; x=1781191887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qbRSdwJuB4t8pq4j0vGo4lsWuuYoZOoK1c1oPRDaWaM=;
 b=WrsSim+PwHlDG8tqJ5U0Do9XpaQqQ9pQfZqw7eLm7I8k8U3FhAP8AbjVUXN0nDjbts
 psgua4Cpa/q1M+yXaICnS69mW/5QuSGv98BlVQvxeAJoKMqAG4ExxXRDib0zJKXA1AT3
 6xmmecCILzaxqVf0uFn3BbvDBJ6U5ApTpvfXbsMZ0Wzp36HICNmMOLRoroI6UAY8EFWc
 TvdkdIfGmDNTVAzMO+tGN72aJecLwv6/gVmECAD1gxvx5Ev6WfkmrA7Dkzpp3GiMVY9g
 DEshRpF/X/MV0a0dCB83q8PI6un538FuwRMies6Imy0jCZWG3udpEm/A3LYgvfqeQJZ8
 Dgjw==
X-Gm-Message-State: AOJu0Yzpc8ICcY/qRkbUTP7U/f0ob8Af8C+T+1EyaEFXImXSB5AdUo6y
 N5KcAH64ixz9jcrIFBYjfjp1WjbFgxn5/6C5nJK0mMaA/OV4rdo1Xo76wau243HjZbo=
X-Gm-Gg: Acq92OHhlMDdLBbsIqye/GwcC56KHl6jlRntmEa5bhiDqw0NpZUHSgN0umOPmgHW4Y7
 sqSgoyzW2yn2YRAVCicnVnwe+ASE3AQ0M5pTMRu1mRSdgyOirGJwXRFbpzAvJs/2GAtksVoHXl0
 +Iwy3jt3w29V/Dz2ZeKjeP/PSZ97fRjGoSQa5Mv/2SSBQ/hdBsYW3Cp2gwwpUKQnLyAoqcFU5M8
 bxBlliZpZxYjB4rryYCMeM9MXGSnAlK8StX/SrJHC7GjiKftRGbIFFv+E319UZ7AFVG/71D7Qkc
 Tv3hOaWVIOhxAlwzyUT1sY2QdPspc5/zk03r5S3h2AkyTlPiCFxV9yO/j2CetG+6vUB9x934GRs
 v1CkEgqRXT/bw4MSnFFhTLUB6P9spDTCfMqb0zqHirzmyZ2kcjsUwHy5fgfLs8hZqcK5q89KAgx
 ONx8HUks7DrOEA+uIuaGSBKsWcC+RO3Z7aEH4HmlfJV88315UR3K0=
X-Received: by 2002:a05:6000:11c8:b0:460:10f6:a554 with SMTP id
 ffacd0b85a97d-46027334b2emr5683174f8f.14.1780587086990; 
 Thu, 04 Jun 2026 08:31:26 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm28284932f8f.27.2026.06.04.08.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:31:26 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 04 Jun 2026 19:31:10 +0400
Subject: [PATCH 5/7] pxe_utils: optionally ignore unknown keys in
 parse_label_keys()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-bls-v1-5-4ce6d1ee4711@flipper.net>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
In-Reply-To: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3973; i=alchark@flipper.net;
 h=from:subject:message-id; bh=gmqzMKQzE39kT86xNCySqNHeENLN66ATuYpev1ReBcA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQpzrIXKQy9pTM30Ovk1Orlnv73zm5vkD2wfZos+8mef
 R5VSeq8HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1piRGhhsR1ra/dm9Oj5S6/MIoYZHz7c//duXtqTJJbzc98FF9mhwjQ98sGU8
 z06BC55g54QVX1zp0e88pnZAX8nWL1nVJputXOAA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The parser currently treats any keyword it does not recognise inside a
label body as the end of that label, pushing the token back so the
caller can dispatch it as menu-level input. That is correct for
extlinux/pxelinux, where the only thing legitimately following a label
body is another 'label' (or a top-level 'menu ...') line.

Other formats that share enough syntax to reuse this parser have
different rules. The Boot Loader Specification, in particular, lists a
number of entry-level keys (title, version, sort-key, machine-id,
architecture, ...) that this parser knows nothing about, and the spec
explicitly requires implementations to silently ignore unrecognised
keys rather than treat them as a structural boundary.

Add an ignore_unknown flag to parse_label_keys(): when set, the default
switch case consumes the rest of the offending line via eol_or_eof()
and continues parsing instead of returning. The existing extlinux
caller passes false and so is unaffected.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c    | 29 +++++++++++++++++++++++++++--
 include/pxe_utils.h |  8 +++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 6dad3045f9d4..7ecee86a9ada 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1266,7 +1266,8 @@ static int parse_label_kernel(char **c, struct pxe_label *label)
 	return 1;
 }
 
-int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label)
+int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label,
+		     bool ignore_unknown)
 {
 	struct token t;
 	char *s;
@@ -1339,7 +1340,31 @@ int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label)
 		case T_EOL:
 			break;
 
+		case T_EOF:
+			if (ignore_unknown) {
+				/*
+				 * BLS-style callers parse a standalone label
+				 * body, so there is no outer context to push
+				 * T_EOF back into — stop cleanly here.
+				 */
+				return 1;
+			}
+			/*
+			 * For pxelinux/extlinux, fall through so the default
+			 * case pushes T_EOF back for the top-level parser.
+			 */
+			fallthrough;
 		default:
+			if (ignore_unknown) {
+				/*
+				 * Skip the rest of the line and keep going.
+				 * Used for formats like the Boot Loader
+				 * Specification, where the spec mandates that
+				 * unknown keys must be silently ignored.
+				 */
+				eol_or_eof(c);
+				break;
+			}
 			/*
 			 * put the token back! we don't want it - it's the end
 			 * of a label and whatever token this is, it's
@@ -1381,7 +1406,7 @@ static int parse_label(char **c, struct pxe_menu *cfg)
 
 	list_add_tail(&label->list, &cfg->labels);
 
-	return parse_label_keys(c, cfg, label);
+	return parse_label_keys(c, cfg, label, false);
 }
 
 /*
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index e639e59e5dc8..653e1a7d866e 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -237,9 +237,15 @@ void label_destroy(struct pxe_label *label);
  * @cfg: Menu the label belongs to (used for 'menu default' bookkeeping)
  * @label: Label to populate; must already be allocated and (when called for
  *	a file that has a 'label' header) attached to @cfg->labels
+ * @ignore_unknown: If true, silently skip unknown keys (and consume the
+ *	rest of their lines) instead of stopping. This matches the Boot
+ *	Loader Specification's requirement that unknown keys be ignored.
+ *	If false (extlinux/pxelinux behaviour), an unknown token is pushed
+ *	back so the caller can treat it as the start of the next label.
  * Return: 1 on success, < 0 on error
  */
-int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label);
+int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label,
+		     bool ignore_unknown);
 
 /**
  * label_boot() - Boot according to the contents of a single pxe_label

-- 
2.53.0

