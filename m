Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9939606A6B8
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rJdOfnw6;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ahQIIXHQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 828A960760;
	Fri, 20 Nov 2026 21:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kV4GkWLGwmIz; Fri, 20 Nov 2026 21:50:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB5A7606C4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795211457;
	b=DJAEpDJwgGE4XJTJR+eM4OAAP/1MaynXFT5LQCdzyLoqNR5e/NlJGlQ3zFbpp364geUg
	 ot6RvNHK8WTRyCa5jTBMoPp/Qz7HmS4pGRmJgheO78kRSbuWcpUtj5dDWhhINe5OqrK2k
	 yZ7EOF9XkLu4VY+l03a6U+O9zoDWqk1XxunbPkF6Y0UPRLY8nCAkszm35mkQIBwr4OzvW
	 mOB1GLwoT3oj9yZcq+xj1pCQN8GobIkmrPgWnun6wd9FGzRtDVsgpNPQprot3hu2y8STa
	 +pS0cyf3Vr8Qg1+Jn0pxZ3xbRACv1JMuH5b83PmTFob2JPKHULovZCrM44OLQgSdJqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795211457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1b8zYJozbBseJ1XI1hQsmy6Hr6sHhDo8u99pfEKE+yE=;
	b=OzJ+g+nYMhoYyVKmBKUUIQsqHudw+ayNEd1KOYRd53vKHpOif8u6JCyvc5Z1syHW6PmV
	 e0qa/dzI8/RNl6FyLiaaXwL/T0bxgB+Fdo5q3niUM7bd7IyFaUg74hYjeUbgsPADd90TD
	 CWZRGJ8h069sspG/SrYrOJ/CZ5eey47CoFdP6mMdckM/8RsWPshLvKe8hK5NhmlctPqak
	 viC68ACe7MTImJ6qFkWo/WKJpKxOQG4X3KD7dSbdlbUj+dDfyZjCok7jprGycJfcoE4Ot
	 TCzbBdzLsop4tmTiNCs/CvpTCqiqR6CBtY+8KNyanXJ4cqoqdnmCnP4KiluKQlz3Ecg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ahQIIXHQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795211457;
	bh=1b8zYJozbBseJ1XI1hQsmy6Hr6sHhDo8u99pfEKE+yE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rJdOfnw6Yv4G9MkJB2auE/i4irvpUk00HfHPLjd7nD+I3ZbXHkSPt7PyhiGKUQS2m
	 Xse5z10M2NGoCq2sWQrL8A6qZDqqy1i/fHHUbSnrmx6UajoHNZ82WkDSXikKe373Aw
	 ys9skqWuatfxcG4YtLq7yijLJ4RuK6YEs6R1BqAI5pHhrwDt50Rvy0Z8BDZMwpPl+l
	 K68NCkHSbUyljG30ls05Pq5kQNWGzQ8mYo3ttI8Am7n7WagY5zkshSr6VkE3Eushq6
	 X9coN05pup3TdzF0hLUbw1gDRKSSrcUPg6/e6gI6Jloz0lxcZ/mNRKWBdXk0NnD+ul
	 WaAHkJzsy+lhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB5A7606C4;
	Fri, 20 Nov 2026 21:50:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B403169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 980E060760
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sXFkXpXQgdLT for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7BDE606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ahQIIXHQ
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7BDE606C4
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:52 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-48eee44b908so879256fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795211451; x=1795816251;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1b8zYJozbBseJ1XI1hQsmy6Hr6sHhDo8u99pfEKE+yE=;
 b=ahQIIXHQAu306CauVy3lmeTeuhuZPML9jnZlJr7tjolUeBUD1uURW9rOpMkib3bSce
 zpPOi9AKReeoEPVRM+cF+7eAFur+9KwD0yhHnC6vzcXV0dh7ApeZ7Gbqg8bW1fKRNjMS
 8mstZTaipl9S13HRnBNLfqIAXyY5ITUqn/qWQH21Tfui+9HWcXjy/BltDWIWfYj75egd
 Mr/Rl6s8FaRDnPjRjNQTGSfYwbDdh8NWYgKwQtAyoYlK1Lh/22NvdZr5TZcrylfM7HxI
 msvevZcsBfufSwFEzOhQ745UGS+Gw2iQ8ZQg89drJUpfko7ZKc7GHDoj/yOB9oZv+sP0
 cdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211451; x=1795816251;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1b8zYJozbBseJ1XI1hQsmy6Hr6sHhDo8u99pfEKE+yE=;
 b=uA6+XtZJiIA0w5XkoukGS2SJ/XhWrtuctmyhOXhQWVZxphNh4UsIQ3Z7pMV7pZVCEy
 ZEpBBxx5qpMkcqO4VYuCqGKRLlL5E9XVPhcUhCBkJX4h9XssV0i9LU527lEJw5DgVl22
 wU95ZrsQ8kJ/4EmCtBUEVA0fxX6fUa4Lrnl9msyMB1BjadV5xHk+z+OlhEf0cJc2vKor
 MXttlgVUO7dL4mNAoBgIuF0oyEJEsodtoTtLHmAxWWGdNQjZ9sF6lJx77WwuimB+GGGP
 2bze8HMG6Rz5Jjye+zI3cqh7AQ6UpRRVoXZipS+4K0BKOc3mHsYcSMDBnDdrrZBKxtvf
 /iPg==
