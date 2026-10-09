Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1B2CA601D
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4C73608A9;
	Fri,  9 Oct 2026 09:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJbL0JOnF87P; Fri,  9 Oct 2026 09:16:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD7D6607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791537400;
	b=S6ygYD6K1V2YxpWBoJSENCFDEa+sUAXIb4vfmFXM+yR2b3yVRls5ZqsRUpYi68qmTxKD
	 vED10edAYBzhyoXyhtFmanaKAE973PoXSqYVcQihukl+Pqfic8rwSeeFRQqhMYWkrotSL
	 Ah5H+4jw/GV7cONm0OG+A7poUQovAQRId4gqtXrnMNYV1fCfrvNAWdYvrgoAKUBKheKhy
	 HykJ0emy4OHNRSlwA1Izs8W1SfLywchGsZOLP0EU5zM1gEwwxWpldzS9q8kpTpU+vr8hH
	 ed5387Nl0gTcWSNA4jnp58tVviQ94Ig4N+5nEwN97bD0RfGycsEBDuqN7/TTuKHauXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791537400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AVhI0j3heayWGejlr78xVBXxvzHPV1cN0fb0WvvDrpQ=;
	b=k5skUpXRzsFtqOvtbOjCOFekEj5IEY51EX9yhz7tncO3uUEayVu2+gwNH4+zsdwH3eB5
	 Wpdn46P3kQYVgq4ni3wPHBMXtfkM09vDr9XXaRbCK+IGNwuPUa1yY7jyCYrb5ZPC77NvD
	 m/kfvDUm1N2rjG2lIy6tHvkij2Rfl/gt4sacL/oSurSAZtNxS5+TLoGX/q3ezl+afnkK1
	 3H3BBrR7ESklOzUbfZgmxumu3Fb1qVUJz+6ZDVSTKfpreP+z/Qcwmrd5oP8i5YnPqBL6L
	 aKEq428aWzcBa4oZ4mODDniNnveaj59Beg5simbETC14Ky33O6OLW/Rp8GSikdskDZg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791537400;
	bh=AVhI0j3heayWGejlr78xVBXxvzHPV1cN0fb0WvvDrpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F9a3T2wSNXI3rKyGnvyKjRNxqF+dnVTR4TWgN5UIo243p82/dj/RET331YipLasN8
	 2Zo7C1ok4/jQ/pco8SSiAVtj5wlgH+Oyq0AvR+BoDA7G/VHcr7F5HY7SRJV2vBFTuQ
	 H+RjoXCcZhhkLVb8pv7Z3nNq9wHBhDevA1yoAs6+oWOp4C530LvCBkjDimY74ktyci
	 6ibd93FxG0bFJZGKaQpQYk7ojoxjtfxz479zkB8T5hbSafzMl/WX2vYHoLOCU1MIcd
	 RlvuYCbj/OE1NyGCjPobn6Edc8zwEuJnVj5qdxias+5NVefE7UMT88OmdQC1319cWm
	 /V51L1h1qKudg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD7D6607B2;
	Fri,  9 Oct 2026 09:16:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE99E422
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A43C48137D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pLflMRhyido for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 08:53:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 112798129D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791536002;
 b=GX7eyunW5Wywxn9fIpwudVQ6nduZLlOz11kui0CgMBypxJhcF+lgly9wyCck/THtPrxU
 bXiotVYpxK/ZLb7mS6ESNMXxudoisuagSdYbllSkyiudEzCyzSWFm7acZlXcQB1GjBRnv
 iq4nwC3z2kiuYK89lhxAeRltflLRbaqgmf3uEcVodp6B4hFbTUb+sLdOdxiVhacpMJl22
 hvTmDKCEPZyu7JNhO9ru7wIGUCvJad+KsWtMKquNU2xC8pis880nPcbyfEyOLPgB2xiHk
 XP3herl1pvMW6oVxhs6bnNi3e1HMXh9w3PdMmy+Tucpu4lQmSc+pU6Zn0QjtmuZYWeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791536002;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=AVhI0j3heayWGejlr78xVBXxvzHPV1cN0fb0WvvDrpQ=;
 b=IHsL8nFJRlRyQnj/P5t/2fMTJuTJDhBQT0mxDy3da5tTQeKfFcsQnI9RlgZQUnKS8y/2
 IIVzhi1uLSMLX/QkqWaV6fvT3Bn+GqZzO4V4F5mTo67G13kut7TFkye0ZXX+tUPj39Zbp
 Fp9Zs95oCkLV/Y0DtR2/64BvTg1rqWRcIH9gGy5XaUt1lArXhgWJd6YAB9qbLeTIUaOj1
 V8LBMk+4ko71hQ78Tol8V24xV/gorKq4xP6clalVb50LLYt3CJMxgyFW/VbpYkXlDBVYG
 EQIbKaP+l9BCBs+84jkClHXmrvEamPgyTxxMJCBjFUI5m4THx7a8BqH592RxzvPXUFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=jl3pZTNq; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=jl3pZTNq
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 112798129D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:21 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64ECF3F2EF
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791535998;
 bh=AVhI0j3heayWGejlr78xVBXxvzHPV1cN0fb0WvvDrpQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=jl3pZTNqD/M4a4RVLYA478Z8FKCs5DrNdb9YN2PJa4fAaBcBqoWDM2CZ4yS04S+ki
 PT28s3sRLqt9OQzqFCXN1X4MJRhcJYHKvWPW+poM0DLWtpowymz/INTS6cFHZmNBC0
 EUUXc+u5R+pYMVel8P9P6DAEuV19X96tiIf+HbaVvn47GSgLx4KnTk1moVe1NTeyeL
 uusdv6fpN8jd2Gp+oOlCYtfDGg0Pe/SF9PjNk6dwQsdAtZ6ZhCrwTAw6wgwvonIuZ2
 5OxgP2blvzfXZek/njOSBykEttT3uTH0YA2vWzECD51pD5HaYsyPqTVWSofSK3NYGS
 KIuKuH1DqHsp+ZKFOq48xDuuiYpYkB5ig8keZKldvDX32uDdACjOAFBdfpUCza2OfY
 SG82jcK4rPgK7qApHArfCQ8G8/0YAun6aZW3Yp0fT/J5tE0BQfw/qhF6jcK5LNlBUa
 Zg7QYcoh/TbG5T6n7QJ2YkT70eehZWJjrTa0KI0BPMzE9zElT+XocQWcYRcagM/F4z
 tWKMo2YP70bngSdfrDfvpCfvWWjHWBNtcpNrUeu9DkIvQBkhP1fnr5J9bJzg4N7tBm
 opAQHTvDx7zo2r/+YbfOffUcKPhRIN+woNT7IhJ91gkTkuzHRdoFdsHEaC7rVt7sna
 hJ8fz6FMJv3TYTxleUMpk5fU=
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30f1b904861so9199877eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 01:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791535996; x=1792140796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AVhI0j3heayWGejlr78xVBXxvzHPV1cN0fb0WvvDrpQ=;
 b=oykIMafh8lUYp3kpI2fZ7fVDsHZLPghAxKtbpki9qgalAYpq/4D+lwGRHZEeheo3dt
 noHsY2rsjK2QuP+56ppxi+WbaixlX/3xL25puz2uaUntNrxmO+KLRpPdF4Y/EoHw1RO+
 WU9LQ92g8U2pWN0gAeMIdkz5M1q9wSnnA3HT5O+RZqIWGP1TZFLmBcSQVRt0rSMioJqw
 fNxdChfinuHaObcTmdPsl8DTs7kH5qbxVzgr5mcOln6vXqGlIs5jiv5Y2o8MPUUAGZBh
 nGaVyVfKEKP+IQ/JcpqZq/ZP64gKc2juMdFtleZn+110AZ7uGYT5YEbeHeNR650KHR3I
 LMjQ==
