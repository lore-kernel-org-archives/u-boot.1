Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64DA606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rGnlEUxl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F8D940D4F;
	Thu, 19 Nov 2026 15:21:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0yX4uiJAsf9y; Thu, 19 Nov 2026 15:21:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BBEF040D36
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101662;
	b=EFVM/E7vuZBWERZM7hp3ixKa4Wca8WQxD0g+QuSAu3otXC9nScI9GfWsjUTjpFHNLqiE
	 +q9wC+ocvC5fxn7RQpOScD4lTv/wjtqc11+dbZ4VKueX4SVXOICBr1ufrV3xHWiFXOEqW
	 FGjTNHPLEDuBSqNwokE/4vJOxqNLoc393KQCBW4HPDSZ4IXlGCsNb/DmtzI2gLnZRlfwz
	 RY4Ppalfhut5Wn1AxH++Vkss8ZkKZQFyvTIa05EM4OMiRtWWm9rlE3W0Ou9/6vFSaZfA2
	 DeW5B/qzIbwEldlcP6QSgn+OyGuBporXb52I+vbjs7iASOppZDQg32xp1S+PQWXtZNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mdKoTBFwwkKBQk9q8LFXxkbiwqbelfTLfmscCd3IOHU=;
	b=SPYi8F1cNBpCuvHfmTUHg7hji6A/AEexxybKzN/txcGWKArviDn+kgT7PceXGosD+YmP
	 B4jkTCngTlK3piVA1F/23Zza+kDRA9bXi5NQR0VspBPkqsuce9AQFqeeUqALTnzhVRcKC
	 uQtkOMQG/RTn2Dm2JVfYVrIlbyICObfU/GvOcyYmK07/52ehZv0l1TMaxc4fItn6UBlxo
	 8ELUTHmZH9wa/x1iqW33WgXzNmB917mfsoL5RuPNd55DYGQCeSRpcJMduvOE0wYYBwiZ5
	 LYXn1Kio5HZKGITD6yszlm1I1EvcXM6Axybw6lQM902Xaod0qeWuShgQ4kI5diEfFMg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101662;
	bh=mdKoTBFwwkKBQk9q8LFXxkbiwqbelfTLfmscCd3IOHU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rGnlEUxlQrx9x4TUjVsyO4SGROMBGnp2rdogVJjFvFpJT/oWr+BLPiCHP+XcJDkKQ
	 mCruKEV59k5IusJkThzmEIBcfl46SvOFjSkJu4OKVzEuBtrqB4Pzbj8wsLWphTD5JP
	 15KZliH0YGmMZLhz8omVo1XXCJH80vEa2kSpogYDC3LGKCF7T9lp6lGuvP7MKpYa+d
	 WfpgOrs/uK5hiV8EvY6uNxQaEpwEvNoe3ZgqadPFZ+2v31b8IZco4hZ0Xto1QGJ/47
	 Lt1MNqsRy/117TX4XgHQ08JjvDGQBC9lKkbJ9SFkL3GpP1dhe1VdzIzNH2zX8/CcUI
	 Pz0wf+uPHyQ7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBEF040D36;
	Thu, 19 Nov 2026 15:21:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF9FB1E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E15B081360
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yAHpw2LT7ROa for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F2E2781372
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=31.223.242.245
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=31.223.242.245;
 helo=mx.dave-tech.it; envelope-from=andrea.scian@dave.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dave.eu
Received: from mx.dave-tech.it (mx.dave-tech.it [31.223.242.245])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2E2781372
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:46 +0000 (UTC)
Received: from [127.0.1.1] (unknown [192.168.0.244])
 by mx.dave-tech.it (Postfix) with ESMTP id 7C77220083;
 Thu, 19 Nov 2026 16:15:35 +0100 (CET)
From: Andrea Scian <andrea.scian@dave.eu>
Subject: [PATCH 0/7] zynq: rsa: fix the boot image verifier
Date: Thu, 19 Nov 2026 16:15:21 +0100
Message-Id: <20261119-b4-zynq-rsa-v1-0-62ed5f983d1e@dave.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIkS/2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0NL3SQT3arKvELdouJEXeM0I8skC1OLRCMjIyWgjoKi1LTMCrBp0bG
 1tQCgC2DFXQAAAA==
X-Change-ID: 20261119-b4-zynq-rsa-3f29b858a222
To: Michal Simek <michal.simek@amd.com>, 
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andrea Scian <andrea.scian@dave.eu>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The zynq rsa command authenticates a Xilinx boot image against the
Primary Public Key of the FSBL that the BootROM authenticated. On a
Zynq-7000 with RSA_EN burned it is meant to accept only images signed
with the device's own key. It accepts others, in several independent
ways. One patch per defect:

1. The SPK is verified with the PPK carried by the image itself, so any
   key pair passes. Confirmed on hardware.
2. The PPK lookup in OCM is placed by the image's fsbl_len, unbounded:
   it can be pointed into DDR, at the image, bypassing 1.
3. A partition with only an MD5 checksum is accepted next to signed ones.
4. The encrypted and checksum flags carry over from one partition to the
   next.
5. The load-address check uses && for ||: any address above the start
   of DDR passes, OCM included.
6. Partitions are copied before they are authenticated, and the copy can
   land on U-Boot's own memory.
7. Success is returned when no partition was authenticated at all.

1 and 2 together restore the trust anchor; 3 to 7 are independent.
All are in the code since it was added in 2018 (37e3a36a5475).

Not addressed here:

- The anchor is the FSBL's certificate as it sits in OCM when the
  command runs. 2 keeps the lookup inside OCM but fsbl_len still picks
  the offset. Comparing the PPK with the eFUSE PPK hash would be a
  stronger anchor, but U-Boot has no driver for the Zynq-7000 PS eFUSE
  controller.
- Partitions are still copied to their load address before they are
  authenticated, and are left there if authentication fails. With 5
  and 6 the copy can no longer reach memory U-Boot uses; a caller must
  still check the return value before using the data.

Tested on an XC7Z020 with RSA_EN, the PPK hash and an AES key burned.
The tested build was the series on v2027.01-rc2-137-g2f83ef8a7dd,
together with local patches that do not touch the verifier (one of them
adds a read-only command to the same file). Since then the series was
rebased onto the current tree and patch 1 gained an alignment attribute;
the object code of cmds.c is unchanged. A device-signed image boots;
each of the following is rejected with a distinct error and a non-zero
return, where the pre-series code accepted or mis-handled it: an image
signed with a foreign key (1); an fsbl_len pointing out of OCM, and one
crafted to wrap onto the image's own public key (2); a partition
carrying only an MD5 checksum beside signed ones (4); an image with no
uboot-owned partition (7); and a signed partition whose load address
falls inside U-Boot's own reserved memory (5, 6).

These were reported privately to Tom and Michal first, who asked for
them to go to the list directly.

Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---
Andrea Scian (7):
      zynq: rsa: verify the SPK against the PPK from OCM
      zynq: rsa: keep the PPK lookup inside OCM
      zynq: rsa: reject partitions that are not signed
      zynq: rsa: reset the partition flags for each partition
      zynq: rsa: fix the load-address bounds check
      zynq: rsa: do not copy a partition over reserved memory
      zynq: rsa: fail if no partition was authenticated

 board/xilinx/zynq/cmds.c | 156 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 111 insertions(+), 45 deletions(-)
---
base-commit: f6e8f09ed39347359ebddd983b96993c78b4ec7d
change-id: 20261119-b4-zynq-rsa-3f29b858a222

Best regards,
-- 
Andrea Scian <andrea.scian@dave.eu>

