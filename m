Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B3ACA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D788560710;
	Mon, 12 Oct 2026 21:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VBVYosTaGQ6c; Mon, 12 Oct 2026 21:50:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 22FB4606F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791841815;
	b=Ov7fzFXdCR9iXwlrsAwL39/Uq5Z8EJpdAIO6hNZtdcAeFA639jIw5QYcElF0dWjOrpIW
	 jdTBtxepXTCkCBzaIQdfe3DlnNzh2wubmsN4nrrIU8ypd08lFJfZ/txp1Baucy1Z7sHJ2
	 gufwzgaYzz2s6dkjxyeRpGYQTdzB0B6niSnMt+jeBSGT9wxOKARpjuWcMwV9dSvLqd5V9
	 HG8iUQhP+VbZIqM8akafaqgn1o1i3OW67IKU771cVuRBT7tOxWdxW/hwWsF6KpVw8LEu9
	 XAMRTf2B4szZdNk3v4WmIntxqVoIwregmkyduMQIGOv14FiFPMJ78IGI8iEYUWt27nQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791841815;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iJ8TV+5SiCbeMxxA0TRkovekTq5xoeL1DRJq8mMxcdc=;
	b=mti7HEiMBB3DiLwwH7hiauirZekiN2F7oK6qmvlh96hYJiyMplr5zdHytuU7aRUvGVG+
	 ZyL4ndMDHUXl+BSRIpikWggIhCfJENdSMhFXW7gqTgsLL8nu+aw75CcupuKhGSJFQ1ZlF
	 Z168SWMJZJnE8EW6SUkQjSEfzIgzqaQCBENQvg9PE1yJbBmHjIWlqJUA45kU9Li37vL6h
	 pM5mpqNQmIVUcEAQboEfeDuYdVzEQRZSyqz2yHEjdUe8UL/kBoQwd2kwDNr0fNjY8g461
	 BZbArEDQ5TFkt5mcPUcIXoGJIrHYAKJt8X5KrOwkQ6JL4regu8eEIWd4z6M/1a66fgg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791841815;
	bh=iJ8TV+5SiCbeMxxA0TRkovekTq5xoeL1DRJq8mMxcdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=quf3ijtyJ4nWCUTfkOEaysmqlP21RyjsJEmEs9OyGeeaFl7AK1DRlUv5ed1fvxYln
	 JPImdT2NbRMzM3u+bFQ1IlisWhZXRLkAeFGTJwCXkDDT3qIDqRLkD2ZNi+FtPxqXs6
	 4c5BAZjHSXb2h2TI+fugRhuLf6dtwgPfn6fCG8K9X1A6sVdEv0OeENM2ecnNdSarik
	 XNCsPbbR9GuPH7Pdhxijaqp/Zwo81ECatqMA1UUy1umV4xsKd/3vPaMJ4G+2wRpvFM
	 TDvu1iz0d5f8HHjwJH3PzdDhGc2LZSgDiT46bjTUplC36A06wIUhsZdTkOOz56gqsT
	 DipqP7QEkikQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22FB4606F0;
	Mon, 12 Oct 2026 21:50:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 75AE1362
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C24E80AC8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:46:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PHSi8Dpi_FAh for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:46:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6891280AE7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791841576;
 b=ElGkdHGU9AzLTudpZuJY5r0eSbiKEzuZjp2hdjP4hNy2oz7CmmeOP1GtUBQAlgI9qw8I
 WMapnQZsa3EjX/+nCYRkXaYpl2JplqpCcjDSD0jnKQu7eAe1D7de5F32epw5XmeyWpY+y
 ap8aHTIBoQpjHh++sKrGUINa57B3ErQq/cF1DSaa0cYLtpL2TxWT2fyf2oWjGawmTpNAo
 2fkEW2MdD/zukIfWj4XersxOIywv1oAE1odp1/Dmbvq8tHOP4wS6UXMRGw2YFoQARgTew
 XHWV+jXYO7lUlxjdHMg5Wdqbs0itvUum8hWu18ZZPRbXy6wBwJTDcicwaRi00BuVoLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791841576;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=iJ8TV+5SiCbeMxxA0TRkovekTq5xoeL1DRJq8mMxcdc=;
 b=Tl0tMTL7jZVAPJ+b6utMpIQESMaWshvaccYzA2IAaydstBI/sjVnuJodZgOUmDsu3NT6
 SfetdGpQPS4nc14/CgtX9wbCp9D3ansS6QVHS6uuy135S5CMT94tateanXvsbN5525MUy
 /IT+qKKcIhqcyoPElyMsa6nhDF1aMZ31ItkhlFjOwUvjzGnrdDtJzMyuODXvrkHfHYOeN
 VUKl9qfBt1VXr5GHcGN4umHfKbcMk+pG8/6IeWjNgj10mBm+kUxpNmOMLaZU+d2nYAZdA
 hjwhsLYuTajhMVeVyY8WygdFVC3dxqbr9KDU4MNnKoncY/yf9vYD/Y2eXw7qudkz1TA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=s8pY0Nw3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2b; helo=mail-vs1-xe2b.google.com;
 envelope-from=sebasjosue84@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=s8pY0Nw3
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6891280AE7
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:46:15 +0000 (UTC)
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-7c03744ef27so579484137.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791841575; x=1792446375;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iJ8TV+5SiCbeMxxA0TRkovekTq5xoeL1DRJq8mMxcdc=;
 b=s8pY0Nw3+VBNkXRqScLo8w/TS3otfceKoNib2AIIIxSWzQMycX7vlFjsMkYk+1VoNt
 AquJAg1cEQaDBrO9OhxMymZdBDRJRh+zqgX6y+aZoIr4PYRG9Zhb314qk+YYfY1NN3jF
 Ap0qokn3B5tbxM4j9qS7YfH2Fw8Fu9gfqz29rKr0w8u2MmBYWPj+cyD3Tl3gk9bbq4IL
 vitgItE9kY9DPm34mEAypb7EhFE5ENzTTNKJjQpzEzfloRj6sPlPtYQAI7ugBp/IVyG8
 3wp5GGURDDIXINrEEvv89r44vyyxiYGHuSUF92QybvlAO92mAzmfi/zWuVeKqudShKGd
 Agbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791841575; x=1792446375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iJ8TV+5SiCbeMxxA0TRkovekTq5xoeL1DRJq8mMxcdc=;
 b=1xxf/L/v6+6SvxsfSMpfuRxNTWVOdcV67FmudQsERoFUtbt6SZ7HmTa6W/1bcwmH3y
 epCXoQBgjCW+7fXa9USrr3zuLijLK0lKrIX/SGP2O/XUcfiS+d6o8YeQvK/u488wMZwH
 x0JUyICihM+YNImBbPZXDG4NX59iWeaSt/JXKEQB11IxvZ2fzEEmhUHeuOxZfUvIgLYs
 vPtp4OiFqTE8ZHnkSNv58zW4TDss0IBvluHRCkdOR3SBuRMTcN8N5F7cd9PXFdiv5mpA
 KgzC/dKaFfBhATupJHVD/uslG9DhGwy/bMgdCwLWMX/YEHU31oVaBNcq7PwlUvygsJZj
 7Dgg==
