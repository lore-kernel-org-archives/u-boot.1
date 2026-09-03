Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0952C624DB
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 13:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C4A360B6E;
	Thu,  3 Sep 2026 13:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zknf90Kr4VMA; Thu,  3 Sep 2026 13:10:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F07F860B66
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788441004;
	b=ZNS9mk9nzMCSR1NtfGzgsKRSNp6ObrXKJA8SY4OzdmGXu1GBB4pLfiDDj1sf8H02s5mn
	 Pk28ubb+K5EpDbGmZ3C3YWNfFeEfQ7H3KFGpBM/KhPNghsnLN7JMiljek0rC7etBbJhrG
	 jzq0+uwcwVUmIt/i7aJ4GGh8WBvl++RQSm5x+EHtSarFtV/Q9xOM82R/VjcJ5/lbrPEel
	 2XEhI6HIWekP4jtyEs2DRFMUjKbNLPAMjL/S51Pd8xwNr4En7w3GyCDKcqD7G8sXK9RAp
	 KXyqKZMJT95pZ3BAd70bix8dhs845vaGp6L2yk1Sm/pBfsN9BZDV8d8DDYIwhvPmRZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788441004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GhxZJa7vYWZxviNqRNZzBcOlrL5ADNXYgvHX6nYGYl0=;
	b=fBtzfqPmyBgiaEJrljJ0Y4miXyA7NnsI4Z+GCNt5PytgZE/I1WDHOIediNO6OD6TLjxI
	 /y6TYTKJbXWdEHMigM7KippSeuW2u3s5zHJ91q8k4tNT9O9RZ8BRhpXN9Q8FC75osj3fY
	 bMF+lpbabBB5U5Moz/09GMiu2eZuGcQ2hZTv3+446Hjgw84LHATkI8hUhouNU13hDGsuI
	 oJ9P9Yb/w+5f1xClFSgsYiQ2lijy84tr8/BDew5J9KC5fgXk9DbvzGxVvPwfOSLgeU+n9
	 NvC3JJvW5DIdym0VskforktJL9s2n4k874NDEzwxQpcFFojkZtgznUcroR8SOleCUaw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788441004;
	bh=GhxZJa7vYWZxviNqRNZzBcOlrL5ADNXYgvHX6nYGYl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ykooBHau3mYhINUlsfUDqk475IfFHgYddZTINmpYSIfTOo6Mdt4m8zvgBLmXSVhHx
	 lVWxIzWOap644sHSpnVjRWLVIvrYsB43FkWmP3Ry0YfFkJ0SW91jlRXYun/fNp4s/U
	 UkNeiK+m0Q2GWq4uIJf9Com3nP+xL57PNjAiWLscp7U99IjEPrBzpMq07I0/vAbiUy
	 hD9Jo3tHr0zh0+0IR9N7Dro+ZbGFg5ZlOsTHJzpjgpeosPPMtwX3q7f4QrWMXeqYNy
	 R9rPm+DohfDZQyS4QL447xF4Xes99Rx/j91WDD1A1D8ODT6Ni9bkymRdiO1qYSXIkx
	 YanlQLpraA5eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F07F860B66;
	Thu,  3 Sep 2026 13:10:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D19B8422
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2F6D40AE5
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vje8gKAnuYTd for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 13:10:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D682640AD4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788441002;
 b=GQZP2jECjvC7CMNcgB7XkBujXxyz4upuMHyom/gKEjviks5Q4A1NIS32ggq91C1/P272
 Lsd0j4O6ftQhfRF0O1/pNPU7q9x4iH1jM7lIu01wejTwrToDzPIThWDvpu64ZSROrQg1I
 IStqHdInTovkb1Z35UryA7018i6Thq3cMXmN8X/cb7neEGCJcH6lF84RX85knBoZ9xarA
 Ofgwf1UJtOEiab6uSrpDrjH9MRpXiaU8trWPIhjrzwyp21FNl+q8dzsjCTkKkNGQUsU+U
 bSmhNAQMZoG7ex/yzcNBtb/gmwXyCqbX0s3cAnk3o8ETqrlqyA2ipFVPKEzS+PJuFYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788441002;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=GhxZJa7vYWZxviNqRNZzBcOlrL5ADNXYgvHX6nYGYl0=;
 b=mdWOoqYHqmWsDGDsFVb71JTbe911c+DR7IGbhT8OwQlc3jt4xXiFe49XBzNnx2Xsky8G
 8BeRsvR6jVVu939lcxFW2diNKzi+Sq5LLmp9NYeqV9ooTHKXG1aEInm/zavgaYzp7g7Eh
 RUy8odD/VwDtn0YCj6U7vEDS7UVmw4BibICAGgrJNAbbmzyIA+CFPw5eTSnmQ62at+XEL
 i+S6KYAK+4qpHpo4T8lByHt905e1vc8Nqr7ip2HCMckoB4TbJhi+EByKeQkzApvxPR9Iy
 +vdpqnZJiM9JQ8C87INPj0Cd5pbFl5CqhtHpUag1S+k1GEjaKk2UGgdnX95M4KK+xfA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QMhgTrYS; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QMhgTrYS
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D682640AD4
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:01 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48436216a98so1490037f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788440999; x=1789045799;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GhxZJa7vYWZxviNqRNZzBcOlrL5ADNXYgvHX6nYGYl0=;
 b=QMhgTrYSbAvPHOje1t43OQKfAWOYGnmFx9GZoC3vNBUSTAHCnYw467NJzGnEFB9mE9
 YzoEI9bEfxwb45QLeGIZ78EIwt6t1gU+jbZZ5yohlhhLuizAETIB+7iDBYh3TWQx7Vie
 o+CpnFCcGlIHK00aoFoGHsnGPm5WVePY8ILW+ZxFDqQ7h/WUUq2NLEWmEfOQJ0beqqXW
 4AkY6Fo+BPZoJ3N1MU0IcsGFrs1Cqq5CMXkRoSPPDymHO5e+99IKexwoG129+73IvOfh
 RiN5dFXqh+ewrrLulTqK/hcg1Z3aLa6NP1yqs3/0EPYfjNjDB1jdzGl7qsuH9wqs/qne
 pHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440999; x=1789045799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GhxZJa7vYWZxviNqRNZzBcOlrL5ADNXYgvHX6nYGYl0=;
 b=hetIUhm3M1D0zTUmtZGC6PwD2GZ/6kXzQ1A9xgbNmSElIXLmLiKfbUMmBl+F6Uujku
 QNmmzfjwXtZOqVJK4metrsegiHvFsfDmoewv1S8FsY5q1a0UBzrfgS3mrs6zD7Hvf9hu
 QgwiWTf9ID8L8LGfWidcCP9W2YUTBHt44FgRy6PmuAOwi7/5Avtt42QNyG0ctzflSjjL
 VZJOdlOrhLYobhMQgHAqCv3EWoft4kpZjwijMX18QNU4HpywQEe2aL1yMIDpjrdaqlRb
 Nm6n1PX/Fux6qJN/o6NmKuFhNmfS0qcdVItlPk1K/60AcLMPDx9KKl00D9yh4gFH8Qra
 2Ykw==
