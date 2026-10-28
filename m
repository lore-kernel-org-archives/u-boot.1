Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D14606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BjGv7YTg;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1vOpvGg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6E5E80C16;
	Wed, 28 Oct 2026 05:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9l9UmsuOKx1l; Wed, 28 Oct 2026 05:49:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B892280BDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166585;
	b=fp+UvEy5I//eDIkWOng73Sc6p/bsoRkQEoHOvyZt+xnNYjdofywgLi2Obu1wlhL/qqy1
	 MDiyfrvdgaGe+5WCW24r9yHPO5u+wkIAJqVo/weWgoMMNImpzTOfJrapWKGU80eq4krRa
	 qdtnxbc1d0RmF54OJZQKkIi+S9wv72nx5NYnIhHseWyz1vyqD2MGmyIrFZUmZf3N4fzga
	 1J84s5Brug2tyH+mQ6dO5CGiNxceuzTDkWG3J9K+1hu0Iz0YgSHO3P7/nGEqx8PrVYZq6
	 aJiibbWMSTcy//Wdx0yXIrTYQiAOfFjtDVRBVNRYJCzrdVHCO8I7svghQlM6heHFh8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RYyh7nb6vY3KFaUyvdZ7cxAUVMyIhGZkbTbp0bSnaaQ=;
	b=kxcebSsOXfdNa/RWWv5x2aTw3zCnsI/+SOd8Gi8YlXKVd2WeE7d+/hsCDWS0UnLZ5LjU
	 GWZQDwfbKZOkzGR2uA9TXll+A0+icgVSbP30vL3YTjV4HqSnsI1x6Weh/xEXoRLSzhs81
	 UMzS54IOLuvG+bYzvhNSIc/wYHIYJICLc6hICuGtLmcrL0IkLba0aMzQCIlY5lVPD93GC
	 uPF/QlvpGOzd/9piToODwv5YNjImlMqXk/XXYb2m0ebrIbIctubqZvYe0tBkbro7lUbzl
	 C/l80vm/JBWV11NVbz1XgKv/iXbqT2etryDuJD3ZvmtfghlP9t+Rv+xZR1+xrhlBKhg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166585;
	bh=RYyh7nb6vY3KFaUyvdZ7cxAUVMyIhGZkbTbp0bSnaaQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BjGv7YTgITm9I/Ebst2Wurn4GcreWrzRONyBwOF/YLZlxrP/jMbUaLipfeFUzcuxv
	 pyEBCNh85uE9gjZEH8U7hFdiFkB4Ot77iRFyf9I68rh9kxMAO10Sd/j/GejsBlec/k
	 Zhi6yehS5GisFsMJ5ENOo+ymIfXtIOwvdlCRhDR6xOus3H5vhygZDQDHYGfEwUj3bM
	 XnQAqXDOXjoZDQstsaXVMvtSztl4cb2aWRK5IhbTodNTMtvtY3v7YgcV9wT5qbdr6t
	 tVn11DJai3lD9ISVvvodTQ5Cy6OMlhOqSAydKrDUQMzhKHqZjJvkpRtSq1utUI38Cp
	 +geJ0rdtjCjsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B892280BDB;
	Wed, 28 Oct 2026 05:49:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7964D2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AD784016B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aGTK1m6Cc7Zh for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:49:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2D5F04006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166583;
 b=GFKzb+OeCWFCyTVJUwmH5eKtEVv8Q09eeXoHL5fDgBfjgsPO9OmL7i2uDPmHi4j5ChZA
 PTuhQkk8O8tbmwbJBBIHeQuLzmvp+53BOjAKyPwKrn1dCfWosBcCrmL2UeulaRiKSJ+w9
 JyN98YeBSs6PSe/rQu5CEAi0t7oM9Q1C0mZU5eB0n0ndXiLRMjhWzQFsMgfxumoGMKcLi
 dS0BLzaGlgN5KhYwnGPm3RKTgTXHR9IeDlyV3cLcixZLYY6B4j7IUlHvvG6TCpMC0rXax
 RvXeGBXveCHgHIySs/ZBfFpVlz07T9J/J2uMb8XToah16PAt98Gntn2+Rd3gAbaLHTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166583;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=RYyh7nb6vY3KFaUyvdZ7cxAUVMyIhGZkbTbp0bSnaaQ=;
 b=W/cKp9WRtEYXEMbaZbO9cf1DpRM56mYat2K4ApsoODGPDlTxlm4bi0MmQlY4WVH58HX7
 575uOswRriPAfb5udy9+ZR1jD1SxKipAwx15D/dhU1VAqFRst+l6bNJY6e3WrfrEdM/zv
 b03VlCgIMYw50JEaAgu6+Ra+iLCWDL29TdD2sxkvRugdTIQ3Kredzfhx1x0rl4QAPwdSy
 02H/XAjc98m5QpmjBu4BM/JuqxAbWXGbWlNbKQuhIGHEw3b+zIeeI0PGpsWkbLdTAxGbs
 5S9Kido2Dk3QbMmO8PEQnQFTdCx9z4Jw+TZrQ6kno9whZfxniSA5g0ZJIwnDw48iLxQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=A1vOpvGg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=A1vOpvGg
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D5F04006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:49:42 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso2801825e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166580; x=1793771380;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RYyh7nb6vY3KFaUyvdZ7cxAUVMyIhGZkbTbp0bSnaaQ=;
 b=A1vOpvGgx0oOvsiIUoo8+ObRbJbjL0fa9nPpJFui70fBsyR6ok7FHR5AEAcPTZ/lmw
 YbWNcD++xKoNIOpxq0durK5iwru8BfW68IJLkJj+G2IT5s7lDnHs5Gj6DXeZXqP5wTiZ
 2zXEGMko/4E/xrSU/Y83vM850lDCLzoQYhSFfzjQCt5XRqjXiDJ0xc8hJx18bRvrERnb
 Vq0Z3KxZFJPe/gjJKFdfPXVOg57Y4A/+IgO3Juq1QziV2wkvsQoI54Cn4ZVg6+ULfX6B
 SHTv1X967xbNaxOrw3J48Zaq2dCy+k9GYSczxSEOG4FqFdKYvt174IeSsDjcJM1YCCXQ
 o6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166580; x=1793771380;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RYyh7nb6vY3KFaUyvdZ7cxAUVMyIhGZkbTbp0bSnaaQ=;
 b=hhbHvLOzn2go7o46lYP8SL66mDW6UJNWLkOay3j5MPOfxSQdHOL927mqGQdUQLgcoU
 /Z0YFhQgYnenG/H4uw9NeZdqf53Tc28iHVO1ajIronIT32a8nZW0Pe8DK9JdMatZ686n
 jX24ZhZCoKNNtvX/NH1eHHjkegSumiGtwdGzJ4PF3RXilGhYtip9bjppkrDYkc2p9JgB
 tAhBl9ROttyCy6wVdUou7n7vQD4B+biKi7a9jijOvwP1LMk4TcZMmHSJeMHF7kuUB7xu
 F/jXA47bp4PdJ3XGCN86UkosoRvFf1cg0nYrgxbIr8CfX2EgbmKRDL2SnYy3ZPd2XRqg
 zNbA==