X-Gm-Message-State: AFq9FYJPKp/dnRc8mIFFVflsb8hTdSMhMVdCLs65SdZx1Okl189y1fBB
 nYofFh7sMDGAOMD24eRrTgz0Voj3DQHRGsrCuG3jg6qizo+mJ01UHWlO9ie5MZaO50WN7w==
X-Gm-Gg: AYBFou2f4gi2iJcff5ZZwzRM4Fn896fQlOAlCYbB0uVPZnsv7XCcyAHuBJHXZxmWTL7
 GxBMVoObfNm3kNAqq82CZpC/2QOhCBY6XnO224KjJd/pZzoO4oGFuh8iFCgLa3NmPFnzJ5lW2KU
 sPc3YvQ36Uf+ch2Y59Ng44fE1V5R/RgQ284LFEf1cV3MgC44fn5K/1kqSY2xdgP8RG4AYFiNI3a
 rHDDsWqAK8MfSwES6wkq+bqCREXvXBAolQ69rKmsbxUALF5KAHaoEDpefkuZTfrMTsuWXC+miFm
 KWez0sKtl9xqhmwpQVdafxr1kBMJNZSR/HxCKEaG0A8uI05ptUsr2UFk6WgPp3TBk7URG+pqU5a
 FSkOeAsFk/sIDwwBFT38CdEPFdGYdWbZmgUwU4mQDGYwnUkWIZaL4Q9Jv/y+q2Usq5xnlKjkZgS
 WmIDk8ujPdU2AoDPAOeq1wgG+E/7CfPCOrsB+DgTBVOIIyZ5sZLyNI1Wr3HWKVW8yXWpIoVxSFk
 q81wnD7LUJ9TiLQPM7hpllKpJhsIJ8KTY3zFn8w1ktM0dY+oi5XzAfNIlVIe3I=
