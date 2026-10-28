Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297AC606A337
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gZ6TUb1T;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYbQ28Ed
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 050D180FC1;
	Wed, 28 Oct 2026 05:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQLXU5uNvPIY; Wed, 28 Oct 2026 05:52:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0319480F55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166736;
	b=ok7ebIMpQ+813fG1nYPreq6LDl2mVzTDZGRxznHxSFOkQzUsywvyrAgmI+Dbmr6JR+p9
	 FkaXgZJQimP+yOFqsqJLFMvFx6BPn9iq7uRMZj6FhuuUkM1IHMuCy+GxPIfiaOd3/UiNf
	 VmH8bqjM1GUEQFaJCRn5bp4KaWLoCiqV27LsPoQ/HzX6pu4ew9cjddblMtpIn90mRpG/k
	 pklfM1nsP2oXd9NzfRq9naDnc1HGShE+pZxNMRmE7ZqoGjlUQxkGGSrno0zts1ZSNH0y4
	 b6jKRHjKVrvPRSOmYMP5mFryGRBfT81STbDzm2BqG58AyQM0ZgStstJSc6ntOH6R89Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rQpxryHMWw6EMH1KjdH+24gjI2ilAWt+anVsWYr4iew=;
	b=Yi+K2IERP2pRFfbqz4sSzTZQFdAaKkbSOFLJmAlJlFuxfLOVS6fuU+vg9BhvERdkB3y9
	 Ok8Q0U8+a2SxsYH7PRA95IsrZRvyTOi3HvWZEkGN3aXiE/XychpPj38LmPD75euAOJ8rE
	 +XwpkILW9uDHQz8bEkWKoIrfs17Gi34a5VtcpBsyQOlg3bCqWoudt39kV6qtCx+44AHAn
	 bVX2q6gGRezcfuSdDHqYB6AsCicPeguo+oSOSvD4wEpq2PLsnc89HgxIOtw2kMlYahU2P
	 gDs1VcUKIuNTjTvK5OFX7Lp5rSe7k5b47gn4InKXnPbZT1xCrdlpNZ7F8GM24tOnczw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166736;
	bh=rQpxryHMWw6EMH1KjdH+24gjI2ilAWt+anVsWYr4iew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gZ6TUb1TK2ieMAG+MsvEdgtciCpS1BeyZQx/WmhZzpNAjWdeUUhpRrFpUFkWrzFRG
	 5wfaDaacqz275H0MBTLtczTfWMB/fCJjAGTDvCCjht3U8dsGriKskctDr3/pD+Hq9l
	 8cTY1BDQphbzn4HhDHDUNwQDz+154TinDn0R2/ICLdnT6pWPftuH1A726Vz1GDGTBU
	 ng3y7oMkzr04FpNuivbwpp1/nC/ySQW9cGdVU1bqcHn9JVjzDZ95KVRQNM8DGF3agV
	 qCSe8GccShOhcw52izCowp2Mkhhy2ZMo233SNtA2s3U1HvV0KmfwwuyCS57J+wiTee
	 mZkp1hPlLkARw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0319480F55;
	Wed, 28 Oct 2026 05:52:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 335134D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1998560791
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f5JDuTAYGmlF for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:52:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4F35960755
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166733;
 b=XgK4i39JwW20DyVLhxTvDIArr/AICDX7apyEgtF2xsiaGkEJYQMMl+RNO5ZpVqOZDoH9
 6V60eaoS7sT88G4ZBs++DToCwTFA1pocadvrMEQEraRocjYFGJiaJ5/09yK6JR5xUzuC7
 T/5XN6XmJeTTJNAXkY568vwf2ez6Fed4NQRfO/0KWmIEVSHUDAkT5RyuuZ5XPxw2COQSc
 i4ystTvTr2QxvoWmBPPQtuj526Dj8oT/Rl8NtLLyiu7KKKBs1WUIn8b8RrodJL/zNcVVx
 MHs4gm3c2NbldkBGO36+qYMSd70+f0jAalVCWs6r2ofXNRKephMozyxKyKL8KE6g9Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166733;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=rQpxryHMWw6EMH1KjdH+24gjI2ilAWt+anVsWYr4iew=;
 b=GoRi4EWthf0D4RX9VO/smMBXC75jguOoogMG4Um2KB1FKcX9eYHkJ6J1Lgm59htU5Vv+
 2Z6B0SiB257U1WJ48nPlvoj61GUg9mD5W5X5KEqHlkIfpgnsmSYKriT4bolM7S4uIb+QW
 ySaOI9rQPTYO+iLm3wBaJtAEe4q8UoOYgmVhw3EhQ97OKAS++V3G6OshufbOm3buz5/HD
 1TkZqngJHln4B65Ii8Mc+hsfToMmVNPkkElEaijR1bonfHCObURzfc66DULuRdNRieCmZ
 wUT78N6Ru7Evz3QSCxx9ZVV/DvL36OViKVIWk6NiNEmyRt3f5PATnAZMlSJfEmrIA/w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PYbQ28Ed; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=PYbQ28Ed
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F35960755
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:52:12 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so4984155e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166731; x=1793771531;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rQpxryHMWw6EMH1KjdH+24gjI2ilAWt+anVsWYr4iew=;
 b=PYbQ28EdR3jXojzGzCUCxFDAj3PTRpqdsC+5yeo1KMfj0EfllsoSFclXNEc3f+wp64
 HAWGXWvoe9z5C0lbUTzbTpZgyXoqmsALHtTU+mR8UFdMRjG96PQiNRfC7Y6s5RWGbm1E
 jxgzDhZd3KsA8ExTopYBHONDAujDYGkcUayi+kV0IzrcFSXkF4ZKiJOe/RQBq1Ct7896
 u+XX4TbiouzEF4Ewk0VL6WT8NEHEwpCwFxDF+ShU8fKbZkDjerQ51/Q3K/8lHt//+Ne6
 hkR2eQsnl61N2Bxl48/OfHfpG4t03ijO1VE4E7p2gTvLcwnRa2hBWEmkImPwF5r2Q/bA
 rR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166731; x=1793771531;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rQpxryHMWw6EMH1KjdH+24gjI2ilAWt+anVsWYr4iew=;
 b=dV47Z453sUH6LV0xWlcaFxDElZISs3dfPV5QJdxY43ewZ9N7SCeXkxGN50Sxi9wxM2
 8UuqEbIQWB77pMb1dWixdqoLQAYRJ7zp2jqrjyJsF7+/bPhWy4kYBf70XJ1yw/9Od45L
 F9+9Bv6JlPZX9MyK3CHkEwE7AT+aWaavGIwb/Sgzmpibaq9f9BNHxheEa5oTAKsXTLT+
 rTSsP2sf+B4e2uuaIFTh/s/85Qs2++VY2OgB15y1r1+vLaQslonbT2GdyFGv3Ax8Fqox
 hQXZT/1n6cSPWGqL0Wkr8ahzeFEGtb/DKjNom+JNmIAjlIolPx1fDvBC2kmtmxUuJXjJ
 8Hqw==
