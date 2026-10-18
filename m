Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0168DCCF2CC
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B73626069B;
	Sun, 18 Oct 2026 08:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujrZSdTJsUZ0; Sun, 18 Oct 2026 08:35:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08134606EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312557;
	b=E3HeaJjPGNuPGlaK+ByefMTSZRQUjOd1hy5hvcZXKWuWKPuDx9X+YpsaKNtyhgU3yAwg
	 ktGFwEdgGQlYYZwfivn/3dJ+Mpm8I0KJsIqdhb199WMtS5dNYT5kktpYb0jnMdlAY4V+Z
	 9XWme3y4kHcv0B1fC6yFrpx+zAhUXNf0Nwr55RuWZmIDmcmnFlRXwlKQIK6/E89oGq/9V
	 PtEF6uGYI1kxRmV0zq329hOU/uJTnk7TW+jBuH/UO6EDjGqHDpDfOr+oiJnsS9YJzmops
	 pwa9Ikbu5hlBZFyfDrY7G94+43yXEi+c6stVZ3lCQuZPZ9oUlTyKQpLffWsdIvD4QDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Z87bjCWPG33aDO10PNitTHFRFHc8ZXGxGQU6xQAL4Ec=;
	b=K+tZYe5jlYZjkYQZrl+VNkLxFnpcLjk/zNy5UQQaMgM+kM72ebuV15e0h5RyBgh1Oq/1
	 6a1IPshXWmjh+pSD0P4wlifiIAQ2jQmyngBbmVizAfg9IshrfqGVrdJHFGNprOgYsVXBa
	 Ybpw+ApTH2wW0OpGuVS1j55MlXpQd/jynabTbLh/hTmkfnXv5iU3PfPZgCFzwZ4DHMCxp
	 bEUXf63F7dRlIlRnR0JpdA8l9zRBAPdgv4/VH7hsNsB9mbiqFD8OjXVKdoxJIaCxMaCy7
	 58KkDPwwm6JrFnNs1FxU31WxkzYJlZ9aHKGr9xiRp9XpNlBiGhBLbAxM2ZFJwOKOu4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312557;
	bh=Z87bjCWPG33aDO10PNitTHFRFHc8ZXGxGQU6xQAL4Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=di8ZMOrQm7Dvr4aFtMC9uWM44BYUNyrFe0xj/qup2LB0tRw2hUKioFFOjL+an8T4L
	 B4jIhDpLswLdlnb+DJP5TkzSKJEyu4GsqXesqYIOboBj7BZVOfqGUz3l7nb6OEP8pT
	 XnOlgMUpYKgMw4Eo/FXCa2l7qnJi/P75o+ckWXlCP/HN7zJQtAypnK8+7Yw6X5PgAl
	 cqUtfX4HjPMOJnfcnc/0os/jXsyD+kNiiAvwFoOFZObK0xycsot22igp6bXvU5x1Lk
	 bZ4j1vPPyvA2yqz11xBZ1CWsztY4GmGwjm3IefKhKUTDcGUWkImuc6RQq5FAEkeRYc
	 x1y/HATqUs6Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08134606EC;
	Sun, 18 Oct 2026 08:35:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 30D6F263
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C3BC812FA
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4kZcptT4-Qnj for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B844812EC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312539;
 b=eg5IyFLn+Yw4cTgbGZGxq9p5ktCZAgdZbUp+9duMxI2D+sSzoFax77Q2n8/FhOwGaw3w
 nO7zPa1QgtDard8Gu5m4kZcB5IA7AsPOj50x8tcGA8AYuue25/ZwE0NcWjg7a+tjXW2Ud
 IOvzPojBH/G95+U0Zicrb6tjcSPe7bLrSsTWWLSuMT7sRGs96O2yzOr6NpFIAsBjdCqRD
 Mj4Sdgdnyu4sj0zd/+NkfSY8hOwlHjiuesGSiAKbGN0PXpOLAvn3+VXolnhJuJZR8xw8C
 pZMb3ANl+FwDVDFzDNfwazuT5izVwPvJqJaBaL5BLLzWQ2Q6hdL/Ty4ygC9Cj6drQxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312539;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=Z87bjCWPG33aDO10PNitTHFRFHc8ZXGxGQU6xQAL4Ec=;
 b=g18nG6Wz6T/crrtCoSXxEbTQgafvPN+Gx1nE02Ys+GKGmNN7h20x1Gk09aE3R3rVIf50
 p0UAQD5Nz4+KnyBeFSx7nTkzChr1mqQmc60KeR4Hc1SgupYLsSl5MkrL4kKl5dKyJabBq
 JVCvdltTdA0BDhqGROAY+JPGDDOImBh5eZ6knumFYlESUvKfHA+xQUS9zmHVTy20Ailsj
 /3CQWg0lMS77sKgjlqOm2xYw+5qTaVTjC20ZkChsS5IFhy8lY20amUFwcnylCSW6foCCX
 XHVsR0TExdFb1y3Pib6SwpVnfdsx9GF4CJvCFwYB3rJQbIM3ERPwxLwF52RCJnJwhEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=khyXAUzd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=khyXAUzd
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B844812EC
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:38 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so676104f8f.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312537; x=1792917337;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z87bjCWPG33aDO10PNitTHFRFHc8ZXGxGQU6xQAL4Ec=;
 b=khyXAUzdqpl4Qi5SovE65hLI+VjiekGuqvQe7DLLkZAmPIZI6Rm+Ot+z+s5fuvVlt4
 sNwcaiC1+ulY8BFMCAw8OMCaj4g5GoxTbvtB/n5GkBTnccDjGpEarLiRfmwSIi2UDESh
 K7o6HLMiu8JyodMA/q+2tcrCBs9Vs+Pi5Nk3/fdwbFdkPTT5RBzpX9jVoMGMg8rPg0fl
 YcssjN0q1850b2T2T8eNBOSsIuZnr11kRcZSNOlehjTr8NiEGz/NBxndK1tS4KLYNXg5
 jN890oR5KUDxTa1Rt1BIdqerc0jU/Od/48HG8MlY4z4twPNU9kBZYLf1Vj+zNeQ+IeJB
 X+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312537; x=1792917337;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z87bjCWPG33aDO10PNitTHFRFHc8ZXGxGQU6xQAL4Ec=;
 b=Jvur1e4MkRMyUrYfIoVZFJJkkv0ZIWmvbJ/RuexEuuQDnxLWXBr9FB/oZ5PXCNkgHn
 +53a330QMS4ViDOqOUvI3dG0zLWYrz7N7L67aHjKYKB+ZBbhv8nvnSI9pSbsRrxmr+2O
 Agh0q113zliw14ZTubpBfIBvqlhuB7oNm57iOm4PYqIB1iXr6Ry5PjqMhZm5XXu1GCD2
 sfuBE4ABQKk5jq66FMx2nfzd2csTVjuzfmEfsxUgVkYKCor1m450HFGIUTRw7SfebfNA
 o8KSgYC8ybSjWYIqK5t0EBRzRmFEGXvVBCnt01fOo0LK2ZXDNcunjD90GbOJk2e0LVch
 GDYA==
