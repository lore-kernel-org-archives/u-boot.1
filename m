Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682D6C982D9
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33D1B40B5E;
	Fri, 18 Sep 2026 10:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYcqYUrghGXr; Fri, 18 Sep 2026 10:53:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7647B40B48
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728797;
	b=iF/PKS4F2wLxn2hM1WHr635HLVYp5wYMmfUO2wWwb8rESxCn2gtqa3qlDvIUDcaGUwKR
	 gINcsIj5BJye97sbnNkMEhZne77XbsBFYs4DlgbA9hyOUDKuZLWHKfU9mcPAddfF1KaBg
	 8calChdtMY7ZybFjK2itm6P3UWRlO9lbUmOas9xEmz1KH6kkPCmUJupXP/i/Dje2eZJra
	 DE/HME+HO5aQ4cvsvAFHOqpZVJXT4wHc6GaiAaNwgTuuhqQgh63/VIfKR0slU70qfchK6
	 W0cw+hxXob/UL6GdLV8jilW4Bmpo/81Iaf9YKOMKeOAXcW1mHTyGiWpbFgisMLsKheA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f//WOEMFk5wCSx67guXcH2xwJ31njf8Ghr0wQvS1t4w=;
	b=WcwYnAFmlUSLXcxraSTqAbkKhaMh4W02ggxZvuDaMKOo7u77nQlaBD5uNgpgH/0CEGYS
	 7FMp4jcfb96nuSdJbJuAh2W4ej11qLdyoXMbLMereJxHseGQAQlGPZ1JMgyFjLOFPbFU7
	 ZeHfkR3HmjVbfUKjhtGAadwX6r6l4YW/JAPIwJiMD4PaALw9MtiUIBJx8STkJRWTtcndr
	 wlJAC454xOlBBECMqxQ1JGNxmtaUH8xdyPP4rIHSr9NQ21fwTOjAq3qR9xUdZKNAHkw4p
	 vZIiD3i5MKT3h+t5vcs2pyydZyfCy0HBSSoES4WriOT0aaCDjonPBklTWMINFisO5RQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728797;
	bh=f//WOEMFk5wCSx67guXcH2xwJ31njf8Ghr0wQvS1t4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qszW5fR2zi1LD9Bq3sWpiym/X1kJauQTRDKKSRa/4IS5Fz3eB80tH3Q5B/zUJM++8
	 Qly/t4HYPMS4x/emApTYsWfoDkxG8CSLh1UVNGLrjf4XR5k4ilxVVunWsI0s8dCitf
	 3CDcO6XwyBtBUex+5ricvFJdiVOnTimcC6He/wa1KQbeH/zQTRbRh/n/m1snoB5d8o
	 ASL8IzQgrU6phcYvOGegrk2y+VcEc1B8S3ibJB2zyOC0+tXDX1mozeVIU8wZ9rGk2b
	 ARUzvVxVzd/XFu7gjqKLExZHnzF8r0FJadXxMTvCSjEhn6d2ktJsyw9BTDZvWvUp5e
	 lO6aP/RP5pGKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7647B40B48;
	Fri, 18 Sep 2026 10:53:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1499279
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B77CE81275
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wfbqaRSyztam for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:53:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD6A38128D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728795;
 b=iPiBFI5iRzWke+5tTDWP/s7Dxh6mQYvhi7PHvivKmk6B1gGI02MRm7QUJQNkWC6ILL8j
 kDaUBf5H1WTvS5gvnODE1A1xnrw6GnOVk8/8eHaC0L5bn5mSyVewdQ3uiJLFyOYDsUWB7
 0JoN441ey4x6lGmsh4qUZdzG4BwntBdVaEBEuxIAbpz2E4KTUdxhEEA5XWhdu3qGRmd8O
 6K8xuW04eR54UkNFpSDB0yVoUEQoDZJPNne1QC8UJ7HlCouIDjLsMMkf8U7Pl9rh9+eUI
 dm/TILj+YYObGVKe1g/jngxKyLxwqBmkx9tWjHUJFHGXtEv78rZSS+l2DtMhKZF95ug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728795;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=f//WOEMFk5wCSx67guXcH2xwJ31njf8Ghr0wQvS1t4w=;
 b=IiOvap6VDSIsXNkScdILdUa+HUsl3dD+oILC04Eaj1MGXzekLYkCHkEtYmzP3utCh91J
 FARgH8RdF0d+MXkbpfE0zb+mZ60f+Bu3h35BJi+el6tBWabB1WJeWmrmhAt+D+4GaZScp
 yfzFZ1GP0gk9jxQmLxjMPXR5FTAkEnmhFa6Ys2bWf7HRpLDg9Sgm6IGwzws7CHS6QHGy+
 AeeMvJOgDK4hDBmUYWOUrKV9JQhIKoTm62meUmFab2imQyNkz0Ov25OowWjGFPWOPiJhQ
 QCEQdPcKyTfmGrnfVC3D5zz1iOfXP4XCm4IkiGXow2Zn1Ei9LQp4C1WCAB+HSWSwNEA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="5B5Qih/a"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=5B5Qih/a
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD6A38128D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:14 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6351831so296418f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728793; x=1790333593;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f//WOEMFk5wCSx67guXcH2xwJ31njf8Ghr0wQvS1t4w=;
 b=5B5Qih/a+MtUl7swB0LVHiNtbiPDnZuthFRM+MStCuYJWRG7OmL+6do828W1prFg3c
 kZGC6EyuqhEjN7yMnbZSsskgRMBSAwisl0RWucX56YFyYqZGbqfReh5t4Qlfa5dqC5Mw
 tFhnO7gL6J0VOld3aoX0M1d8nb6X2ZlYK178WaYCX012BpGJvCadiXLDK4SDFsnq0TPv
 XLfkyoNTnafBuXyj4rmlneqraUhW4z5L6wVhkp8qM9/t2n7ZNkoA3o/4RT9hpgjeKXdL
 cKKKsWO9NBoyCrpaEcFJas70h5NAYDu7QPxFMZOi1euQECM8CYM39Rz+OYphK5c0i5Vm
 4mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728793; x=1790333593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f//WOEMFk5wCSx67guXcH2xwJ31njf8Ghr0wQvS1t4w=;
 b=pGuCyYRWbxGeaBNonpbcZ877TCGkHsyShpqCcmSRcqaGYptr32nXn8k5fnphnyZlTP
 xQeg2w7BWslJHSnCMpoEoQv9hcgXws/Pr9L488IuFI2nIFRlhJgxZCxubfF05VXqQekg
 6Gyku9fMzpJn8abkNt9KN7+ynIch7Qz9AZwCI76hh+Ip7y21O3cNTc4oynW+FD+SO7PY
 tGd5XhMe80yov13gE+LAk8VnyrgZ+v+rFTefGtxhaKxfirDKWwlzZQVn0Kz/csd/nlGG
 LRIqRWLKi92I1sObSpd8mHWN9WmnaF0iFN7mD09Qt3Z7VhFlhYhQK8y0kkGMhx9jhdg8
 FBXw==
