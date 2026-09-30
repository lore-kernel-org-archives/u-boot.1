Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B48CA5FC1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF43F80EBA;
	Wed, 30 Sep 2026 17:46:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNWH8L2863uY; Wed, 30 Sep 2026 17:46:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 07011810B7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790790386;
	b=VBA+uiYwLGhAJGiGcmuKIQM8pD3MmT6psM6pd2h2Pv4gIfCf6LHgRFnILSzUaMJjdWPw
	 S38irCyTx3wKZTsn5avC28i0WJzhFRgu1M+GgVmNsi0lRuRa8/TW1xDpPOldi/+ZXRgv0
	 acAH/699f71h1EyXghIY695y22YQ7/S4kRzPvk3CrsHb5kkLfh9hnXxWfFrnsO/jkaMcJ
	 qEVsO8g+3ZhN4F1j8vPAtkrSKLNqZmr9Z2+kiHFIy/yX/d0G7JmHUhjQZUjx0cFUk0GYM
	 bUztugtqb2xOuJj0jG0HIJ1C8hDGUN6ZnTBl79p+KJUbfGaULqy0a0/UgfH0zE2ueqg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790790386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=k0GOdr7oLFBoLzJVprvOcKez/5An7D/0rHTGbd0EwCg=;
	b=eAP2gPvDMWPcXBX2JNqklZM0vjRLMRIQV+ddUhM3OejJvRzEAxIiBdCuq9RQh6VnAN0p
	 3fhNzxuT0t8EAc8Tf71PSn+BN1puc5eohtPnoxLy5buYJHhqwYWRhwGTGdTE4LjLUaizJ
	 MS4gbGpnMKL3L0VeUMAI1KlH3Q29HdibFpdeTFaVIQdXrKKyc57uhGsaNNjknPYvskx2a
	 IGgUGi4eb03IP4sygIpqi/6ADC2f1tFtnc/3i74x5f/CZqqVAu26ttljK6ID5CwrAKUFK
	 EQDrQA13zkBBoe/8tOlYu0464tb7eLevbyTReTEar9q72gf1Ofghn7q/eiwCQ580fQQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790790386;
	bh=k0GOdr7oLFBoLzJVprvOcKez/5An7D/0rHTGbd0EwCg=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ApP9oZWXvhTRSkLXT+owEu7nk0x7M6MAfSgfQ5JpvduvDjIrf0ezMOY3noHMILyhQ
	 sm48nSYPHsJzHt/FPSYW3qzNY9uaSw/y6P0/diXsLSiF0CsQp8pqEmgGG2XetbcUFB
	 zh5hW/ThrzN44zGbk0a2FgUpi9pVFAS9QxmmQOh6eYzsaBdcFPPsW/UBiGfEy0Yip2
	 DFBjHxi1ZDaayaHkTKBk33zpx62IFrfzDSdrYxQ6bK87Norm+OPkJ3ynGu4SBrowVC
	 Z0kGhRxlSj5zLAs7f4muI1IDD8c0v0PvI7jZDBHQHRqwrPxn744YsMr9GnYU1vQxrd
	 cCDciw6uJukLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07011810B7;
	Wed, 30 Sep 2026 17:46:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 82F1714C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 749F140ABD
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QXvZM6_11x4f for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:46:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 64C2B4086C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790790383;
 b=n8pFhoTB+uZOSvBdJbEtk5A0S25GS6wZ8mJybdlK/fcQSE4UNOk7t++qLFEcRfxcXfI+
 bXEustTNExRDyM0bscVBKvARSLpsQnB2hHBEFMsFYCYjR6ROpUK9L8ILIFnNuBvCZ4nVw
 zDMKuL2HvgKTLxHJS1wVnEddkEzU+ZsGBJujdzkFXlypdnq9Q38P++nfVBZTZuQAVgLMT
 5neALRavOsR4xVhKxJu/yVhmINXFB9nFHH053+aHCac7euOLZmjMxWSpeTTsHt9ilEr4J
 kaKpb/d9mHjSRrjdgODP/49uEGvGdJj9qK9xEiJZXLhAP2H6egdRo2eZnhA2vPiwwMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790790383;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
 bh=k0GOdr7oLFBoLzJVprvOcKez/5An7D/0rHTGbd0EwCg=;
 b=j61RoQr/ygrnvCmQNTqUiMn8uovzb3aQGEZjRQ1msIgMY+M15GKNckwcuUzutCrLL8gC
 LHFoLcnVGpZTGXCDY1Bp382PR4X761fRBQya9irGSMPlqqqIVaZqrduUl8oQuEFA28hJ0
 sXJYViFxka6xUzJm4IeU23e6eQ0NQ1gnYFC/5uEfK47ICyuAUIOiDy7G9smpHbThLCrJ8
 chN0iu4GglRMpstme8N/h94T9+P14j6SVHD/me1gYqaUHg3p6smrPb9QxmDt5Kxoz5r/o
 1bxZBD2JqABJzqFtQ3DYORDFzwnQhDWKbx1JdjFce7LMPGB7bv7ZS9/r9TemlU8vrWg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MX9Vo+QN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MX9Vo+QN
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64C2B4086C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:46:21 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2e17363b97so182809566b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790790380; cv=none;
 d=google.com; s=arc-20260327;
 b=GQFH9LEY/d+5tC0OeNyUBFroufjeIOXlgLOO6TOLOlXsyxlJb9GuwSFDRAStKwb5K0
 V4edjAN1UtSiIb3RLuvJ0O0hBVB1cNUH+GjCVgFePaLiLepFOBk/7IN8qLRv5J8jORvY
 wWKTDxT3B+6pAixS9FVBdL//yxVotsBbO8nE7ED7ZKc++0TM16cBfZyYH3AycHeTU6PZ
 +z4Q2+rLhv+8zJ3/HlPutyF1MkB5giZlvMh+e5kaH76ZRGDy5+v8PURILDeNmvgpBBrE
 m1tgwWWpKSaJtSt0Cr6QQWBUjJxrdC7ZpEUdTq3qmXlBdFM/eM6khdDkjDfo89sm/zru
 vGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=k0GOdr7oLFBoLzJVprvOcKez/5An7D/0rHTGbd0EwCg=;
 fh=k6xPnGHBdclR8VQUQhxzMkG582Pw/zvu1Ix0zA0WlPA=;
 b=Qh34DBAH+onM9dPRibT0rd+n20akN1bnin5LCA2FgUTZKMUzUTYkh0edZX5SrdCM8r
 2FErogvJWEnupeTLtTOJdIL+XU7Yr7Zx1XRyR3ouCdf7F3x524E6RlNcJ3jeVwmPBlFM
 Lm/l/xHEJ5ItgJJLK7emMvJyTd0yKMGourYyXDHwb8ffeDjlZxRY8jOpdDkg3qtC+7XQ
 x3uPAh/nDOrpyQmUj33TAKLQjoaaYSCfpIn+G6gKpxIRHfRC+o6Yfb0bh3x/GoEESqSY
 z5O61OjOwMw14ILmEpvsaDwftrDbDa+UMoUJyIfdS27tIobaGAOhWgOm4fO0k0CnirwJ
 d4yA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790790380; x=1791395180;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k0GOdr7oLFBoLzJVprvOcKez/5An7D/0rHTGbd0EwCg=;
 b=MX9Vo+QNEz1GjvR47DJB05BCYU+uqs+UICwRgIWpBCwoymcCdgxjnQW1oUPxaOyP4n
 62L9pMRvceW+3e9TXrG5VmiUOXwil+SheWaZZzU++Rm7ln3nyLswb15VGk6Sc+eaPOMb
 aCJBuuiO01hpl16y2QD87yTi9u4r4wceDwBmxKL/5jEg2yx91Ay9XzRTc2IZpI8ZqVPD
 Dw6c/sFqArb7iiKVRJYjSk0LyQ7ATYaHGZEYILt+8VsIKr3RMP0nJ44yRLhCp6VhDoYk
 P04CPcqfAM0X8LxD/6Ca+pmhxEg0YTKC6u5LQMEaG5EvLIxZmB6owmHOqx4ehBfSpPCf
 KRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790380; x=1791395180;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k0GOdr7oLFBoLzJVprvOcKez/5An7D/0rHTGbd0EwCg=;
 b=VpHbE2nRZlZOfT+taUnvlJJqSsLHX6HB6DbFhGzkUwSIb4dEOIxy8XkvCKFsofy1lQ
 33unDQUnAKW68sOhPbh9+88du4PowNXQFdaAV+S+SaSV265PjN1neS1ex9/HaQG/tFbF
 70m+t/93nbhbHDeNF1zt/FlvFPFs8ycIubMUYnGLivfmXXTcd0LzYi+2z65T9DNAx6kh
 sjwe757z9IINXDA47lMQYzIBQf395DrKZozbeANCxnr/7s0zO4Yy99WoMwwvV6jevYWu
 lIB1L6gidFsDCOM/6Qj/MwlTjaIRReVoZjmAoMYaABpcXuMP8Fb5kLPY68V+uoKLyBWc
 OXEg==
