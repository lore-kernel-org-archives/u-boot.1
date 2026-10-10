Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F03BCA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44297608DA;
	Sat, 10 Oct 2026 13:12:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJCteHtmEwqI; Sat, 10 Oct 2026 13:12:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 50C98606F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791637933;
	b=qQDQvuRDzJVrvQQ8lTWSCZu3kpjjhvLGzGl7KaTyVb143a4KclguqO/nR7ctRfCuUbln
	 8x8qRq6Nt0jIRzvrxonPHZvXmmp1EkNxLwB3T3PrKjvUSQduK/X1ocFEHlNnajBqOTaFR
	 hFnZ98Czpa+XqIq7v5atdFdbzZyi+t+KUVEBSshy7bd0Fe8j2d5RbiKBuJNED5rO3H7yR
	 O/wm8RTzZaYJzMVwtAtgfgF7L2Oxo+P+W0OZ2t7QBf/46NzdAw43r8pSN3ZV644zdaZ2F
	 to0HpYaYmi5axO9rMa0bywMTMZ6SzYCwBAIGZYuO+4PB19oDl+pulN3wrRIgnUOZdfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791637933;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fNQ1/Ay/fccO7Iaqhm1WYKcukNC8t2O/BVcJh8po9cE=;
	b=HmTOV23HKGblbxF7baKy6yQySLOncvpriNCeNqjWJchQXkamTBK1js+9WzKwEzDTZ4Pa
	 RCp+WLuYGca8NvNKN8jG6sqlq/CObWQHqc92Q2Ws0Cy5js2QwTKFT6yi8epgyeetgj7Xn
	 lqUpowwcheylAbMgSVtIbu/Kh7xbN7ey+4wavf+2jkD9OVEO7xOeXmVVg9myp/HZNCPAe
	 0w8FTNG3TKQ5JL1JrvEos6sZILgpxoFWi+Mo6yMCG+u/W7NUbFZaFNXBwG54nUmT/anHZ
	 FUs5qCA3ZEvYsIkAAMkPOF2xWdq7BvSpgeXtNq5hGTs1c3AoMvnfZm4mMgt3ntl+JCQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=jI3sU3uk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791637933;
	bh=fNQ1/Ay/fccO7Iaqhm1WYKcukNC8t2O/BVcJh8po9cE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y/JkI24mfJXk++ArbateeTJvMemJtU5g8NlTisXlcQA6EKi40I6QdfsR7fUMcFuGb
	 1rfhjVuBdryVZh5tnxla/uW+32nIEhzTWz8UYStXhC5qoQx/GUi9/YifUzwWco2ilS
	 y7Wj8127+5thHu1ugLJ5bvA0dFmbgp4MjFAj/CtRoyAP6OqGLbalKE11sg5AcJZg1e
	 NATZcu5k0VEd4jDnApgBRM2q8go/pm833ihcgWLtM8SDX6AVVvq67Z3nYIRKUc07Kx
	 GgU0E0iwprA+AoqMMbVvU4Gr4PcOB40hUruRPSiopWF6NxzkzHsKpUAgZnJCkz755Z
	 NIFwjyALQYBww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50C98606F8;
	Sat, 10 Oct 2026 13:12:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41BE322B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0095B606F8
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1p6DA7CsgN-B for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 13:12:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E11ED60631
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791637929;
 b=BhAS9GEZHAueVG9UzI/aSqB6+rkJJrHZ8mk9RXi+bxzzf4SHIdbhvjJdsroE785Pn1mp
 GZMTenOvRGIagX3Pjnr/q9tVqPl7MgoccSlDp8+ikyFq22MwYXE1heG0TdXgv7XSuh8Gi
 DwX16qXc1RpnIyQrZaKKM41/euYt6LBtSQkIOtwqJiWllMS4R5PkRVmMEA+Vg+gnmeeDD
 rXVvnRXve1sT2HDujx5bkso1zqXk2TtF+v/sNj7v4W4LW6g7l7P3O/sDGLK9B7YQLav13
 I3wIFQdZ+A2ps3iSi3C0g8JnsPdj10W3YoPc0YStmB+UfH2DR3E6MbtSySAZTopXC2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791637929;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=fNQ1/Ay/fccO7Iaqhm1WYKcukNC8t2O/BVcJh8po9cE=;
 b=kkWNS/PUjo2EFgHfB6tLevoA8q9DxWYtDJoTThc72BDl4vfx69hOg56LWAF4isaHEfYU
 cfyvMnCw8AWCAxvQq3s3XIdHP/8aZ6Lgukd3DdmMVsPx4DLt2zFcE0UR3dnOrBsRX7una
 NPgOvES0mjbAX52TIis4GMN2ygQWsx7jHwRh1uxFLyupbwBwKyTe/QJXa5DJep7edJPhX
 1uCxnTvkCfImjG7SdLZqI5VbssyiKictGu+H8Sr97qMLuglcikJQghVEAs903FZPYof0Z
 XN781V7JNX34bbQLlUy8TDSWXDyX6J1tZaKFetJ4UyHTOxyOdH0sk1Qbo24lzTsJ7vw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=jI3sU3uk; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=jI3sU3uk
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E11ED60631
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:12:08 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso108209866b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1791637926; x=1792242726;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fNQ1/Ay/fccO7Iaqhm1WYKcukNC8t2O/BVcJh8po9cE=;
 b=jI3sU3ukeY5RcXqUaThTsf9RAHUYtemog3SurKOqb5oEzv0ZxMxK8eZO8UaPBJsuR1
 MeFXRDPwmZw5TEUccoied9/nxLOOXzVmMr2RqYNMM6EXy6fuaC+LUeoW6169qJ/f2xds
 EqJKQizuNE+a3myxViWEE2YS8+qwQeLYswioWjbDDtRO7t8ISooYuFvqEcb1uH6+v0Hw
 wy/zCji6nWl3/WgTM6KkyThReNuIAHs+VPj6iqGLPaGsIOCHRJQmYqXS6hdSixdWGI7o
 tfccGBqBKk5wYs/39ASe9UJD8N5jBn13kxpXHlFQ+cyWYIW5KO6rp/dTNQ2lzMhcyeYo
 dTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791637926; x=1792242726;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fNQ1/Ay/fccO7Iaqhm1WYKcukNC8t2O/BVcJh8po9cE=;
 b=S7YZk//9an3TxlrxipBQCvdeBtKn9Y3D3Fe054nvZPuqlNNl4Yir0AmywwcdLPtx8A
 9BUaQMDxCu58jBH83pzIbNSfX1QFQkpUXG3xwKBxn+LuCZD57gYUxLtPoWs8BKzqPox9
 tFLL/9y7ylxMQkxSjXBnC4r4Xvnpeqgcaf4vJAZ4eOsVMCZFCmnM2JxrmQdJe+XZdnmF
 oeTGxJ/UZ4m2z4glrINNZDZUn6HxYeU+M7vBb2Rk43wmkPRXgNPNFQi+jAzl2AMmky03
 tejDOqozqGYyqOSHb9W60RPaIAaKz5uRf2hGsIdqpf0qDKy1+OL3Nw5iRQJk12xrTNzL
 sp9g==
