Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC7E6070992
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u5J39aPW;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=V6SrEXJD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD61581199;
	Wed,  4 Nov 2026 21:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dAGpHze3DXfh; Wed,  4 Nov 2026 21:52:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AFC5810AD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793829160;
	b=nrCwzEYEIAgNMkFwnKyp27xQ1KB9dc2jNSZTSglM98hJAKBvVwH2MBigrTbZLmETty7v
	 bYqb27LmLuLU/1CybGnWen2NM+AWo3w4f8wyXm4e+4ZIixzRJ/72MfF8FoR+Ltq3iA+sq
	 O+EUf2EdYhPSSZ7X8Xfrv+IoMG9JGyCSKyFLui4zp5NmAdVy5mh5hfCGhqJW03DpJR8N8
	 DnUCqeh39a5OLZJOcvPDdrGkUl9Lqnbe+lABmK74xW2sxzpogn1eIohvQ724prjdsVW9j
	 C1wgfYgOta7yDkZnJQaVREckGW6efizY0lggVDCXIliXsvVj+c7DSoFsORcE65K/fGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793829160;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kDkO2gJxpusLq22TVPswNUMpYdnJtcq+LzlXiWAjJwA=;
	b=OLs9+QaNbr8BJNAcpnf23OQ04i1dBJ4m8m7ghMh1xpz5ztT8ttfHER7dlLSGy1A5gpoZ
	 1HsDrncqdqMPl2is+/aHduSZFKN74m3JOeh3dOoEAFRG7lDgwx1NsESzJ5yGiNBiTpHO5
	 +jOMixdvqc0sDwgTOQlnp7l5m5yjmd4ZfaMsVd3Vku9RgvDT1dyaoJY5Hz9BlgOhZ4FqW
	 Y8rMroRHiI22RSLIFmpfdBG5Uo6eTnOjWk8oNktLDmjbYKEri/ycz++vQkEszNNJW2Lfc
	 7TlGxSisyWU9KxocUfxPsInuz67i0lwgGYs3icZV8oVgBtvRQh8sGfm15HP6KUgYmBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=V6SrEXJD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793829160;
	bh=kDkO2gJxpusLq22TVPswNUMpYdnJtcq+LzlXiWAjJwA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u5J39aPWe36qK8jdTjlzAmKEeS9RL6dfRlddANpxewJVwbdReEKJjco1Cnuy4hONq
	 tbuSJ35bHW+WPG9DTECAOkRPcuYWBfqu0lOsrxQvUBQt7ES1WU5hSjwCG0jkALwUyG
	 tifKWqYZcZ2+e0J8YpwhjsZtOR27BeFXd7uulsVrrD+IkRQF2RhgcmJcmt0hK5V+Jy
	 lkonGjx1M82gQ7yWaRLGGWPrFd37mzDiE5ryWRUy6l+OptDcj2wOoIbb0fhBjjHiyS
	 DdZgOVINvy6NRWjeY5PMTtUn+TRMWFwHZI6CrarYw8pNs1Cf4fhHgetrrZS4v/gRqP
	 T7rOeFP6zu/hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AFC5810AD;
	Wed,  4 Nov 2026 21:52:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D91AC362
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF20480FB3
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIRb2-A0MIjg for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 21:52:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A7F1E80F75
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=V6SrEXJD
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7F1E80F75
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:35 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-70b875f6f1fso1118153eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793829155; x=1794433955;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kDkO2gJxpusLq22TVPswNUMpYdnJtcq+LzlXiWAjJwA=;
 b=V6SrEXJDl8UnCD9vTLOzm1ItrgWUebQtFnKIQ5OeE0Iq3/vEYRP8kBI62amkHr0XkF
 HwQ4p9QJgx4EjVPPdOdwprs0L4krjFmlUJQyzdd4hY9s/lk8m7GhFbxkdwKKRJYvvtjM
 1Tt5vvsCBbVNkljYBKHKddHLRx5Bn4uwRcdjRkv3Z9ARvItxjveTHYfxRnX/i+XE39lz
 Wp0JtH27eFvgm8zTqX1XBatU0Y0wv9WvaIbXOa0EHQTcYY/mKOKahu2NrlDWK6DW67oE
 /Ha6KTfCAQjbgbMbjDl9N789/3B8WLkWmxTe5Nn+1W5MLFBxYNioRX0I7ab5PwR2f7Kh
 VAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793829155; x=1794433955;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kDkO2gJxpusLq22TVPswNUMpYdnJtcq+LzlXiWAjJwA=;
 b=KmIMEPPMZxbTkHAzdm+86HzyRn9VGNhPzmcN/j36ST+FISvIKpjsQhQrG00fdmnWZB
 T44yqtqzkEmO9t71qXpIAlL7icOG+joSayiqIttl3CuKkzuU+EUjxahhhB7fE8ogBYDy
 CQgBQBbr8hBv93qGYPf1cnexfxpL7cSyhPv1rvGeWEgEvxomXubmPRsTyIdMhUXK/oO8
 69zQBCiNyLZ5kVj9fMPaZ6QHnHr83cbhhy9AWtwj0scuznFIZO3HDI/gX43g8J9mmDOZ
 2Niao4rsq4pcw6YSJh+1dji/PgQXUBQnv3MCpSuReEVtEQxMaS9ybgc384kB/JsBuim0
 Ym4A==
