Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E507AC9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 07:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5953E40B08;
	Fri, 25 Sep 2026 07:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uEPRMWhSYGIY; Fri, 25 Sep 2026 07:24:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 45FC440A6D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790321096;
	b=fzvGf7F11h+TxER272S9XYo0lWONIr5YbztOWIqM2sfxzF6mKKPG3N5qFbgw+mJAtuuS
	 cl0vjG9VowZ61UVMtUoeAA/r6msPR4z8w5LXJkfMUPlAK5j9QarYXP4dHUfINXlk6NIVV
	 NYvjn3R7JjQkatlm5nSyOl6ZUSKEpLHGjrghzy6nGJHkanUtUZ3gudRksehVwWkJ4J9FQ
	 O2Tp5/xBpgwUF/nRXwjGdyQJAUEVBnq8axEIWLaEyW7sSNbgqLlobgaIwjdWPE9C9isp9
	 /bkGb7avZCfZ3R4I7iXNwKbft0kB9ctq/caJG/ULwLOEoB725FT22RdUFp0ZLCvkl/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790321096;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lV+m5ytJd8k1kDw71lKLcWNHjz7XgqbYpiWC4XVAhqE=;
	b=sNLgxsP5wg6HQ/UHEeSHfJcNniZ9ru1T+1t7y2pcPp1qargL0Cqwzu+zuOTM29b/ILPC
	 1/vZp061ZlHEuTXBm22+OuKhuKTsbq5PUs1121/VeSqw2I4ab4ndp+9X0fADzBNIPe2CU
	 TongpImW9uhnFZHhCONjhCIBm0sHfxSaMWCYtFAiQr3SbaRR7h3vH02UhxuzfxW6QZYJr
	 VLhn5cQ8gr51XqLNtsQITIgBtVZOLo57zrCAFy4Rc8PL4w1nI6DYCxhmCET3zoKtC7ONv
	 f8OUJs883q452EFf1wr4n0GoflCzzmNUScmDk18XwqW9bskc/nLrW0yqt6uGbIdugtw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790321096;
	bh=lV+m5ytJd8k1kDw71lKLcWNHjz7XgqbYpiWC4XVAhqE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wrgS7zfsvF+tdK8R1PNgd54ngMi/R79NbvbNoeeOzKR6DKd2KvUZ9JjBJ2Egb3IaX
	 1FBUIraD3wwFqfoZfn3/h8Ljdv/poGMth2LUK4EySDBN6i0Qs1BFFGGdU8PekMzSsr
	 b0s276i5ioaAGBc6mROn+TArh+GPBpBQaakE6OpiTzzkPH10LM95sMDSOH+6Bh3UNl
	 HxztXZMqBdqBZndSDVkOascKM8vvQ3BV4ScC9vFhTjK4wNSF98j2kGkdjcv8UXbKv9
	 zAYGm8JV2x/V4RHsSNDnUgsYFwYl9HR8XR5zUXwp6LZJfeIf3sRQZi/vKtuEAoyXcr
	 1pb4zDaZ0tKbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45FC440A6D;
	Fri, 25 Sep 2026 07:24:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 17F4F355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1C05811ED
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:24:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qLxyMh9vedGZ for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 07:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 13E65811D1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790321093;
 b=b5kiC11Vwv3F2/Y6wHSL8wp9BtG6y2e4SClXP6/Cm3a1FgoWZorrcsh7Encs9zKRN+ro
 35CnnffLUivPvs/ZPJLPnUdw2xUIMLPRd1TiaQJ26sYQxY+9eHzlT8UUMrJUCXdk8yVf5
 Xo2ajYP3SNg74bc9iNYjz3c1WY6vmPLFK7QCSEdgyhe8X2dS5uaSvMo5VcJ3ZU5Eb8ben
 WRO03YuEJWbMLed6sDcsPK8PonMcUdyQSpYuWtoynVwqJ8ZHluASVLbRRi3LEZU6wrr/S
 WD42V+ZZedNfNYH9Ceqw64rfPlcgbB2VbTNzreLKNLknK3jvk6hPX/4GUJoIYN0Txrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790321093;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=lV+m5ytJd8k1kDw71lKLcWNHjz7XgqbYpiWC4XVAhqE=;
 b=iEFumh5I8f2M05qy4jua9Iaevt53thDeswh/xd0hpS/OKBrhSoy+pWO2aKzV/4ltLGSw
 d8QPbvknuO6RogSrzAsWugpPC7xdySwkpEFm7WZsEDUjyEOq+jh2TIk7VBvL2ub2/XbtC
 zYeQDgj+cP97EAAdhT4xgQdyDZC18CKWT5l2PpmLThuEsBVAr6dnqbEK1SqGIItwuRKno
 +0ybaW1RuGu4TeZqkF0Mz4x4v0huNsH6kFmDzSMskOaMOEvG86kwniJsGrDK/jT4/FA6J
 F19deiFP8LmnG+vCWRT5HlSMYnvk+pN8tfetLutySwx3/NIN1clnYoUf9aFQgVBxoSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Y763Nff5; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Y763Nff5
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13E65811D1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:24:52 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so437087a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 00:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790321092; x=1790925892;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lV+m5ytJd8k1kDw71lKLcWNHjz7XgqbYpiWC4XVAhqE=;
 b=Y763Nff5o88i/s4N4suRaa2H5cu9R8ZQjxj9bI34aDltlnGjiTvnfJfLrcSkVdunS9
 q1s0RtnURItFBi7LOqljBl85fE0U6+9k4IB/9bh07ix2DsDe+P6k87rP9zH2DRlBYTz9
 1kA4bmPAWTP+9fp/ZMSH05I15m9ULI9H6TNa6owJY/UfAvmTRf2SJytJqQrT2G0c1Cql
 MhNfj0/d7lrAC4lCMaPdSQJVLx0eOuwfAoOI9lBo+raYy2As1a2/7JSAzkFCfV+LRfzS
 XTydCUJKqYYDpDZzLmjRp2kRZe8uZ+Y2QnoOF5KeDpGTAExJ14m3X3YnMIchIRAP68Ev
 iUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790321092; x=1790925892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lV+m5ytJd8k1kDw71lKLcWNHjz7XgqbYpiWC4XVAhqE=;
 b=ZxKg9ljo9mr8zSZ2bLPFiN3ucelaV3WwYE0ohwSCxcj3eZz0Vvzu/XvDRTkivi719z
 NPqZ7VvUpgJYYAs/kb6/3d3YfJniBPIlcZWWHx/UvXYCyse3F7UkpYCQfNdZJAuvksoC
 xfz5bEl4RlidDGoM6Tqy60grdtl2Im8ztr30aHmUjjOLSw/Elv9+kX/RtU7NLKpE4E9q
 XiwfDGxmwqNz0SWdWVrzZhKRrT915yTn5zh/+Hvl5n35i6MRdn5txVwaq8f32Y0ogXXQ
 4pkUbfFEHZBIOpuWxDa8jVEmcNHM6KVszMdhB9szHNEA1QW1XS4Q5atBsZJcz9fhUqIv
 kYWg==
