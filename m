Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F9606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u1Z8MMLP;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MML4O9kj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6074E80F86;
	Mon,  9 Nov 2026 21:48:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uprsx5mzunCY; Mon,  9 Nov 2026 21:48:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 30CB380DCE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794260934;
	b=edSx6/Brmg+h0hW/2RV34/i2i164d/gGFaxhVOcFUmFyqqihnhkD2GsEo3dq0zflqzfq
	 eQ/mDOfTpd9rWebdez9W1fo1984KDp0gMh485GSeDDgQrdJFm4Tb23FrDq3WYRkC8Z15+
	 X6QZGR9pilfCnfdDxjbCX+HNSD+wBGFlIhge0UeGZOT1fU8iUT1bvlQBMiC3D0eQQSwBs
	 i+gZSyUM6xml/Rdh5vMcdrVvHTGNWCraKnuhusvvS0yMl+YfAFjomaiTxWHcJgq4D0uNN
	 nfGZygfWxB1hjV9IBUSK8Wdkz+A5bNNveiigfwW7TD609q6LErgQBFMRwgGr9Ffy+sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aY5kD823PyAiKq/0RaL5zxKssukJU2mYto29epcMAaI=;
	b=hJp05n0bYqdtmmn1Bp3l4Ts+y4noNEDuFwNXnAL5j3S1LSqLeKnCxYk5N4OURPix43sT
	 5xmJG/ZOUoHe/988qyCnRDQF/4pCz4unCPwihqHK2vUxFLXDythXd434ZSYXyS4330Hvp
	 igtL1ntVdBjdxgR2qPsksxDbhGfHXE6VgOJQLUyKYoIsWoLJlpmXphplLZ97OxwEJKjyJ
	 ecxvhsdsoEFeooYoLw3tSxICZXH45aSemCX5N7Cq0U3hFhetKawznKBy+GvZ2r3IXLZwJ
	 j7DszFNQcOZIpNCpKbfSgj1SLUK3Wx4eGH8sp28lYiPCc/K6Mk24wTRU8Wqn+93VQSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794260934;
	bh=aY5kD823PyAiKq/0RaL5zxKssukJU2mYto29epcMAaI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u1Z8MMLPlobDJXi7uJT8Btz4ULm8iCgTtxjM+p1an8nzGrN1sD6krfMTA6nRBDYQy
	 DeVn7HlEqA5F34AuR8+ayoq8N47zuorMeH/mHD7iAosq8JYo7+gjYk0KmHqz413XDS
	 MifVJmJrXF03POi+ukDSVh0yair/aBEr/jtfCnT/gZxn4b7gpjU5fBYxN5w7E/gGTe
	 l1uFjkkARHJYWx904OrbBWRw6X/HQMBnR0VYONR8yEzwJx27hiz++pwTqFMP0h8s6p
	 g1nMK29kHLDdLbniSZO216trnGsiKyfA3pIvhNMrGjVZ/lkq2hLT4po4umco3VnTbO
	 hkCtaizxIqmOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30CB380DCE;
	Mon,  9 Nov 2026 21:48:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 808CE388
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72052607AB
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sWPdyuStcBQM for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:48:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E3506070F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MML4O9kj
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E3506070F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:48:50 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4b7252a32c8so14698855e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794260929; x=1794865729;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aY5kD823PyAiKq/0RaL5zxKssukJU2mYto29epcMAaI=;
 b=MML4O9kj56sPSf0Pabusfh8MEBLle2Gz1F+eCkKt33ntSgXo1xoclllM+ypcT+UdMw
 OGa5j6yMyhLYC52LvtkFoEIeO8bCFeBBQiqzOMrRDAjm1rPWiTotl4jfiQU1tTDMGZIl
 PBP9jlv9Rflg/+jnk98y3PgYTRcPQo1LyECdjKuAXmQ+vkjmCg9W8zvCqWh0JiiT0YSA
 O4u/WL6sVU/Gmryp4VIPsxFJh0BvLyOSyJ+7s66eCe3XjIwvXmJo6SvsPrqwQNqMEIgy
 ITjS4q2LonvfavxRWITRm0OY0Y4GF/LWKtRLk8R+801nqlO71ntYyqC0hTTYKzwK1XPD
 A0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260929; x=1794865729;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aY5kD823PyAiKq/0RaL5zxKssukJU2mYto29epcMAaI=;
 b=2NInfeOeHe3NeTCdaygFhlcmOaNxT86mlKb8qy/Z2ZHzpWOS3gR1bmKZlx6rGV3MYG
 yw4TTputp9axEvO0e1Cqc/jb6JhT3vfGsPfa6HEnM2mlbKxbZgR7uo4QzBacdN5QquL+
 k0BtwlKM0JNLB6cUuZCKu7uNKgJ74E7ASf1Ev8YRwxflWcwS0uBpSR7UaCCV4oVh1kFc
 gcztPBSGNHLTWazZjWo6/1YOkiAXYF8Q6H7O0CMT68qGPJkc2fR/fals9CGdvV9JDdEg
 +QBa9CUVYfzv8H3lbp0wR9ki7Q0qpjpnH5rMNbm/4O9TTYoRBqBU5gLEPG9vTjp5Bxer
 mTXg==
