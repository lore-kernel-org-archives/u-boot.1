Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3E6CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 04:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4953640849;
	Sun, 18 Oct 2026 04:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wGTLArw6DPzH; Sun, 18 Oct 2026 04:24:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8911340851
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792297452;
	b=a9NgMmev6ZGpM1PIr3/Gy/AQ3N8MalqwM7MvkCSg79ccbPq1l1BHWRJ/w3UBlSQ/IYBt
	 PTWY1cfsjlZmJM4f4M1fMHCxYaoOJl+ORgu1lM29Vq7SbzrvT/5NRnIbbVXV4OG+I7CwV
	 aA7mndDKn1WI/8WJo3I19uQF8KqPbwh6ryzXcmqtovcCW38vvpHtkQSbbog0foIswP/mV
	 ndsle9bfuucew6rNcXUTWr9lSdt78XAsEg0U3yYCENoBRdTI+lfDM4ij1eIb989GR4m/v
	 TgdAFg0EF44XR97G0BtQXTDsSgu3ft0Gd5wCiuJSkgDb64SHw/VAx2MoKR2F5GBkwBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792297452;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=p9Lp+i4TTMjuQOuR1c6AiYrXgg60g+iH8r02mxRBhhc=;
	b=snWcQf33UKvjs18pFdQ98RHxX0XL8ozh0oa3XbCoOw1nyqXErnfGtpobjTJ77TRVC67D
	 z+EHjUCLVlVuQbFnTODZBBm2LihsCZcqccogrjISLn09tonIwUfRaGIR7VjoExXT9OruF
	 R5Xv8t0XqKasrkV+BGVPmh8RVj+yiooThUWFiCGvp2+Ubp6zsDg1MWH1UWzlsaYJhap3O
	 b3WBxZ7/xRhQBD3aVllcZj/9KUp5n3oQ8q9eRWRSaHA1kP3PYLBa3rXBTmFJ6QW2/zigD
	 B38K7vOchmKe8AG3qrBVPsjO+82FjL72PToj795UDnUBy7jBTnazPRYY+pnLdTKmPCg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792297452;
	bh=p9Lp+i4TTMjuQOuR1c6AiYrXgg60g+iH8r02mxRBhhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RB7CfN0qmWm+l52YxMChcS/XMIX4oB/HSB0qmajcLWyWMjhD/3pEBalUnpwkDbezG
	 mN/spaY4KA3TQbQekErq3UiBx2xMqUKf+YQ4QrciLSMd8dfqSzBmZkwVWjwbDaEttw
	 juXb/0AXy6miR7BSpojXoZkpsY2vj6WE9aEMyeJ/A+wQtxe4a+i2lYNkpa163I4Cex
	 pwXc1O5b2XbqQWFfKDp+t9zXBVQJnr9PgK4is/V2ioXC2apfds5XTKoZLgjsRItiFj
	 EmclvLBO8BoYvlABlwdPMaATQM/saqH3N1620tRZLxmWpZnyvO4rshzV5TouSk7dZF
	 oCqcWcjFKNPBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8911340851;
	Sun, 18 Oct 2026 04:24:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 56A0461
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 545E66061C
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xI3k-nC8Uvzv for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 04:24:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8568560616
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1132"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792297444;
 b=M4aGDs+smAsrKALwakzTIRQRqHa9pkYXrvzfqbWS1CU5bCM0zQYCdsQFOrNGECZQ5mgT
 i/q1NLi24H/f3XxgcML0ZpSYaZ8RtVeOngdXbnu+8z3FrBy34cuaeUWJCZlAo02rVu+dk
 ImY5cpF/EzVObpGgb5rRSwlHpoT7yNBXmya3lZMAzHymJPviiGhFzozIYaNhDjEFR4u8h
 Jykil3BF5KNAN4UbTbjpHQFzSv6IZgl8U3TcphXHSI3KKesOSBzimlnsNhruF3YtdBb4r
 n+NSSYRkVk/XagRYPK1/3y7JpLqNI50F8Gkk/zIUTZWb9GZ0Q3GDVr/qnRMNULM+26w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792297444;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=p9Lp+i4TTMjuQOuR1c6AiYrXgg60g+iH8r02mxRBhhc=;
 b=FiaTcvv30UegZ1LSY28u1fHFIhJRDXDeGvG5x93PzTsz6B9yuYukKrlGCqTckNLCIPZn
 IXkc2FJCoHzXHnFyXOH8/GDpW/3aVj7tiYyBx4zXuHWMi0gYNxeUx3zsPHoMeyiVVAb/7
 3cTgH0wb21yIcCuThpK5GnihAug7h0hwAlN/Z24W7BIVhlD6G6El+IJPdaLVgiEq/dEg+
 USh4zO5LJPmcYSMCrELeFZicerebNTRNb1yUVZMw/MCaUrPOmCxkJsVcgJNRKw0as4ws7
 XlI3IV9AoZBbYtvEf3huwvokjOj+xi3Xax8q/PY0m18BDSYRWpxDnLGWB7GrDHvqbJw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=VIrmIb+Y; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1132"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=VIrmIb+Y
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8568560616
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 04:24:04 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b0a921ee46so8104387b3.2
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 21:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792297443; x=1792902243;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p9Lp+i4TTMjuQOuR1c6AiYrXgg60g+iH8r02mxRBhhc=;
 b=VIrmIb+YWvJud4jO3teImxcOrOk5mrvA0+zfYbO2udNFwA+c+4emgojy3m2+1GteXu
 l95fjD4RHyrXjyfAjMbWY2APG23HPGCVR/jv3PNd0yCfzMm55BwPqfVyQmZYmIzlnrQv
 I3JoRrHUMckWOqMq9B2nFoWhLQ1CKTZn9DT26lDfR9Zxegi9oRhcDsKIsMgX/aVdKtut
 Tjg9InZ8Hx+ULGBql7z1koHa9aoAddmnX1PO0obWuTD5Nu/wsFDtizPHE/hW7ZuRR2H4
 4woY39SKz3MBdBEk8XMbctcqtzvROcJAtAe6UNbGgXq61IPcRrB0WqT9O+1ysP1fIosu
 Qq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792297443; x=1792902243;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p9Lp+i4TTMjuQOuR1c6AiYrXgg60g+iH8r02mxRBhhc=;
 b=oKApoWndUGJDJ1H9JHSIS09NJ0fM7CkzPnvELDO7w2/ySkCj+W+U5MVUMC79Tpg2US
 IR2NbI+4rYdFHSfY6cqxv5Z3LXH8NmNpwFJTcXJMWnHVNsYhSuMPoWk2yT7W7fCIHer4
 6sjLMjry5ohE4bMz6hOAtW+B5gOaWJCkIZE+KD0i3Pv87aT5+nb2IX9Gh+HIBL1GM40E
 f+gyoeLuvkEGy41l//GmhrlazTHWR3joRlSFw7NhhhNKUETLE2j/2o36hlXxDF/CVb84
 NdGy/NsRgsBSYtDljKDT4YP/hxEPv7w8KFNvhwdq/xzHxUJLmLyiyq+zxbDkZeUOMRll
 4YCA==
