Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BE2CA600A
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 08:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AE5781135;
	Thu,  8 Oct 2026 08:37:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XqfUyhDkKg4; Thu,  8 Oct 2026 08:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6B2B1811F4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791448673;
	b=GZKeLn7Uxd0QP9OZOmfdfpxzgBt9Gey878L1GFWwN4mucY80a7eWlBlf8APMLJfR2wKv
	 vIARjGQFQ49hw8cuYIHC/VRmRLVKyTWKJd4zBSp6JwTI6XSNzo9V81lwEn5CmCZwsfG/s
	 rbIsfmIgOCI6JPPn0z7PKJozwwfwSc7r/QlL201sBN/Hmg3FiYifPwkG588bv3tGKE8jL
	 bI5w+34w3vNmQIVxSm46eHHFWEBkppqH13+8M87BT/OKdqNZt1pfq1UcqxZJopHt4dyn8
	 R8VjPdL9jmXtW+a9QdUfSsRACubGmAZM2qkZkWiQ81KNajUUPixReL7GirdPGbfw3cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791448673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=X5MM2UqqGFwPw0mhARFFI3VUR+7PHEPat6EyVtwYZWQ=;
	b=QpYzYyeO8TST0IwCC4EOTa3MIhbVDeimW9WQmIIJkwuv5zk16pMNf97/PPax0vP0ZpP/
	 LoOR1lEcKYrVcdQi7GtkM2ki+TnnVgCv4Axb4zgjcNq8eMNDLX4PqeTk1Z8nKZVZOstAJ
	 Vfv5HCIcR/I2x1FwxnNvTxdHwSLSHar1IbMUKfX35GMkIOCskjk3sxFrh3lxinvl8erJU
	 WFaXLgTcGXCrP8jNCdmGTbPhG8KRQ8EuwVFHxL2s//ry8cUkEfOUFrxCV3fh8LjOp3JIB
	 wJLaEwzC/7glCqEqjX9IJ7DAWYCIp58yRAk5ibWS7sa+2Eee6dBw0yVNZzcJmtNCiuA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=rj7SFF7L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791448673;
	bh=X5MM2UqqGFwPw0mhARFFI3VUR+7PHEPat6EyVtwYZWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FySBp5O5TsEdw+V7OxubDglIWtZNcR1LMjcOAuvBpm6CPpt86/P9SS3GwuuS6DHCt
	 9sMkhABMJ7pk0wSvYFujs4veThgGTkftEbr2qkgr4Iq/iP1+L4HB8wAvR9jnor7lLv
	 QvCq8mnA8ehROP+DW7YkbOKgBpB3PPMxxjRrpNnR3qsxn775NZ7/6kxQW7rby/eEEM
	 +Y4rfIbfaKLCF+e9TdEFP5DfPlHVqhjWUeoTgjoMwtk4k3MQxAsWXvFmDjjjHXlyDw
	 hNdz2jU1pSALn+KYHd/LRhbNFJTd+Qd/PnY6l+3msoAysZ7eFlYHkEfjC2nhGtLOZ6
	 v0neRyCgEVFoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B2B1811F4;
	Thu,  8 Oct 2026 08:37:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CD5CE338
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3C0081164
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NsJ6-7Q9xpul for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 07:01:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1DBEC8115C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791442908;
 b=PvWjmNamW4UD9qKpbcENeD1diRBpKDMX1Ihjq+6l+KwY2cSdhRAyxvUMRkJyk136bNaV
 +amAOVRBA5g0GsKxJmCHKJ9f4fkRAxnfh+wgZ1oZA9DDeZm7jMltw9taYEc1QLXo9Thwl
 vcWzfNoh8A5/sr408lvZf69CENVyhcY1lqKCJ65MPD95CC4qss222NbxBydSVodGcaPo7
 SshFTsi6zv4I52cbucjwfoq5RatGA+INuLrbVdR57MEy1KZiSavXBqeo59p6IA0HfnqiR
 XA2c/EV9aXdNqfLX0PsmntruCT8X06z5qJRF7qKzDHqls5hCo8vW3Xlc1WkYq3ArP2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791442908;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=X5MM2UqqGFwPw0mhARFFI3VUR+7PHEPat6EyVtwYZWQ=;
 b=GmOzHoRrZiOzaltmKWS/wqayOsRbtXIJz2mf787u+OgzNeF+WM21gWZEiI0iKrgSqemc
 dKUwBJSvFXdKCkPhiPjfOxts5FodueV0i7OY0NoJR/B5h3/ZAN0sYpNMCdue3BWe515tM
 jKjrYNVUpUxsSjbTub97yrwV/kpPpt8wONOGLu3ivzhJxPsZt4t7MO+NsLNPYDiBB6ny6
 IMqahec/oMNaUP/ilyc7qTrq1UX0HntAij9paneQyiX8sbsMRIBm6f9PZWdy2RyyXCFS/
 f405aN1co86OI6ItGMs0DEfrrtYMv5b92Uc2yq5b9xGf6zEdMPqDqmnBMpZRmA6YKcQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=rj7SFF7L; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=rj7SFF7L
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DBEC8115C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:47 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E5313FC3E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791442905;
 bh=X5MM2UqqGFwPw0mhARFFI3VUR+7PHEPat6EyVtwYZWQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rj7SFF7LWZOt1UsG7S9BQ+86VKiStBxSqAvDNCnd+XddG2qIGbum4oZmhMj34cz3A
 cR8zCpWFyEfb0oiOZ7fUfvEypzpv4pYmI6TXG0Ipvy4rTRKdCNKSK60Ju7ph3gH6JM
 4ZT9D+l1mWxUjmdSu4s6fIKCGiu3cQ88SbtOxU1ANn9HdodF7+lNmR/1LuSSVeXzQG
 rFGv4Hg0LHDUW7UnnJINPTdtjBcY0nn9EPLOaduptK0TEbZwsns82ywr13XLnlWw8k
 1l/LqKAkWCeixi96APUpneuY77bBev889OwIFFO37SrUTc1EUy7/LBos/AqpHh3+zB
 joUEhEjEnN8l2kYaCKux9q2aEoSX+aFWC++VX8+Y4UcWmBnEvKzMecGd0r7oM1Oujw
 XLfz/6enY3Gvb9TawyFjaeevey+pTo9sbbliIkr1eMDCgRjUMLqtPxKJncKhfaxjRw
 30ZEOsRkxbaOKrfkaAPVNWjaFiNUZaJFuddFsGdpeh5Dm+PZADaa59GdGkFQ14n5QC
 uwj4t3XdEOiLjz17SvN68Xsfehb5JdAuyJSg+4GhskrL6KU3+B2PTcHC/bmRZ038m7
 MqQH7zaBs4wp+PgMuMHD35Y5YgQRvJ0iQFSgnENcbTFP31DMTVvnhnKOpeI2UlUnkx
 xl4rrPNE0/TcaB6kvFDPTKwY=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e60770381cso17820045ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 00:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791442904; x=1792047704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X5MM2UqqGFwPw0mhARFFI3VUR+7PHEPat6EyVtwYZWQ=;
 b=MB7fy3vVQoKlcJ6RmddtUw+b2sNsnGoDrGh53HcpccJQVl4d14TCVJXApY16GVmOJl
 PEIoMnpeUltBFQVZ3XCLXLQWKQ3xB0HkIM+Kycs+oNkI4+xlI46Np+qeJzFvWrqiEaMW
 mV1opw0pv9P4ogJ7QI/Zycr3ul4xDU2QmNZDG1zq4VH/2Rp9hora8mRceSL7XICOCPV4
 d3GYlSIDgQVbzfQJnBDjPPq1wQgF762iFAMIIV4rjt6XAyiA/CXSAzT8Q579dH+06qXX
 4Dp8bqnW9AY76+lK9KoigqL8dXpLr7ZbjMrNSyL8NvGLANDZ0pYm61SrbkEFQK/8graX
 9VGA==