X-Gm-Message-State: AFuF++leajwQfEeyN8uz0Qg3gJApIuqD+ov1B80tDoBcnyv0s2Hty3eA
 b8GoQl6Jr7am85Q8WIkinMikzG8DsJ3VJO4yXOA57sL0yakjlknXl54GRZFvacOe2Cg=
X-Gm-Gg: AYBFou1bVfj0j+9lXyPYvz4wLdm+BkIJzDEcXzRxWm+V1dGW4z11JLI4q3reG/vshPl
 Qk4/xQCd5w2E6EPyeBC903G+St5G6QquokaWI7Dw1UNi+MqXVmU5cF7klG1Rw09xkezp9OrMNPD
 hJwFTB2K39SY6Ae5JLPbPJ0KXl8ok+zmTa0/VJGdMe6/7pBt69T8xDOp8Ac0yUT4bJPrZRjJkvV
 iPDrhWyM4KgQygPG59bvMC8KN2WP0YzEZ72TOQ4v549wzRIBSBDTQ3KaB1UnQEXy3/ESOGDSeq+
 iN/ldLEHyE67BzfxcIyD4lVagjTGSK7hocKykqSWy1arbzXLvhpAh4oLJeFxuHlR4UvSjEF6SbO
 2lQK3JeKffK2818c69SinLMMHAiAmojdU1qVJW8xrhIeC00p8s5HIQnaXOrYlUKLUMLe2xtopCy
 zi17r6rTWYWRUYlVKscjnYRR7go8ELVKHAZ9dNEhmuM9XCTLUIPUrrPkFIQG52GErzcJSy2PVvd
 QIgsDSFSmq2aEKeWaUkMdzBAhTQWLyklpf+rsSnD0v+0NyctAw/qmHumLtGMPa9WhuG+vq6EDwh
 QtqYlG3SkiWfXfSE5ioIWFFGiEa1+CekTBr58EY39KZG6X0=
