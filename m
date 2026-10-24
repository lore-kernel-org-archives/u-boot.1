Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F19606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IJLunO1I;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JAaVD5I2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D57D060670;
	Sat, 24 Oct 2026 22:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yuzC8TpwmDnz; Sat, 24 Oct 2026 22:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 434576061D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881325;
	b=AcyqzAZmicPGY5MIp1mhQlSLHcisv5Ing8H002sLcCiRqMF27E1xhS0z4GC7BEdkJY8R
	 iN7F/Y62gE+/CqyP9J8pOaqziSKju0uTjqDEzR7BWkHtprN7Q33rbKiyOcXPSAcrDeYMF
	 lcc5Yg6Mg286f9Bxo564shxKKyGSnzNJ+MnVoYIG+0ZRiCrp4xcffA7vny08o5JoDV2DL
	 OTZZyhM4sgvp1uJkRZ8Jv/NrYogepBkHKBtmtAtQzq9dO0v8npdeUVOFpiJMqEvCpNKgg
	 mAiwznTKhjxzNmRRDOErTkt7xjEiR77Jmrk58JTsDe/0WbAUJjEwlCJIVgFxjUuHnNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yKKRlnXbxOTnKr4Er43e2B8KYbKWyAXMW7JvQGpt7lY=;
	b=Xt8pjowgi6Zv+x+O/kJ4ZnqS2KKHoBz60tY3GGR7YH8T6x0Av9ZAWn93Q8r4HTf2jT51
	 YFuQKkL+tNbjorTufiZo1K5oOOBU6xJvRpL9T/F6rK+aPPmOH2EVzajau1r9OxBa/PILY
	 /EPA2w7/2adm1vQBXfmqfMH9Z/CcCyJa209C9+WUL35lfqPglPMXoRaEIYhiCARKe5T/U
	 dXB7B9W4ecm0faG00+U1GEesFACaK6ertdl3Nm+GqRlbOg5O0MxDvtLJctsKlM8T42sjD
	 R+Z0e514o6BT8zkKH6ArxSfk2+ATAOkIjvxjjH4JXJklHAROMtoy5lWJnd1ajU6x0+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881325;
	bh=yKKRlnXbxOTnKr4Er43e2B8KYbKWyAXMW7JvQGpt7lY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IJLunO1IojKu4UConyGse12OyOCwpLtvlZ77m00T8NgLM1iaq5e1WR5q7wgO5NqHn
	 WJ4tCASMEjXOAHSDeyLQg1mTMBkZKBBsHpPILRUT6vNKG2uZZlWgRbldkGDfvK46zL
	 5FCOKj7SZvXQc66kpk5VcvjIQvDE/VIHdjYgbhgz3PXhkOGhQaucZZY1Ez/uxesfbn
	 70ka9uR/j9dEi12f/TOUQ5zfvJP+ax1hyfTlfuvytJM7m/L4konkrNTBx2s1N6L0Hz
	 m1rdgl4yGGSHWWQDWJ94kNIwQbDpUF4++L5gj7ELHUIiycXCV1qEKWEpJp7C1WDMoj
	 vHDAXLIyj9YiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 434576061D;
	Sat, 24 Oct 2026 22:35:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79A863D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77A6140079
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JtUbAOSODBJM for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2F7AA4006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881321;
 b=nAWAKlYmT3eNT8bR+FFQ/8cy6okaXvULnOMdHOWdb1XBuHyzqwXN4JOu5JQKHQuhbxBb
 i6eisY6xuOlnRU/EZsEUBHQvhSiXOU0ChCSxU5aC4AQibUiK08Y+hp51uXZfL5cMXnwxa
 yKjqfWy/RJPs2EXjHM+4R8GnHrUJ7P9Qcg02i/7avxbIDeitbtlCsjoOwbTSt1VH16ExX
 yP0yJwmd/AmZ35hxnDnYsxgIkKQSH+fGVHDSF/znaSPgF2QvzVbvu/MGOIDNqTZrXL9XQ
 IgWF0+LeXJ1PJrqvXfBEc1NvAA9DhEUF5KnpN+AxFC5NBvH7SBSMSoX2hCbgetxb3uQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881321;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=yKKRlnXbxOTnKr4Er43e2B8KYbKWyAXMW7JvQGpt7lY=;
 b=UNlHTqCPW93MUd2Z04iRpSe7hNkplyqN6ts/qI3D1bxYr5V2+Hgv7F3K6rzhYuZe3NM9
 FUiH/+3FeQf/7ilxazhLbC19pm949TzAynf0NvSd0S+DPPZUfrieyShrkP1FW3QYa95ez
 FLzJP3u4FTkASc16tRTbKw62TA11c3j7QHm9Z5KFmMlYJh7Oh0xB+nLPYsnZ7dxqz+Fov
 zMYaEBA7aLYbym1TkxRqpucpV87TIDJ/Ctnw2meeuzmB8bMJdm0Uny6olce25XIW6CYwj
 ISh+JKXKe8n5k7vvZQtgApximgh9c8Ilw2vb1NvFM4awEQzN4R5NHyMDydUvZhjvqUA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JAaVD5I2; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JAaVD5I2
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F7AA4006B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:20 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-483a66818edso973820fac.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881319; x=1793486119;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yKKRlnXbxOTnKr4Er43e2B8KYbKWyAXMW7JvQGpt7lY=;
 b=JAaVD5I22YDvFlb+H1rXixCrJM7IagwXdp+/0xRNsMM2fLNAi/ANe+zm18It4x9LCk
 kZ46KMuykjA6AVRqN96+IFiL79RJFj9PhS+mRVSmXZz2P6TXtOwkc35sKV+gcCd71hvC
 chIsA4DiCu4yOaIWa9FA1K1o7lnPl3P5NBUicGXRQdMkZue8h8SlcErh9QuF/jjvmNTa
 8t6zlJqh3M8wOaFunqOydW67/3rMkmjGZVkt3I/tZOAMkGP4QDTtFkTS5ub1WTLSt5bL
 zf14KYbp9TTNmjenzIljZ0WicNhNjOs38Ve32Wc4EFuPRQM1o8BnMRGVAK9XXU8yv1UM
 1Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881319; x=1793486119;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yKKRlnXbxOTnKr4Er43e2B8KYbKWyAXMW7JvQGpt7lY=;
 b=cmA6N4cz00e8/nEVD35Mq2l9LaEOMfYLANwPHX0KxG1/lYqkLHdoZMsZtffad0Lqey
 0gNo9X5BL/eaMItke57EoCA4Jl7/o5ZMJ/N4cyLvs4wLMRPK9w1ILpy7ep+P5+wgCxL3
 KNlAJfGYqz+jT+VI6K54cbvwiFi4r4soERO54IcDRJEPqQVQtlZ/NhSoA6hRIF/7cNQP
 ioEJYR8LV6iuVFYmeJlhdcTsSQbRnEcTOOBmBDEBBB8H7phLaJAzFHDjWGsi11nEvdNq
 SlY96qzaWRYPjjjuQLWoeo5V4+deSUEsZnLLvDaWpv1B7Ue+qklMol0gRABc13XzgkGt
 y3wQ==
