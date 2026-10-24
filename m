Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644F606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b/uHFVmk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SqKS99uU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBFBE60649;
	Sat, 24 Oct 2026 22:35:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uu_TNrRzu4Wq; Sat, 24 Oct 2026 22:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A840E6061B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881332;
	b=LDrRJAo6VwRl2hSAdLFXwRbRmLm5gQWV2xLKp4vFw+zFRabKaOV/rbuVzLxzpfQ6usMc
	 gXt0X4PbcAeSKj/GhRgmkyuhD6byB3/7MUPP2Y4aYNAeVhuTWSMGqnQsK/GDDcBfk7kI5
	 +vYPwF4qtDV7YF7jr/7UZNeyy28CCUMicaq92JKxkTimVgXoMgQsbKewBRqJ1bci8sWwV
	 lNM6Lbxbi3+Y3sne+1OIvfDLuxrbwTS9++Ey8YGxY+XpoGxEgM+g419D0Fca9iNJbcgzq
	 NKKxX7Sx+4RonZLPfR+yFQYI//i6PLuPCqLudZOFOZxwlEiFqZatLxVvGkLPoWv1HTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881332;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DR4M3bHC8OUu4h2bTokXH9JCB7NYAorhOznPJcyZ3BY=;
	b=IJwSQ344mwU1g67Opnz0/mgHKCH2tJrElWFDTYKc+UfDzqfCZESP7+msHwHMDuI5htYq
	 dgGCOU6biD8H8cqspFHND+t70nC3P+Of+XgNv1Yv4/CeICDNYz2ZTq+XZXBF/dK0eqVOz
	 8QDe26xH679m60FcWKDRR3r31EhLPR9kaTazDJsNQ5Njoky8pLyG9lfqPqTTzUMBtHP/f
	 7+RcplyfcaQMkWEFko+G2SyR3L8yD09+wOkVZl5KmZy6e11MbOrL2wIc4ma4nw2f4ieIB
	 sEvCucISQp9/Yt5YmAy21U95zEqx62QwT/HuLY4XDDQNpw2L4+zsvhdLyPjZayuOQHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881331;
	bh=DR4M3bHC8OUu4h2bTokXH9JCB7NYAorhOznPJcyZ3BY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b/uHFVmk2TywSKeuCOlEQ9gMpebOBDHY/mxir8c4c+RkSj2rYAD/bWzKpyiyZtPt4
	 tZ6peiQc/Mmjad2QqCd4Z2/MithPCbUJokAtoXnQ13GGHq+BJWZ+aYBk/xoHDxESTs
	 0UVCe0EEzp1guiZUyR2fTWpGg4YGxrAeQod2J3xRqRpSFd1IsN2zvD0eazQt5G9SKe
	 89rxlgkgWnvKmAxVPaIUgQHFUqFEyQ+/7tsY/y+5k7F+mIdxtgG9xCMU4IaMGi47zY
	 +k0CHffsAO3S10x70bazECMAG9FVezDlCfUCoNjwe04BkruUFOJCjI01XD0A513mhx
	 KOhczO6uTtLVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A840E6061B;
	Sat, 24 Oct 2026 22:35:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 807CF380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7445680F33
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5Qe1xJO5aRb for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 75F6780E3B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881325;
 b=mVOd+lc2+xpBf2wJmpUgo6OmxQHeqGx8eprc//+7eu5ZyhXd2mdy7HuXynCH+QqOWqFg
 GGcc01f5Z8w9tE0vsrddHoSFn3XIM2xLNKRDzOAcq4H0P92IMEfUKw40UD4OCE9NgpRFK
 qsS7MZSjrXYMh3gzzbp3LfObmQHo9d0SEOSnvGZrV+zzBNwWMuJrgvD5OohYiPxIB0aYP
 zNF8rCsNY8eJlL/MoTlI0DEAHIpZIY93ioMz03q9C6Uu+pl5qJIjsJvvzPwAAeUzuTpuq
 naHzPElricX9G1/3MpYL5HPvgKkj3fvqfDU3QDyvjo5cFrmpPMz9Zxl/B047Gm4mycA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881325;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=DR4M3bHC8OUu4h2bTokXH9JCB7NYAorhOznPJcyZ3BY=;
 b=sImvjiPN7QggwukLf9kPEzkFUmDLNbe3COL9Km7s7HMoEcB1RB6LKzedKA2iI3y8W3bG
 +ZIALYwTYzJvBXFQpHJZOs2hBZzKSrYQKHCV4Ct6gDhuBetF9U97sXe6hvOoa3VuqQp37
 sG49B7Mk7OTkcKhOwnpnhwX/9YbJh5tO5NZ8re6uivdskgoYzb5RGhpvaYjSU2FSJznHH
 MHXiv3YgE9GMg7nnIYSgNRInDzO6qqBXX6vHlMriuVnXjNRN4tfxfIWAbmwQyIehNyNzD
 50uM1yrQrDRzcRBtkY2yMPvXGhdT5Dh4Mp0dM7GTK+3VTnR/zYrfZV8ZPxtOCcfErzQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SqKS99uU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SqKS99uU
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75F6780E3B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:25 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6e560e00a86so1303008eaf.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881324; x=1793486124;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DR4M3bHC8OUu4h2bTokXH9JCB7NYAorhOznPJcyZ3BY=;
 b=SqKS99uUHE26W8Z5GL8PRBALPepdFbU8oW7k8CJ5BAy0mDOxQxgvX3UDoCFa/C3Cb5
 4TLoGQs4XNnKxGhrY7ON1GaOBN12TrqPHA3VGNZXMJeGOqvLDy2D6XlFt/Ehv8JyUta/
 5pHvkfBVUe6SdCuWKGMt+zcUs/jVKtmtvuyQYe4+NGQkKUj6K3wkXXBNsS7hk7GcivnV
 Q1AwE5v22Lu32Zh2FbtbqTd7LCa/qlQk4BmP2H0IdoZeRLbfXcn04iGo+0nROR2KJnoC
 ZxgMkQb2fLgaKnVkpzPZQLrkM3IyTefiyKaQnNY9WEA3tH2Zhb6LmRyNv8iwmqBlTR51
 gkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881324; x=1793486124;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DR4M3bHC8OUu4h2bTokXH9JCB7NYAorhOznPJcyZ3BY=;
 b=k62u5w1iNhnLqlo1upPGxeOLV7CxSQqnC352oJm3Bi95HlvV2zupbVKsqtzjs4eXGe
 49tkS8NXaGH7F5jFFkoE7+hGjizz2PMk4XElELGQdnxBR+KQICj8+8bHZ+z67Jo722t1
 uhTVzNVBUigqrvhJWGXBI1a8C4F8po5nIUBrnywSAFAXgfthcZl07Fb0DZsKujQHt3h9
 rhndBfLjrFSi+U2wEyrmLv4KiS17LHe26Sgasf4BdLO7TWm/3p244woJuTZjq5BS3xNI
 5ejxCXmcDKLN09BIXUHCtoZz+d5OpdcCP5Kbp9C+TsWm7WBN82/bK5QB5V8/w5YmNhQG
 1KIQ==
