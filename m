Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66116606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ooPTuGkI;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f0bUXauq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B2616065A;
	Sat, 24 Oct 2026 10:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8VU41NK-_b4j; Sat, 24 Oct 2026 10:12:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 413C460680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836753;
	b=PunSwigC7R5bek5LUOifAnk+ysjEggwN5e2aIGy/S0Ouznlimw7ruiD5Og3ngzuaeDLA
	 uc/vlH1BvPmvvuSFrXR2ley/Ym9TyR1eOBzTEih3M/BBodnssD5hXTz5JsiPiouP9srfw
	 9RK6PKnhSdxBAVKa9oZYe2aEEHxfQ9TOvzaw9HTTLoEuysCmb2YL6IUc5sRbn/6NI1xeM
	 7U3TmSYJOuN8dXmXIS94aDIn5s2IhH8baJIZnVG9BLp9+/ggwX1XdvIibaPKl/tuluexl
	 X4ceOif+8p2pr7Q5ocFyl5b6DEvqfP2Ss2S63lFVlKD3Cdc5ayQ2O5IYZZdHS7GTrtQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792836753;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0KY837XrZpHflpd8ec+loFKAhCw88NrmC3YJ8kCu2tU=;
	b=TO+UNfqqgeyHS7f4bw//MZyMUXZ2CzA3fb6RUVPKWPikMgrx7emWA+UhBBPhrVEAGoBx
	 dXcdurNyUuW6cUSIB7m+WxTy8/FnbLS0ilH04Xh/SZutO8mSz/SmAzOb9JoOq/gDTwffe
	 N0uawusTwLCmGnJIxWRVdZWn5MQkms6wKGkajGEQm/JZY7KKofn4auv/y7niHIegwKHjF
	 aXroxIvdarONN0ym+j8o+I5g5HBkLdHvxFajXQ0Rz6czgSO7oWmB5yZg5dD4xHk9uauhm
	 N/3E/xko7v2+SF/JEgREDLAihkK/91NaUJPUe8w3aQV2yOnl3XdJgkvu7sPZ4b4Ua4A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792836753;
	bh=0KY837XrZpHflpd8ec+loFKAhCw88NrmC3YJ8kCu2tU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ooPTuGkIIvzw+XudxOo/RTdxO2aZw6jYwpl9sU01jqeFil+5XMb7BkRkx96HmDyBc
	 e2gVSv9LBAMhYZ1i1/57lplNcNrueMOv0VO0Q7ddMkeFLAcYUv6/cmva2HcDlan3Bw
	 99cIN/yCRvZhMKk3E7s4sn31WDznbgKrCc/JpLPthf1XSLse5i556MZDdCgGIsc0Qt
	 DXdjANutRbsDIKYp6xYf0KqMrtjmfaeA6MpFkhXAWS3G1qXpG4A9POXTzAlDBjLkSI
	 nNLKs6L8qPPsG+vS0/dDzJ6wQe2KotWX+oQMNDfgDCFGJq2cyGkJ4PFpy0yKguKfmu
	 aaUTdf/3x0AuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 413C460680;
	Sat, 24 Oct 2026 10:12:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80F4F235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7309340A58
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V0MNd39ZNprv for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 10:12:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B68040A57
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836751;
 b=KaIXlTRQxSLMMgufm3PMrgR1d+ZgL3pblo7oK94OT8deQjHI45fWGIeOw1hgoJxADQhz
 GqV/JKkzPqzsuKwJhqOexLGPeVQOI4o7UDsUn5g9B8y9vSj6ggz96gNhrSCnRc05b2FzD
 ULyljCBnQHPkkUrLTAWRuycu6yXnQC0E2FFsQkpzVH39VXsDAwkyoLII+s5bMz+lSLwzK
 2/PJpImBhKrhmyuwpdca8rCnYr7+6ZVlSzOwIB+sN1k9RsVXX08f9qE/LrA/YFcBOCnw9
 zHs2rDiLg4eZyGdGJOdGKMoFjAjV5zjmLbCCkemPPAxV4qWQdOVAHQTZ1ELsPoa3pgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792836751;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=0KY837XrZpHflpd8ec+loFKAhCw88NrmC3YJ8kCu2tU=;
 b=Qogrn6Xkc1XMi/XFFau4i5XhoI7mviwPHXa/exdYNmhh229o3NnCQjy0Rkpl7dqdpghy
 XRipaJmUVe8z/mbRfki+ORjcIp/s6V1bsjvGRES55wmOpWzFDBxGQutXTuSJQKmkCyUNi
 Ip4Y7gLmL5nqJLnGNWVccHs0apgPUC5QxaIvXqRtCTp+tspLnMo0q1V/CyNYtnwyuyN+k
 OY3OXnwYikIZKuqzFlNf1yGA8XVNPZLq1sGoQuXip2HPVL00aC8DHYre475BpyPvZC8QL
 9vd4rbnUfg29doKLQQrnMolz/z1RLiY9BfsWLEZRY8hB/BBoxNkttUrCuEYzEBjkieA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=f0bUXauq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=f0bUXauq
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B68040A57
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:30 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6faddda49e7so1420118eaf.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 03:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792836750; cv=none;
 d=google.com; s=arc-20260327;
 b=moUv24OSKHHy/KXXETOVStu/bmGsw3xBqWJJIFHCKZiaGz6nKr9ZLHQY9o9oPmMBar
 HAeOQiIog6s+YB9hWG8oPj0uIstedM3iig8QXRSqaPYscm2otlYmatvQtJW1AVTfayhZ
 OMARlVempDx5bvPdkCRsQ2IwtDh7g4sYSWx90cgsXzs59Q/0E/jN/H7eJNLZraestP6b
 jtOBHvktEyM9vpmwnWkYen6Hpa3QgcNqvauejr4Wi7gIE3a95AuehFBmKj/mVJrICYFV
 o2jzJE0eIAZv6U1le5MnTtbN0IW4svdzsPQzzkASl1TKm0oS13WvWs5+GVXqHHOZRNKc
 LDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date
 :mime-version:from:dkim-signature;
 bh=0KY837XrZpHflpd8ec+loFKAhCw88NrmC3YJ8kCu2tU=;
 fh=Y1ZREHJ+pHB0HlzZ/KBn18KcwK0OUTCLdCrezQyH/Kw=;
 b=fTvL5Vl71Bo5apz+PSwYsxeHD1thF5YqZcibOQvzRuhE6eu7DDDyrRt/3V4XNa/gZy
 y5wT+ZaU78rx2xK/ggx9Q6nF5ihxJamYWMmuiJCRZDzj5NuA+jyhmElHdHRY+8nYSXXu
 D1D8f+k5O+Ak/F/8jnjQUbTJo6CHGKAbDPXBRZpmXh1T74NDhXNk5S9NwRpGK3HzHWE7
 VoCjaqnSZL8mZwPjy/4oq0E/D3oCoLVEKob704rc4yQXhOuihlvIwaBeUxYbAG98FZ01
 6NxDtxn9EglW7czGp5hzy5yKaqtVF3iGKJr7xGWpglxOItOrTJAQg7s8uRX++cZhKlox
 HGKQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792836750; x=1793441550;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0KY837XrZpHflpd8ec+loFKAhCw88NrmC3YJ8kCu2tU=;
 b=f0bUXauqyemJgqexRyLfTAUF9dh/abzsrID7f/P2yIEGMRuz63BqbslZK3+UAHqwyG
 DpbSbYiV1H4hdY9ftMfZAH1DvX7VGL+TU8MouDlJ12ARBsnPbhsUR/BqXYYVdkU9x4ix
 JevFtLBNTGM3T6nrcDsQ9wQtcWIc7QvpwYB0vzc9DjRq0HGDrpr9lVMuFLPopk8M8STr
 ckB0RWq5Gc8oQ0gGySVXMXGWLZmExM1rIN7je/JP3eJBPuJJwtZNp7vAAYO4335CrXO7
 AhKHCRlK4b/eXBuRlCdsrYvMbb0u6Yllco8efgYYfsZnrBZZm5tKbIjc1RkWcA9C7DH2
 aWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792836750; x=1793441550;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0KY837XrZpHflpd8ec+loFKAhCw88NrmC3YJ8kCu2tU=;
 b=TM2CXxLx+KR8YNiY5UKKcYLW2YvB7sSn+mF7EFDi1yVRX2yjoVx3d46bdZJefo16Tg
 21wLOqz9uEb8GQDTd/Rs83xytTBrZ87NJ74tPWQDz8nvwZu7PJOkJrxfWWntdkGy4O8x
 Os8Eu9rn8BeMWgfwKumOTIJD5f+/NKSbZXBpHrRsH4TFSkCRTkKJ2WSPZOKUqMaD1Zk1
 +wRKUx49IRYIs88srWXvZS6XQkKinlyHA29isZU/cV0ex/jseRdHLIHVJWiMzBo57M4f
 a29Ucjsd+CICoJQXTCXP9e+jAnkRihRIbF3LejzedcIY4/lq+6fmtaDSRcYOwlsskZan
 G58w==