X-Gm-Message-State: AFq9FYJ3GP+dH60JcEW1Uu4TMclZi19p8Z4OQisXa2JCMVwpt2nEtfcg
 eiQfLCgIs9zc2A0eDV9WXEqEjWrn/Xs3aAWBgek460NGEtIJGvowq4QM
X-Gm-Gg: AYBFou2OTMsyKHC8f61V0b4qLmQ8ksI/mFUzXKNSfO/LAwGllK/1ctotkHMZc5okwE5
 x1OtsHsTGAskK+veS2P7FzWThSq4lk1CY4JSurf6fZ1EhNk+luMnotqU50s1OaoYuQRdaYMRuQd
 4CoI/RyMgWAH5BStgr6h7fexRb8jPyQO6ca+NgFhEtX81mnJMFH0an7O+5zGs3L4rfVxs28Ftzd
 RYg63uKj6JKByFs8c+7h45G7bziShyct2lp3IZo5+f89iPj9sEiJJuTRm6o2KVlf9G7duEDpSnK
 kRyDuTtYFX4kKjCTz0LSXxhRBV8PXf0PpEs4F5nQLhdp3lAY5D5w9g8MltWa9kCYGHSPIy65VAg
 7qbNj4sky5PAqxF12guo/Zk9AzROui8ohTq1c6WtTa1OEEshJkUqtnSGz6OY09ZjLe9xJ0/77HB
 csJfnpdEivfi/fzYENSBx6jV0wNbB8LE0hBuCT2zST6o37T+dRy788yS5jqFaiGNDrXieAmZb4c
 LXPt7L0Ghdh8YeMtwgUX/b6fZhJ7Zu3muxutNi6WIoLETt1WVoUX8/Hqao1/M/lyZX/PXhXPVOA
 qS/HQ/vpF41JEUbPBYBAO7Gn69KX5PCYugmQ/74C8Wu6jdNqIcHWZyxx0Evptl5rMeV9xrhrEiZ
 RxcwYSLxvJMS7wzaewLFegGoA6CjtlpDR7L1MurXkXW5QlYK362v35DKkBeDcLbLvzW00+VpT25
 4wrUI=
X-Received: by 2002:a05:6870:e0b1:b0:448:cf96:25c7 with SMTP id
 586e51a60fabf-4a83f40aa92mr1988852fac.17.1792881319119; 
 Sat, 24 Oct 2026 15:35:19 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:49 -0600
Subject: [PATCH v2 02/16] net: lwip: tftp: fix transfer retransmissions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-2-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The request timer retransmits at TFTP_TIMER_MSECS intervals rather than
waiting for TFTP_TIMEOUT_MSECS. The first response then cancels that
timer without starting an active-transfer timer, so later packet loss
stalls the client indefinitely.

Use one-shot timers at the configured retransmission interval for both
the request and active transfer. Accept the server transfer ID only from
a valid first response, then reject packets from other endpoints with
ERROR 5. Retain DATA packets and regenerate the previous ACK for
retransmission. Recover from duplicate DATA and matching OACK packets.
Ignore non-matching ACKs without sending an error, retransmitting DATA or
extending its timer and retry budget, including ACKs delayed by multiple
blocks. RFC 1123 requires avoiding the Sorcerer's Apprentice Syndrome.

Reply to a matching duplicate OACK only until DATA 1 is received or
acknowledged. Ignore matching stale OACKs after that, without postponing
the active timer or resetting its retry budget. Track this handshake
separately from the block number so rollover cannot restart negotiation.

Retry constructing DATA when its packet allocation failed before the read
callback consumed the block. Ignore delayed duplicate ACKs while
that block is pending, and allow a matching repeated OACK to retry DATA 1.
Once constructed, retain the packet so retries do not consume input again.
Do not rearm the timer if a read error closes the transfer during recovery.

A server can also receive the initial WRQ again when ACK 0 is lost.
Acknowledge the same request from the same peer while waiting for DATA 1,
without reopening the file or resetting the timer and retry budget.
Reject a changed request or a WRQ after data reception has started.

Report timeout exhaustion through the error callback and decode server
error codes in host byte order. Add a client/server setter for the
timeout and retry count, keep the existing values as defaults and remove
the obsolete cyclic-timer option. Reject delays outside sys_timeout()'s
wrap-safe range. Convert the sandbox clock to milliseconds as required
by lwIP.

Request the RFC 2349 timeout option using the legacy whole-second
conversion and require the server to echo it exactly. Omit values outside
the RFC's 1..255-second range while retaining the local millisecond timer.
Validate repeated OACKs against the negotiated timeout as well.

Test duplicate ACKs, OACKs, WRQs, timeout negotiation and retry
exhaustion in sandbox, including delayed control packets after progress
and rollover, local timer precision after negotiation, and recovery from
DATA allocation failures before the first and subsequent blocks.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/apps/tftp/tftp.c                | 334 ++++++++++++----
 lib/lwip/lwip/src/include/lwip/apps/tftp_common.h |   1 +
 lib/lwip/lwip/src/include/lwip/apps/tftp_opts.h   |   7 -
 net/lwip/net-lwip.c                               |   2 +-
 test/dm/lwip_tftp.c                               | 445 ++++++++++++++++++++++
 5 files changed, 714 insertions(+), 75 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index a28958934bb..6a8c846cc8a 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -95,18 +95,25 @@ struct tftp_state {
   struct udp_pcb *upcb;
   ip_addr_t addr;
   u16_t port;
-  int timer;
-  int last_pkt;
   u16_t blknum;
   u16_t blksize;
   u32_t tsize;
   u32_t put_tsize;
-  u8_t retries;
+  u32_t timeout_msecs;
+  u32_t max_retries;
+  u32_t retries;
+  u8_t request_timeout;
+  u8_t negotiated_timeout;
   u8_t mode_write;
   u8_t tftp_mode;
   bool wait_oack;
+  /* An accepted OACK still needs confirmation by DATA 1 or ACK 1. */
+  bool oack_pending;
   bool request_tsize;
   bool put_tsize_set;
+  bool wrq_pending;
+  char server_fname[TFTP_MAX_FILENAME_LEN + 1];
+  char server_mode[TFTP_MAX_MODE_LEN + 1];
 };
 
 static struct tftp_state tftp_state;
@@ -117,6 +124,8 @@ static void tftp_req_tmr(void *arg);
 static const char *mode_to_string(enum tftp_transfer_mode mode);
 static u16_t payload_size(void);
 
+static const char tftp_timeout_msg[] = "Transfer timeout";
+
 static void
 clear_req(void)
 {
@@ -138,6 +147,7 @@ close_handle(void)
   tftp_state.port = 0;
   ip_addr_set_any(0, &tftp_state.addr);
   tftp_state.retries = 0;
+  tftp_state.wrq_pending = false;
 
   if (tftp_state.last_data != NULL) {
     pbuf_free(tftp_state.last_data);
@@ -153,6 +163,23 @@ close_handle(void)
   }
 }
 