X-Gm-Message-State: AFq9FYKPLb3bphH5hMIL0wau5mkUxJpBGS5OGnM0w09hvSeTbb606NhV
 /o5vw3lFJDPquC6Cdka+Gwo+ZLLmOvtH2eSKeIvEgksI9LccSdZtwaBg
X-Gm-Gg: AYBFou1iv+N6+wL+rmgN3MV0iZelnHdw1u8KdZrU7XOmTSMaVEqWkh431eCCV9MmfzQ
 geykVGqmlQ8OSsddtxBwfIlbUHI/MjbnDPEOcBt4jq7irDCGsT7VefOjueP/F1Zh7az55W6RBQ6
 YRY+XDnxes16se1F+9g/vB8FHVJFNgCQwpSiYAACIYo4WoarU+nMJnXOlPNmFBOWDgd1L9SIV0G
 MiYF71CxkGxlI4kjVCND+a3zYA4aGKf8sFlgErUdLYSDwWJxGsySsbbV/RpctAAHQb30eH7izG0
 WeHrJ+gI00iwasx0ehV7Ug5KWC6cFz0tJbbxyY5UvdGJe3aEiZtXIWs0hqD2n2bcHQSsrw67ocF
 xNZenuJb9dzBqDeqpNdq72wWYEnUWcxPR7hWETTCA08ffdVY6+WkhMtuGLQylmV4vZX2tYuXw/F
 obFktMURWUaAbnKEFxfp9T8LF8AtVF8UD+iC/giYgwquRtWL+g1SdFufb03QuvBnTp76uijy9Ln
 9y+XBgg2G1I/rOStyh1Gfwl423oDW6CQrcCP8eHzlyIA1x4/WQiw4GWWVh0RFdXlhJyDWrxvHu1
 mTnhHG0w/i8XAif56Y9XRFt/k0qpoOqgnAbc76XprbOw4St69zW3VVbdti+3SxefJzsSyniXjWE
 x/60BmSko3n6At+RndAjhtmLcnq91qvg5f/vhs3Fst3Eg5zQ5cZnfzGAzgu4ldCgmAMQH+sMY34
 CD3RM=
X-Received: by 2002:a05:6820:1395:b0:6e2:3d8b:a01c with SMTP id
 006d021491bc7-70ba0da04fbmr1563775eaf.19.1792881323994; 
 Sat, 24 Oct 2026 15:35:23 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:52 -0600
Subject: [PATCH v2 05/16] net: tftp: make automatic updates stack-independent
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-5-0f663f735ee8@gmail.com>
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

The update code overrides variables internal to the legacy TFTP
client before calling net_loop(). This cannot work with lwIP. The
timeout override is also ineffective with the legacy client because
tftp_start() uses a separate private value.

Add a common helper which scopes an initial-request timeout around
tftpb_run(). Keep the documented 100 ms server probe and zero retries
for automatic updates, without changing the normal transfer timeout or
the RFC 2349 timeout option. Both stacks switch to their normal timeout
and retry budget after the first DATA or OACK response. Leave the timeout
environment variables unchanged, and remove the update-only globals.

Resolve the server or gateway MAC address before starting lwIP's short
request timer. Like the legacy stack, keep the bounded ARP retry phase
separate from the server-response budget so a lost ARP reply does not
exhaust the probe before its request reaches the server.

Suppress autostart while downloading: unlike net_loop(), the command
path can otherwise attempt to boot an update before the caller processes
it. Preserve the exact previous autostart value, including its absence,
and restore it on transfer failure as well as success.

This dispatches through the selected network stack. Have the lwIP
client publish net_boot_file_size for the update cache flush, reset the
legacy client's private timeout settings for each transfer, and select
the required network commands.

Add sandbox coverage for both stacks: lost ARP replies, gateway resolution,
bounded ARP failure and cancellation, silent-server probes, request retries,
normal DATA and OACK recovery, subsequent ordinary transfers, automatic
boot suppression and preservation of environment settings.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 common/Kconfig                                    |   6 +-
 common/update.c                                   |  55 ++--
 include/net-common.h                              |  24 ++
 include/net/tftp.h                                |   3 -
 lib/lwip/lwip/src/apps/tftp/tftp.c                |  30 +-
 lib/lwip/lwip/src/include/lwip/apps/tftp_client.h |   1 +
 net/Kconfig                                       |   1 -
 net/lwip/tftp.c                                   |  58 ++++
 net/net-common.c                                  |  46 +++
 net/tftp.c                                        |  55 ++--
 test/dm/Makefile                                  |   3 +
 test/dm/tftp.c                                    | 362 ++++++++++++++++++++++
 12 files changed, 579 insertions(+), 65 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index c739225621b..bcefa5ebc57 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1036,8 +1036,10 @@ config UPDATE_COMMON
 
 config UPDATE_TFTP
 	bool "Auto-update using fitImage via TFTP"
-	depends on FIT && OF_LIBFDT && !MTD_NOR_FLASH
+	depends on FIT && OF_LIBFDT && !MTD_NOR_FLASH && NET
 	select UPDATE_COMMON
+	select CMD_NET
+	select CMD_TFTPBOOT
 	help
 	  This option allows performing update of NOR with data in fitImage
 	  sent via TFTP boot.
@@ -1045,11 +1047,13 @@ config UPDATE_TFTP
 config UPDATE_TFTP_CNT_MAX
 	int "The number of connection retries during auto-update"
 	default 0
