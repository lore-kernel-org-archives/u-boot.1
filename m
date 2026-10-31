Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F41606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J6Fs2Mgf;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E8dH/uNs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D153760639;
	Sat, 31 Oct 2026 09:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z5RSrt4yAHgz; Sat, 31 Oct 2026 09:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27D3A60667
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439195;
	b=YSSjy3lEGk0QLyQ1zFnFOvTXZGnHLJQBqKCNx9gzkELy9OrqZyZ69ItIAMXKBxc6+0+O
	 d4mchr65q4hEkmCFICyQty9lzH6tsrUIvf2TY44vdXSmdYWbBBbO4O+04ITO6d0O1AUqm
	 K3CMQ6vEVs21dE6OAo73Y8tLq+QOzr4Dn8Boc5da9JBRuCxF6G8zyNPuDgV7P0a/hKp3p
	 3KdQQsfsWlDEqJzl3NTmcBOFM0I8DE+F7+WsLCElUsqc7HqN34NBUHrdtECV1Rhf6lvfg
	 uoFksOFsYUz3omPUsvnHTWPtHv/aAZh/LgIIcdHRqSlYjJZSpGlU9shP2D/e078UNxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439195;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7U4IsbZT4rEhYeV4wVXKvQPbZzP87Hr72lGgv9dg2tk=;
	b=X50+dqu0qonjHhj48NcWR9cmoblzl46hFZTWFPlnXcyFP5SXOVNEahPazxR3Vz6VrkCJ
	 lPlQGS3AI4+0qfwEsWtsEQWOV+CKv8wjrL/gLC+ltYZmRCmtSLNFzUNmrXP0yTe6dGYuE
	 7z6CqkmX6rOyS0gaHm0qBxq193MGLG9DKSvp+UI0nfSlqseiq1WGw24t3L+SaIOb7Hjbd
	 1adLPjQbo+4HM2P7vWhJwgbnPDShYiNtxQ2qwl8rdCnT6lFvi0CWU+4XQczxnaSbRFbjV
	 7nN0g6CFhNlzvQPfn/VlQgn7ax0tryRq3pQc6Y7HKHh/mcBhiZUB2vkVwkOPYsDVoog==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="E8dH/uNs";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439195;
	bh=7U4IsbZT4rEhYeV4wVXKvQPbZzP87Hr72lGgv9dg2tk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J6Fs2Mgf4/QMiQO1lHgT9lOlEXm5gcaP2fo8cuCjCtpnV+47HwWw69IHDaHrA3I4t
	 8Z0OyFqoh+ncxLRxgW1UE7fCZRe6TVuYfOIA0CWbI/e2RiMJ9+bS64BcWnr9V+ByVq
	 CceLf3hB/FsNZdhX8gDdqVTs1bspDafHtPsxImrTAtnEr9XebTD0rJKv35cWtxIcGC
	 fvCjFMAKOGDvdql+g8v8Yg42mz+l6wT5wS2rJs9wk9CpSbslXaht6zylWfeLZbrUqh
	 djlSv+I2hdjJ3ZUcrZ3W3T4IStEsQjbGf0pKELRUZCdZeV/h6vsJCXvtllVlSajq+B
	 HIQQIPH5XK5IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27D3A60667;
	Sat, 31 Oct 2026 09:33:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DAF6B2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CCEEB60667
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BUK0Y2BWDXn7 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:33:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 389F160639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439193;
 b=XQRD7tZIXGD5Xf8XU2wBmH6nP94BkoujfSQEbABW2i5kbIxrSdhf3Jfo46l2pPkhL2Fu
 mXSmOc66UMBOmlbWON4in2Grah4MqRLwhyF9uQhOYGRXKXEoCyVEk6GCyAMGYNBJHTio3
 AX34M0IlkhSxa2BYzHqhwhZTYhZt/nPCD+6sKOHDTjc+PZTWOcNEXHbKE8cH4Hlq+ftHM
 viaTmiLBZXg1915yaE25LMJ/sYHiZvPWYv9GEe51WuP6ZamczQN6FZ1f6hIgS7Hb1/adA
 bcLt6EePqkSUXOKOUpAgWNSXHqdnCzj4PZ/7ypr8mlebyH5Jm3vtZrSJ7CRSazZR7cg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439193;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=7U4IsbZT4rEhYeV4wVXKvQPbZzP87Hr72lGgv9dg2tk=;
 b=EOQeEBlk7Ubhjv57rdu++o3oAvBGzgJJmc8u2jBFQ2EdKjWa86d8+P84NIlwiAtey2Ip
 AbSd4xq00IpcEiwCe8eHFqSAHXIsne8Zm2TlyXFg0clOkjV/GPhMZGK312quf3fsCAT9h
 +9YVbtqUjQcNQehcEGjczXTqKCQTq3HNZulCRUF0/oJ3RYqc6nsbKPRlyIqOePfRNfDMo
 EXzTkUFo/dtBbzrzw/fK1BylNGHJDvNgBFMSSOm4LKXfhMY3X2npe0PyXO4GFq3RffXQd
 NwQJ1nHiC9QWoWQXV/P66AVQyDwY1E76xisfHywnrHORQWF1DZIjR0jdaeLCZ2OzGBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="E8dH/uNs"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=E8dH/uNs
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 389F160639
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:12 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3adac5b29ebso964865a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:33:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439192; cv=none;
 d=google.com; s=arc-20260327;
 b=UTBlT8Yf5Xchf3Ss83bKA1pLBgTcVAURmS6rtmvyLvJU5PkfAGwxQWZqNc/UwG2nXn
 1ubQMPWvMlhtxTH+yfCwl3chhnqzETHfXalGFNWgKJfkvIGVUHXLUuSvsRGU8BqlQaNd
 k3Qod1pkDP+XvNyfzURKw0NeTeoA9fbY5NYlAsXOOrxCghBY+9nTu7zi/yABv/RAUzhI
 BqmoV0OUOLLspR26mjq3q64sm49Ftu1sO2H+1CwoLcbLe7p2HLfBXXC9/k2gNlXk73FV
 /Almf+4jV23nSITkMMr6SUzpSPVsxMoj/ysAaSUPdcxaf+S4CBR3beJbuGerrnYCp+uV
 ifNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=7U4IsbZT4rEhYeV4wVXKvQPbZzP87Hr72lGgv9dg2tk=;
 fh=Ww6xVWcAIQVsKLdZmXM6vq3HXwFFi2lg88aUY4FeYrY=;
 b=IfSp/nS5kIzPKi5+AOrVAM7TL44symhKLKMc4RRg2MkMKf0faOV+hLUVAdBPGJLPYW
 wnHzh8Unvqa64uBfN5I+M6PK9aF6NC8vGcRfsq4iFZe84+dtIg9jA2LhFIWkY+5wsLTA
 rhjTCYNkyQFUtAKSv4jaUEpNZgt9foT7EXKpwoWHvm1T8OrHJCiSfOPix7d0wtkx4buy
 HGKJ+Y9AklSPZzljgEG+OJKX+bTt/r56hTmPt8vODL8qolbv7EO2J1+dOhzsdjQ6SS0C
 OjmRD/Q6vTpYycgZ3e70v4aEWOvjyAOHCU5UbRAZVp+ZdWlgTDpNhFIrg0rg7fmtUIIb
 ph+w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439192; x=1794043992;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7U4IsbZT4rEhYeV4wVXKvQPbZzP87Hr72lGgv9dg2tk=;
 b=E8dH/uNs2p6EDCeNMTPCpipDvvQv3vUZ0mk5fX610GcpTkhD6+z6iBB5R3s08k8Qgw
 AuYNY8Jtyb3HjQlGoFeL52XQD/fIO/v5JYegl0BcuAgEadwYaN7l1kUkzpzjRX1Nem3R
 1QPSaplY8K0+dge8PDv4INenoiHGyyxbalNPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439192; x=1794043992;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7U4IsbZT4rEhYeV4wVXKvQPbZzP87Hr72lGgv9dg2tk=;
 b=iLa3KJ11kXUbjN7m9I9b5PiO8t3wRjmRDeMFOhbksV0RjFHqbX0ZdasK27tamzH/dN
 USYXoYVM8O4WIYU32AKcPVZDpvH/k6ZruUJh7iSvoXjKgDyZEK0g79mMwXBCTArq3ADa
 4fmrGa00Qo6WoBOoeYxou6KsusEOOhf+neC8vJLKbOw07F+TX/tzO3GkKsD7IMwylhqm
 W9XymVrvLhKqGrldDDmXAOPNpOTbh2ulg14JzAg/Lk7gYETTGZ8asC7bkxWt+7zmjVGX
 rePE+4i8COyrRUJM1LysDzILEuTNWqF+QCaJL04Owg9sq5SC0EiJUDeDtTLtMzNXozep
 XcUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhAqM/8w368Cw4SHptMrllTDdcB57iS5ISSOAvZDh2oj2kBuwvUxRSjHTwJVxVmBMjwhGrMHY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIX2yjH+LrFyzfoEcRRIpcEWdz0HUPcTs9pEIESw/nPSEJUUplV
 XkQf2xCiRt0Frb5W7JCFzGwBHiQZLmDbosD/RB22OHjhgzz18fnHCSoe/kjk8hx+nlugbQnnWgf
 ihr47LuCMQVZ0e7TpyQqilHYhyJvgjVlfI4d6VVN751MBU9qnfr+45Q==
