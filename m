Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E36EC98311
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 08:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BCC040DF9;
	Thu, 24 Sep 2026 08:59:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id un_-tuyUxCZE; Thu, 24 Sep 2026 08:59:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E40A40DFD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790240349;
	b=W9+1lFZpQwjqQXKqPd3ErukXyCS1XjsmtwvHG/eoJD5F+yDcW5dbd/6IT0G9mD2SMYeB
	 +Bv2VSNRQypAvaIxOzb0e6rHbSyDkuOh1KLTt2ScJODbMWRXsWZ+nQS0LH9jQAjJnoZix
	 iP0WcZEPGRoQMcawoCWAPO6kYkzgUB1OvInW+ZzV0DAdAXAZET207XR0FOAPnntxPrJWo
	 e+I4qCA0cDMdpVfBIv8GbvoyXT37EZV4b1kVliz3hleS6Gwq7H/GJilEq3k4EB3GDUkk3
	 Ojy2Vh7lLsBzZAs2poGK3OlamI5Gfo8WOWW8p/KfhyW1iIEYGtpwmH5kzjEC4V6FhGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790240349;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VEMyk8c9hV5JOveVTTnbYJLbdWk/BvJKGBTCwo1BSR8=;
	b=XV0v/aNZBySdkyG56yXs/sKKJrkPFkFR9ONx0BTeMWGGtC4AfMHMQgWsXaqTUwuI0IRU
	 0l/7DiZb9uW4RJOdAggkQ78vd9ydD6/pgIhJDb7xuh2mJcEa0af1zeYUdPQzyDSJ6nv9Z
	 0QPIlU95b6yAWmyC6JtdO8JYAgeUDOxbk+yOKL4z3wO6bMvxQd2f0kh4Nvvj2a+R/fqHY
	 bLUrtgUIJ3v/PL3SyR4/ZOpvnnOMN4hkSO3uvRd8t1+hrCwtzkBsrZmLDRWIP14cbH+7B
	 kKJBk65XydsEYjRA6BPk4O7j6Y9TEWnVlV/f4HAUpz/uAMk1YfsSHxY0aHkdyAwk74w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=nEfEi9x0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790240348;
	bh=VEMyk8c9hV5JOveVTTnbYJLbdWk/BvJKGBTCwo1BSR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lRzFNpCzaFrRvgByP5zPt0e5Y7Gf8jUpwRMTAcjsD+c0zYlbhpOWpE7wl/wssqA95
	 xubK0SdaadDyvmuv/yoOJ0j42xxZuQgEeVIMmoWJfG7nGhM+2gZi8FvcriPH4YBstx
	 lAPo2aQfev8rFVoy1JXGpbvio1qE4H0n/zSOP5AbuEgTeFvub1Bpmh6NFzlXkOftUQ
	 /g+SHs0uwOQ9FuJHOutb/TPLbfKxuQCtMFBdq4HFdgaL5CInRV3rjitpMLn8Ur/HsV
	 odx6FUZFx1ECUaUJl09NerACkcDBETCTDAYHYYcLHHwJj/XfcApuefj8IW8xRi+LUJ
	 kIuPd6Ngmp2KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E40A40DFD;
	Thu, 24 Sep 2026 08:59:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C607392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 827A340763
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5YARIvmAPg7 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 05:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CBC8D40853
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790229327;
 b=L/K+rUpxBH9LVGEzVzm1usNoFDxKiuwYVR2FAscGSz8w9ZTZUZpyKsCxc88z7jbgKy0i
 DUBGIprP/B/jY9EE0aOXqMR1dPAe1WtXgSk+WYRhIRTuw45s9RtklgHFxvxB2sItexknZ
 3jIVCe+8OUvrP1A2GqjpGaVqB7nL9fcTs06ps4RjcoOFyAisUE7JCO8bQjDqV7D32ysX9
 fq+lHjJ8vy+a+p7bl9YzgcE0xQPduQHRG7cwD2PTrVdUnEbRC9hId/Dla6j5rMgxtU/Ud
 ++T5e4qgnBcEMGsQseL00x1lKRTXeXlQYt+kFeZAC3QWgWRKKHthw+VEMBQ1dl3YJWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790229327;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=VEMyk8c9hV5JOveVTTnbYJLbdWk/BvJKGBTCwo1BSR8=;
 b=RBj0wqbJ5mrfFWUBJ79DGEF1aO4+GXZHqNnA/4KF6/XQXAJ8ig+vHImIYEnHxw4Ms5+v
 gLD5Wmav/XSEB5Bn5julHn5a88hOM0NULtdWpMInlJfksonETnPXocj7wD81GpRnt6Vfc
 OaIF9xpCFoQTcA348+ZFCsny/jetT+bwwYylo/f2VVY48fK7ZMO3wRIUtH3WdlDQT84ex
 qEpkJR5+2jYeDzeHRpEGo7e3qX0GrtoKVphiolg6nx7SRTwVb3/1rSX07gZhTm3baOINH
 V2TwVCpBb7v5UYx+IiiRW12o6CIOEf7QwT/5uP1IrNLLkYtLcbRPIyU+WaXtM5JGJBg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=nEfEi9x0; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=nEfEi9x0
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CBC8D40853
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:25 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D7AA3F51A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790229323;
 bh=VEMyk8c9hV5JOveVTTnbYJLbdWk/BvJKGBTCwo1BSR8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nEfEi9x0b4r1WTDJRsOt7oev8Eg0yOPZ3T9Uu4JBIDj/aIm6BwCNMPykG0NtsSXYh
 RPx2ZENDLeCRMZa6O4PZgGE6/Or7XQQnVa08pTr6aunH0ydkkJR696PRNKcOOouJSU
 6dZAxZRS7++BhQA/N///lviNzpZJuTcqPDJ+H7uccTCWSZ6Aurjsbi3bjJVMDI5Q5s
 /hQzPigC83hHGGexvm2oDfC0Cmr/5JAqdgpu0o1tslrCC1h8v3K7I3bKHKtvET7dn3
 H4BolDrk4ZiPsC+eAmY4KEd66/bGeuYWzr6v4jgbg4M+/iH3sVHIEiEroFxv3viLCW
 UKwFS6/WFsVeTLuvKakEI/4jM4clZ5lQj2MkwigZyUozJNv/KeXEUk9mLNxaxqhJBF
 kN/a/w6ma86qAObYecQzddTiIdSJv+qI//1eqzp1g8TUxoLThLjnEsHMAVw9hUHwB6
 1odtpKH3LrK7R/AGaNQCQxMrXi7ssGEIVmaECfKVGDI16YfHF3DC5DwJMgxwtMzArq
 vngMZDfy6hvdzUWB1Nt8JK1xFF4o014wrRWeZI9DU3o2cOiLfquj0z7Ei0shAL0tvh
 wuZ0tBG4R2GpZvjKSfmgnMwlXSt6Eml0ZHQyYURMHWjfGSryPop44yESzRWt82R/xW
 cLZpNtyIs1VhR+KQX/7H1kOg=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-396901263b6so1671077a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 22:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790229322; x=1790834122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VEMyk8c9hV5JOveVTTnbYJLbdWk/BvJKGBTCwo1BSR8=;
 b=cFRes2zJPAQtQXy49FlqoyC8DwhzxbRgUhu3C/vGKOsZS+Xrl4UoKzM87oXbPdSAVg
 uu1isvOCQtZrrxV5o0rzyzxBxcNXrE8miB64Af8cFFHlPqkbihI5vCMm5bbq7u7vsWa5
 r+n5Pl02C7SLp+B90PD0gfuVQu41IICASGsmvGwAHypW7eyuA0d+ER4aGum782S0TmIO
 6F1Z3CaNBUMaU5tNITg4FICxKAYTAZRAy+kUsbPHU54PDCcVNR7VkFuL4fZTJDHC3H+r
 0trUjPWxBL/HklgURLn51U5qSfK4YZhgi++WWn3j83zk1oClv7WcSEwcAb8sjhdWxnMH
 1nWg==
