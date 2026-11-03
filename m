Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C7606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nSrGU3sO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btxns1mF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E82E86070F;
	Tue,  3 Nov 2026 12:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ai3YbP-vYrnU; Tue,  3 Nov 2026 12:53:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A7BC606D9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793710382;
	b=TvI3PyImeb57flfZj7o92V9TAedo5yEfP/VSNZC1F1R5IMqIsdLwLEPhWKaNrKsnGze3
	 4OOBRfUhwrFAHEFjV0SHCCKm8/0ZFSy/Q26uOLyRUuZVmH8/i+AdwCWVuUQgqfsDeoUtE
	 FnQcrveyF4SUqr18NH9M8FjCHjOoTSAkIJQM673FKlCR7xbFpGvB281dqujBfoHLazJd+
	 qpEtfnzAVaneiBr2DW+yrkMtFLHA7q1htY1HEMIiuquyL66u0ZgdBgO/NhOSYg+2Vx6Hc
	 2JKQTYexToxQOWYF3Zat6kK9qTgHtxo1z5dqedLCtSczEculb7kj3txVjBAvO130vFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793710382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=njrZFineKQ7zuJCDKdGgWpi8qbi0RLM1pI7OCvhzEvo=;
	b=rNJAc02L4U/Z6zWYI1SlrCtSNvdMpASe5HB5GBpxWZKaMNP8nD5yufhVadnJV1v6/TS4
	 K28pEhTKV/qhnw8e7i+cH5adNwI6vdyAnl2ti9IX360Tf2JX0h4PZjtWgT8gpLyx1JzUD
	 7IhL7hjV1JXCyzThRFTCpI4mfrVNkdl8c2U6T0Nm3KK3nS8aXiuf6109m4QL6AJX3UvJG
	 1QsBhvj6gN/U6HAzsg2L7P7lSctRglWggqdK0XWm9lydAvZfqJrdSaZ5kjETmZ4ky4sH8
	 HkPOlrPvKkCh9+NnwK0XSj7qP7cpGLpxzYAlfkmwRkfMkdWYXdLD6vsdrb5uZzspaGQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btxns1mF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793710382;
	bh=njrZFineKQ7zuJCDKdGgWpi8qbi0RLM1pI7OCvhzEvo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nSrGU3sOYHZgTDmxG1Fhg61L2eJHeoTr9AZ8yZkvw39pPnBix0KvEhD2UctcTiIjg
	 jtaz8+qeVd6BKLtZXUDjCUzeplKDbtOvcOvhOfeWov4S3ZdRc0iEEI6FUQoUTvX4zs
	 sujsbonYCRKyr7nrVYgDalH0t3oyhiylEM5QMXrX5ZDpLVfdqclbBdozXEwCYcQ/4b
	 flG/zZrdl1IeHgxEeA7nTJIJazzr1nZGEpY4USkSGYgkWQ/Y6RaSJGzH9glUNPV2h4
	 vRwVqhw6gR1NjlCUhEYHX9QG557uktvrYtiXkhr7IpXXv/4pxWwOvUrWkrjhEin0Sy
	 a+8ywn9n5lsdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A7BC606D9;
	Tue,  3 Nov 2026 12:53:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C512EA15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB472606CB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:53:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JtISDUX7PDFp for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:53:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D981606D9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793710380;
 b=r9HxMP38MuBRph6YJ58761l26ncMgPJq/l+9qf4Ek+xCjwFak73XakF4OkyB+1DhgNdH
 u7tVOceO5gqhxuLGpmhidePHG31Vt/zo5tGrVcbOOTeayV4AT/8AEJOnsJ0FEAlNeKbPK
 lLOjJ6G9hYeg45SYLMCUCT8EqP94PeuNoTvmCJKgH5Hor2+R8dLAlg5dQGwu42sgGbtZ8
 kg16lcC2tnlFdc+osLo1edWuQSYG1SrG3rwP2EbfPrf0wjAAmcdmrsziUli7XPzdc436c
 qcGeRzECKjiMs0BgRnVGXGY4vWH4xNxIMrfp16bphBxOmb1Cf6eVAT4Dry18IjEvsSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793710380;
 h=Received-SPF:Received:Received:DKIM-Signature:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=njrZFineKQ7zuJCDKdGgWpi8qbi0RLM1pI7OCvhzEvo=;
 b=CTWxkI7vzoxZpQBDF67s0JociDFHaRPRYCcxtN5y5j4AwSsAyYUYo+wQ/u46aRd9KNDg
 YIHZiSwunzGz/tTuqk0v71/M9QkuBA1fQuk2rwc4Sn7YSSleOtXvOBoxBlezbKV+qQFkc
 r4qXy7EpDlxQx2/LmgJDzRq465P2fDUBOhitW0deF8xuRhb3A2WOiaGXmzig5bjuIJzSV
 kuBcOIFbjU9tf1GgqXs/nFdx8yeRlS6fFaF55VBvXIARUDAVZ/qBqegRuFN85QN6lf9KR
 HMyVlIeP+/b4Q3kFt3WgIVEInI09BmYxARz4TEZ1yki95LghfX+lE9XTP38cw+W+tSA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=btxns1mF; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=btxns1mF
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D981606D9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:52:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 354B6411A3;
 Tue,  3 Nov 2026 12:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9690A1F00A1A;
 Tue,  3 Nov 2026 12:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793710377;
 bh=njrZFineKQ7zuJCDKdGgWpi8qbi0RLM1pI7OCvhzEvo=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=btxns1mFMUF7UiBe7iWnmTYE9t8HdaB5g/rvyHtLUHfOIlOYT9BAkm0wbHcrX0xd5
 Y5Yk47nA/Dx27w+ilumoU3C1ZOgjL/5BriVlO0T49K+7ajmgxYdMn2C1PdQWH33zpt
 Wr/Zxisb77v4BhmcwQKSu9JlCIMxEHVk/AfYFN7JgbBRtG0IViIq2j2V2T1Jdf3zD6
 IDXCzqpFHu6ybObnfU7NAZiazegUwCyOXVX9FM4QV+H1V7o8D46EEjfjTAk3pMnnlx
 8pOcd0YXhBCQfjp0R8qjpUYQ3icpMA7Is6rFgOE48TCwZlHE1J+yY2t4FzmM0B+bfi
 +SX+8NbCH9hiA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] libavb: resync with AOSP 1.4.0 on U-Boot's SHA library
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jan Kehren <jan.kehren@emteria.com>
In-Reply-To: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
References: <20261023-upstream-libavb_b4-v1-0-97ed25b09ed3@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 13:52:51 +0100
Message-Id: <179371037162.349126.14908074643674172139.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=652;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=RhEuH8P85dOG0Ol+qym5AO7ThC4LObhUUfXbLP8xiKQ=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq6dkmGEDAko3VVm4D67w9Kl5MfHvkjcTcS0Zru
 yXCbz1BM7qJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaunZJgAKCRAZDR20Zk4Z
 NQCICACIZYyoMYT2tqvF5zeJjUemZEtBoKJkL6mKL6ex0MbA4DcQylt4xOQw1bQEdmLB7a1anQg
 yEOiTJnJg1Ig/z3mm9pvrfseM3u8/AvqFsq2y3d00EG4al0EPyUjE5pMDrTs5xlkb0BoeZGUIiN
 mIFMrG/591dR5DaGomXzLa4c1sS8j1iJtAMYiUYSkGm7PpZQxFQOoi2nVb534kD7bIEG4xkbCWW
 1WIafFXWtmdyg7uw5LifMOSyhxwQ4a9BvWtDDaf/YQbQEA++EmbprN7HY4/B0ewzadhu2DUs4WW
 9eMBnv91+aMkHQKInCJzJaNh+aQ43JioDp+VUvHA49YXZ9m+
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 21:50:44 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> libavb: resync with AOSP 1.4.0 on U-Boot's SHA library
> 
> lib/libavb is a copy of AOSP external/avb's libavb from 2023 (1.3.0)
> with U-Boot glue. Upstream has since fixed a verification bypass in
> chained vbmeta partitions, a silent failure of RSA verification on
> allocation errors and out-of-bounds reads in the key parsers, and
> added the vbmeta digest command line properties that newer Android
> releases expect.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
