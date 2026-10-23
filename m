Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94600606A31D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0EXS34gA;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Kn17BGDR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1B5260A4C;
	Fri, 23 Oct 2026 22:33:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufhoe3Bbb4cG; Fri, 23 Oct 2026 22:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 41B9D60A38
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792794796;
	b=HivjJThsExQCcHfZmYus0UBoLcfgMCAeMiuEJJKvmwhvspGSHQfQcZ+4dpdYmpjpvgpp
	 8oEqa0cAeB/pZJh7e32sxSxI16BozyRuzHHO8Fha8WqX0bBmV/I5q2hSESPRa67Ps1765
	 oSJlrQuIqFDiOtbL7gHORJjkqeVGjYsbQoscvGhTZFzhNnYg2IlhM4JXDhXg7OxBWfdP3
	 TEn7y17160hFZcx/rn76YlNeAWaD9UuUw7jKwcDYXU5Fi05V18RpsjYvhmqbcHWBqHI3U
	 mKpovUzq3zJZNTB0oerm841C68joScN6lP1Va4zxOBQknFu92deSTI4f22w5pGJQaHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792794796;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RRkd12sEtukujyMNgpzCsexRAIRvGCwD5ktwbfNzpYA=;
	b=ZPGzzL+f/ITI3ej0qzHEUCeHvWOnRXHoTFafLqN24ty8dgdM1i87zUH69ih6VqvVmeiQ
	 sskmp9Bugvsz6m2w0WhbbqMlkio3HCMm4ZPM2HSrTzmIzUj8enrGXXBLwinJtkM0XxWBP
	 lP2JUut1U8ZFF0AxvrfJrEB0Nock1LtvXSrMz2vfUhViZ9xJuKtE35vVwwOyB/2pZBvQa
	 5qvETg8PLBe67mUYmn7WJq4ybjTDwNTZJuKKNx6s4d9G4KC+JLHrO58WnLcTP5rFmfrua
	 T+1TxOsUNLQJDvi5lJuD/8B0ovTUlDdP9QC6Z3S0fH8T7+QSs0+E0vd1HmtcdNqm3lw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792794796;
	bh=RRkd12sEtukujyMNgpzCsexRAIRvGCwD5ktwbfNzpYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0EXS34gATtF59nZBXWevVA/oEaxjd/tDQaNV7xH3L14zdNpF1tp2kplzukwx4mpcp
	 wzAH3UoIMRXrHHeBHdtGEdp2WV3K9GGAz2S8D6J74BmyIDFhaLFDaM2pTD2xc8P4yL
	 v0MOTzqFZKK8iNn+Uz2IN6Os4E3zgPhrp4+tMO3Dk1NoPobJ1/wFBBlawHlmXCgut2
	 EqETLCC6AM4+M82l93Xrsb6RQ0XsmCw5aqqRdFLUFQwLyhw1zVguClfUKEu4JVr86N
	 45R1IQrFhRGEx+Skb9YANI9upJ45toasgHakkzSUkq+Hi+FjyqbrNFijxhRYrp0u15
	 Li/TaAQl84OkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41B9D60A38;
	Fri, 23 Oct 2026 22:33:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E78F0371
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D927240488
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsv2mNrt59kr for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 031334016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792794794;
 b=NyXel436cbq2T0tXCDhqU5pzSladnX9958F7LITlPFXN5emRiWUrKbnS8ZeTZuiffuqC
 wjAwLh/r5L76mTnfbwcA189sPlsHEU0GTryQngmbT0jxU1qw9OdeL+7ci9eROwiu2frZl
 S+Pl71BS6j/y5kpickLRe0vhaZ85gODM5Usc0Zfejg8co1PImLKLFU21FU7JO37fxw1js
 NnVoLYKEsaznjGWNdaU+2C/khrk5ed2YN3R3IW7pPsGZocJes928h7PmrYwho1Xwq1ege
 deC631SylI9UcWx75vLpTEdEW4Xexp+e53F4Lk5IoSSGpV1MdrJQ2UxNFTyzKURfgAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792794794;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=RRkd12sEtukujyMNgpzCsexRAIRvGCwD5ktwbfNzpYA=;
 b=AvHEaLKNnwv3MM8Tz7JHvDiw98qNMEbUelNvdoIiVXzERb1Bt/ezKtA09As3pyRwriY2
 pqYgvzTuQtodFDYWLp7c3vldICPYkM5vZLQaf/TrgLqVvVuzNT6g4AxGeh/U8I0tbqCOF
 325gufxly8zIUCphQrsyiUJtNguxIx21ulSvCeIM1JxQ4quj+d3n1JUjig8CsW77Pm5j5
 JcFDGZp21IkJw8Rh8AqzB7euBeX0+x1EbMYJm8I/5izOpbumQiDVbdVkPPYFQEay5KbdS
 PnaEgq6llrNZDL/6PnWtCCspDmS4znDeYfDDHoFQnVbAtgyZPN7J2736vlWCuBdFZ/A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Kn17BGDR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Kn17BGDR
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 031334016D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:33:13 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-703be215729so621186eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792794792; x=1793399592;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RRkd12sEtukujyMNgpzCsexRAIRvGCwD5ktwbfNzpYA=;
 b=Kn17BGDR/NK/dRS7QQWs+9IVzzQHPlZBKdEcu4bWFGOpY6OaVq8ndl+AmLbp8HvU6+
 t/+5q1eJkC350LbiOfPzQqXT/Yl7EoOCMJuY0xPWO7fg/dquTBJQ9wmrneVADu8nT+HS
 Nj+LI4ARQgU7irSoQhnJdv4n8gO328l/GkNUWcHxFW/eGube2OAarowWYGGN8Y4DXXAe
 O6+u2ZoWYWJZqDwoAJ53cSf+m/Ud90AAkUfBhsDpvv5x94xQiblzGj4JL3wfM3MuQFeb
 I8Nz1bcLjsnf5hWd2sJ0OSZwwqJPkmZY1Xbc9f9Knh1Ww6VfkSjdbiQ72kVQCFAfVNdj
 zHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792794792; x=1793399592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RRkd12sEtukujyMNgpzCsexRAIRvGCwD5ktwbfNzpYA=;
 b=xS+gaEnEiAR3HiIqjMA3W8Y1OURnTKSzJGv7VUqNAfuZ2MoHtD9kTkUqkjVf5zLnps
 0Fxi7KkFEW/ozNTUniDGfRiPXrnQxIFiCFZdl0rxUmn/p1WHOY3UzgHrgkWPjNu+qTPz
 dSppd4AvDphxT8SOASsJ3OMxdNhZMCXbsMOQjyd7YBp5iqlktMdQTnjhl6yIGlIkSLo8
 5NlZcv/rz6RxOq6Rvqg0DPVITQvixkIYvur6skVQHRAMjHz69qZ8Jk1iflU8dVohf8X0
 YFQy+7BXQ5s4abxQMpc4FTWvNMPf5S8PFgQZ+QgUvYztqLeVm5n1uTmVHxpNEPCw2fqH
 ECPA==
