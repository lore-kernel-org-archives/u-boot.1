Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE3606A326
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KLi04/pZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zH9FEpkU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D48D980EBA;
	Sun,  1 Nov 2026 07:03:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uUF2DRX4HTat; Sun,  1 Nov 2026 07:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4FED58110C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793516585;
	b=qXCaRlJ12Q01XY0lgcL95wYAFkMGc/t3GMuGZXGDRwJ1H1LenwM5cwgdI9ONOJS+J0gm
	 t4wiq1fCE8pzw5+W08NL0+GkGkCZFXmGf4J01gl3ub/gnJpvRyPK72nr3xczwkwB6e8Jo
	 fDwp3RnZ2Ib5NWCvklTs+eVpkDoJvHev0+1j9k0PySvqK/gTZLB4Vx1RiabWeKBHMiS7v
	 MP793eqjC33e4FuUTCs3Mmyjgd1Q2YpAqPf39oOL6DK8dSMynoff9cfcoPuhFdObwkV+i
	 RrnjS9izDHvrqjPJ6Xlwty3GNmX7bv3jsigwWC5iHaKPJWOeUydAe2Q4Mf4vpPAMNNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793516585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0ptGTyALQHVsxt61Q3at4LUoCwQqERUfFFsfmP6Loro=;
	b=POgY3XAiH5oBnOTetG7pl2KJM7u8JK3NzaZESIFgj1vLVSNdmkTqlrtsjfAE+hHmUrf1
	 tuH3x0yzTzJOuBTbpc/cUqz7Gj6SZsK5Xms3Jxw2gHd3npU08RmXpFPvnt6TwvBraUup0
	 K72mFd80hUNa3MsB4ESZlOiEjwpmLywRfspk/Puel4VMIRCzNZAJ2caB5fFeheqOf450n
	 KShuHtH9pvmMChGsN3CmNfJrC/tK/VtkRGV17H5iAFIR71QHhnmy0K8DON41y0gj+F+RI
	 wq0pI2PIp2GCquo9WwAvZWOEC1pLTLW7HR2TflYreWdIpz2xQJO3s1FxHphgDvG/P4Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793516585;
	bh=0ptGTyALQHVsxt61Q3at4LUoCwQqERUfFFsfmP6Loro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KLi04/pZbysETMfafvVYZqLVE5I/IDIDpt/oGV87bat6qIP8v7U4iOGcAT3o6IYd8
	 EClyQuy6dXtw74Mg2+sRGyoZ0NW5uzQCE4QfgxtsAj5BcHf2FjdpQwTRfGfSAxix/t
	 xKCU/i8HwC6lIA5p9hiX7AkEeM3UKtmeY3Q49BZOTb8UbLO6HLQqq1osHlU6tR6wOZ
	 spLUK6+ozV4ZyKsaYD30hM6B7glR0Y+4ROoHCA9eNvuRi0D6PpAVj/MiqkXjaSNI7j
	 PcA2J2qvI2FNVcumo4JO0Reg3cDC2HBhqutq6DysgqsnoXzQWGwdOsAqhq9rPU1GH0
	 fVzu3glaXCwlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FED58110C;
	Sun,  1 Nov 2026 07:03:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 25519D3A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0ADCC400AF
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:03:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZO8EIU_qEboC for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 07:03:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 526CC4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793516582;
 b=BOulHqe/c+Fnvoa5lklTdSj0c/TaFoiZ4SPHPwwkP2HL1CB1poUc+GPJO/eWj19nzgX+
 ub47Z8l6XXktT0X8/5lsnoilZFo4tYzTE+yVWvUYst+sLP2Rhr3LXqA9U5Sbgm/cAeiR/
 mAmlKKCmB57/UZ6ySR/6OyNOQyYHnK9lQwpnbjybmLL9Ir36pkpKRsnsn3gwETeFU32d8
 tZzsa9BaU3BZt5YXMJ/unEBjn7UbnneUuCKOkcYLmT/ijhr+UYi6DOVFO2HvnFGU2Tyz8
 25ywCIAve+fnU308kjCKoqXIz+JW+ndimdbVLOw0rZsm1hJqytfFB5TX9hP7705oDpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793516582;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=0ptGTyALQHVsxt61Q3at4LUoCwQqERUfFFsfmP6Loro=;
 b=NwI0Cgs4liP+DS1PQPejHX9LhE4iPs4PbsoHaGJZ8eHyg3caIS4MOSmOcUOgVH91gxyU
 7/6UUQwcerBnRuGEKknNla32bSlLGhxCK5gS0Y7rAX3zI58C1fowW5gY6Nfr0yEa5z1sE
 Ddi6Q6ne52/+l6p3mKdX7DJpl0Ks2z/+F3hLI702N5QPu8WnmxULkXnZBC9gPoVwdrjoh
 zaZF9VgGzJW1EskAVhYXmpfnPKiRs1Rx0/xqwJ9w7HLwy2I4Vk+rlvzUfuVvgDO+dT9k9
 6F4NNeedElgChvEPwX2DBj2M1eOi1PVp/kvo/WfzA6KZuLdFRp5CzPuLPdqBXxOD1wA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=zH9FEpkU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=zH9FEpkU
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 526CC4004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 07:03:01 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so3042485e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793516580; x=1794121380;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0ptGTyALQHVsxt61Q3at4LUoCwQqERUfFFsfmP6Loro=;
 b=zH9FEpkUq2FsTcH1Kd08R7wKmfVy+p3Ds7+Ktyw1nUz9UmTItY6wcjohN0IM/ynBDW
 WmsM45srVjYRK6jLI1h2uo3Bg5IhRt0p4+96XWHL8SqvDrBbl3bxlWQ5k30f/mWopxsk
 P9vp0dEDIJqo9TKYI3h83Qc+ts48/txOYnGLKd8Ppw/Uk71lRS8rxIECOkRZBXLKtpli
 lBSlq5eFxxO8sOkj9Y4J1G48tkGBkR4O43zBMxab9VaB900w7weMektfMJbRCOSidEil
 DjdLtUpEIB9GC2QarQ2rcbXT+oD/hpnma8wL48+o3vGYSjA5rJUy36tAAW9lGDRrbBOF
 mLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793516580; x=1794121380;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0ptGTyALQHVsxt61Q3at4LUoCwQqERUfFFsfmP6Loro=;
 b=i7PmiZS33QzPU6LSjAqnhmMPpFwx1OzTJhqvshwbJkmQxcd3RQi0XiiU09EMnhT2br
 9saYHtFP8tcV/4tyzYGb2XeHToE7v3J86N/eFotxli/zdk/6SF5Dnf27Kq9GERoCFFAV
 C3eQ8dnRnfmkF7/CT03fWFGhG6yKs3Cj6WFWCgpVEQOd9KjIKg+ZTYucfgK+Prn4iZgT
 TS16za8lBOuggxI42FzFX3jEn7YR8/AdXkStBY1Jx3A4rr+dzVVmWG6/SVRAtjhNkpU8
 +IUBsmjCKmujDC1hGWNQS8Olguq0aWSWBTionGHV2WGmKrgR+5V9iPDlEyJkmqyFq1p7
 tc3A==