X-Gm-Message-State: AFq9FYIqAPX5Yq8JV7ff9hk46xkgy/ZJvVMNKAEFOlVqN87WWhp6zNv0
 uWly77Tg0R9EXRyBrHVuKPGJsqHddlaYc4MBk1rmtPLBJfUmOY1iKe73
X-Gm-Gg: AYBFou1bXdRUoxLFOqQt2h01g7IfHQtumSZ/bbUh/q/mQ7Q3wROyOwri6ZN3m3YwfrI
 B/nUGlvLEZIvIZP8h7ka95jKGtjjWzyPi44JFZOpZtjLuGwWnHJKlcmiCDedd6xtxo0tFGjoHhr
 6nlseCKsp517DCCAvnbdEG9TTZBgGM27y33XWmDn1uO2mGNtYw5VAgzY2j7zj/IKS3Fj8ryBENC
 tI7qKif6VNiZU5Fp9aNAZr4gU9nioX2QwtyqkdIdUp3F9vrmbRQpCsEp7VswDkfxZGTpDYcxlAk
 pHCMB5uzpq9KGK2id8pTyV32ezkrgsgQKdU5vjv1LTpWQnygv17XIDSr29V7F7L6wwFstTqreWZ
 SyeVc9C5FPv0Czm8wv8wy3fZrndIEJA2p4ZjraA+TXGSk2BfmdXz2qJFzN6IeSyE0HjwK1K6KTi
 lJ4CQME/jvhhsQPScU3BNJcFDVSBYawT0eZnv8V1kdEAh6pNmN3qGaaq8PisCk29pW7MSvS5ubs
 fNAxhKAEqPDaINQjOq5XjCAbHts+71vAInUTuM++/kYzrT3kz490hdBKO+1Wfx70PgK1QeKzMg/
 Kf3P1XmQ47ejuUM56uQUNunh5N8HyuDXh+JxDWiW2Iskv7Q9L6EQ
