Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47586606A321
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fHLv3/s5;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UKH2cVDH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D375E40974;
	Fri, 27 Nov 2026 13:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KX2Ecl8CM6GW; Fri, 27 Nov 2026 13:25:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0CDFC408E1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795785945;
	b=dq7DCvrki34PhEJ8bNtaQ92nF8jyHOhmJvi57+NA73utx2ip3aySp+qY+/XA3dWeDla6
	 IvaNKZhkIkHdDHfULZT0vZCy4W9mClC9AgIVvmiWJqoMitMOOtLj3YZ8jkR9kMa1S3Has
	 IDCbpUkS3ylER6dvkcwPq1eTHrNKYCKixFDHxPzi2pN7niun9WYVPluAclvXBe9otfmxx
	 pXlbxv5icBJd6F4rfWR7W0GLwQPyxdjPqXbdl6+qNHUH/KQbPX89/kSij2iiU2CspRknv
	 9U84Ing6/FT38QEQUCBPwbKykv+BdM2wzvyJ9xsPJp2VVLcsCIA5h7P3H6uleOXpSRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785945;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bV+xzc7O0QGiCasC4D7VdW3VE9gcj/wW/nRasyoh1cQ=;
	b=RoYYy7nY8Jo8sOJQEu0OsvwG4AlOWmnLNpuMajIVIvY7O7m168odcdeziySg6jlTyDHa
	 /E5alSAJkx7twWHyAsduxFB/uSindDaMOVmFP9hjA1Txa1Jh8TM9jpiqircnvcSE4VxaU
	 7e9qfW3d6KZU7lPZRe4dWd7AD9MqfUj9+CxoDIYnYTjZf3L4VbMAqIfnr3pGao0U6V3VV
	 hdjiihoxnrHU5sRrw/OsQrEkIwzZVaf+p44l18Q/KLKky9KbUilvfvCG2p4Od3KALB54+
	 kBEWVHb3FXjTIayLpLfOwWq/Eq1j0Y4wZJQHzExjjcU7gow9Cvpw/gu63vZNyLRYBEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795785945;
	bh=bV+xzc7O0QGiCasC4D7VdW3VE9gcj/wW/nRasyoh1cQ=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fHLv3/s5XMrKph8aUAyARc/5q2dLM32U5jwH6rco0yEM7Q7krnCdiLsGtwz/PQGIo
	 PaxTRkXBEtfXisecf0TYfr2URNLu6zs8e6YNd8z7ixvPOp+F/exlgJZk2nIj5xKA0l
	 vh93XbEldl6lIbcOORwkq2XtIOzRzpYxsoqt7lYUDBnb/Rd1j27G/ljDdDgcowg+pr
	 bE6K9cRBZiOOXL3h2GJgQ9ySGJbOLv54jptkF1ZNuH/e/tOTgE8fDqnBM2kIPDluq+
	 ClKQx17oR0ADXQtFZV0ewStJHiBggXTBobWuZx9ihfZyjPje4bicMDFYtvoJImvntN
	 oQMZiP33Oetrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CDFC408E1;
	Fri, 27 Nov 2026 13:25:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEE271C9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B47844008B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:14:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WGt3wrrG7IJi for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 11:14:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E5CC4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=urak76028@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=UKH2cVDH
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E5CC4004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:14:20 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b4c685c751so69090277b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 03:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795778059; x=1796382859;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bV+xzc7O0QGiCasC4D7VdW3VE9gcj/wW/nRasyoh1cQ=;
 b=UKH2cVDHiSnJmWKIILjxz43/CaLi1siUa59ns62LUZ2OhNNQE1RL/oKay+zVA0JUTF
 cJgHuWkquhsWvxjnb8Xz31HIgEmRTiKKog9MIu0i2jt4EwWaeOOxRI0gjkmXEGLJNyDJ
 ZKtKC8OYLb0h4kBcRPnDarlpXoJRh+93bmkLqwqo5m7dlI8WNmhx1r9Bt+ABJIFjMpvW
 xHaex7/kUwteU0G/uwUSkv0oCLkhHk43tHqjdUX23KjD8wz3OjC9bPQEqchUreRn+zBW
 2NvJKw5ct383RgRz87R5/iqXhkGOTqvhoMxGxYZ6fA4WVG6KKtH1fePqyaWI+4UECOIM
 Z9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795778059; x=1796382859;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bV+xzc7O0QGiCasC4D7VdW3VE9gcj/wW/nRasyoh1cQ=;
 b=njVrTiv7ykMxyshkflJS12w+bMjeNvTdl7Znc4A0HaXt5j5x69Ji05w87WfImpIb9N
 hvx34JeeTxTkKuSZS2OWOhMGgBHFVyA6oLsSA40fLG0hqLLUT+P+tm97joeINGV3sm0w
 lg6wY/Jo55JkeDxzEnTTYYoFpnTuuNJF8/fdEhCkyLllJlHdyPVFpXjccVsWdWOMzMBD
 OccURY21J5rPYwQl18ZS8F4olE6eypWydz/e7ElvND7EQLOVLQ/Bdh7L08SyJEHOqYIy
 oLTiPj64eTpi2REk9OMwRdXAz740SNzQHgUQU2AH2oW7JNNguqFkG5Z1sl6gCm9IXNvv
 33XA==