X-Gm-Message-State: AFq9FYJYM3B+31Z8rakiTdnkqvtZEK+viyN/UiourWsEBUx4zR2Ue5+y
 Asxvgnlkhy9gBdTikyMD/jNo2Oe0RghHm2advbNJD/SbrbRPhiy1eeKKu796apZt
X-Gm-Gg: AYBFou3lvsWO2ilSDmSVnuDittvkEHagWiAhhgz8tjvDqRDT+jlfilxHQnJVEuqS4Yp
 lhaS9PdaKHE8Yv03hZe2sT+Z22Hl/F7pXbplXji9R/3KxjLJv1Rqf4+eB51aSdHDRVt5KMGontk
 uG/RlCJjuY+/vlgVwy/Wn3DtMpV0a+5PP9pjkgBRyYqvqWwjhA0R78XFo6UEvHU7xvGWGtRuDyK
 BBzn4rADSZ29zn/893rHRjaXB9fqOXc42iWFb3DHO4ajbxNDm5P5EhWM2PJJ+wUQek3p9ju3xiW
 AwQxNNUqTXqyF+dTRh0P9L7VnIrqu5jpl7+7yd3ABh7DuR4hphdKqkOaPPtP5MO72haHb3XHPOh
 GZOr8VFa0BnEVGqS3RdGMGRCrUaDG2skm+kGxCo3yEMOertYrCjb4E84TthzlejQDHI2A6vK9HU
 hdKF0D9IjOI5utxsH9Mwd1Oa8Ehaz2bDdPJHBMyjQBIRlUPwTEeOz/j0SOJzGmNbq+F28IGNigq
 xHqAFyKPelzEVB0cBqxAGVT8gty/UYELznu75T5FHJFOi2qxOBksV7qrqetmxxNZFsfgsMQudDv
 EUPfp/tAN1E+YA9J7w4euY1Nrip3HMQarJ1dYRe1lgcHMMNBQPQ3X4N4dNQGUCblgH1mqDCy3Sp
 01dO7YQqlLREcOL7mAxPu6Vk=