+	range 0 2147483647
 	depends on UPDATE_TFTP || DFU_TFTP
 
 config UPDATE_TFTP_MSEC_MAX
 	int "Delay in mSec to wait for the TFTP server during auto-update"
 	default 100
+	range 1 1073741823
 	depends on UPDATE_TFTP || DFU_TFTP
 
 config UPDATE_LOAD_ADDR
diff --git a/common/update.c b/common/update.c
index 06e53cbd402..5adce3fc245 100644
--- a/common/update.c
+++ b/common/update.c
@@ -13,7 +13,6 @@
 #include <command.h>
 #include <env.h>
 #include <net.h>
-#include <net/tftp.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <dfu.h>
@@ -23,8 +22,6 @@
 /* env variable holding the location of the update file */
 #define UPDATE_FILE_ENV		"updatefile"
 
-extern ulong tftp_timeout_ms;
-extern int tftp_timeout_count_max;
 #ifdef CONFIG_MTD_NOR_FLASH
 #include <flash.h>
 #include <mtd/cfi_flash.h>
@@ -32,48 +29,38 @@ static uchar *saved_prot_info;
 #endif
 static int update_load(char *filename, ulong msec_max, int cnt_max, ulong addr)
 {
-	int rv, ret;
-	ulong saved_timeout_msecs;
-	int saved_timeout_count;
+	const char *netretry;
 	char *saved_netretry, *saved_bootfile;
+	int rv = 1;
+	int ret;
 
-	rv = 0;
-	/* save used globals and env variable */
-	saved_timeout_msecs = tftp_timeout_ms;
-	saved_timeout_count = tftp_timeout_count_max;
-	saved_netretry = strdup(env_get("netretry"));
+	netretry = env_get("netretry");
+	saved_netretry = netretry ? strdup(netretry) : NULL;
+	if (netretry && !saved_netretry)
+		return 1;
 	saved_bootfile = strdup(net_boot_file_name);
-
-	/* set timeouts for auto-update */
-	tftp_timeout_ms = msec_max;
-	tftp_timeout_count_max = cnt_max;
+	if (!saved_bootfile)
+		goto out_free_netretry;
 
 	/* we don't want to retry the connection if errors occur */
-	env_set("netretry", "no");
+	if (env_set("netretry", "no"))
+		goto out_restore;
 
 	/* download the update file */
-	image_load_addr = addr;
-	copy_filename(net_boot_file_name, filename, sizeof(net_boot_file_name));
-	ret = net_loop(TFTPGET);
+	ret = tftpb_run_timeout(addr, filename, msec_max, cnt_max);
 
-	if (ret < 0)
-		rv = 1;
-	else
+	if (!ret) {
 		flush_cache(addr, net_boot_file_size);
+		rv = 0;
+	}
 
-	/* restore changed globals and env variable */
-	tftp_timeout_ms = saved_timeout_msecs;
-	tftp_timeout_count_max = saved_timeout_count;
-
+out_restore:
 	env_set("netretry", saved_netretry);
-	if (saved_netretry != NULL)
-		free(saved_netretry);
-
-	if (saved_bootfile != NULL) {
-		copy_filename(net_boot_file_name, saved_bootfile,
-			      sizeof(net_boot_file_name));
-		free(saved_bootfile);
-	}
+	copy_filename(net_boot_file_name, saved_bootfile,
+		      sizeof(net_boot_file_name));
+	free(saved_bootfile);
+out_free_netretry:
+	free(saved_netretry);
 
 	return rv;
 }
diff --git a/include/net-common.h b/include/net-common.h
index f1f670dbd8b..12c1689bf57 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -535,6 +535,30 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
  */
 int tftpb_run(ulong addr, const char *fname);
 
+/**
+ * tftpb_run_timeout() - Download via TFTP with an initial server-probe timeout
+ *
+ * Normal transfer timeouts apply after the server responds. Suppresses
+ * automatic boot and restores autostart on success and failure. Does not
+ * change the timeout environment variables or the RFC 2349 timeout option.
+ *
+ * @addr: Address to load the file into
+ * @fname: Filename of file to load
+ * @timeout_ms: Initial request timeout in milliseconds, 1..U32_MAX / 4
+ * @max_retries: Maximum number of initial request retransmissions
+ * Return: 0 if successful, otherwise a negative error code
+ */
+int tftpb_run_timeout(ulong addr, const char *fname, ulong timeout_ms,
+		      int max_retries);
+
+struct tftp_request_timeout {
+	ulong msecs;
+	int max_retries;
+};
+
+/* Initial request override for the current synchronous download, or NULL. */
+const struct tftp_request_timeout *tftp_get_request_timeout(void);
+
 /**
  * do_ping - Run the ping command
  *
diff --git a/include/net/tftp.h b/include/net/tftp.h
index c7e14817280..a02ea051db6 100644
--- a/include/net/tftp.h
+++ b/include/net/tftp.h
@@ -22,9 +22,6 @@ void tftp_start(enum proto_t protocol);	/* Begin TFTP get/put */
 void tftp_start_server(void);	/* Wait for incoming TFTP put */
 #endif
 
-extern ulong tftp_timeout_ms;
-extern int tftp_timeout_count_max;
-
 /**********************************************************************/
 
 #endif /* __TFTP_H__ */
diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index e3453fa9bfa..49749fb8262 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -101,6 +101,8 @@ struct tftp_state {
   u32_t put_tsize;
   u32_t timeout_msecs;
   u32_t max_retries;
+  u32_t request_timeout_msecs;
+  u32_t request_max_retries;
   u32_t retries;
   u8_t request_timeout;
   u8_t negotiated_timeout;
@@ -809,7 +811,7 @@ tftp_req_tmr(void *arg)
     return;
   }
 
