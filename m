Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5E606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OY/xU0Jf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EOLRIrFx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 496BB60729;
	Sat, 24 Oct 2026 22:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CVhnjQvRlhA4; Sat, 24 Oct 2026 22:35:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4FDC606A6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881339;
	b=cvuX348C6VjNAZ4bhpxHsJP5AwiEJvuR2QyxGeFDTGCNSokxh1eZXXpaKk/5+54p5XjS
	 qVFnTWYe7fNrw/CTonsmra+cZgxMMI/y1ueW//IDrQjow2zpF+HtAQTgR5z/ZVLCixPb2
	 6nRFnW6SGYXOVPqIZNLdODm3JvvuzRu26YiC43cXA1KC62C9KizPw7xWGLc9l9zIFX+tK
	 4WknhrCr3pF2+xav7UY8s8LdlJ7ie4KxfG4ZWjFaNEMIG0QcYJDdWNanXqOGdiZ0lkXUA
	 EJXELr7nQmLM65NoKiH1ishDfOGacqCRVlewIkoo2gKhjm/0693AfzBm78I30xQM+Hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1bzFqXkAcL2A/JIdSHhHGGxkijIr//LVeWAfeImYP6A=;
	b=FiB/TFFhmFuuC7wjACyBcdUlcLlwmvL6ShMo10VNXqOOSFOBcRn9ycpTNx4ijYKi6Chx
	 kqX55iMl+Zwyh1+FGrafj61+HtBV52dtjj5QZuSIiyF7QIM/A1X2OhG4ZMcynQoCsbtw9
	 7jKnB316oczbKrH2VjjTEZhOEjZoCctKJTKCPIz32UfxDXWRFkitsOPXn283KsrFzrBLM
	 1S3TIARtVmrbcn82iGTurkc/Rk2HW/tvqq55kyrIeroxgFWleijRrq3m0zQ39bFh0LjH7
	 LeN2z5Scm6Z3MIWI8TE+s3QdYo+kIgFMcYRdEcgoiuzA8OfhfoS5AmYEUsE7xrFXnQw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881339;
	bh=1bzFqXkAcL2A/JIdSHhHGGxkijIr//LVeWAfeImYP6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OY/xU0Jf7SgGxLWvHYpANJrhslxyRrEX2Mm+Dbl8hASL4iYAGMLw0Bn2+L8RWpTZk
	 RLc1VK3XUpNuR+cvYREUl0QcWcF8ye/f5WTZTtbN4miJIGWgq88IvjlRegw5IglWYk
	 bm9jGPwJjXB73gH8bCgEpPqRfhs94iR3SLNbBkzGaND6sxTb7FDlvVwBVhmMLF8xRK
	 8/WK1L0cjtrGBOlOh5IgJeZCUhO+gVF9rUo1gJR74MPPo9QOQnvqZNEPJZ+iqZzcbx
	 S1HJTQsNMBQHZ3L1X5fFDo0+ssxKOcF32BcwZs+t8o5tiSyBAZMG8+JpUFpWqyxMnt
	 SsMPDISFSIaoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4FDC606A6;
	Sat, 24 Oct 2026 22:35:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E9360380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB52440079
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id flDjfuFhYGbV for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 695254006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881330;
 b=pu4uu5KKrBApum8Bg8hstOOwpOzAor/fE/a+WNlcb7IzjuY1UAWEBXMVikSUmBtWqfaV
 y3ci3Oaz7t2LeIzLhYag5uc3q3+u56NVTO9cN6KGQ1lep9HSMspxbMonUYjOMgAmdjG7T
 XcENfUAbgJN7YM33y798whhD7QdlIREmn0pa2VO9hO86OMSbYNjdoNUidX3pFL8QcT5Xa
 FJxx2j6p8tFOhdyWbCnEGRHIVVDEVkdR/u3Ll6UbzgmBuBClVGLQqyKOvcICyvxbgcQIZ
 0PEbSoczhmMSoeIKDVJDZ0cYh+IKksn7PRPWuzd+rsVUaXuwpUAjqwSRKiAJ7nyDKWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881330;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=1bzFqXkAcL2A/JIdSHhHGGxkijIr//LVeWAfeImYP6A=;
 b=M4bhaw+6/8kYVKfJ/P0GuUMemtVP6sHSvc2d0bqbxWZcAgOq7gR0/z376qnOfyQIhtY3
 YxMvrAV21vC3da6xdope7R6DEB29ShUPptGgXlxnywPURCkba1bczlC6ojNhxampceaB2
 ZxzA26iJtoHCEljviWJyYmWKR1BjqyXGe6l4ZFfEFylt+qa/W/sil1499NH1mZYaKAXLg
 0+cIY6KM9cC1B13IHBS/9wBvnf28AF5WBjN+w0dCnNfKH8wX8p0Pby6L1d8vrge9ZGoKK
 HUJWHCYMVKPVnObRvGIFimWXlTtWDLlSNUo3IpVxkZJ67/x4sv4ruCQ335sy9bPWkAQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EOLRIrFx; 
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EOLRIrFx
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 695254006B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:30 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-46556b9e02cso1271948fac.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881329; x=1793486129;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1bzFqXkAcL2A/JIdSHhHGGxkijIr//LVeWAfeImYP6A=;
 b=EOLRIrFxgM6VZiqaRIXkuwYfIME5z+MRX312WsCih+Kji8GKGdxEy+Npv7gDtwAkJ+
 yl85Z4QxlGS3jwqud+xMoGumRhkJQdkWgNZZaA2FT+d9C2pJMF10wQJKdJuz+2FADvyC
 0kZgtis0ueZ1ITQ59mmjtYiG690TZBEfCULq92/Qwl2FhGbkZ4uPdolQlUhuGLnTuTJu
 ZopC3IoNmZTp9HlS2wYCBjuaD8Sm8svVxNdYCdOY6Nf6h7Ghv4FkhF77cvNuK48pen2F
 k6xjRHBVIXfd48hGUGRpYeH/xyxOdPmbYr1M03eqpoIK/xpgzUghUQdfYZO7SjSKzF4v
 vpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881329; x=1793486129;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1bzFqXkAcL2A/JIdSHhHGGxkijIr//LVeWAfeImYP6A=;
 b=pV0PI0yP5JjRu4WJHhCMPbkgVta8oJJ5MeuRYS1rjd5lOqgAcEyu7ZolzOX7bnCMcF
 yF0NtbmYkwv4sK58ehmEsIYeKPdAgb+Ej3VINLMGfya38qXHKhZzuO+UzHSjZK70z7Nt
 6AbuM/hO2s4j5qtfSnsHaGv2r7CIjnIexVdTGTT2yJkUKM3tYCOh7Ki3Cr3XrTOoB5W6
 GZYbFh81leTMq+zuc3UzNtU8cB7IeR2fTT886B7gT9/nKyYgNarMydPaP9U3TnEQCxAU
 tyX+2ZU87zA+kiXmMYspUUKiPqZ0v1VWTv91HMmQszR50MFjbfTXpsVOClrLSKTIKQva
 lKVw==
