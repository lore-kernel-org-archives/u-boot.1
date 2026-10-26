Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30070606A325
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G0pmPfJ2;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HvmmnX6V
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 063524041A;
	Mon, 26 Oct 2026 13:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cYg5zway1ous; Mon, 26 Oct 2026 13:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A5D740422
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793020739;
	b=noUpGQ4+v33x2MFjgC6BeBMlu1UA6vdpDeXOBGNzXQJOhjhkIH0ATnVYKXtCnBp8FZ5X
	 hDeAifYfofvU3Wb8OyJEY9wCu27i+38ewQsr8dvGNW0+U+ykgcydOAXqqSOpUzV2Wirco
	 FTSCt3CR8+OibMtwmdor/JEZ9cR5a411MJPUkCwgbPwvXFMssC++O/fxG4/2BtywVlAvw
	 LOEojW6rWMr2XdOio9ZknJhKWktw5dIzj1xDtXxBKwXEyArIGzzkXfxFkmgSBoJiBH7rA
	 VEQbUGs/uJcz+N78CTEG6pgXfT/YgxTVuhEyCI1uBPQcV6Z9i/d8i0SgI4ZX45F4ETQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793020739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Xz3cFtPUVZ0HIYwQwWCWmRq1KdmijJUtxyX/cSXmYQU=;
	b=QpMqm54H7R+iISvIp6efH80JgA/EC4PNJ5QcP1jRvSXHSHpW+FPQnacMcybvS/dlauYH
	 9qzw5TdV+UIm5Z47x4YBLXHvVEkWFmEOzy3BBcjclq/MP9f2YUDWLxLKJLtPNoXby8T7N
	 5O+QPXscV4Xmm4RjspypZT5qEIIR81qrcpZgbVbiSG5eZChmuaDoYQCmPFrsO4+Vq6sQB
	 ik8AIXObac4mw8Kt7bjorkmFm9d4jx275tWh3ebk4Vqm6DQY8LgwKGnfSdKzfobGAxxNy
	 TJEFxY9UG7geKKaDegauIMdmfGwXMDH9ovry3SumDgluFEPBfXb/a+n2Nkl1p7iEmFA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793020739;
	bh=Xz3cFtPUVZ0HIYwQwWCWmRq1KdmijJUtxyX/cSXmYQU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G0pmPfJ2aA4dE6SHS2cxiXytHukha0HdEgV28lMCSw7O0gLtzUMpdbNhARY6NARF7
	 twRyAxzEHrf001+M5gEY1BZ0iPt8Ljtt+gy8i1XExGsr1a9MdRAan47gcgxEN2cquV
	 +gFkzpmRr8n6eHyAaQfNnToNXq2uGUH6CZ3fZpogiHWhOJVKDX82lPBO+YNd7yZj1W
	 jorZBAehO7WN8TFamuj4DeKffHPMHV4CXM+P7yryayQOuGZH3jF+NFuPZvusAIAxY7
	 AoFc/QK3+hRzOK0UUxggDII/FEGtMjMAgkyZtgVLFIeMlVr3yyviDjhtPx9mavyKYB
	 H8kRIZUY7dOAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A5D740422;
	Mon, 26 Oct 2026 13:18:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 102684B8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA62680C5D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:18:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sX6bqDx1gsyU for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D5CCD80BD3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793020737;
 b=mWoAG1eQT7jsA/w51iuvA4J1BGIqO9Po7RBGdjRfGwYSoVGTSG6ouIMRKVxRnlCqusM3
 aie94aJRs07AmdboH2b2ztP3bKfL4EtQkYHHRHdrkNFE87p+Nk4r3sp7h+38nMf4DPLMU
 MNOraUCx9+68NLmKXxdKD3ng8btE/jlY23g1yHEGCqHP1I4WbF5OnOzZaEhEt675Bnnk9
 D4FUfPfKifNqSgSF11dz1VAGgzpujiQZqgKLicRLHJh4Vv5rr4NqjbVA+vzf+xed1UBXa
 h/6iffYyw1tUFtg4gkqkcmKS6nnVTFRQiFjbncQxMFe8D+xkNqP4ikyb1e6BvkmCoOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793020737;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=Xz3cFtPUVZ0HIYwQwWCWmRq1KdmijJUtxyX/cSXmYQU=;
 b=XZUfFhY31TMtSFvMvugU9vk/CdMCMMfypaTemhyjVpKZOH6e111FDJ6/X4FyI/cIifUp
 oLjqIDneimfo/PYiOGT6OthmkcI5TgwnKh0hOYiStNt7OK4z4S0tQhAFA1U2JJuf2ACsh
 lEVhtTSUMOPiaoSzMgFTPmlGYhPXuXFSQVlUFi4pFPfnTU5ku5rkf39WbgVNtxoQy7d6K
 /4NXXl/mvKxoWO8W2EgOl9DJ0/rhMJFZMW55gOyCc7brGiDhuwvELGAHUXxBpWHfztq5L
 ytYUyPOu2ERLVxJcUnOCFOMBLivLoDCEooU5KYLGYa1GviIRfN1s38SYCAnfREl10cA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HvmmnX6V; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HvmmnX6V
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D5CCD80BD3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:18:55 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so17793735e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793020734; x=1793625534;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xz3cFtPUVZ0HIYwQwWCWmRq1KdmijJUtxyX/cSXmYQU=;
 b=HvmmnX6VqGSFabeSUn6pSEONoJdJlmkwNxsXIkOvW873bKo3BDAyLYmCdABrjr0zqZ
 ar8f3WuI4GncTRw+vQVzY00EsTNbRkone8dEwJjbxFlDBTnaTtUIvR+5wBJfkkAs/iBi
 TpEh0Ag9/B28AP0pZ450pGh0YDMyaPmA/MdnzyNqiFA/qdzgjGst4nWWpjofsI1H4nx4
 9J5ZUq+GlUhVD4XwPt+5nx2scPz11FIzWSRFX2BQjkGlPDEnkM+VatJSm/nYpfZNUJ4K
 gRHv8mC2Ddrpr5YKJ7jUkvERdd1+2u5aUjPHo5HK84n5ZxLPn+cu9xkyIMbbgNGUWZVF
 lgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793020734; x=1793625534;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xz3cFtPUVZ0HIYwQwWCWmRq1KdmijJUtxyX/cSXmYQU=;
 b=CEP9GUr4TVNrdgtZYZ47jpHMoeBqOnZFNUxMDZSbOEKXY3tKHsD4/kKWmLlshCH+jW
 wRam1EJNkq/4zobPGB8+ZP7Q85cOK8fyznGSNyG0Qdgl+3eIzqXRB9Zfufq8A5iVAfw3
 u83wbw2YdpJxONQlRfMnraEvhioashK8EZ6pZrM1Uve1IJP1dUzExxcrEI5DNCL5qkTH
 2U1NyaZpUTwYTlTX/+BcniNdbHCeT9g1qDApD6AElrKclgPW90iMrCwAhpm3cpA4z67/
 sXy7QeSFtrzdYqhlGHgpYMYkmgcm2KLwZj/04Sk+6lW8E4P70pern3ocL15nPd8rYtKU
 84LQ==