X-Gm-Message-State: AFq9FYIj62wdY5VxUp3YIyUfWuMoTRF5z/Qbe3HoqxlvsJ6UY21PQA38
 1vBFpfyE8mVQ02XsclfnBqnorD62WxDyf8K32t7kuwnjguEqV8BnjpMY+Yh2Bfl1m7Vadp6zaHu
 TQvW5HHZlCaETqCnui9GHJ8YpGGgB4xtHEVr6ajU62gJHqgIf5OxdW6ZXoaIuZuNh4NMevoTcHz
 mWdQJBGDJW5mKkNR8wjQ==
X-Gm-Gg: AYBFou1Ne8hjaeocMNItN8fKZGtFPAN5tXYoETj1QjPZvxm27vux2nbw4V4xjSG2j11
 k5TqQvMdiuoBErAEbJECZ7rJ7GkH8NGSRVfUMakaTQ2j0JMEms8s2trew705v8OYCPm4//d0fY9
 quwsAoMr2orVr+Lo7iJXIiOzq3oVQXFrDtipErDbhmPAft/aG+qtaeRFR4mGT8L32FCOwURmuJ6
 KE7bTLXHQkiYG7GpGZGYNb29AN6dAFYvxfKDxIT5m2YbzKvrLdwycOEJecPTRcjSgP7xBUSFrdJ
 ANqOQcqWlFGOMD3MXSqLJ4wiU7rGezW4PlyeP/veod18GFIAIy7ttXQvEzxVV/47zjtRMlnu6sz
 IjlmM+O1e1pqN5qisjV5UcFiZDHqKhazAJyvVFohNHsRJ4FbvB0CpYBY75CYazLQPUw==