X-Gm-Message-State: AFq9FYJTU9vRIxR9oIBzaWK1nix2O+ACd7b0mvdZBwDwKraQX98KVEPE
 2enhQEiK4X7CRntc16LBQATC6HvrDB0SdfkkCkT1AxQw1zGdpBebyA8HY9ACd0BeSKQ=
X-Gm-Gg: AYBFou3JRquqNJx1JEHc0PQeYL8IxQTd0URFpMEzycsmQTQOEQVS+Kn+USHSrcjG2ss
 NRNA45ctHZNqTK4eD5Ox8GxAgABUVAYGkR77cs8OXsxFzuZkvWMEUJ+9PMcK2uLb23CMhmD5RGJ
 KqNSOlVUrnDVacDMqMc3PwnpeZxuRDLdLbKGRORfxYZy8KGN0l/hDTWWpzjSyP9/gkI6pzaG0sG
 LtLakWbkE01t/QeLWTEZOYiU0UoNmEdWuYID6ORTP22xbrM5vYhBVCQ+9TbHCr9koJf6E3ggZlC
 1DC2837NL4qj9kxOMt37xx6cY0RlDy/65Gzak+jU5ULh7/wF5xXCrNZ4J4xZsYZo2vvzFobpb8O
 nzIvUS5vq70J715dPNs43H44WXaNGkL/ossZhQSlXlNpecPRkOQUpFOdbC4M7eaXDQ6j7nP57k4
 5v63FU8CHqKDWet545CTufLAeYHorPgNniJuuG65g5ZJVKPebZQ19NdyJp8G2uXRgRKeX7yZWWv
 rZ9odUD2HRyipK9vtvXeHpAveHAlMNMqpXoOogat+sm4dmwRDtCZrCiJ0Md
X-Received: by 2002:a05:6820:a28c:10b0:703:3ff5:ddc0 with SMTP id
 006d021491bc7-70ba0dcd5a7mr121619eaf.17.1792794792639; 
 Fri, 23 Oct 2026 15:33:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb0741c9sm696300a34.10.2026.10.23.15.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 15:33:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Oct 2026 17:32:44 -0500
Subject: [PATCH 2/2] configs: mt8189: enable bloblist support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mtk-mt8189-tfa-fdt-v1-2-f86616860bcb@baylibre.com>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
In-Reply-To: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ANmsHdjKTE3deIzU8bDha+XmfGiuIhzqBK/T/+iJXbQ=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGrb4J2jdBD05vmxR6A2Y+xaqML/ctmblKk072fuwRtmFsygg
 IkBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJq2+CdFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8Dx3Af/QjwBqqka8+3bRPKsSiOfgf/L7a85w04oqTzjSjgWsJWrwWS
 hE8fNmHkeT/f7T3yRegeOiPhHPoxnnmfWKcEPBjvgCwi66guxqUA+kK41W28RkvmlahpLdiCwXM
 PI3CI8GHtBH5c9rzCyCMIBQt0Hx30LYxzJjz+iN1g+BZc+LYKjXw7UtxfxPjBTn2nN26FkFtdg9
 jYv+KQasBTK7t/+DXzvmxqQU1IL56bPpJ05NYlGojHAfBiLgND/BXLBOcVTjl4ier0fdENDhXBS
 jiI35hZ/jV1VMsGf2boDoxpIThCmbNUpTUqGBvDAdlxntvdHS8TziQ8SwDcQNWIKQYTZNw==
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable bloblist support so that U-Boot may pick up a Firmware Handoff
transfer list from TF-A and apply the devicetree overlays in it.

TF-A BL2 can describe the DRAM with such an overlay: its size and the
regions reserved for the DRAM controller, which depend on the DRAM
fitted to the board and so cannot be described by the devicetree built
into U-Boot. Without a transfer list, U-Boot uses its devicetree as
before.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index a60f67bd7cb..0dc3c2873f9 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -12,6 +12,7 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOARD_INIT is not set
+CONFIG_BLOBLIST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y

-- 
2.53.0