X-Gm-Message-State: AFuF++nxu7vVuHDijhsqMD49hS++rTsxDXujx+S4WBVaVX0wHl8xj20C
 ZdHEdurk+oDy2mN46LIIWN8yYQz9HhivfgJqBlR4J7ms6NsJTjBqPoZFoqv7Mb78HqJUJ1pK+mZ
 561VsGHkhbG22TlBFwt1l27BijgXmxXIAfFKe
X-Gm-Gg: AYBFou0dO8ymkKnqeUQFtrUV92A/Eh7qGzgJeeBggfjliYFH1VS4a1vUrScu0Pwnozo
 7XRMBXdv7Jtbqo2Ki+lq1OnxOFQ+AzUamTreCc20BD1tCeAla7LKcXp/Q//93WuDDlqlITjdB4u
 36e4wHsLajh9YPpPN37rtcxh2c0OUQ0mx3sC+jL7Bla3UqLI3h0zh3CDdcMAGi7EV/DGNfKJVps
 UlG/LA0UYgwmZVF9nUxWj1ELP7he/+hsg8DNsUu3eD+RMLTyw84EtBHzgXi1KDDadjvfaNEWyDR
 PnkaqhqOEXdiTUSgADtefW+VutDGdXpcCJVSmnZc5O4aC2mvahFr+jbhGXu5yIIgiNs=
