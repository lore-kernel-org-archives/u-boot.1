Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAFE6070995
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kbZYpcmo;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ngQWpMG6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D011607D5;
	Wed,  4 Nov 2026 21:52:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7x0DY2bli4OC; Wed,  4 Nov 2026 21:52:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D021607B4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793829165;
	b=MNjLVFnEK9+qy91CNxnRvuzeVCN9Odg2X5b8UFa0CfYfpIDnP6FeNetGVodkXyA80Jom
	 XiysVCkH+LFmCBNe4KvGY4zEpJqWj0VqjMX77GuQdjDeNXnK4fdJNY+dzdc5aFIfhnyI0
	 V/7YCmlUSfvzfXN/fJv/XWM5o6awDI67j41ME0RNd5BYHuwiP9CKTcHKaXkkunkGj+ql+
	 ccPPRXDnymBjCVd2tvdVq5faCIIJeBTp+1NN8fhayMMMKlX6wjCQY0+xZDUteBie3d355
	 /ktYdke1FBCRBIBoG5JyEHqizZ5jhjtORSMPeVUlX0xuU2PmZZbNukMsxB6OhKLNsDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793829165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tL2XGn+w3Mv1PakLus+jhQODJCjPknL9MDLIV6EEDi4=;
	b=HDETR8kvxmyfyBiURePZdQbBkuatAlKDjnC/wEHBC+ai8fktRgF21uOmVdCiFVLwW7G2
	 w9V924qZr0WCTJ9akhCzhU0HeCXSPYDW/rkxcdNoDgMxs7qL06157Zx648/73Iu0C0OZM
	 ZPpFsXTDWOX98hXBfTsk5CUPaQzkcT5N93LxyyMMfBaG0ZLJWkuXTRQ0S6j1MS3tzSt4h
	 Bc0QQBYxrjn/sbngzeH3wjhtTsXWZpnDDMvTL6xOQJfC7zkzKnTFADMtDYKxiEWlt9CiT
	 JifgnVRgTfWKyf5fPzXB87qqUkY1pMjrNIMmEhqDr5RisTq0HVCgzTbEW9w51gjFntQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793829165;
	bh=tL2XGn+w3Mv1PakLus+jhQODJCjPknL9MDLIV6EEDi4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kbZYpcmoDYcao6F75PawPhEoTPaKfWkMUQL8D/fNr96PfdkuZHt0BLwlLxgNoCa+Z
	 9yyf5vk1a0Yf6hZEqFBuoVwWcMBgDQ4FvNAEXKshEW90+ArraboBhRPs5tPxMHHKCY
	 +CvJMJIiM7WseqdldphcbF8BFp/BjpRSarAUpySAyHSlukTlaMZruj+Kwn0riT0udJ
	 8IGNbRd42PIG5Ll+0YDFOxvtRKQkfPr92FCGGMNoYIBmjZeFqC5IH7FTM5Y4eXbuDb
	 AeFTWNoK/FMHFa7qR4rMOkMyABDAS28kF2Km/PBfxSpCZUVcAPg8Ht5+i6NJF4ig51
	 pW+ZVQzrAB6Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D021607B4;
	Wed,  4 Nov 2026 21:52:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C6F8CB00
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B893940211
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJ_Qf5BrIHoa for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 21:52:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A49DA4008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ngQWpMG6
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A49DA4008E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 21:52:39 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6deb848ddd7so870499eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 13:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793829158; x=1794433958;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tL2XGn+w3Mv1PakLus+jhQODJCjPknL9MDLIV6EEDi4=;
 b=ngQWpMG6wFOQjARZz+HtIbZaELCxq9KtR62EG6r7GV2LOdY/fyxJtwBF/3i3N97IZL
 WMopmS+Jt8VNQJHTbF2UsnMW9XiblEEzYdtIbv8BLo9rnHSDOGzOchnvgsOM6mR3pX0L
 PHv1oaVshMAcVpl6nXW15OfuaY+S1gxk4wUifleGx2lK91Bulmw7zvWgtAUrtmLuvAj6
 hLYNC/hWwxgxM+iebaJZcHQ2li5C8dmQ6QdyJ4iYcBNy59/AVZbs2lllAPOaYSS1Rjo2
 d7OlHM5Sm8R1fxR9PIM6iS61Q4tjLwzbzW2RCLBVVhJVLRuOEhSKxJKLyDFCSwACleOo
 pmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793829158; x=1794433958;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tL2XGn+w3Mv1PakLus+jhQODJCjPknL9MDLIV6EEDi4=;
 b=VWSBmo9wK7XZc07AcFzxbwWyAm3ryWie+sx4p3GCOlzG9QotnuX6jD4eE5A1Tp4JyY
 2ftFe9Khm2Mo9eis9OoP2UcLYS3HfmW4C4mx6ybjy63BkdhD7GqYhQkwjehderKMhhZK
 Y6wUjUP7QfIPhZy3QhnH14dmevMRXr+pwsQUur6CE2yJML1VlWNbbZ4U0lI12mQAi09E
 NYh2s072m5gMziUelRN20TuR1GdLewrB5Vp86Pq/LX3RAt5ou4Y10FR1hBcYW4j98UiW
 nqLTlVCHbZAEkZoIKTM+cVURamy/rDdbvbxj4Il44NzBc5CElwsL1rUUDIlenOyPE9Bp
 lBcQ==