X-Gm-Message-State: AFq9FYK0aVNm55IjLGdf7U005/DxsLianIbrq2jb9/rMIn1NbXN4H2aA
 eUwR5ZUyJRKeNKNG5CnLnCP0mOlJi6gcBQTxxDB5OAV8to/+kJvjXL0R
X-Gm-Gg: AYBFou3INfPL2ihC0igxGWWRA7jxDft8/pgY1e+wEgBs+9Fi4Hy2HobaQ7rLvs6gCTW
 48bwhtcHtftjxvY7y9RSLHaAQcZl1DsUAGJULxovRsfUCkxg19C4vR71ab0qLO96R4hnovBZhUs
 Q1Q/PmEZgun5WD639oVKuv/0MiRXK0fQXKMBDJKJbGyK0E/Fr1z8Pnx9d+FCO0oE1MlAZw4R0Ox
 THViWPWq16Z6+lp9HbHyXHJOroDkFJyw6/yXGBC4/cnbP1IwOkHgZsqkg/YYxtM5guadm+J2XnX
 U5D2IDMDq1EseNtC+HDNl/xheQ4R53a56x+C2FHzu5Z42zUfc6u6DnT56wL0hr/eu8wsXPxTbUK
 vZsMiqXWdmOkoRo2s+0bqZ62caDJywm5VSLeHufvNtNnvt3zerRqmHT5Uw5XhxwK4Y6/XTUzUBh
 jBvRnDIP93yKOMxHv303zm3uEk9wLzxx5ZtzzAHwKHG9iXwdDRVo2rRUnrWh8JOgQ6iUS+VDnZG
 Zi4V3nEm49GELbevdwwf1BSHnBxquOqe/idpMlk7dCKVK3r6y/ylzREHylrVyN7rdB4rnJUSVAQ
 TfKG75Ff91i62Y0z0mYegAsfvCf945vHpw6nYT0rFVif4Fl2MSdiM8nB8IMGT8aabfEA0sCEaDu
 FmgfHLS3SwA3Vf49OPEc1bYb3hEY65p296PcOcnBXJr9J/WoFhDqcqmcqHGipZY6ST7B/hEkW+O
 CDCR0=
