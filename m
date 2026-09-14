Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0ADC88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 21:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1FCB4054C;
	Mon, 14 Sep 2026 21:33:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rHHYFysnqrVs; Mon, 14 Sep 2026 21:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DD40440547
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789421618;
	b=ny0i1Q8qL0gCZtMljSZKzIYSz4V1It75+rSxXI7SO4V9Z3R/DkHUrpXHPY3Otc0cbatE
	 ejxe8tE146krz2RzZz8lBoTjutIxK8OzYN9vvjNs/ENKYFlSzvmBEmSeFy5+cODQSYNJI
	 wOuKk5amAd94xFuHceH3KYFYHkIyREenirrGYNn25NZ2AT80HBPI3yVccEIZV3WnRdvRi
	 1+I9P915il+u35rIDTF9saZb4Wt1dLaicOSekPhFF/EHmmoWm26qE16ZW4wQiRKT65oz8
	 mwv0GHC29fMDgjaQ3YCdwqjLmnVgpTsUwnNUW6I6Ct5RP2S5oibE6whFW9cRWHNfkhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789421618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RXI1aU72CBUc/yTw7KSfG6vkdvZzP0LrnD2FLSmspDQ=;
	b=RiWNzACTwhGSXVOuHVNGm3TvlTu1yt0XfpzL1UFhr3TARhGdSzFlOv90AB/VZIffh7yS
	 jF4y0w/aporTJKOkw1t9LlxueIuA8Q3cpHyuBuOtHUQ9IQdc76MN17rfdY0utkTm+qrBg
	 skqHxLd/j6F8nOBKRanKbbptmbjV3KqwYedTSUSbQ68vXwM7KliwXK8C2+jNo1eYnonRi
	 mS1UqAMv7sf2ttKMwBlXclgzzUYGiahOI2h+V7QqNwHv0A9ippOb1buZ9AaEeroVPHYDm
	 S2rLpzGMA0rJ46/ebeZw9sTYXiFyGPARC9b9RnsTW3Bx0oM3Rz+Ss4ZHnANd/HvJetg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789421618;
	bh=RXI1aU72CBUc/yTw7KSfG6vkdvZzP0LrnD2FLSmspDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Db5sIOvfccJysfq1nM6PI0ygVkH+1afMwq+co2k6cxFMq0A8V9mZwOtB0lqw4kT8G
	 YYkqf/YQlSfpDG+hNK+qaWqeP2WfjWxKelgqyVcAFME5qZcZyt1XKzlzCnqSFUUvSl
	 pafz5aMjI2C7ueemRxfEfVsibww8xMSR91T/A7xer4SaPHBaA4gKZnfyghE2zStMEU
	 eQQY6sogB7FNLNAApe286TwvhF4HtAGVNC3ObZbPNFd7Z2NKHWZitFoH20D5NJJxjS
	 s6svNALR1yzdV1xcjkGWmTiZDKMwJ30ZoAuT+pgQXN/u8Z3KFdWrySk5otTzK4UQjj
	 z2SZvdmrbQNkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD40440547;
	Mon, 14 Sep 2026 21:33:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29AEC465
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F70F80BB7
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:00:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87tkgvAuKC6X for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 21:00:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 45F2F80880
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789419658;
 b=NDikzPfeQJ0PWNEG29HwYdRW5GPpNl0IxaKYdke2+1KdBWqajHP7r9YJhcUL/8FVRsob
 wv+BO4hJlqcFFsduef+U87gTS+2XMy8eEQEkU03cLCD+vWsrASHc4c7OAMfFj+CzAkJlH
 MbtHujQS10rN9tR3hK+sZGsqdZWryYto1ywz9cRdf4SHsZ/2E0vqGoao67XMaO5rdf9Up
 aR++1om38E/PLaW0Oq4hmeFKTDj8xh9MRi4dMTjEBAKY5ox0w7oOresZXJMNQaCBbtmMU
 LgcszpVOw7GMxYyEyCD0s+dSF2F5ltjtwqRJ/CKdpj9H2W2rsVHt7wowrGDVIBxL6xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789419658;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=RXI1aU72CBUc/yTw7KSfG6vkdvZzP0LrnD2FLSmspDQ=;
 b=B0/ckpXdm3i50HQTtYGaueISlY4nLaUsK1ck5XT9Az90w5g5x+398F84UL8BQBr62H02
 9iwR083wGPAt9tAjrqsRBr0dmvNKkXl5XAmmlCQLovPMFddgRn9HcxiRqdOtf9GsJ4lKE
 +Qm/AIXlMx8gvTLzpNcRaND2me8jp76N2oGsnY6gMoni/fhex4ecfDSU5YI8qVgQV3/zh
 anli7ZjXIHAiaiHqRHRRfceBFAHnNWxSHRWKx9bo1O4beWmwb5+slbNJ9wvAH0yJTvq9N
 +WhKnvVoulzrwdp/DbfBBl8Lc9O2rDZ9PRKMW8lK0Pt+Pxkh2VbLDcr0AUTbkEWsqYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ont4ZQqH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::f;
 helo=mail-pz2-x0f.google.com; envelope-from=0xiviel@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ont4ZQqH