X-Received: by 2002:a17:902:ce07:b0:2dd:c100:4b82 with SMTP id
 d9443c01a7336-2e600553820mr41861725ad.57.1791442903793; 
 Thu, 08 Oct 2026 00:01:43 -0700 (PDT)
X-Received: by 2002:a17:902:ce07:b0:2dd:c100:4b82 with SMTP id
 d9443c01a7336-2e600553820mr41861565ad.57.1791442903452; 
 Thu, 08 Oct 2026 00:01:43 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e6046fe0c1sm20245455ad.21.2026.10.08.00.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 00:01:41 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v1 2/2] fit: use FIT_DATA_SIZE_UNCIPHERED_PROP for
 data-size-unciphered
Date: Thu,  8 Oct 2026 06:59:49 +0000
Message-ID: <20261008070116.328864-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008070116.328864-1-aristo.chen@canonical.com>
References: <20261008070116.328864-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Oct 2026 08:37:42 +0000
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

Commit 195f273b6c86 ("tools: mkimage: resolve image-data references
between FIT images") added FIT_DATA_SIZE_UNCIPHERED_PROP but did not
convert the existing code that spells the property name out:
fit_image_get_data_size_unciphered() on the boot side, and in mkimage
fit_image_write_cipher(), which adds the property, and
fit_image_cipher_data(), which checks for it to avoid encrypting the
data twice. Use the constant there as well.

No functional change intended.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/image-fit.c   | 2 +-
 tools/image-host.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index e173108033b..cf435329e44 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1044,7 +1044,7 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 	const fdt32_t *val;
 	int len;
 
-	val = fdt_getprop(fit, noffset, "data-size-unciphered", &len);
+	val = fdt_getprop(fit, noffset, FIT_DATA_SIZE_UNCIPHERED_PROP, &len);
 	if (!val)
 		return -ENOENT;
 
diff --git a/tools/image-host.c b/tools/image-host.c
index 7718d8f678a..4774c1743c5 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -529,7 +529,8 @@ int fit_image_write_cipher(void *fit, int image_noffset, int noffset,
 	}
 
 	/* add non ciphered data size */
-	ret = fdt_setprop_u32(fit, image_noffset, "data-size-unciphered", size);
+	ret = fdt_setprop_u32(fit, image_noffset,
+			      FIT_DATA_SIZE_UNCIPHERED_PROP, size);
 	if (ret == -FDT_ERR_NOSPACE) {
 		ret = -ENOSPC;
 		goto out;
@@ -623,7 +624,8 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 	 * image is already encrypted. This is important as 'mkimage -F' can be
 	 * run multiple times on a FIT image.
 	 */
-	if (fdt_getprop(fit, image_noffset, "data-size-unciphered", &len))
+	if (fdt_getprop(fit, image_noffset,
+			FIT_DATA_SIZE_UNCIPHERED_PROP, &len))
 		return 0;
 	if (len != -FDT_ERR_NOTFOUND) {
 		fprintf(stderr, "Failure testing for data-size-unciphered\n");
-- 
2.43.0

