Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC42CCA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42D4D40DA3;
	Fri,  2 Oct 2026 12:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9hpgcMvvgKqz; Fri,  2 Oct 2026 12:26:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7589440DBC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790943992;
	b=ClAcbaA+kc6wLi9vcWXjqYpIQ6SvnUaaEGkTsRI31Kyihob0mUIKDhzAQpD5MF/s18GW
	 OhKKq1aVyA0v6yoDasGOjL9A9UcKAQO6zxA24WheUBoLCipkfbtsokmhu+RuPDo2oD89n
	 V0I7u0UNmIKn23I7QJwZo/ihUqL1eI7Id6W5fbIGCRt9hCAjDTRYVSJsoSf6MVMaeyznx
	 pJAthV29+xjIxjKZSY20LTKYbYCaChM6or5LdA3/KjN44e6AkYzPBjzOs/pcyhevKodQJ
	 relwKPAk/EB5ObMk3bi3ajeTGxU9/npRXXS6yK8KEQeql53/xV+wImVNuIZZte9cdUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790943992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qVLlzOqi4Bu5W4YAbkaR29OM8dslM69abB+OA678CmI=;
	b=s+XpMIw+02umBJbzG3bKA+kUlfF25440eN1jVtRGpvPZV8GA4xDE2zTrNRN9Leyu2VM5
	 U9S7OYqT8PECKr0ay9N2iGfL1sgwl6bVlUOxJ9lhe4+/IG/EYFxV9uiBonle/JKWvjQTv
	 hN5r3hMCWp8LgpZcjm1ioOlh8nHsJUg8ix7RhHYqZ19eFHwNaFP4uPzsKqVWo7VURVNBv
	 Yl0lUx9fbCC0Ut+s9uQFbKEZoerOsMBe8kMw2pGE0EcB7ctlCCRCvTXpyFqM7Yw3FDHud
	 h28NGFAqmnoYJ5ggeqqrGGEO5hNF9SJ0Tm5j3kh3U170Q0rtQCwjncRGnG22MnW38dg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790943992;
	bh=qVLlzOqi4Bu5W4YAbkaR29OM8dslM69abB+OA678CmI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TrFmLa4wQPMWZ8jkse2TCtpi4hFpWdfiMPBunHMehzlTZqi0+oODvB2oGNfNkip6K
	 TZCs+3aq2AVvR15xbIvo680ZvIppolsNK+orIvY9ZiCoo+9uGJhv6nDovwpbGgsmfa
	 uCiXstBoInsik19dw4ICPL5kMuEtVhu3yrXkNmiBa1rxDBI17Gwp7POTPaWcSC3dUk
	 Zi/MpCxHDPHugKTVBfI9k6OrmG0jGOpBrgJfxWzQDbltRREDvkJWEuuMRAdnALt+bq
	 IllfJ3B3a9BmQlwHFSpYn7xrxnhasdQR2bOVMblYQ0g+apOyuZPuXLqGiRNdaOYnWM
	 KVP+xBbaZNJXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7589440DBC;
	Fri,  2 Oct 2026 12:26:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3F32282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E60B1400B3
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PN36GgMrR4rS for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:34:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 619BE40057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790926473;
 b=VeWSVP7F4C8KQuTLSxOHPnCt0fCq+haI411ZEma1m+oRdLkobiqXMs+raGI/Czj7/4lm
 c7wUCQeN/UhXVSYO0GI3mtFDe929DqnR6x7oMGFBS/yUeQuwDClbo93izmN6Szn4wLbhx
 GQyJ7agSxt93PvKTvNzcEXwVe/onS4vPkz04Bk8Tvo0O/pnrfZ+15RZBBdDiNmmd2tbtB
 7wnALplJQGDF1MdPshN1B3ED0V3NqtCNBNEkDR4sraHaELVyq+vTOdr7t8wmgKDUjr/qn
 QS2pJbLYXXJ+1GM5apxJObt1HB8bnSIpx4BQPlDaJuQBg2cX8p3iSL7j66yyHEI6pCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790926473;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=qVLlzOqi4Bu5W4YAbkaR29OM8dslM69abB+OA678CmI=;
 b=OEBxNw5kwg+uNBqaiZbyEjpntjMF0jlfVLMMyMsLBGWddu3FMOxYV2Hny1B8j7IthRy8
 mU5MGeupiS/13Z4f5ljx3kTo/Nxfkm4LrTZktjyKVhFGQkJJ+mKx9FePYBYVYzMDD8nxE
 A8w5b8RazcZuOzAgDtoJaqXVFhPnxN+VIE+ucXhBYgo+Cqksd9ggV6bjRl+JcYpj2eFpA
 MXdl9jRJtlX18ynnSJI9I8ylLt4rgfY2F6FEoNn3a4lBNnQOShBoyE6e2ZnXoGE/Voobn
 MEqcBHYiHFZC2u/00I/9fC6gCs3zoCfUwkkSW7H6vR77zlkJ8GAB1EQVOjKFJCwfHeA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=KBtzp24Y; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=KBtzp24Y
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 619BE40057
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:31 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3B1CE3F2A8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790926469;
 bh=qVLlzOqi4Bu5W4YAbkaR29OM8dslM69abB+OA678CmI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=KBtzp24Y0rTX8WOuFrsvjJHhX3OwAJzEK96Ad/jj3GRU1glCTPVwLekXFLg21brhP
 v53FE0ozbrKxH58WPg0d8sIXuvisY/ToK9rZ0HEgl+3/DpIKmzr3H9lzPenNG0eJW3
 5cai+8m0LW6ClfMy5H2Vrxysg0w6liURzT9nF4FPytRGP/tW8gQNrtsmAXRmqeIomi
 MOaYw3WVY7pEzhrkzWpSCmtO9T2L3bA/qOOsOk89zBsdde4ku0Jx8qeVKWuaKylNmw
 iedZ1yiAcviIbHFHiiuG4nvxtIXDvUnVK77oGyuNltrL2Kxyrv+CERqkabvjCRmuic
 jmFbrhlD7p0xnpg1UU02ugh7XSBFJdafRj6UmP/0xTtBKNFe2Ikj/Okh1zyEJfIFQ8
 70u0fP1Mdjgavsh60baqUmS/5zUxUMcfxIT96gUm6SPVAg3jEYhAy1N9KdgaU/RsZK
 OkwaqWaM4SdJPXVs/1vsYb5CuiQ28MOlzhcK1lKRBPpqcJSraW737lNkbmor4K51xa
 shLTojhKWb+gfzQbvq71787WNYpP4YZ87GDNUAaRkCHGu30y57h5ZLN161MN7NXCNh
 Kfu+KL2yN6nKVI0qPLy2al4em2CgxDb5AVgrFTkKz24bB9m8FSHCy1i5Dwqyrm5hps
 7gNY2d1cKJ6Wmg3LHU7Pk3Ho=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a4e36d5a77so2440542a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 00:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926468; x=1791531268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qVLlzOqi4Bu5W4YAbkaR29OM8dslM69abB+OA678CmI=;
 b=Vf8cIn0gaKI/sY59tp3oETQug8mgW9wfGEgOKH0mWPX1i9ofOSBRFsiOMvOsWaO7WG
 9c8bujWF8fRrqDGGsdMHlU+WDCly2p23/Mn5Cmj2k/kw4C1xESWv/4TQbaP4LWSQGdMs
 1N2OBZUwXDregFomCznQdEh1FBD9AG7TkVcEnuwLEFsf63BOwUGrAzchxNntFzNW5REy
 qxjon0WGEWRvVXf6O9E9Is9Ys6zANHLOIfvKDzUfxOJbo02bI/xnMKvn8ZrlBnAA0Hnt
 S0PWmUWnK1LHjy2ljmyUM+uLS1aoaMCV+U645sl267AYxcfDS1VVKsVDUXNjXfIdj/dt
 hUSQ==
