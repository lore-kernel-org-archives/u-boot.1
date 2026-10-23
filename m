Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DD606A31D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oHW80O36;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FETwPCql
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D40360A77;
	Fri, 23 Oct 2026 22:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lruFIsDsKwoV; Fri, 23 Oct 2026 22:33:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DEE960A78
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792794798;
	b=Cj47l6vIrTytormWobiBjRA9JsnGoEqZi2gnAtatEhWPydZYNrMrx7kwDjf3vK9+yn3z
	 qX6hTb80DtY8XzvAlF3G9sSMOl5kIrF7xpC3nOiZ0elEwHAfu3Eui0wqYJT4jIUH4JomC
	 qO6zZa4Si8bfxfs4f9GSnykGFAyh/m/1iE0L7t+KoVQYkS52zc340r3dPMm2PdCe1lObJ
	 Sir+pG2xC0MMxx+oWFpj8qHfwyL/Yb38kdTXt1Uxm1JZu4HcUmHzZS1JWzWrfPuGiUnC/
	 UdMH34yd96p3OoZHB56m8fKwMq7NoZcjnCgVwEnHGN2RtQ+6SteP5Ten/uUmzSRZJIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792794798;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YnIIAvB2lW/NJE/Kwk4kRYHz3R/2ETafd542EXZh5PI=;
	b=fElWoSvRdh5edOYMAiswIoNFynufm/V+BgyCg/Hm5R/oe4Q2fAFtPSsUECsQKHAKo2iA
	 TqdyQIjmg4bK4YLQenwOyvOsnNGs8nQ9HajsYTDMTZHPKr1uzhuzLDWAei/EXp+3spBBQ
	 kY1RcDKloUb1EInF444zk1uU9TLtGYAF6CTNAdyoKbz/4RjtgWQ0WU1BdM9aN2gqvQlyD
	 CAhS9fcqbUTdpehKi9MxQHD+JeoX8oGd0FRvMHXQXTcHoBMwm2909XwyK7eu/JMBTxUaI
	 82l3zC0f7La5zivZtkM/vja/jiON1yTZn2ey06Oyh7QVLkfXg+7oYyLyDDUTmT9QQ5g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FETwPCql;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792794798;
	bh=YnIIAvB2lW/NJE/Kwk4kRYHz3R/2ETafd542EXZh5PI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oHW80O36L2UYWAFXPlLPMXh3qwgi+ZVrwSRAe8Vu0PNRteeVkZZ814963DPOEdQ9+
	 UeDmPKDMRoqIgh5JCYaEZVwTdlkDnqZFkG1+0ZKDLd9p6fvePaM3e4zMFR6vM7BbLG
	 +Bs8AVG0Xn45jGKgmVYtfPiiLQjMW9AphfN5u2SXzwRaO8DxjZkI2nsUULeTsUNKCN
	 JuU89wBYR2TOJHMEazme/Q+MRvqVZ+kzxqj0VEO5KF/yTZGVnu2ImTAcGZnhLa7UVh
	 8/0GWqftWIrhbLMlmHr+MB31GUZc7tBUQIvFx71y0yQki7lwpBS1fDFDm8cK23v2g1
	 9ao6BYX8Q3xCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DEE960A78;
	Fri, 23 Oct 2026 22:33:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 040E9D31
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE55260A38
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5mj5RiV-Th1j for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 44DD160652
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792794794;
 b=fKWipO7An2W+Pw+TvyGFl4J0FfPWEiBBR6DJwdGDqICgu/qIFPh/yoauFLej4vHRI6EN
 soUWWKH5B5pYgvWQf9NeaMjM8xRoOp/5fGL0m1Y0xz5wEnPMHfdaPT5lEUVIyG68mCzTX
 U3rVxWkHlY6c1lXpAqKflJ+cV9/u360oS6jgZw2ek5RzwtkYefV1T3eEgcuba1ogEoPh9
 FzRAm87ADrEaP6N9eehGn4ir+/1/ngvHXR/DJOzVDm2tLkaAGPh7JaivIRnv4LRLcsLZx
 1a1LOM+BiIR53TSpYFw9AHoSLOzrwAICCfPSpKxbyINUeWhDLEXlCG1mngwAS7ERxhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792794794;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=YnIIAvB2lW/NJE/Kwk4kRYHz3R/2ETafd542EXZh5PI=;
 b=f1A70tivO0zI+3xhTxB3NBHh4W19Ier7uh7vCk02QUGiwtNkOiomSok5NLYAq5buI8g7
 MQLWyHIDuptiOZ9Nqcdv1+WvlYHAYowymN1kqMz68Y+504p/Fr38gCw5l7Tbw3VoU/19v
 0T1Fo2qYC5xndcEMkGAWEZZvSGRn8c6kUKl3TvylryyxFAz0FVn3jvOdQvwZTEobTCi0z
 A4HcoBmOFwOG2T6TlV8lfAHP6blkh/jhYeafc0vawZDEav+L2uQdMYQ+Am05iiMRzjBqY
 is21nnHtLlrmcm0vWUCR6H4Q4sUlpk3cS4xJ7PdePYpW/d2HEJqGeriiyRwna5pfAnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FETwPCql; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FETwPCql
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44DD160652
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:33:12 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7f432ac553fso1384576a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792794792; x=1793399592;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YnIIAvB2lW/NJE/Kwk4kRYHz3R/2ETafd542EXZh5PI=;
 b=FETwPCqlRBYqP22G3nom4FEkiD+DQutpj+2FPdPJ/a6tXsfgCytt+8E55UIeUWbKf5
 7kU1wmNAP4NG+IcAPxy64gNn3ZwLtv02rltaCngsdFMkyFwG0yzf6enuw5dvg2e+DR26
 gucrLjCpxCvsMo1BDDOVfGMLQ5OR/DLbGcoYlaJGuRngVTRRb2O4STTyJY3IgMm/MuAg
 IYQlCd00SBBPNUNCscnzfRJkSwpl24PC85u06AKYKKpZW8VsbPVxidPnkGbdu9nx8ehf
 Vv2QkThOmhfrTfJ6Di/Zq8F58Bgp1sRMXAu15ziXaz/HLbml8OkQC/3X/LVOYfnieDgk
 4thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792794792; x=1793399592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YnIIAvB2lW/NJE/Kwk4kRYHz3R/2ETafd542EXZh5PI=;
 b=ad3SSQfjNVipIKTIopHTCaTGxRr/x1Zm6smZ0H9xw7EkTV56xkjom9bbxjTXs0H2S+
 nNx4lkCpV+MkVPju5PSvv6RlR8OBkkA+Y+y1An25+aRORr8KCm8x72kLC8a4pxHBfGAX
 eACQdxZYRv+YoE7VQmxc5oP0OkMeaWGPj5ib8ykxPmVAuSznnlWlwzQqsyXEYp5a8M2s
 YKtmZKD3cStGbEd6CVuvoCq2ouiMpSWK08RgtMuQ3FcC6KX/z1I6RREYGQxemhimnb4B
 r6yE7I4Ka/hUYG5SsuEGg8Z8bQXhRtDwkSX7psdkcqqvKf77Foy3JSnQ96qVRYgbXgb8
 pmwg==