X-Forwarded-Encrypted: i=1;
 AL+hErF5SXGfLk9qgAGBlQYZmfemFdGhnHsx53UqSvut90PTSTYa2iVthSYToyPbmTA5WmonUZNizBA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+YKIRfxQ0OaS54SB2rqZssigvIM21jwL70xJ9BY9bZHIvcFeEq
 nsQXwP1qdKMKMVq0mGCn/mFPMhGCVPgkkm7PRbvY2t/aqZR+RFWKrkUjlw49V8ezKYE=
X-Gm-Gg: AYBFou3hahluucd7xOxtMKjGIxkhTbKI+et7n16EwXROnbiVSCLfD1qao1ptG91CTGV
 24XCPN3sZukLdTkMJeUH5+SybWmrw+hdPaTUK6tKhNgVKW45YoJq2JhpuN2R3yVM3HDMtmjsE1X
 bY7lbi2lPbOjJxJCAwBZmMD8/VzWYulfqgy7Ln4clATKXwqSZMRFv1T+x87aP2lErVcWuL/T73C
 B6LuZknLxhlvtfXeU0uKPqBgPCvIHI7IsXvSUHGQ3M7X2ZJsLdXBvfe5rH0OUuD7oue6f2loMIS
 W1J+iqE1FWmf6IsHyipeAy3M4Uyiq3+kuANDdlraY/JL6GDlbsZVrKCYr28BNA+lUL0iNzTVapu
 Ec5kNW1NIU2GOt6QdbuDEzeFm3VQXgf2m0w9H+38VL+21LFDCrde6H1vpxXCx2/E/8AnAlIFlb0
 X4US7TMHf+gAmedzT++cMxQwPJa5NaMIvELGUkyAT3iev3M7rb5BzYFKPVyY3yONyAO6DQYLB/J
 cLWTRgw5HI0NnkEg5y9ntnGKfCipXz4PhvqPRKr2JXwVfN+2i0wMk027aR0VKBD1gkVJj2TcLDW
 MogKqUUNLhywbawSIruAwKkLMmV0j3jVDikq9J+KaF931eLj/2IuDE7KMyIT3yBD11UL3mSsPqQ
 44oQB+f2zgqHj3Bk8JoB2rjTDTYiQqBXiytXHn2U=
X-Received: by 2002:a05:600c:3e11:b0:4b3:9540:47a6 with SMTP id
 5b1f17b1804b1-4ba0234f7a2mr7322855e9.28.1794260928651; 
 Mon, 09 Nov 2026 13:48:48 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835f1772dsm1169903f8f.31.2026.11.09.13.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:48:48 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v4 0/7] Prepare devicetrees from FIT configurations with
 fdt fit
Date: Mon, 09 Nov 2026 22:48:17 +0100
Message-Id: <20261109-ccaione-upstream-fdt-fit-v4-0-5323cbfcc9f3@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Oy24CIRQG4FcxrEvLTTq66ns0LuBwcE5TGQM40
 Zh5d8FuTNOYLv9z+fJfWcFMWNh2dWUZZyo0pRbMy4rB6NIeOYWWmRLKSiEtB3DtBPnpWGpGd+A
 xVB6pcrWJgw4iOuuAtfdjxkjnO/25+8nl5L8Qavf6hXcFuc8uwdhHU6Y9pbeE59q3I5U65cu92
 Sy78o8Ss+SCR6sGi3FQ2poP7y7f5DO+wnRgvcesHiylnliqWUYagQJMWLvNH5Z+tJ710s2ysA6
 DBS3Ee/xlLctyA7iKCpSLAQAA
