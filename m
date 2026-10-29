Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1F606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZnL3FJG3;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=S3PaqnmC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37A098104C;
	Thu, 29 Oct 2026 16:23:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsMPlr3CoNrX; Thu, 29 Oct 2026 16:23:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2ECCC80FC6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291022;
	b=bLlFF/epcK719XT06VulZVfre0Xf3DKyqEaAMTo3GbzzYYMC/HK8tTjbG7Pb3QPsJYEM
	 o5dwg0GjB/7DejUNrfFmGIUyHWxBe0JbrlmaaebLpn3U8um2DKrmRdvTSjTZOdGYQKDxG
	 ulrkQyguGqR8DLwnCAgIoEO8ZIwtK1xx78CPzcPrsXu0TxV8v38RBxrzGSHXPwI0U6scy
	 6NY/0Q0GBLTZeEMmZhWEjJKydSLzr3FOhBxyfw77xd97QLXXMVLIdKJF2rtpfP1E8OpnW
	 yH3hhTcnGFoL4+gxrabBVK0gdX/Kca9ZDE1S/JUU5vV8hQF5I2WGss7mSyA7GybA2cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nByYmU4yX4ZJmQRBzw+r/iyyOTA3FeATBO7o8Spocrs=;
	b=J2MHBBtIOPl/F9JC5Won3IfPtebwrjwuFJlFxIodTmQiF30ouDgsr1NIwIi5TfFrQGjV
	 gR68IbzxlX2d66NgivW61Ke8ayXJlYuRp65YWFsag1PnnDY55ZXszJpRdjo+rHv/RpyaP
	 cqAyV6b2X8BP9KzPFxrX/lJHaB8T+vFWupdcATQ71hNq+kGiFKFClXlUeSMxb8Sa5ziWa
	 6qRdTcd/x8+dyzCTFRpaLdPM5V9d2A7GohdaZS/Lsl0+/wiWWjyPQ9N3dC8WfbWgEkY5z
	 H4XOw9792X5WGhkn93E2AlMs73sBrfM1kSTl6sB6c9yPSKMhbcCsbaJ6eKBZq7wrcCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291022;
	bh=nByYmU4yX4ZJmQRBzw+r/iyyOTA3FeATBO7o8Spocrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZnL3FJG3p1uSukHEHAbBeBMH4suOH3NjiiEXToz+YpF1V9ANe49xkYmEk/ygLmhww
	 HUGfcn+2nUEJqkrIs9meY7l+tKL/PIQ/vNEh/uHlEFJDP24nhDbGmALNrUd7K7yBkU
	 KVZNOylhJ4FVgoNXkLtsR75TO5OAdN+fH0Wmq3lKrxWpbSu40vHeDYR+sxj4NFamTi
	 p6tU0x4YD5KMGl+YyGbxIFX2k0i0lhPpteCmvPUY4LLfPrJbtggC9Hn3TMckjZdgBW
	 IqOJD4LW0Tdd6QILaojAE5vGYJOlJJsHUn1QEJ/5UNmOnGHemOwYq/bS7ehQHk5rUn
	 Dc3vpE+CV3tDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ECCC80FC6;
	Thu, 29 Oct 2026 16:23:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 48C8A362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EEC94075F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pN2PC4JszXJk for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE3F940744
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291010;
 b=ZqeGPPO+KM2Ya3Gsp/rii0NT0w6p4rr96TxVakY0BLaOqHWgNsIjOerD9XAh4Wf9Z3r7
 529/kS9I+TyQvqvRs8F9v3yVNFaZRNrXPEQLf+TQUjWLZOENDmN0+2SiR2CNE7oHFu520
 LU1kG0o8Zs3ai+leVsmvI+M7BCQqing5nydswJ2i+1cm4Ia2ckhJP0ujlvgLeJiXQLP3K
 jglOXnEHPIO8rh2DxmwZsuZLlszoivqrxnz7tYoS3yYzzmJqE+Kj1kKV9irVm5F8wyxZd
 5IyWrPx/4CqUESEksxVV6VRhGxtnR6RMy/keeiBGf9GOcs1qE729ZvrqyHinv67Wc9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291010;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=nByYmU4yX4ZJmQRBzw+r/iyyOTA3FeATBO7o8Spocrs=;
 b=nErrOLza5roTrj8DdzhI2UePZTaT8fbS95J2DTY8C9u3mH28FaKF8/7rQJsNm/6A6QAp
 4f4sb9/KQonK5I3/CMdOs0dEsefStz6FWqJTUezGQVvinNGg+QWrW11Bvml9Zh6QcrTk+
 HAG8+XaQNVitHC39W2lj3phi8woeTshehsaivXVPs+F2gZWX8BJQP6WcFYhyaW29/6Q5s
 t18VKACqoRi0io0G95nrocg3pEXwltefMLWg1WyQpWjdfgyZzP6uIwOOczC+YIrEcAGOE
 YamNb7aeUYW3KefGSK135mYyw9lX6hIJvKbtE3ejAhoKgN/4k0oQBV4TvBsVI7P6PEg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=S3PaqnmC; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=S3PaqnmC
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE3F940744
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:27 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nByYmU4yX4ZJmQRBzw+r/iyyOTA3FeATBO7o8Spocrs=;
 b=S3PaqnmCh9IXpBi+94qBPdzvYEhjR6IBCdvzzV44oUQ2XDqJSMF7E2jE7TC5q3+CjtbbjS
 FKWkg9ixIscDkYTlQ65xmv/BkIvn1PvpstuAC2AP0Msjon4xpt5bm9nkTpHRGiNLSdNQC6
 yu5+5Yo+/aoH7WNzuYZyuloiE9n1lAoRjZskHAB8LvpfZI7SL9rB9We9pYDa22r4Yn+DGY
 5e4A+vmnZVNJYlspVO51hd8o5xvwyBTeyWGxHMwHMvv6YZ7ACB92CxzEaKC6sg0apaklDd
 tQ+eNXoHdhP0vxE7z+ky8E+TR9hMS23qIoqZQFKgQlSP55Y7lnRtuIEc3kqaMA==
