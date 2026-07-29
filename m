Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF519C54FCD
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B25B480F8B;
	Wed, 29 Jul 2026 21:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5N7UnxT0bVVc; Wed, 29 Jul 2026 21:52:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCACD80F7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361952;
	bh=XYX7helxH4RXhfe/ZZJYdkSf81fO1As2yh4xFwytlAw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bji/Mel7V2gBZqvllnZPAWpaKaBSxLvzr07QxB0/D31AEIr5N7UdGfJONmT5YFG8Z
	 j1dP50rZ6cZqqDyB1NPlqt5cvcQb/MpM/dyDpKEwifLhrBIUI0ujEo6VvtIS4yc9VV
	 rMa22uYWhrzQd+CCVLJQNqEC9PRkua+PhTvb6Q5Y1XBt5QxJGe0998tsqv3MwW82+f
	 LG65O2GhjXfsyFbcA44U7Xt+i+4QrHey/6b7YeRwx+Ive5Q/FroWafiJU+vqIc7ajq
	 Gge3+W0WVMA+Ejsoq2+K//ORZkiBIdiT4WHmt6MggXdfvJ41KSEiNakOybuSUiQFf5
	 l+3bE8X9FvgEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCACD80F7D;
	Wed, 29 Jul 2026 21:52:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9B3326E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF9F5806FF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qmd6-xuePUEz for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 19:02:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=shahriyar@byteray.co.uk;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C78ED8069D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C78ED8069D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C78ED8069D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:02:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B86318493F; Wed, 29 Jul 2026 21:02:35 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C31803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 21:02:33 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so1929496a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 12:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785351753; x=1785956553;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XYX7helxH4RXhfe/ZZJYdkSf81fO1As2yh4xFwytlAw=;
 b=JBcUScjUFJ4wLnIh5COxbcIWuMvau6Lt0TvgJlfN3fW+BB/C9j6sMy/TiybyesyZzi
 sVf09abqPuAFUtfkggUEVhrTXFY2j5mAhey7nXQxak7fLlGFbUb8guZMu1ioawdlHy4R
 XmQo2rtIbgrl0Q1+2KXoiN4f1Xr7J/uByI3hoiQxQlQeqzhfeSO4LzmIMBx2h/yOs8mg
 tKcNuUeVZs3R0e65SSeTVcVlck3l9KbqCDZlX9C4v2q/RoEjqOxD9MM8L431h3MZu6H3
 ix/MzsH5Qc34i1wWbDgzVETdfcuYgulrqFiwToAMlKIAZlP5fwzgk/pMI8HADzTgCFFL
 q05Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYdVLE3ISje/6XRVLLDzzmfxkygOQplW1K20Wnlm7Cf8M50w9zh3x4IGH4LN1eKPEsl8gIiNs=@lists.denx.de
X-Gm-Message-State: AOJu0YyLkajJj4sU6YpqGTULXbPplfeXXi2oWu3Ay9JuPK0NZpweQh7t
 1rpEg1lE8ErGI6kxVLNZPfXiPkKcAlCoPD71IoUJNW3Fn3a95G6UQO4gCrNMzwY4B5M=
X-Gm-Gg: AR+sD11ZcO85pbQhoqrEd/nYDEBwnH0uwpoLFBzF6tm8Pagxpt0vkd2/LXZQ0vi8lhG
 H7tciNLABtl13r3KX2pucGsLA8Fdoz1zB+bTjQxyaPZAkBaLeS6scqFmoMd++DP8Kwrhv6IQXyu
 q4NhuQXrCyKUxFVt2ANs6cW58OehLC3uQUqHWFXTpTlbS87NsR9PtKD0kJWusbOMjeum+mZl7aV
 vkLQX/VN43vTvBNFCxhbONA3+l3blt3eRzIp0AojNTIeDEwzE2qEclABXamfNP/n9ajf4KvYnc8
 oy0IgD7qoktL6pv8SZ5mX+4nwSzL6dzF67dvYm8+Rpv8fJVvFoir+4ILsdlQwFyDQSSrq0aV50w
 ss6Q4ADI6ucfIJiFWpEub1v3+OcblRiOOKY1ZRAmtdupU+s4/1vLNOcA8p7zKR+NytwB4wgkLB0
 K/joBM/ne5hmqF6PcW5itjXCAjNsT5IaGWq6efbkLyODPXlO0jgpDLBbfpgIMuYtvdXtcpgxhyU
 lbYBcwvoUyHf4GaST9sGvNnkCqyx7d0a3GggjF8pKQSNe4+kIp9pw==
