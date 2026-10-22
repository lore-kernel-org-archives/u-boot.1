Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6C606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lKU4pGvE;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L6eP/ZyY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70E5C4099C;
	Thu, 22 Oct 2026 19:41:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id je4wS3xFrAcj; Thu, 22 Oct 2026 19:41:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A90894096D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792698072;
	b=Mr0kmTf1lVJHtWdU6QIxaDerLHFo4JX1luUYSh696dQZrZvx+MDfyWdw+snNRO5OpZW8
	 87tDwAdgGaOBElm1ZM1Iq1am7K9lQPR8UOeTxZkZT9Kblz0ZP90otjEZjCamOlL01i3co
	 QnTbf/KuVRND/PCVwNGFntD2+GHA7tNa/Cz5rQyCit1O72dXKVIx0MGqPgr14WUQVmiyM
	 Gope2W4Vua0h4kIBT9IVPsX59un4iHtDlIYT0tTgvrXYi/f48Ze86CApO2pnrfH+SDs1G
	 LofB+hnmNze97bIXjrKzU0jRFfTG/afR6eC/Qmv/2sh5Dv4L0HEe4Nml9MeN6bgzUhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792698072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
	b=fLXyW+gp57anUsNOorvcKD7DqMeTW/1p5IIDgnb+y9QVC4ifJTDZJ2b3uwoVdkLpiixB
	 4fUdFPVFrGWG26t1SspODxxT48Yy7eLG6erhRkPAbaP7LKfS75R5+SILVyskgTQOU7dHU
	 oB8hpmk7zBpyuG+/GyWCljmgIi3LlAgDMSrqzT/zp1HDD85YdRKa5m3jC5fXjhkcj30vc
	 mX1djOB/mB4CpaYgMngqeUFTcq8RDaA49XYWOwxJMwUirO5+EKUVkSLNo4O6fGJCUiZ4n
	 V/+2kPL5R+R4R7a84MZVBbfAFi/xuLOSe62niPekkvEE6f+5v/9lp4z2zu+byARdZiA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792698072;
	bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lKU4pGvEbRynblsR3nsdGac520WaHXP5SdtA9QpW03j/T0OXfxq4nk0eZTshmxAMQ
	 6xQEEaI3/2oAkwyadSJosfSuB536t+8j4+KRNPlw/W9WWLes2RHTPelPIjuITdCXOU
	 NtaTHsplmZkzAoT/Th0mBvOe7BmcMrccUkWQ+VMyp2wjmlr0q+RoDMNlBwAlXBtIiB
	 CMfTR6+n3rkB2luj93SGYDhGqgQtWo8i2rUCilYl2AH5lAjOr5TTA4Ak1WhukgMEvG
	 RPHBWcdR7kWt81GPL+KE3aZo0/6pvuy53CE3itu5bo23YHEvOsIaLs2lAdmEIHg5EA
	 ovx+EjQ+qhtww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A90894096D;
	Thu, 22 Oct 2026 19:41:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EEA24BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6BDB401A1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pvonJK2VOeT for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EC9D2400B1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792698068;
 b=ebDCOp1ysNnO6KXC7aMdfSc+YjSYCWFsUrSoJsbDv01lIbCaJ23rOW7qdSHi/TaJ6fgE
 acWAQ0u/fR+S64Rl6MOi0O7Y4KV4dO+B2VZPuDAU6OTIJUka0xpN3bO6EkC5qulgzLlvv
 FcfMMdNuHdVY0yG7G2/JTMDLuxqWOrKpGmU48zz0Bu9SDal3tWcIqFZUsdLeUIkxNWkql
 rL2mev2X0sDZmIqBdecRN2ms/Tl6EXVnz8ubAhY1bS2YmEvWuLSRh0qpx2LvndZbwyOl3
 RypUTlPZ3wkd61RH7wPtRlPoSpu/kRx39iB/6xfuo632Me90z3mUquRXXhs23ul3yDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792698068;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=tLIz8Hw4HXviF6mt3gZkjIX+1sxDk96+9veuhVdrT76br4evAf47tQbvVwJKEPRdJGaV
 15Sw/CkWRGsUsZfVOOukQuYB6jlDT0Ekwg9vSEnzbM9m35OtvFGmmxM472zB6gsYGVEB0
 ek/X2IQQa7C1Ite828m50FbRT2YjdrWohj3Ob6uFoMvSvss13wQBjfVs9YLPBsNgxCZlS
 cdBJXWhzbhCPxkeI4agDtbXqI1PsOt8wbKorcStwz02F+XjADoMK1k/1eAKJbcWJF5t+E
 KjZgDhAc1WoB2TwG95hIma59TQOFft1tvzzfkj/PVyimpQuyZGhmNm23G1DTImEL/Gg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="L6eP/ZyY"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=L6eP/ZyY
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC9D2400B1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:41:07 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so1407175e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792698065; x=1793302865;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=L6eP/ZyYLmaFNP8dvuWNoHWtPWf9yQAwew+ZHO977aUr+FVP9G4urMswiFseyK+q1c
 iYp/E6v/DMTPwzokIjCfn1qOOCyyaOQMfqi7ctrLCQCDkoMXXo75ifs7+XwEPpJHaRL6
 rFYAMTv93hXpwkN49XMtcbK29x45HVpWEqXJYeSi5My42ymLKMb4RBlfGpDDMP5EPlh5
 hazeHGVpnLyufST9FnaVYWOhXwxbIK1y/4w0yCFDlzg0yAKC/jzjDEYBp9LFQ4O/oDAd
 CJdVEVirJK1qo2VvPo8eItmy1jqsVEBBekWlxX5o2kFQGaxNCYB14f8d1mIYqh9T8r9P
 gMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792698065; x=1793302865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=JSa2fQuCjROHy4L1TePU2ab+oMkw8x2O8S+ASLkW82ZS1/SKovzAXrivfWeItNP7et
 WP5EcoM5p6BrgJNTUflJeY1B4/eO/uMBQXkDiWfZ910XUJe2yerjheNyD+hZQ3hVw7w6
 MSsTPPPzagvCeXW738iTr2oTBsIvZtv3hqHIR831dCc0XwmjYzHuBIyZJQ51Hk6aATTy
 P4guEez2eHnhbgJ0DgHocPmGJh8Fx9xrIFnsyoxf4Z3Oyz7dFcka45xzW2JrUO+og7hx
 k1jGGGR1Fpni1NcL2jPI0PkE3H1MaPmTbvYTikjlW6qy6pmAabSdYnIoKcIKYb7qzL6w
 D+rg==