X-Received: by 2002:a05:600c:8b28:b0:4a1:ac66:6ac6 with SMTP id
 5b1f17b1804b1-4a9677caa3cmr21817765e9.26.1793166730884; 
 Tue, 27 Oct 2026 22:52:10 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a9792269a7sm18945305e9.12.2026.10.27.22.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:52:10 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 12/12] efi_loader: Measure the GPT the partition driver uses
Date: Wed, 28 Oct 2026 05:52:09 +0000
Message-ID: <8dcede4f-fba2-4635-b8e6-93fb35ae07ce@gmail.com>
In-Reply-To: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

tcg2_measure_gpt_data() measures the GPT of the disk an EFI application
is started from into PCR 5, so that a remote verifier, or a key sealed
to PCR 5, can tell whether the partition table is the expected one. It
reads the primary GPT itself and measures it without any check, while
the partition driver checks the primary header and entries and, if
either is not valid, finds the partitions in the backup GPT. PCR 5 then
holds a GPT the partitions were not found in. Unused entries are not
measured but are covered by the CRC of the entry array, so a change to
one of them leaves PCR 5 as it was while the partitions come from the
backup GPT, whatever that holds: a disk whose partitions were changed
that way still attests, and unseals, as the original one.

The sizes in the header are not checked either. The entries are read
into a buffer whose size is num_partition_entries *
sizeof_partition_entry, worked out in 32 bits, and walked
num_partition_entries times with sizeof_partition_entry as the stride,
so a product that wraps, or an entry size smaller than the GUID read
from each entry, makes the walks read past the end of the buffer.

Measure the GPT the partitions are found in instead, read by the
partition driver's own code, which checks the sizes too since "disk:
part_efi: Check the header and entry sizes of a GPT". Add
part_get_gpt_primary(), which finds the GPT as find_valid_gpt() does,
and gives a backup header as the primary header that
gpt_repair_headers() makes from it. EDK2 also measures the GPT its
partition driver uses, since 7c12d4359abd
("SecurityPkg/DxeTpm2MeasureBootLib: Use GptLib parser"), and that
driver restores a primary GPT that is not valid from the backup on the
disk before it is measured. Here the disk is not written: the primary
header is only rebuilt in memory, so a disk whose primary GPT was lost
gives the PCR 5 it has once repaired with gpt repair. A disk that is
not a U-Boot block device has no partitions found by that driver, and
gets no GPT event.

If no valid GPT can be read from the disk when the application is
started, measure no GPT event but return success, as an error would
make efi_tcg2_measure_efi_app_invocation() skip the separators.

Add a test that starts an EFI application from a GPT disk on sandbox
and checks PCR 5: it holds the GPT, the same GPT when the primary header
gives an entry array that comes to one block in 32 bits, and the backup
GPT when that differs from a primary GPT with a changed unused entry.
Without this change sandbox crashes in the second case, and PCR 5 holds
the primary GPT in the third. Check part_get_gpt_primary() in
lib_test_gpt_sizes too.

Fixes: ce3dbc5d080d ("efi_loader: add UEFI GPT measurement")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- New subject: measure the GPT the partition driver uses, read with its
  own code through a new part_get_gpt_primary(), so that the CRC of the
  entries is checked too, as EDK2 does (Simon)
