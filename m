Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA8BC624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1ABF60B75;
	Thu,  3 Sep 2026 14:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U085EiBB-oZ0; Thu,  3 Sep 2026 14:51:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3C5D260B6E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788447093;
	b=gL9z6q9dDdQaoslOg+1FcGdooOtGNjtJP0csxjx+1GrZPFjZey8q1uvILWywNlxZocia
	 eYV83KC8aUUSc7k+/n801tLR9SMD8w3HMHPRgGE2RjVx1I2OIAEmYKPAYoakLuqy3K0XG
	 aEZi78MhPYRzo2DDsWsms9F65VSX/BlN3ZnBaBnrqOqh9g+Ks4YzLH/3/Kuv9BDCOQ419
	 tyY8KjtztNbDP1/3KQuJcFQnWlY43lWX9ozRMKlpymRQKI9+0RvfLuFEk/qXarXMOcWf2
	 25i8U66kMqJFvg8HKl+Cl53OGhc3oQO5Xqk1eQ/nQjC2XRJGbRVhRaXo/FFprfsLrLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788447093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=an8TqTYo6Wct8AqRENIcconUJESp+h7hw3+kCEGEMWQ=;
	b=s9GpQN2GkTssgpTO1gjYnF5ShR9+/lD89ncNSpPTeqAeaZjKLRmEOQnBL76D/MO9vMYm
	 IDc8fgPEIYvZ+zX9fbdfbk3bmp8RJ1ZmTstGI20QBg7/rt9LNUqGCeovIGWkWI9AQHsXI
	 dNBxBI+PVcc6nEF5zE27fF7QjqYNrMLp8xutiRjeIKkKoErwC7b1/UyLAWXihtSN6EeeF
	 O/+p6MLjgQKgQjxLXt1LNvNM2jy7ULq5Yuo8xTEGlG8rw0W1WmJrhaNGpmAPhveWgOgth
	 6FjuDLk6vL9LUBDqek5ogmTpYgLB2Rs3qJqYk+MhLAv7SyT+KdOXQSKoxbi1Nxf7u4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=gN+FRtrv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788447093;
	bh=an8TqTYo6Wct8AqRENIcconUJESp+h7hw3+kCEGEMWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aoTgukI17OeaNrojs/FAXhb9RzLIKEEfc29I6D1dmwTXRAwtVMh4i1yqNIo966O6u
	 Qza+MxvRbz10fiLHB4lBkkbG1LCD+h6/LLfTjNtv9DhzehrqaC5DYyhFR1yvjcNeDd
	 gpR/KuahQ7oJeMOyqHGnT1ioDfiKJZTAhPBBiiTMZEdUJG3qlMN/Nuhp7kOb8Q6Er8
	 zSpg+TLhLaMBJ8c3HI68xuY40tGxRgX+MJnFqMlRSA1t9m25h43rBpjc/56iXZ5CrC
	 TK45LfHb+u5yJF8N37VeLHn/KLQUK0ysbcF+6AlBCgpeNsb70kVMlHF3qGTYaETOlq
	 TUXemAZRdN9GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C5D260B6E;
	Thu,  3 Sep 2026 14:51:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 887B934E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A11E60B6B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNNR8KwZM9ck for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:48:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1E46260B64
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788446917;
 b=lT4RrMkB2/JI8+PwLcA5C6cKP2W3kOKyCyiRZ9eKF0zWoP0WNZvvQLgr2A+5vB9r9MTZ
 sjH9S1XznUfs5Ci4fHmGD3G4OZpHFl06zve7rpBzbj1Jvfhsu+y6Ywz1FQ7UxcVe0xf3Y
 9jkdPRW3vKsNUD+IzFg4amsE4DxrYmtPcFdtLBSAjjSxGF4ig1VL8ZcyfheLVwXoJBtpN
 E3R5gYTMSkMJwgWPYsjdun2Z/pTxJL8B2Li6GlndpXWPSKNGjVFfBWtPkeaUdKN8p09Dq
 7OH8c4VCtX44ap6XPC1zqutrIsbmQhI76gVsoWVcKFmSmWvoGLmZMo3ZxuBb63JtU0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446917;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=an8TqTYo6Wct8AqRENIcconUJESp+h7hw3+kCEGEMWQ=;
 b=e62lPTW+CPCt8Tzp2/+YQ87RxBRip0fwiMG4EOA+4vGk9tHYvC1bXvyfs2pd+z+9YPnW
 74XC4NzGz6UkKkGRl2T9HDkCGbMxwH501lbaPSKCdOOYVZaOCFYPdpCPjb97c4u4yJXHp
 AVuDjnplbsWUKK9vYHibouASkHxOTE0JsJV1grxYrpiGP7w84eADYUIgqYf+wd/xpHSpO
 qdOixxHA7bG3NXu1kGmII4QynSi1BCL6veXH3z3UJw2wyU/sqX6HRAMu6N+BETTBxT2sT
 p/CZ1IX+tX88ISiprwbjcyVZS/44RCUQ57p+hAweTgD24O7ZvGIceiGeD+dx9FB+3Cg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=gN+FRtrv; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=gN+FRtrv
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E46260B64
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:36 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 14FD94293E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788446914;
 bh=an8TqTYo6Wct8AqRENIcconUJESp+h7hw3+kCEGEMWQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gN+FRtrvsJLSHLrr4Gd2e1Bu8cRojO3LIxit6R7vp+rAf5tMchUpSV9Dcl6doQ/Xk
 hinD1L1ZJ0ZqsNOfUSpKyHoRXdMuIY8joKQI3pvZ7DlcMB6sOdIsMNjg/19RupO5i0
 kKKTSmBGZW30ycKx78C2iyzt+WVPqFY7ILuU8SAO3V1AT0XbwtBz41DEWcxd6H4E/F
 rQZf9xDobToznbVSU676T5JmzllHHUkQvX2vBN9I5b3XSfF76HIWbCeKw8VT4RMAHc
 V6xte0jj9//WSrJIXxs5aJGo7y2xsjAImsU7zbBG7DkUpkM59pOfCx9palaIWtUJGj
 XMmMwYY5mI4dAaTc2bhsbDwcItTeURuDGALlAsUMPrtzpPx7v3AHOBvcb5FeYeft64
 zldckg9s+jVO0QBWIiTGKDhi7n6811wlg8LYvUQ32mMUClTIeSHiz3ZFrGZWIa5oZu
 LkajOK8Tcbo+KAV4dK1lt83XM0HrX/DbjTDKmItxEcAZ5sUdIX3WUlXbjJjBdgiTO6
 gJjr8yeI1BEK0TyW/vJlkTp6H5WNjoPAS+pnRD63LNgbUzmC83I6SSUgBITIAgMGKh
 3iyEzQlkCowPttgQxSMtIwArktzwCxWtKev62PPoqDBGDgJTzZGiAUE6WGjk8SwLom
 kLrgDwjpjN+yY39gOdc3VoYM=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so1244397a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446912; x=1789051712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=an8TqTYo6Wct8AqRENIcconUJESp+h7hw3+kCEGEMWQ=;
 b=SdVbrYnGgVUpTYKj6bn7A6hGgxFDume/0MagK2zGT/q6IQGK0VCmhrHqoeME8fpIa0
 /Q6zttWt1dOSEu9bOJbnU3u1i2YAz8Q2CEypQDj91DiO5arzuuf9n6pXbMqE/aOZdT89
 u71uRtQObfwZ544bruTzp3dxGXBSJDnf9Se4CiX3ZuXvz6uaRMJjVXufln9Kkk3XVKPb
 6l+pbkovo9KlLw/z2H5ghGh8jgF4Mo71CskkkvPyNA3UyJmHNw2cYDm3y0MmdjowzkUV
 F8ahV8d9WOiNIiWx2bjqbjsBK96MQ16z8FjA/rPvE14B4QgKXQ5UmX1ZIgo5nRgjK8ln
 sj5A==
