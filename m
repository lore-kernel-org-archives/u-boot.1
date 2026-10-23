Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9CB606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=if7mxWre;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jw7xgoRm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F6496069D;
	Fri, 23 Oct 2026 11:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fv-CYkbtiAWZ; Fri, 23 Oct 2026 11:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9907260666
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754167;
	b=R7fg/9/RJGN0sxNjIw5aDnY3eb633s+MFIeDkVVHseFsFgRw2+TWhYZhKQ9RdIshQ69d
	 Yi6sRiaDdr2UHtoc9PAN12qvthhUVwpjE8UhB4upmkeelQxH0WbmKH4FzxOQ5rgd0Tmxa
	 avS4ewuRxvZRK5lvCoZgjE25jxdKMhKbK1pCI1wT4ssykkr9nDtJ/taeb0ZjgI64GpZnx
	 Lmo3+h753eI3Mgn9DkA9JkftO7T9Q81sxRcvKLxihKjsCstUpuR+t1WI4qUzHDvgDxrdP
	 2/nVq6plvaBltoBj9HcW1ry9nGY1hz9METxvLCVCnNl9NeUkCUfPCtE1gJXPoKw7r9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PieyAkXWefZUz/r5QWXBYkN+NsZpTfzBM7cfWnc6p4w=;
	b=bcQS+b9ctPlzGp2Wmh4Y8NOjAVb5qU5qv5K7Vk8rZ+ZqA59XfV/qHLajMeDJmq/RXp8i
	 Bt/36qGYqxHGb+RwMFhbdroYGqFiyd57lGwLzknZECKYw+HAW6vcPRcdhRpAge+P/a3D3
	 o3shStX45vp8a57HAo/h/XFBj5DEL7y3HG2tk+7dD49A6fyvezV5lOQMVoc6gvDrCFx44
	 s670hJK6s+k1IQqrfTW8IvtU2Jsa3pBdROFNXZG+Tme1kVy8rbG94Oo3qwKCRESRNC52T
	 HWE9tQEbYDU9ffO2R27FoioeBVQeK52MHrspqLZiEJ/UwcKuN/FnCQ/wAcqgz5FPwuQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754167;
	bh=PieyAkXWefZUz/r5QWXBYkN+NsZpTfzBM7cfWnc6p4w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=if7mxWreFqlOuoySMs+biVCw9Lc3KmDs9HQKKjbA0cp4voBGUtFddLb1wJiYlQ4Au
	 jTJYMmFhrR3sZvRCixXKUhwvojwIMONyxhLNXRCi+476GW0mqEdCZI7zXlnc5jSV5U
	 yQ8fi24MniNXAGzIkGqeh6XMrd465CpBlKAoDNFKdzgVWfW8xSiPeVpU7PQqaKRXCO
	 OitE2lpQ3aBbAOmsqkUesCX28d/yQ3IvzjHcX0WEk5liFIArmzQpcyyH/hrkwHmI6M
	 xtrSZjT//qqH7R9UxiL3FYZqX64lScX3HCVWP+mnfLrckLhZCfewqd1QcLdim1I1Xs
	 Ki0p7slXRyeJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9907260666;
	Fri, 23 Oct 2026 11:16:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 04FE3235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE14440904
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6NKIVEX0uvVG for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:16:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8689A4082D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754164;
 b=djoru+76YueVKzk4+BtWWVlrKXnA2Ep84CXHJ3yJFlqtwD6g6E8hK0L4S2/iWdVsJZml
 o1KWwF3uENzrb1DlzAjud1kd2944qnb8LElT3ti0szEvdlmn9/03+ottzaZTDn+ctEoBU
 5I49PknjGMlK7uFkqsX6frJQ2diwFmM4eHGBNP5QRhFBU0SWJr7iLzT4rLgepXHBiGq/7
 HI0D4tjNW/R/KyQ1EmtbTkTiJmgGM1l/F9LGK/ag5SB9XLzk3M2y8qb2zl1R+raetJ/vP
 S57JgUUkvlsSVPyjePPHud8YyY3C2OWNjWYnrXu2iYlcIrtkrpfFOLsklP+vJEXzsxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754164;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=PieyAkXWefZUz/r5QWXBYkN+NsZpTfzBM7cfWnc6p4w=;
 b=g+0VqRXnQ4rx4Le8PbOcdsH7THIBD4AE2/KL5VnD99fwwBJLPTnRPiOKS75Oo5ruLtpn
 PLCG6YC/wTsdBxllhPr9n2O7ScI1iTiYaUPJSnLBbFGlUF+syKb59HVcCax4A+WO64S37
 IMe7C+KTJCMCIN3/+cAc3l66/xhUDNw36Loh1Ju1Mhi4BApdVY7fiE5ECGKFfl+QqeJBV
 JkvMKpaaqqUAXTuBTG9qGV3YhsYaY4IxBlNTcDG8yHBJ8n/dEPrLMw7vBwSKTCKFnlloN
 ppErN2b0H0H4sTAr6NXKq3hO0mjPoA6sUvA0KhMA40tT5F3McEc7i9mcrc9CrUQI+Lg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Jw7xgoRm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Jw7xgoRm
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8689A4082D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:04 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so4201005e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792754162; x=1793358962;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PieyAkXWefZUz/r5QWXBYkN+NsZpTfzBM7cfWnc6p4w=;
 b=Jw7xgoRm93Qpxi3SRlCqCadTFuQHLeqTBGVyAlI9Kx/jqGxSV8kFvnq77Osy2q3cVw
 VwJY8l9s7UgtFFKWLSmcFHN2/6ic0V1/i9MlPK8qwXuSesYpghQb3jJ6ZQLOcF5heoGG
 p06nT5gq65nJofxbh4foRCKsZSThSfwCWLGAwxxHNS+lCH6m5FbA01qe2n+KV/bwI3+M
 HdlBRLYMeBLBpJTgzwKIgnenKaE60LP2RZWBVgeiXv1oRG0PanLSOB+cppDJ6pGri6Zi
 bOJEwulqh/DTY1CpI2sTJv5f2HbkyQ57q2DJywdgQlXlA0QFciB5qXUcWWCVifA8Gzr9
 5jfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754162; x=1793358962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PieyAkXWefZUz/r5QWXBYkN+NsZpTfzBM7cfWnc6p4w=;
 b=FSlq07qSJmCFheVZTdnsfFnBlUk4CW2k0OH31wUnxMXjRY0rEc4C/emMlPyygjyLXr
 zewKZ8lEMBRTqvRWax8dR8ua8FTZIdvrtMPj4d2sUwNh4xUgkT06o8MDqzf7Wt/c40cm
 GrhaypT7eNoL50gRLWOLrNHeZy9hTF8Dx5GdbZfWSSJwzmuN5q7O5Tu0AOS1v03wiYPJ
 M9mjCOS1AwX4acwlxoFwKH+0HEprXZPncRWjlLg9Pau2FR7+nKasWOz/avqnHQgf50z2
 HQ6lDHqHansl0cC9jKkkwBopvXuDpt9+g5FtDG2mtEobL64gXhp/fXrhjaFDTY2MefaT
 F9Dw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnsbZhFQAN4vStQ1xofHXsfB/+XXVA4OnoRvRcoH1gfdw2KJqd2OmQYkt8e7UR9qItaORM1Rk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJKWGjRStS18zODDVW+cdeYAr8sUU3v7nhPkqjHGjpXZRF7+eYZ
 wLykv6h1BXKvKyyCGYGRwgN4x5JeVdxkW8SfhI41PsWVu8YWWNJMPGLb0at2djGX