X-Received: by 2002:a17:90b:4b12:b0:39e:6c6a:4b78 with SMTP id
 98e67ed59e1d1-3a098e43c20mr4644614a91.66.1790321091850; 
 Fri, 25 Sep 2026 00:24:51 -0700 (PDT)
Received: from 0xiviel.ip (122-63-128-121.mobile.spark.co.nz. [122.63.128.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976cacbesm8904742a91.13.2026.09.25.00.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 00:24:51 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Eva Crystal <0xiviel@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH 0/2] image-fit-sig: close the image-signature fail-open gate
Date: Fri, 25 Sep 2026 19:27:39 +1200
Message-ID: <20260925072741.1966573-1-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

fit_image_verify_required_sigs() returns success when the U-Boot control
devicetree has no "/signature" node, so a FIT whose image signatures are
absent, malformed or invalid verifies anyway and the only indication is a
debug() call which a normal build compiles out. I reported this on the list
on 2026-09-07 as "[SECURITY] FIT signature enforcement fails open when the
control DTB has no /signature node".

Ludwig Nussel's "Improve FIT signature handling" closes the same fail-open
condition on the configuration gate with FIT_REQUIRE_CONFIG_SIGS. It does
not touch the image gate, which has its own early return in a different
function. This series adds the matching option for that gate,
FIT_REQUIRE_IMAGE_SIGS, along with SPL_FIT_REQUIRE_IMAGE_SIGS, both
defaulting to n, and a test/py case covering the missing-node path.

1/2 also raises the missing-node report from debug() to log_warning(), once
per boot. Ludwig's configuration gate deliberately keeps debug() after Jonas
Karlman pointed out that Rockchip enables FIT_SIGNATURE for image hash
integrity alone and has no "/signature" node by design. The commit message
of 1/2 explains why this gate diverges. Jonas is on Cc.

Based on next at 9e002445cd0d with Ludwig's v10 applied on top, following
Tom's request on the v9 thread on 2026-09-16, "Please make sure v10 is based
on the current next branch". v10 is at
https://lore.kernel.org/u-boot/20260923114940.349985-1-ludwig.nussel@siemens.com/
and its seven patches are listed as prerequisite-patch-id below. Note that
the series does not apply to main: v10 4/7 depends on f252d228be ("tools:
fit: sign all config image references"), which is on next only.

checkpatch warns on a 119-character line in patch 1; it is a verbatim
console transcript and re-wrapping it would misrepresent what the binary
printed.

Eva Crystal (2):
  image-fit-sig: fail when the control FDT has no /signature node
  test: vboot: add coverage for a control FDT with no /signature node

 boot/Kconfig                |  34 +++++++++++
 boot/image-fit-sig.c        |  15 ++++-
 test/py/tests/test_vboot.py | 109 ++++++++++++++++++++++++++++++++++++
 tools/mkimage.h             |   1 +
 4 files changed, 157 insertions(+), 2 deletions(-)


base-commit: 9e002445cd0d47d3965312f12e97a18e1ed8bd53
prerequisite-patch-id: 538dac9ee272034842d8a60d8df4f8b070018d33
prerequisite-patch-id: 5fa9f72555e76e6c88a57610b4c1d802408e1989
prerequisite-patch-id: e8d9d6c807dd9998e7f666dd283838e58ae54a7f
prerequisite-patch-id: 99c40b0d120a323d736144ed1e918d61076d3ddd
prerequisite-patch-id: 6089c7c67ff501e18182647ca27e5a111bbd5247
prerequisite-patch-id: c30e2a1afe9372416f5af90a2e6eff1a181e06af
prerequisite-patch-id: 1cdb386dab84419340acfea28362cb56e9a60cd4
-- 
2.53.0