X-Gm-Gg: AYBFou1CCB6VfhiZUlZAAVUSxoFzel5xpkRIbL+K+2qKCv8YoUGEd18g3t1DtnYKg7F
 oyLu+Pestzzg127OrpncvZVkOUSMmr9RmPbdqYVzmTver3ooEtvUZr6EE8Fi62EbaZ9RCbmi4/G
 vuaHN4rdS8vfdDdEuj9NfDIcUunY87iNz47OX97nlYtTRFfXlvgia9ueZoVyWB3KA2msAjgP+f6
 xEJiyQBON+rNSoGuFzqJcPsyFYn1+jQms5SdJQmYcbEVqDR2z5CDGDioRoa6eJDkLj3K8Lj9PAS
 B54xxlTzulQdMGm1UK23iUTGqJmGvdgFTD54Q+YSRtnvkbupDiZgL6UGIwG0psE0un71Vr8PBx6
 yqxO9anEzcOsNFLei8xkD+ROgcg3VKuiTNrR4zwXOcUEdpZ1YxI6EdIUVRmqBOWwoIMpqnhs=
X-Received: by 2002:a17:90b:5250:b0:3ab:d45c:59da with SMTP id
 98e67ed59e1d1-3ae897936f9mr3975696a91.40.1793439191933; Sat, 31 Oct 2026
 02:33:11 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:09 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:08:57 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-1-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:33:09 -0700
