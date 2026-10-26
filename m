Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E20606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qovYlptz;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=snO/PMsd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B4098078C;
	Mon, 26 Oct 2026 12:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JSTp3r-A7oSO; Mon, 26 Oct 2026 12:28:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 410B0808AF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793017722;
	b=ePgTTa0t9Z0XKvHwiLt22Fr4rL437NCoTCe/q5ayZ4+xnlUG02mA4KmMhh4xaEzzZV0o
	 rUhvD8BkvEq5T5prOjCjWiSb3W0MPJCftm0u+/isDaLL+q503Pecw99ZCnZMdgbq2r7Tn
	 1iDb6XcXTeeE+9vWMCDhbCV9RAUNRAJvbQ36PzTmx1PntwEkJwTwjWZfHWsYcQxy5pLia
	 f6EfzcoZfxNZgR2N8jUAirQEpZyELYuhlxaLQqFpiWbE/9YmXG9RhK4cEPm5U+f9K+P0C
	 GTnwtgmDm2CAA2C+nBVP8XUNDmAboyFUBmMsb+TDw9qNMgNqC3vJkMXnvbsOTT0UPiQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793017722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zprZum4SDGiZePDKPT2yP98xnYfbSeQYTmGGNNDCijQ=;
	b=bFYzhFyWNic8c6C2Dk/5n8Q+LC1zdbeRfxt+qqgjwAZJj7d94aW1hPqmmHxx0A+7DIIt
	 PQdVmRELf5OmIo1S8B4Cwq23vnZtEuInB6S4ctoOpeYBAyRzI6CSl3C70DfhVlslnMeei
	 1gbOI02O68SD/MZ8a6JNU8xbo4N9887DcRfNMAc07Jq2dH7h7DYnGNkBc3b3kdgD3FNpK
	 dBbW8ZfgFUJs8VFGowlnuAKh1J0FK8D9xIDWpDepi4u1S/rDUh3BgagmnPV1CM5jhZljE
	 qnWQypI2ooJC4JuiJqn1wUBH4UKOTvIOIlEkmmuxFvWsdTogRAPvVdZsMeXw4cpJsWQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793017722;
	bh=zprZum4SDGiZePDKPT2yP98xnYfbSeQYTmGGNNDCijQ=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qovYlptzLKMVxhT0efqJQyE1EdxGedeuvjrvdQnpi7LmfgG0xdk0rQ7X15p+tCBL1
	 YLKbKugiJwJUCPp6SDygbrVuMqC/+MTwhkPjQ8xdaqwjLAcVKFpc2SGr4lhOcDw9pS
	 m7mJQYweYOBzuc9RB/3p0cq8atLCTgZQQQMyB9enGsZc/PGvzz8xVwc5geCU8Bkck5
	 CuIf1z+b7zab5UYbic691yLHJYGoD1MXrHjpLN0smBACq8t8UJNh0GM+/7YN15i+el
	 LfZGyX6hC8emTHTvklKPN3LqMKH3Oeh2UIK6HEbDSNXRzyZXamu59WdwmbZmbs4rpK
	 KS+g/hfrDGZ6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 410B0808AF;
	Mon, 26 Oct 2026 12:28:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33F383D9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A2B6405F6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OjCWdXUKvsHe for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:28:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4EB3B405EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793017720;
 b=XwebxprDZeNMLFXPyB3k2bWwGd5bVO8wSdOIXgLaGzwzYcgirR1LVwiD8QmOcyic2PxK
 0N+MHJDbyJeuvBv0rMOXOpzR75UHVXdDOZLbUbm8mo6JoGfspsja/474zI5tBkOPrMWRv
 WCQn6D7d5NRS3AVCzlQW3WAMpF5uX1WALDBjDL9XqrWZDT/x5ObiujsSnTB7z4l7FtrbL
 3qNRIhoqoLn3DZJvPoaX5wdM5pyByzaOR7Owdrwo50yGltnLgZpHy7Vt/F+mgQnWtGIfB
 /W76eYDHBvDJn42eXBSpwiZS1GZ63uHpgaQAAS/r4dkmSS1sOUgxsIbjJXwkIUXhQpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793017720;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Content-Type;
 bh=zprZum4SDGiZePDKPT2yP98xnYfbSeQYTmGGNNDCijQ=;
 b=OEEI2KS91hicOF6/T5urMavpuVqBs9KtYNZKqwXNwylKlDtaQGJRM9ClDGobilqn4GtV
 HCyYr93humukSVdKya7XW03lTCIHn82xADS/xy2n3SYhl3Br7yOYGZzig/LgZ3Yf6yFgp
 k5FDAIVIHF3I5c5EDuQKHAphuoJ07w1AQCzoaia6MdKUZX1UeF5KU1Y/Bu8B4vl+r8V+j
 miDI0kBcuSCgU5AyCoDDQszBUAWrl6Rui/06zImDm/8QWWzwUJxdRc1RLpM/0sEesC9t/
 ptz1mpDaV68Eyjp5S/oI2QOdFk97iwRi4d9+ddSu/OMk32PpIrHlDpQU7RHy/XjzSzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="snO/PMsd"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com;
 envelope-from=pbiel7@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=snO/PMsd
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EB3B405EE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:28:39 +0000 (UTC)
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso8645523eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793017719; cv=none;
 d=google.com; s=arc-20260327;
 b=anX4adZ1k1vQ/H10b01BubRMzQqM1YyTGE/0Zy84ZGxkoSJYTpUgPUI5kRzmU1nQ5w
 A8IOvfPxfnjYSeWbYA3ly3UFfzy1hDk5QwYHjJbH6Yv9YcVqK9SwKlrPntinC4iOKbCb
 3Z5bFw2jic9HDL8Le+GsEFktVf30qIizQdZc3tEoBpU7o5tDMEgybGPXG1uTYepXDzpB
 btLreaFU2mAGheKu9fzVzOdJjU0C9pN9YsH3tpGxM7OzkZx84G71JlTfP5E/1zqQmXv4
 p0bzmWxodNf1yMhy67CIyr1BEsw17kzkAz7pQNpwe1mQoS7g2uG9xe5cqZyxqVZuPrqX
 Mr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=zprZum4SDGiZePDKPT2yP98xnYfbSeQYTmGGNNDCijQ=;
 fh=UPNS4HXYeIypNL+s9tL6UKBnRLDlxVjvSkHwqhb8LsE=;
 b=ZlBMqq/0V1wdGjt/kFDjYRAcV38HizOSqT/gKidDkjKczhUMiBrbdPnUDkF+NJZRgy
 fQF6YmROjIqvPDwqCIKIB9lBDFiPNiSjIyAcLAYrl6XdYoOjc1igqL1RtnAVTAYhSGpC
 a7uqvz3TcVv3tbkuz5mITw/f5wiJ6Wlszi1Yd/xE2bUknAEoOqetHT7ihyanwd2PNDJA
 KbvKJ3zhBql5SklYrFfWDSEkL84tc38NlI4l28mEJhspip9E4gXnmAAWexx170/QIe3z
 gMQKOVhuMjlbBmv9fwx34nQ45SKXxeq3oydo9P3fnckNVPgAh5YoE6FEi1TmZEqUS085
 F5tA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793017719; x=1793622519;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zprZum4SDGiZePDKPT2yP98xnYfbSeQYTmGGNNDCijQ=;
 b=snO/PMsd+YB6bBBn2kggVFhVy62ZaNrm2gxBEz6yrzLh10Bl5LJKqWILLWCXywCWX3
 Klr24f44QXtmwozCx5oHdOVjDL8lpRhWFxgQFju941m0hJI21/8E7KRh6J6emSE908cW
 JGWu98JnD72bXvRE899NHpX6r4ztsjv1hXc4GfIHP6qy89p+B+3ihYf56dIkwTvrkxpz
 4viyTpvsZFOvxZrF8Ff2gWYuA4iwZFl81aKgHZKIeBOoBcivMQONxpeOhRABCx/4oRpt
 lj+Pr/Km/vFNp9HDWi5cbyRff9RwMYFDl98YSKb0lFgJTKUCe4Qirgj+fv+eIZvHJ8A8
 7inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793017719; x=1793622519;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zprZum4SDGiZePDKPT2yP98xnYfbSeQYTmGGNNDCijQ=;
 b=GYcLmaIPhU/7IlZuuFGJRv/zyslO7KfBClhyXhYzweDj+281YRuD6dOOZN4vIVC/Xg
 kl3Sm62Ci4eB9bGFbSXJWyFikC/Zw3PfiltGhfqEQ0UtTcQpWx+1PMhMkKbqS4lhd32l
 rW55ht1P1yTf/WzRaOFq4cRHxCF2SGIQDjJ1l4YJRM3SDPqYrDrceXTRsIAEgxEm0MpK
 E6QeCROcNrH4WOk5EhLBzUt/s3E9w9r+7CutYLLOEbICb61Lk2Tw0U279AR6FEWJVQlw
 Cl6EbCUOvXzy5c4iMTeYQYRIY7VI72Ir0S0xnq8FUHG5W6oqK8zae8y98fuM29zXZC7R
 co1w==