X-Gm-Message-State: AFq9FYKhyE10AvfsOpshVYz/HpKV1fdHYmVdo01ub5jUNJ67bYTiKSzV
 D1WqMG4vFH9v1AqzVcMhRSilnOab6cG+VmPb5pEMmv/41Cac4LD3VArIjB2z76Sh
X-Gm-Gg: AYBFou01byvsP/mZIfUlxdK100ENKbpLGDK946PVtmmmGUXT9T20bjgvMo6Tawgbfgx
 NGDjLVES4ZGXMpJNn/H6U7oXrHfMXq1CFQ3bmzdxAWzbIpDu8rzBtaR9u//thycw6vnyDjs5sEs
 L+W8aH2NKY4M1e3n+XWMsHinCU2rQh2MbthTYiSA0RclfJHfk/2+D+Zkv8Lxs3jR7ivy5nBG7s+
 FuSGth7jE5H/0a9xYUiW0AYw9T7UW+J3pE+Voc5C0FBHPCboqpzJXNeoyo76Odz35nSc2PrUb7y
 zwecu2pbZIYvL8X9yjjOaTXKPlAO1HE7gmOU2YmMqOw8jZ/ULw5t71QkEbVLSOR+XXZyTtPG/pp
 Jp2K14nslnSnOh6gzRsQhDU8IpRV7remgN04pvdwXWVvFlY7tWhf+4atAFWsZG4SSm+x1r71snf
 JxYygbofFahsF7D/TYcTcBPORu5kpXm2HnCKACnGBSKSKd9geEvGsnumMs7+zz8VKqi9F8WSQQ7
 Va+YjHJ5Pg5MuMoTa3HWA3SaQLAWluZRu7cE988IUEUxu/FjjSlGg2fAYCXv6XZsKDqyjX9kqPa
 fLE=