Date: Thu, 29 Oct 2026 17:23:10 +0100
Subject: [PATCH 04/10] bootstd: rauc: Free the boot script of a failed boot
 attempt
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-main-v1-4-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
In-Reply-To: <20261029-main-v1-0-b5a878627107@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=c5iCqD8XzI6d8uolad0tBtHoMIT/3mmKQHsAq5z7F6g=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0a+Zv4p7Uv7MuxgvU8Oz4tnyWfvqWL7aue53ic3lr
 vd6Wf6so5SFQYyLQVZMkUWK3+K1rVmsj/yx6iiYOaxMIEMYuDgFYCK8NQz/Qx4LK74Rl3+w6mR8
 d3zEm6+pW5fr6H7Tdv11b3vGgSMxixkZvibt2RjxJMlmTqHuVBXD6XG5siG1OosemueIb+n0u1j
 DBwA=
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

Free what a previous attempt loaded before loading the script again,
in the same way as bootflow_free(). Also check the strdup() of the
subdir.

Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 boot/bootmeth_rauc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index fc073aadd21..3bb9a2ace3d 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -285,6 +285,7 @@ static int distro_rauc_load_boot_script(struct bootflow *bflow,
 {
 	struct blk_desc *desc;
 	struct distro_rauc_priv *priv;
+	struct bootflow_img *img;
 	struct udevice *bootstd;
 	const char *const *prefixes;
 	int ret;
@@ -305,6 +306,15 @@ static int distro_rauc_load_boot_script(struct bootflow *bflow,
 	if (!bflow->part)
 		return log_msg_ret("part", -ENOENT);
 
+	/* Drop the boot script of a previous, failed boot attempt */
+	free(bflow->buf);
+	bflow->buf = NULL;
+	free(bflow->subdir);
+	bflow->subdir = NULL;
+	alist_for_each(img, &bflow->images)
+		free(img->fname);
+	alist_empty(&bflow->images);
+
 	ret = bootmeth_setup_fs(bflow, desc);
 	if (ret)
 		return log_msg_ret("set", ret);
@@ -316,6 +326,8 @@ static int distro_rauc_load_boot_script(struct bootflow *bflow,
 					  prefixes[i], script_names[j],
 					  bflow->dev->name, bflow->part);
 				bflow->subdir = strdup(prefixes[i]);
+				if (!bflow->subdir)
+					return log_msg_ret("buf", -ENOMEM);
 			}
 		}
 	}

-- 
2.56.0