X-Gm-Message-State: AFq9FYIXube0K5W+EIk/E3lunT2aQ1WuF1hkXEtYx6mQlR39hVF82Zx3
 e4uyAZ1ALPrfwn4nLUoFEGMgZ7MsDRYUlNPljyROSa3BDFKXZMWkak3Jol7v89msGMhVK2IHrrQ
 xD8pucRlJMZwf8H9qhjP03UYLrbNao3NJswM2
X-Gm-Gg: AYBFou0JojdCcbk/ZnNptpJ0CBXUUsNI1Sj7QK783rXKs9wfpGUaqXy92KP+rrhRqOQ
 rC+1jF+/Mfpey/54iwAevwDnNWy+exAlZzWg7xCRL5x0f9kned0onYZu1j76lcrEfg1WaU89++h
 cPbUvYwhNWcRwSKgyQ5BNTOAQ1vZiABmpe0S5kRD4mGo3UDERI+VgN7kGb5deqNUt0/H4a24vMh
 PwQGOC3L+MLR4txvBGWvzkwrJda+83d5JXrBy97pl+odYHxRYDTxJrGYUz3x2u1UAyGk3xyRM17
 bujmzeslqi1I+xAjcgGag480LkQFkwdoB/qrk3TWVVoF8GuMr3DzvF07Zs5Ma7wVfVBMTvTSkrc
 7R4BOOWaiAabQOxa8q+iXecsLl8lCHqvizYidfyEvjnXt7h680JbQR0Eg5hPUXEJBa5YeqvGL8m
 /ISaM1v/QfA5MFYdKgSF2ybOeuwk6gxHVQPOP3wphYhJ57Wixfwz13