X-Received: by 2002:a05:6402:3216:b0:698:3e08:29f8 with SMTP id
 4fb4d7f45d1cf-6a0349ec4f6mr4776915a12.11.1785351752852; 
 Wed, 29 Jul 2026 12:02:32 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f0047bee160d2cc76b5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:47be:e160:d2cc:76b5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a050c78e65sm1168672a12.31.2026.07.29.12.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 12:02:32 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Wed, 29 Jul 2026 21:02:09 +0200
Subject: [PATCH] bootstd: android: bound the boot image read by its
 partition size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-b4-android-bootmeth-oob-v1-1-31c3450ae0be@byteray.co.uk>
X-B4-Tracking: v=1; b=H4sIADBOamoC/yXMQQqDMBBA0avIrDsQQ1XSq5QuMmbUKTRTkiiCe
 Pem7fIt/j8gcxLOcGsOSLxJFo0V7aWBcfFxZpRQDdbY3gzWIV3Rx5BUApJqeXFZUJXQeZra3jj
 buQ5q/U48yf473x9/55WePJbvDs7zA16tE5p7AAAA
X-Change-ID: 20260729-b4-android-bootmeth-oob-9abf16092595
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Cc: Argus <argus@byteray.co.uk>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 21:52:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785351753; x=1785956553;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XYX7helxH4RXhfe/ZZJYdkSf81fO1As2yh4xFwytlAw=;
 b=Ic069XAXE23oZ16a7JAkNpo52vC/tkFeDEVRH/dCVpcfURVY1Uf/+tDNiBDrlrLVJH
 GLRw8a1KgvlaIeN0c5HanDFWyFFzYGQjdBS9xzuwUP49+SKzRXeBr8+QPqUOeXB8N3mc
 5Arm3BquNO+iJqXYAgle3MkfT+YzXQxMxQ9dOyUMDf7pBoUpwfXwKOaPQ69o4iwit7eR
 gwV9ltPkT7+Bh05WqdAT/oihlqDIAa5JkJqRA7uvoNFi7gjwzJUwK5CTQIKkl/SN/Uec
 IXt5y9nzTkMtbXKGk9GrQ2QtM/ZZKfwooTyPYGrEvY9A9YbiTXaLvsFhOe7gQrI9raSh
 771w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; spf=none
 smtp.mailfrom=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Ic069XAX
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="Ic069XAX"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

read_slotted_partition() loads an Android boot/vendor_boot image into the
load address, sizing the read from the image header:

	num_blks = DIV_ROUND_UP(image_size, desc->blksz);
	...
	blk_dread(desc, partition.start, num_blks, map_sysmem(addr, 0));

image_size is priv->boot_img_size / priv->vendor_boot_img_size, taken from
the boot image header and never bounded by the partition. A header
claiming a size larger than the partition makes blk_dread read past the
partition and write past the load buffer: an out-of-bounds write of
attacker-controlled length on media a physical attacker can supply. It is
reached during boot on a device where AVB does not gate the read (AVB
disabled, or an unlocked device).

Reject an image that does not fit in its partition before issuing the read.
Both the boot and vendor_boot reads go through this function.

Fixes: abadcda24b10 ("bootstd: android: don't read whole partition sizes")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
An out-of-bounds write in the Android bootmeth: read_slotted_partition()
sizes its blk_dread from the untrusted boot image header, so a header
claiming a size larger than the partition overruns the load buffer. Bound
the read by the partition size.

Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.
---
 boot/bootmeth_android.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 1d70e8d5c05..4b58f850b20 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -384,6 +384,14 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
 	if (ret < 0)
 		return log_msg_ret("part", ret);
 
+	/*
+	 * The image size comes from the (untrusted) boot image header, so bound
+	 * the read by the partition size: a valid image cannot be larger than
+	 * the partition holding it.
+	 */
+	if (num_blks > partition.size)
+		return log_msg_ret("image larger than partition", -EFBIG);
+
 	n = blk_dread(desc, partition.start, num_blks, map_sysmem(addr, 0));
 	if (n < num_blks)
 		return log_msg_ret("part read", -EIO);

---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260729-b4-android-bootmeth-oob-9abf16092595

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

