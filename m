Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C54606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DW1TDwIA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S53p2wtB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8CD940620;
	Sun, 25 Oct 2026 14:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9oogz4cF7EA; Sun, 25 Oct 2026 14:15:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A4AF40E34
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792937734;
	b=MHVBzeT+8IHZZS60wT/mchAvqDAlXI71jPah9uBGmoeYB+2f032Kk3ds2L40ntdjc7wg
	 4lYmn+MvRPcZsBPFzk0LgaQBSQIdYnoOTar/T03Q8fRFJIZzT4cX8iYDOnR65mYLBk9cm
	 QerYRWmPhTaYBRz8CnGHBJFtBPcxLhOwVtubW0toaMT3ygZmIMAE8Lipv809nDH67kQyi
	 CHzmc8RVubXZfwnpGHjG0xM9dj4537Ilys5+Tf1pOUzjvOCoSUptTIsGa8Kael5Wtr/1S
	 Jrbx5y90khVtsb2cqxmynCc1xiKUtxKjPXzi2j8LqwmshllXNC8ymdWkZeNWmCrry4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792937734;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bG88ZnJQwapt9k1fFWYsKZCiYrHhFlkXT8DVl6EPuBM=;
	b=NkBwQ1odHUkMAmD8cEKwLNWlZGq5V6qOzEF3AmBfZimDf5VPmRHqikHDe8g0B528xiXq
	 m6TaKr8YqRm1iUHwoAlAXRDO4iSgLkuEt289o6VBYPpUK+/tszjqNSacgNqADgbnYaAP7
	 IUYVA2DTPfd3JrCr4sNUiniKYxhBmM74WXsYUkwe9CvuU4y3QzWMkvG4DZhweuUm2nz+m
	 /nmr/Dbw2g+1fRy3YQW5FyM92+rR63ikjEtxdyLVNJp5GHFFu3G0FoP+s7VptInTkv+pX
	 lomuXesjfEq/r0JE9MuQivwixq5k22woByCjBmj9Uyi47Gbd77PvWucC2wdc+5N6r4A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S53p2wtB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792937734;
	bh=bG88ZnJQwapt9k1fFWYsKZCiYrHhFlkXT8DVl6EPuBM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DW1TDwIA9nPFmAfitsez8OVb5lo2JSwE68l1GeOCyJq8ATduFioxSVo8WjW3LPTbC
	 HhpSinA5jV/pdRBI9ITj70l5F01fFmVUVpd0jB5mRYvUJQ9bu/BqhQbchbSh2mcSc3
	 zD6vHkNOyylRfZTEBbhMGflB+5HnZ92pHijfB3+6hogbocqhNwE1a61e5Zk9ho5JrF
	 TdaEk406IYxbo0zx0gHQkvdZgHWvY9TtO7+gFyzq/Dq25ggv1Q1R6Yk6lotTxPUEOV
	 WlpGPvceql6PNtqHb2JKw4QbNHVShdek4MW7SOvGTOR7IRXKxwgWrwn4xlArzHv0Zj
	 RBzQZOSO+e/Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A4AF40E34;
	Sun, 25 Oct 2026 14:15:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E1D52C7
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 10:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B9834065B
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 10:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wpdf7--mB28g for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 10:26:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4F8C34066A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792924004;
 b=ZVnSy6cSnZzSMEPA0QCIcN1GtiCAXqIn1zIJgCs88N/MrO7TH4LTCSy51X19yKetpTJv
 R8IwJasYSlB7Lg114DDlRlkzlbd4ZoN5PNadFZrhxkANoN6K1k+8EJ41MBnGiLIxhdKCp
 0PDqB7OyuOudM5Wi2Ptds3Mm9pwDIxR33gVbJLSIfwvrkUCGR39TghL89Sy6Kj25PLVNg
 1nQAeZMtw2DloiibH0+2twdRtaDxqI1EY1vt9KaJzZ6Chd59tyxk+W5UU1d3ZL7uHDIS0
 Iu8GQeC1jiMvl0VgNkS6sUT7ynwnZJD31r71HAYtI5ImSJscms0poOlsfQ2vjKTTE2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792924004;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=bG88ZnJQwapt9k1fFWYsKZCiYrHhFlkXT8DVl6EPuBM=;
 b=AlayQpsiuTWOUy+nw6swcpqRwyOaKvIJl4nNa/Kf+qUxydfuCjhXivvL/9TNP/6LIHyu
 9A3wp/WqeQqfK5K+I2Lu86H8/J+KKXlkvVZ2MPH4xp1AcFOl1vhQLMeQG8WE7Ozaf9brD
 ggsisYZqwW8eJXCw4tKwpie4/huO9jvoJ+y217bL9x4cEXd88x74lIy8tz/at+5VWkORg
 fN99JDYCtylXNY0homGiI8nwFk0uuBaP7rGotnlk8nbTG8bQOVTeQBYQZcYAwTbPpV2xa
 kuIf1IAv8k5zI0xDxctac/qtP7YX+ArsOog60BEpsbMQSsVuctK2XXQNmhECumFC8Zg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=S53p2wtB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com;
 envelope-from=vikrantyadav4802@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=S53p2wtB
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F8C34066A
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 10:26:43 +0000 (UTC)
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-16079d54c17so1382664c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792924003; x=1793528803;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bG88ZnJQwapt9k1fFWYsKZCiYrHhFlkXT8DVl6EPuBM=;
 b=S53p2wtBOm7d1Y+47vjgyeC8gmh5b+vLM66DiSoIq8GMAbC45AXXwbo+F/C+trfJ3h
 IJ3vyfPW0KT99DCXSQCbwCNvzDs+fSLONQ7tFvn0nDFmOR2p36L5TqcpvpwZJMhKPVy8
 Btzq8T6gf2UlbDwKiuSTkznwK9FAA6fIqrmjGNOyArLVMsIrcjNHpQr8b10LaBm5arN0
 G5h0LT7yxiQ3N4WegcDpx/TAfv2ZC0anVdP0WUUJ7SmZEEDGr7pdHop7hTlM4dtRKcW9
 ifH8WwQ7cEXIQgYVFHzHcOKEAlFWlj6BLFgLLJrSPjPGuCoB79gAAt/aOyljKAcSuuvF
 be3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792924003; x=1793528803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bG88ZnJQwapt9k1fFWYsKZCiYrHhFlkXT8DVl6EPuBM=;
 b=lnN/TRpHVnSpXbMLiimfHKb6BDP726br9RDP3tQpbOpG3w6HRrOrVCxYsgWRuw4CCe
 zhVcJGvs3OVKrMiHHSKzzhE/BoWxY/nxVhTj+U2C+mxqD0Ik7J9CNxIvpBc8a6rR+cGy
 Vvpo9NyrRHMLPEFAMATm2DxjzQNe9Hj1jAw4+KDDghVwqXpX2RzUiYdp5f6aJvhqw27Z
 H7xV3OcigsEvhUcJVp90z+152d/1h99k2i8861hJUnuaSkKNOM7/CH9EBPBwQyJ/xUcL
 7dyWaQsuT72rII7s1eCKCrHXxMKaoIn96tv6DnQPc0EIw/Kkr6hgUVl117P53EYznNRU
 oV7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0H/lwnI+/+HhbMQsH5AacyhCFe3oMjFtbXDqZoW1aeM2zLXGh0sBkIEl3wMlY4nYgPkj6NgI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLQyy17grFlf1CMZAdmkrfVjAkZWy/WSRAT5C4Gtt/vKgUXjY5w
 vMCaIuwSBru4ySkXkpMVkmhvsNqY7ExtWZLGwUXHqR6aXGnjhz9AVz9H