X-Gm-Message-State: AFuF++mjFEBTeH9YVJTJvoUXpjvZ8qSLgJZFl58dKIao6uLYFKVR5Nh4
 OFCXU4+8yuYMfnPF6wkRwHeP/Udp8NdW9P2NKs5p++EPw77la+V4Z8EsAqDOo3Cz7KFn6lAQ/xK
 M4zxWHNcbZnorGGfHuqn8leGP4HObBUgZghbJSeDmTDZX/WIKwiu0nZTCwYPDPRWaru93xP6PSK
 thPmQszoAGgwSvTKCImg==
X-Gm-Gg: AYBFou04Gw+TeP1a/7EXWauv0MSyNxsvbC+8+AND156M6KWa4zW6ofojFcwNOA5C7+R
 jqpWcb4DTfP2Uf8XwQeuPJiOZBFd6/u72ozMqTHkSJkOBC8iwcqSuv0+4aqoCR45yXBhR0tVwoJ
 u8VV6jqipbaEt/0ljAsNSaVFfXK57rS4bdODyjqjQBNla1C6MW4++JiheCFbwywZkYTuBOYsfAz
 4KiJbldIskvUgTB+RXjae5nu+s8MwKTHKuG07E92p7ySPMSi+Q9WrPE19JwKgxk1dhmcSlJHgK1
 +EmAHu+F9i0IdnELFDkaUtZJGKQGMK2NaxK5jNvImEyCfcInBKftefUGzRx48IdxntCXyEzt8SS
 QEHZokWohvDXSTJFSRYzIYdClkkqPl3mNskt1MgPx9Sebu+ty6TMxflleU9yehYkCoWS7nw==
