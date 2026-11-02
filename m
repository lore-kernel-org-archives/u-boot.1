Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0C6070CBB
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aUsfQ232;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=ewbY9647
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87F706060D;
	Mon,  2 Nov 2026 16:21:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k19JwxKgJnMb; Mon,  2 Nov 2026 16:20:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9437607EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636459;
	b=bdLfmmTp3zKdjRq8QR55K53ZizUYp9IzWic1YX8Zh4X64BAEftWJ0uvnNqnAmZrn1VYO
	 3vTzTx7ryscxwU5Nw0tLnr324/yhkkRdd/P7L8ffqfKOHvDOtRQuxGk9K0jbhPA4Ozy+o
	 8YjFyH39i3ZFVfJoy314wrDE2YM+LCEktFNKahpWC9FWfP1PRDGDJTbQUq3zE3nFdpQX1
	 KwkYaJHj4yQnMfESZI3zdHF8ziJmYtHi5GVQu3RzdjATdGuFZ4eprJXW/HdaqZb1it37v
	 r1j+fOA8FzVkMM7QlR9mtJTAwlCpW25gMolFTeXaEDemXXVjzK3n2WuIP28XonehDDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dci5E6psLXdJ/P/SU4116QAjblG0fEOym7RLBN2qdYs=;
	b=PHXAcyqGem5PswRu4rjWD4RPZbW0l5shJ3GkeTofLbUnZgGBEEPR5x3jsDWr0zrGLXhK
	 bKyhpvUf9RgZKv5WRrVIC9rCtObY2EY4hES+yqrVhwn/qZQDnjrQtnLP+gFJZpOzjqSBI
	 cWMgu+MnaEkwNl6EWQotWFizyJ6o6PS1A5j5Ttjd0C7scFIfgXgC3g0TJb/4EFyioRr8t
	 r8H4KJQ1jyzteZKxQwajCv54kynXDgYPfRHRY7sU6i2HN09WKwUpxyoW6bSKQFixJZ09g
	 VytnufLnheAC8eBlzRFSCeei+03qsPmN1YjwUIDjJ776ovvAVBUjotzJVNaDYJOLC1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636459;
	bh=dci5E6psLXdJ/P/SU4116QAjblG0fEOym7RLBN2qdYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aUsfQ232CRnA3CoBJ0Zu9NPoyLQ3G7T52BIFuboNYC63kOpskPfVixMuH8qflyMn8
	 0Xrp1imEm9EvIP4Mub4UHR1StXTerCRy/Y/F2rbxbswo+K/+ZwSl8o4NvGGljjpXer
	 O52BlkgIpY0CueFld7CxQnU6OtwGy8RiujHrectdY7oCWLb/cXGxR6nLISrvGZh2vB
	 uxkhXAVabjdlft2XxJfQndK8tT8uC7QgW9HczV6/DEA9b5o25gn4vTzqhvpQE5C8DS
	 rfFCuygjh0XDty45xkKQAeoCbNMocogfHavxWsop8iJNWvUDo05w3qSNe4T4gc+Gsl
	 N5bvasHTA1bWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9437607EC;
	Mon,  2 Nov 2026 16:20:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65392EF4
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52BD7406CE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xpWMRmZUyasr for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F079D406A5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636452;
 b=gr7jCzGW9QZbQJCbbk2eLPnEWA9hbBt9HdIBk5b17NPfM0ABWRP1LMSaJR/S0U4K1rQj
 hzSVZ5j+HWotNSFUOkakI3bjOFueMfV9D6TNbNiQ0wnTXb6j1gBo93UFcMr9w1wzb4Zqd
 EwI6GYmjqg18bIojZlhNT5m1MRo+2CosrvgLDDv7c7zq1IlwS0Rns7H6cMExLF4G6TP/j
 b0Ap79kv0GbJchyapYuhmEZzgPY2axqTYHaDmrNm6JlG3Up8sBv+EjdEFfkwhPZdrHsZ2
 fZj6bqz7RrFikk1qHA2e7xnJCcTjuKjhWTx4/xylapF9JqXNvTpkaXDULJcXKdyn4yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636452;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=dci5E6psLXdJ/P/SU4116QAjblG0fEOym7RLBN2qdYs=;
 b=MC4BtApUkANVPPBICo2oHemXVjJc3FMdL32x/p2H3555cJqdzgcWjSwDLa7MX1IP1sn2
 wYwVV/E5BegX/YaAKoXmHCGZvH4J8y0v1hnY8tjapYcCY3gD8rdRpiHKDmVXnTVW0Qky9
 83nplwpe88443kliYseh8b5K3RXFqULH9PZmwzwxD5fUJD3+N9vUJ168HGf+K2B1u+mcJ
 GgL0ICRKAH56XRj97tZoikoCPQrcFaGmBnfq0UGBgYVbREqVA1TrzdO/6+EG3nJgwk1Oa
 697xHbCoIrSzR7YR924M8WDlJ0iOGoPu58j4vPs1OSVL5iqR1Zi9q62or8AT4DpKTuA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=ewbY9647; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=ewbY9647
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F079D406A5
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:50 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dci5E6psLXdJ/P/SU4116QAjblG0fEOym7RLBN2qdYs=;
 b=ewbY96473t7VL9FJY19dDAKFLiDRLCSXz3qGkN84lXBMc0hgwRSLbRIdnksFvsDOiKhIrD
 g4HBbVMZuMhfNcBwfUJIPGakJGYtqxOPk/eX/28ifyAJAMxBzP/m4Y5HpLbOEQ20wiAuMR
 nB0sVdS6y/UkcSb1TS5LORrnTkDoFK+6HlAFeV5LLXbjKS99Kb5Uf1I2iK8p3XGeYUNGsF
 rIpEAeSfVREDOlHQOSVaJk//M0R9cQENXBcp2mw4ZJTgpWqhj+lLaae8G6WDQgQhl2RIO7
 eLU7D4BqVjZa8BPOpz+6hvgcPHFJEktBUiIwdMDPFvexkmfF+WgeOnhfpzGgiw==