- When the partitions come from the backup GPT, measure that, with the
  primary header gpt repair makes from it, rather than no GPT, as EDK2
  measures the GPT its partition driver restores (Ilias)
- Say in the commit message what the bug does to PCR 5 (Ilias)
- Keep validate_gpt_header() static, as efi_tcg2 no longer reads the GPT
  itself
- Test a backup GPT that differs from the primary one, and rename the
  test to test_efi_tcg2_gpt

 disk/part_efi.c                |  21 ++++
 include/part.h                 |  26 ++++
 lib/efi_loader/efi_tcg2.c      |  51 ++++----
 test/lib/part_efi.c            |  42 ++++++-
 test/py/tests/test_efi_tcg2.py | 222 +++++++++++++++++++++++++++++++++
 5 files changed, 334 insertions(+), 28 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 85945634915..3030482d168 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -875,6 +875,27 @@ int gpt_repair_headers(struct blk_desc *desc)
 	return ret;
 }
 
+int part_get_gpt_primary(struct blk_desc *desc, gpt_header *gpt_h,
+			 gpt_entry **gpt_pte)
+{
+	/* This function validates AND fills in the GPT header and PTE */
+	if (find_valid_gpt(desc, gpt_h, gpt_pte) != 1) {
+		/* is_gpt_valid() may leave a freed array here */
+		*gpt_pte = NULL;
+		return -EINVAL;
+	}
+
+	/*
+	 * The partitions come from the backup GPT, as the primary one is not
+	 * valid, or is marked to be ignored: give its header as the primary
+	 * header that gpt_repair_headers() makes from a backup one
+	 */
+	if (le64_to_cpu(gpt_h->my_lba) != GPT_PRIMARY_PARTITION_TABLE_LBA)
+		restore_primary_gpt_header(gpt_h, desc);
+
+	return 0;
+}
+
 int gpt_verify_partitions(struct blk_desc *desc,
 			  struct disk_partition *partitions, int parts,
 			  gpt_header *gpt_head, gpt_entry **gpt_pte)
diff --git a/include/part.h b/include/part.h
index 1dc510cb6b1..43c82919967 100644
--- a/include/part.h
+++ b/include/part.h
@@ -680,6 +680,32 @@ int get_disk_guid(struct blk_desc *desc, char *guid);
  */
 int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e);
 
+/**
+ * part_get_gpt_primary() - Get the GPT the partitions of a disk are found in
+ *
+ * Read the GPT as the partition driver does: the primary one if it is valid,
+ * else the backup one. A backup header is given as the primary header that
+ * gpt_repair_headers() makes from it. Nothing is written to the disk.
+ *
+ * @desc:	block device descriptor
+ * @gpt_h:	buffer of @desc->blksz bytes, filled with the header
+ * @gpt_pte:	set to the partition entries, which the caller frees, or to
+ *		NULL on error
+ *
+ * Return:	0 on success, -EINVAL if no valid GPT was read from the disk,
+ *		-ENOSYS if GPT support is not built in
+ */
+int part_get_gpt_primary(struct blk_desc *desc, gpt_header *gpt_h,
+			 gpt_entry **gpt_pte);
+
+#else
+static inline int part_get_gpt_primary(struct blk_desc *desc,
+				       gpt_header *gpt_h, gpt_entry **gpt_pte)
+{
+	*gpt_pte = NULL;
+
+	return -ENOSYS;
+}
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 5f9bbe97455..65c2833074a 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -16,6 +16,8 @@
 #include <efi_tcg2.h>
 #include <log.h>
 #include <malloc.h>
+#include <memalign.h>
+#include <part.h>
 #include <smbios.h>
 #include <version_string.h>
 #include <tpm_api.h>
