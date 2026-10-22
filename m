Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8530606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LWzSI2XW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iNtblGWY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F3C96066A;
	Thu, 22 Oct 2026 07:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qde6HTsjbxEc; Thu, 22 Oct 2026 07:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7B9FC6068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652947;
	b=HyP8agQjtvh7D/vFHYErzuOGxbsr/4jV0uzT5I+QOEduLj/iBI0qjtDmUDz8w3RkNsF3
	 TkFlP+JZukC202tPtBV+S2Hr5jMIJ59VAH4yjkzbdMlDYJJkd8fFnzkM1AYHQcmkhpCSg
	 49JSNkSKsqGWDfc5CkWypv7WWc+vb1/85vIKMpC5oIKF5OOBBrU/GO6xexvAGMLtdqDdN
	 /F5np0eLTid92QyEP77AUzZgGtpZ/eQwH7fPTYd0h52wfM16M37HP4j3TLY4Ay+jiu8xE
	 hbQKDf5BOiUikrqKioFY7+senRDHyyRkNDUpPqQMp/mtueOsSRIbDGQrO6MIKUizIRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lcgJSKHgFRuil3WkX8LzT6F1hUUZR8P7IPA4gHNRtbs=;
	b=sRP71+/yz8YnUahXIMJQFFTk+UFxH5RbnlMpWLmPZ5PWLIISugoRjRrrYd+cz4zvF5HU
	 KxCst26Q4667ICgZdnsvx1HqKSTmlqzQcOlG1CtWZD/h8s9qabWmwW18JPqtjQ5HjmuQP
	 2bcXSpydoNJnVfGFZKAL1PT95LJwUrlDAeKtIQvx3AW6lxz5KoOTSeZlmV4AcpU1W11Im
	 GvYid4uJfIB2KGuZo7xWq71DlbmG4V+idLOXzIMgRggLDtHTStaISpxCFkR9+2IEKlao/
	 JpNtpfPCPNRpj5fxL4fvAEL01n5Dnpd+gZQ+5axNUQIOGHjGDB0b8UtiHhsN58MkGQQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652947;
	bh=lcgJSKHgFRuil3WkX8LzT6F1hUUZR8P7IPA4gHNRtbs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LWzSI2XWNMjib7rnFkF/f2/IXjd7dT3VHG17+7BEAg5ILRmapZwf85GRRgvYKDFmk
	 Q/tPoxWwQAK3O1ksTs8m7zBabNhxzXlq9UokVskojqeZzjljhRKVtJGTSEt37vNaF+
	 cv5sL8lRVQlqS73EKBQi3LnSO1xMsKSjoeYIFTRjQriq0FSv9aK2KOg+5s5Snww2pS
	 S/hGQhm+fU7AjL9bTlVII2szTS6ftzdz9z4tog4XUuSiQ2S1IINwQ5vb1CA9eQYaaW
	 7CQ+5qcTZ5kbMCi439UX2rIzLvsvbn7KwiBlpKA8FzBUoLc9aJAsJQO6M+AcrGhmGX
	 20ykcRnw+Ks8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B9FC6068B;
	Thu, 22 Oct 2026 07:09:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 30EDF371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22E6740075
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jiucVMaYbTcs for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AD3DB40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652945;
 b=sGO/QUQElEeWeTK1nMCocZVS3TfSQ+IAncH0hbe5jmmPEbQ5z2bO7B4g5+RHGiqx+pTw
 SR505+4qpZq0/FwO1RpjbzQukdxXTbzD4LpNdPgTdia5ZYki5LLd4v9K5G9omfzmAuoo8
 uAz3vaCdaBhQ9sEMOxxX3lnpdJGWCQX9HEbzJBNkBe2EpZGVXVZYvmiGc79SU+Ino3VN5
 JmKRed9XM43BVrvsc5iFOkrMmQn+HPjmTDdFqHfhiM4s6+xwIv+Yexc6zU1QJaAKvMuTc
 jpEQB6NBpDts2S/sF3PWzzQKYbmhxHIpddXS/L0abB07mFa/D8sB5ZZDL14MT20eeSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652945;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=lcgJSKHgFRuil3WkX8LzT6F1hUUZR8P7IPA4gHNRtbs=;
 b=XITAmWFJRLIFILVunKx3kmc3kzF+Mx19oCPVa7eXW+SCI6yE/eDxEEbv6xmI/IzpXIsR
 hPirBumMw/5czUSPOguuzmDP9/zK0CbDcunb1Bya6F+/IlX7UCURPJJVC9H4dYcLu0DO5
 zigJtV47V93BpqxBvmRfFdJrZ+FRV3VHo+ObGJNclG20lXxy+y21oDY7gbAhN2eCl+5Ws
 OgbE0rOHiGY0CUSR4qcwdt9fj+zU4yYQBZoNteFKXib+pkkl02Ayf7AUgTopFE0ecdoJk
 +GotoVjJ0alvwh1MukwXuULj78QMPi5/iXOXWJNmh6LoKwZnawXFmiZo5ZpWWuGsO7A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iNtblGWY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=iNtblGWY
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD3DB40042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:04 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so1019895f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652942; x=1793257742;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lcgJSKHgFRuil3WkX8LzT6F1hUUZR8P7IPA4gHNRtbs=;
 b=iNtblGWYxTBNiCHmn7qvC43yyje8Lhji4p4rQ9pIY3Pe1jjOUaurrFWzcoH8Z9f8BM
 VnACJILVAeBD5QQVtlBou7iX9tdMia805S9No1jq1yd8UOHJGQo0kq5ajxvWoS5B5Mnc
 jE+z4Z8kfFfamlIX7K1h0m3paMETlMNtjsTpwKi5w30pNJqIjbeVjVmpdmX0NNp2+uZL
 W3zkA16JBFYvrCujQUT80ir6ApLFEvND8nzT0g8DqFdpD4Ia56EaJdFQ53kC0byB3jUa
 QH4IipLy4/nHB6GiOlqu5e+l4H7zC/77QYotPIS3Oh3iuvUWNRbx3If7Zdkwa0w4okPY
 C/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652942; x=1793257742;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lcgJSKHgFRuil3WkX8LzT6F1hUUZR8P7IPA4gHNRtbs=;
 b=fJisDth8GV8MtKHF1Aw91P1YX7ciLUBeKEyql232dPI6f+nKYodPcgoXlHQwY8ZjXJ
 jgnSidFIbXTtlHCXIKjlzRn+iT4VXlld+dXwp1W1gAm03g3JK6RhsJ2xezOB1+ApKty0
 KpgJ1kOkrIjigHJtZVC2xliWGnW9a8U3MFDi2OLie+9/MreUGd2WZomxi5Gx9Hwk3dTQ
 FSNXvCcY6k4nODYMIJyowY9te/knKzgZaYZdEGz8MdtW8A576g0L++Td+jt4jbJkLwhc
 0hsqInzdGGC/0OJQjHRLwsoQkpJKeLek43hKwld44iEsKwZT8LMUBGPhaq0KtPX3RrEU
 1SdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBziVS0OZssTISpiCko1HVlHKlFe0abxfVHTbh8Sp/JuvWpVOAR7JpjBhwA6cROjx8ieeut9Zzw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIO7eafBFuf7+JqlIsS0tlpNk3Ia9JVSNQQdUgSmfaCrDDNIDuU
 muOU6LA8molur9JbFRdvlqJjJnr3vaH6B0qJJevBIglVlnqlfzzY8b8G