-  if (tftp_state.retries >= tftp_state.max_retries) {
+  if (tftp_state.retries >= tftp_state.request_max_retries) {
     transfer_timed_out();
     return;
   }
@@ -818,7 +820,7 @@ tftp_req_tmr(void *arg)
   ret = resend_request();
   LWIP_UNUSED_ARG(ret);
   tftp_state.retries++;
-  sys_timeout(tftp_state.timeout_msecs, tftp_req_tmr, NULL);
+  sys_timeout(tftp_state.request_timeout_msecs, tftp_req_tmr, NULL);
 }
 
 /**
@@ -853,6 +855,8 @@ tftp_init_common(u8_t mode, const struct tftp_context *ctx)
   tftp_state.tftp_mode = mode;
   tftp_state.timeout_msecs = TFTP_TIMEOUT_MSECS;
   tftp_state.max_retries = TFTP_MAX_RETRIES;
+  tftp_state.request_timeout_msecs = TFTP_TIMEOUT_MSECS;
+  tftp_state.request_max_retries = TFTP_MAX_RETRIES;
   tftp_state.wrq_pending = false;
 
   udp_recv(pcb, tftp_recv, NULL);
@@ -930,6 +934,26 @@ tftp_set_timeout(u32_t timeout_msecs, u32_t max_retries)
 
   tftp_state.timeout_msecs = timeout_msecs;
   tftp_state.max_retries = max_retries;
+  tftp_state.request_timeout_msecs = timeout_msecs;
+  tftp_state.request_max_retries = max_retries;
+  return ERR_OK;
+}
+
+/** @ingroup tftp
+ * Override the initial request timeout after tftp_set_timeout().
+ * Transfer timeouts and the advertised RFC 2349 option remain unchanged.
+ * @param timeout_msecs Initial request timeout in milliseconds
+ * @param max_retries Maximum number of request retransmissions
+ * @return ERR_ARG if the timeout is zero or outside sys_timeout()'s range
+ */
+err_t
+tftp_client_set_request_timeout(u32_t timeout_msecs, u32_t max_retries)
+{
+  if ((timeout_msecs == 0) || (timeout_msecs > LWIP_UINT32_MAX / 4))
+    return ERR_ARG;
+
+  tftp_state.request_timeout_msecs = timeout_msecs;
+  tftp_state.request_max_retries = max_retries;
   return ERR_OK;
 }
 
@@ -1005,7 +1029,7 @@ start_send_requests(const ip_addr_t *addr, u16_t port, u16_t opcode, const char*
     return ret;
   }
 
-  sys_timeout(tftp_state.timeout_msecs, tftp_req_tmr, NULL);
+  sys_timeout(tftp_state.request_timeout_msecs, tftp_req_tmr, NULL);
   return ERR_OK;
 }
 
diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
index 6a5019c079b..1d54c9ff2bc 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
@@ -45,6 +45,7 @@ enum tftp_transfer_mode {
 
 err_t tftp_init_client(const struct tftp_context* ctx);
 err_t tftp_client_bind(u16_t port);
+err_t tftp_client_set_request_timeout(u32_t timeout_msecs, u32_t max_retries);
 void tftp_client_set_blksize(u16_t blksize);
 void tftp_client_set_tsize(u32_t tsize);
 u32_t tftp_client_get_tsize(void);
diff --git a/net/Kconfig b/net/Kconfig
index 0f50b422f4f..1018df11df9 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -48,7 +48,6 @@ config NETCONSOLE
 
 config ARP_TIMEOUT
 	int "Milliseconds before trying ARP again"
-	depends on NET_LEGACY
 	default 5000
 
 config NET_RETRY_COUNT
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 5347155120c..025b65a3a82 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -12,6 +12,7 @@
 #include <linux/kconfig.h>
 #include <lwip/apps/tftp_client.h>
 #include <lwip/apps/tftp_server.h>
+#include <lwip/etharp.h>
 #include <lwip/timeouts.h>
 #include <mapmem.h>
 #include <net.h>
@@ -152,6 +153,7 @@ static void tftp_close(void *handle)
 		return;
 	}
 	ctx->done = SUCCESS;
+	net_boot_file_size = ctx->size;
 
 	tftp_tsize = tftp_transfer_size(ctx);
 	if (tftp_tsize) {
@@ -275,12 +277,54 @@ static int tftp_get_blocksize(enum tftp_operation operation, u16 *blksize)
 	return 0;
 }
 
