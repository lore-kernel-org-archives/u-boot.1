Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48160C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 13:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AA43405F1;
	Mon,  7 Sep 2026 13:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdukyQOeU11d; Mon,  7 Sep 2026 13:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D69524058A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788786185;
	b=OxpwOQEiAvzOuSPkz+YZfs1FcyDeWlrRh6fqk21c7XZAlQrtvqMvgEww0oHsoPiBTaWE
	 EyFWxsn/yZBp3CASiCc6OtWPmnNNvhp5AZcMGatn0gryYjxMIBr/+o+p2JmkTmPgvNSTv
	 4MpdKavs1Jfg5Zlz/s1yC4/9sFneRu4fp/OvdzciwYcoJF59eZWj/Js0WUz2qY44yi5GQ
	 WjhOBpnBs7q5ABtkfkkzRHPaRWPl9Z0cR9QnyvNFLvQHk5192G3vBepcEHiKFGPIQLu4C
	 AlQtOEDRprZPTf0AyVAbjQk1sctCMbYFzFBBzjTSJ4AVb0CK6eerDx4rJmW9PxSKFxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788786185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SW8wcSaofcukBWr7u8EuEAQxdnOJAh7KqQOP8zbAv6g=;
	b=LQpAO8GqjTeyVTlHmbsgTncEGLKwYGhxpUKG/iJNfceWuO6bud4I1ygkdbv99HX26P7M
	 lYlyp7x1V76AqhrehnlKMjgzRhC4B7b+zabH6uedks/yt9L2R7xQ5OXA9NLiPIp3n/p9X
	 x0QqxTxJHO6NS7fw+JhjWg0du2+UuZWhlK2qznxg7k/1kdEEktW2gFbuaL9zB/7RdBL1r
	 EGeGJc6PSuKyFw1ktEgQocDgjPoFJd7BcUNPTWixN35KRaZxVjT78CYzYNJOFs12p71ri
	 zt36h2pTSihyA1JX8GM/6OsoCQDp/+BrRi7JdNq0h17YYw/zhNnRMuERwSGeSqC87tA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788786185;
	bh=SW8wcSaofcukBWr7u8EuEAQxdnOJAh7KqQOP8zbAv6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P4sxvrxJYOhQoPDngaBoNpJdUatdegTHDPf2BGjBQnr4eBK3i7tg4wg+K5/TBg9i/
	 CV8MVvn8gvr4DpRERZf0NF/7FuE7sU/2Twtabq/vGGBTwp+RLrqLhOdLBvOFhu/ZIB
	 RFZVE8c05/ArfclvbtVRsrAELe2rfkRxvS1FaEUx6Ycu9GvOQycRnqmwrJl7Y+mjCQ
	 IT8SG1ffehtoCNzgyn8cOyzCafzA0kgXnMH5ok8lA7eFMFh7PXl03NybZzX3JxILeq
	 NCMERpQ5/bWQhnTC+eUd3/Ut86787VrX/8jH/D/Xwz6e7dKfM6dN3EIi3QhejgfRQw
	 qv6Abt7w9gdVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D69524058A;
	Mon,  7 Sep 2026 13:03:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AF0AFD61
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0E5180963
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:43:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FR1S2LVuCFu for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 07:43:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C06C380960
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788766980;
 b=FrsGRKUEbzOFLoJpfU0JUuYLhQgaAJpIeeoLRYjhim/i9ieEkY32clw09T0ROP7H5Cki
 PuUSgB+PfgjIt9ZG3IYAttQT/XlL3QfGZOPhqnhRcNu2bWJqqc8L2wZD07/cMrk8Oi2Qq
 1b+0/Ie4aSxf+3jdtGFDHa0bZBrnGSX1J/IPp8oP82/+AQcQGfiM4zuBUw8LC6cv22oYp
 0iI8sNwPaIp6xflx8ZYi4is/lo89CBKjAksqmW114DqRhdOTMuwvDBTjA+EdK5Wm+vrT0
 wddt0VnuLNAnlDYtdQKc+Q5ONyeo4COUiisZoKXCt9dgkHlDqajk5OJDkQ64FNz4fTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788766980;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=SW8wcSaofcukBWr7u8EuEAQxdnOJAh7KqQOP8zbAv6g=;
 b=tgoTbi/6MGLtCTL2nfihDKey1NF0nNtMQFdh6YWnDwVGSLWwsVs0ZOYEp9vbsN2Sib1+
 GhtaZCcg8ctMMsmxF8spf9gSM9U1aHn+t5p+KVEx5Cm9ty8WCXT/XUsqUR374wrwD3En2
 Qq0VBXaMLoqKEOE8dRkq4dLZeMoK1K8xF0RBxSWd2UgTiG+GtlmQ8G3xgZJs9t41HWk3d
 XojAUgoZQE5pXSRxwAcYQYOvr1K3ghleOO9vUoDshoNpaYaM22eWDMtq4apKcD+EnISsR
 Yo0hFYSlkW5ZmPFuefUaUoh+NPfa0iR4OM+LwZc4RoPAI3QCTVjMGOdmizf/decrv4Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=PX9uCJde; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=PX9uCJde
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C06C380960
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:42:58 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 854303F28B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788766976;
 bh=SW8wcSaofcukBWr7u8EuEAQxdnOJAh7KqQOP8zbAv6g=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=PX9uCJde3DAlYkz4R+FHeulzwOvjIE6tf1U5OKbgTbOpi7rMgNWNcpArKK7caGIMc
 oIFd/ss4sNlMbPtDuT6NiAFo+Tu8mFaJMG45WvhWoeyPlJAq+NVuhEYpEFiT7au7SE
 4YWl5l/5/c3f/2CaBBCw0j3kjICnocItg4kv7C7+Hu6nPaNTeTtbSXwdd9bUlupPOy
 6xJO7TXKFMdf2HOSQquP+bfYIwgaRnVRT2VxLUZ6XPa8RrGH0zZ5NDRh2d7vUxaSEs
 RjR+pu/4QtLns4rsHWlSnQGJedB+iY3l8YtXrHcpN3J43nKZV+Hyz+9OjHmNb0S+ja
 RD29uAM4bxR+5Q/87UgHZtf9g0YM8Ye4z+4MFyUD84JIkcxHzfHlDE7C1xY12T3jUV
 aO0xNsP5fJjlOD7WGs0tRutT4Fa3ozDsxp/iHJEoHqJlVJS/XsHNqWM+lnnvGjsZ2J
 TV7IFJFQQShNMJsBUzk3j+3ozjJLUc2MmHVAZNJ/DkNUkGleQnBPf62ao+D8vgFL56
 O4MpAWOwYDyZwM/Un65Xx3hKlBIJY1LjjgsbP6FqU5ZlIv7OjCEInXgRVoCHHvilzE
 ln9JFWAzhXz41LAFfI2EBUAcVK/twMFc23cxaBtkICuYa9v18fKRKoIPb5wzZNVVL1
 pjv+PAb9xj7cP0m+inbXCuyw=
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84a251c2e3eso5124024b3a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 00:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766975; x=1789371775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SW8wcSaofcukBWr7u8EuEAQxdnOJAh7KqQOP8zbAv6g=;
 b=PW93AO28VV6Xgxz90RzTQPIvarrojgE7ZVgZUMShXjkCcRq7CUrwN9D6cO3MtCT+Lg
 lpNqVE0noi0NbPbdSYLnp9lp5s5yXGfprG8gjzM/ptYrYgaNFe+l20RJr4bemLR88iyn
 aowrHTjDaB8RIShkpCjG8Zu+QYjl+vATV68aUQ0JR+5eCeX7elzO0baq6qGHOlpBqty/
 /9A0uC5cwKFLoIR8Pt3DuBtmWv6aUUEttLI6a7jvFaPMo7E0DvLg/em7GnLXBBJ1USjn
 qXEVIRZbVtx2167Dz/SvsRy6MSynjY9GPDexdkpBgVK5BD9SN3VVRVf7mAUNZaFfjcLW
 w4hQ==
