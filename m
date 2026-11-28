Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB36606A323
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wRjpBns7;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Qn2KrzSa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 204CD810E6;
	Sat, 28 Nov 2026 13:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aL8McI7R535j; Sat, 28 Nov 2026 13:16:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25EEC810E8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871778;
	b=DH18l/QV1r1j+yjQuWgK29Uq54h8jU7QXT+Ir0t02pVRQCfJhThj0adgXEfy8+qADuHo
	 GYKPKl26pcfLQQRwAzRZFcsz3vNwLmtUSC3OkI2hO70rit6IYl8LLFaGaEYSmkOn+Zz/C
	 Qxwl9MXYYhF58OdVV53Z+Wz2PW7mJbE2xdbWtsIirOoinUikZDhGW2donnrESoTcwPmJP
	 FgATV6B1hrnXm8dHUmC10bgjS+UtLu5nEa1NRxnOLykN2kaiKUGsL2KK5HDne7SQjs8Xk
	 ApFDeSCO5pbBnhPyI6CvoBPIhSp5hF0QuhaavWE+pfC4mk/qqLdletq+MbbFIp5o/Zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871778;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ADV4lYL6DQx1D5PwWpRnKw502T5TP7OtzQDnv8HnWGU=;
	b=aKkoYtisRVv70TEUsjljxDqufD83XwAATQ2f0Jso0+2M16tEbiOUJnnB+pm8Vjme/Wnn
	 APKaIa4kQf4lLZYB8hIH4A0NRE3wXqNR9myH7ZFYOWAxHAXTUvS0oOTitLVADKfkCWYmB
	 Y4WofwGlZPUdEnWz5GNaqDOF/FV1W75EKyKw+d6askCyp/EWvsnyHPZeWsLnX1zn798iD
	 ZPIQLECwFxb7fNWrH/pE1oAB+2BXg+HcKVw5uNMQVTkGK1fnNXe6EWJRqAnUZK1Xx4PLk
	 JKMuGL8DiTcFFiBElmKrAyj5OmGoe1lxpXY1zpBMDrvr9tbRlSusVPtiz1im0aPHbew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871778;
	bh=ADV4lYL6DQx1D5PwWpRnKw502T5TP7OtzQDnv8HnWGU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wRjpBns71n5LvGwNCUGs4qB7uuVqhd1f56qHBrRp3+zc4gDbne/XrF0uZtrNBpWX1
	 diQs1MVEU/WxnwWWyAaBXxi+DbulLxlQZJuPtIeQr85/Rg7HiKaWR+IJm9/kiL/l9V
	 V2QFpjqsw4bbWUA6b2if2aQM+l+FWjzV9yHdr/h/hv69H70DnFDF+wXHO1iF5TRJ5n
	 +oDSaUDevtdCatuFMu+WQczpworrrohIymuaOloqoWh77xleBARdMy8YN096wzcEh/
	 Zbuj9B5nrgO6UwhIlPJlrkeIWWvXONd2ddryvR/jckcdgAqGdZZGfaUVqwkm5lnaz6
	 Yc+CgLUG/zVJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25EEC810E8;
	Sat, 28 Nov 2026 13:16:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9186C2BD
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 836A5400C7
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QFW3K7mnoLsv for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 07:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 99EE44008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Qn2KrzSa
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99EE44008C
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:42 +0000 (UTC)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BE74E3FE92
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795852120;
 bh=ADV4lYL6DQx1D5PwWpRnKw502T5TP7OtzQDnv8HnWGU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Qn2KrzSakr1TZ1txRCEvuSINTsmaDfGSVg0lcA+sTylR9OyBDBTAZxNMOUFENxqra
 o8H4PZFlU38zQ3S0qfQY3u7tvV0lY5oUDSY4bcTrv6z4AVDK3/5BH/ScUu3tV8wBKu
 hejE3a7ED2hmoykAFVQXdDQ2te1LX5q5syToCJBVFvke6OXUQS/OgAreQXntmVqnv9
 5xAVf1UlvIhFAXJXGEvBClrSjU5gIGtIT5BAjHccV4OIogAEJoUmGgnzKJxcsbpYCq
 NTa3bQ4hgue5s/Jw8G/gy691hQzMUah3qjxm7bepE7mRkxZoVY983mNtcSzK378HKf
 kcLvXjFjYsPkTxmNcXzx/2gYW3ZuejkNEJwARjzgWXigIfW8qrFLfSsu+gxZvSfb85
 dHTzC/pfxgEQ61Xz99ExBBXHGG8kYIAZIu3AIAYd5nh44jbgCNDV3CDcbEm3vM7SWv
 vZC+zYXz7fnVaw0myoyS6Na5ljiak/R1xS9ZZD/Zm4oPH7yLUSPUd/4NQXoEgIa04j
 UqCQe3QwbEMcmoprybt7wNRb6CWOtOieK6C0L53ojBjKZQtPWB/DSWodcAKzXvWnad
 DTCkmzktjsOmUZImVDkU/5kH/nnUFc+nHVbbFtOfeYyzPb5W829K7KgbyGhPJYwsz7
 Jo/jzPu2WW6U0OMMhRH6WvMc=
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cdb8931aeeaso4018609a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795852118; x=1796456918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ADV4lYL6DQx1D5PwWpRnKw502T5TP7OtzQDnv8HnWGU=;
 b=nxS0UoluTbpQvFT17t9c32g+Cx9lCa+sivDD8r+Zxghnt5Pk5ubYIEL2nG0NAh7/ay
 T/42n3BGNNGj7LpEY/7ct1tVXGqxVMZ2xDBDle2wB6Y0wBGX34ssPsEO3tPHkKslzn7o
 Lyowzdeo3qpTxunqCxZzE6ALu/CFiLevvcKF0jkYoPPSeqOw2hfdS2WmrPHPLMvT1TOs
 S7y36t9Jv3vzt6JVJzHY7CUSFymg1DfDVqEOI8fnfKbRCtbkYkcLfTjO3PwS9hM7CWor
 ivcrKSNbsel9yRpN4G81FZHQv4KIpudOPcPyiRm2f0+WOFW8q4dz4iRgHYi4JSkho26N
 LCBg==