Date: Mon, 02 Nov 2026 17:20:21 +0100
Subject: [PATCH v2 04/12] bootstd: rauc: Free the boot script of a failed
 boot attempt
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-4-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4042;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=et+4nuMOz9Kr5btHzjfROvuchfE2+lJeqGI5W0e9meU=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjljTiMl/4oWOlO1mlV3NNavW4WLYvpdmlqe28Zm0V
 xp0hgR3lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATCSiheGfQsaTl93z5b9fyJ3C
 z34nXuPLZofMRbP1FkxJ1Lm5xPEIPyPDy+Vhd/X4DQ9vbvwpLzhHiqv4YRuLwv45bFe7b06/cnk
 qEwA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The RAUC bootmeth loads the boot script when booting, not when reading
the bootflow. If the boot fails, the bootflow keeps its private data and
can be booted again, for example with another 'bootflow boot'. Each
attempt then loads the script into a new buffer and adds another image
to the bootflow, but the previous buffer, image list entry and subdir
are never freed. 'bootstd images' lists one more copy of boot.scr after
every attempt.

If the previous attempt found the script but failed to read it, the
bootflow also stays in BOOTFLOWST_FILE. The next attempt then skips the
search and reads the file name and size found on the previous slot from
the partition of the new one.

Free what a previous attempt loaded and reset the state before loading
the script again. Move the freeing of the image list from bootflow_free()
into a new helper bootflow_free_images(), so that both can use it. Also
check the strdup() of the subdir.

Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- Reset the bootflow state before loading the script again (Simon)
- Move freeing the image list into bootflow_free_images() in
  bootflow.c, used by bootflow_free() as well (Simon)
- Update the commit message accordingly
---
 boot/bootflow.c      | 13 +++++++++----
 boot/bootmeth_rauc.c | 10 ++++++++++
 include/bootflow.h   | 10 ++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 7ee940460af..38747d35c29 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -634,10 +634,17 @@ void bootflow_init(struct bootflow *bflow, struct udevice *bootdev,
 	alist_init_struct(&bflow->images, struct bootflow_img);
 }
 
-void bootflow_free(struct bootflow *bflow)
+void bootflow_free_images(struct bootflow *bflow)
 {
 	struct bootflow_img *img;
 
+	alist_for_each(img, &bflow->images)
+		free(img->fname);
+	alist_empty(&bflow->images);
+}
+
+void bootflow_free(struct bootflow *bflow)
+{
 	free(bflow->name);
 	free(bflow->subdir);
 	free(bflow->fname);
@@ -647,9 +654,7 @@ void bootflow_free(struct bootflow *bflow)
 	free(bflow->fdt_fname);
 	free(bflow->bootmeth_priv);
 
-	alist_for_each(img, &bflow->images)
-		free(img->fname);
-	alist_empty(&bflow->images);
+	bootflow_free_images(bflow);
 }
 
 void bootflow_remove(struct bootflow *bflow)
diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 32e1de886cc..52d5be388cc 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -309,6 +309,14 @@ static int distro_rauc_load_boot_script(struct bootflow *bflow,
 	if (!bflow->part)
 		return log_msg_ret("part", -ENOENT);
 
+	/* Drop the boot script of a previous, failed boot attempt */
+	free(bflow->buf);
+	bflow->buf = NULL;
+	free(bflow->subdir);
+	bflow->subdir = NULL;
+	bootflow_free_images(bflow);
+	bflow->state = BOOTFLOWST_READY;
+
 	ret = bootmeth_setup_fs(bflow, desc);
 	if (ret)
 		return log_msg_ret("set", ret);
@@ -320,6 +328,8 @@ static int distro_rauc_load_boot_script(struct bootflow *bflow,
 					  prefixes[i], script_names[j],
 					  bflow->dev->name, bflow->part);
 				bflow->subdir = strdup(prefixes[i]);
+				if (!bflow->subdir)
+					return log_msg_ret("buf", -ENOMEM);
 			}
 		}
 	}
diff --git a/include/bootflow.h b/include/bootflow.h
index 1cfdda403ac..3df022f9aa3 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -395,6 +395,16 @@ int bootflow_first_glob(struct bootflow **bflowp);
  */
 int bootflow_next_glob(struct bootflow **bflowp);
 
+/**
+ * bootflow_free_images() - Free the list of images of a bootflow
+ *
+ * This frees the file names of the images and empties the list. It does not
+ * free the image data itself.
+ *
+ * @bflow: Bootflow to update
+ */
+void bootflow_free_images(struct bootflow *bflow);
+
 /**
  * bootflow_free() - Free memory used by a bootflow
  *

-- 
2.56.0