X-Gm-Gg: AYBFou3ffToXX402ck6nz2PBL/CV9oqTPw0BY1/KzFRNckSpzVKTP+fKqXf+0K7cEfJ
 aCSxJa2GQGFDu0MadxRLQM3ud//vr2sZMRVnZZUHhvjX8mPTSuIvhS8ay8t3k845vOQoPWoWQ9U
 7iP2ubM/LIzC6nOgfe4InZscyvqFvrlyUZJs1uebhvsEiqijGRtS6n/grgmfYZ2tXjaevqWaVlS
 N3lPwaV70PDslhbkhIsy1mVNo89Oy77stNjNM8dKlwWV4Jjftbb4q/a4yC/UJ2DMwawzQaO0geO
 lnWQlL+zQ9XvTtAelLB5KLilxIPmYc+n/gC5RrZhutIy8qama5Foj/yZl2ECeA3zzf1kT1SHj1L
 PwJLkTZKe9hzU3PRU6rCHD5GMgFThdUC8FJJGHmhPdFECBp2S/0wUUMENGEb5IqrBW0TSIrnv0n
 l8HAW7Iy/TuwjbXnZ11h7kNbFRZL5eaHAqFS5qXLUXS4tMP1YFJsAMzu+yF04sfHJc24guFPH8l
 VAHAaLEkYMve4+juSIxzjEcKDiCgUsiGzNFCb1tHV/jgBa4mb8tmxPhlsVlzQ==