X-Gm-Message-State: AFq9FYLmJfvfauk7thR2XATc2HT/RJhXzsulfhZhXiLFkir1WnXBzvAe
 CxY9cRHNdPRRHyeJcwjC7RH5sa12FTdYmknbIKSPtZoe/2uFU4nYj6+2rNdrJf9uVFGK4BZzOnK
 BsjoCKL8jXbAhWuholim0k4l2UainpcyBve5WVJhvtGcuiNih8BaF9A7a9Aw7fzQ2OOOR80APSv
 U5xT8FwyjVqYNDy38CJA==
X-Gm-Gg: AYBFou18FXliEiU3yNC1I3zjTLSDIQ1s72Nb81jeAlodCI2Ix0qs8tMrqnUFSFyPP98
 KuxjN3enSSgf98PlvQeNgpknSjPLooyysPBqU7U7hBoL1uqFSYlXamk+zq2usckqYgJINetWSip
 FIoN5XtCGbpRYvo2ukZl7wXY8DaELS7rBAepE1msttKzqUAdu096828E+kxMHcEGpwMLn1y7ql/
 vdF6X4581dQxBiMB+6++h65ZJwNq8wIu6yybX6/DAbxGDYaJqjBDnXtC2AQ9MppjppInL0uE15k
 CgngAoCh0uyI0Zfm6SEr7kxU2Jxckx/eEMfWUixQbdcXuTWrdupAB7MRxr3WsGLL2WpZazNLiAL
 opr8A1cXxhvTFIa2SkCRLlS6ZfH9aVeiHe9+oGzTbTWRBA/2tmng=