X-Gm-Message-State: AFq9FYIBDp7bzIh44+A4H92I4Fhk51GHzKLFGsgVeDeTTHWM0z5z4csO
 eFBlYiNExrsukH1RGlP/gh4W/3EqRGGzFt+67mG7Q2tPcdeM/scBB3so4kZl6mhGiFEBaDoLcOB
 WhsgEtUvMFzg8TPXh4MBb1Zi51mNjMRzJYbGL
X-Gm-Gg: AYBFou0jLlF3Zj1T17GMjuDAJrzdpGizOwrfJEAuyqINb6Iceh4z0EB19E4XD9kiY45
 AGXbXiGIGMk3Wl2khkEYzSG1fiksgf3bGDs+3y+4ZS7EWgJj46+Bk9NElHETRpkrsyLQcgROFS+
 BhVPlXag6G+ZorVGexFr4BW+kKLTQXcnVwAh1K40D6SWYGuYDvYiSfzcStEncFuPXJ6FyjmX5T/
 phZv+kjmn83OPWLOlBJE7ZNGlzVF9gq6G4A2uyhh6p29K82gqGH4sG6MvyJhD2dwQnG6eQzlP2R
 MpMPWT7aMKIE21S5T6aFN4u7EPX8omVNJG+mA2BMTPEnQOTPLzp561rZysBan1RXFjji/YSjW60
 N5VFFK2rXFCL+td41QnF63G+t2xkSbrh7DjitXQ==
