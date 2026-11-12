Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34B606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KkPKibW6;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l9HkDo0A
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2AD76081A;
	Thu, 12 Nov 2026 11:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LyWCl_NfspEz; Thu, 12 Nov 2026 11:58:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 103B760B4E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484732;
	b=cRPW1rao/ppANwl3oBVJWTa9zQLdxnRLfX1D9Zb1TjIURUlY0now/do9898FQL5GaloC
	 i77AfKOt+bhs0y/Xg5KpxuyCxFW1vScm2yy56BpARGzhFzRfJt3CS4k8edjKPKrYkdm6e
	 2iSfkbcKfFesQuFCdMJ18V58rHLfAYmm0kj8Mgp8hvijmif+PEcq2yzw85t+IwzYYMfXh
	 r6KFnHyUVHac7gBDzPzP/XsVsqQxqUKwOWNWqQbiUi0FgFC5fGqH3LNJPkYeVn5mujnbv
	 mnOsedhjijqubXKTfT89Fhie4fU2Sn8UKCSPEUimwFvbK55A0Hqc4EkKDIYgKR+TnwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o8rnTJyssiqhEemckduhgZHiIR7nFpya/+BP2fremfs=;
	b=p9mIKcyGqoKm3cw6r40v1+BbrvFYK5K7gPmTWY+1tD+L1tnSEdCnhAYYm0Pj5MwhHdcT
	 m+/yQOYL1CG9foOSGaLdbH8z/b9FAkIFvXtENDZlUuz1u1MePI02k81IFQ6YSAAZ6D97d
	 gvMpcihx791JJenvcNp+oiCiyH/ZMD+UQqc8TROfeAl+R+SeI78NQlmanmA7lSVNGizHx
	 PpXmAa/pizviHrMnWaaSu7sw8gwn2DAotZnGyhQBT0vFofYDO2woQOXoA3YHnFC5Njtj5
	 x0N3tbtbgn8PPfQ0r8Wo9fP0XHdW+iTLH8FqbXJogJ6DWOaNJQQqVcNsxFc9JvOQ9rg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484732;
	bh=o8rnTJyssiqhEemckduhgZHiIR7nFpya/+BP2fremfs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KkPKibW6fUUlErJpVGFrO6SaqMLfeCBCqzCdvEW24RtZKXCjf83A1iToTP08tbbil
	 tudYE6BxWUTmNb5fzy8FFjWFmyZdWVWcdfRFpV7+YtP0zP0LLdt+jt00sYFNB/4aoc
	 0pyg+WFZetMulYQyzmAaW0TZ185HnK550QToT01DyX8F+Hb8WdlFADgz0Kc3g284kH
	 OoKP273VoqWzE6lPzoEiLFs7xR1XVe/7b7uX9uKFz9QXfFQtoiG9rZTICwatt2NAlV
	 YqIILgcRR7S6B8UMaoVkCVTWsiBk7ENtB+oGKb/Qw5MIRmkEVjGRwF/y06QV8D0TgE
	 kkKGg1t9l3N2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 103B760B4E;
	Thu, 12 Nov 2026 11:58:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A13471A6
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E0958156D
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UeWsCizTkmKQ for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A31648156E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=l9HkDo0A
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A31648156E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:48 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso29272065e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 03:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794484727; x=1795089527;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o8rnTJyssiqhEemckduhgZHiIR7nFpya/+BP2fremfs=;
 b=l9HkDo0A1FIDt5mJiHjtA6UpfzEITHvfo3LaOcqrk1GMMnht0E0XPjP2pWk5CvTvVS
 +4jpga4wIbneLhMOX8aawZQ1xW3Gr9+rmvr79I+pbPRF7DinlV6JmDLEQsajXYOrSt/F
 uNRt2jB/bvYU5cfW9fL3Byca9xBEYZZzVcMcN0jQ7Mj3cSF3HGIPkXZr6vd+iWjfbH7n
 z/LIF44UJeONN5rS1k+vfHly5HWnc7E4X/2L6M4cNZAupHSnA0M/yE9lo1XVDvs1+HAk
 zcd4TKVlAyFuWuwWDzFemPMFCJ1QZXO9yHK5vn5BqzDSULgEOnLQosc3EzO4H9polG4S
 1ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794484727; x=1795089527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o8rnTJyssiqhEemckduhgZHiIR7nFpya/+BP2fremfs=;
 b=He2rAM7ZdPkBlSy1ARzwHlSKaizf3+OKbrTya/kjZRu5HxMtccwZFmabeOaJ/tw8md
 ZbfuQGHYZ3douJ8ZHBFUaRh4E1mo4VrTedRey15Mp3I4sYqPkSHAwYIdyhZpdasYi92d
 TKJ9au1DppENyckcp1Z9WqDjH+SNtakGOawSLRxC6Ebc6oxmkoMmXFoPkKG/zAEwdMb/
 LsJ8pWNbOOFdUdwcbAhJXy/e2AxLBdUKdfK5Dkeq6fUPVYZvdzWWjBVvygrr8HsBnyE0
 yC+cRckMfwKduG7cZC6LVzVYvvWRsOBKTadPIkDvGBn0ciT2jjTdOCTeGKNM2868NTq8
 TN9w==
