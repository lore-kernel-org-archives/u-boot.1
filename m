Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69060606A325
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A8LMZGC5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nZm2jAT0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B442260635;
	Mon, 26 Oct 2026 13:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OjwXWHwWN7T7; Mon, 26 Oct 2026 13:19:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E53360612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793020752;
	b=Y/fWVjGoFz/osGTSdPp6a4rcgCALKgVJo9ozFA4VywJEehXkXYXSSeVjjmDISz/YVqvx
	 zObydmQAsCo+4CQ9G+yMJigMOtSK4A9qXj09ce4WDQK/36MoauooEkhI5Pns41CA6RDwH
	 aYgWaTisz0kQbutVsNvUY7+bXaRIl56W31i+xPYk5t63D5BVRYNTBDM7icwlb+M5Fobi8
	 UUlhTUcfKAAiWQ6VtwDbadd7bYaGOZw3xlt3tjT2uNCmzNOMLX+WxoAcxx32CvViO9JAY
	 qm7bn6jqQHUhA0nQeji5ZwA/3qGjUSTk0pNAbbHuhaPJ/j8JBeAa3hGXgdWagzxl77A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793020752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gZK50kW+1k0n3ZkLVndgpShafn9w3GK9GElRYKJKRSw=;
	b=AEZgTtNV/QyjrqZvLUro+2cHf7237ubbcCngeuh51uKMVKygnN6YbmZB8kiJ+SoZnIjG
	 Kz7pSShRj9r1G1RqcjHGEzs1M2Tefer1+arH78KJ09sAlMwxyi86OkH+/cZiWUiD0F67i
	 d9NxT/1fkfN1WcgGb/rx2AnXkb8QSQpdL/OPuPctzZeNqiVgRP2Y3BCRPNLXQ9ldobfCa
	 FDY/urR5XRwITSpYJEt9FD4TwaMyuGwT/znmEsWZLIBUCDGfvKWBI14Wl6bRGwRxtf+Gv
	 5trlthRJRE7x9KqKD9pJvKhjwXJz6bcvmpd4Hj0KPjJ3Y8dpzTYFNH6Rl1q/pIVNB6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793020752;
	bh=gZK50kW+1k0n3ZkLVndgpShafn9w3GK9GElRYKJKRSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A8LMZGC5jSmERz/LIlj80mItuwjQbbyLG2UJxL2K+0JCXJ4huvftxhrOAM/ebJac7
	 qicAqhNjKgxR1VYArJ8CshQM+ld2cKeuVUDhCK5QjkzA9PGmfspthviY++BcQ/85ac
	 /rnQoaRL4iMu58VNR5t2eSz2jTYtORx5GIjvYbiCraBz/pGUTV6+K+LxLjU9girO8B
	 WxrhRCcufEbCcKkJ+dg66Z6CG2b9QYlUWJOYpaGdx6zeys4+m4bVGhVBLGNGsfPqjQ
	 wucf0j7TqBDW+yq58/2KvTb3PO4eC6VVugIDdNPHsqGgAWhkLVV6DdVrMxcioJJUtu
	 f3SSaTMJLLFSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E53360612;
	Mon, 26 Oct 2026 13:19:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A2D735F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85BE040112
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id olDVDOX9Ywr1 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:19:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 73F4A4007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793020750;
 b=QXyuqfW+7zuktAT1PKHz29+vFlyEOkmMI/qa+caJTKaGpY/kYHro57GfKsSjb67O772v
 qXOS0XdE3KsIb0ZXtYS9+dswSHUlIEjuwUua8EWW9JrSlEan51WHUXfLuwWy5M2pGmIf3
 h9Ic3v3GE55YZ9tk4p4AsiYD9TCN86HLOC7YCIm0sqfDkWY7KYZUtptmePCFlM3fzR5E5
 cq/AXruNXzYXu2lpaI5rnD9hU3nE2rJAH36FALRZuK9DRWkric/imRVqAHrGWkLknWwIq
 Asx/jyRGTWR22hkjh3LnGEIRUMPZ3g3kf8L7BImbLzTFJNcekbDqxhbe2E/PaVPhM1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793020750;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=gZK50kW+1k0n3ZkLVndgpShafn9w3GK9GElRYKJKRSw=;
 b=kLMxI09GkcuzLLpp4je6C+m7kyLX/0qj7r9DXi49CjJTNDukA5Jpz0eTqHwApFyNmyLi
 IncKFxIrDuDh7Z0X3zYrybWDXLXVMP5oQXNLaHfcGKUTBf7dMygd1rZqRIYta3BgMidG4
 pI8J9ZRawrFH7XNxNAlKMcCM/cQsnO2SsIolZDTkaRwS3JVbaWdU/S2w0SptVJkyq2fBA
 wLDtQrc1ahVyh2/JV+0dXJZNT4Xey4QWHsDHMWKebglxccrzztn3IVBMPAcc1pFWrOHVZ
 M5LgYYB7cbzrAmuefUsHyehDQYQRAFx9lJoKOnHiGhJ7eP6i2MG5VC4E56nNWD9Qr/w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nZm2jAT0; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nZm2jAT0
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73F4A4007E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:19:09 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso13749305e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793020747; x=1793625547;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gZK50kW+1k0n3ZkLVndgpShafn9w3GK9GElRYKJKRSw=;
 b=nZm2jAT0G3CMY2IaDFB6E5Bki/NIXZzRnxHSHdVKeQ4H/GOR+XUcVp83ii1n4o0VUZ
 PrLHak0UjPwF/wEfjIoQOfecN2lzHAWIJ4QVqggOKAf/2gMbUpHAZd2PuGk7shSrS3RQ
 amEu+jNnVdtdJ3YlUxey2ZoFOleGvEsoQC65yiLTP73MLUBN8fK3w++8k2RQ/DN6d+bb
 6jy2eGi/MEjwtclAKZ/9OXTQm9GTFqx07qGvfZsmJS35aptlQS3QI+p/jy/vWvNFfQKE
 mAuLGClViVx3ezkCH2bAPFPpExBrWV7de5KdCc81dXr17q9KXsRe7wRzFDnbhXxEPik3
 Wjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793020747; x=1793625547;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gZK50kW+1k0n3ZkLVndgpShafn9w3GK9GElRYKJKRSw=;
 b=jCbdxDrQy1DzgRY1xljJ+RJWTFCiq58QKXpMotZD+cCu97iszLqvdyVePazV9G6Mlx
 s1zXt7hHbpxA0VQPN+mH6bDcKgGFFRM+fKWgTyn+ccz8gFbnioBvBUi+09bts9EWjvte
 SgaNrf5H/4qXjczSJbbzJh46g29NLKx3EFpGf+cMTZ1Bfl0yZLTuUCt+NZh6PSR9/x6E
 V8qPpC+2HY5VNgYj7FckPGFxdHF7YRhLPfaq0UG/MzvsTiTJAGpxRHDC/ukzerPjDGyu
 EfJt8TnNhSjsljL+1yn/6HkufPlwvcgLg3A9zoJqzsK3e54cCwi0IQLkm9BUa+J0P0z+
 LRog==