X-Gm-Gg: AYBFou3AZO5W31eEzINwg9lQpSoIvtxw6ejNieIJVEPS14RQNJL1Bg1M8SBF02x7jZA
 RcakR1bJ8dByCaWr4sEYhj043/VYv54aXsu8V3BQeX45550WfAAIjWBUwQ1UkItv9No675fVGNh
 HWYJzMSpUrdiY0TMJgt3Njuf2j3BFetu4SnQFDcZTs2lIR0Od9SBmdTtsxzhrGEG2WrEzA4z43v
 1I+qD4jnJxBiyuNzzrJOmQ53nTJJ65NVK5KOEFb+pqmM+BbbZgzZyrtOReTPLdMv1sMlWFuz0xi
 ECQleniV5SWExEQ8LUHT4JfdMC029rm+7cyAfGPfqaWYK9KuSSNiF9S7+sVjkQTbMh/LaScuH9J
 1JiUpfGTK4vU5nIHpvtS1CaXvuLwrGGyx8rhr5QIhQJb7n8oMQB+UXm2SXR4qC361LtLs5WFke9
 MHlAW8UwYT0qv+jGXYMSBZMqZZDz+y7vA7//uQSvTJwPqLXph103eHEJ7kUmGRbY+9SZu6eUsnV
 +WJ8pdccjmnSv7xF/zwVx13hwFStMzDTzE6bl/PS6IZTh+QZwTSLi2NDRVgQVbFC7wdeQkwQ4ss
 dAx0
X-Received: by 2002:a05:7022:b883:b0:166:af48:a2ba with SMTP id
 a92af1059eb24-1991b9e5d21mr5442911c88.0.1792924002629; 
 Sun, 25 Oct 2026 03:26:42 -0700 (PDT)
Received: from localhost.localdomain ([110.235.239.152])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm18923825c88.13.2026.10.25.03.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 03:26:42 -0700 (PDT)
From: Vikrant Yadav <vikrantyadav4802@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 u-boot@lists.u-boot-project.org, Vikrant Yadav <vikrantyadav4802@gmail.com>
Subject: [PATCH 0/2] pinctrl: airoha: fix pinconf_get and pinmux_set
Date: Sun, 25 Oct 2026 15:56:32 +0530
Message-Id: <20261025102634.53851-1-vikrantyadav4802@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 14:15:31 +0000
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

Two independent fixes for the Airoha pinctrl common code:

1/2 airoha_pinconf_get() always failed when reading back a pull-up or
    pull-down.
2/2 airoha_pinmux_set() matched pin names against group names. It now
    resolves the pin to a single-pin group of the requested function.

Patch 2 changes what "pins =" accepts when combined with "function":
multi-pin groups must now be selected with "groups =". The binding
only documents "function" + "groups" for mux nodes, and no in-tree DT
uses "function" at all: the Airoha DTs only have pinconf nodes
(e.g. drive-open-drain on pcie_reset0/1), which do not go through
pinmux_set().

Both patches are compile-tested only, with an7581_evb_defconfig.

Vikrant Yadav (2):
  pinctrl: airoha: fix bias readback in airoha_pinconf_get()
  pinctrl: airoha: fix pin lookup in airoha_pinmux_set()

 drivers/pinctrl/airoha/pinctrl-airoha.c | 46 +++++++++++++++++++------
 1 file changed, 36 insertions(+), 10 deletions(-)

-- 
2.34.1

