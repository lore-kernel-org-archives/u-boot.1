Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C77606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CtbMF/Mk;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e2NeajOI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 868124051D;
	Thu, 29 Oct 2026 20:25:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEM958_xZzOv; Thu, 29 Oct 2026 20:25:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E43E3406BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793305518;
	b=JIVjcWwagE0xfUwgFzwmx7uaE+57SXyCBIGIMMj6hahnyTrIAgPKOkL1XKhexikeNuTB
	 ag9Plp6Uey612rYKNaDYr64IK5VQYy46Vv7c9nKTj9WxjCddkPpkZ0nkBbzFs4j9vTFPi
	 7Lf3hwkRL7PhbDltZhFNx0RKN4u9OxxoCJN6Lsaefvcjaaw3thxjnnYxuWKWsEuyCuSMb
	 P/ZThySjJCb7sS0w9sAzEssE2LSLs+uvSwaktotIbJjbHpBMJ3Vxn8KWLvM4IwF0XHrgG
	 47ZQ/0GgnDPA++TIu9v2pLpEYf4qOBpLFtJLjti9c0EI40vvqUAvnDYZVqK3cn16vNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793305518;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cOZht8z4sW2q+dixlkXWGqptN1whNs16GsYqjmWXQUw=;
	b=atu4BzaMc9fCXpgd+KCVnG/8hvBmv7Sh2v1qoQ6jY1nhlx7injHwS8IIVGNDSIJa6wkS
	 ZNVQ3aB2nO6s+DPkGYxmc7SxnBh1U0oOG8laJpXCAqS3I24hUBmkOmuwRNJhVhvYA1EKD
	 otLx8IGz6N3b7mDw5e1saOJ71FagIlMYyaaMec3S6qdg6gXfNEyX3qd7rrodfshV93pRD
	 VhvGpY4zPV8Dvnf4p5uxXjyOUn4ig5a9F/raX4eg/ewvHhWrZiqoyR42d55Po4hoGclDk
	 9+n/7iqDinoxFHYiFBqZgvsm3gHJDanc7s8pfelhvZ/txUFqAYKFvgbO492FIvqOiow==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793305518;
	bh=cOZht8z4sW2q+dixlkXWGqptN1whNs16GsYqjmWXQUw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CtbMF/MkVxzxHIJlyIPE9NjrY9MUK3NYk2fzlIcgl0CPhImcffMdwBpiFOz9qqu7x
	 5bjekuQ8LcyF40P2YXuDCG8MJlJexIUWPbZ2aqJWj9p0AFqS5uZeMhhINOrl5UdqzC
	 Wjlu4/FjfKRyWqaoI+wRN5YBDGEzy7ttYK8G8lc/QeCS7vBTgHgRKYlvMKxtDJccXO
	 I5nWU31+1YoL2RaRS482mHM8NoyibBkia3+ZcWaRoV8Urf5YML0YwxOAdsX71elUsA
	 3lbl99/B0fF+Yf8UcyzNMB1J0JMFDtzUyOYmep197gSnWdKwvFMaF19S3PE+tYbV+Y
	 cp8n9sv0QhdKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E43E3406BC;
	Thu, 29 Oct 2026 20:25:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D694362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D7B760A70
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ad9c_AJyunhF for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 20:14:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C849B60755
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793304841;
 b=YmK7F60x8epyZATkHaqeoY5cVr6YhApT0LDif8jztPeSPVtsn7F7qZgQmIwL8zLaAs0k
 S+p8j3t02Bof6g4tymKzTDoI5S3BOrF9b6rIoVtedbmy1+G6R3v678g8QfCokjw+sHW8A
 VwmSLyRS7hUObWuKwZbqjsdSU7+ElPee+VPLSmxuZE6BcoCFZTeaEazBxCdMdnK1o30hu
 IpjkOVgfo8azxduQlIgwNSrk1EnJeMet67CCjjfHFmd1TQ0hKhHIgxD+X8OMz3h+4HBOG
 LxCNTrVCEFnd/BG2Y8X8z83HkZ+t90DkCSflpK5llLskqaYU6qrhuIhRaV0YLLmsR4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793304841;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=cOZht8z4sW2q+dixlkXWGqptN1whNs16GsYqjmWXQUw=;
 b=Yhzpp6sRuhmtwcafGSFEooRmG4lumW0hNfH5A4c0IF/0uqUkNrdivb08K3G6RILgzPB5
 ARuwYJKE94FykDd5MA8BN1w6YCNSmQwCghI0JCtyBKTugD1vsuHlQ1N8koqdMmDf8cOC5
 ZK82aWBsR2H0D+bERr5k/GlpfSdi8s0b6qGBYDU7sCbrDp8Fh5wXm3Ue5Pk/CEvhs9z42
 SF8VrHs2NsFVostU+WxxaOqc0dVjFZgpgfExqzj75ooVuS+nWvJj3SYtVjJQlrrmaArVi
 TwL2FjxCYX1ZidEFQwLVYJ7iCLzrwi0dJOoHS63PnJ9DgkDqLQCHxpQU9zqreeqMcfg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=e2NeajOI; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ekovsky@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e2NeajOI
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id C849B60755
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793304839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cOZht8z4sW2q+dixlkXWGqptN1whNs16GsYqjmWXQUw=;
 b=e2NeajOIEYMzIHp/4k2Pn9pCyO0dGsMEIXWUGSmD9ppdAYUXmpQMMhvo1X3eG3YerEN1TP
 Ef+p+fuaW20sluu0UzKWRd+GiYS8ZhRwZMW9Q88dqe4Gd23911cRKaXrUX5ASYbgrhGELe
 9wbks8OAEH5snbDBmx+ubA4qR/QLev4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-GElIHd04O9SgiSUgmE28Qg-1; Thu, 29 Oct 2026 16:13:57 -0400