X-Received: by 2002:a05:6102:149d:b0:7c3:c0b9:9031 with SMTP id
 ada2fe7eead31-7cb37b2a030mr2521071137.36.1791841574565; 
 Mon, 12 Oct 2026 14:46:14 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cb35471536sm7301225137.11.2026.10.12.14.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:46:13 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, michal.simek@amd.com,
 Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2 1/2] spl: atf: Keep the caller's default when the entry
 lookup fails
Date: Mon, 12 Oct 2026 15:46:03 -0600
Message-ID: <20261012214604.1477684-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012214604.1477684-1-sebasjosue84@gmail.com>
References: <20261012214604.1477684-1-sebasjosue84@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 21:50:12 +0000
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

spl_fit_images_get_entry() reads the entry point of a /fit-images node
with fit_image_get_entry(), falling back to fit_image_get_load(). Both
report failure through their return value and leave the caller's ulong
untouched: fit_image_get_address() returns -1 before it reaches the
*load assignment, both when the property is absent and when the value
does not fit in a target ulong.

The result was stored in ret but never tested, so a node carrying
neither an entry nor a load property made the function return an
uninitialised stack value, after first reading it in the debug() call.
spl_invoke_atf() hands that value to bl31_entry() as the BL33 entry
point, overwriting the CONFIG_TEXT_BASE default the caller set up for
exactly this case.

Before commit caa7fc2c5775 ("spl: Use standard FIT entries") the lookup
used fdt_getprop_u32(), which returns the value itself and yields
FDT_ERROR on failure, so the variable was always assigned. Switching to
the fit_image_get_*() accessors moved the failure signal into the
return value, where it was left unchecked.

Pass the entry point out through a parameter instead. The accessors
leave it untouched when they fail, so both call sites keep the default
they initialised, and the uninitialised read is gone. A failed lookup
is not an error the caller can act on - the default is the fallback -
so the function returns void rather than a status nobody would check.

Fixes: caa7fc2c5775 ("spl: Use standard FIT entries")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 common/spl/spl_atf.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index cb0604ce03..c1233b54cf 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -252,17 +252,20 @@ static int spl_fit_images_find(void *blob, int os)
 	return found;
 }
 
-ulong spl_fit_images_get_entry(void *blob, int node)
+void spl_fit_images_get_entry(void *blob, int node, ulong *entry)
 {
-	ulong  val;
 	int ret;
 
-	ret = fit_image_get_entry(blob, node, &val);
+	ret = fit_image_get_entry(blob, node, entry);
 	if (ret)
-		ret = fit_image_get_load(blob, node, &val);
-
-	debug("%s: entry point 0x%lx\n", __func__, val);
-	return val;
+		ret = fit_image_get_load(blob, node, entry);
+	if (ret) {
+		debug("%s: no entry or load address, keeping 0x%lx\n",
+		      __func__, *entry);
+		return;
+	}
+
+	debug("%s: entry point 0x%lx\n", __func__, *entry);
 }
 
 void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
@@ -280,7 +283,7 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 	 */
 	node = spl_fit_images_find(blob, IH_OS_TEE);
 	if (node >= 0)
-		bl32_entry = spl_fit_images_get_entry(blob, node);
+		spl_fit_images_get_entry(blob, node, &bl32_entry);
 
 	/*
 	 * Find the U-Boot binary (in /fit-images) load addreess or
@@ -291,7 +294,7 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
 
 	node = spl_fit_images_find(blob, IH_OS_U_BOOT);
 	if (node >= 0)
-		bl33_entry = spl_fit_images_get_entry(blob, node);
+		spl_fit_images_get_entry(blob, node, &bl33_entry);
 
 	/*
 	 * If ATF_NO_PLATFORM_PARAM is set, we override the platform
-- 
2.43.0