X-Gm-Message-State: AFq9FYI4+lr09R/c4U42R4kCw8QE9Er+553GZWEB5d6tp6zr3d+MzAtN
 ZRKMBgWxLn2f1dwInGVK6MlnWsPzvaH/LIXWBL6a0lJdfZpkqOKriM2e
X-Gm-Gg: AYBFou1sPyUUZA+qb7HMk+b2XXph5fhvLVs4N+uWNogBjq5RemRU3Rn3E64W859T/qJ
 0pyWaEB4UATSHaE5Ng8aKkpKIakncFpOV1vgSthtbq8lOvCij9PyNttUoNNX4D5Kjpr82Yu4rZZ
 IAbdEt2WWNkuAV7nwUHYVyhtYPVOtk1cFcQ+CEfBYwMNvZ47CyLyrrgEmbVWde1HjiN5p+eia2H
 zOpNc5Z52dqo/Ehy2TZdaSBBPDxafxqdcA5YzSeg8ALeY7dI5rX0IEV+ruEytOZKBZfQ+wLF8xJ
 jdpPC0OggfJnPgJZD3QGQ8AhxH+4Yh2E5XXpg6JaYawmbs/tqPp1h4d6x0tyEsDTsql4W7pO4R0
 /ih61My+JMHVmo+ML+W6O+bLVaM1qxkao5VycB9PIZhSCXRgnnBEVqlOC38UiWEKag0IGGJg/sw
 0N+nJ/mYNAUb0v6COY0ard0NK4I1+91AGaVepMUPt5n9RjfVsHU0TzHDTwcWjJoz0+4L/JErLvC
 25IT9f0il64mo3ij/Yma0T6uPvQ2M3ANybb9bSuQ9qz5BEt3cpFxIWSZXOW3e64Vivqx56qfKWl
 cXfysOsBJ1XuDRo0/vDMmBnGkyTC5n8=
X-Received: by 2002:a05:600c:4f8b:b0:4a3:5d64:df91 with SMTP id
 5b1f17b1804b1-4ac17ffaf95mr157210525e9.18.1793516579673; 
 Sun, 01 Nov 2026 00:02:59 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm254771345e9.1.2026.11.01.00.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 00:02:59 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 12/14] efi_loader: Measure the GPT the partition driver uses
