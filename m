Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060CBC982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A59240B94;
	Fri, 18 Sep 2026 12:14:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Sc4C8FPEoTw; Fri, 18 Sep 2026 12:14:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4DEDD40AEF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789733653;
	b=bn6IoS49j0MQQdSd3gz+d2C7ezYLMY8c/id90/AcTMGEKN+6bT0arRRJn2FJyjOFKnAq
	 PthYrTDTnU4N1+44PvRXc5JCp3rHrPvr0UazMEI+jdm8CaTOSxUWgtalQs0P4ApmAUBde
	 09v9g5lFt5b+b6IyCOPEFnBZ7tCL5Medc7t3XeCeuTHb4M8VlEd0SXKv3UxwJlBIDGhHm
	 /AQ8T3MIlkNjdpjVJ7CMXx8PHREMuC3lpDris6MfAnePl7IjdlN1dNtmlG9W/Vd4GrVqi
	 G18SkIJc0ZAgn7i23civyFs6XyEevsrLtXviZlgzL1GpRrCyYyZiixX06r9ddTZxG9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789733653;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZKaxMmCrC78SlheT1U6JjF1y8kOnvNLrz5tr2+h+Qgg=;
	b=r4AlyP/RTAXWMCqDZT7GgqhqLRh5I5KmHj4Lvf3TFIY0mJlo73oexbQoVLVWhOa0+RFC
	 a4p63gHQfXPlAEMjuQf5GA5znhqHvINQx0GzK4YvI1Arttm3gyPnR1alfSfIGFlUFM5IG
	 PtFsmvP5/A0bAh/AZNUBr/s7iBRLdFsxmqhdj824J1XV9qRHGJbXvapnrCv2yaOfo90KS
	 H9jDXvsamzywAZ5kOBEQUMFaS2XIzFwhirAGDoZ7OtP8TMZZEZ6mjWIge2cVGndG190A1
	 OwSrZs9oyc+LSKUNL3/0mWso1lDa63Gyu+pmvcyUK9/4OQGshCjbcB/USyXfM0ZYMEw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789733653;
	bh=ZKaxMmCrC78SlheT1U6JjF1y8kOnvNLrz5tr2+h+Qgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p5l4GV0rKsYqM07narSRiV7RACDRuwF21ovn/g/RVGXfTwddtpIbuCnskHUeaEgzL
	 uWxWJXqHwNWXcORMNPpdfEwjP8CQi99UB83+yKhugnnBoLl3biCP0qNKaJZenEwnD5
	 HCRSj8SCPogR2fNrIgmTrc+M50CSHEyFLDMh62OrzjEw9tGgCldVreMkUKLXj4eWQu
	 i6Ixz8gMKnDkww/H1zKQzTWopukH7ZZCnUbFNHeC4A1cROhf0DKc3wr2KU/CDVi/LQ
	 PbhjMvND2W2+PLBG6789KOxQ8AhvuPHRvBb616DkGac1XzOXLWQx6MPeFbVbBhAynj
	 ceV/D31hDJQ6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DEDD40AEF;
	Fri, 18 Sep 2026 12:14:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B18D9224
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A34C260D67
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id djUam0T8Pwwx for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:14:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6E0C760B9B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789733650;
 b=qlc7DdCyAGUTqUvZpWz1fgWCqnpMg+/ggDNHgCWYgqtPn6K6f+uFmVZ23e/L0RF1bY3p
 wcMIhnmBPpeRXhrq2cMHuhRkiAXE6/VnoNdOMC1yWa7TeJhHcfpDMZTMa2QgTfkJaTB2O
 ewCD6C7jinLbjkJGyUbHDl3tw5f3VPwaNLYZQMkUKM96+20e22HaYUbMWQEP/6LAi+Dv0
 nmudIlrbcU5/0fPWTyjuhD9iKF11MeJMOT35lAa2qPKSOCrRxQ+2nXDX8twPPfb64b/YW
 XYv5SUT09d6dOSLO3sQUgcJ/rvZDagq/qdwjMOJNkCQ34C/Gn6R0ukR13gs5YSMgFcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789733650;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ZKaxMmCrC78SlheT1U6JjF1y8kOnvNLrz5tr2+h+Qgg=;
 b=gJzvYDu62UP8TFYO8sLubNFOz3IGLETpWzgki20Rd1X+gw0nF2hMEWN/53MqEDh8+FQZ
 cp1JL5KErXrFyp1wp5n9V9fi/lN61/vofip6Bogpy6jP5IxyN0beuvs6eur2aflQVdHLy
 8eXQxevloDLACAlpwGiy+uBx+unitnE4wlGKi0dbMzIoccADFDaDR9UpveS+ibpf8VI+I
 /1nW0xvK/hFoTLKrr8njvZXUjZal17VfzrgdyUMy5XouZd4DHOczZM3estkU3PQ9JjmVv
 JT8d2DJIBA78VFo1MXu1XrsZ0TYMNPqAwF4QIU8bnM+QdiH5+wt2kAYAwDcc7vzr25g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=pS0a2Iro; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=pS0a2Iro
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E0C760B9B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:14:09 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d1ca5b0d6so5297115e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789733648; x=1790338448;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZKaxMmCrC78SlheT1U6JjF1y8kOnvNLrz5tr2+h+Qgg=;
 b=pS0a2Iro27qy+ip50EEk4mFpiTKnRwlu9HOEjB/pQub4he9qVadHoB7K20niLTEyg0
 oMxIJuBEiJ3R3vJUdV2rXe7xXnStw9XjG85UvlMZQcpia8GRWvnpkeILm5bTxjBO0Gx6
 gJLNwMaiRcCmEGEOLouPK8hZHJ2/QCVCvSjvauML2Duvs6tiD8KDYQb5xFdm+hXYNau9
 o095y1/YLxORtb4YtCSgFMKHhz3tB8OlYEZguygmq+SVS0zyr9WHUQXAzQLVfCSWXQ/o
 LlzHfPeiIVshOenimxfRosQpmsvPCUdJUzfljD57V/pmWsrLFF4sCmos1ZFi+l3rZkv1
 AMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733648; x=1790338448;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZKaxMmCrC78SlheT1U6JjF1y8kOnvNLrz5tr2+h+Qgg=;
 b=Hkc9i/CTSGtH9JpGskPerVYdelJIxDpE92QYfdfgtx/gyo5K/W/V0tzII41wDXLWxZ
 AozkIA2LxnREbw6IBaNeYIJXD+84OKRPxnVS+bYlmTa6zJZmd2NUHjAUjCX+FtFuOPnW
 eZt4SEsaIhKalQeoI1VDSy+TuPLGvT3TUCsny4d5MNUxxD41bjgjA0rrhyapwHIHtPHY
 sElL5ZW9JDUk1j1GD3tKtZf1f4ZW1fnMxtFg3w612E2HyuTRPyT2XrkTN1z6pvXugshM
 dRgRNEhodlfFh8k6qbp8xhZ2Qgfi1YTQcv1vuWCVoLlbf0mOBYKsJVAuuXeC7TIezp+r
 wlkA==