X-Received: by 2002:a05:600c:8706:b0:4a1:946c:953f with SMTP id
 5b1f17b1804b1-4a1d7601873mr92942195e9.20.1792312536606; 
 Sun, 18 Oct 2026 01:35:36 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:36 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 12/14] board: CZ.NIC: turris_1x: Make NVMe and SCSI boot
 targets conditional
Date: Sun, 18 Oct 2026 10:35:14 +0200
Message-ID: <20261018083516.49229-13-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

A Turris 1.x configuration without CONFIG_NVME or CONFIG_SCSI does not
build. The NVMe and SCSI distroboot targets are listed unconditionally,
and config_distro_bootcmd.h turns a target whose support is disabled
into a build error such as:

  error: expected '}' before
  'BOOT_TARGET_DEVICES_references_NVME_without_CONFIG_NVME'

List the NVMe target only when CONFIG_NVME is enabled and the SCSI
target only when CONFIG_SCSI is enabled, so that the NOR build can drop
NVMe and SCSI to make room for the ubi command. Both defconfigs enable
NVMe and SCSI, so nothing changes yet.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
(no changes since v1)

u-boot.bin of turris_1x_nor and turris_1x_sdcard has the same size and
md5 before and after this patch (Debian GCC 14.2).
---
 include/configs/turris_1x.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/configs/turris_1x.h b/include/configs/turris_1x.h
index c05614950c7..3a2818d1904 100644
--- a/include/configs/turris_1x.h
+++ b/include/configs/turris_1x.h
@@ -71,6 +71,18 @@
  *         define CONFIG_SPL_MAX_SIZE = CONFIG_SYS_L2_SIZE
  */
 
+#ifdef CONFIG_NVME
+#define BOOT_TARGET_NVME(func) func(NVME, nvme, 0)
+#else
+#define BOOT_TARGET_NVME(func)
+#endif
+
+#ifdef CONFIG_SCSI
+#define BOOT_TARGET_SCSI(func) func(SCSI, scsi, 0)
+#else
+#define BOOT_TARGET_SCSI(func)
+#endif
+
 #ifdef CONFIG_SDCARD
 #define CFG_SYS_MMC_U_BOOT_SIZE	CONFIG_BOARD_SIZE_LIMIT
 #define CFG_SYS_MMC_U_BOOT_DST	CONFIG_TEXT_BASE
@@ -266,8 +278,8 @@
 #ifdef CONFIG_SDCARD
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
-	func(NVME, nvme, 0) \
-	func(SCSI, scsi, 0) \
+	BOOT_TARGET_NVME(func) \
+	BOOT_TARGET_SCSI(func) \
 	func(USB, usb, 0) \
 	func(USB, usb, 1) \
 	func(USB, usb, 2) \
@@ -279,8 +291,8 @@
 #else
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
-	func(NVME, nvme, 0) \
-	func(SCSI, scsi, 0) \
+	BOOT_TARGET_NVME(func) \
+	BOOT_TARGET_SCSI(func) \
 	func(USB, usb, 0) \
 	func(USB, usb, 1) \
 	func(USB, usb, 2) \
-- 
2.54.0 (Apple Git-157)

