Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91E606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tnbOmguU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FvXa8ypz
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED9AD4055E;
	Mon, 26 Oct 2026 13:40:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bWlMAPqf6ht5; Mon, 26 Oct 2026 13:40:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 322134053E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793022022;
	b=JiE//+gfRtOrXZvxBwGdtIbaziNYmufdAjOYSpb8kziNaeHa0NklGxbiBSB90eu8wvzD
	 rCvbqEN4snkHAjt/NE1gPAj/Y/2nQpoO6mFZ9PO3Ub7kTxDcKRNInekOGAeUJ4UEbZ/XB
	 r2Q4SAJ0s9afmvxTevLpd82CZffr+k2cCgW7ClI8m+58MMFSFZgKhZRvqJlsgCdRhUVlO
	 pSLaWj927l0NjEymUTHWxHdHd8V2gIVbEyMfC9n7MkDtbhbdXm7Mn2KEdufl6N44wZOy5
	 eCB1XPjHyZ/HujmbzUtuvCEE076qbW/kK13EwIcHF69hWyDSN6Y1uKblJq2sfp2j3EA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793022022;
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
	b=C219Q+/trGwdz7zKwy2Sd8qt64r1A8r7/kpzrDoKGNXXTA3aIIXkYdwpzBnKR64ab2tK
	 4F3woxpXiRbCVhBo2I1bydn3oa1VcM4dWrQG+PjRDaWMHp8FrRuuaB6AYf/bMmqmpO5WA
	 G/uRAw6Z4iWXi2dZtX8JH9vQhEuUZOmLVy0LV0GLqWPnxEtD9kbs5kP8AtZmSiIPxZk0a
	 0I2QfkRMnDebPPJvpg6xLXCaNMZumKOl8wNN+KzQPSpIdPl9eXCmEznev8SzHkh5UjNmR
	 tAM3Kdsls0lfVyHmzq7tWKEaxvoVSlLPgpaF4LdazCNZVaALCGRLFnEZ/dLQAagymNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793022022;
	bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tnbOmguUuo/Ka2ml57O6/QHKeBN1XnIFLFuI1lKyWpkWFf3YYr6owJHrdTyPMJYnm
	 OBXnl00KXGvkHIgMZaTNE+ZfwyG/RjGyyn+xQKjWr6RummDIBK20EgDismZgaz1xZV
	 X8Mdkg6JQjr7+TVZH8kGv+EfLVrqr3VcGcLhaDmsEJYD0t/lYbTsS8WICCyqZDMooR
	 sJehvjifdIwC6JJT04IxxUy9/43xi5E2VJxiACJRpWeEs776LA3LrQyoIp7rbkFyZ9
	 cCOn3EwPllc4beRM/4C30uMLVf/BkhNF40nMcDzf1uh1BkjslKuGUYnsRTjDqzgPAM
	 nI98mmRlEJuMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 322134053E;
	Mon, 26 Oct 2026 13:40:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E54C279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 401A9400F6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ArUFX2G3tjH8 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5A22B40062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793022019;
 b=PL0vwZpzstBKikvdzZkGGXPBFhZkt1E60tG4C5CDxnjAmcO3ziZJwpNqp9+wf9NXCIMH
 LO33hikveNgQ7OKpA6MlPQUE7Mn4RI/gH8BfQ6S4/tIJWzPJNnXQlV045PCBbxlEtZ1W3
 m1DAST9N8Xp1ajIFy3uFoevUl9Ar0AxwbgiYTyQufkzQGs+URfNF76AhevLnJi0pUda+A
 hKYF0/fEhhy70Q68eNlb7zWQevWbdDZLtWBKqx8rvHrPMNoSgrJQcjf0CB1Eq1FZGniYQ
 blOsvnWL/69i6so9OJmrGb+1IG6qTyp99LPVTafM+CD4u45cPDFMBK9pIX9SCiaGM2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793022019;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=RL5VATHCXnphKADEkLVXdR+491FQd5EVpRlq5xgtchBFUfmUVlG96632QU3Cwz7WkbSC
 7o1tijkfPEbIVnlJt8Gy2KF0auvilLKSKM25w6mo6+S5ruonQ7XVbej+d4GvG2FuLrr95
 XT2XfdfHbWI9t3EnCFHNxe3Cb1gJ0qREHIttUr3ak44zGrJJMwJxHDuKkJQ5AIfyqn1ca
 ZRDb8j1+tF9GURHK7rj9CfWS9FYkY4XIiyrMrHKvVU+egzm882xgWtjLOVZvVhsXhzj1+
 ywTdj+fwIXNj52M8BWr/0AGzjUfYkCMDBVLVSBbsDlAUMgxBX70FZbOxczRGnQjQYvQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FvXa8ypz; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FvXa8ypz
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A22B40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:18 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so19461335e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793022017; x=1793626817;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=FvXa8ypzN60wZ8Bx/A9NKLepk54U5oQiVayL5hTACAe9/E1A/W8p3NhQq4dmM20T1p
 mC24OShobMKXIqzua+sTrTePcB373MGatFe0ld6gAy6y1+h215yiocfcGVfyu9gsiMVc
 tD+iY8j8h4dHjMKWhOvDP+/XVSDFPAvQsYivI75NOSfVj1CKXgvvJy/8GUeg4jGfqSEv
 QafvVF/uWTCKgeZ3SK5qtMjZft+LRMCjDEXGnnRQCyxrOcVOPOwjct/eqK8cOuIYX5wu
 AIjUofekY/P6kX9h8RkMd5JtqTJ2tTaVRl8Ko8iEe8S1CSPXlR3boq1JYQYJRyVNpJNk
 mnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793022017; x=1793626817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=WQFkgALuJFpcpeGnxNRPwcfem5OnHRTqOlTbIoR5EbLwQI4Rny5ZVZkkpp8XZN2ZrF
 Agq3dziUfMvK82Cx1ERahFU3ZadD4J3ox68P5aVfwrvYIDJru+DO0PW+p92DRyMly3IF
 8OWr3l69fBlXNAQucg00x9HCWQvF0aNsv/YbA24PRUMFaMD94hGUWGqlSJeJIZfKepQ2
 6NFmJKRR7UbjKTNyevbC1JZIzPUZ38i5snTvOlmJNlRRJYtNXVKv17eC5YNM8JCh0vc8
 fpCS2/k1N3qJ2RCGwOjQCbnjsPwT/TMXh+dK9eChe48Sf5K53DiiLZ2C5Zg+5AdmTMGw
 74BQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYM2qGh5d0jTd2ArqmQ1KlPtTmlsPy4nVWzcMPcdBwXcZpLGhRT/Lg7AN2C/Hc5Pg6KnwADqI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYINSA+LagPbCvA0tkS38uj3LHcLXmlJ1HanIQ5XTxnyq+5X23PR
 IPV1Cj2qzlEjBAZ35MUzu0zCaUkn0EdJ1pImww1FHnTY+uU08sYOp3Sx
