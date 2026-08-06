Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD29C5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C87860820;
	Thu,  6 Aug 2026 11:00:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xj_lO4Rvzk89; Thu,  6 Aug 2026 11:00:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 258D060803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014054;
	bh=foA5zoWJyA+ulKyhnTSy9/PxlqMU/aRhcIVUSep4JmU=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rt9f8gnGtXaNXhy15luLKwpWZ25+6z22q/jT3SOG5XTvMLFB85tpXw8MkCKZNwVEa
	 fIKVEVA/2E7crU7Hd3/N6VmbrDOuZSe18RxF1t4Y2UFJl2dQDFdrXxFXOviO8GbGMq
	 PxCIP7+hJewTDPZ0deCEFqWOTLfossrbrox8+i7W4vK4GrVvhDFrJhJDcEVq6HNUHO
	 wsDEOV9ULQ+R1x8qPiFunepV39Js7lhoEw2JlFXoYMZm4qkUCRm5vm1JHetvIUitAs
	 gZRW+5YI3uFs4iJznlFvWbTLv00AjKXQt4dPVbtoTfTXUNAH6iWV3oURcJdodYGEXk
	 Cexfivr84gXQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 258D060803;
	Thu,  6 Aug 2026 11:00:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 12C08282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04DEF80D5B
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3EpyZ1YhpHNY for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 10:37:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B398F80CDB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B398F80CDB
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B398F80CDB
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:43 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CF1243FBFD
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:37:41 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d001671a54so39069305ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 03:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786012660; x=1786617460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=foA5zoWJyA+ulKyhnTSy9/PxlqMU/aRhcIVUSep4JmU=;
 b=j6bGu7clxMj0CvfbBn0opfw7Uh5JmlhqNXuFLuMmewMuYnS23A8MY8WtgUbscrCp3Z
 OEX0g6n3bsQ5hyPA+nVUFoTQ3y3oPA+nEYxjroejcB2lOiX9K03dAzsLSkX/5HYEBmbi
 xXB8+9pMcS5bFFhfv5c47c4KWqrgu7xhr7sjzWuYUeENcXsgdDL9aW6vpghvdctepNVL
 td3MduvgFvUatM04ZJ6PrMkYiGhHhyxKeGRFXVzuhGJh9dJyvW0fWTRaMf8woLDrOHWa
 FszAldoe7Zi2s9mSMhp/7OPqp/vvtovZ5aaBBhCN47QNp5sKWmlUGLzbfXVlM6bJRnay
 QRKw==
X-Gm-Message-State: AOJu0YxMsGcL4WFVlmaVFZckS9Ij43i8CseMH51UnJmw/ndsrgywL6U0
 +e7HmGkcVo1d9D4qK+zLAMZ/mkRV6l5850VH9dW6Wd0oL8yb2OO1ifhpC3IvFsSyZpxapCFe/4a
 2epaM4QssBeAzF7rIEhGaIveFwauKR3l1mNHBD4LZ4NIBjq9UffhiqsltMtG5/Y2rG6iB1qxrYs
 CQ/0+RoMBxzGNuZ0MTMw==
X-Gm-Gg: AR+sD11IzG3j05AvWhBdEB+eaVWphrfeg3N87emFfZV+TsYG+0vPZn8oh+7qzEU7uK1
 61knBFBYsjj+BEF63lDmjXLVQr6lj5kxCUme4h2FJsnaW8dce6w/pL7Y3sTLcwDVmR/zTLm1jyV
 3kSiQEKAF35gqQjjXA24xpLE0/zuajjADZ8fGVqak1JvOB3krdKS8NSkvU+ZF5OJjWKvcYvfmiI
 dJZTWx62H0AzcW1nRXPhWiEr4A47S3watV3TvfSyOVmgIfPWjte6XlwwWDt2MliA+Pa3G7H3Lpw
 eHywlEc2lFLAq+KwoiyXaSWieZB4yxGObEPTXeAxCEfOWGmn2mpJoHotWhQYDV5oLuXvgEEwdlQ
 3gi6k6rzvxi+d8Mopv1AA2r5mKacwxbIVj55OZ1VHhKkCOmFL
X-Received: by 2002:a17:903:3903:b0:2ca:6c8:abd8 with SMTP id
 d9443c01a7336-2d0ca751829mr174592345ad.12.1786012660308; 
 Thu, 06 Aug 2026 03:37:40 -0700 (PDT)
X-Received: by 2002:a17:903:3903:b0:2ca:6c8:abd8 with SMTP id
 d9443c01a7336-2d0ca751829mr174591405ad.12.1786012659790; 
 Thu, 06 Aug 2026 03:37:39 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9fd3949sm29640545ad.18.2026.08.06.03.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:37:38 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] gunzip: Fix spurious Z_BUF_ERROR in chunked gzwrite
 decompression