X-Received: by 2002:a05:6820:7099:20b0:708:d037:c504 with SMTP id
 006d021491bc7-70ba0e12c28mr441117eaf.31.1792836749704; Sat, 24 Oct 2026
 03:12:29 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:28 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:28 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 03:12:28 -0700
X-Gm-Features: AclHuK-geg58O5m76zWHXv6NPL_aKb9Dnrwoy5M44R8BzNqHnjeGSGAGnQu5Meg
Message-ID: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
Subject: [PATCH 0/9] block,
 disk: Check block sizes and partition tables of devices
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, 
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot scans the partitions of a block device as soon as it probes it,
and takes several sizes from the device and from its partition tables
as they are. A USB stick or SD card that U-Boot merely probes can
therefore make it read or write outside its buffers. This series checks
those sizes where they are read.

Block size. A block driver sets the block size of a device from what
the device reports, and only the virtio block driver and the host
command check it. The partition and filesystem code sizes buffers by the
block size, expects a block to hold a 512-byte boot sector and converts
between bytes and blocks with log2(blksz). So a USB stick, SCSI disk,
ATAPI drive or NVMe namespace reporting a block size below 512 bytes,
one that is not a power of two or a huge one makes U-Boot read or write
outside its buffers, in the partition scan run when the device is probed
and in the filesystem code after it.