X-Gm-Message-State: AFq9FYL3nSAFbqYpuk47QTwrqx7JnoLIj46MH3BDPB3of3EaoxA7+1Ti
 CAmmvcUG1rpMKfDluim6lzR+aywTIqVFkKNYdcRAJSegFZDbLI3wJyxfwQxgoq6B
X-Gm-Gg: AYBFou3NnVSn4NOZ/oobnBjQn8LyqBsAD/4pCwBjTL82QIBmgN09QMf3UFUN80Z/I+I
 C756iw01yHEfBqCUQNX2BnTGt52cINvwCdvNyDfnAToHXNK6s7CD933upiG6NDSyO5IqEFWcoHF
 DWIW7kVGLoB+XJovPgbA5jFzBCj6WCdNNpeOhXJQYP1KRhh38ArdwbFGkvHmZjgg0gbZGg4U6hB
 xZWcyfvKPJi4dHvAtkx8FwbFmxpJgCZTiclqZy3o2fyCOK+IQ/thLMRgIQYF81Es/3qiduH6Wkz
 VdLd6gs4taEKmw5TJZyh3OGlgOVAmfX3Nx1xsE+HU4DEKN61dpMrOhQdLSfzuS8K/V4Yjzax3iu
 AZcNhve8G6I0+NxdYiADijYeKg/KQV+Sjpdp25Bln9aqir3mYGQM+PDGUtes80iG58TDhb0CBzG
 MM44C4IkramQJA9NWI7zB22VA+Q24wMZLqQnmtTjrxAq/ze8XESBC3Gnj02tLI8e/dUfUDWi3AE
 k6tRqaeGsPd7zNPzoMNiCzow2+TDJxy6MEaDL8W3rD0XLdigKM2uXDBAA==
X-Received: by 2002:a05:600c:4e87:b0:4a1:f99e:f22d with SMTP id
 5b1f17b1804b1-4a35acafe0dmr127779465e9.6.1793020746937; 
 Mon, 26 Oct 2026 06:19:06 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a029332sm172430295e9.4.2026.10.26.06.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 06:19:06 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 2/6] efi_loader: capsule: check the capsule header size
Date: Mon, 26 Oct 2026 13:19:05 +0000
Message-ID: <77e1e646-f867-44fe-a8f7-00e2f840d91a@gmail.com>
In-Reply-To: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
References: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

On the capsule on disk path, efi_capsule_update_firmware() is called
without the header checks of efi_update_capsule(). It only checks
header_size against the size of the FMP capsule header, so a
header_size smaller than struct efi_capsule_header is accepted, and the
empty capsules of the FWU multi bank update are handled before any
check at all: fwu_empty_capsule_process() reads the image GUID of an
accept capsule at header_size, which may lie anywhere after the
capsule.

Check that header_size covers the capsule header and lies within the
capsule before handling any capsule, and that an accept capsule holds
the image GUID.

Fixes: 8d99026f0697 ("efi_loader: capsule: support firmware update")
Fixes: 86794052418b ("FWU: Add support for the FWU Multi Bank Update feature")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_capsule.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 54c118736cf..e8835315e86 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -445,7 +445,14 @@ static __maybe_unused efi_status_t fwu_empty_capsule_process(
 		/*
 		 * Image accepted by the OS. Set the acceptance
 		 * status for the image.
+		 *
+		 * The caller has checked that header_size does not exceed
+		 * capsule_image_size.
 		 */
+		if (capsule->capsule_image_size - capsule->header_size <
+		    sizeof(*image_guid))
+			return EFI_INVALID_PARAMETER;
+
 		image_guid = (void *)(char *)capsule +
 			capsule->header_size;
 
@@ -544,6 +551,11 @@ static efi_status_t efi_capsule_update_firmware(
 	uint update_index;
 	bool fw_accept_os;
 
+	/* sanity check */
+	if (capsule_data->header_size < sizeof(*capsule_data) ||
+	    capsule_data->header_size > capsule_data->capsule_image_size)
+		return EFI_INVALID_PARAMETER;
+
 	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
 		if (fwu_empty_capsule(capsule_data)) {
 			if (fwu_empty_capsule_checks_pass()) {