X-Gm-Message-State: AFuF++mGZadZwhPXv53Jq7X4DPZ6XlsrNhvbO5xx0MZJzta9zBMot6iP
 2gIGhUhDNCB6gTfzlLdSOqOUQBD3btaqAgo7CLMNAFhNjKB7U0JVv8kSWDuW0oGEhKO/gca9UWc
 +BJ5PPRaNTSHk9vgWv/ZdtY9wSrEb7C1WtfdLVQ6N+JL+yUxAWR6TcIKdWZr3UtUU9r53NVg1tP
 UxFvwGLrYzOeG5bCQOeg==
X-Gm-Gg: AYBFou3iKOQTITbsrZ7/GrPoHTJB8f6LuR884aSBvnLrk6uhKbxH34bEo0Ar4UzjAoa
 iwtSoHK2SIAC6n0r0prBCSZVpUiV8khNTvgempMhs3hqNSv+UyjQ4MGz42CyE8DDCfGRK9mABD2
 6w9SHfrvKKsP9ouBVF3127Zcd9Rw9GnW826tCu7mSpfVKaGb/p8w0Tuu4qWaZAPRqGgal10KO7c
 7RphmHNzkmuT7i2U0iArzgd/tjA4Vdo803JyBT4bt4ES7CgEJwy39qmfIV2UD8WSXB1MiGSVEsf
 CbQW9Jl/bgnfxBjx48qPeb78r7JjqFfS2g3nVpspHyILGIOhaFGZlLFyMNuCDgmSoKD2bHn592D
 cym25WlenA1x8jR3GcP8CE4sr0sYPcJ1QeF0ShZkuwlyQq4s=