X-Change-ID: 20261016-ccaione-upstream-fdt-fit-29f83d0fa6ac
To: Julius Werner <jwerner@chromium.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some boards keep a base devicetree and its overlays in a FIT, while the
kernel or EFI application comes from another source. Boot scripts need
a way to verify and assemble that tree without booting an OS from the FIT.

This series adds:

    fdt fit <addr>[#<conf>] <dest> [<len>]

The script loads the FIT into memory with an existing command. fdt fit
then prepares the devicetree described by one configuration, verifies it,
applies its overlays and copies the completed result to the chosen
destination. The script can pass that address to bootefi, booti or
another boot command, and must stop the boot if preparation fails.

The command reuses the FIT loader, always checks image hashes and
enforces any required configuration signatures, even with verify=no.
It rejects chained configurations: signing each configuration separately
does not authenticate their combination. FIT image load addresses are
ignored, so preparation does not write to them before checks complete.

The first two patches fix allocation error handling in the existing FIT
loader. The next three provide the loader support for the command,
including rejecting missing or invalid overlays. The last two add the
command, documentation and sandbox tests.

Patch 4 also changes bootm, even when fdt fit is disabled. If a listed
overlay cannot be loaded or verified, bootm now aborts instead of booting
without it. Boards which previously relied on a broken overlay being
skipped must fix their FIT configuration or overlay. The bootm tests
cover successful preparation and rejection of bad or missing overlays.

This is a new, simpler approach to the firmware-owned devicetree work
previously submitted in the EBBR series [1]. Storage, configuration
selection and boot policy stay in the script. There is no new DT binding,
storage driver or automatic hook into the EFI boot paths.

[1] https://lore.kernel.org/all/20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com/

---
Changes in v4:
- Split allocation-failure checks and error-path cleanup into two fixes
  before the ownership patch, with Fixes tags for their original causes.
- Clarify ownership names and document how to free the returned address.
- Use separate variables for command status and libfdt errors.
- Use GPL-2.0-or-later for the new Python test's SPDX identifier.
- Retain the collected Reviewed-by tags, including on the extracted fixes.
- Link to v3: https://patch.msgid.link/20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com

Changes in v3:
- Make patch 2's bootm behaviour change explicit in its commit message
  and the cover letter.
- Add direct bootm tests for valid, corrupted-hash and missing overlays,
  independent of CMD_FDT_FIT.
- Collect Simon Glass's remaining Reviewed-by tags for patch 3 and the cover.
- Link to v2: https://patch.msgid.link/20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com

Changes in v2:
- Clarify that load_op controls only the base devicetree and document the
  overlay policy and enum values.
- Collect Simon Glass's Reviewed-by tags for patches 1, 2, 4 and 5.
- Link to v1: https://patch.msgid.link/20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com

---
Carlo Caione (7):
      boot: fit: check allocations for decompression and alignment
      boot: fit: free temporary image buffers on load errors
      boot: fit: tell callers when a devicetree buffer must be freed
      boot: fit: reject configurations with missing or invalid overlays
      boot: fit: let callers choose where to place the devicetree
      cmd: fdt: add 'fdt fit' to prepare a devicetree for other boot commands
      test: py: cover fdt fit preparation and failure handling

 boot/image-fdt.c              |   4 +-
 boot/image-fit.c              |  84 +++++++---
 cmd/Kconfig                   |   9 +
 cmd/fdt.c                     |  83 ++++++++++
 configs/sandbox_defconfig     |   1 +
 doc/usage/cmd/fdt.rst         |  75 +++++++++
 include/image.h               |  13 +-
 test/py/tests/test_fdt_fit.py | 371 ++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_fit.py     |  60 +++++++
 9 files changed, 678 insertions(+), 22 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261016-ccaione-upstream-fdt-fit-29f83d0fa6ac

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