X-Gm-Message-State: APuU4Z9nFRyKpIL4cvza8XNIqaVimHCKGqQCdBlDLTyguWFCB4lKKEuW
 Yf/U62aZxhg0VfaDq0QKnUHGsdcRGSQhsKuWwHBzr3/iOzvt0dd16vKhMh2eNOUWtsx1f+OLRLd
 DxTZGwxQhiXqghLgSCKSQaiQW6Ja2TJ+Bbw==
X-Gm-Gg: AZFdTZdjTFYtcYewd8pLNI76cl4i83Aefk+57eH08hX8BN4XinqGsj6cfeWjUPagxpG
 Xu+2pF3q9WeL5Y48pJIIdKT8IPi1UQ+AV8pMvf5zGXhq078E25AS4bPjRziX4+CTxFF5nu0o7fu
 LFI78ar6tVXRhMmDxNFnNvF+M5PRXzIHmnEAL/O72W0P4Jk96jqeZhCLgLe0Bt7Xwe00bxnxE0q
 u2A4dBmBawT0+VQe0GmTxQlalXvnpjqrR381UdM9HAikkf9/npDS53MeFh83uxrb+9lJasQbcY9
 WcpQWsnn+bO7uW8WeeCFbfAmNt1+y7PlnzEZDRXMHvoCAgLS2NnN9WrQ0RaX2GzgKgkYHbvC3NT
 tc2vdgqZXkTi6Io7Abq5KXBQKxNMxqNXxTRE=
X-Received: by 2002:a05:690c:e3f0:b0:8b4:d44a:c4ce with SMTP id
 00721157ae682-8b5204e5e75mr83351117b3.82.1795778059146; Fri, 27 Nov 2026
 03:14:19 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 27 Nov 2026 06:14:18 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 27 Nov 2026 05:29:15 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?2bQ=?= <urak76028@gmail.com>
Date: Fri, 27 Nov 2026 06:14:18 -0500
X-Gm-Features: Aa3M54qAg9y45sUi0HXg5FtUSQ3_upbCp2o88ZwFwyfyglSCyGmW8J0gsb-17N0
Message-ID: <CADwP7ENpn=ks26u=q2y0aLFb0+KcPsQEYZn7QAbutjM7Z-Op5Q@mail.gmail.com>
Subject: MT7626 / Leopard: historical public U-Boot source references
To: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 27 Nov 2026 13:25:43 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello U-Boot developers,

I am investigating TP-Link EC225-G5(RU) V1.0. Three local firmware
reference files of unconfirmed provenance contain a legacy uImage
labelled U-Boot 2014.04-rc1 for leopard_e with MT7626 markers. A
repeat static analysis verified header/data CRCs and identical
decompressed components (196032 bytes, SHA-256
4ee47962110a775886d6147be238858f7dd1470ec412f084c9d463ff6440dbdd).
This is not proof of vendor provenance or the installed build.

A related public third-party tree is
https://github.com/a-andre/u-boot_mt7626_archer_c88 ; I do not assume
it is the corresponding source for EC225-G5. Are there historical
upstream or vendor-published references for Leopard board
initialization, SPL and build configuration which could help identify
the lineage? A historical device log recorded a June 2023 build
identifier, but the reference filename date alone does not establish a
match.

I am pursuing corresponding source separately with the distributor. No
custom image has been booted on the physical router. This is a request
for source-lineage references, not a patch submission or a request for
proprietary information.

Thank you.