X-Received: by 2002:a05:6a00:410d:b0:851:8bde:7861 with SMTP id
 d2e1a72fcca58-86199e9d400mr15698078b3a.1.1788766974943; 
 Mon, 07 Sep 2026 00:42:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:410d:b0:851:8bde:7861 with SMTP id
 d2e1a72fcca58-86199e9d400mr15698056b3a.1.1788766974521; 
 Mon, 07 Sep 2026 00:42:54 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8615292d875sm3974215b3a.25.2026.09.07.00.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 00:42:53 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/2] bootstd: cros: Validate keyblock_size before locating
 the preamble
Date: Mon,  7 Sep 2026 07:42:17 +0000
Message-ID: <20260907074221.3718-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907074221.3718-1-aristo.chen@canonical.com>
References: <20260907074221.3718-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 13:03:00 +0000
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

cros_read_bootflow() locates the kernel preamble with

	preamble = (void *)hdr + hdr->keyblock_size;

where hdr is a PROBE_SIZE (4KB) buffer holding the start of the kernel
partition and keyblock_size is a 32-bit value read from the disk. The
only field checked before this is the keyblock magic, so a corrupt or
malicious partition can carry an arbitrary keyblock_size and make every
subsequent preamble access read far outside the buffer, crashing U-Boot
or fetching garbage that then drives allocation sizes and disk offsets.

Reject the partition if the keyblock claims to be smaller than its own
header, or if the preamble does not lie entirely within the probed
area.

Also require the computed kernel body offset (keyblock_size plus
preamble_size) to lie beyond the probed area, as cros_read_kernel()
already demands just before reading the body. Rejecting such invalid
metadata during scanning means no bootflow is created for it, and the
single comparison also catches a preamble_size that wraps the 32-bit
sum, since a wrapped value is necessarily smaller than keyblock_size
and therefore below PROBE_SIZE.

Fixes: 3257835e5640 ("bootstd: cros: Decode some kernel preamble fields")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootmeth_cros.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index f894ed78e3a..685d5335e86 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -369,6 +369,7 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	struct vb2_keyblock *hdr;
 	const char *uuid = NULL;
 	struct cros_priv *priv;
+	ulong body_offset;
 	int ret;
 
 	log_debug("starting, part=%x\n", bflow->part);
@@ -380,6 +381,31 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		return log_msg_ret("scan", ret);
 	}
 
+	/*
+	 * Make sure that the preamble, which follows the keyblock, lies within
+	 * the data read by scan_part(), since keyblock_size comes from the
+	 * disk and cannot be trusted
+	 */
+	if (hdr->keyblock_size < sizeof(*hdr) ||
+	    hdr->keyblock_size > PROBE_SIZE - sizeof(*preamble)) {
+		log_debug("- invalid keyblock size %x\n", hdr->keyblock_size);
+		free(hdr);
+		return log_msg_ret("kblk", -ERANGE);
+	}
+	preamble = (void *)hdr + hdr->keyblock_size;
+
+	/*
+	 * The kernel body must start beyond the probed area, as
+	 * cros_read_kernel() requires; this also rejects a preamble_size
+	 * that wraps the 32-bit sum
+	 */
+	body_offset = hdr->keyblock_size + preamble->preamble_size;
+	if (body_offset < PROBE_SIZE) {
+		log_debug("- invalid body offset %lx\n", body_offset);
+		free(hdr);
+		return log_msg_ret("bod", -ERANGE);
+	}
+
 	priv = malloc(sizeof(struct cros_priv));
 	if (!priv) {
 		free(hdr);
@@ -391,8 +417,7 @@ static int cros_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		  (ulong)map_to_sysmem(hdr));
 
 	/* Grab a few things from the preamble */
-	preamble = (void *)hdr + hdr->keyblock_size;
-	priv->body_offset = hdr->keyblock_size + preamble->preamble_size;
+	priv->body_offset = body_offset;
 	priv->part_start = info.start;
 
 	/* Now read everything we can learn about kernel */
-- 
2.43.0