X-Gm-Message-State: APuU4Z+z2qGX/GJFt/ywLkOJ9i/OQ+wjgBH60msFGXQ0WlowQX7/FZvW
 If3or5F3xjGTXo3QQ2JnhNhZxAHOP9IP8OzqYABxaYta896FkzfPlIL8foY+HaxCIRkqcGH0jaJ
 SEmBlkr0=
X-Gm-Gg: AYBFou1kPkrQ1+GEDglMTYcTt+rMmZqsA+O2g7H+Bmkq1/E+bSMN6OGKjM1TNxnolUd
 zqIquaIHURgpJhd6cvt2cFi2nGcyg3MW6vEmu8CPPv90wk94ls+N00GVUadlQvQzlB4rj/CT6mH
 8HStbo1T3GVOolqTgS1U1iELElQTjEniU+3q3JU2YH4bjemVnhQnvQbE+BaZ3kLJWSIweZNOk7g
 KzQI8RjURAYASkX0RiDhc9yfK0O0fyzCKo3RcSivTByZXHjXUL8WCf/Ri7tNdcm50UVaEV/rffK
 dTBYm6UuOchBar0ABGMsy4+Gq1dB5S9oEuOxBaN+oGtTooRnge12CKIqILJfBL1DtlZRqQQQCsL
 hV0IbO/usJgQFsmCmhC+OlhMEHVQJ0SmECKyX+qazFKenZb6FRPfd/Ni7cseZ9XPFakyPVapQKU
 EI/rszvXmgv0vibZr6f5RiuDJCKvGEnIHIRVbR+B/qQLEVUsA4z1U5WGmfNooaKp4MS86DFGy3I
 IYNaw/qnvfYF1Wgo9jVePWQWsc9tlD3//F0wWKpONm58DJ8/wUCbdfS6wng7z8oZJYKAZPqbO2B
 e8TOZgElpbRRGqHl8iVVy5Jnb/9VEjEI
X-Received: by 2002:a05:6820:1c87:b0:6e0:fb60:d5c8 with SMTP id
 006d021491bc7-714f24f979cmr11251378eaf.1.1793829154957; 
 Wed, 04 Nov 2026 13:52:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12d1f36sm2479415eaf.8.2026.11.04.13.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:52:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/4] spl: pass the bloblist to the next phase in registers
Date: Wed, 04 Nov 2026 15:51:53 -0600
Message-Id: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7Zi2RDCuvIdhQcsANZU2HSQSw
 t1t8QD+3Uv+f38DpmiJ4VZsEGmxbP2UQJ0KMGM7DYS2SwxKqEpKUSIHh9p57SzPGFpmjDQwlrI
 Upq+rq5IS0jhE6u3nED+aH/NbP8nM2ZYbYxL4uB7Pi8y9vyeLRIE6p6bq0nfdXberszrS2fgXN
 Pu+fwFpAE1q0QAAAA==