X-Forwarded-Encrypted: i=1;
 AKwUvByKVYGFwEfJQa929vCF6mkjr8fZRArvJ9fMBxKN+uZa8AZ4bG+8pHUagokRS3vnLjFw7l1NpwY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLsXXEb42PS9J86KxN0clCrWI2eS3XqZ1qZzFN0iznr3hij65wt
 eUpcx/VES5CrhixwdsNXy0hflFWsF98gn29lCAshW43MEkd6ktG4OUTC
X-Gm-Gg: AYBFou2fSY6InuynK8UHvcZ4EldL179LbYLAn1yQ8x4+SaYn5qlZg6bFK+OHQR2obGA
 c4NORr/SWRbhqN2bu2S3QNCTVFMpVqbHlrwpJ0FZunsM94YfN607nMx1LeGBPhK4HVENHvs4yLb
 XXHQnQRiESi9415mK9h0P9KaR4MovDLFbrKQeVSi1RJ1qScBpmscFipCKl7kAwZqGOSCyAFLqye
 rs57/R0dAwSZxaxhu3TKhX0pLBIUi+PJxn9EBjQXNppBxwR75sv5xD+9t5AaJAmdr3zp6fc9cGy
 21L6qnXslEtMn0OBEE7zPQQfz5WRBeNK7fsBjEETTl4Es9ceMfhOgfqltB6/XCe1Cx0NLR05kgr
 aMMUZWXPVdTviYFd6OgRRIupr4BQtkzBnYQwCz7rGhUWzYtEs/Hc0O6d9pwBH1VzQQKrQjMqVNf
 YQAwt5UzvGbjAHOor0J5ugtD9oE3o8M0zTAbETsN9ATr+NLUWCOrZRdB2DkP0FpXBNAhVUEaPae
 Z3EP0SvsM+jRYCPKs+NZx4jBaA86Sl44Ba+e9wv0sPT+y8BLZyLlm15FRyao5qlOa0TOXiWpSvt
 j3NagNoySkNdQjNfGE53V3OlSESMuZvOWcest7ubl1WPDTsoCho1zCL3dGkJ
X-Received: by 2002:a05:600c:37c4:b0:4a1:d6db:1be0 with SMTP id
 5b1f17b1804b1-4a211c917famr1568805e9.8.1792698065426; 
 Thu, 22 Oct 2026 12:41:05 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a211be8f79sm3185715e9.14.2026.10.22.12.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:41:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v8 1/7] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Thu, 22 Oct 2026 21:40:36 +0200
Message-ID: <20261022194049.670889-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022194049.670889-1-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When dev_get_priv errors out, the ubifs is not umounted (if used).

Correctly handle this handle condition and while at it also return -EINVAL
instead of -ENOMEM as a better error since no memory is allocated but is
actually an invalid scenario for fw_get_filesystem_firmware().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/misc/fs_loader.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 6af4c7f15e7b..cd4695b08eea 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -175,8 +175,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 
 	struct firmware *firmwarep = dev_get_priv(dev);
 
-	if (!firmwarep)
-		return -ENOMEM;
+	if (!firmwarep) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
 			firmwarep->offset, firmwarep->size, &actread);
-- 
2.55.0

