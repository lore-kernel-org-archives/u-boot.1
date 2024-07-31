Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8375C52D54
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DD088ADF;
	Thu,  1 Aug 2024 16:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="daj62t/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A5388A9B; Thu,  1 Aug 2024 01:31:39 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF0688AAC
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 01:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=darekjens@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so3862722a12.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722468695; x=1723073495; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zW6Kef/mp93hOhioh8R5F7i6Ci+TPAH4x3/U+z0w7uk=;
 b=daj62t/a6sHykaWbeKwA06SGfu5S4H2F9juwWiRBW7tvycb7LWf2alAjx2A35scoKD
 Kel0Q1U0lNk6Dyy50c2org6jo6Ak4tsfKDrrifP2oQasfC1lASH6oFZeSUn8xijspWQ/
 ULoAuXG/aORGWuY19+PFWJj5qedY0eKCMJeaLJPn15cidij7Hopxb8kmqDlm3qpnHTld
 ZJdrdFCYcFQ3IBfWmvAbJYziSWAAKtWcL+fxN7rmmwZn9bsrH/E88ShWFH0knq4hJLQR
 PEiXB2ZqD8csXkzQct8yI9L/FgQpBxoUJ98dIFKVk7xHYo2fYANK6fobqnXUBS7qWGAY
 q7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722468695; x=1723073495;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zW6Kef/mp93hOhioh8R5F7i6Ci+TPAH4x3/U+z0w7uk=;
 b=YQX29a6N4f6nS1eA21fsFRkfyJcOV4eNsoKiuNNOaquCInt/vcv5NHNDnD5gcAI0Wt
 vl95n5CtvtEBXnRH2Nj99Hxjfw+ik27PvonaF5xA65Mlj6eg3HRMSahoMgH6Z7dRXQm2
 7wbUl97CaWKju7iIj0coXtuWzav5Mzwv/3yIyUjIl0nKHrIscRHodbe10HBDqQfGSdsr
 NEyRHvmIlBfCX6iBENkBwZVcfK/c9y7BSYc7hhI5KiYXggz02k8Dm/qKIubuDd+J1Z7f
 PCAIdTiAP04WAvBTzZscBVTbx4LAjUfLcM31TO9TZZI9I9R7zGip8Lw0XoPQeSHNSy9z
 WBGg==
X-Gm-Message-State: AOJu0Yzji7oeDUokbSWMXzWmcj2/UoHLOaEutvaWjZ/hKUqRxnRiyvw1
 HQhkd5oKc5JWoN5PJGyzUqdixOP7R4EEILslzQZxCuperNtbwgGB4aqMJIkk+aByzXFif2T6xLO
 VfgwqwF/1QvY4y+C4NOAy/O/p4AH6OsYG
X-Google-Smtp-Source: AGHT+IHvq9w166l3wJ8mRxE0lxel1MC/pFvyhUTtgteXo8tDF+nGwJFffSsTjX8Tg/zYlZ+8mN4t5ibRE6zCVQnXkqc=
X-Received: by 2002:a17:90a:780b:b0:2c9:6f06:8009 with SMTP id
 98e67ed59e1d1-2cfe774a1dcmr1013377a91.1.1722468694684; Wed, 31 Jul 2024
 16:31:34 -0700 (PDT)
MIME-Version: 1.0
From: Darek <x64x6a@gmail.com>
Date: Wed, 31 Jul 2024 16:31:24 -0700
Message-ID: <CAC7rXdTb5u5pzP-mr_+pddCxzfcO8Vm_t-=_+5wxRitMjy6-JA@mail.gmail.com>
Subject: Vulnerability in LZMA implementation
To: u-boot@lists.denx.de, "trini@konsulko.com" <trini@konsulko.com>, 
 marek.vasut+renesas@mailbox.org, "sjg@chromium.org" <sjg@chromium.org>
X-Mailman-Approved-At: Thu, 01 Aug 2024 16:06:21 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello!  I hope this is all the correct contacts for reporting this issue.

I have discovered that there is a vulnerability in the version of 7z LZMA
that U-Boot is using (9.20).  I've found this to lead to code execution
when used with `lzmadec`.
I have found no issued CVEs or public disclosures announcing this
vulnerability, but it appears to have been patched in 7z LZMA version 21.02
alpha.  I've patched locally with 24.07 and U-Boot appeared to LZMA
decompress successfully, but I'm unaware of other use cases within the
project.  I would also be curious if another LZMA implementation would be
considered.

I'm separately coordinating disclosure with the 7z maintainers and planning
on requesting a CVE.  Since your project uses an older version that is
unlikely to get a backported patch, and the issue is already fixed in newer
versions, I am disclosing this to U-Boot maintainers at the same time.


The bug triggers when an LZMA has the 8-byte length field in the header set
to 0.  This field is located at offset 5 from the start of an LZMA file.
Due to how the logic of `LzmaDec_DecodeToDic()` works, this eventually
reaches a `memcpy(p->tempBuf, src, inSize)` on this line -
https://github.com/u-boot/u-boot/blob/8877bc51a8a4d921ba2f163208b8b1a57ba47c18/lib/lzma/LzmaDec.c#L793

The `inSize` value here is allowed to be greater than the buffer size due
to the previous if-statement ignoring this value if `checkEndMarkNow` is
set.
The return value from `LzmaDec_TryDummy()` also needs to return
`DUMMY_ERROR` to reach the `memcpy()`.

The value of `dicLimit` in this function is initially the value read from
the LZMA header, which for this case is 0.  Under my testing, when this was
0, it hits the memcpy call, using the passed `srcLen` value (`inSize`).

Within `lmzadec`, this value is originally set to max size_t as the default
here -
https://github.com/u-boot/u-boot/blob/8877bc51a8a4d921ba2f163208b8b1a57ba47c18/cmd/lzmadec.c#L24

And passed to the `LzmaDecode()` function here -
https://github.com/u-boot/u-boot/blob/8877bc51a8a4d921ba2f163208b8b1a57ba47c18/lib/lzma/LzmaTools.c#L110


Under my testing, when `lzmadec` is passed an LZMA file with a 0-length
field, this ends up calling:
```
memcpy(p->tempBuf, src, 0xFFFFFFFFFFFFFFF5)
```
This is no longer max size_t due to previous subtractions in this loop and
within a previous function:
https://github.com/u-boot/u-boot/blob/8877bc51a8a4d921ba2f163208b8b1a57ba47c18/lib/lzma/LzmaDec.c#L746
and
https://github.com/u-boot/u-boot/blob/8877bc51a8a4d921ba2f163208b8b1a57ba47c18/lib/lzma/LzmaTools.c#L51

This leads to code execution when the corrupted LZMA file is large enough
to overwrite `memcpy()`'s instructions, or if the memory past the LZMA file
is also controlled previously.

In my testing, I created a small LZMA file and modified the header's size
to 0.  I then appended assembly instructions that performed a loop to this
file, so that when code execution would occur, I could easily verify by
seeing the loop. I repeated this until the file was over 1GB.
In U-Boot CLI, I then used TFTP to load the LZMA file from my server and
then ran `lzmadec`with my selected source and destination address far away
from U-Boot's code.  When I attached a debugger at this point, the program
was stuck in my infinite loop code.


I believe this is especially a concern for secure boot implementations that
utilize U-Boot's LZMA decompression, as it could bypass their secure boot
implementation.

Please let me know if any additional details are needed or if a
proof-of-concept video/script would be required for further evidence.

Thank you,
Darek