+/* Resolve the next hop before starting an internal caller's short RRQ timer. */
+static int tftp_probe_arp(struct netif *netif, const ip4_addr_t *server)
+{
+	const ip4_addr_t *target = server;
+	const ip4_addr_t *resolved;
+	struct eth_addr *ethaddr;
+	ulong start;
+	int tries;
+
+	if (ip4_addr_isbroadcast(server, netif) || ip4_addr_ismulticast(server))
+		return 0;
+	if (!ip4_addr_net_eq(server, netif_ip4_addr(netif), netif_ip4_netmask(netif)) &&
+	    !ip4_addr_islinklocal(server)) {
+		target = netif_ip4_gw(netif);
+		/* Leave a missing route to the TFTP client's normal error handling. */
+		if (ip4_addr_isany_val(*target))
+			return 0;
+	}
+	if (etharp_find_addr(netif, target, &ethaddr, &resolved) >= 0)
+		return 0;
+
+	/* Match net/arp.c's bounded retry policy, including the initial request. */
+	for (tries = 0; tries < max(1, CONFIG_NET_RETRY_COUNT - 1); tries++) {
+		start = get_timer(0);
+		/* Do not queue an RRQ or create a pending entry with its own timer. */
+		etharp_request(netif, target);
+		do {
+			net_lwip_poll();
+			if (ctrlc()) {
+				printf("\nAbort\n");
+				return -EINTR;
+			}
+			if (etharp_find_addr(netif, target, &ethaddr, &resolved) >= 0)
+				return 0;
+		} while (get_timer(start) <= CONFIG_ARP_TIMEOUT);
+	}
+
+	printf("\nARP Retry count exceeded\n");
+	return -EAGAIN;
+}
+
 static int tftp_loop(struct net_lwip_ctx *net,
 		     enum tftp_operation operation,
 		     ulong addr, ulong size, char *fname, ip_addr_t srvip,
 		     u16 srvport, u16 srcport, u32 timeout_msecs,
 		     u32 max_retries)
 {
+	const struct tftp_request_timeout *request = tftp_get_request_timeout();
 	struct tftp_ctx ctx;
 	bool initialized = false;
 	u16 blksize;
@@ -303,6 +347,7 @@ static int tftp_loop(struct net_lwip_ctx *net,
 	ctx.daddr = addr;
 	ctx.total_size = size;
 	ctx.upload = operation == TFTP_UPLOAD;
+	net_boot_file_size = 0;
 
 	printf("Using %s device\n", net->dev->name);
 	printf("TFTP %s server %s; our IP address is %s\n",
@@ -318,6 +363,13 @@ static int tftp_loop(struct net_lwip_ctx *net,
 		printf("Loading: ");
 	}
 
+	if (operation == TFTP_DOWNLOAD && request) {
+		int ret = tftp_probe_arp(net->netif, ip_2_ip4(&srvip));
+
+		if (ret)
+			return ret;
+	}
+
 	err = tftp_init_client(&tftp_context);
 	if (err != ERR_OK) {
 		log_err("tftp_init_client err: %d\n", err);
@@ -338,6 +390,11 @@ static int tftp_loop(struct net_lwip_ctx *net,
 		log_err("tftp_set_timeout err: %d\n", err);
 		goto out_cleanup;
 	}
+	if (operation == TFTP_DOWNLOAD && request) {
+		err = tftp_client_set_request_timeout(request->msecs, request->max_retries);
+		if (err != ERR_OK)
+			goto out_cleanup;
+	}
 
 	tftp_client_set_blksize(blksize);
 
@@ -422,6 +479,7 @@ static int tftpsrv_loop(struct net_lwip_ctx *net, ulong addr)
 	ctx.done = NOT_DONE;
 	ctx.daddr = addr;
 	ctx.is_server = true;
+	net_boot_file_size = 0;
 
 	printf("Using %s device\n", net->dev->name);
 	printf("Listening for TFTP transfer on %s\n", ipaddr);
diff --git a/net/net-common.c b/net/net-common.c
index 3a9a0635ad8..c5d13a23b09 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <env.h>
+#include <limits.h>
 #include <malloc.h>
 #include <net-common.h>
 #include <rtc.h>
@@ -105,6 +106,13 @@ int dhcp_run(ulong addr, const char *fname, bool autoload)
 #endif
 
 #if defined(CONFIG_CMD_TFTPBOOT)
+static const struct tftp_request_timeout *tftp_request_timeout;
+
+const struct tftp_request_timeout *tftp_get_request_timeout(void)
+{
+	return tftp_request_timeout;
+}
+
 int tftpb_run(ulong addr, const char *fname)
 {
 	char *tftp_argv[] = {"tftpboot", NULL, (char *)fname, NULL};
@@ -123,4 +131,42 @@ int tftpb_run(ulong addr, const char *fname)
 	return 0;
 }
 
+int tftpb_run_timeout(ulong addr, const char *fname, ulong timeout_ms,
+		      int max_retries)
+{
+	struct tftp_request_timeout timeout = { timeout_ms, max_retries };
+	const struct tftp_request_timeout *saved = tftp_request_timeout;
+	const char *autostart_env = env_get("autostart");
+	char *saved_autostart = NULL;
+	int restore_ret = 0;
+	int ret;
+
+	if (!timeout_ms || timeout_ms > U32_MAX / 4 || max_retries < 0)
+		return -EINVAL;
+
+	if (autostart_env) {
+		saved_autostart = strdup(autostart_env);
+		if (!saved_autostart) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+	}
+
+	/* Updates need the downloaded data, not the command's automatic boot. */
+	ret = env_set("autostart", "no");
+	if (ret)
+		goto out_free;
+
+	tftp_request_timeout = &timeout;
+	ret = tftpb_run(addr, fname);
+	tftp_request_timeout = saved;
+
+	if (env_set("autostart", saved_autostart))
+		restore_ret = -EINVAL;
+out_free:
+	free(saved_autostart);
+
+	return ret ?: restore_ret;
+}
+
 #endif
diff --git a/net/tftp.c b/net/tftp.c
index 73b31b8357d..e70358a3963 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -47,21 +47,11 @@
 
 static ulong timeout_ms = TIMEOUT;
 static int timeout_count_max = (CONFIG_NET_RETRY_COUNT * 2);
+static ulong request_timeout_ms;
+static int request_timeout_count_max;
 static ulong time_start;   /* Record time we started tftp */
 static struct in6_addr tftp_remote_ip6;
 
-/*
- * These globals govern the timeout behavior when attempting a connection to a
- * TFTP server. tftp_timeout_ms specifies the number of milliseconds to
- * wait for the server to respond to initial connection. Second global,
- * tftp_timeout_count_max, gives the number of such connection retries.
- * tftp_timeout_count_max must be non-negative and tftp_timeout_ms must be
- * positive. The globals are meant to be set (and restored) by code needing
- * non-standard timeout behavior when initiating a TFTP transfer.
- */
-ulong tftp_timeout_ms = TIMEOUT;
-int tftp_timeout_count_max = (CONFIG_NET_RETRY_COUNT * 2);
-
 enum {
 	TFTP_ERR_UNDEFINED           = 0,
 	TFTP_ERR_FILE_NOT_FOUND      = 1,
@@ -527,7 +517,9 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 		break;
 #endif
 
-	case TFTP_OACK:
+	case TFTP_OACK: {
+		bool first_oack = tftp_state == STATE_SEND_RRQ;
+
 		/*
 		 * RFC 2347 makes every option name and value a NUL terminated
 		 * string, so a well-formed OACK always ends in a NUL. Checking
@@ -590,6 +582,10 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 		}
 
 		tftp_next_ack = tftp_windowsize;
+		if (first_oack && tftp_state == STATE_OACK) {
+			timeout_count = 0;
+			net_set_timeout_handler(timeout_ms, tftp_timeout_handler);
+		}
 
 #ifdef CMD_TFTPPUT
 		if (tftp_put_active && tftp_state == STATE_OACK) {
@@ -600,6 +596,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 #endif
 		tftp_send(); /* Send ACK or first data block */
 		break;
+	}
 	case TFTP_DATA:
 		if (len < 2)
 			return;
@@ -664,7 +661,6 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 
 		update_block_number();
 		tftp_prev_block = tftp_cur_block;
-		timeout_count_max = tftp_timeout_count_max;
 		net_set_timeout_handler(timeout_ms, tftp_timeout_handler);
 
 		if (store_block(tftp_cur_block, pkt + 2, len)) {
@@ -717,11 +713,15 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 
 static void tftp_timeout_handler(void)
 {
-	if (++timeout_count > timeout_count_max) {
+	bool request = tftp_state == STATE_SEND_RRQ;
+	int max_retries = request ? request_timeout_count_max : timeout_count_max;
+	ulong msecs = request ? request_timeout_ms : timeout_ms;
+
+	if (++timeout_count > max_retries) {
 		restart("Retry count exceeded");
 	} else {
 		puts("T ");
-		net_set_timeout_handler(timeout_ms, tftp_timeout_handler);
+		net_set_timeout_handler(msecs, tftp_timeout_handler);
 		if (tftp_state != STATE_RECV_WRQ)
 			tftp_send();
 	}
@@ -773,8 +773,12 @@ static void sanitize_tftp_block_size_option(enum proto_t protocol)
 
 void tftp_start(enum proto_t protocol)
 {
+	const struct tftp_request_timeout *request = tftp_get_request_timeout();
 	__maybe_unused char *ep;             /* Environment pointer */
 
+	timeout_ms = TIMEOUT;
+	timeout_count_max = CONFIG_NET_RETRY_COUNT * 2;
+
 	if (saved_tftp_block_size_option) {
 		tftp_block_size_option = saved_tftp_block_size_option;
 		saved_tftp_block_size_option = 0;
@@ -807,16 +811,22 @@ void tftp_start(enum proto_t protocol)
 
 		ep = env_get("tftptimeoutcountmax");
 		if (ep != NULL)
-			tftp_timeout_count_max = simple_strtol(ep, NULL, 10);
+			timeout_count_max = simple_strtol(ep, NULL, 10);
 
-		if (tftp_timeout_count_max < 0) {
+		if (timeout_count_max < 0) {
 			printf("TFTP timeout count max (%d ms) negative, set to 0\n",
-			       tftp_timeout_count_max);
-			tftp_timeout_count_max = 0;
+			       timeout_count_max);
+			timeout_count_max = 0;
 		}
 	}
 
 	sanitize_tftp_block_size_option(protocol);
+	request_timeout_ms = timeout_ms;
+	request_timeout_count_max = timeout_count_max;
+	if (protocol == TFTPGET && request) {
+		request_timeout_ms = request->msecs;
+		request_timeout_count_max = request->max_retries;
+	}
 
 	debug("TFTP blocksize = %i, TFTP windowsize = %d timeout = %ld ms\n",
 	      tftp_block_size_option, tftp_window_size_option, timeout_ms);
@@ -920,9 +930,8 @@ void tftp_start(enum proto_t protocol)
 	}
 
 	time_start = get_timer(0);
-	timeout_count_max = tftp_timeout_count_max;
 
-	net_set_timeout_handler(timeout_ms, tftp_timeout_handler);
+	net_set_timeout_handler(request_timeout_ms, tftp_timeout_handler);
 	net_set_udp_handler(tftp_handler);
 #ifdef CMD_TFTPPUT
 	net_set_icmp_handler(icmp_handler);
@@ -966,7 +975,7 @@ void tftp_start_server(void)
 
 	puts("Loading: *\b");
 
-	timeout_count_max = tftp_timeout_count_max;
+	timeout_count_max = CONFIG_NET_RETRY_COUNT * 2;
 	timeout_count = 0;
 	timeout_ms = TIMEOUT;
 	net_set_timeout_handler(timeout_ms, tftp_timeout_handler);
diff --git a/test/dm/Makefile b/test/dm/Makefile
index f35f45e084d..75e82216181 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -49,6 +49,9 @@ obj-$(CONFIG_ECDSA_VERIFY) += ecdsa.o
 obj-$(CONFIG_DM_HASH) += hash.o
 obj-$(CONFIG_EFI_MEDIA_SANDBOX) += efi_media.o
 obj-$(CONFIG_DM_ETH) += eth.o
+ifeq ($(CONFIG_DM_ETH)$(CONFIG_CMD_TFTPBOOT),yy)
+obj-y += tftp.o
+endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_PROT_UDP_LWIP),yy)
 obj-y += lwip.o
 endif
diff --git a/test/dm/tftp.c b/test/dm/tftp.c
new file mode 100644
index 00000000000..eb178573312
--- /dev/null
+++ b/test/dm/tftp.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <env.h>
+#include <env_internal.h>
+#include <image.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <net.h>
+#include <time.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <test/ut.h>
+
+static const char tftp_test_data[] = "update data, not a bootable image";
+
+#define TFTP_TEST_ADDR 0x2000000
+
+enum tftp_test_probe {
+	TFTP_PROBE_NONE,
+	TFTP_PROBE_SILENT,
+	TFTP_PROBE_DATA,
+	TFTP_PROBE_OACK,
+};
+
+struct tftp_test_context {
+	bool fail;
+	bool autostart;
+	unsigned int requests;
+	unsigned int arp_requests;
+	unsigned int drop_arp;
+	struct in_addr arp_target;
+	bool abort_arp;
+	enum tftp_test_probe probe;
+	unsigned int probe_acks;
+	ulong request_start;
+	ulong ack_start;
+	ulong ack_delay;
+	unsigned int advertised_timeout;
+};
+
+/* Answer an RRQ with one short DATA block or a file-not-found error. */
+static int tftp_test_tx_handler(struct udevice *dev, void *packet,
+				unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct tftp_test_context *ctx = priv->priv;
+	struct ethernet_hdr *eth = packet, *reply_eth;
+	struct ip_udp_hdr *ip, *reply_ip;
+	const char *data = ctx->fail ? "not found" : tftp_test_data;
+	unsigned int data_len = strlen(data) + 1;
+	unsigned int reply_len, header_len = 4;
+	u16 opcode, reply_opcode = ctx->fail ? 5 : 3, block = 1;
+	bool partial = false;
+	u8 *payload;
+
+	if (len >= ETHER_HDR_SIZE + ARP_HDR_SIZE &&
+	    ntohs(eth->et_protlen) == PROT_ARP) {
+		const u8 *arp = (void *)(eth + 1);
+
+		/* Ignore gratuitous ARP: compare the sender and target IPv4 addresses. */
+		if (get_unaligned_be16(arp + 6) == 1 &&
+		    memcmp(arp + 14, arp + 24, 4)) {
+			memcpy(&ctx->arp_target, arp + 24, 4);
+			ctx->arp_requests++;
+			if (ctx->arp_requests <= ctx->drop_arp) {
+				if (ctx->abort_arp)
+					console_in_puts("\x03");
+				else if (IS_ENABLED(CONFIG_NET_LWIP))
+					/* Advance after the client has armed its RRQ timer. */
+					sandbox_eth_skip_timeout();
+				else
+					timer_test_add_offset(CONFIG_ARP_TIMEOUT + 1);
+				return 0;
+			}
+		}
+	}
+	if (!sandbox_eth_arp_req_to_reply(dev, packet, len))
+		return 0;
+	if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + 2 ||
+	    ntohs(eth->et_protlen) != PROT_IP)
+		return 0;
+	ip = (void *)(eth + 1);
+	if (ip->ip_p != IPPROTO_UDP)
+		return 0;
+	opcode = get_unaligned_be16(ip + 1);
+	if (opcode == 4 && ctx->probe >= TFTP_PROBE_DATA) {
+		ctx->probe_acks++;
+		if (ctx->probe_acks == 1) {
+			ctx->ack_start = get_timer(0);
+			return 0;
+		}
+		if (ctx->probe_acks != 2)
+			return 0;
+		ctx->ack_delay = get_timer(ctx->ack_start);
+		block = ctx->probe == TFTP_PROBE_DATA ? 2 : 1;
+	} else if (opcode == 1 && ntohs(ip->udp_dst) == 69) {
+		unsigned int i, request_len = len - ETHER_HDR_SIZE - IP_UDP_HDR_SIZE;
+
+		if (!ctx->requests++)
+			ctx->request_start = get_timer(0);
+		payload = (void *)(ip + 1);
+		for (i = 2; i + 10 <= request_len; i++) {
+			if (!memcmp(payload + i, "timeout\0", 8))
+				ctx->advertised_timeout = dectoul((char *)payload + i + 8, NULL);
+		}
+		if (ctx->probe == TFTP_PROBE_SILENT)
+			return 0;
+		if (ctx->probe == TFTP_PROBE_DATA) {
+			partial = true;
+			data_len = 512;
+		} else if (ctx->probe == TFTP_PROBE_OACK) {
+			/* Consume an initial retry before switching timeout budgets. */
+			if (ctx->requests == 1)
+				return 0;
+			reply_opcode = 6;
+			header_len = 2;
+			data = IS_ENABLED(CONFIG_NET_TFTP_VARS) ?
+				"timeout\0" "1" : "timeout\0" "5";
+			data_len = 10;
+		}
+	} else {
+		return 0;
+	}
+	if (priv->recv_packets >= PKTBUFSRX)
+		return -ENOSPC;
+
+	reply_len = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + header_len + data_len;
+	ctx->autostart |= env_get_autostart();
+	reply_eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memcpy(reply_eth->et_dest, eth->et_src, ARP_HLEN);
+	memcpy(reply_eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	reply_eth->et_protlen = htons(PROT_IP);
+
+	reply_ip = (void *)(reply_eth + 1);
+	memset(reply_ip, 0, IP_UDP_HDR_SIZE);
+	reply_ip->ip_hl_v = 0x45;
+	reply_ip->ip_len = htons(IP_UDP_HDR_SIZE + header_len + data_len);
+	reply_ip->ip_ttl = 64;
+	reply_ip->ip_p = IPPROTO_UDP;
+	reply_ip->ip_src = ip->ip_dst;
+	reply_ip->ip_dst = ip->ip_src;
+	reply_ip->udp_src = htons(1234);
+	reply_ip->udp_dst = ip->udp_src;
+	reply_ip->udp_len = htons(UDP_HDR_SIZE + header_len + data_len);
+	reply_ip->ip_sum = compute_ip_checksum(reply_ip, IP_HDR_SIZE);
+	payload = (void *)(reply_ip + 1);
+	put_unaligned_be16(reply_opcode, payload);
+	if (header_len == 4)
+		put_unaligned_be16(block, payload + 2);
+	if (partial)
+		memset(payload + header_len, 0xee, data_len);
+	else
+		memcpy(payload + header_len, data, data_len);
+	priv->recv_packet_length[priv->recv_packets++] = reply_len;
+
+	return 0;
+}
+
+static int tftp_test_probe_arp(struct unit_test_state *uts,
+			       struct tftp_test_context *ctx)
+{
+	void *buffer = map_sysmem(TFTP_TEST_ADDR, sizeof(tftp_test_data));
+	ulong elapsed;
+	int i, ret, ctrlc_state;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(run_command("setenv gatewayip 1.1.2.1", 0));
+	for (i = 0; i < 4; i++) {
+		ut_assertok(run_command(i == 1 ? "setenv serverip 1.2.3.4" :
+				       "setenv serverip 1.1.2.2", 0));
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->drop_arp = i == 3 ? UINT_MAX : 1;
+		ctx->probe = i == 2 ? TFTP_PROBE_SILENT : TFTP_PROBE_NONE;
+		ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
+		elapsed = get_timer(ctx->request_start);
+		ut_assertnull(tftp_get_request_timeout());
+		ut_asserteq(i < 2 ? 0 : -ENOENT, ret);
+		ut_asserteq(i == 3 ? max(1, CONFIG_NET_RETRY_COUNT - 1) : 2,
+			    ctx->arp_requests);
+		ut_asserteq(i == 3 ? 0 : 1, ctx->requests);
+		ut_asserteq(htonl(i == 1 ? 0x01010201 : 0x01010202),
+			    ctx->arp_target.s_addr);
+		if (i < 2) {
+			ut_asserteq(sizeof(tftp_test_data), net_boot_file_size);
+			ut_asserteq_mem(tftp_test_data, buffer, sizeof(tftp_test_data));
+		} else if (i == 2) {
+			/* ARP retries must not consume the server's response budget. */
+			ut_assert(elapsed >= 100);
+			ut_assert(elapsed < 900);
+		}
+	}
+	/* Ctrl-C must also cancel the separate ARP wait. */
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->drop_arp = UINT_MAX;
+	ctx->abort_arp = true;
+	ctrlc_state = disable_ctrlc(0);
+	ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
+	clear_ctrlc();
+	disable_ctrlc(ctrlc_state);
+	ut_asserteq(-ENOENT, ret);
+	ut_asserteq(1, ctx->arp_requests);
+	ut_asserteq(0, ctx->requests);
+	ut_assertnull(tftp_get_request_timeout());
+
+	/* Failed or cancelled ARP must not leave a request or timer behind. */
+	memset(ctx, 0, sizeof(*ctx));
+	ut_assertok(tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0));
+	ut_asserteq(1, ctx->requests);
+	unmap_sysmem(buffer);
+	return 0;
+}
+
+static int tftp_test_probe_timeout(struct unit_test_state *uts,
+				   struct tftp_test_context *ctx)
+{
+	ulong elapsed;
+	int i, ret;
+
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(env_set("tftptimeout", "1000"));
+	ut_assertok(env_set("tftptimeoutcountmax", "1"));
+	for (i = 0; i < 4; i++) {
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->probe = i < 2 ? TFTP_PROBE_SILENT :
+			     i == 2 ? TFTP_PROBE_DATA : TFTP_PROBE_OACK;
+		ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, i & 1 ? 2 : 0);
+		elapsed = get_timer(ctx->request_start);
+		ut_assertnull(tftp_get_request_timeout());
+		ut_asserteq(i < 2 ? -ENOENT : 0, ret);
+		ut_asserteq(i == 1 ? 3 : i == 3 ? 2 : 1, ctx->requests);
+		ut_asserteq(IS_ENABLED(CONFIG_NET_TFTP_VARS) ? 1 : 5, ctx->advertised_timeout);
+		if (i < 2) {
+			ut_assert(elapsed >= (i ? 300 : 100));
+			ut_assert(elapsed < 900);
+		} else {
+			ut_asserteq(3, ctx->probe_acks);
+			ut_assert(ctx->ack_delay >= 1000);
+		}
+	}
+	/* The next ordinary transfer must not inherit the short probe. */
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->probe = TFTP_PROBE_OACK;
+	ut_assertok(tftpb_run(TFTP_TEST_ADDR, "update.bin"));
+	ut_assert(get_timer(ctx->request_start) >= 2000);
+	ut_asserteq(2, ctx->requests);
+	ut_asserteq(3, ctx->probe_acks);
+	ut_asserteq_str("1000", env_get("tftptimeout"));
+	ut_asserteq_str("1", env_get("tftptimeoutcountmax"));
+	ut_asserteq(-EINVAL, tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 0, 0));
+	ut_asserteq(-EINVAL, tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, -1));
+	ut_asserteq(-EINVAL, tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 1073741824, 0));
+	return 0;
+}
+
+static int tftp_test_download(struct unit_test_state *uts,
+			      struct tftp_test_context *ctx)
+{
+	static const char * const autostart[] = { "yes", NULL, "no", "yes-please" };
+	const char *timeout, *retries;
+	void *buffer = map_sysmem(TFTP_TEST_ADDR, sizeof(tftp_test_data));
+	int i, fail, ret;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	/* Run the address callbacks used by the legacy stack as well. */
+	ut_assertok(run_command("setenv ipaddr 1.1.2.3", 0));
+	ut_assertok(run_command("setenv serverip 1.1.2.2", 0));
+	ut_assertok(run_command("setenv netmask 255.255.255.0", 0));
+	ut_assertok(env_set("tftpserverip", NULL));
+	ut_assertok(env_set("netretry", "no"));
+	ut_assertok(env_set("tftpsrcp", NULL));
+	ut_assertok(env_set("tftpdstp", NULL));
+	ut_assertok(tftp_test_probe_arp(uts, ctx));
+	ut_assertok(tftp_test_probe_timeout(uts, ctx));
+
+	for (i = 0; i < ARRAY_SIZE(autostart); i++) {
+		timeout = i & 1 ? NULL : "7000";
+		retries = i & 1 ? NULL : "09";
+		for (fail = 0; fail < 2; fail++) {
+			ut_assertok(env_set("autostart", autostart[i]));
+			ut_assertok(env_set("tftptimeout", timeout));
+			ut_assertok(env_set("tftptimeoutcountmax", retries));
+			memset(buffer, 0, sizeof(tftp_test_data));
+			memset(ctx, 0, sizeof(*ctx));
+			ctx->fail = fail;
+
+			ret = tftpb_run_timeout(TFTP_TEST_ADDR, "update.bin", 100, 0);
+			ut_asserteq(fail ? -ENOENT : 0, ret);
+			ut_asserteq(1, ctx->requests);
+			ut_assert(!ctx->autostart);
+			if (!fail) {
+				ut_asserteq(sizeof(tftp_test_data), net_boot_file_size);
+				ut_asserteq_mem(tftp_test_data, buffer,
+						sizeof(tftp_test_data));
+			}
+			if (autostart[i])
+				ut_asserteq_str(autostart[i], env_get("autostart"));
+			else
+				ut_assertnull(env_get("autostart"));
+			if (timeout) {
+				ut_asserteq_str(timeout, env_get("tftptimeout"));
+				ut_asserteq_str(retries, env_get("tftptimeoutcountmax"));
+			} else {
+				ut_assertnull(env_get("tftptimeout"));
+				ut_assertnull(env_get("tftptimeoutcountmax"));
+			}
+		}
+	}
+	unmap_sysmem(buffer);
+
+	return 0;
+}
+
+static int dm_test_tftp_download_only(struct unit_test_state *uts)
+{
+	static const char * const vars[] = {
+		"autostart", "tftptimeout", "tftptimeoutcountmax", "ethact",
+		"ipaddr", "serverip", "netmask", "gatewayip", "netretry", "tftpsrcp",
+		"tftpdstp", "tftpserverip", "fileaddr", "filesize",
+	};
+	char saved_bootfile[sizeof(net_boot_file_name)];
+	ulong saved_load_addr = image_load_addr;
+	char *saved[ARRAY_SIZE(vars)] = {};
+	struct tftp_test_context ctx = {};
+	const char *value;
+	int i, ret = -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		value = env_get(vars[i]);
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i])
+				goto out;
+		}
+	}
+	memcpy(saved_bootfile, net_boot_file_name, sizeof(saved_bootfile));
+
+	sandbox_eth_set_tx_handler(0, tftp_test_tx_handler);
+	sandbox_eth_set_priv(0, &ctx);
+	ret = tftp_test_download(uts, &ctx);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	image_load_addr = saved_load_addr;
+	memcpy(net_boot_file_name, saved_bootfile, sizeof(saved_bootfile));
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		char * const argv[] = { "setenv", (char *)vars[i], saved[i] };
+
+		if (env_do_env_set(0, saved[i] ? 3 : 2, argv, 0))
+			ret = -EINVAL;
+	}
+out:
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		free(saved[i]);
+
+	return ret;
+}
+
+DM_TEST(dm_test_tftp_download_only, UTF_SCAN_FDT);

-- 
2.53.0

