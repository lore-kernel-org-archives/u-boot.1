Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9F606A32D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OX7ZdBfX;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BKDcwrsB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDC04810C1;
	Tue, 20 Oct 2026 10:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CeVfX6u3us2P; Tue, 20 Oct 2026 10:16:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA2D38109F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792491379;
	b=E0Mz4gadbPzzbpjHHvzRVFlKmvCGzxo5dXQiujfCBtMce+UmPV78BguVvuZOfOXBW/si
	 pkCKkOfnh31cgjC0ht5+CTEua/kvzcg8kt5jquYZDI/WTAGC2dR3Mez2+SWMAyYirbnzK
	 CDZKErnkO75v9EV8PhJq3RKnqhneNlndL+GttFxArNjwj7h+0tizSHggLL2oxk78k0S+S
	 hvu9R9B/ZBAio8qu6mRWcVDbDsezzZMk8vxwT79VHIMdCqgdUe3xjBRENVQ5zLmb6nttz
	 PrKDO6umCQGDNJc8dkvQavgoEitNN2Kv3uq0KoWIoX8YvK7PvH1bTQCA6T5N83zvq7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792491379;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yLqiBwmBtRL3lFv1bYE7p5GYP2/map26WrEubRbyC3E=;
	b=adYQ5smKSCXvm8bOnok+Yygoqw4TBaBEW5YwUDwplB7uEcHr00L5lcO7mbh89Z6tFuAz
	 wAVhkGazEkApnspAu/EnCglCjPap566jAD3SUC9C/muff2LHagnfIbzpjcOI5HIEkMcko
	 /Ubv6Q+kfC+xcoCkwLE11SgDh3i0OfR/TdWVSfJ5naNdkXZu8vTm47x7+s2V3U851QQCm
	 yZkuZYzCOHwh/csov3P+h/+Bno8mXTDLHD4oPcbM/LqFOnTdlM+qzhCUasiQajBAKUtj5
	 nXeWkwxRRXpYZzy3xOapoNtMBvOnvOL5c+sLm/9l6v+oLcO97NUtLLJTQRDvCRLcwgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792491379;
	bh=yLqiBwmBtRL3lFv1bYE7p5GYP2/map26WrEubRbyC3E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OX7ZdBfX10xGRgYnYd+tV14ePb1pEn/W+BeldnDUfg+441RBBAOYSBX90b3YkYT1O
	 ooAVVk2wlvSvTgKOdi5OhhAbtPrfbs8PTPpnpCrUdO1oSjw1+XE0+eFQvxQWTmP2kq
	 p/o9bJ9TI9tQ/iNIdaLXnazxNING12Q4XaCjS1O6TJvexD71dsFBtJxjLFzVZXsIdl
	 E5yX8o1RZ/PFagElfoK6L7RdWxxoTTtn31nJCQtCtcnE3lj6WKhC1up38mbr+dW44M
	 mGzPz2ELShxxF6XC5qHR3Z7e9/pwNoZjAa/JLVdRjdRBKI7rSlmWpLYnv9hhHLtEnP
	 IQk6Sqr/Ac80w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA2D38109F;
	Tue, 20 Oct 2026 10:16:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 937F7769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 916F060825
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2sNUdZeQ1W0S for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:16:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3FC8060822
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792491374;
 b=V8xai5Qpt6Ec9bESR6z05ujwRcxuQ7in9OUzw20BBjpWTWjkRukkeUMcCy/YnzDoKBpJ
 mFCr5Nzl4p2Z7MUWCVPMpIElyLwNqu7GbqBxobsFWG186hT1dawZrrviTzUUwyvGxALlA
 ufm5aP4bJNcgJOUzZ0t5/noH9fIozDiTMJZrFn+3gN5EqqfLHovOhd84c9V2RCrZLygJr
 pxe/HCIkfMbSx2/Bv/Dh43YJEG4Qr0A+mijvXlH8EnOTvREsvyhqBs452MC8pYd3wLLGK
 zq6PIUmgbJsr91vtk4+X9kqHCPCl430YSGOqq4LsM00QY8V4EjEnnhO8Ze5Ou5VNSnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792491374;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=yLqiBwmBtRL3lFv1bYE7p5GYP2/map26WrEubRbyC3E=;
 b=HMYRNbB+hEaVZoZCo5atGpuRKc3mcBoiEr5wcDxXyT9hhhf0gogJ1a72+z1ar3BDwopy
 9qTg2wHWKpAXRaXrMPfdlxYB4Q3OCIdz+egPZtYQRSsDfVa9K6oYfTezCC4RszOwM7RLJ
 4dcI5epvt4hRa0q8A01/YlYJlXR6FCxxzeSiqO6fhrIgWgXNTgbLA4hizNVk9MjKVJ5v5
 s1uFVqiPOuGA4D4o9BBFotVadfOKULedUQBF3IaH4zlTjm4iBTz76jS/2Vj8BVR/qKEuB
 k21YU8VjXefntUhO7jUt8grT7ZCCJpkLJjQQiSKHxY/MNlFVXzKAQ1XrL5Ctoaa9uLg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BKDcwrsB; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BKDcwrsB
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FC8060822
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:16:12 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso35500195e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792491371; x=1793096171;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yLqiBwmBtRL3lFv1bYE7p5GYP2/map26WrEubRbyC3E=;
 b=BKDcwrsBRSDmYqC+Auaa6XRGM1wIz+avkeOtJMOtJZuWR8sagEbaSJ0CE2fYye3Sp5
 ES6/isE/XuZ5WZ7YH51mMoknFhR/eG/ndlATxE5wA3KgmZqlSil5/ZY+a6bvwG4+7P3Q
 51jmd6yqA4C8VmzEPonkXN1tj+QJsOqsiTqAVH1vuQZ2QWkOFhQlUNnY5NbCZ1iOaLP9
 YKQFL3yTp7F4G8TM4U9N4LQf/XPnvJNj+Lg5hq8ECB8QaDHLByt3pYegO1/GAU/8lBol
 EWSAsQo9VGjRA1SEmlzTQcIrpgQF9esUyvNaYu1yA/vakt92UgXYUhvJpR7gjdQHsElu
 a3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491371; x=1793096171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yLqiBwmBtRL3lFv1bYE7p5GYP2/map26WrEubRbyC3E=;
 b=m+6t2/Ey1/TU7SPTGnKwBrjcbRGmPduxus+xvd9WJNSbNAMwSCbUeN2U4TFuyHhyqt
 aOtikB4u1n/6ssnt/VAAdAlx9UUMNf4aqWUHvDyUrwfe+vah/Ek1nHslQq2odmenTXiz
 GVhsE4ckBmquqT1j53GIpND3suxL+ULbbiYZWROiFpV/o3O9corhMml53PBUEXdALKOC
 ymJQstQVSVwflk9h8NCayfvoBc2mIaHofyRce/yFebb3PtliUiIUag9jBa6Qcuql1KWU
 qX6jTwzBpxW8145d+dW3iwOyRYSYS2GzkVEvBqhMI0Lb+776NnXCIhoY2N3LkycKl7XJ
 9XcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIVmgHPNxXmlfQnaS+iMDf8L5mom7TV2H5H3sgLchY9j9zzkfc5AWstH67HZ5WNF9/O321NYM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLIsRKWXb97KXZTmx7vI/JFgbMWxgq4aD9TWIN5R8OM+EPfbRQU
 2ad9Og5NoPeVHlBvdK1WshcFy25A+gZ36TLFK7UYGK9eV1swNzDNWFO6