X-Gm-Message-State: AFq9FYInbhppBygcCg+IkmXkagd4mmBjobf4ynpW8rgw4vXtRrW3yA5d
 z5eNBzn7t47ry4QZ8uil4BeMHG4Tql9dWYxvZDHH/+JKoPf/rQ9p91kxQzECy0dhtEc=
X-Gm-Gg: AYBFou2DG4wByuNOhMn6Qt+aQzK+qeDlZ4yhlGy/DTxdTaqx///5Av6k0bWpcwT3/qw
 1W3PNBAISIzX/6w6uW+EY32YtRCCBz9xWnajWyTp/IF8OkR1EHOkQa8St+fKaahFw84Uda1Yh84
 w7JGBuQiItYqflWe7+PjEweDVHyZpAOrB937dG5YLRXd21hVH9i9Rgb6mJXtFUmNbXPvwLCcKR9
 RFfgYV3D/ZoALCn5Y8h/ftttgcnGRetaMCMUDQZ3cPLllvH4WnjSvmmxS8fdTF6mMWVzbQYDNy3
 yWyByvPwnRIXalZnD6agyiqpZhwU1AuI+nX3SEq/sk6/9LOR/CwZ4y/OmyRN8YtXq/xtlr/gPHr
 dff5VuEYkB7Vsimh2kynpnHN7eI99wq52kHK999TcaskyCjt0khsYHkUA7/2nxotdS55FtOqQoz
 Rf5ITc38PdBBAuxbBc01u7bFhezxmP3Vb+O+qbtAaTifDoyY0SpzVV/IVQjPX4cKI9hDi5ERtjn
 R99OSOGehgJ/C1fGZQWJCy9BA1pBKGR4B3BdM0Om/QnSQ2Uz6QQ1B5I9792XUBL9iU1NJU3eKj8
 m0nQcnmDaoCRMlX0vz+slBZLOOOcCiA=