X-Forwarded-Encrypted: i=1;
 AL+hErH5RrDOUN7LSJheeLpFDKNkeaAGxYPmtbflU9PP4BoGpsHTuHoDu2s0H0qIin+ttvmNdIhPCNI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Bt/4lDnmj9Ew5YCazyPEBlMZ1RiirMjSFDsX5rXBYsnwqJGg2
 5tGfcKDxbMxnDEtlUzToXL+aG1CqFnz5dedIpvKas/Ic0gElJQNgcyln
X-Gm-Gg: AYBFou2rvKny1VtCX3d01L8FQIqCaHOd4b/tJQJ7vFGAR70XJJ3iJy293E2G2YvBD25
 qZxeznI6shqP02Ha+OReX36WOae8n2fixNjCKEgCG9tu7Su7yoz8HI+NivcDJpt2575qH1Wlko5
 nTvkgIf/qSbW6ZJ4r9D8LOoQyYuqWfhRHCPJaFS5yUpORnpv/PEkmhDFEeo4ZJyBRAUfnxIG6Pi
 Oc18fjFuYK3Yu+ZYzheGEN9kQvngcWINk/ljrA1M3NyvoHxnbF9z7blsCpzi6SLKdkUfy1F77DW
 lvyYEP+/v1vba7EQFBKlhk+TnKBxav1CKS6amZUoozrEB4B6Fah4yDMTHUIN/QFkzXMzzE9LMrj
 lYgetgXnjG5Mtlxqd1gNU3/Mh3niuemvy5GHU8TY+F3VCbkpq4Bn4bi0MNMFGCuNQ5/if6A1Hp5
 TNO9aso9JVNT9aseE8RlWr8wVwGPmx3ccSDHEARa5YNZu+Dkj5hXA6mdfBCqBW9eGX48sSYDCNl
 kT2eomj+bJ2attpsJXLK0oIMkU5ulXqfiUypcMzjuacVdrqrjzaG0Z9ugZvLOGajc+BooRzZMf0
 H6svB1RQvk9OUCeenHp8cZlo8IPO8IZ31NXiQh5ZXphAyR7oTliGJkKLr0GGXyqUtmqzN3llJV9
 cVsbL736zhPxPJ/vRZ6cAyGGdQFz1mGtkgWAIU4UtJsPrnSi/pu8ODLuX2HaW9fn64f9RQgnmYI
 9ok6JAKsiPSqDO
X-Received: by 2002:a05:600c:4f09:b0:4a9:18f4:925e with SMTP id
 5b1f17b1804b1-4ba09379eb5mr101143985e9.18.1794484726617; 
 Thu, 12 Nov 2026 03:58:46 -0800 (PST)
Received: from cypher.home.roving-it.com
 ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4ba08de826asm90878885e9.0.2026.11.12.03.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 03:58:45 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 0/1] MAINTAINERS updates
Date: Thu, 12 Nov 2026 11:58:36 +0000
Message-ID: <20261112115842.39126-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the departure of Simon there's opportunities for new
people to step up as maintainers if they so desire. If you
are interested in helping out in this regard feel reach out
to the PLC (Tom Rini, Neil Armstrong or myself) or other
exisiting maintainers in the community if you want more
information about what the role involves.

Peter Robinson (1):
  Update maintainers and get_maintainer.ignore

 .get_maintainer.ignore                     |  4 +-
 .mailmap                                   |  1 -
 MAINTAINERS                                | 46 +++++++---------------
 board/bluewater/gurnard/MAINTAINERS        |  3 +-
 board/coreboot/coreboot/MAINTAINERS        |  6 +--
 board/efi/efi-x86_app/MAINTAINERS          |  6 +--
 board/firefly/firefly-rk3288/MAINTAINERS   |  3 +-
 board/google/chromebook_coral/MAINTAINERS  |  3 +-
 board/google/chromebook_link/MAINTAINERS   |  6 +--
 board/google/chromebook_samus/MAINTAINERS  |  6 +--
 board/google/chromebox_panther/MAINTAINERS |  3 +-
 board/google/gru/MAINTAINERS               |  4 +-
 board/google/veyron/MAINTAINERS            | 15 +++----
 board/intel/minnowmax/MAINTAINERS          |  3 +-
 board/radxa/rock2/MAINTAINERS              |  3 +-
 board/samsung/smdk5250/MAINTAINERS         |  3 +-
 board/sandbox/MAINTAINERS                  | 16 +++-----
 17 files changed, 43 insertions(+), 88 deletions(-)

-- 
2.56.1