X-Received: by 2002:a17:90b:1806:b0:3a0:309d:5549 with SMTP id
 98e67ed59e1d1-3a0985872cfmr1334721a91.8.1790229321854; 
 Wed, 23 Sep 2026 22:55:21 -0700 (PDT)
X-Received: by 2002:a17:90b:1806:b0:3a0:309d:5549 with SMTP id
 98e67ed59e1d1-3a0985872cfmr1334715a91.8.1790229321451; 
 Wed, 23 Sep 2026 22:55:21 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09733f48fsm2825829a91.11.2026.09.23.22.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 22:55:20 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/4] fit: use constants for property names in mkimage,
 boot and SPL
Date: Thu, 24 Sep 2026 05:54:48 +0000
Message-ID: <20260924055459.125648-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923154610.339153-1-aristo.chen@canonical.com>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 08:59:03 +0000
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

include/image.h defines constants for the FIT property and node names,
and most of the FIT code uses them, but mkimage, boot/ and the SPL FIT
loader still spell a few of the names out as string literals. This
series converts the remaining ones in those three areas: mkimage in
patches 1 and 2, boot/ in patch 3 and SPL in patch 4.

Most of the changes swap a literal for the matching constant. Two need
a word of explanation. fdt_property_file() in mkimage already takes the
property name as an argument but ignores it and hardcodes "data", so
patch 2 uses the argument; every caller passes FIT_DATA_PROP.
FIT_COMPAT_PROP was added for the compatible property of configuration
nodes by commit 3059eb0c27dd ("boot/fit: declare (and use) new constant
for conf's compatible prop"), which noted that the same property can
appear in FPGA image nodes but did not convert those. Patches 3 and 4
use FIT_COMPAT_PROP for the FPGA image node as well, in U-Boot proper
and in SPL.

No functional change is intended. Built for sandbox, sandbox_spl and
dra7xx_evm (U-Boot proper, SPL and host tools), the objects of all
touched files are identical before and after the series once debug
info is stripped and the embedded version string is held fixed. The
only exception is four __LINE__ values in boot/image-fit.c log calls,
which move down by one where patch 3 wraps a line. Each patch builds
for those three boards, and the sandbox FIT, vboot, mkimage and
dm-verity pytests pass.

The series is based on next, where the dm-verity code touched by patch
3 lives.

Link to v1:
https://lore.kernel.org/u-boot/20260923154610.339153-1-aristo.chen@canonical.com/

Changes in v2:
- Split v1 patch 1 in two, so that the fdt_property_file() change,
  which is not a plain constant swap, is a patch of its own (Quentin)
- No code changes; collected Quentin's Reviewed-by on all patches,
  carried over to both halves of the split patch

Aristo Chen (4):
  tools: mkimage: use FIT_ALGO_PROP for the signature algo property
  tools: mkimage: use the name argument in fdt_property_file()
  boot: fit: use constants for FIT property names
  spl: fit: use constants for FIT property names

 boot/boot_fit.c      |  4 ++--
 boot/image-board.c   |  3 ++-
 boot/image-fit.c     |  3 ++-
 common/spl/spl_fit.c | 12 ++++++------
 tools/fit_image.c    |  2 +-
 tools/image-host.c   |  3 ++-
 6 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.43.0