X-Received: by 2002:a17:90b:260b:b0:3a4:f1f9:1cb2 with SMTP id
 98e67ed59e1d1-3a6ce6b4005mr1954161a91.13.1790926467669; 
 Fri, 02 Oct 2026 00:34:27 -0700 (PDT)
X-Received: by 2002:a17:90b:260b:b0:3a4:f1f9:1cb2 with SMTP id
 98e67ed59e1d1-3a6ce6b4005mr1954148a91.13.1790926467247; 
 Fri, 02 Oct 2026 00:34:27 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd44c2c9sm3172004a91.6.2026.10.02.00.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:34:26 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/6] Drop duplicate macro definitions
Date: Fri,  2 Oct 2026 07:31:50 +0000
Message-ID: <20261002073357.382228-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

Six files define one or two macros twice, with the same value and under
the same preprocessor conditions: two SPI NOR opcodes, two SCSI opcodes,
an ACPI PPTT cache type, two GT-64120 register offsets, an i.MX8 power
domain name and two constants in the video test. An identical
redefinition is valid C, so the compiler never warned about them. This
series drops the second copy, one patch per file.

Three of them need a word of explanation. In include/scsi.h the two
SCSI_SEND_DIAG copies also disagreed on the command type, optional in
one table and mandatory in the other. SCSI-2 makes SEND DIAGNOSTIC
mandatory for all device types, so the copy patch 2 keeps now says
mandatory. include/gt64120.h was imported from Linux, which had the
same duplicate until the fix for it was applied to mips-next [1].
Apart from that, Linux has only changed the header's SPDX tag since the
import, so rather than re-syncing, patch 4 drops the duplicate here as
well. In test/dm/video.c both copies sit inside test functions,
although check_vidconsole_output() further down uses SCROLL_LINES too,
so patch 6 defines both constants once at file scope instead.

No functional change is intended. Built for sandbox, malta,
imx8qxp_mek, imx8qm_mek, qemu-arm-sbsa, rpi_arm64 and evb-ast2600,
which between them cover every touched file, all objects rebuilt by
the series are identical before and after once debug info is stripped
and the embedded version string and timestamp are held fixed, and so
are the final images and the i.MX8 device trees. The only exception is
test/dm/video.o, and with it the sandbox binary: its assertions record
__LINE__ values that patch 6 moves by three lines. Each patch builds
for all seven boards, and the sandbox video tests pass.

The patches are independent of each other and touch different areas
(SPI NOR, SCSI, ACPI, the GT-64120 PCI driver, the i.MX8 device tree
bindings and the video test), so they can be applied one by one or as
a whole. The series is based on next.

[1] https://lore.kernel.org/all/20261001053016.76578-1-aristo.chen@canonical.com/

Aristo Chen (6):
  mtd: spi-nor: drop the duplicate EN4B/EX4B opcode definitions
  scsi: drop the duplicate COMPARE and SEND DIAGNOSTIC opcodes
  acpi: drop the duplicate ACPI_PPTT_CACHE_TYPE_DATA definition
  pci: gt64120: drop the duplicate GT_PCI1M1LD/HD_OFS definitions
  dt-bindings: soc: imx8_pd: drop the duplicate PD_LVDS0_PWM definition
  test: video: define WHITE and SCROLL_LINES once at file scope

 include/acpi/acpi_table.h         | 1 -
 include/dt-bindings/soc/imx8_pd.h | 1 -
 include/gt64120.h                 | 2 --
 include/linux/mtd/spi-nor.h       | 2 --
 include/scsi.h                    | 4 +---
 test/dm/video.c                   | 9 +++------
 6 files changed, 4 insertions(+), 15 deletions(-)

-- 
2.43.0