X-Received: by 2002:a17:907:ca85:b0:c29:45f6:6a0b with SMTP id
 a640c23a62f3a-c2e23dfb7a6mr207408366b.34.1790790379537; Wed, 30 Sep 2026
 10:46:19 -0700 (PDT)
MIME-Version: 1.0
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 30 Sep 2026 19:46:08 +0200
X-Gm-Features: AclHuK8nKFHlyuhpbnvvkLRIxABnidNTW77NW58CywfUkeVtFBWNihL2d0yW4c0
Message-ID: <CAC928HYhgVNM9BwpJJ821PWpZuR2gCKZisuQK4exKSCG42AO3g@mail.gmail.com>
Subject: [RFC] XPL linker scripts and related Kconfig options questions
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I'm going to send a patch to fix arch/arm/cpu/armv8/u-boot-spl.lds linker
script, making it honor the TPL_SEPARATE_BSS value and not the SPL_SEPARATE_BSS
one within TPL builds (quite trivial). In the meanwhile, I would like feedback
on some doubts I have, starting with the comment that stated to use "#ifdef
[CONFIG_SPL_SEPARATE_BSS] to avoid using CONFIG_SPL_BSS_START_ADDR which is
not valid in this case" in commit:

a3403e6fbf8 ("armv8: Support not having separate BSS")

First of all, I've noticed that there are several linker scripts using
SPL_BSS_START_ADDR without any guard. Second, the Kconfig guard for
SPL_BSS_START_ADDR is SPL_HAS_BSS_LINKER_SECTION.

Therefore, wouldn't it make sense to have the Kconfig default value for
SPL_LDSCRIPT pointing to these linker scripts if and only if
SPL_HAS_BSS_LINKER_SECTION is selected?

Moreover, I would expect all architectures relying on these default linker
scripts to have at least 'imply' SPL_HAS_BSS_LINKER_SECTION under their own
'config' ARCH_XXX section. But I found it just for ARCH_SNAPDRAGON.

ARCH_ROCKCHIP has a second 'config' statement for SPL_HAS_BSS_LINKER_SECTION
and for SPL_BSS_START_ADDR too, the latter losing its dependency from the first:
unselecting SPL_HAS_BSS_LINKER_SECTION does not make SPL_BSS_START_ADDR
undefined anymore, which does not sound very good.

Another point is related to the relationship between SPL_HAS_BSS_LINKER_SECTION
and SPL_SEPARATE_BSS: looking at armv8/u-boot-spl.lds SPL_SEPARATE_BSS makes
sense to be defined if and only if SPL_BSS_START_ADDR exists and therefore
SPL_HAS_BSS_LINKER_SECTION is defined. Is this always true? If it is true,
shouldn't we have a 'depends on' SPL_HAS_BSS_LINKER_SECTION under 'config'
SPL_SEPARATE_BSS?

Third: TPL_SEPARATE_BSS exists but TPL_HAS_BSS_LINKER_SECTION TPL_BSS_START_ADDR
etc. do not, even if armv8/u-boot-spl.lds is the default value for TPL_LDSCRIPT,
therefore it would be used to build TPL too. Do these TPL config options need to
be created (maybe with defaults equal to SPL ones), or are there no real use
cases where SPL and TPL need different values? In the latter case, I would
prefer to rename these 'common' SPL_XXX config options as XPL_XXX to underline
that they are common to all XPL builds and not SPL specific only. My cases are
without TPL_SEPARATE_BSS, thus I do not care.

I would also rename all linker scripts not used solely for SPL as u-boot-xpl.lds
instead of u-boot-spl.lds, as before, for the same reason.

For SPL_BSS_MAX_SIZE/SPL_BSS_LIMIT the situation is similar to that one of
SPL_BSS_START_ADDR/SPL_HAS_BSS_LINKER_SECTION described.

We maybe can drop IMAGE_TEXT_BASE and IMAGE_MAX_SIZE definitions appended to
LDPPFLAGS in scripts/Makefile.xpl and use CONFIG_VAL(TEXT_BASE) and
CONFIG_VAL(MAX_SIZE) in the linker scripts.

Thanks for your support.
Regards,
Massimo