X-Received: by 2002:a05:600c:3f12:b0:4a4:7a8d:c436 with SMTP id
 5b1f17b1804b1-4a47a8dc6e6mr103490125e9.11.1793020733451; 
 Mon, 26 Oct 2026 06:18:53 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f523c0sm99011905e9.0.2026.10.26.06.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 06:18:52 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND 0/6] efi_loader: capsule: check sizes against the
 capsule
Date: Mon, 26 Oct 2026 13:18:35 +0000
Message-ID: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

This is a resend of the series posted on 22 October, now with the
patches inline: the first posting carried them as attachments, which b4
and Patchwork cannot use. The patches are unchanged and still apply to
main.

The capsule update code takes several lengths and offsets from a capsule
and uses them without checking them against the size of the capsule. On
the capsule on disk path this happens before the image is authenticated,
so a capsule file in \EFI\UpdateCapsule on the ESP makes U-Boot read
outside the capsule buffer the next time capsule on disk runs, even
where CONFIG_EFI_CAPSULE_AUTHENTICATE rejects the capsule afterwards.

Patches 1-4 check the capsule file size, the capsule header size, the
FMP capsule layout (header, item offset list, item offsets, image and
vendor code sizes) and the certificate length of an image, each against
the size of the capsule. Patch 5 checks the FMP payload header size;
with CONFIG_EFI_CAPSULE_AUTHENTICATE that header is part of the signed
image, so there it is hardening. Patch 6 adds unit tests for the FMP and
certificate checks: without patches 1-5 four of them fail and the
certificate one ends in the crash described below; with them all five
pass, as does the rest of "ut lib".

The capsule file check, the FWU accept capsule and the FMP payload
header have no unit test, as they need a file system, FWU or a signed
capsule. I checked patches 1-4 on sandbox_defconfig with CONFIG_VALGRIND
instead, by placing malformed capsule files in \EFI\UpdateCapsule and
running "efidebug capsule disk-update". Without the series valgrind
reports reads past the capsule buffer in efi_capsule_read_file(),
efi_capsule_update_firmware() and efi_parse_pkcs7_header(), and a
capsule ending inside its FMP header is reported as applied; with the
series each one is rejected and none of those reads remains.

On that MbedTLS build a malformed certificate of valid length still
crashes sandbox in efi_signature_verify(), with or without this series:
pkcs7_parse_message() returns ERR_PTR() of an MbedTLS error code, which
IS_ERR() does not catch. Vsevolod Kozlov's "lib/mbedtls: Do not use
ERR_PTR with mbedTLS error values" fixes that.

Ana Bobillo (6):
  efi_loader: capsule: check the size of a capsule file
  efi_loader: capsule: check the capsule header size
  efi_loader: capsule: check the FMP capsule against its size
  efi_loader: capsule: check the certificate length of an image
  efi_loader: firmware: check the FMP payload header size
  test: lib: add tests for the capsule size checks

 lib/efi_loader/efi_capsule.c  |  63 ++++++++---
 lib/efi_loader/efi_firmware.c |  20 +++-
 test/lib/Makefile             |   1 +
 test/lib/efi_capsule.c        | 193 ++++++++++++++++++++++++++++++++++
 4 files changed, 259 insertions(+), 18 deletions(-)
 create mode 100644 test/lib/efi_capsule.c


base-commit: acc808479730e13e74199119eb9b2b9113999244