+static void
+transfer_activity(void)
+{
+  tftp_state.retries = 0;
+  sys_untimeout(tftp_tmr, NULL);
+  sys_timeout(tftp_state.timeout_msecs, tftp_tmr, NULL);
+}
+
+static void
+transfer_timed_out(void)
+{
+  LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: timeout\n"));
+  tftp_state.ctx->error(tftp_state.handle, -1, tftp_timeout_msg,
+                        sizeof(tftp_timeout_msg) - 1);
+  close_handle();
+}
+
 static struct pbuf*
 init_packet(u16_t opcode, u16_t extra, size_t size)
 {
@@ -175,7 +202,9 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
   size_t mode_length = strlen(mode)+1;
   size_t tsize_length = 0;
   size_t blksize_length = 0;
+  size_t timeout_length = 0;
   char tsize[11];
+  char timeout[4];
   int blksize = tftp_state.blksize;
   struct pbuf* p;
   char* payload;
@@ -195,7 +224,13 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
     }
   }
 
-  p = init_packet(opcode, 0, fname_length + mode_length + blksize_length + tsize_length - 2);
+  if (tftp_state.request_timeout) {
+    sprintf(timeout, "%u", tftp_state.request_timeout);
+    timeout_length = sizeof("timeout") + strlen(timeout) + 1;
+  }
+
+  p = init_packet(opcode, 0, fname_length + mode_length + blksize_length +
+                  tsize_length + timeout_length - 2);
   if (p == NULL) {
     return ERR_MEM;
   }
@@ -207,8 +242,11 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
     sprintf(payload+2+fname_length+mode_length, "tsize%c%s", 0, tsize);
   if (tftp_state.blksize)
     sprintf(payload+2+fname_length+mode_length+tsize_length, "blksize%c%d", 0, tftp_state.blksize);
+  if (timeout_length)
+    sprintf(payload+2+fname_length+mode_length+tsize_length+blksize_length,
+            "timeout%c%s", 0, timeout);
 
-  tftp_state.wait_oack = tsize_length || blksize_length;
+  tftp_state.wait_oack = tsize_length || blksize_length || timeout_length;
   ret = udp_sendto(tftp_state.upcb, p, addr, port);
   pbuf_free(p);
   return ret;
@@ -287,7 +325,7 @@ resend_data(const ip_addr_t *addr, u16_t port)
   return ret;
 }
 
-static void
+static err_t
 send_data(const ip_addr_t *addr, u16_t port)
 {
   u16_t size = payload_size();
@@ -300,7 +338,7 @@ send_data(const ip_addr_t *addr, u16_t port)
 
   tftp_state.last_data = init_packet(TFTP_DATA, tftp_state.blknum, size);
   if (tftp_state.last_data == NULL) {
-    return;
+    return ERR_MEM;
   }
 
   payload = (u16_t *) tftp_state.last_data->payload;
@@ -309,11 +347,11 @@ send_data(const ip_addr_t *addr, u16_t port)
   if (ret < 0) {
     send_error_and_close(addr, port, TFTP_ERROR_ACCESS_VIOLATION,
                          "Error occurred while reading the file.");
-    return;
+    return ERR_VAL;
   }
 
   pbuf_realloc(tftp_state.last_data, (u16_t)(TFTP_HEADER_LENGTH + ret));
-  resend_data(addr, port);
+  return resend_data(addr, port);
 }
 
 static u16_t payload_size(void)
@@ -366,13 +404,14 @@ read_option_field(struct pbuf *p, u16_t *offset, char *field, size_t size)
 }
 
 static int
-parse_oack(struct pbuf *p, u32_t *blksize, u32_t *tsize)
+parse_oack(struct pbuf *p, u32_t *blksize, u32_t *tsize, u32_t *timeout)
 {
   u16_t offset = 2;
   unsigned int seen = 0;
 
   *blksize = 0;
   *tsize = 0;
+  *timeout = 0;
   while (offset < p->tot_len) {
     char option[16], value[11];
     u32_t number;
@@ -394,6 +433,12 @@ parse_oack(struct pbuf *p, u32_t *blksize, u32_t *tsize)
         return 0;
       seen |= 2;
       *tsize = number;
+    } else if (!lwip_stricmp(option, "timeout")) {
+      if ((seen & 8) || !tftp_state.request_timeout ||
+          (number != tftp_state.request_timeout))
+        return 0;
+      seen |= 8;
+      *timeout = number;
     } else {
       /* RFC 2347 forbids acknowledging an option we did not request. */
       return 0;
@@ -403,6 +448,26 @@ parse_oack(struct pbuf *p, u32_t *blksize, u32_t *tsize)
   return seen != 0;
 }
 
+static int
+is_expected_response(struct pbuf *p, u16_t opcode)
+{
+  u16_t *sbuf = (u16_t *) p->payload;
+
+  if (opcode == PP_HTONS(TFTP_ERROR))
+    return 1;
+  if (opcode == PP_HTONS(TFTP_OACK))
+    return tftp_state.wait_oack;
+  if (p->len < TFTP_HEADER_LENGTH)
+    return 0;
+
+  if (tftp_req.opcode == TFTP_RRQ)
+    return (opcode == PP_HTONS(TFTP_DATA)) &&
+      (lwip_ntohs(sbuf[1]) == tftp_state.blknum);
+
+  return (opcode == PP_HTONS(TFTP_ACK)) &&
+    (lwip_ntohs(sbuf[1]) == tftp_state.blknum);
+}
+
 static void
 tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr, u16_t port)
 {
@@ -412,20 +477,40 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
   LWIP_UNUSED_ARG(arg);
   LWIP_UNUSED_ARG(upcb);
 
+  if (p->len < sizeof(*sbuf)) {
+    pbuf_free(p);
+    return;
+  }
+
   if (((tftp_state.port != 0) && (port != tftp_state.port)) ||
       (!ip_addr_isany_val(tftp_state.addr) && !ip_addr_eq(&tftp_state.addr, addr))) {
-    send_error(addr, port, TFTP_ERROR_ACCESS_VIOLATION, "Only one connection at a time is supported");
+    send_error(addr, port, TFTP_ERROR_UNKNOWN_TRFR_ID, "Unknown transfer ID");
     pbuf_free(p);
     return;
   }
 
   opcode = sbuf[0];
+  if (((opcode == PP_HTONS(TFTP_DATA)) ||
+       (opcode == PP_HTONS(TFTP_ACK)) ||
+       (opcode == PP_HTONS(TFTP_ERROR))) &&
+      (p->len < TFTP_HEADER_LENGTH)) {
+    send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION,
+               "Packet too short");
+    pbuf_free(p);
+    return;
+  }
 
-  tftp_state.last_pkt = tftp_state.timer;
-  tftp_state.retries = 0;
+  if (tftp_req.fname) {
+    if (!is_expected_response(p, (u16_t)opcode)) {
+      send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION,
+                 "Unexpected response");
+      pbuf_free(p);
+      return;
+    }
 
-  if (tftp_req.fname)
+    tftp_state.port = port;
     clear_req();