X-Gm-Message-State: APuU4Z+ZlHPg36QjiDXY8zA/Y8JulrtOU1r1ajHGZqkHa5qZ00jiVUaV
 dIAg2bvoMbYC5l2z3w01VgN9UyCeXZorWqeMedlEMDuvmLIEawhDAzEvx10DvSTXyiHF9jEvdde
 IxxVWeUI=
X-Gm-Gg: AYBFou2RV2vtBdiwFdcl1qaS1KpyPep1ywOgjyy7Dfr2JPCsCvb5zwik/XhTpF/ucRK
 jFvqjcgn7gWuIC+lMq8L4bMtNzgWOkp8HkCStZoHNGd5Vy16Sbo6GhOyiD/JuopM8Dz3oNjgYsI
 EdGXrw65zYpzPBYxlxgb4dpDYWwbnx/oto3oAsl021oGELEMhake2a7zQopP9QJZJTmFHSUYgxQ
 gToeotHfh7I2QMs5d5lS7VGOOWGJR/XMa5qYf3M4+Mjs5Qgv26fqkhOo4ZkHAHeK/ChXLiGuuxV
 565mj92XQ3jZmrPEZmczdZh135toaDox20ECsWdNtWbY/KugIm+roFAlGqhbVWxXTJaXZIiBYmB
 yXcjJjuFYEjv892OLvBP3ojnpL7XwPeDm+QDLQexmmqlAxrfLPY8f0BtQHZHPv036H+AKaBnQ1P
 fBNZCrgFCoNUBtO2lvXxbAB3WvjGIltFvtzW3G6Aq7EX6dKvc3bZikX3UIeUx5nNszGk4Cop9VQ
 /iztoxPzy+C7kWn+YWKR6rLldr9Lw8ahgS/TuQQC502KxSOqH7KDb6Uoxa21O83LWaV3pa+9oj8
 DMMybRRwiCWerd4CZq92RNhg63WwNolD
X-Received: by 2002:a05:6820:4587:b0:6e7:9606:6c07 with SMTP id
 006d021491bc7-714f255547dmr8609368eaf.74.1793829158018; 
 Wed, 04 Nov 2026 13:52:38 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12d1f36sm2479415eaf.8.2026.11.04.13.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:52:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 04 Nov 2026 15:51:54 -0600
Subject: [PATCH v2 1/4] bloblist: add bloblist_get_reg_conv()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-spl-bloblist-pass-regs-v2-1-3126de1b77e9@baylibre.com>
References: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
In-Reply-To: <20261104-spl-bloblist-pass-regs-v2-0-3126de1b77e9@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4799; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2Jq8uJZ3dvWdZZzWmVRXmkQEznXhVjXUhUx2NHcwqvM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq66kEbodb1qg9KbR3Y82ogugQthZ71p/7RDjY9
 33UBGDnaMaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauupBBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AE5QH/jp48y3VbWQjG3jkwcCdmaCC3OUQQnjBkxhzKjR
 TL7lQxUqbyEfmTzE0KlYOVxjDE4eo5RYg//nvD2Aw25AjJy/+97is5Y3VRSo0OEHtNxkGpFHyAi
 zenm3ZDgk3KGpulJu6qQxe37iJIb3phJGDuKPkvXruW5hDV4gJiOB/En1kMGMUfu3c9uhIR0Xl+
 ywoNC41t/jhD67hKV7c8+1Ej8mx4zm0cBZPVS+cY/+q3iYsOuWTUrFKembg6avhjln6627URsFx
 Zw7CRxmciVfDRplsbbt8osamb20l8O47SV2vTcYNq6M+vdb3HYlEs89/rhCW0xr4Ku7MiT4mUMn
 TTEs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add bloblist_get_reg_conv() to get the register values for passing the
