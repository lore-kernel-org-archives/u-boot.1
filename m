Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A11606D80C
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ksnWWOPt;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=QDD7OjpW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69AFD81662;
	Sat,  7 Nov 2026 14:34:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0LxAf--EmCJ; Sat,  7 Nov 2026 14:34:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E175581ABB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062059;
	b=O4RGtZo0NTVtgNAo6qQjhdguiu+g3kAbMacpzJ3KONStRwHQIVnbpLWDoev1UtLccTyJ
	 w3fFYjLlHS9+cvv5F2ChFiKzqi2ANa4rxClQBIcGfWSR0+uoHCFGXGtn2V2PZGL2ywvKD
	 GVzXyXWyOysqqH6G8VUuVB240JLaUwSppBtjVZuuCDqdb5wOcu5uw2pRi6ORKTmCX2ts/
	 CKO9C4JHlC5tvGqPL1kpo3D+ir1jd1Co/jtPOcjbR1HVVgahHeWz1sYJI5ZV9pxfGnjLi
	 7Y5V54Shh4GYYuOZBjHtQNshXOwgaA+9Cz3hTR9E7jvLikjpAZVBo+8GTw5IfvEMZnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062059;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=07bXEWUGdpmQKBZwO1ivQCclZ5Qr10T7Tii74FMI6lI=;
	b=DLJic+wBAtAFsGsJnW59M5LQWtncDHg9o0uB2cSmwz2Sb6JrLYx1KYWEmDN1miegW2Zh
	 znqCMevrkQ421Q/3Ya31CTVcOYEE0g1E4BpFHcMkIyGNnGAEilQYIbg7G9xG1AsXuE26x
	 3SPVtTtuM0cfBCifG+ww4tchqHEtOjy0gU8QIW/l8IZ7PypjGRsS9trxzddSZXKPEDpAb
	 FyMIko97mSFpMF2Hv1rEArVI+bC/mETkc4DVQK3Qh7C6xBK4uQFunhRuHHwKVATvEEBr4
	 dxVZpp7TAVq0nA3e7JauVy8fdg7a741HCDYzVesARgr3kHooJ9/uRnvdLThunP/DQGA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062059;
	bh=07bXEWUGdpmQKBZwO1ivQCclZ5Qr10T7Tii74FMI6lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ksnWWOPtc2TBfLnnKcx3Fcg6eu7im1BsQXbBVXT5aiGN334O7je7XAUdimUpLkGrk
	 /DpqvTce6CEug2mU+5u1Yo/tVgpRQ6pdH0CbIr8HmovK7GXld1U791ZQMcdFZBcqbH
	 S2XgT2RU7a7hDJ2/cV9KFEsGt3VoMBx3MZGZD23FjyiPZm4olMziFpFmT116s+9GMF
	 E6pno9RZ1ATB65Y1qys33CKY3xcDFbG5736pqhfchOZ2RUGcapDQuHiYS3kHIOMqNe
	 Vs+sNxxvz0+SlyIvXwvd2h/y/6Zt5b4JyXvxdT66UATG4si2ymH31pdnzhUChnfIYw
	 Fyp36HCvMaKxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E175581ABB;
	Sat,  7 Nov 2026 14:34:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D8274B8
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 949DE40762
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bn02eHLFA6Eu for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A8FC84075F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=QDD7OjpW
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8FC84075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:49 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso787389f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062027; x=1794666827;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=07bXEWUGdpmQKBZwO1ivQCclZ5Qr10T7Tii74FMI6lI=;
 b=QDD7OjpWfHQ9v35aeAleQkCGRiFBJ5poTdVAHPmLmXSlRkGQMfd0lBznjWqtrchFDp
 wKem3KGQg6jlmNN7tnYA2RocqzOAgzgOQND2xmJclRDdRlJBLvLE+05Hkp0UU9M0S6D6
 FkeQlXbZhP+z0jxYs1WMV2zup3YntolX+EFF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062027; x=1794666827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=07bXEWUGdpmQKBZwO1ivQCclZ5Qr10T7Tii74FMI6lI=;
 b=tWeetSa0RV8AUrvK6/di3oo/HdfHEv0XW5hclrbT+IoX4oAXi9PiGpojfClSq6gHDq
 gFisVFU959WYg+A3L4LCwhj9nHil5VlouS2t4IKhkYspD7LAmYuWlQ5p71T3SkwpwdIQ
 w0VaYVwR7DRzD+h5ayW/cibyiZpXnIqFDcrRQld8u2oxBiWFf7xDjf27euwZp6rWAGq7
 8supRXiyMHSX6POfUMZ3fSJ+G+10jTV64EaPeIvb3tJ8M6BP3utg9o7TBwZNfBf1LUAV
 ovOX5zSXVtnWkHmtrJA9jUe3nfd4fEvBRRxlO6e2h9AvPK0ZJJVriMCSjM7pdwdg5YRi
 WK1g==
