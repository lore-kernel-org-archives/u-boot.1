Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03161C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 20:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D8826077A;
	Wed, 29 Jul 2026 20:47:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccwd10xRfZgT; Wed, 29 Jul 2026 20:47:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28CFF60786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785358065;
	bh=jmcRSwa2LBOiCHWdJ7hZjXep/ezqD8cCzktQgodKLcs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ICyJBB8yDbIJfEczc0L0a3Fn2g6wUv78z5iS3sL0Vc7PvZEpkU7xAZwzdzMsedBee
	 HVkINlxwJ74p2NlzLlLDZJv8gVRNGZ4mh43jJ+J82xRlitFpNu7pT3M2I1bOgJ3Rz8
	 wlrsTiYbTUVpGVKeWnizFO6f18hX30BPpAyWm/jLpkd/6syMM8Qo0uMcCDOuDkXRHY
	 OMR012OhccTv96HdhbPopDhevX2UyudSW6u+oYO2OVP8O2khDXVbEhS7eJoSxBfcT/
	 x4+52mcNToZvx6RiZdyKaJ4UmpSBs8lswxx3OvDgrtodbRBk1H7/DFl8bdzzcf0pFb
	 +y1Q0l0M/wsIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28CFF60786;
	Wed, 29 Jul 2026 20:47:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B14627B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7123640738
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-1biVvXMKDp for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 20:47:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8299D40729
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8299D40729
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8299D40729
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:47:42 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7ee50eb2db4so1025979a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785358061; x=1785962861;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jmcRSwa2LBOiCHWdJ7hZjXep/ezqD8cCzktQgodKLcs=;
 b=nJbzVToFeAWQCWpaNg4TMgPqqszNFZhP2L+qqrrtO1pktysIfwy611+ZOnA2sowDrG
 bWP84/NwLtTBJq6Qq8NaBLhVtIDKQQ6Ezp3e7c7FVndO/yh1dejpk8OV3VQx5wKX+K8z
 fJAyeqmV07HaHJTYErBZ6PV7lIiB4tptx921VjjtQ8Cl9Y62HHRK1m1P13ppcMQWeGsA
 cGmogQuhZPyTAXlvYw7cy/z6tf4IMmBfoBTVcwPkbcSAg89/f+0WrYcCEBI331WiZe2s
 3uz5VRisBT0/3WAUIKAgLZ+nNESkUAC/9RMhraja/OEolceCy0knVUzKlph6Hz8FHWGT
 AGYA==
X-Gm-Message-State: AOJu0YzE3jGTo3Dg7Wp1RfE0K+JiEMASUmSgq4L3H6ANcddXfpmOK1pu
 fw0U7e0I4JO+SN5x2eGyK1sKVCRF960OG95gSDlyhRRjtHIRElUhQfWPDM38uXzI3dCNzFMFsdL
 h8i54z0A=
X-Gm-Gg: AR+sD10WuPVdM8tFvmGlZpsJtyvhhbdQ3zeHzhOL1BEfyGhXsKVf9lRL046EERtQKHL
 AiGEye1pp9iLqFdDBwl6thFQGSKpE9hAOriUs3lIsXm/+4+blQwDjhU0WiGunzZsXvSNWRvKkUQ
 Ym4y37vrm5GeHbPpiJN+/4tIWtMGbp5dWm5DbZIw8kSZN67MC0YvXnGLoJQlHHN3zgpHLvbH/w8
 KL98UM/KXJmlnIeTWwQutn3rjRRt9Kgb8esAJeNFsMPrUsCDIjoLpp2zwVE3eEduOoIBaPHvSKA
 8heUwwjm64mAhjAAgmwbLqpQDMBmA0mFHy3cdl80Rm/WnM3ZUJC4y+cRCsTZkOuXP+JcDj+qDjf
 cw9Ew9Nks50qLL0uPDNiqqlq4sjOHzbPgnn0YGyr6VB60va1zIJRFeBPId7xgC0EsW6YgXViZdt
 3jpXtU8ykE3Y+JXwFOe2zsuNlhD5vc7dWs9MAwLsgaYXtYW51TrpFzp8LV5NbP6fYaUZXaia/hj
 VussANDpETwyVIA2NEgturf80HhAKjSFfTk8MU1lMVOrWKPXDk20ncKpv2LH3Rq57Ifss2IA4xA
 tLhaM+15Hw==
X-Received: by 2002:a05:6830:64c9:b0:7ec:61e4:9d61 with SMTP id
 46e09a7af769-7f028259ea8mr184231a34.20.1785358061301; 
 Wed, 29 Jul 2026 13:47:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d5f3ae0sm3188230a34.8.2026.07.29.13.47.40
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 13:47:40 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:47:38 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: Temporary workaround for b4 and lore.kernel.org
Message-ID: <20260729204738.GF1773261@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3WrKzOpZyMu5q+xy"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785358061; x=1785962861;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jmcRSwa2LBOiCHWdJ7hZjXep/ezqD8cCzktQgodKLcs=;
 b=C9Vn3QcozmJSgLqiJxuoNGLON+hBSdiYxlpDCwgDfJGAZMAgFcCmR6yWHFJJ7HU9bx
 1ma+ctWX82r8xv3h9vu7ftdoLQ/ULp23WsuEmWtkTt+XgJEXcnQRJvUEWSVlb3HT9nM8
 jkG24IjtbR4J6yovTjHKv1PmsFR//kZX5dAVM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=C9Vn3Qco
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--3WrKzOpZyMu5q+xy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

While we wait for our list to be restored again on lore.kernel.org,
here's a temporary workaround (so long as patchwork is up) for using b4
and patchwork more directly. Thanks to Quentin for pointing out you can
take the mbox from patchwork and pass it to b4.


#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: $0 message-id"
	exit 1
fi

wget -O - https://patchwork.ozlabs.org/project/uboot/patch/"$1"/mbox/ \
	2>/dev/null | b4 shazam -S -m -

Feel free to modify as needed.

--=20
Tom

--3WrKzOpZyMu5q+xy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCampm5QAKCRAr4qD1Cr/k
CqlUAP4sRMn2ZQZYctXn3PbgISiQw9NbefdAA/3QZ+yz5hThHgEA9WmbiUovlJUb
QTk9ATnXptW2wGNVKHl43S1e7F9fGAw=
=2Yo2
-----END PGP SIGNATURE-----

--3WrKzOpZyMu5q+xy--