X-Gm-Message-State: APuU4Z96YvQIEL+nyy7DM2OkWUATyN4XjQO8s7FcLMiqhrmx3Rz7lrU0
 VolW4iTm9sa2kCgaLM6wajCIdOsEJPO19EyjNvF3IsW0obd25wc7GkKA3Zdm+jPoOSAY/TLiOb5
 SDRwZLIr2VN3sGjZxe3PWqUpusp7lZycO1Fn181Up9g74+dL7kbT+Iuv2csGfOE7lgat9JR2Bk0
 tA0mb3cIspZU3UfvjjBg==
X-Gm-Gg: AZFdTZcJ4Ob8qNkwru0/jShbo0QMFwhWXy9OMckNVEJn2MyOBRdsk9k7paUt0iZ5yhV
 lFZzdKumDEzSrS02OBVNiiqrf9yXkCrBX6u0uCgzlnFsJ5X9NCbdGgEB0v5gUVwdURbHKzpFtxM
 VuHFoqPhOneBBHExfWaLDKncZ5FBIzSv/nIsrtgDGvIWHZrXPaA59AH4WBkEE4FyFK3IFMDc6xA
 fGoK2Jr+wUDsxzByocBnQ3BH+4fYt/ZJXvu61a1ObXen5NUgW+VmPfXr1uNugZusk8NNY224gx/
 36iO4aLnZ32cTYhfkP/qYDAbmLQWxg+seDWiUrGKVmfaxAvxp8zv9ygZF401FAgc44fYm7tvxEO
 +ktaJnBCjcsbEcfyGuJbYtI5l8BOAayMksJX6Xzs1dVYSnrUMFfyV4y12jjkqjPG6CbORSWc6h+
 /QLpauXwZttts04CYWjybZeVH+