X-Gm-Gg: AYBFou07ggqFP+PWg6sriu/Q2Na++7/UmgFOKjeEVRCX1dY70gKK8786e58TLZVrCgV
 qqSyresZduVcmWqSot5ScSq/UPBQb2Sd7UYXolhxS4FxKkjOCji1yiUkCZTIgw+euXd6zn6G9uO
 9eTHp3jeUvg7qp8+5eroFzpg2VutFgFABunVAaRB2BwB4g4m+zcwnkUuHzGDMw7FPt69zcQ+C66
 p+w8Ymfbmy4X+VSVDj++0w2legW54SVA/hNfWcR1zGajSmrXxt2Q/iug1A1+FCY1coujQezKU9U
 4q2/DZeC9/+k1jWTOr1pAB7XE8DRLH6rxpocXBFrOiX1mo3af0Q16VYODrYfz7jkLRC0HWh7VLc
 U57SMZhKttDw9bKiAbo3991/lL0fkU/N8UYvJtQ462Ve7Uh7PJUNWCKHXXKEq3HnrHsER6IV0l1
 pixiRNkMzOfcWp0QkNGNVPv5VdLnK8JRrttm8uEf2rpIp3n6AO2k9rVM7Q6n3MKQTT3TksZhbEJ
 JfqLvGX4kGZtjaDUUB5+IyMtsI6b6IepQsIPXawdTAiHOt7sujrVtkRUHmyLIAtKanaQxAVIXQw
 KVr9VqNIzn1+XK2S+2cYulrw3SXzBTPI8txwSFi8Z1sUnfzPNUxWMxioY7SY
X-Received: by 2002:a05:600c:1c10:b0:4a6:eca1:7d5c with SMTP id
 5b1f17b1804b1-4a6eca1801cmr40498425e9.32.1793022016595; 
 Mon, 26 Oct 2026 06:40:16 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2c0458sm194344375e9.11.2026.10.26.06.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:40:16 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Randolph Sapp <rs@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Cc: Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v10 1/8] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Mon, 26 Oct 2026 14:39:54 +0100
Message-ID: <20261026134002.109025-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026134002.109025-1-ansuelsmth@gmail.com>
References: <20261026134002.109025-1-ansuelsmth@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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