Patch 1 adds blk_valid_blksz() and has blk_post_probe() refuse a block
device whose block size it rejects, which covers every block driver.
Patches 2-5 check the block size where the USB storage, SCSI, IDE
(ATAPI) and NVMe drivers read it, so that each refuses such a device
cleanly: the USB LUN is skipped instead of failing the whole stick, no
SCSI block device is created, the ATAPI drive is treated as one without
a medium and the NVMe namespace is skipped like an inactive one.

The upper bound is 64KiB, the largest logical block size Linux accepts;
the GPT code is already tested with block sizes up to 32KiB.

Partition tables. Patch 6 checks the header size and the size of the
partition entry array of a GPT, as Linux does, before they size the
CRC of the header and the entry buffer. It leaves
alloc_read_gpt_entries() alone, so it applies with or without Beno=C3=AEt
Monin's "disk: efi: Reuse the GPT entries buffer with simple malloc".
Patch 7 walks the chain of DOS extended partition tables in a loop,
bounded by the number of tables read: a table linking back to itself
adds no partition, so the limit added for CVE-2019-13103 did not stop
the recursion. Patch 8 makes room for partition number 256 in the UUID
made up for a DOS partition. Patch 9 has the TCG2 measurement of the
GPT check the primary header it reads itself with validate_gpt_header(),
now exported: the partition driver falls back to the backup header when
the primary one is not valid, so the measurement could still take its
sizes from a primary header that the driver refused.

Patches 1-3 and 6-9 add tests: DM tests on sandbox, for the GPT a test
in test/lib on a blkmap device, and for the TCG2 measurement a test in
test/py that starts an EFI application from a GPT disk on sandbox and
checks PCR 5. Without the series the new tests fail; with it they pass,
as do the rest of "ut dm" and "ut lib" on sandbox_defconfig with
CONFIG_ASAN (but for lib_crypt, which ASan flags without the series
too), and every patch builds on its own. The test/py test is skipped
with CONFIG_ASAN, under which sandbox cannot run an EFI application; on
sandbox_defconfig it passes, as do the other EFI, TPM and GPT tests in
test/py. The IDE and NVMe changes are build tested only, as sandbox has
no emulator for them.

Ana Bobillo (9):
  block: Refuse a device with an unsupported block size
  usb: storage: Refuse a block size the block layer cannot use
  scsi: Refuse a block size the block layer cannot use
  ide: Refuse an ATAPI block size atapi_read() cannot read
  nvme: Skip a namespace with an unsupported LBA data size
  disk: part_efi: Check the header and entry sizes of a GPT
  disk: part_dos: Walk the extended partition tables in a bounded loop
  disk: part_dos: Make room for a three-digit partition number in the
    UUID
  efi_loader: Check the GPT header before measuring it

 arch/sandbox/include/asm/test.h  |  20 ++++
 cmd/host.c                       |   6 +-
 common/usb_storage.c             |   8 +-
 disk/part_dos.c                  |  47 ++++++---
 disk/part_efi.c                  |  48 +++++++--
 drivers/block/blk-uclass.c       |  15 ++-
 drivers/block/ide.c              |  11 +-
 drivers/nvme/nvme.c              |  33 +++++-
 drivers/scsi/sandbox_scsi.c      |   8 ++
 drivers/scsi/scsi.c              |   4 +
 drivers/usb/emul/sandbox_flash.c |   8 ++
 drivers/virtio/virtio_blk.c      |   3 +-
 include/blk.h                    |  20 ++++
 include/part.h                   |  23 +++++
 lib/efi_loader/efi_tcg2.c        |  16 +++
 test/dm/blk.c                    |  41 ++++++++
 test/dm/part.c                   | 146 ++++++++++++++++++++++++++
 test/dm/scsi.c                   |  37 +++++++
 test/dm/usb.c                    |  45 ++++++++
 test/lib/part_efi.c              | 161 +++++++++++++++++++++++++++++
 test/py/tests/test_efi_tcg2.py   | 170 +++++++++++++++++++++++++++++++
 21 files changed, 839 insertions(+), 31 deletions(-)
 create mode 100644 test/py/tests/test_efi_tcg2.py