Received: from mail-pz2-x0f.google.com (mail-pz2-x0f.google.com
 [IPv6:2607:f8b0:4864:3b::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 45F2F80880
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 21:00:57 +0000 (UTC)
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469b35611so1400543b3a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789419657; x=1790024457;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RXI1aU72CBUc/yTw7KSfG6vkdvZzP0LrnD2FLSmspDQ=;
 b=Ont4ZQqH+WjcRbmjsqq8X4T1rdwK/kounODiFwmzlNBoDwtKoaA30cPkCDay5cHdE+
 /csqig0h4FSL6OIzsLG3bUKcaLYNaqBB/jayvpqEy/LhvF8X/wL7J1lrUgEt0pC8Lc4B
 gGydAOsWNcoCgo0islILRQ1b5DxNCGVtNJUevjnRExzip8n3v31HjlRmeULlDOHwNiHG
 vTWTgC9Bt8jFFXbYZjCzfyNfN+YVdlYJ3cG3/5jMWKGlpBCY80e6sdIYu2s40buXLpiJ
 a51qTWwDz/7ahQ28M2GnTiYlneW/8Pil344G2ozW1n0/nhpZ60waBK8pAfeWpZuvkAT9
 LqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789419657; x=1790024457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RXI1aU72CBUc/yTw7KSfG6vkdvZzP0LrnD2FLSmspDQ=;
 b=fy9bqMwdRmtZZur8ON2TQBG97tsM5fFszH9LMrcNEgUfd/Iim/mJOV0dpb2vHYlfws
 Yr/3QJPGewu94zCJBeQXkj29YIPh6Y0X8acq4KMC9lZTA4PpMLRLu8hWHBqtiYhVbK7z
 OJZwyqcphTH9BuHyoewrcQhUIz+IGSoy4pHCmNaACCTseo8Ov3MVRHnveyfsbXh7EUrp
 u5BwvhAJYTBj7Y9HgilrFXNGE/z9+sffEpymFLAxW6EUM7o5xI4eltQWtsFwQPYx3389
 7k29uo5xfjlTSio7NyPpyfXGPWe54rMedi+drVLYppJK6y5Nuj5DHX6S838jTlbz8zuD
 Og2w==
X-Gm-Message-State: AFuF++l6i9g7uQx4hQQT/X7CsgzQmYTOCfwYQi930E+C/qphrKskLj/k
 W+QoI/24N+9A/4Ja2X+DL8Kf9phNeLRZA9MPD2GmrB41WpE6LQ1O/x8m
X-Gm-Gg: AYBFou3GtMdvAV2LTGtGMbP9v09TckprtDelN8GKXT7DOG3R4JgweEb0ZYJb4woXjxN
 JaoViJnwtONdwfgYYep+Ol5oIe5Iy5hz0dKiG2sqv9qnpTtFmxc7tAnbH6bcdUuflLomgHCQvxg
 9Gvqfzd6tij0vCruAcvf2S//gEPb5CVeNFQaygtyHz0HBZFIVbgecxcZ9wDavgjw69e6m/R/6/N
 Hx4kaBgG4B/EHRTjQ3mwaYG6LIwUOcNG+j/48+ncy9KgvnEPCFWovftZmUDOnXUDlzcIJnju+Vc
 p1B32JySenXYme9jvoxYufvoGB5LT6u5d7Q+UfCc6WS64T6N1wgT0jmddo2rUGEE2v5aF4oyTZt
 eukA3FCMLO5KTOTcz3E5wM5bVI7Pz0wtvkX9FFCbgkXLbGSr6qkBGbCca+pgS13ey9+zP/p0Sbd
 2r4NbnyDpsvra8ERz5gfG0bQ4yDKQtYK7sI3MIxspHz+ZvqQjMiMblxGtTHPcaXIcXaDi94Z9sE
 urwSxQd/OsdqE6k+prrM/rPreaZf0h3/EYemP2RwoMNZVjUz1gkTuubny3WR6tcN/7EDVb2iqM3
 xHUxIbNcsTWnkAwGlkUtiaFpbcdsO4imrhWVOqNc0d2VPHu+1QIJlJU=
X-Received: by 2002:a05:6a00:3cd6:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-86f8314eefamr7903005b3a.7.1789419654994; 
 Mon, 14 Sep 2026 14:00:54 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b5674bc2dsm5263328b3a.59.2026.09.14.14.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:00:54 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, daniel@makrotopia.org,
 jbx6244@gmail.com, ludwig.nussel@siemens.com, anton@binarly.io,
 jonas@kwiboo.se, Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH v2 1/2] image-fit-sig: also require signatures on the image
 gate
Date: Tue, 15 Sep 2026 08:58:39 +1200
Message-ID: <20260914205840.360734-2-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914205840.360734-1-0xiviel@gmail.com>
References: <20260914205840.360734-1-0xiviel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 21:33:29 +0000
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

fit_image_verify_required_sigs() at boot/image-fit-sig.c:187 looks up the
"/signature" node of the U-Boot control devicetree and returns success
when it is absent, at boot/image-fit-sig.c:203-207:

	/* Work out what we need to verify */
	*no_sigsp = 1;
	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
	if (key_node < 0) {
		debug("%s: No signature node found: %s\n", __func__,
		      fdt_strerror(key_node));
		return 0;
	}

With no /signature node there are no keys marked 'required', so nothing
downstream can fail the image: a FIT whose signatures are absent,
malformed or invalid verifies successfully. The only indication is a
debug() call, which is compiled out of a normal build.

fit_config_verify_required_keys() carries the same early return, and in
that path reqd_sigs also stays at 0, so the closing
"if (reqd_sigs && !verified)" check never fires either.

'iminfo' at this HEAD verifies images but not configurations, so it
reaches this gate directly. Against a control devicetree with no
/signature node at all, and a FIT whose configuration signature carries
no 'value':

  ## Checking hash(es) for FIT Image at 10400100 ...
     Hash(es) for Image 0 (kernel): sha256+
     Hash(es) for Image 1 (fdt-1): sha256+

That '+' is fit_image_verify_with_data() reporting the signature
verified, on a board holding no keys whatsoever.

Add FIT_REQUIRE_CONFIG_SIGS, which turns a missing "/signature" node,
and a "/signature" node holding no required keys, into a verification
failure on both gates. With CONFIG_FIT_REQUIRE_CONFIG_SIGS=y the same
command gives:

  ## Checking hash(es) for FIT Image at 10400100 ...
     Hash(es) for Image 0 (kernel): No signature node in control FDT: FDT_ERR_NOTFOUND
   error!
  Unable to verify required signature for '' hash node in 'kernel' image node
  Bad hash in FIT image!

The option defaults to n, and that is a measured choice. Full test_vboot
on sandbox with these patches applied:

  option at its default (not set):  32 passed,  0 failed
  CONFIG_FIT_REQUIRE_CONFIG_SIGS=y: 19 passed, 13 failed

The 13 are not a defect in the patch. test/py/tests/test_vboot.py:312
boots an unsigned-images FIT against a key-less devicetree and asserts
that it boots, which encodes the old contract. Restructuring that is
Ludwig Nussel's 5/8. Default n keeps the shipped behaviour byte-for-byte
unchanged.

The new console message is printed only when the option is enabled.
Jonas Karlman objected to an unconditional message: Rockchip enables
FIT_SIGNATURE for image hash integrity alone and has no /signature node
by design, so an unconditional message would be noise on every boot
there. Measured with the option off, the string "No signature node in
control FDT" appears 0 times in the boot output, and 'iminfo' prints the
same 'sha256+' lines as an unpatched build.

printf() is used rather than log_err() so that this stays applicable to
main standalone; log_err() in this file requires Ludwig's 3/8. If these
are ever squashed together, log_err() is the better choice.

Not tested:

- SPL: SPL_FIT_REQUIRE_CONFIG_SIGS compiles through CONFIG_IS_ENABLED,
  but no SPL configuration was built or run. Compile coverage only.
- Host tools: mkimage and fit_check_sign build, but no fit_check_sign
  behaviour change was exercised. CONFIG_IS_ENABLED is false in the host
  build since tools/Makefile only defines CONFIG_FIT_SIGNATURE, so
  unchanged host behaviour is argued, not measured.
- Sandbox only: sandbox_defconfig on x86-64. No signed-boot hardware.
- Jonas's Rockchip setup was not reproduced.

No Fixes: tag. The early return is original behaviour rather than a
regression. The oldest commit touching it in this path is commit
b983cc2da0ba ("lib: rsa: decouple rsa from FIT image verification"),
which moves the code from common/image-sig.c to common/image-fit-sig.c
rather than introducing it. No introducing commit could be identified
with enough confidence to tag one.

Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 boot/Kconfig         | 27 +++++++++++++++++++++++++++
 boot/image-fit-sig.c | 15 +++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba49..c1dd1de6ed 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -137,6 +137,25 @@ config FIT_SIGNATURE
 	  format support in this case, enable it using
 	  CONFIG_LEGACY_IMAGE_FORMAT.
 
+config FIT_REQUIRE_CONFIG_SIGS
+	bool "Fail verification when the control FDT has no /signature node"
+	depends on FIT_SIGNATURE
+	help
+	  Without this option both required-signature gates return success
+	  when the U-Boot control devicetree contains no "/signature" node.
+	  Verified boot is then silently disabled: a FIT image whose
+	  signatures are absent, malformed or invalid verifies successfully
+	  and the only indication is a debug() message, which is compiled
+	  out of a normal build.
+
+	  Enable this option to treat a missing "/signature" node, and a
+	  "/signature" node which holds no keys marked required="conf", as a
+	  verification failure instead.
+
+	  Say N if the same U-Boot binary must also run in setups which carry
+	  no keys, or which enable FIT_SIGNATURE only for image hash
+	  integrity checking rather than for signature enforcement.
+
 config FIT_SIGNATURE_MAX_SIZE
 	hex "Max size of signed FIT structures"
 	depends on FIT_SIGNATURE
@@ -259,6 +278,14 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
 	  device memory. Assure this size does not extend past expected storage
 	  space.
 
+config SPL_FIT_REQUIRE_CONFIG_SIGS
+	bool "Fail verification when the SPL control FDT has no /signature node"
+	depends on SPL_FIT_SIGNATURE
+	select FIT_REQUIRE_CONFIG_SIGS
+	help
+	  Enable the FIT_REQUIRE_CONFIG_SIGS behaviour in SPL. See the help text
+	  of FIT_REQUIRE_CONFIG_SIGS for details.
+
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
 	depends on SPL
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index a0c50bba4c..06ec0f39d8 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -201,6 +201,11 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 	*no_sigsp = 1;
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
 	if (key_node < 0) {
+		if (CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS)) {
+			printf("No signature node in control FDT: %s\n",
+			       fdt_strerror(key_node));
+			return -ENOENT;
+		}
 		debug("%s: No signature node found: %s\n", __func__,
 		      fdt_strerror(key_node));
 		return 0;
@@ -684,6 +689,11 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	/* Work out what we need to verify */
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
 	if (key_node < 0) {
+		if (CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS)) {
+			printf("No signature node in control FDT: %s\n",
+			       fdt_strerror(key_node));
+			return -ENOENT;
+		}
 		debug("%s: No signature node found: %s\n", __func__,
 		      fdt_strerror(key_node));
 		return 0;
@@ -735,6 +745,11 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 		return -EPERM;
 	}
 
+	if (!reqd_sigs && CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS)) {
+		printf("No required keys found for configuration verification\n");
+		return -EPERM;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