X-Received: by 2002:a05:6870:2252:b0:470:e97e:8f8a with SMTP id
 586e51a60fabf-4a83f588ca9mr1413247fac.26.1792881328999; 
 Sat, 24 Oct 2026 15:35:28 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:28 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:55 -0600
Subject: [PATCH v2 08/16] net: lwip: tftp: support RFC 7440 receive windows
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-8-0f663f735ee8@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a receive-window setter and advertise windowsize in read requests
only. Validate the negotiated value against the requested bound and fall
back to a single block if the server ignores the option.

Deliver in-order blocks immediately and acknowledge the last block of
each window or the final short block. On a gap, discard out-of-order
data and acknowledge the last contiguous block once; a timeout repeats
that cumulative ACK. Restart the window at the cumulative ACK, preserve
the retry budget on sequence errors and handle 16-bit block-number wrap.
Memory usage is independent of the negotiated window size. Uploads and
server transfers remain stop-and-wait.

Make TFTP_WINDOWSIZE available to both stacks and honor tftpwindowsize
for lwIP downloads when NET_TFTP_VARS is enabled. Validate the RFC 7440
range before starting a transfer and preserve the single-block default.

Cover negotiation bounds, unrequested and duplicate options, server
fallback, cumulative ACKs, missing and repeated blocks, timeout
recovery, short final blocks and 16-bit block-number rollover. Confirm
uploads do not request receive windows and that window-one behavior is
retained.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/apps/tftp/tftp.c                |  95 ++++++++++++++---
 lib/lwip/lwip/src/include/lwip/apps/tftp_client.h |   1 +
 net/Kconfig                                       |  18 ++--
 net/lwip/tftp.c                                   |  12 +++
 test/dm/lwip_tftp.c                               | 118 +++++++++++++++++++++-
 5 files changed, 221 insertions(+), 23 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index 49749fb8262..a2c82ababd9 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -97,6 +97,9 @@ struct tftp_state {
   u16_t port;
   u16_t blknum;
   u16_t blksize;
+  u16_t windowsize;
+  u16_t request_windowsize;
+  u16_t window_count;
   u32_t tsize;
   u32_t put_tsize;
   u32_t timeout_msecs;
@@ -113,6 +116,7 @@ struct tftp_state {
   bool oack_pending;
   bool request_tsize;
   bool put_tsize_set;
+  bool rx_error_acked;
   bool wrq_pending;
   char server_fname[TFTP_MAX_FILENAME_LEN + 1];
   char server_mode[TFTP_MAX_MODE_LEN + 1];
@@ -204,8 +208,10 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
   size_t mode_length = strlen(mode)+1;
   size_t tsize_length = 0;
   size_t blksize_length = 0;
+  size_t windowsize_length = 0;
   size_t timeout_length = 0;
   char tsize[11];
+  char windowsize[6];
   char timeout[4];
   int blksize = tftp_state.blksize;
   struct pbuf* p;
@@ -226,13 +232,18 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
     }
   }
 
+  if ((opcode == TFTP_RRQ) && (tftp_state.request_windowsize > 1)) {
+    sprintf(windowsize, "%u", tftp_state.request_windowsize);
+    windowsize_length = sizeof("windowsize") + strlen(windowsize) + 1;
+  }
+
   if (tftp_state.request_timeout) {
     sprintf(timeout, "%u", tftp_state.request_timeout);
     timeout_length = sizeof("timeout") + strlen(timeout) + 1;
   }
 
   p = init_packet(opcode, 0, fname_length + mode_length + blksize_length +
-                  tsize_length + timeout_length - 2);
+                  tsize_length + windowsize_length + timeout_length - 2);
   if (p == NULL) {
     return ERR_MEM;
   }