X-Received: by 2002:a05:6a00:c08a:10b0:886:3a6c:a9da with SMTP id
 d2e1a72fcca58-8c91eaeb4b8mr19469796b3a.26.1795852118509; 
 Fri, 27 Nov 2026 23:48:38 -0800 (PST)
X-Received: by 2002:a05:6a00:c08a:10b0:886:3a6c:a9da with SMTP id
 d2e1a72fcca58-8c91eaeb4b8mr19469782b3a.26.1795852118051; 
 Fri, 27 Nov 2026 23:48:38 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e4af1fsm14086238b3a.28.2026.11.27.23.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 23:48:37 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/4] cmd: pstore: handle the dump records as Linux does
Date: Sat, 28 Nov 2026 07:47:36 +0000
Message-ID: <20261128074801.11306-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Nov 2026 13:16:13 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dump records hold the panic and oops messages of Linux, which
compresses them by default. pstore display does not show a compressed
record, and pstore save writes it as it is, to a file whose name ends
with .enc.z. This series decompresses these records in both commands,
after a fix for the names that pstore save gives to the dump records.
Each change is followed by tests in test_pstore.py that fail without it.

Patch 1 names the saved dump records after their zone, as Linux does
and as pstore display dump <n> counts them. pstore save numbered the
records that it saved instead, so a record got another name than in
/sys/fs/pstore when a zone before it held no record, for example after
the file of that zone was deleted there. Patch 2 saves two records with
an empty one between them.

Patch 3 decompresses the dump records with zunzip(), into a buffer of 3
times the zone size. This covers the records of Linux 6.6 and later,
which only compresses them with deflate, and the ones that Linux 4.17
to 6.5 compress with their default algorithm. The buffer is large
enough for the text of these records since Linux 4.20. The commit
message has the case in which an older kernel needs more, and the
kernels and algorithms that are not covered. A record that cannot be
decompressed is handled as before, which is the case of all of them
when CONFIG_GZIP is disabled.

Patch 4 checks a record as Linux 6.6 and later write them, one as Linux
4.17 to 6.5 do, a record that is not compressed after them, and a
record that reaches the size limit once decompressed. It also checks
the records that must be kept compressed: one that exceeds the limit by
one byte, one that is cut short, one with the zlib header of Linux 4.16
and older, one that does not hold deflate data, and one that there is
no memory to decompress.

Patch 1 is a fix, and could go to main with patch 2. Patch 3 adds a
feature, so the series is for next.

Each commit builds for sandbox, sandbox64 and pinephone (arm64), and
cmd/pstore.c builds without warnings with W=1 for these and for three
32-bit boards: r8a78000_ironhide_cm33, rpi_4_32b with CMD_PSTORE
enabled (64-bit phys_size_t) and tbs2910 with CMD_PSTORE enabled
(CONFIG_GZIP disabled). The last two also link. All pstore tests pass
on sandbox.

I also ran both commands against Linux 7.2.11 on QEMU (qemu_arm64),
with dump zones larger than the record size. After an oops and a panic,
pstore display shows for each dump zone the text of the
dmesg-ramoops-<n> file that Linux has in /sys/fs/pstore, and pstore
save writes files with the same names and contents, to the host through
semihosting. This still holds after dmesg-ramoops-0 is deleted in
Linux, which leaves the record of the panic alone in dump zone 1.

Aristo Chen (4):
  cmd: pstore: name the saved dump records after their zone
  test: pstore: check the names of the saved dump records
  cmd: pstore: decompress the dump records
  test: pstore: check that compressed dump records are decompressed

 cmd/pstore.c                 |  86 +++++++++++++++++++----
 doc/usage/cmd/pstore.rst     |  11 +++
 test/py/tests/test_pstore.py | 132 ++++++++++++++++++++++++++++++++++-
 3 files changed, 216 insertions(+), 13 deletions(-)


base-commit: a1ce46a6689641dd83d725edbfc3f5719abf3a94
-- 
2.43.0