+  }
 
   switch (opcode) {
     case PP_HTONS(TFTP_RRQ): /* fall through */
@@ -436,18 +521,11 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       u16_t filename_end_offset;
       u16_t mode_end_offset;
 
-      if (tftp_state.handle != NULL) {
-        send_error(addr, port, TFTP_ERROR_ACCESS_VIOLATION, "Only one connection at a time is supported");
-        break;
-      }
-
       if ((tftp_state.tftp_mode & LWIP_TFTP_MODE_SERVER) == 0) {
         send_error(addr, port, TFTP_ERROR_ACCESS_VIOLATION, "TFTP server not enabled");
         break;
       }
 
-      sys_timeout(TFTP_TIMER_MSECS, tftp_tmr, NULL);
-
       /* find \0 in pbuf -> end of filename string */
       filename_end_offset = pbuf_memfind(p, &tftp_null, sizeof(tftp_null), 2);
       if ((u16_t)(filename_end_offset - 1) > sizeof(filename)) {
@@ -464,6 +542,22 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       }
       pbuf_copy_partial(p, mode, mode_end_offset - filename_end_offset, filename_end_offset + 1);
 
+      if (tftp_state.handle != NULL) {
+        /* The initial ACK may have been lost. Only acknowledge the same
+         * write request, before any DATA has arrived, without reopening
+         * the file or extending the transfer's timeout/retry budget.
+         * The peer address and port were checked above.
+         */
+        if ((opcode == PP_HTONS(TFTP_WRQ)) && tftp_state.wrq_pending &&
+            !strcmp(filename, tftp_state.server_fname) &&
+            !lwip_stricmp(mode, tftp_state.server_mode)) {
+          send_ack(addr, port, 0);
+        } else {
+          send_error(addr, port, TFTP_ERROR_ACCESS_VIOLATION, "Only one connection at a time is supported");
+        }
+        break;
+      }
+
       tftp_state.handle = tftp_state.ctx->open(filename, mode, opcode == PP_HTONS(TFTP_WRQ));
       tftp_state.blknum = 1;
 
@@ -478,9 +572,13 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
 
       ip_addr_copy(tftp_state.addr, *addr);
       tftp_state.port = port;
+      transfer_activity();
 
       if (opcode == PP_HTONS(TFTP_WRQ)) {
         tftp_state.mode_write = 1;
+        tftp_state.wrq_pending = true;
+        strcpy(tftp_state.server_fname, filename);
+        strcpy(tftp_state.server_mode, mode);
         send_ack(addr, port, 0);
       } else {
         tftp_state.mode_write = 0;
@@ -505,17 +603,19 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       }
 
       blknum = lwip_ntohs(sbuf[1]);
-      if (tftp_state.wait_oack) {
-        /*
-         * Data received while we are expecting an OACK for our tsize option.
-         * This means the server doesn't support it, let's switch back to the
-         * default block size.
-         */
-        tftp_state.tsize = 0;
-        tftp_state.blksize = 0;
-        tftp_state.wait_oack = false;
-      }
       if (blknum == tftp_state.blknum) {
+        tftp_state.wrq_pending = false;
+        tftp_state.oack_pending = false;
+        transfer_activity();
+        if (tftp_state.wait_oack) {
+          /*
+           * Data received while we are expecting an OACK. This means the
+           * server doesn't support options, so use the default block size.
+           */
+          tftp_state.tsize = 0;
+          tftp_state.blksize = 0;
+          tftp_state.wait_oack = false;
+        }
         pbuf_remove_header(p, TFTP_HEADER_LENGTH);
 
         ret = tftp_state.ctx->write(tftp_state.handle, p);
@@ -533,6 +633,7 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
         }
       } else if ((u16_t)(blknum + 1) == tftp_state.blknum) {
         /* retransmit of previous block, ack again (casting to u16_t to care for overflow) */
+        transfer_activity();
         send_ack(addr, port, blknum);
       } else {
         send_error(addr, port, TFTP_ERROR_UNKNOWN_TRFR_ID, "Wrong block number");
@@ -555,13 +656,20 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       }
 
       blknum = lwip_ntohs(sbuf[1]);