X-Gm-Message-State: AFuF++nD2T2ZvO3qwbBG/8zY301yUJz4B/YRTUGbVzhj5vZHOwadMb/r
 IVAQQvYcFD37cvUl4YR/rcJBZSSitKEMVAA0hAlhwdXuz7lXSlaGqr+OnJBKccTBp4E3qo/G71m
 jb27LkTDN0U3sN9Jf+4pzdRYqiUU0Jmk2sJe6UBLWNmEdp8tt//ecnunss9jWTbWWC0ya1RQTfH
 aXdXu4X8uzCQSUV0cqWw==
X-Gm-Gg: AYBFou2kKXXpuYvdKItuInWJXc8olNU5lfKcng13UHaSTXE8ZfhOkOq9APRjm2QaBjc
 wj4ciuvcENHt5JSanflqyZ86Es/c2i70gXiczgp2G/+BIKjfUrsaYmtC4eDUs02niiSA29/6VQY
 dmlKvbXOFHN4oYJHaEG7U+1d0F9lW3J5Kz2mVM87d7B2UaGfsh6Bxum8zEGw4bNxWT4dSOZ7iJq
 gP2DRrpNLnDb9MjO4Q3J+or+NAxl5KaFc7BeMUzfIG2X1+DH+iCmm02neDdD/3GBRHQ7it44U3v
 wSu2CI0zfTkEJBuObETdm+Qyk6e+UM2aOWB+COxN0GEH3HCIxInCuRpwqmlFya8PvI+IpdiAQP1
 Hr2EH9sgeFkYpzca8b7ZDfXIiMgUZedQdbnM6AVZaBeGkXgK9tWz+UUGregT2rN+sGw==