@@ -244,11 +255,14 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
     sprintf(payload+2+fname_length+mode_length, "tsize%c%s", 0, tsize);
   if (tftp_state.blksize)
     sprintf(payload+2+fname_length+mode_length+tsize_length, "blksize%c%d", 0, tftp_state.blksize);
-  if (timeout_length)
+  if (windowsize_length)
     sprintf(payload+2+fname_length+mode_length+tsize_length+blksize_length,
+            "windowsize%c%s", 0, windowsize);
+  if (timeout_length)
+    sprintf(payload+2+fname_length+mode_length+tsize_length+blksize_length+windowsize_length,
             "timeout%c%s", 0, timeout);
 
-  tftp_state.wait_oack = tsize_length || blksize_length || timeout_length;
+  tftp_state.wait_oack = tsize_length || blksize_length || windowsize_length || timeout_length;
   ret = udp_sendto(tftp_state.upcb, p, addr, port);
   pbuf_free(p);
   return ret;
@@ -406,13 +420,15 @@ read_option_field(struct pbuf *p, u16_t *offset, char *field, size_t size)
 }
 
 static int
-parse_oack(struct pbuf *p, u32_t *blksize, u32_t *tsize, u32_t *timeout)
+parse_oack(struct pbuf *p, u32_t *blksize, u32_t *tsize, u32_t *windowsize,
+           u32_t *timeout)
 {
   u16_t offset = 2;
   unsigned int seen = 0;
 
   *blksize = 0;
   *tsize = 0;
+  *windowsize = 1;
   *timeout = 0;
   while (offset < p->tot_len) {
     char option[16], value[11];
@@ -435,6 +451,13 @@ parse_oack(struct pbuf *p, u32_t *blksize, u32_t *tsize, u32_t *timeout)
         return 0;
       seen |= 2;
       *tsize = number;
+    } else if (!lwip_stricmp(option, "windowsize")) {
+      if ((seen & 4) || !tftp_state.mode_write ||
+          (tftp_state.request_windowsize <= 1) || (number < 1) ||
+          (number > tftp_state.request_windowsize))
+        return 0;
+      seen |= 4;
+      *windowsize = number;
     } else if (!lwip_stricmp(option, "timeout")) {
       if ((seen & 8) || !tftp_state.request_timeout ||
           (number != tftp_state.request_timeout))
@@ -562,6 +585,8 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
 
       tftp_state.handle = tftp_state.ctx->open(filename, mode, opcode == PP_HTONS(TFTP_WRQ));
       tftp_state.blknum = 1;
+      tftp_state.window_count = 0;
+      tftp_state.rx_error_acked = false;
 
       if (!tftp_state.handle) {
         send_error(addr, port, TFTP_ERROR_FILE_NOT_FOUND, "Unable to open requested file.");
@@ -616,16 +641,28 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
            */
           tftp_state.tsize = 0;
           tftp_state.blksize = 0;
+          tftp_state.windowsize = 1;
           tftp_state.wait_oack = false;
         }
+        if (p->tot_len > payload_size() + TFTP_HEADER_LENGTH) {
+          send_error_and_close(addr, port, TFTP_ERROR_ILLEGAL_OPERATION,
+                               "DATA exceeds block size");
+          break;
+        }
         pbuf_remove_header(p, TFTP_HEADER_LENGTH);
 
         ret = tftp_state.ctx->write(tftp_state.handle, p);
         if (ret < 0) {
           send_error_and_close(addr, port, TFTP_ERROR_ACCESS_VIOLATION,
                                "error writing file");
-        } else {
+          break;
+        }
+        tftp_state.window_count++;
+        tftp_state.rx_error_acked = false;
+        if ((tftp_state.window_count == tftp_state.windowsize) ||
+            (p->tot_len < payload_size())) {
           send_ack(addr, port, blknum);
+          tftp_state.window_count = 0;
         }
 
         if (p->tot_len < payload_size()) {
@@ -633,12 +670,16 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
         } else {
           tftp_state.blknum++;
         }
-      } else if ((u16_t)(blknum + 1) == tftp_state.blknum) {
-        /* retransmit of previous block, ack again (casting to u16_t to care for overflow) */
-        transfer_activity();
-        send_ack(addr, port, blknum);
       } else {
-        send_error(addr, port, TFTP_ERROR_UNKNOWN_TRFR_ID, "Wrong block number");
+        /* Retain only in-order data. A cumulative ACK starts a new window
+         * at the first missing block, including across block-number wrap.
+         * Do not emit an ACK for every remaining packet of a broken window.
+         */
+        if ((tftp_state.windowsize == 1) || !tftp_state.rx_error_acked) {
+          send_ack(addr, port, (u16_t)(tftp_state.blknum - 1));
+          tftp_state.window_count = 0;
+          tftp_state.rx_error_acked = true;
+        }
       }
       break;
     }