X-Gm-Gg: AYBFou1Crjk8SfzpQNJG8sezt9Az2EFIyE66ZYAuMmFf6REtDA8lAW84TVzLT68BmDK
 sxoqv1gxojPkVD62GTd8BEb3hTKgt/tmwLZ9pluBFUAilFppkAOu0EyfvotsUx1wqVBF4kEHkr/
 hddzOciIKotf6UmyoH4SHsJhZyf4bYejxZE1f9mUtWzKI4TG97MvvnMLeE82fw6J+QPlrLOJrX7
 UdDDq4T9DP50Vutz5qctUyCasQck7EbhAJ/OZ03dVI8YFLL+Ir86jZEcOWvVcrDew8m+Un+s4+Q
 7Ut9qyVEwkofUatPTYR+KfyGxpo/Gj2YrJSxhQ/lxicDWhA4lnnshW1PmjUxf4FLcWf1AqK6sI+
 gMFPj2WFjKTl7V6PDeoas3/YMEx1Y8t728Q4r1EzeA81N1iW3SDIyfuTR1md4TFwsj+46gImM6/
 /7drssA0fdWUHakBDh/9m+ztC0liJE/9c5BEX4VQZirc7SJf6RZsqqecJsv+9oSYZZi5JBNz1Xn
 k8FDPHqOmuzTR8Hjdw1Ewu9u1/ivbSeoTJ6UBCV/SMflxUH+jjyPIlgMgAsNA==