X-MC-Unique: GElIHd04O9SgiSUgmE28Qg-1
X-Mimecast-MFC-AGG-ID: GElIHd04O9SgiSUgmE28Qg_1793304836
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179a2035a4so23279216d6.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793304836; x=1793909636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cOZht8z4sW2q+dixlkXWGqptN1whNs16GsYqjmWXQUw=;
 b=hbI7f3RQSMZ6x4aMBlJq3BlKiQnnUZnIgylc+hbMILkjBTvPgOEDc6fm6C47quAaHA
 6qCulFA1eOcqcnLCjl36PkE79YroWemjFttNjYakJQ4IsvkGexsSQCwreQMMqJmPzZ2/
 PSGBtGnQStrPtpmOI+B+NSxvtwuHvhLzr+Ma4tySqt+OyqW8ggS7RkQduDXCGVlI+fu0
 T/nzNYtq4h+w7i+2Iuhnl5RFSEeLkr9F24op60rhz2nv5naOvSMm6ZdBEieL1MT3w8he
 w45wxGwc17GqEw+BjilHomg/5EPTVuRHXYSoXtPvTfWd7M2LvwpsLemDmm+WxyWMw+rv
 ZHUA==
X-Gm-Message-State: AFq9FYLNJuLvqSWqHxX7ml/VDQJILkOaFmd4olFSj3veNrFF3LSJaFN0
 iZi3qAhFj3vkuSpmLpx9D5sf4wD9GxZn2ZfM5+k5ylPOHxfIDmG7EchnkgNw+dL0wJmBljG/eOs
 8DyOJdh+XVUA6L015TcsFWbvc8kswiB8zWq+EWXLt9EBuU8RKO2DOtI6RF1yrnZYqTuSL/A==