X-Gm-Message-State: AFq9FYIE9qy2rZoMQNPIFzzUFCR1SqyCx9n+JH3ECbKdgzbxW9KDUUUb
 H2ZtGLCf2xKnwrjrc1pg27oTEMhRxcvzMOeNNKfgtkWZh+Xz/3htxC1IuNPnUEucj/c=
X-Gm-Gg: AYBFou0SqkgJLi1r1+NIwwH3lOzUe3WkemcO8LB68FJDX2dPgKnwmcdJLtMEXNE5iiD
 Vx2+8CS2bEH2yk8mzUqYpvKMCvu2P3G+g1+ejYW564GW5seFMP3vAvCgUnlKgBmMpQw7Pt+ETl0
 2Vd7s1csLVzK0IJAwPPgHltSGUqxWrCRv4xOiQ/mSVlzwFszGeGeYcUmFGCXNKJxjpxK9NHmxDr
 Bt3O7pnDHvBWlI7JXTg/C0f/6CRoRqS/chucvS86J0ihh1MWxnb+wj15lziIX92+LiPQgFwtLkB
 NzLE4D0Yo/OvCe/zeBliWMZGPC0YQy9SZcinoY9+jd02TQKzGZ0WPGANDFtO0CZ1fK1tb53LV1S
 Eu1ZZqAXg4ZdYQiq/YsaXr7TsSdeRUiFiAdQVjCsW5S8kuhUGK1ijY0FW3QckAVdqOz7jgqei6q
 UuZTNe39i3nxp2AL3StTzKf+RCKKpSLK2GtAEWSXTUaxDyLefEsTpJy4T60bj2+K79C2+1b0pe2
 OFPTbN6kd2y/OwSv59l1mjTwM2C/sRWFvoMLH6MDfkSrSDjueNZZQrwJC+J
X-Received: by 2002:a05:6830:2e11:b0:81e:abb6:7498 with SMTP id
 46e09a7af769-850ff0a484emr622936a34.23.1792794791620; 
 Fri, 23 Oct 2026 15:33:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb0741c9sm696300a34.10.2026.10.23.15.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 15:33:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Oct 2026 17:32:43 -0500