X-Received: by 2002:a05:600c:c08d:b0:4a1:d49e:9ce with SMTP id
 5b1f17b1804b1-4a204ac82b1mr90693365e9.2.1792754161841; 
 Fri, 23 Oct 2026 04:16:01 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edcf9csm4596141f8f.4.2026.10.23.04.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:16:01 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v9 0/9] usb: ehci-vf: make the USB host port usable
Date: Fri, 23 Oct 2026 13:15:50 +0200
Message-ID: <20261023111559.4081795-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

"usb start" on a Colibri VF50 or VF61 kills U-Boot with a data abort,
and even with that fixed the host port stays unpowered:

- patch 1 makes the flat-tree alias lookups match a stem exactly, as
  the live tree does; their prefix match is what gave the two USB
  controllers of the Vybrid the sequence numbers 2 and 3
- patch 2 fixes the data abort: the controller index came from that
  sequence number and indexed past the driver's tables
- patches 3 to 7 drop the dead non-DM path and the empty bind hook,
  take dr_mode through usb_get_dr_mode() and the ID detect gpio
  through the device, and the PHY, usbmisc and anatop bases from the
  device tree instead of the tables
- patch 8 sorts the includes
- patch 9 enables the vbus-supply of the port

Patches 3 to 7 are the follow-up Marek asked for in his review of the
data abort fix: the PHY and usbmisc tables are gone, and the port index
that is left, for board_ehci_hcd_init() and the anatop registers, comes
from the clock of the PHY.

v9:
- Krzysztof's review of v8: patch 7 takes the port index from the clock
  of the PHY, VF610_CLK_USBPHY0 or VF610_CLK_USBPHY1, instead of the
  usbphy alias, which is not documented ABI; the ofnode_get_alias_seq()
  patch of v8 is dropped, so patches 6 to 10 of v8 are now 5 to 9
- patch 9 puts dev before vbus_supply in the private data (Marek)
- patches 5 and 9 carry Marek's Reviewed-by; patch 7 drops his v8 one,
  its code changed, and so does patch 8 for the one include it now sorts
- rebased on main

v8:
- Marek's review of v7: patch 6 reads dr_mode through usb_get_dr_mode()
  alone and takes USB_DR_MODE_UNKNOWN as host, for legacy device trees
  without the property; an unknown value now means host as well, as
  in v6, instead of the -EINVAL of v7
- new patch 9 sorts the includes; patch 10 adds its two in order and
  leaves the argument of the reset hook named dev
- patches 7 and 8 carry Marek's Reviewed-by
- rebased on main

v7:
- Marek's review of v6: the dr_mode patch is split in two, patch 6 only
  replaces the private enum and the strcmp() chain, the new patch 7
  moves the ID detect gpio request to the device and into the probe,
  checks the results of gpio_request_by_name() and dm_gpio_get_value(),
  and frees the gpio in a new remove hook and on the failing probe
  paths, so the probe that follows a "usb stop" can request it again
- a dr_mode value the driver does not know fails the probe with
  -EINVAL again, as it did before the series; v6 made it host
- patch 8 keeps the u32 portnr, the alias lookup writes a local int
- the tags sit above the Signed-off-by; patch 3 carries Marek's
  Reviewed-by
- Simon's Reviewed-by on v6 carried to patches 1 to 5, whose code is
  unchanged; patches 6 and 8 changed after his review and patch 7 is
  new
- patch 9 drops the Reviewed-by of Marek and Simon on v6: its VBUS code
  is unchanged, but it now adds its line to the remove hook of patch 7
- rebased on main

v6:
- Marek's review of v5: patch 3 names USB_HOST as the option that
  selects DM_USB, patch 4 loses its two Fixes tags, patches 2 and 4
  carry his Reviewed-by
- new patch 6: the driver's own dr_mode enum and parsing go, it uses
  usb_get_dr_mode() and USB_DR_MODE_* as ehci-mx6 does
- patch 7 reads the phandles of the controller node with
  dev_read_phandle_with_args() and passes the private data to the
  helpers instead of single addresses
- patch 8 reports through dev_err() and dev_dbg()

v5:
- Simon's review of patch 4 (now 5): the live and the flat lookup
  treated the stem differently, exact against prefix, and the register
  base patch relied on the prefix to find usbphy0 with the "usb" stem.
  New patch 1 makes the flat lookup exact, ofnode_get_alias_seq()
  documents it and its test checks a prefix stem; the PHY node is
  looked up with the "usbphy" stem