bloblist on according to the Firmware Handoff spec: the FDT address, the
signature and register conventions version, and the transfer list
address. It is the counterpart of bloblist_check_reg_conv(), which checks
these values when a bloblist is received, and shares its signature
calculation.

This allows U-Boot to pass its bloblist to the next stage in registers
instead of at a fixed address in memory.

Add a test that passes the values from bloblist_get_reg_conv() to
bloblist_check_reg_conv().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/bloblist.c      | 36 +++++++++++++++++++++++++-----------
 include/bloblist.h     | 16 ++++++++++++++++
 test/common/bloblist.c | 24 ++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 846c8047f74..4269a49ef99 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -664,22 +664,36 @@ int bloblist_init(void)
 	return 0;
 }
 
-int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
+static ulong bloblist_reg_conv_sig(void)
 {
 	u64 version = BLOBLIST_REGCONV_VER;
-	ulong sigval;
-	int ret;
 
 	if ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
-			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD))) {
-		sigval = ((BLOBLIST_MAGIC & ((1ULL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
-			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64));
-	} else {
-		sigval = ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
-			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
-	}
+			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD)))
+		return ((BLOBLIST_MAGIC & ((1ULL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
+			((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64));
+
+	return ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
+		((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
+}
+
+int bloblist_get_reg_conv(ulong *rfdt, ulong *rsig, ulong *xlist)
+{
+	if (!gd->bloblist)
+		return -ENOENT;
+
+	*rfdt = (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+	*rsig = bloblist_reg_conv_sig();
+	*xlist = bloblist_get_base();
+
+	return 0;
+}
+
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
+{
+	int ret;
 
-	if (rzero || rsig != sigval)
+	if (rzero || rsig != bloblist_reg_conv_sig())
 		return -EIO;
 
 	ret = bloblist_check(xlist, 0);
diff --git a/include/bloblist.h b/include/bloblist.h
index fcd290eeb16..cdb5764cf55 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -536,6 +536,22 @@ int bloblist_init(void);
  */
 int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist);
 
+/**
+ * bloblist_get_reg_conv() - Get the register values for passing the bloblist
+ *			     according to the Firmware Handoff spec.
+ *
+ * This is the counterpart of bloblist_check_reg_conv(). The register that
+ * must be zero is not returned. Call bloblist_finish() before passing the
+ * bloblist on.
+ *
+ * @rfdt:  Returns the FDT base address, or 0 if there is no control FDT in
+ *	   the bloblist.
+ * @rsig:  Returns the signature and register conventions version.
+ * @xlist: Returns the transfer list base address.
+ * Return: 0 if OK, -ENOENT if there is no bloblist.
+ */
+int bloblist_get_reg_conv(ulong *rfdt, ulong *rsig, ulong *xlist);
+
 /**
  * xferlist_from_boot_arg() - Get bloblist from the boot args.
  *
diff --git a/test/common/bloblist.c b/test/common/bloblist.c
index 797bde27025..23def33ab6f 100644
--- a/test/common/bloblist.c
+++ b/test/common/bloblist.c
@@ -605,3 +605,27 @@ static int bloblist_test_blob_maxsize(struct unit_test_state *uts)
 	return 0;
 }
 BLOBLIST_TEST(bloblist_test_blob_maxsize, UFT_BLOBLIST);
+
+/* Test that the register values for passing a bloblist pass the check */
+static int bloblist_test_reg_conv(struct unit_test_state *uts)
+{
+	ulong rfdt, rsig, xlist;
+	void *fdt;
+
+	clear_bloblist();
+	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
+	fdt = bloblist_add(BLOBLISTT_CONTROL_FDT, TEST_SIZE, 0);
+	ut_assertnonnull(fdt);
+	ut_assertok(bloblist_finish());
+
+	ut_assertok(bloblist_get_reg_conv(&rfdt, &rsig, &xlist));
+	ut_asserteq((ulong)fdt, rfdt);
+	ut_asserteq(TEST_ADDR, xlist);
+	ut_assertok(bloblist_check_reg_conv(rfdt, 0, rsig, xlist));
+
+	ut_asserteq(-EIO, bloblist_check_reg_conv(rfdt, 1, rsig, xlist));
+	ut_asserteq(-EIO, bloblist_check_reg_conv(rfdt, 0, rsig + 1, xlist));
+
+	return 0;
+}
+BLOBLIST_TEST(bloblist_test_reg_conv, UFT_BLOBLIST);

-- 
2.53.0