X-Received: by 2002:a05:7301:1602:b0:369:fd32:79fe with SMTP id
 5a478bee46e88-369fd3294bfmr5065310eec.17.1793017718682; Mon, 26 Oct 2026
 05:28:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Patryk Biel <pbiel7@gmail.com>
Date: Mon, 26 Oct 2026 13:28:27 +0100
X-Gm-Features: AclHuK8B9HALGrtQDXjxrkaRhG3jiR6FllvcRuT7zUn7g4Gb59TNqSAfK4dGLYs
Message-ID: <CA+DkFDa=Tnaeey9UWkViSOUCBbvw6eLkA5R5+AwKd50ZJBGr0Q@mail.gmail.com>
Subject: FWU multi-bank (A/B) at early boot on K3, env as metadata store?
To: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

I'm planning to add A/B firmware-update slot selection on a TI K3
DRA821 platform (will be testing on a J7200 EVM, nothing really
implemented yet, I'm still evaluating the approach and messing around
with the code) and would appreciate some guidance.

For context, let me just briefly recall the boot flow of this
platform. On K3 the chain is: ROM, then R5 SPL (the first SPL, bundled
with TIFS in tiboot3.bin), then ATF/BL31, then optional OP-TEE, then
A72 SPL, then U-Boot proper. The R5 SPL is loaded by ROM from the eMMC
boot0/boot1 hardware partitions, which makes it a natural immutable
anchor. Unlike the PSA/TF-A model where BL2 picks the active bank,
here the earliest stage that can make a slot decision is R5 SPL. I'd
like that stage to select the slot (and roll back to the previous one
on a failed boot, tracked by a boot counter in an RTC/syscon/backup
register/whatever applicable, not in env).

My questions:

1) Why is FWU_MULTI_BANK_UPDATE (the fwu_mdata metadata handling)
U-Boot-proper only, with no SPL support? Is that a deliberate design
decision (e.g. size, dependency on the EFI/capsule machinery), or just
that no one has needed it in SPL yet? For my flow the slot decision
has to happen in R5 SPL, long before U-Boot proper runs.

2) Is storing the A/B metadata (active/previous slot + per-slot state)
in the U-Boot environment a reasonable approach, or is it discouraged?
My reasoning: the env already has CRC, redundant env gives two
power-fail-safe copies, and SPL can already read env today (it's used
for Falcon mode), so the read path exists in both SPL and U-Boot
proper. The downside I see is that there's only one environment, so my
fwu.* metadata would share it with bootcmd etc., and a userspace
saveenv or a bad script could clobber boot-selection state. Is that
coupling considered acceptable in practice, or do people keep FWU
metadata in a separate store for exactly this reason? Beyond that and
the default-env fallback when both copies fail CRC, are there pitfalls
I'm underestimating?

3) VBE. I'm aware this overlaps with what VBE aims to solve, I've
looked at it, but, for now it's kinda off the table (too much
integration effort for this project), but it may be an option later.

Happy to hear if that changes the recommendation.
Best regards

Patryk