X-Gm-Message-State: AFuF++lUhHgCyErWCrHgBI5wpwuCeTJIOqdCfmDEOAbCgTT+1j+Mr/8d
 SNYqeE4r44PZZLuAlqGRr0lnCS3PAF4yjhzRSsSi8zUWHiwP4clybUiwqKcJLjzUzfo=
X-Gm-Gg: AYBFou09aycdGWYgW2Xl1+V7uHuDytS8LIFE6gaVHuPMd+XW8F6iuLCOS5HybZNV1u1
 /vVD2rOXy8APe5kTWyw2ahxtQnLbHyehbgYt4s31aWX3j8NNWQv3DXMPqXXUtB0vr40uPaZ4jBI
 U3GhJxl+pOUwfOIq4xI8qo9KgsFpDZPvhrHkrnreN705QSV8PbtpIOzY2/6IIi8YYzuqvH5Drlk
 GSwF1jtKdWEQ7g9sXmRm/zZxxzfGeoDwrv93UQFtCZNXPqK34oiJGryQe6KpeCo1gsNVlHdexSS
 9PIpOoFMH+8/ObP+utj+sbsdPG1vZw9UokN4sukI+ytx7D55mLokGx8BLC0m5E7PrxykPmhvSRF
 6r0jSolRYGgK71xLupIKiGqu7vusNGZvWW2RHJyKFBpgi8F/L2vaeWU4gsKtiNgHtDGJXUnr3eL
 DRwRCvOYWzuGK2FTOzzq+I5bJFerzGSn3XHu0xo/tNIoYZJcOpnj+xlmtE6Orjhnyg8xjn+0PDa
 hb1kK8tfVt0Pl51gcZAWd5Ft0aU0mR86UuwIbnPu1MDxdS8y/JxS4w+22mr7nMHnHHcHQA12caI
 T+uF
X-Received: by 2002:a05:6000:230d:b0:485:82f9:44a4 with SMTP id
 ffacd0b85a97d-48582f9456fmr7414489f8f.16.1788440999291; 
 Thu, 03 Sep 2026 06:09:59 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed38cfsm12755807f8f.19.2026.09.03.06.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:09:58 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 03 Sep 2026 15:09:48 +0200
Subject: [PATCH v3 1/5] efi_loader: bootmgr: preserve a passed devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-ccaione-upstream-ebbr-v3-1-016658d0b6ba@baylibre.com>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
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

An FDT explicitly passed to efi_bootmgr_run() is currently replaced by
the FDT referenced by the selected Boot#### load option. This makes an
operator-supplied devicetree ineffective whenever the boot option carries
one.

Only consult the load-option FDT when no FDT was passed. Document the
resulting precedence so the explicit call argument remains the
highest-priority source.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 lib/efi_loader/efi_bootmgr.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 8938b214ceb..6b5dad21b06 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1294,9 +1294,9 @@ out:
  * efi_bootmgr_run() - execute EFI boot manager
  * @fdt:	Flat device tree
  *
- * Invoke EFI boot manager and execute a binary depending on
- * boot options. If @fdt is not NULL, it will be passed to
- * the executed binary.
+ * Invoke the EFI boot manager and execute a binary according to its boot
+ * options. The devicetree precedence, from highest to lowest, is an FDT
+ * passed in @fdt, the Boot#### load-option FDT, then the distro/ESP FDT.
  *
  * Return:	status code
  */
@@ -1305,7 +1305,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	efi_handle_t handle;
 	void *load_options;
 	efi_status_t ret;
-	void *fdt_lo, *fdt_distro = NULL;
+	void *fdt_lo = NULL, *fdt_distro = NULL;
 	efi_uintn_t fdt_size;
 
 	/* Initialize EFI drivers */
@@ -1320,11 +1320,13 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	}
 
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
-		ret = load_fdt_from_load_option(&fdt_lo);
-		if (ret != EFI_SUCCESS)
-			return ret;
-		if (fdt_lo)
-			fdt = fdt_lo;
+		if (!fdt) {
+			ret = load_fdt_from_load_option(&fdt_lo);
+			if (ret != EFI_SUCCESS)
+				return ret;
+			if (fdt_lo)
+				fdt = fdt_lo;
+		}
 		if (!fdt) {
 			efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
 			fdt = fdt_distro;

-- 
2.55.0