-      if ((blknum == 0) && (tftp_state.blknum == 0) && tftp_state.wait_oack) {
-        /* The server ignored the options in our write request. */
-        tftp_state.blksize = 0;
-        tftp_state.wait_oack = false;
-      }
-      if (blknum != tftp_state.blknum) {
-        send_error(addr, port, TFTP_ERROR_UNKNOWN_TRFR_ID, "Wrong block number");
+      if (blknum == tftp_state.blknum) {
+        tftp_state.oack_pending = false;
+        transfer_activity();
+        if ((blknum == 0) && tftp_state.wait_oack) {
+          /* The server ignored the options in our write request. */
+          tftp_state.blksize = 0;
+          tftp_state.wait_oack = false;
+        }
+      } else {
+        /* An ACK can be delayed by more than one block. Ignore all
+         * non-matching ACKs without errors or DATA retransmission
+         * (RFC 1123), even while DATA allocation is pending. Leave the
+         * timer and retry budget alone as well.
+         */
         break;
       }
 
@@ -583,27 +691,60 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
     case PP_HTONS(TFTP_ERROR):
       if (tftp_state.handle != NULL) {
         pbuf_remove_header(p, TFTP_HEADER_LENGTH);
-        tftp_state.ctx->error(tftp_state.handle, sbuf[1], (const char*)p->payload, p->len);
+        tftp_state.ctx->error(tftp_state.handle, lwip_ntohs(sbuf[1]),
+                              (const char*)p->payload, p->len);
         close_handle();
       }
       break;
     case PP_HTONS(TFTP_OACK): {
       u32_t srv_blksize = 0;
       u32_t srv_tsize = 0;
+      u32_t srv_timeout = 0;
 
       if (tftp_state.handle == NULL) {
         send_error(addr, port, TFTP_ERROR_ACCESS_VIOLATION, "No connection");
         break;
       }
-      if (!parse_oack(p, &srv_blksize, &srv_tsize)) {
+      if (!parse_oack(p, &srv_blksize, &srv_tsize, &srv_timeout)) {
         send_error_and_close(addr, port, TFTP_ERROR_OPTION_NEGOTIATION,
                              "Invalid OACK");
         break;
       }
+      if (!tftp_state.wait_oack) {
+        if (((tftp_state.tftp_mode & LWIP_TFTP_MODE_CLIENT) != 0) &&
+            (srv_blksize == tftp_state.blksize) &&
+            (srv_tsize == tftp_state.tsize) &&
+            (srv_timeout == tftp_state.negotiated_timeout)) {
+          /* Delayed OACKs cannot restart negotiation after DATA, even
+           * when the block number wraps back to one.
+           */
+          if (!tftp_state.oack_pending)
+            break;
+          if (tftp_state.mode_write == 0) {
+            if (tftp_state.last_data != NULL)
+              resend_data(addr, port);
+            else
+              send_data(addr, port);
+            break;
+          }
+          if ((tftp_state.mode_write != 0) &&
+              (tftp_state.last_data == NULL)) {
+            send_ack(addr, port, 0);
+            break;
+          }
+        }
+        send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION,
+                   "Unexpected OACK");
+        break;
+      }
+
+      transfer_activity();
       tftp_state.wait_oack = false;
+      tftp_state.oack_pending = true;
       /* Publish only after validating the entire option list. */
       tftp_state.blksize = (u16_t)srv_blksize;
       tftp_state.tsize = srv_tsize;
+      tftp_state.negotiated_timeout = (u8_t)srv_timeout;
       if (tftp_state.mode_write == 0) {
         tftp_state.blknum = 1;
         send_data(addr, port);
@@ -623,46 +764,61 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
 static void
 tftp_tmr(void *arg)
 {
-  LWIP_UNUSED_ARG(arg);
+  err_t ret;
 
-  tftp_state.timer++;
+  LWIP_UNUSED_ARG(arg);
 
   if (tftp_state.handle == NULL) {
     return;
   }
 
-  sys_timeout(TFTP_TIMER_MSECS, tftp_tmr, NULL);
+  if (tftp_state.retries >= tftp_state.max_retries) {
+    transfer_timed_out();
+    return;
+  }
 
-  if ((tftp_state.timer - tftp_state.last_pkt) > (TFTP_TIMEOUT_MSECS / TFTP_TIMER_MSECS)) {
-    if ((tftp_state.last_data != NULL) && (tftp_state.retries < TFTP_MAX_RETRIES)) {
-      LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: timeout, retrying\n"));
-      resend_data(&tftp_state.addr, tftp_state.port);
-      tftp_state.retries++;
-    } else {
-      LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: timeout\n"));
-      close_handle();
-    }
+  LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: timeout, retrying\n"));
+  if (tftp_state.last_data != NULL)
+    ret = resend_data(&tftp_state.addr, tftp_state.port);
+  else if (tftp_state.mode_write != 0)
+    ret = send_ack(&tftp_state.addr, tftp_state.port,
+                   (u16_t)(tftp_state.blknum - 1));
+  else {
+    /* Allocation failed before the read callback consumed this block. */
+    ret = send_data(&tftp_state.addr, tftp_state.port);
+  }
+  LWIP_UNUSED_ARG(ret);
+
+  /* A read error while constructing DATA may have closed the transfer. */
+  if (tftp_state.handle == NULL) {
+    return;
   }
+
+  tftp_state.retries++;
+  sys_timeout(tftp_state.timeout_msecs, tftp_tmr, NULL);
 }
 
 static void
 tftp_req_tmr(void *arg)
 {
+  err_t ret;
+
+  LWIP_UNUSED_ARG(arg);
+
   if (tftp_state.handle == NULL) {
     return;
   }
 
-  sys_timeout(TFTP_TIMER_MSECS, tftp_req_tmr, NULL);
-
-  if (tftp_state.retries < TFTP_MAX_RETRIES) {
-    LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: req timeout, retrying\n"));
-    resend_request();
-    tftp_state.retries++;
-  } else {
-    LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: req timeout\n"));
-    tftp_state.ctx->error(tftp_state.handle, -1, "Request timeout", strlen("Request timeout"));
-    close_handle();
+  if (tftp_state.retries >= tftp_state.max_retries) {
+    transfer_timed_out();
+    return;
   }
+
+  LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: req timeout, retrying\n"));
+  ret = resend_request();
+  LWIP_UNUSED_ARG(ret);
+  tftp_state.retries++;
+  sys_timeout(tftp_state.timeout_msecs, tftp_req_tmr, NULL);
 }
 
 /**
@@ -692,10 +848,12 @@ tftp_init_common(u8_t mode, const struct tftp_context *ctx)
   tftp_state.handle    = NULL;
   tftp_state.port      = 0;
   tftp_state.ctx       = ctx;
-  tftp_state.timer     = 0;
   tftp_state.last_data = NULL;
   tftp_state.upcb      = pcb;
   tftp_state.tftp_mode = mode;
+  tftp_state.timeout_msecs = TFTP_TIMEOUT_MSECS;
+  tftp_state.max_retries = TFTP_MAX_RETRIES;
+  tftp_state.wrq_pending = false;
 
   udp_recv(pcb, tftp_recv, NULL);
 
@@ -754,6 +912,27 @@ tftp_client_set_tsize(u32_t tsize)
   tftp_state.put_tsize_set = true;
 }
 
+/** @ingroup tftp
+ * Set the TFTP client/server retransmission timeout and maximum retry count.
+ * Clients request RFC 2349 timeout negotiation using whole seconds, like U-Boot's
+ * legacy client, while retaining millisecond precision for the local timer.
+ * Omit the option if the seconds value is outside the RFC's 1..255 range.
+ * @param timeout_msecs Retransmission timeout in milliseconds
+ * @param max_retries Maximum number of retransmissions
+ * @return ERR_OK on success, ERR_ARG if timeout_msecs is zero or exceeds
+ *         the wrap-safe range supported by sys_timeout()
+ */
+err_t
+tftp_set_timeout(u32_t timeout_msecs, u32_t max_retries)
+{
+  if ((timeout_msecs == 0) || (timeout_msecs > LWIP_UINT32_MAX / 4))
+    return ERR_ARG;
+
+  tftp_state.timeout_msecs = timeout_msecs;
+  tftp_state.max_retries = max_retries;
+  return ERR_OK;
+}
+
 /** @ingroup tftp
  * Deinitialize ("turn off") TFTP client/server.
  */
@@ -780,18 +959,39 @@ mode_to_string(enum tftp_transfer_mode mode)
   return NULL;
 }
 
-err_t
+static err_t
 start_send_requests(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname, enum tftp_transfer_mode mode)
 {
+  err_t ret;
+  u32_t seconds = tftp_state.timeout_msecs / 1000;
+
+  tftp_state.request_timeout = seconds <= 255 ? (u8_t)seconds : 0;
+  tftp_state.negotiated_timeout = 0;
+  tftp_state.oack_pending = false;
+
   tftp_req.addr = *addr;
   tftp_req.port = port;
   tftp_req.opcode = opcode;
   tftp_req.fname = strdup(fname);
   tftp_req.mode = mode;
-  if (!tftp_req.fname)
+  if (!tftp_req.fname) {
+    tftp_state.handle = NULL;
     return ERR_MEM;
-  sys_timeout(TFTP_TIMER_MSECS, tftp_req_tmr, NULL);
-  return resend_request();
+  }
+
+  ip_addr_copy(tftp_state.addr, *addr);
+  tftp_state.port = 0;
+  tftp_state.retries = 0;
+  ret = resend_request();
+  if (ret != ERR_OK) {
+    clear_req();
+    ip_addr_set_any(0, &tftp_state.addr);
+    tftp_state.handle = NULL;
+    return ret;
+  }
+
+  sys_timeout(tftp_state.timeout_msecs, tftp_req_tmr, NULL);
+  return ERR_OK;
 }
 
 err_t
diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h
index 4bc2c173478..092e7d4059a 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_common.h
@@ -99,6 +99,7 @@ struct tftp_context {
 #define LWIP_TFTP_MODE_CLIENTSERVER (LWIP_TFTP_MODE_SERVER | LWIP_TFTP_MODE_CLIENT)
 
 err_t tftp_init_common(u8_t mode, const struct tftp_context* ctx);
+err_t tftp_set_timeout(u32_t timeout_msecs, u32_t max_retries);
 void tftp_cleanup(void);
 
 #ifdef __cplusplus
diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_opts.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_opts.h
index 509fabd6795..5d117550413 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/tftp_opts.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_opts.h
@@ -78,13 +78,6 @@
 #define TFTP_MAX_RETRIES      5
 #endif
 
-/**
- * TFTP timer cyclic interval
- */
-#if !defined TFTP_TIMER_MSECS || defined __DOXYGEN__
-#define TFTP_TIMER_MSECS      (TFTP_TIMEOUT_MSECS / 10)
-#endif
-
 /**
  * Max. length of TFTP filename
  */
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 4319f4441e8..2afe74cc6a5 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -716,7 +716,7 @@ int net_loop(enum proto_t protocol)
 u32_t sys_now(void)
 {
 #if CONFIG_IS_ENABLED(SANDBOX_TIMER)
-	return timer_early_get_count();
+	return timer_early_get_count() / 1000;
 #else
 	return get_timer(0);
 #endif
diff --git a/test/dm/lwip_tftp.c b/test/dm/lwip_tftp.c
index af4d6564929..7abe4a47d87 100644
--- a/test/dm/lwip_tftp.c
+++ b/test/dm/lwip_tftp.c
@@ -20,14 +20,27 @@ struct tftp_protocol_test {
 	u16 opcode;
 	u16 block;
 	unsigned int sent;
+	unsigned int opened;
 	unsigned int closed;
 	unsigned int written;
+	unsigned int reads;
 	int error;
+	int read_error;
 	bool initialized;
+	bool fail_data_alloc;
+	char timeout[4];
 };
 
 static struct tftp_protocol_test *tftp_test_active;
 
+static void *tftp_test_open(const char *fname, const char *mode, u8 is_write)
+{
+	if (!is_write)
+		return NULL;
+	tftp_test_active->opened++;
+	return tftp_test_active;
+}
+
 /* Capture IP output without depending on ARP or a real TFTP server. */
 static err_t tftp_test_output(struct netif *netif, struct pbuf *p,
 			      const ip4_addr_t *addr)
@@ -39,6 +52,14 @@ static err_t tftp_test_output(struct netif *netif, struct pbuf *p,
 	test->port = get_unaligned_be16(packet + IP_HDR_SIZE);
 	test->opcode = get_unaligned_be16(packet + IP_UDP_HDR_SIZE);
 	test->block = get_unaligned_be16(packet + IP_UDP_HDR_SIZE + 2);
+	if (test->opcode == 1 || test->opcode == 2) {
+		u16 offset = pbuf_memfind(p, "timeout", sizeof("timeout"), IP_UDP_HDR_SIZE);
+
+		memset(test->timeout, 0, sizeof(test->timeout));
+		if (offset != 0xffff)
+			pbuf_copy_partial(p, test->timeout, sizeof(test->timeout),
+					  offset + sizeof("timeout"));
+	}
 	test->sent++;
 	return ERR_OK;
 }
@@ -52,6 +73,11 @@ static void tftp_test_close(void *handle)
 
 static int tftp_test_read(void *handle, void *buf, int len)
 {
+	struct tftp_protocol_test *test = handle;
+
+	test->reads++;
+	if (test->read_error)
+		return test->read_error;
 	memset(buf, 0x5a, len);
 	return len;
 }
@@ -72,6 +98,7 @@ static void tftp_test_error(void *handle, int err, const char *msg, int len)
 }
 
 static const struct tftp_context tftp_test_callbacks = {
+	.open = tftp_test_open,
 	.close = tftp_test_close,
 	.read = tftp_test_read,
 	.write = tftp_test_write,
@@ -105,7 +132,12 @@ static int tftp_test_input(struct tftp_protocol_test *test, const void *data,
 		pbuf_take(tail, data + split, len - split);
 		pbuf_cat(p, tail);
 	}
+	/* Allow the activity timer, then fail the pending DATA allocation. */
+	if (test->fail_data_alloc)
+		malloc_enable_testing(1);
 	pcb->recv(pcb->recv_arg, pcb, p, &test->server, 1234);
+	if (test->fail_data_alloc)
+		malloc_disable_testing();
 	return 0;
 }
 
@@ -171,6 +203,405 @@ static int tftp_test_oack(struct unit_test_state *uts,
 	return 0;
 }
 
+static int tftp_test_data_alloc_retry(struct unit_test_state *uts,
+				      struct tftp_protocol_test *test)
+{
+	static const char oack[] = "\000\006blksize\0001024";
+	u8 ack[] = { 0, 4, 0, 0 };
+	unsigned int sent;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		ut_assertok(tftp_test_start(test, true));
+		ut_assertok(tftp_set_timeout(30, 3));
+		ack[3] = 0;
+		test->fail_data_alloc = true;
+		if (i)
+			ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+		else
+			ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+		test->fail_data_alloc = false;
+		ut_asserteq(1, test->sent);
+		ut_asserteq(0, test->reads);
+
+		/* An old ACK must not reject or postpone the pending block. */
+		ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+		ut_asserteq(1, test->sent);
+		timer_test_add_offset(40);
+		sys_check_timeouts();
+		ut_asserteq(2, test->sent);
+		ut_asserteq(3, test->opcode);
+		ut_asserteq(1, test->block);
+		ut_asserteq(1, test->reads);
+
+		/* Retrying the constructed packet must not consume input again. */
+		timer_test_add_offset(40);
+		sys_check_timeouts();
+		ut_asserteq(3, test->sent);
+		ut_asserteq(1, test->block);
+		ut_asserteq(1, test->reads);
+
+		/* Repeat after freeing an acknowledged, nonempty DATA buffer. */
+		ack[3] = 1;
+		test->fail_data_alloc = true;
+		ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+		test->fail_data_alloc = false;
+		ut_asserteq(3, test->sent);
+		ut_asserteq(1, test->reads);
+		ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+		ut_asserteq(3, test->sent);
+		ack[3] = 0;
+		ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+		ut_asserteq(3, test->sent);
+		if (i) {
+			ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+			ut_asserteq(3, test->sent);
+		}
+		ut_asserteq(1, test->reads);
+		timer_test_add_offset(40);
+		sys_check_timeouts();
+		ut_asserteq(4, test->sent);
+		ut_asserteq(3, test->opcode);
+		ut_asserteq(2, test->block);
+		ut_asserteq(2, test->reads);
+		ut_asserteq(0, test->error);
+	}
+
+	/* A repeated OACK can also retry constructing the first DATA packet. */
+	ut_assertok(tftp_test_start(test, true));
+	ut_assertok(tftp_set_timeout(30, 1));
+	test->fail_data_alloc = true;
+	ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+	test->fail_data_alloc = false;
+	ut_asserteq(0, test->reads);
+	timer_test_add_offset(20);
+	ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+	ut_asserteq(2, test->sent);
+	ut_asserteq(3, test->opcode);
+	ut_asserteq(1, test->block);
+	ut_asserteq(1, test->reads);
+	timer_test_add_offset(20);
+	sys_check_timeouts();
+	ut_asserteq(3, test->sent);
+	ut_asserteq(1, test->reads);
+
+	/* A read error during timer recovery must close without rearming it. */
+	ut_assertok(tftp_test_start(test, true));
+	ut_assertok(tftp_set_timeout(30, 1));
+	ack[3] = 0;
+	test->fail_data_alloc = true;
+	ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+	test->fail_data_alloc = false;
+	test->read_error = -EIO;
+	timer_test_add_offset(40);
+	sys_check_timeouts();
+	ut_asserteq(2, test->error);
+	ut_asserteq(1, test->closed);
+	ut_asserteq(1, test->reads);
+	sent = test->sent;
+	timer_test_add_offset(40);
+	sys_check_timeouts();
+	ut_asserteq(sent, test->sent);
+	ut_asserteq(1, test->closed);
+	return 0;
+}
+
+static int tftp_test_duplicate_ack(struct unit_test_state *uts,
+				   struct tftp_protocol_test *test)
+{
+	u8 ack[] = { 0, 4, 0, 0 };
+	unsigned int block, i, sent;
+
+	for (block = 1; block <= 3; block += 2) {
+		ut_assertok(tftp_test_start(test, true));
+		ut_assertok(tftp_set_timeout(30, 1));
+		for (i = 0; i < block; i++) {
+			ack[3] = i;
+			ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+		}
+		ut_asserteq(3, test->opcode);
+		ut_asserteq(block, test->block);
+		sent = test->sent;
+		timer_test_add_offset(20);
+		/* Ignore all older ACKs, not just the immediately preceding one. */
+		for (i = 0; i < block; i++) {
+			ack[3] = i;
+			ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+			ut_asserteq(sent, test->sent);
+		}
+		/* An ACK for an unsent block must not advance the input either. */
+		ack[3] = block + 1;
+		ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+		ut_asserteq(sent, test->sent);
+		ut_asserteq(block, test->reads);
+		timer_test_add_offset(20);
+		sys_check_timeouts();
+		ut_asserteq(sent + 1, test->sent);
+		ut_asserteq(block, test->block);
+		ut_asserteq(block, test->reads);
+		ack[3] = 0;
+		ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+		timer_test_add_offset(40);
+		sys_check_timeouts();
+		ut_asserteq(-1, test->error);
+		ut_asserteq(1, test->closed);
+		ut_asserteq(sent + 1, test->sent);
+	}
+	return 0;
+}
+
+static int tftp_test_duplicate_oack(struct unit_test_state *uts,
+				    struct tftp_protocol_test *test)
+{
+	static const char oack[] = "\000\006blksize\0001024";
+	unsigned int sent;
+	int put;
+
+	for (put = 0; put < 2; put++) {
+		ut_assertok(tftp_test_start(test, put));
+		ut_assertok(tftp_set_timeout(30, 1));
+		ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+		sent = test->sent;
+		timer_test_add_offset(20);
+		ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+		ut_asserteq(sent + 1, test->sent);
+		ut_asserteq(put ? 3 : 4, test->opcode);
+		ut_asserteq(put ? 1 : 0, test->block);
+
+		/* A duplicate neither postpones a retry nor replenishes its budget. */
+		timer_test_add_offset(20);
+		sys_check_timeouts();
+		ut_asserteq(sent + 2, test->sent);
+		ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+		timer_test_add_offset(40);
+		sys_check_timeouts();
+		ut_asserteq(-1, test->error);
+		ut_asserteq(1, test->closed);
+		ut_asserteq(sent + 3, test->sent);
+	}
+	return 0;
+}
+
+static int tftp_test_stale_control(struct unit_test_state *uts,
+				   struct tftp_protocol_test *test)
+{
+	static const char oack[] = "\000\006blksize\00016";
+	static const char changed[] = "\000\006blksize\0008";
+	static const char invalid[] = "\000\006unknown\0001";
+	u8 data[4 + 16] = { 0, 3 };
+	u8 ack[] = { 0, 4, 0, 0 };
+	unsigned int end, i, sent, reads, written;
+	int put, wrap;
+
+	for (put = 0; put < 2; put++) {
+		for (wrap = 0; wrap < 2; wrap++) {
+			ut_assertok(tftp_test_start(test, put));
+			ut_assertok(tftp_set_timeout(30, 1));
+			ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+			end = wrap ? 65536 : 1;
+			for (i = 1; i <= end; i++) {
+				put_unaligned_be16(i, (put ? ack : data) + 2);
+				ut_assertok(tftp_test_input(test, put ? ack : data,
+							    put ? sizeof(ack) : sizeof(data), 0));
+			}
+			reads = put ? end + 1 : 0;
+			written = put ? 0 : end * 16;
+			ut_asserteq(reads, test->reads);
+			ut_asserteq(written, test->written);
+			ut_asserteq(put ? 3 : 4, test->opcode);
+			ut_asserteq((u16)(end + put), test->block);
+			sent = test->sent;
+			timer_test_add_offset(20);
+			if (put) {
+				/* Two blocks old, including ACK 65535 while awaiting ACK 1. */
+				put_unaligned_be16(end - 1, ack + 2);
+				ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+				ut_asserteq(sent, test->sent);
+			}
+			/*
+			 * A matching OACK must not restart negotiation after DATA,
+			 * even when the block number has wrapped back to one.
+			 */
+			ut_assertok(tftp_test_input(test, oack, sizeof(oack), 5));
+			ut_asserteq(sent, test->sent);
+			ut_asserteq(reads, test->reads);
+			ut_asserteq(written, test->written);
+			ut_asserteq(0, test->error);
+			ut_asserteq(0, test->closed);
+			timer_test_add_offset(20);
+			sys_check_timeouts();
+			ut_asserteq(sent + 1, test->sent);
+			ut_asserteq(put ? 3 : 4, test->opcode);
+			ut_asserteq((u16)(end + put), test->block);
+			ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+			timer_test_add_offset(40);
+			sys_check_timeouts();
+			ut_asserteq(-1, test->error);
+			ut_asserteq(1, test->closed);
+			ut_asserteq(sent + 1, test->sent);
+			ut_asserteq(reads, test->reads);
+			ut_asserteq(written, test->written);
+		}
+
+		/* Only matching, valid options may be ignored after progress. */
+		ut_assertok(tftp_test_start(test, put));
+		ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+		put_unaligned_be16(1, (put ? ack : data) + 2);
+		ut_assertok(tftp_test_input(test, put ? ack : data,
+					    put ? sizeof(ack) : sizeof(data), 0));
+		ut_assertok(tftp_test_input(test, changed, sizeof(changed), 0));
+		ut_asserteq(5, test->opcode);
+		ut_asserteq(4, test->block);
+		ut_assertok(tftp_test_input(test, invalid, sizeof(invalid), 0));
+		ut_asserteq(5, test->opcode);
+		ut_asserteq(8, test->block);
+		ut_asserteq(8, test->error);
+		ut_asserteq(1, test->closed);
+	}
+	return 0;
+}
+
+static int tftp_test_timeout_range(struct unit_test_state *uts,
+				   struct tftp_protocol_test *test)
+{
+	ut_assertok(tftp_test_start(test, false));
+	ut_asserteq(ERR_ARG, tftp_set_timeout(0, 1));
+	ut_assertok(tftp_set_timeout(1, 1));
+	ut_assertok(tftp_set_timeout(U32_MAX / 4, 1));
+	ut_asserteq(ERR_ARG, tftp_set_timeout(U32_MAX / 4 + 1, 1));
+	ut_asserteq(ERR_ARG, tftp_set_timeout(U32_MAX, 1));
+	return 0;
+}
+
+static int tftp_test_timeout_option(struct unit_test_state *uts,
+				    struct tftp_protocol_test *test)
+{
+	static const u32 delays[] = { 999, 1000, 1500, 255000, 256000 };
+	static const char * const values[] = { "", "1", "1", "255", "" };
+	static const char oack[] = "\000\006timeout\0001";
+	static const char bad[] = "\000\006timeout\0002";
+	static const char maximum[] = "\000\006timeout\000255";
+	static const char duplicate[] = "\000\006timeout\0001\000TIMEOUT\0001";
+	static const u8 ack[] = { 0, 4, 0, 0 };
+	int i, put;
+
+	for (put = 0; put < 2; put++) {
+		for (i = 0; i < ARRAY_SIZE(delays); i++) {
+			if (test->initialized)
+				tftp_cleanup();
+			memset(test, 0, sizeof(*test));
+			ipaddr_aton("1.1.2.2", &test->server);
+			ut_assertok(tftp_init_client(&tftp_test_callbacks));
+			test->initialized = true;
+			tftp_client_set_blksize(1024);
+			ut_assertok(tftp_set_timeout(delays[i], 1));
+			if (put)
+				ut_assertok(tftp_put(test, &test->server, 69, "file",
+						     TFTP_MODE_OCTET));
+			else
+				ut_assertok(tftp_get(test, &test->server, 69, "file",
+						     TFTP_MODE_OCTET));
+			ut_asserteq_str(values[i], test->timeout);
+			if (i == 1 || i == 2) {
+				ut_assertok(tftp_test_input(test, oack, sizeof(oack), 5));
+				ut_asserteq(0, test->error);
+				ut_asserteq(put ? 3 : 4, test->opcode);
+				ut_assertok(tftp_test_input(test, oack, sizeof(oack), 0));
+				ut_asserteq(0, test->error);
+				ut_asserteq(put ? 3 : 4, test->opcode);
+				if (i == 2) {
+					unsigned int sent = test->sent;
+
+					timer_test_add_offset(1001);
+					sys_check_timeouts();
+					ut_asserteq(sent, test->sent);
+					timer_test_add_offset(500);
+					sys_check_timeouts();
+					ut_asserteq(sent + 1, test->sent);
+				}
+				ut_assertok(tftp_test_input(test, duplicate, sizeof(duplicate), 0));
+			} else {
+				if (i == 3) {
+					ut_assertok(tftp_test_input(test, maximum,
+								    sizeof(maximum), 0));
+					ut_asserteq(0, test->error);
+					ut_asserteq(put ? 3 : 4, test->opcode);
+				}
+				/* Reject unrequested or non-echoed timeout values. */
+				ut_assertok(tftp_test_input(test, bad, sizeof(bad), 0));
+			}
+			ut_asserteq(8, test->error);
+			ut_asserteq(1, test->closed);
+		}
+	}
+	/* An ACK 0 still works when the server ignores all WRQ options. */
+	ut_assertok(tftp_test_start(test, true));
+	ut_assertok(tftp_test_input(test, ack, sizeof(ack), 0));
+	ut_asserteq(3, test->opcode);
+	ut_asserteq(1, test->block);
+	ut_asserteq(0, test->error);
+	return 0;
+}
+
+static int tftp_test_server_retries(struct unit_test_state *uts,
+				    struct tftp_protocol_test *test)
+{
+	static const char wrq[] = "\000\002file\000octet";
+	static const char other[] = "\000\002other\000octet";
+	u8 data[4 + 512] = { 0, 3, 0, 1 };
+	unsigned int sent;
+
+	if (test->initialized)
+		tftp_cleanup();
+	memset(test, 0, sizeof(*test));
+	ipaddr_aton("1.1.2.2", &test->server);
+	ut_assertok(tftp_init_server(&tftp_test_callbacks));
+	test->initialized = true;
+	test->port = 69;
+	ut_assertok(tftp_set_timeout(30, 1));
+	ut_assertok(tftp_test_input(test, wrq, sizeof(wrq), 0));
+	ut_asserteq(1, test->opened);
+	ut_asserteq(4, test->opcode);
+	ut_asserteq(0, test->block);
+	sent = test->sent;
+
+	timer_test_add_offset(20);
+	ut_assertok(tftp_test_input(test, wrq, sizeof(wrq), 5));
+	ut_asserteq(sent + 1, test->sent);
+	ut_asserteq(4, test->opcode);
+	ut_asserteq(0, test->block);
+	ut_asserteq(1, test->opened);
+	ut_assertok(tftp_test_input(test, other, sizeof(other), 0));
+	ut_asserteq(5, test->opcode);
+	ut_asserteq(1, test->opened);
+
+	/* The repeated WRQ did not postpone the first retry or reset its budget. */
+	timer_test_add_offset(20);
+	sys_check_timeouts();
+	ut_asserteq(sent + 3, test->sent);
+	ut_asserteq(4, test->opcode);
+	ut_asserteq(0, test->block);
+	ut_assertok(tftp_test_input(test, wrq, sizeof(wrq), 0));
+	timer_test_add_offset(40);
+	sys_check_timeouts();
+	ut_asserteq(-1, test->error);
+	ut_asserteq(1, test->closed);
+	ut_asserteq(1, test->opened);
+
+	/* A later transfer still works, but a WRQ cannot rewind received data. */
+	ut_assertok(tftp_test_input(test, wrq, sizeof(wrq), 0));
+	ut_asserteq(2, test->opened);
+	ut_assertok(tftp_test_input(test, data, sizeof(data), 0));
+	ut_asserteq(512, test->written);
+	ut_assertok(tftp_test_input(test, wrq, sizeof(wrq), 0));
+	ut_asserteq(5, test->opcode);
+	ut_asserteq(2, test->opened);
+	put_unaligned_be16(2, data + 2);
+	ut_assertok(tftp_test_input(test, data, 4, 0));
+	ut_asserteq(2, test->closed);
+	return 0;
+}
+
 static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 {
 	static const char * const vars[] = { "ethact", "ipaddr", "netmask" };
@@ -199,6 +630,20 @@ static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 	net.netif->output = tftp_test_output;
 	tftp_test_active = &test;
 	ret = tftp_test_oack(uts, &test);
+	if (!ret)
+		ret = tftp_test_data_alloc_retry(uts, &test);
+	if (!ret)
+		ret = tftp_test_duplicate_ack(uts, &test);
+	if (!ret)
+		ret = tftp_test_duplicate_oack(uts, &test);
+	if (!ret)
+		ret = tftp_test_stale_control(uts, &test);
+	if (!ret)
+		ret = tftp_test_timeout_range(uts, &test);
+	if (!ret)
+		ret = tftp_test_timeout_option(uts, &test);
+	if (!ret)
+		ret = tftp_test_server_retries(uts, &test);
 	if (test.initialized)
 		tftp_cleanup();
 	net.netif->output = output;

-- 
2.53.0