X-Gm-Message-State: AFq9FYJqK8ZNjBNbYkrnSEOmFfJMqNhRupPudEuqXQm9g9x/ElfJRcpA
 H9eJlTLhfl//ugupcbuGaoh2nOiOxiMx4jlC2dgelhM93oNA5oEuOc6b0G0AyCf0v0s=
X-Gm-Gg: AYBFou1IGR9tT0ew0ubnE8EpU5eypP0m5Afk0Z2vjvHoVLxmABP193LZluQ+tbLLSgA
 qbYdg4R8TGKdGcKwrOUg6fExi8WULVRIDuV2no94pz7CRvrYB0Efwu9LiNyO6bPVpvlN/WaCWQL
 hCziL32NJu46jzQqdBtcw0VwPYtbLx6A1k+y/9zkLL3tsNI0vrAiS9Pm4eEZmP8RNTIaTDNGI61
 B4Lr1+OVMi1mhz4Ys4jnXFztHl2MMXbdqxMUEDk01gTvpqfGv+qIk907oxExM4PO0tefoZIMgMg
 NA+sZK6feC5F353GZz2blBGh7531YXetdrYf3705VnOOZFK/3kCDG0CYIqIU3TfFEpbVN2k9n+C
 S5XQV6QKeS4FBLO6gG+cHModG8MW2SaGFfcdtB2BL/tsmaq+NWeN4qhmEtliObc2Ut7qEmOo6Vu
 mWQhhCx+zmOhRcXFwds1YNA6iL7bf/mdfEsv0zvKc/jHrmIFVfN+z83hEWRkh/Lq6Ut0CunQLte
 tRtTcNmpjwWRU10BqYbcPx0TQlNWcV++N97P8UTP1Jpi0FZPZD5fw==
X-Received: by 2002:a05:690c:39a:b0:8b0:f116:1200 with SMTP id
 00721157ae682-8b0f2222c49mr13041517b3.85.1792297443041; 
 Sat, 17 Oct 2026 21:24:03 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:4b47:590f:51dd:a46d])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-679b1f0e01fsm2838791d50.20.2026.10.17.21.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 21:24:02 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 17 Oct 2026 23:23:48 -0500
Subject: [PATCH v3 3/5] bios_emulator: use driver-model functions for PCI
 config acceses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-aspeed_vbios_fixes-v3-3-961124989594@oss.tenstorrent.com>
References: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
In-Reply-To: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
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

To allow BIOSEMU to build without CONFIG_DM_PCI_COMPAT, update the
PCI config space read/write methods in BE_accessReg to use the
dm_pci_read_config8/16/32 and dm_pci_write_config8/16/32 methods.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/besys.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index 23392d3c86e..e02c9fc636c 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -435,27 +435,27 @@ static u32 BE_accessReg(int regOffset, u32 value, int func)
 	if ((function == _BE_env.vgaInfo.function) &&
 	    (device == _BE_env.vgaInfo.device) &&
 	    (bus == _BE_env.vgaInfo.bus)) {
-		pci_dev_t bdf = PCI_BDF(bus, device, function);
+		struct udevice *dev = _BE_env.vgaInfo.pcidev;
 		switch (func) {
 		case REG_READ_BYTE:
-			pci_read_config_byte(bdf, regOffset, &val8);
+			dm_pci_read_config8(dev, regOffset, &val8);
 			return val8;
 		case REG_READ_WORD:
-			pci_read_config_word(bdf, regOffset, &val16);
+			dm_pci_read_config16(dev, regOffset, &val16);
 			return val16;
 		case REG_READ_DWORD:
-			pci_read_config_dword(bdf, regOffset, &val32);
+			dm_pci_read_config32(dev, regOffset, &val32);
 			return val32;
 		case REG_WRITE_BYTE:
-			pci_write_config_byte(bdf, regOffset, value);
+			dm_pci_write_config8(dev, regOffset, value);
 
 			return 0;
 		case REG_WRITE_WORD:
-			pci_write_config_word(bdf, regOffset, value);
+			dm_pci_write_config16(dev, regOffset, value);
 
 			return 0;
 		case REG_WRITE_DWORD:
-			pci_write_config_dword(bdf, regOffset, value);
+			dm_pci_write_config32(dev, regOffset, value);
 
 			return 0;
 		}

-- 
2.43.0