X-Gm-Message-State: AFuF++nDja0WNuokZBCQi2XQb+sfFwutC64p5DBhVPRwjcrJsB75jTuD
 dcuo4Ia0ScYggijfQCK/6CB5oYMdENgMokTNClDAm4bOWH7+KHJ8nMb2vwXp6ylCraZGUibh5Ps
 y+IN8
X-Gm-Gg: AYBFou3N6yhMBV8cKNTMsCMjXhMcY9GzJaFWe25oT8ULZhkGsYTcDKGZ38pUGPt5hYE
 G3svZGqwAn8SKjs9yQF6S/bYcjiLkuMeIB6X3CNLU3chz4NGMNEUj74liojk+zFZ9i7mefq3Y/u
 PVHxnGDtBrGM2TF4mSttfwNe2S+IsPkNoA0ai75ZUPinpyselOyEfKz1zhuDL53oDihYMWkw0o9
 4pRBhsuIWpnXranANix5pjogAq3XPycOzXLIIC9TKTvvsdPmbiZLLmUSsLLVyE9A6SGbQ8U2AZd
 kaWDpmdh/SmjcdXDQDpJEzehcBWqOgJBWM1S7OO+3Gee+HEFpcklVdX936ze4M67Xi2xcl6pUlT
 lWGlde2kg6612L54+0745Gq3xDA+kEH4Z4rbuav6dVLEZQ3kJbKj08V0uQ/R3K5noYD6PylVhUs
 fmdpaaeuOmSU99vJhYAiWHNWBi7G2TeEkYLUoK1SZlQNhYjcl5eSir3Q5lb64o/DMS8RgWQ+3PX
 yjzBe6kZdz1A58MIqRSIRS0jXi2zW245SnQea7b6W2dYiFN70M=
X-Received: by 2002:a05:600c:5254:b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49fc5737b8bmr28459855e9.20.1789733648013; 
 Fri, 18 Sep 2026 05:14:08 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc59286b6sm42755035e9.4.2026.09.18.05.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:14:07 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 16:13:50 +0400
Subject: [PATCH v2 1/7] disk: part_efi: Size the partition entry array from
 the block size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-gpt-4k-v2-1-daefa4792e9f@flipper.net>
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
In-Reply-To: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
To: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Denis Mukhin <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anton Burticica <mouse@ya.ru>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6619; i=alchark@flipper.net;
 h=from:subject:message-id; bh=03aLcXREEAba4pGf9B+JKfgu1+vlF8lx/t/lCWzBAd0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt1ea9vtBI+kOoqcvfe987F3675t61WP3lvlWdf7LuP
 ao6EdqzvmMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpFvVhZJjwq/KxTEzRvbeFfAuqLj9pqS269yGRbyrLbeePrIbLdX8xMtw9l1E
 0zXNGfkumzx6pYuVtLJnGLDsL68zqpq6+USruxwcA
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
written tables change. Partitions given without an explicit start= will
now be placed lower on those boards; on sunxi first_usable_lba lands on
the 8 KiB SPL offset, so such boards should keep specifying start=
explicitly.

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