X-Gm-Features: AclHuK973ye11xDgll9iAE2rwNz27XZtwbKZg9bR0kONBY6Ip4OR6tE7Kbn8VPg
Message-ID: <CAFLszTgT31tNCvsJ7+MRvm0LfMA4FCWcx85hFj8=TE_W3pWjsA@mail.gmail.com>
Subject: Re: [PATCH v2 00/37] rockchip: Miscellaneous RK35xx clock fixes
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:

> Some of these fixes have only been compile tested as it involves clocks
> or rates that are rarely used in U-Boot.

Please can you say which patches were tested on hardware, and on which
boards? Patches 1 to 6 and 14 change PLL and bus-clock setup that
every RK3568/RK3576/RK3588 board runs at boot, so they carry more risk
than the one-line copy-paste fixes. Knowing which ones still need a
run on real hardware would help the people testing on the various
SoCs.

> This series fixes a few trivial copy-paste mistakes and other misc clock
> issues for RK35xx SoCs.

Within each SoC the fixes are mixed with cosmetic changes (the macro
renames and removals, the PLL-table alignment, SPLL_HZ and the GRF
lookup drops). Several of the cosmetic ones carry a Fixes: tag even
though they don't change behaviour, e.g. the PPLL macro renames, the
unused-macro removals and the PWM0 shift change, whose commit message
says as much. It would be worth moving the real fixes to the front of
the series and keeping Fixes: only on patches that change behaviour.
Then the fixes can be picked up (and backported) on their own, while
the tidy-ups wait for the next merge window. What do you think?

Regards,
Simon