X-Gm-Message-State: AFq9FYKKkvcmA+DJkQQS0NXzMwpXG+CSQwdEg8N5yfUYniNmQk/C8IdX
 A9eqxOkeVWEcvm37jlLchcwPFz9MjyQeFhVit0d+tk4hVoalnQsdYHpIc6DxdQdCXzA=
X-Gm-Gg: AYBFou3pVznBg/z06Wl3x0AJssqVJAlZtmUYu8/f0kShX5QfyvAuMHOfYJn7j9CndeE
 9Y6BNB7L1g/ViPvvDInPfPKEdKjcte+WaKvm3m7hnpr0ecqAwE+YyerVR+cbjuXNQd1clq+nClF
 85XqotiRGAiN9QeZMQOpoyce5yBMJ2KBL3LNfuRve6SD1kqSaAKXi5BLWHr5FmjZ2HF5HADNeRS
 7TUYG3fuV2XNng30hdcLAV7zNjIP7D02g53RTd8vpSVbYrn24IbN2ozNzJbg6qayH9DsG068KuJ
 GzRukvMJjZxzcsT5+PCdgx2M/eRxfjokr5MtPm33qEHtsB3giRLgZXwWZdwFKFdSPgucMOfwHXu
 aJH9rmRQXWQolupkGjxd9DtBQSnAE+1GuUMiRUgNLAzRZ8ry5ZKGv1/SYvHH0Dfs1S+pfwssh5H
 FHgB4qwRvH+PHh2gLQVMyB3LrzyUtAbagUDsw0NexT+fwb7AT5aq+UvPQGOdE2TDoYlY6CgzNsA
 eAw1YqGvBnpwzb1v39k