- ofnode_get_alias_seq() now works on a node of any tree, on the live
  tree as well: of_alias_get_id() looks a node outside the control tree
  up in the /aliases node of its own tree; a test uses the other tree of
  the sandbox tests
- the checkpatch note of patch 4 (now 5) moved below the --- line
- rebased on main after the v2026.10 release

v4:
- rebased on next; the dm core change that moved of_to_plat() after
  pinctrl is gone, the regulator GPIO is now claimed at probe time
  upstream, which is what the vbus patch needed
- the data abort fix joins the series, the register base patch depends
  on it
- the vbus patch enables VBUS in the reset hook only, as ehci-mx6 does;
  v3 enabled it there and in the shared init, so the regulator counted
  two enables per probe and "usb stop" never switched VBUS off
- the dm core patch gains a test and no longer documents -ENOENT for a
  missing alias, the live tree returns -ENODEV

v8 of this series:
https://lore.kernel.org/u-boot/20261022070900.616265-1-mehmet.fide@gmail.com/
v7 of this series:
https://lore.kernel.org/u-boot/20261020101608.2818265-1-mehmet.fide@gmail.com/
v6 of this series:
https://lore.kernel.org/u-boot/20261016072526.2277530-1-mehmet.fide@gmail.com/
v5 of this series:
https://lore.kernel.org/u-boot/20261013090738.377537-1-mehmet.fide@gmail.com/
v4 of this series:
https://lore.kernel.org/u-boot/cover.1791381507.git.mehmet.fide@screeningeagle.com/
v2 of the register base series:
https://lore.kernel.org/u-boot/20260820071511.1036506-1-mehmet.fide@gmail.com/
v3 of the vbus series:
https://lore.kernel.org/u-boot/20260820102523.1076815-1-mehmet.fide@gmail.com/
the data abort fix on its own:
https://lore.kernel.org/u-boot/20260818151236.2891878-1-mehmet.fide@gmail.com/

Tested on a Colibri VF50 V1.2A on the Iris carrier, colibri_vf_defconfig
on main (903c9578eeb): "usb start" finds a USB stick behind the host
port at usb@400b4000 and reads the same data before and after "usb
reset", VBUS goes on at "usb start" and off at "usb stop", also after
repeated resets, and Linux takes the port over when U-Boot boots it
without "usb stop". The code of patches 1 to 4 is the one tested on a
VF61 V1.2B for v6; patches 5 to 9 changed only in the driver and were
tested on the VF50 as above, usb0 on PLL3 and usb1 on PLL7. With local
device trees that make usb0 an OTG port with the fsl,cdet-gpio
colibri_vf had before its device tree sync, both ID states went through
"usb start", "usb reset" and "usb stop" cycles: read as device, the port
is not available on every start and the gpio stays free; read as host
(GPIO_ACTIVE_LOW), the port holds the gpio while it runs and gives it
back at "usb stop". Without the frees, every probe after the first fails
with -EBUSY. An unknown dr_mode and a missing one both give a host port.
The gadget side goes through the same probe: "dfu" and "ums" on usb0,
the latter with the stick behind usb1 as its storage, enumerate on a
Windows host, which reads the first MiB of the stick through usb0 with
the same CRC32 as "usb read" in U-Boot, and "usb start" works after
both; on the host state of the OTG device trees, and with an unknown or
a missing dr_mode, "dfu" fails with -ENODEV instead. v2026.07, whose
ehci-vf driver is the one on main, hangs in "dfu".
The five ARCH_VF610 boards build at every patch, and "ut dm" on sandbox
gives the same result as on main, plus the test of patch 1 on the live
and the flat tree.

Mehmet Fide (9):
  fdtdec: match an alias to its stem only when the number follows it
  usb: ehci-vf: take the controller index from the device tree
  usb: ehci-vf: remove the code path for a build without DM_USB
  usb: ehci-vf: drop the empty bind hook
  usb: ehci-vf: use usb_get_dr_mode()
  usb: ehci-vf: request the ID detect gpio through the device
  usb: ehci-vf: take the register bases from the device tree
  usb: ehci-vf: sort the includes
  usb: ehci-vf: enable the vbus supply of the port

 drivers/usb/host/ehci-vf.c | 322 +++++++++++++++++++------------------
 lib/fdtdec.c               |  43 +++--
 test/dm/fdtdec.c           |  35 ++++
 3 files changed, 229 insertions(+), 171 deletions(-)


base-commit: 903c9578eeb36d72f087082da494c605ddaed3b2
-- 
2.55.0