X-Received: by 2002:a05:600c:3b07:b0:4a1:f377:5c6c with SMTP id
 5b1f17b1804b1-4a9661ab5b3mr22020525e9.10.1793166580088; 
 Tue, 27 Oct 2026 22:49:40 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97cfb3da6sm19077595e9.14.2026.10.27.22.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:49:39 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/7] efi_loader: capsule: check sizes against the capsule
Date: Wed, 28 Oct 2026 05:49:37 +0000
Message-ID: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
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
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

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
image, so there it is hardening.

Patch 6 adds unit tests for patches 2-4, and patch 7 capsule on disk
tests for patches 1 and 5. Each test fails without the patch it covers,
except the one for patch 1: a capsule file shorter than its header is
usually rejected anyway, because the read past the end of its buffer
picks up heap data. Valgrind (CONFIG_VALGRIND) reports that read without
patch 1 and nothing with it. The FWU accept capsule check of patch 2 has
no test, as no sandbox configuration enables FWU_MULTI_BANK_UPDATE.

On an MbedTLS build a malformed certificate of valid length still
crashes sandbox in efi_signature_verify(), with or without this series:
pkcs7_parse_message() returns ERR_PTR() of an MbedTLS error code, which
IS_ERR() does not catch. Vsevolod Kozlov's "lib/mbedtls: Do not use
ERR_PTR with mbedTLS error values" fixes that.

CI: Azure build 13698 passed, all 91 jobs, with this series on
https://github.com/u-boot/u-boot/pull/1064, a CI-only pull request that
also carries my USB Ethernet rx, ext4 v2 and block size v2 series,
merged with main c267fa81d42:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13698

Changes in v2:
- Use size_t for item and item_count in patch 3 (Heinrich)
- Test a capsule header running past the end of the capsule in patch 6
- Add patch 7, capsule on disk tests for patches 1 and 5 (Heinrich)
- Add Ilias's Reviewed-by to patch 1
- Rebase on main

Ana Bobillo (7):
  efi_loader: capsule: check the size of a capsule file
  efi_loader: capsule: check the capsule header size
  efi_loader: capsule: check the FMP capsule against its size
  efi_loader: capsule: check the certificate length of an image
  efi_loader: firmware: check the FMP payload header size
  test: lib: add tests for the capsule size checks
  test: py: efi_capsule: test truncated capsules and FMP payload headers

 arch/sandbox/dts/sandbox_capsule.dtsi         |  52 +++++
 lib/efi_loader/efi_capsule.c                  |  64 ++++--
 lib/efi_loader/efi_firmware.c                 |  20 +-
 test/lib/Makefile                             |   1 +
 test/lib/efi_capsule.c                        | 212 ++++++++++++++++++
 .../test_capsule_firmware_raw.py              |  34 +++
 .../test_capsule_firmware_signed_raw.py       |  56 +++++
 7 files changed, 420 insertions(+), 19 deletions(-)
 create mode 100644 test/lib/efi_capsule.c


base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