X-Gm-Message-State: APuU4Z/fY/MB4E4/Ovu8+ypMBynrIoLrSBpB53KGBWAcwkv0P0y+IXHg
 upOf0eZsfXxk95Ss7wQh6N1IINZs4U0xiTAnXsOSUEENF2x4pHxRJBpsh/rnl2I0pjU=
X-Gm-Gg: AZFdTZdmjDeUD6YlvfFkBJXJsKf4X5TVwmTDE/oLwTf4BvWRaC2ZU0GIkvm2D9xvleT
 u0gHoAXVgW7ucx40WwU1TUQgU7ywNi11+LqhceNikZz/qYL62rEpAC8+pGp2YOnaft3prljhSeu
 //LrQia8GmQfhOWHaw4bRMJkAufXcN84TdGpudz+dyxK+yOu+vNmYZ5w8sK5dnfAaNBmlnpalq8
 gpnoTkAmerhXMB/DHb5H75E6xiYq5aOXMrFzrL3hw0P+1XJxmZfw4TXMHC4SHDeZ4P7yz9JGRIY
 y3n2I+7OrMlLiJBN+hHomgeKP/2QOU2/FpfWf2NfS+Wd62RPvi4UQZ6ejcNhtc0K/Aegg66iZFP
 gNLbVAb37tQrJFwG1UIPBzz/rhOAUVgwCLnKn3U7xRobg1H8MgbD2CH59FpWKcR2ZYbJ2uj45cu
 vJcpx3w4vZR3w3ZqokETDQ81XB+f10TFPRORLts7/PEYyrAd6P2IxEINnnAeaVli1R7vQidX/L6
 lBWMuRoPuvYM/+iAbKsRnGrVhyI7XWs6dwmbEPog3Wvr8pFxheRgHz5XM4McfX/qFTaRkHPhuib
 Wbx6UzCHK/chZ4oLhe87UbavRYRm+xjz
X-Received: by 2002:a05:6870:de0d:b0:4ad:95cd:49c9 with SMTP id
 586e51a60fabf-4bc83571e02mr4420842fac.25.1795211451212; 
 Fri, 20 Nov 2026 13:50:51 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bd044fc4besm2846726fac.7.2026.11.20.13.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:50:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 15:49:32 -0600
Subject: [PATCH v2 5/8] arm: mediatek: load the next stage from UFS in SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-720-spl-ufs-v2-5-3ef93cb27dcc@baylibre.com>
References: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
In-Reply-To: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=f+SZ4tzPVi9CjzuM6iY6jZ7lE+9bc8tqJz6zuaQZABc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMCQJQFZ9OU14jvYnF8JabwB1L5BJ1DqKaBn6
 uwPNFZrbYWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDAkBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A90cH/j3o5gBvaSKiYJGSfNz2l94jsY8FdHEbp/3UdHY
 dVsK5cPBNe3w5fCTVz8oUwNfNVcZqWIT+erJCqmHy5NPaEiFeJJEn9/vlgupX7l/FGJgPTPX6fp
 ojxv8iSqVMlqJ6jlrNUuhGWV7ynNqIk4W4q5/use658/HKawyQ7a7Zf7fNVNxOXuvldSUCBTTCn
 eIIpuTSGfP3Yb91OWvGnVvtr5DDQgotaDONna074jwt5RooeEYKBeLdvvxzfuxczP7JehQaGjiI
 kXYaMN8jGCvU0DjoK4CYo2ULxmp6J/m+5Cd/OslldTpvVUse0e1CrnPX83/dxJYWMn/10UXRYZK
 6vh4=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Return BOOT_DEVICE_UFS from spl_boot_device() when SPL is built with UFS
support, so that SPL can load the next stage from UFS. Check it after
MMC, like the other storage types, so that configurations which enable
SPL MMC keep booting from MMC.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/spl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index f6012d4ec22..6221bf2fa41 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -66,6 +66,8 @@ u32 spl_boot_device(void)
 		return BOOT_DEVICE_SPI;
 	if (CONFIG_IS_ENABLED(MMC))
 		return BOOT_DEVICE_MMC1;
+	if (CONFIG_IS_ENABLED(UFS))
+		return BOOT_DEVICE_UFS;
 	if (CONFIG_IS_ENABLED(NAND_SUPPORT))
 		return BOOT_DEVICE_NAND;
 	if (CONFIG_IS_ENABLED(NOR_SUPPORT))

-- 
2.53.0