Subject: [PATCH 1/2] fdtdec: apply bloblist DT overlays to the built-in
 devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mtk-mt8189-tfa-fdt-v1-1-f86616860bcb@baylibre.com>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
In-Reply-To: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3366; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/pFwmlRLMzCSMQSsSKqZqUJlO8jqL9qKwm8A8FZTUXU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2+CXhw26P7uj1RWtvwpHwpxMwZ+gRUOSTbxKV
 cBOyVH1i/KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatvglxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AibIH/Rf1bh7FuBJHRehhl6o4S2zOppnqrPJ4+DELUb4
 gTZDWx22sIkgFs+5DzjIJB1VRv6ndyazqBymiFYiEpH8L7e0xzSRmv2pO76QICIfiwCJfUgXlDu
 SDQUK98K0U9ajHwVRpzAYaigdrhSyGQRqdqJXQG0M2MKj7CCsuTLStPy1fuNz2qhOVJC3z84+kY
 WA+itvrdr2iU9GhYgX/jxNUI6W6xMn8LY/0ieEGZ5aNCLRF8JpybWdXxFkCq7pZbEoisI9+TIZP
 YtQA06ACdx5u1iQ+sofXo0DlzSHyceMtEGKArrEde8wsWSjbF8EpfKAg2AVjCFDl95Z8CLHzPQ/
 ajD4=
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

Apply the devicetree overlays passed in a bloblist in the case when the
bloblist does not contain the devicetree itself. To do so, copy the
devicetree that U-Boot found by other means, e.g. the one appended to
U-Boot, into the bloblist and apply the overlays to the copy. This runs
early in the boot sequence so the bloblist is the only memory with room
for the devicetree to grow. And we can reuse the existing code that
already applies overlays to a devicetree in the bloblist that way.

This lets a previous stage describe what only it knows, such as the
size of the DRAM it has initialized and the memory reserved for the
hardware, without having to provide the whole devicetree of U-Boot.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/develop/devicetree/control.rst |  5 ++++-
 lib/fdtdec.c                       | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 7d6117d5c4b..36a11c6e3ff 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -138,7 +138,10 @@ devicetree at runtime, for example if an earlier bootloader stage creates
 it and passes it to U-Boot.
 
 If `BLOBLIST` is selected by Kconfig, the devicetree may come from a bloblist
-passed from a previous stage, if present.
+passed from a previous stage, if present. Devicetree overlays in that bloblist
+are applied to the devicetree, even when the devicetree itself does not come
+from the bloblist. In that case, the previous stage must leave enough free space
+in the bloblist for a copy of the devicetree.
 
 If `SANDBOX` is selected by Kconfig, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index d25535bf36c..bad99f204da 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1818,6 +1818,36 @@ static int fdtdec_apply_bloblist_dtos(void)
 	return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsize(live_fdt));
 }
 
+/*
+ * The previous phase may pass DT overlays in the bloblist without passing a
+ * devicetree, e.g. to describe the memory it has set up. Apply them to the
+ * devicetree found by other means, by moving it into the bloblist first.
+ */
+static int fdtdec_apply_bloblist_dtos_to_own_fdt(void)
+{
+	void *fdt;
+	int size;
+
+	if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) ||
+	    !CONFIG_IS_ENABLED(BLOBLIST) ||
+	    !(gd->flags & GD_FLG_BLOBLIST_HANDOFF) ||
+	    !bloblist_find(BLOBLISTT_FDT_OVERLAY, 0) ||
+	    bloblist_find(BLOBLISTT_CONTROL_FDT, 0))
+		return 0;
+
+	size = fdt_totalsize(gd->fdt_blob);
+	fdt = bloblist_add(BLOBLISTT_CONTROL_FDT, size, 0);
+	if (!fdt)
+		return -ENOSPC;
+
+	memcpy(fdt, gd->fdt_blob, size);
+	gd->fdt_blob = fdt;
+	gd->fdt_src = FDTSRC_BLOBLIST;
+	log_debug("Devicetree moved to bloblist at %p for overlays\n", fdt);
+
+	return fdtdec_apply_bloblist_dtos();
+}
+
 int fdtdec_setup(void)
 {
 	int ret = -ENOENT;
@@ -1893,6 +1923,8 @@ setup_fdt:
 		setup_multi_dtb_fit();
 
 	ret = fdtdec_prepare_fdt(gd->fdt_blob);
+	if (!ret)
+		ret = fdtdec_apply_bloblist_dtos_to_own_fdt();
 	if (!ret)
 		ret = fdtdec_board_setup(gd->fdt_blob);
 	oftree_reset();

-- 
2.53.0