X-Gm-Gg: AYBFou39dSm/8Pn+ZvACcg9mLoPEUPxl6WUoUmQUlp++r7R3DdLeKJMoJl2p961gA/c
 J9Vz1Y2DkTHet0y6mBwxmrxmnkxQbU4gWsFKb3hafiu1Tt9Vhz/yx01IaA9FdmhsLpsbCeXVfNM
 /e7TRBiMKJmY4Xa69SHRcmnAPM9v3H/xtcY2PX2jhHrwKX0KJO+VoCn2a8y55cc7lyd9u3r/j9k
 zyj69Ob4idHQSN2N+qxEEsQZ02Qx6vcUaY0bjj5LKKfEIp1JA/IWzEXg7PEVlAfs/pG3sPPJiul
 4SIlKat/J0ObBAsfo77IfcE1ebNFn8SaXvT4Pn7jVxDVa1mjHnFMBArijUfDogx8vNo3QStF6ET
 Hpeao61NwHSRDn8+MWjPx9+umsBR1nX3/t/8pYz9on7uqVcuxxMANVv74Vvc2tlsdtf8OMPe84+
 HnwBUIe4ygSwlkDLx5Vz+SBmsh4oleYiJjfoJBspAPq2Bby+CUPI0bsAK/lBWUbpeEAsQMQMnR5
 q9u