@@ -701,13 +742,14 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
     case PP_HTONS(TFTP_OACK): {
       u32_t srv_blksize = 0;
       u32_t srv_tsize = 0;
+      u32_t srv_windowsize = 1;
       u32_t srv_timeout = 0;
 
       if (tftp_state.handle == NULL) {
         send_error(addr, port, TFTP_ERROR_ACCESS_VIOLATION, "No connection");
         break;
       }
-      if (!parse_oack(p, &srv_blksize, &srv_tsize, &srv_timeout)) {
+      if (!parse_oack(p, &srv_blksize, &srv_tsize, &srv_windowsize, &srv_timeout)) {
         send_error_and_close(addr, port, TFTP_ERROR_OPTION_NEGOTIATION,
                              "Invalid OACK");
         break;
@@ -716,6 +758,7 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
         if (((tftp_state.tftp_mode & LWIP_TFTP_MODE_CLIENT) != 0) &&
             (srv_blksize == tftp_state.blksize) &&
             (srv_tsize == tftp_state.tsize) &&
+            (srv_windowsize == tftp_state.windowsize) &&
             (srv_timeout == tftp_state.negotiated_timeout)) {
           /* Delayed OACKs cannot restart negotiation after DATA, even
            * when the block number wraps back to one.
@@ -746,6 +789,7 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       /* Publish only after validating the entire option list. */
       tftp_state.blksize = (u16_t)srv_blksize;
       tftp_state.tsize = srv_tsize;
+      tftp_state.windowsize = (u16_t)srv_windowsize;
       tftp_state.negotiated_timeout = (u8_t)srv_timeout;
       if (tftp_state.mode_write == 0) {
         tftp_state.blknum = 1;
@@ -782,10 +826,12 @@ tftp_tmr(void *arg)
   LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: timeout, retrying\n"));
   if (tftp_state.last_data != NULL)
     ret = resend_data(&tftp_state.addr, tftp_state.port);
-  else if (tftp_state.mode_write != 0)
+  else if (tftp_state.mode_write != 0) {
     ret = send_ack(&tftp_state.addr, tftp_state.port,
                    (u16_t)(tftp_state.blknum - 1));
-  else {
+    tftp_state.window_count = 0;
+    tftp_state.rx_error_acked = false;
+  } else {
     /* Allocation failed before the read callback consumed this block. */
     ret = send_data(&tftp_state.addr, tftp_state.port);
   }
@@ -858,6 +904,10 @@ tftp_init_common(u8_t mode, const struct tftp_context *ctx)
   tftp_state.request_timeout_msecs = TFTP_TIMEOUT_MSECS;
   tftp_state.request_max_retries = TFTP_MAX_RETRIES;
   tftp_state.wrq_pending = false;
+  tftp_state.windowsize = 1;
+  tftp_state.request_windowsize = 1;
+  tftp_state.window_count = 0;
+  tftp_state.rx_error_acked = false;
 
   udp_recv(pcb, tftp_recv, NULL);
 
@@ -916,6 +966,21 @@ tftp_client_set_tsize(u32_t tsize)
   tftp_state.put_tsize_set = true;
 }
 
+/** @ingroup tftp
+ * Set the receive window requested by tftp_get() (RFC 7440).
+ * Data is delivered in order without allocating a window-sized buffer.
+ * @param windowsize Number of blocks, 1..65535; 1 disables negotiation
+ * @return ERR_ARG for zero, ERR_OK otherwise
+ */
+err_t
+tftp_client_set_windowsize(u16_t windowsize)
+{
+  if (!windowsize)
+    return ERR_ARG;
+  tftp_state.request_windowsize = windowsize;
+  return ERR_OK;
+}
+
 /** @ingroup tftp
  * Set the TFTP client/server retransmission timeout and maximum retry count.
  * Clients request RFC 2349 timeout negotiation using whole seconds, like U-Boot's
@@ -1045,6 +1110,8 @@ tftp_get(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enu
   tftp_state.mode_write = 1; /* We want to receive data */
   tftp_state.tsize = 0;
   tftp_state.request_tsize = true;
+  tftp_state.window_count = 0;
+  tftp_state.rx_error_acked = false;
   return start_send_requests(addr, port, TFTP_RRQ, fname, mode);
 }
 
@@ -1060,6 +1127,8 @@ tftp_put(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enu
   tftp_state.mode_write = 0; /* We want to send data */
   tftp_state.tsize = tftp_state.put_tsize;
   tftp_state.request_tsize = tftp_state.put_tsize_set;
+  /* Windowed sending is not implemented. Do not advertise it in a WRQ. */
+  tftp_state.windowsize = 1;
   return start_send_requests(addr, port, TFTP_WRQ, fname, mode);
 }
 
diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
index 1d54c9ff2bc..3827901d157 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
@@ -48,6 +48,7 @@ err_t tftp_client_bind(u16_t port);
 err_t tftp_client_set_request_timeout(u32_t timeout_msecs, u32_t max_retries);
 void tftp_client_set_blksize(u16_t blksize);
 void tftp_client_set_tsize(u32_t tsize);
+err_t tftp_client_set_windowsize(u16_t windowsize);
 u32_t tftp_client_get_tsize(void);
 err_t tftp_get(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode);
 err_t tftp_put(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode);
diff --git a/net/Kconfig b/net/Kconfig
index 1018df11df9..56ff8542321 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -46,6 +46,15 @@ config NETCONSOLE
 	  Support the 'nc' input/output device for networked console.
 	  See doc/usage/netconsole.rst for details.
 
+config TFTP_WINDOWSIZE
+	int "TFTP window size"
+	default 1
+	range 1 65535
+	help
+	  Default receive window for TFTP downloads (RFC 7440). The server
+	  may select a smaller window or decline the option. One preserves
+	  the original stop-and-wait protocol. Override with tftpwindowsize.
+
 config ARP_TIMEOUT
 	int "Milliseconds before trying ARP again"
 	default 5000
@@ -95,15 +104,6 @@ config NET_MAXDEFRAG
 	  used for reassembly, and thus an upper bound for the size of
 	  IP datagrams that can be received.
 
-config TFTP_WINDOWSIZE
-	int "TFTP window size"
-	default 1
-	help
-	  Default TFTP window size.
-	  RFC7440 defines an optional window size of transmits,
-	  before an ack response is required.
-	  The default TFTP implementation implies a window size of 1.
-
 config TFTP_TSIZE
 	bool "Track TFTP transfers based on file size option"
 	depends on CMD_TFTPBOOT
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index e58e1995cb3..4cf451e1184 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -341,6 +341,8 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	const struct tftp_request_timeout *request = tftp_get_request_timeout();
 	struct tftp_ctx ctx;
 	bool initialized = false;
+	const char *window_env = NULL;
+	ulong windowsize = CONFIG_TFTP_WINDOWSIZE;
 	u16 blksize;
 	err_t err;
 
@@ -351,6 +353,14 @@ static int tftp_loop(struct net_lwip_ctx *net,
 		return -E2BIG;
 	if (tftp_get_blocksize(operation, &blksize))
 		return -1;
+	if (IS_ENABLED(CONFIG_NET_TFTP_VARS))
+		window_env = env_get("tftpwindowsize");
+	if (operation == TFTP_DOWNLOAD &&
+	    ((window_env && strict_strtoul(window_env, 10, &windowsize)) ||
+	     !windowsize || windowsize > U16_MAX)) {
+		log_err("error: TFTP window size must be between 1 and 65535\n");
+		return -EINVAL;
+	}
 
 	if (!srvport)
 		srvport = TFTP_PORT;
@@ -410,6 +420,8 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	}
 
 	tftp_client_set_blksize(blksize);
+	if (operation == TFTP_DOWNLOAD)
+		tftp_client_set_windowsize(windowsize);
 
 	ctx.start_time = get_timer(0);
 	if (ctx.upload) {
diff --git a/test/dm/lwip_tftp.c b/test/dm/lwip_tftp.c
index 4f303276a9b..3c2562f99a1 100644
--- a/test/dm/lwip_tftp.c
+++ b/test/dm/lwip_tftp.c
@@ -32,6 +32,7 @@ struct tftp_protocol_test {
 	int read_error;
 	bool initialized;
 	bool fail_data_alloc;
+	bool window_requested;
 	char timeout[4];
 };
 
@@ -56,6 +57,10 @@ static err_t tftp_test_output(struct netif *netif, struct pbuf *p,
 	test->port = get_unaligned_be16(packet + IP_HDR_SIZE);
 	test->opcode = get_unaligned_be16(packet + IP_UDP_HDR_SIZE);
 	test->block = get_unaligned_be16(packet + IP_UDP_HDR_SIZE + 2);
+	if (test->opcode == 1 || test->opcode == 2)
+		test->window_requested = pbuf_memfind(p, "windowsize",
+						      sizeof("windowsize"),
+						    IP_UDP_HDR_SIZE) != 0xffff;
 	if (test->opcode == 1 || test->opcode == 2) {
 		u16 offset = pbuf_memfind(p, "timeout", sizeof("timeout"), IP_UDP_HDR_SIZE);
 
@@ -145,7 +150,8 @@ static int tftp_test_input(struct tftp_protocol_test *test, const void *data,
 	return 0;
 }
 
-static int tftp_test_start(struct tftp_protocol_test *test, bool put)
+static int tftp_test_start_window(struct tftp_protocol_test *test, bool put,
+				  u16 windowsize)
 {
 	err_t err;
 
@@ -158,11 +164,17 @@ static int tftp_test_start(struct tftp_protocol_test *test, bool put)
 		return err;
 	test->initialized = true;
 	tftp_client_set_blksize(1024);
+	tftp_client_set_windowsize(windowsize);
 	if (put)
 		return tftp_put(test, &test->server, 69, "file", TFTP_MODE_OCTET);
 	return tftp_get(test, &test->server, 69, "file", TFTP_MODE_OCTET);
 }
 
+static int tftp_test_start(struct tftp_protocol_test *test, bool put)
+{
+	return tftp_test_start_window(test, put, 1);
+}
+
 static int tftp_test_oack(struct unit_test_state *uts,
 			  struct tftp_protocol_test *test)
 {
@@ -606,6 +618,108 @@ static int tftp_test_server_retries(struct unit_test_state *uts,
 	return 0;
 }
 
+static int tftp_test_windows(struct unit_test_state *uts,
+			     struct tftp_protocol_test *test)
+{
+	static const char oack[] = "\000\006blksize\0008\000windowsize\0002";
+	static const char one[] = "\000\006blksize\0008\000windowsize\0001";
+	static const char ignored[] = "\000\006blksize\0008";
+	static const char rollover[] = "\000\006blksize\0008\000windowsize\0004";
+	static const char * const bad[] = {
+		"\000\006windowsize\0000", "\000\006windowsize\0005",
+		"\000\006windowsize\00065536", "\000\006windowsize\000-1",
+		"\000\006windowsize\0002\000windowsize\0002",
+	};
+	static const unsigned int bad_len[] = { 15, 15, 19, 16, 28 };
+	u8 data[4 + 512] = { 0, 3, 0, 1 };
+	unsigned int sent, i;
+
+	for (i = 0; i < ARRAY_SIZE(bad); i++) {
+		ut_assertok(tftp_test_start_window(test, false, 4));
+		ut_assert(test->window_requested);
+		ut_assertok(tftp_test_input(test, bad[i], bad_len[i], 0));
+		ut_asserteq(8, test->error);
+		ut_asserteq(1, test->closed);
+	}
+	ut_assertok(tftp_test_start_window(test, false, 4));
+	ut_asserteq(ERR_ARG, tftp_client_set_windowsize(0));
+	ut_assertok(tftp_set_timeout(30, 1));
+	ut_assertok(tftp_test_input(test, oack, sizeof(oack), 5));
+	ut_asserteq(0, test->block);
+	sent = test->sent;
+	ut_assertok(tftp_test_input(test, data, 12, 0)); /* DATA 1 */
+	ut_asserteq(sent, test->sent);
+	put_unaligned_be16(2, data + 2);
+	ut_assertok(tftp_test_input(test, data, 12, 0));
+	ut_asserteq(sent + 1, test->sent);
+	ut_asserteq(2, test->block);
+	put_unaligned_be16(4, data + 2); /* Missing DATA 3. */
+	ut_assertok(tftp_test_input(test, data, 12, 0));
+	ut_asserteq(sent + 2, test->sent);
+	ut_asserteq(2, test->block);
+	ut_assertok(tftp_test_input(test, data, 12, 0));
+	ut_asserteq(sent + 2, test->sent);
+	ut_asserteq(16, test->written);
+	for (i = 3; i <= 5; i++) {
+		put_unaligned_be16(i, data + 2);
+		ut_assertok(tftp_test_input(test, data, 12, 0));
+	}
+	ut_asserteq(4, test->block);
+	timer_test_add_offset(40); /* Lost the tail of the window. */
+	sys_check_timeouts();
+	ut_asserteq(5, test->block);
+	for (i = 6; i <= 7; i++) {
+		put_unaligned_be16(i, data + 2);
+		ut_assertok(tftp_test_input(test, data, 12, 0));
+	}
+	ut_asserteq(7, test->block);
+	put_unaligned_be16(8, data + 2);
+	ut_assertok(tftp_test_input(test, data, 4, 0));
+	ut_asserteq(8, test->block);
+	ut_asserteq(56, test->written);
+	ut_asserteq(1, test->closed);
+
+	/* Negotiated one, omitted option, and a server without OACK support. */
+	for (i = 0; i < 3; i++) {
+		ut_assertok(tftp_test_start_window(test, false, 4));
+		if (i < 2) {
+			ut_assertok(tftp_test_input(test, i ? ignored : one,
+						    i ? sizeof(ignored) : sizeof(one), 0));
+			/* A duplicate OACK must still be accepted after selecting one. */
+			ut_assertok(tftp_test_input(test, i ? ignored : one,
+						    i ? sizeof(ignored) : sizeof(one), 0));
+		}
+		put_unaligned_be16(1, data + 2);
+		ut_assertok(tftp_test_input(test, data, i == 2 ? sizeof(data) : 12, 0));
+		ut_asserteq(1, test->block);
+		ut_asserteq(0, test->closed);
+		ut_asserteq(0, test->error);
+		put_unaligned_be16(2, data + 2);
+		ut_assertok(tftp_test_input(test, data, 4, 0));
+		ut_asserteq(1, test->closed);
+	}
+	ut_assertok(tftp_test_start_window(test, true, 4));
+	ut_assert(!test->window_requested);
+	ut_assertok(tftp_test_start_window(test, false, 1));
+	ut_assert(!test->window_requested);
+	ut_assertok(tftp_test_input(test, one, sizeof(one), 0));
+	ut_asserteq(8, test->error); /* Unrequested option. */
+
+	ut_assertok(tftp_test_start_window(test, false, 65535));
+	ut_assertok(tftp_test_input(test, rollover, sizeof(rollover), 0));
+	for (i = 1; i <= 65536; i++) {
+		put_unaligned_be16(i, data + 2);
+		ut_assertok(tftp_test_input(test, data, 12, 0));
+	}
+	ut_asserteq(0, test->block);
+	ut_asserteq(65536 * 8, test->written);
+	ut_asserteq(0, test->error);
+	put_unaligned_be16(1, data + 2);
+	ut_assertok(tftp_test_input(test, data, 4, 0));
+	ut_asserteq(1, test->closed);
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_CMD_TFTPSRV)
 static void tftp_test_server_input(void *arg)
 {
@@ -698,6 +812,8 @@ static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
 		ret = tftp_test_timeout_option(uts, &test);
 	if (!ret)
 		ret = tftp_test_server_retries(uts, &test);
+	if (!ret)
+		ret = tftp_test_windows(uts, &test);
 #if IS_ENABLED(CONFIG_CMD_TFTPSRV)
 	if (!ret)
 		ret = tftp_test_server_command(uts, &test);

-- 
2.53.0