Date: Sun, 01 Nov 2026 07:02:58 +0000
Message-ID: <d416499f-dd42-4162-91f9-1752f090142d@gmail.com>
In-Reply-To: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
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

tcg2_measure_gpt_data() reads the primary GPT and measures it into
PCR 5 without checking it, while the partition driver uses the backup
GPT when the primary header or entries are not valid. So PCR 5 may hold
a GPT the partitions were not found in: a change to an unused primary
entry, which is not measured, leaves PCR 5 as it was while the
partitions come from the backup GPT. Nor are the sizes in the header
checked, so an entry array size that wraps in 32 bits makes the walks
read past the end of the entry buffer.

Measure the GPT the partitions are found in, read by the partition
driver's own code through a new part_get_gpt(), which checks the sizes
too. When the primary GPT is not valid, measure the backup header as
the primary header that 'gpt repair' writes from it, so that PCR 5 is
as for the repaired disk; a primary header marked to be ignored
(ChromeOS) is never repaired, so measure the backup header as it is
then. If no valid GPT is read, measure no GPT event but return success,
so that the separators are still measured.

EDK2 measures the GPT its partition driver uses too, since 7c12d4359abd
("SecurityPkg/DxeTpm2MeasureBootLib: Use GptLib parser"), with the
primary header that driver restores from the backup.

Add a sandbox test that checks PCR 5 for a valid GPT, an entry array
size that wraps, a backup GPT that differs from a broken primary one
and an ignored primary header, and check part_get_gpt() in
lib_test_gpt_sizes.

Fixes: ce3dbc5d080d ("efi_loader: add UEFI GPT measurement")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v3:
- Rename part_get_gpt_primary() to part_get_gpt(), and say in its
  comment when a backup header is turned into a primary one (Simon)
- When the primary header is marked IGNOREME (ChromeOS), measure the
  backup header as it is, since gpt repair never rebuilds the primary
  one then, and correct the comment and commit message that said
  otherwise (Simon); test that case too
- Name the device in the warning when no valid GPT is read (Simon)
- Shorten the commit message (Simon)

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

 disk/part_efi.c                |  27 ++++
 include/part.h                 |  27 ++++
 lib/efi_loader/efi_tcg2.c      |  52 ++++---
 test/lib/part_efi.c            |  61 +++++++-
 test/py/tests/test_efi_tcg2.py | 246 +++++++++++++++++++++++++++++++++
 5 files changed, 385 insertions(+), 28 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 85945634915..a274a268764 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -875,6 +875,33 @@ int gpt_repair_headers(struct blk_desc *desc)
 	return ret;
 }
 
+int part_get_gpt(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry **gpt_pte)
+{
+	int r;
+
+	/* Find the GPT as find_valid_gpt() does */
+	r = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_h, gpt_pte);
+	if (r == 1)
+		return 0;
+
+	if (is_gpt_valid(desc, desc->lba - 1, gpt_h, gpt_pte) != 1) {
+		/* is_gpt_valid() may leave a freed array here */
+		*gpt_pte = NULL;
+		return -EINVAL;
+	}
+
+	/*
+	 * If the primary GPT is not valid, give the backup header as the
+	 * primary header that gpt_repair_headers() writes from it. A primary
+	 * header marked to be ignored (ChromeOS) is never repaired, so give
+	 * the backup header as it is then.
+	 */
+	if (r != 2)
+		restore_primary_gpt_header(gpt_h, desc);
+
+	return 0;
+}
+
 int gpt_verify_partitions(struct blk_desc *desc,
 			  struct disk_partition *partitions, int parts,
 			  gpt_header *gpt_head, gpt_entry **gpt_pte)
diff --git a/include/part.h b/include/part.h
index 1dc510cb6b1..4b1d40511db 100644
--- a/include/part.h
+++ b/include/part.h
@@ -680,6 +680,33 @@ int get_disk_guid(struct blk_desc *desc, char *guid);
  */
 int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e);
 