X-Received: by 2002:a17:907:9801:b0:c2d:be57:f73a with SMTP id
 a640c23a62f3a-c31a9fcedffmr550355666b.13.1791637926391; 
 Sat, 10 Oct 2026 06:12:06 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.209.196.154])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a71d42sm240051766b.32.2026.10.10.06.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:12:06 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 10 Oct 2026 17:11:38 +0400
Subject: [PATCH v3 1/7] disk: part_efi: Size the partition entry array from
 the block size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-gpt-4k-v3-1-89fd290f85cb@flipper.net>
References: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
In-Reply-To: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Anton Burticica <mouse@ya.ru>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6702; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Qv/uqQ1qH1NQMFgesQ7fnR5aeZVz0BBwU8szmSQvF/w=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSdslxoc1NM9OCDTTvXCrJP/LWzVKGP5YzXbdnMpieOG
 yPudZyf3zGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBt9Wf4p73Zu1Hi8fKjf5pUL248qrThzxSvu9uzN3zwf5LmIvh0miLDfzdHhb3
 L+FYd/vor7kLAuQmzLk198X+50seXb9zsz5eyWjMCAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

gpt_fill_header() computes last_usable_lba and first_usable_lba from
hardcoded block counts that silently assume 512-byte sectors and the
default number of partition entries.

The partition entry array holds num_partition_entries entries of
sizeof_partition_entry bytes each, both of which the GPT header carries,
so the number of blocks it needs depends on those two fields and on the
block size. gpt_fill_header() reserves a fixed 34 blocks instead, while
write_gpt_table() derives the real extent and writes the backup array at
last_usable_lba + 1, so whenever the reserved count and the written
extent differ the backup array no longer immediately precedes the backup
GPT header. Furthermore, on a device with 4096-byte native sectors, such
as UFS flash, and the default entry count, the array is 4 blocks rather
than 32. Current code reserves 34 blocks at each end of the disk for any
block size and wastes about 114 KiB at each end.

Add a new helper gpt_pte_blocks() and use it in all four places which
currently calculate the number of blocks each in its own way, so the
layout written by gpt_fill_header() and the extent written by
write_gpt_table() cannot drift apart again. With this, first_usable_lba
on 4096-byte sectors is 6, last_usable_lba is lba - 6, and the backup
array occupies lba - 5 .. lba - 2, immediately preceding the backup
header, as the UEFI specification describes.

Note that this changes the 512-byte layout too for boards that do not use
the default entry count. CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is
"default 56 if ARCH_SUNXI" and is set to 64 by a number of Rockchip
defconfigs:

  entries  array blocks  first_usable_lba  last_usable_lba
       56            14        34 -> 16    lba - 34 -> lba - 16
       64            16        34 -> 18    lba - 34 -> lba - 18
      128            32        34 -> 34    lba - 34 -> lba - 34

Existing partition tables stay readable either way, since is_gpt_valid()
locates the entry array from the on-disk partition_entry_lba. Only newly
written tables change. In-tree layouts on these boards place their first
partition with an explicit start=, which gpt_fill_pte() has always
accepted even below first_usable_lba, so they do not move. On sunxi,
loader1 at 8 KiB used to sit below first_usable_lba, out of spec, and
now starts exactly on it.

While here, report both LBAs when the requested layout does not fit, since
the existing "Partitions layout exceeds disk size" debug message gives no
clue as to by how much, making it less helpful in debugging.

Co-developed-by: Anton Burticica <mouse@ya.ru>
Signed-off-by: Anton Burticica <mouse@ya.ru>
Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 disk/part_efi.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index de7048639a6d..ede8bcddce1f 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -391,10 +391,23 @@ static int set_protective_mbr(struct blk_desc *desc)
 	return 0;
 }
 