X-Received: by 2002:a05:701b:4512:20b0:14a:d8fe:33b3 with SMTP id
 a92af1059eb24-16a62bcc0a7mr1406561c88.40.1791535996380; 
 Fri, 09 Oct 2026 01:53:16 -0700 (PDT)
X-Received: by 2002:a05:701b:4512:20b0:14a:d8fe:33b3 with SMTP id
 a92af1059eb24-16a62bcc0a7mr1406537c88.40.1791535995784; 
 Fri, 09 Oct 2026 01:53:15 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a32eb7ebsm5765591c88.12.2026.10.09.01.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:53:15 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/2] fit: use constants for the cipher property names
Date: Fri,  9 Oct 2026 08:51:13 +0000
Message-ID: <20261009085250.331110-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008070116.328864-1-aristo.chen@canonical.com>
References: <20261008070116.328864-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:16:36 +0000
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

The image-data series [1] added FIT_IV_HINT, FIT_IV_PROP and
FIT_DATA_SIZE_UNCIPHERED_PROP to include/image.h. It was on the list at
the same time as the series that converted the remaining FIT property
literals in mkimage, boot and SPL [2], which was written before these
constants existed, so the cipher code still spells the three names out.
This series converts them: patch 1 the iv-name-hint and iv properties,
patch 2 data-size-unciphered, including the fit_cipher unit test that
sets it. The two patches touch different files and do not depend on each
other.

Patch 1 also uses FIT_IV_PROP for the iv property of the key node that
mkimage adds to the U-Boot device tree. That node is not part of the
FIT, but lib/rsa/rsa-sign.c already uses the FIT_* constants for the
properties of the key node it writes.

No functional change is intended. Built for sandbox and sandbox_spl
(U-Boot proper, SPL and host tools), the objects of all touched files
are identical before and after the series once debug info is stripped
and the embedded version string is held fixed. Each patch builds for
both boards, and the sandbox FIT, vboot, mkimage and dm-verity pytests,
the fit_cipher unit tests and the binman encrypted-FIT tests pass.

The series is based on main, where these constants are; next does not
have them yet.

[1] https://lore.kernel.org/r/20260922123630.608961-1-aristo.chen@canonical.com
[2] https://lore.kernel.org/r/20260924055459.125648-1-aristo.chen@canonical.com

Link to v1:
https://lore.kernel.org/u-boot/20261008070116.328864-1-aristo.chen@canonical.com/

Changes in v2:
- Patch 2 also converts the two literals in test/boot/fit_cipher.c
  (Simon)
- Collected Simon's Reviewed-by on both patches; patch 1 is unchanged

Aristo Chen (2):
  fit: use FIT_IV_PROP and FIT_IV_HINT for the iv properties
  fit: use FIT_DATA_SIZE_UNCIPHERED_PROP for data-size-unciphered

 boot/image-cipher.c    | 6 +++---
 boot/image-fit.c       | 2 +-
 lib/aes/aes-encrypt.c  | 6 +++---
 test/boot/fit_cipher.c | 4 ++--
 tools/image-host.c     | 6 ++++--
 5 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.43.0