X-Gm-Message-State: AFuF++la8YkNvMO04/hkqvw3DUyvkkx2LncVGWgrR5OYir6OsSNoNcFm
 2oNmTn/Mi9t49telOiYtN3U/78j1mpLR7C4MUGZ8IEsa6TV4C6ieB0bKEIqYGsXiIv98itm8Nyq
 4w9yzJAY/b2kIKlJUnPbHj/91MrQgsEvC53fjVzPBEU76pjazgq6lWu9lY/FIvmjbhTIjTlvBMd
 JqBhjVF13WD7hkgykxng==
X-Gm-Gg: AYBFou2B6HnJH5XhH4Jj5rcxjqTYYVdfxpqtadFT7sojY1w2EadNpx3QLn2xUW+FNi2
 5PyDMBPOLYP1Egu4cQsGmbKUfj5VNTuPr92FcwVq210gMzMVksy2RQui5VeTdZ2itdXiVVF4QRs
 Dh8oDBTEqN4kVqQvsYeES9jcAYi/dtqlE4WULPlrNKNoq+IkiJ20ZaGTOkAO5BEKeV9BowVzLqn
 4LafLodzBObCnkisOobhVLJXCfwxGLyL7elHLtNKNcObJa9bZOgJiPGhIzhVj7bF/cJcd/RuLCj
 tqvXTElUmmHvf+tkmyE+ee9CM1frOyDJPHwHT5y/BKXJiwA9bP0EYiLUvdoazrhQwI88oyvfT29
 HJDMoQKFHugINiV9uu/BdH2nrM5z6VVpzsSv7TE450kCUgeXeP3CUMnBtlBAJriy4bUWZkQ==