+/**
+ * gpt_pte_blocks() - number of blocks taken up by a partition entry array
+ *
+ * @desc:	block device descriptor
+ * @gpt_h:	GPT header describing the array
+ * Return: number of blocks the array occupies on @desc
+ */
+static u32 gpt_pte_blocks(struct blk_desc *desc, const gpt_header *gpt_h)
+{
+	return DIV_ROUND_UP(le32_to_cpu(gpt_h->num_partition_entries) *
+			    le32_to_cpu(gpt_h->sizeof_partition_entry),
+			    desc->blksz);
+}
+
 int write_gpt_table(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e)
 {
-	const int pte_blk_cnt = BLOCK_CNT((gpt_h->num_partition_entries
-					   * sizeof(gpt_entry)), desc);
+	const int pte_blk_cnt = gpt_pte_blocks(desc, gpt_h);
 	u32 calc_crc32;
 
 	debug("max lba: %x\n", (u32)desc->lba);
@@ -456,9 +469,7 @@ int gpt_fill_pte(struct blk_desc *desc,
 	size_t hdr_end = hdr_start + 1;
 
 	size_t pte_start = gpt_h->partition_entry_lba;
-	size_t pte_end = pte_start +
-		gpt_h->num_partition_entries * gpt_h->sizeof_partition_entry /
-		desc->blksz;
+	size_t pte_end = pte_start + gpt_pte_blocks(desc, gpt_h);
 
 	for (i = 0; i < parts; i++) {
 		/* partition starting lba */
@@ -485,7 +496,9 @@ int gpt_fill_pte(struct blk_desc *desc,
 		gpt_e[i].starting_lba = cpu_to_le64(start);
 
 		if (offset > (last_usable_lba + 1)) {
-			log_debug("Partitions layout exceeds disk size\n");
+			log_debug("Partitions layout exceeds disk size: "
+				  LBAFU " > " LBAFU "\n",
+				  offset, last_usable_lba + 1);
 			return -E2BIG;
 		}
 		/* partition ending lba */
@@ -607,18 +620,29 @@ static uint32_t partition_entries_offset(struct blk_desc *desc)
 int gpt_fill_header(struct blk_desc *desc, gpt_header *gpt_h, char *str_guid,
 		    int parts_count)
 {
+	u32 pte_sectors;
+
 	gpt_h->signature = cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
 	gpt_h->revision = cpu_to_le32(GPT_HEADER_REVISION_V1);
 	gpt_h->header_size = cpu_to_le32(sizeof(gpt_header));
+	gpt_h->num_partition_entries = cpu_to_le32(GPT_ENTRY_NUMBERS);
+	gpt_h->sizeof_partition_entry = cpu_to_le32(sizeof(gpt_entry));
+
+	/*
+	 * Number of blocks occupied by the partition entry array. For the
+	 * default of 128 entries that is 32 blocks on 512-byte sectors, but
+	 * only 4 blocks on 4096-byte sectors.
+	 */
+	pte_sectors = gpt_pte_blocks(desc, gpt_h);
+
 	gpt_h->my_lba = cpu_to_le64(1);
 	gpt_h->alternate_lba = cpu_to_le64(desc->lba - 1);
-	gpt_h->last_usable_lba = cpu_to_le64(desc->lba - 34);
+	/* Reserve space for backup GPT header (1) + backup partition entries */
+	gpt_h->last_usable_lba = cpu_to_le64(desc->lba - pte_sectors - 2);
 	gpt_h->partition_entry_lba =
 		cpu_to_le64(partition_entries_offset(desc));
 	gpt_h->first_usable_lba =
-		cpu_to_le64(le64_to_cpu(gpt_h->partition_entry_lba) + 32);
-	gpt_h->num_partition_entries = cpu_to_le32(GPT_ENTRY_NUMBERS);
-	gpt_h->sizeof_partition_entry = cpu_to_le32(sizeof(gpt_entry));
+		cpu_to_le64(le64_to_cpu(gpt_h->partition_entry_lba) + pte_sectors);
 	gpt_h->header_crc32 = 0;
 	gpt_h->partition_entry_array_crc32 = 0;
 
@@ -750,8 +774,7 @@ static void restore_primary_gpt_header(gpt_header *gpt_h, struct blk_desc *desc)
 static int write_one_gpt_table(struct blk_desc *desc, gpt_header *gpt_h,
 			       gpt_entry *gpt_e)
 {
-	const int pte_blk_cnt = BLOCK_CNT((gpt_h->num_partition_entries
-					   * sizeof(gpt_entry)), desc);
+	const int pte_blk_cnt = gpt_pte_blocks(desc, gpt_h);
 	lbaint_t start;
 	int ret = 0;
 

-- 
2.55.0