+/**
+ * part_get_gpt() - Get the GPT the partitions of a disk are found in
+ *
+ * Read the GPT as the partition driver does: the primary one if it is valid,
+ * else the backup one. If the primary GPT is not valid, the backup header is
+ * turned into the primary header that gpt_repair_headers() writes from it. If
+ * the primary header is marked to be ignored (ChromeOS 'IGNOREME'), the backup
+ * header is given as it is. Nothing is written to the disk.
+ *
+ * @desc:	block device descriptor
+ * @gpt_h:	buffer of @desc->blksz bytes, filled with the header
+ * @gpt_pte:	set to the partition entries, which the caller frees, or to
+ *		NULL on error
+ *
+ * Return:	0 on success, -EINVAL if no valid GPT was read from the disk,
+ *		-ENOSYS if GPT support is not built in
+ */
+int part_get_gpt(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry **gpt_pte);
+
+#else
+static inline int part_get_gpt(struct blk_desc *desc, gpt_header *gpt_h,
+			       gpt_entry **gpt_pte)
+{
+	*gpt_pte = NULL;
+
+	return -ENOSYS;
+}
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 5f9bbe97455..97fce462138 100644
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
@@ -1202,40 +1203,37 @@ tcg2_measure_gpt_data(struct udevice *dev,
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
+	if (part_get_gpt(desc, gpt_h, &entry)) {
+		log_warning("%s: No valid GPT read, not measured\n",
+			    handle->dev->name);
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
index 42de9109360..696b73f28a7 100644
--- a/test/lib/part_efi.c
+++ b/test/lib/part_efi.c
@@ -328,6 +328,7 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 	struct blk_desc *desc;
 	struct udevice *blk;
 	gpt_entry *gpt_pte;
+	gpt_header orig, written, backup;
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
+		ret = part_get_gpt(desc, hdr, &gpt_pte);
+		free(gpt_pte);
+		ut_assertf(!ret, "case %d: GPT not found: %d\n", i, ret);
+		if (cases[i].ret)
+			ut_asserteq_mem(&orig, hdr, sizeof(gpt_header));
+		else
+			ut_asserteq_mem(&written, hdr, sizeof(gpt_header));
 
 		/*
 		 * Read it back into a buffer as large as the one above, so
@@ -396,6 +415,45 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
 		ut_asserteq_64(parts[0].size, info.size);
 	}
 
+	/*
+	 * A primary header marked to be ignored is never repaired, so the
+	 * backup header is given as it is
+	 */
+	memset(hdr, '\0', 2 * blksz);
+	memcpy(hdr, &orig, sizeof(orig));
+	hdr->signature = cpu_to_le64(GPT_HEADER_CHROMEOS_IGNORE);
+	ut_asserteq(1, blk_dwrite(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, 1,
+				  hdr));
+	ut_asserteq(1, blk_dread(desc, lba - 1, 1, hdr));
+	memcpy(&backup, hdr, sizeof(backup));
+	memset(hdr, '\0', 2 * blksz);
+	gpt_pte = NULL;
+	ret = part_get_gpt(desc, hdr, &gpt_pte);
+	free(gpt_pte);
+	ut_assertok(ret);
+	ut_asserteq_64(lba - 1, le64_to_cpu(hdr->my_lba));
+	ut_asserteq_mem(&backup, hdr, sizeof(gpt_header));
+
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
+	ut_asserteq(-EINVAL, part_get_gpt(desc, hdr, &gpt_pte));
+	ut_assertnull(gpt_pte);
+
 	return 0;
 }
 
@@ -403,7 +461,8 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
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
index 00000000000..4a17b839ab4
--- /dev/null
+++ b/test/py/tests/test_efi_tcg2.py
@@ -0,0 +1,246 @@
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
+def gpt_event(fname, backup=False):
+    """Get the EV_EFI_GPT_EVENT data for a GPT of a disk image
+
+    Args:
+        fname (str): Filename of the disk image
+        backup (bool): True for the backup GPT, as it is on the disk, else
+            the primary one
+
+    Returns:
+        bytes: The header, the number of partitions, then their entries
+    """
+    with open(fname, 'rb') as inf:
+        disk = inf.read()
+    start = (len(disk) - SECTOR) if backup else SECTOR
+    hdr = disk[start:start + GPT_HEADER_SIZE]
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
+def ignore_primary(fname):
+    """Mark the primary GPT header to be ignored, as ChromeOS does
+
+    Args:
+        fname (str): Filename of the disk image
+    """
+    with open(fname, 'r+b') as outf:
+        outf.seek(SECTOR)
+        outf.write(b'IGNOREME')
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
+    one, and the GPT event holds that, with the primary header it restores,
+    or the backup header as it is when the primary one is marked to be
+    ignored.
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
+
+        # a primary header marked to be ignored, which is never repaired:
+        # PCR 5 holds the backup GPT as it is
+        make_gpt_disk(ubman, fname)
+        ignore_primary(fname)
+        expect = extend(extend(bytes(32), gpt_event(fname, backup=True)),
+                        separator)
+        assert boot_and_read_pcr5(ubman, fname) == expect
+    finally:
+        for path in (fname, other):
+            if os.path.exists(path):
+                os.remove(path)
+        ubman.restart_uboot()