X-Received: by 2002:a05:600d:849a:10b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4a1d75af354mr162822875e9.4.1792491370310; 
 Tue, 20 Oct 2026 03:16:10 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2ca3597sm60140505e9.2.2026.10.20.03.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:16:09 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v7 0/9] usb: ehci-vf: make the USB host port usable
Date: Tue, 20 Oct 2026 12:15:59 +0200
Message-ID: <20261020101608.2818265-1-mehmet.fide@gmail.com>
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
- patch 9 enables the vbus-supply of the port

Patches 3 to 8 are the follow-up Marek asked for in his review of the
data abort fix: the PHY and usbmisc tables are gone, and the port index
that is left, for board_ehci_hcd_init() and the anatop registers, comes
from the usbphy alias of the PHY node.

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
on main (8d534cec0cc): "usb start" finds a USB stick behind the host
port at usb@400b4000 and reads the same data before and after "usb
reset", VBUS goes on at "usb start" and off at "usb stop", also after
repeated resets, and Linux takes the port over when U-Boot boots it
without "usb stop". The code of patches 1 to 5 is the one tested on a
VF61 V1.2B for v6; patches 6 to 9 changed only in the driver and were
tested on the VF50 as above. With local device trees that make usb0 an
OTG port with the fsl,cdet-gpio colibri_vf had before its device tree
sync, both ID states went through "usb start", "usb reset" and "usb
stop" cycles: read as device, the port is not available on every start
and the gpio stays free; read as host (GPIO_ACTIVE_LOW), the port holds
the gpio while it runs and gives it back at "usb stop". Without the
frees, every probe after the first fails with -EBUSY. An unknown dr_mode
fails the probe with -EINVAL, a missing one gives a host port. The five
ARCH_VF610 boards build at every patch, and "ut dm" on sandbox gives the
same result as on main, plus the three tests of patches 1 and 5 on the
live and the flat tree.

Mehmet Fide (9):
  fdtdec: match an alias to its stem only when the number follows it
  usb: ehci-vf: take the controller index from the device tree
  usb: ehci-vf: remove the code path for a build without DM_USB
  usb: ehci-vf: drop the empty bind hook
  dm: core: add ofnode_get_alias_seq()
  usb: ehci-vf: use usb_get_dr_mode()
  usb: ehci-vf: request the ID detect gpio through the device
  usb: ehci-vf: take the register bases from the device tree
  usb: ehci-vf: enable the vbus supply of the port

 arch/sandbox/dts/other.dts |   5 +
 drivers/core/of_access.c   |  42 ++++++
 drivers/core/ofnode.c      |  20 +++
 drivers/core/read.c        |  20 +--
 drivers/usb/host/ehci-vf.c | 288 ++++++++++++++++++-------------------
 include/dm/of_access.h     |   7 +-
 include/dm/ofnode.h        |  16 +++
 include/dm/read.h          |   8 +-
 lib/fdtdec.c               |  43 ++++--
 test/dm/fdtdec.c           |  35 +++++
 test/dm/ofnode.c           |  49 +++++++
 11 files changed, 348 insertions(+), 185 deletions(-)


base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
-- 
2.55.0