X-Received: by 2002:a17:90b:50cb:b0:398:baa7:4c2f with SMTP id
 98e67ed59e1d1-39b13222d5dmr3425023a91.5.1788446912178; 
 Thu, 03 Sep 2026 07:48:32 -0700 (PDT)
X-Received: by 2002:a17:90b:50cb:b0:398:baa7:4c2f with SMTP id
 98e67ed59e1d1-39b13222d5dmr3424993a91.5.1788446911708; 
 Thu, 03 Sep 2026 07:48:31 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08ce4221sm7051971a91.14.2026.09.03.07.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:48:30 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/2] bootmeth: efi_mgr: Report EFI boot manager failures to
 bootflow
Date: Thu,  3 Sep 2026 14:48:12 +0000
Message-ID: <20260903144817.9666-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811155940.17698-1-aristo.chen@canonical.com>
References: <20260811155940.17698-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 14:51:32 +0000
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

When the EFI boot manager fails, efi_mgr_boot() assigns the status
returned by efi_bootmgr_run() to a local variable and then returns 0.
A zero return from a bootmeth's boot() method means "should not get
here", so bootflow_boot() reports -EFAULT for every boot manager
failure and the real cause (no boot option loadable, load error, ...)
is lost. The unused assignment also trips -Wunused-but-set-variable
on newer compilers.

Patch 1 maps the EFI status to an errno instead: EFI_NOT_FOUND (no
BootOrder) becomes -ENOENT and any other failure -EIO, so 'bootflow
boot' now prints an error that reflects what actually happened.

Patch 2 adds a bootstd test for the error path, which was previously
unreachable from any test: it binds the efi_mgr bootmeth, removes the
BootOrder variable so that the boot manager has nothing to load and
checks that booting the bootflow returns -ENOENT rather than -EFAULT.
Running the real boot manager initialises the EFI subsystem in the
sandbox process, which would leak into later tests, so the test is also
added to the restart list in test_ut.py like the other session-changing
tests.

Tested on sandbox: the new test fails with -EFAULT before patch 1 and
passes after it, and the full bootstd suite passes at each commit. The
test also passes with Heinrich's "cmd/efidebug: do not allow invalid
boot order" applied on top.

Changes in v2:
- Remove BootOrder in the test instead of pointing it at a non-existent
  load option, which relied on efidebug accepting invalid input
  (Heinrich)

Aristo Chen (2):
  bootmeth: efi_mgr: Do not discard the EFI boot manager error
  test: boot: Check that efi_mgr boot failures are reported

 boot/bootmeth_efi_mgr.c  |  5 ++++-
 test/boot/bootflow.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py |  3 ++-
 3 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.43.0