X-Change-ID: 20261103-spl-bloblist-pass-regs-3130cf768211
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3184; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8rDmYxNiZXeKz+l+t/RAq5eqRxlIrqjtLuOXeaJdNpU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq66j9mis/x2gFCOYGuB9LdYr/9gP4a2/HK0A5r
 k4fZ6TSUHaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauuo/RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AV5UH+wUVWSwbS8QpDUtY5Lzkc9wE4vP4WpqAlLPYOOX
 Qkg8b4yywpFou0ei0IJjhZNBXi3kr6Y5PaTdTvhxGmyTdwwXsPjpRRDlVmEP2iReuRmV3DURCVw
 HjBtyFm2JzfeR+yxeHZ++mAnPZ42OF12zMzM4CWU0sJs6VUdTVl6VeSATWc61jDHyfaOd248j6h
 ocOR8eLbGoxTI1HA2jmBds0weKp4PrnbXLAqVJlvVaoyXj8fzBLGDgbPw7Ymw5NsO1t0tauQimK
 opj2Ykp6FsAlsc9Ws90M8ZSfxfVoeGcLC0iBFDFvD/eRtKpXlkLwUtW9txNJLiyp0rUUOZHMawE
 PTmI=
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot proper already accepts a bloblist passed in registers with the
register conventions of the Firmware Handoff spec, but SPL has no way to
pass its own bloblist on like this. The only option today is
BLOBLIST_FIXED, which needs every phase to agree on a fixed address.

This series adds config SPL_BLOBLIST_PASS_REGS. With it, SPL works out
the register values once, right after it finishes the bloblist, and the
default jump_to_image() passes them to the next phase. When SPL starts
BL31 (SPL_ATF), the bloblist is passed to BL33 the same way, through the
BL33 entry point arguments.

The register values come from a new hook, xferlist_to_boot_arg(), the
counterpart of xferlist_from_boot_arg(). It has a weak default in
common/bloblist.c and the ARM version in arch/arm/lib/xferlist.c, so
other architectures can add theirs later.

This replaces "spl: atf: optionally pass the bloblist to BL33" [1], which
only handled the SPL_ATF case. The Genio 520 and 720 SPL series will use
it.

Testing:
- sandbox: new "ut bloblist reg_conv" test.
- QEMU arm64, SPL -> U-Boot proper: on top of "board: qemu-arm: Add SPL
  support" [2] (which also needs scripts/Makefile.xpl to skip the SPL
  devicetree when OF_OMIT_DTB is set), U-Boot proper finds a record that
  SPL added to the bloblist.
- SPL -> BL31 -> U-Boot proper: Genio 720 EVK.
- 32-bit ARM: build only (Cubietruck with the option enabled), checked
  the register order in the disassembly.

[1]: https://lore.kernel.org/u-boot/20261023-mtk-genio-720-spl-v1-3-f2c0ee094fd0@baylibre.com/
[2]: https://lore.kernel.org/u-boot/20261009-spl-for-quemu-arm-v2-1-460427488c17@gmail.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Work out the register values once in board_init_r(), right after
  bloblist_finish(), and keep them in struct spl_image_info.
- spl: atf: set the BL33 arguments after bl2_plat_get_bl31_params*()
  returns instead of in the default implementations, so that boards which
  override these functions also pass the bloblist to BL33.
- Link to v1: https://patch.msgid.link/20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com

---
David Lechner (4):
      bloblist: add bloblist_get_reg_conv()
      arm: add xferlist_to_boot_arg()
      spl: optionally pass the bloblist to the next phase in registers
      spl: atf: pass the bloblist to BL33 in registers

 arch/arm/lib/xferlist.c | 23 +++++++++++++++++++++++
 common/Kconfig          | 17 +++++++++++++++++
 common/bloblist.c       | 44 +++++++++++++++++++++++++++++++++-----------
 common/spl/spl.c        | 21 ++++++++++++++++++++-
 common/spl/spl_atf.c    | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 include/bloblist.h      | 27 +++++++++++++++++++++++++++
 include/spl.h           |  3 +++
 test/common/bloblist.c  | 24 ++++++++++++++++++++++++
 8 files changed, 190 insertions(+), 17 deletions(-)
---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261103-spl-bloblist-pass-regs-3130cf768211

Best regards,
--  
David Lechner <dlechner@baylibre.com>