X-Forwarded-Encrypted: i=1;
 AL+hErH+gK+CI0LLJSwr0dKGRcf3JiQao/NR4Jd0dL0yLOl8RUtsXPISFgm/xBYFZsp9LDK/OeXFN+c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z944Kzr74MdZ94pIuf6GkoPZrdEAzTs9M5meQiPmmBCxlFFlRib
 PheMQwx8ZqNhBonsI6FH9895WUlXF84mVJj5B0qPi1FYsCmY6yFtn0Y/S0Q7AugPi0M=
X-Gm-Gg: AYBFou3R1dtYJFVfztapkb/yoJMOfoJyT8yAEsoyBRhQ3tb55+7o7Lgtid+ZoKLiAtn
 GSDNfMtI5OTnvTQPxJQFnbcieRkkbDg1BeVeVOPo0v11PFGcMALgP1885jUCHREd+WgZ5dd+a3d
 3/eIy3jflL/vtyjBsjpr0AnmwtZ9gt84gQjj92QRrQfyhUNwyGX0Vhz6OTAjDN1SmdCpCTmmsdg
 Yt+U00LuPkyqFQJMSZS0BIe5i4VgdClyDYbH0M+Ef4bThdg2jfnr/lOIiDlo5cOnCTlrvoBGsW9
 fLXcmw8eN1YkNzNmehP5HclRGM6XMLr+8aztipIwZFnEApLScjpk5KCQnKauHO6VYpLEcMPpUkp
 aqqk6RLLEELc51wDjSx+gAg2gzJYeXrsjvvkeAPqi4eGNOITL9RjuSFStB20me5eqmBxBxGp0er
 9T+GqTmz5Vw5IY8zKSLwKCebWuMUITnDra4GOzWRXnQ6e2s8G75535bTnHPvcZM/Ij1kb7624Cl
 ujJY2BZ0gbVsyUpSbFSAfU7moDA7rgy8CwSsWj4m2eIFevF2kVFkRWrgFC9ReOuwnG/2qN8Vf+V
 CtXhvFFIDAWvfwBEiFJpKQO8YsGIs8Da3IeUMTc0arcNgTyVv0miSgQK1Lhocku/PDOkOXHQHgL
 OIC4EVRJ/28oIp91+A4PZtLr0fLaRa0uVGMI48wXMPpG6aUNrWFIi4htA5Hxgn8Lll7X/gf88ed
 93dA6p3h5TnXPh8SkDFdbMouLEhA==
X-Received: by 2002:a05:6000:2506:b0:48d:ee35:b3fe with SMTP id
 ffacd0b85a97d-49273f500cfmr11244267f8f.8.1794062027430; 
 Sat, 07 Nov 2026 06:33:47 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:46 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 31/35] dts: support applying DT overlays to the control DT
 with OF_UPSTREAM
Date: Sat,  7 Nov 2026 15:32:21 +0100
Message-ID: <20261107143241.2236511-32-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend to OF_UPSTREAM the support for building the control DT by
applying DT overlays to a base DT, so far available for the DTs in
arch/$(ARCH)/dts only. The upstream DT overlays to apply are listed in
CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- New patch

 dts/Kconfig          | 10 ++++++++++
 dts/Makefile         |  2 ++
 scripts/Makefile.dts |  7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/dts/Kconfig b/dts/Kconfig
index a2973ef40860..f8cc3b26b10f 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -137,6 +137,16 @@ config OF_UPSTREAM_VENDOR
 	help
 	  Select the vendor to build all devicetree files for.
 
+config OF_UPSTREAM_CONTROL_DT_OVERLAYS
+	string "List of upstream device tree overlays to apply for DT control"
+	depends on OF_UPSTREAM
+	help
+	  This option specifies a list of device tree overlays to apply at
+	  build time to the device tree used for DT control, so that the
+	  board can select at run-time the hardware they describe. This is
+	  a list of device tree overlays (without the .dtbo suffix)
+	  separated by <space>.
+
 config OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS
 	bool "Build local DTBOs as fallback for DTBOs missing upstream"
 	default n
diff --git a/dts/Makefile b/dts/Makefile
index befc6de18056..3fee5a0515c0 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -32,6 +32,8 @@ endif
 
 ifneq ($(EXT_DTB),)
 DTB := $(EXT_DTB)
+else ifneq ($(subst ",,$(CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS)),)
+DTB := $(dt_dir)/$(DEVICE_TREE)-overlays.dtb
 else
 DTB := $(dt_dir)/$(DEVICE_TREE).dtb
 endif
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 3871a4ad4123..5067f6ea2daf 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -16,6 +16,13 @@ dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
 
 endif
 
+ifneq ($(subst ",,$(CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS)),)
+control-dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)))
+$(control-dt)-overlays-dtbs := $(control-dt).dtb \
+	$(patsubst %,%.dtbo,$(subst ",,$(CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS)))
+dtb-y += $(control-dt)-overlays.dtb
+endif
+
 ifneq ($(CONFIG_SYS_DTC_PAD_BYTES),0)
 DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
 endif
-- 
2.43.0