X-Gm-Gg: AYBFou0XejrDvnrMuAeOuzQ8yhhYTuHDitAJpIV/pcFr3LGRLHH8K3PQk1EhmwfvFY6
 iQRaK/RyDwDTSbc1t7tue3z13RPOQ/zSxEtJfM2RQZpVb/UZJg9eC5oR/ZQmZoRaqNzmoqIhJUC
 vWpl4Spe3Bh3w0e7RvN7ffKEUJrF6eATSYaeMRwlA21R8Rv297oigfMOh9LISsfkKm+yaZAd0qm
 Fd+jnp78RrsexQR9ONYQXXoNwzyx+fsNxekNdAJPZThyoUC5dG7hO9z5KqVWDH9b+4CSuKuyRS/
 J0N7XNmhdy7sIjBncoB3DJHCo/chV/GzXXbHzy5mtId0AG+JmqkL+1n9SfQy1FxzeFK7VEXcR2y
 1jyrzuRb0vRHYOyt1Zga4M+brTTpNmf1pMwU4+PfOExiU
X-Received: by 2002:a05:6214:e8d:b0:91b:5d39:e139 with SMTP id
 6a1803df08f44-91c908973acmr54975636d6.36.1793304836112; 
 Thu, 29 Oct 2026 13:13:56 -0700 (PDT)
X-Received: by 2002:a05:6214:e8d:b0:91b:5d39:e139 with SMTP id
 6a1803df08f44-91c908973acmr54975286d6.36.1793304835540; 
 Thu, 29 Oct 2026 13:13:55 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca31032besm5128686d6.19.2026.10.29.13.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:13:55 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
To: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Bastian <bst@pengutronix.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: [PATCH v5 0/3] Add support for OpenSSL Provider API
Date: Thu, 29 Oct 2026 14:13:40 -0600
Message-ID: <20261029201348.730274-1-ekovsky@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hUVcW8IEBa2EgJRwQ58kSEmbQNf0MnerTpDrxUKQOQ0_1793304836
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Thu, 29 Oct 2026 20:25:16 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Engine API has been deprecated since the release of OpenSSL 3.0. End
users have been advised to migrate to the new Provider interface.
Several distributions have already removed support for engines, which is
preventing U-Boot from being compiled in those environments.

This series adds support for the OpenSSL Provider API while continuing
to support the existing Engine API on distros shipping older releases of
OpenSSL. Build dependencies for local development and CI are also
updated, while the final patch adds support for using hardware tokens
with the Provider API.

The changes have been tested with the FIT signature verification vboot
tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
tests pass with both the legacy Engine library installed and with the
Provider API.

Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
---
Changes in v5:
- Fix Tested-by trailers
- Change error string in drain_openssl_errors()
- Additional testing on RHEL 8 with openssl 1.1.1
- Tested hardware token signing path with SoftHSM
v4: https://lore.kernel.org/u-boot/20260429180247.83091-1-ekovsky@redhat.com/

Changes in v4:
- Add comment that @engine pointer is null when using pkcs11 provider
- Remove extra line break
- Add pkcs11-provider package to build dependencies
v3: https://lore.kernel.org/u-boot/20260120164524.253188-1-ekovsky@redhat.com/

Changes in v3:
- Removed Kconfig option
- Changed macro symbol from CONFIG_OPENSSL_NO_DEPRECATED to
    USE_PKCS11_PROVIDER or USE_PKCS11_ENGINE
v2: https://lore.kernel.org/u-boot/20251027195834.71109-1-ekovsky@redhat.com/

Changes in v2:
- Remove default for new Kconfig option
- Use #ifdef instead of IS_ENABLED macro
- Remove comment after #endif
- Remove unrelated checkpatch cleanup of 'sslErr' variable name
v1: https://lore.kernel.org/u-boot/20251017171329.255689-1-ekovsky@redhat.com/
---

Eddie Kovsky (3):
  Add support for OpenSSL Provider API
  Add pkcs11-provider package to build dependencies
  rsa: load a pkcs11 token key through OSSL_STORE in the provider path

 doc/build/gcc.rst       |   4 +-
 lib/aes/aes-encrypt.c   |   4 +-
 lib/rsa/rsa-sign.c      | 194 ++++++++++++++++++++++++++++++++++++++--
 tools/docker/Dockerfile |   1 +
 4 files changed, 195 insertions(+), 8 deletions(-)

-- 
2.56.0