Date: Thu,  6 Aug 2026 10:36:59 +0000
Message-ID: <20260806103720.1026454-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806103720.1026454-1-aristo.chen@canonical.com>
References: <20260806103720.1026454-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786012661;
 bh=foA5zoWJyA+ulKyhnTSy9/PxlqMU/aRhcIVUSep4JmU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=FwIfLvA5x9o1ZQfbaKIq9vWvEQ8R1MzA0A+sEnhhojYQspJMu5cz06WyL9Pn605oa
 ulNRYcMGYD8+vamDvXkapXJzblLKr/HayugFlJrS11w06GrtJuPjLJ8OeGcaAtS8ha
 vmHMs4FdnrMxB1eHaQ/XAYEHFg4vXOFWhDbZgIp/tyQEiKwP/RuLz+VRodxjj5MQoi
 Shkx3Mg/qpqC5jPzrK+jKEElMKsoNfXdEzGm8zitX4kjwFMwvEOmD75tajUXOOekca
 ZiOqsNSe5tRNL8wpGGF4evVQNSqhZe+UG2cKz/6wYiyz4/yIW0DNNGD9XO1BlGrNEg
 373ZU5f2Vnlovmf9UFc+3McrsAQK7HV2nnHzjdh6C+Qs4qKfxGzpcdk/s2BzWjMKTs
 j0PmiIP57ZTtqjfLRzHD61o8xVVm+WZxqO5ZRpZXR0TI3gKyNDny8uLgDs5Zsq7ArM
 iVxrs2bH2TAxjBmVWS7TnosT/yfGwkhNzy6llyo8KY6cn5hF3Xh/RHx/L1zZSNX/uA
 ihNgp0AQXVwE6rJDjagfc9LI1ZHmNjTgXIBlGURY7lcud2FhFULdU9PPKOZmflD8Vd
 8fnbG/sWd6n6BytqapDWB2mipyX9lvQsehZwbB3r3YHioeQoZ6r8UqUUtO8peJasMg
 ZpH2FI0jJ0lm03DP5ewn9PhE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=FwIfLvA5
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The chunked decompression loop in gzwrite() treats any inflate()
return value other than Z_OK and Z_STREAM_END as a fatal error. When
the current input chunk happens to be exhausted at exactly the same
time as the write buffer fills up, the inner loop calls inflate()
again with avail_in == 0. No forward progress is possible in that
state, so inflate() returns Z_BUF_ERROR and gzwrite() bails out:

  Error: inflate() returned -5

Per the zlib documentation, Z_BUF_ERROR is not fatal and only means
that no progress was possible; the call should be repeated once more
input is available. The reference implementation in zlib
examples/zpipe.c continues in this exact situation.

The failure is data dependent: it needs a stream position where the
consumed input and produced output line up with both the chunk and
the write buffer boundary at once, and the inflate side must have no
buffered output. That is most likely with incompressible input, where
deflate emits stored blocks and inflate holds no lookahead bits. This
is how dm_test_cmd_zip_gzwrite occasionally fails in sandbox64 CI on
random data with gzwrite_chunk = SZ_1M + 1, stopping at a multiple of
the 1 MiB write buffer:

  12582912/16777216
  Error: inflate() returned -5

Detect this case and let the outer loop refill the input chunk
instead of failing.

On sandbox64, the random data dm_test_cmd_zip_gzwrite test failed
17 out of 2000 runs (about 1 percent) without this fix, every time
with the same signature as the CI flake, and passed 2000 out of 2000
runs with it.

Fixes: 58e523fedf48 ("gunzip: Implement chunked decompression")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 lib/gunzip.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/gunzip.c b/lib/gunzip.c
index 20cc14f9688..b30cbfc34ef 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -246,6 +246,16 @@ int gzwrite(unsigned char *src, size_t len, struct blk_desc *dev,
 				s.next_out = writebuf;
 			}
 			r = inflate(&s, Z_SYNC_FLUSH);
+			if (r == Z_BUF_ERROR && !s.avail_in && payload_size) {
+				/*
+				 * The input chunk was exhausted at exactly
+				 * the same time as the write buffer filled
+				 * up, so no progress was possible. This is
+				 * not fatal, let the outer loop refill the
+				 * input chunk.
+				 */
+				break;
+			}
 			if ((r != Z_OK) &&
 			    (r != Z_STREAM_END)) {
 				printf("Error: inflate() returned %d\n", r);
-- 
2.43.0