X-Gm-Message-State: AFuF++kpy1zACsdKnfr+ICuxfrlzGTzBEbt1aPSfRKSgWvqQ4QYln5gk
 PdSnrBXubG6oY6TYvAw8Lud2+VTUKw2MZTrit2Uknv+SjnpmY8Fp5NvdJ7Rld/oQAKA=
X-Gm-Gg: AYBFou34MaSU1QIpPudLYbx/oT9Sve5+Uvd/YNU/rsT2fAL9eVYNem1ELfQqaKCcHCo
 cEzo84ZWcJR8QdnuC06G4k6WLv8i75pv1AggB19dFiaRpZyAPDhUon79BCr6qrD3Fg1tkglaGkM
 7w+CgeeWmiPhJTF282h2gvt+rozYZIT2943zVAZWhsfR27uKiOkgPHfyuyyhTUfPlMuRwgkwIp8
 FGItkZrxw0BkR3QuWo4r9leIYColjGuHjCd5nQf4oKR4Qtpy3yqlq3D5Z9GBi9gi/nRWuMcv3ml
 naE+TzDBUqpvnJm1lrfI6bM77qYEstsBHxTycIDYC2UWco02ldIL91GrqsntjJwTJO1OlKcYSjy
 Uxfgr0gqTe2yNZ0tt5d1IQB9Z7RkIfMBNU76FTzuVtS1TpZfwHq+MYi9lHQrjlLYU+C2g0Cgvje
 Klc7pKAZq0d26I3/QVtoXt1P9y3VwTJzVR0+iJzN7VgcLd696x21DK/FvXa1GMw1q/rQlhbwS5W
 gkG96LvUi/hf1Ojpqc5nhmuz6Hku5GioSIK+Y8BbKawT2WdPtmD
X-Received: by 2002:a05:6000:2309:b0:487:9a9:6d24 with SMTP id
 ffacd0b85a97d-4871e220ab3mr2819370f8f.19.1789728792844; 
 Fri, 18 Sep 2026 03:53:12 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:53:12 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:33 +0400
Subject: [PATCH v2 06/11] test: spl: Keep the payload create_fit() is
 handed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-6-28e946f57357@flipper.net>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=alchark@flipper.net;
 h=from:subject:message-id; bh=JSM3sluxSzUtFvuWVX6Vbzp5M44pdB0vsnm9usrDods=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf9bcn+G1ZlWlQL2VxtbM25veW92UtSlUDBr/3nTN
 RIXr+5Q6ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqT6gyMpxRuC437XzhxV01S3fZ2qVUbhMpK1fjdf7waqdF24Et234y/FM5urD
 +TPvs2Qd1FE9tUVyx0Tb784rtPA7abXafr1tfO84DAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

fdt_create() clears the whole buffer it is given, and for a FIT with
internal data that buffer covers the payload the caller has already
written at the offset create_image() told it to use. So every
FIT_INTERNAL test has been loading zeros and comparing them against the
same zeroed memory, and would pass whatever the loader did with them.

Keep a copy of the payload across the call.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/image/spl_load.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 334ec77b18ec..94ac3a16b863 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -164,6 +164,7 @@ static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 			 size_t *data_offset, bool external)
 {
 	size_t prop_size = 596, total_size = prop_size + spl_image->size;
+	void *payload = NULL;
 	size_t off, size;
 
 	if (external) {
@@ -184,8 +185,28 @@ static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 	if (!dst)
 		goto out;
 
-	if (start_fit(dst, size, spl_image->size, external) != off)
+	/*
+	 * fdt_create() clears every byte of the buffer it is given. For
+	 * internal data that buffer covers the payload our caller was asked to
+	 * write beforehand, so keep a copy across the call. Nothing written
+	 * after it reaches back that far.
+	 */
+	if (!external && spl_image->size) {
+		payload = malloc(spl_image->size);
+		if (!payload)
+			return 0;
+		memcpy(payload, dst + off, spl_image->size);
+	}
+
+	if (start_fit(dst, size, spl_image->size, external) != off) {
+		free(payload);
 		return 0;
+	}
+
+	if (payload) {
+		memcpy(dst + off, payload, spl_image->size);
+		free(payload);
+	}
 
 	if (fdt_property_string(dst, FIT_DESC_PROP, spl_image->name))
 		return 0;

-- 
2.55.0