@@ -1157,11 +1159,11 @@ tcg2_measure_gpt_data(struct udevice *dev,
 {
 	efi_status_t ret;
 	efi_handle_t handle;
-	struct efi_handler *dp_handler, *io_handler;
+	struct efi_handler *dp_handler;
 	struct efi_device_path *orig_device_path;
 	struct efi_device_path *device_path;
 	struct efi_device_path *dp;
-	struct efi_block_io *block_io;
+	struct blk_desc *desc;
 	struct efi_gpt_data *event = NULL;
 	efi_guid_t null_guid = NULL_GUID;
 	gpt_header *gpt_h;
@@ -1170,7 +1172,6 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	u32 num_of_valid_entry = 0;
 	u32 event_size;
 	u32 i;
-	u32 total_gpt_entry_size;
 
 	ret = efi_search_protocol(&loaded_image->header,
 				  &efi_guid_loaded_image_device_path,
@@ -1202,40 +1203,36 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	if (ret != EFI_SUCCESS)
 		goto out1;
 
-	ret = efi_search_protocol(handle, &efi_block_io_guid, &io_handler);
-	if (ret != EFI_SUCCESS)
+	/*
+	 * Measure the GPT the partitions were found in: read it with the
+	 * partition driver's own code, which checks it and uses the backup GPT
+	 * if the primary one is not valid. Only a block device of U-Boot's has
+	 * partitions found by it.
+	 */
+	if (!handle->dev || device_get_uclass_id(handle->dev) != UCLASS_BLK) {
+		log_debug("Not a U-Boot block device, GPT not measured\n");
+		ret = EFI_SUCCESS;
 		goto out1;
-	block_io = io_handler->protocol_interface;
+	}
+	desc = dev_get_uclass_plat(handle->dev);
 
-	gpt_h = memalign(block_io->media->io_align, block_io->media->block_size);
+	gpt_h = malloc_cache_aligned(desc->blksz);
 	if (!gpt_h) {
 		ret = EFI_OUT_OF_RESOURCES;
 		goto out2;
 	}
 
-	ret = EFI_CALL(block_io->read_blocks(block_io,
-					     block_io->media->media_id, 1,
-					     block_io->media->block_size,
-					     gpt_h));
-	if (ret != EFI_SUCCESS)
-		goto out2;
-
-	/* read GPT entry */
-	total_gpt_entry_size = gpt_h->num_partition_entries *
-			       gpt_h->sizeof_partition_entry;
-	entry = memalign(block_io->media->io_align, total_gpt_entry_size);
-	if (!entry) {
-		ret = EFI_OUT_OF_RESOURCES;
+	/*
+	 * The disk may have changed since its partitions were found, or not
+	 * read. Measure no GPT then, but return success, as an error would
+	 * skip the separators.
+	 */
+	if (part_get_gpt_primary(desc, gpt_h, &entry)) {
+		log_warning("No valid GPT read, not measured\n");
+		ret = EFI_SUCCESS;
 		goto out2;
 	}
 
-	ret = EFI_CALL(block_io->read_blocks(block_io,
-					     block_io->media->media_id,
-					     gpt_h->partition_entry_lba,
-					     total_gpt_entry_size, entry));
-	if (ret != EFI_SUCCESS)
-		goto out2;
-
 	/* count valid GPT entry */
 	gpt_e = entry;
 	for (i = 0; i < gpt_h->num_partition_entries; i++) {
diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
index 42de9109360..8fcd4148b13 100644
--- a/test/lib/part_efi.c
+++ b/test/lib/part_efi.c
@@ -328,6 +328,7 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 	struct blk_desc *desc;
 	struct udevice *blk;
 	gpt_entry *gpt_pte;
+	gpt_header orig, written;
 	void *entries;
 	int i, ret;
 
@@ -341,6 +342,8 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 	disk_partition_set_uuid(&parts[0],
 				"a2a0d0eb-e5b9-3344-87c0-68b6b72699c7");
 	ut_assertok(gpt_restore(desc, str_disk_guid, parts, 1));
+	ut_asserteq(1, blk_dread(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, 1, hdr));
+	memcpy(&orig, hdr, sizeof(orig));
 
 	for (i = 0; i < ARRAY_SIZE(cases); i++) {
 		u32 header_size = cases[i].header_size;
@@ -365,6 +368,22 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 						      header_size));
 		ut_asserteq(1, blk_dwrite(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
 					  1, hdr));
+		memcpy(&written, hdr, sizeof(written));
+
+		/*
+		 * efi_tcg2 measures the GPT this gives: the header just
+		 * written if it is valid, else the backup header turned into
+		 * the primary one, which is then the header gpt_restore() wrote
+		 */
+		memset(hdr, '\0', 2 * blksz);
+		gpt_pte = NULL;
+		ret = part_get_gpt_primary(desc, hdr, &gpt_pte);
+		free(gpt_pte);
+		ut_assertf(!ret, "case %d: GPT not found: %d\n", i, ret);
+		if (cases[i].ret)
+			ut_asserteq_mem(&orig, hdr, sizeof(gpt_header));
+		else
+			ut_asserteq_mem(&written, hdr, sizeof(gpt_header));
 
 		/*
 		 * Read it back into a buffer as large as the one above, so
@@ -396,6 +415,26 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 		ut_asserteq_64(parts[0].size, info.size);
 	}
 
+	/*
+	 * With the primary header valid again but not its entries, and the
+	 * backup header broken, there is no GPT left, and no entries either
+	 */
+	memset(hdr, '\0', 2 * blksz);
+	memcpy(hdr, &orig, sizeof(orig));
+	ut_asserteq(1, blk_dwrite(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, 1,
+				  hdr));
+	ut_asserteq(1, blk_dread(desc, le64_to_cpu(orig.partition_entry_lba),
+				 1, hdr));
+	((gpt_entry *)hdr)->partition_name[0] ^= 1;
+	ut_asserteq(1, blk_dwrite(desc, le64_to_cpu(orig.partition_entry_lba),
+				  1, hdr));
+	ut_asserteq(1, blk_dread(desc, lba - 1, 1, hdr));
+	hdr->signature = 0;
+	ut_asserteq(1, blk_dwrite(desc, lba - 1, 1, hdr));
+	gpt_pte = (gpt_entry *)hdr;
+	ut_asserteq(-EINVAL, part_get_gpt_primary(desc, hdr, &gpt_pte));
+	ut_assertnull(gpt_pte);
+
 	return 0;
 }
 
@@ -403,7 +442,8 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
  * A GPT header gives its own size and the size of its partition entries, and
  * its CRCs cover only what those say, so a CRC does not show that either size
  * is one the parser can use. Check that a primary header with a size the
- * parser cannot use is refused, CRCs or not, and that the backup is used.
+ * parser cannot use is refused, CRCs or not, and that the backup is used, for
+ * the GPT efi_tcg2 measures too.
  */
 static int lib_test_gpt_sizes(struct unit_test_state *uts)
 {
diff --git a/test/py/tests/test_efi_tcg2.py b/test/py/tests/test_efi_tcg2.py
new file mode 100644
index 00000000000..02e1e9e1535
--- /dev/null
+++ b/test/py/tests/test_efi_tcg2.py
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+"""Test the measurements made by the EFI_TCG2_PROTOCOL on sandbox
+
+The sandbox TPM starts with every PCR clear, and the events measured when an
+EFI application is started (boot variables, GPT, separators) are only measured
+the first time one is. So each case restarts U-Boot, starts one application
+and checks PCR 5 against the events it should then hold.
+"""
+
+import hashlib
+import os
+import re
+import shutil
+import struct
+import zlib
+
+import pytest
+
+import utils
+from tests.fs_helper import FsHelper
+
+# EFI System Partition
+ESP_TYPE = 'C12A7328-F81F-11D2-BA4B-00A0C93EC93B'
+SECTOR = 512
+
+# Fields of the GPT header, by offset
+GPT_HEADER_SIZE = 92
+GPT_HDR_SIZE_OFF = 12
+GPT_HDR_CRC_OFF = 16
+GPT_ALTERNATE_OFF = 32
+GPT_ENTRIES_OFF = 72    # partition_entry_lba, num_partition_entries, ...
+GPT_NUM_ENTRIES_OFF = 80
+GPT_ENTRY_SIZE = 128
+
+
+def extend(pcr, data):
+    """Extend a SHA256 PCR value with the digest of some data
+
+    Args:
+        pcr (bytes): PCR value before
+        data (bytes): Event data
+
+    Returns:
+        bytes: PCR value after
+    """
+    return hashlib.sha256(pcr + hashlib.sha256(data).digest()).digest()
+
+
+def make_gpt_disk(ubman, fname):
+    """Write a GPT disk image with helloworld.efi on its only partition
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        fname (str): Filename of the disk image
+    """
+    with FsHelper(ubman.config, 'vfat', 1, 'tcg2') as fsh:
+        shutil.copy(os.path.join(ubman.config.build_dir,
+                                 'lib/efi_loader/helloworld.efi'),
+                    fsh.srcdir)
+        fsh.mk_fs()
+        with open(fsh.fs_img, 'rb') as inf:
+            fs_data = inf.read()
+
+    # 1MiB for the primary GPT, the partition, 1MiB for the backup GPT
+    with open(fname, 'wb') as outf:
+        outf.truncate((2 << 20) + len(fs_data))
+    utils.run_and_log(ubman, f'sfdisk {fname}',
+                      stdin=(f'label: gpt\nstart=2048, '
+                             f'size={len(fs_data) // SECTOR}, '
+                             f'type={ESP_TYPE}\n').encode())
+    with open(fname, 'r+b') as outf:
+        outf.seek(1 << 20)
+        outf.write(fs_data)
+
+
+def gpt_event(fname):
+    """Get the EV_EFI_GPT_EVENT data for the primary GPT of a disk image
+
+    Args:
+        fname (str): Filename of the disk image
+
+    Returns:
+        bytes: The header, the number of partitions, then their entries
+    """
+    with open(fname, 'rb') as inf:
+        disk = inf.read()
+    hdr = disk[SECTOR:SECTOR + GPT_HEADER_SIZE]
+    entry_lba, num, size = struct.unpack_from('<QII', hdr, GPT_ENTRIES_OFF)
+    entries = []
+    for i in range(num):
+        start = entry_lba * SECTOR + i * size
+        entry = disk[start:start + size]
+        if any(entry[:16]):
+            entries.append(entry)
+    return hdr + struct.pack('<Q', len(entries)) + b''.join(entries)
+
+
+def set_num_entries(fname, num):
+    """Set num_partition_entries in the primary GPT header and fix its CRC
+
+    Args:
+        fname (str): Filename of the disk image
+        num (int): Number of partition entries
+    """
+    with open(fname, 'r+b') as outf:
+        outf.seek(SECTOR)
+        hdr = bytearray(outf.read(SECTOR))
+        struct.pack_into('<I', hdr, GPT_NUM_ENTRIES_OFF, num)
+        struct.pack_into('<I', hdr, GPT_HDR_CRC_OFF, 0)
+        hdr_size = struct.unpack_from('<I', hdr, GPT_HDR_SIZE_OFF)[0]
+        struct.pack_into('<I', hdr, GPT_HDR_CRC_OFF,
+                         zlib.crc32(hdr[:hdr_size]))
+        outf.seek(SECTOR)
+        outf.write(hdr)
+
+
+def corrupt_entries(fname):
+    """Change an unused entry of the primary GPT, leaving the header as it is
+
+    The CRC of the entries in the header no longer matches them.
+
+    Args:
+        fname (str): Filename of the disk image
+    """
+    with open(fname, 'r+b') as outf:
+        outf.seek(SECTOR)
+        hdr = outf.read(GPT_HEADER_SIZE)
+        entry_lba = struct.unpack_from('<Q', hdr, GPT_ENTRIES_OFF)[0]
+        # the name of the second entry, whose type GUID stays zero
+        outf.seek(entry_lba * SECTOR + GPT_ENTRY_SIZE + 56)
+        outf.write(b'x')
+
+
+def copy_backup_gpt(src, dst):
+    """Copy the backup GPT of a disk image to another of the same size
+
+    Args:
+        src (str): Filename of the disk image to copy it from
+        dst (str): Filename of the disk image to copy it to
+    """
+    with open(src, 'rb') as inf:
+        inf.seek(SECTOR)
+        hdr = inf.read(GPT_HEADER_SIZE)
+        backup_lba = struct.unpack_from('<Q', hdr, GPT_ALTERNATE_OFF)[0]
+        inf.seek(backup_lba * SECTOR)
+        hdr = inf.read(GPT_HEADER_SIZE)
+        entry_lba = struct.unpack_from('<Q', hdr, GPT_ENTRIES_OFF)[0]
+        inf.seek(entry_lba * SECTOR)
+        data = inf.read()
+    with open(dst, 'r+b') as outf:
+        outf.seek(entry_lba * SECTOR)
+        outf.write(data)
+
+
+def boot_and_read_pcr5(ubman, fname):
+    """Start helloworld.efi from a disk image on a fresh U-Boot
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        fname (str): Filename of the disk image
+
+    Returns:
+        bytes: PCR 5 after the application has run
+    """
+    addr = utils.find_ram_base(ubman) + (4 << 20)
+    ubman.restart_uboot()
+    ubman.run_command(f'host bind 0 {fname}')
+    output = ubman.run_command(f'load host 0:1 {addr:x} helloworld.efi')
+    assert 'bytes read' in output
+    output = ubman.run_command(f'bootefi {addr:x}')
+    assert 'Hello, world!' in output
+    output = ubman.run_command(f'tpm2 pcr_read 5 {addr:x}')
+    assert 'PCR #5 sha256 32 byte content' in output
+    digest = output.split('content', 1)[1].split('\n', 1)[1]
+    return bytes.fromhex(''.join(re.findall(r'\b[0-9a-f]{2}\b', digest)))
+
+
+@pytest.mark.boardspec('sandbox')
+# EFI applications are built with the sanitizer but cannot run with it
+@pytest.mark.notbuildconfigspec('asan')
+@pytest.mark.buildconfigspec('efi_tcg2_protocol')
+@pytest.mark.buildconfigspec('efi_partition')
+@pytest.mark.buildconfigspec('cmd_tpm_v2')
+@pytest.mark.buildconfigspec('bootefi_hello_compile')
+def test_efi_tcg2_gpt(ubman):
+    """Check that PCR 5 holds the GPT the partitions are found in
+
+    PCR 5 holds the GPT event and then the separator. When the partition
+    driver refuses the primary GPT, it finds the partitions in the backup
+    one, and the GPT event holds that, with the primary header it restores.
+    """
+    fname = os.path.join(ubman.config.persistent_data_dir, 'tcg2_gpt.img')
+    other = os.path.join(ubman.config.persistent_data_dir, 'tcg2_other.img')
+    separator = struct.pack('<I', 0)
+    try:
+        make_gpt_disk(ubman, fname)
+        expect = extend(extend(bytes(32), gpt_event(fname)), separator)
+        assert boot_and_read_pcr5(ubman, fname) == expect
+
+        # an entry array whose size comes to one block in 32 bits: the
+        # backup GPT is the same GPT, so PCR 5 is too
+        set_num_entries(fname, (1 << 32) // GPT_ENTRY_SIZE +
+                        SECTOR // GPT_ENTRY_SIZE)
+        assert boot_and_read_pcr5(ubman, fname) == expect
+
+        # a backup GPT whose partition has another GUID, and primary entries
+        # that do not match their CRC, though the change is in an unused
+        # entry, which is not measured
+        make_gpt_disk(ubman, fname)
+        shutil.copy(fname, other)
+        utils.run_and_log(ubman, f'sfdisk --part-uuid {other} 1 '
+                          '0a6a1f54-1b55-4d0c-9a52-6d1e5e0e5d01')
+        expect = extend(extend(bytes(32), gpt_event(other)), separator)
+        copy_backup_gpt(other, fname)
+        corrupt_entries(fname)
+        assert boot_and_read_pcr5(ubman, fname) == expect
+    finally:
+        for path in (fname, other):
+            if os.path.exists(path):
+                os.remove(path)
+        ubman.restart_uboot()