X-Received: by 2002:a05:600c:3b2a:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4a1fdd4ea2amr84465445e9.27.1792652942071; 
 Thu, 22 Oct 2026 00:09:02 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:01 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 00/10] usb: ehci-vf: make the USB host port usable
Date: Thu, 22 Oct 2026 09:08:50 +0200
Message-ID: <20261022070900.616265-1-mehmet.fide@gmail.com>
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
- patches 3 to 8 drop the dead non-DM path and the empty bind hook,
  add ofnode_get_alias_seq(), take dr_mode through usb_get_dr_mode()
  and the ID detect gpio through the device, and the PHY, usbmisc and
  anatop bases from the device tree instead of the tables
- patch 9 sorts the includes
- patch 10 enables the vbus-supply of the port

Patches 3 to 8 are the follow-up Marek asked for in his review of the
data abort fix: the PHY and usbmisc tables are gone, and the port index
that is left, for board_ehci_hcd_init() and the anatop registers, comes
from the usbphy alias of the PHY node.

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
on main (06f988df538): "usb start" finds a USB stick behind the host
port at usb@400b4000 and reads the same data before and after "usb
reset", VBUS goes on at "usb start" and off at "usb stop", also after
repeated resets, and Linux takes the port over when U-Boot boots it
without "usb stop". The code of patches 1 to 5 is the one tested on a
VF61 V1.2B for v6; patches 6 to 10 changed only in the driver and were
tested on the VF50 as above. With local device trees that make usb0 an
OTG port with the fsl,cdet-gpio colibri_vf had before its device tree
sync, both ID states went through "usb start", "usb reset" and "usb
stop" cycles: read as device, the port is not available on every start
and the gpio stays free; read as host (GPIO_ACTIVE_LOW), the port holds
the gpio while it runs and gives it back at "usb stop". Without the
frees, every probe after the first fails with -EBUSY. An unknown dr_mode
and a missing one both give a host port. The five ARCH_VF610 boards
build at every patch, and "ut dm" on sandbox gives the same result as
on main, plus the three tests of patches 1 and 5 on the live and the
flat tree.

Mehmet Fide (10):
  fdtdec: match an alias to its stem only when the number follows it
  usb: ehci-vf: take the controller index from the device tree
  usb: ehci-vf: remove the code path for a build without DM_USB
  usb: ehci-vf: drop the empty bind hook
  dm: core: add ofnode_get_alias_seq()
  usb: ehci-vf: use usb_get_dr_mode()
  usb: ehci-vf: request the ID detect gpio through the device
  usb: ehci-vf: take the register bases from the device tree
  usb: ehci-vf: sort the includes
  usb: ehci-vf: enable the vbus supply of the port

 arch/sandbox/dts/other.dts |   5 +
 drivers/core/of_access.c   |  42 +++++
 drivers/core/ofnode.c      |  20 +++
 drivers/core/read.c        |  20 +--
 drivers/usb/host/ehci-vf.c | 314 ++++++++++++++++++-------------------
 include/dm/of_access.h     |   7 +-
 include/dm/ofnode.h        |  16 ++
 include/dm/read.h          |   8 +-
 lib/fdtdec.c               |  43 +++--
 test/dm/fdtdec.c           |  35 +++++
 test/dm/ofnode.c           |  49 ++++++
 11 files changed, 360 insertions(+), 199 deletions(-)


base-commit: 06f988df538e5507287918d45100a66921b6feef
-- 
2.55.0

